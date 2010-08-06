#!/bin/sh
make clean || exit 1
make win32 CC=amd64-mingw32msvc-gcc CXX=amd64-mingw32msvc-g++ WINDRES=amd64-mingw32msvc-windres LDFLAGS=-static || exit 1
makensis -DAMD64 wargus.nsi || exit 1

make clean || exit 1
make win32 CC=i586-mingw32msvc-gcc CXX=i586-mingw32msvc-g++ WINDRES=i586-mingw32msvc-windres LDFLAGS=-static || exit 1
makensis wargus.nsi || exit 1

