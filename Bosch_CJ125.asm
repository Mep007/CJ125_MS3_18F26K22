
_CJ125_Write:

;Bosch_CJ125.c,5 :: 		u16 CJ125_Write(u16 TX_data){
;Bosch_CJ125.c,7 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_HIGH_2_LOW);  // OK pro CJ125  - musi byt v kazdekomunikacni fci
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	CLRF        FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;Bosch_CJ125.c,8 :: 		Delay_ms(10);  // otazka
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_CJ125_Write0:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Write0
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Write0
	NOP
	NOP
;Bosch_CJ125.c,10 :: 		CJ125_CS = 0;
	BCF         CJ125_CS+0, BitPos(CJ125_CS+0) 
;Bosch_CJ125.c,12 :: 		hidata = SPI1_Read(TX_data>>8);  // 0x48 napr.  - zde je pak 1. odpoved CJ125 - 00101000b - x28 (dulezitejsou jen b101)
	MOVF        FARG_CJ125_Write_TX_data+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       CJ125_Write_hidata_L0+0 
;Bosch_CJ125.c,13 :: 		lodata = SPI1_Read(TX_data);
	MOVF        FARG_CJ125_Write_TX_data+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;Bosch_CJ125.c,14 :: 		CJ125_CS = 1;
	BSF         CJ125_CS+0, BitPos(CJ125_CS+0) 
;Bosch_CJ125.c,16 :: 		return ((hidata<<8)+lodata);
	MOVF        CJ125_Write_hidata_L0+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
;Bosch_CJ125.c,17 :: 		}
L_end_CJ125_Write:
	RETURN      0
; end of _CJ125_Write

_CJ125_Test:

;Bosch_CJ125.c,19 :: 		u16 CJ125_Test() {     // napeti alespon 10.5V
;Bosch_CJ125.c,20 :: 		char n=0,error=0;
	CLRF        CJ125_Test_error_L0+0 
;Bosch_CJ125.c,22 :: 		Vbat_init_mV= 0;
	CLRF        _Vbat_init_mV+0 
	CLRF        _Vbat_init_mV+1 
;Bosch_CJ125.c,25 :: 		CJ125_RST = 1;   // az tady povolime CJ125
	BSF         CJ125_RST+0, BitPos(CJ125_RST+0) 
;Bosch_CJ125.c,26 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_CJ125_Test1:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Test1
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Test1
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Test1
;Bosch_CJ125.c,27 :: 		CJ125_Ans = CJ125_Write(CJ125_INIT_REG2_RESET_ALL); // reset chipu
	MOVLW       64
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       90
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,28 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_CJ125_Test2:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Test2
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Test2
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Test2
	NOP
;Bosch_CJ125.c,29 :: 		CJ125_Ans = 0;
	CLRF        _CJ125_Ans+0 
	CLRF        _CJ125_Ans+1 
;Bosch_CJ125.c,30 :: 		CJ125_Ans = CJ125_Write(CJ125_IDENT_REG_REQUEST);
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       72
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,31 :: 		UART_PrintTxt(1,"Bosch CJ125, chip version = ");
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr1_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr1_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,32 :: 		if      (CJ125_Ans ==  CJ125_RD_IDENT_CJ125BA_ANS ) UART_PrintTxt(1,"0x62(BA)");
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Test76
	MOVLW       98
	XORWF       _CJ125_Ans+0, 0 
L__CJ125_Test76:
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Test3
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr2_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr2_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	GOTO        L_CJ125_Test4
L_CJ125_Test3:
;Bosch_CJ125.c,33 :: 		else if (CJ125_Ans ==  CJ125_RD_IDENT_CJ125BB_ANS ) UART_PrintTxt(1,"0x63(BB)");
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Test77
	MOVLW       99
	XORWF       _CJ125_Ans+0, 0 
L__CJ125_Test77:
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Test5
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr3_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr3_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	GOTO        L_CJ125_Test6
L_CJ125_Test5:
;Bosch_CJ125.c,34 :: 		else { error = 1; }
	MOVLW       1
	MOVWF       CJ125_Test_error_L0+0 
L_CJ125_Test6:
L_CJ125_Test4:
;Bosch_CJ125.c,35 :: 		UART_PrintTxt(1,", Status code = " ); UART_PrintU16_HEX(1,CJ125_Ans);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr4_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr4_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _CJ125_Ans+0, 0 
	MOVWF       FARG_WordToHex_input+0 
	MOVF        _CJ125_Ans+1, 0 
	MOVWF       FARG_WordToHex_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToHex_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToHex_output+1 
	CALL        _WordToHex+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr5_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr5_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,36 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,38 :: 		if(error) {  // tady skoncime, protoze stejne nelze nic dal delat
	MOVF        CJ125_Test_error_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_CJ125_Test7
;Bosch_CJ125.c,39 :: 		UART_PrintTxt(1,"Error during CJ125 init. Program stopped." );
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr6_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr6_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,40 :: 		while (1) {  //
L_CJ125_Test8:
;Bosch_CJ125.c,41 :: 		LED_BLUE_100ms  // error cipu, blikame rychle modre
	MOVLW       10
	MOVWF       _LED1_Tresh+0 
;Bosch_CJ125.c,42 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_CJ125_Test10:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Test10
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Test10
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Test10
	NOP
;Bosch_CJ125.c,43 :: 		}
	GOTO        L_CJ125_Test8
;Bosch_CJ125.c,44 :: 		}
L_CJ125_Test7:
;Bosch_CJ125.c,46 :: 		Vbat_init_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF );  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV
	MOVLW       4
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _VBAT_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _VBAT_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat_init_mV+0 
	MOVF        R1, 0 
	MOVWF       _Vbat_init_mV+1 
;Bosch_CJ125.c,47 :: 		CR_LF(1); UART_PrintTxt(1,"Init Vbat = "); WordToStr(Vbat_init_mV,_txtU16); UART_PrintTxt(1,_txtU16);UART_PrintTxt(1," mV"); CR_LF(1);CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr7_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr7_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Vbat_init_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Vbat_init_mV+1, 0 
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
	MOVLW       ?lstr8_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr8_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,49 :: 		return CJ125_Ans;
	MOVF        _CJ125_Ans+0, 0 
	MOVWF       R0 
	MOVF        _CJ125_Ans+1, 0 
	MOVWF       R1 
;Bosch_CJ125.c,50 :: 		}
L_end_CJ125_Test:
	RETURN      0
; end of _CJ125_Test

_CJ125_Sensor_Test:

;Bosch_CJ125.c,53 :: 		u16 CJ125_Sensor_Test() {     // testuje stav pripojeni LSU senzoru
;Bosch_CJ125.c,54 :: 		char n=0,error=1;
;Bosch_CJ125.c,55 :: 		CJ125_Ans = 0;
	CLRF        _CJ125_Ans+0 
	CLRF        _CJ125_Ans+1 
;Bosch_CJ125.c,57 :: 		CR_LF(1); UART_PrintTxt(1,"WBO LSU 4.9 Sensor status - ");
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr9_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr9_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,59 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);    // dotaz na stav pripojeni sensoru
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,60 :: 		if      (CJ125_Ans == CJ125_DIAG_REG_STATUS_OK )       { UART_PrintTxt(1,"OK"); error = 0; }
	MOVF        R1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Sensor_Test79
	MOVLW       255
	XORWF       R0, 0 
L__CJ125_Sensor_Test79:
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Sensor_Test11
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr10_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr10_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	GOTO        L_CJ125_Sensor_Test12
L_CJ125_Sensor_Test11:
;Bosch_CJ125.c,61 :: 		else if (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOSENSOR) { UART_PrintTxt(1,"Not connected"); }
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Sensor_Test80
	MOVLW       127
	XORWF       _CJ125_Ans+0, 0 
L__CJ125_Sensor_Test80:
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Sensor_Test13
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr11_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr11_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	GOTO        L_CJ125_Sensor_Test14
L_CJ125_Sensor_Test13:
;Bosch_CJ125.c,62 :: 		else if (CJ125_Ans ==  CJ125_DIAG_REG_STATUS_NOPOWER)  { UART_PrintTxt(1,"No power");      }
	MOVF        _CJ125_Ans+1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Sensor_Test81
	MOVLW       85
	XORWF       _CJ125_Ans+0, 0 
L__CJ125_Sensor_Test81:
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Sensor_Test15
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr12_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr12_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	GOTO        L_CJ125_Sensor_Test16
L_CJ125_Sensor_Test15:
;Bosch_CJ125.c,63 :: 		else                                                   { UART_PrintTxt(1,"Other failure"); }  // vubec nic
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr13_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr13_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
L_CJ125_Sensor_Test16:
L_CJ125_Sensor_Test14:
L_CJ125_Sensor_Test12:
;Bosch_CJ125.c,65 :: 		UART_PrintTxt(1," - Status code = ");  // vubec nic
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr14_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr14_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,66 :: 		UART_PrintU16_HEX(1,CJ125_Ans);   //  UART_PrintU16(1,CJ125_Ans); WordToStr(CJ125_Ans,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);
	MOVF        _CJ125_Ans+0, 0 
	MOVWF       FARG_WordToHex_input+0 
	MOVF        _CJ125_Ans+1, 0 
	MOVWF       FARG_WordToHex_input+1 
	MOVLW       __txtU16+0
	MOVWF       FARG_WordToHex_output+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_WordToHex_output+1 
	CALL        _WordToHex+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr15_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr15_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU16+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU16+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,67 :: 		return CJ125_Ans;
	MOVF        _CJ125_Ans+0, 0 
	MOVWF       R0 
	MOVF        _CJ125_Ans+1, 0 
	MOVWF       R1 
;Bosch_CJ125.c,68 :: 		}
L_end_CJ125_Sensor_Test:
	RETURN      0
; end of _CJ125_Sensor_Test

_CJ125_Vbat_check:

;Bosch_CJ125.c,71 :: 		u16 CJ125_Vbat_check() {     // testuje stav Vbat - dle toho spusti dal ohrivani sondy
;Bosch_CJ125.c,76 :: 		char n=0,Wait_for_run=10;
	MOVLW       10
	MOVWF       CJ125_Vbat_check_Wait_for_run_L0+0 
;Bosch_CJ125.c,77 :: 		Vbat_init_mV = Vbat_mV = CJ125_Ans = 0;
	CLRF        _CJ125_Ans+0 
	CLRF        _CJ125_Ans+1 
	CLRF        _Vbat_mV+0 
	CLRF        _Vbat_mV+1 
	CLRF        _Vbat_init_mV+0 
	CLRF        _Vbat_init_mV+1 
;Bosch_CJ125.c,78 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,81 :: 		do {  /// pokdu je napaeti mimo zakladni meze, zustaneme zde , potencialni loop
L_CJ125_Vbat_check17:
;Bosch_CJ125.c,82 :: 		Vbat_init_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF );  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV - po zapnuti klicku
	MOVLW       4
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _VBAT_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _VBAT_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat_init_mV+0 
	MOVF        R1, 0 
	MOVWF       _Vbat_init_mV+1 
;Bosch_CJ125.c,83 :: 		UART_PrintTxt(1,"Init Vbat[mV] = ");  UART_PrintU16(1,Vbat_init_mV); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr16_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr16_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _Vbat_init_mV+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _Vbat_init_mV+1, 0 
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
;Bosch_CJ125.c,84 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_CJ125_Vbat_check20:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Vbat_check20
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Vbat_check20
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Vbat_check20
	NOP
	NOP
;Bosch_CJ125.c,85 :: 		} while ((Vbat_init_mV <= VBAT_LOW) || (Vbat_init_mV > VBAT_MAX));
	MOVF        _Vbat_init_mV+1, 0 
	SUBLW       41
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Vbat_check83
	MOVF        _Vbat_init_mV+0, 0 
	SUBLW       4
L__CJ125_Vbat_check83:
	BTFSC       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check17
	MOVF        _Vbat_init_mV+1, 0 
	SUBLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Vbat_check84
	MOVF        _Vbat_init_mV+0, 0 
	SUBLW       140
