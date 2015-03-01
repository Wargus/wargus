# - Try to find the StormLib library
# Once done this will define
#
#  STORMLIB_FOUND - system has StormLib
#  STORMLIB_INCLUDE_DIR - the STORMLIB include directory
#  STORMLIB_LIBRARY - The STORMLIB library

# Copyright (c) 2015, cybermind <cybermindid@gmail.com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

if(STORMLIB_INCLUDE_DIR AND STORMLIB_LIBRARY)
	set(STORMLIB_FOUND true)
else()
	find_path(STORMLIB_INCLUDE_DIR StormLib.h)
	find_library(STORMLIB_LIBRARY NAMES StormLibRAD)

	if(STORMLIB_INCLUDE_DIR AND STORMLIB_LIBRARY)
		set(STORMLIB_FOUND true)
		message(STATUS "Found StormLib: ${STORMLIB_LIBRARY}")
	else()
		set(STORMLIB_FOUND false)
		message(STATUS "Could not find StormLib")
	endif()

	mark_as_advanced(STORMLIB_INCLUDE_DIR STORMLIB_LIBRARY)
endif()
