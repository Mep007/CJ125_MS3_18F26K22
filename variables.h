
// ====================================================================
// USER VARIABLE DECLARATIONS:
//
#define TMP_BUF_LEN    32  //
extern u8 _txtU8[],_txtI8[],_txtU16[],_txtI16[],_txtFLOAT[],Tmp_buf[];
extern u8 u8TMP=0;
extern i16 I16_tmp=0;
extern u16 U16_tmp=0;
extern u32 U32_tmp=0;
extern float tmpFloat=0.0;
extern u8 ConfigMode=0;
//extern u8 LSU_TYPE;
//extern button But0;
extern _tmr CfgTmr;

extern u16 LED1_Cnt=0,LED2_Cnt=0,LED3_Cnt=0;
extern u8 LED1_Tresh=0,LED2_Tresh=0,LED3_Tresh=0;

extern u16 AD_KOEF=0,DAC_KOEF=0,VBAT_KOEF=0;
extern i8 DAC_COEF_OFS_EEPROM=0,ADC_COEF_OFS_EEPROM=0,VBAT_COEF_OFS_EEPROM=0;
extern u16 DAC_OUT=0;
extern u16 DAC_ERR_CNT=0;
extern u16 Heat_PWM=0,Heat_Target_PWM=0;
extern u16 ADC_RAW=0,CJ125_Ans=0;

extern float MAP=0.0;
extern u16 UA_mV=0,UR_mV=0,UA_mV_ref=0,UR_mV_ref=0,Vbat_mV=0,Vbat_init_mV=0;
extern u16 UA_avg=0,AFR_act=0;
extern u16 UA_results[11];
extern u8 MeasTime_Cnt=0,MeasStart=0;
extern u8 DisplayRefreshCnt=0;

extern char RX_buf[RX_BUF_LEN]; //,RX_buf2[RX_BUF2_LEN];
extern u8 RX_Status=0,RX_BUF64_cnt=0,RX_Normal=1;
extern u16 RX_cnt=0;

extern RxUart rU1,rU2;
#define       RX_FLAG         rU1.Stat.B4
#define       BUF1_OVERR      rU1.Stat.B0  // preteceni bufferu = 1, jinak 0
#define       BUF1_TIMEOUT    rU1.Stat.B1
#define       BUF1_TEMINATED  rU1.Stat.B2
#define       UART1_NEW_DATA  rU1.Stat.B3

#define       BUF2_OVERR      rU2.Stat.B0  // preteceni bufferu = 1, jinak 0
#define       BUF2_TIMEOUT    rU2.Stat.B1
#define       BUF2_TEMINATED  rU2.Stat.B2
#define       UART2_NEW_DATA  rU2.Stat.B3

#define UART1_FIX_ERR if (FERR1_bit || OERR1_bit) { SPEN1_bit = TXEN1_bit = CREN1_bit = 0; SPEN1_bit = TXEN1_bit = CREN1_bit = 1; }
#define UART2_FIX_ERR if (FERR2_bit || OERR2_bit) { SPEN2_bit = TXEN2_bit = CREN2_bit = 0; SPEN2_bit = TXEN2_bit = CREN2_bit = 1; }

//extern u16 RX_cnt2=0;

//extern float LAMBDA_IP=0; // LAMBDA_O2=0;
//extern sbit RX_Flag at RX_Status.B0; - todle nefunguje

//PID regulation variables.
extern char _PID_Calc;
extern float PID_OutPWM;
extern float pTerm;
extern float iTerm;
extern float dTerm;
extern i16 dState;                                                         /* Last position input. */
extern i16 iState;                                                         /* Integrator state. */
extern i16 iMax;                                               /* Maximum allowable integrator state. */
extern i16 iMin;                                              /* Minimum allowable integrator state. */
extern float pGain;                                            /* Proportional gain. Default = 120*/
extern float iGain;                                            /* Integral gain. Default = 0.8*/
extern float dGain;                                             /* Derivative gain. Default = 10*/


extern EEprom EE_Consts;


extern u16 DAC1_Out=0, DAC2_Out=0;
 // Tabulky
extern u16 DAC_NB_EMUL[2*DAC_NB_EMUL_SIZE];
extern u16 DAC_LINEAR[2*DAC_LINEAR_SIZE];
extern u16 Innov_818_Tab[2*INOV818_TAB_SIZE];

extern i16 cj42Tab [CJ42_TAB_SIZE*2];  // .. proto je pole 2x vetsi
extern i16 cj49Tab[CJ49_TAB_SIZE*2];

extern const code u16 Flash_Tables[];
extern u16 Flash_Buf64[];
extern u16 *pLSU42_Offset_Tab;
extern u16 *pLSU49_Offset_Tab;
extern u16 *pDAC1_Offset_Tab;
extern u16 *pDAC2_Offset_Tab;