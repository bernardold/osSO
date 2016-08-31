/**
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.

 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 *	Author: Alex Frederico Ramos Barboza <alex.barboza>
 *
 *	Assembly Inline:
 *	Alguns compiladores (como o GCC) permitem que códigos assembly
 *	sejam enxertados em meio ao codigo C.
 *	Isso permite ao programador evitar que o compilador faca
 *	certas otimizacoes indesejaveis. Tambem permite programar em baixo
 *	nivel trechos de codigo que não seriam possiveis de programar
 *	em linguagens de alto (como C, C++, Pascal, Rust, etc..), sem que
 *	para isso seja necessario dois arquivos: um em .c e outro .s (.asm)
 *
 *	Todo assembly inline segue um template basico, como demonstrado abaixo.
 *	__asm__ __volatile__
 *	(
 *		"instrucoes assembly"
 *		: "operandos de saida"
 *		: "operando  de entrada"
 *
 *	Instrucoes assembly sao todo o codigo em asembly da arquitetura
 *	para a qual se programa. NOte que nomes de registradores comecam com %%
 *
 *	Operandos de saida sao os valores que variaveis declaradas em C localmente
 *	irao receber assim que o codigo assembly for executado. Eles sao da forma
 *	:"=<nome_do_registrador>(variavel alterada)", indicando que a variavel
 *	ira assumir o valor do registrador assim que o codigo assembly for executado.
 *
 *	Operando de entrada fazem com que registradores recebam os valores
 *	de variaveis declaradas no codigo C localmente.
 *
 *	Para detalhes aprofundados sobre assembly inline, consultar:
 *	http://wiki.osdev.org/Inline_Assembly
 *	Professional Assembly Language, capitulo 13.
 */


#include <stdio.h>

void swap(int *a, int *b)
{
	__asm__ __volatile__
	(
		/* Eu NAO vou usar a instrucao XCGH */
		"movl	%%eax, %%ecx;\t\n"
		"movl	%%ebx, %%edx;\t\n"
		"movl	%%ecx, %%ebx;\t\n"
		"movl	%%edx, %%eax;\t\n"
		:"=a"(*a), "=b"(*b)
		:"a"(*a), "b"(*b)
	);
}

int main(void)
{
	int a = 10;
	int b = 20;
	printf("a= %d\tb= %d\n", a, b);
	swap(&a, &b);
	printf("a= %d\tb= %d\n", a, b);
	return 0;
}
