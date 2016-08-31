.section	.data
value:		.byte	69

.section	.text
.globl		_start
_start:
		# modo de enderecamento indireto:

		# ecx recebe o endereco representado pela
		# label value
		movl	$value, %ecx # ecx <- &(value)

		# %ebx recebe o byte menos significativo
		# do valor apontado por ecx
		movb	(%ecx), %bl # bl <- *(ecx)
		movl	$1, %eax
		int	$0x80
