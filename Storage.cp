#line 1 "C:/MCU/projects/CJ125_MS3_v1.0/Storage.c"
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
#line 1 "c:/mcu/projects/cj125_ms3_v1.0/ssd1306oled.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 95 "c:/mcu/projects/cj125_ms3_v1.0/ssd1306oled.h"
extern  _Bool  wrap;
extern  _Bool  SSD1306_Color;

extern void ssd1306_command(uint8_t c);
extern void SSD1306_Begin(uint8_t vccstate, uint8_t i2caddr);
extern void SSD1306_TextSize(uint8_t t_size);
extern void SSD1306_GotoXY(uint8_t x, uint8_t y);
extern void SSD1306_DrawPixel(uint8_t x, uint8_t y);
extern void SSD1306_StartScrollRight(uint8_t start, uint8_t stop);
extern void SSD1306_StartScrollLeft(uint8_t start, uint8_t stop);
extern void SSD1306_StartScrollDiagRight(uint8_t start, uint8_t stop);
extern void SSD1306_StartScrollDiagLeft(uint8_t start, uint8_t stop);
extern void SSD1306_StopScroll(void);
extern void SSD1306_Dim( _Bool  dim);
extern void SSD1306_Display(void);
extern void SSD1306_ClearDisplay(void);
extern void SSD1306_DrawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1);
extern void SSD1306_DrawFastHLine(uint8_t x, uint8_t y, uint8_t w);
extern void SSD1306_DrawFastVLine(uint8_t x, uint8_t y, uint8_t h);
extern void SSD1306_FillRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h);
extern void SSD1306_FillScreen();
extern void SSD1306_DrawCircle(int16_t x0, int16_t y0, int16_t r);
extern void SSD1306_DrawCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername);
extern void SSD1306_FillCircle(int16_t x0, int16_t y0, int16_t r);
extern void SSD1306_FillCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername, int16_t delta);
extern void SSD1306_DrawRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h);
extern void SSD1306_DrawRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r);
extern void SSD1306_FillRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r);
extern void SSD1306_DrawTriangle(uint8_t x0, uint8_t y0, uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2);
extern void SSD1306_FillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2);
extern void SSD1306_PutC(uint8_t c);
extern void SSD1306_Print(char *s);
extern void SSD1306_PutCustomC(const uint8_t *c);
extern void SSD1306_DrawBMP(uint8_t x, uint8_t y, const uint8_t *bitmap, uint8_t w, uint8_t h);
extern void SSD1306_SetTextWrap( _Bool  w);
extern void SSD1306_InvertDisplay( _Bool  i);
#line 4 "C:/MCU/projects/CJ125_MS3_v1.0/Storage.c"
void FLASH_64Words( unsigned int  Flash_Adr,  unsigned int  Buf[]) {
  unsigned int  *p32Buf = &Buf[32];


 FLASH_Erase_Write_64(Flash_Adr, Buf);
 FLASH_Erase_Write_64(Flash_Adr+64,p32Buf);
}


void EEPROM_Write_Constant( unsigned int  Adr,EEprom Cal_Data) {
  unsigned short  i=0;
#line 34 "C:/MCU/projects/CJ125_MS3_v1.0/Storage.c"
}

EEprom EEPROM_Read_Constant( unsigned int  Adr) {
  unsigned short  i=0;
 EEprom Cal_Data;


 Cal_Data.SN = EEPROM_Read( 0x00 );
 Cal_Data.SN = Cal_Data.SN << 8;
 Cal_Data.SN = Cal_Data.SN + EEPROM_Read( 0x00 +0x01);

 Cal_Data.HW_ver = EEPROM_Read( 0x02 );

 Cal_Data.SW_ver = EEPROM_Read( 0x03 );

 Cal_Data.OPTION = EEPROM_Read( 0x04 );


 return Cal_Data;
}
