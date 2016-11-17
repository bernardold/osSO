/** @file 	stdint.h
 *	@brief	Header in C standard library to define integer data types
 *	
 *	Header in C standard library that defines exact-width integer data types
 *  Types based on: ISO-C
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
#ifndef __STDINT_H__
#define __STDINT_H__

typedef unsigned char           byte;
typedef unsigned short          word;
typedef unsigned int            dword;
typedef signed char             int8_t;
typedef unsigned char           uint8_t;
typedef signed short int        int16_t;
typedef unsigned short int      uint16_t;
typedef signed int              int32_t;
typedef unsigned int            uint32_t;
typedef unsigned long long      uint64_t;
typedef long long               int64_t;
typedef unsigned char           uchar_t;
typedef uint32_t                size_t;
typedef uint32_t                addr_t;
typedef int32_t                 pid_t;

#endif
