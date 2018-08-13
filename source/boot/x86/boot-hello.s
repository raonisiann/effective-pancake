
.code16
.section .text
.globl _start 

_start:
	ljmp $0x07C0, $_init

_init:
	movw %cs, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %ss	

	leaw message, %si	
	jmp print
print:
	lodsb
	andb %al, %al
	je end_of_code
	movb $0x0e, %ah
	int $0x10
	jmp print

end_of_code:
	movb $0x0, %ah
	int $0x16

.section .data
message:
	.ascii "Hello"

.section .bootsig, "a"
        .byte 0x55
        .byte 0xaa


