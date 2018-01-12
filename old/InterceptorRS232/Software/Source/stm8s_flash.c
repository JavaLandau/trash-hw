#include "bits_operations.h"
#include "stm8_types.h"

/*Register map*/
#define FLASH_CR1     (((volatile char*)(0x00505A)))
#define FLASH_CR2     (((volatile char*)(0x00505B)))
#define FLASH_NCR2    (((volatile char*)(0x00505C)))
#define FLASH_FPR     (((volatile char*)(0x00505D)))
#define FLASH_NFPR    (((volatile char*)(0x00505E)))
#define FLASH_IAPSR   (((volatile char*)(0x00505F)))
#define FLASH_PUKR    (((volatile char*)(0x005062)))
#define FLASH_DUKR    (((volatile char*)(0x005064)))

/*Register's bits values*/
#define OPT	   7
#define WPRG  	   6
#define ERASE  	   5
#define FPRG  	   4
#define PRG  	   0

#define NOPT	   7
#define NWPRG  	   6
#define NERASE  	   5
#define NFPRG  	   4
#define NPRG  	   0

#define HVOFF          6
#define DUL            3
#define EOP            2
#define PUL            1
#define WR_PG_DIS      0

#define FIRST_HWR_KEY  0xAE
#define SECOND_HWR_KEY 0x56

uint8_res stm8s_Flash_OptionBytesEnable(void)
{
  //Write MASS key for unlocked EEPROM area
  CHANGE_REG(FLASH_DUKR,FIRST_HWR_KEY);
  CHANGE_REG(FLASH_DUKR,SECOND_HWR_KEY);
  
  //Check unlocked status
  if(GET_REG_BIT(FLASH_IAPSR,DUL) == RESET)
    return FUNC_ERROR;
  
  //Enable option bytes for flash wait
  SET_REG_BIT(FLASH_CR2,OPT);
  RESET_REG_BIT(FLASH_NCR2,NOPT);

  if(GET_REG_BIT(FLASH_CR2,OPT) != SET || 
     GET_REG_BIT(FLASH_NCR2,NOPT) != RESET)
  {
    return FUNC_ERROR;
  }

  return FUNC_OK;
}

uint8_res stm8s_Flash_OptionBytesDisable(void)
{
  RESET_REG_BIT(FLASH_CR2,OPT);
  SET_REG_BIT(FLASH_NCR2,NOPT);

  if(GET_REG_BIT(FLASH_CR2,OPT) != RESET || 
     GET_REG_BIT(FLASH_NCR2,NOPT) != SET)
  {
    return FUNC_ERROR;
  }

  //Write proteced EEPROM area
  RESET_REG_BIT(FLASH_IAPSR,DUL);

  return FUNC_OK;
}