        /* PIC 18F26K22
  ==============
  - 16Mhz INT
  - UART1 : 115k2 (FT232RL), na prijem pouziva IRQ a ceka na <LF> - data jsou v RX_BUF[..], priznak prijeti dat => RX_Flag = 1
  - SPI1 - Fosc/16 (16Mhz/16 = 1Mhz, /64 u CJ125) - Pozor: MAX7219 pouziva jinouplatnou hranu nez CJ125
  - Timer 0 - pro PID regulator a vykreslovani na displej - IRQ po 50ms  -!!! DULEZITE !!!
  - Timer 2 - pro CCP4 - PWM pro heater  (od mikroC pouzivanim CCP knihovny)
  - Timer 4 - pro CCP3 a CCP5 - pro analog. DAC1 a DAC2
  - N.U. Timer 6 - 10ms timer pro tlacitko na RA2
  - spotreba z 5V cca 50mA max pri behu
  -
  - Po startu programu zmeri Ua a Ur - Ur musi byt mezich 900-1200mV (bezne 1040mV), Ua je 1500mV (vystup z CJ125) - kdyz se lehce lisi, dokalibrovat v CFG modu (Rx+Tx= ON pri startu)
  - http://www.devtechnics.com/winlog.htm - soft na logovani
*/
#include "resource.h"

#define  DAC2_USE_GAUGE           1             // 1 - pouzije na DAC2 vystup 1V - 0V pro AFR 8 - 18 - Innovate analog gauge ( 0 - no gauge a linear out 0-5V)
#define  DAC2_NO_GAUGE            0             // 0 - pouzije linear out na DAC2 dtto jako pro DAC1

//#define DEBUG       //d po HW init je while(1) na testy novych fci apod.
// #define PID_DEBUG   // vypisuje na uart slozky PID a PWM

//===================================================================================
//===================================================================================

     #define PID_REFRESH      2      // perioda x * 50ms => 2 * 50 = 100ms
     #define MEAS_REFRESH     1      // - perioda mereni vsech AD a generovani DAC -(max 10) perioda x * 50ms => 2 * 50 = 100ms
     #define LED_REFRESH      4      // perioda x * 50ms => 4x50 = 200ms = > 5Hz refresh rate for 7seg LCD
     #define DISP_REFRESH     1      // 4x50 = 200ms => 5Hz refresh pro LCD7 seg a UART vypis
     #define BUT_TIME_TRESH   5      // perioda timeru pro obsluhu tlacitka po 10ms (5x10=50ms)
//#endif
#ifdef DEBUG
     #define PID_REFRESH        8      // perioda x * 50ms => 2 * 50 = 100ms
     #define TEST_MIN        1000
     #define TEST_MAX        1900
     #define TEST_STEP          5
#endif
                ///!!! SELECT CORRECT LSU TYPE !!!!!!!!
// ==========================================================================================
// ==========================================================================================
void UART_Service();
void DACx_Service(u16 AFR_Val,u8 UseGauge);
void DACx_Err_Mode(u16 start_DAC,u16 max_DAC_add, u16 step);
u16 LSU_PID_Heater_Service(u16 Ur_Act,u16 Ur_Target);
void OLED_Show_AFR(u16 Afr, u16 Vbat);
//void void Button_Service(u8 MaxPress);
// Main.c Variables

//sbit RX_FLAG at RX_Status.B0;
//sbit RX2_Flag at RX_Status.B1;


// ==========================================================================================
// ==========================================================================================


