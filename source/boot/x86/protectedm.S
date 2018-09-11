#include <asm.h>

.code16
.section .text
.globl switch_protectedm
.extern kmain

switch_protectedm:

	movb $'P', %al
	movb $0x0e, %ah
	int $0x10

/* Disable interrupts */
	cli

/* Reset DS to 0x0000*/
	xorw %ax, %ax
	movw %ax, %ds

 /* move gdt */
	movw $GDT_ADDRESS >> 4, %ax
	movw %ax, %es
	movw $gdt_table, %si
	xorw %di, %di
	movw $GDT_SIZE >> 2, %cx
	rep
	movsl

/* Load GDT */
	lgdt gdt_descriptor

/* Switch to protected mode */
	movl %cr0, %eax	
	orl $0x1, %eax
	movl %eax, %cr0
	
/* Far jump to kmain at kernel/kmain.c */
	ljmpl $0x8, $0x10000

/* Adding 16-bit align */
.p2align 4

gdt_table:
	GDT_ENTRY_NULL
	GDT_ENTRY(0xfffff, 0x00000000, GDT_FLAG_TYPE_CS)
	GDT_ENTRY(0xfffff, 0x00000000, GDT_FLAG_WRITE)

gdt_descriptor:
		.word (gdt_descriptor - gdt_table - 1)
		.long GDT_ADDRESS
