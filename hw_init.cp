#line 1 "C:/MCU/projects/CJ125_MS3_v1.0/hw_init.c"
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
#line 7 "C:/MCU/projects/CJ125_MS3_v1.0/hw_init.c"
sfr sbit BUT0_PIN at RA3_bit;
sfr sbit LED1 at LATA6_bit;
sfr sbit LED2 at LATB3_bit;
sfr sbit LED3 at LATB4_bit;
sfr sbit DAC1 at LATA4_bit;


sfr sbit CJ125_CS at LATC1_bit;
sfr sbit CJ125_RST at LATC2_bit;
sfr sbit CJ125_Heater at LATB0_bit;



void HW_Init() {

 PORTA = LATA = 0;
 ANSELA = 0b00100111;
 TRISA = 0b10101111;

 PORTB = LATB = 0;
 ANSELB = 0;
 TRISB = 0b11000010;

 PORTC = LATC = 0b00000011;
 ANSELC = 0;
 TRISC = 0b11010000;




 OSCCON = 0b01010000;

 PLLEN_bit = 1;

 while (!HFIOFS_bit);
 while (!PLLRDY_bit);

 PMD0 = 0;

 Delay_ms(250);


 TXSTA1 = RCSTA1 = 0;
 BRG16_BAUD1CON_bit = 1;
 BRGH1_bit = 1;
 SPBRGH1 = 0; SPBRG1 = 34;
 SYNC1_bit = 0;
 SPEN1_bit = 1;
 TXEN1_bit = CREN1_bit = 1;

 rU1.Stat = 0;
 rU1.UseTermCh =  0 ;
 rU1.TermCh = 10;
 rU1.UseASCII = 1;
 rU1.TIMEOUT =  400*100 ;
 rU1.TimeCnt = 0;
 rU1.CntBuf = 0;
 rU1.BufLen =  32+1 ;
#line 93 "C:/MCU/projects/CJ125_MS3_v1.0/hw_init.c"
 T0CON = 0x81;
 TMR0H = 0x3C; TMR0L = 0xB0; TMR0IF_bit = 0; TMR0IE_bit = 0;


 T6CON = 0x4E; TMR6IF_bit = 0; PR6 = 250; TMR6IE_bit = 1;


 ADC_Init();



 CJ125_CS = 1;
 CJ125_RST = 0;

 LED_Welcome();

 for (u8TMP=0; u8TMP < 10; u8TMP++) UA_results[u8TMP] = 0;
 for (u8TMP=0; u8TMP <  32+1 ; u8TMP++) RX_buf[u8TMP] = 0;

 for (u8TMP=0; u8TMP <  32 ; u8TMP++) Tmp_buf[u8TMP] = u8TMP;





  if (FERR1_bit || OERR1_bit) { SPEN1_bit = TXEN1_bit = CREN1_bit = 0; SPEN1_bit = TXEN1_bit = CREN1_bit = 1; } 

 u8TMP = RCREG1; u8TMP = RCREG2;


 EE_Consts = EEPROM_Read_Constant( 0x00 );



 ADC_COEF_OFS_EEPROM = EEPROM_Read( 0x10 ); delay_ms(20);

 if ((ADC_COEF_OFS_EEPROM >= 50) && (ADC_COEF_OFS_EEPROM <= -50)) {
 ADC_COEF_OFS_EEPROM = 0;
 }
 AD_KOEF =  489  + ADC_COEF_OFS_EEPROM; Delay_ms(20);

 DAC_COEF_OFS_EEPROM = EEPROM_Read( 0x12 );
 if ((DAC_COEF_OFS_EEPROM >= 40) && (DAC_COEF_OFS_EEPROM <= -40)){
 DAC_COEF_OFS_EEPROM = 5;
 }
 DAC_KOEF =  489  - DAC_COEF_OFS_EEPROM; Delay_ms(20);


 VBAT_COEF_OFS_EEPROM = EEPROM_Read( 0x11 ); delay_ms(20);
 if ((VBAT_COEF_OFS_EEPROM >= 50) && (VBAT_COEF_OFS_EEPROM <= -50)) {
 VBAT_COEF_OFS_EEPROM = 0;
 }
 VBAT_KOEF =  ( 489  * 11 )  + VBAT_COEF_OFS_EEPROM;



 PWM4_Init(1000);
 PWM4_Set_Duty(0);

 PWM_Init_DAC1( 300 );

 PWM_Init_DAC2( 300 );

 RC1IE_bit = 1;

 PEIE_bit = 1;
 GIE_GIEH_bit = 1 ;
}


