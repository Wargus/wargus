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
#    Copyright (C) 2011-2016  Pali Rohár <pali.rohar@gmail.com>
#                             cybermind <cybermindid@gmail.com>
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
set(WARGUS_VERSION 2.4.1)

# Wargus sources

set(pudconvert_SRCS
	pud.cpp
	pudconvert.cpp
)

set(pudconvert_HDRS
	endian.h
	pud.h
)

set(wartool_SRCS
	pud.cpp
	wartool.cpp
	xmi2mid.cpp
)

set(wartool_HDRS
	wartool.h
	endian.h
	pud.h
	xmi2mid.h
)

set(wargus_SRCS
	wargus.cpp
)

set(tales_SRCS
	aleonas_tales.cpp
)

if(WIN32)
	set(wargus_SRCS
		${wargus_SRCS}
		wargus.rc
	)
	set(tales_SRCS
		${tales_SRCS}
		wargus.rc
	)
	set(wartool_SRCS
		${wartool_SRCS}
		rip_music_win32.cpp
	)
else()
	set(wartool_SRCS
		${wartool_SRCS}
		rip_music_unix.cpp
	)
endif()

set(warextract_SRCS
	warextract.c
)

# Additional platform checks
if(NOT (WIN32 AND MSVC))
	find_package(PkgConfig QUIET REQUIRED)
endif()

# Find all libraries

option(ENABLE_STATIC "Compile Wargus binaries as static executable" OFF)

if(ENABLE_STATIC)
	set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib;.a")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

find_package(Stratagus REQUIRED)
find_package(PNG REQUIRED)
find_package(ZLIB REQUIRED)
find_package(StormLib)

if(WIN32)
	find_package(MakeNSIS)
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
option(ENABLE_STRIP "Strip all symbols from executables" OFF)

option(WITH_STORMLIB "Compile wartool with StormLib support" ON)

# Install paths
set(BINDIR "bin" CACHE PATH "Where to install user binaries")
set(GAMEDIR "games" CACHE PATH "Where to install games binaries")
set(SHAREDIR "share/games/stratagus/wargus" CACHE PATH "Where to install data files")
set(DATAROOTDIR "${CMAKE_INSTALL_PREFIX}/share" CACHE PATH "Sets the root of data directories to a non-default location")
set(ICONDIR "${DATAROOTDIR}/pixmaps" CACHE PATH "Sets the icon directory for desktop entry to a non-default location.")
set(DESKTOPDIR "${DATAROOTDIR}/applications" CACHE PATH "Sets the desktop file directory for desktop entry to a non-default location.")

if(NOT IS_ABSOLUTE "${GAMEDIR}")
	set(GAMEDIRABS "${CMAKE_INSTALL_PREFIX}/${GAMEDIR}")
else()
	set(GAMEDIRABS "${GAMEDIR}")
endif()

# Wargus definitions

add_definitions(${PNG_DEFINITIONS})
include_directories(${PNG_INCLUDE_DIR} ${ZLIB_INCLUDE_DIRS} ${STRATAGUS_INCLUDE_DIR})
set(pudconvert_LIBS ${pudconvert_LIBS} ${ZLIB_LIBRARIES})
set(wartool_LIBS ${pudconvert_LIBS} ${PNG_LIBRARIES} ${ZLIB_LIBRARIES})

# Platform definitions

if (WIN32 AND MSVC)
	add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
endif()

if(NOT WIN32)
	include_directories(${X11_INCLUDE_DIR} ${GTK2_INCLUDE_DIRS})
	set(wargus_LIBS ${wargus_LIBS} ${X11_X11_LIB} ${GTK2_LIBRARIES})
endif()

if (NOT WIN32)
	if(NOT IS_ABSOLUTE "${SHAREDIR}")
		set(DATA_PATH "${CMAKE_INSTALL_PREFIX}/${SHAREDIR}")
	else()
		set(DATA_PATH "${SHAREDIR}")
	endif()
	add_definitions(-DDATA_PATH="${DATA_PATH}")
	add_definitions(-DSCRIPTS_PATH="${DATA_PATH}")
	add_definitions(-DSTRATAGUS_BIN="${STRATAGUS}")
