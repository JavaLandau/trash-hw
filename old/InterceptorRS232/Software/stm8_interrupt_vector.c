#include "stm8s_GPIO.h"
#include "stm8s_TIM.h"
#include "stm8s_GPIO.h"
#include "bits_operations.h"

#define PB_IDR     (((volatile char*)(0x005006)))

//extern char* ArrayUARTCurrentPointer;

typedef void @far (*interrupt_handler_t)(void);

struct interrupt_vector {
  unsigned char interrupt_instruction;
  interrupt_handler_t interrupt_handler;
};

@far @interrupt void NonHandledInterrupt (void)
{
  /* in order to detect unexpected events during development, 
     it is recommended to set a breakpoint on the following instruction
  */
  return;
}

@far @interrupt void TLI_IRQHandler (void)
{
  return;
}

@far @interrupt void AWU_IRQHandler (void)
{
  return;
}

@far @interrupt void CLK_IRQHandler (void)
{
  return;
}

@far @interrupt void EXTI0_IRQHandler (void)
{
  return;
}

@far @interrupt void EXTI1_IRQHandler (void)
{
  return;
}

@far @interrupt void EXTI2_IRQHandler (void)
{
  return;
}

@far @interrupt void EXTI3_IRQHandler (void)
{
  return;
}

@far @interrupt void EXTI4_IRQHandler (void)
{
  return;
}

@far @interrupt void beCANRX_IRQHandler (void)
{
  return;
}

@far @interrupt void beCANTX_IRQHandler (void)
{
  return;
}

@far @interrupt void SPI_IRQHandler (void)
{
  return;
}


@far @interrupt void TIM1Update_IRQHandler (void)
{    
  return;
}

@far @interrupt void TIM1Capture_IRQHandler (void)
{
  return;
}

@far @interrupt void TIM2Update_IRQHandler (void)
{
  //*(ArrayUARTCurrentPointer++) =  GET_REG_BIT(PB_IDR,3);
  return;
}

@far @interrupt void TIM2Capture_IRQHandler (void)
{  
  return;
}

@far @interrupt void TIM3Update_IRQHandler (void)
{
  stm8s_TIM3_UpdateInterrupt();
  return;
}

@far @interrupt void TIM3Capture_IRQHandler (void)
{
  return;
}

@far @interrupt void UART1TX_IRQHandler (void)
{
  return;
}

@far @interrupt void UART1RX_IRQHandler (void)
{
  return;
}

@far @interrupt void I2C_IRQHandler (void)
{
  return;
}

@far @interrupt void UART3TX_IRQHandler (void)
{
  return;
}

@far @interrupt void UART3RX_IRQHandler (void)
{
  return;
}

@far @interrupt void ADC2_IRQHandler (void)
{
  return;
}

@far @interrupt void TIM4_IRQHandler (void)
{
  return;
}

@far @interrupt void Flash_IRQHandler (void)
{
  return;
}


extern void _stext();     /* startup routine */

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
	{0x82, NonHandledInterrupt}, /* trap  */
	{0x82, TLI_IRQHandler}, /* irq0  */
	{0x82, AWU_IRQHandler}, /* irq1  */
	{0x82, CLK_IRQHandler}, /* irq2  */
	{0x82, EXTI0_IRQHandler}, /* irq3  */
	{0x82, EXTI1_IRQHandler}, /* irq4  */
	{0x82, EXTI2_IRQHandler}, /* irq5  */
	{0x82, EXTI3_IRQHandler}, /* irq6  */
	{0x82, EXTI4_IRQHandler}, /* irq7  */
	{0x82, beCANRX_IRQHandler}, /* irq8  */
	{0x82, beCANTX_IRQHandler}, /* irq9  */
	{0x82, SPI_IRQHandler}, /* irq10 */
	{0x82, TIM1Update_IRQHandler}, /* irq11 */
	{0x82, TIM1Capture_IRQHandler}, /* irq12 */
	{0x82, TIM2Update_IRQHandler}, /* irq13 */
	{0x82, TIM2Capture_IRQHandler}, /* irq14 */
	{0x82, TIM3Update_IRQHandler}, /* irq15 */
	{0x82, TIM3Capture_IRQHandler}, /* irq16 */
	{0x82, UART1TX_IRQHandler}, /* irq17 */
	{0x82, UART1RX_IRQHandler}, /* irq18 */
	{0x82, I2C_IRQHandler}, /* irq19 */
	{0x82, UART3TX_IRQHandler}, /* irq20 */
	{0x82, UART3RX_IRQHandler}, /* irq21 */
	{0x82, ADC2_IRQHandler}, /* irq22 */
	{0x82, TIM4_IRQHandler}, /* irq23 */
	{0x82, Flash_IRQHandler}, /* irq24 */
	{0x82, NonHandledInterrupt}, /* irq25 */
	{0x82, NonHandledInterrupt}, /* irq26 */
	{0x82, NonHandledInterrupt}, /* irq27 */
	{0x82, NonHandledInterrupt}, /* irq28 */
	{0x82, NonHandledInterrupt}, /* irq29 */
};
