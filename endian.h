//       _________ __                 __
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/
//  ______________________                           ______________________
//                        T H E   W A R   B E G I N S
//         Stratagus - A free fantasy real time strategy game engine
//
/**@name wartool.h */
//
//      (c) Copyright 1998-2004 by Lutz Sammer
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; only version 2 of the License.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program; if not, write to the Free Software
//      Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//      02111-1307, USA.
//

#ifndef __WENDIAN_H__
#define __WENDIAN_H__

#ifdef __aarch64__
#ifdef __AARCH64EB__
# define __BYTE_ORDER __BIG_ENDIAN
#define __BIG_ENDIAN__ 4321
#else
# define __BYTE_ORDER __LITTLE_ENDIAN
#define __LITTLE_ENDIAN__ 1234
#endif
#endif

// From SDL_byteorder.h
#if  defined(__i386__) || defined(__ia64__) || defined(WIN32) || \
    (defined(__alpha__) || defined(__alpha)) || \
     defined(__arm__) || \
    (defined(__mips__) && defined(__MIPSEL__)) || \
     defined(__SYMBIAN32__) || \
     defined(__x86_64__) || \
     defined(__LITTLE_ENDIAN__)
#ifdef __cplusplus
static inline unsigned short FetchLE16(unsigned char*& p) {
	unsigned short s = *(unsigned short*)p;
	p += 2;
	return s;
}
static inline unsigned int FetchLE32(unsigned char*& p) {
	unsigned int s = *(unsigned int*)p;
	p += 4;
	return s;
}
#else
#define FetchLE16(p) (*((unsigned short*)(p))); p += 2
#define FetchLE32(p) (*((unsigned int*)(p))); p += 4
#endif
#define AccessLE16(p) (*((unsigned short*)(p)))
#define AccessLE32(p) (*((unsigned int*)(p)))
#define ConvertLE16(v) (v)
#define ConvertLE32(v) (v)
#else
static inline unsigned short Swap16(unsigned short D) {
	return ((D << 8) | (D >> 8));
}
static inline unsigned int Swap32(unsigned int D) {
	return ((D << 24) | ((D << 8) & 0x00FF0000) | ((D >> 8) & 0x0000FF00) | (D >> 24));
}
#define FetchLE16(p) Swap16(*((unsigned short*)(p))); p += 2
#define FetchLE32(p) Swap32(*((unsigned int*)(p))); p += 4
#define AccessLE16(p) Swap16((*((unsigned short*)(p))))
#define AccessLE32(p) Swap32(*((unsigned int*)(p)))
#define ConvertLE16(v) Swap16(v)
#define ConvertLE32(v) Swap32(v)
#endif

#define FetchByte(p) (*((unsigned char*)(p))); ++p

#endif /* __WENDIAN_H__ */
