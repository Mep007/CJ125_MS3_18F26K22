#include "resource.h"

//===========================================================================
//Function for transfering SPI data to the CJ125.
u16 CJ125_Write(u16 TX_data){
  u8 lodata,hidata;
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_HIGH_2_LOW);  // OK pro CJ125  - musi byt v kazdekomunikacni fci
  Delay_ms(10);  // otazka
  
   CJ125_CS = 0; 
    //delay_us(50); // cekani nebylo zadne, zkusime pridat pro zlepseni stability
    hidata = SPI1_Read(TX_data>>8);  // 0x48 napr.  - zde je pak 1. odpoved CJ125 - 00101000b - x28 (dulezitejsou jen b101)
    lodata = SPI1_Read(TX_data);
   CJ125_CS = 1;

  return ((hidata<<8)+lodata);
}
//===========================================================================
u16 CJ125_Test() {     // napeti alespon 10.5V
   char n=0,error=0;
    // CJ125 Init - test odpovedi samotneho CJ125(done) + test sensoru(todo)
    Vbat_init_mV= 0;

 // 1. posleme 0x48 - identifikace chipu
    CJ125_RST = 1;   // az tady povolime CJ125
    delay_ms(100);
    CJ125_Ans = CJ125_Write(CJ125_INIT_REG2_RESET_ALL); // reset chipu
    delay_ms(50);
    CJ125_Ans = 0;
    CJ125_Ans = CJ125_Write(CJ125_IDENT_REG_REQUEST);
    UART_PrintTxt(1,"Bosch CJ125, chip version = ");
    if      (CJ125_Ans ==  CJ125_RD_IDENT_CJ125BA_ANS ) UART_PrintTxt(1,"0x62(BA)");
    else if (CJ125_Ans ==  CJ125_RD_IDENT_CJ125BB_ANS ) UART_PrintTxt(1,"0x63(BB)");
    else { error = 1; }
    UART_PrintTxt(1,", Status code = " ); UART_PrintU16_HEX(1,CJ125_Ans);
    CR_LF(1);

    if(error) {  // tady skoncime, protoze stejne nelze nic dal delat
      UART_PrintTxt(1,"Error during CJ125 init. Program stopped." );
      while (1) {  //
        LED_BLUE_100ms  // error cipu, blikame rychle modre
        delay_ms(50);
      }
    }
 // 2. zmerime prvnotni Vbat
    Vbat_init_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF );  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV
   CR_LF(1); UART_PrintTxt(1,"Init Vbat = "); WordToStr(Vbat_init_mV,_txtU16); UART_PrintTxt(1,_txtU16);UART_PrintTxt(1," mV"); CR_LF(1);CR_LF(1);

    return CJ125_Ans;
}

//===========================================================================
u16 CJ125_Sensor_Test() {     // testuje stav pripojeni LSU senzoru
   char n=0,error=1;
   CJ125_Ans = 0;

   CR_LF(1); UART_PrintTxt(1,"WBO LSU 4.9 Sensor status - ");
   
   CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);    // dotaz na stav pripojeni sensoru
   if      (CJ125_Ans == CJ125_DIAG_REG_STATUS_OK )       { UART_PrintTxt(1,"OK"); error = 0; }
   else if (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOSENSOR) { UART_PrintTxt(1,"Not connected"); }
   else if (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOPOWER)  { UART_PrintTxt(1,"No power");      }
   else                                                   { UART_PrintTxt(1,"Other failure"); }  // vubec nic

   UART_PrintTxt(1," - Status code = ");  // vubec nic
   UART_PrintU16_HEX(1,CJ125_Ans);   //  UART_PrintU16(1,CJ125_Ans); WordToStr(CJ125_Ans,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);
   return CJ125_Ans;
}

