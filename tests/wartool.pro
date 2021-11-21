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
	../endian.h \
	../pud.h \
	../xmi2mid.h \

DISTFILES +=

