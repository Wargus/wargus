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
/**@name pudconvert.c - convert PUD files to native stratagus format. */
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#include "endian.h"
#include "pud.h"

#ifdef _MSC_VER
#define PATH_MAX _MAX_PATH
#endif


int WriteSMP(const struct PudData * const pdata, FILE *smpout, const char *smsname)
{
	int i;
	char buf[512];
	int num;

	fprintf(smpout, "-- Stratagus Map Presentation\n");
	fprintf(smpout, "-- File generated automatically from pudconvert.\n");
	fprintf(smpout, "\n");

	strcpy(buf, "DefinePlayerTypes(");
	num = pdata->NumPlayers;
	for (i = 0; num; ++i) {
		sprintf(buf + strlen(buf), "\"%s\",", PlayerTypeStrings[pdata->Players[i]]);
		if (pdata->Players[i] != PlayerNobody) {
			--num;
		}
	}
	strcpy(&buf[strlen(buf) - 1], ")\n");
	fprintf(smpout, buf);

	fprintf(smpout, "PresentMap(\"%s\", %d, %d, %d, %d)\n", pdata->Description,
		pdata->NumPlayers, pdata->MapSizeX, pdata->MapSizeY, 1);
	
	return 0;
}

int WriteSMS(const struct PudData * const pdata, FILE *smsout)
{
	int i;
	int num;
	int j;

	num = pdata->NumPlayers;
	for (i = 0; num; ++i) {
		fprintf(smsout, "SetStartView(%d, %d, %d)\n", i,
			pdata->StartX[i], pdata->StartY[i]);
		fprintf(smsout, "SetPlayerData(%d, \"Resources\", \"gold\", %d)\n",
			i, pdata->StartGold[i]);
		fprintf(smsout, "SetPlayerData(%d, \"Resources\", \"wood\", %d)\n",
			i, pdata->StartLumber[i]);
		fprintf(smsout, "SetPlayerData(%d, \"Resources\", \"oil\", %d)\n",
			i, pdata->StartOil[i]);
		if (pdata->Players[i] != PlayerNobody) {
			--num;
		}
	}

	fprintf(smsout, "\n");

	fprintf(smsout, "LoadTileModels(\"scripts/tilesets/%s.lua\")\n\n",
		TilesetTypeStrings[pdata->Tileset]);

	for (j = 0; j < pdata->MapSizeY; ++j) {
		for (i = 0; i < pdata->MapSizeX; ++i) {
			fprintf(smsout, "SetTile(%d, %d, %d)\n",
				pdata->Tiles[j * pdata->MapSizeX + i], i, j);
		}
	}

	fprintf(smsout, "\n");

	for (i = 0; i < pdata->NumUnits; ++i) {
		if (pdata->Units[i].Type == UnitHumanStart ||
				pdata->Units[i].Type == UnitOrcStart) {
			continue;
		}

		fprintf(smsout, "unit = CreateUnit(\"%s\", %d, {%d, %d})\n",
			UnitScriptNames[pdata->Units[i].Type], pdata->Units[i].Player,
			pdata->Units[i].X, pdata->Units[i].Y);
		if (pdata->Units[i].Type == UnitGoldMine || pdata->Units[i].Type == UnitOilPatch) {
			fprintf(smsout, "SetResourcesHeld(unit, %d)\n", pdata->Units[i].Data * 2500);
		}
	}

	return 0;
}

int PudReadHeader(const unsigned char *puddata, char *header, int *len)
{
	unsigned int tmp;

	memcpy(header, puddata, 4);
	header[4] = '\0';

	memcpy(&tmp, puddata + 4, 4);

	*len = ConvertLE32(tmp);

	return 8;
}

