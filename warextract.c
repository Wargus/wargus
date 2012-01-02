/*
       _________ __                 __
      /   _____//  |_____________ _/  |______     ____  __ __  ______
      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
             \/                  \/          \//_____/            \/
  ______________________                           ______________________
                        T H E   W A R   B E G I N S
         Stratagus - A free fantasy real time strategy game engine

    warextract.c - Wargus Game Extractor for Maemo
    Copyright (C) 2010-2011  Pali Rohár <pali.rohar@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#define GAME_NAME "Wargus"
#define GAME_CD "Warcraft II CD"
#define GAME_CD_DIR "MyDocs/WAR2/DATA"
#define GAME_CD_FILE "rezdat.war"
#define GAME "wargus"

#define EXTRACT_BIN "/opt/stratagus/bin/wartool"
#define EXTRACT_COMMAND "/opt/stratagus/bin/wartool -m -v /home/user/MyDocs/WAR2/DATA /home/user/MyDocs/stratagus/wargus"
#define EXTRACT_INFO "If you want to add music support,\nextract audio tracks from Warcraft II CD\nto folder MyDocs/WAR2/music"

#include <stratagus-maemo-extract.h>