//===========================================================================
u16 CJ125_Vbat_check() {     // testuje stav Vbat - dle toho spusti dal ohrivani sondy
/*  Evenuality: (zakladni podminka: vbat >=10.5 && < 15.5V)
  1. Vbat >=10.5V (VBAT_LOW) && < 12.9V (VBAT_RE_RUN) = > pak zmeri Vbat_init a ceka na dobu kdy Vbat >= Vbat_init + 0.6V (DELTA_VBAT) - kdyz po dobu [Wait_for_run] bude splneno, pokracuje dal ohrev etc.
  2. Vbat >= VBAT_RE_RUN = > rovnou pokracujeme dal v ohrevu etc. (napr dojde k resetu kontroleru na bezicim motoru- nevadi, pokracujeme dale)
*/
   char n=0,Wait_for_run=10;
   Vbat_init_mV = Vbat_mV = CJ125_Ans = 0;
   CR_LF(1);

// 1. Mereni Vbat_init
   do {  /// pokdu je napaeti mimo zakladni meze, zustaneme zde , potencialni loop
    Vbat_init_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF );  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV - po zapnuti klicku
    UART_PrintTxt(1,"Init Vbat[mV] = ");  UART_PrintU16(1,Vbat_init_mV); CR_LF(1);
    delay_ms(500);
   } while ((Vbat_init_mV <= VBAT_LOW) || (Vbat_init_mV > VBAT_MAX));
   
