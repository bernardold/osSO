.section	.data
# unsigned char array[] = {0xA, 0xB, 0xC, 0xD, 0xE, 0xF};
array:		.byte	0xA, 0xB, 0xC, 0xD, 0xE, 0xF

.section	.text
.globl		_start
_start:
		# Modo de enderecamento indexado
		# Neste modo de enderecamento um valor
		# constante (no exemplo 1)  
		# eh multiplicado pelo registrador
		# indice (no exemplo, edi) e entao somado
		# a um endereco base (no caso, array).

		# int index = 4
		mov	$4, %edi

		# ebx = array[1 * index];
		mov	array(, %edi, 1), %ebx

		# eax = 1;
		movl	$1, %eax

		# exit(ebx);
		int	$0x80
