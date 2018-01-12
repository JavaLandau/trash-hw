#ifndef __STM8S_GPIO__
#define __STM8S_GPIO__

#include "stm8_types.h"

typedef enum _GPIOMode {
  GPIO_FLOATING_INPUT                = 0x0,
  GPIO_INPUT_WITH_PULLUP             = 0x2,
  GPIO_OUTPUT_PSEUDO_OPEN_DRAIN      = 0x1,
  GPIO_OUTPUT_PUSHPULL               = 0x3
} GPIOMode;

typedef enum _GPIOSpeed {
  GPIO_SPEED_2MHZ                    = 0x0,
  GPIO_SPEED_10MHZ                   = 0x1
} GPIOSpeed;

typedef enum _GPIOPort {
  GPIO_PORT_A                        = 0x00,
  GPIO_PORT_B                        = 0x05,  
  GPIO_PORT_C                        = 0x0A,    
  GPIO_PORT_D                        = 0x0F,      
  GPIO_PORT_E                        = 0x14,      
  GPIO_PORT_F                        = 0x19,      
  GPIO_PORT_G                        = 0x1E,      
  GPIO_PORT_H                        = 0x23,        
  GPIO_PORT_I                        = 0x28
} GPIOPort;

typedef struct _GPIOType {
  GPIOMode          Mode;
  GPIOSpeed         Speed;
  HwrIntFunc        FuncCallback;
  void*             UserData;          
  char              NumPin;
  GPIOPort          NumPort;
} GPIOType;

#define GPIO_OUTPUT_LOW             0
#define GPIO_OUTPUT_HIGH            1

uint8_res stm8s_GPIO_Init(GPIOType* GPIODef);
uint8_res stm8s_GPIO_Set(GPIOPort NumPort, char NumPin, char GPIOValue);

#endif