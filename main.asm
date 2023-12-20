
_interrupt:

;main.c,56 :: 		void interrupt() {
;main.c,57 :: 		char tmp=0,i=0;
;main.c,58 :: 		u16 RX_cnt=0;
;main.c,60 :: 		if (TMR6IF_bit && TMR6IE_bit){      // 10ms timer pro tlacitka - trva cca 64instrukci + LED
	BTFSS       TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
	GOTO        L_interrupt2
	BTFSS       TMR6IE_bit+0, BitPos(TMR6IE_bit+0) 
	GOTO        L_interrupt2
L__interrupt118:
;main.c,62 :: 		if      (LED1_Tresh == 255)        LED1 = 1;  // trvaly svit
	MOVF        _LED1_Tresh+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
	BSF         LED1+0, BitPos(LED1+0) 
	GOTO        L_interrupt4
L_interrupt3:
;main.c,63 :: 		else if (LED1_Tresh == 0)          LED1 = 0;  // trvale OFF
	MOVF        _LED1_Tresh+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
	BCF         LED1+0, BitPos(LED1+0) 
	GOTO        L_interrupt6
L_interrupt5:
;main.c,64 :: 		else if (LED1_Cnt >= LED1_Tresh) { LED1 ^= 1; LED1_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
	MOVLW       0
	SUBWF       _LED1_Cnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt122
	MOVF        _LED1_Tresh+0, 0 
	SUBWF       _LED1_Cnt+0, 0 
L__interrupt122:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt7
	BTG         LED1+0, BitPos(LED1+0) 
	CLRF        _LED1_Cnt+0 
	CLRF        _LED1_Cnt+1 
L_interrupt7:
L_interrupt6:
L_interrupt4:
;main.c,66 :: 		if      (LED2_Tresh == 255)        LED2 = 1;  // trvaly svit
	MOVF        _LED2_Tresh+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
	BSF         LED2+0, BitPos(LED2+0) 
	GOTO        L_interrupt9
L_interrupt8:
;main.c,67 :: 		else if (LED2_Tresh == 0)          LED2 = 0;  // trvale OFF
	MOVF        _LED2_Tresh+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
	BCF         LED2+0, BitPos(LED2+0) 
	GOTO        L_interrupt11
L_interrupt10:
;main.c,68 :: 		else if (LED2_Cnt >= LED2_Tresh) { LED2 ^= 1; LED2_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
	MOVLW       0
	SUBWF       _LED2_Cnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt123
	MOVF        _LED2_Tresh+0, 0 
	SUBWF       _LED2_Cnt+0, 0 
L__interrupt123:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	BTG         LED2+0, BitPos(LED2+0) 
	CLRF        _LED2_Cnt+0 
	CLRF        _LED2_Cnt+1 
L_interrupt12:
L_interrupt11:
L_interrupt9:
;main.c,70 :: 		if      (LED3_Tresh == 255)        LED3 = 1;  // trvaly svit
	MOVF        _LED3_Tresh+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt13
	BSF         LED3+0, BitPos(LED3+0) 
	GOTO        L_interrupt14
L_interrupt13:
;main.c,71 :: 		else if (LED3_Tresh == 0)          LED3 = 0;  // trvale OFF
	MOVF        _LED3_Tresh+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
	BCF         LED3+0, BitPos(LED3+0) 
	GOTO        L_interrupt16
L_interrupt15:
;main.c,72 :: 		else if (LED3_Cnt >= LED3_Tresh) { LED3 ^= 1; LED3_Cnt = 0; }  // do 5us vs ca 95us pac deleni 16bit    else if(!(LED_Cnt % LED1_Blink))  LED1 ^= 1;   // toglovacka s LED v zadanem intervalu
	MOVLW       0
	SUBWF       _LED3_Cnt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt124
	MOVF        _LED3_Tresh+0, 0 
	SUBWF       _LED3_Cnt+0, 0 
L__interrupt124:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
	BTG         LED3+0, BitPos(LED3+0) 
	CLRF        _LED3_Cnt+0 
	CLRF        _LED3_Cnt+1 
L_interrupt17:
L_interrupt16:
L_interrupt14:
;main.c,74 :: 		LED1_Cnt++; LED2_Cnt++; LED3_Cnt++;
	INFSNZ      _LED1_Cnt+0, 1 
	INCF        _LED1_Cnt+1, 1 
	INFSNZ      _LED2_Cnt+0, 1 
	INCF        _LED2_Cnt+1, 1 
	INFSNZ      _LED3_Cnt+0, 1 
	INCF        _LED3_Cnt+1, 1 
;main.c,75 :: 		TMR6IF_bit = 0;
	BCF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
;main.c,76 :: 		return;
	GOTO        L__interrupt121
;main.c,77 :: 		} // TMR6IF
L_interrupt2:
;main.c,80 :: 		if (TMR0IF_bit && TMR0IE_bit){ // pro PID po 50/100ms viz HW_ini.c
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt20
	BTFSS       TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
	GOTO        L_interrupt20
L__interrupt117:
;main.c,81 :: 		_PID_Calc++;
	INCF        __PID_Calc+0, 1 
;main.c,82 :: 		DisplayRefreshCnt++;    // pro zobrazovani na 7seg LCD
	INCF        _DisplayRefreshCnt+0, 1 
;main.c,83 :: 		MeasStart=1;            // priznak, ze muzeme merit
	MOVLW       1
	MOVWF       _MeasStart+0 
;main.c,84 :: 		TMR0H = 0x3C; TMR0L = 0xB0; // 15536 pro pozadovany cas
	MOVLW       60
	MOVWF       TMR0H+0 
	MOVLW       176
	MOVWF       TMR0L+0 
;main.c,85 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,87 :: 		return;
	GOTO        L__interrupt121
;main.c,88 :: 		}
L_interrupt20:
;main.c,92 :: 		if (RC1IF_bit && RC1IE_bit){ // UART1 IRQ  - ceka na prikaz ukonceny d10
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt23
	BTFSS       RC1IE_bit+0, BitPos(RC1IE_bit+0) 
	GOTO        L_interrupt23
L__interrupt116:
;main.c,95 :: 		LED_RED_100ms
	MOVLW       10
	MOVWF       _LED3_Tresh+0 
;main.c,96 :: 		BUF1_TIMEOUT = BUF1_OVERR = BUF1_TEMINATED = 0;   // flag na preteceni bufferu 2
	BCF         _rU1+0, 2 
	BTFSC       _rU1+0, 2 
	GOTO        L__interrupt125
	BCF         _rU1+0, 0 
	GOTO        L__interrupt126
L__interrupt125:
	BSF         _rU1+0, 0 
L__interrupt126:
	BTFSC       _rU1+0, 0 
	GOTO        L__interrupt127
	BCF         _rU1+0, 1 
	GOTO        L__interrupt128
L__interrupt127:
	BSF         _rU1+0, 1 
L__interrupt128:
;main.c,97 :: 		UART1_NEW_DATA = 1;   // bit - indikace novych dat - nastavime zde, v pripade chyb se nize nuluje
	BSF         _rU1+0, 3 
;main.c,98 :: 		rU1.ch = rU1.CntBuf = rU1.TimeCnt= 0;
	CLRF        _rU1+7 
	CLRF        _rU1+8 
	CLRF        _rU1+9 
	CLRF        _rU1+10 
	CLRF        _rU1+1 
;main.c,99 :: 		while(!BUF1_OVERR && !BUF1_TIMEOUT && !BUF1_TEMINATED) {  //max (RX_BUF_LEN-1) znaku a timeout 100ms + ukoncuje znak d10
L_interrupt24:
	BTFSC       _rU1+0, 0 
	GOTO        L_interrupt25
	BTFSC       _rU1+0, 1 
	GOTO        L_interrupt25
	BTFSC       _rU1+0, 2 
	GOTO        L_interrupt25
L__interrupt115:
;main.c,100 :: 		if(RC1IF_bit) { // neco je ve FIFO ?, max 6 znaku celkem muze prijit + ukoncovaci - RCIF JE JEN PRO CTENI !! KDYZ 1 je neco ve FIFO
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt28
;main.c,101 :: 		UART1_FIX_ERR   // osetreni pripadnych chyb na UARTU
	BTFSC       FERR1_bit+0, BitPos(FERR1_bit+0) 
	GOTO        L__interrupt114
	BTFSC       OERR1_bit+0, BitPos(OERR1_bit+0) 
	GOTO        L__interrupt114
	GOTO        L_interrupt31
L__interrupt114:
	BCF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt129
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt130
L__interrupt129:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt130:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt131
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt132
L__interrupt131:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt132:
	BSF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt133
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt134
L__interrupt133:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt134:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt135
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt136
L__interrupt135:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt136:
L_interrupt31:
;main.c,102 :: 		rU1.ch = RC1REG;  // cteme prijaty znak z RCREG
	MOVF        RC1REG+0, 0 
	MOVWF       _rU1+1 
;main.c,103 :: 		if (rU1.CntBuf < (rU1.BufLen-1)) { // je jeste volny buffer ?
	MOVLW       1
	SUBWF       _rU1+11, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      _rU1+12, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       _rU1+10, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt137
	MOVF        R1, 0 
	SUBWF       _rU1+9, 0 
L__interrupt137:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt32
;main.c,104 :: 		if (rU1.UseASCII) { // ASCII mod ?
	MOVF        _rU1+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;main.c,105 :: 		if (rU1.UseTermCh) { // pouzivame termchar ?
	MOVF        _rU1+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt34
;main.c,106 :: 		if (rU1.ch > 31) RX_buf[rU1.CntBuf++] = rU1.ch; // rU1.pRxBuf  ch ulozime do bufferu jen kdyz je tisknutelny znak
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
;main.c,107 :: 		if (rU1.ch == rU1.TermCh) BUF1_TEMINATED = 1;    // prisel ukoncovaci znak, nastavime priznak
	MOVF        _rU1+1, 0 
	XORWF       _rU1+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt36
	BSF         _rU1+0, 2 
L_interrupt36:
;main.c,108 :: 		} // if rU1.UseTermChar
	GOTO        L_interrupt37
L_interrupt34:
;main.c,109 :: 		else {            RX_buf[rU1.CntBuf++] = rU1.ch; }  // ASCII mod bez termcharu
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
;main.c,110 :: 		}  // if rU1.UseASCII
	GOTO        L_interrupt38
L_interrupt33:
;main.c,111 :: 		else {  RX_buf[rU1.CntBuf++] = rU1.ch; } // RX_buf[rU1.CntBuf++] = rU1.ch; } // rU1.pRxBuf[rU1.CntBuf++] = rU1.ch; } // binary mod - ukladame veskere znaky 0-255
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
;main.c,112 :: 		}  // if (rU1.CntBuf < (RX_buf_LEN-1)) { // je plny buffer ?
	GOTO        L_interrupt39
L_interrupt32:
;main.c,114 :: 		BUF1_OVERR = 1;   // ... buffer pretekl, tudiz zadne nova data a koncime
	BSF         _rU1+0, 0 
;main.c,115 :: 		UART1_NEW_DATA = 0;  //..timpadem nemame validni data
	BCF         _rU1+0, 3 
;main.c,116 :: 		} // else // if (rU1.CntBuf < (rU1.BufLen-1)) { // je jeste volny buffer ?
L_interrupt39:
;main.c,117 :: 		}// if (RC1IF)
L_interrupt28:
;main.c,118 :: 		rU1.TimeCnt++;   // inkrementujeme timer
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
;main.c,119 :: 		if (rU1.TimeCnt > rU1.TIMEOUT) BUF1_TIMEOUT = 1; // uplynul timout na vycteni ?
	MOVF        _rU1+8, 0 
	SUBWF       _rU1+6, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt138
	MOVF        _rU1+7, 0 
	SUBWF       _rU1+5, 0 
L__interrupt138:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt40
	BSF         _rU1+0, 1 
L_interrupt40:
;main.c,120 :: 		Delay_us(2); //5
	MOVLW       2
	MOVWF       R13, 0
L_interrupt41:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt41
	NOP
;main.c,121 :: 		} // while
	GOTO        L_interrupt24
L_interrupt25:
;main.c,122 :: 		RX_buf[rU1.CntBuf] = 0x00;  // pridame 0x00 za posledni prijaty znak/cislo
	MOVLW       _RX_buf+0
	ADDWF       _rU1+9, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	ADDWFC      _rU1+10, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;main.c,123 :: 		if (BUF1_TIMEOUT) {  // osetreni timeoutu
	BTFSS       _rU1+0, 1 
	GOTO        L_interrupt42
;main.c,124 :: 		if (rU1.UseASCII && rU1.UseTermCh && (BUF1_TEMINATED!=1))
	MOVF        _rU1+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt45
	MOVF        _rU1+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt45
	BTFSC       _rU1+0, 2 
	GOTO        L_interrupt45
L__interrupt113:
;main.c,125 :: 		UART1_NEW_DATA = 0;  // pouzivame Term char ale ten neprisel -> zadna validni data
	BCF         _rU1+0, 3 
L_interrupt45:
;main.c,126 :: 		}
L_interrupt42:
;main.c,127 :: 		if (BUF1_OVERR) { // pretekl buufer - vse dovycteme a pak konec
	BTFSS       _rU1+0, 0 
	GOTO        L_interrupt46
;main.c,128 :: 		Delay_ms(10);
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
;main.c,129 :: 		while (RC1IF_bit) {UART1_FIX_ERR RX_buf[rU1.ch] = RC1REG; Delay_us(20); }   // jen vycitame data, dokud jsou,
L_interrupt48:
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt49
	BTFSC       FERR1_bit+0, BitPos(FERR1_bit+0) 
	GOTO        L__interrupt112
	BTFSC       OERR1_bit+0, BitPos(OERR1_bit+0) 
	GOTO        L__interrupt112
	GOTO        L_interrupt52
L__interrupt112:
	BCF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt139
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt140
L__interrupt139:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt140:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt141
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt142
L__interrupt141:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt142:
	BSF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__interrupt143
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt144
L__interrupt143:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__interrupt144:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__interrupt145
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__interrupt146
L__interrupt145:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__interrupt146:
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
;main.c,130 :: 		UART1_NEW_DATA = 0;
	BCF         _rU1+0, 3 
;main.c,131 :: 		} // if BUF1_Overr
L_interrupt46:
;main.c,133 :: 		return;
	GOTO        L__interrupt121
;main.c,134 :: 		} // if RCIF
L_interrupt23:
;main.c,135 :: 		} // interrupt
L_end_interrupt:
L__interrupt121:
	RETFIE      1
; end of _interrupt

_main:

;main.c,141 :: 		void main() {
;main.c,142 :: 		u16 i=0, RXdata=0, CJ125_Status=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
	CLRF        main_tst_mode_L0+0 
	CLRF        main_USE_UART1_L0+0 
	CLRF        main_DAC_Set_L0+0 
	CLRF        main_DAC_Set_L0+1 
;main.c,147 :: 		START_TMR6      // dtto pro Timer 6 (IRQ po 10ms)
	BSF         TMR6IE_bit+0, BitPos(TMR6IE_bit+0) 
;main.c,148 :: 		START:
___main_START:
;main.c,149 :: 		HW_Init();      // all include UART's....
	CALL        _HW_Init+0, 0
;main.c,150 :: 		ALL_LEDs_OFF
	CLRF        _LED1_Tresh+0 
	CLRF        _LED2_Tresh+0 
	CLRF        _LED3_Tresh+0 
;main.c,152 :: 		UART_Welcome(1,EE_Consts);
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
;main.c,153 :: 		USE_UART1 = _UART1_LISTING(EE_Consts.OPTION);
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
;main.c,154 :: 		if (USE_UART1) { UART_PrintTxt(1,"USE UART1 for listing"); CR_LF(1); }
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
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
L_main57:
;main.c,156 :: 		do {
L_main58:
;main.c,157 :: 		if (UART1_NEW_DATA) {  // nejky prikaz na UART 1 ?   max 2s po zapnuti
	BTFSS       _rU1+0, 3 
	GOTO        L_main61
;main.c,158 :: 		i = 101;      //zustaneme zde navzdy
	MOVLW       101
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
;main.c,160 :: 		DAC_Set = DAC_14p7_VOLT;
	MOVLW       108
	MOVWF       main_DAC_Set_L0+0 
	MOVLW       12
	MOVWF       main_DAC_Set_L0+1 
;main.c,161 :: 		DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
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
;main.c,162 :: 		UART_PrintTxt(1,"Enetered to test mode, DAC1/2 outputs set to 14.7AFR => ");UART_PrintU16(1,DAC_14p7_VOLT); UART_PrintTxt(1,"mV"); CR_LF(1); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr2_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr2_main+0)
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
	MOVLW       ?lstr3_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr3_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,163 :: 		i=102;
	MOVLW       102
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
;main.c,165 :: 		tst_mode=1;
	MOVLW       1
	MOVWF       main_tst_mode_L0+0 
;main.c,166 :: 		ALL_LEDs_ON;
	MOVLW       255
	MOVWF       _LED1_Tresh+0 
	MOVLW       255
	MOVWF       _LED2_Tresh+0 
	MOVLW       255
	MOVWF       _LED3_Tresh+0 
;main.c,167 :: 		UART1_NEW_DATA = 0;
	BCF         _rU1+0, 3 
;main.c,168 :: 		if (!__SET_DACtoXXXXX(RX_buf)) {  // nastavi oba DACi na dane mV (syntaxe DAC=1500 - bez ukoncovaciho znaku)
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr4_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr4_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       4
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main63
;main.c,169 :: 		ADC_COEF_OFS_EEPROM =  EEPROM_Read(ADC_OFFSET_ADR); delay_ms(20);
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
;main.c,170 :: 		str_cut_left(RX_buf,4); DAC_Set=atoi(RX_buf); UART_PrintTxt(1," >DACx set to ="); UART_PrintU16(1,DAC_Set);   // odestrani DAC= a zbyde jen cislo ve stringu,na prevod
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
	MOVLW       ?lstr5_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr5_main+0)
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
;main.c,171 :: 		DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set); CR_LF(1);
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
;main.c,172 :: 		} // if __SET_DAC
	GOTO        L_main65
L_main63:
;main.c,173 :: 		else if (!__GET_VBAT(RX_buf)) {
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr6_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr6_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       5
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main66
;main.c,174 :: 		VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
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
;main.c,175 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);
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
;main.c,176 :: 		UART_PrintTxt(1,">Vbat= "); UART_PrintU16(1,Vbat_mV); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr7_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr7_main+0)
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
;main.c,177 :: 		}
	GOTO        L_main68
