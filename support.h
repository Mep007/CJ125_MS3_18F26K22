


extern void UART_PrintCh(u8 Nr, char ch);
extern void PrintF1(char *p_string);
extern void HC06_SendByteBuf(u8 *pBuf, u8 BufLen);
extern void UART_PrintTxt(char UART_nr,char *p_string);
extern void PWM_Init_DAC1(u16 mVout);
extern void PWM_Init_DAC2(u16 mVout);
extern u16 DACx_mV_Out_10bit(u8 ch, u16 OutmV);
extern u16 LinFit(i16 X,i16 pTab[], u8 Tab_size);
extern void BT_Send_Data(u16 TxData);
extern u16 TxtToU16(u8 *Buf);  // prevede ASCII cislo max. 9999 na u16
//extern void DACx_mV_Out(u8 ch, u16 mV_Out); //  // nastavi napeti na DAC1 resp. DAC2
//extern u16 LinFit_NB(u16 X_Act,u8 Tab_size);
//extern u16 LinFit_DAC(u16 X_Act,u8 Tab_size);
//extern u16 LinFit42(i16 X_Act, u8 Tab_size);