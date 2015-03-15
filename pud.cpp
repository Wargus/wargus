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
/**@name pud.c - library for convert PUD files to native stratagus format. */
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

#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <zlib.h>

#include "endian.h"
#include "pud.h"

#define VERSION "1.0"

const char *PlayerTypeStrings[] = {
	"",
	"",
	"neutral",
	"nobody",
	"computer",
	"person",
	"rescue-passive",
	"rescue-active"
};

const char *RaceNames[] = {
	"human",
	"orc",
	"neutral"
};

const char *TilesetTypeStrings[] = {
	"summer",
	"winter",
	"wasteland",
	"swamp"
};

// unit script names that correspond to the unit types
const char *UnitScriptNames[] = {
	"unit-footman", "unit-grunt",
	"unit-peasant", "unit-peon",
	"unit-ballista", "unit-catapult",
	"unit-knight", "unit-ogre",
	"unit-archer", "unit-axethrower",
	"unit-mage", "unit-death-knight",
	"unit-paladin", "unit-ogre-mage",
	"unit-dwarves", "unit-goblin-sappers",
	"unit-attack-peasant", "unit-attack-peon",
	"unit-ranger", "unit-berserker",
	"unit-female-hero", "unit-evil-knight",
	"unit-flying-angel", "unit-fad-man",
	"unit-white-mage", "unit-beast-cry",
	"unit-human-oil-tanker", "unit-orc-oil-tanker",
	"unit-human-transport", "unit-orc-transport",
	"unit-human-destroyer", "unit-orc-destroyer",
	"unit-battleship", "unit-ogre-juggernaught",
	"", "unit-fire-breeze",
	"", "",
	"unit-human-submarine", "unit-orc-submarine",
	"unit-balloon", "unit-zeppelin",
	"unit-gryphon-rider", "unit-dragon",
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
	"unit-farm", "unit-pig-farm",
	"unit-human-barracks", "unit-orc-barracks",
	"unit-church", "unit-altar-of-storms",
	"unit-human-watch-tower", "unit-orc-watch-tower",
	"unit-stables", "unit-ogre-mound",
	"unit-inventor", "unit-alchemist",
	"unit-gryphon-aviary", "unit-dragon-roost",
	"unit-human-shipyard", "unit-orc-shipyard",
	"unit-town-hall", "unit-great-hall",
	"unit-elven-lumber-mill", "unit-troll-lumber-mill",
	"unit-human-foundry", "unit-orc-foundry",
	"unit-mage-tower", "unit-temple-of-the-damned",
	"unit-human-blacksmith", "unit-orc-blacksmith",
	"unit-human-refinery", "unit-orc-refinery",
	"unit-human-oil-platform", "unit-orc-oil-platform",
	"unit-keep", "unit-stronghold",
	"unit-castle", "unit-fortress",
	"unit-gold-mine",
	"unit-oil-patch",
	"unit-human-start-location", "unit-orc-start-location",
	"unit-human-guard-tower", "unit-orc-guard-tower",
	"unit-human-cannon-tower", "unit-orc-cannon-tower",
	"unit-circle-of-power",
	"unit-dark-portal",
	"unit-runestone",
	"unit-human-wall", "unit-orc-wall"
};

const char *AiTypeNames[] = {
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
	"orc-14-blue",
	"wc2-sea-attack",
	"wc2-air-attack",
	"hum-14-red",
	"hum-14-white",
	"hum-14-black",
	"orc-14-green",
	"orc-14-white",
	// expansion scenarios
	"orc-exp-4",
	"orc-exp-5",
	"orc-exp-7a",
	"orc-exp-9",
	"orc-exp-10",
	"orc-exp-12",
	"orc-exp-6a",
	"orc-exp-6b",
	"orc-exp-11a",
	"orc-exp-11b",
	"hum-exp-2a",
	"hum-exp-2b",
	"hum-exp-2c",
	"hum-exp-3a",
	"hum-exp-3b",
	"hum-exp-3c",
	"hum-exp-4a",
	"hum-exp-4b",
	"hum-exp-4c",
	"hum-exp-5a",
	"hum-exp-5b",
	"hum-exp-5c",
	"hum-exp-5d",
	"hum-exp-6a",
	"hum-exp-6b",
	"hum-exp-6c",
	"hum-exp-6d",
	"hum-exp-8a",
	"hum-exp-8b",
	"hum-exp-8c",
	"hum-exp-9a",
	"hum-exp-9b",
	"hum-exp-9c",
	"hum-exp-9d",
	"hum-exp-10a",
	"hum-exp-10b",
	"hum-exp-10c",
	"hum-exp-11a",
	"hum-exp-11b",
	"hum-exp-12a",
	"orc-exp-5b",
	"hum-exp-7a",
	"hum-exp-7b",
	"hum-exp-7c",
	"orc-exp-12a",
	"orc-exp-12b",
	"orc-exp-12c",
	"orc-exp-12d",
	"orc-exp-2",
	"orc-exp-7b",
	"orc-exp-3",
};