L__CJ125_Vbat_check84:
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check17
L__CJ125_Vbat_check70:
;Bosch_CJ125.c,88 :: 		if (Vbat_init_mV <= VBAT_RE_RUN) {
	MOVF        _Vbat_init_mV+1, 0 
	SUBLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Vbat_check85
	MOVF        _Vbat_init_mV+0, 0 
	SUBLW       100
L__CJ125_Vbat_check85:
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check23
;Bosch_CJ125.c,89 :: 		do {  ///
L_CJ125_Vbat_check24:
;Bosch_CJ125.c,90 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF );  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV
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
;Bosch_CJ125.c,91 :: 		UART_PrintTxt(1,"Vbat="); UART_PrintU16(1,Vbat_mV); UART_PrintTxt(1,", "); // UART_PrintU16(1,UR_mV); // CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr17_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr17_Bosch_CJ125+0)
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
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr18_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr18_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,92 :: 		if ((Vbat_mV >= VBAT_LOW) && (Vbat_mV < VBAT_MAX)) {  // povolene meze Vbat
	MOVLW       41
	SUBWF       _Vbat_mV+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Vbat_check86
	MOVLW       4
	SUBWF       _Vbat_mV+0, 0 
L__CJ125_Vbat_check86:
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check29
	MOVLW       60
	SUBWF       _Vbat_mV+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Vbat_check87
	MOVLW       140
	SUBWF       _Vbat_mV+0, 0 
L__CJ125_Vbat_check87:
	BTFSC       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check29
L__CJ125_Vbat_check69:
;Bosch_CJ125.c,94 :: 		if  (Vbat_mV >= (Vbat_init_mV + DELTA_VBAT)) Wait_for_run--;    // Vbat se zvestsil o DELTA_VBAT => zrejme s nastartovalo a zaclo se dobijet - zaciname odpocitavat pro spusteni - SW filtr
	MOVLW       88
	ADDWF       _Vbat_init_mV+0, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWFC      _Vbat_init_mV+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       _Vbat_mV+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Vbat_check88
	MOVF        R1, 0 
	SUBWF       _Vbat_mV+0, 0 
L__CJ125_Vbat_check88:
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check30
	DECF        CJ125_Vbat_check_Wait_for_run_L0+0, 1 
	GOTO        L_CJ125_Vbat_check31
L_CJ125_Vbat_check30:
;Bosch_CJ125.c,95 :: 		else Wait_for_run=10;       // nejake ruseni, zpet na cekani na nastartovani
	MOVLW       10
	MOVWF       CJ125_Vbat_check_Wait_for_run_L0+0 
L_CJ125_Vbat_check31:
;Bosch_CJ125.c,96 :: 		UART_PrintU8(1,Wait_for_run); UART_PrintTxt(1,", ");
	MOVF        CJ125_Vbat_check_Wait_for_run_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr19_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr19_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,97 :: 		}
	GOTO        L_CJ125_Vbat_check32
L_CJ125_Vbat_check29:
;Bosch_CJ125.c,98 :: 		else UART_PrintTxt(1,"Vbat mimo meze ");
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr20_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr20_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
L_CJ125_Vbat_check32:
;Bosch_CJ125.c,99 :: 		delay_ms(500); // bylo 25ms
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_CJ125_Vbat_check33:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Vbat_check33
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Vbat_check33
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Vbat_check33
	NOP
	NOP
;Bosch_CJ125.c,100 :: 		} while (wait_for_run > 0); // zde cekani, dokud se napeti baterie nedostane do pracovnich mezi - !! POTENCIALNI LOOP NAVZDY !!
	MOVF        CJ125_Vbat_check_Wait_for_run_L0+0, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_Vbat_check24
;Bosch_CJ125.c,101 :: 		} // if
L_CJ125_Vbat_check23:
;Bosch_CJ125.c,103 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,104 :: 		UART_PrintTxt(1,"VBAT TEST FINISHED");
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr21_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr21_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,105 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,106 :: 		}
L_end_CJ125_Vbat_check:
	RETURN      0
; end of _CJ125_Vbat_check

_CJ125_Ri_Cal:

