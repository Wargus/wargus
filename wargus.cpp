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

    wargus.c - Wargus Game Launcher
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
#define GAME_CD "Warcraft II DOS REZDAT.WAR or BNE Battle.snp file"
#define GAME_CD_FILE_PATTERNS "REZDAT.WAR", "rezdat.war", "War Resources", "WAR2BNE.ICO", "war2bne.ico"
#define GAME "wargus"
#define EXTRACTOR_TOOL "wartool"
#define EXTRACTOR_ARGS "-v -r"
#define CHECK_EXTRACTED_VERSION 1
#define CONTRIB_DIRECTORIES { "campaigns", "campaigns", \
			      "contrib", "graphics/ui", \
			      "maps", "maps",		\
			      "shaders", "shaders",	\
			      "scripts", "scripts", NULL }

const char* SRC_PATH() { return __FILE__; }

#ifdef WIN32
#define TITLE_PNG "%s\\graphics\\ui\\title.png"
#else
#define TITLE_PNG "%s/graphics/ui/title.png"
#endif

#undef DATA_PATH
#define DATA_PATH "invalid"

#include <stratagus-game-launcher.h>
