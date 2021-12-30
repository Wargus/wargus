# This file is a cut-down version just to build wartool and run tests.
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

project(wartool_testing)
cmake_minimum_required(VERSION 3.10)
cmake_policy(VERSION 3.10..3.20.2)
set(WARGUS_VERSION 2.4.1)

set(CMAKE_CXX_STANDARD 17)

if(EXISTS ${WIN32_CMAKE_PREFIX_PATH})
	list(APPEND CMAKE_PREFIX_PATH "${WIN32_CMAKE_PREFIX_PATH}")
	message("Using prefix path ${CMAKE_PREFIX_PATH}")
endif()

set(wartool_SRCS
	../pud.cpp
	../wartool.cpp
	../xmi2mid.cpp
)

set(wartool_HDRS
	../wartool.h
	../endian.h
	../pud.h
	../xmi2mid.h
)

if(WIN32)
	set(wartool_SRCS
		${wartool_SRCS}
		../rip_music_win32.cpp
	)
else()
	set(wartool_SRCS
		${wartool_SRCS}
		../rip_music_unix.cpp
	)
endif()


# Additional platform checks
if(NOT (WIN32 AND MSVC))
	find_package(PkgConfig QUIET REQUIRED)
endif()

# Find all libraries

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/modules ${CMAKE_MODULE_PATH})

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

option(WITH_STORMLIB "Compile wartool with StormLib support" ON)

if(NOT IS_ABSOLUTE "${GAMEDIR}")
	set(GAMEDIRABS "${CMAKE_INSTALL_PREFIX}/${GAMEDIR}")
else()
	set(GAMEDIRABS "${GAMEDIR}")
endif()

# Wargus definitions

add_definitions(${PNG_DEFINITIONS})
include_directories(${PNG_INCLUDE_DIR} ${ZLIB_INCLUDE_DIRS})
set(pudconvert_LIBS ${pudconvert_LIBS} ${ZLIB_LIBRARIES})
set(wartool_LIBS ${pudconvert_LIBS} ${PNG_LIBRARIES} ${ZLIB_LIBRARIES})

# Platform definitions

if(WIN32 AND MSVC)
	add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
else()
	include(CheckCXXSourceCompiles)
	set(FS_SRC "
	#include <experimental/filesystem> 
	namespace fs = std::experimental::filesystem;
	int main(int argc, char **argv) {
		fs::path p = fs::path(\".\");
		if (fs::absolute(p).is_absolute()) {
			return 0;
		} else {
			return 1;
		}
	}
	")
	check_cxx_source_compiles("${FS_SRC}" HAS_17_FS)
	if(NOT HAS_17_FS)
		set(CMAKE_REQUIRED_LIBRARIES stdc++fs)
		check_cxx_source_compiles("${FS_SRC}" HAS_EXP_17_FS_WITH_STDC)
		if(HAS_EXP_17_FS_WITH_STDC)
			set(wartool_LIBS ${wartool_LIBS} stdc++fs)
		else()
			set(CMAKE_REQUIRED_LIBRARIES c++fs)
			check_cxx_source_compiles("${FS_SRC}" HAS_EXP_17_FS_WITH_CLIB)
			if(HAS_EXP_17_FS_WITH_CLIB)
				set(wartool_LIBS ${wartool_LIBS} c++fs)
			else()
				message(FATAL_ERROR "I don't know how to compile with C++17 filesystem support on your system")
			endif()
		endif()
	endif()
endif()

if(NOT WIN32)
	include_directories(${X11_INCLUDE_DIR} ${GTK2_INCLUDE_DIRS})
endif()

if(ENABLE_STRIP)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s")
endif()

if (WITH_STORMLIB)
	if (NOT STORMLIB_FOUND AND UNIX)
		set(BUILD_STORMLIB true)
		include(ExternalProject)
		message(STATUS "Will build StormLib as part of compilation.")
		ExternalProject_Add(StormLib 
		  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/StormLib/"
		  SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../StormLib/"
		  INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/StormLib/"
		  LOG_DIR "${CMAKE_CURRENT_BINARY_DIR}/StormLib/Logs/"
		  LOG_CONFIGURE ON
		  LOG_BUILD ON
		  LOG_OUTPUT_ON_FAILURE ON
		  CMAKE_ARGS -DSTORM_SKIP_INSTALL=ON
		  INSTALL_COMMAND ""
		)
		set(STORMLIB_FOUND true)
		set(STORMLIB_INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/../StormLib/src)
		set(STORMLIB_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/StormLib/src/StormLib-build/libstorm.a)
	endif()

	if (STORMLIB_FOUND)
		add_definitions(-DUSE_STORMLIB -D__STORMLIB_SELF__)
		include_directories(${STORMLIB_INCLUDE_DIR})
		set(wartool_LIBS ${wartool_LIBS} ${STORMLIB_LIBRARY} ${BZIP2_LIBRARIES})
	endif()
endif()

# Compile Wartool
add_executable(wartool ${wartool_SRCS} ${wartool_HDRS})
target_link_libraries(wartool ${wartool_LIBS})

if(BUILD_STORMLIB)
	add_dependencies(wartool StormLib)
endif()

if(WIN32 AND MINGW AND ENABLE_STATIC)
	set_target_properties(wartool PROPERTIES LINK_FLAGS "${LINK_FLAGS} -static-libgcc -static-libstdc++")
endif()

########### next target ###############

if (WIN32 AND MSVC)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS}")
	set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS}")
	add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
	set_target_properties(wartool PROPERTIES LINK_FLAGS "${LINK_FLAGS}")
endif()

