#include "resource.h"


void UART_PrintCh(u8 Nr, char ch) {
  if (Nr == 1) {
     TXREG1 = ch;
     asm { nop };
     while (!TX1STA.B1);       //  while (!TX1IF_bit);  //    while (!TX1STA.B1);    // TRMT1_bit at TX1STA.B1;    // cekame pokud je odesilaci bufer plny(=0), (1 = empty)
  } //if
  else if (Nr == 2) {
      TXREG2 = ch;
      asm { nop };
      while (!TX2STA.B1);
  } // else if
}
// ====================================================================== //
void PrintF1( char *p_string )
{
   char n;
   n = 0;
   while( p_string[n]) /*!= 0*/ {              // Check for end of string
    while (!TRMT_TX1STA_bit);   // cekame pokud je odesilaci bufer plny
    TXREG1 = p_string[n++];
//   UART1_Write(p_string[n++]);                // Display char on LCD
  }
}
// ====================================================================== //
// ====================================================================== //
void HC06_SendByteBuf(u8 pBuf[], u8 BufLen) {  // vyzkouseno i 255Bytes pri 115k2
  u8 n=0;         // mobil vycital bezproblemu pri 200ms opakovani (tzn. 5x255 bytes za 1s)
  while(BufLen--) {              // Check for end of string
    TXREG2 = pBuf[n++];
    asm { nop };
    while (!TX2STA.B1);
  }
}
// ====================================================================== //
// ====================================================================== //
void UART_PrintTxt(char UR_nr,char *p_string){
  while(*p_string > 31) { // dokud jsou tisknutelne znaky, piseme...
    if      (UR_nr == 1) {
      TXREG1 = *(p_string++); while (!TX1STA.B1); }      //  while (!TX1IF_bit);  //    while (!TX1STA.B1);    // TRMT1_bit at TX1STA.B1;    // cekame pokud je odesilaci bufer plny(=0), (1 = empty)
    else if (UR_nr == 2) { 
      TXREG2 = *(p_string++); while (!TX2STA.B1); }
  } // while
}
// ==============================================================================
// ==============================================================================
void PWM_Init_DAC1(u16 mVout) {   // RB5 - CCP3 PWM - Timer 4 - 15.625kHz@10bit pro 16Mhz, 31.25k pro 32Mhz @ 10bit
   CCP3CON  = 0b00001100;   // PWM mode for CCP3
   C3TSEL0_bit = 0; C3TSEL0_bit = 1;  // Timer4 for CCP3
   PR4  = 0xFF;    // max F_pwm
   TMR4ON_bit = 1; // start timeru 4
   DACx_mV_Out_10bit(1,mVout); //CCPR3L = 23;   // defaultni napeti - 23 ~ 450mV
}
void PWM_Init_DAC2(u16 mVout) {   // RA4 - CCP5 PWM - Timer 4 - 20kHz
   CCP5CON  = 0b00001100;   // PWM mode for CCP5
   C5TSEL0_bit = 0; C5TSEL0_bit = 1;  // Timer 4 for CCP5
   PR4  = 0xFF;    // max F_pwm
   TMR4ON_bit = 1; // start timeru 4
   DACx_mV_Out_10bit(2,mVout);  //  CCPR5L = 128;   // defaultni napeti - 128 - 2.5V
}