void LED_Welcome() {
 LED1=1; Delay_ms(100); LED1=0;
 LED2=1; Delay_ms(100); LED2=0;
 LED3=1; Delay_ms(100); LED3=0;
}

void UART_Welcome( unsigned short  ComNr, EEprom EE_Data){
 CR_LF(ComNr);
 CR_LF(ComNr);
 if (ComNr == 1){
 UART_PrintTxt(ComNr,"MS3_MEP WBO Controller:"); CR_LF(ComNr);
 UART_PrintTxt(ComNr,"============================"); CR_LF(ComNr);
 UART_PrintTxt(ComNr,"SN: ");  WordToHex(EE_Data.SN,_txtU16); UART_PrintTxt(ComNr,"0x"); UART_PrintTxt(ComNr,_txtU16); ;CR_LF(ComNr);
 UART_PrintTxt(ComNr,"HW_VER: ");  ByteToStr(EE_Data.HW_ver,_txtU8); UART_PrintTxt(ComNr,_txtU8); ; CR_LF(ComNr);
 UART_PrintTxt(ComNr,"SW_VER: ");  ByteToStr(EE_Data.SW_ver,_txtU8); UART_PrintTxt(ComNr,_txtU8); ; CR_LF(ComNr);
 UART_PrintTxt(ComNr,"OPTION: ");  ByteToStr(EE_Data.OPTION,_txtU8); UART_PrintTxt(ComNr,_txtU8); ; CR_LF(ComNr);
 CR_LF(ComNr);
 UART_PrintTxt(ComNr,"EEPROM CALIBRATION DATA:"); CR_LF(ComNr);
 UART_PrintTxt(ComNr,"============================"); CR_LF(ComNr);
 UART_PrintTxt(1,"  ADC_OFFSET=");  ShortToStr(ADC_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(ComNr,_txtI8); ; UART_PrintTxt(ComNr,", AD_KOEF=");  WordToStr(AD_KOEF,_txtU16); UART_PrintTxt(ComNr,_txtU16); ; CR_LF(ComNr);
 UART_PrintTxt(1,"  DAC_OFFSET=");  ShortToStr(DAC_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(ComNr,_txtI8); ; UART_PrintTxt(ComNr,", DAC_KOEF=");  WordToStr(DAC_KOEF,_txtU16); UART_PrintTxt(ComNr,_txtU16); ; CR_LF(ComNr);
 UART_PrintTxt(1,"  VBAT_OFFSET="); ShortToStr(VBAT_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(ComNr,_txtI8); ; UART_PrintTxt(ComNr,",VBAT_KOEF=");  WordToStr(VBAT_KOEF,_txtU16); UART_PrintTxt(ComNr,_txtU16); ; CR_LF(ComNr);
 CR_LF(ComNr);
 CR_LF(ComNr);
 }
}
#line 193 "C:/MCU/projects/CJ125_MS3_v1.0/hw_init.c"
void CR_LF( unsigned short  i) {
 if (i == 1) { TXREG1 =10; while(!TX1STA.B1); TXREG1 =13; while(!TX1STA.B1); }
 else { TXREG2 =10; while(!TX2STA.B1); TXREG2 =13; while(!TX2STA.B1); }
}
