/** @file 	string.h
 *	@brief	Header in C standard library to manipulate strings
 *	
 *	Header in C standard library that allows strings manipulation
 *	Following specs, only implemented strlen, strcpy, memcpy and strcmp
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
#ifndef __STRING_H__
#define __STRING_H__
#include "stdint.h"

/* String funcs */
extern size_t strlen(const char*);
extern int strcmp(const char *s1, const char *s2);
extern char *strncpy(char *dest, const char *src, size_t n);
extern char *strcpy(char *dest, const char *src);

/* mem* funcs - memset used in VGA Driver */
extern void *memcpy(void *dest, const void *src, size_t n);
extern void *memset(void *s, int c, size_t n);

#endif
