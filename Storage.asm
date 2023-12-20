
_FLASH_64Words:

;Storage.c,4 :: 		void FLASH_64Words(u16 Flash_Adr, u16 Buf[]) { // ulozi od adresy Flash_Adr pole 64 wordu z pBuf
;Storage.c,5 :: 		u16 *p32Buf = &Buf[32];   // pointere na pulku pole (protoze FLASH_Write zapisuje po bytech)
	MOVLW       64
	ADDWF       FARG_FLASH_64Words_Buf+0, 0 
	MOVWF       FLASH_64Words_p32Buf_L0+0 
	MOVLW       0
	ADDWFC      FARG_FLASH_64Words_Buf+1, 0 
	MOVWF       FLASH_64Words_p32Buf_L0+1 
;Storage.c,8 :: 		FLASH_Erase_Write_64(Flash_Adr, Buf);      // zapise 64bytes = 32 U16 od 0-31
	MOVF        FARG_FLASH_64Words_Flash_Adr+0, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_address+0 
	MOVF        FARG_FLASH_64Words_Flash_Adr+1, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_address+1 
	MOVLW       0
	MOVWF       FARG_FLASH_Erase_Write_64_address+2 
	MOVWF       FARG_FLASH_Erase_Write_64_address+3 
	MOVF        FARG_FLASH_64Words_Buf+0, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_data_+0 
	MOVF        FARG_FLASH_64Words_Buf+1, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_data_+1 
	CALL        _FLASH_Erase_Write_64+0, 0
;Storage.c,9 :: 		FLASH_Erase_Write_64(Flash_Adr+64,p32Buf);   // druha pulka bufferu 32-63
	MOVLW       64
	ADDWF       FARG_FLASH_64Words_Flash_Adr+0, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_address+0 
	MOVLW       0
	ADDWFC      FARG_FLASH_64Words_Flash_Adr+1, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_address+1 
	MOVLW       0
	MOVWF       FARG_FLASH_Erase_Write_64_address+2 
	MOVWF       FARG_FLASH_Erase_Write_64_address+3 
	MOVF        FLASH_64Words_p32Buf_L0+0, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_data_+0 
	MOVF        FLASH_64Words_p32Buf_L0+1, 0 
	MOVWF       FARG_FLASH_Erase_Write_64_data_+1 
	CALL        _FLASH_Erase_Write_64+0, 0
;Storage.c,10 :: 		}
L_end_FLASH_64Words:
	RETURN      0
; end of _FLASH_64Words

_EEPROM_Write_Constant:

;Storage.c,13 :: 		void EEPROM_Write_Constant(u16 Adr,EEprom Cal_Data) {
;Storage.c,14 :: 		u8 i=0;
;Storage.c,34 :: 		}
L_end_EEPROM_Write_Constant:
	RETURN      0
; end of _EEPROM_Write_Constant

_EEPROM_Read_Constant:

;Storage.c,36 :: 		EEprom EEPROM_Read_Constant(u16 Adr) {
	MOVF        R0, 0 
	MOVWF       _EEPROM_Read_Constant_su_addr+0 
	MOVF        R1, 0 
	MOVWF       _EEPROM_Read_Constant_su_addr+1 
;Storage.c,37 :: 		u8 i=0;
;Storage.c,41 :: 		Cal_Data.SN = EEPROM_Read(_SN_ADR);  // MSB
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+0 
	MOVLW       0
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+1 
;Storage.c,42 :: 		Cal_Data.SN = Cal_Data.SN << 8;    // prevedeme na 16bit cislo
	MOVF        EEPROM_Read_Constant_Cal_Data_L0+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+0 
	MOVF        R1, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+1 
;Storage.c,43 :: 		Cal_Data.SN = Cal_Data.SN + EEPROM_Read(_SN_ADR+0x01);  // LSB
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        EEPROM_Read_Constant_Cal_Data_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        EEPROM_Read_Constant_Cal_Data_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+0 
	MOVF        R1, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+1 
;Storage.c,45 :: 		Cal_Data.HW_ver = EEPROM_Read(_HWVer_ADR);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+2 
;Storage.c,47 :: 		Cal_Data.SW_ver = EEPROM_Read(_SWVer_ADR);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+3 
;Storage.c,49 :: 		Cal_Data.OPTION = EEPROM_Read(_OPTION_ADR);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       EEPROM_Read_Constant_Cal_Data_L0+4 
;Storage.c,52 :: 		return Cal_Data;
	MOVLW       5
	MOVWF       R0 
	MOVF        _EEPROM_Read_Constant_su_addr+0, 0 
	MOVWF       FSR1L+0 
	MOVF        _EEPROM_Read_Constant_su_addr+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       EEPROM_Read_Constant_Cal_Data_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(EEPROM_Read_Constant_Cal_Data_L0+0)
	MOVWF       FSR0L+1 
L_EEPROM_Read_Constant0:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_EEPROM_Read_Constant0
;Storage.c,53 :: 		}
L_end_EEPROM_Read_Constant:
	RETURN      0
; end of _EEPROM_Read_Constant
