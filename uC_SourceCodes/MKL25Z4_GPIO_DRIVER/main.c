#include "hal_gpio.h"
#include <MKL25Z4.h>

#include "pin_macros.h"
#include "hal_gpio.h"
#include "hal_tpm.h"

#define FREQ_PWM 50
#define MOD_VALUE (48000000 / FREQ_PWM)
#define MIN_PULSE 48000
#define MAX_PULSE 96000

// Puertos y pines
static const MCAL_GPIO_Port_t PORTA_INFO = {PORTA, PTA, MCAL_PORTA};
static const MCAL_GPIO_Port_t PORTB_INFO = {PORTB, PTB, MCAL_PORTB};
static const MCAL_GPIO_Port_t PORTD_INFO = {PORTD, PTD, MCAL_PORTD};
static const MCAL_GPIO_Port_t PORTE_INFO = {PORTE, PTE, MCAL_PORTE};


// TPM config for 50 Hz, prescaler 0, using TPM1
static const HAL_TPM_Config_t pwm_config_ch0 = {
    .tpm = TPM1,
    .channel = HAL_TPM_CH_0,
    .mod_value = MOD_VALUE,
    .clk_src = 1,       // MCGFLLCLK
    .prescaler = 0      // Divide by 1
};

static const HAL_TPM_Config_t pwm_config_ch1 = {
    .tpm = TPM1,
    .channel = HAL_TPM_CH_1,
    .mod_value = MOD_VALUE,
    .clk_src = 1,
    .prescaler = 0
};


// Tabla de configuración
static const GPIO_Config_t config_table[] = {
    // LEDs
    {&PORTB_INFO, RED_LED_PIN,   GPIO_DIR_OUTPUT, GPIO_MUX_GPIO},
    {&PORTB_INFO, GREEN_LED_PIN, GPIO_DIR_OUTPUT, GPIO_MUX_GPIO},
    {&PORTD_INFO, BLUE_LED_PIN,  GPIO_DIR_OUTPUT, GPIO_MUX_GPIO},

    // GPIO (botón)
    {&PORTB_INFO, 1, GPIO_DIR_OUTPUT, GPIO_MUX_GPIO},
    {&PORTB_INFO, 2, GPIO_DIR_OUTPUT, GPIO_MUX_GPIO},
    {&PORTB_INFO, 3, GPIO_DIR_INPUT,  GPIO_MUX_GPIO},

    // UART0 (ALT2)
    {&PORTA_INFO, UART_0_RX, GPIO_DIR_ALT, GPIO_MUX_ALT2},
    {&PORTA_INFO, UART_0_TX, GPIO_DIR_ALT, GPIO_MUX_ALT2},

    // UART1 (ALT3)
    {&PORTE_INFO, UART_1_RX, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTE_INFO, UART_1_TX, GPIO_DIR_ALT, GPIO_MUX_ALT3},

    // UART2 (ALT3)
    {&PORTD_INFO, UART_2_RX, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTD_INFO, UART_2_TX, GPIO_DIR_ALT, GPIO_MUX_ALT3},

    // TPM0 (ALT3)
    {&PORTA_INFO, TPM0_CH0, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTA_INFO, TPM0_CH1, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTA_INFO, TPM0_CH2, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTA_INFO, TPM0_CH3, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTA_INFO, TPM0_CH4, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTA_INFO, TPM0_CH5, GPIO_DIR_ALT, GPIO_MUX_ALT3},

    // TPM1 (ALT3)
    {&PORTB_INFO, TPM1_CH0, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTB_INFO, TPM1_CH1, GPIO_DIR_ALT, GPIO_MUX_ALT3},

    // TPM2 (ALT3)
    {&PORTB_INFO, TPM2_CH0, GPIO_DIR_ALT, GPIO_MUX_ALT3},
    {&PORTB_INFO, TPM2_CH1, GPIO_DIR_ALT, GPIO_MUX_ALT3},

    // I2C0 (ALT5)
    {&PORTE_INFO, I2C0_SCL, GPIO_DIR_ALT, GPIO_MUX_ALT5},
    {&PORTE_INFO, I2C0_SDA, GPIO_DIR_ALT, GPIO_MUX_ALT5},

    // I2C1 (ALT2)
    {&PORTB_INFO, I2C1_SCL, GPIO_DIR_ALT, GPIO_MUX_ALT2},
    {&PORTB_INFO, I2C2_SDA, GPIO_DIR_ALT, GPIO_MUX_ALT2}
};


void delay_ms(uint32_t ms) {
    for (uint32_t i = 0; i < ms * 6000; i++) {
        __NOP();
    }
}

void set_servo_both(int angle) {
    if (angle < 0) angle = 0;
    if (angle > 180) angle = 180;

    uint32_t pulse = MIN_PULSE + (angle * (MAX_PULSE - MIN_PULSE)) / 180;

    HAL_TPM_SetPulse(TPM1, HAL_TPM_CH_0, pulse);
    HAL_TPM_SetPulse(TPM1, HAL_TPM_CH_1, pulse);
}

int main(void) {
	HAL_GPIO_Driver_Init(config_table, sizeof(config_table) / sizeof(GPIO_Config_t));

    HAL_TPM_Init(&pwm_config_ch0);
    HAL_TPM_Init(&pwm_config_ch1);

    while (1) {
        for (int angle = 0; angle <= 180; angle += 5) {
            set_servo_both(angle);
            delay_ms(50);
        }

        delay_ms(500);

        for (int angle = 180; angle >= 0; angle -= 5) {
            set_servo_both(angle);
            delay_ms(50);
        }

        delay_ms(500);
    }
}
