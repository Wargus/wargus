#A small file to enable the use of Qtcreator for editing Wartool. Delete later.
TEMPLATE = app
CONFIG += console c++20
CONFIG -= app_bundle
CONFIG -= qt

SOURCES=../pud.cpp \
	../wartool.cpp \
	../xmi2mid.cpp \
        ../rip_music_unix.cpp

HEADERS=../wartool.h \
    StormLib.h \
	../endian.h \
	../pud.h \
    ../rip_music.h \
	../xmi2mid.h \


DISTFILES +=
DEFINES += USE_STORMLIB


unix:!macx: LIBS +=../tests/libstorm.a -lpng -lz -lbz2
DESTDIR=../tests/build/
