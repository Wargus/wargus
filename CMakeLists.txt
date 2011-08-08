#       _________ __                 __
#      /   _____//  |_____________ _/  |______     ____  __ __  ______
#      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
#      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
#     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
#             \/                  \/          \//_____/            \/
#  ______________________                           ______________________
#                        T H E   W A R   B E G I N S
#         Stratagus - A free fantasy real time strategy game engine
#
#    CMakeLists.txt
#    Copyright (C) 2011  Pali Rohár <pali.rohar@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 2 of the License, or
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

project(wargus)
cmake_minimum_required(VERSION 2.6)
set(WARGUS_VERSION 2.2.6)

# Wargus sources

set(pudconvert_SRCS
	pud.c
	pudconvert.c
)

set(pudconvert_HDRS
	endian.h
	pud.h
)

set(wartool_SRCS
	pud.c
	wartool.c
	xmi2mid.cpp
)

set(wartool_HDRS
	endian.h
	pud.h
	xmi2mid.h
)

set(wargus_SRCS
	wargus.c
)

set(warextract_SRCS
	warextract.c
)

# Additional platform checks

find_package(PkgConfig QUIET REQUIRED)

# Check if platform is Maemo
if(UNIX AND CMAKE_SYSTEM_NAME MATCHES Linux)
	pkg_check_modules(MAEMO_VERSION maemo-version)
	if(MAEMO_VERSION_FOUND)
		set(MAEMO true)
	endif()
endif()

# Find all libraries

option(ENABLE_STATIC "Compile Wargus binaries as static executable" OFF)

if(ENABLE_STATIC)
	set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib;.a")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

find_package(PNG REQUIRED)
find_package(ZLIB REQUIRED)

if(WIN32)
	find_package(MakeNSIS)
endif()

if(NOT WIN32)
	find_package(GTK2 REQUIRED gtk)
endif()

if(MAEMO)
	pkg_check_modules(HILDON REQUIRED hildon-1)
endif()

find_package(SelfPackers)

# Windows RC compiler definitions

if(WIN32)
	enable_language(RC)
	include(CMakeDetermineRCCompiler)

	if(MINGW)
		set(CMAKE_RC_COMPILER_INIT windres)
		set(CMAKE_RC_COMPILE_OBJECT "<CMAKE_RC_COMPILER> <FLAGS> -O coff <DEFINES> -i <SOURCE> -o <OBJECT>")
	endif()
endif()

# Options for compiling

if(WIN32)
	option(ENABLE_NSIS "Create Stratagus Window NSIS Installer" OFF)
endif()

option(ENABLE_UPX "Compress Stratagus executable binary with UPX packer" OFF)

# Wargus definitions

add_definitions(${PNG_DEFINITIONS})
include_directories(${PNG_INCLUDE_DIR} ${ZLIB_INCLUDE_DIRS})
set(pudconvert_LIBS ${pudconvert_LIBS} ${ZLIB_LIBRARIES})
set(wartool_LIBS ${pudconvert_LIBS} ${PNG_LIBRARIES} ${ZLIB_LIBRARIES})

# Platform definitions

if(NOT WIN32)
	include_directories(${GTK2_INCLUDE_DIRS})
	set(wargus_LIBS ${wargus_LIBS} ${GTK2_LIBRARIES})
endif()

if(BEOS)
	add_definitions(-DUSE_BEOS)
endif()

if(MAEMO)
	add_definitions(${HILDON_CFLAGS})
	include_directories(${HILDON_INCLUDE_DIRS})
	set(wargus_LIBS ${wargus_LIBS} ${HILDON_LIBRARIES})
endif()

# Compile Wargus

add_executable(pudconvert ${pudconvert_SRCS} ${pudconvert_HDRS})
target_link_libraries(pudconvert ${pudconvert_LIBS})

if(MAEMO)
	add_executable(warextract ${warextract_SRCS} ${warextract_HDRS})
	target_link_libraries(warextract ${warextract_LIBS})
endif()

add_executable(wargus WIN32 ${wargus_SRCS} ${wargus_HDRS})
target_link_libraries(wargus ${wargus_LIBS})

add_executable(wartool ${wartool_SRCS} ${wartool_HDRS})
target_link_libraries(wartool ${wartool_LIBS})

if(WIN32 AND MINGW AND ENABLE_STATIC)
	set_target_properties(pudconvert PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc")
	set_target_properties(wargus PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc")
	set_target_properties(wartool PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc")
endif()

########### next target ###############

macro(self_packer PACKER_TARGET)
	get_target_property(PACKER_NAME ${PACKER_TARGET} OUTPUT_NAME)
	if(NOT PACKER_NAME)
		set(PACKER_NAME ${PACKER_TARGET})
	endif()
	add_custom_command(TARGET ${PACKER_TARGET} POST_BUILD
		COMMAND ${SELF_PACKER_FOR_EXECUTABLE}
		ARGS ${SELF_PACKER_FOR_EXECUTABLE_FLAGS} ${PACKER_NAME}${CMAKE_EXECUTABLE_SUFFIX}
	)
endmacro()

if(ENABLE_UPX AND SELF_PACKER_FOR_EXECUTABLE)
	self_packer(pudconvert)
	self_packer(wargus)
	self_packer(wartool)
endif()

########### next target ###############

if(WIN32 AND ENABLE_NSIS AND MAKENSIS_FOUND)
	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/COPYING DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/COPYING-3rd DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/wargus.ico DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_command(OUTPUT Wargus-${WARGUS_VERSION}${MAKENSIS_SUFFIX}
		COMMAND ${MAKENSIS} ARGS ${MAKENSIS_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/wargus.nsi
		DEPENDS wargus.nsi pudconvert wargus wartool COPYING COPYING-3rd
		COMMENT "Generating Wargus Windows NSIS Installer" VERBATIM
	)
	add_custom_target(nsis ALL DEPENDS Wargus-${STRATAGUS_VERSION}${MAKENSIS_SUFFIX})
endif()

########### install files ###############

install(TARGETS wargus DESTINATION games)
install(TARGETS pudconvert wartool DESTINATION bin)

if(MAEMO)
	install(TARGETS warextract DESTINATION bin)
endif()
