Windows: <a href="https://ci.appveyor.com/project/timfel/wargus"><img width="100" src="https://ci.appveyor.com/api/projects/status/github/Wargus/wargus?branch=master&svg=true"></a>

Linux & OSX: [![Build Status](https://travis-ci.org/Wargus/wargus.svg?branch=master)](https://travis-ci.org/Wargus/wargus)

Nightly builds are available:

- Windows Installer: https://github.com/Wargus/wargus/releases/tag/master-builds
- Ubuntu/Debian Packages: https://launchpad.net/~stratagus/+archive/ubuntu/ppa
- OS X App Bundle: https://github.com/Wargus/stratagus/wiki/osx/Wargus.app.tar.gz

##### Note to Windows XP Users
* Change your operating system.
* If that is not possible:
  * The installer should work on XP, but extraction of data might not, so extract the data on some other machine and copy it into the installation folder
  * Manually download and install the Visual Studio 2015 Redistributable from Microsoft
  * Change the shortcut to launch stratagus.exe rather than wargus.exe in the installation folder directly if your game complains that it cannot find Stratagus.


============================================================================
About
============================================================================

Wargus is a Warcraft II data game set for the Stratagus engine.

Wargus can be used to play Warcraft II from Blizzard Entertainment.

You need the original Warcraft II CD to extract the game data files.

Wargus is developed together for Windows, Linux and Mac OS X.

Homepage: https://github.com/Wargus/wargus

============================================================================
Changelog
============================================================================

See file doc/changelog

============================================================================
Build depends
============================================================================

Stratagus
	- https://github.com/Wargus/stratagus
	- Wargus and Stratagus version must match
	- Use same version or from bzr branches with the same date

CMake
	- http://www.cmake.org/

Gtk+
	- http://www.gtk.org/
	- Not needed for Windows

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

============================================================================
Installation Instructions
============================================================================

For straight source builds on supported systems, you can always study
.travis.yml or (for Windows) appveyor.yml, which are used by the automatic
build system to build each commit.

On Debian, Ubuntu, and other Debian-like systems use deb packages:

	1. create deb package:
		dpkg-buildpackage -b -rfakeroot

	2. install deb package:
		sudo dpkg -i ../wargus_<version>_<arch>.deb

On other systems:

	1. first download, build, and install Stratagus (with game headers)

	2. generate Makefile in build dir with cmake:
		rm -rf build && mkdir build && cd build && cmake ..

	3. build tools and programs:
		cd build && make

	4. install wargus to system
		cd build && sudo make install

On all systems:

	X. start wargus:
		wargus

On Windows you can replace steps 4-6 by generating Windows NSIS Installer which
create classic Windows setup executable. Enable by cmake param -DENABLE_NSIS
