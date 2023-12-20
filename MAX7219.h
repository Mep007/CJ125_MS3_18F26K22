// extern sfr sbit MAX7219_CS;  // ted v HW_Init.h

extern void MAX7219_Init(unsigned char nr_digits, unsigned char intensity);
extern void MAX7219_DisplayOnOff(unsigned char on_off);
extern void MAX7219SetIntensity(unsigned char new_intensity);
extern void MAX7219_TestDisplay(unsigned char on_off);
extern void MAX7219_ShowNumber(unsigned long Number, unsigned char firstDigit, unsigned char numberOfDigits);
extern void MAX7219_ShowDigit(unsigned char number, unsigned char digit);
extern void MAX7219_PrintAFR(u16 temp,char DP,u8 type);
extern void MAX7219_PrintMAP(u16 temp,char DP);     // 1258 => 12.58
extern void MAX7219_ShowLSUName(u16 num);
extern void MAX7219_ShowNumAuto(u16 num);

#ifndef __MAX7219__
  #define __MAX7219__                           0
  #define _MAX7219_REG_NO_OP                 0x00
  #define _MAX7219_REG_DIGIT_0               0x01
  #define _MAX7219_REG_DIGIT_1               0x02
  #define _MAX7219_REG_DIGIT_2               0x03
  #define _MAX7219_REG_DIGIT_3               0x04
  #define _MAX7219_REG_DIGIT_4               0x05
  #define _MAX7219_REG_DIGIT_5               0x06
  #define _MAX7219_REG_DIGIT_6               0x07
  #define _MAX7219_REG_DIGIT_7               0x08
  #define _MAX7219_REG_DECODE_MODE           0x09
  #define _MAX7219_REG_INTENSITY             0x0A
  #define _MAX7219_REG_SCAN_LIMIT            0x0B
  #define _MAX7219_REG_SHUTDOWN              0x0C
  #define _MAX7219_REG_DISPLAY_TEST          0x0F
  
  #define _MAX7219_DECODE_DIGITs_0           0x01
  #define _MAX7219_DECODE_DIGITs_1           0x02
  #define _MAX7219_DECODE_DIGITs_2           0x04
  #define _MAX7219_DECODE_DIGITs_3           0x08
  #define _MAX7219_DECODE_DIGITs_4           0x10
  #define _MAX7219_DECODE_DIGITs_5           0x20
  #define _MAX7219_DECODE_DIGITs_6           0x40
  #define _MAX7219_DECODE_DIGITs_7           0x80
  
  #define _MAX7219_INTENSITY_0               0x00
  #define _MAX7219_INTENSITY_1               0x01
  #define _MAX7219_INTENSITY_2               0x02
  #define _MAX7219_INTENSITY_3               0x03
  #define _MAX7219_INTENSITY_4               0x04
  #define _MAX7219_INTENSITY_5               0x05
  #define _MAX7219_INTENSITY_6               0x06
  #define _MAX7219_INTENSITY_7               0x07
  #define _MAX7219_INTENSITY_8               0x08
  #define _MAX7219_INTENSITY_9               0x09
  #define _MAX7219_INTENSITY_10              0x0A
  #define _MAX7219_INTENSITY_11              0x0B
  #define _MAX7219_INTENSITY_12              0x0C
  #define _MAX7219_INTENSITY_13              0x0D
  #define _MAX7219_INTENSITY_14              0x0E
  #define _MAX7219_INTENSITY_15              0x0F
  
  #define _MAX7219_SHOW_DIGITS_0             0x00
  #define _MAX7219_SHOW_DIGITS_0_1           0x01
  #define _MAX7219_SHOW_DIGITS_0_2           0x02
  #define _MAX7219_SHOW_DIGITS_0_3           0x03
  #define _MAX7219_SHOW_DIGITS_0_4           0x04
  #define _MAX7219_SHOW_DIGITS_0_5           0x05
  #define _MAX7219_SHOW_DIGITS_0_6           0x06
  #define _MAX7219_SHOW_DIGITS_0_7           0x07
  
  #define _MAX7219_SHUTDOWN_SHUTDOWN_MODE    0x00
  #define _MAX7219_SHUTDOWN_NORMAL_MODE      0x01
  
  #define _MAX7219_DISPLAY_TEST_ON           0x01
  #define _MAX7219_DISPLAY_TEST_OFF          0x00
  #define MAX7219_BLANK                      0x7F    // vypne vsechny segmenty v ramci digitu
  
  
#endif



//#include "MAX7219.c"