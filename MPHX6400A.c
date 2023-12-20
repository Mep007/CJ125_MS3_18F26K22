#include "resource.h"


void MAP_Calc(u16 MAP_mV,u8 type) {  // 1= MPXH6400A, 2=MPXH6300A
 if      (type == 1) MAP = ((float)MAP_mV + 4.2) / 12.105;  // napr 1150mV => 95.35 kPa
 else if (type == 2) MAP = ((float)MAP_mV + 1.765) / 15.9;  // napr 1450mV => cca 95.35 kPa
                                                        // B = 0.01765, A= 0.0159
}