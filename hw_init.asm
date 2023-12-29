
_HW_Init:

;hw_init.c,20 :: 		void HW_Init() {
;hw_init.c,22 :: 		PORTA = LATA = 0;
	CLRF        LATA+0 
	MOVF        LATA+0, 0 
	MOVWF       PORTA+0 
;hw_init.c,23 :: 		ANSELA = 0b00100111;         // RA0-2,5 => A/D, RA3 - I/O IN (L_BUT0)
	MOVLW       39
	MOVWF       ANSELA+0 
;hw_init.c,24 :: 		TRISA  = 0b10101111;         // RA4- CCP5 - DAC2 PWM out
	MOVLW       175
	MOVWF       TRISA+0 
;hw_init.c,26 :: 		PORTB = LATB = 0;
	CLRF        LATB+0 
	MOVF        LATB+0, 0 
	MOVWF       PORTB+0 
;hw_init.c,27 :: 		ANSELB = 0;                // all digitals I/O     ; ;
	CLRF        ANSELB+0 
;hw_init.c,28 :: 		TRISB = 0b11000000;        // RB0- PWM CCP4 OUT spojen cinem s RB1(INPUT) - PIC_HEATER (pac RB1 nema CCPx unit)                        // RB5 - DAC2 Out
	MOVLW       192
	MOVWF       TRISB+0 
;hw_init.c,30 :: 		PORTC = LATC = 0b00000011;   // MAX7219 nCS OFF :> RC0 = log1, Bosch CJ125 - RC1 = log1 (OFF), RC2 - Bosch CJ125 - RST (log1 = working)
	MOVLW       3
	MOVWF       LATC+0 
	MOVF        LATC+0, 0 
	MOVWF       PORTC+0 
;hw_init.c,31 :: 		ANSELC = 0;                  // all digitals I/O
	CLRF        ANSELC+0 
;hw_init.c,32 :: 		TRISC = 0b11010000;          //0b10010000; - RC6/7 - UART 1 - both pins as INPUTS !! (see pdf page 260)
	MOVLW       208
	MOVWF       TRISC+0 
;hw_init.c,37 :: 		OSCCON  = 0b01010000;         // 4Mhz int osc 4*4 = 16Mhz
	MOVLW       80
	MOVWF       OSCCON+0 
;hw_init.c,39 :: 		PLLEN_bit = 1;               // * 4 = 32Mhz or 16Mhz
	BSF         PLLEN_bit+0, BitPos(PLLEN_bit+0) 
;hw_init.c,41 :: 		while (!HFIOFS_bit);     // cekame na ustaleni oscilatoru
L_HW_Init0:
	BTFSC       HFIOFS_bit+0, BitPos(HFIOFS_bit+0) 
	GOTO        L_HW_Init1
	GOTO        L_HW_Init0
L_HW_Init1:
;hw_init.c,42 :: 		while (!PLLRDY_bit);     // dtto na ustaleni PLL
L_HW_Init2:
	BTFSC       PLLRDY_bit+0, BitPos(PLLRDY_bit+0) 
	GOTO        L_HW_Init3
	GOTO        L_HW_Init2
L_HW_Init3:
;hw_init.c,44 :: 		PMD0 = 0;
	CLRF        PMD0+0 
;hw_init.c,46 :: 		Delay_ms(250);  // kvuli FOrte - drzi PGD a PGC v nule cca 120 ms !!!!
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_HW_Init4:
	DECFSZ      R13, 1, 1
	BRA         L_HW_Init4
	DECFSZ      R12, 1, 1
	BRA         L_HW_Init4
	DECFSZ      R11, 1, 1
	BRA         L_HW_Init4
	NOP
	NOP
;hw_init.c,49 :: 		TXSTA1 = RCSTA1 = 0;
	CLRF        RCSTA1+0 
	MOVF        RCSTA1+0, 0 
	MOVWF       TXSTA1+0 
;hw_init.c,50 :: 		BRG16_BAUD1CON_bit = 1;    // high speed UART
	BSF         BRG16_BAUD1CON_bit+0, BitPos(BRG16_BAUD1CON_bit+0) 
;hw_init.c,51 :: 		BRGH1_bit = 1; //BRGH_TX1STA_bit = 1;
	BSF         BRGH1_bit+0, BitPos(BRGH1_bit+0) 
;hw_init.c,52 :: 		SPBRGH1 = 0; SPBRG1 = 34;  // 34 for 16Mhz @115k2 (0.79% error)
	CLRF        SPBRGH1+0 
	MOVLW       34
	MOVWF       SPBRG1+0 
;hw_init.c,53 :: 		SYNC1_bit = 0;  // asynchronous mode
	BCF         SYNC1_bit+0, BitPos(SYNC1_bit+0) 
;hw_init.c,54 :: 		SPEN1_bit = 1;
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
;hw_init.c,55 :: 		TXEN1_bit = CREN1_bit = 1;  // povoleni Tx i Rx, zpnuti UART1
	BSF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__HW_Init50
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__HW_Init51
L__HW_Init50:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__HW_Init51:
;hw_init.c,57 :: 		rU1.Stat    = 0;       // init user struktury pro RX UART1
	CLRF        _rU1+0 
;hw_init.c,58 :: 		rU1.UseTermCh = _USE_UART1_TERM_CHAR;     // 1 = TRUE
	CLRF        _rU1+2 
;hw_init.c,59 :: 		rU1.TermCh = 10;      // ukoncovaci znak pri Rx
	MOVLW       10
	MOVWF       _rU1+3 
;hw_init.c,60 :: 		rU1.UseASCII = 1;
	MOVLW       1
	MOVWF       _rU1+4 
;hw_init.c,61 :: 		rU1.TIMEOUT = RX_TIMEOUT;  // timeout v us pro cekani na Rx data
	MOVLW       64
	MOVWF       _rU1+5 
	MOVLW       156
	MOVWF       _rU1+6 
;hw_init.c,62 :: 		rU1.TimeCnt = 0;
	CLRF        _rU1+7 
	CLRF        _rU1+8 
;hw_init.c,63 :: 		rU1.CntBuf  = 0;
	CLRF        _rU1+9 
	CLRF        _rU1+10 
;hw_init.c,64 :: 		rU1.BufLen  = RX_BUF_LEN;
	MOVLW       33
	MOVWF       _rU1+11 
	MOVLW       0
	MOVWF       _rU1+12 
;hw_init.c,93 :: 		T0CON = 0x81;   //   0x81 - 50ms@16Mhz, 0x82 - 100ms@16Mhz
	MOVLW       129
	MOVWF       T0CON+0 
;hw_init.c,94 :: 		TMR0H = 0x3C; TMR0L = 0xB0; TMR0IF_bit = 0; TMR0IE_bit = 0;  // 15536 - pro 50ms a 0x82@32Mhz
	MOVLW       60
	MOVWF       TMR0H+0 
	MOVLW       176
	MOVWF       TMR0L+0 
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;hw_init.c,97 :: 		T6CON = 0x4E; TMR6IF_bit = 0; PR6 = 250; TMR6IE_bit = 1; // zatim nepovolime IRQ
	MOVLW       78
	MOVWF       T6CON+0 
	BCF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
	MOVLW       250
	MOVWF       PR6+0 
	BSF         TMR6IE_bit+0, BitPos(TMR6IE_bit+0) 
;hw_init.c,100 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;hw_init.c,104 :: 		CJ125_CS = 1;       // SPI devices DISABLED
	BSF         LATC1_bit+0, BitPos(LATC1_bit+0) 
;hw_init.c,105 :: 		CJ125_RST = 0;                   // 1 => CJ125 ENABLED
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;hw_init.c,107 :: 		LED_Welcome();  // sekvence LED1,2,3 pri zapnuti
	CALL        _LED_Welcome+0, 0
;hw_init.c,109 :: 		for (u8TMP=0; u8TMP < 10; u8TMP++) UA_results[u8TMP] = 0;
	CLRF        _u8TMP+0 
L_HW_Init5:
	MOVLW       10
	SUBWF       _u8TMP+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_HW_Init6
	MOVF        _u8TMP+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _UA_results+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_UA_results+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	INCF        _u8TMP+0, 1 
	GOTO        L_HW_Init5
L_HW_Init6:
;hw_init.c,110 :: 		for (u8TMP=0; u8TMP < RX_BUF_LEN; u8TMP++)  RX_buf[u8TMP] = 0;
	CLRF        _u8TMP+0 
L_HW_Init8:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HW_Init52
	MOVLW       33
	SUBWF       _u8TMP+0, 0 
L__HW_Init52:
	BTFSC       STATUS+0, 0 
	GOTO        L_HW_Init9
	MOVLW       _RX_buf+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_RX_buf+0)
	MOVWF       FSR1L+1 
	MOVF        _u8TMP+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	CLRF        POSTINC1+0 
	INCF        _u8TMP+0, 1 
	GOTO        L_HW_Init8