void interrupt() {
  char tmp=0,i=0;
  u16 RX_cnt=0;

  if (TMR6IF_bit && TMR6IE_bit){      // 10ms timer pro tlacitka - trva cca 64instrukci + LED
  // LED 1 sekce
    if      (LED1_Tresh == 255)        LED1 = 1;  // trvaly svit
    else if (LED1_Tresh == 0)          LED1 = 0;  // trvale OFF
    else if (LED1_Cnt >= LED1_Tresh) { LED1 ^= 1; LED1_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
  // LED 2 sekce
    if      (LED2_Tresh == 255)        LED2 = 1;  // trvaly svit
    else if (LED2_Tresh == 0)          LED2 = 0;  // trvale OFF
    else if (LED2_Cnt >= LED2_Tresh) { LED2 ^= 1; LED2_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
  // LED 3 sekce
    if      (LED3_Tresh == 255)        LED3 = 1;  // trvaly svit
    else if (LED3_Tresh == 0)          LED3 = 0;  // trvale OFF
    else if (LED3_Cnt >= LED3_Tresh) { LED3 ^= 1; LED3_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu

    LED1_Cnt++; LED2_Cnt++; LED3_Cnt++;
    TMR6IF_bit = 0;
    return;
  } // TMR6IF

 //==================================================================
  if (TMR0IF_bit && TMR0IE_bit){ // pro PID po 50/100ms viz HW_ini.c
    _PID_Calc++;
    DisplayRefreshCnt++;    // pro zobrazovani na 7seg LCD
    MeasStart=1;            // priznak, ze muzeme merit
    TMR0H = 0x3C; TMR0L = 0xB0; // 15536 pro pozadovany cas
    TMR0IF_bit = 0;
//    if (LED3) LED3=0; else LED3=1;    // jen pro debug
    return;
  }
 //==================================================================

  //==================================================================
  if (RC1IF_bit && RC1IE_bit){ // UART1 IRQ  - ceka na prikaz ukonceny d10
//    LED2 = 1;
   //    for (u8TMP=0; u8TMP < RX_buf_LEN; u8TMP++) RX_buf[u8TMP] = 0; // cistei bufferu
    LED_RED_100ms
    BUF1_TIMEOUT = BUF1_OVERR = BUF1_TEMINATED = 0;   // flag na preteceni bufferu 2
    UART1_NEW_DATA = 1;   // bit - indikace novych dat - nastavime zde, v pripade chyb se nize nuluje
    rU1.ch = rU1.CntBuf = rU1.TimeCnt= 0;
    while(!BUF1_OVERR && !BUF1_TIMEOUT && !BUF1_TEMINATED) {  //max (RX_BUF_LEN-1) znaku a timeout 100ms + ukoncuje znak d10
      if(RC1IF_bit) { // neco je ve FIFO ?, max 6 znaku celkem muze prijit + ukoncovaci - RCIF JE JEN PRO CTENI !! KDYZ 1 je neco ve FIFO
        UART1_FIX_ERR   // osetreni pripadnych chyb na UARTU
        rU1.ch = RC1REG;  // cteme prijaty znak z RCREG
        if (rU1.CntBuf < (rU1.BufLen-1)) { // je jeste volny buffer ?
          if (rU1.UseASCII) { // ASCII mod ?
            if (rU1.UseTermCh) { // pouzivame termchar ?
              if (rU1.ch > 31) RX_buf[rU1.CntBuf++] = rU1.ch; // rU1.pRxBuf  ch ulozime do bufferu jen kdyz je tisknutelny znak
              if (rU1.ch == rU1.TermCh) BUF1_TEMINATED = 1;    // prisel ukoncovaci znak, nastavime priznak
            } // if rU1.UseTermChar
            else {            RX_buf[rU1.CntBuf++] = rU1.ch; }  // ASCII mod bez termcharu
          }  // if rU1.UseASCII
          else {  RX_buf[rU1.CntBuf++] = rU1.ch; } // RX_buf[rU1.CntBuf++] = rU1.ch; } // rU1.pRxBuf[rU1.CntBuf++] = rU1.ch; } // binary mod - ukladame veskere znaky 0-255
        }  // if (rU1.CntBuf < (RX_buf_LEN-1)) { // je plny buffer ?
        else {
          BUF1_OVERR = 1;   // ... buffer pretekl, tudiz zadne nova data a koncime
          UART1_NEW_DATA = 0;  //..timpadem nemame validni data
        } // else // if (rU1.CntBuf < (rU1.BufLen-1)) { // je jeste volny buffer ?
      }// if (RC1IF)
      rU1.TimeCnt++;   // inkrementujeme timer
      if (rU1.TimeCnt > rU1.TIMEOUT) BUF1_TIMEOUT = 1; // uplynul timout na vycteni ?
      Delay_us(2); //5
    } // while
    RX_buf[rU1.CntBuf] = 0x00;  // pridame 0x00 za posledni prijaty znak/cislo
    if (BUF1_TIMEOUT) {  // osetreni timeoutu
      if (rU1.UseASCII && rU1.UseTermCh && (BUF1_TEMINATED!=1))
        UART1_NEW_DATA = 0;  // pouzivame Term char ale ten neprisel -> zadna validni data
    }
    if (BUF1_OVERR) { // pretekl buufer - vse dovycteme a pak konec
      Delay_ms(10);
      while (RC1IF_bit) {UART1_FIX_ERR RX_buf[rU1.ch] = RC1REG; Delay_us(20); }   // jen vycitame data, dokud jsou,
      UART1_NEW_DATA = 0;
    } // if BUF1_Overr
//    LED2 = 0;
    return;
  } // if RCIF
} // interrupt

// =============== =============== =============== =============== =============== ===============
//                       +++++++++++++    M   A   I   N +++++++++++++++
// =============== =============== =============== =============== =============== ===============

void main() {
  u16 i=0, RXdata=0, CJ125_Status=0;
  u8 *pNum,ch=0, tst_mode=0, USE_UART1=0;
  u16 test=0,tmp16=0,DAC_Set=0;
  i8  tmpi8=0;
  
  START_TMR6      // dtto pro Timer 6 (IRQ po 10ms)
START:
  HW_Init();      // all include UART's....
  I2C2_Init(400000);

  ALL_LEDs_OFF
    // ====== 1. vycteme EEPROM konstanty na UART, prip displej apod. ================================
  UART_Welcome(1,EE_Consts);
  USE_UART1 = _UART1_LISTING(EE_Consts.OPTION);
  UART_PrintTxt(1,"OLED test"); CR_LF(1);

  SSD1306_Begin(SSD1306_SWITCHCAPVCC, 0x78); // SSD1306_I2C_ADDRESS);
  SSD1306_ClearDisplay();   // clear the buffer
  SSD1306_Display();
/*
     AFR_act = 1000;
   while(1)
   {
     OLED_Show_AFR(AFR_act, AFR_act);
  // SSD1306_InvertDisplay(1);
  //   Delay_ms(1000);
  // SSD1306_InvertDisplay(0);
   Delay_ms(50);
   AFR_act++;
   if (AFR_act > 1999) AFR_act=1000;
   }
  */

  if (USE_UART1) { UART_PrintTxt(1,"USE UART1 for listing"); CR_LF(1); }
  // vstup do RS232 debug modu
  do {
    if (UART1_NEW_DATA) {  // nejky prikaz na UART 1 ?   max 2s po zapnuti
      i = 101;      //zustaneme zde navzdy
      if (i==101) {  // jen jednou vykoname po vstupu do tst
        DAC_Set = DAC_14p7_VOLT;
        DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
        UART_PrintTxt(1,"Enetered to test mode, DAC1/2 outputs set to 14.7AFR => ");UART_PrintU16(1,DAC_14p7_VOLT); UART_PrintTxt(1,"mV"); CR_LF(1); CR_LF(1);
        i=102;
      }
      tst_mode=1;
      ALL_LEDs_ON;
      UART1_NEW_DATA = 0;
      if (!__SET_DACtoXXXXX(RX_buf)) {  // nastavi oba DACi na dane mV (syntaxe DAC=1500 - bez ukoncovaciho znaku)
        ADC_COEF_OFS_EEPROM =  EEPROM_Read(ADC_OFFSET_ADR); delay_ms(20);
        str_cut_left(RX_buf,4); DAC_Set=atoi(RX_buf); UART_PrintTxt(1," >DACx set to ="); UART_PrintU16(1,DAC_Set);   // odestrani DAC= a zbyde jen cislo ve stringu,na prevod
        DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
      } // if __SET_DAC
      else if (!__GET_VBAT(RX_buf)) {
        VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
        Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);
        UART_PrintTxt(1,">Vbat= "); UART_PrintU16(1,Vbat_mV); CR_LF(1);
      }
      else if (!__SET_VBAT_OFFSET(RX_buf)) {
        VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20); UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_OLD="); UART_PrintI8(1,VBAT_COEF_OFS_EEPROM);  CR_LF(1);
        str_cut_left(RX_buf,9); tmpi8=atoi(RX_buf); EEPROM_Write(VBAT_OFFSET_ADR,tmpi8); Delay_ms(20); VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR);
        VBAT_KOEF = (AD_KOEF * _VBAT_DIV) + VBAT_COEF_OFS_EEPROM;
        UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_NEW="); UART_PrintI8(1,VBAT_COEF_OFS_EEPROM); UART_PrintTxt(1," VBAT_KOEF="); UART_PrintU16(1,VBAT_KOEF); CR_LF(1);
        Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);
        UART_PrintTxt(1,"  Vbat= "); UART_PrintU16(1,Vbat_mV); CR_LF(1);
      }
      else if (!__SET_ADC_OFFSET(RX_buf)) {  // vyctze ADC_OFFSET konstantu z EEPROM, zapise novou a pro kontrolu vypise z EEPROM na UART (rozsah +/- 127)
        ADC_COEF_OFS_EEPROM = EEPROM_Read(ADC_OFFSET_ADR);
        UART_PrintTxt(1,"ADC_KOEF_OFFSET_OLD="); UART_PrintI8(1,ADC_COEF_OFS_EEPROM); // pred EEPROM zapisem dalsim
        UART_PrintTxt(1," ADC_KOEF_OLD="); UART_PrintU16(1,AD_KOEF); // pred EEPROM zapisem dalsim
        CR_LF(1); Delay_ms (20); // kvuli EEPROM
        str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write(ADC_OFFSET_ADR,tmpi8); Delay_ms(20); ADC_COEF_OFS_EEPROM = EEPROM_Read(ADC_OFFSET_ADR);
        AD_KOEF = _AD_CONST + ADC_COEF_OFS_EEPROM;
        UART_PrintTxt(1,"ADC_KOEF_OFFSET_NEW="); UART_PrintI8(1,ADC_COEF_OFS_EEPROM);
        UART_PrintTxt(1," ADC_KOEF="); UART_PrintU16(1,AD_KOEF); // pred EEPROM zapisem dalsim
         CR_LF(1);
        VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
        VBAT_KOEF = (AD_KOEF * _VBAT_DIV) + VBAT_COEF_OFS_EEPROM;
        UART_PrintTxt(1,"  Vbat= "); UART_PrintU16(1,Vbat_mV);
        CR_LF(1);
      }
      else if (!__SET_DAC_OFFSET(RX_buf)) {  // vyctze DAC_OFFSET konstantu z EEPROM, zapise novou a pro kontrolu vypise z EEPROM na UART (rozsah +/- 127)
        DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR); 
        UART_PrintTxt(1,"DAC_KOEF_OFFSET_OLD="); UART_PrintI8(1,DAC_COEF_OFS_EEPROM); // pred EEPROM zapisem dalsim
        UART_PrintTxt(1," DAC_KOEF_OLD="); UART_PrintU16(1,DAC_KOEF); // pred EEPROM zapisem dalsim
        CR_LF(1); Delay_ms (20); // kvuli EEPROM
        str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write(DAC_OFFSET_ADR,tmpi8); Delay_ms(20); DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
        DAC_KOEF = _DAC_CONST - DAC_COEF_OFS_EEPROM ;
        UART_PrintTxt(1,"DAC_KOEF_OFFSET_NEW="); UART_PrintI8(1,DAC_COEF_OFS_EEPROM);
        UART_PrintTxt(1," DAC_KOEF="); UART_PrintU16(1,DAC_KOEF); // pred EEPROM zapisem dalsim
        CR_LF(1);
        DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set);   // znovu nastavime DACy
        UART_PrintTxt(1," >DACx set to ="); UART_PrintU16(1,DAC_Set);
        CR_LF(1);
      }
