ENTRY(kmain)

SECTIONS{
	/* Kernel must be load at 0x10000 */
	. = 0x10000;
	.text  		: { kmain.o(.text) }
	.data  		: { kmain.o(.data) }
	.bss   		: { kmain.o(.bss) }

	/DISCARD/ 	: { *(.comment .eh_frame .note.GNU-stack) }
}
