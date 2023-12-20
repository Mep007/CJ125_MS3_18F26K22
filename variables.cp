#line 1 "C:/MCU/projects/CJ125_MS3_v1.0/variables.c"
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/resource.h"
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/typedefs.h"



typedef struct {
  unsigned short  Stat;
 char ch;
  unsigned short  UseTermCh;
 char TermCh;
  unsigned short  UseASCII;
  unsigned int  TIMEOUT;
  unsigned int  TimeCnt;
  unsigned int  CntBuf;

  unsigned int  BufLen;
} RxUart;

typedef struct {
  unsigned short  Blink_ON;
  unsigned short  Peroid;
} _led;


typedef struct {
  unsigned short  Cnt;
  unsigned short  _500msFlag;
  unsigned short  _1sFlag;

} _tmr;

typedef struct {
  unsigned short  LED_sel;
  unsigned short  _ON_time;
  unsigned int  _TOTAL_time;

} _LEDtmr;

typedef struct {
  unsigned short  i;


} myData;


typedef struct {
  unsigned int  SN;
  unsigned short  HW_ver;
  unsigned short  SW_ver;
  unsigned short  OPTION;

} EEprom;
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/hw_init.h"






extern sfr sbit BUT0_PIN;
extern sfr sbit LED1;
extern sfr sbit LED2;
extern sfr sbit LED3;
extern sfr sbit CJ125_CS;
extern sfr sbit CJ125_RST;
extern sfr sbit CJ125_Heater;
extern sfr sbit DAC1;


extern void HW_Init();
extern void LED_Welcome();
extern void UART_Welcome( unsigned short  ComNr, EEprom EE_Data);
extern void UART2_BT_Welcome();
extern void CR_LF( unsigned short  i);
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/variables.h"





extern  unsigned short  _txtU8[],_txtI8[],_txtU16[],_txtI16[],_txtFLOAT[],Tmp_buf[];
extern  unsigned short  u8TMP=0;
extern  int  I16_tmp=0;
extern  unsigned int  U16_tmp=0;
extern  unsigned long  U32_tmp=0;
extern float tmpFloat=0.0;
extern  unsigned short  ConfigMode=0;


extern _tmr CfgTmr;

extern  unsigned int  LED1_Cnt=0,LED2_Cnt=0,LED3_Cnt=0;
extern  unsigned short  LED1_Tresh=0,LED2_Tresh=0,LED3_Tresh=0;

extern  unsigned int  AD_KOEF=0,DAC_KOEF=0,VBAT_KOEF=0;
extern  short  DAC_COEF_OFS_EEPROM=0,ADC_COEF_OFS_EEPROM=0,VBAT_COEF_OFS_EEPROM=0;
extern  unsigned int  DAC_OUT=0;
extern  unsigned int  DAC_ERR_CNT=0;
extern  unsigned int  Heat_PWM=0,Heat_Target_PWM=0;
extern  unsigned int  ADC_RAW=0,CJ125_Ans=0;

extern float MAP=0.0;
extern  unsigned int  UA_mV=0,UR_mV=0,UA_mV_ref=0,UR_mV_ref=0,Vbat_mV=0,Vbat_init_mV=0;
extern  unsigned int  UA_avg=0,AFR_act=0;
extern  unsigned int  UA_results[11];
extern  unsigned short  MeasTime_Cnt=0,MeasStart=0;
extern  unsigned short  DisplayRefreshCnt=0;

extern char RX_buf[ 32+1 ];
extern  unsigned short  RX_Status=0,RX_BUF64_cnt=0,RX_Normal=1;
extern  unsigned int  RX_cnt=0;

extern RxUart rU1,rU2;
#line 59 "c:/mcu/projects/cj125_ms3_v1.0/variables.h"
extern char _PID_Calc;
extern float PID_OutPWM;
extern float pTerm;
extern float iTerm;
extern float dTerm;
extern  int  dState;
extern  int  iState;
extern  int  iMax;
extern  int  iMin;
extern float pGain;
extern float iGain;
extern float dGain;


extern EEprom EE_Consts;


extern  unsigned int  DAC1_Out=0, DAC2_Out=0;

extern  unsigned int  DAC_NB_EMUL[2* 3 ];
extern  unsigned int  DAC_LINEAR[2* 2 ];
extern  unsigned int  Innov_818_Tab[2* 9 ];

extern  int  cj42Tab [ 8 *2];
extern  int  cj49Tab[ 17 *2];

extern const code  unsigned int  Flash_Tables[];
extern  unsigned int  Flash_Buf64[];
extern  unsigned int  *pLSU42_Offset_Tab;
extern  unsigned int  *pLSU49_Offset_Tab;
extern  unsigned int  *pDAC1_Offset_Tab;
extern  unsigned int  *pDAC2_Offset_Tab;
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/support.h"