//      else if {
      
      
      
  //    }
      else if (!__EXIT_CFG(RX_buf)) {
      UART_PrintTxt(1,"Exit cfg mode.."); CR_LF(1);
       tst_mode = 0;
      }

    }  // if (RX_FLAG) ========   ======

    if (i > 100) i = 102;
    else { UART_PrintCh(1,'-'); i++; }
    delay_ms(20);
   } while ((i < 100) || (tst_mode == 1)) ;

   RC1IE_bit = 0;         // Uart 1 Rx OFF
   ALL_LEDs_OFF

  // CJ125 - S T A R T    P R O C E D U R E
  // =========================================
#ifndef DEBUG
   CJ125_Test();    // test obvodu CJ125
   CJ125_Ri_Cal(LSU49);  // kalibrace Ur - zalezi jen na osazeni Ri odporu, ne na pripojene sonde
     LED_RED_100ms;
   do {      // test, zda je pripojena sonda - muze zde zustat navzdy
     CJ125_Ans = CJ125_Sensor_Test();
     DACx_Err_Mode(50, 50, 50); // plynule zvetsujeme DAC1/2 out po dobu chyby - cca 6.75-7.1AFR
     delay_ms(500);
   } while (CJ125_Ans != CJ125_DIAG_REG_STATUS_OK);
   DAC_ERR_CNT=0;
     LED_BLUE_100ms;

   DACx_Service(400, DAC2_NO_GAUGE); // sensor je ok, zaciname heating -> oba DACy na AFR 8.00
   DACx_Err_Mode(450, 450, 50); // plynule zvetsujeme DAC1/2 out po dobu chyby - cca 6.75-7.1AFR
   CJ125_Vbat_check();     // cekame na spravnou hodnotu Vbat, pripadne Vbat + DELTA_VBAT => doslo k nastartovani
    LED_BLUE_ON; LED_RED_OFF;
   CJ125_PreHeat_LSU(LSU49);
     LED_BLUE_OFF;
