
_ssd1306_command:

;SSD1306OLED.c,232 :: 		void ssd1306_command(uint8_t c) {
;SSD1306OLED.c,233 :: 		SSD1306_Start();
	CALL        _I2C2_Start+0, 0
;SSD1306OLED.c,234 :: 		SSD1306_Write(_i2caddr);
	MOVF        __i2caddr+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;SSD1306OLED.c,235 :: 		SSD1306_Write(0);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;SSD1306OLED.c,236 :: 		SSD1306_Write(c);
	MOVF        FARG_ssd1306_command_c+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;SSD1306OLED.c,237 :: 		SSD1306_Stop();
	CALL        _I2C2_Stop+0, 0
;SSD1306OLED.c,238 :: 		}
L_end_ssd1306_command:
	RETURN      0
; end of _ssd1306_command

_SSD1306_Begin:

;SSD1306OLED.c,240 :: 		void SSD1306_Begin(uint8_t vccstate, uint8_t i2caddr) {
;SSD1306OLED.c,241 :: 		_vccstate = vccstate;
	MOVF        FARG_SSD1306_Begin_vccstate+0, 0 
	MOVWF       __vccstate+0 
;SSD1306OLED.c,242 :: 		_i2caddr  = i2caddr;
	MOVF        FARG_SSD1306_Begin_i2caddr+0, 0 
	MOVWF       __i2caddr+0 
;SSD1306OLED.c,252 :: 		ssd1306_command(SSD1306_DISPLAYOFF);                    // 0xAE
	MOVLW       174
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,253 :: 		ssd1306_command(SSD1306_SETDISPLAYCLOCKDIV);            // 0xD5
	MOVLW       213
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,254 :: 		ssd1306_command(0x80);                                  // the suggested ratio 0x80
	MOVLW       128
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,256 :: 		ssd1306_command(SSD1306_SETMULTIPLEX);                  // 0xA8
	MOVLW       168
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,257 :: 		ssd1306_command(SSD1306_LCDHEIGHT - 1);
	MOVLW       63
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,259 :: 		ssd1306_command(SSD1306_SETDISPLAYOFFSET);              // 0xD3
	MOVLW       211
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,260 :: 		ssd1306_command(0x0);                                   // no offset
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,261 :: 		ssd1306_command(SSD1306_SETSTARTLINE | 0x0);            // line #0
	MOVLW       64
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,262 :: 		ssd1306_command(SSD1306_CHARGEPUMP);                    // 0x8D
	MOVLW       141
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,263 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF        FARG_SSD1306_Begin_vccstate+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_Begin0
;SSD1306OLED.c,264 :: 		{ ssd1306_command(0x10); }
	MOVLW       16
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
	GOTO        L_SSD1306_Begin1
L_SSD1306_Begin0:
;SSD1306OLED.c,266 :: 		{ ssd1306_command(0x14); }
	MOVLW       20
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
L_SSD1306_Begin1:
;SSD1306OLED.c,267 :: 		ssd1306_command(SSD1306_MEMORYMODE);                    // 0x20
	MOVLW       32
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,268 :: 		ssd1306_command(0x00);                                  // 0x0 act like ks0108
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,269 :: 		ssd1306_command(SSD1306_SEGREMAP | 0x1);
	MOVLW       161
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,270 :: 		ssd1306_command(SSD1306_COMSCANDEC);
	MOVLW       200
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,279 :: 		ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
	MOVLW       218
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,280 :: 		ssd1306_command(0x12);
	MOVLW       18
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,281 :: 		ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
	MOVLW       129
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,282 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF        FARG_SSD1306_Begin_vccstate+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_Begin2
;SSD1306OLED.c,283 :: 		{ ssd1306_command(0x9F); }
	MOVLW       159
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
	GOTO        L_SSD1306_Begin3
L_SSD1306_Begin2:
;SSD1306OLED.c,285 :: 		{ ssd1306_command(0xCF); }
	MOVLW       207
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
L_SSD1306_Begin3:
;SSD1306OLED.c,298 :: 		ssd1306_command(SSD1306_SETPRECHARGE);                  // 0xd9
	MOVLW       217
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,299 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF        FARG_SSD1306_Begin_vccstate+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_Begin4
;SSD1306OLED.c,300 :: 		{ ssd1306_command(0x22); }
	MOVLW       34
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
	GOTO        L_SSD1306_Begin5
L_SSD1306_Begin4:
;SSD1306OLED.c,302 :: 		{ ssd1306_command(0xF1); }
	MOVLW       241
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
L_SSD1306_Begin5:
;SSD1306OLED.c,303 :: 		ssd1306_command(SSD1306_SETVCOMDETECT);                 // 0xDB
	MOVLW       219
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,304 :: 		ssd1306_command(0x40);
	MOVLW       64
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,305 :: 		ssd1306_command(SSD1306_DISPLAYALLON_RESUME);           // 0xA4
	MOVLW       164
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,306 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);                 // 0xA6
	MOVLW       166
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,308 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW       46
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,310 :: 		ssd1306_command(SSD1306_DISPLAYON);//--turn on oled panel
	MOVLW       175
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,311 :: 		}
L_end_SSD1306_Begin:
	RETURN      0
; end of _SSD1306_Begin

_SSD1306_DrawPixel:

