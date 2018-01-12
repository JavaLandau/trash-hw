#ifndef __STM8_TYPES__
#define __STM8_TYPES__

/*Code return of functions*/
#define FUNC_OK                 0
#define FUNC_ERROR              1
#define FUNC_INVALID_PARAM      2
#define FUNC_HEAP_MEM_ERROR     3

/*Boolean values*/
#define FALSE                   0
#define TRUE                    1

/*Value of zeros pointers*/
#define NULL                    0


/*Type redefinition*/
typedef char uint8_res;

/*Types of pointers of functions*/
typedef void (*HwrIntFunc)(void*);


#endif