// Start timeru pro PID a obsluhA lED (Timer6)
  START_PID_TMR   // spusti timer pro PID regulaci - tam bezi
     LED_GREEN_1s

// =-=-=-=-=-=-=-=-M=-A=-I=-N=-=-=L-=O-=O=-P-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //
// =-=-=-=-=-=-=-=-M=-A=-I=-N=-=-=L-=O-=O=-P-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- //

  while(1){
     // detekce odpojeni sondy behem provozu
    CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);
    if (CJ125_Ans !=  CJ125_DIAG_REG_STATUS_OK) {
      UART_PrintTxt(1,"LSU sensor disconnected/failure, ");  //CR_LF(1);
      Heat_PWM = 0;
     // DACx_Service(2100, DAC2_NO_GAUGE);  // doslo k odpojeni sondy, AFR na DACu nastavime na 5.0V
      STOP_PID_TMR
      UART_PrintTxt(1,"waiting for reconnecting...."); CR_LF(1);
      do {
        CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);
        delay_ms(500); UART_PrintTxt(1,".");
        ALL_LEDs_OFF; LED_RED_100ms;  // blikame red jako chyba
        DACx_Err_Mode(50, 50, 50); // chyba AFR - cca 6.75 - 7.1 cyklujeme DACy
      } while (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOSENSOR);// CR_LF(1);
     UART_PrintTxt(1,"Sensor re-connected, going back to starting procedure...."); CR_LF(1);
     delay_ms(1000);
     goto START;
    }
    
  // 1. PID kalkulace                          macro
    if (_PID_Calc >= PID_REFRESH) {  // v IRQ timer se nastavi na 1 po 100ms - provedeme update PID topeni
      _PID_Calc = 0;                   // priznak hned mazeme, dalsi az po 100ms v IRQ  UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - vnitrni impedance
      UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - vnitrni impedance
      Heat_PWM = LSU_PID_Heater_Service(UR_mV,UR_mV_ref);        // if (LED3) LED3=0; else LED3=1;    // jen pro debug
    } // if PID_Calc...

  // 2.1 Vypocty AFR, mereni vsech analogu (krom UR), DAC generovani
    if (MeasTime_Cnt >= MEAS_REFRESH) {          // cela fce cca 48ms s AD 256x vzroky, 30ms se 128x vzorky AD !!!
      MeasTime_Cnt = MeasStart=0;              // povoli az dalsi IRQ

     // for (i=0; i <= MEAS_REFRESH; i++) UA_avg = UA_avg + UA_results[i];  // prumer zmerenych AFR z pole + i z toho predesleho AVG
     // UA_avg =  UA_avg / (MEAS_REFRESH+1); // +1 protoze do prumeru bereme i predchozi hodnotu UA_avg
      AFR_act = LinFit(CJ125_Calc_Ip(UA_mV,8), cj49Tab,CJ49_TAB_SIZE);   // cca 1.3-1.5ms (Ip pocitano s floaty)
      Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);   // merime vbat
     /* if ((Vbat_mV < VBAT_LOW) || (Vbat_mV > VBAT_MAX)) {  //test zda Vbat behem mereni nespadnul mimo meze
        Heat_PWM = 0;
        DACx_Service(2100, DAC2_NO_GAUGE);  // doslo k odpojeni sondy, AFR na DACu nastavime na 5.0V
        STOP_PID_TMR
        UART_PrintTxt(1,"Vbat outside limits - restarting..."); CR_LF(1);
        goto START;
      } */
      DACx_Service(AFR_act, DAC2_NO_GAUGE);      // cca 1.5ms - obslouzeni analogovych vystupu
    } // if (MeasTime_Cnt...
    else {  // 2.0 tady nabirame vzorky do pole UA_results[] pro prumerovani Ua v if 2.1
      UA_mV = Get_AD_mV(UA_AD_ch,AD_KOEF);   // merime UA napeti z CJ125 ~ "lambda"
     // UA_results[MeasTime_Cnt] = UA_mV;      // ukladame data do pole UA (max 10)
      MeasStart=0;  // povoli az dalsi IRQ
      MeasTime_Cnt++;
    }; // else  (MeasTime...

    // 3. Displej - refresh AFR na displeji a poslani dat na UARTy
    if (DisplayRefreshCnt >= DISP_REFRESH) { // cas na refresh AFR displeje   2 => 200ms => 5Hz
      DisplayRefreshCnt = 0;
      OLED_Show_AFR(AFR_act, AFR_act);
      if (USE_UART1) UART_Service();        // UART - posilani dat -  techto 6x vypisu na UART trva 10ms (115k2)
    } // if DisplayRefresh....
  } // while 1     ===================================================