;Bosch_CJ125.c,108 :: 		u8 CJ125_Ri_Cal(u8 LSU) {   // prepnuti do kalibracniho modu a zmereni Rical (82R pro LSU4.2 - cca 780mV  a 301R pro LSU4.9 - cca 2160mV)
;Bosch_CJ125.c,109 :: 		char n=0, Stat=0;
	CLRF        CJ125_Ri_Cal_n_L0+0 
	CLRF        CJ125_Ri_Cal_Stat_L0+0 
	CLRF        CJ125_Ri_Cal_LoUR_L0+0 
	CLRF        CJ125_Ri_Cal_LoUR_L0+1 
	CLRF        CJ125_Ri_Cal_HiUR_L0+0 
	CLRF        CJ125_Ri_Cal_HiUR_L0+1 
;Bosch_CJ125.c,114 :: 		CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,115 :: 		LoUR = 800; HiUR = 1200; UR_def = 1000;  //UART_PrintTxt(1,"LSU 4.9 selected");
	MOVLW       32
	MOVWF       CJ125_Ri_Cal_LoUR_L0+0 
	MOVLW       3
	MOVWF       CJ125_Ri_Cal_LoUR_L0+1 
	MOVLW       176
	MOVWF       CJ125_Ri_Cal_HiUR_L0+0 
	MOVLW       4
	MOVWF       CJ125_Ri_Cal_HiUR_L0+1 
;Bosch_CJ125.c,116 :: 		CJ125_Ans = CJ125_Write(CJ125_INIT_REG1_MODE_CALIBRATE);  // Ans: 11264 (0x2C00) - 2bit je 1, protoze se jedan o Write Access v pred. prikazu
	MOVLW       157
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       86
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,119 :: 		while ((Stat != 1) && (n < 5)) {
L_CJ125_Ri_Cal34:
	MOVF        CJ125_Ri_Cal_Stat_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_CJ125_Ri_Cal35
	MOVLW       5
	SUBWF       CJ125_Ri_Cal_n_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_CJ125_Ri_Cal35
L__CJ125_Ri_Cal72:
;Bosch_CJ125.c,120 :: 		CJ125_Ans = CJ125_Write(CJ125_INIT_REG1_MODE_CALIBRATE);
	MOVLW       157
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       86
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,121 :: 		Delay_ms(500);  //Let values settle.
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_CJ125_Ri_Cal38:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Ri_Cal38
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Ri_Cal38
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Ri_Cal38
	NOP
	NOP
;Bosch_CJ125.c,123 :: 		UA_mV_ref  = Get_AD_mV(UA_AD_ch,AD_KOEF);  // merime UA  pro lambda=1 => 1.5V (proud Ip=0mA) - cca 307 RAW
	MOVLW       1
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _AD_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _UA_mV_ref+0 
	MOVF        R1, 0 
	MOVWF       _UA_mV_ref+1 
;Bosch_CJ125.c,124 :: 		UR_mV_ref  = Get_AD_mV(UR_AD_ch,AD_KOEF);  // merime UR pro optimalni teplotu senzoru  na Ri=82R pro LSU4.2 resp. Ri=301R pro LSU4.9
	MOVLW       2
	MOVWF       FARG_Get_AD_mV_ch+0 
	MOVF        _AD_KOEF+0, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+0 
	MOVF        _AD_KOEF+1, 0 
	MOVWF       FARG_Get_AD_mV_adc_koef+1 
	CALL        _Get_AD_mV+0, 0
	MOVF        R0, 0 
	MOVWF       _UR_mV_ref+0 
	MOVF        R1, 0 
	MOVWF       _UR_mV_ref+1 
;Bosch_CJ125.c,125 :: 		if ((UR_mV_ref > HiUR) ||  (UR_mV_ref < LoUR)) {
	MOVF        R1, 0 
	SUBWF       CJ125_Ri_Cal_HiUR_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Ri_Cal90
	MOVF        R0, 0 
	SUBWF       CJ125_Ri_Cal_HiUR_L0+0, 0 
L__CJ125_Ri_Cal90:
	BTFSS       STATUS+0, 0 
	GOTO        L__CJ125_Ri_Cal71
	MOVF        CJ125_Ri_Cal_LoUR_L0+1, 0 
	SUBWF       _UR_mV_ref+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_Ri_Cal91
	MOVF        CJ125_Ri_Cal_LoUR_L0+0, 0 
	SUBWF       _UR_mV_ref+0, 0 
L__CJ125_Ri_Cal91:
	BTFSS       STATUS+0, 0 
	GOTO        L__CJ125_Ri_Cal71
	GOTO        L_CJ125_Ri_Cal41
L__CJ125_Ri_Cal71:
;Bosch_CJ125.c,126 :: 		CJ125_Write(CJ125_INIT_REG2_RESET_ALL); //   RESET ALL CHIP
	MOVLW       64
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       90
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
;Bosch_CJ125.c,127 :: 		UART_PrintTxt(1,"UR_ref ="); UART_PrintU16(1,UR_mV_ref); UART_PrintTxt(1," - value outside limits [800-1200]"); CR_LF(1); // WordToStr(UR_mV_ref,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr22_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr22_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _UR_mV_ref+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _UR_mV_ref+1, 0 
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
	MOVLW       ?lstr23_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr23_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,130 :: 		Stat=10;
	MOVLW       10
	MOVWF       CJ125_Ri_Cal_Stat_L0+0 
;Bosch_CJ125.c,131 :: 		}
	GOTO        L_CJ125_Ri_Cal42
L_CJ125_Ri_Cal41:
;Bosch_CJ125.c,132 :: 		else Stat = 1;
	MOVLW       1
	MOVWF       CJ125_Ri_Cal_Stat_L0+0 
L_CJ125_Ri_Cal42:
;Bosch_CJ125.c,133 :: 		if (Stat==10) { UART_PrintTxt(1," UR_ref calibration failed.");CR_LF(1);  }
	MOVF        CJ125_Ri_Cal_Stat_L0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Ri_Cal43
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr24_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr24_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
L_CJ125_Ri_Cal43:
;Bosch_CJ125.c,136 :: 		CJ125_Write(CJ125_INIT_REG1_MODE_NORMAL_V8);
	MOVLW       136
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       86
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
;Bosch_CJ125.c,137 :: 		CJ125_Write(CJ125_INIT_REG1_MODE_NORMAL_V8);   // zkousime 2x zapsat, asi neni nutne ale...
	MOVLW       136
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       86
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
;Bosch_CJ125.c,138 :: 		UART_PrintTxt(1,"CJ125 amplification set to v = 8 (9.55 - 21.00 AFR)"); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr25_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr25_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,140 :: 		if (LSU == LSU49) {
	MOVF        FARG_CJ125_Ri_Cal_LSU+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_Ri_Cal44
;Bosch_CJ125.c,141 :: 		CJ125_Ans = CJ125_Write(CJ125_INIT_REG2_SET_20uA_Ip );    // vnitrni referencni proud Ip pro 4.9 sondu
	MOVLW       2
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       90
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,142 :: 		CJ125_Ans = CJ125_Write(CJ125_INIT_REG2_SET_20uA_Ip );    // vnitrni referencni proud Ip pro 4.9 sondu
	MOVLW       2
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       90
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,143 :: 		UART_PrintTxt(1,"Ip ref. current set to 20uA"); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr26_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr26_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,144 :: 		}
L_CJ125_Ri_Cal44:
;Bosch_CJ125.c,145 :: 		UART_PrintTxt(1,"UA ref[mV]="); UART_PrintU16(1,UA_mV_ref);             // WordToStr(UA_mV_ref,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr27_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr27_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _UA_mV_ref+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _UA_mV_ref+1, 0 
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
;Bosch_CJ125.c,146 :: 		UART_PrintTxt(1,", UR ref[mV]="); UART_PrintU16(1,UR_mV_ref); CR_LF(1); //WordToStr(UR_mV_ref,_txtU16); UART_PrintTxt(1,_txtU16); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr28_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr28_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVF        _UR_mV_ref+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _UR_mV_ref+1, 0 
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
;Bosch_CJ125.c,147 :: 		if (Stat!=1) Delay_ms(500);
	MOVF        CJ125_Ri_Cal_Stat_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_CJ125_Ri_Cal45
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_CJ125_Ri_Cal46:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_Ri_Cal46
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_Ri_Cal46
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_Ri_Cal46
	NOP
	NOP
L_CJ125_Ri_Cal45:
;Bosch_CJ125.c,148 :: 		n++;
	INCF        CJ125_Ri_Cal_n_L0+0, 1 
;Bosch_CJ125.c,149 :: 		} // while (ok !=)
	GOTO        L_CJ125_Ri_Cal34
L_CJ125_Ri_Cal35:
;Bosch_CJ125.c,152 :: 		CR_LF(1);CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,154 :: 		return Stat;
	MOVF        CJ125_Ri_Cal_Stat_L0+0, 0 
	MOVWF       R0 
;Bosch_CJ125.c,155 :: 		}
L_end_CJ125_Ri_Cal:
	RETURN      0
; end of _CJ125_Ri_Cal

_CJ125_PreHeat_LSU:

