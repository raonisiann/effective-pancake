OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS {
	. = 0x7c00;
	.text  		: { *(.text) }	
	.data  		: { *(.data) }
	.bss   		: { *(.bss) }

	/* gap to boot signature +510 bytes from 0x7c00*/
	. = 0x7dfe;
	.bootsig  : { boot.o(.bootsig) }
}
