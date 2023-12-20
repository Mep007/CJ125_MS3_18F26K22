
_MAP_Calc:

;MPHX6400A.c,4 :: 		void MAP_Calc(u16 MAP_mV,u8 type) {  // 1= MPXH6400A, 2=MPXH6300A
;MPHX6400A.c,5 :: 		if      (type == 1) MAP = ((float)MAP_mV + 4.2) / 12.105;  // napr 1150mV => 95.35 kPa
	MOVF        FARG_MAP_Calc_type+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_MAP_Calc0
	MOVF        FARG_MAP_Calc_MAP_mV+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAP_Calc_MAP_mV+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       20
	MOVWF       R4 
	MOVLW       174
	MOVWF       R5 
	MOVLW       65
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _MAP+0 
	MOVF        R1, 0 
	MOVWF       _MAP+1 
	MOVF        R2, 0 
	MOVWF       _MAP+2 
	MOVF        R3, 0 
	MOVWF       _MAP+3 
	GOTO        L_MAP_Calc1
L_MAP_Calc0:
;MPHX6400A.c,6 :: 		else if (type == 2) MAP = ((float)MAP_mV + 1.765) / 15.9;  // napr 1450mV => cca 95.35 kPa
	MOVF        FARG_MAP_Calc_type+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_MAP_Calc2
	MOVF        FARG_MAP_Calc_MAP_mV+0, 0 
	MOVWF       R0 
	MOVF        FARG_MAP_Calc_MAP_mV+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       133
	MOVWF       R4 
	MOVLW       235
	MOVWF       R5 
	MOVLW       97
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       126
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _MAP+0 
	MOVF        R1, 0 
	MOVWF       _MAP+1 
	MOVF        R2, 0 
	MOVWF       _MAP+2 
	MOVF        R3, 0 
	MOVWF       _MAP+3 
L_MAP_Calc2:
L_MAP_Calc1:
;MPHX6400A.c,8 :: 		}
L_end_MAP_Calc:
	RETURN      0
; end of _MAP_Calc