L_HW_Init9:
;hw_init.c,112 :: 		for (u8TMP=0; u8TMP < TMP_BUF_LEN; u8TMP++) Tmp_buf[u8TMP] = u8TMP;
	CLRF        _u8TMP+0 
L_HW_Init11:
	MOVLW       32
	SUBWF       _u8TMP+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_HW_Init12
	MOVLW       _Tmp_buf+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_Tmp_buf+0)
	MOVWF       FSR1L+1 
	MOVF        _u8TMP+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        _u8TMP+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _u8TMP+0, 1 
	GOTO        L_HW_Init11
L_HW_Init12:
;hw_init.c,118 :: 		UART1_FIX_ERR
	BTFSC       FERR1_bit+0, BitPos(FERR1_bit+0) 
	GOTO        L__HW_Init48
	BTFSC       OERR1_bit+0, BitPos(OERR1_bit+0) 
	GOTO        L__HW_Init48
	GOTO        L_HW_Init16
L__HW_Init48:
	BCF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__HW_Init53
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__HW_Init54
L__HW_Init53:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__HW_Init54:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__HW_Init55
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__HW_Init56
L__HW_Init55:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__HW_Init56:
	BSF         CREN1_bit+0, BitPos(CREN1_bit+0) 
	BTFSC       CREN1_bit+0, BitPos(CREN1_bit+0) 
	GOTO        L__HW_Init57
	BCF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__HW_Init58