;SSD1306OLED.c,313 :: 		void SSD1306_DrawPixel(uint8_t x, uint8_t y) {
;SSD1306OLED.c,314 :: 		if ((x >= SSD1306_LCDWIDTH) || (y >= SSD1306_LCDHEIGHT))
	MOVLW       128
	SUBWF       FARG_SSD1306_DrawPixel_x+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__SSD1306_DrawPixel136
	MOVLW       64
	SUBWF       FARG_SSD1306_DrawPixel_y+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__SSD1306_DrawPixel136
	GOTO        L_SSD1306_DrawPixel8
L__SSD1306_DrawPixel136:
;SSD1306OLED.c,315 :: 		return;
	GOTO        L_end_SSD1306_DrawPixel
L_SSD1306_DrawPixel8:
;SSD1306OLED.c,316 :: 		if (SSD1306_Color)
	MOVF        _SSD1306_Color+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_DrawPixel9
;SSD1306OLED.c,317 :: 		buffer[x + (uint16_t)(y / 8) * SSD1306_LCDWIDTH] |=  (1 << (y & 7));
	MOVF        FARG_SSD1306_DrawPixel_y+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       7
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__SSD1306_DrawPixel146:
	BZ          L__SSD1306_DrawPixel147
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__SSD1306_DrawPixel146
L__SSD1306_DrawPixel147:
	MOVF        FARG_SSD1306_DrawPixel_x+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       SSD1306OLED_buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(SSD1306OLED_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       7
	ANDWF       FARG_SSD1306_DrawPixel_y+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__SSD1306_DrawPixel148:
	BZ          L__SSD1306_DrawPixel149
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__SSD1306_DrawPixel148
L__SSD1306_DrawPixel149:
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_SSD1306_DrawPixel10
L_SSD1306_DrawPixel9:
;SSD1306OLED.c,319 :: 		buffer[x + (uint16_t)(y / 8) * SSD1306_LCDWIDTH] &=  ~(1 << (y & 7));
	MOVF        FARG_SSD1306_DrawPixel_y+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       7
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__SSD1306_DrawPixel150:
	BZ          L__SSD1306_DrawPixel151
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__SSD1306_DrawPixel150
L__SSD1306_DrawPixel151:
	MOVF        FARG_SSD1306_DrawPixel_x+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       SSD1306OLED_buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(SSD1306OLED_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       7
	ANDWF       FARG_SSD1306_DrawPixel_y+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__SSD1306_DrawPixel152:
	BZ          L__SSD1306_DrawPixel153
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__SSD1306_DrawPixel152
L__SSD1306_DrawPixel153:
	COMF        R0, 1 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_SSD1306_DrawPixel10:
;SSD1306OLED.c,320 :: 		}
L_end_SSD1306_DrawPixel:
	RETURN      0
; end of _SSD1306_DrawPixel

_SSD1306_StartScrollRight:

;SSD1306OLED.c,322 :: 		void SSD1306_StartScrollRight(uint8_t start, uint8_t stop) {
;SSD1306OLED.c,323 :: 		ssd1306_command(SSD1306_RIGHT_HORIZONTAL_SCROLL);
	MOVLW       38
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,324 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,325 :: 		ssd1306_command(start);
	MOVF        FARG_SSD1306_StartScrollRight_start+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,326 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,327 :: 		ssd1306_command(stop);
	MOVF        FARG_SSD1306_StartScrollRight_stop+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,328 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,329 :: 		ssd1306_command(0XFF);
	MOVLW       255
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,330 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW       47
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,331 :: 		}
L_end_SSD1306_StartScrollRight:
	RETURN      0
; end of _SSD1306_StartScrollRight

_SSD1306_StartScrollLeft:

;SSD1306OLED.c,333 :: 		void SSD1306_StartScrollLeft(uint8_t start, uint8_t stop) {
;SSD1306OLED.c,334 :: 		ssd1306_command(SSD1306_LEFT_HORIZONTAL_SCROLL);
	MOVLW       39
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,335 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,336 :: 		ssd1306_command(start);
	MOVF        FARG_SSD1306_StartScrollLeft_start+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,337 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,338 :: 		ssd1306_command(stop);
	MOVF        FARG_SSD1306_StartScrollLeft_stop+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,339 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,340 :: 		ssd1306_command(0XFF);
	MOVLW       255
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,341 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW       47
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,342 :: 		}
L_end_SSD1306_StartScrollLeft:
	RETURN      0
; end of _SSD1306_StartScrollLeft

_SSD1306_StartScrollDiagRight:

;SSD1306OLED.c,344 :: 		void SSD1306_StartScrollDiagRight(uint8_t start, uint8_t stop) {
;SSD1306OLED.c,345 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW       163
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,346 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,347 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW       64
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,348 :: 		ssd1306_command(SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL);
	MOVLW       41
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,349 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,350 :: 		ssd1306_command(start);
	MOVF        FARG_SSD1306_StartScrollDiagRight_start+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,351 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,352 :: 		ssd1306_command(stop);
	MOVF        FARG_SSD1306_StartScrollDiagRight_stop+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,353 :: 		ssd1306_command(0X01);
	MOVLW       1
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,354 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW       47
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,355 :: 		}
L_end_SSD1306_StartScrollDiagRight:
	RETURN      0
; end of _SSD1306_StartScrollDiagRight

_SSD1306_StartScrollDiagLeft:

;SSD1306OLED.c,357 :: 		void SSD1306_StartScrollDiagLeft(uint8_t start, uint8_t stop) {
;SSD1306OLED.c,358 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW       163
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,359 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,360 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW       64
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,361 :: 		ssd1306_command(SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL);
	MOVLW       42
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,362 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,363 :: 		ssd1306_command(start);
	MOVF        FARG_SSD1306_StartScrollDiagLeft_start+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,364 :: 		ssd1306_command(0X00);
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,365 :: 		ssd1306_command(stop);
	MOVF        FARG_SSD1306_StartScrollDiagLeft_stop+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,366 :: 		ssd1306_command(0X01);
	MOVLW       1
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,367 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW       47
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,368 :: 		}
L_end_SSD1306_StartScrollDiagLeft:
	RETURN      0
; end of _SSD1306_StartScrollDiagLeft

_SSD1306_StopScroll:

;SSD1306OLED.c,370 :: 		void SSD1306_StopScroll(void) {
;SSD1306OLED.c,371 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW       46
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,372 :: 		}
L_end_SSD1306_StopScroll:
	RETURN      0
; end of _SSD1306_StopScroll

_SSD1306_Dim:

;SSD1306OLED.c,374 :: 		void SSD1306_Dim(bool dim) {
;SSD1306OLED.c,376 :: 		if (dim)
	MOVF        FARG_SSD1306_Dim_dim+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_Dim11
;SSD1306OLED.c,377 :: 		contrast = 0; // Dimmed display
	CLRF        SSD1306_Dim_contrast_L0+0 
	GOTO        L_SSD1306_Dim12
L_SSD1306_Dim11:
;SSD1306OLED.c,379 :: 		if (_vccstate == SSD1306_EXTERNALVCC)
	MOVF        __vccstate+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_Dim13
;SSD1306OLED.c,380 :: 		contrast = 0x9F;
	MOVLW       159
	MOVWF       SSD1306_Dim_contrast_L0+0 
	GOTO        L_SSD1306_Dim14
L_SSD1306_Dim13:
;SSD1306OLED.c,382 :: 		contrast = 0xCF;
	MOVLW       207
	MOVWF       SSD1306_Dim_contrast_L0+0 
L_SSD1306_Dim14:
;SSD1306OLED.c,383 :: 		}
L_SSD1306_Dim12:
;SSD1306OLED.c,386 :: 		ssd1306_command(SSD1306_SETCONTRAST);
	MOVLW       129
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,387 :: 		ssd1306_command(contrast);
	MOVF        SSD1306_Dim_contrast_L0+0, 0 
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,388 :: 		}
L_end_SSD1306_Dim:
	RETURN      0
; end of _SSD1306_Dim

_SSD1306_Display:

;SSD1306OLED.c,390 :: 		void SSD1306_Display(void) {
;SSD1306OLED.c,393 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW       33
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,394 :: 		ssd1306_command(0);   // Column start address (0 = reset)
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,395 :: 		ssd1306_command(SSD1306_LCDWIDTH-1); // Column end address (127 = reset)
	MOVLW       127
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,397 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW       34
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,398 :: 		ssd1306_command(0); // Page start address (0 = reset)
	CLRF        FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,400 :: 		ssd1306_command(7); // Page end address
	MOVLW       7
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
;SSD1306OLED.c,409 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++) {
	CLRF        SSD1306_Display_i_L0+0 
	CLRF        SSD1306_Display_i_L0+1 
L_SSD1306_Display15:
	MOVLW       4
	SUBWF       SSD1306_Display_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_Display161
	MOVLW       0
	SUBWF       SSD1306_Display_i_L0+0, 0 
L__SSD1306_Display161:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_Display16
;SSD1306OLED.c,411 :: 		SSD1306_Start();
	CALL        _I2C2_Start+0, 0
;SSD1306OLED.c,412 :: 		SSD1306_Write(_i2caddr);
	MOVF        __i2caddr+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;SSD1306OLED.c,413 :: 		SSD1306_Write(0x40);
	MOVLW       64
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;SSD1306OLED.c,414 :: 		for (x = 0; x < 16; x++) {
	CLRF        SSD1306_Display_x_L0+0 
L_SSD1306_Display18:
	MOVLW       16
	SUBWF       SSD1306_Display_x_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_Display19
;SSD1306OLED.c,415 :: 		SSD1306_Write(buffer[i]);
	MOVLW       SSD1306OLED_buffer+0
	ADDWF       SSD1306_Display_i_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(SSD1306OLED_buffer+0)
	ADDWFC      SSD1306_Display_i_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;SSD1306OLED.c,416 :: 		i++;
	INFSNZ      SSD1306_Display_i_L0+0, 1 
	INCF        SSD1306_Display_i_L0+1, 1 
;SSD1306OLED.c,414 :: 		for (x = 0; x < 16; x++) {
	INCF        SSD1306_Display_x_L0+0, 1 
;SSD1306OLED.c,417 :: 		}
	GOTO        L_SSD1306_Display18
L_SSD1306_Display19:
;SSD1306OLED.c,418 :: 		i--;
	MOVLW       1
	SUBWF       SSD1306_Display_i_L0+0, 1 
	MOVLW       0
	SUBWFB      SSD1306_Display_i_L0+1, 1 
;SSD1306OLED.c,419 :: 		SSD1306_Stop();
	CALL        _I2C2_Stop+0, 0
;SSD1306OLED.c,409 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++) {
	INFSNZ      SSD1306_Display_i_L0+0, 1 
	INCF        SSD1306_Display_i_L0+1, 1 
;SSD1306OLED.c,420 :: 		}
	GOTO        L_SSD1306_Display15
L_SSD1306_Display16:
;SSD1306OLED.c,421 :: 		}
L_end_SSD1306_Display:
	RETURN      0
; end of _SSD1306_Display

_SSD1306_ClearDisplay:

;SSD1306OLED.c,423 :: 		void SSD1306_ClearDisplay(void) {
;SSD1306OLED.c,425 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++)
	CLRF        R1 
	CLRF        R2 
L_SSD1306_ClearDisplay21:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_ClearDisplay163
	MOVLW       0
	SUBWF       R1, 0 
L__SSD1306_ClearDisplay163:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_ClearDisplay22
;SSD1306OLED.c,426 :: 		buffer[i] = 0;
	MOVLW       SSD1306OLED_buffer+0
	ADDWF       R1, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(SSD1306OLED_buffer+0)
	ADDWFC      R2, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;SSD1306OLED.c,425 :: 		for (i = 0; i < (SSD1306_LCDWIDTH*SSD1306_LCDHEIGHT / 8); i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;SSD1306OLED.c,426 :: 		buffer[i] = 0;
	GOTO        L_SSD1306_ClearDisplay21
L_SSD1306_ClearDisplay22:
;SSD1306OLED.c,427 :: 		}
L_end_SSD1306_ClearDisplay:
	RETURN      0
; end of _SSD1306_ClearDisplay

_SSD1306_DrawLine:

;SSD1306OLED.c,429 :: 		void SSD1306_DrawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1) {
;SSD1306OLED.c,434 :: 		steep = abs(y1 - y0) > abs(x1 - x0);
	MOVF        FARG_SSD1306_DrawLine_y0+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_y1+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_SSD1306_DrawLine_y0+1, 0 
	SUBWFB      FARG_SSD1306_DrawLine_y1+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__SSD1306_DrawLine+0 
	MOVF        R1, 0 
	MOVWF       FLOC__SSD1306_DrawLine+1 
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_x1+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_SSD1306_DrawLine_x0+1, 0 
	SUBWFB      FARG_SSD1306_DrawLine_x1+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       FLOC__SSD1306_DrawLine+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawLine165
	MOVF        FLOC__SSD1306_DrawLine+0, 0 
	SUBWF       R0, 0 
L__SSD1306_DrawLine165:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       SSD1306_DrawLine_steep_L0+0 
;SSD1306OLED.c,435 :: 		if (steep) {
	MOVF        R2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_DrawLine24
;SSD1306OLED.c,436 :: 		ssd1306_swap(x0, y0);
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	MOVWF       SSD1306_DrawLine_t_L2+0 
	MOVF        FARG_SSD1306_DrawLine_x0+1, 0 
	MOVWF       SSD1306_DrawLine_t_L2+1 
	MOVF        FARG_SSD1306_DrawLine_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVF        FARG_SSD1306_DrawLine_y0+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        SSD1306_DrawLine_t_L2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVF        SSD1306_DrawLine_t_L2+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
;SSD1306OLED.c,437 :: 		ssd1306_swap(x1, y1);
	MOVF        FARG_SSD1306_DrawLine_x1+0, 0 
	MOVWF       SSD1306_DrawLine_t_L2_L2+0 
	MOVF        FARG_SSD1306_DrawLine_x1+1, 0 
	MOVWF       SSD1306_DrawLine_t_L2_L2+1 
	MOVF        FARG_SSD1306_DrawLine_y1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	MOVF        FARG_SSD1306_DrawLine_y1+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+1 
	MOVF        SSD1306_DrawLine_t_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	MOVF        SSD1306_DrawLine_t_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+1 
;SSD1306OLED.c,438 :: 		}
L_SSD1306_DrawLine24:
;SSD1306OLED.c,439 :: 		if (x0 > x1) {
	MOVLW       128
	XORWF       FARG_SSD1306_DrawLine_x1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_DrawLine_x0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawLine166
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_x1+0, 0 
L__SSD1306_DrawLine166:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawLine25
;SSD1306OLED.c,440 :: 		ssd1306_swap(x0, x1);
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	MOVWF       SSD1306_DrawLine_t_L2_L2_L2+0 
	MOVF        FARG_SSD1306_DrawLine_x0+1, 0 
	MOVWF       SSD1306_DrawLine_t_L2_L2_L2+1 
	MOVF        FARG_SSD1306_DrawLine_x1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVF        FARG_SSD1306_DrawLine_x1+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        SSD1306_DrawLine_t_L2_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	MOVF        SSD1306_DrawLine_t_L2_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+1 
;SSD1306OLED.c,441 :: 		ssd1306_swap(y0, y1);
	MOVF        FARG_SSD1306_DrawLine_y0+0, 0 
	MOVWF       SSD1306_DrawLine_t_L2_L2_L2_L2+0 
	MOVF        FARG_SSD1306_DrawLine_y0+1, 0 
	MOVWF       SSD1306_DrawLine_t_L2_L2_L2_L2+1 
	MOVF        FARG_SSD1306_DrawLine_y1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVF        FARG_SSD1306_DrawLine_y1+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
	MOVF        SSD1306_DrawLine_t_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	MOVF        SSD1306_DrawLine_t_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+1 
;SSD1306OLED.c,442 :: 		}
L_SSD1306_DrawLine25:
;SSD1306OLED.c,443 :: 		dx = x1 - x0;
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_x1+0, 0 
	MOVWF       SSD1306_DrawLine_dx_L0+0 
;SSD1306OLED.c,444 :: 		dy = abs(y1 - y0);
	MOVF        FARG_SSD1306_DrawLine_y0+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_y1+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_SSD1306_DrawLine_y0+1, 0 
	SUBWFB      FARG_SSD1306_DrawLine_y1+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawLine_dy_L0+0 
;SSD1306OLED.c,446 :: 		err = dx / 2;
	MOVF        SSD1306_DrawLine_dx_L0+0, 0 
	MOVWF       SSD1306_DrawLine_err_L0+0 
	MOVLW       0
	MOVWF       SSD1306_DrawLine_err_L0+1 
	RRCF        SSD1306_DrawLine_err_L0+0, 1 
	BCF         SSD1306_DrawLine_err_L0+0, 7 
	MOVLW       0
	MOVWF       SSD1306_DrawLine_err_L0+1 
;SSD1306OLED.c,447 :: 		if (y0 < y1)
	MOVLW       128
	XORWF       FARG_SSD1306_DrawLine_y0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_DrawLine_y1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawLine167
	MOVF        FARG_SSD1306_DrawLine_y1+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_y0+0, 0 
L__SSD1306_DrawLine167:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawLine26
;SSD1306OLED.c,448 :: 		ystep = 1;
	MOVLW       1
	MOVWF       SSD1306_DrawLine_ystep_L0+0 
	GOTO        L_SSD1306_DrawLine27
L_SSD1306_DrawLine26:
;SSD1306OLED.c,450 :: 		ystep = -1;
	MOVLW       255
	MOVWF       SSD1306_DrawLine_ystep_L0+0 
L_SSD1306_DrawLine27:
;SSD1306OLED.c,452 :: 		for (; x0 <= x1; x0++) {
L_SSD1306_DrawLine28:
	MOVLW       128
	XORWF       FARG_SSD1306_DrawLine_x1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_DrawLine_x0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawLine168
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	SUBWF       FARG_SSD1306_DrawLine_x1+0, 0 
L__SSD1306_DrawLine168:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_DrawLine29
;SSD1306OLED.c,453 :: 		if (steep)
	MOVF        SSD1306_DrawLine_steep_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_DrawLine31
;SSD1306OLED.c,454 :: 		SSD1306_DrawPixel(y0, x0);
	MOVF        FARG_SSD1306_DrawLine_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
	GOTO        L_SSD1306_DrawLine32
L_SSD1306_DrawLine31:
;SSD1306OLED.c,456 :: 		SSD1306_DrawPixel(x0, y0);
	MOVF        FARG_SSD1306_DrawLine_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        FARG_SSD1306_DrawLine_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
L_SSD1306_DrawLine32:
;SSD1306OLED.c,457 :: 		err -= dy;
	MOVF        SSD1306_DrawLine_dy_L0+0, 0 
	SUBWF       SSD1306_DrawLine_err_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      SSD1306_DrawLine_err_L0+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawLine_err_L0+0 
	MOVF        R2, 0 
	MOVWF       SSD1306_DrawLine_err_L0+1 
;SSD1306OLED.c,458 :: 		if (err < 0) {
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawLine169
	MOVLW       0
	SUBWF       R1, 0 
L__SSD1306_DrawLine169:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawLine33
;SSD1306OLED.c,459 :: 		y0  += ystep;
	MOVF        SSD1306_DrawLine_ystep_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawLine_y0+0, 1 
	MOVLW       0
	BTFSC       SSD1306_DrawLine_ystep_L0+0, 7 
	MOVLW       255
	ADDWFC      FARG_SSD1306_DrawLine_y0+1, 1 
;SSD1306OLED.c,460 :: 		err += dx;
	MOVF        SSD1306_DrawLine_dx_L0+0, 0 
	ADDWF       SSD1306_DrawLine_err_L0+0, 1 
	MOVLW       0
	ADDWFC      SSD1306_DrawLine_err_L0+1, 1 
;SSD1306OLED.c,461 :: 		}
L_SSD1306_DrawLine33:
;SSD1306OLED.c,452 :: 		for (; x0 <= x1; x0++) {
	INFSNZ      FARG_SSD1306_DrawLine_x0+0, 1 
	INCF        FARG_SSD1306_DrawLine_x0+1, 1 
;SSD1306OLED.c,462 :: 		}
	GOTO        L_SSD1306_DrawLine28
L_SSD1306_DrawLine29:
;SSD1306OLED.c,463 :: 		}
L_end_SSD1306_DrawLine:
	RETURN      0
; end of _SSD1306_DrawLine

_SSD1306_DrawFastHLine:

;SSD1306OLED.c,465 :: 		void SSD1306_DrawFastHLine(uint8_t x, uint8_t y, uint8_t w) {
;SSD1306OLED.c,466 :: 		SSD1306_DrawLine(x, y, x + w - 1, y);
	MOVF        FARG_SSD1306_DrawFastHLine_x+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        FARG_SSD1306_DrawFastHLine_y+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
	MOVF        FARG_SSD1306_DrawFastHLine_w+0, 0 
	ADDWF       FARG_SSD1306_DrawFastHLine_x+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	CLRF        FARG_SSD1306_DrawLine_x1+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawLine_x1+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_DrawLine_x1+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawLine_x1+1, 1 
	MOVF        FARG_SSD1306_DrawFastHLine_y+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y1+1 
	CALL        _SSD1306_DrawLine+0, 0
;SSD1306OLED.c,467 :: 		}
L_end_SSD1306_DrawFastHLine:
	RETURN      0
; end of _SSD1306_DrawFastHLine

_SSD1306_DrawFastVLine:

;SSD1306OLED.c,469 :: 		void SSD1306_DrawFastVLine(uint8_t x, uint8_t y, uint8_t h) {
;SSD1306OLED.c,470 :: 		SSD1306_DrawLine(x, y, x, y + h - 1);
	MOVF        FARG_SSD1306_DrawFastVLine_x+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        FARG_SSD1306_DrawFastVLine_y+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
	MOVF        FARG_SSD1306_DrawFastVLine_x+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x1+1 
	MOVF        FARG_SSD1306_DrawFastVLine_h+0, 0 
	ADDWF       FARG_SSD1306_DrawFastVLine_y+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	CLRF        FARG_SSD1306_DrawLine_y1+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawLine_y1+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_DrawLine_y1+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawLine_y1+1, 1 
	CALL        _SSD1306_DrawLine+0, 0
;SSD1306OLED.c,471 :: 		}
L_end_SSD1306_DrawFastVLine:
	RETURN      0
; end of _SSD1306_DrawFastVLine

_SSD1306_FillRect:

;SSD1306OLED.c,473 :: 		void SSD1306_FillRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
;SSD1306OLED.c,475 :: 		for (i = x; i < x + w; i++)
	MOVF        FARG_SSD1306_FillRect_x+0, 0 
	MOVWF       SSD1306_FillRect_i_L0+0 
	MOVLW       0
	MOVWF       SSD1306_FillRect_i_L0+1 
L_SSD1306_FillRect34:
	MOVF        FARG_SSD1306_FillRect_w+0, 0 
	ADDWF       FARG_SSD1306_FillRect_x+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       128
	XORWF       SSD1306_FillRect_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillRect173
	MOVF        R1, 0 
	SUBWF       SSD1306_FillRect_i_L0+0, 0 
L__SSD1306_FillRect173:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillRect35
;SSD1306OLED.c,476 :: 		SSD1306_DrawFastVLine(i, y, h);
	MOVF        SSD1306_FillRect_i_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        FARG_SSD1306_FillRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        FARG_SSD1306_FillRect_h+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,475 :: 		for (i = x; i < x + w; i++)
	INFSNZ      SSD1306_FillRect_i_L0+0, 1 
	INCF        SSD1306_FillRect_i_L0+1, 1 
;SSD1306OLED.c,476 :: 		SSD1306_DrawFastVLine(i, y, h);
	GOTO        L_SSD1306_FillRect34
L_SSD1306_FillRect35:
;SSD1306OLED.c,477 :: 		}
L_end_SSD1306_FillRect:
	RETURN      0
