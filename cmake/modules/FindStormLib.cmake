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

if(STORMLIB_INCLUDE_DIR AND STORMLIB_LIBRARY AND (NOT UNIX OR BZIP2_FOUND))
	set(STORMLIB_FOUND true)
else()
	find_path(STORMLIB_INCLUDE_DIR StormLib.h)
	find_library(STORMLIB_LIBRARY NAMES storm)
	if (UNIX)
		find_package(BZip2)
	endif()

	if(STORMLIB_INCLUDE_DIR AND STORMLIB_LIBRARY AND (NOT UNIX OR BZIP2_FOUND))
		set(STORMLIB_FOUND true)
		message(STATUS "Found StormLib: ${STORMLIB_LIBRARY}")
	elseif(UNIX AND NOT BZIP2_FOUND)
		set(STORMLIB_FOUND false)
		message(STATUS "Could not find BZip2 required for StormLib")
	else()
		set(STORMLIB_FOUND false)
		message(STATUS "Could not find StormLib")
	endif()

	mark_as_advanced(STORMLIB_INCLUDE_DIR STORMLIB_LIBRARY)
endif()
