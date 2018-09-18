#include <kernel.h>
#include <ktypes.h>
#include <vga.h>

static inline void init_segments(void){
    // Setup Segments
    __asm__ __volatile__ (
        "movl $0x10, %eax\t\n"
        "movl %eax, %ds\t\n"       
        "movl %eax, %es\t\n"
        "movl %eax, %ss\t\n"
        "movl $0x70000, %eax\t\n"
        "movl %eax, %esp\t\n"
        "movl %esp, %ebp\t\n"
    ); 
    
}


static inline void clear_screen(void){    
    // video buffer
    uint_16 *buffer = (uint_16*)VIDEO_MEM_ADDR;  
    int i, j;
    for(i = 0; i < VIDEO_MAX_ROWS; i++){
        for(j = 0; j < VIDEO_MAX_COLS; j++){
            buffer = (uint_16*)(VIDEO_MEM_ADDR + 0x2 * (i * VIDEO_MAX_COLS + j));
            *(buffer) = (((VGA_BLACK) << 12) | '\0');
        }
    }
    
}

static inline void out_screen_char(const char c, unsigned int row, unsigned int col){
// video buffer
    uint_16 *buffer = (uint_16*)VIDEO_MEM_ADDR;     
    buffer = (uint_16*)(VIDEO_MEM_ADDR + 0x2 * (row * VIDEO_MAX_COLS + col));
    *(buffer) = (((VGA_WHITE|VGA_BLACK) << 12) | c );
}

void out_string(const char *str){
    unsigned x = 0, y = 0, pos = 0;
    while(str[pos] != '\0'){
        out_screen_char(str[pos], x, y);
        pos++;
        y++;
        if(y > VIDEO_MAX_COLS){
            y = 0;
            x++;
        }
    }
}

void kmain(void){

    init_segments();
    
    clear_screen();

    out_screen_char('A', 0, 0);

    out_string("Ok, its working...\0");
    out_string("So... is not to simply.\0");

    for(;;);
  
}
