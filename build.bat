@ECHO OFF
REM
REM  ___________                     _________                _____  __
REM  \_   _____/______   ____   ____ \_   ___ \____________ _/ ____\/  |_
REM   |    __) \_  __ \_/ __ \_/ __ \/    \  \/\_  __ \__  \\   __\\   __\
REM   |     \   |  | \/\  ___/\  ___/\     \____|  | \// __ \|  |   |  |
REM   \___  /   |__|    \___  >\___  >\______  /|__|  (____  /__|   |__|
REM       \/                \/     \/        \/            \/
REM ______________________                           ______________________
REM                       T H E   W A R   B E G I N S
REM	   FreeCraft - A free fantasy real time strategy game engine
REM
REM	build.bat	-	The graphics and sound extractor.
REM
REM	(c) Copyright 1999-2000 by Lutz Sammer.
REM
REM	$Id$
REM
REM	Johns didn't know how to write dos batch scripts.
REM	This should become more user friendly!
REM	See build.sh what must done.
REM

REM
REM	Choose your CDROM drive.
REM
SET CDROM=D:
REM SET CDROM=E:

REM	Choose where you have the orignal file.
REM
REM	Here are the input files for sounds, graphics and texts.
REM	WARNING: If not from CD, choose below expansion/no-expansion
REM	First choice:   installed on orginal position
REM	Second choise:  installed/copied in current directory
REM	Third choise:   uninstalled on original cdrom

REM SET ARCHIVE=C:\war2\data
REM SET ARCHIVE=.\
SET ARCHIVE=%CDROM%\data

REM SET ARCHIVE=C:\games\war2\data

REM
REM	Here are my executables. (wartool...)
REM
SET BINDIR=tools

REM
REM	Here is the extra files contributed with FreeCraft.
REM
SET CONTRIB=contrib

REM
REM	Here is the destionation for the generated library files.
REM
SET DIR=data

REM
REM     Below this point, you should only search bugs. :-)
REM

REM Create the directory structure

mkdir %DIR%
mkdir %DIR%graphic
mkdir %DIR%graphic\tileset
mkdir %DIR%graphic\interface

mkdir %DIR%sound

mkdir %DIR%campaigns
mkdir %DIR%campaigns\human
mkdir %DIR%campaigns\orc
mkdir %DIR%campaigns\human-exp
mkdir %DIR%campaigns\orc-exp
mkdir %DIR%text

mkdir %DIR%puds
mkdir %DIR%puds\internal
mkdir %DIR%puds\demo
REM new structure
mkdir %DIR%graphic\tilesets
mkdir %DIR%graphic\tilesets\summer
mkdir %DIR%graphic\tilesets\winter
mkdir %DIR%graphic\tilesets\wasteland
mkdir %DIR%graphic\tilesets\swamp
mkdir %DIR%graphic\ui\human
mkdir %DIR%graphic\ui\orc

REM ###########################################################################
REM ##      Extract
REM ###########################################################################

REM ADD -e      To force the archive are expansion compatible
REM ADD -n      To force the archive is not expansion compatible   
%BINDIR%\wartool %ARCHIVE% %DIR%

REM own supplied files

copy /b %CONTRIB%\cross.png %DIR%\graphic
copy /b %CONTRIB%\mana.png %DIR%
copy /b %CONTRIB%\health.png %DIR%
copy /b %CONTRIB%\food.png %DIR%\graphic
copy /b %CONTRIB%\score.png %DIR%\graphic
copy /b %CONTRIB%\ore,stone,coal.png %DIR%\graphic
copy /b %CONTRIB%\ale-title.png %DIR%

REM ###########################################################################
REM ##      MISC
REM ###########################################################################

REM Compress HOW-TODO ?

REM
REM	Setup the default pud
REM
copy /b %DIR%\puds\internal\internal12.pud.gz %DIR%\default.pud.gz
ECHO You only need to run this scipt once

