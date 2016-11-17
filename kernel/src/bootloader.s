/** @file 	bootloader.s
 *	@brief	Simple multiboot sector
 *	
 *	Simple multiboot sector implementation for osSO.
 *  
 *	STRONGLY BASED ON: http://wiki.osdev.org/Meaty_Skeleton#Kernel_Design
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

.set ALIGN,    1<<0
.set MEMINFO,  1<<1
.set FLAGS,    ALIGN | MEMINFO
.set MAGIC,    0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS)
.set STACK_SIZE,	0x4000

.section	.text
.globl		start, _start

start:
_start:
		jmp		multiboot_entry
		.align	4
multiboot_header:
		.long	MAGIC
		.long	FLAGS
		.long	CHECKSUM

multiboot_entry:
		movl	$(stack + STACK_SIZE), %esp
		pushl	$0
		popf
		pushl	%ebx
		pushl	%eax
		call	kernel_main
loop:	hlt
		jmp		loop

		.comm	stack, STACK_SIZE