L_main66:
;main.c,178 :: 		else if (!__SET_VBAT_OFFSET(RX_buf)) {
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr8_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr8_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       9
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main69
;main.c,179 :: 		VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20); UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_OLD="); UART_PrintI8(1,VBAT_COEF_OFS_EEPROM);  CR_LF(1);
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
	MOVLW       ?lstr9_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr9_main+0)
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
;main.c,180 :: 		str_cut_left(RX_buf,9); tmpi8=atoi(RX_buf); EEPROM_Write(VBAT_OFFSET_ADR,tmpi8); Delay_ms(20); VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR);
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
;main.c,181 :: 		VBAT_KOEF = (AD_KOEF * _VBAT_DIV) + VBAT_COEF_OFS_EEPROM;
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
;main.c,182 :: 		UART_PrintTxt(1,"  VBAT_KOEF_OFFSET_NEW="); UART_PrintI8(1,VBAT_COEF_OFS_EEPROM); UART_PrintTxt(1," VBAT_KOEF="); UART_PrintU16(1,VBAT_KOEF); CR_LF(1);
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
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr11_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr11_main+0)
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
;main.c,183 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);
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
;main.c,184 :: 		UART_PrintTxt(1,"  Vbat= "); UART_PrintU16(1,Vbat_mV); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr12_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr12_main+0)
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
;main.c,185 :: 		}
	GOTO        L_main72
