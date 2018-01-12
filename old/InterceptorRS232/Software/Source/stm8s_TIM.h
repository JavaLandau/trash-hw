#ifndef __STM8S_TIM__
#define __STM8S_TIM__

#include "stm8_types.h"

typedef enum _TIMTypeObj {
  TIM1 = 0x005250,
  TIM2 = 0x005300,
  TIM3 = 0x005320,
  TIM4 = 0x005340
} TIMTypeObj;

typedef struct _TIMType  {
  TIMTypeObj        Instance;  
  HwrIntFunc        FuncCallback;
  void*             UserData;
  unsigned int      Prescaler;
  unsigned int      ARR;
} TIMType;


uint8_res stm8s_TIM_Init(TIMType* TIMDef);
uint8_res stm8s_TIM_Start(TIMType* TIMDef);
uint8_res stm8s_TIM_Stop(TIMType* TIMDef);

void stm8s_TIM1_UpdateInterrupt(void);
void stm8s_TIM2_UpdateInterrupt(void);
void stm8s_TIM3_UpdateInterrupt(void);

#endif