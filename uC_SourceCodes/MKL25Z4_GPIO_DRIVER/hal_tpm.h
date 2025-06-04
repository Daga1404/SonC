#ifndef HAL_TPM_H
#define HAL_TPM_H

#include <stdint.h>
#include <MKL25Z4.h>

typedef enum {
    HAL_TPM_CH_0 = 0,
    HAL_TPM_CH_1 = 1,
    HAL_TPM_CH_2 = 2,
    HAL_TPM_CH_3 = 3,
    HAL_TPM_CH_4 = 4,
    HAL_TPM_CH_5 = 5
} HAL_TPM_Channel_t;

typedef struct {
    TPM_Type *tpm;
    HAL_TPM_Channel_t channel;
    uint32_t mod_value;
    uint8_t clk_src;      // 0~3 for TPM clock sources
    uint8_t prescaler;    // 0~7 for TPM_SC_PS
} HAL_TPM_Config_t;

void HAL_TPM_Init(const HAL_TPM_Config_t *config);
void HAL_TPM_SetPulse(TPM_Type *tpm, HAL_TPM_Channel_t ch, uint32_t value);

#endif // HAL_TPM_H
