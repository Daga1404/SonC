/*
 * UART_TYPES.h
 *
 *  Created on: Jun 6, 2025
 *      Author: dmart
 */
#ifndef UART_TYPES_H
#define UART_TYPES_H

#include <stdint.h>
#include "MKL25Z4.h"

typedef enum {
    UART_PARITY_NONE,
    UART_PARITY_EVEN,
    UART_PARITY_ODD
} UART_parity;

typedef enum {
    UART_STOPBITS_1,
    UART_STOPBITS_2
} UART_stop_bits;

typedef struct {
    UART0_Type *base;        // Instancia de UART, ej. UART0
    uint32_t baud_rate;      // Baud rate deseado
    UART_parity parity;      // Configuración de paridad
    UART_stop_bits stop_bits; // Bits de parada
} UART_Config;

#endif