; end of _SSD1306_FillRect

_SSD1306_DrawCircle:

;SSD1306OLED.c,479 :: 		void SSD1306_DrawCircle(int16_t x0, int16_t y0, int16_t r) {
;SSD1306OLED.c,480 :: 		int16_t f = 1 - r;
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	SUBLW       1
	MOVWF       SSD1306_DrawCircle_f_L0+0 
	MOVF        FARG_SSD1306_DrawCircle_r+1, 0 
	MOVWF       SSD1306_DrawCircle_f_L0+1 
	MOVLW       0
	SUBFWB      SSD1306_DrawCircle_f_L0+1, 1 
;SSD1306OLED.c,481 :: 		int16_t ddF_x = 1;
	MOVLW       1
	MOVWF       SSD1306_DrawCircle_ddF_x_L0+0 
	MOVLW       0
	MOVWF       SSD1306_DrawCircle_ddF_x_L0+1 
;SSD1306OLED.c,482 :: 		int16_t ddF_y = -2 * r;
	MOVLW       254
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_SSD1306_DrawCircle_r+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawCircle_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawCircle_ddF_y_L0+1 
;SSD1306OLED.c,483 :: 		int16_t x = 0;
	CLRF        SSD1306_DrawCircle_x_L0+0 
	CLRF        SSD1306_DrawCircle_x_L0+1 
;SSD1306OLED.c,484 :: 		int16_t y = r;
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	MOVWF       SSD1306_DrawCircle_y_L0+0 
	MOVF        FARG_SSD1306_DrawCircle_r+1, 0 
	MOVWF       SSD1306_DrawCircle_y_L0+1 
;SSD1306OLED.c,486 :: 		SSD1306_DrawPixel(x0  , y0 + r);
	MOVF        FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,487 :: 		SSD1306_DrawPixel(x0  , y0 - r);
	MOVF        FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,488 :: 		SSD1306_DrawPixel(x0 + r, y0);
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,489 :: 		SSD1306_DrawPixel(x0 - r, y0);
	MOVF        FARG_SSD1306_DrawCircle_r+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,491 :: 		while (x < y) {
L_SSD1306_DrawCircle37:
	MOVLW       128
	XORWF       SSD1306_DrawCircle_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SSD1306_DrawCircle_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawCircle175
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	SUBWF       SSD1306_DrawCircle_x_L0+0, 0 
L__SSD1306_DrawCircle175:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawCircle38
;SSD1306OLED.c,492 :: 		if (f >= 0) {
	MOVLW       128
	XORWF       SSD1306_DrawCircle_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawCircle176
	MOVLW       0
	SUBWF       SSD1306_DrawCircle_f_L0+0, 0 
L__SSD1306_DrawCircle176:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_DrawCircle39
;SSD1306OLED.c,493 :: 		y--;
	MOVLW       1
	SUBWF       SSD1306_DrawCircle_y_L0+0, 1 
	MOVLW       0
	SUBWFB      SSD1306_DrawCircle_y_L0+1, 1 
;SSD1306OLED.c,494 :: 		ddF_y += 2;
	MOVLW       2
	ADDWF       SSD1306_DrawCircle_ddF_y_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      SSD1306_DrawCircle_ddF_y_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawCircle_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawCircle_ddF_y_L0+1 
;SSD1306OLED.c,495 :: 		f += ddF_y;
	MOVF        R0, 0 
	ADDWF       SSD1306_DrawCircle_f_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SSD1306_DrawCircle_f_L0+1, 1 
;SSD1306OLED.c,496 :: 		}
L_SSD1306_DrawCircle39:
;SSD1306OLED.c,497 :: 		x++;
	INFSNZ      SSD1306_DrawCircle_x_L0+0, 1 
	INCF        SSD1306_DrawCircle_x_L0+1, 1 
;SSD1306OLED.c,498 :: 		ddF_x += 2;
	MOVLW       2
	ADDWF       SSD1306_DrawCircle_ddF_x_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      SSD1306_DrawCircle_ddF_x_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawCircle_ddF_x_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawCircle_ddF_x_L0+1 
;SSD1306OLED.c,499 :: 		f += ddF_x;
	MOVF        R0, 0 
	ADDWF       SSD1306_DrawCircle_f_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SSD1306_DrawCircle_f_L0+1, 1 
;SSD1306OLED.c,501 :: 		SSD1306_DrawPixel(x0 + x, y0 + y);
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,502 :: 		SSD1306_DrawPixel(x0 - x, y0 + y);
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,503 :: 		SSD1306_DrawPixel(x0 + x, y0 - y);
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,504 :: 		SSD1306_DrawPixel(x0 - x, y0 - y);
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,505 :: 		SSD1306_DrawPixel(x0 + y, y0 + x);
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,506 :: 		SSD1306_DrawPixel(x0 - y, y0 + x);
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,507 :: 		SSD1306_DrawPixel(x0 + y, y0 - x);
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,508 :: 		SSD1306_DrawPixel(x0 - y, y0 - x);
	MOVF        SSD1306_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,509 :: 		}
	GOTO        L_SSD1306_DrawCircle37
L_SSD1306_DrawCircle38:
;SSD1306OLED.c,511 :: 		}
L_end_SSD1306_DrawCircle:
	RETURN      0
; end of _SSD1306_DrawCircle

_SSD1306_DrawCircleHelper:

;SSD1306OLED.c,513 :: 		void SSD1306_DrawCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername) {
;SSD1306OLED.c,514 :: 		int16_t f     = 1 - r;
	MOVF        FARG_SSD1306_DrawCircleHelper_r+0, 0 
	SUBLW       1
	MOVWF       SSD1306_DrawCircleHelper_f_L0+0 
	MOVF        FARG_SSD1306_DrawCircleHelper_r+1, 0 
	MOVWF       SSD1306_DrawCircleHelper_f_L0+1 
	MOVLW       0
	SUBFWB      SSD1306_DrawCircleHelper_f_L0+1, 1 
;SSD1306OLED.c,515 :: 		int16_t ddF_x = 1;
	MOVLW       1
	MOVWF       SSD1306_DrawCircleHelper_ddF_x_L0+0 
	MOVLW       0
	MOVWF       SSD1306_DrawCircleHelper_ddF_x_L0+1 
;SSD1306OLED.c,516 :: 		int16_t ddF_y = -2 * r;
	MOVLW       254
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVF        FARG_SSD1306_DrawCircleHelper_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_SSD1306_DrawCircleHelper_r+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawCircleHelper_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawCircleHelper_ddF_y_L0+1 
;SSD1306OLED.c,517 :: 		int16_t x     = 0;
	CLRF        SSD1306_DrawCircleHelper_x_L0+0 
	CLRF        SSD1306_DrawCircleHelper_x_L0+1 
;SSD1306OLED.c,518 :: 		int16_t y     = r;
	MOVF        FARG_SSD1306_DrawCircleHelper_r+0, 0 
	MOVWF       SSD1306_DrawCircleHelper_y_L0+0 
	MOVF        FARG_SSD1306_DrawCircleHelper_r+1, 0 
	MOVWF       SSD1306_DrawCircleHelper_y_L0+1 
;SSD1306OLED.c,520 :: 		while (x < y) {
L_SSD1306_DrawCircleHelper40:
	MOVLW       128
	XORWF       SSD1306_DrawCircleHelper_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SSD1306_DrawCircleHelper_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawCircleHelper178
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	SUBWF       SSD1306_DrawCircleHelper_x_L0+0, 0 
L__SSD1306_DrawCircleHelper178:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawCircleHelper41
;SSD1306OLED.c,521 :: 		if (f >= 0) {
	MOVLW       128
	XORWF       SSD1306_DrawCircleHelper_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawCircleHelper179
	MOVLW       0
	SUBWF       SSD1306_DrawCircleHelper_f_L0+0, 0 
L__SSD1306_DrawCircleHelper179:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_DrawCircleHelper42
;SSD1306OLED.c,522 :: 		y--;
	MOVLW       1
	SUBWF       SSD1306_DrawCircleHelper_y_L0+0, 1 
	MOVLW       0
	SUBWFB      SSD1306_DrawCircleHelper_y_L0+1, 1 
;SSD1306OLED.c,523 :: 		ddF_y += 2;
	MOVLW       2
	ADDWF       SSD1306_DrawCircleHelper_ddF_y_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      SSD1306_DrawCircleHelper_ddF_y_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawCircleHelper_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawCircleHelper_ddF_y_L0+1 
;SSD1306OLED.c,524 :: 		f     += ddF_y;
	MOVF        R0, 0 
	ADDWF       SSD1306_DrawCircleHelper_f_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SSD1306_DrawCircleHelper_f_L0+1, 1 
;SSD1306OLED.c,525 :: 		}
L_SSD1306_DrawCircleHelper42:
;SSD1306OLED.c,526 :: 		x++;
	INFSNZ      SSD1306_DrawCircleHelper_x_L0+0, 1 
	INCF        SSD1306_DrawCircleHelper_x_L0+1, 1 
;SSD1306OLED.c,527 :: 		ddF_x += 2;
	MOVLW       2
	ADDWF       SSD1306_DrawCircleHelper_ddF_x_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      SSD1306_DrawCircleHelper_ddF_x_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SSD1306_DrawCircleHelper_ddF_x_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_DrawCircleHelper_ddF_x_L0+1 
;SSD1306OLED.c,528 :: 		f     += ddF_x;
	MOVF        R0, 0 
	ADDWF       SSD1306_DrawCircleHelper_f_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SSD1306_DrawCircleHelper_f_L0+1, 1 
;SSD1306OLED.c,529 :: 		if (cornername & 0x4) {
	BTFSS       FARG_SSD1306_DrawCircleHelper_cornername+0, 2 
	GOTO        L_SSD1306_DrawCircleHelper43
;SSD1306OLED.c,530 :: 		SSD1306_DrawPixel(x0 + x, y0 + y);
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,531 :: 		SSD1306_DrawPixel(x0 + y, y0 + x);
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,532 :: 		}
L_SSD1306_DrawCircleHelper43:
;SSD1306OLED.c,533 :: 		if (cornername & 0x2) {
	BTFSS       FARG_SSD1306_DrawCircleHelper_cornername+0, 1 
	GOTO        L_SSD1306_DrawCircleHelper44
;SSD1306OLED.c,534 :: 		SSD1306_DrawPixel(x0 + x, y0 - y);
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,535 :: 		SSD1306_DrawPixel(x0 + y, y0 - x);
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,536 :: 		}
L_SSD1306_DrawCircleHelper44:
;SSD1306OLED.c,537 :: 		if (cornername & 0x8) {
	BTFSS       FARG_SSD1306_DrawCircleHelper_cornername+0, 3 
	GOTO        L_SSD1306_DrawCircleHelper45
;SSD1306OLED.c,538 :: 		SSD1306_DrawPixel(x0 - y, y0 + x);
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,539 :: 		SSD1306_DrawPixel(x0 - x, y0 + y);
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,540 :: 		}
L_SSD1306_DrawCircleHelper45:
;SSD1306OLED.c,541 :: 		if (cornername & 0x1) {
	BTFSS       FARG_SSD1306_DrawCircleHelper_cornername+0, 0 
	GOTO        L_SSD1306_DrawCircleHelper46
;SSD1306OLED.c,542 :: 		SSD1306_DrawPixel(x0 - y, y0 - x);
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,543 :: 		SSD1306_DrawPixel(x0 - x, y0 - y);
	MOVF        SSD1306_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,544 :: 		}
L_SSD1306_DrawCircleHelper46:
;SSD1306OLED.c,545 :: 		}
	GOTO        L_SSD1306_DrawCircleHelper40
L_SSD1306_DrawCircleHelper41:
;SSD1306OLED.c,547 :: 		}
L_end_SSD1306_DrawCircleHelper:
	RETURN      0
