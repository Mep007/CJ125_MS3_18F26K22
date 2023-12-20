


typedef struct {
 u8 Stat;        // status prijmu
 char ch;       // aktualne prijaty byte
 u8 UseTermCh;   // spriznak, zda-li se pouziva TermChar > 0 => TRUE else FALSE
 char TermCh;   // znak pro ukonceni prijmu, typ 10 ci 13 (CR,LF)
 u8 UseASCII;   // 1 - ASCII mod, 0 - binary mod
 u16 TIMEOUT;   // hodnota timeoutu pro cekani na Rx data
 u16 TimeCnt;   // counter pro Rx timeut mereni
 u16 CntBuf;    // counter pro Rx buffer
 //u16 pRxBuf[];   // pointer na prijimaci Rx buffer
 u16 BufLen;    // velikost bufferu
} RxUart;
// ==================================================
typedef struct { // pro LED - jestli ma blikat
  u8 Blink_ON;  // 0 - OFF, 1 - BLINK ON, > 1 - Light ON
  u8 Peroid;
} _led;

// ==================================================
typedef struct { // vsechny data, co merime, pocitame
  u8 Cnt;
  u8 _500msFlag;
  u8 _1sFlag;

} _tmr;

typedef struct { // vsechny data, co merime, pocitame
  u8 LED_sel;     // volba LED binarne - 0 - nic, 1 - LED1, 2 - LED2, 4 - LED3 + kombinace
  u8 _ON_time;    // 0 - FF, 1-254 - perioda x10ms, 255 - trvale ON
  u16 _TOTAL_time; // jak dlouho bude dana sekvence plati 0 - neomezene, 1-65535 * 10ms (az 655s)

} _LEDtmr;
// ==================================================
typedef struct { // vsechny data, co merime, pocitame
 u8 i;


} myData;

// ==================================================
typedef struct {    // struktura parametru prikazu pres UART, xxx YYYYYYYY, kde xxx je prikaz o delce 3 znaky, YYYYYY jsou data az 16 znaku
  u16 SN;
  u8 HW_ver;
  u8 SW_ver;
  u8 OPTION;   // b7 - use UART listing during run, b6 ....
 // char HW_name[10];   // max. 9znaku (10. je null)
} EEprom;

// ==================================================
/*
typedef struct {
 u8 Cnt;
 u8 Lcnt;    // counter pro long press po 10ms * 300 = 3000ms
 u8 Press;    // priznak kratkeho stisku -
 u8 Lpress;  // priznak long pressu - staci tento
 u8 Armed;   // priznak, ze je byl stisk a nebyl obslouzen
 u8 Larmed;  // dtto pro long
 u8 Click;     // pocitadlo stisku tlacitka - i pro EEPROM
 u8 MaxClicks; // maximalni pocet stisku pred snulovanim
 u8 CfgMenu;  // index vybraneho menu v CFG modu - po long pressu
} button;
*/