/*
 * MCAL_UART.h
 *
 *  Created on: Jun 6, 2025
 *      Author: dmart
 */
#ifndef MCAL_UART_H
#define MCAL_UART_H

#include "UART_Types.h"

// Inicializa UART con configuración especificada
void MCAL_UART_Init(UART_Config *config);

// Envía un carácter por la UART indicada
void MCAL_UART_SendChar(UART0_Type *uart, char c);

#endif