L__HW_Init57:
	BSF         TXEN1_bit+0, BitPos(TXEN1_bit+0) 
L__HW_Init58:
	BTFSC       TXEN1_bit+0, BitPos(TXEN1_bit+0) 
	GOTO        L__HW_Init59
	BCF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
	GOTO        L__HW_Init60
L__HW_Init59:
	BSF         SPEN1_bit+0, BitPos(SPEN1_bit+0) 
L__HW_Init60:
L_HW_Init16:
;hw_init.c,120 :: 		u8TMP = RCREG1; u8TMP = RCREG2;
	MOVF        RCREG1+0, 0 
	MOVWF       _u8TMP+0 
	MOVF        RCREG2+0, 0 
	MOVWF       _u8TMP+0 
;hw_init.c,123 :: 		EE_Consts = EEPROM_Read_Constant(EEPROM_CONST_ADR);
	CLRF        FARG_EEPROM_Read_Constant_Adr+0 
	CLRF        FARG_EEPROM_Read_Constant_Adr+1 
	MOVLW       FLOC__HW_Init+0
	MOVWF       R0 
	MOVLW       hi_addr(FLOC__HW_Init+0)
	MOVWF       R1 
	CALL        _EEPROM_Read_Constant+0, 0
	MOVLW       5
	MOVWF       R0 
	MOVLW       _EE_Consts+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_EE_Consts+0)
	MOVWF       FSR1L+1 
	MOVLW       FLOC__HW_Init+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(FLOC__HW_Init+0)
	MOVWF       FSR0L+1 
L_HW_Init17:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_HW_Init17
;hw_init.c,127 :: 		ADC_COEF_OFS_EEPROM =  EEPROM_Read(ADC_OFFSET_ADR); delay_ms(20);
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
L_HW_Init18:
	DECFSZ      R13, 1, 1
	BRA         L_HW_Init18
	DECFSZ      R12, 1, 1
	BRA         L_HW_Init18
	NOP
