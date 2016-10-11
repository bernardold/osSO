/** @file 	boot.s
 *	@brief	Simple boot sector
 *	
 *	Simple boot sector implementation for osSo.
 *  
 *	It performs a simple operations given by the opcodes:
 *		- 0 for sum
 *		- 1 for sub
 *		- 2 for mul
 *		- 3 for div
 *
 *	@author		Decio Lauro Soares (deciolauro@gmail.com)
 *	@date		2016
 *	@bug		--
 *	@warning	--
 * 	@copyright	GNU Public License v3
 */

.code16

.section .data
msg_welcome:
	.asciz "Welcome to OsSo"
msg_cmd:
	.asciz "Waiting..."
msg_foo:
	.asciz "foo"
msg_bar:
	.asciz "bar"
msg_help:
	.asciz "Help info"

.section .text

	.globl _start

_start:
	jmp start

print_setup:
	mov $0xB800, %ax
	mov %ax, %ds
	jmp print

print:
	xor %dx, %dx
	mov %cs:(%si), %dl # si MUST contain the string to be printed
	cmp $0, %dl
	jz end_print
	mov %dl, (%di)
	inc %di
	movb $0x1E, (%di)
	inc %di
	inc %si
	jmp print

print_welcome:
	call clear_screen
	mov $0xB800, %ax # Set to color monitor (use 0xB000 for monochrome)
	mov %ax, %ds
	mov $msg_welcome, %si
	jmp move
print_welcome2:
	mov $0xB800, %ax
	mov %ax, %ds
	mov $msg_cmd, %si
	jmp move
print_foo:
	mov $msg_foo, %si
	call print
	ret
print_bar:
	mov $msg_bar, %si
	call print
	ret
print_help:
	mov $msg_bar, %si
	call print
	ret

move:
	xor %dx, %dx
	mov %cs:(%si), %dl
	cmp $0, %dl
idle:
	jz end_print
	mov %dl, (%di)
	inc %di
	movb $0x1E, (%di) # color
	inc %di
	inc %si
	jmp move
end_print:
	ret

clear_screen:
	mov $0x0600, %ax
    mov $0x7, %bh
    mov $0x0, %cx
    mov $0x184f, %dx
	int $0x10
	ret

move_cursor:
	mov $0x02, %ah # set cursor position
    mov $0x00, %bh # display page (change for text mode)
	mov $0x10, %dh # set cursor row
	mov $0x03, %dl # set cursor column
	int $0x10
	jmp print_welcome2

read_op:
	xor %ax, %ax
	//mov $0x11, %ah	# check keyboard buffer
	//int $0x16
	//jz read_op # still waiting
	mov $0x10, %ah
	int $0x16	# consume key
	ret

print_op:
	push %eax
	mov $0xB800, %ax
	mov %ax, %ds
	pop %eax
	mov (%eax), %si
	jmp move

foo_aux:
	int $0x19
	ret
	//mov $0x0000, %ax
	//mov %ax, 0x00400072
	//jmp 0xFFFF0000
	//int $0x19
	//call print_foo
	//jmp loop_user_op

print_bar_aux:
	call print_bar
	jmp loop_user_op

print_help_aux:
	call print_help
	jmp loop_user_op

user_op:
	call print_welcome
	call move_cursor
	call print_welcome2
loop_user_op:
	call read_op
	cmp $0x61, %al
	jz foo_aux
	cmp $0x62, %al
	jz print_bar
	xor %al, %al
	jnz	print_help

start:
	nop
	xor %ax, %ax
	xor %di, %di
	int $0x19 # Here it restarts
	call user_op
	call read_op
	cmp $0x66, %al
	je	print_foo
	jne print_welcome2
	//call print_op
	//call print_welcome
	//call move_cursor
	//call print_welcome2
	//call read_op

end:
	jmp end
