/**
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>
  *
  * boot.s: a simple bootloader without using grub.
  *
  * Author: Rene de Souza Pinto <rene@renesp.com.br>
  */


.globl	_start
.text

_start:
.code16
		xorw	%ax, %ax
		movw	%ax, %ds
		movw	%ax, %ss
		movw	%ax, %fs
		jmp	start

start:
		movb	$'A', %al
		movb	$0x1E, %ah
		movl	$0xB8000, %ecx
		movl	%eax, (%ecx)
loop:		jmp	loop

. = _start + 510
.byte		0X55, 0xAA
