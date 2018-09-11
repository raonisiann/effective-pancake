
.code16
.section .text
.globl load_kernel
.extern switch_protectedm

load_kernel:
	movb $0x0e, %ah
	movb $'1', %al
	int $0x10

/*
	Read a sector from disk.
	ah: 0x13, read function.
	al: 0x1, number of sectors to read (count)
	ch: 0x0, cylinder (0x0 to 3ff)
	cl: 0x2, sector (0x1 is the boot sector)
	dh: 0x0, head number (0x0 to 0xf
	dl: 0x80, disk number (hd1 is 0x80, hd2 is 0x81)
*/
	movb $0x2, %ah
	movb $0x1, %al
	movb $0x0, %ch
	movb $0x2, %cl
	movb $0x0, %dh
	movb $0x80, %dl

/*
	Lets put our kernel in 0x10000.
	Address = (0x7C00 * 0x10) + 0x10000
*/
	movw $0x10000, %bx

	int $0x13

	jc disk_error # if error (stored in the carry bit)

	movb $'K', %al
	movb $0x0e, %ah
	int $0x10

/* Jump to switch_protectedm in protectedm.S file */
	jmp switch_protectedm

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
