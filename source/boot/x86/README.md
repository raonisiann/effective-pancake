
# x86 Boot

## Loading steps

1. boot
  * Initialize segments
2. kloader
  * Load kernel source/kernel/kmain file at 0x10000
3. protectedm
  * Switch to protected mode
  * Jump to kernel
4. Start of kernel code (kmain)
  * File at kernel/kmain.c
