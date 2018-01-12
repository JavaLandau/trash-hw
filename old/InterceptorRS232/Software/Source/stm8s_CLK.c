#include "stm8s_OptionBytes.h"
#include "stm8s_flash.h"
#include "stm8s_CLK.h"
#include "bits_operations.h"

/*Register map*/
#define CLK_ICKR     (((volatile char*)(0x0050C0)))
#define CLK_ECKR     (((volatile char*)(0x0050C1)))
#define CLK_CMSR     (((volatile char*)(0x0050C3)))
#define CLK_SWR      (((volatile char*)(0x0050C4)))
#define CLK_SWCR     (((volatile char*)(0x0050C5)))
#define CLK_CKDIVR   (((volatile char*)(0x0050C6)))
#define CLK_PCKENR1  (((volatile char*)(0x0050C7)))
#define CLK_CSSR     (((volatile char*)(0x0050C8)))
#define CLK_CCOR     (((volatile char*)(0x0050C9)))
#define CLK_PCKENR2  (((volatile char*)(0x0050CA)))
#define CLK_CANCCR   (((volatile char*)(0x0050CB)))
#define CLK_HSITRIMR (((volatile char*)(0x0050CC)))
#define CLK_SWIMCCR  (((volatile char*)(0x0050CD)))

/*Register's bits values*/
#define HSIEN	 0
#define HSIRDY  	 1
#define FHWU    	 2
#define LSIEN    	 3
#define LSIRDY    	 4
#define REGAH     	 5

#define HSEEN	 0
#define HSERDY	 1

#define SWBSY	 0
#define SWEN	 1
#define SWIEN	 2
#define SWIF	 3

#define HSI_SELECT	 0xE1
#define LSI_SELECT	 0xD2
#define HSE_SELECT	 0xB4

uint8_res stm8s_CLK_SetHSEMasterClock(void)
{
  uint8_res Res;
  
  //Set HSE master clock source
  CHANGE_REG(CLK_SWR,HSE_SELECT);

  if(GET_REG(CLK_SWR) != HSE_SELECT) 
    return FUNC_ERROR;
    
  // Waiting stabilization oscillator  
  while(!GET_REG_BIT(CLK_SWCR,SWIF))
    _asm("NOP");	
  
  RESET_REG_BIT(CLK_SWCR,SWIF);

  if(GET_REG_BIT(CLK_SWCR,SWIF) != RESET) 
    return FUNC_ERROR;

  //Enable write access for option bytes
  Res = stm8s_Flash_OptionBytesEnable();
  
  if(Res != FUNC_OK)
    return Res;
  
  //Change flash wait for Fclk > 16 MHz
  Res = stm8s_OptionBytes_SetFlashWait(OPT7_WAIT_1);
	
  if(Res != FUNC_OK)
    return Res;          
  
  //Disable write access for option bytes 
  Res = stm8s_Flash_OptionBytesDisable();
  
  if(Res != FUNC_OK)
    return Res;          
         
  //Switch master clock source        
  SET_REG_BIT(CLK_SWCR,SWEN);	
			
  return FUNC_OK;
}