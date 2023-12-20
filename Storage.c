#include "resource.h"


void FLASH_64Words(u16 Flash_Adr, u16 Buf[]) { // ulozi od adresy Flash_Adr pole 64 wordu z pBuf
  u16 *p32Buf = &Buf[32];   // pointere na pulku pole (protoze FLASH_Write zapisuje po bytech)

//  for (i=0; i<32; i++) { Offset_Flash_Buf64[i] = i+800; }
  FLASH_Erase_Write_64(Flash_Adr, Buf);      // zapise 64bytes = 32 U16 od 0-31
  FLASH_Erase_Write_64(Flash_Adr+64,p32Buf);   // druha pulka bufferu 32-63
}

// ==============================================================================
void EEPROM_Write_Constant(u16 Adr,EEprom Cal_Data) {
     u8 i=0;
    /* //1 . SN - 1xU16, 2. HW_ver - 1xU8, 3. HW_name - 7x CHAR, 4. LSU_Type 1x U8
     5. MAP_type 1xU8 6. SPARE 2xU8    */
 // 1. SN - U16
  /*  EEPROM_Write(EE_SN_Adr, Cal_Data.SN>>8);     // MSB
    EEPROM_Write(EE_SN_Adr+0x01, Cal_Data.SN);   // LSB
 // 2. HW_ver - U8
    EEPROM_Write(EE_HWVer_Adr, Cal_Data.HW_ver);
 // 3. HW_name - max 10znaku
    while (i < 9) {  // ulozime string do EEPROM, max 9 znaku + 10. je null
      EEPROM_Write(EE_HWName_Adr+i, Cal_Data.HW_name[i]);
      i++;
    } //EEPROM_Write(EE_HWName_Adr+9, 0x00);  // piseme null
 // 4. LSU Write - 0x0D - 1xU8 (0-LSU4.2, 1-LSU4.9)
    EEPROM_Write(EE_LSUSel_Adr, Cal_Data.LSU_sel);
 // 5.  - jake menu se zobrazovalo na displeji pred vypnutim 0-x - v cfg modu neukladame, pac tlacitkem menime intenzitu displeje
    if (!ConfigMode) EEPROM_Write(EE_DispSel_Adr, Cal_Data.DisplaySel);
 // 6.  -  intenzita displeje
    EEPROM_Write(EE_DispSel_Adr, Cal_Data.DispIntens);
    */
}
// ==============================================================================
EEprom EEPROM_Read_Constant(u16 Adr) {
    u8 i=0;
    EEprom Cal_Data;

 // 1. SN - adr. 0x00 [1xU16]
    Cal_Data.SN = EEPROM_Read(_SN_ADR);  // MSB
    Cal_Data.SN = Cal_Data.SN << 8;    // prevedeme na 16bit cislo
    Cal_Data.SN = Cal_Data.SN + EEPROM_Read(_SN_ADR+0x01);  // LSB
 // 2. HW_ver - [1xU8]
    Cal_Data.HW_ver = EEPROM_Read(_HWVer_ADR);
 // 3. HW_ver - [1xU8]
    Cal_Data.SW_ver = EEPROM_Read(_SWVer_ADR);
 // 4. HW_ver - [1xU8]
    Cal_Data.OPTION = EEPROM_Read(_OPTION_ADR);
    

  return Cal_Data;
}