; end of _SSD1306_DrawCircleHelper

_SSD1306_FillCircle:

;SSD1306OLED.c,549 :: 		void SSD1306_FillCircle(int16_t x0, int16_t y0, int16_t r) {
;SSD1306OLED.c,550 :: 		SSD1306_DrawFastVLine(x0, y0 - r, 2 * r + 1);
	MOVF        FARG_SSD1306_FillCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        FARG_SSD1306_FillCircle_r+0, 0 
	SUBWF       FARG_SSD1306_FillCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        FARG_SSD1306_FillCircle_r+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	RLCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	BCF         FARG_SSD1306_DrawFastVLine_h+0, 0 
	INCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,551 :: 		SSD1306_FillCircleHelper(x0, y0, r, 3, 0);
	MOVF        FARG_SSD1306_FillCircle_x0+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_x0+0 
	MOVF        FARG_SSD1306_FillCircle_x0+1, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_x0+1 
	MOVF        FARG_SSD1306_FillCircle_y0+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_y0+0 
	MOVF        FARG_SSD1306_FillCircle_y0+1, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_y0+1 
	MOVF        FARG_SSD1306_FillCircle_r+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_r+0 
	MOVF        FARG_SSD1306_FillCircle_r+1, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_r+1 
	MOVLW       3
	MOVWF       FARG_SSD1306_FillCircleHelper_cornername+0 
	CLRF        FARG_SSD1306_FillCircleHelper_delta+0 
	CLRF        FARG_SSD1306_FillCircleHelper_delta+1 
	CALL        _SSD1306_FillCircleHelper+0, 0
;SSD1306OLED.c,552 :: 		}
L_end_SSD1306_FillCircle:
	RETURN      0
; end of _SSD1306_FillCircle

_SSD1306_FillCircleHelper:

;SSD1306OLED.c,555 :: 		void SSD1306_FillCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername, int16_t delta) {
;SSD1306OLED.c,556 :: 		int16_t f     = 1 - r;
	MOVF        FARG_SSD1306_FillCircleHelper_r+0, 0 
	SUBLW       1
	MOVWF       SSD1306_FillCircleHelper_f_L0+0 
	MOVF        FARG_SSD1306_FillCircleHelper_r+1, 0 
	MOVWF       SSD1306_FillCircleHelper_f_L0+1 
	MOVLW       0
	SUBFWB      SSD1306_FillCircleHelper_f_L0+1, 1 
;SSD1306OLED.c,557 :: 		int16_t ddF_x = 1;
	MOVLW       1
	MOVWF       SSD1306_FillCircleHelper_ddF_x_L0+0 
	MOVLW       0
	MOVWF       SSD1306_FillCircleHelper_ddF_x_L0+1 
;SSD1306OLED.c,558 :: 		int16_t ddF_y = -2 * r;
	MOVLW       254
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVF        FARG_SSD1306_FillCircleHelper_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_SSD1306_FillCircleHelper_r+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       SSD1306_FillCircleHelper_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_FillCircleHelper_ddF_y_L0+1 
;SSD1306OLED.c,559 :: 		int16_t x     = 0;
	CLRF        SSD1306_FillCircleHelper_x_L0+0 
	CLRF        SSD1306_FillCircleHelper_x_L0+1 
;SSD1306OLED.c,560 :: 		int16_t y     = r;
	MOVF        FARG_SSD1306_FillCircleHelper_r+0, 0 
	MOVWF       SSD1306_FillCircleHelper_y_L0+0 
	MOVF        FARG_SSD1306_FillCircleHelper_r+1, 0 
	MOVWF       SSD1306_FillCircleHelper_y_L0+1 
;SSD1306OLED.c,562 :: 		while (x < y) {
L_SSD1306_FillCircleHelper47:
	MOVLW       128
	XORWF       SSD1306_FillCircleHelper_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SSD1306_FillCircleHelper_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillCircleHelper182
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	SUBWF       SSD1306_FillCircleHelper_x_L0+0, 0 
L__SSD1306_FillCircleHelper182:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillCircleHelper48
;SSD1306OLED.c,563 :: 		if (f >= 0) {
	MOVLW       128
	XORWF       SSD1306_FillCircleHelper_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillCircleHelper183
	MOVLW       0
	SUBWF       SSD1306_FillCircleHelper_f_L0+0, 0 
L__SSD1306_FillCircleHelper183:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_FillCircleHelper49
;SSD1306OLED.c,564 :: 		y--;
	MOVLW       1
	SUBWF       SSD1306_FillCircleHelper_y_L0+0, 1 
	MOVLW       0
	SUBWFB      SSD1306_FillCircleHelper_y_L0+1, 1 
;SSD1306OLED.c,565 :: 		ddF_y += 2;
	MOVLW       2
	ADDWF       SSD1306_FillCircleHelper_ddF_y_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      SSD1306_FillCircleHelper_ddF_y_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SSD1306_FillCircleHelper_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_FillCircleHelper_ddF_y_L0+1 
;SSD1306OLED.c,566 :: 		f     += ddF_y;
	MOVF        R0, 0 
	ADDWF       SSD1306_FillCircleHelper_f_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SSD1306_FillCircleHelper_f_L0+1, 1 
;SSD1306OLED.c,567 :: 		}
L_SSD1306_FillCircleHelper49:
;SSD1306OLED.c,568 :: 		x++;
	INFSNZ      SSD1306_FillCircleHelper_x_L0+0, 1 
	INCF        SSD1306_FillCircleHelper_x_L0+1, 1 
;SSD1306OLED.c,569 :: 		ddF_x += 2;
	MOVLW       2
	ADDWF       SSD1306_FillCircleHelper_ddF_x_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      SSD1306_FillCircleHelper_ddF_x_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       SSD1306_FillCircleHelper_ddF_x_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_FillCircleHelper_ddF_x_L0+1 
;SSD1306OLED.c,570 :: 		f     += ddF_x;
	MOVF        R0, 0 
	ADDWF       SSD1306_FillCircleHelper_f_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SSD1306_FillCircleHelper_f_L0+1, 1 
;SSD1306OLED.c,572 :: 		if (cornername & 0x01) {
	BTFSS       FARG_SSD1306_FillCircleHelper_cornername+0, 0 
	GOTO        L_SSD1306_FillCircleHelper50
;SSD1306OLED.c,573 :: 		SSD1306_DrawFastVLine(x0 + x, y0 - y, 2 * y + 1 + delta);
	MOVF        SSD1306_FillCircleHelper_x_L0+0, 0 
	ADDWF       FARG_SSD1306_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	RLCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	BCF         FARG_SSD1306_DrawFastVLine_h+0, 0 
	INCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	MOVF        FARG_SSD1306_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_SSD1306_DrawFastVLine_h+0, 1 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,574 :: 		SSD1306_DrawFastVLine(x0 + y, y0 - x, 2 * x + 1 + delta);
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	ADDWF       FARG_SSD1306_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        SSD1306_FillCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        SSD1306_FillCircleHelper_x_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	RLCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	BCF         FARG_SSD1306_DrawFastVLine_h+0, 0 
	INCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	MOVF        FARG_SSD1306_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_SSD1306_DrawFastVLine_h+0, 1 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,575 :: 		}
L_SSD1306_FillCircleHelper50:
;SSD1306OLED.c,576 :: 		if (cornername & 0x02) {
	BTFSS       FARG_SSD1306_FillCircleHelper_cornername+0, 1 
	GOTO        L_SSD1306_FillCircleHelper51
;SSD1306OLED.c,577 :: 		SSD1306_DrawFastVLine(x0 - x, y0 - y, 2 * y + 1 + delta);
	MOVF        SSD1306_FillCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	RLCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	BCF         FARG_SSD1306_DrawFastVLine_h+0, 0 
	INCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	MOVF        FARG_SSD1306_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_SSD1306_DrawFastVLine_h+0, 1 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,578 :: 		SSD1306_DrawFastVLine(x0 - y, y0 - x, 2 * x + 1 + delta);
	MOVF        SSD1306_FillCircleHelper_y_L0+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        SSD1306_FillCircleHelper_x_L0+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        SSD1306_FillCircleHelper_x_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	RLCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	BCF         FARG_SSD1306_DrawFastVLine_h+0, 0 
	INCF        FARG_SSD1306_DrawFastVLine_h+0, 1 
	MOVF        FARG_SSD1306_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_SSD1306_DrawFastVLine_h+0, 1 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,579 :: 		}
L_SSD1306_FillCircleHelper51:
;SSD1306OLED.c,580 :: 		}
	GOTO        L_SSD1306_FillCircleHelper47
L_SSD1306_FillCircleHelper48:
;SSD1306OLED.c,582 :: 		}
L_end_SSD1306_FillCircleHelper:
	RETURN      0
; end of _SSD1306_FillCircleHelper

_SSD1306_DrawRect:

;SSD1306OLED.c,585 :: 		void SSD1306_DrawRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
;SSD1306OLED.c,586 :: 		SSD1306_DrawFastHLine(x, y, w);
	MOVF        FARG_SSD1306_DrawRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        FARG_SSD1306_DrawRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	MOVF        FARG_SSD1306_DrawRect_w+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,587 :: 		SSD1306_DrawFastHLine(x, y + h - 1, w);
	MOVF        FARG_SSD1306_DrawRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        FARG_SSD1306_DrawRect_h+0, 0 
	ADDWF       FARG_SSD1306_DrawRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	DECF        FARG_SSD1306_DrawFastHLine_y+0, 1 
	MOVF        FARG_SSD1306_DrawRect_w+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,588 :: 		SSD1306_DrawFastVLine(x, y, h);
	MOVF        FARG_SSD1306_DrawRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        FARG_SSD1306_DrawRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        FARG_SSD1306_DrawRect_h+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,589 :: 		SSD1306_DrawFastVLine(x + w - 1, y, h);
	MOVF        FARG_SSD1306_DrawRect_w+0, 0 
	ADDWF       FARG_SSD1306_DrawRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	DECF        FARG_SSD1306_DrawFastVLine_x+0, 1 
	MOVF        FARG_SSD1306_DrawRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        FARG_SSD1306_DrawRect_h+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,590 :: 		}
L_end_SSD1306_DrawRect:
	RETURN      0
; end of _SSD1306_DrawRect

_SSD1306_DrawRoundRect:

;SSD1306OLED.c,593 :: 		void SSD1306_DrawRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r) {
;SSD1306OLED.c,595 :: 		SSD1306_DrawFastHLine(x + r, y, w - 2 * r); // Top
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_DrawRoundRect_w+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,596 :: 		SSD1306_DrawFastHLine(x + r, y + h - 1, w - 2 * r); // Bottom
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        FARG_SSD1306_DrawRoundRect_h+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	DECF        FARG_SSD1306_DrawFastHLine_y+0, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_DrawRoundRect_w+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,597 :: 		SSD1306_DrawFastVLine(x, y + r, h - 2 * r); // Left
	MOVF        FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_DrawRoundRect_h+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,598 :: 		SSD1306_DrawFastVLine(x + w - 1, y + r, h - 2 * r); // Right
	MOVF        FARG_SSD1306_DrawRoundRect_w+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_x+0 
	DECF        FARG_SSD1306_DrawFastVLine_x+0, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_y+0 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_DrawRoundRect_h+0, 0 
	MOVWF       FARG_SSD1306_DrawFastVLine_h+0 
	CALL        _SSD1306_DrawFastVLine+0, 0
;SSD1306OLED.c,600 :: 		SSD1306_DrawCircleHelper(x + r, y + r, r, 1);
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_x0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_y0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+1 
	MOVLW       1
	MOVWF       FARG_SSD1306_DrawCircleHelper_cornername+0 
	CALL        _SSD1306_DrawCircleHelper+0, 0
;SSD1306OLED.c,601 :: 		SSD1306_DrawCircleHelper(x + w - r - 1, y + r, r, 2);
	MOVF        FARG_SSD1306_DrawRoundRect_w+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_x0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_y0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+1 
	MOVLW       2
	MOVWF       FARG_SSD1306_DrawCircleHelper_cornername+0 
	CALL        _SSD1306_DrawCircleHelper+0, 0
;SSD1306OLED.c,602 :: 		SSD1306_DrawCircleHelper(x + w - r - 1, y + h - r - 1, r, 4);
	MOVF        FARG_SSD1306_DrawRoundRect_w+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_x0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_h+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_y0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+1 
	MOVLW       4
	MOVWF       FARG_SSD1306_DrawCircleHelper_cornername+0 
	CALL        _SSD1306_DrawCircleHelper+0, 0
;SSD1306OLED.c,603 :: 		SSD1306_DrawCircleHelper(x + r, y + h - r - 1, r, 8);
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_x0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_h+0, 0 
	ADDWF       FARG_SSD1306_DrawRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_y0+0 
	CLRF        FARG_SSD1306_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_DrawRoundRect_r+0, 0 
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawCircleHelper_r+1 
	MOVLW       8
	MOVWF       FARG_SSD1306_DrawCircleHelper_cornername+0 
	CALL        _SSD1306_DrawCircleHelper+0, 0
;SSD1306OLED.c,604 :: 		}
L_end_SSD1306_DrawRoundRect:
	RETURN      0
; end of _SSD1306_DrawRoundRect

_SSD1306_FillRoundRect:

;SSD1306OLED.c,607 :: 		void SSD1306_FillRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r) {
;SSD1306OLED.c,609 :: 		SSD1306_FillRect(x + r, y, w - 2 * r, h);
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_FillRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_FillRect_x+0 
	MOVF        FARG_SSD1306_FillRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_FillRect_y+0 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_FillRoundRect_w+0, 0 
	MOVWF       FARG_SSD1306_FillRect_w+0 
	MOVF        FARG_SSD1306_FillRoundRect_h+0, 0 
	MOVWF       FARG_SSD1306_FillRect_h+0 
	CALL        _SSD1306_FillRect+0, 0
;SSD1306OLED.c,611 :: 		SSD1306_FillCircleHelper(x + w - r - 1, y + r, r, 1, h - 2 * r - 1);
	MOVF        FARG_SSD1306_FillRoundRect_w+0, 0 
	ADDWF       FARG_SSD1306_FillRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_x0+0 
	CLRF        FARG_SSD1306_FillCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_FillCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	SUBWF       FARG_SSD1306_FillCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_FillCircleHelper_x0+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_FillCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_FillCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_FillRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_y0+0 
	CLRF        FARG_SSD1306_FillCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_FillCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_FillCircleHelper_r+1 
	MOVLW       1
	MOVWF       FARG_SSD1306_FillCircleHelper_cornername+0 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_FillRoundRect_h+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_delta+0 
	MOVF        R1, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_delta+1 
	MOVLW       0
	SUBFWB      FARG_SSD1306_FillCircleHelper_delta+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_FillCircleHelper_delta+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_FillCircleHelper_delta+1, 1 
	CALL        _SSD1306_FillCircleHelper+0, 0
;SSD1306OLED.c,612 :: 		SSD1306_FillCircleHelper(x + r        , y + r, r, 2, h - 2 * r - 1);
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_FillRoundRect_x+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_x0+0 
	CLRF        FARG_SSD1306_FillCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_FillCircleHelper_x0+1, 1 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	ADDWF       FARG_SSD1306_FillRoundRect_y+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_y0+0 
	CLRF        FARG_SSD1306_FillCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_FillCircleHelper_y0+1, 1 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_FillCircleHelper_r+1 
	MOVLW       2
	MOVWF       FARG_SSD1306_FillCircleHelper_cornername+0 
	MOVF        FARG_SSD1306_FillRoundRect_r+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       FARG_SSD1306_FillRoundRect_h+0, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_delta+0 
	MOVF        R1, 0 
	MOVWF       FARG_SSD1306_FillCircleHelper_delta+1 
	MOVLW       0
	SUBFWB      FARG_SSD1306_FillCircleHelper_delta+1, 1 
	MOVLW       1
	SUBWF       FARG_SSD1306_FillCircleHelper_delta+0, 1 
	MOVLW       0
	SUBWFB      FARG_SSD1306_FillCircleHelper_delta+1, 1 
	CALL        _SSD1306_FillCircleHelper+0, 0
;SSD1306OLED.c,613 :: 		}
L_end_SSD1306_FillRoundRect:
	RETURN      0
; end of _SSD1306_FillRoundRect

_SSD1306_DrawTriangle:

;SSD1306OLED.c,616 :: 		void SSD1306_DrawTriangle(uint8_t x0, uint8_t y0, uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2) {
;SSD1306OLED.c,617 :: 		SSD1306_DrawLine(x0, y0, x1, y1);
	MOVF        FARG_SSD1306_DrawTriangle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        FARG_SSD1306_DrawTriangle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
	MOVF        FARG_SSD1306_DrawTriangle_x1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x1+1 
	MOVF        FARG_SSD1306_DrawTriangle_y1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y1+1 
	CALL        _SSD1306_DrawLine+0, 0
;SSD1306OLED.c,618 :: 		SSD1306_DrawLine(x1, y1, x2, y2);
	MOVF        FARG_SSD1306_DrawTriangle_x1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        FARG_SSD1306_DrawTriangle_y1+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
	MOVF        FARG_SSD1306_DrawTriangle_x2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x1+1 
	MOVF        FARG_SSD1306_DrawTriangle_y2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y1+1 
	CALL        _SSD1306_DrawLine+0, 0
;SSD1306OLED.c,619 :: 		SSD1306_DrawLine(x2, y2, x0, y0);
	MOVF        FARG_SSD1306_DrawTriangle_x2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x0+1 
	MOVF        FARG_SSD1306_DrawTriangle_y2+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y0+1 
	MOVF        FARG_SSD1306_DrawTriangle_x0+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_x1+1 
	MOVF        FARG_SSD1306_DrawTriangle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_SSD1306_DrawLine_y1+1 
	CALL        _SSD1306_DrawLine+0, 0
;SSD1306OLED.c,620 :: 		}
L_end_SSD1306_DrawTriangle:
	RETURN      0
; end of _SSD1306_DrawTriangle

_SSD1306_FillTriangle:

