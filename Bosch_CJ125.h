
//Define CJ125 registers used
#define  CJ125_IDENT_REG_REQUEST             0x4800        /* Identify request, gives revision of the chip. */
#define  CJ125_DIAG_REG_REQUEST              0x7800        /* Dignostic request, gives the current status. */
#define  CJ125_INIT_REG1_REQUEST             0x6C00        /* Requests the first init register. */
#define  CJ125_INIT_REG2_REQUEST             0x7E00        /* Requests the second init register. */
#define  CJ125_INIT_REG1_MODE_CALIBRATE      0x569D        /* Sets the first init register in calibration mode. */
#define  CJ125_INIT_REG1_MODE_NORMAL_V8      0x5688        /* Sets the first init register in operation mode. V=8 amplification. */
#define  CJ125_INIT_REG1_MODE_NORMAL_V17     0x5689        /* Sets the first init register in operation mode. V=17 amplification. */
#define  CJ125_INIT_REG2_RESET_ALL           0x5A40        // Set pin SRESET - ALL SPI registers
#define  CJ125_INIT_REG2_DEFAULT             0x5A00        // Set pin - pump ref. current OFF (LSU 4.2)
#define  CJ125_INIT_REG2_SET_10uA_Ip         0x5A01        // 20uA pump reference current ON (LSU 4.9 only)
#define  CJ125_INIT_REG2_SET_20uA_Ip         0x5A02        // 20uA pump reference current ON (LSU 4.9 only)

#define  CJ125_DIAG_REG_STATUS_OK            0x28FF        /* The response of the diagnostic register when everything is ok. */
#define  CJ125_DIAG_REG_STATUS_NOPOWER       0x2855        /* The response of the diagnostic register when power is low. */
#define  CJ125_DIAG_REG_STATUS_NOSENSOR      0x287F        /* The response of the diagnostic register when no sensor is connected. */
#define  CJ125_INIT_REG1_STATUS_0            0x2888        /* The response of the init register when V=8 amplification is in use. */
#define  CJ125_INIT_REG1_STATUS_1            0x2889        /* The response of the init register when V=17 amplification is in use. */


#define  CJ125_RD_IDENT_CJ125BA_ANS          0x2862   //MEP /* odpoved na 0x4800 kdyz CJ125 komunikuje a je to verze CJ125BA - 0x62 */
#define  CJ125_RD_IDENT_CJ125BB_ANS          0x2863   //MEP /* dtto a je to verze CJ125BB - 0x63 */

//Function for transfering SPI data to the CJ125.
extern u16 CJ125_Write(u16 TX_data);
extern u16 CJ125_Test(void);
extern u16 CJ125_Sensor_Test(void);
extern u16 CJ125_Vbat_check(void);
extern void CJ125_PreHeat_LSU(u8 LSU);
extern u8 CJ125_Ri_Cal(u8 LSU);
//extern i16 CJ125_Calc_IP(float Ua_mV, u8 Amplify);
extern i16 CJ125_Calc_Ip(float Ua_mV, u8 Amplify);
extern i16 Heater_PID_Control(u8 LSU, i16 input,i16 target);

//extern u16 AFR_Lookup(u16 UA_mV);
//extern u16 Get_AFR_LSU49(u16 UA_mV);
//extern u16 Get_AFR(u16 U_mV, u16 *pTab[],char UseRound);