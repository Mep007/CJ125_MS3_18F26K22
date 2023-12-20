
_MAX7219_Init:

;MAX7219.c,5 :: 		void MAX7219_Init(unsigned char nr_digits, unsigned char intensity)
;MAX7219.c,7 :: 		unsigned char i, j = 0;
	CLRF        MAX7219_Init_j_L0+0 
;MAX7219.c,9 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,10 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,13 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,14 :: 		SPI1_Write(_MAX7219_REG_DECODE_MODE);
	MOVLW       9
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,15 :: 		for (i = 0; i <= nr_digits; i++)  {
	CLRF        MAX7219_Init_i_L0+0 
L_MAX7219_Init0:
	MOVF        MAX7219_Init_i_L0+0, 0 
	SUBWF       FARG_MAX7219_Init_nr_digits+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219_Init1
;MAX7219.c,16 :: 		j = j << 1;
	RLCF        MAX7219_Init_j_L0+0, 1 
	BCF         MAX7219_Init_j_L0+0, 0 
;MAX7219.c,17 :: 		j++;
	INCF        MAX7219_Init_j_L0+0, 1 
;MAX7219.c,15 :: 		for (i = 0; i <= nr_digits; i++)  {
	INCF        MAX7219_Init_i_L0+0, 1 
;MAX7219.c,18 :: 		}
	GOTO        L_MAX7219_Init0
L_MAX7219_Init1:
;MAX7219.c,19 :: 		SPI1_Write(j);
	MOVF        MAX7219_Init_j_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,20 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,21 :: 		Delay_10ms();
	CALL        _Delay_10ms+0, 0
;MAX7219.c,23 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,24 :: 		SPI1_Write(_MAX7219_REG_INTENSITY);
	MOVLW       10
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,25 :: 		SPI1_Write(intensity);
	MOVF        FARG_MAX7219_Init_intensity+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,26 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,27 :: 		Delay_10ms();
	CALL        _Delay_10ms+0, 0
;MAX7219.c,29 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,30 :: 		SPI1_Write(_MAX7219_REG_SCAN_LIMIT);
	MOVLW       11
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,31 :: 		SPI1_Write(nr_digits);
	MOVF        FARG_MAX7219_Init_nr_digits+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,32 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,34 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,35 :: 		SPI1_Write(_MAX7219_REG_SHUTDOWN);
	MOVLW       12
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,36 :: 		SPI1_Write(_MAX7219_SHUTDOWN_NORMAL_MODE);
	MOVLW       1
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,37 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,39 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,40 :: 		SPI1_Write(_MAX7219_REG_NO_OP);
	CLRF        FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,41 :: 		SPI1_Write(0xff);
	MOVLW       255
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,42 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,45 :: 		MAX7219_ShowDigit(0x0A,0); // zapise pomlcku do vsech digitu (0xF - je blank)
	MOVLW       10
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	CLRF        FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,46 :: 		MAX7219_ShowDigit(0x0A,1);
	MOVLW       10
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       1
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,47 :: 		MAX7219_ShowDigit(0x0A,2);
	MOVLW       10
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       2
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,48 :: 		MAX7219_ShowDigit(0x0A,3);
	MOVLW       10
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       3
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,50 :: 		}
L_end_MAX7219_Init:
	RETURN      0
; end of _MAX7219_Init

_MAX7219_DisplayOnOff:

;MAX7219.c,52 :: 		void MAX7219_DisplayOnOff(unsigned char on_off)
;MAX7219.c,54 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,55 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,56 :: 		SPI1_Write(_MAX7219_REG_SHUTDOWN);
	MOVLW       12
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,57 :: 		SPI1_Write(on_off);
	MOVF        FARG_MAX7219_DisplayOnOff_on_off+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,58 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,59 :: 		}
L_end_MAX7219_DisplayOnOff:
	RETURN      0
; end of _MAX7219_DisplayOnOff

_MAX7219SetIntensity:

