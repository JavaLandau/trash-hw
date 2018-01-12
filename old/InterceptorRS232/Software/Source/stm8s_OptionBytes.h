#ifndef __STM8S_OPTIONBYTES__
#define __STM8S_OPTIONBYTES__

#include "stm8_types.h"

#define OPT7_WAIT_0			0
#define OPT7_WAIT_1			1

uint8_res stm8s_OptionBytes_SetFlashWait(char WaitState);

#endif