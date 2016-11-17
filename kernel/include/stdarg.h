/** @file 	stdarg.h
 *	@brief	Header in C standard library to accept indefinite number of args
 *	
 *	Header in C standard library that allows functions to accept an
 *	indefinite number of arguments.
 *  Types based on:  IEEE Std 1003.1
 *
 *	@author		Bernardo Simoes Lage Gomes Duarte (bernardolageduarte@gmail.com)
 *	@author		Decio Lauro Soares (deciolauro@gmail.com)
 *	@author		Giovani Ortolani Barbosa (giovani.barbosa@usp.br)
 *	@author		Jhonathan Roberto Viudes (jhonathan.viudes@gmail.com)
 *	@date		2016
 *	@bug		--
 *	@warning	--
 * 	@copyright	GNU Public License v3
 */
#ifndef __STDARG_H__
#define __STDARG_H__

#define va_alist __builtin_va_alist
#define __va_ellipsis ...

typedef int __builtin_va_alist_t __attribute__((__mode__(__word__)));

#define va_dcl __builtin_va_alist_t __builtin_va_alist; ...

#ifndef __GNUC_VA_LIST
#define __GNUC_VA_LIST
typedef __builtin_va_list __gnuc_va_list;
#endif

#define va_start(ap, param)  __builtin_va_start(ap, param)
#define va_end(ap)           __builtin_va_end(ap)
#define va_arg(ap, type)     __builtin_va_arg(ap, type)
#define __va_copy(d,s)       __builtin_va_copy((d), (s))

typedef __gnuc_va_list va_list;

#endif
