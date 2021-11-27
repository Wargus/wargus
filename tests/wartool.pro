#A small file to enable the use of Qtcreator for editing Wartool. Delete later.
TEMPLATE = app
CONFIG += console c++20
CONFIG -= app_bundle
CONFIG -= qt

SOURCES=../pud.cpp \
	../wartool.cpp \
        ../xmi2mid.cpp

HEADERS=../wartool.h \
    ../../stratagus/gameheaders/stratagus-gameutils.h \
    ../Image.hpp \
    ../PngIO.hpp \
    StormLib.h \
	../endian.h \
	../pud.h \
    ../rip_music.h \
	../xmi2mid.h \


unix: SOURCES += ../rip_music_unix.cpp
win32: SOURCES += ../rip_music_win32.cpp

DISTFILES +=
DEFINES += USE_STORMLIB

INCLUDEPATH += ../../stratagus/gameheaders/

unix:!macx: LIBS +=../tests/libstorm.a -lpng -lz -lbz2
DESTDIR=../tests/build/

win32: QMAKE_INCDIR = ..\tests\build\dependencies\include
win32: QMAKE_LIBDIR = ..\tests\build\dependencies\lib
win32: LIBS += -lbz2