;MAX7219.c,61 :: 		void MAX7219SetIntensity(unsigned char new_intensity)
;MAX7219.c,63 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,64 :: 		if(new_intensity >= 0 && new_intensity <= 15)
	MOVLW       0
	SUBWF       FARG_MAX7219SetIntensity_new_intensity+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219SetIntensity5
	MOVF        FARG_MAX7219SetIntensity_new_intensity+0, 0 
	SUBLW       15
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219SetIntensity5
L__MAX7219SetIntensity41:
;MAX7219.c,66 :: 		MAX7219_CS=0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,67 :: 		SPI1_Write(_MAX7219_REG_INTENSITY);
	MOVLW       10
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,68 :: 		SPI1_Write(new_intensity);
	MOVF        FARG_MAX7219SetIntensity_new_intensity+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,69 :: 		MAX7219_CS=1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,70 :: 		}
L_MAX7219SetIntensity5:
;MAX7219.c,71 :: 		}
L_end_MAX7219SetIntensity:
	RETURN      0
; end of _MAX7219SetIntensity

_MAX7219_TestDisplay:

;MAX7219.c,73 :: 		void MAX7219_TestDisplay(unsigned char on_off)
;MAX7219.c,75 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,76 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,77 :: 		SPI1_Write(_MAX7219_REG_DISPLAY_TEST);
	MOVLW       15
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,78 :: 		SPI1_Write(on_off);
	MOVF        FARG_MAX7219_TestDisplay_on_off+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,79 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,80 :: 		}
L_end_MAX7219_TestDisplay:
	RETURN      0
; end of _MAX7219_TestDisplay

_MAX7219_ShowNumber:

;MAX7219.c,82 :: 		void MAX7219_ShowNumber(unsigned long Number, unsigned char firstDigit, unsigned char numberOfDigits) {
;MAX7219.c,84 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,86 :: 		numberOfDigits = firstDigit + numberOfDigits;
	MOVF        FARG_MAX7219_ShowNumber_firstDigit+0, 0 
	ADDWF       FARG_MAX7219_ShowNumber_numberOfDigits+0, 1 
;MAX7219.c,87 :: 		for(i = firstDigit; i <= numberOfDigits; Number/=10, i++)
	MOVF        FARG_MAX7219_ShowNumber_firstDigit+0, 0 
	MOVWF       MAX7219_ShowNumber_i_L0+0 
	MOVLW       0
	MOVWF       MAX7219_ShowNumber_i_L0+1 
L_MAX7219_ShowNumber6:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       MAX7219_ShowNumber_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowNumber50
	MOVF        MAX7219_ShowNumber_i_L0+0, 0 
	SUBWF       FARG_MAX7219_ShowNumber_numberOfDigits+0, 0 
L__MAX7219_ShowNumber50:
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumber7
;MAX7219.c,89 :: 		MAX7219_CS=0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,90 :: 		SPI1_Write((i + 1) << 8 + (Number %10));
	MOVF        MAX7219_ShowNumber_i_L0+0, 0 
	ADDLW       1
	MOVWF       FARG_SPI1_Write_data_+0 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_MAX7219_ShowNumber_Number+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_ShowNumber_Number+1, 0 
	MOVWF       R1 
	MOVF        FARG_MAX7219_ShowNumber_Number+2, 0 
	MOVWF       R2 
	MOVF        FARG_MAX7219_ShowNumber_Number+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVLW       8
	ADDWF       R0, 1 
	MOVF        R0, 0 
L__MAX7219_ShowNumber51:
	BZ          L__MAX7219_ShowNumber52
	RLCF        FARG_SPI1_Write_data_+0, 1 
	BCF         FARG_SPI1_Write_data_+0, 0 
	ADDLW       255
	GOTO        L__MAX7219_ShowNumber51
L__MAX7219_ShowNumber52:
	CALL        _SPI1_Write+0, 0
;MAX7219.c,91 :: 		SPI1_Write(Number % 10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_MAX7219_ShowNumber_Number+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_ShowNumber_Number+1, 0 
	MOVWF       R1 
	MOVF        FARG_MAX7219_ShowNumber_Number+2, 0 
	MOVWF       R2 
	MOVF        FARG_MAX7219_ShowNumber_Number+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,92 :: 		MAX7219_CS=1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,93 :: 		Delay_1ms();
	CALL        _Delay_1ms+0, 0
;MAX7219.c,87 :: 		for(i = firstDigit; i <= numberOfDigits; Number/=10, i++)
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_MAX7219_ShowNumber_Number+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_ShowNumber_Number+1, 0 
	MOVWF       R1 
	MOVF        FARG_MAX7219_ShowNumber_Number+2, 0 
	MOVWF       R2 
	MOVF        FARG_MAX7219_ShowNumber_Number+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MAX7219_ShowNumber_Number+0 
	MOVF        R1, 0 
	MOVWF       FARG_MAX7219_ShowNumber_Number+1 
	MOVF        R2, 0 
	MOVWF       FARG_MAX7219_ShowNumber_Number+2 
	MOVF        R3, 0 
	MOVWF       FARG_MAX7219_ShowNumber_Number+3 
	INFSNZ      MAX7219_ShowNumber_i_L0+0, 1 
	INCF        MAX7219_ShowNumber_i_L0+1, 1 
;MAX7219.c,94 :: 		}
	GOTO        L_MAX7219_ShowNumber6
L_MAX7219_ShowNumber7:
;MAX7219.c,95 :: 		}
L_end_MAX7219_ShowNumber:
	RETURN      0
