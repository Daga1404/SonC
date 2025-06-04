#include "hal_tpm.h"
#include "mcal_tpm.h"

void HAL_TPM_Init(const HAL_TPM_Config_t *config) {
    MCAL_TPM_EnableClock(config->tpm);
    MCAL_TPM_SetClockSource(config->clk_src);
    MCAL_TPM_SetMOD(config->tpm, config->mod_value);
    MCAL_TPM_ConfigPWM(config->tpm, config->channel);
    MCAL_TPM_SetCnV(config->tpm, config->channel, 0); // Initial duty
    MCAL_TPM_Start(config->tpm, config->prescaler);
}

void HAL_TPM_SetPulse(TPM_Type *tpm, HAL_TPM_Channel_t ch, uint32_t value) {
    MCAL_TPM_SetCnV(tpm, ch, value);
}

