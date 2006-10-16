
CC = gcc

CROSSDIR = /usr/local/cross
STRATAGUSPATH = ../stratagus/

CFLAGS = -I/usr/local/include -Wall -Wsign-compare
LDFLAGS = -lz -lpng -lm -L/usr/local/lib

all: cleanobj wartool

wartool: wartool.o pudconvert.o
	$(CC) -o $@ $^ $(LDFLAGS)

cleanobj:
	rm -f wartool.o pudconvert.o

clean:
	rm -rf wartool wartool.exe wartool.o data.wc2 wargus-* wargus

strip:
	strip wartool
#	strip wartool.exe

date = $(shell date +%y%m%d)
ver = 2.1pre2

release: release-src release-linux

release-src: clean cleanobj
	echo `find Makefile build.* contrib campaigns wartool.c wartool.ds* scripts maps README | grep -v '/\.'` > .list
	mkdir wargus-$(ver); \
	for i in `cat .list`; do echo $$i; done | cpio -pdml --quiet wargus-$(ver);\
	rm -rf `find wargus-$(ver) | grep -i cvs`; \
	tar -zcf wargus-$(ver)-src.tar.gz wargus-$(ver); \
	zip -qr wargus-$(ver)-src.zip wargus-$(ver); \
	rm -rf wargus-$(ver) .list;

release-linux: clean wartool strip cleanobj
	pwd
	cp -f $(STRATAGUSPATH)stratagus .
	echo `find Makefile build.sh contrib campaigns wartool scripts maps stratagus README | grep -v '/\.'` > .list
	mkdir wargus-$(ver); \
	for i in `cat .list`; do echo $$i; done | cpio -pdml --quiet wargus-$(ver);\
	rm -rf `find wargus-$(ver) | grep -i cvs`; \
	tar -zcf wargus-$(ver)-linux.tar.gz wargus-$(ver); \
	rm -rf wargus-$(ver) .list stratagus;
