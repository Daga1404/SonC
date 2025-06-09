/*
 * HAL_UART.h
 *
 *  Created on: Jun 6, 2025
 *      Author: dmart
 */
#ifndef HAL_UART_H
#define HAL_UART_H

void HAL_UART_Init(void);
void HAL_UART_SendChar(char c);
void HAL_UART_SendString(const char *str);

#endif
