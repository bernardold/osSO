#ifndef __VGA_TERMINAL_H__
#define __VGA_TERMINAL_H__
#include <stdbool.h>
#include <stdint.h>

/* Hardware text mode color constants. */
enum vga_colors
{
	COLOR_BLACK         = 0,
	COLOR_BLUE          = 1,
	COLOR_GREEN         = 2,
	COLOR_CYAN          = 3,
	COLOR_RED           = 4,
	COLOR_MAGENTA       = 5,
	COLOR_BROWN         = 6,
	COLOR_LIGHT_GREY    = 7,
	COLOR_DARK_GREY     = 8,
	COLOR_LIGHT_BLUE    = 9,
	COLOR_LIGHT_GREEN   = 10,
	COLOR_LIGHT_CYAN    = 11,
	COLOR_LIGHT_RED     = 12,
	COLOR_LIGHT_MAGENTA = 13,
	COLOR_LIGHT_BROWN   = 14,
	COLOR_WHITE         = 15
};

typedef uint8_t vga_color_t;

/* Redraw/initialize the terminal */
#define VGAClear VGAInitialize

/* External functions */
extern void VGAWriteNString(const char *str, size_t len, vga_color_t color);
extern void VGAWriteRNString(const char *str, size_t len);
extern void VGAWriteRString(const char *str);
extern void VGAWriteString(const char* str, vga_color_t color);
extern void VGAInitialize(void);
extern void VGAPutc(char c, vga_color_t color);
extern void VGARedraw(void);
extern void VGABackground(vga_color_t color);

/* set in the upper bits of the character.
 * 0xFBCC - FB = foreground and Background; CC = ascii character
 */
#define VGAColor(fg, bg) ((fg << 4) | (bg & 0x0F))
inline vga_color_t vga_color(uint8_t fg, uint8_t bg) { return (fg << 4) | (bg & 0x0F); }

#endif