#endif
}  // void main()


// =============== =============== =============== =============== =============== ===============
//                       +++++++++++++    M   A   I   N    E  N  D  +++++++++++++++
// =============== =============== =============== =============== =============== ===============

u16 LSU_PID_Heater_Service(u16 Ur_Act,u16 Ur_Target) {
  u16 PWM_Out=1;
  PWM_Out = (u8) Heater_PID_Control(LSU_TYPE, Ur_Act, Ur_Target);
  PWM4_Set_Duty(PWM_Out);
  return PWM_Out;
}

// ===========================================================================
void DACx_Service(u16 AFR_Val,u8 UseGauge) {   // cca 1.5ms@16Mhz
   u8 x=0;
   // DAC1 analog Out  - NB emulace
  // DAC1_Out = LinFit(AFR_Val,DAC_NB_EMUL,DAC_NB_EMUL_SIZE);   // pocitame DAC1 pro NB emulaci (1. analog out)
   DAC1_Out = LinFit(AFR_Val,DAC_LINEAR,DAC_LINEAR_SIZE);    // AFR 9~0.15V - 18.7~5.0V
   DACx_mV_Out_10bit(1, DAC1_Out);    // zapiseme DAC 1 vystup
   // DAC2 analog Out
   if (UseGauge) DAC2_Out = LinFit(AFR_Val, Innov_818_Tab,INOV818_TAB_SIZE);  // Innovate gauge 8-18AFR (1V - 0V)
   else          DAC2_Out = LinFit(AFR_Val,DAC_LINEAR, DAC_LINEAR_SIZE);     // DAC2_Out = (5*AFR_act)-4350;
   DACx_mV_Out_10bit(2, DAC2_Out);    // dtto DAC 2 vystup
}