// ==============================================================================
u16 DACx_mV_Out_10bit(u8 ch, u16 OutmV) {// cca 420us@16Mhz  // nastavi napeti na DAC1 resp. DAC2 - 10bit / 15625Hz @ 16Mhz // vraci vysledny
   u16 PWM_raw=0;
 //  u32 tmp=0;  // primo s OutmV to nefunguje !!!! pozor !!!!
   U32_tmp = (u32)OutmV * 100; // !!! POZOR, musi byt pretypovano na U32, jinak nefunguje !!!!
   U32_tmp =  U32_tmp / DAC_KOEF;  // koeficient 19.6mv ~ 1bit   //45000 / 489 = 92

   if (U32_tmp >= 1023) U32_tmp = 1023;
   PWM_raw = (u16)U32_tmp;
   
   if (ch==1) {  //DAC 1
   // UART1_Write_Text(" DAC1 = "); WordToStr((u16)U32_tmp,_txtU16);  UART1_Write_Text(_txtU16);
     if ((U32_tmp & 0b01) == 1) DC3B0_bit = 1;  // testujeme DCxB0
     else                       DC3B0_bit = 0;
     if ((U32_tmp & 0b10) == 2) DC3B1_bit = 1;  // testujeme DCxB1
     else                       DC3B1_bit = 0;
     U32_tmp >>=2;   // spodni dva bity mame a ted zbyvajicich vrchnich 8 (takze posuneme o 2 vpravo)
     CCPR3L = (u8)U32_tmp;
     return PWM_raw;
   }
   else if (ch==2) {   //DAC 2
    // UART1_Write_Text(" DAC2 = "); WordToStr((u16)U32_tmp,_txtU16);  UART1_Write_Text(_txtU16);  //
     if ((U32_tmp & 0b01) == 1) DC5B0_bit = 1;  // testujeme DCxB0
     else                       DC5B0_bit = 0;
     if ((U32_tmp & 0b10) == 2) DC5B1_bit = 1;  // testujeme DCxB1
     else                       DC5B1_bit = 0;
     U32_tmp >>=2;   // spodni dva bity mame a ted zbyvajicich vrchnich 8 (takze posuneme o 2 vpravo)
     CCPR5L = (u8)U32_tmp;
     return PWM_raw;
  }
}
// ==============================================================================
u16 LinFit(i16 X,i16 pTab[], u8 Tab_size) {  // cca xxx us@16Mhz pomoci lin. aproximace hledame z 1D tabulky Y pro zadane X (misto 2D tabulky)
   i32 X_k1=0,Y_k1=0,X_k=0,Y_k=0,Y=0,Xmin=0,Xmax=0;    //   1D_Array[2*8] = { 0, 250, 500, 255, 565 ,5656, 5856, 800,    - X [mA]*1000
   u8 id=0;                                //                                 2,  25,  50, 244, 1245, 455,  522, 565 };  - Y  [AFR]

   Xmin = pTab[0];
   Xmax = pTab[Tab_size-1]; //    UART1_Write_Text("X = "); IntToStr(X,_txtU16);  UART1_Write_Text(_txtU16);  //  UART1_Write_Text(" Xmin = "); IntToStr(Xmin,_txtU16);  UART1_Write_Text(_txtU16);
   if (X <= Xmin)      { return pTab[Tab_size]; }        // - krajni hodnoty - pro Y se posuneme o Tab_size na zactek druheho radku
   else if (X >= Xmax) { return (i16)pTab[(Tab_size+Tab_size)-1]; } // X posledni = 8-1 a k nemu y je o 8 dal => id=15

   do {  // hledame v tabulce prvni X vyssi nez hledane (vstupni) X
     X_k1 =  pTab[id];  // hledame vyssi X jen v prvnim radku (tzn 0 az Tab_size-1) -
     if (X_k1 == X) return (i16)pTab[id + Tab_size];  // nasli jsme primo hondotu v tabulce - pro ziskani Y se musime posunout do druheho radku o TAB_size
     if (X_k1 > X) {  // nasli sme X vetsi nez hledane -> mame tudiz X_k1 a Y_k1
       Y_k1 = pTab[Tab_size+id];     // UART1_Write_Text(" X_k1 = "); IntToStr(X_k1,_txtU16);  UART1_Write_Text(_txtU16); UART1_Write_Text(" Y_k1 = "); IntToStr(Y_k1,_txtU16);  UART1_Write_Text(_txtU16);
       X_k  = pTab[id-1]; // Xk je pred Xk1 tzn. -1
       Y_k  = pTab[(id+Tab_size)-1]; //    //  UART1_Write_Text(" X_k = "); IntToStr(X_k,_txtU16);  UART1_Write_Text(_txtU16); UART1_Write_Text(" Y_k = "); IntToStr(Y_k,_txtU16);  UART1_Write_Text(_txtU16);
       Y = (Y_k * (X - X_k1) - Y_k1 * (X - X_k)) / (X_k - X_k1);  // a zde spocitame aproximaci z dat z tabulky hledane Y
   // UART1_Write_Text(" Y = "); IntToStr(Y,_txtU16);  UART1_Write_Text(_txtU16); //       UART1_Write_Text(" Ip = "); IntToStr(X,_txtU16);  UART1_Write_Text(_txtU16);     UART1_Write_Text("  => AFR = "); WordToStr((u16)Y,_txtU16);  UART1_Write_Text(_txtU16);   // CR_LF(1);
       return (u16)Y; // vrcime spocitane Y a koncime
     }
     id++;
   } while (id < Tab_size);
 /*
     if (UseRound) {  // zaokrouhlujeme na 0005 (5. setiny AFR) napr 1400 - 1405 - 1410 - 1415 atd.
     AFRtmp = AFRdata % 10;   // posledni cislice v AFR - kdyz >=5 =>
     if (AFRtmp >=5) AFRdata = (AFRdata - AFRtmp) + 5;  // zaokrouhlime nahoru na 5. setiny tzn. AFR 1495-1499 => 1495
     else            AFRdata = AFRdata - AFRtmp;       // zaokrouhlime dolu na desetiny   1490-1494 = > 1490
   }
 */ return 0; // (u16)Y; // vrcime spocitane Y a koncime
}
// ===========================================
void BT_Send_Data(u16 TxData) {
  u16 TX=0,tmp=0;
  TX = TxData / 10; // 1475 / 10 = 147
  tmp = TxData % 10;  // 1475 % 100 = 5
  if (tmp >= 5) TX++;
  TXREG2 = TX; while(!TX2STA.B1);  //UART2_Write(TX);   // binarne posleme 1byte AFR napr. 1475 => 148
}
// ==============================================================================

u16 TxtToU16(char *Buf) { // prevede ASCII cislo z TXT buferu za znakem '=' - max. 9999 na u16
  u16 res=0;
  u8 numBuf[4];
  u8 i=0,*pNu;
  
  pNu = strstr(Buf,"=");
  pNu++;
  while ((*pNu > 47) && (*pNu < 58) && (i < 4)) {  // znaky 0 - 9 a cislo max. na 3 mista (9999 max)
   numBuf[i++] = *pNu - 48;  // prevedeme na cislici 0-9
   pNu++;  // pointer posuneme dal
  }
  if (i == 0) return res=0;
  i--;
  if (i == 3) {  //napr 6 , 5 , 4 , 8
   res  = (u16)numBuf[0] * 1000;  //6 * 1000
   res += (u16)(numBuf[1] * 100);  // 6000 + 5*100
   res += (u16)(numBuf[2] * 10);   // 6500 + 4*10
   res += (u16)numBuf[3];         // 6540 + 8
   return res;
  }
  else if (i == 2) {
   res  = (u16)numBuf[0] * 100;
   res += (u16)numBuf[1] * 10;
   res += (u16)numBuf[2];
   return res;
  }
  else if (i == 1) {   // napr. 8, 4
   res  = (u16)numBuf[0] * 10;  // 8 * 10 = 80
   res += (u16)numBuf[1]; // 80 + 4
   return res;
  }
  else  res = numBuf[0];
  return res;
}