/** @file 	boot.s
 *	@brief	Simple boot sector
 *	
 *	Simple boot sector implementation for osSO.
 *  
 *	It performs few simple operations given by the opcodes:
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
msg_ver:
	.asciz "osSO v.1.1.0"
msg_help:
	.asciz "InvOp, op(1,2,3,4,5)"
msg_mem:
	.asciz "  h mem available" #output should be hex
msg_floppy:
	.asciz "Floppy; "
msg_mouse:
	.asciz "Mouse; "
msg_dma_sup:
	.asciz "DMASup; "
msg_gamep:
	.asciz "GPort; "
msg_vga:
	.asciz "VGA; "
msg_eighty:
	.asciz "8086; "

.section .text

	.globl _start

_start:
	jmp start

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
	call print

print_welcome2:
	mov $0x0A00, %di
	mov $0xB800, %ax
	mov %ax, %ds
	mov $msg_cmd, %si
	call print
	ret
	
print_ver:
	call clear_screen_op2
	mov $msg_ver, %si
	call print
	jmp loop_user_op
print_help:
	call clear_screen_op2
	mov $msg_help, %si
	call print
	jmp loop_user_op
print_floppy:
	call clear_screen_op2
	mov $msg_floppy, %si
	call print
	jmp mouse
print_mouse:
	mov $msg_mouse, %si
	call print
	jmp dma
print_dma_sup:
	mov $msg_dma_sup, %si
	call print
	jmp gamep
print_game_port:
	mov $msg_gamep, %si
	call print
	jmp vga
print_vga:
	mov $msg_vga, %si
	call print
	jmp eighty
print_eighty:
	mov $msg_eighty, %si
	call print
	jmp drives

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

restart:
	ljmp $0xF000, $0xfff0

print_ver_aux:
	call print_ver
	jmp loop_user_op

mem_size:
	call clear_screen_op2
	push %ax

	mov $msg_mem, %si
	call print

	int $0x12			# ax <- mem size (uses al though)
	call print_hex

	pop %ax
	jmp loop_user_op

print_hex:		# as http://stackoverflow.com/questions/3853730/printing-hexadecimal-digits-with-assembly
	push %cx

	push %ax 			# saves al (from int 0x12)
	shr $4, %al 		# high from al
	call nibble_to_hex	# convert high al to hex
	movb %al, %cl

	pop %ax 			# brings original al back
	and $0x0F, %al 		# low from al
	call nibble_to_hex 	# convert low al to hex

	movb $0x0E, %ah 	# to print correctly
	movb $0x00, %bh 	# set page num

	int 	$0x10 		# print high (should already be in al)
	
	movb 	%cl, %al 	# move low to al
	int 	$0x10		# print al

	pop %cx
	ret

nibble_to_hex:
	cmp $10, %al
	jl skip_nibble_to_hex

	# if (al >= 10)
	add $0x57, %al #0x57 = 'A' - 10
	jmp return_nibble_to_hex

	# else (al < 10)
	skip_nibble_to_hex:
		add $'0', %al 	#adiciona 0 para o digito inicial (que eh o valor de al + o char 0)
		jmp return_nibble_to_hex

return_nibble_to_hex:
	ret 	# al has the hex for the nibble


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
	cmp $0x35, %al # available memory size op=5
	jz mem_size
	jmp	print_help

clear_screen_op:
	call clear_screen
	mov $0x0, %di
	jmp user_op

clear_screen_op2:
	mov $0x0, %di
	call print_welcome
	call move_cursor
	call print_welcome2
	ret

print_dev:
	int $0x11
	push %ax
	floppy:
		and $0x1, %ax # diskette
		cmp $0x1, %ax
		jz print_floppy
	mouse:
		pop %ax
		push %ax
		and $0x3, %ax
		cmp $0x3, %ax
		jz print_mouse
	dma:
		pop %ax
		push %ax
		and $0x8, %ax
		jnz print_dma_sup
	gamep:
		pop %ax
		push %ax
		and $0xC, %ax
		jz print_game_port
	vga:
		pop %ax
		push %ax
		and $0x30, %ax
		cmp $0x0, %ax
		jnz print_vga
	eighty:
		pop %ax
		push %ax
		and $0x2, %ax
		cmp $0x2, %ax
		jz print_eighty
	drives:
		xor %ax, %ax
		jmp loop_user_op

start:
	nop
	xor %ax, %ax
	xor %di, %di
	call user_op
	call read_op

end:
	jmp end
