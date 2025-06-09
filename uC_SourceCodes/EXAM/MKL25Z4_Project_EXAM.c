#include "MKL25Z4.h"
#include "HAL_UART.h"

int main(void) {
    HAL_UART_Init();
    HAL_UART_SendString("Hi\n");

    while (1) {
        // Loop principal
    }
}

