#ifndef MCAL_TPM_H
#define MCAL_TPM_H

#include <stdint.h>
#include <MKL25Z4.h>

void MCAL_TPM_EnableClock(TPM_Type *tpm);
void MCAL_TPM_SetClockSource(uint32_t src);
void MCAL_TPM_SetMOD(TPM_Type *tpm, uint32_t mod);
void MCAL_TPM_ConfigPWM(TPM_Type *tpm, uint8_t channel);
void MCAL_TPM_Start(TPM_Type *tpm, uint8_t prescaler);
void MCAL_TPM_SetCnV(TPM_Type *tpm, uint8_t channel, uint32_t value);

#endif // MCAL_TPM_H
