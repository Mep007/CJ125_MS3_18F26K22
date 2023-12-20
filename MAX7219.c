#include "resource.h"

// sfr sbit MAX7219_CS at RC0_bit;  // zde v HW_Init.c

void MAX7219_Init(unsigned char nr_digits, unsigned char intensity)
{
  unsigned char i, j = 0;
  
  MAX7219_CS = 1;
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
//  SPI1_Init();   // v HW_init.c

  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_DECODE_MODE);
  for (i = 0; i <= nr_digits; i++)  {
    j = j << 1;
    j++;
  }
  SPI1_Write(j);
  MAX7219_CS = 1;
  Delay_10ms();
  
  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_INTENSITY);
  SPI1_Write(intensity);
  MAX7219_CS = 1;
  Delay_10ms();
  
  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_SCAN_LIMIT);
  SPI1_Write(nr_digits);
  MAX7219_CS = 1;
  
  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_SHUTDOWN);
  SPI1_Write(_MAX7219_SHUTDOWN_NORMAL_MODE);
  MAX7219_CS = 1;
  
  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_NO_OP);
  SPI1_Write(0xff);
  MAX7219_CS = 1;
  
//  MAX7219_ShowDigit(0x0F,0);  MAX7219_ShowDigit(0x0F,1);  MAX7219_ShowDigit(0x0F,2);  MAX7219_ShowDigit(0x0F,3); // zapise BLANK do vsech digitu
  MAX7219_ShowDigit(0x0A,0); // zapise pomlcku do vsech digitu (0xF - je blank)
  MAX7219_ShowDigit(0x0A,1);  
  MAX7219_ShowDigit(0x0A,2);  
  MAX7219_ShowDigit(0x0A,3); 

}
//////////////////////////////
void MAX7219_DisplayOnOff(unsigned char on_off)
{
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_SHUTDOWN);
  SPI1_Write(on_off);
  MAX7219_CS = 1;
}
//////////////////////////////
void MAX7219SetIntensity(unsigned char new_intensity)
{
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  if(new_intensity >= 0 && new_intensity <= 15)
  {
    MAX7219_CS=0;
    SPI1_Write(_MAX7219_REG_INTENSITY);
    SPI1_Write(new_intensity);
    MAX7219_CS=1;
  }
}
//////////////////////////////
void MAX7219_TestDisplay(unsigned char on_off)
{
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_DISPLAY_TEST);
  SPI1_Write(on_off);
  MAX7219_CS = 1;
}
//////////////////////////////
void MAX7219_ShowNumber(unsigned long Number, unsigned char firstDigit, unsigned char numberOfDigits) {
  i16 i;
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP

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
//////////////////////////////
void MAX7219_ShowNumAuto(u16 num){ // zobrazi max. 4 cislice (kdyz 0 na MSB, digit=off)
  i8 i,digits=1,n=-1;
  u16 temp;
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  MAX7219_CS = 0;
   SPI1_Write(_MAX7219_REG_SCAN_LIMIT);
   SPI1_Write(_MAX7219_SHOW_DIGITS_0_3);  // 1 znak
  MAX7219_CS = 1;
  if (num >   9)  digits = 2; //SPI1_Write(_MAX7219_SHOW_DIGITS_0_3); } // 2znaky
  if (num >  99)  digits = 3; //SPI1_Write(_MAX7219_SHOW_DIGITS_0_3); }  // 3znaky
  if (num > 999)  digits = 4; //SPI1_Write(_MAX7219_SHOW_DIGITS_0_3); }  // 4znaky
  if (num < 10)   digits = 1;
  temp = num;
  for(i = 1; i <= 4; temp = temp / 10, i++) { // i=1 -> 12345 % 10 = 5 i=2 -> 12345/10= 1234 % 10 = 4 atd.
    n = digits - i;    // kdyz je >= 0 => tiskneme znak, jinak znak OFF
    MAX7219_CS=0;      // 3-1=2 3-2=1, 3-3=0
    SPI1_Write(5-i); // pozice
    if(n>=0) SPI1_Write((temp % 10));  // je cislice k tisku... ?
    else   { SPI1_Write(MAX7219_BLANK); }  // ...neni, segment OFF (blank)
    MAX7219_CS=1;
  }
}
//////////////////////////////
void MAX7219_ShowDigit(unsigned char number, unsigned char digit)
{
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  MAX7219_CS=0;
  SPI1_Write(digit + 1);  // pozice
  SPI1_Write(number);     // cislo
  MAX7219_CS=1;
}
//////////////////////////////
void MAX7219_PrintAFR(u16 temp,char DP,u8 type)     // 1258 => 12.58
{
  u8 i;
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP

  MAX7219_CS = 0;
  SPI1_Write(_MAX7219_REG_SCAN_LIMIT);
  SPI1_Write(_MAX7219_SHOW_DIGITS_0_3);
  MAX7219_CS = 1;
  for(i = 1; i <= 4; temp=temp/10, i++) {
    MAX7219_CS=0;
    SPI1_Write(5-i); // pozice
    if ((i == 3) && (DP > 0))     SPI1_Write((temp % 10) | 0x80); // DP na pozici 2
    else if ((i==4) && (type==1)) SPI1_Write((temp % 10) | 0x80);
    else SPI1_Write(temp % 10);
    MAX7219_CS=1;
//    Delay_1ms();
   }
}
//////////////////////////////
void MAX7219_PrintMAP(u16 num,char DP)     // 1258 => 12.58
{                           //
  u8 i=0,tmp=0;
  
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  
  MAX7219_ShowDigit(0x0F|0x80,0);   // symbol tecky na prvni digit jako Pressure
  for(i = 1; i <= 3; num=num/10, i++) {
    MAX7219_CS=0;
    SPI1_Write(5-i); // pozice
    tmp = num % 10;
    if (i==3 && tmp==0) MAX7219_ShowDigit(0xF,1);   // kdyz je cislo mensi nez 100, pak druhy digit OFF
    else   SPI1_Write(tmp);
    MAX7219_CS=1;
   }
}
//////////////////////////////
void MAX7219_ShowLSUName(u16 num)     // zobrazi bud L 4.2 (1) nebo L 4.9 (0)
{
 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
  if (num != LSU_ERROR) {
    MAX7219_ShowDigit(0xD,0);   // symbol L na 0
    MAX7219_ShowDigit(0x0A,1);  // -
    MAX7219_ShowDigit(4|0x80,2);    // 4 s teckou
    if      (num==LSU42) MAX7219_ShowDigit(2,3);  //  2
    else if (num==LSU49) MAX7219_ShowDigit(9,3);  //  9
  }
  else {   // neni zadna sonda, eror
    MAX7219_ShowDigit(0x0F,0);   // blank 0
    MAX7219_ShowDigit(0xB,1);   // symbol E na 1
    MAX7219_ShowDigit(0xB,2);   // symbol E na 2
    MAX7219_ShowDigit(0x0F,3);   // blank  3
  }
}