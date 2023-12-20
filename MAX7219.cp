#line 1 "C:/MCU/CJ125_MS3_v1.0/trunk/MAX7219.c"
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
#line 5 "C:/MCU/CJ125_MS3_v1.0/trunk/MAX7219.c"
void MAX7219_Init(unsigned char nr_digits, unsigned char intensity)
{
 unsigned char i, j = 0;

 MAX7219_CS = 1;
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);


 MAX7219_CS = 0;
 SPI1_Write( 0x09 );
 for (i = 0; i <= nr_digits; i++) {
 j = j << 1;
 j++;
 }
 SPI1_Write(j);
 MAX7219_CS = 1;
 Delay_10ms();

 MAX7219_CS = 0;
 SPI1_Write( 0x0A );
 SPI1_Write(intensity);
 MAX7219_CS = 1;
 Delay_10ms();

 MAX7219_CS = 0;
 SPI1_Write( 0x0B );
 SPI1_Write(nr_digits);
 MAX7219_CS = 1;

 MAX7219_CS = 0;
 SPI1_Write( 0x0C );
 SPI1_Write( 0x01 );
 MAX7219_CS = 1;

 MAX7219_CS = 0;
 SPI1_Write( 0x00 );
 SPI1_Write(0xff);
 MAX7219_CS = 1;


 MAX7219_ShowDigit(0x0A,0);
 MAX7219_ShowDigit(0x0A,1);
 MAX7219_ShowDigit(0x0A,2);
 MAX7219_ShowDigit(0x0A,3);

}

void MAX7219_DisplayOnOff(unsigned char on_off)
{
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 MAX7219_CS = 0;
 SPI1_Write( 0x0C );
 SPI1_Write(on_off);
 MAX7219_CS = 1;
}

void MAX7219SetIntensity(unsigned char new_intensity)
{
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 if(new_intensity >= 0 && new_intensity <= 15)
 {
 MAX7219_CS=0;
 SPI1_Write( 0x0A );
 SPI1_Write(new_intensity);
 MAX7219_CS=1;
 }
}

void MAX7219_TestDisplay(unsigned char on_off)
{
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 MAX7219_CS = 0;
 SPI1_Write( 0x0F );
 SPI1_Write(on_off);
 MAX7219_CS = 1;
}

void MAX7219_ShowNumber(unsigned long Number, unsigned char firstDigit, unsigned char numberOfDigits) {
  int  i;
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 numberOfDigits = firstDigit + numberOfDigits;
 for(i = firstDigit; i <= numberOfDigits; Number/=10, i++)
 {
 MAX7219_CS=0;
 SPI1_Write((i + 1) << 8 + (Number %10));
 SPI1_Write(Number % 10);
 MAX7219_CS=1;
 Delay_1ms();
 }
}

void MAX7219_ShowNumAuto( unsigned int  num){
  short  i,digits=1,n=-1;
  unsigned int  temp;
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 MAX7219_CS = 0;
 SPI1_Write( 0x0B );
 SPI1_Write( 0x03 );
 MAX7219_CS = 1;
 if (num > 9) digits = 2;
 if (num > 99) digits = 3;
 if (num > 999) digits = 4;
 if (num < 10) digits = 1;
 temp = num;
 for(i = 1; i <= 4; temp = temp / 10, i++) {
 n = digits - i;
 MAX7219_CS=0;
 SPI1_Write(5-i);
 if(n>=0) SPI1_Write((temp % 10));
 else { SPI1_Write( 0x7F ); }
 MAX7219_CS=1;
 }
}

void MAX7219_ShowDigit(unsigned char number, unsigned char digit)
{
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 MAX7219_CS=0;
 SPI1_Write(digit + 1);
 SPI1_Write(number);
 MAX7219_CS=1;
}

void MAX7219_PrintAFR( unsigned int  temp,char DP, unsigned short  type)
{
  unsigned short  i;
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 MAX7219_CS = 0;
 SPI1_Write( 0x0B );
 SPI1_Write( 0x03 );
 MAX7219_CS = 1;
 for(i = 1; i <= 4; temp=temp/10, i++) {
 MAX7219_CS=0;
 SPI1_Write(5-i);
 if ((i == 3) && (DP > 0)) SPI1_Write((temp % 10) | 0x80);
 else if ((i==4) && (type==1)) SPI1_Write((temp % 10) | 0x80);
 else SPI1_Write(temp % 10);
 MAX7219_CS=1;

 }
}

void MAX7219_PrintMAP( unsigned int  num,char DP)
{
  unsigned short  i=0,tmp=0;

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 MAX7219_ShowDigit(0x0F|0x80,0);
 for(i = 1; i <= 3; num=num/10, i++) {
 MAX7219_CS=0;
 SPI1_Write(5-i);
 tmp = num % 10;
 if (i==3 && tmp==0) MAX7219_ShowDigit(0xF,1);
 else SPI1_Write(tmp);
 MAX7219_CS=1;
 }
}

void MAX7219_ShowLSUName( unsigned int  num)
{
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 if (num !=  10 ) {
 MAX7219_ShowDigit(0xD,0);
 MAX7219_ShowDigit(0x0A,1);
 MAX7219_ShowDigit(4|0x80,2);
 if (num== 0 ) MAX7219_ShowDigit(2,3);
 else if (num== 1 ) MAX7219_ShowDigit(9,3);
 }
 else {
 MAX7219_ShowDigit(0x0F,0);
 MAX7219_ShowDigit(0xB,1);
 MAX7219_ShowDigit(0xB,2);
 MAX7219_ShowDigit(0x0F,3);
 }
}
