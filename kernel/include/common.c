/** @file 	common.c
 *	@brief	Implementation of port and I/O auxiliar functions
 *	
 *	Port and I/O auxiliar functions
 *  Based on: https://gcc.gnu.org/
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

#include "common.h"

/* Write byte to port */
void outb(uint16_t port, uint8_t value)
{
	__asm__ __volatile__("outb %1, %0" :: "dN" (port), "a" (value));
}

/* Read Byte from port */
uint8_t inb(uint16_t port)
{
	uint8_t ret;
	__asm__ __volatile__("inb %1, %0" : "=a" (ret) : "dN" (port));
	return ret;
}

/* read word (2 bytes) from port */
uint16_t inw(uint16_t port)
{
	uint16_t ret;
	__asm__ __volatile__("inw %1, %0" : "=a" (ret) : "dN" (port));
	return ret;
}

/* Write word (2 bytes) to port */
void outw(uint16_t port, uint16_t value)
{
	__asm__ __volatile__("outw %1, %0" :: "dN" (port), "a" (value));
}

/* Read double-word (4 bytes) from port */
uint32_t inl(uint16_t port)
{
	uint32_t ret;
	__asm__ __volatile__("inl %1, %0" : "=a" (ret) : "dN" (port));
	return ret;
}

void outl(uint16_t port, uint32_t value)
{
	__asm__ __volatile__("outl %1, %0" :: "dN" (port), "a" (value));
}

void sleep(uint32_t secs)
{
	extern uint32_t tick;
	uint32_t nexttick = tick + (secs * 100);
	while (tick < nexttick)
		__asm__ __volatile__("hlt");
}