;SSD1306OLED.c,623 :: 		void SSD1306_FillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2) {
;SSD1306OLED.c,625 :: 		dx01 = x1 - x0,
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_x1+0, 0 
	MOVWF       SSD1306_FillTriangle_dx01_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	SUBWFB      FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       SSD1306_FillTriangle_dx01_L0+1 
;SSD1306OLED.c,626 :: 		dy01 = y1 - y0,
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y1+0, 0 
	MOVWF       SSD1306_FillTriangle_dy01_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	SUBWFB      FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       SSD1306_FillTriangle_dy01_L0+1 
;SSD1306OLED.c,627 :: 		dx02 = x2 - x0,
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_x2+0, 0 
	MOVWF       SSD1306_FillTriangle_dx02_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	SUBWFB      FARG_SSD1306_FillTriangle_x2+1, 0 
	MOVWF       SSD1306_FillTriangle_dx02_L0+1 
;SSD1306OLED.c,628 :: 		dy02 = y2 - y0,
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y2+0, 0 
	MOVWF       SSD1306_FillTriangle_dy02_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	SUBWFB      FARG_SSD1306_FillTriangle_y2+1, 0 
	MOVWF       SSD1306_FillTriangle_dy02_L0+1 
;SSD1306OLED.c,629 :: 		dx12 = x2 - x1,
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_x2+0, 0 
	MOVWF       SSD1306_FillTriangle_dx12_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	SUBWFB      FARG_SSD1306_FillTriangle_x2+1, 0 
	MOVWF       SSD1306_FillTriangle_dx12_L0+1 
;SSD1306OLED.c,630 :: 		dy12 = y2 - y1;
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y2+0, 0 
	MOVWF       SSD1306_FillTriangle_dy12_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	SUBWFB      FARG_SSD1306_FillTriangle_y2+1, 0 
	MOVWF       SSD1306_FillTriangle_dy12_L0+1 
;SSD1306OLED.c,631 :: 		int32_t  sa   = 0, sb   = 0;
	CLRF        SSD1306_FillTriangle_sa_L0+0 
	CLRF        SSD1306_FillTriangle_sa_L0+1 
	CLRF        SSD1306_FillTriangle_sa_L0+2 
	CLRF        SSD1306_FillTriangle_sa_L0+3 
	CLRF        SSD1306_FillTriangle_sb_L0+0 
	CLRF        SSD1306_FillTriangle_sb_L0+1 
	CLRF        SSD1306_FillTriangle_sb_L0+2 
	CLRF        SSD1306_FillTriangle_sb_L0+3 
;SSD1306OLED.c,633 :: 		if (y0 > y1) {
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle189
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y1+0, 0 
L__SSD1306_FillTriangle189:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle52
;SSD1306OLED.c,634 :: 		ssd1306_swap(y0, y1); ssd1306_swap(x0, x1);
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2+0 
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2+1 
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y0+0 
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y0+1 
	MOVF        SSD1306_FillTriangle_t_L2+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y1+0 
	MOVF        SSD1306_FillTriangle_t_L2+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y1+1 
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2+1 
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x0+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x0+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x1+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x1+1 
;SSD1306OLED.c,635 :: 		}
L_SSD1306_FillTriangle52:
;SSD1306OLED.c,636 :: 		if (y1 > y2) {
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle190
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y2+0, 0 
L__SSD1306_FillTriangle190:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle53
;SSD1306OLED.c,637 :: 		ssd1306_swap(y2, y1); ssd1306_swap(x2, x1);
	MOVF        FARG_SSD1306_FillTriangle_y2+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2+0 
	MOVF        FARG_SSD1306_FillTriangle_y2+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2+1 
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y2+0 
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y2+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y1+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y1+1 
	MOVF        FARG_SSD1306_FillTriangle_x2+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2+0 
	MOVF        FARG_SSD1306_FillTriangle_x2+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2+1 
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x2+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x2+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x1+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x1+1 
;SSD1306OLED.c,638 :: 		}
L_SSD1306_FillTriangle53:
;SSD1306OLED.c,639 :: 		if (y0 > y1) {
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle191
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y1+0, 0 
L__SSD1306_FillTriangle191:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle54
;SSD1306OLED.c,640 :: 		ssd1306_swap(y0, y1); ssd1306_swap(x0, x1);
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2+0 
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2+1 
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y0+0 
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y0+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y1+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_y1+1 
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2+1 
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x0+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x0+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x1+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_SSD1306_FillTriangle_x1+1 
;SSD1306OLED.c,641 :: 		}
L_SSD1306_FillTriangle54:
;SSD1306OLED.c,643 :: 		if(y0 == y2) { // Handle awkward all-on-same-line case as its own thing
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	XORWF       FARG_SSD1306_FillTriangle_y2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle192
	MOVF        FARG_SSD1306_FillTriangle_y2+0, 0 
	XORWF       FARG_SSD1306_FillTriangle_y0+0, 0 
L__SSD1306_FillTriangle192:
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_FillTriangle55
;SSD1306OLED.c,644 :: 		a = b = x0;
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
;SSD1306OLED.c,645 :: 		if(x1 < a)      a = x1;
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_x0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle193
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_x1+0, 0 
L__SSD1306_FillTriangle193:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle56
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
	GOTO        L_SSD1306_FillTriangle57
L_SSD1306_FillTriangle56:
;SSD1306OLED.c,646 :: 		else if(x1 > b) b = x1;
	MOVLW       128
	XORWF       SSD1306_FillTriangle_b_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_x1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle194
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	SUBWF       SSD1306_FillTriangle_b_L0+0, 0 
L__SSD1306_FillTriangle194:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle58
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
L_SSD1306_FillTriangle58:
L_SSD1306_FillTriangle57:
;SSD1306OLED.c,647 :: 		if(x2 < a)      a = x2;
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_x2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SSD1306_FillTriangle_a_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle195
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_x2+0, 0 
L__SSD1306_FillTriangle195:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle59
	MOVF        FARG_SSD1306_FillTriangle_x2+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x2+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
	GOTO        L_SSD1306_FillTriangle60
L_SSD1306_FillTriangle59:
;SSD1306OLED.c,648 :: 		else if(x2 > b) b = x2;
	MOVLW       128
	XORWF       SSD1306_FillTriangle_b_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_x2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle196
	MOVF        FARG_SSD1306_FillTriangle_x2+0, 0 
	SUBWF       SSD1306_FillTriangle_b_L0+0, 0 
L__SSD1306_FillTriangle196:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle61
	MOVF        FARG_SSD1306_FillTriangle_x2+0, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_x2+1, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
L_SSD1306_FillTriangle61:
L_SSD1306_FillTriangle60:
;SSD1306OLED.c,649 :: 		SSD1306_DrawFastHLine(a, y0, b - a + 1);
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	SUBWF       SSD1306_FillTriangle_b_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	INCF        FARG_SSD1306_DrawFastHLine_w+0, 1 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,650 :: 		return;
	GOTO        L_end_SSD1306_FillTriangle
;SSD1306OLED.c,651 :: 		}
L_SSD1306_FillTriangle55:
;SSD1306OLED.c,653 :: 		if(y1 == y2) last = y1;   // Include y1 scanline
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	XORWF       FARG_SSD1306_FillTriangle_y2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle197
	MOVF        FARG_SSD1306_FillTriangle_y2+0, 0 
	XORWF       FARG_SSD1306_FillTriangle_y1+0, 0 
L__SSD1306_FillTriangle197:
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_FillTriangle62
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	MOVWF       SSD1306_FillTriangle_last_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       SSD1306_FillTriangle_last_L0+1 
	GOTO        L_SSD1306_FillTriangle63
L_SSD1306_FillTriangle62:
;SSD1306OLED.c,654 :: 		else         last = y1 - 1; // Skip it
	MOVLW       1
	SUBWF       FARG_SSD1306_FillTriangle_y1+0, 0 
	MOVWF       SSD1306_FillTriangle_last_L0+0 
	MOVLW       0
	SUBWFB      FARG_SSD1306_FillTriangle_y1+1, 0 
	MOVWF       SSD1306_FillTriangle_last_L0+1 
L_SSD1306_FillTriangle63:
;SSD1306OLED.c,656 :: 		for(y = y0; y <= last; y++) {
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	MOVWF       SSD1306_FillTriangle_y_L0+0 
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	MOVWF       SSD1306_FillTriangle_y_L0+1 
L_SSD1306_FillTriangle64:
	MOVLW       128
	XORWF       SSD1306_FillTriangle_last_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SSD1306_FillTriangle_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle198
	MOVF        SSD1306_FillTriangle_y_L0+0, 0 
	SUBWF       SSD1306_FillTriangle_last_L0+0, 0 
L__SSD1306_FillTriangle198:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle65
;SSD1306OLED.c,657 :: 		a   = x0 + sa / dy01;
	MOVF        SSD1306_FillTriangle_dy01_L0+0, 0 
	MOVWF       R4 
	MOVF        SSD1306_FillTriangle_dy01_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dy01_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        SSD1306_FillTriangle_sa_L0+0, 0 
	MOVWF       R0 
	MOVF        SSD1306_FillTriangle_sa_L0+1, 0 
	MOVWF       R1 
	MOVF        SSD1306_FillTriangle_sa_L0+2, 0 
	MOVWF       R2 
	MOVF        SSD1306_FillTriangle_sa_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SSD1306_FillTriangle+0 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FLOC__SSD1306_FillTriangle+1 
	MOVF        FLOC__SSD1306_FillTriangle+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        FLOC__SSD1306_FillTriangle+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
;SSD1306OLED.c,658 :: 		b   = x0 + sb / dy02;
	MOVF        SSD1306_FillTriangle_dy02_L0+0, 0 
	MOVWF       R4 
	MOVF        SSD1306_FillTriangle_dy02_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dy02_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        SSD1306_FillTriangle_sb_L0+0, 0 
	MOVWF       R0 
	MOVF        SSD1306_FillTriangle_sb_L0+1, 0 
	MOVWF       R1 
	MOVF        SSD1306_FillTriangle_sb_L0+2, 0 
	MOVWF       R2 
	MOVF        SSD1306_FillTriangle_sb_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        R5, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
;SSD1306OLED.c,659 :: 		sa += dx01;
	MOVF        SSD1306_FillTriangle_dx01_L0+0, 0 
	ADDWF       SSD1306_FillTriangle_sa_L0+0, 1 
	MOVF        SSD1306_FillTriangle_dx01_L0+1, 0 
	ADDWFC      SSD1306_FillTriangle_sa_L0+1, 1 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dx01_L0+1, 7 
	MOVLW       255
	ADDWFC      SSD1306_FillTriangle_sa_L0+2, 1 
	ADDWFC      SSD1306_FillTriangle_sa_L0+3, 1 
;SSD1306OLED.c,660 :: 		sb += dx02;
	MOVF        SSD1306_FillTriangle_dx02_L0+0, 0 
	ADDWF       SSD1306_FillTriangle_sb_L0+0, 1 
	MOVF        SSD1306_FillTriangle_dx02_L0+1, 0 
	ADDWFC      SSD1306_FillTriangle_sb_L0+1, 1 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dx02_L0+1, 7 
	MOVLW       255
	ADDWFC      SSD1306_FillTriangle_sb_L0+2, 1 
	ADDWFC      SSD1306_FillTriangle_sb_L0+3, 1 
;SSD1306OLED.c,665 :: 		if(a > b) ssd1306_swap(a, b);
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FLOC__SSD1306_FillTriangle+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle199
	MOVF        FLOC__SSD1306_FillTriangle+0, 0 
	SUBWF       R4, 0 
L__SSD1306_FillTriangle199:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle67
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+0 
	MOVF        SSD1306_FillTriangle_a_L0+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+1 
	MOVF        SSD1306_FillTriangle_b_L0+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        SSD1306_FillTriangle_b_L0+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+1, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
L_SSD1306_FillTriangle67:
;SSD1306OLED.c,666 :: 		SSD1306_DrawFastHLine(a, y, b - a + 1);
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        SSD1306_FillTriangle_y_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	SUBWF       SSD1306_FillTriangle_b_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	INCF        FARG_SSD1306_DrawFastHLine_w+0, 1 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,656 :: 		for(y = y0; y <= last; y++) {
	INFSNZ      SSD1306_FillTriangle_y_L0+0, 1 
	INCF        SSD1306_FillTriangle_y_L0+1, 1 
;SSD1306OLED.c,667 :: 		}
	GOTO        L_SSD1306_FillTriangle64
L_SSD1306_FillTriangle65:
;SSD1306OLED.c,671 :: 		sa = dx12 * (y - y1);
	MOVF        FARG_SSD1306_FillTriangle_y1+0, 0 
	SUBWF       SSD1306_FillTriangle_y_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_SSD1306_FillTriangle_y1+1, 0 
	SUBWFB      SSD1306_FillTriangle_y_L0+1, 0 
	MOVWF       R1 
	MOVF        SSD1306_FillTriangle_dx12_L0+0, 0 
	MOVWF       R4 
	MOVF        SSD1306_FillTriangle_dx12_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       SSD1306_FillTriangle_sa_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_FillTriangle_sa_L0+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       SSD1306_FillTriangle_sa_L0+2 
	MOVWF       SSD1306_FillTriangle_sa_L0+3 
;SSD1306OLED.c,672 :: 		sb = dx02 * (y - y0);
	MOVF        FARG_SSD1306_FillTriangle_y0+0, 0 
	SUBWF       SSD1306_FillTriangle_y_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_SSD1306_FillTriangle_y0+1, 0 
	SUBWFB      SSD1306_FillTriangle_y_L0+1, 0 
	MOVWF       R1 
	MOVF        SSD1306_FillTriangle_dx02_L0+0, 0 
	MOVWF       R4 
	MOVF        SSD1306_FillTriangle_dx02_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       SSD1306_FillTriangle_sb_L0+0 
	MOVF        R1, 0 
	MOVWF       SSD1306_FillTriangle_sb_L0+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       SSD1306_FillTriangle_sb_L0+2 
	MOVWF       SSD1306_FillTriangle_sb_L0+3 
;SSD1306OLED.c,673 :: 		for(; y <= y2; y++) {
L_SSD1306_FillTriangle68:
	MOVLW       128
	XORWF       FARG_SSD1306_FillTriangle_y2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       SSD1306_FillTriangle_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle200
	MOVF        SSD1306_FillTriangle_y_L0+0, 0 
	SUBWF       FARG_SSD1306_FillTriangle_y2+0, 0 
L__SSD1306_FillTriangle200:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle69
;SSD1306OLED.c,674 :: 		a   = x1 + sa / dy12;
	MOVF        SSD1306_FillTriangle_dy12_L0+0, 0 
	MOVWF       R4 
	MOVF        SSD1306_FillTriangle_dy12_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dy12_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        SSD1306_FillTriangle_sa_L0+0, 0 
	MOVWF       R0 
	MOVF        SSD1306_FillTriangle_sa_L0+1, 0 
	MOVWF       R1 
	MOVF        SSD1306_FillTriangle_sa_L0+2, 0 
	MOVWF       R2 
	MOVF        SSD1306_FillTriangle_sa_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_SSD1306_FillTriangle_x1+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__SSD1306_FillTriangle+0 
	MOVF        FARG_SSD1306_FillTriangle_x1+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FLOC__SSD1306_FillTriangle+1 
	MOVF        FLOC__SSD1306_FillTriangle+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        FLOC__SSD1306_FillTriangle+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
;SSD1306OLED.c,675 :: 		b   = x0 + sb / dy02;
	MOVF        SSD1306_FillTriangle_dy02_L0+0, 0 
	MOVWF       R4 
	MOVF        SSD1306_FillTriangle_dy02_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dy02_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        SSD1306_FillTriangle_sb_L0+0, 0 
	MOVWF       R0 
	MOVF        SSD1306_FillTriangle_sb_L0+1, 0 
	MOVWF       R1 
	MOVF        SSD1306_FillTriangle_sb_L0+2, 0 
	MOVWF       R2 
	MOVF        SSD1306_FillTriangle_sb_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_SSD1306_FillTriangle_x0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVF        FARG_SSD1306_FillTriangle_x0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        R5, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
;SSD1306OLED.c,676 :: 		sa += dx12;
	MOVF        SSD1306_FillTriangle_dx12_L0+0, 0 
	ADDWF       SSD1306_FillTriangle_sa_L0+0, 1 
	MOVF        SSD1306_FillTriangle_dx12_L0+1, 0 
	ADDWFC      SSD1306_FillTriangle_sa_L0+1, 1 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dx12_L0+1, 7 
	MOVLW       255
	ADDWFC      SSD1306_FillTriangle_sa_L0+2, 1 
	ADDWFC      SSD1306_FillTriangle_sa_L0+3, 1 
;SSD1306OLED.c,677 :: 		sb += dx02;
	MOVF        SSD1306_FillTriangle_dx02_L0+0, 0 
	ADDWF       SSD1306_FillTriangle_sb_L0+0, 1 
	MOVF        SSD1306_FillTriangle_dx02_L0+1, 0 
	ADDWFC      SSD1306_FillTriangle_sb_L0+1, 1 
	MOVLW       0
	BTFSC       SSD1306_FillTriangle_dx02_L0+1, 7 
	MOVLW       255
	ADDWFC      SSD1306_FillTriangle_sb_L0+2, 1 
	ADDWFC      SSD1306_FillTriangle_sb_L0+3, 1 
;SSD1306OLED.c,682 :: 		if(a > b) ssd1306_swap(a, b);
	MOVLW       128
	XORWF       R5, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FLOC__SSD1306_FillTriangle+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillTriangle201
	MOVF        FLOC__SSD1306_FillTriangle+0, 0 
	SUBWF       R4, 0 
L__SSD1306_FillTriangle201:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillTriangle71
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+0 
	MOVF        SSD1306_FillTriangle_a_L0+1, 0 
	MOVWF       SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+1 
	MOVF        SSD1306_FillTriangle_b_L0+0, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+0 
	MOVF        SSD1306_FillTriangle_b_L0+1, 0 
	MOVWF       SSD1306_FillTriangle_a_L0+1 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+0 
	MOVF        SSD1306_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+1, 0 
	MOVWF       SSD1306_FillTriangle_b_L0+1 
L_SSD1306_FillTriangle71:
;SSD1306OLED.c,683 :: 		SSD1306_DrawFastHLine(a, y, b - a + 1);
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_x+0 
	MOVF        SSD1306_FillTriangle_y_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_y+0 
	MOVF        SSD1306_FillTriangle_a_L0+0, 0 
	SUBWF       SSD1306_FillTriangle_b_L0+0, 0 
	MOVWF       FARG_SSD1306_DrawFastHLine_w+0 
	INCF        FARG_SSD1306_DrawFastHLine_w+0, 1 
	CALL        _SSD1306_DrawFastHLine+0, 0
;SSD1306OLED.c,673 :: 		for(; y <= y2; y++) {
	INFSNZ      SSD1306_FillTriangle_y_L0+0, 1 
	INCF        SSD1306_FillTriangle_y_L0+1, 1 
;SSD1306OLED.c,684 :: 		}
	GOTO        L_SSD1306_FillTriangle68
L_SSD1306_FillTriangle69:
;SSD1306OLED.c,685 :: 		}
L_end_SSD1306_FillTriangle:
	RETURN      0
; end of _SSD1306_FillTriangle

_SSD1306_FillScreen:

;SSD1306OLED.c,687 :: 		void SSD1306_FillScreen() {
;SSD1306OLED.c,689 :: 		for (i = 0; i < (SSD1306_LCDWIDTH * SSD1306_LCDHEIGHT) / 8; i++)
	CLRF        R1 
	CLRF        R2 
L_SSD1306_FillScreen72:
	MOVLW       4
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_FillScreen203
	MOVLW       0
	SUBWF       R1, 0 
L__SSD1306_FillScreen203:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_FillScreen73
;SSD1306OLED.c,690 :: 		buffer[i] = 0xFF;
	MOVLW       SSD1306OLED_buffer+0
	ADDWF       R1, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(SSD1306OLED_buffer+0)
	ADDWFC      R2, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;SSD1306OLED.c,689 :: 		for (i = 0; i < (SSD1306_LCDWIDTH * SSD1306_LCDHEIGHT) / 8; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;SSD1306OLED.c,690 :: 		buffer[i] = 0xFF;
	GOTO        L_SSD1306_FillScreen72
L_SSD1306_FillScreen73:
;SSD1306OLED.c,691 :: 		}
L_end_SSD1306_FillScreen:
	RETURN      0
; end of _SSD1306_FillScreen

_SSD1306_SetTextWrap:

;SSD1306OLED.c,693 :: 		void SSD1306_SetTextWrap(bool w) {
;SSD1306OLED.c,694 :: 		wrap = w;
	MOVF        FARG_SSD1306_SetTextWrap_w+0, 0 
	MOVWF       _wrap+0 
;SSD1306OLED.c,695 :: 		}
L_end_SSD1306_SetTextWrap:
	RETURN      0
; end of _SSD1306_SetTextWrap

_SSD1306_InvertDisplay:

;SSD1306OLED.c,698 :: 		void SSD1306_InvertDisplay(bool i) {
;SSD1306OLED.c,699 :: 		if (i)
	MOVF        FARG_SSD1306_InvertDisplay_i+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_InvertDisplay75
;SSD1306OLED.c,700 :: 		ssd1306_command(SSD1306_INVERTDISPLAY_);
	MOVLW       167
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
	GOTO        L_SSD1306_InvertDisplay76
L_SSD1306_InvertDisplay75:
;SSD1306OLED.c,702 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);
	MOVLW       166
	MOVWF       FARG_ssd1306_command_c+0 
	CALL        _ssd1306_command+0, 0
L_SSD1306_InvertDisplay76:
;SSD1306OLED.c,703 :: 		}
L_end_SSD1306_InvertDisplay:
	RETURN      0
; end of _SSD1306_InvertDisplay

_SSD1306_TextSize:

;SSD1306OLED.c,706 :: 		void SSD1306_TextSize(uint8_t t_size)
;SSD1306OLED.c,708 :: 		if(t_size < 1)
	MOVLW       1
	SUBWF       FARG_SSD1306_TextSize_t_size+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_TextSize77
;SSD1306OLED.c,709 :: 		t_size = 1;
	MOVLW       1
	MOVWF       FARG_SSD1306_TextSize_t_size+0 
L_SSD1306_TextSize77:
;SSD1306OLED.c,710 :: 		text_size = t_size;
	MOVF        FARG_SSD1306_TextSize_t_size+0, 0 
	MOVWF       _text_size+0 
;SSD1306OLED.c,711 :: 		}
L_end_SSD1306_TextSize:
	RETURN      0
; end of _SSD1306_TextSize

_SSD1306_GotoXY:

;SSD1306OLED.c,714 :: 		void SSD1306_GotoXY(uint8_t x, uint8_t y)
;SSD1306OLED.c,716 :: 		if((x >= SSD1306_LCDWIDTH) || (y >= SSD1306_LCDHEIGHT))
	MOVLW       128
	SUBWF       FARG_SSD1306_GotoXY_x+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__SSD1306_GotoXY137
	MOVLW       64
	SUBWF       FARG_SSD1306_GotoXY_y+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__SSD1306_GotoXY137
	GOTO        L_SSD1306_GotoXY80
L__SSD1306_GotoXY137:
;SSD1306OLED.c,717 :: 		return;
	GOTO        L_end_SSD1306_GotoXY
L_SSD1306_GotoXY80:
;SSD1306OLED.c,718 :: 		x_pos = x;
	MOVF        FARG_SSD1306_GotoXY_x+0, 0 
	MOVWF       _x_pos+0 
;SSD1306OLED.c,719 :: 		y_pos = y;
	MOVF        FARG_SSD1306_GotoXY_y+0, 0 
	MOVWF       _y_pos+0 
;SSD1306OLED.c,720 :: 		}
L_end_SSD1306_GotoXY:
	RETURN      0