PudData::PudData()
{
	memset(Description, 0, sizeof(Description));
	memset(Players, 0, sizeof(Players));
	memset(Races, 0, sizeof(Races));
	Tileset = TilesetTypes(0);
	MapSizeX = 0;
	MapSizeY = 0;
	memset(AiType, 0, sizeof(AiType));
	memset(StartGold, 0, sizeof(StartGold));
	memset(StartLumber, 0, sizeof(StartLumber));
	memset(StartOil, 0, sizeof(StartOil));
	memset(StartX, 0, sizeof(StartX));
	memset(StartY, 0, sizeof(StartY));
}

void PudData::WriteSMP(gzFile smpout, const char *smsname) const
{
	const PudData &pdata = *this;
	gzprintf(smpout, "-- Stratagus Map Presentation\n");
	gzprintf(smpout, "-- File generated automatically from pudconvert V" VERSION "\n");
	gzprintf(smpout, "\n");

	char buf[512];
	strcpy(buf, "DefinePlayerTypes(");
	int playerCount = 0;
	for (int i = 0; i != PLAYERMAX; ++i) {
		sprintf(buf + strlen(buf), "\"%s\",", PlayerTypeStrings[pdata.Players[i]]);
		if (pdata.Players[i] != PlayerNobody && pdata.Players[i] != PlayerNeutral) {
			++playerCount;
		}
	}
	strcpy(&buf[strlen(buf) - 1], ")\n");
	gzprintf(smpout, buf);

	gzprintf(smpout, "PresentMap(\"%s\", %d, %d, %d, %d)\n", pdata.Description,
		playerCount, pdata.MapSizeX, pdata.MapSizeY, 1);

	// hack for campaigns
	if (smsname) {
		buf[0] = '\0';
		for (const char *c = strstr(smsname, "./campaigns"); *c != '\0'; ++c) {
			if (*c == '\\') {
				strcat(buf, "/");
			} else {
				strncat(buf, c, 1);
			}
		}
		strcpy(strstr(buf, ".sms"), "_c.sms");
		gzprintf(smpout, "DefineMapSetup(\"%s\")\n", buf);
	}
}

