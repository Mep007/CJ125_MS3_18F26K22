
// YAT test 128bytes: SO=<LF>\!(Delay(10))\h(4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5 4F 22 23 4F 22 22 44 1F 44 11 22 55 22 11 44 F5)

 // LED_Welcome();
        //   AD_ch1 = Get_AD_mV(0,AD_CH1_KOEF);
        //   WordToStr(AD_ch1,_txtU16); UART1_Write_Text(_txtU16); CR_LF(1);
        //   intensity++; if (intensity > 14) { intensity = 0; }
        //   MAX7219SetIntensity(intensity);
     /*
         if ((!strncmp(RX_buf,"UA[mV]",4))) {  // CJ125 UA
             UART1_Write_Text("UA[mV]=");
             UA_mV = Get_AD_mV(UA_AD_ch,AD_KOEF);
             WordToStr(UA_mV,_txtU16); UART1_Write_Text(_txtU16); UART1_Write_Text(" [mV] - RAW:");
             MAX7219_PrintAFR(UA_mV,0);
             WordToStr(ADC_RAW,_txtU16); UART1_Write_Text(_txtU16); UART1_Write_Text(" [mV]");CR_LF(1);
          } // if !strncpy
          if ((!strncmp(RX_buf,"UR",4))) {  // CJ125 UR
             UART1_Write_Text("UR=[mV]");
             UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);
             WordToStr(UR_mV,_txtU16); UART1_Write_Text(_txtU16); UART1_Write_Text(" [mV]");CR_LF(1);
             MAX7219_PrintAFR(UR_mV,0);
          } // if !strncpy
          if ((!strncmp(RX_buf,"Vbat",4))) {  // Vbat
             UART1_Write_Text("AD4=");
             Vbat_mV = Get_AD_mV(Vbat_AD_ch,AD_VBAT_KOEF);
             WordToStr(Vbat_mV,_txtU16); UART1_Write_Text(_txtU16); UART1_Write_Text(" [mV]");CR_LF(1);
             MAX7219_PrintAFR(Vbat_mV,0);
          } // if !strncpy

         */
            /*  while(1) {
      for (i=0; i < 753; i++) {
      UART1_Write_Text(" "); FloatToStr(Lambda_Table[i],_txtFLOAT); UART1_Write_Text(_txtFLOAT);CR_LF(1);
      Delay_ms(50);
      }
        /*    UART1_Write_Text(" "); ByteToStr((u8)Heat_PWM, _txtU8); UART1_Write_Text(_txtU8);
      if (BUT0) { PWM4_Set_Duty(1);  UART1_Write_Text("PID EMERGENCY SHUTDOWN"); CR_LF(1); while(1); }
    */
 /*
 AFR= 2002 MAP=    0 Vbat=13205 UA= 2200 UR=  877

 AFR= 2002 MAP=    0 Vbat=13960 UA= 2195 UR=  877

 AFR= 2002 MAP=    0 Vbat=13582 UA= 2195 UR=  877

 AFR= 2002 MAP=    0 Vbat=13636 UA= 2195 UR=  877

 AFR= 2002 MAP=    0 Vbat=13636 UA= 2195 UR=  877

 AFR= 2002 MAP=    0 Vbat=13636 UA= 2195 UR=  877

   */
   
   /*#ifdef LSU42
  #define PreHeat_Level        500      // uroven, na kterou se topi v kondenzacni fazi (1000 ~ 0.3A(cca 3.2VRMS), 500~PWM=10~2.0V RMS,I=0.15A)
  #define RampHeatInit_PWM    5000     // uroven v mC, od ktere zaciname zvysovat rampu po fazi - 6000 ~ cca 7.5V RMS
  #define HEAT_MAX             225      // max. strida pro topeni 0-255 (0-100% PWM)
  #define HEAT_STEP              4      // o kolik se pridava PWM pri zahrivani
  #define HEAT_RAMP_DELAY      250      // interval zvysovani stridy v [ms]
  #define PID_PWM_0             80      // pocatecni uroven stridy pri zacatku PID regulace (cca odpovida ustatele hodnote PWM pri sonde mimo vyfuk)
#endif
#ifdef LSU49
  #define PreHeat_Level        450      // uroven, na kterou se topi v kondenzacni fazi (1000 ~ 0.3A(cca 3.2VRMS), 500~PWM=10~2.0V RMS,I=0.15A)
  #define RampHeatInit_PWM    4000     // uroven v mC, od ktere zaciname zvysovat rampu po fazi - 6000 ~ cca 7.5V RMS
  #define HEAT_MAX             170     // 160 bylo ok, max. strida pro topeni 0-255 (0-100% PWM)
  #define HEAT_STEP              4      // o kolik se pridava PWM pri zahrivani
  #define HEAT_RAMP_DELAY      300      // 350 bylo - interval zvysovani stridy v [ms]
  #define PID_PWM_0             80      // pocatecni uroven stridy pri zacatku PID regulace (cca odpovida ustatele hodnote PWM pri sonde mimo vyfuk)
#endif

 // PUVODNI IRQ1 pro UART1
  if (RC1IF_bit && RC1IE_bit){ // UART1 IRQ  - ceka na prikaz ukonceny d10
    LED2 = 1;
    RX_FLAG = 1;   // v pripade chyby se nize priznak nuluje
    if (RX_Normal==1) {
      while((tmp != 10) && (RX_cnt < RX_TIMEOUT)) {  //max (RX_BUF_LEN-1) znaku a timeout 100ms + ukoncuje znak d10
        if(RC1IF_bit) { // neco je ve FIFO ?, max 6 znaku celkem muze prijit + ukoncovaci - RCIF JE JEN PRO CTENI !! KDYZ 1 je neco ve FIFO
          if (FERR1_bit || OERR1_bit) { SPEN1_bit = TXEN1_bit = CREN1_bit = 0; SPEN1_bit = TXEN1_bit = CREN1_bit = 1; } // framing error, proto resetujeme UART
          tmp = RC1REG;  //S/ cteme FIFO
          if (tmp > 31) {  // ukladame jen tisknutelne znaky
            if (i<(RX_BUF_LEN-1)) { RX_buf[i] = tmp; i++; }  // (10-1)je misto v RX bufferu ?
            else                  { RX_FLAG = 0; }   // ...neni, presto jsou dalsi znaky na UARTU, vycteme je, ale zahodime - chyba
          }// if tmp > 31
        }// if (RC1IF)
        RX_cnt++;
        Delay_us(5);
      } // while
      RX_buf[i] = 0x00;  // ukonceni stringu v poli za poslednim znakem prikazu
      if ((RX_cnt >= RX_TIMEOUT) || !RX_FLAG) {  // NEprijali jsme validni data - spravna delka nebo timeout
        UART1_FIX_ERR
        while (RC1IF_bit) { RX_buf[i] = RC1REG; Delay_us(10); }   // jen vycitame data, dokud jsou,      // NEZKOUSENO ? ale u UART2 je to OK
        for(i=0; i < RX_BUF_LEN;i++) RX_buf[i] = 0;  // neukonceny prikaz, mazeme buffer
        RX_FLAG = 0;
      } // if RX_cnt
      LED2 = 0;
      return;
    } // if RX_Normal == 1

    else if (RX_Normal == 0) { // cekame na 128bytes binarnich dat
      RX_FLAG = RX_cnt = 0;
      i=1; RX_BUF64_cnt=0;
      RC1IE_bit = 0; // IRQ OFF
      while((RX_BUF64_cnt < RX_FLASH_BUF_LEN) && (RX_cnt < RX_TIMEOUT)) {  //max (RX_BUF_LEN-1) znaku a timeout 100ms + ukoncuje znak d10
        if(RC1IF_bit) { // nova data ?
          UART1_FIX_ERR
          if      (i==1) { i=2; u8TMP = RCREG1; }  // 1. byte - MSB
          else if (i==2) {
            i=1;                    // 2. byte - LSB => 1x U16
            U16_tmp = u8TMP << 8;
            u8TMP = RC1REG;
            U16_tmp += u8TMP;
            Flash_Buf64[RX_BUF64_cnt] = U16_tmp;
            RX_BUF64_cnt++;      //az zde po 2 bytech (1x u16) zvetsime
          } // else if
        } // if (RCIF
        Delay_us(10);
        RX_cnt++;    // kvuli timeoutu
      } // while (( RX_BUF
      RX_Normal = 2; // koncime s priznakem
    }  // else if (RX_Normal == 0

    else {    // prislo neco, co nechceme, vycistime
      while (RC1IF_bit) {  // vycistime FIFO
        UART1_FIX_ERR
        tmp = RC1REG;
      } // while (RCIF
      RX_FLAG = 0;
    } // else
  } // if RCIF
 
 
 */
 
 
 