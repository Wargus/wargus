
CC = gcc

CROSSDIR = /usr/local/cross

all: cleanobj wartool$(EXE)

wartool: wartool.o
	$(CC) -o $@ $^ -lz -lpng -lm

wartool.exe: wartool.o
	$(CC) -o $@ $^ -lz -lpng -lm

wartool.o:
	$(CC) -c wartool.c -o $@

win32_2:
	

win32:
	export PATH=$(CROSSDIR)/bin:$(CROSSDIR)/i386-mingw32msvc/bin:$$PATH; \
	export EXE=.exe; \
	$(MAKE) $(WIN32)

cleanobj:
	rm -f wartool.o

clean:
	rm -rf wartool wartool.exe wartool.o data.wc2 wargus-* wargus

strip:
	strip wartool
	strip wartool.exe

date = $(shell date +%y%m%d)

release: clean wartool win32 strip cleanobj
	echo `find Makefile build.* contrib campaigns wartool* scripts maps | grep -v 'CVS' | grep -v '/\.'` > .list
	mkdir wargus; \
	for i in `cat .list`; do echo $$i; done | cpio -pdml --quiet wargus;\
	rm -rf `find wargus | grep -i cvs`; \
	tar -zcf wargus-$(date).tar.gz wargus; \
	zip -qr wargus-$(date).zip wargus; \
	rm -rf wargus .list;
