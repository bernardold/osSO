# lembrem-se:
# .byte - cada valor desse tipo ocupa 8	 bits (1 byte)
# .word - cada valor desse tipo ocupa 16 bits (2 bytes)
# .long - cada valor desse tipo ocupa 32 bits (4 bytes)

.section	.data
# int array[] = {10, 20, 30, 40, 50};
array:		.long 10, 20, 30, 40, 50

.section	.text
.globl		_start
_start:
		# modo de enderecamento base-ponteiro

		# edi recebe o endereco representado
		# pela label array.
		movl	$array, %edi

		# ebx recebe o valor contido no endereco
		# apontado por edi deslocado em 8 bytes.
		movl	8(%edi), %ebx # ebx = *(array + 2)

		movl	$1, %eax
		int	$0x80