L_main69:
;main.c,186 :: 		else if (!__SET_ADC_OFFSET(RX_buf)) {  // vyctze ADC_OFFSET konstantu z EEPROM, zapise novou a pro kontrolu vypise z EEPROM na UART (rozsah +/- 127)
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr13_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr13_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       8
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main73
;main.c,187 :: 		ADC_COEF_OFS_EEPROM = EEPROM_Read(ADC_OFFSET_ADR);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ADC_COEF_OFS_EEPROM+0 
;main.c,188 :: 		UART_PrintTxt(1,"ADC_KOEF_OFFSET_OLD="); UART_PrintI8(1,ADC_COEF_OFS_EEPROM); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr14_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr14_main+0)
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
;main.c,189 :: 		UART_PrintTxt(1," ADC_KOEF_OLD="); UART_PrintU16(1,AD_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr15_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr15_main+0)
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
;main.c,190 :: 		CR_LF(1); Delay_ms (20); // kvuli EEPROM
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
;main.c,191 :: 		str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write(ADC_OFFSET_ADR,tmpi8); Delay_ms(20); ADC_COEF_OFS_EEPROM = EEPROM_Read(ADC_OFFSET_ADR);
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
;main.c,192 :: 		AD_KOEF = _AD_CONST + ADC_COEF_OFS_EEPROM;
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
;main.c,193 :: 		UART_PrintTxt(1,"ADC_KOEF_OFFSET_NEW="); UART_PrintI8(1,ADC_COEF_OFS_EEPROM);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr16_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr16_main+0)
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
;main.c,194 :: 		UART_PrintTxt(1," ADC_KOEF="); UART_PrintU16(1,AD_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr17_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr17_main+0)
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
;main.c,195 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
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
L_main76:
	DECFSZ      R13, 1, 1
	BRA         L_main76
	DECFSZ      R12, 1, 1
	BRA         L_main76
	NOP