; end of _MAX7219_ShowNumber

_MAX7219_ShowNumAuto:

;MAX7219.c,97 :: 		void MAX7219_ShowNumAuto(u16 num){ // zobrazi max. 4 cislice (kdyz 0 na MSB, digit=off)
;MAX7219.c,98 :: 		i8 i,digits=1,n=-1;
	MOVLW       1
	MOVWF       MAX7219_ShowNumAuto_digits_L0+0 
	MOVLW       255
	MOVWF       MAX7219_ShowNumAuto_n_L0+0 
;MAX7219.c,100 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,101 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,102 :: 		SPI1_Write(_MAX7219_REG_SCAN_LIMIT);
	MOVLW       11
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,103 :: 		SPI1_Write(_MAX7219_SHOW_DIGITS_0_3);  // 1 znak
	MOVLW       3
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,104 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,105 :: 		if (num >   9)  digits = 2; //SPI1_Write(_MAX7219_SHOW_DIGITS_0_3); } // 2znaky
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_MAX7219_ShowNumAuto_num+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowNumAuto54
	MOVF        FARG_MAX7219_ShowNumAuto_num+0, 0 
	SUBLW       9
L__MAX7219_ShowNumAuto54:
	BTFSC       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumAuto9
	MOVLW       2
	MOVWF       MAX7219_ShowNumAuto_digits_L0+0 
L_MAX7219_ShowNumAuto9:
;MAX7219.c,106 :: 		if (num >  99)  digits = 3; //SPI1_Write(_MAX7219_SHOW_DIGITS_0_3); }  // 3znaky
	MOVLW       0
	MOVWF       R0 
	MOVF        FARG_MAX7219_ShowNumAuto_num+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowNumAuto55
	MOVF        FARG_MAX7219_ShowNumAuto_num+0, 0 
	SUBLW       99
L__MAX7219_ShowNumAuto55:
	BTFSC       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumAuto10
	MOVLW       3
	MOVWF       MAX7219_ShowNumAuto_digits_L0+0 
L_MAX7219_ShowNumAuto10:
;MAX7219.c,107 :: 		if (num > 999)  digits = 4; //SPI1_Write(_MAX7219_SHOW_DIGITS_0_3); }  // 4znaky
	MOVF        FARG_MAX7219_ShowNumAuto_num+1, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowNumAuto56
	MOVF        FARG_MAX7219_ShowNumAuto_num+0, 0 
	SUBLW       231
L__MAX7219_ShowNumAuto56:
	BTFSC       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumAuto11
	MOVLW       4
	MOVWF       MAX7219_ShowNumAuto_digits_L0+0 
L_MAX7219_ShowNumAuto11:
;MAX7219.c,108 :: 		if (num < 10)   digits = 1;
	MOVLW       0
	SUBWF       FARG_MAX7219_ShowNumAuto_num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowNumAuto57
	MOVLW       10
	SUBWF       FARG_MAX7219_ShowNumAuto_num+0, 0 
L__MAX7219_ShowNumAuto57:
	BTFSC       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumAuto12
	MOVLW       1
	MOVWF       MAX7219_ShowNumAuto_digits_L0+0 
L_MAX7219_ShowNumAuto12:
;MAX7219.c,109 :: 		temp = num;
	MOVF        FARG_MAX7219_ShowNumAuto_num+0, 0 
	MOVWF       MAX7219_ShowNumAuto_temp_L0+0 
	MOVF        FARG_MAX7219_ShowNumAuto_num+1, 0 
	MOVWF       MAX7219_ShowNumAuto_temp_L0+1 
;MAX7219.c,110 :: 		for(i = 1; i <= 4; temp = temp / 10, i++) { // i=1 -> 12345 % 10 = 5 i=2 -> 12345/10= 1234 % 10 = 4 atd.
	MOVLW       1
	MOVWF       MAX7219_ShowNumAuto_i_L0+0 
L_MAX7219_ShowNumAuto13:
	MOVLW       128
	XORLW       4
	MOVWF       R0 
	MOVLW       128
	XORWF       MAX7219_ShowNumAuto_i_L0+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumAuto14
;MAX7219.c,111 :: 		n = digits - i;    // kdyz je >= 0 => tiskneme znak, jinak znak OFF
	MOVF        MAX7219_ShowNumAuto_i_L0+0, 0 
	SUBWF       MAX7219_ShowNumAuto_digits_L0+0, 0 
	MOVWF       MAX7219_ShowNumAuto_n_L0+0 
;MAX7219.c,112 :: 		MAX7219_CS=0;      // 3-1=2 3-2=1, 3-3=0
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,113 :: 		SPI1_Write(5-i); // pozice
	MOVF        MAX7219_ShowNumAuto_i_L0+0, 0 
	SUBLW       5
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,114 :: 		if(n>=0) SPI1_Write((temp % 10));  // je cislice k tisku... ?
	MOVLW       128
	XORWF       MAX7219_ShowNumAuto_n_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219_ShowNumAuto16
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        MAX7219_ShowNumAuto_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        MAX7219_ShowNumAuto_temp_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
	GOTO        L_MAX7219_ShowNumAuto17
L_MAX7219_ShowNumAuto16:
;MAX7219.c,115 :: 		else   { SPI1_Write(MAX7219_BLANK); }  // ...neni, segment OFF (blank)
	MOVLW       127
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
L_MAX7219_ShowNumAuto17:
;MAX7219.c,116 :: 		MAX7219_CS=1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,110 :: 		for(i = 1; i <= 4; temp = temp / 10, i++) { // i=1 -> 12345 % 10 = 5 i=2 -> 12345/10= 1234 % 10 = 4 atd.
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        MAX7219_ShowNumAuto_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        MAX7219_ShowNumAuto_temp_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       MAX7219_ShowNumAuto_temp_L0+0 
	MOVF        R1, 0 
	MOVWF       MAX7219_ShowNumAuto_temp_L0+1 
	INCF        MAX7219_ShowNumAuto_i_L0+0, 1 
;MAX7219.c,117 :: 		}
	GOTO        L_MAX7219_ShowNumAuto13
L_MAX7219_ShowNumAuto14:
;MAX7219.c,118 :: 		}
L_end_MAX7219_ShowNumAuto:
	RETURN      0
; end of _MAX7219_ShowNumAuto

_MAX7219_ShowDigit:

;MAX7219.c,120 :: 		void MAX7219_ShowDigit(unsigned char number, unsigned char digit)
;MAX7219.c,122 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,123 :: 		MAX7219_CS=0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,124 :: 		SPI1_Write(digit + 1);  // pozice
	MOVF        FARG_MAX7219_ShowDigit_digit+0, 0 
	ADDLW       1
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,125 :: 		SPI1_Write(number);     // cislo
	MOVF        FARG_MAX7219_ShowDigit_number+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,126 :: 		MAX7219_CS=1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,127 :: 		}
