#include <kernel.h>
#include <ktypes.h>

void kmain(void){
  __asm__ __volatile ("nop");
  __asm__ __volatile ("jmp .");
  
}
