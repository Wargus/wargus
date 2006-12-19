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
//      (c) Copyright 2005 by The Stratagus Team
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

#define PLAYERMAX 16

enum PlayerTypes {
	PlayerNeutral = 2,    // neutral
	PlayerNobody,         // unused slot
	PlayerComputer,       // computer player
	PlayerPerson,         // human player
	PlayerRescuePassive,  // passive rescue
	PlayerRescueActive,   // active rescue
};

char *PlayerTypeStrings[] = {
	"",
	"",
	"neutral",
	"nobody",
	"computer",
	"person",
	"rescue-passive",
	"rescue-active"	
};

enum RaceTypes {
	RaceHuman,
	RaceOrc,
	RaceNeutral
};

char *RaceNames[] = {
	"human",
	"orc",
	"neutral"
};

enum TilesetTypes {
	TilesetForest,
	TilesetWinter,
	TilesetWasteland,
	TilesetSwamp
};

char *TilesetTypeStrings[] = {
	"summer",
	"winter",
	"wasteland",
	"swamp"
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

// unit script names that correspond to the unit types
char *UnitScriptNames[] = {
	"unit-footman",
	"unit-grunt",
	"unit-peasant",
	"unit-peon",
	"unit-ballista",
	"unit-catapult",
	"unit-knight",
	"unit-ogre",
	"unit-archer",
	"unit-axethrower",
	"unit-mage",
	"unit-death-knight",
	"unit-paladin",
	"unit-ogre-mage",
	"unit-dwarves",
	"unit-goblin-sappers",
	"unit-attack-peasant",
	"unit-attack-peon",
	"unit-ranger",
	"unit-berserker",
	"unit-female-hero",
	"unit-evil-knight",
	"unit-flying-angel",
	"unit-fad-man",
	"unit-white-mage",
	"unit-beast-cry",
	"unit-human-oil-tanker",
	"unit-orc-oil-tanker",
	"unit-human-transport",
	"unit-orc-transport",
	"unit-human-destroyer",
	"unit-orc-destroyer",
	"unit-battleship",
	"unit-ogre-juggernaught",
	"",
	"unit-fire-breeze",
	"",
	"",
	"unit-human-submarine",
	"unit-orc-submarine",
	"unit-balloon",
	"unit-zeppelin",
	"unit-gryphon-rider",
	"unit-dragon",
	"unit-knight-rider",
	"unit-eye-of-vision",
	"unit-arthor-literios",
	"unit-quick-blade",
	"",
	"unit-double-head",
	"unit-wise-man",
	"unit-ice-bringer",
	"unit-man-of-light",
	"unit-sharp-axe",
	"",
	"unit-skeleton",
	"unit-daemon",
	"unit-critter",
	"unit-farm",
	"unit-pig-farm",
	"unit-human-barracks",
	"unit-orc-barracks",
	"unit-church",
	"unit-altar-of-storms",
	"unit-human-watch-tower",
	"unit-orc-watch-tower",
	"unit-stables",
	"unit-ogre-mound",
	"unit-inventor",
	"unit-alchemist",
	"unit-gryphon-aviary",
	"unit-dragon-roost",
	"unit-human-shipyard",
	"unit-orc-shipyard",
	"unit-town-hall",
	"unit-great-hall",
	"unit-elven-lumber-mill",
	"unit-troll-lumber-mill",
	"unit-human-foundry",
	"unit-orc-foundry",
	"unit-mage-tower",
	"unit-temple-of-the-damned",
	"unit-human-blacksmith",
	"unit-orc-blacksmith",
	"unit-human-refinery",
	"unit-orc-refinery",
	"unit-human-oil-platform",
	"unit-orc-oil-platform",
	"unit-keep",
	"unit-stronghold",
	"unit-castle",
	"unit-fortress",
	"unit-gold-mine",
	"unit-oil-patch",
	"unit-human-start-location",
	"unit-orc-start-location",
	"unit-human-guard-tower",
	"unit-orc-guard-tower",
	"unit-human-cannon-tower",
	"unit-orc-cannon-tower",
	"unit-circle-of-power",
	"unit-dark-portal",
	"unit-runestone",
	"unit-human-wall",
	"unit-orc-wall"
};

char *AiTypeNames[] = {
	"wc2-land-attack",
	"wc2-passive",
	"orc-03",
	"hum-04",
	"orc-04",
	"hum-05",
	"orc-05",
	"hum-06",
	"orc-06",
	"hum-07",
	"orc-07",
	"hum-08",
	"orc-08",
	"hum-09",
	"orc-09",
	"hum-10",
	"orc-10",
	"hum-11",
	"orc-11",
	"hum-12",
	"orc-12",
	"hum-13",
	"orc-13",
	"hum-14-orange",
	"wc2-land-attack",
	"wc2-sea-attack",
	"wc2-air-attack",
	"hum-14-red",
	"hum-14-white",
	"hum-14-black",
	"wc2-land-attack",
	"wc2-land-attack",
	// expansion scenarios
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
	"wc2-land-attack",
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

#endif
