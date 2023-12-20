#include "resource.h"

// ====================================================================
// USER VARIABLE DEFINITIONS:

u8 _txtU8[4],_txtI8[5],_txtU16[6],_txtFLOAT[15],_txtI16[7], Tmp_buf[TMP_BUF_LEN];
u8 u8TMP=0;
i16 I16_tmp=0;
u16 U16_tmp=0;
u32 U32_tmp=0;
float tmpFloat=0.0;

u8 ConfigMode=0;
//u8 LSU_TYPE = LSU49;

//button But0;
_tmr CfgTmr;

u16 LED1_Cnt=0,LED2_Cnt=0,LED3_Cnt=0;
u8 LED1_Tresh=0,LED2_Tresh=0,LED3_Tresh=0;

u16 AD_KOEF=0, DAC_KOEF=0,VBAT_KOEF=0;
i8 DAC_COEF_OFS_EEPROM=0,ADC_COEF_OFS_EEPROM=0,VBAT_COEF_OFS_EEPROM=0;
u16 DAC_OUT=0;
u16 DAC_ERR_CNT=0;
u16 Heat_PWM=0,Heat_Target_PWM=0;
u16 ADC_RAW=0,CJ125_Ans=0;

float MAP=0.0;
u16 UA_mV=0,UR_mV=0,UA_mV_ref=0,UR_mV_ref=0,Vbat_mV=0,Vbat_init_mV=0;
u16 UA_avg=0,AFR_act=0;
u16 UA_results[11];
u8 MeasTime_Cnt=0,MeasStart=0;
u8 DisplayRefreshCnt=0;

char RX_buf[RX_BUF_LEN]; //, RX_buf2[RX_BUF2_LEN];
u8 RX_Status=0,RX_BUF64_cnt=0,RX_Normal=1;
u16 RX_cnt=0;

RxUart rU1,rU2;

//PID regulation variables.
char _PID_Calc=0;
float PID_OutPWM=0.0;
float pTerm=0.0;            // PID slozky nastaveny primo ve fci
float iTerm=0.0;
float dTerm=0.0;
i16 dState;                 /* Last position input. */
i16 iState;                 /* Integrator state. */
i16 iMax = 250;             /* Maximum allowable integrator state. */
i16 iMin = -250;            /* Minimum allowable integrator state. */
float pGain = 0.0;
float iGain = 0.0;
float dGain = 0.0;

// EEPROM
EEprom EE_Consts;


// Tabulky pro IP vs AFR, DACx....
u16 DAC1_Out=0, DAC2_Out=0;
// tabulka pro DAC emulaci NB sondy - AFR vs Vout[mV] - dle Innovate PDF k LC1 (AFR 14.0 = 1.1V a 15.0 = 0.12V
//   14.08AFR ~ 1.1V, 15.01AFR ~ 0.118V -
u16 DAC_NB_EMUL[DAC_NB_EMUL_SIZE*2] = { 1408, 1470, 1504,   // - osa X - AFR   vs
                                        1100,   91,   86 };    // - osa Y -  DAC output [mV] values
//   10AFR ~ 0V, 20AFR ~ 5V - tabulka pro AFR vs DAC2 out [mV]
u16 DAC_LINEAR[DAC_LINEAR_SIZE*2] = { 900, 1900,   // - osa X - AFR vs was: 900/150,1470/3000, 1870/5000
                                      900, 4900 };    // - osa Y - DAC output [mV] values
// LSU 4.2  - 1D tab pro lin. interpolaci proudu Ip vs AFR  - z RusEFI fora - stejne jako PDF, jen navic prvni hodnota pro Ip=-2.2mA

i16 cj42Tab [CJ42_TAB_SIZE*2] = {
    -2240,-1850,-1080,-760,-470,   0, 340, 680,          // = Ip*1000 - prepocitano z floatu na inty
      955, 1029, 1176,1250,1323,1483,1735,2102 };  // AFR
// LSU 4.9  - 1D tab pro lin. interpolaci proudu Ip vs AFR  - z RusEFI fora - lehce jine nez v PDF od sondy

i16 cj49Tab[CJ49_TAB_SIZE*2] = {
     -2000,-1602,-1243,-927,-800,-652,-405,-183,-106, -40,   0,  15,  97, 193, 250, 329, 671,   // *1000 - prepocitano z floatu na inty
       955, 1029, 1103,1176,1208,1250,1323,1397,1425,1455,1474,1485,1544,1617,1664,1733,2100 };   //AFR
       
u16 Innov_818_Tab[INOV818_TAB_SIZE*2] = { 800, 1000, 1200, 1300, 1400, 1470, 1500, 1600, 1800,   // - osa X - AFR   vs
                                          990,  810,  600,  490,  390,  325,  275,  170,    1 };
                                          
// Flash promenna ulozenych tabulek pro offset, DACy apod.
u16 const code Flash_Tables[RX_FLASH_BUF_LEN] = {0xFF} absolute FLASH_TAB_ADR;
u16 Flash_Buf64[RX_FLASH_BUF_LEN];      // dtto v RAM pro praci s daty z Flash
u16 *pLSU42_Offset_Tab = &Flash_Buf64[0];
u16 *pLSU49_Offset_Tab = &Flash_Buf64[10]; // pointery na zacatky jednotlicych tabulek
u16 *pDAC1_Offset_Tab = &Flash_Buf64[30];
u16 *pDAC2_Offset_Tab = &Flash_Buf64[35];