;main.c,197 :: 		VBAT_KOEF = (AD_KOEF * _VBAT_DIV) + VBAT_COEF_OFS_EEPROM;
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
;main.c,198 :: 		UART_PrintTxt(1,"  Vbat= "); UART_PrintU16(1,Vbat_mV);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr18_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr18_main+0)
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
;main.c,199 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,200 :: 		}
	GOTO        L_main77
L_main73:
;main.c,201 :: 		else if (!__SET_DAC_OFFSET(RX_buf)) {  // vyctze DAC_OFFSET konstantu z EEPROM, zapise novou a pro kontrolu vypise z EEPROM na UART (rozsah +/- 127)
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr19_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr19_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       8
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main78
;main.c,202 :: 		DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC_COEF_OFS_EEPROM+0 
;main.c,203 :: 		UART_PrintTxt(1,"DAC_KOEF_OFFSET_OLD="); UART_PrintI8(1,DAC_COEF_OFS_EEPROM); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr20_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr20_main+0)
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
;main.c,204 :: 		UART_PrintTxt(1," DAC_KOEF_OLD="); UART_PrintU16(1,DAC_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr21_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr21_main+0)
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
;main.c,205 :: 		CR_LF(1); Delay_ms (20); // kvuli EEPROM
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
;main.c,206 :: 		str_cut_left(RX_buf,8); tmpi8=atoi(RX_buf); EEPROM_Write(DAC_OFFSET_ADR,tmpi8); Delay_ms(20); DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
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
;main.c,207 :: 		DAC_KOEF = _DAC_CONST - DAC_COEF_OFS_EEPROM ;
	MOVF        R0, 0 
	SUBLW       233
	MOVWF       _DAC_KOEF+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       _DAC_KOEF+1 
	MOVLW       1
	SUBFWB      _DAC_KOEF+1, 1 