void PudData::WriteSMS(gzFile smsout) const
{
	const PudData &pdata = *this;
	gzprintf(smsout, "-- Stratagus Map Setup\n");
	gzprintf(smsout, "-- File generated automatically from pudconvert V" VERSION "\n");
	gzprintf(smsout, "\n");

	for (int i = 0; i != PLAYERMAX - 1; ++i) {
		if (pdata.Players[i] == PlayerNobody) {
			continue;
		}
		gzprintf(smsout, "SetStartView(%d, %d, %d)\n", i, pdata.StartX[i], pdata.StartY[i]);
		gzprintf(smsout, "SetPlayerData(%d, \"Resources\", \"gold\", %d)\n",
			i, pdata.StartGold[i]);
		gzprintf(smsout, "SetPlayerData(%d, \"Resources\", \"wood\", %d)\n",
			i, pdata.StartLumber[i]);
		gzprintf(smsout, "SetPlayerData(%d, \"Resources\", \"oil\", %d)\n",
			i, pdata.StartOil[i]);
		gzprintf(smsout, "SetPlayerData(%d, \"RaceName\", \"%s\")\n", i, RaceNames[pdata.Races[i]]);
		if (pdata.Players[i] != PlayerNeutral) {
			gzprintf(smsout, "SetAiType(%d, \"%s\")\n", i, AiTypeNames[pdata.AiType[i]]);
		}
	}
	gzprintf(smsout, "SetPlayerData(%d, \"RaceName\", \"neutral\")\n", PLAYERMAX - 1);
	gzprintf(smsout, "\n");

	gzprintf(smsout, "LoadTileModels(\"scripts/tilesets/%s.lua\")\n\n",
		TilesetTypeStrings[pdata.Tileset]);

	for (int y = 0; y < pdata.MapSizeY; ++y) {
		for (int x = 0; x < pdata.MapSizeX; ++x) {
			const int mapOffset = y * pdata.MapSizeX + x;
			gzprintf(smsout, "SetTile(%d, %d, %d, %d)\n",
				pdata.Tiles[mapOffset], x, y, pdata.Value[mapOffset]);
		}
	}

	gzprintf(smsout, "\nlocal unit\n");

	for (size_t i = 0; i < pdata.Units.size(); ++i) {
		if (pdata.Units[i].Type == UnitHumanStart
			|| pdata.Units[i].Type == UnitOrcStart) {
			continue;
		}
		if (strlen(UnitScriptNames[pdata.Units[i].Type]) <= 1) {
			fprintf(stderr, "Skipping unknown unit type %d for player %d at [%d, %d]\n", pdata.Units[i].Type, pdata.Units[i].Player, pdata.Units[i].X, pdata.Units[i].Y);
			continue;
		}
		gzprintf(smsout, "unit = CreateUnit(\"%s\", %d, {%d, %d})\n",
			UnitScriptNames[pdata.Units[i].Type], pdata.Units[i].Player,
			pdata.Units[i].X, pdata.Units[i].Y);
		if (pdata.Units[i].Type == UnitHumanOilPlatform || pdata.Units[i].Type == UnitOrcOilPlatform ||
				pdata.Units[i].Type == UnitGoldMine || pdata.Units[i].Type == UnitOilPatch) {
			gzprintf(smsout, "SetResourcesHeld(unit, %d)\n", pdata.Units[i].Data * 2500);
		}
	}
}

static int PudReadHeader(const unsigned char *puddata, char *header, int *len)
{
	unsigned int tmp;

	memcpy(header, puddata, 4);
	header[4] = '\0';
	memcpy(&tmp, puddata + 4, 4);
	*len = ConvertLE32(tmp);
	return 8;
}

