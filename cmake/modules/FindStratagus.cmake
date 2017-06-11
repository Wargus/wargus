# - Try to find the stratagus executable and game headers
# Once done this will define
#
#  STRATAGUS_FOUND - system has stratagus
#  STRATAGUS - the stratagus executable
#  STRATAGUS_INCLUDE_DIR - the stratagus include directory

# Copyright (c) 2011, Pali Rohár <pali.rohar@gmail.com>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

if(STRATAGUS AND STRATAGUS_INCLUDE_DIR)
	set(STRATAGUS_FOUND true)
else()
	find_program(STRATAGUS NAMES stratagus PATH_SUFFIXES games)
	find_path(STRATAGUS_INCLUDE_DIR stratagus-game-launcher.h)

	if(STRATAGUS AND STRATAGUS_INCLUDE_DIR)
		set(STRATAGUS_FOUND true)
		message(STATUS "Found stratagus: ${STRATAGUS}:${STRATAGUS_INCLUDE_DIR}")
	else()
		set(STRATAGUS_FOUND false)
		message(FATAL_ERROR "Could not find stratagus, please set STRATAGUS_INCLUDE_DIR and STRATAGUS")
	endif()

	mark_as_advanced(STRATAGUS STRATAGUS_INCLUDE_DIR)
endif()
