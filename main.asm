
_interrupt:

;main.c,57 :: 		void interrupt() {
;main.c,58 :: 		char tmp=0,i=0;
;main.c,59 :: 		u16 RX_cnt=0;
;main.c,61 :: 		if (TMR6IF_bit && TMR6IE_bit){      // 10ms timer pro tlacitka - trva cca 64instrukci + LED
	BTFSS       TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
	GOTO        L_interrupt2
	BTFSS       TMR6IE_bit+0, BitPos(TMR6IE_bit+0) 
	GOTO        L_interrupt2
L__interrupt115:
;main.c,63 :: 		if      (LED1_Tresh == 255)        LED1 = 1;  // trvaly svit
	MOVF        _LED1_Tresh+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
	BSF         LED1+0, BitPos(LED1+0) 
	GOTO        L_interrupt4
L_interrupt3:
;main.c,64 :: 		else if (LED1_Tresh == 0)          LED1 = 0;  // trvale OFF
	MOVF        _LED1_Tresh+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
	BCF         LED1+0, BitPos(LED1+0) 
	GOTO        L_interrupt6
L_interrupt5:
;main.c,65 :: 		else if (LED1_Cnt >= LED1_Tresh) { LED1 ^= 1; LED1_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
	MOVLW       0
	SUBWF       _LED1_Cnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt119
	MOVF        _LED1_Tresh+0, 0 
	SUBWF       _LED1_Cnt+0, 0 
L__interrupt119:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt7
	BTG         LED1+0, BitPos(LED1+0) 
	CLRF        _LED1_Cnt+0 
	CLRF        _LED1_Cnt+1 
L_interrupt7:
L_interrupt6:
L_interrupt4:
;main.c,67 :: 		if      (LED2_Tresh == 255)        LED2 = 1;  // trvaly svit
	MOVF        _LED2_Tresh+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	BSF         LED2+0, BitPos(LED2+0) 
	GOTO        L_interrupt9
L_interrupt8:
;main.c,68 :: 		else if (LED2_Tresh == 0)          LED2 = 0;  // trvale OFF
	MOVF        _LED2_Tresh+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
	BCF         LED2+0, BitPos(LED2+0) 
	GOTO        L_interrupt11
L_interrupt10:
;main.c,69 :: 		else if (LED2_Cnt >= LED2_Tresh) { LED2 ^= 1; LED2_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
	MOVLW       0
	SUBWF       _LED2_Cnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt120
	MOVF        _LED2_Tresh+0, 0 
	SUBWF       _LED2_Cnt+0, 0 
L__interrupt120:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	BTG         LED2+0, BitPos(LED2+0) 
	CLRF        _LED2_Cnt+0 
	CLRF        _LED2_Cnt+1 
L_interrupt12:
L_interrupt11:
L_interrupt9:
;main.c,71 :: 		if      (LED3_Tresh == 255)        LED3 = 1;  // trvaly svit
	MOVF        _LED3_Tresh+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt13
	BSF         LED3+0, BitPos(LED3+0) 
	GOTO        L_interrupt14
L_interrupt13:
;main.c,72 :: 		else if (LED3_Tresh == 0)          LED3 = 0;  // trvale OFF
	MOVF        _LED3_Tresh+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
	BCF         LED3+0, BitPos(LED3+0) 
	GOTO        L_interrupt16
L_interrupt15:
;main.c,73 :: 		else if (LED3_Cnt >= LED3_Tresh) { LED3 ^= 1; LED3_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
	MOVLW       0
	SUBWF       _LED3_Cnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt121
	MOVF        _LED3_Tresh+0, 0 
	SUBWF       _LED3_Cnt+0, 0 
L__interrupt121:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
	BTG         LED3+0, BitPos(LED3+0) 
	CLRF        _LED3_Cnt+0 
	CLRF        _LED3_Cnt+1 
L_interrupt17:
L_interrupt16:
L_interrupt14:
;main.c,75 :: 		LED1_Cnt++; LED2_Cnt++; LED3_Cnt++;
	INFSNZ      _LED1_Cnt+0, 1 
	INCF        _LED1_Cnt+1, 1 
	INFSNZ      _LED2_Cnt+0, 1 
	INCF        _LED2_Cnt+1, 1 
	INFSNZ      _LED3_Cnt+0, 1 
	INCF        _LED3_Cnt+1, 1 
;main.c,76 :: 		TMR6IF_bit = 0;
	BCF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
;main.c,77 :: 		return;
	GOTO        L__interrupt118
;main.c,78 :: 		} // TMR6IF
L_interrupt2:
;main.c,81 :: 		if (TMR0IF_bit && TMR0IE_bit){ // pro PID po 50/100ms viz HW_ini.c
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt20
	BTFSS       TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
	GOTO        L_interrupt20
L__interrupt114:
;main.c,82 :: 		_PID_Calc++;
	INCF        __PID_Calc+0, 1 
;main.c,83 :: 		DisplayRefreshCnt++;    // pro zobrazovani na 7seg LCD
	INCF        _DisplayRefreshCnt+0, 1 
;main.c,84 :: 		MeasStart=1;            // priznak, ze muzeme merit
	MOVLW       1
	MOVWF       _MeasStart+0 
;main.c,85 :: 		TMR0H = 0x3C; TMR0L = 0xB0; // 15536 pro pozadovany cas
	MOVLW       60
	MOVWF       TMR0H+0 
	MOVLW       176
	MOVWF       TMR0L+0 
;main.c,86 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,88 :: 		return;
	GOTO        L__interrupt118
;main.c,89 :: 		}
L_interrupt20:
;main.c,93 :: 		if (RC1IF_bit && RC1IE_bit){ // UART1 IRQ  - ceka na prikaz ukonceny d10
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt23
	BTFSS       RC1IE_bit+0, BitPos(RC1IE_bit+0) 
	GOTO        L_interrupt23
L__interrupt113:
;main.c,96 :: 		LED_RED_100ms
	MOVLW       10
	MOVWF       _LED3_Tresh+0 
;main.c,97 :: 		BUF1_TIMEOUT = BUF1_OVERR = BUF1_TEMINATED = 0;   // flag na preteceni bufferu 2
	BCF         _rU1+0, 2 
	BTFSC       _rU1+0, 2 
	GOTO        L__interrupt122
	BCF         _rU1+0, 0 
	GOTO        L__interrupt123
L__interrupt122:
	BSF         _rU1+0, 0 
L__interrupt123:
	BTFSC       _rU1+0, 0 
	GOTO        L__interrupt124
	BCF         _rU1+0, 1 
	GOTO        L__interrupt125
L__interrupt124:
	BSF         _rU1+0, 1 
L__interrupt125:
;main.c,98 :: 		UART1_NEW_DATA = 1;   // bit - indikace novych dat - nastavime zde, v pripade chyb se nize nuluje
	BSF         _rU1+0, 3 
;main.c,99 :: 		rU1.ch = rU1.CntBuf = rU1.TimeCnt= 0;
	CLRF        _rU1+7 
	CLRF        _rU1+8 
	CLRF        _rU1+9 
	CLRF        _rU1+10 
	CLRF        _rU1+1 
;main.c,100 :: 		while(!BUF1_OVERR && !BUF1_TIMEOUT && !BUF1_TEMINATED) {  //max (RX_BUF_LEN-1) znaku a timeout 100ms + ukoncuje znak d10
L_interrupt24:
	BTFSC       _rU1+0, 0 
	GOTO        L_interrupt25
	BTFSC       _rU1+0, 1 
	GOTO        L_interrupt25
	BTFSC       _rU1+0, 2 
	GOTO        L_interrupt25
L__interrupt112:
;main.c,101 :: 		if(RC1IF_bit) { // neco je ve FIFO ?, max 6 znaku celkem muze prijit + ukoncovaci - RCIF JE JEN PRO CTENI !! KDYZ 1 je neco ve FIFO
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt28
;main.c,102 :: 		UART1_FIX_ERR   // osetreni pripadnych chyb na UARTU
	BTFSC       FERR1_bit+0, BitPos(FERR1_bit+0) 
	GOTO        L__interrupt111
	BTFSC       OERR1_bit+0, BitPos(OERR1_bit+0) 
	GOTO        L__interrupt111
	GOTO        L_interrupt31
L__interrupt111:
	BCF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt126
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt127
L__interrupt126:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt127:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt128
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt129
L__interrupt128:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt129:
	BSF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt130
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt131
L__interrupt130:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt131:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt132
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt133
L__interrupt132:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt133:
L_interrupt31:
;main.c,103 :: 		rU1.ch = RC1REG;  // cteme prijaty znak z RCREG
	MOVF        RC1REG+0, 0 
	MOVWF       _rU1+1 
;main.c,104 :: 		if (rU1.CntBuf < (rU1.BufLen-1)) { // je jeste volny buffer ?
	MOVLW       1
	SUBWF       _rU1+11, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      _rU1+12, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       _rU1+10, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt134
	MOVF        R1, 0 
	SUBWF       _rU1+9, 0 
L__interrupt134:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt32
;main.c,105 :: 		if (rU1.UseASCII) { // ASCII mod ?
	MOVF        _rU1+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;main.c,106 :: 		if (rU1.UseTermCh) { // pouzivame termchar ?
	MOVF        _rU1+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt34
;main.c,107 :: 		if (rU1.ch > 31) RX_buf[rU1.CntBuf++] = rU1.ch; // rU1.pRxBuf  ch ulozime do bufferu jen kdyz je tisknutelny znak
	MOVF        _rU1+1, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt35
	MOVLW       _RX_buf+0
	ADDWF       _rU1+9, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	ADDWFC      _rU1+10, 0 
	MOVWF       FSR1L+1 
	MOVF        _rU1+1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       1
	ADDWF       _rU1+9, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _rU1+10, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _rU1+9 
	MOVF        R1, 0 
	MOVWF       _rU1+10 
L_interrupt35:
;main.c,108 :: 		if (rU1.ch == rU1.TermCh) BUF1_TEMINATED = 1;    // prisel ukoncovaci znak, nastavime priznak
	MOVF        _rU1+1, 0 
	XORWF       _rU1+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt36
	BSF         _rU1+0, 2 
L_interrupt36:
;main.c,109 :: 		} // if rU1.UseTermChar
	GOTO        L_interrupt37
L_interrupt34:
;main.c,110 :: 		else {            RX_buf[rU1.CntBuf++] = rU1.ch; }  // ASCII mod bez termcharu
	MOVLW       _RX_buf+0
	ADDWF       _rU1+9, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	ADDWFC      _rU1+10, 0 
	MOVWF       FSR1L+1 
	MOVF        _rU1+1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       1
	ADDWF       _rU1+9, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _rU1+10, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _rU1+9 
	MOVF        R1, 0 
	MOVWF       _rU1+10 
L_interrupt37:
;main.c,111 :: 		}  // if rU1.UseASCII
	GOTO        L_interrupt38
L_interrupt33:
;main.c,112 :: 		else {  RX_buf[rU1.CntBuf++] = rU1.ch; } // RX_buf[rU1.CntBuf++] = rU1.ch; } // rU1.pRxBuf[rU1.CntBuf++] = rU1.ch; } // binary mod - ukladame veskere znaky 0-255
	MOVLW       _RX_buf+0
	ADDWF       _rU1+9, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	ADDWFC      _rU1+10, 0 
	MOVWF       FSR1L+1 
	MOVF        _rU1+1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       1
	ADDWF       _rU1+9, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _rU1+10, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _rU1+9 
	MOVF        R1, 0 
	MOVWF       _rU1+10 
L_interrupt38:
;main.c,113 :: 		}  // if (rU1.CntBuf < (RX_buf_LEN-1)) { // je plny buffer ?
	GOTO        L_interrupt39
L_interrupt32:
;main.c,115 :: 		BUF1_OVERR = 1;   // ... buffer pretekl, tudiz zadne nova data a koncime
	BSF         _rU1+0, 0 
;main.c,116 :: 		UART1_NEW_DATA = 0;  //..timpadem nemame validni data
	BCF         _rU1+0, 3 
;main.c,117 :: 		} // else // if (rU1.CntBuf < (rU1.BufLen-1)) { // je jeste volny buffer ?
L_interrupt39:
;main.c,118 :: 		}// if (RC1IF)
L_interrupt28:
;main.c,119 :: 		rU1.TimeCnt++;   // inkrementujeme timer
	MOVLW       1
	ADDWF       _rU1+7, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _rU1+8, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _rU1+7 
	MOVF        R1, 0 
	MOVWF       _rU1+8 
;main.c,120 :: 		if (rU1.TimeCnt > rU1.TIMEOUT) BUF1_TIMEOUT = 1; // uplynul timout na vycteni ?
	MOVF        _rU1+8, 0 
	SUBWF       _rU1+6, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt135
	MOVF        _rU1+7, 0 
	SUBWF       _rU1+5, 0 
L__interrupt135:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt40
	BSF         _rU1+0, 1 
L_interrupt40:
;main.c,121 :: 		Delay_us(2); //5
	MOVLW       2
	MOVWF       R13, 0
L_interrupt41:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt41
	NOP
;main.c,122 :: 		} // while
	GOTO        L_interrupt24
L_interrupt25:
;main.c,123 :: 		RX_buf[rU1.CntBuf] = 0x00;  // pridame 0x00 za posledni prijaty znak/cislo
	MOVLW       _RX_buf+0
	ADDWF       _rU1+9, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	ADDWFC      _rU1+10, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;main.c,124 :: 		if (BUF1_TIMEOUT) {  // osetreni timeoutu
	BTFSS       _rU1+0, 1 
	GOTO        L_interrupt42
;main.c,125 :: 		if (rU1.UseASCII && rU1.UseTermCh && (BUF1_TEMINATED!=1))
	MOVF        _rU1+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt45
	MOVF        _rU1+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt45
	BTFSC       _rU1+0, 2 
	GOTO        L_interrupt45
L__interrupt110:
;main.c,126 :: 		UART1_NEW_DATA = 0;  // pouzivame Term char ale ten neprisel -> zadna validni data
	BCF         _rU1+0, 3 
L_interrupt45:
;main.c,127 :: 		}
L_interrupt42:
;main.c,128 :: 		if (BUF1_OVERR) { // pretekl buufer - vse dovycteme a pak konec
	BTFSS       _rU1+0, 0 
	GOTO        L_interrupt46
;main.c,129 :: 		Delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_interrupt47:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt47
	DECFSZ      R12, 1, 1
	BRA         L_interrupt47
	NOP
	NOP
;main.c,130 :: 		while (RC1IF_bit) {UART1_FIX_ERR RX_buf[rU1.ch] = RC1REG; Delay_us(20); }   // jen vycitame data, dokud jsou,
L_interrupt48:
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt49
	BTFSC       FERR1_bit+0, BitPos(FERR1_bit+0) 
	GOTO        L__interrupt109
	BTFSC       OERR1_bit+0, BitPos(OERR1_bit+0) 
	GOTO        L__interrupt109
	GOTO        L_interrupt52
L__interrupt109:
	BCF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt136
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt137
L__interrupt136:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt137:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt138
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt139
L__interrupt138:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt139:
	BSF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt140
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt141
L__interrupt140:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt141:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt142
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt143
L__interrupt142:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt143:
L_interrupt52:
	MOVLW       _RX_buf+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FSR1L+1 
	MOVF        _rU1+1, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       26
	MOVWF       R13, 0
L_interrupt53:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt53
	NOP
	GOTO        L_interrupt48
L_interrupt49:
;main.c,131 :: 		UART1_NEW_DATA = 0;
	BCF         _rU1+0, 3 
;main.c,132 :: 		} // if BUF1_Overr
L_interrupt46:
;main.c,134 :: 		return;
	GOTO        L__interrupt118
;main.c,135 :: 		} // if RCIF
L_interrupt23:
;main.c,136 :: 		} // interrupt
L_end_interrupt:
L__interrupt118:
	RETFIE      1
; end of _interrupt

_main:

;main.c,142 :: 		void main() {
;main.c,143 :: 		u16 i=0, RXdata=0, CJ125_Status=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
	CLRF        main_tst_mode_L0+0 
	CLRF        main_USE_UART1_L0+0 
	CLRF        main_DAC_Set_L0+0 
	CLRF        main_DAC_Set_L0+1 
;main.c,148 :: 		START_TMR6      // dtto pro Timer 6 (IRQ po 10ms)
	BSF         TMR6IE_bit+0, BitPos(TMR6IE_bit+0) 
;main.c,149 :: 		START:
___main_START:
;main.c,150 :: 		HW_Init();      // all include UART's....
	CALL        _HW_Init+0, 0
;main.c,151 :: 		I2C2_Init(400000);
	MOVLW       10
	MOVWF       SSP2ADD+0 
	CALL        _I2C2_Init+0, 0
;main.c,153 :: 		ALL_LEDs_OFF
	CLRF        _LED1_Tresh+0 
	CLRF        _LED2_Tresh+0 
	CLRF        _LED3_Tresh+0 
;main.c,155 :: 		UART_Welcome(1,EE_Consts);
	MOVLW       1
	MOVWF       FARG_UART_Welcome_ComNr+0 
	MOVLW       5
	MOVWF       R0 
	MOVLW       FARG_UART_Welcome_EE_Data+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(FARG_UART_Welcome_EE_Data+0)
	MOVWF       FSR1L+1 
	MOVLW       _EE_Consts+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_EE_Consts+0)
	MOVWF       FSR0L+1 
L_main54:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main54
	CALL        _UART_Welcome+0, 0
;main.c,156 :: 		USE_UART1 = _UART1_LISTING(EE_Consts.OPTION);
	MOVF        _EE_Consts+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main55
L_main56:
	CLRF        R0 
L_main55:
	MOVF        R0, 0 
	MOVWF       main_USE_UART1_L0+0 
;main.c,157 :: 		UART_PrintTxt(1,"OLED test"); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,159 :: 		SSD1306_Begin(SSD1306_SWITCHCAPVCC, 0x78); // SSD1306_I2C_ADDRESS);
	MOVLW       2
	MOVWF       FARG_SSD1306_Begin_vccstate+0 
	MOVLW       120
	MOVWF       FARG_SSD1306_Begin_i2caddr+0 
	CALL        _SSD1306_Begin+0, 0
;main.c,160 :: 		SSD1306_ClearDisplay();   // clear the buffer
	CALL        _SSD1306_ClearDisplay+0, 0
;main.c,161 :: 		SSD1306_Display();
	CALL        _SSD1306_Display+0, 0
;main.c,176 :: 		if (USE_UART1) { UART_PrintTxt(1,"USE UART1 for listing"); CR_LF(1); }
	MOVF        main_USE_UART1_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr2_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr2_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
L_main57:
;main.c,178 :: 		do {
L_main58:
;main.c,179 :: 		if (UART1_NEW_DATA) {  // nejky prikaz na UART 1 ?   max 2s po zapnuti
	BTFSS       _rU1+0, 3 
	GOTO        L_main61
;main.c,180 :: 		i = 101;      //zustaneme zde navzdy
	MOVLW       101
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
;main.c,182 :: 		DAC_Set = DAC_14p7_VOLT;
	MOVLW       108
	MOVWF       main_DAC_Set_L0+0 
	MOVLW       12
	MOVWF       main_DAC_Set_L0+1 
;main.c,183 :: 		DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVLW       108
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVLW       12
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,184 :: 		UART_PrintTxt(1,"Enetered to test mode, DAC1/2 outputs set to 14.7AFR => ");UART_PrintU16(1,DAC_14p7_VOLT); UART_PrintTxt(1,"mV"); CR_LF(1); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr3_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr3_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       108
	MOVWF       FARG_WordToStr_input+0 
	MOVLW       12
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr4_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr4_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,185 :: 		i=102;
	MOVLW       102
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
;main.c,187 :: 		tst_mode=1;
	MOVLW       1
	MOVWF       main_tst_mode_L0+0 
;main.c,188 :: 		ALL_LEDs_ON;
	MOVLW       255
	MOVWF       _LED1_Tresh+0 
	MOVLW       255
	MOVWF       _LED2_Tresh+0 
	MOVLW       255
	MOVWF       _LED3_Tresh+0 
;main.c,189 :: 		UART1_NEW_DATA = 0;
	BCF         _rU1+0, 3 
;main.c,190 :: 		if (!__SET_DACtoXXXXX(RX_buf)) {  // nastavi oba DACi na dane mV (syntaxe DAC=1500 - bez ukoncovaciho znaku)
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr5_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr5_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       4
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main63
;main.c,191 :: 		ADC_COEF_OFS_EEPROM =  EEPROM_Read(ADC_OFFSET_ADR); delay_ms(20);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ADC_COEF_OFS_EEPROM+0 
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main64:
	DECFSZ      R13, 1, 1
	BRA         L_main64
	DECFSZ      R12, 1, 1
	BRA         L_main64
	NOP
;main.c,192 :: 		str_cut_left(RX_buf,4); DAC_Set=atoi(RX_buf); UART_PrintTxt(1," >DACx set to ="); UART_PrintU16(1,DAC_Set);   // odestrani DAC= a zbyde jen cislo ve stringu,na prevod
	MOVLW       _RX_buf+0
	MOVWF       FARG_str_cut_left_S1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_str_cut_left_S1+1 
	MOVLW       4
	MOVWF       FARG_str_cut_left_n+0 
	MOVLW       0
	MOVWF       FARG_str_cut_left_n+1 
	CALL        _str_cut_left+0, 0
	MOVLW       _RX_buf+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_DAC_Set_L0+0 
	MOVF        R1, 0 
	MOVWF       main_DAC_Set_L0+1 
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr6_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr6_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,193 :: 		DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,194 :: 		} // if __SET_DAC
	GOTO        L_main65
L_main63:
;main.c,195 :: 		else if (!__GET_VBAT(RX_buf)) {
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr7_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr7_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       5
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main66
;main.c,196 :: 		VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VBAT_COEF_OFS_EEPROM+0 
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main67:
	DECFSZ      R13, 1, 1
	BRA         L_main67
	DECFSZ      R12, 1, 1
	BRA         L_main67
	NOP
;main.c,197 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);
	MOVLW       4
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _VBAT_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _VBAT_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat_mV+0 
	MOVF        R1, 0 
	MOVWF       _Vbat_mV+1 
;main.c,198 :: 		UART_PrintTxt(1,">Vbat= "); UART_PrintU16(1,Vbat_mV); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr8_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr8_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Vbat_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Vbat_mV+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,199 :: 		}
	GOTO        L_main68
L_main66:
;main.c,200 :: 		else if (!__SET_VBAT_OFFSET(RX_buf)) {
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr9_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr9_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       9
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main69
;main.c,201 :: 		VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20); UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_OLD="); UART_PrintI8(1,VBAT_COEF_OFS_EEPROM);  CR_LF(1);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VBAT_COEF_OFS_EEPROM+0 
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main70:
	DECFSZ      R13, 1, 1
	BRA         L_main70
	DECFSZ      R12, 1, 1
	BRA         L_main70
	NOP
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr10_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr10_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _VBAT_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,202 :: 		str_cut_left(RX_buf,9); tmpi8=atoi(RX_buf); EEPROM_Write(VBAT_OFFSET_ADR,tmpi8); Delay_ms(20); VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR);
	MOVLW       _RX_buf+0
	MOVWF       FARG_str_cut_left_S1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_str_cut_left_S1+1 
	MOVLW       9
	MOVWF       FARG_str_cut_left_n+0 
	MOVLW       0
	MOVWF       FARG_str_cut_left_n+1 
	CALL        _str_cut_left+0, 0
	MOVLW       _RX_buf+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main71:
	DECFSZ      R13, 1, 1
	BRA         L_main71
	DECFSZ      R12, 1, 1
	BRA         L_main71
	NOP
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        FLOC__main+0, 0 
	MOVWF       _VBAT_COEF_OFS_EEPROM+0 
;main.c,203 :: 		VBAT_KOEF = (AD_KOEF * _VBAT_DIV) + VBAT_COEF_OFS_EEPROM;
	MOVF        _AD_KOEF+0, 0 
	MOVWF       R0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       R1 
	MOVLW       11
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__main+0, 0 
	ADDWF       R0, 0 
	MOVWF       _VBAT_KOEF+0 
	MOVLW       0
	BTFSC       FLOC__main+0, 7 
	MOVLW       255
	ADDWFC      R1, 0 
	MOVWF       _VBAT_KOEF+1 
;main.c,204 :: 		UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_NEW="); UART_PrintI8(1,VBAT_COEF_OFS_EEPROM); UART_PrintTxt(1," VBAT_KOEF="); UART_PrintU16(1,VBAT_KOEF); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr11_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr11_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _VBAT_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr12_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr12_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _VBAT_KOEF+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _VBAT_KOEF+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,205 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);
	MOVLW       4
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _VBAT_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _VBAT_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat_mV+0 
	MOVF        R1, 0 
	MOVWF       _Vbat_mV+1 
;main.c,206 :: 		UART_PrintTxt(1,"  Vbat= "); UART_PrintU16(1,Vbat_mV); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr13_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr13_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Vbat_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Vbat_mV+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,207 :: 		}
	GOTO        L_main72
L_main69:
;main.c,208 :: 		else if (!__SET_ADC_OFFSET(RX_buf)) {  // vyctze ADC_OFFSET konstantu z EEPROM, zapise novou a pro kontrolu vypise z EEPROM na UART (rozsah +/- 127)
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr14_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr14_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       8
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main73
;main.c,209 :: 		ADC_COEF_OFS_EEPROM = EEPROM_Read(ADC_OFFSET_ADR);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ADC_COEF_OFS_EEPROM+0 
;main.c,210 :: 		UART_PrintTxt(1,"ADC_KOEF_OFFSET_OLD="); UART_PrintI8(1,ADC_COEF_OFS_EEPROM); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr15_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr15_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _ADC_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,211 :: 		UART_PrintTxt(1," ADC_KOEF_OLD="); UART_PrintU16(1,AD_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr16_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr16_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _AD_KOEF+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,212 :: 		CR_LF(1); Delay_ms (20); // kvuli EEPROM
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main74:
	DECFSZ      R13, 1, 1
	BRA         L_main74
	DECFSZ      R12, 1, 1
	BRA         L_main74
	NOP
;main.c,213 :: 		str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write(ADC_OFFSET_ADR,tmpi8); Delay_ms(20); ADC_COEF_OFS_EEPROM = EEPROM_Read(ADC_OFFSET_ADR);
	MOVLW       _RX_buf+0
	MOVWF       FARG_str_cut_left_S1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_str_cut_left_S1+1 
	MOVLW       8
	MOVWF       FARG_str_cut_left_n+0 
	MOVLW       0
	MOVWF       FARG_str_cut_left_n+1 
	CALL        _str_cut_left+0, 0
	MOVLW       _RX_buf+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main75:
	DECFSZ      R13, 1, 1
	BRA         L_main75
	DECFSZ      R12, 1, 1
	BRA         L_main75
	NOP
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ADC_COEF_OFS_EEPROM+0 
;main.c,214 :: 		AD_KOEF = _AD_CONST + ADC_COEF_OFS_EEPROM;
	MOVLW       233
	MOVWF       _AD_KOEF+0 
	MOVLW       1
	MOVWF       _AD_KOEF+1 
	MOVF        R0, 0 
	ADDWF       _AD_KOEF+0, 1 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	ADDWFC      _AD_KOEF+1, 1 
;main.c,215 :: 		UART_PrintTxt(1,"ADC_KOEF_OFFSET_NEW="); UART_PrintI8(1,ADC_COEF_OFS_EEPROM);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr17_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr17_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _ADC_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,216 :: 		UART_PrintTxt(1," ADC_KOEF="); UART_PrintU16(1,AD_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr18_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr18_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _AD_KOEF+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,217 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,218 :: 		VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _VBAT_COEF_OFS_EEPROM+0 
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main76:
	DECFSZ      R13, 1, 1
	BRA         L_main76
	DECFSZ      R12, 1, 1
	BRA         L_main76
	NOP
;main.c,219 :: 		VBAT_KOEF = (AD_KOEF * _VBAT_DIV) + VBAT_COEF_OFS_EEPROM;
	MOVF        _AD_KOEF+0, 0 
	MOVWF       R0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       R1 
	MOVLW       11
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        _VBAT_COEF_OFS_EEPROM+0, 0 
	ADDWF       R0, 0 
	MOVWF       _VBAT_KOEF+0 
	MOVLW       0
	BTFSC       _VBAT_COEF_OFS_EEPROM+0, 7 
	MOVLW       255
	ADDWFC      R1, 0 
	MOVWF       _VBAT_KOEF+1 
;main.c,220 :: 		UART_PrintTxt(1,"  Vbat= "); UART_PrintU16(1,Vbat_mV);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr19_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr19_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Vbat_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Vbat_mV+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,221 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,222 :: 		}
	GOTO        L_main77
L_main73:
;main.c,223 :: 		else if (!__SET_DAC_OFFSET(RX_buf)) {  // vyctze DAC_OFFSET konstantu z EEPROM, zapise novou a pro kontrolu vypise z EEPROM na UART (rozsah +/- 127)
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr20_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr20_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       8
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main78
;main.c,224 :: 		DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC_COEF_OFS_EEPROM+0 
;main.c,225 :: 		UART_PrintTxt(1,"DAC_KOEF_OFFSET_OLD="); UART_PrintI8(1,DAC_COEF_OFS_EEPROM); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr21_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr21_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,226 :: 		UART_PrintTxt(1," DAC_KOEF_OLD="); UART_PrintU16(1,DAC_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr22_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr22_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC_KOEF+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _DAC_KOEF+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,227 :: 		CR_LF(1); Delay_ms (20); // kvuli EEPROM
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main79:
	DECFSZ      R13, 1, 1
	BRA         L_main79
	DECFSZ      R12, 1, 1
	BRA         L_main79
	NOP
;main.c,228 :: 		str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write(DAC_OFFSET_ADR,tmpi8); Delay_ms(20); DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
	MOVLW       _RX_buf+0
	MOVWF       FARG_str_cut_left_S1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_str_cut_left_S1+1 
	MOVLW       8
	MOVWF       FARG_str_cut_left_n+0 
	MOVLW       0
	MOVWF       FARG_str_cut_left_n+1 
	CALL        _str_cut_left+0, 0
	MOVLW       _RX_buf+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main80:
	DECFSZ      R13, 1, 1
	BRA         L_main80
	DECFSZ      R12, 1, 1
	BRA         L_main80
	NOP
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC_COEF_OFS_EEPROM+0 
;main.c,229 :: 		DAC_KOEF = _DAC_CONST - DAC_COEF_OFS_EEPROM ;
	MOVF        R0, 0 
	SUBLW       233
	MOVWF       _DAC_KOEF+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       _DAC_KOEF+1 
	MOVLW       1
	SUBFWB      _DAC_KOEF+1, 1 
;main.c,230 :: 		UART_PrintTxt(1,"DAC_KOEF_OFFSET_NEW="); UART_PrintI8(1,DAC_COEF_OFS_EEPROM);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr23_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr23_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,231 :: 		UART_PrintTxt(1," DAC_KOEF="); UART_PrintU16(1,DAC_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr24_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr24_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC_KOEF+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _DAC_KOEF+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,232 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,233 :: 		DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set);   // znovu nastavime DACy
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;main.c,234 :: 		UART_PrintTxt(1," >DACx set to ="); UART_PrintU16(1,DAC_Set);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr25_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr25_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        main_DAC_Set_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        main_DAC_Set_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,235 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,236 :: 		}
	GOTO        L_main81
L_main78:
;main.c,242 :: 		else if (!__EXIT_CFG(RX_buf)) {
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr26_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr26_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       4
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main82
;main.c,243 :: 		UART_PrintTxt(1,"Exit cfg mode.."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr27_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr27_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,244 :: 		tst_mode = 0;
	CLRF        main_tst_mode_L0+0 
;main.c,245 :: 		}
L_main82:
L_main81:
L_main77:
L_main72:
L_main68:
L_main65:
;main.c,247 :: 		}  // if (RX_FLAG) ========   ======
L_main61:
;main.c,249 :: 		if (i > 100) i = 102;
	MOVLW       0
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main145
	MOVF        main_i_L0+0, 0 
	SUBLW       100
L__main145:
	BTFSC       STATUS+0, 0 
	GOTO        L_main83
	MOVLW       102
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
	GOTO        L_main84
L_main83:
;main.c,250 :: 		else { UART_PrintCh(1,'-'); i++; }
	MOVLW       1
	MOVWF       FARG_UART_PrintCh_Nr+0 
	MOVLW       45
	MOVWF       FARG_UART_PrintCh_ch+0 
	CALL        _UART_PrintCh+0, 0
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
L_main84:
;main.c,251 :: 		delay_ms(20);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main85:
	DECFSZ      R13, 1, 1
	BRA         L_main85
	DECFSZ      R12, 1, 1
	BRA         L_main85
	NOP
;main.c,252 :: 		} while ((i < 100) || (tst_mode == 1)) ;
	MOVLW       0
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main146
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
L__main146:
	BTFSS       STATUS+0, 0 
	GOTO        L_main58
	MOVF        main_tst_mode_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
L__main116:
;main.c,254 :: 		RC1IE_bit = 0;         // Uart 1 Rx OFF
	BCF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;main.c,255 :: 		ALL_LEDs_OFF
	CLRF        _LED1_Tresh+0 
	CLRF        _LED2_Tresh+0 
	CLRF        _LED3_Tresh+0 
;main.c,260 :: 		CJ125_Test();    // test obvodu CJ125
	CALL        _CJ125_Test+0, 0
;main.c,261 :: 		CJ125_Ri_Cal(LSU49);  // kalibrace Ur - zalezi jen na osazeni Ri odporu, ne na pripojene sonde
	MOVLW       1
	MOVWF       FARG_CJ125_Ri_Cal_LSU+0 
	CALL        _CJ125_Ri_Cal+0, 0
;main.c,262 :: 		LED_RED_100ms;
	MOVLW       10
	MOVWF       _LED3_Tresh+0 
;main.c,263 :: 		do {      // test, zda je pripojena sonda - muze zde zustat navzdy
L_main88:
;main.c,264 :: 		CJ125_Ans = CJ125_Sensor_Test();
	CALL        _CJ125_Sensor_Test+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;main.c,265 :: 		DACx_Err_Mode(50, 50, 50); // plynule zvetsujeme DAC1/2 out po dobu chyby - cca 6.75-7.1AFR
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_start_DAC+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_start_DAC+1 
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_max_DAC_add+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_max_DAC_add+1 
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_step+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_step+1 
	CALL        _DACx_Err_Mode+0, 0
;main.c,266 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main91:
	DECFSZ      R13, 1, 1
	BRA         L_main91
	DECFSZ      R12, 1, 1
	BRA         L_main91
	DECFSZ      R11, 1, 1
	BRA         L_main91
	NOP
	NOP
;main.c,267 :: 		} while (CJ125_Ans != CJ125_DIAG_REG_STATUS_OK);
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__main147
	MOVLW       255
	XORWF       _CJ125_Ans+0, 0 
L__main147:
	BTFSS       STATUS+0, 2 
	GOTO        L_main88
;main.c,268 :: 		DAC_ERR_CNT=0;
	CLRF        _DAC_ERR_CNT+0 
	CLRF        _DAC_ERR_CNT+1 
;main.c,269 :: 		LED_BLUE_100ms;
	MOVLW       10
	MOVWF       _LED1_Tresh+0 
;main.c,271 :: 		DACx_Service(400, DAC2_NO_GAUGE); // sensor je ok, zaciname heating -> oba DACy na AFR 8.00
	MOVLW       144
	MOVWF       FARG_DACx_Service_AFR_Val+0 
	MOVLW       1
	MOVWF       FARG_DACx_Service_AFR_Val+1 
	CLRF        FARG_DACx_Service_UseGauge+0 
	CALL        _DACx_Service+0, 0
;main.c,272 :: 		DACx_Err_Mode(450, 450, 50); // plynule zvetsujeme DAC1/2 out po dobu chyby - cca 6.75-7.1AFR
	MOVLW       194
	MOVWF       FARG_DACx_Err_Mode_start_DAC+0 
	MOVLW       1
	MOVWF       FARG_DACx_Err_Mode_start_DAC+1 
	MOVLW       194
	MOVWF       FARG_DACx_Err_Mode_max_DAC_add+0 
	MOVLW       1
	MOVWF       FARG_DACx_Err_Mode_max_DAC_add+1 
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_step+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_step+1 
	CALL        _DACx_Err_Mode+0, 0
;main.c,273 :: 		CJ125_Vbat_check();     // cekame na spravnou hodnotu Vbat, pripadne Vbat + DELTA_VBAT => doslo k nastartovani
	CALL        _CJ125_Vbat_check+0, 0
;main.c,274 :: 		LED_BLUE_ON; LED_RED_OFF;
	MOVLW       255
	MOVWF       _LED1_Tresh+0 
	CLRF        _LED3_Tresh+0 
;main.c,275 :: 		CJ125_PreHeat_LSU(LSU49);
	MOVLW       1
	MOVWF       FARG_CJ125_PreHeat_LSU_LSU+0 
	CALL        _CJ125_PreHeat_LSU+0, 0
;main.c,276 :: 		LED_BLUE_OFF;
	CLRF        _LED1_Tresh+0 
;main.c,278 :: 		START_PID_TMR   // spusti timer pro PID regulaci - tam bezi
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,279 :: 		LED_GREEN_1s
	MOVLW       100
	MOVWF       _LED2_Tresh+0 
;main.c,284 :: 		while(1){
L_main92:
;main.c,286 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;main.c,287 :: 		if (CJ125_Ans !=  CJ125_DIAG_REG_STATUS_OK) {
	MOVF        R1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__main148
	MOVLW       255
	XORWF       R0, 0 
L__main148:
	BTFSC       STATUS+0, 2 
	GOTO        L_main94
;main.c,288 :: 		UART_PrintTxt(1,"LSU sensor disconnected/failure, ");  //CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr28_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr28_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,289 :: 		Heat_PWM = 0;
	CLRF        _Heat_PWM+0 
	CLRF        _Heat_PWM+1 
;main.c,291 :: 		STOP_PID_TMR
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,292 :: 		UART_PrintTxt(1,"waiting for reconnecting...."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr29_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr29_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,293 :: 		do {
L_main95:
;main.c,294 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;main.c,295 :: 		delay_ms(500); UART_PrintTxt(1,".");
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main98:
	DECFSZ      R13, 1, 1
	BRA         L_main98
	DECFSZ      R12, 1, 1
	BRA         L_main98
	DECFSZ      R11, 1, 1
	BRA         L_main98
	NOP
	NOP
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr30_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr30_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,296 :: 		ALL_LEDs_OFF; LED_RED_100ms;  // blikame red jako chyba
	CLRF        _LED1_Tresh+0 
	CLRF        _LED2_Tresh+0 
	CLRF        _LED3_Tresh+0 
	MOVLW       10
	MOVWF       _LED3_Tresh+0 
;main.c,297 :: 		DACx_Err_Mode(50, 50, 50); // chyba AFR - cca 6.75 - 7.1 cyklujeme DACy
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_start_DAC+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_start_DAC+1 
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_max_DAC_add+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_max_DAC_add+1 
	MOVLW       50
	MOVWF       FARG_DACx_Err_Mode_step+0 
	MOVLW       0
	MOVWF       FARG_DACx_Err_Mode_step+1 
	CALL        _DACx_Err_Mode+0, 0
;main.c,298 :: 		} while (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOSENSOR);// CR_LF(1);
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__main149
	MOVLW       127
	XORWF       _CJ125_Ans+0, 0 
L__main149:
	BTFSC       STATUS+0, 2 
	GOTO        L_main95
;main.c,299 :: 		UART_PrintTxt(1,"Sensor re-connected, going back to starting procedure...."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr31_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr31_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,300 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main99:
	DECFSZ      R13, 1, 1
	BRA         L_main99
	DECFSZ      R12, 1, 1
	BRA         L_main99
	DECFSZ      R11, 1, 1
	BRA         L_main99
	NOP
;main.c,301 :: 		goto START;
	GOTO        ___main_START
;main.c,302 :: 		}
L_main94:
;main.c,305 :: 		if (_PID_Calc >= PID_REFRESH) {  // v IRQ timer se nastavi na 1 po 100ms - provedeme update PID topeni
	MOVLW       2
	SUBWF       __PID_Calc+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main100
;main.c,306 :: 		_PID_Calc = 0;                   // priznak hned mazeme, dalsi az po 100ms v IRQ  UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - vnitrni impedance
	CLRF        __PID_Calc+0 
;main.c,307 :: 		UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - vnitrni impedance
	MOVLW       2
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _AD_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _UR_mV+0 
	MOVF        R1, 0 
	MOVWF       _UR_mV+1 
;main.c,308 :: 		Heat_PWM = LSU_PID_Heater_Service(UR_mV,UR_mV_ref);        // if (LED3) LED3=0; else LED3=1;    // jen pro debug
	MOVF        R0, 0 
	MOVWF       FARG_LSU_PID_Heater_Service_Ur_Act+0 
	MOVF        R1, 0 
	MOVWF       FARG_LSU_PID_Heater_Service_Ur_Act+1 
	MOVF        _UR_mV_ref+0, 0 
	MOVWF       FARG_LSU_PID_Heater_Service_Ur_Target+0 
	MOVF        _UR_mV_ref+1, 0 
	MOVWF       FARG_LSU_PID_Heater_Service_Ur_Target+1 
	CALL        _LSU_PID_Heater_Service+0, 0
	MOVF        R0, 0 
	MOVWF       _Heat_PWM+0 
	MOVF        R1, 0 
	MOVWF       _Heat_PWM+1 
;main.c,309 :: 		} // if PID_Calc...
L_main100:
;main.c,312 :: 		if (MeasTime_Cnt >= MEAS_REFRESH) {          // cela fce cca 48ms s AD 256x vzroky, 30ms se 128x vzorky AD !!!
	MOVLW       1
	SUBWF       _MeasTime_Cnt+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main101
;main.c,313 :: 		MeasTime_Cnt = MeasStart=0;              // povoli az dalsi IRQ
	CLRF        _MeasStart+0 
	CLRF        _MeasTime_Cnt+0 
;main.c,317 :: 		AFR_act = LinFit(CJ125_Calc_Ip(UA_mV,8), cj49Tab,CJ49_TAB_SIZE);   // cca 1.3-1.5ms (Ip pocitano s floaty)
	MOVF        _UA_mV+0, 0 
	MOVWF       R0 
	MOVF        _UA_mV+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+0 
	MOVF        R1, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+1 
	MOVF        R2, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+2 
	MOVF        R3, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+3 
	MOVLW       8
	MOVWF       FARG_CJ125_Calc_Ip_Amplify+0 
	CALL        _CJ125_Calc_Ip+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_LinFit_X+0 
	MOVF        R1, 0 
	MOVWF       FARG_LinFit_X+1 
	MOVLW       _cj49Tab+0
	MOVWF       FARG_LinFit_pTab+0 
	MOVLW       hi_addr(_cj49Tab+0)
	MOVWF       FARG_LinFit_pTab+1 
	MOVLW       17
	MOVWF       FARG_LinFit_Tab_size+0 
	CALL        _LinFit+0, 0
	MOVF        R0, 0 
	MOVWF       _AFR_act+0 
	MOVF        R1, 0 
	MOVWF       _AFR_act+1 
;main.c,318 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);   // merime vbat
	MOVLW       4
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _VBAT_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _VBAT_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat_mV+0 
	MOVF        R1, 0 
	MOVWF       _Vbat_mV+1 
;main.c,326 :: 		DACx_Service(AFR_act, DAC2_NO_GAUGE);      // cca 1.5ms - obslouzeni analogovych vystupu
	MOVF        _AFR_act+0, 0 
	MOVWF       FARG_DACx_Service_AFR_Val+0 
	MOVF        _AFR_act+1, 0 
	MOVWF       FARG_DACx_Service_AFR_Val+1 
	CLRF        FARG_DACx_Service_UseGauge+0 
	CALL        _DACx_Service+0, 0
;main.c,327 :: 		} // if (MeasTime_Cnt...
	GOTO        L_main102
L_main101:
;main.c,329 :: 		UA_mV = Get_AD_mV(UA_AD_ch,AD_KOEF);   // merime UA napeti z CJ125 ~ "lambda"
	MOVLW       1
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _AD_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _UA_mV+0 
	MOVF        R1, 0 
	MOVWF       _UA_mV+1 
;main.c,331 :: 		MeasStart=0;  // povoli az dalsi IRQ
	CLRF        _MeasStart+0 
;main.c,332 :: 		MeasTime_Cnt++;
	INCF        _MeasTime_Cnt+0, 1 
;main.c,333 :: 		}; // else  (MeasTime...
L_main102:
;main.c,336 :: 		if (DisplayRefreshCnt >= DISP_REFRESH) { // cas na refresh AFR displeje   2 => 200ms => 5Hz
	MOVLW       1
	SUBWF       _DisplayRefreshCnt+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main103
;main.c,337 :: 		DisplayRefreshCnt = 0;
	CLRF        _DisplayRefreshCnt+0 
;main.c,338 :: 		OLED_Show_AFR(AFR_act, AFR_act);
	MOVF        _AFR_act+0, 0 
	MOVWF       FARG_OLED_Show_AFR_Afr+0 
	MOVF        _AFR_act+1, 0 
	MOVWF       FARG_OLED_Show_AFR_Afr+1 
	MOVF        _AFR_act+0, 0 
	MOVWF       FARG_OLED_Show_AFR_Vbat+0 
	MOVF        _AFR_act+1, 0 
	MOVWF       FARG_OLED_Show_AFR_Vbat+1 
	CALL        _OLED_Show_AFR+0, 0
;main.c,339 :: 		if (USE_UART1) UART_Service();        // UART - posilani dat -  techto 6x vypisu na UART trva 10ms (115k2)
	MOVF        main_USE_UART1_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main104
	CALL        _UART_Service+0, 0
L_main104:
;main.c,340 :: 		} // if DisplayRefresh....
L_main103:
;main.c,341 :: 		} // while 1     ===================================================
	GOTO        L_main92
;main.c,343 :: 		}  // void main()
L_end_main:
	GOTO        $+0
; end of _main

_LSU_PID_Heater_Service:

;main.c,350 :: 		u16 LSU_PID_Heater_Service(u16 Ur_Act,u16 Ur_Target) {
;main.c,351 :: 		u16 PWM_Out=1;
	MOVLW       1
	MOVWF       LSU_PID_Heater_Service_PWM_Out_L0+0 
	MOVLW       0
	MOVWF       LSU_PID_Heater_Service_PWM_Out_L0+1 
;main.c,352 :: 		PWM_Out = (u8) Heater_PID_Control(LSU_TYPE, Ur_Act, Ur_Target);
	MOVLW       1
	MOVWF       FARG_Heater_PID_Control_LSU+0 
	MOVF        FARG_LSU_PID_Heater_Service_Ur_Act+0, 0 
	MOVWF       FARG_Heater_PID_Control_input+0 
	MOVF        FARG_LSU_PID_Heater_Service_Ur_Act+1, 0 
	MOVWF       FARG_Heater_PID_Control_input+1 
	MOVF        FARG_LSU_PID_Heater_Service_Ur_Target+0, 0 
	MOVWF       FARG_Heater_PID_Control_target+0 
	MOVF        FARG_LSU_PID_Heater_Service_Ur_Target+1, 0 
	MOVWF       FARG_Heater_PID_Control_target+1 
	CALL        _Heater_PID_Control+0, 0
	MOVF        R0, 0 
	MOVWF       LSU_PID_Heater_Service_PWM_Out_L0+0 
	MOVLW       0
	MOVWF       LSU_PID_Heater_Service_PWM_Out_L0+1 
;main.c,353 :: 		PWM4_Set_Duty(PWM_Out);
	MOVF        LSU_PID_Heater_Service_PWM_Out_L0+0, 0 
	MOVWF       FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
;main.c,354 :: 		return PWM_Out;
	MOVF        LSU_PID_Heater_Service_PWM_Out_L0+0, 0 
	MOVWF       R0 
	MOVF        LSU_PID_Heater_Service_PWM_Out_L0+1, 0 
	MOVWF       R1 
;main.c,355 :: 		}
L_end_LSU_PID_Heater_Service:
	RETURN      0
; end of _LSU_PID_Heater_Service

_DACx_Service:

;main.c,358 :: 		void DACx_Service(u16 AFR_Val,u8 UseGauge) {   // cca 1.5ms@16Mhz
;main.c,359 :: 		u8 x=0;
;main.c,362 :: 		DAC1_Out = LinFit(AFR_Val,DAC_LINEAR,DAC_LINEAR_SIZE);    // AFR 9~0.15V - 18.7~5.0V
	MOVF        FARG_DACx_Service_AFR_Val+0, 0 
	MOVWF       FARG_LinFit_X+0 
	MOVF        FARG_DACx_Service_AFR_Val+1, 0 
	MOVWF       FARG_LinFit_X+1 
	MOVLW       _DAC_LINEAR+0
	MOVWF       FARG_LinFit_pTab+0 
	MOVLW       hi_addr(_DAC_LINEAR+0)
	MOVWF       FARG_LinFit_pTab+1 
	MOVLW       2
	MOVWF       FARG_LinFit_Tab_size+0 
	CALL        _LinFit+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC1_Out+0 
	MOVF        R1, 0 
	MOVWF       _DAC1_Out+1 
;main.c,363 :: 		DACx_mV_Out_10bit(1, DAC1_Out);    // zapiseme DAC 1 vystup
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        R0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        R1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;main.c,365 :: 		if (UseGauge) DAC2_Out = LinFit(AFR_Val, Innov_818_Tab,INOV818_TAB_SIZE);  // Innovate gauge 8-18AFR (1V - 0V)
	MOVF        FARG_DACx_Service_UseGauge+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DACx_Service105
	MOVF        FARG_DACx_Service_AFR_Val+0, 0 
	MOVWF       FARG_LinFit_X+0 
	MOVF        FARG_DACx_Service_AFR_Val+1, 0 
	MOVWF       FARG_LinFit_X+1 
	MOVLW       _Innov_818_Tab+0
	MOVWF       FARG_LinFit_pTab+0 
	MOVLW       hi_addr(_Innov_818_Tab+0)
	MOVWF       FARG_LinFit_pTab+1 
	MOVLW       9
	MOVWF       FARG_LinFit_Tab_size+0 
	CALL        _LinFit+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC2_Out+0 
	MOVF        R1, 0 
	MOVWF       _DAC2_Out+1 
	GOTO        L_DACx_Service106
L_DACx_Service105:
;main.c,366 :: 		else          DAC2_Out = LinFit(AFR_Val,DAC_LINEAR, DAC_LINEAR_SIZE);     // DAC2_Out = (5*AFR_act)-4350;
	MOVF        FARG_DACx_Service_AFR_Val+0, 0 
	MOVWF       FARG_LinFit_X+0 
	MOVF        FARG_DACx_Service_AFR_Val+1, 0 
	MOVWF       FARG_LinFit_X+1 
	MOVLW       _DAC_LINEAR+0
	MOVWF       FARG_LinFit_pTab+0 
	MOVLW       hi_addr(_DAC_LINEAR+0)
	MOVWF       FARG_LinFit_pTab+1 
	MOVLW       2
	MOVWF       FARG_LinFit_Tab_size+0 
	CALL        _LinFit+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC2_Out+0 
	MOVF        R1, 0 
	MOVWF       _DAC2_Out+1 
L_DACx_Service106:
;main.c,367 :: 		DACx_mV_Out_10bit(2, DAC2_Out);    // dtto DAC 2 vystup
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        _DAC2_Out+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        _DAC2_Out+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;main.c,368 :: 		}
L_end_DACx_Service:
	RETURN      0
; end of _DACx_Service

_UART_Service:

;main.c,371 :: 		void UART_Service() {
;main.c,372 :: 		UART_PrintTxt(1," AFR=");   UART_PrintU16(1,AFR_act);    //WordToStr(AFR_act,_txtU16);  UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr32_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr32_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _AFR_act+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _AFR_act+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,374 :: 		UART_PrintTxt(1," Vbat= "); UART_PrintU16(1,Vbat_mV );  //WordToStr(Vbat_mV,_txtU16);  UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr33_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr33_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Vbat_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Vbat_mV+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,375 :: 		UART_PrintTxt(1," UA="); UART_PrintU16(1,UA_mV);    //WordToStr(UA_avg,_txtU16);   UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr34_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr34_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _UA_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _UA_mV+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,376 :: 		UART_PrintTxt(1," UR=");    UART_PrintU16(1,UR_mV);     //WordToStr(UR_mV,_txtU16);    UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr35_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr35_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _UR_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _UR_mV+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,379 :: 		UART_PrintTxt(1," DAC2=");  UART_PrintU16(1,DAC2_Out); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr36_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr36_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC2_Out+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _DAC2_Out+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,381 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,382 :: 		}
L_end_UART_Service:
	RETURN      0
; end of _UART_Service

_DACx_Err_Mode:

;main.c,384 :: 		void DACx_Err_Mode(u16 start_DAC,u16 max_DAC_add, u16 step) {  // plynule zvetsuje DAC1/2 vystupy z DACx_INIT voltage max. o max_DAC_add
;main.c,385 :: 		u16 DAC_out =0;
	CLRF        DACx_Err_Mode_DAC_out_L0+0 
	CLRF        DACx_Err_Mode_DAC_out_L0+1 
;main.c,387 :: 		if (DAC_ERR_CNT < max_DAC_add) DAC_ERR_CNT += step;
	MOVF        FARG_DACx_Err_Mode_max_DAC_add+1, 0 
	SUBWF       _DAC_ERR_CNT+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_Err_Mode154
	MOVF        FARG_DACx_Err_Mode_max_DAC_add+0, 0 
	SUBWF       _DAC_ERR_CNT+0, 0 
L__DACx_Err_Mode154:
	BTFSC       STATUS+0, 0 
	GOTO        L_DACx_Err_Mode107
	MOVF        FARG_DACx_Err_Mode_step+0, 0 
	ADDWF       _DAC_ERR_CNT+0, 1 
	MOVF        FARG_DACx_Err_Mode_step+1, 0 
	ADDWFC      _DAC_ERR_CNT+1, 1 
	GOTO        L_DACx_Err_Mode108
L_DACx_Err_Mode107:
;main.c,388 :: 		else DAC_ERR_CNT = 0;
	CLRF        _DAC_ERR_CNT+0 
	CLRF        _DAC_ERR_CNT+1 
L_DACx_Err_Mode108:
;main.c,390 :: 		DAC_out = start_DAC + DAC_ERR_CNT;
	MOVF        _DAC_ERR_CNT+0, 0 
	ADDWF       FARG_DACx_Err_Mode_start_DAC+0, 0 
	MOVWF       R0 
	MOVF        _DAC_ERR_CNT+1, 0 
	ADDWFC      FARG_DACx_Err_Mode_start_DAC+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       DACx_Err_Mode_DAC_out_L0+0 
	MOVF        R1, 0 
	MOVWF       DACx_Err_Mode_DAC_out_L0+1 
;main.c,391 :: 		DACx_mV_Out_10bit(1,DAC_out); DACx_mV_Out_10bit(2,DAC_out); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        R0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        R1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        DACx_Err_Mode_DAC_out_L0+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        DACx_Err_Mode_DAC_out_L0+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,393 :: 		}
L_end_DACx_Err_Mode:
	RETURN      0
; end of _DACx_Err_Mode

_OLED_Show_AFR:

;main.c,395 :: 		void OLED_Show_AFR(u16 Afr, u16 Vbat)  // zobrazi na pozici  [0,2] 14 pak [71,2] tecku aka 5x5 ctverecek a na [71,2] za destin. carkou  napr 1489 => 14.89
;main.c,397 :: 		SSD1306_ClearDisplay();
	CALL        _SSD1306_ClearDisplay+0, 0
;main.c,398 :: 		SSD1306_FillRect(60,43,5,5);  // desetinna tecka
	MOVLW       60
	MOVWF       FARG_SSD1306_FillRect_x+0 
	MOVLW       43
	MOVWF       FARG_SSD1306_FillRect_y+0 
	MOVLW       5
	MOVWF       FARG_SSD1306_FillRect_w+0 
	MOVLW       5
	MOVWF       FARG_SSD1306_FillRect_h+0 
	CALL        _SSD1306_FillRect+0, 0
;main.c,399 :: 		SSD1306_TextSize(5);  // velky font
	MOVLW       5
	MOVWF       FARG_SSD1306_TextSize_t_size+0 
	CALL        _SSD1306_TextSize+0, 0
;main.c,400 :: 		SSD1306_GotoXY(0, 2);  sprintf(Tmp_buf,"%u",Afr/100); SSD1306_Print(Tmp_buf);  // 1489=> 14
	CLRF        FARG_SSD1306_GotoXY_x+0 
	MOVLW       2
	MOVWF       FARG_SSD1306_GotoXY_y+0 
	CALL        _SSD1306_GotoXY+0, 0
	MOVLW       _Tmp_buf+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_Tmp_buf+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_37_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_37_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_37_main+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_OLED_Show_AFR_Afr+0, 0 
	MOVWF       R0 
	MOVF        FARG_OLED_Show_AFR_Afr+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
	MOVLW       _Tmp_buf+0
	MOVWF       FARG_SSD1306_Print_s+0 
	MOVLW       hi_addr(_Tmp_buf+0)
	MOVWF       FARG_SSD1306_Print_s+1 
	CALL        _SSD1306_Print+0, 0
;main.c,401 :: 		SSD1306_GotoXY(71, 2); sprintf(Tmp_buf,"%u",Afr%100); SSD1306_Print(Tmp_buf);  // 1489=> 89
	MOVLW       71
	MOVWF       FARG_SSD1306_GotoXY_x+0 
	MOVLW       2
	MOVWF       FARG_SSD1306_GotoXY_y+0 
	CALL        _SSD1306_GotoXY+0, 0
	MOVLW       _Tmp_buf+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_Tmp_buf+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_38_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_38_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_38_main+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_OLED_Show_AFR_Afr+0, 0 
	MOVWF       R0 
	MOVF        FARG_OLED_Show_AFR_Afr+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
	MOVLW       _Tmp_buf+0
	MOVWF       FARG_SSD1306_Print_s+0 
	MOVLW       hi_addr(_Tmp_buf+0)
	MOVWF       FARG_SSD1306_Print_s+1 
	CALL        _SSD1306_Print+0, 0
;main.c,407 :: 		SSD1306_FillRect(60,43,5,5);  // desetinna tecka
	MOVLW       60
	MOVWF       FARG_SSD1306_FillRect_x+0 
	MOVLW       43
	MOVWF       FARG_SSD1306_FillRect_y+0 
	MOVLW       5
	MOVWF       FARG_SSD1306_FillRect_w+0 
	MOVLW       5
	MOVWF       FARG_SSD1306_FillRect_h+0 
	CALL        _SSD1306_FillRect+0, 0
;main.c,408 :: 		SSD1306_Display();
	CALL        _SSD1306_Display+0, 0
;main.c,409 :: 		}
L_end_OLED_Show_AFR:
	RETURN      0
; end of _OLED_Show_AFR