;Bosch_CJ125.c,157 :: 		void CJ125_PreHeat_LSU(u8 LSU){
;Bosch_CJ125.c,159 :: 		u8 HEAT_MAX,HEAT_STEP,PID_PWM_0, i=0, sensor_present=1;
	CLRF        CJ125_PreHeat_LSU_i_L0+0 
;Bosch_CJ125.c,163 :: 		if (LSU == LSU49) {
	MOVF        FARG_CJ125_PreHeat_LSU_LSU+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_CJ125_PreHeat_LSU47
;Bosch_CJ125.c,165 :: 		RampHeatInit_PWM  =  8000;      // uroven v mV, od ktere zaciname zvysovat rampu po fazi suseni kondenzace - dle PDF je max. 8.5V RMS initial voltage str. 4/13 Bosch technical 258 E00 015e)
	MOVLW       64
	MOVWF       CJ125_PreHeat_LSU_RampHeatInit_PWM_L0+0 
	MOVLW       31
	MOVWF       CJ125_PreHeat_LSU_RampHeatInit_PWM_L0+1 
;Bosch_CJ125.c,166 :: 		HEAT_MAX          =   180;      // 190 bylo taky, 160 stacelo a bylo ok, max. strida pro topeni 0-255 (0-100% PWM)  - DLE pdf lsu 4.9 JE MAX. NAPETI TRVALE NA topeni 12.0V (max 13.0 po dobu 30s)
	MOVLW       180
	MOVWF       CJ125_PreHeat_LSU_HEAT_MAX_L0+0 
;Bosch_CJ125.c,167 :: 		HEAT_STEP         =     2;      // max. +0.4V/s -> o kolik se pridava PWM pri zahrivani, 3% z 12.5V=0.4V => DC=8, => HEAT_STEP = 2 za HEAT_RAMP_DELAY=250ms (tj. 4x2=8 za 1s => 0.4V/s)
	MOVLW       2
	MOVWF       CJ125_PreHeat_LSU_HEAT_STEP_L0+0 
;Bosch_CJ125.c,169 :: 		}
L_CJ125_PreHeat_LSU47:
;Bosch_CJ125.c,171 :: 		PWM4_Set_Duty(1);  // zatim temer vypnuto topeni
	MOVLW       1
	MOVWF       FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
;Bosch_CJ125.c,172 :: 		PWM4_Start();  // zapiname PWM jendotku na topeni
	CALL        _PWM4_Start+0, 0
;Bosch_CJ125.c,174 :: 		LED1 = 0;
	BCF         LED1+0, BitPos(LED1+0) 
;Bosch_CJ125.c,175 :: 		CR_LF(1);   CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,177 :: 		if (Vbat_mV >= 14000) PWM4_Set_Duty(33);  // Vbat vyssi nez 14V, omezime proto DC topeni pro kondenz. fazi na max. 2V RMS  (tj 33/255* 14.5V) = 1.88V
	MOVLW       54
	SUBWF       _Vbat_mV+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_PreHeat_LSU93
	MOVLW       176
	SUBWF       _Vbat_mV+0, 0 
L__CJ125_PreHeat_LSU93:
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_PreHeat_LSU48
	MOVLW       33
	MOVWF       FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
	GOTO        L_CJ125_PreHeat_LSU49
L_CJ125_PreHeat_LSU48:
;Bosch_CJ125.c,178 :: 		else                  PWM4_Set_Duty(38);  // dtto pro Vbat <14V  (38/255) * 13.8V) = 2.1V
	MOVLW       38
	MOVWF       FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
L_CJ125_PreHeat_LSU49:
;Bosch_CJ125.c,179 :: 		UART_PrintTxt(1,"CJ125 condensation heating start...");
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr29_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr29_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,181 :: 		i=0;
	CLRF        CJ125_PreHeat_LSU_i_L0+0 
;Bosch_CJ125.c,182 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);    // test pripojeni sondy, kdyz by nebyla pripojena, koncime
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,183 :: 		do {
L_CJ125_PreHeat_LSU50:
;Bosch_CJ125.c,184 :: 		i++;   // 50x0.1s = 5s faze suseni kondenzacni vlhkosti
	INCF        CJ125_PreHeat_LSU_i_L0+0, 1 
;Bosch_CJ125.c,185 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF);  // MeasVbat;   // zmeri Vbat a ulozi jako U16 v [mV], napr 12.46V = 12460mV
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
;Bosch_CJ125.c,186 :: 		UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);
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
;Bosch_CJ125.c,187 :: 		UART_PrintU8(1,i); UART_PrintTxt(1," "); UART_PrintU16(1,UR_mV); UART_PrintTxt(1," ");    //     ByteToStr(i, _txtU8); UART_PrintTxt(1,_txtU8);UART_PrintTxt(1," ");
	MOVF        CJ125_PreHeat_LSU_i_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       __txtU8+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(__txtU8+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr30_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr30_Bosch_CJ125+0)
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
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr31_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr31_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
;Bosch_CJ125.c,188 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_CJ125_PreHeat_LSU53:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_PreHeat_LSU53
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_PreHeat_LSU53
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_PreHeat_LSU53
;Bosch_CJ125.c,189 :: 		} while ((i < 50) && (UR_mV > 2000)); // do nebo for  // dokud je UR vetsi nez 2000, bezi kondenzace - teply start by mel byt preskocen
	MOVLW       50
	SUBWF       CJ125_PreHeat_LSU_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__CJ125_PreHeat_LSU73
	MOVF        _UR_mV+1, 0 
	SUBLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_PreHeat_LSU94
	MOVF        _UR_mV+0, 0 
	SUBLW       208
L__CJ125_PreHeat_LSU94:
	BTFSC       STATUS+0, 0 
	GOTO        L__CJ125_PreHeat_LSU73
	GOTO        L_CJ125_PreHeat_LSU50
L__CJ125_PreHeat_LSU73:
;Bosch_CJ125.c,190 :: 		CR_LF(1); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,193 :: 		Heat_Target_PWM = RampHeatInit_PWM;    // na tomto napeti zaciname fazi 2
	MOVF        CJ125_PreHeat_LSU_RampHeatInit_PWM_L0+0, 0 
	MOVWF       _Heat_Target_PWM+0 
	MOVF        CJ125_PreHeat_LSU_RampHeatInit_PWM_L0+1, 0 
	MOVWF       _Heat_Target_PWM+1 
;Bosch_CJ125.c,194 :: 		UART_PrintTxt(1,"CJ125 heating start...."); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr32_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr32_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,195 :: 		Vbat_mV = Get_AD_mV(Vbat_AD_ch,VBAT_KOEF ); Vbat_mV = Vbat_mV /10;  // napr 13600 / 10 = 1360
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
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _Vbat_mV+0 
	MOVF        R1, 0 
	MOVWF       _Vbat_mV+1 
;Bosch_CJ125.c,196 :: 		Heat_PWM = (Heat_Target_PWM / Vbat_mV) * 25;  // napr. 8500 / 1360 = 6 * 25 = 150
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        _Heat_Target_PWM+0, 0 
	MOVWF       R0 
	MOVF        _Heat_Target_PWM+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       25
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _Heat_PWM+0 
	MOVF        R1, 0 
	MOVWF       _Heat_PWM+1 