L_end_MAX7219_ShowDigit:
	RETURN      0
; end of _MAX7219_ShowDigit

_MAX7219_PrintAFR:

;MAX7219.c,129 :: 		void MAX7219_PrintAFR(u16 temp,char DP,u8 type)     // 1258 => 12.58
;MAX7219.c,132 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,134 :: 		MAX7219_CS = 0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,135 :: 		SPI1_Write(_MAX7219_REG_SCAN_LIMIT);
	MOVLW       11
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,136 :: 		SPI1_Write(_MAX7219_SHOW_DIGITS_0_3);
	MOVLW       3
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,137 :: 		MAX7219_CS = 1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,138 :: 		for(i = 1; i <= 4; temp=temp/10, i++) {
	MOVLW       1
	MOVWF       MAX7219_PrintAFR_i_L0+0 
L_MAX7219_PrintAFR18:
	MOVF        MAX7219_PrintAFR_i_L0+0, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219_PrintAFR19
;MAX7219.c,139 :: 		MAX7219_CS=0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,140 :: 		SPI1_Write(5-i); // pozice
	MOVF        MAX7219_PrintAFR_i_L0+0, 0 
	SUBLW       5
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,141 :: 		if ((i == 3) && (DP > 0))     SPI1_Write((temp % 10) | 0x80); // DP na pozici 2
	MOVF        MAX7219_PrintAFR_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_PrintAFR23
	MOVF        FARG_MAX7219_PrintAFR_DP+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_MAX7219_PrintAFR23
L__MAX7219_PrintAFR43:
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_MAX7219_PrintAFR_temp+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_PrintAFR_temp+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
	GOTO        L_MAX7219_PrintAFR24
L_MAX7219_PrintAFR23:
;MAX7219.c,142 :: 		else if ((i==4) && (type==1)) SPI1_Write((temp % 10) | 0x80);
	MOVF        MAX7219_PrintAFR_i_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_PrintAFR27
	MOVF        FARG_MAX7219_PrintAFR_type+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_PrintAFR27
L__MAX7219_PrintAFR42:
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_MAX7219_PrintAFR_temp+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_PrintAFR_temp+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
	GOTO        L_MAX7219_PrintAFR28
L_MAX7219_PrintAFR27:
;MAX7219.c,143 :: 		else SPI1_Write(temp % 10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_MAX7219_PrintAFR_temp+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_PrintAFR_temp+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
L_MAX7219_PrintAFR28:
L_MAX7219_PrintAFR24:
;MAX7219.c,144 :: 		MAX7219_CS=1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,138 :: 		for(i = 1; i <= 4; temp=temp/10, i++) {
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_MAX7219_PrintAFR_temp+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_PrintAFR_temp+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MAX7219_PrintAFR_temp+0 
	MOVF        R1, 0 
	MOVWF       FARG_MAX7219_PrintAFR_temp+1 
	INCF        MAX7219_PrintAFR_i_L0+0, 1 
;MAX7219.c,146 :: 		}
	GOTO        L_MAX7219_PrintAFR18
L_MAX7219_PrintAFR19:
;MAX7219.c,147 :: 		}
L_end_MAX7219_PrintAFR:
	RETURN      0
; end of _MAX7219_PrintAFR

_MAX7219_PrintMAP:

;MAX7219.c,149 :: 		void MAX7219_PrintMAP(u16 num,char DP)     // 1258 => 12.58
;MAX7219.c,151 :: 		u8 i=0,tmp=0;
	CLRF        MAX7219_PrintMAP_i_L0+0 
	CLRF        MAX7219_PrintMAP_tmp_L0+0 
;MAX7219.c,153 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,155 :: 		MAX7219_ShowDigit(0x0F|0x80,0);   // symbol tecky na prvni digit jako Pressure
	MOVLW       143
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	CLRF        FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,156 :: 		for(i = 1; i <= 3; num=num/10, i++) {
	MOVLW       1
	MOVWF       MAX7219_PrintMAP_i_L0+0 
L_MAX7219_PrintMAP29:
	MOVF        MAX7219_PrintMAP_i_L0+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_MAX7219_PrintMAP30
;MAX7219.c,157 :: 		MAX7219_CS=0;
	BCF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,158 :: 		SPI1_Write(5-i); // pozice
	MOVF        MAX7219_PrintMAP_i_L0+0, 0 
	SUBLW       5
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;MAX7219.c,159 :: 		tmp = num % 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_MAX7219_PrintMAP_num+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_PrintMAP_num+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       MAX7219_PrintMAP_tmp_L0+0 
;MAX7219.c,160 :: 		if (i==3 && tmp==0) MAX7219_ShowDigit(0xF,1);   // kdyz je cislo mensi nez 100, pak druhy digit OFF
	MOVF        MAX7219_PrintMAP_i_L0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_PrintMAP34
	MOVF        MAX7219_PrintMAP_tmp_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_PrintMAP34
L__MAX7219_PrintMAP44:
	MOVLW       15
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       1
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
	GOTO        L_MAX7219_PrintMAP35
L_MAX7219_PrintMAP34:
;MAX7219.c,161 :: 		else   SPI1_Write(tmp);
	MOVF        MAX7219_PrintMAP_tmp_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
L_MAX7219_PrintMAP35:
;MAX7219.c,162 :: 		MAX7219_CS=1;
	BSF         MAX7219_CS+0, BitPos(MAX7219_CS+0) 
;MAX7219.c,156 :: 		for(i = 1; i <= 3; num=num/10, i++) {
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_MAX7219_PrintMAP_num+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAX7219_PrintMAP_num+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MAX7219_PrintMAP_num+0 
	MOVF        R1, 0 
	MOVWF       FARG_MAX7219_PrintMAP_num+1 
	INCF        MAX7219_PrintMAP_i_L0+0, 1 
;MAX7219.c,163 :: 		}
	GOTO        L_MAX7219_PrintMAP29
L_MAX7219_PrintMAP30:
;MAX7219.c,164 :: 		}
L_end_MAX7219_PrintMAP:
	RETURN      0
; end of _MAX7219_PrintMAP

_MAX7219_ShowLSUName:

;MAX7219.c,166 :: 		void MAX7219_ShowLSUName(u16 num)     // zobrazi bud L 4.2 (1) nebo L 4.9 (0)
;MAX7219.c,168 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);  // MEP
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	MOVLW       128
	MOVWF       FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MAX7219.c,169 :: 		if (num != LSU_ERROR) {
	MOVLW       0
	XORWF       FARG_MAX7219_ShowLSUName_num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowLSUName62
	MOVLW       10
	XORWF       FARG_MAX7219_ShowLSUName_num+0, 0 
L__MAX7219_ShowLSUName62:
	BTFSC       STATUS+0, 2 
	GOTO        L_MAX7219_ShowLSUName36
;MAX7219.c,170 :: 		MAX7219_ShowDigit(0xD,0);   // symbol L na 0
	MOVLW       13
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	CLRF        FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,171 :: 		MAX7219_ShowDigit(0x0A,1);  // -
	MOVLW       10
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       1
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,172 :: 		MAX7219_ShowDigit(4|0x80,2);    // 4 s teckou
	MOVLW       132
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       2
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,173 :: 		if      (num==LSU42) MAX7219_ShowDigit(2,3);  //  2
	MOVLW       0
	XORWF       FARG_MAX7219_ShowLSUName_num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowLSUName63
	MOVLW       0
	XORWF       FARG_MAX7219_ShowLSUName_num+0, 0 
L__MAX7219_ShowLSUName63:
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_ShowLSUName37
	MOVLW       2
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       3
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
	GOTO        L_MAX7219_ShowLSUName38
L_MAX7219_ShowLSUName37:
;MAX7219.c,174 :: 		else if (num==LSU49) MAX7219_ShowDigit(9,3);  //  9
	MOVLW       0
	XORWF       FARG_MAX7219_ShowLSUName_num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__MAX7219_ShowLSUName64
	MOVLW       1
	XORWF       FARG_MAX7219_ShowLSUName_num+0, 0 
L__MAX7219_ShowLSUName64:
	BTFSS       STATUS+0, 2 
	GOTO        L_MAX7219_ShowLSUName39
	MOVLW       9
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       3
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
L_MAX7219_ShowLSUName39:
L_MAX7219_ShowLSUName38:
;MAX7219.c,175 :: 		}
	GOTO        L_MAX7219_ShowLSUName40
L_MAX7219_ShowLSUName36:
;MAX7219.c,177 :: 		MAX7219_ShowDigit(0x0F,0);   // blank 0
	MOVLW       15
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	CLRF        FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,178 :: 		MAX7219_ShowDigit(0xB,1);   // symbol E na 1
	MOVLW       11
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       1
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,179 :: 		MAX7219_ShowDigit(0xB,2);   // symbol E na 2
	MOVLW       11
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       2
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,180 :: 		MAX7219_ShowDigit(0x0F,3);   // blank  3
	MOVLW       15
	MOVWF       FARG_MAX7219_ShowDigit_number+0 
	MOVLW       3
	MOVWF       FARG_MAX7219_ShowDigit_digit+0 
	CALL        _MAX7219_ShowDigit+0, 0
;MAX7219.c,181 :: 		}
L_MAX7219_ShowLSUName40:
;MAX7219.c,182 :: 		}
L_end_MAX7219_ShowLSUName:
	RETURN      0
; end of _MAX7219_ShowLSUName
