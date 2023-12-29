                             //128 se zda porad OK - testovano na varici cca 2hodiny, 256 jeste ok, 512 se zda i pri 16Mhz ok
#define AD_AVG_COUNT           8      // delitelne 8, pocet vzorku pro vypocet AVG hodnoty (upravit i deleni/posuv vrpavo nize !!!)
#define AD_AVG_COUNT_FAST      3     // 1~/2, 2~/4, 3~/8, 4~/16, 5~/32, 6~/64, 7~/128, 8~/256, 9~/512

//  definice kanalu AD prevodu
#define MAP_AD_ch              0        // AD channel pro MAP cidlo - AN0 (RA0)
#define UA_AD_ch               1        // AD channel pro UA - AN1 (RA1)
#define UR_AD_ch               2        // AD channel pro UR - AN2 (RA2)
#define Vbat_AD_ch             4        // AD channel pro UB - AN4 (RA5)



extern u16 Get_AD_mV(u8 ch, u16 adc_koef);