// 2. Detekce napeti baterie
    if (Vbat_init_mV <= VBAT_RE_RUN) {
      do {  ///
       Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF );  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV
       UART_PrintTxt(1,"Vbat="); UART_PrintU16(1,Vbat_mV); UART_PrintTxt(1,", "); // UART_PrintU16(1,UR_mV); // CR_LF(1);
       if ((Vbat_mV >= VBAT_LOW) && (Vbat_mV < VBAT_MAX)) {  // povolene meze Vbat
         //if       (Vbat_mV >= VBAT_RE_RUN) Wait_for_run = 0;    // napeti Vbat je kolem 12.9V - muzeme rovnou pokracovat v ohrevu etc.
         if  (Vbat_mV >= (Vbat_init_mV + DELTA_VBAT)) Wait_for_run--;    // Vbat se zvestsil o DELTA_VBAT => zrejme s nastartovalo a zaclo se dobijet - zaciname odpocitavat pro spusteni - SW filtr
         else Wait_for_run=10;       // nejake ruseni, zpet na cekani na nastartovani
         UART_PrintU8(1,Wait_for_run); UART_PrintTxt(1,", ");
       }
       else UART_PrintTxt(1,"Vbat mimo meze ");
       delay_ms(500); // bylo 25ms
     } while (wait_for_run > 0); // zde cekani, dokud se napeti baterie nedostane do pracovnich mezi - !! POTENCIALNI LOOP NAVZDY !!
   } // if
  // else Wait_for_run = 0;  // Vbat_init >= VBAT_RE-RUN rovnou pokracujeme
   CR_LF(1);
   UART_PrintTxt(1,"VBAT TEST FINISHED");
   CR_LF(1);
}
//===========================================================================
u8 CJ125_Ri_Cal(u8 LSU) {   // prepnuti do kalibracniho modu a zmereni Rical (82R pro LSU4.2 - cca 780mV  a 301R pro LSU4.9 - cca 2160mV)
   char n=0, Stat=0;
   u16 LoUR=0,HiUR=0,UR_def=0;

  // if      (LSU == LSU42) { LoUR = 650; HiUR = 1400; UR_def = 800;   UART_PrintTxt(1,"LSU 4.2 selected"); }
  // else if (LSU == LSU49) { LoUR = 800; HiUR = 1200; UR_def = 1000;  UART_PrintTxt(1,"LSU 4.9 selected"); // kdyz je dobre osazeno UR_ref_ musi byt kolem 1000 +- 10 cca
   CR_LF(1);
   LoUR = 800; HiUR = 1200; UR_def = 1000;  //UART_PrintTxt(1,"LSU 4.9 selected");
   CJ125_Ans = CJ125_Write(CJ125_INIT_REG1_MODE_CALIBRATE);  // Ans: 11264 (0x2C00) - 2bit je 1, protoze se jedan o Write Access v pred. prikazu
    // zde otestovat, ze jsme skuecne v kalibraci

   while ((Stat != 1) && (n < 5)) {
     CJ125_Ans = CJ125_Write(CJ125_INIT_REG1_MODE_CALIBRATE);
     Delay_ms(500);  //Let values settle.
     //Store optimal values before leaving calibration mode.
     UA_mV_ref  = Get_AD_mV(UA_AD_ch,AD_KOEF);  // merime UA  pro lambda=1 => 1.5V (proud Ip=0mA) - cca 307 RAW
     UR_mV_ref  = Get_AD_mV(UR_AD_ch,AD_KOEF);  // merime UR pro optimalni teplotu senzoru  na Ri=82R pro LSU4.2 resp. Ri=301R pro LSU4.9
     if ((UR_mV_ref > HiUR) ||  (UR_mV_ref < LoUR)) {
       CJ125_Write(CJ125_INIT_REG2_RESET_ALL); //   RESET ALL CHIP
       UART_PrintTxt(1,"UR_ref ="); UART_PrintU16(1,UR_mV_ref); UART_PrintTxt(1," - value outside limits [800-1200]"); CR_LF(1); // WordToStr(UR_mV_ref,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);CR_LF(1);
     //     UR_mV_ref = UR_def;
     //    UART_PrintTxt(1,"UR sets to default, UR_ref ="); UART_PrintU16(1,UR_mV_ref); CR_LF(1);CR_LF(1);
       Stat=10;
     }
     else Stat = 1;
     if (Stat==10) { UART_PrintTxt(1," UR_ref calibration failed.");CR_LF(1);  }

  // nastavime zesileni - pro rich lepsi V=8 - od 9.55AFR s V=17 je az tak od 11.3)
     CJ125_Write(CJ125_INIT_REG1_MODE_NORMAL_V8);
     CJ125_Write(CJ125_INIT_REG1_MODE_NORMAL_V8);   // zkousime 2x zapsat, asi neni nutne ale...
     UART_PrintTxt(1,"CJ125 amplification set to v = 8 (9.55 - 21.00 AFR)"); CR_LF(1);

     if (LSU == LSU49) {
       CJ125_Ans = CJ125_Write(CJ125_INIT_REG2_SET_20uA_Ip );    // vnitrni referencni proud Ip pro 4.9 sondu
       CJ125_Ans = CJ125_Write(CJ125_INIT_REG2_SET_20uA_Ip );    // vnitrni referencni proud Ip pro 4.9 sondu
       UART_PrintTxt(1,"Ip ref. current set to 20uA"); CR_LF(1);
    }
     UART_PrintTxt(1,"UA ref[mV]="); UART_PrintU16(1,UA_mV_ref);             // WordToStr(UA_mV_ref,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);
     UART_PrintTxt(1,", UR ref[mV]="); UART_PrintU16(1,UR_mV_ref); CR_LF(1); //WordToStr(UR_mV_ref,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);
     if (Stat!=1) Delay_ms(500);
     n++;
   } // while (ok !=)
  //Delay_ms(500);  // bylo, ale proc ?
  //  UART_PrintTxt(1,"UR ref - konec kalibrace");
   CR_LF(1);CR_LF(1);
//  UR_mV_ref = 3500;   // jen pro debug
  return Stat;
}
//===========================================================================
void CJ125_PreHeat_LSU(u8 LSU){
  u16 PreHeat_Level,RampHeatInit_PWM;
  u8 HEAT_MAX,HEAT_STEP,PID_PWM_0, i=0, sensor_present=1;

#define HEAT_RAMP_DELAY 250      // interval zvysovani stridy v [ms]
//   LED1 = LED2 = LED3 = 0;
  if (LSU == LSU49) {
    PreHeat_Level     =   450;      // uroven, na kterou se topi v kondenzacni fazi (1000 ~ 0.3A(cca 3.2VRMS), 500~PWM=10~2.0V RMS,I=0.15A)
    RampHeatInit_PWM  =  8000;      // uroven v mV, od ktere zaciname zvysovat rampu po fazi suseni kondenzace - dle PDF je max. 8.5V RMS initial voltage str. 4/13 Bosch technical 258 E00 015e)
    HEAT_MAX          =   180;      // 190 bylo taky, 160 stacelo a bylo ok, max. strida pro topeni 0-255 (0-100% PWM)  - DLE pdf lsu 4.9 JE MAX. NAPETI TRVALE NA topeni 12.0V (max 13.0 po dobu 30s)
    HEAT_STEP         =     2;      // max. +0.4V/s -> o kolik se pridava PWM pri zahrivani, 3% z 12.5V=0.4V => DC=8, => HEAT_STEP = 2 za HEAT_RAMP_DELAY=250ms (tj. 4x2=8 za 1s => 0.4V/s)
    PID_PWM_0         =    80;      // pocatecni uroven stridy pri zacatku PID regulace (cca odpovida ustatele hodnote PWM pri sonde mimo vyfuk)
  }
  // 1. faze zkondenzovane vlhkosti - strida odpovidajici cca 2V po dobu 5s - behem ni stale merime Vbat a pripadne upravujeme stridu
   PWM4_Set_Duty(1);  // zatim temer vypnuto topeni
   PWM4_Start();  // zapiname PWM jendotku na topeni

   LED1 = 0;
   CR_LF(1);   CR_LF(1);

   if (Vbat_mV >= 14000) PWM4_Set_Duty(33);  // Vbat vyssi nez 14V, omezime proto DC topeni pro kondenz. fazi na max. 2V RMS  (tj 33/255* 14.5V) = 1.88V
   else                  PWM4_Set_Duty(38);  // dtto pro Vbat <14V  (38/255) * 13.8V) = 2.1V
   UART_PrintTxt(1,"CJ125 condensation heating start...");

   i=0;
   CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);    // test pripojeni sondy, kdyz by nebyla pripojena, koncime
   do {
     i++;   // 50x0.1s = 5s faze suseni kondenzacni vlhkosti
     Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV
     UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);
     UART_PrintU8(1,i); UART_PrintTxt(1," "); UART_PrintU16(1,UR_mV); UART_PrintTxt(1," ");    //     ByteToStr(i, _txtU8); UART_PrintTxt(1,_txtU8);UART_PrintTxt(1," ");
     Delay_ms(100);
   } while ((i < 50) && (UR_mV > 2000)); // do nebo for  // dokud je UR vetsi nez 2000, bezi kondenzace - teply start by mel byt preskocen
    CR_LF(1); CR_LF(1);

 // 2. faze zvysovani stridycca 0.4V/s - dle pdf k LSU4.2/4.9
    Heat_Target_PWM = RampHeatInit_PWM;    // na tomto napeti zaciname fazi 2
    UART_PrintTxt(1,"CJ125 heating start...."); CR_LF(1);
    Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF ); Vbat_mV = Vbat_mV /10;  // napr 13600 / 10 = 1360
    Heat_PWM = (Heat_Target_PWM / Vbat_mV) * 25;  // napr. 8500 / 1360 = 6 * 25 = 150
    do {
      UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - teplotu sondy
      if (Heat_PWM >= HEAT_MAX) Heat_PWM = HEAT_MAX;   // omezime max. stridu (max. trvale  12.0V na topeni !)
       UART_PrintTxt(1," UR=");       UART_PrintU16(1,UR_mV); // WordToStr(UR_mV, _txtU16); UART_PrintTxt(1,_txtU16);
       UART_PrintTxt(1," PWM="); UART_PrintU16(1,Heat_PWM); CR_LF;
      PWM4_Set_Duty(Heat_PWM);    // topime
      Heat_PWM += HEAT_STEP;   //  +3 a 300ms Delay je cca 0.4V RMS/s
      Delay_ms(HEAT_RAMP_DELAY);     //
      CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);    // test pripojeni sondy, kdyz by nebyla pripojena, koncime
      if (CJ125_Ans !=  CJ125_DIAG_REG_STATUS_OK) { UART_PrintTxt(1," Sensor failure/disconnect during heat-up.."); CR_LF(1); UR_mV=UR_mV_ref; }
    } while (UR_mV >= (UR_mV_ref+200));   // || (Heat_PWM < HEAT_MAX));  // zvysujeme rampu dokud nedosahme max. teploty dle UR ci max. stridy
    CR_LF(1); CR_LF(1);
}