;main.c,208 :: 		UART_PrintTxt(1,"DAC_KOEF_OFFSET_NEW="); UART_PrintI8(1,DAC_COEF_OFS_EEPROM);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr22_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr22_main+0)
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
;main.c,209 :: 		UART_PrintTxt(1," DAC_KOEF="); UART_PrintU16(1,DAC_KOEF); // pred EEPROM zapisem dalsim
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr23_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr23_main+0)
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
;main.c,210 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,211 :: 		DACx_mV_Out_10bit(1,DAC_Set); DACx_mV_Out_10bit(2,DAC_Set);   // znovu nastavime DACy
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
;main.c,212 :: 		UART_PrintTxt(1," >DACx set to ="); UART_PrintU16(1,DAC_Set);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr24_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr24_main+0)
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
;main.c,213 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,214 :: 		}
	GOTO        L_main81
L_main78:
;main.c,220 :: 		else if (!__EXIT_CFG(RX_buf)) {
	MOVLW       _RX_buf+0
	MOVWF       FARG_strncmp_s1+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FARG_strncmp_s1+1 
	MOVLW       ?lstr25_main+0
	MOVWF       FARG_strncmp_s2+0 
	MOVLW       hi_addr(?lstr25_main+0)
	MOVWF       FARG_strncmp_s2+1 
	MOVLW       4
	MOVWF       FARG_strncmp_len+0 
	CALL        _strncmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main82
;main.c,221 :: 		UART_PrintTxt(1,"Exit cfg mode.."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr26_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr26_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,222 :: 		tst_mode = 0;
	CLRF        main_tst_mode_L0+0 
;main.c,223 :: 		}
L_main82:
L_main81:
L_main77:
L_main72:
L_main68:
L_main65:
;main.c,225 :: 		}  // if (RX_FLAG) ========   ======
L_main61:
;main.c,227 :: 		if (i > 100) i = 102;
	MOVLW       0
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main148
	MOVF        main_i_L0+0, 0 
	SUBLW       100
L__main148:
	BTFSC       STATUS+0, 0 
	GOTO        L_main83
	MOVLW       102
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
	GOTO        L_main84
L_main83:
;main.c,228 :: 		else { UART_PrintCh(1,'-'); i++; }
	MOVLW       1
	MOVWF       FARG_UART_PrintCh_Nr+0 
	MOVLW       45
	MOVWF       FARG_UART_PrintCh_ch+0 
	CALL        _UART_PrintCh+0, 0
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
L_main84:
;main.c,229 :: 		delay_ms(20);
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
;main.c,230 :: 		} while ((i < 100) || (tst_mode == 1)) ;
	MOVLW       0
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main149
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
L__main149:
	BTFSS       STATUS+0, 0 
	GOTO        L_main58
	MOVF        main_tst_mode_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
L__main119:
;main.c,232 :: 		RC1IE_bit = 0;         // Uart 1 Rx OFF
	BCF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;main.c,233 :: 		ALL_LEDs_OFF
	CLRF        _LED1_Tresh+0 
	CLRF        _LED2_Tresh+0 
	CLRF        _LED3_Tresh+0 
;main.c,238 :: 		CJ125_Test();    // test obvodu CJ125
	CALL        _CJ125_Test+0, 0
;main.c,239 :: 		CJ125_Ri_Cal(LSU49);  // kalibrace Ur - zalezi jen na osazeni Ri odporu, ne na pripojene sonde
	MOVLW       1
	MOVWF       FARG_CJ125_Ri_Cal_LSU+0 
	CALL        _CJ125_Ri_Cal+0, 0