int ProcessPud(const unsigned char *puddata, size_t size, FILE *smsout,
	FILE *smpout, const char *smsname)
{
	char header[5];
	int len;
	int i;
	int j;
	const unsigned char *curp;
	struct PudData pdata; 

	pdata.Tiles = NULL;
	curp = puddata;

	curp += PudReadHeader(curp, header, &len);
	if (strcmp(header, "TYPE")) {
		return -1;
	}

	if (strcmp(curp, "WAR2 MAP")) {
		return -1;
	}
	curp += len;

	while (curp - puddata < size) {
		curp += PudReadHeader(curp, header, &len);
		if (!strcmp(header, "VER ")) {
			// nothing useful here, skip it
		} else if (!strcmp(header, "DESC")) {
			strcpy(pdata.Description, curp);
		} else if (!strcmp(header, "OWNR")) {
			pdata.NumPlayers = 0;
			for (i = 0; i < 16; ++i) {
				pdata.Players[i] = curp[i];
				if (pdata.Players[i] != PlayerNobody && pdata.Players[i] != PlayerNeutral) {
					++pdata.NumPlayers;
				}
			}
		} else if (!strcmp(header, "ERA ") || !strcmp(header, "ERAX")) {
			pdata.Tileset = curp[0];
		} else if (!strcmp(header, "DIM ")) {
			pdata.MapSizeX = curp[0] | (curp[1] << 8);
			pdata.MapSizeY = curp[2] | (curp[3] << 8);
		} else if (!strcmp(header, "UDTA")) {
			// FIXME: todo
		} else if (!strcmp(header, "ALOW")) {
			// FIXME: todo
		} else if (!strcmp(header, "UGRD")) {
			// FIXME: todo
		} else if (!strcmp(header, "SIDE")) {
			for (i = 0; i < 16; ++i) {
				pdata.Races[i] = curp[i];
			}
		} else if (!strcmp(header, "SGLD")) {
			for (i = 0; i < 16; ++i) {
				pdata.StartGold[i] = curp[i * 2] | (curp[i * 2 + 1] << 8);
			}
		} else if (!strcmp(header, "SLBR")) {
			for (i = 0; i < 16; ++i) {
				pdata.StartLumber[i] = curp[i * 2] | (curp[i * 2 + 1] << 8);
			}
		} else if (!strcmp(header, "SOIL")) {
			for (i = 0; i < 16; ++i) {
				pdata.StartOil[i] = curp[i * 2] | (curp[i * 2 + 1] << 8);
			}
		} else if (!strcmp(header, "AIPL")) {
			// FIXME: todo
		} else if (!strcmp(header, "MTXM")) {
			pdata.Tiles = malloc(sizeof(*pdata.Tiles) * pdata.MapSizeX * pdata.MapSizeY);

			for (j = 0; j < pdata.MapSizeY; ++j) {
				for (i = 0; i < pdata.MapSizeX; ++i) {
					pdata.Tiles[j * pdata.MapSizeX + i] = curp[j * pdata.MapSizeX * 2 + i * 2] |
						(curp[j * pdata.MapSizeX * 2 + i * 2 + 1] << 8);
				}
			}
		} else if (!strcmp(header, "SQM ")) {
			// FIXME: todo
		} else if (!strcmp(header, "OILM")) {
			// UNUSED
		} else if (!strcmp(header, "REGM")) {
			// FIXME: todo
		} else if (!strcmp(header, "UNIT")) {
			pdata.NumUnits = len / 8;

			pdata.Units = malloc(sizeof(*pdata.Units) * pdata.NumUnits);

			for (i = 0; i < pdata.NumUnits; ++i) {
				pdata.Units[i].X = curp[i * 8] | (curp[i * 8 + 1] << 8);
				pdata.Units[i].Y = curp[i * 8 + 2] | (curp[i * 8 + 3] << 8);
				pdata.Units[i].Type = curp[i * 8 + 4];
				pdata.Units[i].Player = curp[i * 8 + 5];
				pdata.Units[i].Data = curp[i * 8 + 6] | (curp[i * 8 + 7] << 8);

				if (pdata.Units[i].Type == UnitHumanStart ||
						pdata.Units[i].Type == UnitOrcStart) {
					pdata.StartX[pdata.Units[i].Player] = pdata.Units[i].X;
					pdata.StartY[pdata.Units[i].Player] = pdata.Units[i].Y;
				}
			}

			for (i = 0; i < PLAYERMAX; ++i) {
				if (pdata.Players[i] == PlayerNobody || pdata.Players[i] == PlayerNeutral) {
					pdata.StartX[i] = pdata.StartY[i] = 0;
				}
			}
		} else {
			printf("unknown section: %s\n", header);
			return -1;
		}
		curp += len;
	}

	WriteSMP(&pdata, smpout, smsname);
	WriteSMS(&pdata, smsout);

	free(pdata.Units);
	free(pdata.Tiles);

	return 0;
}

// Convert pud to native stratagus format
int PudToStratagus(const unsigned char *puddata, size_t size,
	const char *name, const char *outdir)
{
	FILE *smpout;
	FILE *smsout;
	char smpname[PATH_MAX];
	char smsname[PATH_MAX];

	strcpy(smpname, outdir);
	strcat(smpname, "/");
	strcat(smpname, name);
	strcat(smpname, ".smp");

	strcpy(smsname, outdir);
	strcat(smsname, "/");
	strcat(smsname, name);
	strcat(smsname, ".sms");

	if (!(smpout = fopen(smpname, "wb"))) {
		fprintf(stderr, "cannot open smpfile\n");
		return -1;
	}
	if (!(smsout = fopen(smsname, "wb"))) {
		fprintf(stderr, "cannot open smsfile\n");
		return -1;
	}

	if (ProcessPud(puddata, size, smsout, smpout, strrchr(smsname, '/') + 1)) {
		fprintf(stderr, "invalid pud data\n");
		exit(-1);
	}

	fclose(smpout);
	fclose(smsout);

	return 0;
}
