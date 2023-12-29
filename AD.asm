
_Get_AD_mV:

;AD.c,7 :: 		u16 Get_AD_mV(u8 ch, u16 adc_koef) {
;AD.c,10 :: 		U32_tmp = 0; /*U16_tmp=0;*/
	CLRF        _U32_tmp+0 
	CLRF        _U32_tmp+1 
	CLRF        _U32_tmp+2 
	CLRF        _U32_tmp+3 
;AD.c,11 :: 		Loop_nr = AD_AVG_COUNT;  /// pocet cyklu pro ziskani AVG
	MOVLW       8
	MOVWF       Get_AD_mV_Loop_nr_L0+0 
	MOVLW       0
	MOVWF       Get_AD_mV_Loop_nr_L0+1 
;AD.c,12 :: 		do {
L_Get_AD_mV0:
;AD.c,14 :: 		U32_tmp = U32_tmp + (u32)ADC_Get_Sample(ch);
	MOVF        FARG_Get_AD_mV_ch+0, 0 
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       _U32_tmp+0, 1 
	MOVF        R1, 0 
	ADDWFC      _U32_tmp+1, 1 
	MOVF        R2, 0 
	ADDWFC      _U32_tmp+2, 1 
	MOVF        R3, 0 
	ADDWFC      _U32_tmp+3, 1 
;AD.c,15 :: 		Loop_nr--;
	MOVLW       1
	SUBWF       Get_AD_mV_Loop_nr_L0+0, 1 
	MOVLW       0
	SUBWFB      Get_AD_mV_Loop_nr_L0+1, 1 
;AD.c,16 :: 		} while (Loop_nr > 0);
	MOVLW       0
	MOVWF       R0 
	MOVF        Get_AD_mV_Loop_nr_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Get_AD_mV4
	MOVF        Get_AD_mV_Loop_nr_L0+0, 0 
	SUBLW       0
L__Get_AD_mV4:
	BTFSS       STATUS+0, 0 
	GOTO        L_Get_AD_mV0
;AD.c,18 :: 		U32_tmp = (u32)U32_tmp >> AD_AVG_COUNT_FAST;  // avg
	MOVLW       3
	MOVWF       R0 
	MOVF        _U32_tmp+0, 0 
	MOVWF       R4 
	MOVF        _U32_tmp+1, 0 
	MOVWF       R5 
	MOVF        _U32_tmp+2, 0 
	MOVWF       R6 
	MOVF        _U32_tmp+3, 0 
	MOVWF       R7 
	MOVF        R0, 0 
L__Get_AD_mV5:
	BZ          L__Get_AD_mV6
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	ADDLW       255
	GOTO        L__Get_AD_mV5
L__Get_AD_mV6:
	MOVF        R4, 0 
	MOVWF       _U32_tmp+0 
	MOVF        R5, 0 
	MOVWF       _U32_tmp+1 
	MOVF        R6, 0 
	MOVWF       _U32_tmp+2 
	MOVF        R7, 0 
	MOVWF       _U32_tmp+3 
;AD.c,19 :: 		ADC_RAW = (u16)U32_tmp;   // jen globalne ulozime vysledek AD RAW prevodu po potreby kalibrace
	MOVF        R4, 0 
	MOVWF       _ADC_RAW+0 
	MOVF        R5, 0 
	MOVWF       _ADC_RAW+1 
;AD.c,20 :: 		U32_tmp = U32_tmp * (u32)adc_koef; //  AD_KOEF=489 pro 5000mV Vref(Vcc) - 10bitAD => 5000/1023= 4.8875
	MOVF        FARG_Get_AD_mV_adc_koef+0, 0 
	MOVWF       R0 
	MOVF        FARG_Get_AD_mV_adc_koef+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _U32_tmp+0 
	MOVF        R1, 0 
	MOVWF       _U32_tmp+1 
	MOVF        R2, 0 
	MOVWF       _U32_tmp+2 
	MOVF        R3, 0 
	MOVWF       _U32_tmp+3 
;AD.c,21 :: 		U32_tmp = (u32)U32_tmp / 100;    // napr 512*489 = 2503(.68) -> presnost na mV/
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
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
;AD.c,22 :: 		return (u16)U32_tmp;
;AD.c,23 :: 		}
L_end_Get_AD_mV:
	RETURN      0
; end of _Get_AD_mV
