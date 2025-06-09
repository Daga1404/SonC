/*
 * HAL_UART.c
 *
 *  Created on: Jun 6, 2025
 *      Author: dmart
 */


#include "HAL_UART.h"
#include "MCAL_UART.h"

static UART_Config uart_config;

void HAL_UART_Init(void) {
    uart_config.base = UART0;
    uart_config.baud_rate = 115200;
    uart_config.parity = UART_PARITY_NONE;
    uart_config.stop_bits = UART_STOPBITS_1;

    MCAL_UART_Init(&uart_config);
}

void HAL_UART_SendChar(char c) {
    MCAL_UART_SendChar(uart_config.base, c);
}

void HAL_UART_SendString(const char *str) {
    while (*str) {
        HAL_UART_SendChar(*str++);
    }
}
