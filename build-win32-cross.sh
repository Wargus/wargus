#!/bin/sh
make clean || exit 1
make win32 CC=amd64-mingw32msvc-gcc CXX=amd64-mingw32msvc-g++ WINDRES=amd64-mingw32msvc-windres LDFLAGS=-static || exit 1
amd64-mingw32msvc-strip wartool.exe pudconvert.exe wargus.exe || exit 1
#upx -9 wartool.exe pudconvert.exe wargus.exe || exit 1
makensis -DNO_DOWNLOAD -DAMD64 wargus.nsi || exit 1

make clean || exit 1
make win32 CC=i586-mingw32msvc-gcc CXX=i586-mingw32msvc-g++ WINDRES=i586-mingw32msvc-windres LDFLAGS=-static || exit 1
i586-mingw32msvc-strip wartool.exe pudconvert.exe wargus.exe || exit 1
upx -9 wartool.exe pudconvert.exe wargus.exe || exit 1
makensis -DNO_DOWNLOAD wargus.nsi || exit 1