bool PudData::Parse(const unsigned char *puddata, size_t size)
{
	const unsigned char *curp = puddata;
	PudData &pdata = *this;
	char header[5];
	int len;
	curp += PudReadHeader(curp, header, &len);
	if (strcmp(header, "TYPE")) {
		return false;
	}

	if (strcmp(reinterpret_cast<const char *>(curp), "WAR2 MAP")) {
		return false;
	}
	curp += len;

	while (curp < puddata + size) {
		curp += PudReadHeader(curp, header, &len);
		if (!strcmp(header, "VER ")) {
			// nothing useful here, skip it
		} else if (!strcmp(header, "DESC")) {
			if (curp[0] != '\0') {
				strcpy(pdata.Description, (const char *)curp);
			} else {
				strcpy(pdata.Description, "(unnamed)");
			}
		} else if (!strcmp(header, "OWNR")) {
			for (int i = 0; i < PLAYERMAX; ++i) {
				pdata.Players[i] = (enum PlayerTypes)curp[i];
			}
		} else if (!strcmp(header, "ERA ") || !strcmp(header, "ERAX")) {
			pdata.Tileset = (enum TilesetTypes)curp[0];
		} else if (!strcmp(header, "DIM ")) {
			pdata.MapSizeX = curp[0] | (curp[1] << 8);
			pdata.MapSizeY = curp[2] | (curp[3] << 8);
		} else if (!strcmp(header, "UDTA")) {
			// FIXME: todo
		} else if (!strcmp(header, "ALOW")) {
			// no puds seem to use this, so we'll ignore
		} else if (!strcmp(header, "UGRD")) {
			// FIXME: todo
		} else if (!strcmp(header, "SIDE")) {
			for (int i = 0; i < PLAYERMAX; ++i) {
				pdata.Races[i] = (enum RaceTypes)curp[i];
			}
		} else if (!strcmp(header, "SGLD")) {
			for (int i = 0; i < PLAYERMAX; ++i) {
				pdata.StartGold[i] = curp[i * 2] | (curp[i * 2 + 1] << 8);
			}
		} else if (!strcmp(header, "SLBR")) {
			for (int i = 0; i < PLAYERMAX; ++i) {
				pdata.StartLumber[i] = curp[i * 2] | (curp[i * 2 + 1] << 8);
			}
		} else if (!strcmp(header, "SOIL")) {
			for (int i = 0; i < PLAYERMAX; ++i) {
				pdata.StartOil[i] = curp[i * 2] | (curp[i * 2 + 1] << 8);
			}
		} else if (!strcmp(header, "AIPL")) {
			for (int i = 0; i < PLAYERMAX; ++i) {
				pdata.AiType[i] = curp[i];
			}
		} else if (!strcmp(header, "MTXM")) {
			pdata.Tiles.resize(pdata.MapSizeX * pdata.MapSizeY);
			pdata.Value.resize(pdata.MapSizeX * pdata.MapSizeY, 0);

			for (int j = 0; j < pdata.MapSizeY; ++j) {
				for (int i = 0; i < pdata.MapSizeX; ++i) {
					int v = curp[j * pdata.MapSizeX * 2 + i * 2] | (curp[j * pdata.MapSizeX * 2 + i * 2 + 1] << 8);
					pdata.Tiles[j * pdata.MapSizeX + i] = v;
					if ((v & 0xFFF0) == 0x00A0 || (v & 0xFFF0) == 0x00C0 || (v & 0xFF00) == 0x0900) {
						// orc wall
						pdata.Value[j * pdata.MapSizeX + i] = 40;
					} else if ((v & 0x00F0) == 0x0090 || (v & 0xFFF0) == 0x00B0 || (v & 0xFF00) == 0x0800) {
						// human wall
						pdata.Value[j * pdata.MapSizeX + i] = 40;
					} else {
						pdata.Value[j * pdata.MapSizeX + i] = 0;
					}
				}
			}
		} else if (!strcmp(header, "SQM ")) { // movement map
		} else if (!strcmp(header, "OILM")) { // oil map
		} else if (!strcmp(header, "REGM")) { // action map
		} else if (!strcmp(header, "SIGN")) {
		} else if (!strcmp(header, "UNIT")) {
			pdata.Units.resize(len / 8);

			for (size_t i = 0; i < pdata.Units.size(); ++i) {
				pdata.Units[i].X = curp[i * 8] | (curp[i * 8 + 1] << 8);
				pdata.Units[i].Y = curp[i * 8 + 2] | (curp[i * 8 + 3] << 8);
				pdata.Units[i].Type = curp[i * 8 + 4];
				pdata.Units[i].Player = curp[i * 8 + 5];
				pdata.Units[i].Data = curp[i * 8 + 6] | (curp[i * 8 + 7] << 8);

				if (pdata.Units[i].Type == UnitHumanStart || pdata.Units[i].Type == UnitOrcStart) {
					pdata.StartX[pdata.Units[i].Player] = pdata.Units[i].X;
					pdata.StartY[pdata.Units[i].Player] = pdata.Units[i].Y;
				}
			}
		} else {
			printf("unknown section: %s, %d\n", header, len);
			return false;
		}
		curp += len;
	}
	return true;
}

// Convert pud to native stratagus format
int PudToStratagus(const unsigned char *puddata, size_t size, const char *name, const char *outdir)
{
	PudData pdata;

	if (pdata.Parse(puddata, size) == false) {
		fprintf(stderr, "invalid pud data\n");
		exit(-1);
	}
	gzFile smpout;
	gzFile smsout;
	char smpname[PATH_MAX];
	char smsname[PATH_MAX];

	strcpy(smpname, outdir);
	strcat(smpname, "/");
	strcat(smpname, name);
	strcat(smpname, ".smp.gz");

	strcpy(smsname, outdir);
	strcat(smsname, "/");
	strcat(smsname, name);
	strcat(smsname, ".sms.gz");

	if (!(smpout = gzopen(smpname, "wb"))) {
		fprintf(stderr, "cannot open smpfile\n");
		return -1;
	}
	if (!(smsout = gzopen(smsname, "wb"))) {
		fprintf(stderr, "cannot open smsfile\n");
		return -1;
	}

	if (strstr(smsname, "campaigns")) {
		pdata.WriteSMP(smpout, smsname);
	} else {
		pdata.WriteSMP(smpout, NULL);
	}
	pdata.WriteSMS(smsout);

	gzclose(smpout);
	gzclose(smsout);
	return 0;
}