;Bosch_CJ125.c,197 :: 		do {
L_CJ125_PreHeat_LSU56:
;Bosch_CJ125.c,198 :: 		UR_mV = Get_AD_mV(UR_AD_ch,AD_KOEF);   // merime UR - teplotu sondy
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
;Bosch_CJ125.c,199 :: 		if (Heat_PWM >= HEAT_MAX) Heat_PWM = HEAT_MAX;   // omezime max. stridu (max. trvale  12.0V na topeni !)
	MOVLW       0
	SUBWF       _Heat_PWM+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_PreHeat_LSU95
	MOVF        CJ125_PreHeat_LSU_HEAT_MAX_L0+0, 0 
	SUBWF       _Heat_PWM+0, 0 
L__CJ125_PreHeat_LSU95:
	BTFSS       STATUS+0, 0 
	GOTO        L_CJ125_PreHeat_LSU59
	MOVF        CJ125_PreHeat_LSU_HEAT_MAX_L0+0, 0 
	MOVWF       _Heat_PWM+0 
	MOVLW       0
	MOVWF       _Heat_PWM+1 
L_CJ125_PreHeat_LSU59:
;Bosch_CJ125.c,200 :: 		UART_PrintTxt(1," UR=");       UART_PrintU16(1,UR_mV); // WordToStr(UR_mV, _txtU16); UART_PrintTxt(1,_txtU16);
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr33_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr33_Bosch_CJ125+0)
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
;Bosch_CJ125.c,201 :: 		UART_PrintTxt(1," PWM="); UART_PrintU16(1,Heat_PWM); CR_LF;
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr34_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr34_Bosch_CJ125+0)
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
;Bosch_CJ125.c,202 :: 		PWM4_Set_Duty(Heat_PWM);    // topime
	MOVF        _Heat_PWM+0, 0 
	MOVWF       FARG_PWM4_Set_Duty_new_duty+0 
	CALL        _PWM4_Set_Duty+0, 0
;Bosch_CJ125.c,203 :: 		Heat_PWM += HEAT_STEP;   //  +3 a 300ms Delay je cca 0.4V RMS/s
	MOVF        CJ125_PreHeat_LSU_HEAT_STEP_L0+0, 0 
	ADDWF       _Heat_PWM+0, 1 
	MOVLW       0
	ADDWFC      _Heat_PWM+1, 1 
;Bosch_CJ125.c,204 :: 		Delay_ms(HEAT_RAMP_DELAY);     //
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_CJ125_PreHeat_LSU60:
	DECFSZ      R13, 1, 1
	BRA         L_CJ125_PreHeat_LSU60
	DECFSZ      R12, 1, 1
	BRA         L_CJ125_PreHeat_LSU60
	DECFSZ      R11, 1, 1
	BRA         L_CJ125_PreHeat_LSU60
	NOP
	NOP
;Bosch_CJ125.c,205 :: 		CJ125_Ans = CJ125_Write(CJ125_DIAG_REG_REQUEST);    // test pripojeni sondy, kdyz by nebyla pripojena, koncime
	MOVLW       0
	MOVWF       FARG_CJ125_Write_TX_data+0 
	MOVLW       120
	MOVWF       FARG_CJ125_Write_TX_data+1 
	CALL        _CJ125_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _CJ125_Ans+0 
	MOVF        R1, 0 
	MOVWF       _CJ125_Ans+1 
;Bosch_CJ125.c,206 :: 		if (CJ125_Ans !=  CJ125_DIAG_REG_STATUS_OK) { UART_PrintTxt(1," Sensor failure/disconnect during heat-up.."); CR_LF(1); UR_mV=UR_mV_ref; }
	MOVF        R1, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_PreHeat_LSU96
	MOVLW       255
	XORWF       R0, 0 
L__CJ125_PreHeat_LSU96:
	BTFSC       STATUS+0, 2 
	GOTO        L_CJ125_PreHeat_LSU61
	MOVLW       1
	MOVWF       FARG_UART_PrintTxt_UART_nr+0 
	MOVLW       ?lstr35_Bosch_CJ125+0
	MOVWF       FARG_UART_PrintTxt_p_string+0 
	MOVLW       hi_addr(?lstr35_Bosch_CJ125+0)
	MOVWF       FARG_UART_PrintTxt_p_string+1 
	CALL        _UART_PrintTxt+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVF        _UR_mV_ref+0, 0 
	MOVWF       _UR_mV+0 
	MOVF        _UR_mV_ref+1, 0 
	MOVWF       _UR_mV+1 
L_CJ125_PreHeat_LSU61:
;Bosch_CJ125.c,207 :: 		} while (UR_mV >= (UR_mV_ref+200));   // || (Heat_PWM < HEAT_MAX));  // zvysujeme rampu dokud nedosahme max. teploty dle UR ci max. stridy
	MOVLW       200
	ADDWF       _UR_mV_ref+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _UR_mV_ref+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       _UR_mV+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__CJ125_PreHeat_LSU97
	MOVF        R1, 0 
	SUBWF       _UR_mV+0, 0 
L__CJ125_PreHeat_LSU97:
	BTFSC       STATUS+0, 0 
	GOTO        L_CJ125_PreHeat_LSU56
;Bosch_CJ125.c,208 :: 		CR_LF(1); CR_LF(1);
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
	MOVLW       1
	MOVWF       FARG_CR_LF_i+0 
	CALL        _CR_LF+0, 0
;Bosch_CJ125.c,209 :: 		}
L_end_CJ125_PreHeat_LSU:
	RETURN      0
; end of _CJ125_PreHeat_LSU

_Heater_PID_Control:

