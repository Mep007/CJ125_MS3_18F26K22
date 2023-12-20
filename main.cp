#line 1 "C:/MCU/projects/CJ125_MS3_v1.0/main.c"
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
#line 41 "C:/MCU/projects/CJ125_MS3_v1.0/main.c"
void UART_Service();
void DACx_Service( unsigned int  AFR_Val, unsigned short  UseGauge);
void DACx_Err_Mode( unsigned int  start_DAC, unsigned int  max_DAC_add,  unsigned int  step);
 unsigned int  LSU_PID_Heater_Service( unsigned int  Ur_Act, unsigned int  Ur_Target);
#line 56 "C:/MCU/projects/CJ125_MS3_v1.0/main.c"
void interrupt() {
 char tmp=0,i=0;
  unsigned int  RX_cnt=0;

 if (TMR6IF_bit && TMR6IE_bit){

 if (LED1_Tresh == 255) LED1 = 1;
 else if (LED1_Tresh == 0) LED1 = 0;
 else if (LED1_Cnt >= LED1_Tresh) { LED1 ^= 1; LED1_Cnt = 0; }

 if (LED2_Tresh == 255) LED2 = 1;
 else if (LED2_Tresh == 0) LED2 = 0;
 else if (LED2_Cnt >= LED2_Tresh) { LED2 ^= 1; LED2_Cnt = 0; }

 if (LED3_Tresh == 255) LED3 = 1;
 else if (LED3_Tresh == 0) LED3 = 0;
 else if (LED3_Cnt >= LED3_Tresh) { LED3 ^= 1; LED3_Cnt = 0; }

 LED1_Cnt++; LED2_Cnt++; LED3_Cnt++;
 TMR6IF_bit = 0;
 return;
 }


 if (TMR0IF_bit && TMR0IE_bit){
 _PID_Calc++;
 DisplayRefreshCnt++;
 MeasStart=1;
 TMR0H = 0x3C; TMR0L = 0xB0;
 TMR0IF_bit = 0;

 return;
 }



 if (RC1IF_bit && RC1IE_bit){


  LED3_Tresh = 10; 
  rU1.Stat.B1  =  rU1.Stat.B0  =  rU1.Stat.B2  = 0;
  rU1.Stat.B3  = 1;
 rU1.ch = rU1.CntBuf = rU1.TimeCnt= 0;
 while(! rU1.Stat.B0  && ! rU1.Stat.B1  && ! rU1.Stat.B2 ) {
 if(RC1IF_bit) {
  if (FERR1_bit || OERR1_bit) { SPEN1_bit = TXEN1_bit = CREN1_bit = 0; SPEN1_bit = TXEN1_bit = CREN1_bit = 1; } 
 rU1.ch = RC1REG;
 if (rU1.CntBuf < (rU1.BufLen-1)) {
 if (rU1.UseASCII) {
 if (rU1.UseTermCh) {
 if (rU1.ch > 31) RX_buf[rU1.CntBuf++] = rU1.ch;
 if (rU1.ch == rU1.TermCh)  rU1.Stat.B2  = 1;
 }
 else { RX_buf[rU1.CntBuf++] = rU1.ch; }
 }
 else { RX_buf[rU1.CntBuf++] = rU1.ch; }
 }
 else {
  rU1.Stat.B0  = 1;
  rU1.Stat.B3  = 0;
 }
 }
 rU1.TimeCnt++;
 if (rU1.TimeCnt > rU1.TIMEOUT)  rU1.Stat.B1  = 1;
 Delay_us(2);
 }
 RX_buf[rU1.CntBuf] = 0x00;
 if ( rU1.Stat.B1 ) {
 if (rU1.UseASCII && rU1.UseTermCh && ( rU1.Stat.B2 !=1))
  rU1.Stat.B3  = 0;
 }
 if ( rU1.Stat.B0 ) {
 Delay_ms(10);
 while (RC1IF_bit) { if (FERR1_bit || OERR1_bit) { SPEN1_bit = TXEN1_bit = CREN1_bit = 0; SPEN1_bit = TXEN1_bit = CREN1_bit = 1; }  RX_buf[rU1.ch] = RC1REG; Delay_us(20); }
  rU1.Stat.B3  = 0;
 }

 return;
 }
}





