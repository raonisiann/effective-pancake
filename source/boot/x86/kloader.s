
.code16
.section .text
.globl disk_load

disk_load:
	movb $0x0e, %ah
	movb $'H', %al
	int $0x10

	movb $0x1, %al # al <- Sectors to read (count)
	movb $0x2, %ah # ah <- int 0x13 function. 0x02 = 'read'
	movb $0x2, %cl # cl <- sector (0x01 .. 0x11)
	movb $0x0, %ch # ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
	movb $0x80, %dl
	movb $0x0, %dh # dh <- head number (0x0 .. 0xF)

	# where to load? 
	# buffer segment
	movw $0x1000, %bx
	movw %bx, %es
	movw $0x0000, %bx
	# ES:DS
	# 0x1000:0x0000

	int $0x13 # BIOS interrupt
	jc disk_error # if error (stored in the carry bit)
	cmp %dh, %al # BIOS also sets 'al' to the # of sectors read. Compare it.
	jne sectors_error

	movb $'L', %al
	movb $0x0e, %ah
	int $0x10

	movw $0x1000, %ax
	movw %ax, %ds
	
	/* 
	  kernel.s 
	  (0x1000) start_kernel 
	*/
	jmp %ds:(%bx)

sectors_error:
	movb $'E', %al
	movb $0x0e, %ah
	int $0x10
	
disk_error:
	movb %ah, %al
	movb $0x0e, %ah
	int $0x10

infinity_loop:
	nop
	jmp infinity_loop
