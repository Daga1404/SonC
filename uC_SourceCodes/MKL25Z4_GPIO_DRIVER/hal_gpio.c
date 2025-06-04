/*
 * File: hal_gpio.c
 * Description: HAL implementation
 */
#include "hal_gpio.h"

void HAL_GPIO_InitOutput(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux) {
    MCAL_GPIO_EnableClock(port_info);
    MCAL_GPIO_ConfigOutput(port_info, pin, mux);
}

void HAL_GPIO_InitInput(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux) {
	MCAL_GPIO_EnableClock(port_info);
	MCAL_GPIO_ConfigInput(port_info, pin, mux);
}

void HAL_GPIO_InitALT(const MCAL_GPIO_Port_t *port_info, uint32_t pin, GPIO_Mux_t mux) {
	MCAL_GPIO_EnableClock(port_info);
	MCAL_GPIO_ConfigALT(port_info, pin, mux);
}

void HAL_GPIO_Write(const MCAL_GPIO_Port_t *port_info, uint32_t pin, uint8_t state) {
	MCAL_GPIO_WritePin(port_info, pin, state);
}

uint8_t HAL_GPIO_Read(const MCAL_GPIO_Port_t *port_info, uint32_t pin) {
	return MCAL_GPIO_ReadPin(port_info, pin);
}

void HAL_GPIO_Driver_Init(const GPIO_Config_t *config_table, uint32_t num_entries) {
    for (uint32_t i = 0; i < num_entries; i++) {
        if (config_table[i].direction == GPIO_DIR_OUTPUT) {
            HAL_GPIO_InitOutput(config_table[i].port_info, config_table[i].pin, config_table[i].mux);
        } else if (config_table[i].direction == GPIO_DIR_INPUT) {
            HAL_GPIO_InitInput(config_table[i].port_info, config_table[i].pin, config_table[i].mux);
        } else {
            HAL_GPIO_InitALT(config_table[i].port_info, config_table[i].pin, config_table[i].mux);
        }
    }
}