;main.c,240 :: 		LED_RED_100ms;
	MOVLW       10
	MOVWF       _LED3_Tresh+0 
;main.c,241 :: 		do {      // test, zda je pripojena sonda - muze zde zustat navzdy
L_main88:
;main.c,242 :: 		CJ125_Ans = CJ125_Sensor_Test();
	CALL        _CJ125_Sensor_Test+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;main.c,243 :: 		DACx_Err_Mode(50, 50, 50); // plynule zvetsujeme DAC1/2 out po dobu chyby - cca 6.75-7.1AFR
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
;main.c,244 :: 		delay_ms(500);
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
;main.c,245 :: 		} while (CJ125_Ans != CJ125_DIAG_REG_STATUS_OK);
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__main150
	MOVLW       255
	XORWF       _CJ125_Ans+0, 0 
L__main150:
	BTFSS       STATUS+0, 2 
	GOTO        L_main88
;main.c,246 :: 		DAC_ERR_CNT=0;
	CLRF        _DAC_ERR_CNT+0 
	CLRF        _DAC_ERR_CNT+1 
;main.c,247 :: 		LED_BLUE_100ms;
	MOVLW       10
	MOVWF       _LED1_Tresh+0 
;main.c,249 :: 		DACx_Service(400, DAC2_NO_GAUGE); // sensor je ok, zaciname heating -> oba DACy na AFR 8.00
	MOVLW       144
	MOVWF       FARG_DACx_Service_AFR_Val+0 
	MOVLW       1
	MOVWF       FARG_DACx_Service_AFR_Val+1 
	CLRF        FARG_DACx_Service_UseGauge+0 
	CALL        _DACx_Service+0, 0
;main.c,250 :: 		DACx_Err_Mode(450, 450, 50); // plynule zvetsujeme DAC1/2 out po dobu chyby - cca 6.75-7.1AFR
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
;main.c,251 :: 		CJ125_Vbat_check();     // cekame na spravnou hodnotu Vbat, pripadne Vbat + DELTA_VBAT => doslo k nastartovani
	CALL        _CJ125_Vbat_check+0, 0
;main.c,252 :: 		LED_BLUE_ON; LED_RED_OFF;
	MOVLW       255
	MOVWF       _LED1_Tresh+0 
	CLRF        _LED3_Tresh+0 
;main.c,253 :: 		CJ125_PreHeat_LSU(LSU49);
	MOVLW       1
	MOVWF       FARG_CJ125_PreHeat_LSU_LSU+0 
	CALL        _CJ125_PreHeat_LSU+0, 0
;main.c,254 :: 		LED_BLUE_OFF;
	CLRF        _LED1_Tresh+0 
;main.c,256 :: 		START_PID_TMR   // spusti timer pro PID regulaci - tam bezi
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,257 :: 		LED_GREEN_1s
	MOVLW       100
	MOVWF       _LED2_Tresh+0 
