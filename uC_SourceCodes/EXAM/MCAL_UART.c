/*
 * MCAL_UART.c
 *
 *  Created on: Jun 6, 2025
 *      Author: dmart
 */


#include "MKL25Z4.h"
#include "UART_TYPES.h"

void MCAL_UART_Init(UART_Config *config) {
    // Habilita reloj para UART0 y Puerto A
    SIM->SCGC4 |= 0x0400;
    SIM->SCGC5 |= 0x0200;

    // Configura pines UART0_RX y UART0_TX
    PORTA->PCR[1] = 0x0200;
    PORTA->PCR[2] = 0x0200;

    UART0->C2 = 0; // Desactiva UART0 para configurar

    // Configura baud rate (suponiendo Fclk = 41.94 MHz, OSR = 15)
    uint16_t sbr = (uint16_t)(41940000 / (config->baud_rate * 16));
    UART0->BDH = (sbr >> 8) & 0x1F;
    UART0->BDL = sbr & 0xFF;
    UART0->C4 = 0x0F;

    // Configura paridad
    switch (config->parity) {
        case UART_PARITY_NONE:
            UART0->C1 &= ~UART0_C1_PE_MASK;
            break;
        case UART_PARITY_EVEN:
            UART0->C1 |= UART0_C1_PE_MASK;
            UART0->C1 &= ~UART0_C1_PT_MASK;
            break;
        case UART_PARITY_ODD:
            UART0->C1 |= UART0_C1_PE_MASK | UART0_C1_PT_MASK;
            break;
    }

    // Configura bits de parada (solo soporta 1 o 2 bits en algunos UART)
    if (config->stop_bits == UART_STOPBITS_2) {
        UART0->BDH |= UART0_BDH_SBNS_MASK;
    } else {
        UART0->BDH &= ~UART0_BDH_SBNS_MASK;
    }

    UART0->C2 = UART0_C2_TE_MASK; // Solo transmisión
}

void MCAL_UART_SendChar(UART0_Type *uart, char c) {
    while (!(uart->S1 & UART0_S1_TDRE_MASK)); // Espera buffer vacío
    uart->D = c;
}
