#define u8                   unsigned short
#define i8                   short
#define i16                  int
#define u16                  unsigned int
#define u32                  unsigned long
#define i32                  long
//#define uint8_t              unsigned short
//#define int16_t              int
//#define PID_DEBUG                            // na UART PID parametry
// kalibracni konstanty pro AD - Aref = 5.0V (LM2940T - 5, +/- 2%)  - Vcc=4980mV = > 4980*100/1023 = 486.8 => AD_KOEF=487
#define _AD_CONST            489      // def. AN0 :hodnota kalibrace jendotliveho AD kanalu (pro ziskani mV) => 1023*495 = 496155/100=4962mV   i pro generovani DAC/PWM (napr. 2800mV*100/490= 571 (raw)
#define _DAC_CONST           489      // def.
#define _VBAT_DIV             11      // Divider 10k/1k
#define _VBAT_KOEF          (_AD_CONST * _VBAT_DIV)     //5390 def. AN4 (RA5) - pres delic 1:11 - (nspr. 489 * 11 = 5379) = Vbat

#define  LSU_TYPE           LSU49              ///!!! SELECT CORRECT LSU TYPE !!!!!!!!
//#define  MAP_SENSOR       MPXH6300A    // USER: select correct MAP sensor

#define  LSU42             0
#define  LSU49             1
#define  LSU_ERROR        10

#define  DAC1_INIT_VOLT   300     // [mV] napeti na DACx vystupech po startu / nez dojde k initu sondy
#define  DAC2_INIT_VOLT   300     // [mV] dtto (AFR 7.5 pri 900/9.00AFR a 4900/19.00AFR)
//#define  DAC_ERR_VOLT     900     // [mV] DAC out pri chybe - AFR 9.0 pri 900/9.00AFR a 4900/19.00AFR)
#define  DAC_14p7_VOLT    3180    // [mV] DAC napeti pro 14.7AFR

#define  VBAT_LOW         10500   // [mV] - min napeti pro rozebeh WBO programu
#define  VBAT_RE_RUN      12900   // [mV] - napeti baterie, pri kterem preskakujeme detekci zacatku dobijeni (DELTA_VBAT) po zapnuti
#define  VBAT_MAX         15500   // [mV] max. napeti, pri jehoz prekroceni WBO vypiname
#define  DELTA_VBAT         600   // [mV] - hodnota, o kterou se musi zvysit napeti, abychom pokraovlay v inicianci WBO


#define   MeasVbat                     Vbat_mV = Get_AD_mV(Vbat_AD_ch,AD_VBAT_KOEF );   // merime Vbat - napeti baterie
#define   UART_PrintU8(nr,val)         ByteToStr(val,_txtU8); \
                                       UART_PrintTxt(nr,_txtU8);
#define   UART_PrintI8(nr,val)         ShortToStr(val,_txtI8); \
                                       UART_PrintTxt(nr,_txtI8);
#define   UART_PrintU16(nr,val)        WordToStr(val,_txtU16); \
                                       UART_PrintTxt(nr,_txtU16);
#define   UART_PrintI16(nr,val)        IntToStr(val,_txtI16); \
                                       UART_PrintTxt(nr,_txtI16);
#define   UART_PrintU16_HEX(nr,val)    WordToHex(val,_txtU16); \
                                       UART_PrintTxt(nr,"0x");\
                                       UART_PrintTxt(nr,_txtU16);

#define  _USE_UART1_TERM_CHAR      0
                                       
#define  ALL_LEDs_OFF                  LED1_Tresh = 0;LED2_Tresh = 0;LED3_Tresh = 0;
#define  ALL_LEDs_ON                   LED1_Tresh = 255;LED2_Tresh = 255;LED3_Tresh = 255;
#define  LED_BLUE_OFF                  LED1_Tresh = 0;
#define  LED_GREEN_OFF                 LED2_Tresh = 0;
#define  LED_RED_OFF                   LED3_Tresh = 0;
#define  LED_BLUE_ON                   LED1_Tresh = 255;
#define  LED_GREEN_ON                  LED2_Tresh = 255;
#define  LED_RED_ON                    LED3_Tresh = 255;
#define  LED_BLUE_100ms                LED1_Tresh = 10;
#define  LED_GREEN_100ms               LED2_Tresh = 10;
#define  LED_RED_100ms                 LED3_Tresh = 10;
#define  LED_BLUE_1s                   LED1_Tresh = 100;
#define  LED_GREEN_1s                  LED2_Tresh = 100;
#define  LED_RED_1s                    LED3_Tresh = 100;



