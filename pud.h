//       _________ __                 __
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/
//  ______________________                           ______________________
//                        T H E   W A R   B E G I N S
//         Stratagus - A free fantasy real time strategy game engine
//
/**@name pud.h - pudconvert header. */
//
//      (c) Copyright 2005-2011 by The Stratagus Team and Pali Rohár
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; only version 2 of the License.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program; if not, write to the Free Software
//      Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//      02111-1307, USA.

#ifndef _PUD_H_
#define _PUD_H_

#include <zlib.h>

#ifdef _MSC_VER
#define PATH_MAX _MAX_PATH
#endif

#define PLAYERMAX 16

enum PlayerTypes {
	PlayerNeutral = 2,    // neutral
	PlayerNobody,         // unused slot
	PlayerComputer,       // computer player
	PlayerPerson,         // human player
	PlayerRescuePassive,  // passive rescue
	PlayerRescueActive,   // active rescue
};

enum RaceTypes {
	RaceHuman,
	RaceOrc,
	RaceNeutral
};

enum TilesetTypes {
	TilesetForest,
	TilesetWinter,
	TilesetWasteland,
	TilesetSwamp
};



// unit types, we dont need the whole list
enum UnitTypes {
	UnitHumanOilPlatform = 0x56,
	UnitOrcOilPlatform,
	UnitGoldMine = 0x5C,
	UnitOilPatch,
	UnitHumanStart,
	UnitOrcStart
};

struct UnitData {
	int X;
	int Y;
	int Type;
	int Player;
	int Data;
};

struct PudData {
	char Description[32];

	int NumPlayers;
	enum PlayerTypes Players[PLAYERMAX];
	enum RaceTypes Races[PLAYERMAX];

	enum TilesetTypes Tileset;
	int MapSizeX;
	int MapSizeY;
	int *Tiles;
	int *Value;

	struct UnitData *Units;
	int NumUnits;

	int AiType[PLAYERMAX];

	int StartGold[PLAYERMAX];
	int StartLumber[PLAYERMAX];
	int StartOil[PLAYERMAX];
	int StartX[PLAYERMAX];
	int StartY[PLAYERMAX];
};

int WriteSMP(const struct PudData * const pdata, gzFile smpout, const char *smsname);
int WriteSMS(const struct PudData * const pdata, gzFile smsout);
int PudReadHeader(const unsigned char *puddata, char *header, int *len);
int ProcessPud(const unsigned char *puddata, size_t size, gzFile smsout, gzFile smpout, const char *smsname);
int PudToStratagus(const unsigned char *puddata, size_t size, const char *name, const char *outdir);

#endif