// ===========================================================================
void UART_Service() {
   UART_PrintTxt(1," AFR=");   UART_PrintU16(1,AFR_act);    //WordToStr(AFR_act,_txtU16);  UART_PrintTxt(1,_txtU16);
  //UART_PrintTxt(1," MAP =");   UART_PrintU16(1,MAP);       //WordToStr(MAP,_txtU16);      UART_PrintTxt(1,_txtU16);
   UART_PrintTxt(1," Vbat= "); UART_PrintU16(1,Vbat_mV );  //WordToStr(Vbat_mV,_txtU16);  UART_PrintTxt(1,_txtU16);
   UART_PrintTxt(1," UA="); UART_PrintU16(1,UA_mV);    //WordToStr(UA_avg,_txtU16);   UART_PrintTxt(1,_txtU16);
   UART_PrintTxt(1," UR=");    UART_PrintU16(1,UR_mV);     //WordToStr(UR_mV,_txtU16);    UART_PrintTxt(1,_txtU16);
   //UART_PrintTxt(1," PWM=");   UART_PrintU16(1,Heat_PWM ); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
  // UART_PrintTxt(1," DAC1=");  UART_PrintU16(1,DAC1_Out); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
   UART_PrintTxt(1," DAC2=");  UART_PrintU16(1,DAC2_Out); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
   //           UART1_Write_Text(" IP = ");  CJ125_Calc_IP(UA_avg,8);  // vypocet IP je ok
    CR_LF(1);
}

