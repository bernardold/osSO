/** @file 	boot.s
 *	@brief	Simple boot sector
 *	
 *	Simple boot sector implementation for osSO.
 *  
 *	It performs a simple operations given by the opcodes:
 *		- 1 clear screen
 *		- 2 bootload version
 *		- 3 print devices
 *		- 4 restart
 *		- 5 print available ram
 *
 *	@author		Bernardo Simoes Lage Gomes Duarte (bernardolageduarte@gmail.com)
 *	@author		Decio Lauro Soares (deciolauro@gmail.com)
 *	@author		Jhonathan Roberto Viudes (jhonathan.viudes@gmail.com)
 *	@date		2016
 *	@bug		--
 *	@warning	--
 * 	@copyright	GNU Public License v3
 */

.code16

.section .data
msg_welcome:
	.asciz "Welcome to osSO"
msg_cmd:
	.asciz "Waiting..."
msg_foo:
	.asciz "foo"
msg_bar:
	.asciz "OsSo version 1.0.1-alpha"
msg_help:
	.asciz "Invalid Opcode, options (1,2,3,4,5)"

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
	mov $0x0A00, %di
	mov $0xB800, %ax
	mov %ax, %ds
	mov $msg_cmd, %si
	mov $0x0A, %ah
	mov $0x61, %al
	mov $0x00, %bh 
	mov $0x10, %bl 
	mov $0x03, %cx 
	int $0x10
	jmp move
print_foo:
	mov $msg_foo, %si
	call print
	ret
print_ver:
	mov $msg_bar, %si
	call print
	jmp loop_user_op
print_help:
	mov $msg_help, %si
	call print
	jmp loop_user_op

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
	mov $0xA, %dl # set cursor column
	int $0x10
	ret

read_op:
	xor %ax, %ax
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

restart:
	ljmp $0xF000, $0xfff0

print_ver_aux:
	call print_ver
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
	cmp $0x31, %al # clear screen op=1
	jz clear_screen_op
	cmp $0x32, %al # print version op=2
	jz print_ver
	cmp $0x33, %al # print devices op=3
	jz print_dev
	cmp $0x34, %al # restart op=4
	jz restart
	jmp	print_help

clear_screen_op:
	call clear_screen
	mov $0x0, %di
	jmp user_op

print_dev:
	nop
	jmp loop_user_op

start:
	nop
	xor %ax, %ax
	xor %di, %di
	call user_op
	call read_op
	cmp $0x66, %al
	je	print_foo
	jne print_welcome2

end:
	jmp end
