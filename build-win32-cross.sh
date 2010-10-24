#!/bin/sh
make clean win32 win32-strip win32-installer CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ WINDRES=x86_64-w64-mingw32-windres STRIP=x86_64-w64-mingw32-strip LDFLAGS=-static NSISFLAGS=-DAMD64
make clean win32 win32-strip win32-pack win32-installer CC=i686-w64-mingw32-gcc CXX=i686-w64-mingw32-g++ WINDRES=i686-w64-mingw32-windres STRIP=i686-w64-mingw32-strip LDFLAGS=-static
