
.code16
.text
.globl start_kernel

start_kernel:

	movb $'V', %al
	movb $0x0e, %ah
	int $0x10

	jmp kernel_loop

kernel_loop:
	nop
	jmp kernel_loop
