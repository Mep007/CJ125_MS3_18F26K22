
#include "resource.h"

// Special Pin function definitions

//sfr sbit BUT0      at RB0_bit;       // puvodni deska
sfr sbit BUT0_PIN  at RA3_bit;     // puvodne BUZZER out - preriznuty spoj u R65 !!
sfr sbit LED1      at LATA6_bit;   // BLUE//at LATB2_bit;   // BLUE
sfr sbit LED2      at LATB3_bit;   // GREEN
sfr sbit LED3      at LATB4_bit;   // RED
sfr sbit DAC1      at LATA4_bit;   // DAC1 OUT

// SPI1 CS pins
sfr sbit CJ125_CS      at LATC1_bit; // RC1_bit;
sfr sbit CJ125_RST     at LATC2_bit; // RC2_bit;
sfr sbit CJ125_Heater  at LATB0_bit; // RB0_bit;

// ============================================================================
// Functions definitons
void HW_Init() {
   // PORT A definition
  PORTA = LATA = 0;
  ANSELA = 0b00100111;         // RA0-2,5 => A/D, RA3 - I/O IN (L_BUT0)
  TRISA  = 0b10101111;         // RA4- CCP5 - DAC2 PWM out
   // PORT B definition
  PORTB = LATB = 0;
  ANSELB = 0;                // all digitals I/O     ; ;
  TRISB = 0b11000000;        // RB0- PWM CCP4 OUT spojen cinem s RB1(INPUT) - PIC_HEATER (pac RB1 nema CCPx unit)                        // RB5 - DAC2 Out
 // PORT C definition                                          RB6/7 - UART2 - both pins as INPUTS !! (see pdf page 260)
  PORTC = LATC = 0b00000011;   // MAX7219 nCS OFF :> RC0 = log1, Bosch CJ125 - RC1 = log1 (OFF), RC2 - Bosch CJ125 - RST (log1 = working)
  ANSELC = 0;                  // all digitals I/O
  TRISC = 0b11010000;          //0b10010000; - RC6/7 - UART 1 - both pins as INPUTS !! (see pdf page 260)

#ifdef _32Mhz_Clk            // !!! CHANGE PROJECT SPEED MANUALLY TOO !!!!!!
  OSCCON  = 0b01100000;         // 8Mhz int osc 8*4 = 32Mhz
#else
  OSCCON  = 0b01010000;         // 4Mhz int osc 4*4 = 16Mhz
#endif
  PLLEN_bit = 1;               // * 4 = 32Mhz or 16Mhz
// OSCTUNE = 0b01000000;        // PLLEN_bit = 1;
  while (!HFIOFS_bit);     // cekame na ustaleni oscilatoru
  while (!PLLRDY_bit);     // dtto na ustaleni PLL

  PMD0 = 0;
 /////////////////////////////////
  Delay_ms(250);  // kvuli FOrte - drzi PGD a PGC v nule cca 120 ms !!!!
 // UART 1 115k2 Init - oporti UART1_Init usetri 70 bytes
 //#ifdef _32Mhz_Clk  SPBRGH1 = 0; SPBRG1 = 68;  // 17 for 32Mhz, 34 for 16Mhz @115k2 (0.79% error)#endif
  TXSTA1 = RCSTA1 = 0;
  BRG16_BAUD1CON_bit = 1;    // high speed UART
  BRGH1_bit = 1; //BRGH_TX1STA_bit = 1;
  SPBRGH1 = 0; SPBRG1 = 34;  // 34 for 16Mhz @115k2 (0.79% error)
  SYNC1_bit = 0;  // asynchronous mode
  SPEN1_bit = 1;
  TXEN1_bit = CREN1_bit = 1;  // povoleni Tx i Rx, zpnuti UART1

  rU1.Stat    = 0;       // init user struktury pro RX UART1
  rU1.UseTermCh = _USE_UART1_TERM_CHAR;     // 1 = TRUE
  rU1.TermCh = 10;      // ukoncovaci znak pri Rx
  rU1.UseASCII = 1;
  rU1.TIMEOUT = RX_TIMEOUT;  // timeout v us pro cekani na Rx data
  rU1.TimeCnt = 0;
  rU1.CntBuf  = 0;
  rU1.BufLen  = RX_BUF_LEN;

 ///////////////////////////////////////////
 ///  UART 2 - BT  UART2_Init(115200);
 /*
  TXSTA2 = RCSTA2 = 0;
  BRG16_bit = 1;    // high speed UART2
  BRGH2_bit = 1;
  SPBRGH2 = 0; SPBRG2 = 34;  // 34 for 16Mhz @115k2 (0.79% error)
  SYNC2_bit = 0;  // asynchronous mode
  SPEN2_bit = 1;
  CREN2_bit = 1;  // povoleni Tx i Rx, zpnuti UART1
  TXEN2_bit = 1;

  rU2.Stat    = 0;    // init user struktury pro RX UART1
  rU2.UseTermCh = 0;     // 1 = TRUE, 0 = FALSE
  rU2.TermCh = 10;     // ukoncovaci znak pri Rx
  rU2.UseASCII = 1;
  rU2.TIMEOUT = RX_TIMEOUT;  // timeout v us pro cekani na Rx data
  rU2.TimeCnt = 0;
  rU2.CntBuf  = 0;
  rU2.BufLen  = RX_BUF2_LEN;
 */
//  RC2IE_bit = 1;

///////////////////////////////////////////
  //Timer0 - pro PID regulaci po 50ms + zobrazovani na dipleji
    // 16Mhz - Prescaler 1:8; TMR0 Preload = 15536; Actual Interrupt Time : 100 ms
 //   T0CON = 0x81;   //   0x81 - 50ms@16Mhz, 0x82 - 100ms@16Mhz
   T0CON = 0x81;   //   0x81 - 50ms@16Mhz, 0x82 - 100ms@16Mhz
   TMR0H = 0x3C; TMR0L = 0xB0; TMR0IF_bit = 0; TMR0IE_bit = 0;  // 15536 - pro 50ms a 0x82@32Mhz

  //Timer6 - pro test tlacitka - po 10ms@16Mhz nebo 5ms@32Mhz
   T6CON = 0x4E; TMR6IF_bit = 0; PR6 = 250; TMR6IE_bit = 1; // zatim nepovolime IRQ

// ADC init
   ADC_Init();

  //  Init functions and variables =====================================
  // ============================= =====================================
   CJ125_CS = 1;       // SPI devices DISABLED
   CJ125_RST = 0;                   // 1 => CJ125 ENABLED
  // CJ125_RST = 1;                   // 1 => CJ125 ENABLED //presunutu do TEST fce
   LED_Welcome();  // sekvence LED1,2,3 pri zapnuti

   for (u8TMP=0; u8TMP < 10; u8TMP++) UA_results[u8TMP] = 0;
   for (u8TMP=0; u8TMP < RX_BUF_LEN; u8TMP++)  RX_buf[u8TMP] = 0;
//   for (u8TMP=0; u8TMP < RX_BUF2_LEN; u8TMP++) RX_buf2[u8TMP] = 0;
   for (u8TMP=0; u8TMP < TMP_BUF_LEN; u8TMP++) Tmp_buf[u8TMP] = u8TMP;

 //  ConfigMode = 0;
 //  UART_PrintU8(1,ConfigMode);

//  UART'S Init
   UART1_FIX_ERR
//   UART2_FIX_ERR
   u8TMP = RCREG1; u8TMP = RCREG2;

// Load EEPROM constants data
    EE_Consts = EEPROM_Read_Constant(EEPROM_CONST_ADR);

  //============================================================================
   //AD / DA / VBAT koef z EEPROM
   ADC_COEF_OFS_EEPROM =  EEPROM_Read(ADC_OFFSET_ADR); delay_ms(20);
 //  I16_tmp = EEPROM_Read(ADC_OFFSET_ADR);  // vycteni offsetu AD_meas (+/- 20 max tj  489-20= 469 nebo 489 + 20 = 509 ) , tj cca Vcc=4.8-5.2V
   if ((ADC_COEF_OFS_EEPROM >= 50) && (ADC_COEF_OFS_EEPROM <= -50)) {
     ADC_COEF_OFS_EEPROM = 0;  // default kdyz jsme mimo meze
   }
   AD_KOEF  = _AD_CONST + ADC_COEF_OFS_EEPROM; Delay_ms(20);
//   I16_tmp = EEPROM_Read(DAC_OFFSET_ADR); // prevod ulozeneho i8 z EEPROM
   DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
   if ((DAC_COEF_OFS_EEPROM >= 40) && (DAC_COEF_OFS_EEPROM <= -40)){
     DAC_COEF_OFS_EEPROM = 5;  // default kdyz jsme mimo meze
   }
   DAC_KOEF = _DAC_CONST - DAC_COEF_OFS_EEPROM; Delay_ms(20); //(muze byt +/- 127 v EEPROM)

//   I16_tmp = EEPROM_Read(VBAT_OFFSET_ADR); // prevod ulozeneho i8 z EEPROM
   VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
   if ((VBAT_COEF_OFS_EEPROM >= 50) && (VBAT_COEF_OFS_EEPROM <= -50)) {
     VBAT_COEF_OFS_EEPROM = 0;  // default kdyz jsme mimo meze
   }
   VBAT_KOEF = _VBAT_KOEF + VBAT_COEF_OFS_EEPROM;
  //============================================================================

   //CCP4 PWM - PIC HEATER - RB0 - pouziva Timer 2 - Pozor !
   PWM4_Init(1000);   // 1k naprosto ok, plynula PID regulace, 100%
   PWM4_Set_Duty(0);
   //CCP3 PWM - DAC1 OUT - RB5  - Timer 4 - emulace NB
   PWM_Init_DAC1(DAC1_INIT_VOLT); //
   //CCP5 PWM - DAC2 OUT - RA4  - Timer 4
   PWM_Init_DAC2(DAC2_INIT_VOLT); //
// IRQ Enabled
   RC1IE_bit = 1;         // Uart 1 Rx
  // RC2IE_bit = 1;       // Uart 2 Rx
   PEIE_bit = 1;        // povoleni pro xt.periferie napr Timer 6
   GIE_GIEH_bit = 1 ;   // Global IRQ ENABLE
}
// ==========================================================================//
// ==========================================================================//
void LED_Welcome() {              //
   LED1=1; Delay_ms(100); LED1=0;// Delay_ms(50);
   LED2=1; Delay_ms(100); LED2=0;// Delay_ms(50);
   LED3=1; Delay_ms(100); LED3=0;// Delay_ms(50);
}
// ==========================================================================//
void UART_Welcome(u8 ComNr, EEprom EE_Data){
   CR_LF(ComNr);
   CR_LF(ComNr);
   if (ComNr == 1){  // jen pro UART1 - ne do UARTU2 - Androidu
     UART_PrintTxt(ComNr,"MS3_MEP WBO Controller:");                       CR_LF(ComNr);
     UART_PrintTxt(ComNr,"============================");                  CR_LF(ComNr);
     UART_PrintTxt(ComNr,"SN: ");      UART_PrintU16_HEX(ComNr,EE_Data.SN);CR_LF(ComNr);
     UART_PrintTxt(ComNr,"HW_VER: ");  UART_PrintU8(ComNr,EE_Data.HW_ver); CR_LF(ComNr);
     UART_PrintTxt(ComNr,"SW_VER: ");  UART_PrintU8(ComNr,EE_Data.SW_ver); CR_LF(ComNr);
     UART_PrintTxt(ComNr,"OPTION: ");  UART_PrintU8(ComNr,EE_Data.OPTION); CR_LF(ComNr);
      CR_LF(ComNr);
     UART_PrintTxt(ComNr,"EEPROM CALIBRATION DATA:");                             CR_LF(ComNr);
     UART_PrintTxt(ComNr,"============================");                  CR_LF(ComNr);
     UART_PrintTxt(1,"  ADC_OFFSET="); UART_PrintI8(ComNr,ADC_COEF_OFS_EEPROM);  UART_PrintTxt(ComNr,", AD_KOEF=");  UART_PrintU16(ComNr,AD_KOEF);   CR_LF(ComNr);
     UART_PrintTxt(1,"  DAC_OFFSET="); UART_PrintI8(ComNr,DAC_COEF_OFS_EEPROM);  UART_PrintTxt(ComNr,", DAC_KOEF="); UART_PrintU16(ComNr,DAC_KOEF);  CR_LF(ComNr);
     UART_PrintTxt(1,"  VBAT_OFFSET=");UART_PrintI8(ComNr,VBAT_COEF_OFS_EEPROM); UART_PrintTxt(ComNr,",VBAT_KOEF="); UART_PrintU16(ComNr,VBAT_KOEF); CR_LF(ComNr);
     CR_LF(ComNr);
     CR_LF(ComNr);
   }
}
/*void UART2_BT_Welcome() {
  UART2_Write_Text("MEP BT v1.0"); CR_LF(2);
} */
// ==========================================================================//
void CR_LF(u8 i) {
  if (i == 1) { TXREG1 =10; while(!TX1STA.B1); TXREG1 =13;  while(!TX1STA.B1); } // UART1_Write(10); UART1_Write(13); }
  else        { TXREG2 =10; while(!TX2STA.B1); TXREG2 =13;  while(!TX2STA.B1); } //UART2_Write(10); UART2_Write(13);  }
}
// ==========================================================================//