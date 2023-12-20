

//======================================================================
//=============     PIN OUTPUT/INPUT DECLARE    ======================
//======================================================================

extern sfr sbit BUT0_PIN;     // input button
extern sfr sbit LED1;         // modra (prvni u L2940)
extern sfr sbit LED2;         // zelena (prostredni)
extern sfr sbit LED3;         // cervena
extern sfr sbit CJ125_CS;
extern sfr sbit CJ125_RST;
extern sfr sbit CJ125_Heater;
extern sfr sbit DAC1;   // DAC1 OUT

// Functions
extern void HW_Init();
extern void LED_Welcome();
extern void UART_Welcome(u8 ComNr, EEprom EE_Data);
extern void UART2_BT_Welcome();
extern void CR_LF(u8 i);