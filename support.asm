
_UART_PrintCh:

;support.c,4 :: 		void UART_PrintCh(u8 Nr, char ch) {
;support.c,5 :: 		if (Nr == 1) {
	MOVF        FARG_UART_PrintCh_Nr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_PrintCh0
;support.c,6 :: 		TXREG1 = ch;
	MOVF        FARG_UART_PrintCh_ch+0, 0 
	MOVWF       TXREG1+0 
;support.c,7 :: 		asm { nop };
	NOP
;support.c,8 :: 		while (!TX1STA.B1);       //  while (!TX1IF_bit);  //    while (!TX1STA.B1);    // TRMT1_bit at TX1STA.B1;    // cekame pokud je odesilaci bufer plny(=0), (1 = empty)
L_UART_PrintCh1:
	BTFSC       TX1STA+0, 1 
	GOTO        L_UART_PrintCh2
	GOTO        L_UART_PrintCh1
L_UART_PrintCh2:
;support.c,9 :: 		} //if
	GOTO        L_UART_PrintCh3
L_UART_PrintCh0:
;support.c,10 :: 		else if (Nr == 2) {
	MOVF        FARG_UART_PrintCh_Nr+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_PrintCh4
;support.c,11 :: 		TXREG2 = ch;
	MOVF        FARG_UART_PrintCh_ch+0, 0 
	MOVWF       TXREG2+0 
;support.c,12 :: 		asm { nop };
	NOP
;support.c,13 :: 		while (!TX2STA.B1);
L_UART_PrintCh5:
	BTFSC       TX2STA+0, 1 
	GOTO        L_UART_PrintCh6
	GOTO        L_UART_PrintCh5
L_UART_PrintCh6:
;support.c,14 :: 		} // else if
L_UART_PrintCh4:
L_UART_PrintCh3:
;support.c,15 :: 		}
L_end_UART_PrintCh:
	RETURN      0
; end of _UART_PrintCh

_PrintF1:

;support.c,17 :: 		void PrintF1( char *p_string )
;support.c,20 :: 		n = 0;
	CLRF        R0 
;support.c,21 :: 		while( p_string[n]) /*!= 0*/ {              // Check for end of string
L_PrintF17:
	MOVF        R0, 0 
	ADDWF       FARG_PrintF1_p_string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PrintF1_p_string+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_PrintF18
;support.c,22 :: 		while (!TRMT_TX1STA_bit);   // cekame pokud je odesilaci bufer plny
L_PrintF19:
	BTFSC       TRMT_TX1STA_bit+0, BitPos(TRMT_TX1STA_bit+0) 
	GOTO        L_PrintF110
	GOTO        L_PrintF19
L_PrintF110:
;support.c,23 :: 		TXREG1 = p_string[n++];
	MOVF        R0, 0 
	ADDWF       FARG_PrintF1_p_string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PrintF1_p_string+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG1+0 
	INCF        R0, 1 
;support.c,25 :: 		}
	GOTO        L_PrintF17
L_PrintF18:
;support.c,26 :: 		}
L_end_PrintF1:
	RETURN      0
; end of _PrintF1

_HC06_SendByteBuf:

;support.c,29 :: 		void HC06_SendByteBuf(u8 pBuf[], u8 BufLen) {  // vyzkouseno i 255Bytes pri 115k2
;support.c,30 :: 		u8 n=0;         // mobil vycital bezproblemu pri 200ms opakovani (tzn. 5x255 bytes za 1s)
	CLRF        HC06_SendByteBuf_n_L0+0 
;support.c,31 :: 		while(BufLen--) {              // Check for end of string
L_HC06_SendByteBuf11:
	MOVF        FARG_HC06_SendByteBuf_BufLen+0, 0 
	MOVWF       R0 
	DECF        FARG_HC06_SendByteBuf_BufLen+0, 1 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HC06_SendByteBuf12
;support.c,32 :: 		TXREG2 = pBuf[n++];
	MOVF        HC06_SendByteBuf_n_L0+0, 0 
	ADDWF       FARG_HC06_SendByteBuf_pBuf+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_HC06_SendByteBuf_pBuf+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG2+0 
	INCF        HC06_SendByteBuf_n_L0+0, 1 
;support.c,33 :: 		asm { nop };
	NOP
;support.c,34 :: 		while (!TX2STA.B1);
L_HC06_SendByteBuf13:
	BTFSC       TX2STA+0, 1 
	GOTO        L_HC06_SendByteBuf14
	GOTO        L_HC06_SendByteBuf13
L_HC06_SendByteBuf14:
;support.c,35 :: 		}
	GOTO        L_HC06_SendByteBuf11
L_HC06_SendByteBuf12:
;support.c,36 :: 		}
L_end_HC06_SendByteBuf:
	RETURN      0
; end of _HC06_SendByteBuf

_UART_PrintTxt:

;support.c,39 :: 		void UART_PrintTxt(char UR_nr,char *p_string){
;support.c,40 :: 		while(*p_string > 31) { // dokud jsou tisknutelne znaky, piseme...
L_UART_PrintTxt15:
	MOVFF       FARG_UART_PrintTxt_p_string+0, FSR0L+0
	MOVFF       FARG_UART_PrintTxt_p_string+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_UART_PrintTxt16
;support.c,41 :: 		if      (UR_nr == 1) {
	MOVF        FARG_UART_PrintTxt_UR_nr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_PrintTxt17
;support.c,42 :: 		TXREG1 = *(p_string++); while (!TX1STA.B1); }      //  while (!TX1IF_bit);  //    while (!TX1STA.B1);    // TRMT1_bit at TX1STA.B1;    // cekame pokud je odesilaci bufer plny(=0), (1 = empty)
	MOVFF       FARG_UART_PrintTxt_p_string+0, FSR0L+0
	MOVFF       FARG_UART_PrintTxt_p_string+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG1+0 
	INFSNZ      FARG_UART_PrintTxt_p_string+0, 1 
	INCF        FARG_UART_PrintTxt_p_string+1, 1 
L_UART_PrintTxt18:
	BTFSC       TX1STA+0, 1 
	GOTO        L_UART_PrintTxt19
	GOTO        L_UART_PrintTxt18
L_UART_PrintTxt19:
	GOTO        L_UART_PrintTxt20
L_UART_PrintTxt17:
;support.c,43 :: 		else if (UR_nr == 2) {
	MOVF        FARG_UART_PrintTxt_UR_nr+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_PrintTxt21
;support.c,44 :: 		TXREG2 = *(p_string++); while (!TX2STA.B1); }
	MOVFF       FARG_UART_PrintTxt_p_string+0, FSR0L+0
	MOVFF       FARG_UART_PrintTxt_p_string+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       TXREG2+0 
	INFSNZ      FARG_UART_PrintTxt_p_string+0, 1 
	INCF        FARG_UART_PrintTxt_p_string+1, 1 
L_UART_PrintTxt22:
	BTFSC       TX2STA+0, 1 
	GOTO        L_UART_PrintTxt23
	GOTO        L_UART_PrintTxt22
L_UART_PrintTxt23:
L_UART_PrintTxt21:
L_UART_PrintTxt20:
;support.c,45 :: 		} // while
	GOTO        L_UART_PrintTxt15
L_UART_PrintTxt16:
;support.c,46 :: 		}
L_end_UART_PrintTxt:
	RETURN      0
; end of _UART_PrintTxt

_PWM_Init_DAC1:

;support.c,49 :: 		void PWM_Init_DAC1(u16 mVout) {   // RB5 - CCP3 PWM - Timer 4 - 15.625kHz@10bit pro 16Mhz, 31.25k pro 32Mhz @ 10bit
;support.c,50 :: 		CCP3CON  = 0b00001100;   // PWM mode for CCP3
	MOVLW       12
	MOVWF       CCP3CON+0 
;support.c,51 :: 		C3TSEL0_bit = 0; C3TSEL0_bit = 1;  // Timer4 for CCP3
	BCF         C3TSEL0_bit+0, BitPos(C3TSEL0_bit+0) 
	BSF         C3TSEL0_bit+0, BitPos(C3TSEL0_bit+0) 
;support.c,52 :: 		PR4  = 0xFF;    // max F_pwm
	MOVLW       255
	MOVWF       PR4+0 
;support.c,53 :: 		TMR4ON_bit = 1; // start timeru 4
	BSF         TMR4ON_bit+0, BitPos(TMR4ON_bit+0) 
;support.c,54 :: 		DACx_mV_Out_10bit(1,mVout); //CCPR3L = 23;   // defaultni napeti - 23 ~ 450mV
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        FARG_PWM_Init_DAC1_mVout+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        FARG_PWM_Init_DAC1_mVout+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;support.c,55 :: 		}
L_end_PWM_Init_DAC1:
	RETURN      0
; end of _PWM_Init_DAC1

_PWM_Init_DAC2:

;support.c,56 :: 		void PWM_Init_DAC2(u16 mVout) {   // RA4 - CCP5 PWM - Timer 4 - 20kHz
;support.c,57 :: 		CCP5CON  = 0b00001100;   // PWM mode for CCP5
	MOVLW       12
	MOVWF       CCP5CON+0 
;support.c,58 :: 		C5TSEL0_bit = 0; C5TSEL0_bit = 1;  // Timer 4 for CCP5
	BCF         C5TSEL0_bit+0, BitPos(C5TSEL0_bit+0) 
	BSF         C5TSEL0_bit+0, BitPos(C5TSEL0_bit+0) 
;support.c,59 :: 		PR4  = 0xFF;    // max F_pwm
	MOVLW       255
	MOVWF       PR4+0 
;support.c,60 :: 		TMR4ON_bit = 1; // start timeru 4
	BSF         TMR4ON_bit+0, BitPos(TMR4ON_bit+0) 
;support.c,61 :: 		DACx_mV_Out_10bit(2,mVout);  //  CCPR5L = 128;   // defaultni napeti - 128 - 2.5V
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        FARG_PWM_Init_DAC2_mVout+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        FARG_PWM_Init_DAC2_mVout+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;support.c,62 :: 		}
L_end_PWM_Init_DAC2:
	RETURN      0
; end of _PWM_Init_DAC2

_DACx_mV_Out_10bit:

