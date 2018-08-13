
ENTRY(_start)

SECTIONS{
	. = 0;
	.text  : { boot.o(.text) }
	.kloader : { kloader.o(.text)}
	.data  : { boot.o(.data) }
	.bss   : { boot.o(.bss) }

	/* gap to boot signature*/
	. = 510;
	.bootsig  : { boot.o(.bootsig) }
	. = 1024;
}
