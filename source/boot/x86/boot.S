.code16
/* Boot sector section */
.section .text
.extern load_kernel
.globl _start

_start:
/* Make cs: 0x0000, ip: 0x7C00 */
	ljmp $0x0000, $_init

_init:
	movw %cs, %ax
	movw %ax, %ds
	movw %ax, %ss
	movw $0x1000, %ax
	movw %ax, %sp
	movw %ax, %es

	leaw message, %si
	movb $0x0e, %ah
	jmp print

print:
	lodsb
	orb %al, %al
	jz end_of_message
	int $0x10
	jmp print

end_of_message:
	nop
	jmp load_kernel

.section .data
message:
	.asciz "hello brother"

/*
	Boot sector signature
	Will be realocated to 0x1fe
*/
.section .bootsig, "a"
  .byte 0x55
  .byte 0xaa