extern void UART_PrintCh( unsigned short  Nr, char ch);
extern void PrintF1(char *p_string);
extern void HC06_SendByteBuf( unsigned short  *pBuf,  unsigned short  BufLen);
extern void UART_PrintTxt(char UART_nr,char *p_string);
extern void PWM_Init_DAC1( unsigned int  mVout);
extern void PWM_Init_DAC2( unsigned int  mVout);
extern  unsigned int  DACx_mV_Out_10bit( unsigned short  ch,  unsigned int  OutmV);
extern  unsigned int  LinFit( int  X, int  pTab[],  unsigned short  Tab_size);
extern void BT_Send_Data( unsigned int  TxData);
extern  unsigned int  TxtToU16( unsigned short  *Buf);
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/ad.h"
#line 13 "c:/mcu/projects/cj125_ms3_v1.0/ad.h"
extern  unsigned int  Get_AD_mV( unsigned short  ch,  unsigned int  adc_koef);
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/bosch_cj125.h"
#line 26 "c:/mcu/projects/cj125_ms3_v1.0/bosch_cj125.h"
extern  unsigned int  CJ125_Write( unsigned int  TX_data);
extern  unsigned int  CJ125_Test(void);
extern  unsigned int  CJ125_Sensor_Test(void);
extern  unsigned int  CJ125_Vbat_check(void);
extern void CJ125_PreHeat_LSU( unsigned short  LSU);
extern  unsigned short  CJ125_Ri_Cal( unsigned short  LSU);

extern  int  CJ125_Calc_Ip(float Ua_mV,  unsigned short  Amplify);
extern  int  Heater_PID_Control( unsigned short  LSU,  int  input, int  target);
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/storage.h"
#line 19 "c:/mcu/projects/cj125_ms3_v1.0/storage.h"
extern void FLASH_64Words( unsigned int  Flash_Adr,  unsigned int  pBuf[]);
extern void EEPROM_Write_Constant( unsigned int  Adr,EEprom Cal_Data);
extern EEprom EEPROM_Read_Constant( unsigned int  Adr);
#line 6 "C:/MCU/projects/CJ125_MS3_v1.0/variables.c"
 unsigned short  _txtU8[4],_txtI8[5],_txtU16[6],_txtFLOAT[15],_txtI16[7], Tmp_buf[ 32 ];
 unsigned short  u8TMP=0;
 int  I16_tmp=0;
 unsigned int  U16_tmp=0;
 unsigned long  U32_tmp=0;
float tmpFloat=0.0;

 unsigned short  ConfigMode=0;



_tmr CfgTmr;

 unsigned int  LED1_Cnt=0,LED2_Cnt=0,LED3_Cnt=0;
 unsigned short  LED1_Tresh=0,LED2_Tresh=0,LED3_Tresh=0;

 unsigned int  AD_KOEF=0, DAC_KOEF=0,VBAT_KOEF=0;
 short  DAC_COEF_OFS_EEPROM=0,ADC_COEF_OFS_EEPROM=0,VBAT_COEF_OFS_EEPROM=0;
 unsigned int  DAC_OUT=0;
 unsigned int  DAC_ERR_CNT=0;
 unsigned int  Heat_PWM=0,Heat_Target_PWM=0;
 unsigned int  ADC_RAW=0,CJ125_Ans=0;

float MAP=0.0;
 unsigned int  UA_mV=0,UR_mV=0,UA_mV_ref=0,UR_mV_ref=0,Vbat_mV=0,Vbat_init_mV=0;
 unsigned int  UA_avg=0,AFR_act=0;
 unsigned int  UA_results[11];
 unsigned short  MeasTime_Cnt=0,MeasStart=0;
 unsigned short  DisplayRefreshCnt=0;

char RX_buf[ 32+1 ];
 unsigned short  RX_Status=0,RX_BUF64_cnt=0,RX_Normal=1;
 unsigned int  RX_cnt=0;

RxUart rU1,rU2;


char _PID_Calc=0;
float PID_OutPWM=0.0;
float pTerm=0.0;
float iTerm=0.0;
float dTerm=0.0;
 int  dState;
 int  iState;
 int  iMax = 250;
 int  iMin = -250;
float pGain = 0.0;
float iGain = 0.0;
float dGain = 0.0;


EEprom EE_Consts;



 unsigned int  DAC1_Out=0, DAC2_Out=0;


 unsigned int  DAC_NB_EMUL[ 3 *2] = { 1408, 1470, 1504,
 1100, 91, 86 };

 unsigned int  DAC_LINEAR[ 2 *2] = { 900, 1900,
 900, 4900 };


 int  cj42Tab [ 8 *2] = {
 -2240,-1850,-1080,-760,-470, 0, 340, 680,
 955, 1029, 1176,1250,1323,1483,1735,2102 };


 int  cj49Tab[ 17 *2] = {
 -2000,-1602,-1243,-927,-800,-652,-405,-183,-106, -40, 0, 15, 97, 193, 250, 329, 671,
 955, 1029, 1103,1176,1208,1250,1323,1397,1425,1455,1474,1485,1544,1617,1664,1733,2100 };

 unsigned int  Innov_818_Tab[ 9 *2] = { 800, 1000, 1200, 1300, 1400, 1470, 1500, 1600, 1800,
 990, 810, 600, 490, 390, 325, 275, 170, 1 };


 unsigned int  const code Flash_Tables[ 64 ] = {0xFF} absolute  0x0FE00 ;
 unsigned int  Flash_Buf64[ 64 ];
 unsigned int  *pLSU42_Offset_Tab = &Flash_Buf64[0];
 unsigned int  *pLSU49_Offset_Tab = &Flash_Buf64[10];
 unsigned int  *pDAC1_Offset_Tab = &Flash_Buf64[30];
 unsigned int  *pDAC2_Offset_Tab = &Flash_Buf64[35];