;support.c,65 :: 		u16 DACx_mV_Out_10bit(u8 ch, u16 OutmV) {// cca 420us@16Mhz  // nastavi napeti na DAC1 resp. DAC2 - 10bit / 15625Hz @ 16Mhz // vraci vysledny
;support.c,66 :: 		u16 PWM_raw=0;
	CLRF        DACx_mV_Out_10bit_PWM_raw_L0+0 
	CLRF        DACx_mV_Out_10bit_PWM_raw_L0+1 
;support.c,68 :: 		U32_tmp = (u32)OutmV * 100; // !!! POZOR, musi byt pretypovano na U32, jinak nefunguje !!!!
	MOVF        FARG_DACx_mV_Out_10bit_OutmV+0, 0 
	MOVWF       R0 
	MOVF        FARG_DACx_mV_Out_10bit_OutmV+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _U32_tmp+0 
	MOVF        R1, 0 
	MOVWF       _U32_tmp+1 
	MOVF        R2, 0 
	MOVWF       _U32_tmp+2 
	MOVF        R3, 0 
	MOVWF       _U32_tmp+3 
;support.c,69 :: 		U32_tmp =  U32_tmp / DAC_KOEF;  // koeficient 19.6mv ~ 1bit   //45000 / 489 = 92
	MOVF        _DAC_KOEF+0, 0 
	MOVWF       R4 
	MOVF        _DAC_KOEF+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _U32_tmp+0 
	MOVF        R1, 0 
	MOVWF       _U32_tmp+1 
	MOVF        R2, 0 
	MOVWF       _U32_tmp+2 
	MOVF        R3, 0 
	MOVWF       _U32_tmp+3 
;support.c,71 :: 		if (U32_tmp >= 1023) U32_tmp = 1023;
	MOVLW       0
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit66
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit66
	MOVLW       3
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit66
	MOVLW       255
	SUBWF       R0, 0 
L__DACx_mV_Out_10bit66:
	BTFSS       STATUS+0, 0 
	GOTO        L_DACx_mV_Out_10bit24
	MOVLW       255
	MOVWF       _U32_tmp+0 
	MOVLW       3
	MOVWF       _U32_tmp+1 
	MOVLW       0
	MOVWF       _U32_tmp+2 
	MOVWF       _U32_tmp+3 
L_DACx_mV_Out_10bit24:
;support.c,72 :: 		PWM_raw = (u16)U32_tmp;
	MOVF        _U32_tmp+0, 0 
	MOVWF       DACx_mV_Out_10bit_PWM_raw_L0+0 
	MOVF        _U32_tmp+1, 0 
	MOVWF       DACx_mV_Out_10bit_PWM_raw_L0+1 
;support.c,74 :: 		if (ch==1) {  //DAC 1
	MOVF        FARG_DACx_mV_Out_10bit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_DACx_mV_Out_10bit25
;support.c,76 :: 		if ((U32_tmp & 0b01) == 1) DC3B0_bit = 1;  // testujeme DCxB0
	MOVLW       1
	ANDWF       _U32_tmp+0, 0 
	MOVWF       R1 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R2 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R3 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	ANDWF       R4, 1 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit67
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit67
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit67
	MOVF        R1, 0 
	XORLW       1
L__DACx_mV_Out_10bit67:
	BTFSS       STATUS+0, 2 
	GOTO        L_DACx_mV_Out_10bit26
	BSF         DC3B0_bit+0, BitPos(DC3B0_bit+0) 
	GOTO        L_DACx_mV_Out_10bit27
L_DACx_mV_Out_10bit26:
;support.c,77 :: 		else                       DC3B0_bit = 0;
	BCF         DC3B0_bit+0, BitPos(DC3B0_bit+0) 
L_DACx_mV_Out_10bit27:
;support.c,78 :: 		if ((U32_tmp & 0b10) == 2) DC3B1_bit = 1;  // testujeme DCxB1
	MOVLW       2
	ANDWF       _U32_tmp+0, 0 
	MOVWF       R1 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R2 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R3 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	ANDWF       R4, 1 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit68
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit68
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit68
	MOVF        R1, 0 
	XORLW       2
L__DACx_mV_Out_10bit68:
	BTFSS       STATUS+0, 2 
	GOTO        L_DACx_mV_Out_10bit28
	BSF         DC3B1_bit+0, BitPos(DC3B1_bit+0) 
	GOTO        L_DACx_mV_Out_10bit29
L_DACx_mV_Out_10bit28:
;support.c,79 :: 		else                       DC3B1_bit = 0;
	BCF         DC3B1_bit+0, BitPos(DC3B1_bit+0) 
L_DACx_mV_Out_10bit29:
;support.c,80 :: 		U32_tmp >>=2;   // spodni dva bity mame a ted zbyvajicich vrchnich 8 (takze posuneme o 2 vpravo)
	MOVF        _U32_tmp+0, 0 
	MOVWF       R0 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R1 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R2 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _U32_tmp+0 
	MOVF        R1, 0 
	MOVWF       _U32_tmp+1 
	MOVF        R2, 0 
	MOVWF       _U32_tmp+2 
	MOVF        R3, 0 
	MOVWF       _U32_tmp+3 
;support.c,81 :: 		CCPR3L = (u8)U32_tmp;
	MOVF        R0, 0 
	MOVWF       CCPR3L+0 
;support.c,82 :: 		return PWM_raw;
	MOVF        DACx_mV_Out_10bit_PWM_raw_L0+0, 0 
	MOVWF       R0 
	MOVF        DACx_mV_Out_10bit_PWM_raw_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_DACx_mV_Out_10bit
;support.c,83 :: 		}
L_DACx_mV_Out_10bit25:
;support.c,84 :: 		else if (ch==2) {   //DAC 2
	MOVF        FARG_DACx_mV_Out_10bit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_DACx_mV_Out_10bit31
;support.c,86 :: 		if ((U32_tmp & 0b01) == 1) DC5B0_bit = 1;  // testujeme DCxB0
	MOVLW       1
	ANDWF       _U32_tmp+0, 0 
	MOVWF       R1 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R2 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R3 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	ANDWF       R4, 1 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit69
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit69
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit69
	MOVF        R1, 0 
	XORLW       1
L__DACx_mV_Out_10bit69:
	BTFSS       STATUS+0, 2 
	GOTO        L_DACx_mV_Out_10bit32
	BSF         DC5B0_bit+0, BitPos(DC5B0_bit+0) 
	GOTO        L_DACx_mV_Out_10bit33
L_DACx_mV_Out_10bit32:
;support.c,87 :: 		else                       DC5B0_bit = 0;
	BCF         DC5B0_bit+0, BitPos(DC5B0_bit+0) 
L_DACx_mV_Out_10bit33:
;support.c,88 :: 		if ((U32_tmp & 0b10) == 2) DC5B1_bit = 1;  // testujeme DCxB1
	MOVLW       2
	ANDWF       _U32_tmp+0, 0 
	MOVWF       R1 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R2 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R3 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R2, 1 
	ANDWF       R3, 1 
	ANDWF       R4, 1 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit70
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit70
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_mV_Out_10bit70
	MOVF        R1, 0 
	XORLW       2
L__DACx_mV_Out_10bit70:
	BTFSS       STATUS+0, 2 
	GOTO        L_DACx_mV_Out_10bit34
	BSF         DC5B1_bit+0, BitPos(DC5B1_bit+0) 
	GOTO        L_DACx_mV_Out_10bit35
L_DACx_mV_Out_10bit34:
;support.c,89 :: 		else                       DC5B1_bit = 0;
	BCF         DC5B1_bit+0, BitPos(DC5B1_bit+0) 
L_DACx_mV_Out_10bit35:
;support.c,90 :: 		U32_tmp >>=2;   // spodni dva bity mame a ted zbyvajicich vrchnich 8 (takze posuneme o 2 vpravo)
	MOVF        _U32_tmp+0, 0 
	MOVWF       R0 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R1 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R2 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	MOVF        R0, 0 
	MOVWF       _U32_tmp+0 
	MOVF        R1, 0 
	MOVWF       _U32_tmp+1 
	MOVF        R2, 0 
	MOVWF       _U32_tmp+2 
	MOVF        R3, 0 
	MOVWF       _U32_tmp+3 
;support.c,91 :: 		CCPR5L = (u8)U32_tmp;
	MOVF        R0, 0 
	MOVWF       CCPR5L+0 
;support.c,92 :: 		return PWM_raw;
	MOVF        DACx_mV_Out_10bit_PWM_raw_L0+0, 0 
	MOVWF       R0 
	MOVF        DACx_mV_Out_10bit_PWM_raw_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_DACx_mV_Out_10bit
;support.c,93 :: 		}
L_DACx_mV_Out_10bit31:
;support.c,94 :: 		}
L_end_DACx_mV_Out_10bit:
	RETURN      0
