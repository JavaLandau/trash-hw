#include "stm8s_CLK.h"
#include "stm8s_GPIO.h"
#include "stm8s_TIM.h"
#include "stm8s_ITC.h"
#include "stm8_types.h"

#define BREAK_LEN_BIT         3200
#define COUNT_LEN             15
#define STANDBY_TRESHOLD      16

//Enum for parity-s values
#define PARITY_NONE           0
#define PARITY_EVEN           1
#define PARITY_ODD            2

//Enum for RecState values
#define REC_BAUDRATE          0
#define REC_SEARCH_STANDBY    1
#define REC_SEARCH_STARTBIT   2
#define REC_SEARCH_MIDDLE     3
#define REC_PROCESS           4

//Enum for status values
#define STATUS_REPLY          0
#define STATUS_INVALID        1
#define STATUS_RELIABLE       2
#define STATUS_FAIL           3
#define STATUS_PROCESS        4

#define UART_LINE_LENGTH      64

//char* ArrayUARTCurrentPointer;

void ErrorHandler(void);

int main()
{
  uint8_res Res;  
  Res = stm8s_CLK_SetHSEMasterClock();  //Set HSE master clock source
  
  if(Res != FUNC_OK)
    return 0;
  
  //char ArrayUARTLine[UART_LINE_LENGTH];
  //ArrayUARTCurrentPointer = ArrayUARTLine;
  
  //Enable interrupt
  stm8s_ITC_InterruptsEnable();

  //Init LED indicator
  {
    GPIOType GPIODef;
    GPIODef.Mode = GPIO_OUTPUT_PUSHPULL;
    GPIODef.Speed = GPIO_SPEED_2MHZ;
    GPIODef.NumPort = GPIO_PORT_D;
    GPIODef.NumPin = 0;
    GPIODef.FuncCallback = NULL;    
    
    Res = stm8s_GPIO_Init(&GPIODef);
        
    if(Res != FUNC_OK)
      return 0;    
  }
  
  //Init TIM2 and TIM3
  TIMType TIMDef;
  TIMDef.Instance = TIM2;
  TIMDef.Prescaler = 0;
  TIMDef.ARR = 52;
  TIMDef.FuncCallback = NULL;
  TIMDef.UserData = NULL;
  Res = stm8s_TIM_Init(&TIMDef);

  if(Res != FUNC_OK)
    ErrorHandler();
  
  Res = stm8s_TIM_Start(&TIMDef);  

  if(Res != FUNC_OK)
    ErrorHandler();

  //Initialization algorithm's variables
  char bits_count = 7;
  char parity = PARITY_EVEN;
  int LenBit  = 1;
  int MinLenBit = BREAK_LEN_BIT;
  

  while (1);
}

void ErrorHandler(void)
{
  while(1)
  {
    unsigned int i;
    stm8s_GPIO_Set(GPIO_PORT_D, 0, GPIO_OUTPUT_HIGH);
    for(i = 0; i < 50000; i++);
  
    stm8s_GPIO_Set(GPIO_PORT_D, 0, GPIO_OUTPUT_LOW);
    for(i = 0; i < 50000; i++);         
  }    
}