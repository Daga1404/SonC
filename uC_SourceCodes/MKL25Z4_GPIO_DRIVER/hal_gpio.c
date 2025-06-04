/*
 * File: hal_gpio.c
 * Description: HAL implementation
 */
#include "hal_gpio.h"

void HAL_GPIO_InitOutput(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux) {
    MCAL_GPIO_EnableClock(port_info);
    MCAL_GPIO_ConfigOutput(port_info, pin, mux);
}

void HAL_GPIO_InitInput(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux, GPIO_Pull_t pull) {
	MCAL_GPIO_EnableClock(port_info);
	MCAL_GPIO_ConfigInput(port_info, pin, mux, pull);
}

void HAL_GPIO_InitALT(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux, GPIO_Pull_t pull) {
	MCAL_GPIO_EnableClock(port_info);
	MCAL_GPIO_ConfigALT(port_info, pin, mux, pull);
}

void HAL_GPIO_Write(const MCAL_GPIO_Port_t *port_info, uint32_t pin, uint8_t state) {
	MCAL_GPIO_WritePin(port_info, pin, state);
}

uint8_t HAL_GPIO_Read(const MCAL_GPIO_Port_t *port_info, uint32_t pin) {
	return MCAL_GPIO_ReadPin(port_info, pin);
}

void HAL_GPIO_Driver_Init(const GPIO_Config_t *config_table, uint32_t num_entries) {
    for (uint32_t i = 0; i < num_entries; i++) {
        const GPIO_Config_t *cfg = &config_table[i];
        MCAL_GPIO_EnableClock(cfg->port_info);

        switch (cfg->direction) {
            case GPIO_DIR_OUTPUT:
                MCAL_GPIO_ConfigOutput(cfg->port_info, cfg->pin, cfg->mux);
                break;
            case GPIO_DIR_INPUT:
                MCAL_GPIO_ConfigInput(cfg->port_info, cfg->pin, cfg->mux, cfg->pull); // ✅ pass pull
                break;
            case GPIO_DIR_ALT:
                MCAL_GPIO_ConfigALT(cfg->port_info, cfg->pin, cfg->mux, cfg->pull); // ✅ pass pull
                break;
        }
    }
}
