#
#    Makefile
#    Copyright (C) 2010  Pali Rohár <pali.rohar@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#

CC = gcc
CFLAGS = -O2 -W -Wall -Wsign-compare
WINDRES = windres
LDFLAGS = 
GTKFLAGS = $(shell pkg-config --cflags --libs gtk+-2.0)

all: unix

clean:
	rm -f wartool wartool.exe pudconvert pudconvert.exe wargus wargus.exe wargus.rc.o

# Unix

unix: wartool pudconvert wargus

wartool:
	$(CC) wartool.c pudconvert.c $(CFLAGS) -o wartool $(LDFLAGS) -lz -lpng -lm

pudconvert:
	$(CC) pudconvert.c $(CFLAGS) -DSTAND_ALONE -o pudconvert $(LDFLAGS) -lz

wargus:
	$(CC) wargus.c $(CFLAGS) -o wargus $(LDFLAGS) $(GTKFLAGS)

# Win32

win32: wartool.exe pudconvert.exe wargus.exe

wartool.exe:
	$(CC) wartool.c pudconvert.c $(CFLAGS) -o wartool.exe $(LDFLAGS) -lz -lpng -lm

pudconvert.exe:
	$(CC) pudconvert.c $(CFLAGS) -DSTAND_ALONE -o pudconvert.exe $(LDFLAGS) -lz

wargus.rc.o:
	$(WINDRES) wargus.rc -o wargus.rc.o

wargus.exe: wargus.rc.o
	$(CC) wargus.c wargus.rc.o $(CFLAGS) -o wargus.exe $(LDFLAGS)

