/** @file 	stdio.h
 *	@brief	Header in C standard library to define functions for I/O
 *	
 *	Header in C standard library that define functions for I/O
 *  BASED ON:
 * 	https://brainbox.cc/stash/projects/RR/repos/retrorocket
 *
 *	@author		Bernardo Simoes Lage Gomes Duarte (bernardolageduarte@gmail.com)
 *	@author		Decio Lauro Soares (deciolauro@gmail.com)
 *	@author		Giovani Ortolani Barbosa (giovani.barbosa@usp.br)
 *	@author		Jhonathan Roberto Viudes (jhonathan.viudes@gmail.com)
 *	@date		2016
 *	@bug		--
 *	@warning	--
 * 	@copyright	GNU Public License v3
 */
#ifndef __STDIO_H__
#define __STDIO_H__
#include "stdarg.h"
#include "stdint.h"
#include <tty/vga.h>

___ATTRIB_FORMAT__(1, 2) extern int printf(const char *, ...);
___ATTRIB_FORMAT__(1, 2) extern int printrf(const char *fmt, ...);
___ATTRIB_FORMAT__(2, 3) extern int printcf(uint32_t color, const char *fmt, ...);
___ATTRIB_FORMAT__(2, 3) extern int sprintf(char *str, const char *format, ...);
___ATTRIB_FORMAT__(3, 4) extern int snprintf(char *str, size_t size, const char *format, ...);

extern int vsprintf(char *str, const char *format, va_list ap);
extern int vsnprintf(char *str, size_t size, const char *format, va_list ap);

extern int putc(int c);

#endif
