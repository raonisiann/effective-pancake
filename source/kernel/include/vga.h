#define I_VGA_H

#define VIDEO_MEM_ADDR 0xB8000
#define VIDEO_MAX_COLS 80
#define VIDEO_MAX_ROWS 25
#define VGA_WHITE 0xf
#define VGA_BLACK 0x0

static inline void clear_screen(void);
static inline void out_screen_char(const char c, unsigned int row, unsigned int col);
void out_string(const char *str);

