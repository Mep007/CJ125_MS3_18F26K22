//  adresy a offsety konstant v EEPROM a FLASH
#define FLASH_TAB_ADR      0x0FE00   // adresa ve Flash, odkud je ulozeno 64 (128Bytes) wordu user dat

// EEPROM addresses
#define EEPROM_CONST_ADR    0x00       // adresa v EEPROM, odkud je ulozen blok konstant
#define _SN_ADR             0x00
#define _HWVer_ADR          0x02
#define _SWVer_ADR          0x03
#define _OPTION_ADR         0x04

#define _UART1_LISTING(val)  (val && 0b10000000) // bit 7 = 1 => USE UART1 listing form AFR etc data during run
//AD const
#define ADC_OFFSET_ADR      0x10   //1 byte offset (+/- 127)
#define VBAT_OFFSET_ADR     0x11   //1 byte offset (+/- 127)
#define DAC_OFFSET_ADR      0x12   //1 byte offset (+/- 127)



extern void FLASH_64Words(u16 Flash_Adr, u16 pBuf[]);  // ulozi od adresy Flash_Adr pole 64 wordu
extern void EEPROM_Write_Constant(u16 Adr,EEprom Cal_Data);
extern EEprom EEPROM_Read_Constant(u16 Adr);