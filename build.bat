@ECHO OFF
GOTO START
REM
REM  ___________                     _________                _____  __
REM  \_   _____/______   ____   ____ \_   ___ \____________ _/ ____\/  |_
REM   |    __) \_  __ \_/ __ \_/ __ \/    \  \/\_  __ \__  \\  __ \\   __|
REM   |     \   |  | \/\  ___/\  ___/\     \____|  | \// __ \|  |   |  |
REM   \___  /   |__|    \___  >\___  >\______  /|__|  (____  /__|   |__|
REM       \/                \/     \/        \/            \/
REM ______________________                           ______________________
REM                       T H E   W A R   B E G I N S
REM	   Stratagus - A free fantasy real time strategy game engine
REM
REM	build.bat	-	The graphics and sound extractor.
REM
REM	(c) Copyright 1999-2003 by Lutz Sammer and Jimmy Salmon.
REM
REM	Stratagus is free software; you can redistribute it and/or modify
REM	it under the terms of the GNU General Public License as published
REM	by the Free Software Foundation; only version 2 of the License.
REM
REM	Stratagus is distributed in the hope that it will be useful,
REM	but WITHOUT ANY WARRANTY; without even the implied warranty of
REM	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM	GNU General Public License for more details.
REM	
REM	$Id$
REM
:START

REM
REM     Enter the letter of your CDROM drive.
REM

SET CDROM=D:

REM
REM     Alternatively: Enter the path to WC2 on your hard drive.
REM	If you need to force expansion, use the -e option.
REM

REM SET CDROM="C:\War2"
REM SET EXPANSION=-e

REM
REM	This is the name of the directory where the files will be extracted.
REM	If you installed with fcmp then you should use data.wc2 instead.
REM

SET DIR=data
REM SET DIR=data.wc2






REM ###########################################################################
REM ##      DO NOT EDIT BELOW THIS LINE
REM ###########################################################################

SET BINDIR=tools
SET CONTRIB=contrib

IF NOT [%1] == [] SET CDROM=%1
IF NOT [%2] == [] SET DIR=%2
SET ARCHIVE=%CDROM%\data

IF NOT EXIST %ARCHIVE%\rezdat.war goto DIRERROR
IF NOT EXIST %CONTRIB%\* goto CONTRIBERROR

REM ###########################################################################
REM ##      Extract
REM ###########################################################################

ECHO Extracting files...

REM ADD -e      To force the archive are expansion compatible
REM ADD -n      To force the archive is not expansion compatible   
%BINDIR%\wartool %EXPANSION% %ARCHIVE% %DIR%

REM copy own supplied files

copy /b %CONTRIB%\cross.png %DIR%\graphics\ui\cursors
copy /b %CONTRIB%\red_cross.png %DIR%\graphics\missiles
copy /b %CONTRIB%\mana.png %DIR%\graphics\ui
copy /b %CONTRIB%\mana2.png %DIR%\graphics\ui
copy /b %CONTRIB%\health.png %DIR%\graphics\ui
copy /b %CONTRIB%\health2.png %DIR%\graphics\ui
copy /b %CONTRIB%\food.png %DIR%\graphics\ui
copy /b %CONTRIB%\score.png %DIR%\graphics\ui
copy /b "%CONTRIB%\ore,stone,coal.png" %DIR%\graphics\ui
copy /b %CONTRIB%\stratagus.png %DIR%\graphics\ui
mkdir %DIR%\music
copy /b %CONTRIB%\music\toccata.mod.gz %DIR%\music\default.mod.gz

REM ###########################################################################
REM ##      MISC
REM ###########################################################################

REM Compress HOW-TODO ?

REM
REM	Copy original puds into data directory
REM
mkdir %DIR%\puds
mkdir %DIR%\puds\single
mkdir %DIR%\puds\multi
mkdir %DIR%\puds\multiple
mkdir %DIR%\puds\strange

IF EXIST %ARCHIVE%\..\puds\multi\* copy /b %ARCHIVE%\..\puds\multi\* %DIR%\puds\multi
IF EXIST %ARCHIVE%\..\puds\single\* copy /b %ARCHIVE%\..\puds\single\* %DIR%\puds\single
IF EXIST %ARCHIVE%\..\puds\strange\* copy /b %ARCHIVE%\..\puds\strange\* %DIR%\puds\strange
IF EXIST %ARCHIVE%\..\*.pud copy /b %ARCHIVE%\..\*.pud %DIR%\puds

REM
REM	Copy contrib puds into data directory
REM
rem copy /b %CONTRIB%\puds\single\* %DIR%\puds\single
copy /b %CONTRIB%\puds\multi\* %DIR%\puds\multiple

REM
REM	Setup the default pud
REM
copy /b %DIR%\puds\multi\(2)mysterious-dragon-isle.pud.gz %DIR%\puds\default.pud.gz
ECHO NOTE: You only need to run this script once
goto EOF

:DIRERROR
ECHO ERROR: '%ARCHIVE%\rezdat.war' not found
goto EOF

:CONTRIBERROR
ECHO ERROR: '%CONTRIB%' not found; try running %0
ECHO 	from the toplevel stratagus directory
goto EOF

:EOF
pause