; end of _DACx_mV_Out_10bit

_LinFit:

;support.c,96 :: 		u16 LinFit(i16 X,i16 pTab[], u8 Tab_size) {  // cca xxx us@16Mhz pomoci lin. aproximace hledame z 1D tabulky Y pro zadane X (misto 2D tabulky)
;support.c,97 :: 		i32 X_k1=0,Y_k1=0,X_k=0,Y_k=0,Y=0,Xmin=0,Xmax=0;    //   1D_Array[2*8] = { 0, 250, 500, 255, 565 ,5656, 5856, 800,    - X [mA]*1000
	CLRF        LinFit_X_k1_L0+0 
	CLRF        LinFit_X_k1_L0+1 
	CLRF        LinFit_X_k1_L0+2 
	CLRF        LinFit_X_k1_L0+3 
	CLRF        LinFit_Y_k1_L0+0 
	CLRF        LinFit_Y_k1_L0+1 
	CLRF        LinFit_Y_k1_L0+2 
	CLRF        LinFit_Y_k1_L0+3 
	CLRF        LinFit_X_k_L0+0 
	CLRF        LinFit_X_k_L0+1 
	CLRF        LinFit_X_k_L0+2 
	CLRF        LinFit_X_k_L0+3 
	CLRF        LinFit_Y_k_L0+0 
	CLRF        LinFit_Y_k_L0+1 
	CLRF        LinFit_Y_k_L0+2 
	CLRF        LinFit_Y_k_L0+3 
	CLRF        LinFit_Xmin_L0+0 
	CLRF        LinFit_Xmin_L0+1 
	CLRF        LinFit_Xmin_L0+2 
	CLRF        LinFit_Xmin_L0+3 
	CLRF        LinFit_Xmax_L0+0 
	CLRF        LinFit_Xmax_L0+1 
	CLRF        LinFit_Xmax_L0+2 
	CLRF        LinFit_Xmax_L0+3 
	CLRF        LinFit_id_L0+0 
;support.c,100 :: 		Xmin = pTab[0];
	MOVFF       FARG_LinFit_pTab+0, FSR0L+0
	MOVFF       FARG_LinFit_pTab+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Xmin_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Xmin_L0+1 
	MOVLW       0
	BTFSC       LinFit_Xmin_L0+3, 7 
	MOVLW       255
	MOVWF       LinFit_Xmin_L0+2 
	MOVWF       LinFit_Xmin_L0+3 
	MOVLW       0
	BTFSC       LinFit_Xmin_L0+1, 7 
	MOVLW       255
	MOVWF       LinFit_Xmin_L0+2 
	MOVWF       LinFit_Xmin_L0+3 
;support.c,101 :: 		Xmax = pTab[Tab_size-1]; //    UART1_Write_Text("X = "); IntToStr(X,_txtU16);  UART1_Write_Text(_txtU16);  //  UART1_Write_Text(" Xmin = "); IntToStr(Xmin,_txtU16);  UART1_Write_Text(_txtU16);
	DECF        FARG_LinFit_Tab_size+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Xmax_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Xmax_L0+1 
	MOVLW       0
	BTFSC       LinFit_Xmax_L0+3, 7 
	MOVLW       255
	MOVWF       LinFit_Xmax_L0+2 
	MOVWF       LinFit_Xmax_L0+3 
	MOVLW       0
	BTFSC       LinFit_Xmax_L0+1, 7 
	MOVLW       255
	MOVWF       LinFit_Xmax_L0+2 
	MOVWF       LinFit_Xmax_L0+3 
;support.c,102 :: 		if (X <= Xmin)      { return pTab[Tab_size]; }        // - krajni hodnoty - pro Y se posuneme o Tab_size na zactek druheho radku
	MOVLW       128
	XORWF       LinFit_Xmin_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit72
	MOVLW       0
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       255
	SUBWF       LinFit_Xmin_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit72
	MOVF        FARG_LinFit_X+1, 0 
	SUBWF       LinFit_Xmin_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit72
	MOVF        FARG_LinFit_X+0, 0 
	SUBWF       LinFit_Xmin_L0+0, 0 
L__LinFit72:
	BTFSS       STATUS+0, 0 
	GOTO        L_LinFit36
	MOVF        FARG_LinFit_Tab_size+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	GOTO        L_end_LinFit
L_LinFit36:
;support.c,103 :: 		else if (X >= Xmax) { return (i16)pTab[(Tab_size+Tab_size)-1]; } // X posledni = 8-1 a k nemu y je o 8 dal => id=15
	MOVLW       128
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       LinFit_Xmax_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit73
	MOVLW       0
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        LinFit_Xmax_L0+2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit73
	MOVF        LinFit_Xmax_L0+1, 0 
	SUBWF       FARG_LinFit_X+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit73
	MOVF        LinFit_Xmax_L0+0, 0 
	SUBWF       FARG_LinFit_X+0, 0 
L__LinFit73:
	BTFSS       STATUS+0, 0 
	GOTO        L_LinFit38
	MOVF        FARG_LinFit_Tab_size+0, 0 
	ADDWF       FARG_LinFit_Tab_size+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       1
	SUBWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      R1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	GOTO        L_end_LinFit
L_LinFit38:
;support.c,105 :: 		do {  // hledame v tabulce prvni X vyssi nez hledane (vstupni) X
L_LinFit39:
;support.c,106 :: 		X_k1 =  pTab[id];  // hledame vyssi X jen v prvnim radku (tzn 0 az Tab_size-1) -
	MOVF        LinFit_id_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_X_k1_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_X_k1_L0+1 
	MOVLW       0
	BTFSC       LinFit_X_k1_L0+3, 7 
	MOVLW       255
	MOVWF       LinFit_X_k1_L0+2 
	MOVWF       LinFit_X_k1_L0+3 
	MOVLW       0
	BTFSC       LinFit_X_k1_L0+1, 7 
	MOVLW       255
	MOVWF       LinFit_X_k1_L0+2 
	MOVWF       LinFit_X_k1_L0+3 
;support.c,107 :: 		if (X_k1 == X) return (i16)pTab[id + Tab_size];  // nasli jsme primo hondotu v tabulce - pro ziskani Y se musime posunout do druheho radku o TAB_size
	MOVLW       0
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       255
	MOVWF       R0 
	XORWF       LinFit_X_k1_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit74
	MOVF        R0, 0 
	XORWF       LinFit_X_k1_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit74
	MOVF        FARG_LinFit_X+1, 0 
	XORWF       LinFit_X_k1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit74
	MOVF        LinFit_X_k1_L0+0, 0 
	XORWF       FARG_LinFit_X+0, 0 
L__LinFit74:
	BTFSS       STATUS+0, 2 
	GOTO        L_LinFit42
	MOVF        FARG_LinFit_Tab_size+0, 0 
	ADDWF       LinFit_id_L0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	GOTO        L_end_LinFit
L_LinFit42:
;support.c,108 :: 		if (X_k1 > X) {  // nasli sme X vetsi nez hledane -> mame tudiz X_k1 a Y_k1
	MOVLW       128
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       LinFit_X_k1_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit75
	MOVLW       0
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        LinFit_X_k1_L0+2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit75
	MOVF        LinFit_X_k1_L0+1, 0 
	SUBWF       FARG_LinFit_X+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LinFit75
	MOVF        LinFit_X_k1_L0+0, 0 
	SUBWF       FARG_LinFit_X+0, 0 
L__LinFit75:
	BTFSC       STATUS+0, 0 
	GOTO        L_LinFit43
;support.c,109 :: 		Y_k1 = pTab[Tab_size+id];     // UART1_Write_Text(" X_k1 = "); IntToStr(X_k1,_txtU16);  UART1_Write_Text(_txtU16); UART1_Write_Text(" Y_k1 = "); IntToStr(Y_k1,_txtU16);  UART1_Write_Text(_txtU16);
	MOVF        LinFit_id_L0+0, 0 
	ADDWF       FARG_LinFit_Tab_size+0, 0 
	MOVWF       R5 
	CLRF        R6 
	MOVLW       0
	ADDWFC      R6, 1 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Y_k1_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Y_k1_L0+1 
	MOVLW       0
	BTFSC       LinFit_Y_k1_L0+3, 7 
	MOVLW       255
	MOVWF       LinFit_Y_k1_L0+2 
	MOVWF       LinFit_Y_k1_L0+3 
	MOVLW       0
	BTFSC       LinFit_Y_k1_L0+1, 7 
	MOVLW       255
	MOVWF       LinFit_Y_k1_L0+2 
	MOVWF       LinFit_Y_k1_L0+3 
;support.c,110 :: 		X_k  = pTab[id-1]; // Xk je pred Xk1 tzn. -1
	DECF        LinFit_id_L0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_X_k_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_X_k_L0+1 
	MOVLW       0
	BTFSC       LinFit_X_k_L0+3, 7 
	MOVLW       255
	MOVWF       LinFit_X_k_L0+2 
	MOVWF       LinFit_X_k_L0+3 
	MOVLW       0
	BTFSC       LinFit_X_k_L0+1, 7 
	MOVLW       255
	MOVWF       LinFit_X_k_L0+2 
	MOVWF       LinFit_X_k_L0+3 
;support.c,111 :: 		Y_k  = pTab[(id+Tab_size)-1]; //    //  UART1_Write_Text(" X_k = "); IntToStr(X_k,_txtU16);  UART1_Write_Text(_txtU16); UART1_Write_Text(" Y_k = "); IntToStr(Y_k,_txtU16);  UART1_Write_Text(_txtU16);
	MOVLW       1
	SUBWF       R5, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      R6, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LinFit_pTab+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LinFit_pTab+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Y_k_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       LinFit_Y_k_L0+1 
	MOVLW       0
	BTFSC       LinFit_Y_k_L0+3, 7 
	MOVLW       255
	MOVWF       LinFit_Y_k_L0+2 
	MOVWF       LinFit_Y_k_L0+3 
	MOVLW       0
	BTFSC       LinFit_Y_k_L0+1, 7 
	MOVLW       255
	MOVWF       LinFit_Y_k_L0+2 
	MOVWF       LinFit_Y_k_L0+3 
;support.c,112 :: 		Y = (Y_k * (X - X_k1) - Y_k1 * (X - X_k)) / (X_k - X_k1) ;  // a zde spocitame aproximaci z dat z atbulky hledane Y
	MOVF        FARG_LinFit_X+0, 0 
	MOVWF       R0 
	MOVF        FARG_LinFit_X+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        LinFit_X_k1_L0+0, 0 
	SUBWF       R0, 1 
	MOVF        LinFit_X_k1_L0+1, 0 
	SUBWFB      R1, 1 
	MOVF        LinFit_X_k1_L0+2, 0 
	SUBWFB      R2, 1 
	MOVF        LinFit_X_k1_L0+3, 0 
	SUBWFB      R3, 1 
	MOVF        LinFit_Y_k_L0+0, 0 
	MOVWF       R4 
	MOVF        LinFit_Y_k_L0+1, 0 
	MOVWF       R5 
	MOVF        LinFit_Y_k_L0+2, 0 
	MOVWF       R6 
	MOVF        LinFit_Y_k_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LinFit+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LinFit+1 
	MOVF        R2, 0 
	MOVWF       FLOC__LinFit+2 
	MOVF        R3, 0 
	MOVWF       FLOC__LinFit+3 
	MOVF        FARG_LinFit_X+0, 0 
	MOVWF       R0 
	MOVF        FARG_LinFit_X+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       FARG_LinFit_X+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        LinFit_X_k_L0+0, 0 
	SUBWF       R0, 1 
	MOVF        LinFit_X_k_L0+1, 0 
	SUBWFB      R1, 1 
	MOVF        LinFit_X_k_L0+2, 0 
	SUBWFB      R2, 1 
	MOVF        LinFit_X_k_L0+3, 0 
	SUBWFB      R3, 1 
	MOVF        LinFit_Y_k1_L0+0, 0 
	MOVWF       R4 
	MOVF        LinFit_Y_k1_L0+1, 0 
	MOVWF       R5 
	MOVF        LinFit_Y_k1_L0+2, 0 
	MOVWF       R6 
	MOVF        LinFit_Y_k1_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        FLOC__LinFit+0, 0 
	MOVWF       R8 
	MOVF        FLOC__LinFit+1, 0 
	MOVWF       R9 
	MOVF        FLOC__LinFit+2, 0 
	MOVWF       R10 
	MOVF        FLOC__LinFit+3, 0 
	MOVWF       R11 
	MOVF        R0, 0 
	SUBWF       R8, 1 
	MOVF        R1, 0 
	SUBWFB      R9, 1 
	MOVF        R2, 0 
	SUBWFB      R10, 1 
	MOVF        R3, 0 
	SUBWFB      R11, 1 
	MOVF        LinFit_X_k_L0+0, 0 
	MOVWF       R4 
	MOVF        LinFit_X_k_L0+1, 0 
	MOVWF       R5 
	MOVF        LinFit_X_k_L0+2, 0 
	MOVWF       R6 
	MOVF        LinFit_X_k_L0+3, 0 
	MOVWF       R7 
	MOVF        LinFit_X_k1_L0+0, 0 
	SUBWF       R4, 1 
	MOVF        LinFit_X_k1_L0+1, 0 
	SUBWFB      R5, 1 
	MOVF        LinFit_X_k1_L0+2, 0 
	SUBWFB      R6, 1 
	MOVF        LinFit_X_k1_L0+3, 0 
	SUBWFB      R7, 1 
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
;support.c,114 :: 		return (u16)Y; // vrcime spocitane Y a koncime
	GOTO        L_end_LinFit
;support.c,115 :: 		}
L_LinFit43:
;support.c,116 :: 		id++;
	INCF        LinFit_id_L0+0, 1 
;support.c,117 :: 		} while (id < Tab_size);
	MOVF        FARG_LinFit_Tab_size+0, 0 
	SUBWF       LinFit_id_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_LinFit39
;support.c,124 :: 		*/ return 0; // (u16)Y; // vrcime spocitane Y a koncime
	CLRF        R0 
	CLRF        R1 
;support.c,125 :: 		}
L_end_LinFit:
	RETURN      0