// Heater temp closed loop regulation (PID) - (1kHz IRQ)
//===========================================================================
i16 Heater_PID_Control(u8 LSU, i16 input, i16 target) { //  vstupvy v mV (napr. 1580, 780); vraci 0-255 (napr. pro ovladani 8bit PWM)
   u16 MAX_PWM=0;
   i16 error = target - input;    /// 1000 - 4200 = -3200
   i16 position = input;
   
   if      (LSU == LSU42)  MAX_PWM = 210;
   else if (LSU == LSU49)  MAX_PWM = 170;  //  tj. 75% z Vbat, tj. pri 14V je Vheat(max) = 10.5V (max dle PDF je 12.0V

   pGain = 2.5;   //  3.0  (3.0, 0.5, 1.0 - OK) , take 6.0 / 0.5 / 1.0 je  tez ok
   iGain = 0.6;   //  0.6
   dGain = 1.0;   //  0.5 ok - 1.0  // ovlivnuje rychlost zmen - 50.0 je masakr

   pTerm = -pGain * error;              // P slozka
   iState += error;                     // "Integrace" chyby
   if (iState > iMax) iState = iMax;    // omezeni I chyby
   if (iState < iMin) iState = iMin;
   iTerm = -iGain * iState;              // I slozka
   dTerm = -dGain * (dState - position); // D
   dState = position;
   PID_OutPWM = pTerm + iTerm + dTerm;
   if (PID_OutPWM > MAX_PWM) PID_OutPWM = MAX_PWM;
   if (PID_OutPWM < 0.0) PID_OutPWM = 0.0;
#ifdef PID_DEBUG
     UART1_Write_Text("  P="); FloatToStr(pTerm,_txtFLOAT); UART1_Write_Text(_txtFLOAT);
     UART1_Write_Text(" ,Istate="); IntToStr(iState, _txtU16); UART1_Write_Text(_txtU16);
     UART1_Write_Text(" ,I="); FloatToStr(iTerm,_txtFLOAT); UART1_Write_Text(_txtFLOAT);
     UART1_Write_Text(" ,D="); FloatToStr(dTerm,_txtFLOAT); UART1_Write_Text(_txtFLOAT);
#endif
  //Return calculated PWM output.
  return (u8)PID_OutPWM;
}

//===========================================================================

i16 CJ125_Calc_Ip(float Ua_mV, u8 Amplify) {  // funguje ok
  float Ip=0;                  // 8 nebo 17
  Ua_mV = Ua_mV / 1000.0;  // prevod na volty
  //Calculate pump current acc. to BOSCH LSU 4.9 Technical Product Information Y 258 E00 015e.
  Ip = (1000.0 * (Ua_mV - 1.5)) / (61.9 * Amplify);
  Ip *= 1000;  // prepocet kvuli nasledne lin. regresy, ktera hleda v i16 tabulce misto float
  return (i16)Ip; // vracime jen jako I16 - kvuli zrychleni
}