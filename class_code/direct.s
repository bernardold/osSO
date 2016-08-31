.section	.data
# value representa um endereco de memoria
# neste endereco de memoria, armazenamos o
# valor 20.
value:		.long 20

.section	.text
.globl		_start
_start:
		# modo de enderecamento direto:
		# mova o conteudo armazenado no endereco
		# representado pela label value
		# para o registrador ebx
		movl	value, %ebx

		# mova o valor 1 para o registrador eax
		movl	$1, %eax

		# interrupcao por software: exit(ebx)
		int	$0x80	
