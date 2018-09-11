

/*
	GDT (Global Descriptor Table) Layout

 -------------------------------------
	0-15  : Segment limit
 	16-31 : Base Address (low)
 -------------------------------------
 	0-7   : Base (middle)
 	8-11  : Type
 	12    : S - Descriptor Type
 	13-14 : DPL - Descriptor privilege level (Ring 0 to 3)
 	15	  : P - Segment is present
 	16-19 : Segment Limit.
 	20	  : AVL - Available for system? (Always set to 0)
	21	  : L - 64-bit code segment
	22    : D/B - Operand Size ( 0 = 16-bit, 1 = 32-bit)
	23	  : G - Granularity ( 0 = 1 byte, 1 = 4 kbyte )
	24-31 : Base Address (high)
 -------------------------------------

	- Segment Limit: Processor put all segment limit
 	  together to form a 20-bit limit address.
 	  To reach 4GB of limit the granularity flag must
 	  be set.

	- Base Address: Define the location of byte 0 of the segment.
	  Processor put together all three base address to form a
	  32-bit value.
	  	* Should be aligned to 16-byte boundaries to maximize performance.

	- Type field: Indicates the segment or gate type.
		* bit 8  : Accessed (A)
		* bit 9  : Write-enable (W)
		* bit 10 : Expansion-direction (E)
		* bit 11 : Code Segment (Set) and Data Segment (Clear)


	- S: Clear for system segment and set for code and data segments.

	- D/B: Peform diferent functions depending on whether the
	  segment descriptor is an executable CS, and expand-down DS,
	  or a SS. Always set to 1 to 32-bit CS and DS, and 0 to
	  16-bit CS and DS.

	- G: Determines the scaling of the segment limit field.
	  When flag is set the segment limit is interpreted in 4 KB units.
	  When flag is not set the segment limit is interpreted in byte units.
	  	* This flag does not affect base address. It is always byte granular.

	- L: Set to indicates that CS contains native 64-bit code.
*/

#define I_ASM_H

#define GDT_ADDRESS					0x80000
#define GDT_ENTRIES					3
#define GDT_SIZE					(8 * GDT_ENTRIES)

#define GDT_FLAG_ACCESSED			0x1
#define GDT_FLAG_WRITE				0x2
#define GDT_FLAG_DC					0x4
#define GDT_FLAG_TYPE_CS			0x8
#define GDT_FLAG_TYPE_DS			0x0	 	// Symbolic... not used
#define GDT_FLAG_SYSTEM_CODE		0x10
#define GDT_FLAG_DPL_0				0x0 	// Symbolic... not used
#define GDT_FLAG_DPL_1				0x20
#define GDT_FLAG_DPL_2				0x40
#define GDT_FLAG_DPL_3				0x60
#define GDT_FLAG_PRESENT			0x80
#define GDT_FLAG_AVL				0x100
#define GDT_FLAG_LONG				0x200
#define GDT_FLAG_DB					0x400
#define GDT_FLAG_GRANULARITY		0x800

#define _RAW_GDT_ENTRY(limit, base, flags) \
	.word ((limit) & 0xffff), ((base) & 0xffff); \
	.byte ((base) >> 24); \
	.byte ((flags) & 0xff); \
	.byte (((flags) & 0xf00) >> 4) | (limit >> 16); \
	.byte (((base) >> 16) & 0xff) \


#define GDT_ENTRY(limit, base, flags) \
	_RAW_GDT_ENTRY(limit, base, (flags | \
			GDT_FLAG_DC | \
			GDT_FLAG_GRANULARITY | \
			GDT_FLAG_DB | \
			GDT_FLAG_PRESENT | \
			GDT_FLAG_SYSTEM_CODE \
		))

#define GDT_ENTRY_NULL \
		.word 0x0, 0x0; \
		.byte 0x0, 0x0, 0x0, 0x0
