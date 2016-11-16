#ifndef _VGA_H_
#define _VGA_H_

#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25

#include "stdint.h"

enum color{
    BLACK,
	BLUE,
	GREEN,
	CYAN,
	RED,
	MAGENTA,
	BROWN,
	LIGHT_GREY,
	DARK_GREY,
	LIGHT_BLUE,
	LIGHT_GREEN,
	LIGHT_CYAN,
	LIGHT_RED,
	LIGHT_MAGENTA,
	LIGHT_BROWN,
	WHITE
};
void set_character_color (enum color letterColor, enum color bgColor);
void clear_screen();
void print_character (char letter, enum color letterColor, enum color bgColor);

#endif