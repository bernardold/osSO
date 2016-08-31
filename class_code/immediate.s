.section	.text
.globl		_start
_start:
		# modo de enderecamento imediato
		# mova o valor 42 para o registrador ebx
		movl	$42, %ebx

		#  faca o registrador eax armazenar o valor 1
		movl	$1, %eax

		# interrupcao por software
		int	$0x80