;hw_init.c,129 :: 		if ((ADC_COEF_OFS_EEPROM >= 50) && (ADC_COEF_OFS_EEPROM <= -50)) {
	MOVLW       128
	XORWF       _ADC_COEF_OFS_EEPROM+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       50
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HW_Init21
	MOVLW       128
	XORLW       206
	MOVWF       R0 
	MOVLW       128
	XORWF       _ADC_COEF_OFS_EEPROM+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HW_Init21
L__HW_Init47:
;hw_init.c,130 :: 		ADC_COEF_OFS_EEPROM = 0;  // default kdyz jsme mimo meze
	CLRF        _ADC_COEF_OFS_EEPROM+0 
;hw_init.c,131 :: 		}
L_HW_Init21:
;hw_init.c,132 :: 		AD_KOEF  = _AD_CONST + ADC_COEF_OFS_EEPROM; Delay_ms(20);
	MOVLW       233
	MOVWF       _AD_KOEF+0 
	MOVLW       1
	MOVWF       _AD_KOEF+1 
	MOVF        _ADC_COEF_OFS_EEPROM+0, 0 
	ADDWF       _AD_KOEF+0, 1 
	MOVLW       0
	BTFSC       _ADC_COEF_OFS_EEPROM+0, 7 
	MOVLW       255
	ADDWFC      _AD_KOEF+1, 1 
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_HW_Init22:
	DECFSZ      R13, 1, 1
	BRA         L_HW_Init22
	DECFSZ      R12, 1, 1
	BRA         L_HW_Init22
	NOP
;hw_init.c,134 :: 		DAC_COEF_OFS_EEPROM = EEPROM_Read(DAC_OFFSET_ADR);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DAC_COEF_OFS_EEPROM+0 
;hw_init.c,135 :: 		if ((DAC_COEF_OFS_EEPROM >= 40) && (DAC_COEF_OFS_EEPROM <= -40)){
	MOVLW       128
	XORWF       R0, 0 
	MOVWF       R1 
	MOVLW       128
	XORLW       40
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HW_Init25
	MOVLW       128
	XORLW       216
	MOVWF       R0 
	MOVLW       128
	XORWF       _DAC_COEF_OFS_EEPROM+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HW_Init25
L__HW_Init46:
;hw_init.c,136 :: 		DAC_COEF_OFS_EEPROM = 5;  // default kdyz jsme mimo meze
	MOVLW       5
	MOVWF       _DAC_COEF_OFS_EEPROM+0 
;hw_init.c,137 :: 		}
L_HW_Init25:
;hw_init.c,138 :: 		DAC_KOEF = _DAC_CONST - DAC_COEF_OFS_EEPROM; Delay_ms(20); //(muze byt +/- 127 v EEPROM)
	MOVF        _DAC_COEF_OFS_EEPROM+0, 0 
	SUBLW       233
	MOVWF       _DAC_KOEF+0 
	MOVLW       0
	BTFSC       _DAC_COEF_OFS_EEPROM+0, 7 
	MOVLW       255
	MOVWF       _DAC_KOEF+1 
	MOVLW       1
	SUBFWB      _DAC_KOEF+1, 1 
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_HW_Init26:
	DECFSZ      R13, 1, 1
	BRA         L_HW_Init26
	DECFSZ      R12, 1, 1
	BRA         L_HW_Init26
	NOP
;hw_init.c,141 :: 		VBAT_COEF_OFS_EEPROM = EEPROM_Read(VBAT_OFFSET_ADR); delay_ms(20);
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
L_HW_Init27:
	DECFSZ      R13, 1, 1
	BRA         L_HW_Init27
	DECFSZ      R12, 1, 1
	BRA         L_HW_Init27
	NOP
;hw_init.c,142 :: 		if ((VBAT_COEF_OFS_EEPROM >= 50) && (VBAT_COEF_OFS_EEPROM <= -50)) {
	MOVLW       128
	XORWF       _VBAT_COEF_OFS_EEPROM+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       50
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HW_Init30
	MOVLW       128
	XORLW       206
	MOVWF       R0 
	MOVLW       128
	XORWF       _VBAT_COEF_OFS_EEPROM+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_HW_Init30
L__HW_Init45:
;hw_init.c,143 :: 		VBAT_COEF_OFS_EEPROM = 0;  // default kdyz jsme mimo meze
	CLRF        _VBAT_COEF_OFS_EEPROM+0 
;hw_init.c,144 :: 		}
L_HW_Init30:
;hw_init.c,145 :: 		VBAT_KOEF = _VBAT_KOEF + VBAT_COEF_OFS_EEPROM;
	MOVLW       3
	MOVWF       _VBAT_KOEF+0 
	MOVLW       21
	MOVWF       _VBAT_KOEF+1 
	MOVF        _VBAT_COEF_OFS_EEPROM+0, 0 
	ADDWF       _VBAT_KOEF+0, 1 
	MOVLW       0
	BTFSC       _VBAT_COEF_OFS_EEPROM+0, 7 
	MOVLW       255
	ADDWFC      _VBAT_KOEF+1, 1 
