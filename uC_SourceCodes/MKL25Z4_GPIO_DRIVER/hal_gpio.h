#ifndef HAL_GPIO_H
#define HAL_GPIO_H

#include <stdint.h>
#include "mcal_gpio.h" // Ensure this includes MCAL_GPIO_Port_t and related functions

// GPIO direction enum
typedef enum {
    GPIO_DIR_INPUT,
    GPIO_DIR_OUTPUT,
    GPIO_DIR_ALT
} GPIO_Direction_t;


// GPIO configuration struct
typedef struct {
    const MCAL_GPIO_Port_t *port_info;
    uint32_t pin;
    GPIO_Direction_t direction;
    GPIO_Mux_t mux;
} GPIO_Config_t;
/**
 * Initialize a GPIO pin for digital output
 */
void HAL_GPIO_InitOutput(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux);

/**
 * Initialize a GPIO pin for digital input
 */
void HAL_GPIO_InitInput(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux);

/**
 * Initialize a GPIO pin for ALT (PWM, UART)
 */
void HAL_GPIO_InitALT(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux);

/**
 * Set the GPIO pin state
 */
void HAL_GPIO_Write(const MCAL_GPIO_Port_t *port_info, uint32_t pin, uint8_t state);

/**
 * Read the GPIO pin state
 */
uint8_t HAL_GPIO_Read(const MCAL_GPIO_Port_t *port_info, uint32_t pin);

/**
 * Initialize GPIO and ALT_GPIO pins
 */
void HAL_GPIO_Driver_Init(const GPIO_Config_t *config_table, uint32_t num_entries);



#endif // HAL_GPIO_H