;Bosch_CJ125.c,213 :: 		i16 Heater_PID_Control(u8 LSU, i16 input, i16 target) { //  vstupvy v mV (napr. 1580, 780); vraci 0-255 (napr. pro ovladani 8bit PWM)
;Bosch_CJ125.c,214 :: 		u16 MAX_PWM=0;
	CLRF        Heater_PID_Control_MAX_PWM_L0+0 
	CLRF        Heater_PID_Control_MAX_PWM_L0+1 
;Bosch_CJ125.c,215 :: 		i16 error = target - input;    /// 1000 - 4200 = -3200
	MOVF        FARG_Heater_PID_Control_input+0, 0 
	SUBWF       FARG_Heater_PID_Control_target+0, 0 
	MOVWF       Heater_PID_Control_error_L0+0 
	MOVF        FARG_Heater_PID_Control_input+1, 0 
	SUBWFB      FARG_Heater_PID_Control_target+1, 0 
	MOVWF       Heater_PID_Control_error_L0+1 
;Bosch_CJ125.c,216 :: 		i16 position = input;
	MOVF        FARG_Heater_PID_Control_input+0, 0 
	MOVWF       Heater_PID_Control_position_L0+0 
	MOVF        FARG_Heater_PID_Control_input+1, 0 
	MOVWF       Heater_PID_Control_position_L0+1 
;Bosch_CJ125.c,218 :: 		if      (LSU == LSU42)  MAX_PWM = 210;
	MOVF        FARG_Heater_PID_Control_LSU+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Heater_PID_Control62
	MOVLW       210
	MOVWF       Heater_PID_Control_MAX_PWM_L0+0 
	MOVLW       0
	MOVWF       Heater_PID_Control_MAX_PWM_L0+1 
	GOTO        L_Heater_PID_Control63
L_Heater_PID_Control62:
;Bosch_CJ125.c,219 :: 		else if (LSU == LSU49)  MAX_PWM = 170;  //  tj. 75% z Vbat, tj. pri 14V je Vheat(max) = 10.5V (max dle PDF je 12.0V
	MOVF        FARG_Heater_PID_Control_LSU+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Heater_PID_Control64
	MOVLW       170
	MOVWF       Heater_PID_Control_MAX_PWM_L0+0 
	MOVLW       0
	MOVWF       Heater_PID_Control_MAX_PWM_L0+1 
L_Heater_PID_Control64:
L_Heater_PID_Control63:
;Bosch_CJ125.c,221 :: 		pGain = 2.5;   //  3.0  (3.0, 0.5, 1.0 - OK) , take 6.0 / 0.5 / 1.0 je  tez ok
	MOVLW       0
	MOVWF       _pGain+0 
	MOVLW       0
	MOVWF       _pGain+1 
	MOVLW       32
	MOVWF       _pGain+2 
	MOVLW       128
	MOVWF       _pGain+3 
;Bosch_CJ125.c,222 :: 		iGain = 0.6;   //  0.6
	MOVLW       154
	MOVWF       _iGain+0 
	MOVLW       153
	MOVWF       _iGain+1 
	MOVLW       25
	MOVWF       _iGain+2 
	MOVLW       126
	MOVWF       _iGain+3 
;Bosch_CJ125.c,223 :: 		dGain = 1.0;   //  0.5 ok - 1.0  // ovlivnuje rychlost zmen - 50.0 je masakr
	MOVLW       0
	MOVWF       _dGain+0 
	MOVLW       0
	MOVWF       _dGain+1 
	MOVLW       0
	MOVWF       _dGain+2 
	MOVLW       127
	MOVWF       _dGain+3 
;Bosch_CJ125.c,225 :: 		pTerm = -pGain * error;              // P slozka
	MOVF        Heater_PID_Control_error_L0+0, 0 
	MOVWF       R0 
	MOVF        Heater_PID_Control_error_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       160
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _pTerm+0 
	MOVF        R1, 0 
	MOVWF       _pTerm+1 
	MOVF        R2, 0 
	MOVWF       _pTerm+2 
	MOVF        R3, 0 
	MOVWF       _pTerm+3 
;Bosch_CJ125.c,226 :: 		iState += error;                     // "Integrace" chyby
	MOVF        Heater_PID_Control_error_L0+0, 0 
	ADDWF       _iState+0, 0 
	MOVWF       R1 
	MOVF        Heater_PID_Control_error_L0+1, 0 
	ADDWFC      _iState+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _iState+0 
	MOVF        R2, 0 
	MOVWF       _iState+1 
;Bosch_CJ125.c,227 :: 		if (iState > iMax) iState = iMax;    // omezeni I chyby
	MOVLW       128
	XORWF       _iMax+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Heater_PID_Control99
	MOVF        R1, 0 
	SUBWF       _iMax+0, 0 
L__Heater_PID_Control99:
	BTFSC       STATUS+0, 0 
	GOTO        L_Heater_PID_Control65
	MOVF        _iMax+0, 0 
	MOVWF       _iState+0 
	MOVF        _iMax+1, 0 
	MOVWF       _iState+1 
L_Heater_PID_Control65:
;Bosch_CJ125.c,228 :: 		if (iState < iMin) iState = iMin;
	MOVLW       128
	XORWF       _iState+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _iMin+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Heater_PID_Control100
	MOVF        _iMin+0, 0 
	SUBWF       _iState+0, 0 
L__Heater_PID_Control100:
	BTFSC       STATUS+0, 0 
	GOTO        L_Heater_PID_Control66
	MOVF        _iMin+0, 0 
	MOVWF       _iState+0 
	MOVF        _iMin+1, 0 
	MOVWF       _iState+1 
L_Heater_PID_Control66:
;Bosch_CJ125.c,229 :: 		iTerm = -iGain * iState;              // I slozka
	MOVLW       0
	XORWF       _iGain+0, 0 
	MOVWF       FLOC__Heater_PID_Control+0 
	MOVLW       0
	XORWF       _iGain+1, 0 
	MOVWF       FLOC__Heater_PID_Control+1 
	MOVLW       128
	XORWF       _iGain+2, 0 
	MOVWF       FLOC__Heater_PID_Control+2 
	MOVLW       0
	XORWF       _iGain+3, 0 
	MOVWF       FLOC__Heater_PID_Control+3 
	MOVF        _iState+0, 0 
	MOVWF       R0 
	MOVF        _iState+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        FLOC__Heater_PID_Control+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Heater_PID_Control+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Heater_PID_Control+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Heater_PID_Control+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Heater_PID_Control+4 
	MOVF        R1, 0 
	MOVWF       FLOC__Heater_PID_Control+5 
	MOVF        R2, 0 
	MOVWF       FLOC__Heater_PID_Control+6 
	MOVF        R3, 0 
	MOVWF       FLOC__Heater_PID_Control+7 
	MOVF        FLOC__Heater_PID_Control+4, 0 
	MOVWF       _iTerm+0 
	MOVF        FLOC__Heater_PID_Control+5, 0 
	MOVWF       _iTerm+1 
	MOVF        FLOC__Heater_PID_Control+6, 0 
	MOVWF       _iTerm+2 
	MOVF        FLOC__Heater_PID_Control+7, 0 
	MOVWF       _iTerm+3 
;Bosch_CJ125.c,230 :: 		dTerm = -dGain * (dState - position); // D
	MOVLW       0
	XORWF       _dGain+0, 0 
	MOVWF       FLOC__Heater_PID_Control+0 
	MOVLW       0
	XORWF       _dGain+1, 0 
	MOVWF       FLOC__Heater_PID_Control+1 
	MOVLW       128
	XORWF       _dGain+2, 0 
	MOVWF       FLOC__Heater_PID_Control+2 
	MOVLW       0
	XORWF       _dGain+3, 0 
	MOVWF       FLOC__Heater_PID_Control+3 
	MOVF        Heater_PID_Control_position_L0+0, 0 
	SUBWF       _dState+0, 0 
	MOVWF       R0 
	MOVF        Heater_PID_Control_position_L0+1, 0 
	SUBWFB      _dState+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        FLOC__Heater_PID_Control+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Heater_PID_Control+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Heater_PID_Control+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Heater_PID_Control+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Heater_PID_Control+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Heater_PID_Control+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Heater_PID_Control+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Heater_PID_Control+3 
	MOVF        FLOC__Heater_PID_Control+0, 0 
	MOVWF       _dTerm+0 
	MOVF        FLOC__Heater_PID_Control+1, 0 
	MOVWF       _dTerm+1 
	MOVF        FLOC__Heater_PID_Control+2, 0 
	MOVWF       _dTerm+2 
	MOVF        FLOC__Heater_PID_Control+3, 0 
	MOVWF       _dTerm+3 
;Bosch_CJ125.c,231 :: 		dState = position;
	MOVF        Heater_PID_Control_position_L0+0, 0 
	MOVWF       _dState+0 
	MOVF        Heater_PID_Control_position_L0+1, 0 
	MOVWF       _dState+1 
;Bosch_CJ125.c,232 :: 		PID_OutPWM = pTerm + iTerm + dTerm;
	MOVF        _pTerm+0, 0 
	MOVWF       R0 
	MOVF        _pTerm+1, 0 
	MOVWF       R1 
	MOVF        _pTerm+2, 0 
	MOVWF       R2 
	MOVF        _pTerm+3, 0 
	MOVWF       R3 
	MOVF        FLOC__Heater_PID_Control+4, 0 
	MOVWF       R4 
	MOVF        FLOC__Heater_PID_Control+5, 0 
	MOVWF       R5 
	MOVF        FLOC__Heater_PID_Control+6, 0 
	MOVWF       R6 
	MOVF        FLOC__Heater_PID_Control+7, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        FLOC__Heater_PID_Control+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Heater_PID_Control+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Heater_PID_Control+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Heater_PID_Control+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Heater_PID_Control+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Heater_PID_Control+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Heater_PID_Control+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Heater_PID_Control+3 
	MOVF        FLOC__Heater_PID_Control+0, 0 
	MOVWF       _PID_OutPWM+0 
	MOVF        FLOC__Heater_PID_Control+1, 0 
	MOVWF       _PID_OutPWM+1 
	MOVF        FLOC__Heater_PID_Control+2, 0 
	MOVWF       _PID_OutPWM+2 
	MOVF        FLOC__Heater_PID_Control+3, 0 
	MOVWF       _PID_OutPWM+3 
;Bosch_CJ125.c,233 :: 		if (PID_OutPWM > MAX_PWM) PID_OutPWM = MAX_PWM;
	MOVF        Heater_PID_Control_MAX_PWM_L0+0, 0 
	MOVWF       R0 
	MOVF        Heater_PID_Control_MAX_PWM_L0+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__Heater_PID_Control+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Heater_PID_Control+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Heater_PID_Control+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Heater_PID_Control+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Heater_PID_Control67
	MOVF        Heater_PID_Control_MAX_PWM_L0+0, 0 
	MOVWF       R0 
	MOVF        Heater_PID_Control_MAX_PWM_L0+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _PID_OutPWM+0 
	MOVF        R1, 0 
	MOVWF       _PID_OutPWM+1 
	MOVF        R2, 0 
	MOVWF       _PID_OutPWM+2 
	MOVF        R3, 0 
	MOVWF       _PID_OutPWM+3 
L_Heater_PID_Control67:
;Bosch_CJ125.c,234 :: 		if (PID_OutPWM < 0.0) PID_OutPWM = 0.0;
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        _PID_OutPWM+0, 0 
	MOVWF       R0 
	MOVF        _PID_OutPWM+1, 0 
	MOVWF       R1 
	MOVF        _PID_OutPWM+2, 0 
	MOVWF       R2 
	MOVF        _PID_OutPWM+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Heater_PID_Control68
	CLRF        _PID_OutPWM+0 
	CLRF        _PID_OutPWM+1 
	CLRF        _PID_OutPWM+2 
	CLRF        _PID_OutPWM+3 
L_Heater_PID_Control68:
;Bosch_CJ125.c,242 :: 		return (u8)PID_OutPWM;
	MOVF        _PID_OutPWM+0, 0 
	MOVWF       R0 
	MOVF        _PID_OutPWM+1, 0 
	MOVWF       R1 
	MOVF        _PID_OutPWM+2, 0 
	MOVWF       R2 
	MOVF        _PID_OutPWM+3, 0 
	MOVWF       R3 
	CALL        _double2byte+0, 0
	MOVLW       0
	MOVWF       R1 
;Bosch_CJ125.c,243 :: 		}
L_end_Heater_PID_Control:
	RETURN      0
