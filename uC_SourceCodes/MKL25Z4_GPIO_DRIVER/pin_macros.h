/*
 * pin_macros.h
 *
 *  Created on: Jun 3, 2025
 *      Author: dmart
 */
#ifndef PIN_MACROS_H
#define PIN_MACROS_H

// LED states
#define ON  0
#define OFF 1

// LED Pins
#define RED_LED_PIN   18 // PORTB
#define GREEN_LED_PIN 19 // PORTB
#define BLUE_LED_PIN  1  // PORTD

// UART pins
#define UART_0_RX 1 // PORTA, ALT2
#define UART_0_TX 2 // PORTA, ALT2
#define UART_1_RX 1 // PORTE, ALT3
#define UART_1_TX 0 // PORTE, ALT3
#define UART_2_RX 2 // PORTD, ALT3
#define UART_2_TX 3 // PORTD, ALT3

// TPM pins
#define TPM0_CH0 0 // PORTA, ALT3
#define TPM0_CH1 1 // PORTA, ALT3
#define TPM0_CH2 2 // PORTA, ALT3
#define TPM0_CH3 3 // PORTA, ALT3
#define TPM0_CH4 4 // PORTA, ALT3
#define TPM0_CH5 5 // PORTA, ALT3

#define TPM1_CH0 0 // PORTB, ALT3
#define TPM1_CH1 1 // PORTB, ALT3
#define TPM2_CH0 18 // PORTB, ALT3
#define TPM2_CH1 19 // PORTB, ALT3

// I2C pins
#define I2C0_SCL 24 // PORTE, ALT5
#define I2C0_SDA 25 // PORTE, ALT5
#define I2C1_SCL 0  // PORTB, ALT2
#define I2C2_SDA 1  // PORTB, ALT2

#endif // PIN_MACROS_H