//#define   BT_PrintU8(val)              ByteToStr(val,_txtU8); \
//                                       UART_PrintTxt(2,_txtU8);

//#define    __CMD_A(val)         strstr(val,"A")
// Prikazy prijate na UARTU2 - BT z mobilu napr
#define    __CMD_A(val)         strstr(val,"A")
#define    __PING(val)          strstr(val,"PING")
#define    __INFO(val)          strstr(val,"INFO")
#define    __CMD_CLSU(val)      strstr(val,"CLST")
#define    __LSU42(val)         strstr(val,"L42")
#define    __LSU49(val)         strstr(val,"L49")
#define    __END_CFG(val)       strstr(val,"ENDCFG")
#define    __SET_INTENSITY(val) strstr(val,"SETINT=")

#define    __SET_DACtoXXXXX(val)   strncmp(val,"DAC=",4)
#define    __GET_VBAT(val)         strncmp(val,"VBAT=",5)
#define    __SET_DAC_OFFSET(val)   strncmp(val,"DAC_OFS=",8)  // DAC_OFFSET=-5 napr
#define    __SET_ADC_OFFSET(val)   strncmp(val,"ADC_OFS=",8)  // ADC_OFFSET=-5 napr
#define    __SET_VBAT_OFFSET(val)  strncmp(val,"VBAT_OFS=",9)  // VBAT_OFFSET=10 napr
#define    __EXIT_CFG(val)         strncmp(val,"EXIT",4)
#define    __GET_UR(val)         strncmp(val,"UR=",3)




// velikosti tabulek pro vypocty AFR, generovani DAC apod (1D tabulky jako 2D, tzn. velikost table je vzdy 2x xxx_TAB_SIZE


#define CJ42_TAB_SIZE       8       // pocet prvku na radku X(pak je tam jeste druhy radek pro Y)..
#define CJ49_TAB_SIZE      17       // pocet prvku na radku X(pak je tam jeste druhy radek pro Y)..
#define DAC_NB_EMUL_SIZE    3       // NB emulace
#define DAC_LINEAR_SIZE     2       // was 3 -
#define INOV818_TAB_SIZE    9

#define RX_BUF_LEN           32+1   // RX buffer pro UART1 - uzivatelska data-1, posledni prvek je 0x00 vzdy !!
#define RX_BUF2_LEN          32+1
#define RX2_USE_TERM_CHAR       0    // kdyz >0 nemazeme buffer po timeoutu (kdyz nepretece i buffer)
#define RX_TIMEOUT        400*100   // v [us] - max doba po kterou ceka prikaz s ukoncovacim znakem 400* = 40ms
#define RX_FLASH_BUF_LEN       64   // velikost v u16 ve FLASH i pak RAM bufferu pro data posilana z PC a ukladana do FLASH (a RAM pro praci)
#define START_PID_TMR    TMR0IE_bit = 1;   // spusti timer pro PID heater
#define STOP_PID_TMR     TMR0IE_bit = 0;   // zastavi timer pro PID heater
#define START_TMR6       TMR6IE_bit = 1;
#define STOP_TMR6        TMR6IE_bit = 0;

#define BUT0_MAX_CLICKS       4   // max. pocet stavu tlacitka (= polozek menu pro vyber)
#define BUT0_MAX_CLICKS_CFG  14   // max. pocet stavu tlacitka - pro nstaveni intenzity displeje jen v config modu

#define __100ms              10   // hodnoty pro TMR6@10ms
#define __250ms              25
#define __500ms              50
#define __1000ms            100
#define __1500ms            150
#define __2000ms            200

// vlastni struktury atd.

// includy vsech .h
#include "typedefs.h"
#include "hw_init.h"
#include "variables.h"  // !!! zde jsou jen DEKLARACE gob. promennych, definice, jsou v .c !!!!!
#include "support.h"     // pomocne fc, jako Printf apod.
#include "AD.h"
#include "Bosch_CJ125.h"
#include "storage.h"
#include "SSD1306OLED.h"
//#include "OLED_SSD1306.h"