; end of _Heater_PID_Control

_CJ125_Calc_Ip:

;Bosch_CJ125.c,247 :: 		i16 CJ125_Calc_Ip(float Ua_mV, u8 Amplify) {  // funguje ok
;Bosch_CJ125.c,248 :: 		float Ip=0;                  // 8 nebo 17
;Bosch_CJ125.c,249 :: 		Ua_mV = Ua_mV / 1000.0;  // prevod na volty
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	MOVF        FARG_CJ125_Calc_Ip_Ua_mV+0, 0 
	MOVWF       R0 
	MOVF        FARG_CJ125_Calc_Ip_Ua_mV+1, 0 
	MOVWF       R1 
	MOVF        FARG_CJ125_Calc_Ip_Ua_mV+2, 0 
	MOVWF       R2 
	MOVF        FARG_CJ125_Calc_Ip_Ua_mV+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+0 
	MOVF        R1, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+1 
	MOVF        R2, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+2 
	MOVF        R3, 0 
	MOVWF       FARG_CJ125_Calc_Ip_Ua_mV+3 
;Bosch_CJ125.c,251 :: 		Ip = (1000.0 * (Ua_mV - 1.5)) / (61.9 * Amplify);
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       64
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__CJ125_Calc_Ip+0 
	MOVF        R1, 0 
	MOVWF       FLOC__CJ125_Calc_Ip+1 
	MOVF        R2, 0 
	MOVWF       FLOC__CJ125_Calc_Ip+2 
	MOVF        R3, 0 
	MOVWF       FLOC__CJ125_Calc_Ip+3 
	MOVF        FARG_CJ125_Calc_Ip_Amplify+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVLW       154
	MOVWF       R4 
	MOVLW       153
	MOVWF       R5 
	MOVLW       119
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__CJ125_Calc_Ip+0, 0 
	MOVWF       R0 
	MOVF        FLOC__CJ125_Calc_Ip+1, 0 
	MOVWF       R1 
	MOVF        FLOC__CJ125_Calc_Ip+2, 0 
	MOVWF       R2 
	MOVF        FLOC__CJ125_Calc_Ip+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
;Bosch_CJ125.c,252 :: 		Ip *= 1000;  // prepocet kvuli nasledne lin. regresy, ktera hleda v i16 tabulce misto float
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
;Bosch_CJ125.c,253 :: 		return (i16)Ip; // vracime jen jako I16 - kvuli zrychleni
	CALL        _double2int+0, 0
;Bosch_CJ125.c,254 :: 		}
L_end_CJ125_Calc_Ip:
	RETURN      0
; end of _CJ125_Calc_Ip