endif()

if(ENABLE_STRIP)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s")
endif()

# For now, doesn't compile on OS X with StormLib
if(WITH_STORMLIB AND STORMLIB_FOUND)
	add_definitions(-DUSE_STORMLIB -D__STORMLIB_SELF__)
	include_directories(${STORMLIB_INCLUDE_DIR})
	set(wartool_LIBS ${wartool_LIBS} ${STORMLIB_LIBRARY} ${BZIP2_LIBRARIES})
endif()

# Compile Wargus

add_executable(pudconvert ${pudconvert_SRCS} ${pudconvert_HDRS})
target_link_libraries(pudconvert ${pudconvert_LIBS})

add_executable(wargus WIN32 ${wargus_SRCS} ${wargus_HDRS})
add_executable(aleonas_tales WIN32 ${tales_SRCS} ${wargus_HDRS})
target_link_libraries(wargus ${wargus_LIBS})
target_link_libraries(aleonas_tales ${wargus_LIBS})

add_executable(wartool ${wartool_SRCS} ${wartool_HDRS})
target_link_libraries(wartool ${wartool_LIBS})

if(WIN32 AND MINGW AND ENABLE_STATIC)
	set_target_properties(pudconvert PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc -static-libstdc++")
	set_target_properties(wargus PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc -static-libstdc++")
	set_target_properties(aleonas_tales PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc -static-libstdc++")
	set_target_properties(wartool PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc -static-libstdc++")
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
	self_packer(aleonas_tales)
	self_packer(wartool)
endif()

########### next target ###############

if(WIN32 AND ENABLE_NSIS AND MAKENSIS_FOUND)
	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/COPYING DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/COPYING-3rd DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/wargus.ico DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_command(OUTPUT Wargus-${WARGUS_VERSION}${MAKENSIS_SUFFIX}
		COMMAND ${MAKENSIS}
		ARGS ${MAKENSIS_FLAGS} -DCMAKE_CURRENT_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}" -DCMAKE_CURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/wargus.nsi
		DEPENDS wargus.nsi pudconvert wargus wartool COPYING COPYING-3rd wargus.ico
		COMMENT "Generating Wargus Windows NSIS Installer" VERBATIM
	)
	add_custom_target(nsis ALL DEPENDS Wargus-${WARGUS_VERSION}${MAKENSIS_SUFFIX})
endif()

if (WIN32 AND MSVC)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS}")
	set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS}")
	add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
	set_target_properties(pudconvert PROPERTIES LINK_FLAGS "${LINK_FLAGS}")
	set_target_properties(wartool PROPERTIES LINK_FLAGS "${LINK_FLAGS}")
endif()

########### next target ###############

configure_file (
	"${PROJECT_SOURCE_DIR}/wargus.desktop.in"
	"${PROJECT_BINARY_DIR}/wargus.desktop"
)

configure_file (
	"${PROJECT_SOURCE_DIR}/aleonas_tales.desktop.in"
	"${PROJECT_BINARY_DIR}/aleonas_tales.desktop"
)

########### install files ###############

install(TARGETS wargus DESTINATION ${GAMEDIR})
install(TARGETS aleonas_tales DESTINATION ${GAMEDIR})
install(TARGETS pudconvert wartool DESTINATION ${BINDIR})
install(FILES wargus.png DESTINATION ${ICONDIR})
install(FILES "${PROJECT_BINARY_DIR}/wargus.desktop" DESTINATION ${DESKTOPDIR})
install(FILES "${PROJECT_BINARY_DIR}/aleonas_tales.desktop" DESTINATION ${DESKTOPDIR})

install(DIRECTORY shaders contrib campaigns graphics maps music scripts sounds DESTINATION ${SHAREDIR})
install(FILES contrib/red_cross.png DESTINATION ${SHAREDIR}/graphics/missiles)
install(FILES contrib/cross.png DESTINATION ${SHAREDIR}/graphics/ui/cursors)
install(FILES contrib/food.png contrib/health.png contrib/health2.png contrib/mana.png contrib/mana2.png contrib/ore,stone,coal.png contrib/score.png DESTINATION ${SHAREDIR}/graphics/ui)
