@ECHO OFF
GOTO START
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
REM	(c) Copyright 1999-2001 by Lutz Sammer.
REM
REM	FreeCraft is free software; you can redistribute it and/or modify
REM	it under the terms of the GNU General Public License as published
REM	by the Free Software Foundation; either version 2 of the License,
REM	or (at your option) any later version.
REM
REM	FreeCraft is distributed in the hope that it will be useful,
REM	but WITHOUT ANY WARRANTY; without even the implied warranty of
REM	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM	GNU General Public License for more details.
REM	
REM	$Id$
REM
REM	Johns didn't know how to write dos batch scripts.
REM	This should become more user friendly!
REM	See build.sh what must done.
REM
:START
REM
REM     Choose your CDROM drive / Installed data path.
REM
SET CDROM=D:
REM SET CDROM=E:
REM SET CDROM=C:\Programme\WAR2E

REM     Altenatively: Choose where you have the orignal file.
REM
REM	Here are the input files for sounds, graphics and texts.
REM	WARNING: If not from CD, choose below expansion/no-expansion
REM	First choice:   installed on orginal position
REM	Second choise:  installed/copied in current directory
REM	Third choise:   uninstalled on original cdrom

REM SET ARCHIVE=C:\war2\data
REM SET ARCHIVE=.
SET ARCHIVE=%CDROM%\data

REM
REM	Here are my executables. (wartool...)
REM
SET BINDIR=tools

REM
REM	Here is the extra files contributed with FreeCraft.
REM
SET CONTRIB=contrib

REM
REM	Here is the destination for the generated library files.
REM
SET DIR=data

REM
REM     Below this point, you should only search bugs. :-)
REM

REM ###########################################################################
REM ##      Extract
REM ###########################################################################

REM ADD -e      To force the archive are expansion compatible
REM ADD -n      To force the archive is not expansion compatible   
%BINDIR%\wartool %ARCHIVE% %DIR%

REM copy own supplied files

copy /b %CONTRIB%\cross.png %DIR%\graphics\ui\cursors
copy /b %CONTRIB%\mana.png %DIR%\graphics\ui
copy /b %CONTRIB%\mana2.png %DIR%\graphics\ui
copy /b %CONTRIB%\health.png %DIR%\graphics\ui
copy /b %CONTRIB%\health2.png %DIR%\graphics\ui
copy /b %CONTRIB%\food.png %DIR%\graphics\ui
copy /b %CONTRIB%\score.png %DIR%\graphics\ui
copy /b "%CONTRIB%\ore,stone,coal.png" %DIR%\graphics\ui
copy /b %CONTRIB%\freecraft.png %DIR%\graphics\ui
mkdir %DIR%\music
copy /b %CONTRIB%\music\toccata.mod.gz %DIR%\music\default.mod.gz
REM copy /b %CONTRIB%\ui\alliance\*.png %DIR%\graphic\ui\alliance
REM copy /b %CONTRIB%\ui\mythical\*.png %DIR%\graphic\ui\mythical

REM ###########################################################################
REM ##      MISC
REM ###########################################################################

REM Compress HOW-TODO ?

REM
REM	Setup the default pud
REM
copy /b %DIR%\puds\internal\internal12.pud.gz %DIR%\default.pud.gz
ECHO You only need to run this script once

