#include "stm8_types.h"


void stm8s_ITC_InterruptsEnable(void)
{
  _asm("RIM");  
}