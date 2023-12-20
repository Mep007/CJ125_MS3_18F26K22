#include "resource.h"




//=============================================================================
u16 Get_AD_mV(u8 ch, u16 adc_koef) {
  u16 Loop_nr;

  U32_tmp = 0; /*U16_tmp=0;*/
  Loop_nr = AD_AVG_COUNT;  /// pocet cyklu pro ziskani AVG
  do {
//    U16_tmp = ADC_Read(ch);
    U32_tmp = U32_tmp + (u32)ADC_Get_Sample(ch);
    Loop_nr--;
  } while (Loop_nr > 0);
//  U32_tmp = U32_tmp / AD_AVG_COUNT;  // avg
  U32_tmp = (u32)U32_tmp >> AD_AVG_COUNT_FAST;  // avg
  ADC_RAW = (u16)U32_tmp;   // jen globalne ulozime vysledek AD RAW prevodu po potreby kalibrace
  U32_tmp = U32_tmp * (u32)adc_koef; //  AD_KOEF=489 pro 5000mV Vref(Vcc) - 10bitAD => 5000/1023= 4.8875
  U32_tmp = (u32)U32_tmp / 100;    // napr 512*489 = 2503(.68) -> presnost na mV/
  return (u16)U32_tmp;
}
 //=============================================================================