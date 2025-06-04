/*
 * mcal_tpm.c
 *
 *  Created on: Jun 3, 2025
 *      Author: dmart
 */


#include "mcal_tpm.h"

void MCAL_TPM_EnableClock(TPM_Type *tpm) {
    if (tpm == TPM0) SIM->SCGC6 |= SIM_SCGC6_TPM0_MASK;
    else if (tpm == TPM1) SIM->SCGC6 |= SIM_SCGC6_TPM1_MASK;
    else if (tpm == TPM2) SIM->SCGC6 |= SIM_SCGC6_TPM2_MASK;
}

void MCAL_TPM_SetClockSource(uint32_t src) {
    SIM->SOPT2 = (SIM->SOPT2 & ~SIM_SOPT2_TPMSRC_MASK) | SIM_SOPT2_TPMSRC(src);
}

void MCAL_TPM_SetMOD(TPM_Type *tpm, uint32_t mod) {
    tpm->MOD = mod - 1;
}

void MCAL_TPM_ConfigPWM(TPM_Type *tpm, uint8_t ch) {
    tpm->CONTROLS[ch].CnSC = TPM_CnSC_MSB_MASK | TPM_CnSC_ELSB_MASK;
}

void MCAL_TPM_Start(TPM_Type *tpm, uint8_t prescaler) {
    tpm->SC = TPM_SC_CMOD(1) | TPM_SC_PS(prescaler);
}

void MCAL_TPM_SetCnV(TPM_Type *tpm, uint8_t ch, uint32_t value) {
    tpm->CONTROLS[ch].CnV = value;
}
