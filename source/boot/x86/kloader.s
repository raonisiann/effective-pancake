
.code16
.section .text
.globl disk_load
.globl kmain

disk_load:
	movb $0x0e, %ah
	movb $'1', %al
	int $0x10

	movb $0x2, %ah 		# ah <- Int 0x13 function. 0x02 = 'read
	movb $0x1, %al 		# al <- Number of sectors to read (count)'
	movb $0x0, %ch 		# ch <- Cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
	movb $0x2, %cl 		# cl <- Sector (0x01 .. 0x11)
	movb $0x0, %dh 		# dh <- Head number (0x0 .. 0xF)
	movb $0x80, %dl 	# dl <- Disk number (0x80 = hd1, 0x81 = hd2)

	# where to load? buffer segment	
	movw $0x1000, %bx
	
	int $0x13 # BIOS interrupt

	jc disk_error # if error (stored in the carry bit)
	
	movb $'K', %al
	movb $0x0e, %ah
	int $0x10

	/* 
	  kmain.c
	  $es:0x1000 kmain()
	*/
	jmp 0x1000	

sectors_error:
	movb $'S', %al
	movb $0x0e, %ah
	int $0x10
	jmp wait_keypress
	
disk_error:
	movb $'D', %al
	movb $0x0e, %ah
	int $0x10
	jmp wait_keypress

wait_keypress:
	nop 
	movb $0x0, %ah
	int $0x16