void main() {
  unsigned int  i=0, RXdata=0, CJ125_Status=0;
  unsigned short  *pNum,ch=0, tst_mode=0, USE_UART1=0;
  unsigned int  test=0,tmp16=0,DAC_Set=0;
  short  tmpi8=0;

  TMR6IE_bit = 1; 
START:
 HW_Init();
  LED1_Tresh = 0;LED2_Tresh = 0;LED3_Tresh = 0; 

 UART_Welcome(1,EE_Consts);
 USE_UART1 =  (EE_Consts.OPTION && 0b10000000) ;
 if (USE_UART1) { UART_PrintTxt(1,"USE UART1 for listing"); CR_LF(1); }

 do {
 if ( rU1.Stat.B3 ) {
 i = 101;
 if (i==101) {
 DAC_Set =  3180 ;
 DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
 UART_PrintTxt(1,"Enetered to test mode, DAC1/2 outputs set to 14.7AFR => "); WordToStr( 3180 ,_txtU16); UART_PrintTxt(1,_txtU16); ; UART_PrintTxt(1,"mV"); CR_LF(1); CR_LF(1);
 i=102;
 }
 tst_mode=1;
  LED1_Tresh = 255;LED2_Tresh = 255;LED3_Tresh = 255; ;
  rU1.Stat.B3  = 0;
 if (! strncmp(RX_buf,"DAC=",4) ) {
 ADC_COEF_OFS_EEPROM = EEPROM_Read( 0x10 ); delay_ms(20);
 str_cut_left(RX_buf,4); DAC_Set=atoi(RX_buf); UART_PrintTxt(1," >DACx set to =");  WordToStr(DAC_Set,_txtU16); UART_PrintTxt(1,_txtU16); ;
 DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
 }
 else if (! strncmp(RX_buf,"VBAT=",5) ) {
 VBAT_COEF_OFS_EEPROM = EEPROM_Read( 0x11 ); delay_ms(20);
 Vbat_mV = Get_AD_mV( 4 ,VBAT_KOEF);
 UART_PrintTxt(1,">Vbat= ");  WordToStr(Vbat_mV,_txtU16); UART_PrintTxt(1,_txtU16); ; CR_LF(1);
 }
 else if (! strncmp(RX_buf,"VBAT_OFS=",9) ) {
 VBAT_COEF_OFS_EEPROM = EEPROM_Read( 0x11 ); delay_ms(20); UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_OLD=");  ShortToStr(VBAT_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(1,_txtI8); ; CR_LF(1);
 str_cut_left(RX_buf,9); tmpi8=atoi(RX_buf); EEPROM_Write( 0x11 ,tmpi8); Delay_ms(20); VBAT_COEF_OFS_EEPROM = EEPROM_Read( 0x11 );
 VBAT_KOEF = (AD_KOEF *  11 ) + VBAT_COEF_OFS_EEPROM;
 UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_NEW=");  ShortToStr(VBAT_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(1,_txtI8); ; UART_PrintTxt(1," VBAT_KOEF=");  WordToStr(VBAT_KOEF,_txtU16); UART_PrintTxt(1,_txtU16); ; CR_LF(1);
 Vbat_mV = Get_AD_mV( 4 ,VBAT_KOEF);
 UART_PrintTxt(1,"  Vbat= ");  WordToStr(Vbat_mV,_txtU16); UART_PrintTxt(1,_txtU16); ; CR_LF(1);
 }
 else if (! strncmp(RX_buf,"ADC_OFS=",8) ) {
 ADC_COEF_OFS_EEPROM = EEPROM_Read( 0x10 );
 UART_PrintTxt(1,"ADC_KOEF_OFFSET_OLD=");  ShortToStr(ADC_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(1,_txtI8); ;
 UART_PrintTxt(1," ADC_KOEF_OLD=");  WordToStr(AD_KOEF,_txtU16); UART_PrintTxt(1,_txtU16); ;
 CR_LF(1); Delay_ms (20);
 str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write( 0x10 ,tmpi8); Delay_ms(20); ADC_COEF_OFS_EEPROM = EEPROM_Read( 0x10 );
 AD_KOEF =  489  + ADC_COEF_OFS_EEPROM;
 UART_PrintTxt(1,"ADC_KOEF_OFFSET_NEW=");  ShortToStr(ADC_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(1,_txtI8); ;
 UART_PrintTxt(1," ADC_KOEF=");  WordToStr(AD_KOEF,_txtU16); UART_PrintTxt(1,_txtU16); ;
 CR_LF(1);
 VBAT_COEF_OFS_EEPROM = EEPROM_Read( 0x11 ); delay_ms(20);
 VBAT_KOEF = (AD_KOEF *  11 ) + VBAT_COEF_OFS_EEPROM;
 UART_PrintTxt(1,"  Vbat= ");  WordToStr(Vbat_mV,_txtU16); UART_PrintTxt(1,_txtU16); ;
 CR_LF(1);
 }
 else if (! strncmp(RX_buf,"DAC_OFS=",8) ) {
 DAC_COEF_OFS_EEPROM = EEPROM_Read( 0x12 );
 UART_PrintTxt(1,"DAC_KOEF_OFFSET_OLD=");  ShortToStr(DAC_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(1,_txtI8); ;
 UART_PrintTxt(1," DAC_KOEF_OLD=");  WordToStr(DAC_KOEF,_txtU16); UART_PrintTxt(1,_txtU16); ;
 CR_LF(1); Delay_ms (20);
 str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write( 0x12 ,tmpi8); Delay_ms(20); DAC_COEF_OFS_EEPROM = EEPROM_Read( 0x12 );
 DAC_KOEF =  489  - DAC_COEF_OFS_EEPROM ;
 UART_PrintTxt(1,"DAC_KOEF_OFFSET_NEW=");  ShortToStr(DAC_COEF_OFS_EEPROM,_txtI8); UART_PrintTxt(1,_txtI8); ;
 UART_PrintTxt(1," DAC_KOEF=");  WordToStr(DAC_KOEF,_txtU16); UART_PrintTxt(1,_txtU16); ;
 CR_LF(1);
 DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set);
 UART_PrintTxt(1," >DACx set to =");  WordToStr(DAC_Set,_txtU16); UART_PrintTxt(1,_txtU16); ;
 CR_LF(1);
 }





 else if (! strncmp(RX_buf,"EXIT",4) ) {
 UART_PrintTxt(1,"Exit cfg mode.."); CR_LF(1);
 tst_mode = 0;
 }

 }

 if (i > 100) i = 102;
 else { UART_PrintCh(1,'-'); i++; }
 delay_ms(20);
 } while ((i < 100) || (tst_mode == 1)) ;

 RC1IE_bit = 0;
  LED1_Tresh = 0;LED2_Tresh = 0;LED3_Tresh = 0; 




 CJ125_Test();
 CJ125_Ri_Cal( 1 );
  LED3_Tresh = 10; ;
 do {
 CJ125_Ans = CJ125_Sensor_Test();
 DACx_Err_Mode(50, 50, 50);
 delay_ms(500);
 } while (CJ125_Ans !=  0x28FF );
 DAC_ERR_CNT=0;
  LED1_Tresh = 10; ;

 DACx_Service(400,  0 );
 DACx_Err_Mode(450, 450, 50);
 CJ125_Vbat_check();
  LED1_Tresh = 255; ;  LED3_Tresh = 0; ;
 CJ125_PreHeat_LSU( 1 );
  LED1_Tresh = 0; ;

  TMR0IE_bit = 1; 
  LED2_Tresh = 100; 




 while(1){

 CJ125_Ans = CJ125_Write( 0x7800 );
 if (CJ125_Ans !=  0x28FF ) {
 UART_PrintTxt(1,"LSU sensor disconnected/failure, ");
 Heat_PWM = 0;

  TMR0IE_bit = 0; 
 UART_PrintTxt(1,"waiting for reconnecting...."); CR_LF(1);
 do {
 CJ125_Ans = CJ125_Write( 0x7800 );
 delay_ms(500); UART_PrintTxt(1,".");
  LED1_Tresh = 0;LED2_Tresh = 0;LED3_Tresh = 0; ;  LED3_Tresh = 10; ;
 DACx_Err_Mode(50, 50, 50);
 } while (CJ125_Ans ==  0x287F );
 UART_PrintTxt(1,"Sensor re-connected, going back to starting procedure...."); CR_LF(1);
 delay_ms(1000);
 goto START;
 }


 if (_PID_Calc >=  5 ) {
 _PID_Calc = 0;
 UR_mV = Get_AD_mV( 2 ,AD_KOEF);
 Heat_PWM = LSU_PID_Heater_Service(UR_mV,UR_mV_ref);
 }


 if (MeasTime_Cnt >=  5 ) {
 MeasTime_Cnt = MeasStart=0;
 for (i=0; i <=  5 ; i++) UA_avg = UA_avg + UA_results[i];
 UA_avg = UA_avg / ( 5 +1);
 AFR_act = LinFit(CJ125_Calc_Ip(UA_avg,8), cj49Tab, 17 );
 Vbat_mV = Get_AD_mV( 4 ,VBAT_KOEF);
#line 303 "C:/MCU/projects/CJ125_MS3_v1.0/main.c"
 DACx_Service(AFR_act,  0 );
 }
 else {
 UA_mV = Get_AD_mV( 1 ,AD_KOEF);
 UA_results[MeasTime_Cnt] = UA_mV;
 MeasStart=0;
 MeasTime_Cnt++;
 };


 if (DisplayRefreshCnt >=  5 ) {
 DisplayRefreshCnt = 0;
 if (USE_UART1) UART_Service();
 }
 }

}






 unsigned int  LSU_PID_Heater_Service( unsigned int  Ur_Act, unsigned int  Ur_Target) {
  unsigned int  PWM_Out=1;
 PWM_Out = ( unsigned short ) Heater_PID_Control( 1 , Ur_Act, Ur_Target);
 PWM4_Set_Duty(PWM_Out);
 return PWM_Out;
}



void DACx_Service( unsigned int  AFR_Val, unsigned short  UseGauge) {
  unsigned short  x=0;


 DAC1_Out = LinFit(AFR_Val,DAC_LINEAR, 2 );
 DACx_mV_Out_10bit(1, DAC1_Out);

 if (UseGauge) DAC2_Out = LinFit(AFR_Val, Innov_818_Tab, 9 );
 else DAC2_Out = LinFit(AFR_Val,DAC_LINEAR,  2 );
 DACx_mV_Out_10bit(2, DAC2_Out);
}


void UART_Service() {
 UART_PrintTxt(1," AFR=");  WordToStr(AFR_act,_txtU16); UART_PrintTxt(1,_txtU16); ;

 UART_PrintTxt(1," Vbat= ");  WordToStr(Vbat_mV,_txtU16); UART_PrintTxt(1,_txtU16); ;
 UART_PrintTxt(1," UA=");  WordToStr(UA_avg,_txtU16); UART_PrintTxt(1,_txtU16); ;
 UART_PrintTxt(1," UR=");  WordToStr(UR_mV,_txtU16); UART_PrintTxt(1,_txtU16); ;
 UART_PrintTxt(1," PWM=");  WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16); ;
 UART_PrintTxt(1," DAC1=");  WordToStr(DAC1_Out,_txtU16); UART_PrintTxt(1,_txtU16); ;
 UART_PrintTxt(1," DAC2=");  WordToStr(DAC2_Out,_txtU16); UART_PrintTxt(1,_txtU16); ;

 CR_LF(1);
}

void DACx_Err_Mode( unsigned int  start_DAC, unsigned int  max_DAC_add,  unsigned int  step) {
  unsigned int  DAC_out =0;

 if (DAC_ERR_CNT < max_DAC_add) DAC_ERR_CNT += step;
 else DAC_ERR_CNT = 0;

 DAC_out = start_DAC + DAC_ERR_CNT;
 DACx_mV_Out_10bit(1,DAC_out); DACx_mV_Out_10bit(2,DAC_out); CR_LF(1);

}