; end of _LinFit

_BT_Send_Data:

;support.c,127 :: 		void BT_Send_Data(u16 TxData) {
;support.c,128 :: 		u16 TX=0,tmp=0;
	CLRF        BT_Send_Data_TX_L0+0 
	CLRF        BT_Send_Data_TX_L0+1 
;support.c,129 :: 		TX = TxData / 10; // 1475 / 10 = 147
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_BT_Send_Data_TxData+0, 0 
	MOVWF       R0 
	MOVF        FARG_BT_Send_Data_TxData+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       BT_Send_Data_TX_L0+0 
	MOVF        R1, 0 
	MOVWF       BT_Send_Data_TX_L0+1 
;support.c,130 :: 		tmp = TxData % 10;  // 1475 % 100 = 5
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_BT_Send_Data_TxData+0, 0 
	MOVWF       R0 
	MOVF        FARG_BT_Send_Data_TxData+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
;support.c,131 :: 		if (tmp >= 5) TX++;
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BT_Send_Data77
	MOVLW       5
	SUBWF       R0, 0 
L__BT_Send_Data77:
	BTFSS       STATUS+0, 0 
	GOTO        L_BT_Send_Data44
	INFSNZ      BT_Send_Data_TX_L0+0, 1 
	INCF        BT_Send_Data_TX_L0+1, 1 
L_BT_Send_Data44:
;support.c,132 :: 		TXREG2 = TX; while(!TX2STA.B1);  //UART2_Write(TX);   // binarne posleme 1byte AFR napr. 1475 => 148
	MOVF        BT_Send_Data_TX_L0+0, 0 
	MOVWF       TXREG2+0 
L_BT_Send_Data45:
	BTFSC       TX2STA+0, 1 
	GOTO        L_BT_Send_Data46
	GOTO        L_BT_Send_Data45
L_BT_Send_Data46:
;support.c,133 :: 		}
L_end_BT_Send_Data:
	RETURN      0
