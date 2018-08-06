
ENTRY(_start)

SECTIONS{
	. = 0;
	.text  : { *(.text) }
	.data  : { *(.data) }
	.bss   : { *(.bss) }

	/* gap to boot signature*/
	. = 510;
	.bootsig  : { *(.bootsig) }
}
