Windows: <a href="https://ci.appveyor.com/project/timfel/war1gus"><img width="100" src="https://ci.appveyor.com/api/projects/status/github/Wargus/war1gus?branch=master&svg=true"></a>

Linux & OSX: [![Build Status](https://travis-ci.org/Wargus/war1gus.svg?branch=master)](https://travis-ci.org/Wargus/war1gus)

============================================================================
About
============================================================================

Wargus is a Warcraft II data game set for the Stratagus engine.

Wargus can be used to play Warcraft II from Blizzard Entertainment.

You need the original Warcraft II CD to extract the game data files.

Wargus is developed together for Windows, Linux and Linux Maemo based
devices (Nokia N900).

Homepage: https://launchpad.net/wargus
Source Code: https://code.launchpad.net/wargus
Bugtracker: https://bugs.launchpad.net/wargus

============================================================================
Changelog
============================================================================

See file doc/changelog

============================================================================
Build depends
============================================================================

Stratagus
	- https://launchpad.net/stratagus
	- Wargus and Stratagus version must match
	- Use same version or from bzr branches with the same date

CMake
	- http://www.cmake.org/

Gtk+
	- http://www.gtk.org/
	- Not needed for Windows

Hildon
	- Only needed for Maemo from Maemo SDK

ffmpeg2theora
	- http://v2v.cc/~j/ffmpeg2theora/
	- Needed for convert extracted audio CD tracks and video files

cdparanoia
	- http://xiph.org/paranoia/
	- Needed for rip audio CD tracks

cdda2wav
	- http://smithii.com/files/cdrtools-2.01-bootcd.ru-w32.zip
	- Needed for rip audio CD tracks (only for Windows)

Original Warcraft II DOS CD
	- The Battle.Net CD is NOT supported, you must use the DOS version
	- Either the Expansion or Original CD can be used
	- Do not extract from both. Extract from one CD only

============================================================================
Installation Instructions
============================================================================

On Debian, Ubuntu, Maemo and other Debian-like systems use deb packages:

	1. create deb package:
		dpkg-buildpackage -b -rfakeroot

	2. install deb package:
		sudo dpkg -i ../wargus_<version>_<arch>.deb

On other systems:

	1. first download, build and install Stratagus (with game headers) from:
		https://launchpad.net/stratagus

	2. generate Makefile in build dir with cmake:
		rm -rf build && mkdir build && cd build && cmake ..

	3. build tools and programs:
		cd build && make

	4. install wargus to system
		cd build && sudo make install

	5. extract data from original CD:
		sudo wartool -m -v -r /media/cdrom /usr/share/games/stratagus/wargus

	6. start wargus:
		wargus

On Windows you can replace steps 4-6 by renerating Windows NSIS Installer which
create classic Windows setup executable. Enable by cmake param -DENABLE_NSIS