; end of _BT_Send_Data

_TxtToU16:

;support.c,136 :: 		u16 TxtToU16(char *Buf) { // prevede ASCII cislo z TXT buferu za znakem '=' - max. 9999 na u16
;support.c,137 :: 		u16 res=0;
	CLRF        TxtToU16_res_L0+0 
	CLRF        TxtToU16_res_L0+1 
	CLRF        TxtToU16_i_L0+0 
;support.c,141 :: 		pNu = strstr(Buf,"=");
	MOVF        FARG_TxtToU16_Buf+0, 0 
	MOVWF       FARG_strstr_s1+0 
	MOVF        FARG_TxtToU16_Buf+1, 0 
	MOVWF       FARG_strstr_s1+1 
	MOVLW       ?lstr1_support+0
	MOVWF       FARG_strstr_s2+0 
	MOVLW       hi_addr(?lstr1_support+0)
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVF        R0, 0 
	MOVWF       TxtToU16_pNu_L0+0 
	MOVF        R1, 0 
	MOVWF       TxtToU16_pNu_L0+1 
;support.c,142 :: 		pNu++;
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       TxtToU16_pNu_L0+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       TxtToU16_pNu_L0+1 
;support.c,143 :: 		while ((*pNu > 47) && (*pNu < 58) && (i < 4)) {  // znaky 0 - 9 a cislo max. na 3 mista (9999 max)
L_TxtToU1647:
	MOVFF       TxtToU16_pNu_L0+0, FSR0L+0
	MOVFF       TxtToU16_pNu_L0+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	SUBLW       47
	BTFSC       STATUS+0, 0 
	GOTO        L_TxtToU1648
	MOVFF       TxtToU16_pNu_L0+0, FSR0L+0
	MOVFF       TxtToU16_pNu_L0+1, FSR0H+0
	MOVLW       58
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TxtToU1648
	MOVLW       4
	SUBWF       TxtToU16_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TxtToU1648
L__TxtToU1658:
;support.c,144 :: 		numBuf[i++] = *pNu - 48;  // prevedeme na cislici 0-9
	MOVLW       TxtToU16_numBuf_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(TxtToU16_numBuf_L0+0)
	MOVWF       FSR1L+1 
	MOVF        TxtToU16_i_L0+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVFF       TxtToU16_pNu_L0+0, FSR0L+0
	MOVFF       TxtToU16_pNu_L0+1, FSR0H+0
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        TxtToU16_i_L0+0, 1 
;support.c,145 :: 		pNu++;  // pointer posuneme dal
	INFSNZ      TxtToU16_pNu_L0+0, 1 
	INCF        TxtToU16_pNu_L0+1, 1 
;support.c,146 :: 		}
	GOTO        L_TxtToU1647
L_TxtToU1648:
;support.c,147 :: 		if (i == 0) return res=0;
	MOVF        TxtToU16_i_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TxtToU1651
	CLRF        TxtToU16_res_L0+0 
	CLRF        TxtToU16_res_L0+1 
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_TxtToU16
L_TxtToU1651:
;support.c,148 :: 		i--;
	DECF        TxtToU16_i_L0+0, 1 
;support.c,149 :: 		if (i == 3) {  //napr 6 , 5 , 4 , 8
	MOVF        TxtToU16_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_TxtToU1652
;support.c,150 :: 		res  = (u16)numBuf[0] * 1000;  //6 * 1000
	MOVF        TxtToU16_numBuf_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R1, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,151 :: 		res += (u16)(numBuf[1] * 100);  // 6000 + 5*100
	MOVLW       100
	MULWF       TxtToU16_numBuf_L0+1 
	MOVF        PRODL+0, 0 
	MOVWF       R2 
	MOVF        PRODH+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       R2, 1 
	MOVF        R1, 0 
	ADDWFC      R3, 1 
	MOVF        R2, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R3, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,152 :: 		res += (u16)(numBuf[2] * 10);   // 6500 + 4*10
	MOVLW       10
	MULWF       TxtToU16_numBuf_L0+2 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       R2, 1 
	MOVF        R1, 0 
	ADDWFC      R3, 1 
	MOVF        R2, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R3, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,153 :: 		res += (u16)numBuf[3];         // 6540 + 8
	MOVF        TxtToU16_numBuf_L0+3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R1, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,154 :: 		return res;
	GOTO        L_end_TxtToU16
;support.c,155 :: 		}
L_TxtToU1652:
;support.c,156 :: 		else if (i == 2) {
	MOVF        TxtToU16_i_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_TxtToU1654
;support.c,157 :: 		res  = (u16)numBuf[0] * 100;
	MOVF        TxtToU16_numBuf_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__TxtToU16+0 
	MOVF        R1, 0 
	MOVWF       FLOC__TxtToU16+1 
	MOVF        FLOC__TxtToU16+0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        FLOC__TxtToU16+1, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,158 :: 		res += (u16)numBuf[1] * 10;
	MOVF        TxtToU16_numBuf_L0+1, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__TxtToU16+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      FLOC__TxtToU16+1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R3, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,159 :: 		res += (u16)numBuf[2];
	MOVF        TxtToU16_numBuf_L0+2, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R1, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,160 :: 		return res;
	GOTO        L_end_TxtToU16
;support.c,161 :: 		}
L_TxtToU1654:
;support.c,162 :: 		else if (i == 1) {   // napr. 8, 4
	MOVF        TxtToU16_i_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_TxtToU1656
;support.c,163 :: 		res  = (u16)numBuf[0] * 10;  // 8 * 10 = 80
	MOVF        TxtToU16_numBuf_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R1, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,164 :: 		res += (u16)numBuf[1]; // 80 + 4
	MOVF        TxtToU16_numBuf_L0+1, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVF        R1, 0 
	MOVWF       TxtToU16_res_L0+1 
;support.c,165 :: 		return res;
	GOTO        L_end_TxtToU16
;support.c,166 :: 		}
L_TxtToU1656:
;support.c,167 :: 		else  res = numBuf[0];
	MOVF        TxtToU16_numBuf_L0+0, 0 
	MOVWF       TxtToU16_res_L0+0 
	MOVLW       0
	MOVWF       TxtToU16_res_L0+1 
;support.c,168 :: 		return res;
	MOVF        TxtToU16_res_L0+0, 0 
	MOVWF       R0 
	MOVF        TxtToU16_res_L0+1, 0 
	MOVWF       R1 
;support.c,169 :: 		}
L_end_TxtToU16:
	RETURN      0
; end of _TxtToU16
