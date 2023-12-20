#line 1 "C:/MCU/CJ125_MS3_v1.0/trunk/MPHX6400A.c"
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/resource.h"
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/typedefs.h"



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
  unsigned short  Cnt;
  unsigned short  _500msFlag;
  unsigned short  _1sFlag;

} _tmr;

typedef struct {
  unsigned short  i;


} myData;


typedef struct {
  unsigned int  SN;
  unsigned short  HW_ver;
 char HW_name[10];
  unsigned short  LSU_sel;
  unsigned short  MAP_sel;
  unsigned short  DisplaySel;
  unsigned short  DispIntens;
} EEpromStore;


typedef struct {
  unsigned short  Cnt;
  unsigned short  Lcnt;
  unsigned short  Press;
  unsigned short  Lpress;
  unsigned short  Armed;
  unsigned short  Larmed;
  unsigned short  Click;
  unsigned short  MaxClicks;
  unsigned short  CfgMenu;
} button;
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/hw_init.h"






extern sfr sbit BUT0_PIN;
extern sfr sbit LED1;
extern sfr sbit LED2;
extern sfr sbit LED3;
extern sfr sbit MAX7219_CS;
extern sfr sbit CJ125_CS;
extern sfr sbit CJ125_RST;
extern sfr sbit CJ125_Heater;
extern sfr sbit DAC1;


extern void HW_Init();
extern void LED_Welcome();
extern void UART_Welcome( unsigned short  ComNr, EEpromStore EE_Data);
extern void UART2_BT_Welcome();
extern void CR_LF( unsigned short  i);
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/variables.h"





extern  unsigned short  _txtU8[],_txtU16[],_txtFLOAT[],Tmp_buf[];
extern  unsigned short  u8TMP=0;
extern  unsigned int  U16_tmp=0;
extern  unsigned long  U32_tmp=0;
extern float tmpFloat=0.0;
extern  unsigned short  ConfigMode=0;

extern button But0;
extern _tmr CfgTmr;

extern  unsigned int  DAC_OUT=0;
extern  unsigned int  Heat_PWM=0,Heat_Target_PWM=0;
extern  unsigned int  ADC_RAW=0,CJ125_Ans=0;

extern float MAP=0.0;
extern  unsigned int  UA_mV=0,UR_mV=0,UA_mV_ref=0,UR_mV_ref=0,Vbat_mV=0;
extern  unsigned int  UA_avg=0,AFR_act=0;
extern  unsigned int  UA_results[11];
extern  unsigned short  MeasTime_Cnt=0,MeasStart=0;
extern  unsigned short  DisplayRefreshCnt=0;

extern char RX_buf[ 32+1 ],RX_buf2[ 32+1 ];
extern  unsigned short  RX_Status=0,RX_BUF64_cnt=0,RX_Normal=1;
extern  unsigned int  RX_cnt=0;

extern RxUart rU1,rU2;
#line 52 "c:/mcu/cj125_ms3_v1.0/trunk/variables.h"
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


extern EEpromStore EE_Consts;


extern  unsigned int  DAC1_Out=0, DAC2_Out=0;

extern  unsigned int  DAC_NB_EMUL[2* 3 ];
extern  unsigned int  DAC_LINEAR[2* 3 ];
extern  unsigned int  Innov_818_Tab[2* 9 ];

extern  int  cj42Tab [ 8 *2];
extern  int  cj49Tab[ 8 *2];

extern const code  unsigned int  Flash_Tables[];
extern  unsigned int  Flash_Buf64[];
extern  unsigned int  *pLSU42_Offset_Tab;
extern  unsigned int  *pLSU49_Offset_Tab;
extern  unsigned int  *pDAC1_Offset_Tab;
extern  unsigned int  *pDAC2_Offset_Tab;
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/support.h"



extern void UART_PrintCh( unsigned short  Nr, char ch);
extern void PrintF1(char *p_string);
extern void HC06_SendByteBuf( unsigned short  *pBuf,  unsigned short  BufLen);
extern void UART_PrintTxt(char UART_nr,char *p_string);
extern void PWM_Init_DAC1( unsigned int  mVout);
extern void PWM_Init_DAC2( unsigned int  mVout);
extern void DACx_mV_Out_10bit( unsigned short  ch,  unsigned int  OutmV);
extern  unsigned int  LinFit( int  X, int  pTab[],  unsigned short  Tab_size);
extern void BT_Send_Data( unsigned int  TxData);
extern  unsigned int  TxtToU16( unsigned short  *Buf);
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/ad.h"
#line 19 "c:/mcu/cj125_ms3_v1.0/trunk/ad.h"
extern  unsigned int  Get_AD_mV( unsigned short  ch,  unsigned int  adc_koef);
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/max7219.h"


extern void MAX7219_Init(unsigned char nr_digits, unsigned char intensity);
extern void MAX7219_DisplayOnOff(unsigned char on_off);
extern void MAX7219SetIntensity(unsigned char new_intensity);
extern void MAX7219_TestDisplay(unsigned char on_off);
extern void MAX7219_ShowNumber(unsigned long Number, unsigned char firstDigit, unsigned char numberOfDigits);
extern void MAX7219_ShowDigit(unsigned char number, unsigned char digit);
extern void MAX7219_PrintAFR( unsigned int  temp,char DP, unsigned short  type);
extern void MAX7219_PrintMAP( unsigned int  temp,char DP);
extern void MAX7219_ShowLSUName( unsigned int  num);
extern void MAX7219_ShowNumAuto( unsigned int  num);
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/bosch_cj125.h"
#line 26 "c:/mcu/cj125_ms3_v1.0/trunk/bosch_cj125.h"
extern  unsigned int  CJ125_Write( unsigned int  TX_data);
extern  unsigned int  CJ125_Test(void);
extern void CJ125_PreHeat_LSU( unsigned short  LSU);
extern  unsigned short  CJ125_Ri_Cal( unsigned short  LSU);

extern  int  CJ125_Calc_Ip(float Ua_mV,  unsigned short  Amplify);
extern  int  Heater_PID_Control( unsigned short  LSU,  int  input, int  target);
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/mpxh6400a.h"


extern void MAP_Calc( unsigned int  MAP_mV, unsigned short  type);
#line 1 "c:/mcu/cj125_ms3_v1.0/trunk/storage.h"
#line 22 "c:/mcu/cj125_ms3_v1.0/trunk/storage.h"
extern void FLASH_64Words( unsigned int  Flash_Adr,  unsigned int  pBuf[]);
extern void EEPROM_Write_Constant( unsigned int  Adr,EEpromStore Cal_Data);
extern EEpromStore EEPROM_Read_Constant( unsigned int  Adr);
#line 4 "C:/MCU/CJ125_MS3_v1.0/trunk/MPHX6400A.c"
void MAP_Calc( unsigned int  MAP_mV, unsigned short  type) {
 if (type == 1) MAP = ((float)MAP_mV + 4.2) / 12.105;
 else if (type == 2) MAP = ((float)MAP_mV + 1.765) / 15.9;

}