;main.c,262 :: 		while(1){
L_main92:
;main.c,264 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;main.c,265 :: 		if (CJ125_Ans !=  CJ125_DIAG_REG_STATUS_OK) {
	MOVF        R1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__main151
	MOVLW       255
	XORWF       R0, 0 
L__main151:
	BTFSC       STATUS+0, 2 
	GOTO        L_main94
;main.c,266 :: 		UART_PrintTxt(1,"LSU sensor disconnected/failure, ");  //CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr27_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr27_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,267 :: 		Heat_PWM = 0;
	CLRF        _Heat_PWM+0 
	CLRF        _Heat_PWM+1 
;main.c,269 :: 		STOP_PID_TMR
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,270 :: 		UART_PrintTxt(1,"waiting for reconnecting...."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr28_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr28_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,271 :: 		do {
L_main95:
;main.c,272 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;main.c,273 :: 		delay_ms(500); UART_PrintTxt(1,".");
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
	MOVLW       ?lstr29_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr29_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;main.c,274 :: 		ALL_LEDs_OFF; LED_RED_100ms;  // blikame red jako chyba
	CLRF        _LED1_Tresh+0 
	CLRF        _LED2_Tresh+0 
	CLRF        _LED3_Tresh+0 
	MOVLW       10
	MOVWF       _LED3_Tresh+0 
;main.c,275 :: 		DACx_Err_Mode(50, 50, 50); // chyba AFR - cca 6.75 - 7.1 cyklujeme DACy
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
;main.c,276 :: 		} while (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOSENSOR);// CR_LF(1);
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__main152
	MOVLW       127
	XORWF       _CJ125_Ans+0, 0 
L__main152:
	BTFSC       STATUS+0, 2 
	GOTO        L_main95
;main.c,277 :: 		UART_PrintTxt(1,"Sensor re-connected, going back to starting procedure...."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr30_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr30_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,278 :: 		delay_ms(1000);
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
;main.c,279 :: 		goto START;
	GOTO        ___main_START
;main.c,280 :: 		}
L_main94:
;main.c,283 :: 		if (_PID_Calc >= PID_REFRESH) {  // v IRQ timer se nastavi na 1 po 100ms - provedeme update PID topeni
	MOVLW       5
	SUBWF       __PID_Calc+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main100
;main.c,284 :: 		_PID_Calc = 0;                   // priznak hned mazeme, dalsi az po 100ms v IRQ  UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - vnitrni impedance
	CLRF        __PID_Calc+0 
;main.c,285 :: 		UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - vnitrni impedance
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
;main.c,286 :: 		Heat_PWM = LSU_PID_Heater_Service(UR_mV,UR_mV_ref);        // if (LED3) LED3=0; else LED3=1;    // jen pro debug
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
;main.c,287 :: 		} // if PID_Calc...
L_main100:
;main.c,290 :: 		if (MeasTime_Cnt >= MEAS_REFRESH) {          // cela fce cca 48ms s AD 256x vzroky, 30ms se 128x vzorky AD !!!
	MOVLW       5
	SUBWF       _MeasTime_Cnt+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main101
;main.c,291 :: 		MeasTime_Cnt = MeasStart=0;              // povoli az dalsi IRQ
	CLRF        _MeasStart+0 
	CLRF        _MeasTime_Cnt+0 
;main.c,292 :: 		for (i=0; i <= MEAS_REFRESH; i++) UA_avg = UA_avg + UA_results[i];  // prumer zmerenych AFR z pole + i z toho predesleho AVG
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main102:
	MOVLW       0
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main153
	MOVF        main_i_L0+0, 0 
	SUBLW       5
L__main153:
	BTFSS       STATUS+0, 0 
	GOTO        L_main103
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _UA_results+0
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_UA_results+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	ADDWF       _UA_avg+0, 1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      _UA_avg+1, 1 
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
	GOTO        L_main102
L_main103:
;main.c,293 :: 		UA_avg =  UA_avg / (MEAS_REFRESH+1); // +1 protoze do prumeru bereme i predchozi hodnotu UA_avg
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _UA_avg+0, 0 
	MOVWF       R0 
	MOVF        _UA_avg+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _UA_avg+0 
	MOVF        R1, 0 
	MOVWF       _UA_avg+1 
;main.c,294 :: 		AFR_act = LinFit(CJ125_Calc_Ip(UA_avg,8), cj49Tab,CJ49_TAB_SIZE);   // cca 1.3-1.5ms (Ip pocitano s floaty)
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
;main.c,295 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);   // merime vbat
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
;main.c,303 :: 		DACx_Service(AFR_act, DAC2_NO_GAUGE);      // cca 1.5ms - obslouzeni analogovych vystupu
	MOVF        _AFR_act+0, 0 
	MOVWF       FARG_DACx_Service_AFR_Val+0 
	MOVF        _AFR_act+1, 0 
	MOVWF       FARG_DACx_Service_AFR_Val+1 
	CLRF        FARG_DACx_Service_UseGauge+0 
	CALL        _DACx_Service+0, 0
;main.c,304 :: 		} // if (MeasTime_Cnt...
	GOTO        L_main105
L_main101:
;main.c,306 :: 		UA_mV = Get_AD_mV(UA_AD_ch,AD_KOEF);   // merime UA napeti z CJ125 ~ "lambda"
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
;main.c,307 :: 		UA_results[MeasTime_Cnt] = UA_mV;      // ukladame data do pole UA (max 10)
	MOVF        _MeasTime_Cnt+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVLW       _UA_results+0
	ADDWF       R2, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_UA_results+0)
	ADDWFC      R3, 0 
	MOVWF       FSR1L+1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;main.c,308 :: 		MeasStart=0;  // povoli az dalsi IRQ
	CLRF        _MeasStart+0 
;main.c,309 :: 		MeasTime_Cnt++;
	INCF        _MeasTime_Cnt+0, 1 
;main.c,310 :: 		}; // else  (MeasTime...
L_main105:
;main.c,313 :: 		if (DisplayRefreshCnt >= DISP_REFRESH) { // cas na refresh AFR displeje   2 => 200ms => 5Hz
	MOVLW       5
	SUBWF       _DisplayRefreshCnt+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main106
;main.c,314 :: 		DisplayRefreshCnt = 0;
	CLRF        _DisplayRefreshCnt+0 
;main.c,315 :: 		if (USE_UART1) UART_Service();        // UART - posilani dat -  techto 6x vypisu na UART trva 10ms (115k2)
	MOVF        main_USE_UART1_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main107
	CALL        _UART_Service+0, 0
L_main107:
;main.c,316 :: 		} // if DisplayRefresh....
L_main106:
;main.c,317 :: 		} // while 1     ===================================================
	GOTO        L_main92
;main.c,319 :: 		}  // void main()
L_end_main:
	GOTO        $+0
; end of _main

_LSU_PID_Heater_Service:

;main.c,326 :: 		u16 LSU_PID_Heater_Service(u16 Ur_Act,u16 Ur_Target) {
;main.c,327 :: 		u16 PWM_Out=1;
	MOVLW       1
	MOVWF       LSU_PID_Heater_Service_PWM_Out_L0+0 
	MOVLW       0
	MOVWF       LSU_PID_Heater_Service_PWM_Out_L0+1 
;main.c,328 :: 		PWM_Out = (u8) Heater_PID_Control(LSU_TYPE, Ur_Act, Ur_Target);
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
;main.c,329 :: 		PWM4_Set_Duty(PWM_Out);
	MOVF        LSU_PID_Heater_Service_PWM_Out_L0+0, 0 
	MOVWF       FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
;main.c,330 :: 		return PWM_Out;
	MOVF        LSU_PID_Heater_Service_PWM_Out_L0+0, 0 
	MOVWF       R0 
	MOVF        LSU_PID_Heater_Service_PWM_Out_L0+1, 0 
	MOVWF       R1 
;main.c,331 :: 		}
L_end_LSU_PID_Heater_Service:
	RETURN      0
; end of _LSU_PID_Heater_Service