; end of _SSD1306_GotoXY

_SSD1306_PutC:

;SSD1306OLED.c,728 :: 		void SSD1306_PutC(uint8_t c) {
;SSD1306OLED.c,731 :: 		if(c == '\a') {
	MOVF        FARG_SSD1306_PutC_c+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_PutC81
;SSD1306OLED.c,732 :: 		x_pos = y_pos = 0;
	CLRF        _y_pos+0 
	CLRF        _x_pos+0 
;SSD1306OLED.c,733 :: 		return;
	GOTO        L_end_SSD1306_PutC
;SSD1306OLED.c,734 :: 		}
L_SSD1306_PutC81:
;SSD1306OLED.c,735 :: 		if( (c == '\b') && (x_pos >= text_size * 6) ) {
	MOVF        FARG_SSD1306_PutC_c+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_PutC84
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVF        PRODH+0, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_PutC209
	MOVF        R1, 0 
	SUBWF       _x_pos+0, 0 
L__SSD1306_PutC209:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_PutC84
L__SSD1306_PutC140:
;SSD1306OLED.c,736 :: 		x_pos -= text_size * 6;
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _x_pos+0, 1 
;SSD1306OLED.c,737 :: 		return;
	GOTO        L_end_SSD1306_PutC
;SSD1306OLED.c,738 :: 		}
L_SSD1306_PutC84:
;SSD1306OLED.c,739 :: 		if(c == '\r') {
	MOVF        FARG_SSD1306_PutC_c+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_PutC85
;SSD1306OLED.c,740 :: 		x_pos = 0;
	CLRF        _x_pos+0 
;SSD1306OLED.c,741 :: 		return;
	GOTO        L_end_SSD1306_PutC
;SSD1306OLED.c,742 :: 		}
L_SSD1306_PutC85:
;SSD1306OLED.c,743 :: 		if(c == '\n') {
	MOVF        FARG_SSD1306_PutC_c+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_PutC86
;SSD1306OLED.c,744 :: 		y_pos += text_size * 8;
	MOVF        _text_size+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       _y_pos+0 
;SSD1306OLED.c,745 :: 		if((y_pos + text_size * 7) >= SSD1306_LCDHEIGHT)
	MOVLW       7
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_PutC210
	MOVLW       64
	SUBWF       R2, 0 
L__SSD1306_PutC210:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_PutC87
;SSD1306OLED.c,746 :: 		y_pos = 0;
	CLRF        _y_pos+0 
L_SSD1306_PutC87:
;SSD1306OLED.c,747 :: 		return;
	GOTO        L_end_SSD1306_PutC
;SSD1306OLED.c,748 :: 		}
L_SSD1306_PutC86:
;SSD1306OLED.c,750 :: 		if((c < ' ') || (c > '~'))
	MOVLW       32
	SUBWF       FARG_SSD1306_PutC_c+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__SSD1306_PutC139
	MOVF        FARG_SSD1306_PutC_c+0, 0 
	SUBLW       126
	BTFSS       STATUS+0, 0 
	GOTO        L__SSD1306_PutC139
	GOTO        L_SSD1306_PutC90
L__SSD1306_PutC139:
;SSD1306OLED.c,751 :: 		c = '?';
	MOVLW       63
	MOVWF       FARG_SSD1306_PutC_c+0 
L_SSD1306_PutC90:
;SSD1306OLED.c,752 :: 		for(i = 0; i < 5; i++ ) {
	CLRF        SSD1306_PutC_i_L0+0 
L_SSD1306_PutC91:
	MOVLW       5
	SUBWF       SSD1306_PutC_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_PutC92
;SSD1306OLED.c,753 :: 		line = font[(c - 32) * 5 + i];
	MOVLW       32
	SUBWF       FARG_SSD1306_PutC_c+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        SSD1306_PutC_i_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _Font+0
	ADDWF       R0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_Font+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       higher_addr(_Font+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, SSD1306_PutC_line_L0+0
;SSD1306OLED.c,755 :: 		for(j = 0; j < 7; j++, line >>= 1) {
	CLRF        SSD1306_PutC_j_L0+0 
L_SSD1306_PutC94:
	MOVLW       7
	SUBWF       SSD1306_PutC_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_PutC95
;SSD1306OLED.c,756 :: 		if(line & 0x01)
	BTFSS       SSD1306_PutC_line_L0+0, 0 
	GOTO        L_SSD1306_PutC97
;SSD1306OLED.c,757 :: 		SSD1306_Color = true;
	MOVLW       1
	MOVWF       _SSD1306_Color+0 
	GOTO        L_SSD1306_PutC98
L_SSD1306_PutC97:
;SSD1306OLED.c,759 :: 		SSD1306_Color = false;
	CLRF        _SSD1306_Color+0 
L_SSD1306_PutC98:
;SSD1306OLED.c,760 :: 		if(text_size == 1) SSD1306_DrawPixel(x_pos + i, y_pos + j);
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_PutC99
	MOVF        SSD1306_PutC_i_L0+0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_PutC_j_L0+0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
	GOTO        L_SSD1306_PutC100
L_SSD1306_PutC99:
;SSD1306OLED.c,761 :: 		else               SSD1306_FillRect(x_pos + (i * text_size), y_pos + (j * text_size), text_size, text_size);
	MOVF        SSD1306_PutC_i_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_SSD1306_FillRect_x+0 
	MOVF        SSD1306_PutC_j_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_SSD1306_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_SSD1306_FillRect_w+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_SSD1306_FillRect_h+0 
	CALL        _SSD1306_FillRect+0, 0
L_SSD1306_PutC100:
;SSD1306OLED.c,755 :: 		for(j = 0; j < 7; j++, line >>= 1) {
	INCF        SSD1306_PutC_j_L0+0, 1 
	RRCF        SSD1306_PutC_line_L0+0, 1 
	BCF         SSD1306_PutC_line_L0+0, 7 
;SSD1306OLED.c,762 :: 		}
	GOTO        L_SSD1306_PutC94
L_SSD1306_PutC95:
;SSD1306OLED.c,752 :: 		for(i = 0; i < 5; i++ ) {
	INCF        SSD1306_PutC_i_L0+0, 1 
;SSD1306OLED.c,763 :: 		}
	GOTO        L_SSD1306_PutC91
L_SSD1306_PutC92:
;SSD1306OLED.c,765 :: 		SSD1306_Color = false;
	CLRF        _SSD1306_Color+0 
;SSD1306OLED.c,766 :: 		SSD1306_FillRect(x_pos + (5 * text_size), y_pos, text_size, 7 * text_size);
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_SSD1306_FillRect_x+0 
	MOVF        _y_pos+0, 0 
	MOVWF       FARG_SSD1306_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_SSD1306_FillRect_w+0 
	MOVLW       7
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_SSD1306_FillRect_h+0 
	CALL        _SSD1306_FillRect+0, 0
;SSD1306OLED.c,768 :: 		x_pos += text_size * 6;
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 1 
;SSD1306OLED.c,769 :: 		if (wrap && (x_pos + (text_size * 5)) >= SSD1306_LCDWIDTH)
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_PutC103
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        _x_pos+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_PutC211
	MOVLW       128
	SUBWF       R2, 0 
L__SSD1306_PutC211:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_PutC103
L__SSD1306_PutC138:
;SSD1306OLED.c,771 :: 		x_pos = 0;
	CLRF        _x_pos+0 
;SSD1306OLED.c,772 :: 		y_pos += text_size * 8;
	MOVF        _text_size+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       _y_pos+0 
;SSD1306OLED.c,773 :: 		if((y_pos + text_size * 7) >= SSD1306_LCDHEIGHT)
	MOVLW       7
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_PutC212
	MOVLW       64
	SUBWF       R2, 0 
L__SSD1306_PutC212:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_PutC104
;SSD1306OLED.c,774 :: 		y_pos = 0;
	CLRF        _y_pos+0 
L_SSD1306_PutC104:
;SSD1306OLED.c,775 :: 		}
L_SSD1306_PutC103:
;SSD1306OLED.c,776 :: 		}
L_end_SSD1306_PutC:
	RETURN      0
; end of _SSD1306_PutC

_SSD1306_Print:

;SSD1306OLED.c,779 :: 		void SSD1306_Print(char *s) {
;SSD1306OLED.c,780 :: 		uint8_t i = 0;
	CLRF        SSD1306_Print_i_L0+0 
;SSD1306OLED.c,781 :: 		while (s[i] != '\0'){
L_SSD1306_Print105:
	MOVF        SSD1306_Print_i_L0+0, 0 
	ADDWF       FARG_SSD1306_Print_s+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_SSD1306_Print_s+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_Print106
;SSD1306OLED.c,782 :: 		if (s[i] == ' ' && x_pos == 0 && wrap)
	MOVF        SSD1306_Print_i_L0+0, 0 
	ADDWF       FARG_SSD1306_Print_s+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_SSD1306_Print_s+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_Print109
	MOVF        _x_pos+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_Print109
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_Print109
L__SSD1306_Print141:
;SSD1306OLED.c,783 :: 		i++;
	INCF        SSD1306_Print_i_L0+0, 1 
	GOTO        L_SSD1306_Print110
L_SSD1306_Print109:
;SSD1306OLED.c,785 :: 		SSD1306_PutC(s[i++]);
	MOVF        SSD1306_Print_i_L0+0, 0 
	ADDWF       FARG_SSD1306_Print_s+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_SSD1306_Print_s+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SSD1306_PutC_c+0 
	CALL        _SSD1306_PutC+0, 0
	INCF        SSD1306_Print_i_L0+0, 1 
L_SSD1306_Print110:
;SSD1306OLED.c,786 :: 		}
	GOTO        L_SSD1306_Print105
L_SSD1306_Print106:
;SSD1306OLED.c,787 :: 		}
L_end_SSD1306_Print:
	RETURN      0
; end of _SSD1306_Print

_SSD1306_PutCustomC:

;SSD1306OLED.c,790 :: 		void SSD1306_PutCustomC(const uint8_t *c) {
;SSD1306OLED.c,793 :: 		for(i = 0; i < 5; i++ ) {
	CLRF        SSD1306_PutCustomC_i_L0+0 
L_SSD1306_PutCustomC111:
	MOVLW       5
	SUBWF       SSD1306_PutCustomC_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_PutCustomC112
;SSD1306OLED.c,794 :: 		line = c[i];
	MOVF        SSD1306_PutCustomC_i_L0+0, 0 
	ADDWF       FARG_SSD1306_PutCustomC_c+0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       0
	ADDWFC      FARG_SSD1306_PutCustomC_c+1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_PutCustomC_c+2, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, SSD1306_PutCustomC_line_L0+0
;SSD1306OLED.c,796 :: 		for(j = 0; j < 7; j++, line >>= 1) {
	CLRF        SSD1306_PutCustomC_j_L0+0 
L_SSD1306_PutCustomC114:
	MOVLW       7
	SUBWF       SSD1306_PutCustomC_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_PutCustomC115
;SSD1306OLED.c,797 :: 		if(line & 0x01)
	BTFSS       SSD1306_PutCustomC_line_L0+0, 0 
	GOTO        L_SSD1306_PutCustomC117
;SSD1306OLED.c,798 :: 		SSD1306_Color = 1;
	MOVLW       1
	MOVWF       _SSD1306_Color+0 
	GOTO        L_SSD1306_PutCustomC118
L_SSD1306_PutCustomC117:
;SSD1306OLED.c,800 :: 		SSD1306_Color = 0;
	CLRF        _SSD1306_Color+0 
L_SSD1306_PutCustomC118:
;SSD1306OLED.c,801 :: 		if(text_size == 1) SSD1306_DrawPixel(x_pos + i, y_pos + j);
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SSD1306_PutCustomC119
	MOVF        SSD1306_PutCustomC_i_L0+0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVF        SSD1306_PutCustomC_j_L0+0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	CALL        _SSD1306_DrawPixel+0, 0
	GOTO        L_SSD1306_PutCustomC120
L_SSD1306_PutCustomC119:
;SSD1306OLED.c,802 :: 		else               SSD1306_FillRect(x_pos + (i * text_size), y_pos + (j * text_size), text_size, text_size);
	MOVF        SSD1306_PutCustomC_i_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_SSD1306_FillRect_x+0 
	MOVF        SSD1306_PutCustomC_j_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_SSD1306_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_SSD1306_FillRect_w+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_SSD1306_FillRect_h+0 
	CALL        _SSD1306_FillRect+0, 0
L_SSD1306_PutCustomC120:
;SSD1306OLED.c,796 :: 		for(j = 0; j < 7; j++, line >>= 1) {
	INCF        SSD1306_PutCustomC_j_L0+0, 1 
	RRCF        SSD1306_PutCustomC_line_L0+0, 1 
	BCF         SSD1306_PutCustomC_line_L0+0, 7 
;SSD1306OLED.c,803 :: 		}
	GOTO        L_SSD1306_PutCustomC114
L_SSD1306_PutCustomC115:
;SSD1306OLED.c,793 :: 		for(i = 0; i < 5; i++ ) {
	INCF        SSD1306_PutCustomC_i_L0+0, 1 
;SSD1306OLED.c,804 :: 		}
	GOTO        L_SSD1306_PutCustomC111
L_SSD1306_PutCustomC112:
;SSD1306OLED.c,806 :: 		x_pos += (text_size * 6);
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 1 
;SSD1306OLED.c,807 :: 		if (wrap && (x_pos + (text_size * 5)) >= SSD1306_LCDWIDTH)
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_PutCustomC123
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        _x_pos+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_PutCustomC215
	MOVLW       128
	SUBWF       R2, 0 
L__SSD1306_PutCustomC215:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_PutCustomC123
L__SSD1306_PutCustomC142:
;SSD1306OLED.c,809 :: 		x_pos = 0;
	CLRF        _x_pos+0 
;SSD1306OLED.c,810 :: 		y_pos += text_size * 8;
	MOVF        _text_size+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       _y_pos+0 
;SSD1306OLED.c,811 :: 		if((y_pos + text_size * 7) >= SSD1306_LCDHEIGHT)
	MOVLW       7
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_PutCustomC216
	MOVLW       64
	SUBWF       R2, 0 
L__SSD1306_PutCustomC216:
	BTFSS       STATUS+0, 0 
	GOTO        L_SSD1306_PutCustomC124
;SSD1306OLED.c,812 :: 		y_pos = 0;
	CLRF        _y_pos+0 
L_SSD1306_PutCustomC124:
;SSD1306OLED.c,813 :: 		}
L_SSD1306_PutCustomC123:
;SSD1306OLED.c,814 :: 		}
L_end_SSD1306_PutCustomC:
	RETURN      0
; end of _SSD1306_PutCustomC

_SSD1306_DrawBMP:

;SSD1306OLED.c,817 :: 		void SSD1306_DrawBMP(uint8_t x, uint8_t y, const uint8_t *bitmap, uint8_t w, uint8_t h)
;SSD1306OLED.c,821 :: 		for (j = 0; j < h/8; j++) {
	CLRF        SSD1306_DrawBMP_j_L0+0 
	CLRF        SSD1306_DrawBMP_j_L0+1 
L_SSD1306_DrawBMP125:
	MOVF        FARG_SSD1306_DrawBMP_h+0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVLW       0
	SUBWF       SSD1306_DrawBMP_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SSD1306_DrawBMP218
	MOVF        R1, 0 
	SUBWF       SSD1306_DrawBMP_j_L0+0, 0 
L__SSD1306_DrawBMP218:
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawBMP126
;SSD1306OLED.c,822 :: 		for(i = 0; i < w; i++)   {
	CLRF        SSD1306_DrawBMP_i_L0+0 
L_SSD1306_DrawBMP128:
	MOVF        FARG_SSD1306_DrawBMP_w+0, 0 
	SUBWF       SSD1306_DrawBMP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawBMP129
;SSD1306OLED.c,823 :: 		for(k = 0; k < 8; k++)  {
	CLRF        SSD1306_DrawBMP_k_L0+0 
L_SSD1306_DrawBMP131:
	MOVLW       8
	SUBWF       SSD1306_DrawBMP_k_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SSD1306_DrawBMP132
;SSD1306OLED.c,824 :: 		if( bitmap[i + j*w] & 1 << k)
	MOVF        SSD1306_DrawBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        SSD1306_DrawBMP_j_L0+1, 0 
	MOVWF       R1 
	MOVF        FARG_SSD1306_DrawBMP_w+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        SSD1306_DrawBMP_i_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_SSD1306_DrawBMP_bitmap+0, 0 
	MOVWF       TBLPTR+0 
	MOVF        R1, 0 
	ADDWFC      FARG_SSD1306_DrawBMP_bitmap+1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      FARG_SSD1306_DrawBMP_bitmap+2, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	MOVF        SSD1306_DrawBMP_k_L0+0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__SSD1306_DrawBMP219:
	BZ          L__SSD1306_DrawBMP220
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__SSD1306_DrawBMP219
L__SSD1306_DrawBMP220:
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SSD1306_DrawBMP134
;SSD1306OLED.c,825 :: 		SSD1306_Color = true;
	MOVLW       1
	MOVWF       _SSD1306_Color+0 
	GOTO        L_SSD1306_DrawBMP135
L_SSD1306_DrawBMP134:
;SSD1306OLED.c,827 :: 		SSD1306_Color = false;
	CLRF        _SSD1306_Color+0 
L_SSD1306_DrawBMP135:
;SSD1306OLED.c,828 :: 		SSD1306_DrawPixel(x + i, y + j*8 + k);
	MOVF        SSD1306_DrawBMP_i_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawBMP_x+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_x+0 
	MOVLW       3
	MOVWF       R1 
	MOVF        SSD1306_DrawBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__SSD1306_DrawBMP221:
	BZ          L__SSD1306_DrawBMP222
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__SSD1306_DrawBMP221
L__SSD1306_DrawBMP222:
	MOVF        R0, 0 
	ADDWF       FARG_SSD1306_DrawBMP_y+0, 0 
	MOVWF       FARG_SSD1306_DrawPixel_y+0 
	MOVF        SSD1306_DrawBMP_k_L0+0, 0 
	ADDWF       FARG_SSD1306_DrawPixel_y+0, 1 
	CALL        _SSD1306_DrawPixel+0, 0
;SSD1306OLED.c,823 :: 		for(k = 0; k < 8; k++)  {
	INCF        SSD1306_DrawBMP_k_L0+0, 1 
;SSD1306OLED.c,829 :: 		}
	GOTO        L_SSD1306_DrawBMP131
L_SSD1306_DrawBMP132:
;SSD1306OLED.c,822 :: 		for(i = 0; i < w; i++)   {
	INCF        SSD1306_DrawBMP_i_L0+0, 1 
;SSD1306OLED.c,830 :: 		}
	GOTO        L_SSD1306_DrawBMP128
L_SSD1306_DrawBMP129:
;SSD1306OLED.c,821 :: 		for (j = 0; j < h/8; j++) {
	INFSNZ      SSD1306_DrawBMP_j_L0+0, 1 
	INCF        SSD1306_DrawBMP_j_L0+1, 1 
;SSD1306OLED.c,831 :: 		}
	GOTO        L_SSD1306_DrawBMP125
L_SSD1306_DrawBMP126:
;SSD1306OLED.c,832 :: 		}
L_end_SSD1306_DrawBMP:
	RETURN      0
; end of _SSD1306_DrawBMP