;hw_init.c,149 :: 		PWM4_Init(1000);   // 1k naprosto ok, plynula PID regulace, 100%
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM4_Init+0, 0
;hw_init.c,150 :: 		PWM4_Set_Duty(0);
	CLRF        FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
;hw_init.c,152 :: 		PWM_Init_DAC1(DAC1_INIT_VOLT); //
	MOVLW       44
	MOVWF       FARG_PWM_Init_DAC1_mVout+0 
	MOVLW       1
	MOVWF       FARG_PWM_Init_DAC1_mVout+1 
	CALL        _PWM_Init_DAC1+0, 0
;hw_init.c,154 :: 		PWM_Init_DAC2(DAC2_INIT_VOLT); //
	MOVLW       44
	MOVWF       FARG_PWM_Init_DAC2_mVout+0 
	MOVLW       1
	MOVWF       FARG_PWM_Init_DAC2_mVout+1 
	CALL        _PWM_Init_DAC2+0, 0
;hw_init.c,156 :: 		RC1IE_bit = 1;         // Uart 1 Rx
	BSF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;hw_init.c,158 :: 		PEIE_bit = 1;        // povoleni pro xt.periferie napr Timer 6
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;hw_init.c,159 :: 		GIE_GIEH_bit = 1 ;   // Global IRQ ENABLE
	BSF         GIE_GIEH_bit+0, BitPos(GIE_GIEH_bit+0) 
;hw_init.c,160 :: 		}
L_end_HW_Init:
	RETURN      0
; end of _HW_Init

_LED_Welcome:

;hw_init.c,163 :: 		void LED_Welcome() {              //
;hw_init.c,164 :: 		LED1=1; Delay_ms(100); LED1=0;// Delay_ms(50);
	BSF         LATA6_bit+0, BitPos(LATA6_bit+0) 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_LED_Welcome31:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Welcome31
	DECFSZ      R12, 1, 1
	BRA         L_LED_Welcome31
	DECFSZ      R11, 1, 1
	BRA         L_LED_Welcome31
	BCF         LATA6_bit+0, BitPos(LATA6_bit+0) 
;hw_init.c,165 :: 		LED2=1; Delay_ms(100); LED2=0;// Delay_ms(50);
	BSF         LATB3_bit+0, BitPos(LATB3_bit+0) 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_LED_Welcome32:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Welcome32
	DECFSZ      R12, 1, 1
	BRA         L_LED_Welcome32
	DECFSZ      R11, 1, 1
	BRA         L_LED_Welcome32
	BCF         LATB3_bit+0, BitPos(LATB3_bit+0) 
;hw_init.c,166 :: 		LED3=1; Delay_ms(100); LED3=0;// Delay_ms(50);
	BSF         LATB4_bit+0, BitPos(LATB4_bit+0) 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_LED_Welcome33:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Welcome33
	DECFSZ      R12, 1, 1
	BRA         L_LED_Welcome33
	DECFSZ      R11, 1, 1
	BRA         L_LED_Welcome33
	BCF         LATB4_bit+0, BitPos(LATB4_bit+0) 
;hw_init.c,167 :: 		}
L_end_LED_Welcome:
	RETURN      0
; end of _LED_Welcome

_UART_Welcome:

;hw_init.c,169 :: 		void UART_Welcome(u8 ComNr, EEprom EE_Data){
;hw_init.c,170 :: 		CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,171 :: 		CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,172 :: 		if (ComNr == 1){  // jen pro UART1 - ne do UARTU2 - Androidu
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_UART_Welcome34
;hw_init.c,173 :: 		UART_PrintTxt(ComNr,"MS3_MEP WBO Controller:");                       CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr1_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr1_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,174 :: 		UART_PrintTxt(ComNr,"============================");                  CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr2_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr2_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,175 :: 		UART_PrintTxt(ComNr,"SN: ");      UART_PrintU16_HEX(ComNr,EE_Data.SN);CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr3_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr3_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_EE_Data+0, 0 
	MOVWF       FARG_WordToHex_input+0 
	MOVF        FARG_UART_Welcome_EE_Data+1, 0 
	MOVWF       FARG_WordToHex_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToHex_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToHex_output+1 
	CALL        _WordToHex+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr4_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr4_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,176 :: 		UART_PrintTxt(ComNr,"HW_VER: ");  UART_PrintU8(ComNr,EE_Data.HW_ver); CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr5_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr5_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_EE_Data+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,177 :: 		UART_PrintTxt(ComNr,"SW_VER: ");  UART_PrintU8(ComNr,EE_Data.SW_ver); CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr6_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr6_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_EE_Data+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,178 :: 		UART_PrintTxt(ComNr,"OPTION: ");  UART_PrintU8(ComNr,EE_Data.OPTION); CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr7_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr7_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_EE_Data+4, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,179 :: 		CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,180 :: 		UART_PrintTxt(ComNr,"EEPROM CALIBRATION DATA:");                             CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr8_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr8_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,181 :: 		UART_PrintTxt(ComNr,"============================");                  CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr9_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr9_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,182 :: 		UART_PrintTxt(1,"  ADC_OFFSET="); UART_PrintI8(ComNr,ADC_COEF_OFS_EEPROM);  UART_PrintTxt(ComNr,", AD_KOEF=");  UART_PrintU16(ComNr,AD_KOEF);   CR_LF(ComNr);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr10_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr10_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _ADC_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr11_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr11_hw_init+0)
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
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,183 :: 		UART_PrintTxt(1,"  DAC_OFFSET="); UART_PrintI8(ComNr,DAC_COEF_OFS_EEPROM);  UART_PrintTxt(ComNr,", DAC_KOEF="); UART_PrintU16(ComNr,DAC_KOEF);  CR_LF(ComNr);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr12_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr12_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _DAC_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr13_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr13_hw_init+0)
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
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,184 :: 		UART_PrintTxt(1,"  VBAT_OFFSET=");UART_PrintI8(ComNr,VBAT_COEF_OFS_EEPROM); UART_PrintTxt(ComNr,",VBAT_KOEF="); UART_PrintU16(ComNr,VBAT_KOEF); CR_LF(ComNr);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr14_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr14_hw_init+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _VBAT_COEF_OFS_EEPROM+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtI8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtI8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr15_hw_init+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr15_hw_init+0)
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
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,185 :: 		CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,186 :: 		CR_LF(ComNr);
	MOVF        FARG_UART_Welcome_ComNr+0, 0 
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;hw_init.c,187 :: 		}
L_UART_Welcome34:
;hw_init.c,188 :: 		}
L_end_UART_Welcome:
	RETURN      0
; end of _UART_Welcome

_CR_LF:

;hw_init.c,193 :: 		void CR_LF(u8 i) {
;hw_init.c,194 :: 		if (i == 1) { TXREG1 =10; while(!TX1STA.B1); TXREG1 =13;  while(!TX1STA.B1); } // UART1_Write(10); UART1_Write(13); }
	MOVF        FARG_CR_LF_i+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_CR_LF35
	MOVLW       10
	MOVWF       TXREG1+0 
L_CR_LF36:
	BTFSC       TX1STA+0, 1 
	GOTO        L_CR_LF37
	GOTO        L_CR_LF36
L_CR_LF37:
	MOVLW       13
	MOVWF       TXREG1+0 
L_CR_LF38:
	BTFSC       TX1STA+0, 1 
	GOTO        L_CR_LF39
	GOTO        L_CR_LF38
L_CR_LF39:
	GOTO        L_CR_LF40
L_CR_LF35:
;hw_init.c,195 :: 		else        { TXREG2 =10; while(!TX2STA.B1); TXREG2 =13;  while(!TX2STA.B1); } //UART2_Write(10); UART2_Write(13);  }
	MOVLW       10
	MOVWF       TXREG2+0 
L_CR_LF41:
	BTFSC       TX2STA+0, 1 
	GOTO        L_CR_LF42
	GOTO        L_CR_LF41
L_CR_LF42:
	MOVLW       13
	MOVWF       TXREG2+0 
L_CR_LF43:
	BTFSC       TX2STA+0, 1 
	GOTO        L_CR_LF44
	GOTO        L_CR_LF43
L_CR_LF44:
L_CR_LF40:
;hw_init.c,196 :: 		}
L_end_CR_LF:
	RETURN      0
; end of _CR_LF