void DACx_Err_Mode(u16 start_DAC,u16 max_DAC_add, u16 step) {  // plynule zvetsuje DAC1/2 vystupy z DACx_INIT voltage max. o max_DAC_add
  u16 DAC_out =0;
  
  if (DAC_ERR_CNT < max_DAC_add) DAC_ERR_CNT += step;
  else DAC_ERR_CNT = 0;
  
  DAC_out = start_DAC + DAC_ERR_CNT;
  DACx_mV_Out_10bit(1,DAC_out); DACx_mV_Out_10bit(2,DAC_out); CR_LF(1);
  //UART_PrintU16(1,DAC_out); CR_LF(1);
}

void OLED_Show_AFR(u16 Afr, u16 Vbat)  // zobrazi na pozici  [0,2] 14 pak [71,2] tecku aka 5x5 ctverecek a na [71,2] za destin. carkou  napr 1489 => 14.89
{  // pouziva globalni tmp txt buf
  SSD1306_ClearDisplay();
  SSD1306_FillRect(60,43,5,5);  // desetinna tecka
  SSD1306_TextSize(5);  // velky font
  SSD1306_GotoXY(0, 2);  sprintf(Tmp_buf,"%u",Afr/100); SSD1306_Print(Tmp_buf);  // 1489=> 14
  SSD1306_GotoXY(71, 2); sprintf(Tmp_buf,"%u",Afr%100); SSD1306_Print(Tmp_buf);  // 1489=> 89

 // SSD1306_TextSize(2);
 // SSD1306_GotoXY(2, 48); sprintf(Tmp_buf,"%u",Vbat/100); SSD1306_Print(Tmp_buf);
 // SSD1306_GotoXY(30, 48); sprintf(Tmp_buf,"%u",Vbat%100); SSD1306_Print(Tmp_buf);
//  SSD1306_GotoXY(80,48); // SSD1306_Print("1945");   //SSD1306_PutC('1');  SSD1306_PutC('9'); SSD1306_PutC('9'); SSD1306_PutC('4');
  SSD1306_FillRect(60,43,5,5);  // desetinna tecka
  SSD1306_Display();
}
// ===========================================================================
/*
void Button_Service(u8 MaxPress) { // obsluha tlacitka But0
  if (But0.Armed == 1) {  // byl platny stisk a jsme zde poprve
    if (But0.Click < MaxPress) But0.Click++;
    else But0.Click = 0;
    UART_PrintTxt(1,"BUT PRESSED ="); UART_PrintU8(1, But0.Click); CR_LF(1);
    But0.Armed = 0;   // povolime dalsi stisk
  }
  else if (But0.Larmed == 1) {  // byl platny stisk a jsme zde poprve
    UART_PrintTxt(1,"BUT LONG PRESSED"); CR_LF(1);
    But0.Larmed = 0;  // povolime dalsi long stisk
  }
  else {   }   // zadny stisk nebyl}
}
*/