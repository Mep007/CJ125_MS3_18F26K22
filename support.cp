#line 1 "C:/MCU/projects/CJ125_MS3_v1.0/support.c"
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
#line 4 "C:/MCU/projects/CJ125_MS3_v1.0/support.c"
void UART_PrintCh( unsigned short  Nr, char ch) {
 if (Nr == 1) {
 TXREG1 = ch;
 asm { nop };
 while (!TX1STA.B1);
 }
 else if (Nr == 2) {
 TXREG2 = ch;
 asm { nop };
 while (!TX2STA.B1);
 }
}

void PrintF1( char *p_string )
{
 char n;
 n = 0;
 while( p_string[n]) {
 while (!TRMT_TX1STA_bit);
 TXREG1 = p_string[n++];

 }
}


void HC06_SendByteBuf( unsigned short  pBuf[],  unsigned short  BufLen) {
  unsigned short  n=0;
 while(BufLen--) {
 TXREG2 = pBuf[n++];
 asm { nop };
 while (!TX2STA.B1);
 }
}


void UART_PrintTxt(char UR_nr,char *p_string){
 while(*p_string > 31) {
 if (UR_nr == 1) {
 TXREG1 = *(p_string++); while (!TX1STA.B1); }
 else if (UR_nr == 2) {
 TXREG2 = *(p_string++); while (!TX2STA.B1); }
 }
}


void PWM_Init_DAC1( unsigned int  mVout) {
 CCP3CON = 0b00001100;
 C3TSEL0_bit = 0; C3TSEL0_bit = 1;
 PR4 = 0xFF;
 TMR4ON_bit = 1;
 DACx_mV_Out_10bit(1,mVout);
}
void PWM_Init_DAC2( unsigned int  mVout) {
 CCP5CON = 0b00001100;
 C5TSEL0_bit = 0; C5TSEL0_bit = 1;
 PR4 = 0xFF;
 TMR4ON_bit = 1;
 DACx_mV_Out_10bit(2,mVout);
}


 unsigned int  DACx_mV_Out_10bit( unsigned short  ch,  unsigned int  OutmV) {
  unsigned int  PWM_raw=0;

 U32_tmp = ( unsigned long )OutmV * 100;
 U32_tmp = U32_tmp / DAC_KOEF;

 if (U32_tmp >= 1023) U32_tmp = 1023;
 PWM_raw = ( unsigned int )U32_tmp;

 if (ch==1) {

 if ((U32_tmp & 0b01) == 1) DC3B0_bit = 1;
 else DC3B0_bit = 0;
 if ((U32_tmp & 0b10) == 2) DC3B1_bit = 1;
 else DC3B1_bit = 0;
 U32_tmp >>=2;
 CCPR3L = ( unsigned short )U32_tmp;
 return PWM_raw;
 }
 else if (ch==2) {

 if ((U32_tmp & 0b01) == 1) DC5B0_bit = 1;
 else DC5B0_bit = 0;
 if ((U32_tmp & 0b10) == 2) DC5B1_bit = 1;
 else DC5B1_bit = 0;
 U32_tmp >>=2;
 CCPR5L = ( unsigned short )U32_tmp;
 return PWM_raw;
 }
}

 unsigned int  LinFit( int  X, int  pTab[],  unsigned short  Tab_size) {
  long  X_k1=0,Y_k1=0,X_k=0,Y_k=0,Y=0,Xmin=0,Xmax=0;
  unsigned short  id=0;

 Xmin = pTab[0];
 Xmax = pTab[Tab_size-1];
 if (X <= Xmin) { return pTab[Tab_size]; }
 else if (X >= Xmax) { return ( int )pTab[(Tab_size+Tab_size)-1]; }

 do {
 X_k1 = pTab[id];
 if (X_k1 == X) return ( int )pTab[id + Tab_size];
 if (X_k1 > X) {
 Y_k1 = pTab[Tab_size+id];
 X_k = pTab[id-1];
 Y_k = pTab[(id+Tab_size)-1];
 Y = (Y_k * (X - X_k1) - Y_k1 * (X - X_k)) / (X_k - X_k1) ;

 return ( unsigned int )Y;
 }
 id++;
 } while (id < Tab_size);
#line 124 "C:/MCU/projects/CJ125_MS3_v1.0/support.c"
 return 0;
}

void BT_Send_Data( unsigned int  TxData) {
  unsigned int  TX=0,tmp=0;
 TX = TxData / 10;
 tmp = TxData % 10;
 if (tmp >= 5) TX++;
 TXREG2 = TX; while(!TX2STA.B1);
}


 unsigned int  TxtToU16(char *Buf) {
  unsigned int  res=0;
  unsigned short  numBuf[4];
  unsigned short  i=0,*pNu;

 pNu = strstr(Buf,"=");
 pNu++;
 while ((*pNu > 47) && (*pNu < 58) && (i < 4)) {
 numBuf[i++] = *pNu - 48;
 pNu++;
 }
 if (i == 0) return res=0;
 i--;
 if (i == 3) {
 res = ( unsigned int )numBuf[0] * 1000;
 res += ( unsigned int )(numBuf[1] * 100);
 res += ( unsigned int )(numBuf[2] * 10);
 res += ( unsigned int )numBuf[3];
 return res;
 }
 else if (i == 2) {
 res = ( unsigned int )numBuf[0] * 100;
 res += ( unsigned int )numBuf[1] * 10;
 res += ( unsigned int )numBuf[2];
 return res;
 }
 else if (i == 1) {
 res = ( unsigned int )numBuf[0] * 10;
 res += ( unsigned int )numBuf[1];
 return res;
 }
 else res = numBuf[0];
 return res;
}
