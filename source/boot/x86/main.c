#include "../../lib/std/types.h"

/* The number of GDT entries */
#define NUM_GDT_ENTRIES 3

/* GDT Structs */
struct _gdt_entry {
	u16 limit_low;
	u16 limit_base;
	u8 middle_base;
	u8 access;
	u8 granularity;
	u8 high_base;
};

struct _gdt {
	u16 size;
	u32 *pointer;
} __attribute__ ((packed));

/* Load GDT */
static void load_gdt(void){

	static struct _gdt_entry gdt_table[NUM_GDT_ENTRIES];
	static struct _gdt gdt;

	gdt.size = ((sizeof(struct _gdt_entry) * NUM_GDT_ENTRIES) -1);
	gdt.pointer = &gdt_table; 
	// load GDT using lgdt instruction
	__asm__ __volatile__ ("lgdt %0" : : "m" (gdt));
}

int main(void){
	__asm__ __volatile__ ("movb $'X'  , %al\n");
	__asm__ __volatile__ ("movb $0x0e, %ah\n");
	__asm__ __volatile__ ("int $0x10\n");
}
