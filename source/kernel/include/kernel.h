#define I_KERNEL_H

#define KERNEL_ADDRESS  0x10000
#define CODE_SEGMENT    0x8
#define DATA_SEGMENT    0x10
#define STACK_SEGMENT   0x10

static inline void init_segments(void);

