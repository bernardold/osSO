/**	
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *   	(at your option) any later version.
 *
 *    	This program is distributed in the hope that it will be useful,
 *    	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *    	You should have received a copy of the GNU General Public License
 *   	along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 *	print_name.s: Shows how to output a single char
 *	using the write() system call.
 *
 *	Author: Alex Frederico Ramos Barboza. <alex.barboza@usp.br>
 */

.section	.data
text:		.byte	'S', 'O', '1', 0

.section	.text
.globl		_start

.type		print_char, @function
print_char:
		pushl	%ebp
		movl	%esp, %ebp

		# allocating space for local variables
		subl	$4, %esp

		# getting the first argument
		movl	8(%ebp), %eax

		# and storing it at local variable
		movl	%eax, (%esp)

		# printing the char at STDOUT
		movl	$4, %eax	# 4 is the code for write syscall
		movl	$1, %ebx	# ebx is the file descriptor
		movl	%esp, %ecx	# ecx is the address of string
		movl	$1, %edx	# the size of string
		int	$0x80

		# restoring the stack
		movl	%ebp, %esp
		popl	%ebp

		# returning to the calling function
		ret

.type		_start, @function
_start:
		movl	$0, %edi
		movl	text(, %edi, 1), %eax
		pushl	%eax
		call	print_char

		pushl	$'\n'
		call	print_char

		movl	$1, %ebx
		movl	$1, %eax
		int	$0x80
