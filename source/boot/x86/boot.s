.code16
.section .text
.globl kmain
.globl disk_load
.globl _start 

_start:
	ljmp $0x07C0, $_init

_init:
	movw %cs, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %ss	
	
	leaw message, %si
	movb $0x0e, %ah
	jmp print

print:
	lodsb
	orb %al, %al
	jz end_of_code
	int $0x10
	jmp print

end_of_code:
	nop
	jmp disk_load
	

.section .data
message:
	.asciz "hello brother"

.section .bootsig, "a"
        .byte 0x55
        .byte 0xaa


