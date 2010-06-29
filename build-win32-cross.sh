#!/bin/sh
make clean || exit 1
make win32 CC=amd64-mingw32msvc-gcc WINDRES=amd64-mingw32msvc-windres || exit 1
makensis -DAMD64 wargus.nsi || exit 1

make clean || exit 1
make win32 CC=i586-mingw32msvc-gcc WINDRES=i586-mingw32msvc-windres || exit 1
makensis wargus.nsi || exit 1