_DACx_Service:

;main.c,335 :: 		void DACx_Service(u16 AFR_Val,u8 UseGauge) {   // cca 1.5ms@16Mhz
;main.c,336 :: 		u8 x=0;
;main.c,339 :: 		DAC1_Out = LinFit(AFR_Val,DAC_LINEAR,DAC_LINEAR_SIZE);    // AFR 9~0.15V - 18.7~5.0V
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
;main.c,340 :: 		DACx_mV_Out_10bit(1, DAC1_Out);    // zapiseme DAC 1 vystup
	MOVLW       1
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        R0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        R1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;main.c,342 :: 		if (UseGauge) DAC2_Out = LinFit(AFR_Val, Innov_818_Tab,INOV818_TAB_SIZE);  // Innovate gauge 8-18AFR (1V - 0V)
	MOVF        FARG_DACx_Service_UseGauge+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_DACx_Service108
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
	GOTO        L_DACx_Service109
L_DACx_Service108:
;main.c,343 :: 		else          DAC2_Out = LinFit(AFR_Val,DAC_LINEAR, DAC_LINEAR_SIZE);     // DAC2_Out = (5*AFR_act)-4350;
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
L_DACx_Service109:
;main.c,344 :: 		DACx_mV_Out_10bit(2, DAC2_Out);    // dtto DAC 2 vystup
	MOVLW       2
	MOVWF       FARG_DACx_mV_Out_10bit_ch+0 
	MOVF        _DAC2_Out+0, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+0 
	MOVF        _DAC2_Out+1, 0 
	MOVWF       FARG_DACx_mV_Out_10bit_OutmV+1 
	CALL        _DACx_mV_Out_10bit+0, 0
;main.c,345 :: 		}
L_end_DACx_Service:
	RETURN      0
; end of _DACx_Service

_UART_Service:

;main.c,348 :: 		void UART_Service() {
;main.c,349 :: 		UART_PrintTxt(1," AFR=");   UART_PrintU16(1,AFR_act);    //WordToStr(AFR_act,_txtU16);  UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr31_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr31_main+0)
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
;main.c,351 :: 		UART_PrintTxt(1," Vbat= "); UART_PrintU16(1,Vbat_mV );  //WordToStr(Vbat_mV,_txtU16);  UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr32_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr32_main+0)
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
;main.c,352 :: 		UART_PrintTxt(1," UA="); UART_PrintU16(1,UA_avg);    //WordToStr(UA_avg,_txtU16);   UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr33_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr33_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _UA_avg+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _UA_avg+1, 0 
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
;main.c,353 :: 		UART_PrintTxt(1," UR=");    UART_PrintU16(1,UR_mV);     //WordToStr(UR_mV,_txtU16);    UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr34_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr34_main+0)
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
;main.c,354 :: 		UART_PrintTxt(1," PWM=");   UART_PrintU16(1,Heat_PWM ); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr35_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr35_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Heat_PWM+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Heat_PWM+1, 0 
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
;main.c,355 :: 		UART_PrintTxt(1," DAC1=");  UART_PrintU16(1,DAC1_Out); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr36_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr36_main+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC1_Out+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _DAC1_Out+1, 0 
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
;main.c,356 :: 		UART_PrintTxt(1," DAC2=");  UART_PrintU16(1,DAC2_Out); //WordToStr(Heat_PWM,_txtU16); UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr37_main+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr37_main+0)
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
;main.c,358 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;main.c,359 :: 		}
L_end_UART_Service:
	RETURN      0
; end of _UART_Service

_DACx_Err_Mode:

;main.c,361 :: 		void DACx_Err_Mode(u16 start_DAC,u16 max_DAC_add, u16 step) {  // plynule zvetsuje DAC1/2 vystupy z DACx_INIT voltage max. o max_DAC_add
;main.c,362 :: 		u16 DAC_out =0;
	CLRF        DACx_Err_Mode_DAC_out_L0+0 
	CLRF        DACx_Err_Mode_DAC_out_L0+1 
;main.c,364 :: 		if (DAC_ERR_CNT < max_DAC_add) DAC_ERR_CNT += step;
	MOVF        FARG_DACx_Err_Mode_max_DAC_add+1, 0 
	SUBWF       _DAC_ERR_CNT+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DACx_Err_Mode158
	MOVF        FARG_DACx_Err_Mode_max_DAC_add+0, 0 
	SUBWF       _DAC_ERR_CNT+0, 0 
L__DACx_Err_Mode158:
	BTFSC       STATUS+0, 0 
	GOTO        L_DACx_Err_Mode110
	MOVF        FARG_DACx_Err_Mode_step+0, 0 
	ADDWF       _DAC_ERR_CNT+0, 1 
	MOVF        FARG_DACx_Err_Mode_step+1, 0 
	ADDWFC      _DAC_ERR_CNT+1, 1 
	GOTO        L_DACx_Err_Mode111
L_DACx_Err_Mode110:
;main.c,365 :: 		else DAC_ERR_CNT = 0;
	CLRF        _DAC_ERR_CNT+0 
	CLRF        _DAC_ERR_CNT+1 
L_DACx_Err_Mode111:
;main.c,367 :: 		DAC_out = start_DAC + DAC_ERR_CNT;
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
;main.c,368 :: 		DACx_mV_Out_10bit(1,DAC_out); DACx_mV_Out_10bit(2,DAC_out); CR_LF(1);
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
;main.c,370 :: 		}
L_end_DACx_Err_Mode:
	RETURN      0
; end of _DACx_Err_Mode
