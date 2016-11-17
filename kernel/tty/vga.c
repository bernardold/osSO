/** @file 	vga.c
 *	@brief	Driver VGA to write memory mapped characters
 *	
 *	Driver VGA to write memory mapped characters
 *	BASED ON:
 *	brainbox.cc/stash/projects/RR/repos/retrorocket/
 *
 *	@author		Bernardo Simoes Lage Gomes Duarte (bernardolageduarte@gmail.com)
 *	@author		Decio Lauro Soares (deciolauro@gmail.com)
 *	@author		Giovani Ortolani Barbosa (giovani.barbosa@usp.br)
 *	@author		Jhonathan Roberto Viudes (jhonathan.viudes@gmail.com)
 *	@date		2016
 *	@bug		Occasional bugs while using backspace key
 *	@warning	--
 * 	@copyright	GNU Public License v3
 */
#include <string.h>
#include "vga.h"
#include <lib/common.h>
#include <ctype.h>

/* Pointer to constant video memory address */
static uint16_t *vidmem = (uint16_t *) 0xB8000;

/* Global string printing driver interfaces */
extern void (*print_color)(const char *, size_t len, vga_color_t color);
extern void (*print_rainbow)(const char *str, size_t len);
extern void (*putch)(const char c, vga_color_t color);

/* Rows and Columns in the terminal */
uint8_t row;
uint8_t column;

/* Standard definition for all VGA terminals */
#define VGA_WIDTH 80
#define VGA_HEIGHT 24

/* Buffer to allow redraws */
uint16_t buffer[VGA_HEIGHT * VGA_WIDTH];

/* black-background and white-foreground space character */
const uint16_t blank = ((VGAColor(COLOR_BLACK, COLOR_WHITE) << 8) | ' ');

/* Scrolls one line. */
static void _vgaScroll(void)
{
	/* Reached the end (25) and need to scroll up */
	if(row >= (VGA_HEIGHT+1))
	{
		/* Adjusts the buffer to move the text*/
		int i;
		for (i = 0; i < (VGA_HEIGHT * VGA_WIDTH); i++)
		{
			vidmem[i] = vidmem[i+VGA_WIDTH];
		}
		
		/* Write spaces on last line to make it look blank */
		for (i = (VGA_HEIGHT * VGA_WIDTH); i < ((VGA_HEIGHT+1) * VGA_WIDTH); i++)
		{
			vidmem[i] = blank;
		}
		/* Put cursor on the last line.*/
		row = 24;
	}
}

/* Updates the hardware cursor. */
static void _vgaMoveCursor(void)
{
	uint16_t cursorLocation = row * VGA_WIDTH + column;
	outb(0x3D4, 14); // Tell the VGA board we are setting the high cursor byte.
	outb(0x3D5, cursorLocation >> 8); // Send the high cursor byte.
	outb(0x3D4, 15); // Tell the VGA board we are setting the low cursor byte.
	outb(0x3D5, cursorLocation); // Send the low cursor byte.
}

/* Put a char and scroll if needed */
void VGAPutc(char c, vga_color_t color)
{
	uint16_t *location;

	/* Adjust backspace, it bugs sometimes */
	if (c == 0x08 && column)
		column--;
	/* Tab */
	else if (c == 0x09)
		column = (column+8) & ~(8-1);
	/* Carriage return */
	else if (c == '\r')
		column = 0;
	/* Newline */
	else if (c == '\n')
	{
		column = 0;
		row++;
	}
	/* Anything else */
	else if(isprint(c))
	{
		location = vidmem + (row * VGA_WIDTH + column);
		*location = c | (color << 8);
		column++;
	}
	if (column >= VGA_WIDTH)
	{
		column = 0;
		row++;
	}
	
	_vgaScroll();
	_vgaMoveCursor();
}

/* Write a null-terminated string */
void VGAWriteString(const char* str, vga_color_t color) { VGAWriteNString(str, strlen(str), color); }

/* Write a string with a specific length */
void VGAWriteNString(const char *str, size_t len, vga_color_t color)
{
	for (size_t i = 0; i < len; ++i)
		VGAPutc(str[i], color);
}

/* Cosmetic colors for strings */
void VGAWriteRNString(const char *str, size_t len)
{
	for (size_t i = 0; i < len; ++i)
	{
		size_t co = i % COLOR_WHITE;
		if (co == COLOR_BLACK)
			co++;
		if (str[i] >= ' ')
			VGAPutc(str[i], VGAColor(COLOR_BLACK, (vga_color_t)co));
		else
			VGAPutc(str[i], VGAColor(COLOR_BLACK, VGAColor(COLOR_BLACK, COLOR_WHITE)));
	}
}

void VGAWriteRString(const char *str) { VGAWriteRNString(str, strlen(str)); }

/* Initialize the VGA console */
void VGAInitialize(void)
{
	static uint8_t initialized = 0;
	row = column = 0;
	
	for (size_t i = 0; i < (VGA_HEIGHT * VGA_WIDTH); ++i)
		vidmem[i] = blank;

	memset(&buffer, 0, VGA_HEIGHT * VGA_WIDTH);
	
	if (initialized == 0)
	{
		VGAWriteString("Initialized VGA console.\n", VGAColor(COLOR_BLACK, COLOR_WHITE));
		print_color = VGAWriteNString;
		print_rainbow = VGAWriteRNString;
		putch = VGAPutc;
		initialized = 1;
	}
}

/* Redraw the console. */
void VGARedraw(void)
{
	memset(vidmem, blank, VGA_HEIGHT * VGA_WIDTH);

	for (size_t i = 0; i < (VGA_HEIGHT * VGA_WIDTH); ++i)
		vidmem[i] = buffer[i];
	_vgaMoveCursor();
}

/* Change the background and foreground color of all the text. */
void VGABackground(vga_color_t color)
{
	for (int i = 0; i < (VGA_HEIGHT * VGA_WIDTH); i++)
	{
		uint8_t ch = vidmem[i] & 0xFF;
		vidmem[i] = ch | (color << 8);
	}
}
