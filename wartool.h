﻿//       _________ __                 __
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/
//  ______________________                           ______________________
//                        T H E   W A R   B E G I N S
//   Utility for Stratagus - A free fantasy real time strategy game engine
//
/**@name wartool.h - Extract files from war archives. */
//
//      (c) Copyright 1999-2016 by Lutz Sammer, Nehal Mistry, Jimmy Salmon,
//                                 Pali Rohár and cybermind
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; version 2 dated June, 1991.
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
//

#ifndef _WARTOOL_H
#define _WARTOOL_H

/*----------------------------------------------------------------------------
--  General
----------------------------------------------------------------------------*/

#define VERSION "3.2.1" // Version of extractor wartool

const char NameLine[] =
    "wartool V" VERSION
    " for Stratagus, (c) 1998-2021 by The Stratagus Project.\n"
    "  Written by Lutz Sammer, Nehal Mistry, Jimmy Salmon, Pali Rohar and "
    "cybermind.\n"
    "  https://wargus.github.io";

/*----------------------------------------------------------------------------
--  Includes
----------------------------------------------------------------------------*/

#include <cctype>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <png.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <zlib.h>

#include <array>
#include <string>

#if __has_include(<filesystem>)
#include <filesystem>
namespace fs = std::filesystem;
#elif __has_include(<experimental/filesystem>)
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
#else
error "Missing the <filesystem> header."
#endif

#ifdef USE_STORMLIB
#include "StormLib.h"
#endif

//----------------------------------------------------------------------------
//  Config
//----------------------------------------------------------------------------

/**
**		Path to the tileset graphics. (default=$DIR/graphics/tilesets)
*/
#define TILESET_PATH "graphics/tilesets"

/**
**		Path to the unit graphics. (default=$DIR/graphics)
*/
#define GRAPHICS_PATH "graphics"

/**
**		Path the pud files. (default=$DIR)
*/
#define PUD_PATH "."

/**
**		Path the font files. (default=$DIR/graphics/ui/fonts)
*/
#define FONT_PATH "graphics/ui/fonts"

/**
**		Path the cursor files. (default=$DIR/graphic/ui/)
*/
#define CURSOR_PATH "graphics/ui"

/**
**		Path the graphic files. (default=$DIR/graphic)
*/
#define GRAPHIC_PATH "graphics"

/**
**		Path the sound files. (default=$DIR/sounds)
*/
#define SOUND_PATH "sounds"

/**
**		Path the sound files. (default=$DIR/music)
*/
#define MUSIC_PATH "music"

/**
**		Path the text files. (default=$DIR/texts)
*/
#define TEXT_PATH "campaigns"

/**
**		How much tiles are stored in a row.
*/
#define TILE_PER_ROW 16

/**
**  Conversion control sturcture.
*/
struct Control {
    int Type;              /// Entry type
    int Version;           /// Only in this version
    std::string File;      /// Save file
    int Arg1;              /// Extra argument 1
    int Arg2;              /// Extra argument 2
    int Arg3;              /// Extra argument 3
    int Arg4;              /// Extra argument 4
    const std::string MPQFile{}; /// MPQ file
    const std::string ArcFile{}; /// Archive file
};

/**
**  Possible entry types of archive file.
*/
enum _archive_type_ {
    S, // Setup
    F, // File                          (name)
    T, // Tileset                       (name,pal,mega,mini,map)
    R, // RGB -> gimp                   (name,rgb)
    G, // Graphics                      (name,pal,gfx)
    U, // Uncompressed Graphics         (name,pal,gfu)
    D, // Grouped Uncompressed Graphic  (name,pal,gfu,glist)
    P, // Pud                           (name,idx)
    N, // Font                          (name,idx)
    I, // Image                         (name,pal,img)
    W, // Wav                           (name,wav)
    M, // XMI Midi Sound                (name,xmi)
    X, // Text                          (name,text,ofs)
    C, // Cursor                        (name,cursor)
    V, // Video                         (name,video)
    L, // Campaign Levels
    Q  // MPQ archive
};

#define CD_MAC (1)
#define CD_EXPANSION (1 << 1)
#define CD_US (1 << 4)
#define CD_SPANISH (1 << 5)
#define CD_GERMAN (1 << 6)
#define CD_UK (1 << 7) // also Australian
#define CD_ITALIAN (1 << 8)
#define CD_PORTUGUESE (1 << 9)
#define CD_FRENCH (1 << 10)
#define CD_RUSSIAN (1 << 11)

#define CD_UPPER (1 << 13) // Filenames on CD are upper
#define CD_BNE (1 << 14)   // This is a BNE version
#define CD_BNE_CAPS                                                            \
    (1 << 15) // This is a BNE version with capitalized Support folder
#define CD_BNE_UPPER                                                           \
    (1 << 16) // This is a BNE version with upper Support folder

/**
**  What, where, how to extract.
**
**  FIXME: version alpha, demo, 1.00, 1.31, 1.40, 1.50 dependend!
*/

const std::array<std::string, 8> BNEReplaceTable = {
    "maindat.war",          "support/tomes/tome.1", "rezdat.war",
    "support/tomes/tome.2", "snddat.war",           "support/tomes/tome.3",
    "strdat.war",           "support/tomes/tome.4"
};

const std::array<std::string, 8> BNEReplaceTableCaps = {
    "maindat.war",          "Support/TOMES/TOME.1", "rezdat.war",
    "Support/TOMES/TOME.2", "snddat.war",           "Support/TOMES/TOME.3",
    "strdat.war",           "Support/TOMES/TOME.4"
};

static Control Todo[] = {
#define __ , 0, 0, 0, "", ""
#define _2 , 0, 0, "", ""

    ///////////////////////////////////////////////////////////////////////////////
    //		TEXT		(must be done for all others!)
    ///////////////////////////////////////////////////////////////////////////////
    {F, 0, "rezdat.war", 3000 __},
    {I, 0, "ui/Credits_background", 27, 28 _2},

    {F, 0, "strdat.war", 4000 __},
    {S, 0, "unit_names", 1 __},
    {L, 0, "objectives", 54, 236 _2},
    //{X,0,"human/dialog",                                   55 __},
    //{X,0,"orc/dialog",                                     56 __},
    {X, 0, "credits", 58, 4 _2},

    {X, 0, "human/level01h", 65, 4 _2},
    {X, 0, "orc/level01o", 66, 4 _2},
    {X, 0, "human/level02h", 67, 4 _2},
    {X, 0, "orc/level02o", 68, 4 _2},
    {X, 0, "human/level03h", 69, 4 _2},
    {X, 0, "orc/level03o", 70, 4 _2},
    {X, 0, "human/level04h", 71, 4 _2},
    {X, 0, "orc/level04o", 72, 4 _2},
    {X, 0, "human/level05h", 73, 4 _2},
    {X, 0, "orc/level05o", 74, 4 _2},
    {X, 0, "human/level06h", 75, 4 _2},
    {X, 0, "orc/level06o", 76, 4 _2},
    {X, 0, "human/level07h", 77, 4 _2},
    {X, 0, "orc/level07o", 78, 4 _2},
    {X, 0, "human/level08h", 79, 4 _2},
    {X, 0, "orc/level08o", 80, 4 _2},
    {X, 0, "human/level09h", 81, 4 _2},
    {X, 0, "orc/level09o", 82, 4 _2},
    {X, 0, "human/level10h", 83, 4 _2},
    {X, 0, "orc/level10o", 84, 4 _2},
    {X, 0, "human/level11h", 85, 4 _2},
    {X, 0, "orc/level11o", 86, 4 _2},
    {X, 0, "human/level12h", 87, 4 _2},
    {X, 0, "orc/level12o", 88, 4 _2},
    {X, 0, "human/level13h", 89, 4 _2},
    {X, 0, "orc/level13o", 90, 4 _2},
    {X, 0, "human/level14h", 91, 4 _2},
    {X, 0, "orc/level14o", 92, 4 _2},
    {X, 2, "human-exp/levelx01h", 99, 4 _2},
    {X, 2, "orc-exp/levelx01o", 100, 4 _2},
    {X, 2, "human-exp/levelx02h", 101, 4 _2},
    {X, 2, "orc-exp/levelx02o", 102, 4 _2},
    {X, 2, "human-exp/levelx03h", 103, 4 _2},
    {X, 2, "orc-exp/levelx03o", 104, 4 _2},
    {X, 2, "human-exp/levelx04h", 105, 4 _2},
    {X, 2, "orc-exp/levelx04o", 106, 4 _2},
    {X, 2, "human-exp/levelx05h", 107, 4 _2},
    {X, 2, "orc-exp/levelx05o", 108, 4 _2},
    {X, 2, "human-exp/levelx06h", 109, 4 _2},
    {X, 2, "orc-exp/levelx06o", 110, 4 _2},
    {X, 2, "human-exp/levelx07h", 111, 4 _2},
    {X, 2, "orc-exp/levelx07o", 112, 4 _2},
    {X, 2, "human-exp/levelx08h", 113, 4 _2},
    {X, 2, "orc-exp/levelx08o", 114, 4 _2},
    {X, 2, "human-exp/levelx09h", 115, 4 _2},
    {X, 2, "orc-exp/levelx09o", 116, 4 _2},
    {X, 2, "human-exp/levelx10h", 117, 4 _2},
    {X, 2, "orc-exp/levelx10o", 118, 4 _2},
    {X, 2, "human-exp/levelx11h", 119, 4 _2},
    {X, 2, "orc-exp/levelx11o", 120, 4 _2},
    {X, 2, "human-exp/levelx12h", 121, 4 _2},
    {X, 2, "orc-exp/levelx12o", 122, 4 _2},
    {X, 2, "credits2", 123, 4 _2},
    //{X,2,"credits-ext",                                    124 __},
    {X, 3, "human/victory", 93, 6 _2},
    {X, 3, "orc/victory", 93, 556 _2},
    {X, 2, "human/victory", 93, 10 _2},
    {X, 2, "orc/victory", 93, 560 _2},
    {X, 2, "human-exp/victory", 93, 1086 _2},
    {X, 2, "orc-exp/victory", 93, 1840 _2},

    ///////////////////////////////////////////////////////////////////////////////
    //		MOST THINGS
    ///////////////////////////////////////////////////////////////////////////////

    {F, 0, "maindat.war", 1000 __},

    {R, 0, "summer/summer", 2 __},
    {T, 0, "summer/terrain/summer", 2, 3, 4, 5},
    {R, 0, "wasteland/wasteland", 10 __},
    {T, 0, "wasteland/terrain/wasteland", 10, 11, 12, 13},
    {R, 3, "swamp/swamp", 10 __},
    {T, 3, "swamp/terrain/swamp", 10, 11, 12, 13},
    {R, 0, "winter/winter", 18 __},
    {T, 0, "winter/terrain/winter", 18, 19, 20, 21},

    {G, 0, "human/units/%16", 2, 33 _2},
    {G, 0, "orc/units/%17", 2, 34 _2},
    {G, 0, "human/units/%44", 2, 35 _2},
    {G, 0, "orc/units/%45", 2, 36 _2},
    {G, 0, "orc/units/%47", 2, 37 _2},
    {G, 0, "human/units/%42", 2, 38 _2},
    {G, 0, "human/units/%-30", 2, 39 _2},
    {G, 0, "orc/units/%-31", 2, 40 _2},
    {G, 0, "human/units/%34", 2, 41 _2},
    {G, 0, "orc/units/%35", 2, 42 _2},
    {G, 0, "human/units/%40", 2, 43 _2},
    {G, 0, "orc/units/%41", 2, 44 _2},
    {G, 0, "human/units/%2", 2, 45 _2},
    {G, 0, "orc/units/%3", 2, 46 _2},
    {G, 0, "human/units/%4", 2, 47 _2},
    {G, 0, "orc/units/%5", 2, 48 _2},
    {G, 0, "human/units/%6", 2, 49 _2},
    {G, 0, "orc/units/%7", 2, 50 _2},
    {G, 0, "human/units/%8", 2, 51 _2},
    {G, 0, "orc/units/%9", 2, 52 _2},
    {G, 0, "human/units/%10", 2, 53 _2},
    {G, 0, "orc/units/%11", 2, 54 _2},
    {G, 0, "human/units/%12", 2, 55 _2},
    {G, 0, "orc/units/%13", 2, 58 _2},
    {G, 0, "human/units/%-28_empty", 2, 59 _2},
    {G, 0, "orc/units/%-29_empty", 2, 60 _2},
    {G, 0, "human/units/%32", 2, 61 _2},
    {G, 0, "orc/units/%33", 2, 62 _2},
    {G, 0, "orc/units/%43", 2, 63 _2},
    {G, 0, "tilesets/summer/neutral/units/%59", 2, 64 _2},
    {G, 0, "tilesets/wasteland/neutral/units/%59", 10, 65 _2},
    {G, 3, "tilesets/swamp/neutral/units/%59", 10, 65 _2},
    {G, 0, "tilesets/winter/neutral/units/%59", 18, 66 _2},
    {G, 0, "neutral/units/%57", 2, 69 _2},
    {G, 0, "neutral/units/%58", 2, 70 _2},
    // 71-79 unknown
    {G, 0, "tilesets/summer/human/buildings/%-98", 2, 80 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-99", 2, 81 _2},
    {G, 0, "tilesets/summer/human/buildings/%-100", 2, 82 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-101", 2, 83 _2},
    {G, 0, "tilesets/summer/human/buildings/%82", 2, 84 _2},
    {G, 0, "tilesets/summer/orc/buildings/%83", 2, 85 _2},
    {G, 0, "tilesets/summer/human/buildings/%90", 2, 86 _2},
    {G, 0, "tilesets/summer/orc/buildings/%91", 2, 87 _2},
    {G, 0, "tilesets/summer/human/buildings/%72", 2, 88 _2},
    {G, 0, "tilesets/summer/orc/buildings/%73", 2, 89 _2},
    {G, 0, "tilesets/summer/human/buildings/%70", 2, 90 _2},
    {G, 0, "tilesets/summer/orc/buildings/%71", 2, 91 _2},
    {G, 0, "tilesets/summer/human/buildings/%60", 2, 92 _2},
    {G, 0, "tilesets/summer/orc/buildings/%61", 2, 93 _2},
    {G, 0, "tilesets/summer/human/buildings/%-62", 2, 94 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-63", 2, 95 _2},
    {G, 0, "tilesets/summer/human/buildings/%64", 2, 96 _2},
    {G, 0, "tilesets/summer/orc/buildings/%65", 2, 97 _2},
    {G, 0, "tilesets/summer/human/buildings/%66", 2, 98 _2},
    {G, 0, "tilesets/summer/orc/buildings/%67", 2, 99 _2},
    {G, 0, "tilesets/summer/human/buildings/%76", 2, 100 _2},
    {G, 0, "tilesets/summer/orc/buildings/%77", 2, 101 _2},
    {G, 0, "tilesets/summer/human/buildings/%78", 2, 102 _2},
    {G, 0, "tilesets/summer/orc/buildings/%79", 2, 103 _2},
    {G, 0, "tilesets/summer/human/buildings/%68", 2, 104 _2},
    {G, 0, "tilesets/summer/orc/buildings/%69", 2, 105 _2},
    {G, 0, "tilesets/summer/human/buildings/%-84", 2, 106 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-85", 2, 107 _2},
    {G, 0, "tilesets/summer/human/buildings/%-74", 2, 108 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-75", 2, 109 _2},
    {G, 0, "tilesets/summer/human/buildings/%-80", 2, 110 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-81", 2, 111 _2},
    {G, 0, "tilesets/summer/human/buildings/%-86", 2, 112 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-87", 2, 113 _2},
    {G, 0, "tilesets/summer/human/buildings/%-88", 2, 114 _2},
    {G, 0, "tilesets/summer/orc/buildings/%-89", 2, 115 _2},
    {G, 0, "tilesets/summer/human/buildings/%92", 2, 116 _2},
    {G, 0, "tilesets/summer/orc/buildings/%93", 2, 117 _2},
    {G, 0, "tilesets/summer/neutral/buildings/%95", 2, 118 _2},
    {G, 0, "tilesets/summer/neutral/buildings/%94", 2, 119 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-98", 2, 80 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-99", 2, 81 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-100", 2, 82 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-101", 2, 83 _2},
    {G, 3, "tilesets/swamp/human/buildings/%82", 2, 84 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%83", 2, 85 _2},
    {G, 3, "tilesets/swamp/human/buildings/%90", 2, 86 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%91", 2, 87 _2},
    {G, 3, "tilesets/swamp/human/buildings/%72", 2, 88 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%73", 2, 89 _2},
    {G, 3, "tilesets/swamp/human/buildings/%70", 2, 90 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%71", 2, 91 _2},
    {G, 3, "tilesets/swamp/human/buildings/%60", 2, 92 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%61", 2, 93 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-62", 2, 94 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-63", 2, 95 _2},
    {G, 3, "tilesets/swamp/human/buildings/%64", 2, 96 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%65", 2, 97 _2},
    {G, 3, "tilesets/swamp/human/buildings/%66", 2, 98 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%67", 2, 99 _2},
    {G, 3, "tilesets/swamp/human/buildings/%76", 2, 100 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%77", 2, 101 _2},
    {G, 3, "tilesets/swamp/human/buildings/%78", 2, 102 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%79", 2, 103 _2},
    {G, 3, "tilesets/swamp/human/buildings/%68", 2, 104 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%69", 2, 105 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-84", 2, 106 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-85", 2, 107 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-74", 2, 108 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-75", 2, 109 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-80", 2, 110 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-81", 2, 111 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-86", 2, 112 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-87", 2, 113 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-88", 2, 114 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-89", 2, 115 _2},
    {G, 3, "tilesets/swamp/human/buildings/%92", 2, 116 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%93", 2, 117 _2},
    {G, 0, "neutral/units/corpses", 2, 120 _2},
    {G, 0, "tilesets/summer/neutral/buildings/destroyed_site", 2, 121 _2},
    // Hardcoded support for worker with resource repairing
    {G, 0, "human/units/%4_with_wood", 2, 122, 47, 25},
    {G, 0, "orc/units/%5_with_wood", 2, 123, 48, 25},
    {G, 0, "human/units/%4_with_gold", 2, 124, 47, 25},
    {G, 0, "orc/units/%5_with_gold", 2, 125, 48, 25},
    {G, 0, "human/units/%-28_full", 2, 126 _2},
    {G, 0, "orc/units/%-29_full", 2, 127 _2},
    {G, 0, "tilesets/winter/human/buildings/%90", 18, 128 _2},
    {G, 0, "tilesets/winter/orc/buildings/%91", 18, 129 _2},
    {G, 0, "tilesets/winter/human/buildings/%72", 18, 130 _2},
    {G, 0, "tilesets/winter/orc/buildings/%73", 18, 131 _2},
    {G, 0, "tilesets/winter/human/buildings/%70", 18, 132 _2},
    {G, 0, "tilesets/winter/orc/buildings/%71", 18, 133 _2},
    {G, 0, "tilesets/winter/human/buildings/%60", 18, 134 _2},
    {G, 0, "tilesets/winter/orc/buildings/%61", 18, 135 _2},
    {G, 0, "tilesets/winter/human/buildings/%-62", 18, 136 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-63", 18, 137 _2},
    {G, 0, "tilesets/winter/human/buildings/%64", 18, 138 _2},
    {G, 0, "tilesets/winter/orc/buildings/%65", 18, 139 _2},
    {G, 0, "tilesets/winter/human/buildings/%66", 18, 140 _2},
    {G, 0, "tilesets/winter/orc/buildings/%67", 18, 141 _2},
    {G, 0, "tilesets/winter/human/buildings/%76", 18, 142 _2},
    {G, 0, "tilesets/winter/orc/buildings/%77", 18, 143 _2},
    {G, 0, "tilesets/winter/human/buildings/%78", 18, 144 _2},
    {G, 0, "tilesets/winter/orc/buildings/%79", 18, 145 _2},
    {G, 0, "tilesets/winter/human/buildings/%68", 18, 146 _2},
    {G, 0, "tilesets/winter/orc/buildings/%69", 18, 147 _2},
    {G, 0, "tilesets/winter/human/buildings/%-84", 18, 148 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-85", 18, 149 _2},
    {G, 0, "tilesets/winter/human/buildings/%-74", 18, 150 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-75", 18, 151 _2},
    {G, 0, "tilesets/winter/human/buildings/%-80", 18, 152 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-81", 18, 153 _2},
    {G, 0, "tilesets/winter/human/buildings/%-86", 18, 154 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-87", 18, 155 _2},
    {G, 0, "tilesets/winter/human/buildings/%-88", 18, 156 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-89", 18, 157 _2},
    {G, 0, "tilesets/winter/human/buildings/%92", 18, 158 _2},
    {G, 0, "tilesets/winter/orc/buildings/%93", 18, 159 _2},
    {G, 0, "tilesets/winter/human/buildings/%82", 18, 160 _2},
    {G, 0, "tilesets/winter/orc/buildings/%83", 18, 161 _2},
    {G, 0, "tilesets/winter/neutral/buildings/%94", 18, 162 _2},
    {G, 0, "tilesets/winter/neutral/buildings/destroyed_site", 18, 163 _2},
    {G, 0, "human/x_startpoint", 2, 164 _2},
    {G, 0, "orc/o_startpoint", 2, 165 _2},
    {G, 0, "neutral/buildings/%102", 2, 166 _2},
    {G, 0, "tilesets/summer/neutral/buildings/%103", 2, 167 _2},
    {G, 0, "tilesets/summer/neutral/buildings/%105", 2, 168 _2},
    {G, 0, "tilesets/winter/human/buildings/%-98", 18, 169 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-99", 18, 170 _2},
    {G, 0, "tilesets/winter/human/buildings/%-100", 18, 171 _2},
    {G, 0, "tilesets/winter/orc/buildings/%-101", 18, 172 _2},
    {G, 0, "tilesets/wasteland/human/buildings/%60", 10, 173 _2},
    {G, 0, "tilesets/wasteland/orc/buildings/%61", 10, 174 _2},
    {G, 0, "tilesets/wasteland/human/buildings/%78", 10, 175 _2},
    {G, 0, "tilesets/wasteland/orc/buildings/%79", 10, 176 _2},
    {G, 0, "tilesets/wasteland/human/buildings/%-88", 10, 177 _2},
    {G, 0, "tilesets/wasteland/orc/buildings/%-89", 10, 178 _2},
    {G, 0, "tilesets/wasteland/neutral/buildings/%94", 10, 179 _2},
    {G, 0, "tilesets/wasteland/neutral/buildings/%95", 10, 180 _2},
    {G, 3, "tilesets/swamp/human/buildings/%60", 10, 173 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%61", 10, 174 _2},
    {G, 3, "tilesets/swamp/human/buildings/%78", 10, 175 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%79", 10, 176 _2},
    {G, 3, "tilesets/swamp/human/buildings/%-88", 10, 177 _2},
    {G, 3, "tilesets/swamp/orc/buildings/%-89", 10, 178 _2},
    {G, 3, "tilesets/swamp/neutral/buildings/%94", 10, 179 _2},
    {G, 3, "tilesets/swamp/neutral/buildings/%95", 10, 180 _2},
    {G, 0, "neutral/buildings/%104", 2, 181 _2},
    {G, 0, "tilesets/wasteland/human/units/%40", 10, 182 _2},
    {G, 0, "tilesets/wasteland/orc/units/%41", 10, 183 _2},
    {G, 3, "tilesets/swamp/human/units/%40", 10, 182 _2},
    {G, 3, "tilesets/swamp/orc/units/%41", 10, 183 _2},
    {G, 0, "tilesets/winter/neutral/buildings/%103", 18, 184 _2},
    {G, 0, "tilesets/wasteland/neutral/buildings/%103", 10, 185 _2},
    {G, 3, "tilesets/swamp/neutral/buildings/%103", 10, 185 _2},
    {G, 3, "tilesets/swamp/neutral/buildings/%104", 2, 181 _2},
    {G, 0, "tilesets/winter/neutral/buildings/%104", 18, 186 _2},
    {U, 0, "ui/gold,wood,oil,mana", 2, 187 _2},
    {
        G, 0, "tilesets/wasteland/neutral/buildings/small_destroyed_site", 10,
        188 _2
    },
    {G, 3, "tilesets/swamp/neutral/buildings/small_destroyed_site", 10, 188 _2},
    {G, 0, "tilesets/summer/neutral/buildings/small_destroyed_site", 2, 189 _2},
    {
        G, 0, "tilesets/winter/neutral/buildings/small_destroyed_site", 18,
        190 _2
    },
    {G, 0, "tilesets/wasteland/neutral/buildings/destroyed_site", 10, 191 _2},
    {G, 3, "tilesets/swamp/neutral/buildings/destroyed_site", 10, 191 _2},
    //--------------------------------------------------
    {P, 0, "campaigns/human/level01h", 192 __},
    {P, 0, "campaigns/orc/level01o", 193 __},
    {P, 0, "campaigns/human/level02h", 194 __},
    {P, 0, "campaigns/orc/level02o", 195 __},
    {P, 0, "campaigns/human/level03h", 196 __},
    {P, 0, "campaigns/orc/level03o", 197 __},
    {P, 0, "campaigns/human/level04h", 198 __},
    {P, 0, "campaigns/orc/level04o", 199 __},
    {P, 0, "campaigns/human/level05h", 200 __},
    {P, 0, "campaigns/orc/level05o", 201 __},
    {P, 0, "campaigns/human/level06h", 202 __},
    {P, 0, "campaigns/orc/level06o", 203 __},
    {P, 0, "campaigns/human/level07h", 204 __},
    {P, 0, "campaigns/orc/level07o", 205 __},
    {P, 0, "campaigns/human/level08h", 206 __},
    {P, 0, "campaigns/orc/level08o", 207 __},
    {P, 0, "campaigns/human/level09h", 208 __},
    {P, 0, "campaigns/orc/level09o", 209 __},
    {P, 0, "campaigns/human/level10h", 210 __},
    {P, 0, "campaigns/orc/level10o", 211 __},
    {P, 0, "campaigns/human/level11h", 212 __},
    {P, 0, "campaigns/orc/level11o", 213 __},
    {P, 0, "campaigns/human/level12h", 214 __},
    {P, 0, "campaigns/orc/level12o", 215 __},
    {P, 0, "campaigns/human/level13h", 216 __},
    {P, 0, "campaigns/orc/level13o", 217 __},
    {P, 0, "campaigns/human/level14h", 218 __},
    {P, 0, "campaigns/orc/level14o", 219 __},
    // --------------------------------------------------
    {P, 0, "maps/skirmish/(6)gold-separates-east-west", 220 __},
    {P, 0, "maps/skirmish/(4)oil-is-the-key", 221 __},
    {P, 0, "maps/skirmish/(8)bridge-to-bridge-combat", 222 __},
    {P, 0, "maps/skirmish/(8)plains-of-snow", 223 __},
    {P, 0, "maps/skirmish/(3)three-ways-to-cross", 224 __},
    {P, 0, "maps/skirmish/(8)a-continent-to-explore", 225 __},
    {P, 0, "maps/skirmish/(8)high-seas-combat", 226 __},
    {P, 0, "maps/skirmish/(4)islands-in-the-stream", 227 __},
    {P, 0, "maps/skirmish/(4)opposing-city-states", 228 __},
    {P, 0, "maps/skirmish/(4)death-in-the-middle", 229 __},
    {P, 0, "maps/skirmish/(5)the-spiral", 230 __},
    {P, 0, "maps/skirmish/(2)mysterious-dragon-isle", 231 __},
    {P, 0, "maps/skirmish/(4)the-four-corners", 232 __},
    {P, 0, "maps/skirmish/(6)no-way-out-of-this-maze", 233 __},
    {P, 0, "maps/skirmish/(8)fierce-ocean-combat", 234 __},
    {P, 0, "maps/skirmish/(2)cross-the-streams", 235 __},
    {P, 0, "maps/skirmish/(5)how-much-can-you-mine", 236 __},
    {P, 0, "maps/skirmish/(2)x-marks-the-spot", 237 __},
    {P, 0, "maps/skirmish/(2)one-way-in-one-way-out", 238 __},
    {P, 0, "maps/skirmish/(4)nowhere-to-run", 239 __},
    {P, 0, "maps/skirmish/(2)2-players", 240 __},
    {P, 0, "maps/skirmish/(7)and-the-rivers-ran-as-blood", 241 __},
    {P, 0, "maps/skirmish/(3)critter-attack", 242 __},
    {P, 0, "maps/skirmish/(6)skull-isle", 243 __},
    {P, 0, "maps/skirmish/(8)cross-over", 244 __},
    {P, 0, "maps/skirmish/(8)garden-of-war", 245 __},
    {P, 0, "maps/skirmish/(4)mine-the-center", 246 __},
    {P, 0, "maps/skirmish/(3)river-fork", 247 __},
    // -------------------------------------------------
    {P, 0, "maps/demo/demo01", 248 __},
    {P, 0, "maps/demo/demo02", 249 __},
    {P, 0, "maps/demo/demo03", 250 __},
    {P, 0, "maps/demo/demo04", 251 __},
    // --------------------------------------------------
    {G, 0, "neutral/buildings/land_construction_site", 2, 252 _2},
    {G, 0, "human/buildings/shipyard_construction_site", 2, 253 _2},
    {G, 0, "orc/buildings/shipyard_construction_site", 2, 254 _2},
    {
        G, 3, "tilesets/swamp/neutral/buildings/land_construction_site", 2,
        252 _2
    },
    {
        G, 3, "tilesets/swamp/human/buildings/shipyard_construction_site", 2,
        253 _2
    },
    {
        G, 3, "tilesets/swamp/orc/buildings/shipyard_construction_site", 2,
        254 _2
    },
    {
        G, 0, "tilesets/summer/human/buildings/oil_well_construction_site", 2,
        255 _2
    },
    {
        G, 0, "tilesets/summer/orc/buildings/oil_well_construction_site", 2,
        256 _2
    },
    {G, 0, "human/buildings/refinery_construction_site", 2, 257 _2},
    {G, 0, "orc/buildings/refinery_construction_site", 2, 258 _2},
    {G, 0, "human/buildings/foundry_construction_site", 2, 259 _2},
    {G, 0, "orc/buildings/foundry_construction_site", 2, 260 _2},
    {
        G, 3, "tilesets/swamp/human/buildings/refinery_construction_site", 2,
        257 _2
    },
    {
        G, 3, "tilesets/swamp/orc/buildings/refinery_construction_site", 2,
        258 _2
    },
    {
        G, 3, "tilesets/swamp/human/buildings/foundry_construction_site", 2,
        259 _2
    },
    {G, 3, "tilesets/swamp/orc/buildings/foundry_construction_site", 2, 260 _2},
    {
        G, 0, "tilesets/summer/neutral/buildings/wall_construction_site", 2,
        261 _2
    },
    {
        G, 0, "tilesets/winter/neutral/buildings/land_construction_site", 18,
        262 _2
    },
    {
        G, 0, "tilesets/winter/human/buildings/shipyard_construction_site", 18,
        263 _2
    },
    {
        G, 0, "tilesets/winter/orc/buildings/shipyard_construction_site", 18,
        264 _2
    },
    {
        G, 0, "tilesets/winter/human/buildings/oil_well_construction_site", 18,
        265 _2
    },
    {
        G, 0, "tilesets/winter/orc/buildings/oil_well_construction_site", 18,
        266 _2
    },
    {
        G, 0, "tilesets/winter/human/buildings/refinery_construction_site", 18,
        267 _2
    },
    {
        G, 0, "tilesets/winter/orc/buildings/refinery_construction_site", 18,
        268 _2
    },
    {
        G, 0, "tilesets/winter/human/buildings/foundry_construction_site", 18,
        269 _2
    },
    {
        G, 0, "tilesets/winter/orc/buildings/foundry_construction_site", 18,
        270 _2
    },
    {
        G, 0, "tilesets/wasteland/human/buildings/oil_well_construction_site", 10,
        271 _2
    },
    {
        G, 0, "tilesets/wasteland/orc/buildings/oil_well_construction_site", 10,
        272 _2
    },
    {
        G, 3, "tilesets/swamp/human/buildings/oil_platform_construction_site", 10,
        271 _2
    },
    {
        G, 3, "tilesets/swamp/orc/buildings/oil_platform_construction_site", 10,
        272 _2
    },
    {G, 0, "tilesets/winter/neutral/buildings/wall", 18, 273 _2},
    {G, 0, "tilesets/wasteland/neutral/buildings/wall", 10, 274 _2},
    {G, 3, "tilesets/swamp/neutral/buildings/wall", 10, 274 _2},
    {
        G, 0, "tilesets/winter/neutral/buildings/wall_construction_site", 18,
        275 _2
    },
    {
        G, 0, "tilesets/wasteland/neutral/buildings/wall_construction_site", 10,
        276 _2
    },
    {
        G, 3, "tilesets/swamp/neutral/buildings/wall_construction_site", 10,
        276 _2
    },
    // 277 Control programs for computer player AI
    // 278 Control programs for unit movement
    // --------------------------------------------------
    {N, 0, "large_episode_titles", 279 __},
    {N, 0, "small_episode_titles", 280 __},
    {N, 0, "large", 281 __},
    {N, 0, "game", 282 __},
    {N, 0, "small", 283 __},
    // --------------------------------------------------
    {I, 0, "ui/human/menubutton", 2, 293 _2},
    {I, 0, "ui/orc/menubutton", 2, 294 _2},
    {I, 0, "ui/human/minimap", 2, 295 _2},
    {I, 0, "ui/orc/minimap", 2, 296 _2},
    {I, 0, "ui/title", 300, 299 _2},
    // 284-286 unknown
    // --------------------------------------------------
    {I, 0, "ui/human/resource", 2, 287 _2},
    {I, 0, "ui/orc/resource", 2, 288 _2},
    {I, 0, "ui/human/filler-right", 2, 289 _2},
    {I, 0, "ui/orc/filler-right", 2, 290 _2},
    {I, 0, "ui/human/statusline", 2, 291 _2},
    {I, 0, "ui/orc/statusline", 2, 292 _2},
    {I, 0, "ui/human/buttonpanel", 2, 297 _2},
    {I, 0, "ui/orc/buttonpanel", 2, 298 _2},
    // --------------------------------------------------
    {C, 0, "human/cursors/human_gauntlet", 2, 301 _2},
    {C, 0, "orc/cursors/orcish_claw", 2, 302 _2},
    {C, 0, "human/cursors/human_dont_click_here", 2, 303 _2},
    {C, 0, "orc/cursors/orcish_dont_click_here", 2, 304 _2},
    {C, 0, "human/cursors/yellow_eagle", 2, 305 _2},
    {C, 0, "orc/cursors/yellow_crosshairs", 2, 306 _2},
    {C, 0, "human/cursors/red_eagle", 2, 307 _2},
    {C, 0, "orc/cursors/red_crosshairs", 2, 308 _2},
    {C, 0, "human/cursors/green_eagle", 2, 309 _2},
    {C, 0, "orc/cursors/green_crosshairs", 2, 310 _2},
    {C, 0, "cursors/magnifying_glass", 2, 311 _2},
    {C, 0, "cursors/small_green_cross", 2, 312 _2},
    {C, 0, "cursors/hourglass", 2, 313 _2},
    {C, 0, "cursors/credits_arrow", 27, 314 _2},
    {C, 0, "cursors/arrow_N", 2, 315 _2},
    {C, 0, "cursors/arrow_NE", 2, 316 _2},
    {C, 0, "cursors/arrow_E", 2, 317 _2},
    {C, 0, "cursors/arrow_SE", 2, 318 _2},
    {C, 0, "cursors/arrow_S", 2, 319 _2},
    {C, 0, "cursors/arrow_SW", 2, 320 _2},
    {C, 0, "cursors/arrow_W", 2, 321 _2},
    {C, 0, "cursors/arrow_NW", 2, 322 _2},
    {U, 0, "ui/bloodlust,haste,slow,invisible,shield", 2, 323 _2},
    // --------------------------------------------------------
    {G, 0, "missiles/lightning", 2, 324 _2},
    {G, 0, "missiles/gryphon_hammer", 2, 325 _2},
    // "fireball (also dragon breath)"
    {G, 0, "missiles/dragon_breath", 2, 326 _2},
    // "fireball (when casting flameshield)"
    {G, 0, "missiles/fireball", 2, 327 _2},
    {G, 0, "missiles/flame_shield", 2, 328 _2},
    {G, 0, "missiles/blizzard", 2, 329 _2},
    {G, 0, "missiles/death_and_decay", 2, 330 _2},
    {G, 0, "missiles/big_cannon", 2, 331 _2},
    {G, 0, "missiles/exorcism", 2, 332 _2},
    {G, 0, "missiles/heal_effect", 2, 333 _2},
    {G, 0, "missiles/touch_of_death", 2, 334 _2},
    {G, 0, "missiles/rune", 2, 335 _2},
    {G, 0, "missiles/tornado", 2, 336 _2},
    {G, 0, "missiles/catapult_rock", 2, 337 _2},
    {G, 0, "missiles/ballista_bolt", 2, 338 _2},
    {G, 0, "missiles/arrow", 2, 339 _2},
    {G, 0, "missiles/axe", 2, 340 _2},
    {G, 0, "missiles/submarine_missile", 2, 341 _2},
    {G, 0, "missiles/turtle_missile", 2, 342 _2},
    {G, 0, "missiles/small_fire", 2, 343 _2},
    {G, 0, "missiles/big_fire", 2, 344 _2},
    {G, 0, "missiles/ballista-catapult_impact", 2, 345 _2},
    {G, 0, "missiles/normal_spell", 2, 346 _2},
    {G, 0, "missiles/explosion", 2, 347 _2},
    {G, 0, "missiles/cannon", 2, 348 _2},
    {G, 0, "missiles/cannon_explosion", 2, 349 _2},
    {G, 0, "missiles/cannon-tower_explosion", 2, 350 _2},
    {G, 0, "missiles/daemon_fire", 2, 351 _2},
    {G, 0, "missiles/green_cross", 2, 352 _2},
    {G, 0, "missiles/unit_shadow", 2, 353 _2},
    {U, 0, "ui/human/infopanel", 2, 354 _2},
    {U, 0, "ui/orc/infopanel", 2, 355 _2},
    {G, 0, "tilesets/summer/icons", 2, 356 _2},
    {G, 0, "tilesets/winter/icons", 18, 357 _2},
    {G, 0, "tilesets/wasteland/icons", 10, 358 _2},
    {G, 3, "tilesets/swamp/icons", 10, 358 _2},

    {I, 0, "ui/human/victory", 363, 359 _2},
    {I, 0, "ui/orc/victory", 364, 360 _2},
    {I, 0, "ui/human/defeat", 365, 361 _2},
    {I, 0, "ui/orc/defeat", 366, 362 _2},

    {I, 0, "../campaigns/human/interface/introscreen1", 367, 369 _2},
    {I, 0, "../campaigns/orc/interface/introscreen1", 368, 370 _2},
    {I, 0, "../campaigns/orc/interface/introscreen2", 368, 371 _2},
    {I, 0, "../campaigns/orc/interface/introscreen3", 368, 372 _2},
    {I, 0, "../campaigns/orc/interface/introscreen4", 368, 373 _2},
    {I, 0, "../campaigns/orc/interface/introscreen5", 368, 374 _2},
    {I, 0, "../campaigns/human/interface/introscreen2", 367, 375 _2},
    {I, 0, "../campaigns/human/interface/introscreen3", 367, 376 _2},
    {I, 0, "../campaigns/human/interface/introscreen4", 367, 377 _2},
    {I, 0, "../campaigns/human/interface/introscreen5", 367, 378 _2},

    {W, 0, "ui/click", 432 __},
    {W, 0, "human/act", 433 __},
    {W, 0, "orc/act", 434 __},
    {W, 0, "ui/highclick", 435 __},
    {W, 0, "ui/statsthump", 436 __},

    {M, 0, "Human Battle 1", 413 __},
    {M, 0, "Human Battle 2", 414 __},
    {M, 0, "Human Battle 3", 415 __},
    {M, 0, "Human Battle 4", 416 __},
    {M, 0, "Orc Battle 1", 417 __},
    {M, 0, "Orc Battle 2", 418 __},
    {M, 0, "Orc Battle 3", 419 __},
    {M, 0, "Orc Battle 4", 420 __},
    {M, 0, "Human Defeat", 421 __},
    {M, 0, "Orc Defeat", 422 __},
    {M, 0, "Human Victory", 423 __},
    {M, 0, "Orc Victory", 424 __},
    {M, 0, "Orc Battle 5", 425 __},
    {M, 0, "I'm a Medieval Man", 426 __},
    {M, 0, "Human Battle 5", 427 __},
    {M, 0, "Human Briefing", 428 __},
    {M, 0, "Orc Briefing", 429 __},
    {M, 0, "Main Menu", 429 __},

    {V, 0, "videos/logo", 430 __},

    {R, 2, "swamp/swamp", 438 __},
    {T, 2, "swamp/terrain/swamp", 438, 439, 440, 441, "", ""},

    // --------------------------------------------------
    {P, 2, "campaigns/human-exp/levelx01h", 446 __},
    {P, 2, "campaigns/orc-exp/levelx01o", 447 __},
    {P, 2, "campaigns/human-exp/levelx02h", 448 __},
    {P, 2, "campaigns/orc-exp/levelx02o", 449 __},
    {P, 2, "campaigns/human-exp/levelx03h", 450 __},
    {P, 2, "campaigns/orc-exp/levelx03o", 451 __},
    {P, 2, "campaigns/human-exp/levelx04h", 452 __},
    {P, 2, "campaigns/orc-exp/levelx04o", 453 __},
    {P, 2, "campaigns/human-exp/levelx05h", 454 __},
    {P, 2, "campaigns/orc-exp/levelx05o", 455 __},
    {P, 2, "campaigns/human-exp/levelx06h", 456 __},
    {P, 2, "campaigns/orc-exp/levelx06o", 457 __},
    {P, 2, "campaigns/human-exp/levelx07h", 458 __},
    {P, 2, "campaigns/orc-exp/levelx07o", 459 __},
    {P, 2, "campaigns/human-exp/levelx08h", 460 __},
    {P, 2, "campaigns/orc-exp/levelx08o", 461 __},
    {P, 2, "campaigns/human-exp/levelx09h", 462 __},
    {P, 2, "campaigns/orc-exp/levelx09o", 463 __},
    {P, 2, "campaigns/human-exp/levelx10h", 464 __},
    {P, 2, "campaigns/orc-exp/levelx10o", 465 __},
    {P, 2, "campaigns/human-exp/levelx11h", 466 __},
    {P, 2, "campaigns/orc-exp/levelx11o", 467 __},
    {P, 2, "campaigns/human-exp/levelx12h", 468 __},
    {P, 2, "campaigns/orc-exp/levelx12o", 469 __},
    // ------------------------------------------
    {G, 2, "tilesets/swamp/neutral/units/%59", 438, 470 _2},
    {G, 2, "tilesets/swamp/icons", 438, 471 _2},
    // 472: default UDTA for expansion PUDs
    {G, 2, "tilesets/swamp/human/buildings/%90", 438, 473 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%91", 438, 474 _2},
    {G, 2, "tilesets/swamp/human/buildings/%72", 438, 475 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%73", 438, 476 _2},
    {G, 2, "tilesets/swamp/human/buildings/%70", 438, 477 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%71", 438, 478 _2},
    {G, 2, "tilesets/swamp/human/buildings/%60", 438, 479 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%61", 438, 480 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-62", 438, 481 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-63", 438, 482 _2},
    {G, 2, "tilesets/swamp/human/buildings/%64", 438, 483 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%65", 438, 484 _2},
    {G, 2, "tilesets/swamp/human/buildings/%66", 438, 485 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%67", 438, 486 _2},
    {G, 2, "tilesets/swamp/human/buildings/%76", 438, 487 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%77", 438, 488 _2},
    {G, 2, "tilesets/swamp/human/buildings/%78", 438, 489 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%79", 438, 490 _2},
    {G, 2, "tilesets/swamp/human/buildings/%68", 438, 491 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%69", 438, 492 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-84", 438, 493 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-85", 438, 494 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-74", 438, 495 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-75", 438, 496 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-80", 438, 497 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-81", 438, 498 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-86", 438, 499 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-87", 438, 500 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-88", 438, 501 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-89", 438, 502 _2},
    {G, 2, "tilesets/swamp/human/buildings/%92", 438, 503 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%93", 438, 504 _2},
    {G, 2, "tilesets/swamp/human/buildings/%82", 438, 505 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%83", 438, 506 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-98", 438, 507 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-99", 438, 508 _2},
    {G, 2, "tilesets/swamp/human/buildings/%-100", 438, 509 _2},
    {G, 2, "tilesets/swamp/orc/buildings/%-101", 438, 510 _2},
    {G, 2, "tilesets/swamp/neutral/buildings/%94", 438, 511 _2},
    {G, 2, "tilesets/swamp/neutral/buildings/destroyed_site", 438, 512 _2},
    {G, 2, "tilesets/swamp/neutral/buildings/%103", 438, 513 _2},
    {G, 2, "tilesets/swamp/neutral/buildings/%104", 438, 514 _2},
    {G, 2, "tilesets/swamp/neutral/buildings/%95", 438, 515 _2},
    {
        G, 2, "tilesets/swamp/human/buildings/%-74_construction_site", 438,
        516 _2
    },
    {G, 2, "tilesets/swamp/orc/buildings/%-75_construction_site", 438, 517 _2},
    {
        G, 2, "tilesets/swamp/human/buildings/%-88_construction_site", 438,
        518 _2
    },
    {G, 2, "tilesets/swamp/orc/buildings/%-89_construction_site", 438, 519 _2},
    {
        G, 2, "tilesets/swamp/human/buildings/%-86_construction_site", 438,
        520 _2
    },
    {G, 2, "tilesets/swamp/orc/buildings/%-87_construction_site", 438, 521 _2},
    {
        G, 2, "tilesets/swamp/human/buildings/%-80_construction_site", 438,
        522 _2
    },
    {G, 2, "tilesets/swamp/orc/buildings/%-81_construction_site", 438, 523 _2},
    {
        G, 2, "tilesets/swamp/neutral/buildings/small_destroyed_site", 438,
        524 _2
    },
    {G, 2, "tilesets/swamp/neutral/buildings/%102", 438, 525 _2},
    {G, 2, "tilesets/swamp/human/units/%40", 438, 526 _2},
    {G, 2, "tilesets/swamp/orc/units/%41", 438, 527 _2},

    ///////////////////////////////////////////////////////////////////////////////
    //		SOUNDS
    ///////////////////////////////////////////////////////////////////////////////

    {F, 4, "sfxdat.sud", 5000 __},

    // 0 file length
    // 1 description
    {W, 4, "ui/placement_error", 2 __},
    {W, 4, "ui/placement_success", 3 __},
    {W, 4, "misc/building_construction", 4 __},
    {W, 4, "human/basic_voices/selected/1", 5 __},
    {W, 4, "orc/basic_voices/selected/1", 6 __},
    {W, 4, "human/basic_voices/selected/2", 7 __},
    {W, 4, "orc/basic_voices/selected/2", 8 __},
    {W, 4, "human/basic_voices/selected/3", 9 __},
    {W, 4, "orc/basic_voices/selected/3", 10 __},
    {W, 4, "human/basic_voices/selected/4", 11 __},
    {W, 4, "orc/basic_voices/selected/4", 12 __},
    {W, 4, "human/basic_voices/selected/5", 13 __},
    {W, 4, "orc/basic_voices/selected/5", 14 __},
    {W, 4, "human/basic_voices/selected/6", 15 __},
    {W, 4, "orc/basic_voices/selected/6", 16 __},
    {W, 4, "human/basic_voices/annoyed/1", 17 __},
    {W, 4, "orc/basic_voices/annoyed/1", 18 __},
    {W, 4, "human/basic_voices/annoyed/2", 19 __},
    {W, 4, "orc/basic_voices/annoyed/2", 20 __},
    {W, 4, "human/basic_voices/annoyed/3", 21 __},
    {W, 4, "orc/basic_voices/annoyed/3", 22 __},
    {W, 4, "human/basic_voices/annoyed/4", 23 __},
    {W, 4, "orc/basic_voices/annoyed/4", 24 __},
    {W, 4, "human/basic_voices/annoyed/5", 25 __},
    {W, 4, "orc/basic_voices/annoyed/5", 26 __},
    {W, 4, "human/basic_voices/annoyed/6", 27 __},
    {W, 4, "orc/basic_voices/annoyed/6", 28 __},
    {W, 4, "human/basic_voices/annoyed/7", 29 __},
    {W, 4, "orc/basic_voices/annoyed/7", 30 __},
    {W, 4, "misc/explosion", 31 __},
    {W, 4, "human/basic_voices/acknowledgement/1", 32 __},
    {W, 4, "orc/basic_voices/acknowledgement/1", 33 __},
    {W, 4, "human/basic_voices/acknowledgement/2", 34 __},
    {W, 4, "orc/basic_voices/acknowledgement/2", 35 __},
    {W, 4, "human/basic_voices/acknowledgement/3", 36 __},
    {W, 4, "orc/basic_voices/acknowledgement/3", 37 __},
    {W, 4, "human/basic_voices/acknowledgement/4", 38 __},
    {W, 4, "orc/basic_voices/acknowledgement/4", 39 __},
    {W, 4, "human/basic_voices/work_complete", 40 __},
    {W, 4, "orc/basic_voices/work_complete", 41 __},
    {W, 4, "human/units/peasant/work_complete", 42 __},
    {W, 4, "human/basic_voices/ready", 43 __},
    {W, 4, "orc/basic_voices/ready", 44 __},
    {W, 4, "human/basic_voices/help/1", 45 __},
    {W, 4, "orc/basic_voices/help/1", 46 __},
    {W, 4, "human/basic_voices/help/2", 47 __},
    {W, 4, "orc/basic_voices/help/2", 48 __},
    {W, 4, "human/basic_voices/dead", 49 __},
    {W, 4, "orc/basic_voices/dead", 50 __},
    {W, 4, "ships/sinking", 51 __},
    {W, 4, "misc/building_explosion/1", 52 __},
    {W, 4, "misc/building_explosion/2", 53 __},
    {W, 4, "misc/building_explosion/3", 54 __},
    {W, 4, "missiles/catapult-ballista_attack", 55 __},
    {W, 4, "misc/tree_chopping/1", 56 __},
    {W, 4, "misc/tree_chopping/2", 57 __},
    {W, 4, "misc/tree_chopping/3", 58 __},
    {W, 4, "misc/tree_chopping/4", 59 __},
    {W, 4, "missiles/sword_attack/1", 60 __},
    {W, 4, "missiles/sword_attack/2", 61 __},
    {W, 4, "missiles/sword_attack/3", 62 __},
    {W, 4, "missiles/punch", 63 __},
    {W, 4, "missiles/fireball_hit", 64 __},
    {W, 4, "missiles/fireball_throw", 65 __},
    {W, 4, "missiles/bow_throw", 66 __},
    {W, 4, "missiles/bow_hit", 67 __},
    {W, 4, "spells/basic_spell_sound", 68 __},
    {W, 4, "buildings/blacksmith", 69 __},
    {W, 4, "human/buildings/church", 70 __},
    {W, 4, "orc/buildings/altar_of_storms", 71 __},
    {W, 4, "human/buildings/stables", 72 __},
    {W, 4, "orc/buildings/ogre_mound", 73 __},
    {W, 4, "human/buildings/farm", 74 __},
    {W, 4, "orc/buildings/pig_farm", 75 __},
    {W, 4, "neutral/buildings/gold_mine", 76 __},
    {W, 4, "missiles/axe_throw", 77 __},
    {W, 4, "ships/tanker/acknowledgement/1", 78 __},
    {W, 4, "missiles/fist", 79 __},
    {W, 4, "buildings/shipyard", 80 __},
    {W, 4, "human/units/peasant/attack", 81 __},
    {W, 4, "buildings/oil_platform", 82 __},
    {W, 4, "buildings/oil_refinery", 83 __},
    {W, 4, "buildings/lumbermill", 84 __},
    {W, 4, "misc/transport_docking", 85 __},
    {W, 4, "misc/burning", 86 __},
    {W, 4, "human/buildings/gryphon_aviary", 87 __},
    {W, 4, "orc/buildings/dragon_roost", 88 __},
    {W, 4, "buildings/foundry", 89 __},
    {W, 4, "human/buildings/gnomish_inventor", 90 __},
    {W, 4, "orc/buildings/goblin_alchemist", 91 __},
    {W, 4, "human/buildings/mage_tower", 92 __},
    {W, 4, "orc/buildings/temple_of_the_damned", 93 __},
    {W, 4, "human/capture", 94 __},
    {W, 4, "orc/capture", 95 __},
    {W, 4, "human/rescue", 96 __},
    {W, 4, "orc/rescue", 97 __},
    {W, 4, "spells/bloodlust", 98 __},
    {W, 4, "spells/death_and_decay", 99 __},
    {W, 4, "spells/death_coil", 100 __},
    {W, 4, "spells/exorcism", 101 __},
    {W, 4, "spells/flame_shield", 102 __},
    {W, 4, "spells/haste", 103 __},
    {W, 4, "spells/healing", 104 __},
    {W, 4, "spells/holy_vision", 105 __},
    {W, 4, "spells/blizzard", 106 __},
    {W, 4, "spells/invisibility", 107 __},
    {W, 4, "spells/eye_of_kilrogg", 108 __},
    {W, 4, "spells/polymorph", 109 __},
    {W, 4, "spells/slow", 110 __},
    {W, 4, "spells/lightning", 111 __},
    {W, 4, "spells/touch_of_darkness", 112 __},
    {W, 4, "spells/unholy_armor", 113 __},
    {W, 4, "spells/whirlwind", 114 __},
    {W, 4, "orc/peon/ready", 115 __},
    {W, 4, "orc/units/death_knight/annoyed/1", 116 __},
    {W, 4, "orc/units/death_knight/annoyed/2", 117 __},
    {W, 4, "orc/units/death_knight/annoyed/3", 118 __},
    {W, 4, "orc/units/death_knight/ready", 119 __},
    {W, 4, "orc/units/death_knight/selected/1", 120 __},
    {W, 4, "orc/units/death_knight/selected/2", 121 __},
    {W, 4, "orc/units/death_knight/acknowledgement/1", 122 __},
    {W, 4, "orc/units/death_knight/acknowledgement/2", 123 __},
    {W, 4, "orc/units/death_knight/acknowledgement/3", 124 __},
    {W, 4, "human/units/dwarven_demolition_squad/annoyed/1", 125 __},
    {W, 4, "human/units/dwarven_demolition_squad/annoyed/2", 126 __},
    {W, 4, "human/units/dwarven_demolition_squad/annoyed/3", 127 __},
    {W, 4, "human/units/dwarven_demolition_squad/ready", 128 __},
    {W, 4, "human/units/dwarven_demolition_squad/selected/1", 129 __},
    {W, 4, "human/units/dwarven_demolition_squad/selected/2", 130 __},
    {W, 4, "human/units/dwarven_demolition_squad/acknowledgement/1", 131 __},
    {W, 4, "human/units/dwarven_demolition_squad/acknowledgement/2", 132 __},
    {W, 4, "human/units/dwarven_demolition_squad/acknowledgement/3", 133 __},
    {W, 4, "human/units/dwarven_demolition_squad/acknowledgement/4", 134 __},
    {W, 4, "human/units/dwarven_demolition_squad/acknowledgement/5", 135 __},
    {W, 4, "human/units/elven_archer-ranger/annoyed/1", 136 __},
    {W, 4, "human/units/elven_archer-ranger/annoyed/2", 137 __},
    {W, 4, "human/units/elven_archer-ranger/annoyed/3", 138 __},
    {W, 4, "human/units/elven_archer-ranger/ready", 139 __},
    {W, 4, "human/units/elven_archer-ranger/selected/1", 140 __},
    {W, 4, "human/units/elven_archer-ranger/selected/2", 141 __},
    {W, 4, "human/units/elven_archer-ranger/selected/3", 142 __},
    {W, 4, "human/units/elven_archer-ranger/selected/4", 143 __},
    {W, 4, "human/units/elven_archer-ranger/acknowledgement/1", 144 __},
    {W, 4, "human/units/elven_archer-ranger/acknowledgement/2", 145 __},
    {W, 4, "human/units/elven_archer-ranger/acknowledgement/3", 146 __},
    {W, 4, "human/units/elven_archer-ranger/acknowledgement/4", 147 __},
    {W, 4, "human/units/gnomish_flying_machine/annoyed/1", 148 __},
    {W, 4, "human/units/gnomish_flying_machine/annoyed/2", 149 __},
    {W, 4, "human/units/gnomish_flying_machine/annoyed/3", 150 __},
    {W, 4, "human/units/gnomish_flying_machine/annoyed/4", 151 __},
    {W, 4, "human/units/gnomish_flying_machine/annoyed/5", 152 __},
    {W, 4, "human/units/gnomish_flying_machine/ready", 153 __},
    {W, 4, "human/units/gnomish_flying_machine/acknowledgement/1", 154 __},
    {W, 4, "orc/units/goblin_sappers/annoyed/1", 155 __},
    {W, 4, "orc/units/goblin_sappers/annoyed/2", 156 __},
    {W, 4, "orc/units/goblin_sappers/annoyed/3", 157 __},
    {W, 4, "orc/units/goblin_sappers/ready", 158 __},
    {W, 4, "orc/units/goblin_sappers/selected/1", 159 __},
    {W, 4, "orc/units/goblin_sappers/selected/2", 160 __},
    {W, 4, "orc/units/goblin_sappers/selected/3", 161 __},
    {W, 4, "orc/units/goblin_sappers/selected/4", 162 __},
    {W, 4, "orc/units/goblin_sappers/acknowledgement/1", 163 __},
    {W, 4, "orc/units/goblin_sappers/acknowledgement/2", 164 __},
    {W, 4, "orc/units/goblin_sappers/acknowledgement/3", 165 __},
    {W, 4, "orc/units/goblin_sappers/acknowledgement/4", 166 __},
    {W, 4, "orc/units/goblin_zeppelin/annoyed/1", 167 __},
    {W, 4, "orc/units/goblin_zeppelin/annoyed/2", 168 __},
    {W, 4, "orc/units/goblin_zeppelin/ready", 169 __},
    {W, 4, "orc/units/goblin_zeppelin/acknowledgement/1", 170 __},
    {W, 4, "human/units/knight/annoyed/1", 171 __},
    {W, 4, "human/units/knight/annoyed/2", 172 __},
    {W, 4, "human/units/knight/annoyed/3", 173 __},
    {W, 4, "human/units/knight/ready", 174 __},
    {W, 4, "human/units/knight/selected/1", 175 __},
    {W, 4, "human/units/knight/selected/2", 176 __},
    {W, 4, "human/units/knight/selected/3", 177 __},
    {W, 4, "human/units/knight/selected/4", 178 __},
    {W, 4, "human/units/knight/acknowledgement/1", 179 __},
    {W, 4, "human/units/knight/acknowledgement/2", 180 __},
    {W, 4, "human/units/knight/acknowledgement/3", 181 __},
    {W, 4, "human/units/knight/acknowledgement/4", 182 __},
    {W, 4, "human/units/paladin/annoyed/1", 183 __},
    {W, 4, "human/units/paladin/annoyed/2", 184 __},
    {W, 4, "human/units/paladin/annoyed/3", 185 __},
    {W, 4, "human/units/paladin/ready", 186 __},
    {W, 4, "human/units/paladin/selected/1", 187 __},
    {W, 4, "human/units/paladin/selected/2", 188 __},
    {W, 4, "human/units/paladin/selected/3", 189 __},
    {W, 4, "human/units/paladin/selected/4", 190 __},
    {W, 4, "human/units/paladin/acknowledgement/1", 191 __},
    {W, 4, "human/units/paladin/acknowledgement/2", 192 __},
    {W, 4, "human/units/paladin/acknowledgement/3", 193 __},
    {W, 4, "human/units/paladin/acknowledgement/4", 194 __},
    {W, 4, "orc/units/ogre/annoyed/1", 195 __},
    {W, 4, "orc/units/ogre/annoyed/2", 196 __},
    {W, 4, "orc/units/ogre/annoyed/3", 197 __},
    {W, 4, "orc/units/ogre/annoyed/4", 198 __},
    {W, 4, "orc/units/ogre/annoyed/5", 199 __},
    {W, 4, "orc/units/ogre/ready", 200 __},
    {W, 4, "orc/units/ogre/selected/1", 201 __},
    {W, 4, "orc/units/ogre/selected/2", 202 __},
    {W, 4, "orc/units/ogre/selected/3", 203 __},
    {W, 4, "orc/units/ogre/selected/4", 204 __},
    {W, 4, "orc/units/ogre/acknowledgement/1", 205 __},
    {W, 4, "orc/units/ogre/acknowledgement/2", 206 __},
    {W, 4, "orc/units/ogre/acknowledgement/3", 207 __},
    {W, 4, "orc/units/ogre-mage/annoyed/1", 208 __},
    {W, 4, "orc/units/ogre-mage/annoyed/2", 209 __},
    {W, 4, "orc/units/ogre-mage/annoyed/3", 210 __},
    {W, 4, "orc/units/ogre-mage/ready", 211 __},
    {W, 4, "orc/units/ogre-mage/selected/1", 212 __},
    {W, 4, "orc/units/ogre-mage/selected/2", 213 __},
    {W, 4, "orc/units/ogre-mage/selected/3", 214 __},
    {W, 4, "orc/units/ogre-mage/selected/4", 215 __},
    {W, 4, "orc/units/ogre-mage/acknowledgement/1", 216 __},
    {W, 4, "orc/units/ogre-mage/acknowledgement/2", 217 __},
    {W, 4, "orc/units/ogre-mage/acknowledgement/3", 218 __},
    {W, 4, "human/ships/annoyed/1", 219 __},
    {W, 4, "orc/ships/annoyed/1", 220 __},
    {W, 4, "human/ships/annoyed/2", 221 __},
    {W, 4, "orc/ships/annoyed/2", 222 __},
    {W, 4, "human/ships/annoyed/3", 223 __},
    {W, 4, "orc/ships/annoyed/3", 224 __},
    {W, 4, "human/ships/ready", 225 __},
    {W, 4, "orc/ships/ready", 226 __},
    {W, 4, "human/ships/selected/1", 227 __},
    {W, 4, "orc/ships/selected/1", 228 __},
    {W, 4, "human/ships/selected/2", 229 __},
    {W, 4, "orc/ships/selected/2", 230 __},
    {W, 4, "human/ships/selected/3", 231 __},
    {W, 4, "orc/ships/selected/3", 232 __},
    {W, 4, "human/ships/acknowledgement/1", 233 __},
    {W, 4, "orc/ships/acknowledgement/1", 234 __},
    {W, 4, "human/ships/acknowledgement/2", 235 __},
    {W, 4, "orc/ships/acknowledgement/2", 236 __},
    {W, 4, "human/ships/acknowledgement/3", 237 __},
    {W, 4, "orc/ships/acknowledgement/3", 238 __},
    {W, 4, "human/ships/gnomish_submarine/annoyed/1", 239 __},
    {W, 4, "human/ships/gnomish_submarine/annoyed/2", 240 __},
    {W, 4, "human/ships/gnomish_submarine/annoyed/3", 241 __},
    {W, 4, "human/ships/gnomish_submarine/annoyed/4", 242 __},
    {W, 4, "orc/units/troll_axethrower-berserker/annoyed/1", 243 __},
    {W, 4, "orc/units/troll_axethrower-berserker/annoyed/2", 244 __},
    {W, 4, "orc/units/troll_axethrower-berserker/annoyed/3", 245 __},
    {W, 4, "orc/units/troll_axethrower-berserker/ready", 246 __},
    {W, 4, "orc/units/troll_axethrower-berserker/selected/1", 247 __},
    {W, 4, "orc/units/troll_axethrower-berserker/selected/2", 248 __},
    {W, 4, "orc/units/troll_axethrower-berserker/selected/3", 249 __},
    {W, 4, "orc/units/troll_axethrower-berserker/acknowledgement/1", 250 __},
    {W, 4, "orc/units/troll_axethrower-berserker/acknowledgement/2", 251 __},
    {W, 4, "orc/units/troll_axethrower-berserker/acknowledgement/3", 252 __},
    {W, 4, "human/units/mage/annoyed/1", 253 __},
    {W, 4, "human/units/mage/annoyed/2", 254 __},
    {W, 4, "human/units/mage/annoyed/3", 255 __},
    {W, 4, "human/units/mage/ready", 256 __},
    {W, 4, "human/units/mage/selected/1", 257 __},
    {W, 4, "human/units/mage/selected/2", 258 __},
    {W, 4, "human/units/mage/selected/3", 259 __},
    {W, 4, "human/units/mage/acknowledgement/1", 260 __},
    {W, 4, "human/units/mage/acknowledgement/2", 261 __},
    {W, 4, "human/units/mage/acknowledgement/3", 262 __},
    {W, 4, "human/units/peasant/ready", 263 __},
    {W, 4, "human/units/peasant/annoyed/1", 264 __},
    {W, 4, "human/units/peasant/annoyed/2", 265 __},
    {W, 4, "human/units/peasant/annoyed/3", 266 __},
    {W, 4, "human/units/peasant/annoyed/4", 267 __},
    {W, 4, "human/units/peasant/annoyed/5", 268 __},
    {W, 4, "human/units/peasant/annoyed/6", 269 __},
    {W, 4, "human/units/peasant/annoyed/7", 270 __},
    {W, 4, "human/units/peasant/selected/1", 271 __},
    {W, 4, "human/units/peasant/selected/2", 272 __},
    {W, 4, "human/units/peasant/selected/3", 273 __},
    {W, 4, "human/units/peasant/selected/4", 274 __},
    {W, 4, "human/units/peasant/acknowledgement/1", 275 __},
    {W, 4, "human/units/peasant/acknowledgement/2", 276 __},
    {W, 4, "human/units/peasant/acknowledgement/3", 277 __},
    {W, 4, "human/units/peasant/acknowledgement/4", 278 __},
    {W, 4, "orc/units/dragon/ready", 279 __},
    {W, 4, "orc/units/dragon/selected/1", 280 __},
    {W, 4, "orc/units/dragon/acknowledgement/1", 281 __},
    {W, 4, "orc/units/dragon/acknowledgement/2", 282 __},
    {W, 4, "human/units/gryphon_rider/selected/1", 283 __},
    {W, 4, "human/units/gryphon_rider/ready", 284 __},
    {W, 4, "human/units/gryphon_rider/acknowledgement/1", 284 __},
    {W, 4, "human/units/gryphon_rider/acknowledgement/2", 285 __},
    {W, 4, "neutral/units/sheep/selected/1", 286 __},
    {W, 4, "neutral/units/sheep/annoyed/1", 287 __},
    {W, 4, "neutral/units/seal/selected/1", 288 __},
    {W, 4, "neutral/units/seal/annoyed/1", 289 __},
    {W, 4, "neutral/units/pig/selected/1", 290 __},
    {W, 4, "neutral/units/pig/annoyed/1", 291 __},
    {W, 4, "units/catapult-ballista/acknowledgement/1", 292 __},
    {W, 6, "human/units/alleria/annoyed/1", 293 __},
    {W, 6, "human/units/alleria/annoyed/2", 294 __},
    {W, 6, "human/units/alleria/annoyed/3", 295 __},
    {W, 6, "human/units/alleria/selected/1", 296 __},
    {W, 6, "human/units/alleria/selected/2", 297 __},
    {W, 6, "human/units/alleria/selected/3", 298 __},
    {W, 6, "human/units/alleria/acknowledgement/1", 299 __},
    {W, 6, "human/units/alleria/acknowledgement/2", 300 __},
    {W, 6, "human/units/alleria/acknowledgement/3", 301 __},
    {W, 6, "human/units/danath/annoyed/1", 302 __},
    {W, 6, "human/units/danath/annoyed/2", 303 __},
    {W, 6, "human/units/danath/annoyed/3", 304 __},
    {W, 6, "human/units/danath/selected/1", 305 __},
    {W, 6, "human/units/danath/selected/2", 306 __},
    {W, 6, "human/units/danath/selected/3", 307 __},
    {W, 6, "human/units/danath/acknowledgement/1", 308 __},
    {W, 6, "human/units/danath/acknowledgement/2", 309 __},
    {W, 6, "human/units/danath/acknowledgement/3", 310 __},
    {W, 6, "human/units/khadgar/annoyed/1", 311 __},
    {W, 6, "human/units/khadgar/annoyed/2", 312 __},
    {W, 6, "human/units/khadgar/annoyed/3", 313 __},
    {W, 6, "human/units/khadgar/selected/1", 314 __},
    {W, 6, "human/units/khadgar/selected/2", 315 __},
    {W, 6, "human/units/khadgar/selected/3", 316 __},
    {W, 6, "human/units/khadgar/acknowledgement/1", 317 __},
    {W, 6, "human/units/khadgar/acknowledgement/2", 318 __},
    {W, 6, "human/units/khadgar/acknowledgement/3", 319 __},
    {W, 6, "human/units/kurdan/annoyed/1", 320 __},
    {W, 6, "human/units/kurdan/annoyed/2", 321 __},
    {W, 6, "human/units/kurdan/annoyed/3", 322 __},
    {W, 6, "human/units/kurdan/selected/1", 323 __},
    {W, 6, "human/units/kurdan/selected/2", 324 __},
    {W, 6, "human/units/kurdan/selected/3", 325 __},
    {W, 6, "human/units/kurdan/acknowledgement/1", 326 __},
    {W, 6, "human/units/kurdan/acknowledgement/2", 327 __},
    {W, 6, "human/units/kurdan/acknowledgement/3", 328 __},
    {W, 6, "human/units/turalyon/annoyed/1", 329 __},
    {W, 6, "human/units/turalyon/annoyed/2", 330 __},
    {W, 6, "human/units/turalyon/annoyed/3", 331 __},
    {W, 6, "human/units/turalyon/selected/1", 332 __},
    {W, 6, "human/units/turalyon/selected/2", 333 __},
    {W, 6, "human/units/turalyon/selected/3", 334 __},
    {W, 6, "human/units/turalyon/acknowledgement/1", 335 __},
    {W, 6, "human/units/turalyon/acknowledgement/2", 336 __},
    {W, 6, "human/units/turalyon/acknowledgement/3", 337 __},
    {W, 6, "orc/units/deathwing/annoyed/1", 338 __},
    {W, 6, "orc/units/deathwing/annoyed/2", 339 __},
    {W, 6, "orc/units/deathwing/annoyed/3", 340 __},
    {W, 6, "orc/units/deathwing/selected/1", 341 __},
    {W, 6, "orc/units/deathwing/selected/2", 342 __},
    {W, 6, "orc/units/deathwing/selected/3", 343 __},
    {W, 6, "orc/units/deathwing/acknowledgement/1", 344 __},
    {W, 6, "orc/units/deathwing/acknowledgement/2", 345 __},
    {W, 6, "orc/units/deathwing/acknowledgement/3", 346 __},
    {W, 6, "orc/units/dentarg/annoyed/1", 347 __},
    {W, 6, "orc/units/dentarg/annoyed/2", 348 __},
    {W, 6, "orc/units/dentarg/annoyed/3", 349 __},
    {W, 6, "orc/units/dentarg/selected/1", 350 __},
    {W, 6, "orc/units/dentarg/selected/2", 351 __},
    {W, 6, "orc/units/dentarg/selected/3", 352 __},
    {W, 6, "orc/units/dentarg/acknowledgement/1", 353 __},
    {W, 6, "orc/units/dentarg/acknowledgement/2", 354 __},
    {W, 6, "orc/units/dentarg/acknowledgement/3", 355 __},
    {W, 6, "orc/units/grom_hellscream/annoyed/1", 356 __},
    {W, 6, "orc/units/grom_hellscream/annoyed/2", 357 __},
    {W, 6, "orc/units/grom_hellscream/annoyed/3", 358 __},
    {W, 6, "orc/units/grom_hellscream/selected/1", 359 __},
    {W, 6, "orc/units/grom_hellscream/selected/2", 360 __},
    {W, 6, "orc/units/grom_hellscream/selected/3", 361 __},
    {W, 6, "orc/units/grom_hellscream/acknowledgement/1", 362 __},
    {W, 6, "orc/units/grom_hellscream/acknowledgement/2", 363 __},
    {W, 6, "orc/units/grom_hellscream/acknowledgement/3", 364 __},
    {W, 6, "orc/units/korgath_bladefist/annoyed/1", 365 __},
    {W, 6, "orc/units/korgath_bladefist/annoyed/2", 366 __},
    {W, 6, "orc/units/korgath_bladefist/annoyed/3", 367 __},
    {W, 6, "orc/units/korgath_bladefist/selected/1", 368 __},
    {W, 6, "orc/units/korgath_bladefist/selected/2", 369 __},
    {W, 6, "orc/units/korgath_bladefist/selected/3", 370 __},
    {W, 6, "orc/units/korgath_bladefist/acknowledgement/1", 371 __},
    {W, 6, "orc/units/korgath_bladefist/acknowledgement/2", 372 __},
    {W, 6, "orc/units/korgath_bladefist/acknowledgement/3", 373 __},
    {W, 6, "orc/units/teron_gorefiend/annoyed/1", 374 __},
    {W, 6, "orc/units/teron_gorefiend/annoyed/2", 375 __},
    {W, 6, "orc/units/teron_gorefiend/annoyed/3", 376 __},
    {W, 6, "orc/units/teron_gorefiend/selected/1", 377 __},
    {W, 6, "orc/units/teron_gorefiend/selected/2", 378 __},
    {W, 6, "orc/units/teron_gorefiend/selected/3", 379 __},
    {W, 6, "orc/units/teron_gorefiend/acknowledgement/1", 380 __},
    {W, 6, "orc/units/teron_gorefiend/acknowledgement/2", 381 __},
    {W, 6, "orc/units/teron_gorefiend/acknowledgement/3", 382 __},
    {W, 6, "neutral/units/warthog/selected/1", 383 __},
    {W, 6, "neutral/units/warthog/annoyed/1", 384 __},

    ///////////////////////////////////////////////////////////////////////////////
    //		INTERFACE
    ///////////////////////////////////////////////////////////////////////////////

    {F, 0, "rezdat.war", 3000 __},

    // palette 27 for the first 3 frames, 14 for the rest
    {D, 0, "ui/human/widgets", 27, 0, 0, 0, "", ""},
    {D, 0, "ui/orc/widgets", 27, 1, 0, 0, "", ""},
    // (correct palette is #2 in maindat)
    {U, 0, "ui/buttons_1", 14, 0 _2},
    // (correct palette is #2 in maindat)
    {U, 0, "ui/buttons_2", 14, 1 _2},
    {I, 0, "ui/cd-icon", 14, 2 _2},
    {I, 0, "ui/human/panel_1", 14, 3 _2},
    {I, 0, "ui/orc/panel_1", 14, 4 _2},
    {I, 0, "ui/human/panel_2", 14, 5 _2},
    {I, 0, "ui/orc/panel_2", 14, 6 _2},
    {I, 0, "ui/human/panel_3", 14, 7 _2},
    {I, 0, "ui/orc/panel_3", 14, 8 _2},
    {I, 0, "ui/human/panel_4", 14, 9 _2},
    {I, 0, "ui/orc/panel_4", 14, 10 _2},
    {I, 0, "ui/human/panel_5", 14, 11 _2},
    {I, 0, "ui/orc/panel_5", 14, 12 _2},
    {I, 0, "ui/Menu_background_with_title", 14, 13 _2},
    {I, 0, "ui/Menu_background_without_title", 16, 15 _2},
    {
        I, 0, "../campaigns/human/interface/Act_I_-_Shores_of_Lordareon", 17,
        19 _2
    },
    {I, 0, "../campaigns/orc/interface/Act_I_-_Seas_of_Blood", 17, 20 _2},
    {I, 0, "../campaigns/human/interface/Act_II_-_Khaz_Modan", 17, 21 _2},
    {I, 0, "../campaigns/orc/interface/Act_II_-_Khaz_Modan", 17, 22 _2},
    {I, 0, "../campaigns/human/interface/Act_III_-_The_Northlands", 17, 23 _2},
    {I, 0, "../campaigns/orc/interface/Act_III_-_Quel'Thalas", 17, 24 _2},
    {
        I, 0, "../campaigns/human/interface/Act_IV_-_Return_to_Azeroth", 17,
        25 _2
    },
    {I, 0, "../campaigns/orc/interface/Act_IV_-_Tides_of_Darkness", 17, 26 _2},

    {I, 0, "ui/human/The_End", 27, 29 _2},
    {I, 0, "ui/orc/Smashing_of_Lordaeron_scroll", 32, 30 _2},
    {I, 2, "ui/Patch", 14, 91 _2},
    {I, 2, "ui/Credits_for_extension_background", 93, 94 _2},
    {
        I, 2, "../campaigns/human-exp/interface/Act_I_-_A_Time_for_Heroes", 17,
        96 _2
    },
    {
        I, 2, "../campaigns/orc-exp/interface/Act_I_-_Draenor,_the_Red_World", 17,
        97 _2
    },
    {
        I, 2, "../campaigns/human-exp/interface/Act_II_-_Draenor,_the_Red_World",
        17, 98 _2
    },
    {
        I, 2, "../campaigns/orc-exp/interface/Act_II_-_The_Burning_of_Azeroth", 17,
        99 _2
    },
    {
        I, 2, "../campaigns/human-exp/interface/Act_III_-_War_in_the_Shadows", 17,
        100 _2
    },
    {
        I, 2, "../campaigns/orc-exp/interface/Act_III_-_The_Great_Sea", 17,
        101 _2
    },
    {
        I, 2, "../campaigns/human-exp/interface/Act_IV_-_The_Measure_of_Valor", 17,
        102 _2
    },
    {
        I, 2, "../campaigns/orc-exp/interface/Act_IV_-_Prelude_to_New_Worlds", 17,
        103 _2
    },

    ///////////////////////////////////////////////////////////////////////////////
    //		SPEECH INTROS
    ///////////////////////////////////////////////////////////////////////////////

    // FIXME: this file contains different data, if expansion or not.
    // FIXME: Where and what are the expansion entries

    {F, 0, "snddat.war", 2000 __},
    {W, 0, "../campaigns/human/victory", 2 __},
    {W, 0, "../campaigns/orc/victory", 3 __},
    {W, 0, "../campaigns/human/level01h-intro1", 4 __},
    {W, 0, "../campaigns/human/level01h-intro2", 5 __},
    {W, 0, "../campaigns/human/level02h-intro1", 6 __},
    {W, 0, "../campaigns/human/level02h-intro2", 7 __},
    {W, 0, "../campaigns/human/level03h-intro1", 8 __},
    {W, 0, "../campaigns/human/level03h-intro2", 9 __},
    {W, 0, "../campaigns/human/level04h-intro1", 10 __},
    {W, 0, "../campaigns/human/level04h-intro2", 11 __},
    {W, 0, "../campaigns/human/level05h-intro1", 12 __},
    {W, 0, "../campaigns/human/level05h-intro2", 13 __},
    {W, 0, "../campaigns/human/level06h-intro1", 14 __},
    {W, 0, "../campaigns/human/level07h-intro1", 15 __},
    {W, 0, "../campaigns/human/level07h-intro2", 16 __},
    {W, 0, "../campaigns/human/level08h-intro1", 17 __},
    {W, 0, "../campaigns/human/level08h-intro2", 18 __},
    {W, 0, "../campaigns/human/level09h-intro1", 19 __},
    {W, 0, "../campaigns/human/level10h-intro1", 20 __},
    {W, 0, "../campaigns/human/level11h-intro1", 21 __},
    {W, 0, "../campaigns/human/level11h-intro2", 22 __},
    {W, 0, "../campaigns/human/level12h-intro1", 23 __},
    {W, 0, "../campaigns/human/level13h-intro1", 24 __},
    {W, 0, "../campaigns/human/level13h-intro2", 25 __},
    {W, 0, "../campaigns/human/level14h-intro1", 26 __},

    {W, 0, "../campaigns/orc/level01o-intro1", 27 __},
    {W, 0, "../campaigns/orc/level02o-intro1", 28 __},
    {W, 0, "../campaigns/orc/level03o-intro1", 29 __},
    {W, 0, "../campaigns/orc/level03o-intro2", 30 __},
    {W, 0, "../campaigns/orc/level04o-intro1", 31 __},
    {W, 0, "../campaigns/orc/level05o-intro1", 32 __},
    {W, 0, "../campaigns/orc/level06o-intro1", 33 __},
    {W, 0, "../campaigns/orc/level07o-intro1", 34 __},
    {W, 0, "../campaigns/orc/level07o-intro2", 35 __},
    {W, 0, "../campaigns/orc/level08o-intro1", 36 __},
    {W, 0, "../campaigns/orc/level09o-intro1", 37 __},
    {W, 0, "../campaigns/orc/level10o-intro1", 38 __},
    {W, 0, "../campaigns/orc/level11o-intro1", 39 __},
    {W, 0, "../campaigns/orc/level11o-intro2", 40 __},
    {W, 0, "../campaigns/orc/level12o-intro1", 41 __},
    {W, 0, "../campaigns/orc/level12o-intro2", 42 __},
    {W, 0, "../campaigns/orc/level13o-intro1", 43 __},
    {W, 0, "../campaigns/orc/level13o-intro2", 44 __},
    {W, 0, "../campaigns/orc/level14o-intro1", 45 __},

    {W, 2, "../campaigns/human-exp/victory-1", 50 __},
    {W, 2, "../campaigns/human-exp/victory-2", 51 __},
    {W, 2, "../campaigns/orc-exp/victory-1", 52 __},
    {W, 2, "../campaigns/orc-exp/victory-2", 53 __},
    {W, 2, "../campaigns/orc-exp/victory-3", 54 __},
    {W, 2, "../campaigns/human-exp/levelx01h-intro1", 55 __},
    {W, 2, "../campaigns/human-exp/levelx01h-intro2", 56 __},
    {W, 2, "../campaigns/human-exp/levelx02h-intro1", 57 __},
    {W, 2, "../campaigns/human-exp/levelx02h-intro2", 58 __},
    {W, 2, "../campaigns/human-exp/levelx03h-intro1", 59 __},
    {W, 2, "../campaigns/human-exp/levelx03h-intro2", 60 __},
    {W, 2, "../campaigns/human-exp/levelx04h-intro1", 61 __},
    {W, 2, "../campaigns/human-exp/levelx04h-intro2", 62 __},
    {W, 2, "../campaigns/human-exp/levelx04h-intro3", 63 __},
    {W, 2, "../campaigns/human-exp/levelx05h-intro1", 64 __},
    {W, 2, "../campaigns/human-exp/levelx05h-intro2", 65 __},
    {W, 2, "../campaigns/human-exp/levelx06h-intro1", 66 __},
    {W, 2, "../campaigns/human-exp/levelx06h-intro2", 67 __},
    {W, 2, "../campaigns/human-exp/levelx06h-intro3", 68 __},
    {W, 2, "../campaigns/human-exp/levelx07h-intro1", 69 __},
    {W, 2, "../campaigns/human-exp/levelx07h-intro2", 70 __},
    {W, 2, "../campaigns/human-exp/levelx07h-intro3", 71 __},
    {W, 2, "../campaigns/human-exp/levelx08h-intro1", 72 __},
    {W, 2, "../campaigns/human-exp/levelx08h-intro2", 73 __},
    {W, 2, "../campaigns/human-exp/levelx09h-intro1", 74 __},
    {W, 2, "../campaigns/human-exp/levelx09h-intro2", 75 __},
    {W, 2, "../campaigns/human-exp/levelx10h-intro1", 76 __},
    {W, 2, "../campaigns/human-exp/levelx10h-intro2", 77 __},
    {W, 2, "../campaigns/human-exp/levelx10h-intro3", 78 __},
    {W, 2, "../campaigns/human-exp/levelx11h-intro1", 79 __},
    {W, 2, "../campaigns/human-exp/levelx11h-intro2", 80 __},
    {W, 2, "../campaigns/human-exp/levelx12h-intro1", 81 __},
    {W, 2, "../campaigns/human-exp/levelx12h-intro2", 82 __},
    {W, 2, "../campaigns/orc-exp/levelx01o-intro1", 83 __},
    {W, 2, "../campaigns/orc-exp/levelx01o-intro2", 84 __},
    {W, 2, "../campaigns/orc-exp/levelx01o-intro3", 85 __},
    {W, 2, "../campaigns/orc-exp/levelx02o-intro1", 86 __},
    {W, 2, "../campaigns/orc-exp/levelx02o-intro2", 87 __},
    {W, 2, "../campaigns/orc-exp/levelx03o-intro1", 88 __},
    {W, 2, "../campaigns/orc-exp/levelx03o-intro2", 89 __},
    {W, 2, "../campaigns/orc-exp/levelx04o-intro1", 90 __},
    {W, 2, "../campaigns/orc-exp/levelx04o-intro2", 91 __},
    {W, 2, "../campaigns/orc-exp/levelx05o-intro1", 92 __},
    {W, 2, "../campaigns/orc-exp/levelx05o-intro2", 93 __},
    {W, 2, "../campaigns/orc-exp/levelx06o-intro1", 94 __},
    {W, 2, "../campaigns/orc-exp/levelx06o-intro2", 95 __},
    {W, 2, "../campaigns/orc-exp/levelx07o-intro1", 96 __},
    {W, 2, "../campaigns/orc-exp/levelx07o-intro2", 97 __},
    {W, 2, "../campaigns/orc-exp/levelx07o-intro3", 98 __},
    {W, 2, "../campaigns/orc-exp/levelx08o-intro1", 99 __},
    {W, 2, "../campaigns/orc-exp/levelx09o-intro1", 100 __},
    {W, 2, "../campaigns/orc-exp/levelx09o-intro2", 101 __},
    {W, 2, "../campaigns/orc-exp/levelx10o-intro1", 102 __},
    {W, 2, "../campaigns/orc-exp/levelx10o-intro2", 103 __},
    {W, 2, "../campaigns/orc-exp/levelx10o-intro3", 104 __},
    {W, 2, "../campaigns/orc-exp/levelx11o-intro1", 105 __},
    {W, 2, "../campaigns/orc-exp/levelx11o-intro2", 106 __},
    {W, 2, "../campaigns/orc-exp/levelx12o-intro1", 107 __},
    {W, 2, "../campaigns/orc-exp/levelx12o-intro2", 108 __},
    {W, 2, "../campaigns/orc-exp/levelx12o-intro3", 109 __},

    ///////////////////////////////////////////////////////////////////////////////
    //		INTERFACE
    ///////////////////////////////////////////////////////////////////////////////

    {F, 4, "muddat.cud", 6000 __},

    {V, 4, "videos/orc-1", 0 __},
    {V, 4, "videos/orc-3", 2 __},
    //{V,0,"videos/human-4",                                 3 __}, //Fixme: 3
    //and 4 same?
    {V, 4, "videos/human-4", 4 __},
    //{V,0,"videos/gameintro",                               5 __}, //Fixme: 5
    //and 6 same?
    {V, 4, "videos/gameintro", 6 __},
    //{V,0,"videos/orc-4",                                   8 __}, //Fixme: 8
    //and 9 same?
    {V, 4, "videos/orc-4", 9 __},
    {V, 4, "videos/human-3", 10 __},
    {V, 4, "videos/human-1", 11 __},
    {V, 4, "videos/orc-2", 12 __},
    {V, 4, "videos/human-2", 14 __},
    //{V,2,"videos/exp-1",                                   15 __}, //Fixme: 15
    //and 16 same?
    {V, 6, "videos/exp-1", 16 __},
    {V, 6, "videos/human-exp-2", 17 __},
    {V, 6, "videos/orc-exp-2", 18 __},

    ///////////////////////////////////////////////////////////////////////////////
    //		BNE SPECIFIC
    ///////////////////////////////////////////////////////////////////////////////

    {Q, 8, "War2Dat.mpq", 0, 0, 0, 0, "install.exe", "files\\War2Dat.mpq"},

    /////// SOUNDS
    ///////////////////////////////////////////////////////////////////

    // female-hero
    {
        Q, 8, "sounds/human/units/alleria/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/alleria/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\aleria\\alyessr3.wav"
    },
    // Buildings
    {
        Q, 8, "sounds/orc/buildings/goblin_alchemist.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\bldg\\alchemst.wav"
    },
    {
        Q, 8, "sounds/human/buildings/gryphon_aviary.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\bldg\\aviary.wav"
    },
    {
        Q, 8, "sounds/orc/buildings/dragon_roost.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\dragon.wav"
    },
    {
        Q, 8, "sounds/orc/buildings/temple_of_the_damned.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\bldg\\dthtower.wav"
    },
    {
        Q, 8, "sounds/buildings/foundry.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\foundry.wav"
    },
    {
        Q, 8, "sounds/human/buildings/church.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\hchant.wav"
    },
    {
        Q, 8, "sounds/human/buildings/farm.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\hfarm.wav"
    },
    {
        Q, 8, "sounds/human/buildings/gnomish_inventor.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\bldg\\inventor.wav"
    },
    {
        Q, 8, "sounds/buildings/lumbermill.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\lumbmill.wav"
    },
    {
        Q, 8, "sounds/neutral/buildings/gold_mine.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\mine.wav"
    },
    {
        Q, 8, "sounds/orc/buildings/altar_of_storms.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\bldg\\ochant.wav"
    },
    {
        Q, 8, "sounds/orc/buildings/pig_farm.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\ofarm.wav"
    },
    {
        Q, 8, "sounds/orc/buildings/ogre_mound.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\ogrecamp.wav"
    },
    {
        Q, 8, "sounds/buildings/oil_platform.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\oilplat.wav"
    },
    {
        Q, 8, "sounds/buildings/oil_refinery.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\oilrefin.wav"
    },
    {
        Q, 8, "sounds/buildings/shipyard.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\shipbell.wav"
    },
    {
        Q, 8, "sounds/buildings/blacksmith.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\smith.wav"
    },
    {
        Q, 8, "sounds/human/buildings/stables.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\stables.wav"
    },
    {
        Q, 8, "sounds/human/buildings/mage_tower.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\bldg\\wzrdtowr.wav"
    },
    // arthor-literios
    {
        Q, 8, "sounds/human/units/danath/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\danath\\dnpisd1.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\danath\\dnpisd2.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\danath\\dnpisd3.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\danath\\dnwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\danath\\dnwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\danath\\dnwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\danath\\dnyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\danath\\dnyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/danath/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\danath\\dnyessr3.wav"
    },
    // death knight
    {
        Q, 8, "sounds/orc/units/death_knight/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkpissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkpissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkpissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkwhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkwhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathknt\\dkyessr3.wav"
    },
    {
        Q, 8, "sounds/orc/units/death_knight/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\deathknt\\dkready.wav"
    },
    // fire-breeze
    {
        Q, 8, "sounds/orc/units/deathwing/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\depissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\depissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\depissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\dewhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\dewhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\dewhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\deyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\deyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/deathwing/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\deathwng\\deyessr3.wav"
    },
    // fad-man
    {
        Q, 8, "sounds/orc/units/dentarg/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dentarg\\odpissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dentarg\\odpissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dentarg\\odpissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dentarg\\odwhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/selected/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dentarg\\odwhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/selected/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dentarg\\odwhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\dentarg\\odyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\dentarg\\odyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/dentarg/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\dentarg\\odyessr3.wav"
    },
    // dragon
    {
        Q, 8, "sounds/orc/units/dragon/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dragon\\drwhat.wav"
    },
    {
        Q, 8, "sounds/orc/units/dragon/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\dragon\\dryessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/dragon/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\dragon\\dryessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/dragon/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\dragon\\drready.wav"
    },
    // dwarf
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/annoyed/1.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/annoyed/2.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/annoyed/3.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/selected/1.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/selected/2.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/acknowledgement/1.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/acknowledgement/2.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/acknowledgement/3.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwyessr3.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/acknowledgement/4.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwyessr4.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/acknowledgement/5.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\dwarf\\dwyessr5.wav"
    },
    {
        Q, 8, "sounds/human/units/dwarven_demolition_squad/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\dwarf\\dwready.wav"
    },
    // elves
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\epissed1.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\epissed2.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\epissed3.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\ewhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\ewhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\ewhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\ewhat4.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/acknowledgement/1.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\elves\\eyessir1.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/acknowledgement/2.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\elves\\eyessir2.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/acknowledgement/3.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\elves\\eyessir3.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/acknowledgement/4.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\elves\\eyessir4.wav"
    },
    {
        Q, 8, "sounds/human/units/elven_archer-ranger/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\elves\\eready.wav"
    },
    // gnome
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/annoyed/1.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\gnome\\gnpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/annoyed/2.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\gnome\\gnpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/annoyed/3.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\gnome\\gnpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/annoyed/4.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\gnome\\gnpissd4.wav"
    },
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/annoyed/5.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\gnome\\gnpissd5.wav"
    },
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/acknowledgement/1.wav", 1,
        1, 0, 0, "War2Dat.mpq", "Gamesfx\\gnome\\gnyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/gnomish_flying_machine/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\gnome\\gnready.wav"
    },
    // goblin
    {
        Q, 8, "sounds/orc/units/goblin_sappers/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gopissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gopissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gopissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gowhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gowhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gowhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\gowhat4.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\goyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\goyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\goyessr3.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/acknowledgement/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\goyessr4.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_sappers/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\goblin\\goready.wav"
    },
    // griffon
    {
        Q, 8, "sounds/human/units/gryphon_rider/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\griffon\\grwhat.wav"
    },
    {
        Q, 8, "sounds/human/units/gryphon_rider/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\griffon\\griffon1.wav"
    },
    {
        Q, 8, "sounds/human/units/gryphon_rider/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\griffon\\griffon2.wav"
    },
    {
        Q, 8, "sounds/human/units/gryphon_rider/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\griffon\\griffon1.wav"
    },
    // grom
    {
        Q, 8, "sounds/orc/units/grom_hellscream/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\grpissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\grpissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\grpissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\grwhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\grwhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\grwhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\gryessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\gryessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/grom_hellscream/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\grom\\gryessr3.wav"
    },
    // human
    {
        Q, 8, "sounds/human/basic_voices/dead.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hdead.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/help/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hhelp1.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/help/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hhelp2.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed1.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed2.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed3.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/4.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed4.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/5.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed5.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/6.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed6.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/annoyed/7.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hpissed7.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\human\\hready.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwhat1.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwhat2.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwhat3.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwhat4.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/selected/5.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwhat5.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/selected/6.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwhat6.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/work_complete.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hwrkdone.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/work_complete.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pswrkdon.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hyessir1.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hyessir2.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hyessir3.wav"
    },
    {
        Q, 8, "sounds/human/basic_voices/acknowledgement/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\human\\hyessir4.wav"
    },
    // kargath
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kargath\\kapissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kargath\\kapissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kargath\\kapissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kargath\\kawhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kargath\\kawhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kargath\\kawhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/acknowledgement/1.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\kargath\\kayessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/acknowledgement/2.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\kargath\\kayessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/korgath_bladefist/acknowledgement/3.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\kargath\\kayessr3.wav"
    },
    // khadgar
    {
        Q, 8, "sounds/human/units/khadgar/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/khadgar/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\khadgar\\khyessr3.wav"
    },
    // knight
    {
        Q, 8, "sounds/human/units/knight/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\knight\\knpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\knight\\knpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\knight\\knpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knwhat4.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knyessr3.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/acknowledgement/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\knight\\knyessr4.wav"
    },
    {
        Q, 8, "sounds/human/units/knight/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\knight\\knready.wav"
    },
    // kurdran
    {
        Q, 8, "sounds/human/units/kurdan/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\kurdran\\kupissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\kurdran\\kupissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\kurdran\\kupissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kurdran\\kuwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kurdran\\kuwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kurdran\\kuwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kurdran\\kuyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kurdran\\kuyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/kurdan/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\kurdran\\kuyessr3.wav"
    },
    // misc
    {
        Q, 8, "sounds/missiles/axe_throw.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\axe.wav"
    },
    {
        Q, 8, "sounds/misc/building_explosion/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\bldexpl1.wav"
    },
    {
        Q, 8, "sounds/misc/building_explosion/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\bldexpl2.wav"
    },
    {
        Q, 8, "sounds/misc/building_explosion/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\bldexpl3.wav"
    },
    {
        Q, 8, "sounds/missiles/bow_throw.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\bowfire.wav"
    },
    {
        Q, 8, "sounds/missiles/bow_hit.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\bowhit.wav"
    },
    {
        Q, 8, "sounds/misc/burning.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\burning.wav"
    },
    {
        Q, 8, "sounds/missiles/catapult-ballista_attack.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\catapult.wav"
    },
    {
        Q, 8, "sounds/units/catapult-ballista/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\catyessr.wav"
    },
    {
        Q, 8, "sounds/misc/building_construction.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\constrct.wav"
    },
    {
        Q, 8, "sounds/misc/transport_docking.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\dock.wav"
    },
    {
        Q, 8, "sounds/ui/placement_error.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\error.wav"
    },
    {
        Q, 8, "sounds/misc/explosion.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\explode.wav"
    },
    {
        Q, 8, "sounds/missiles/fireball_throw.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\fireball.wav"
    },
    {
        Q, 8, "sounds/missiles/fireball_hit.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\firehit.wav"
    },
    {
        Q, 8, "sounds/missiles/fist.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\fist.wav"
    },
    {
        Q, 8, "sounds/human/capture.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\hcapture.wav"
    },
    {
        Q, 8, "sounds/human/rescue.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\hrescue.wav"
    },
    {
        Q, 8, "sounds/orc/capture.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\ocapture.wav"
    },
    {
        Q, 8, "sounds/orc/rescue.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\orescue.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/attack.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\peonatak.wav"
    },
    {
        Q, 8, "sounds/neutral/units/pig/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\pig.wav"
    },
    {
        Q, 8, "sounds/neutral/units/pig/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\pigpissd.wav"
    },
    {
        Q, 8, "sounds/missiles/punch.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\punch.wav"
    },
    {
        Q, 8, "sounds/neutral/units/seal/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\seal.wav"
    },
    {
        Q, 8, "sounds/neutral/units/seal/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\sealpisd.wav"
    },
    {
        Q, 8, "sounds/neutral/units/sheep/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\sheep.wav"
    },
    {
        Q, 8, "sounds/neutral/units/sheep/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\shpisd1.wav"
    },
    {
        Q, 8, "sounds/missiles/sword_attack/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\sword1.wav"
    },
    {
        Q, 8, "sounds/missiles/sword_attack/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\sword2.wav"
    },
    {
        Q, 8, "sounds/missiles/sword_attack/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\sword3.wav"
    },
    {
        Q, 8, "sounds/ui/placement_success.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\thunk.wav"
    },
    {
        Q, 8, "sounds/misc/tree_chopping/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\tree1.wav"
    },
    {
        Q, 8, "sounds/misc/tree_chopping/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\tree2.wav"
    },
    {
        Q, 8, "sounds/misc/tree_chopping/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\tree3.wav"
    },
    {
        Q, 8, "sounds/misc/tree_chopping/4.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\misc\\tree4.wav"
    },
    {
        Q, 8, "sounds/neutral/units/warthog/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\warthog.wav"
    },
    {
        Q, 8, "sounds/neutral/units/warthog/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\wartpisd.wav"
    },
    // skeleton
    {
        Q, 8, "sounds/neutral/units/skeleton/dead.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamefx\\misc\\Skeleton Death.wav"
    },
    {
        Q, 8, "sounds/neutral/units/skeleton/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\misc\\Skeleton Move.wav"
    },
    // ogre
    {
        Q, 8, "sounds/orc/units/ogre/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogpissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogpissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogpissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/annoyed/4.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogpissd4.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/annoyed/5.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogpissd5.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogwhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/selected/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogwhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/selected/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogwhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/selected/4.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogwhat4.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogre\\ogyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogre\\ogyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogre\\ogyessr3.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogre\\ogready.wav"
    },
    // ogremage
    {
        Q, 8, "sounds/orc/units/ogre-mage/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\ompissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\ompissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\ompissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omwhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omwhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omwhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omwhat4.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ogremage\\omyessr3.wav"
    },
    {
        Q, 8, "sounds/orc/units/ogre-mage/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ogremage\\omready.wav"
    },
    // orc
    {
        Q, 8, "sounds/orc/basic_voices/dead.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\odead.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/help/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\ohelp1.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/help/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\ohelp2.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed1.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed2.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed3.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/4.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed4.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/5.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed5.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/6.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed6.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/annoyed/7.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\opissed7.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\oready.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\owhat1.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/selected/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\owhat2.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/selected/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\owhat3.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/selected/4.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\owhat4.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/selected/5.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\owhat5.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/selected/6.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\orc\\owhat6.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/work_complete.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\orc\\owrkdone.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\orc\\oyessir1.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\orc\\oyessir2.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\orc\\oyessir3.wav"
    },
    {
        Q, 8, "sounds/orc/basic_voices/acknowledgement/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\orc\\oyessir4.wav"
    },
    // paladin
    {
        Q, 8, "sounds/human/units/paladin/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkwhat4.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkyessr3.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/acknowledgement/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\paladin\\pkyessr4.wav"
    },
    {
        Q, 8, "sounds/human/units/paladin/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\paladin\\pkready.wav"
    },
    // peasant
    {
        Q, 8, "sounds/human/units/peasant/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/annoyed/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd4.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/annoyed/5.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd5.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/annoyed/6.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd6.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/annoyed/7.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pspissd7.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pswhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pswhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pswhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/selected/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\pswhat4.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\psyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\psyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\psyessr3.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/acknowledgement/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\peasant\\psyessr4.wav"
    },
    {
        Q, 8, "sounds/human/units/peasant/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\peasant\\psready.wav"
    },
    // peon
    {
        Q, 8, "sounds/orc/peon/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\peon\\pnready.wav"
    },
    // peasant
    {
        Q, 8, "sounds/ships/tanker/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\foghorn.wav"
    },
    {
        Q, 8, "sounds/human/ships/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshppis1.wav"
    },
    {
        Q, 8, "sounds/human/ships/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshppis2.wav"
    },
    {
        Q, 8, "sounds/human/ships/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshppis3.wav"
    },
    {
        Q, 8, "sounds/human/ships/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshpredy.wav"
    },
    {
        Q, 8, "sounds/human/ships/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshpwht1.wav"
    },
    {
        Q, 8, "sounds/human/ships/selected/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshpwht2.wav"
    },
    {
        Q, 8, "sounds/human/ships/selected/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\hshpwht3.wav"
    },
    {
        Q, 8, "sounds/human/ships/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\hshpyes1.wav"
    },
    {
        Q, 8, "sounds/human/ships/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\hshpyes2.wav"
    },
    {
        Q, 8, "sounds/human/ships/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\hshpyes3.wav"
    },
    {
        Q, 8, "sounds/orc/ships/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshppis1.wav"
    },
    {
        Q, 8, "sounds/orc/ships/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshppis2.wav"
    },
    {
        Q, 8, "sounds/orc/ships/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshppis3.wav"
    },
    {
        Q, 8, "sounds/orc/ships/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpredy.wav"
    },
    {
        Q, 8, "sounds/orc/ships/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpwht1.wav"
    },
    {
        Q, 8, "sounds/orc/ships/selected/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpwht2.wav"
    },
    {
        Q, 8, "sounds/orc/ships/selected/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpwht3.wav"
    },
    {
        Q, 8, "sounds/orc/ships/acknowledgement/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpyes1.wav"
    },
    {
        Q, 8, "sounds/orc/ships/acknowledgement/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpyes2.wav"
    },
    {
        Q, 8, "sounds/orc/ships/acknowledgement/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\oshpyes3.wav"
    },
    {
        Q, 8, "sounds/ships/sinking.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\ships\\shipsink.wav"
    },
    {
        Q, 8, "sounds/human/ships/gnomish_submarine/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\subpiss1.wav"
    },
    {
        Q, 8, "sounds/human/ships/gnomish_submarine/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\subpiss2.wav"
    },
    {
        Q, 8, "sounds/human/ships/gnomish_submarine/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\subpiss3.wav"
    },
    {
        Q, 8, "sounds/human/ships/gnomish_submarine/annoyed/4.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\ships\\subpiss4.wav"
    },
    // spells
    {
        Q, 8, "sounds/spells/bloodlust.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\blodlust.wav"
    },
    {
        Q, 8, "sounds/spells/death_and_decay.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\decay.wav"
    },
    {
        Q, 8, "sounds/spells/death_coil.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\dethcoil.wav"
    },
    {
        Q, 8, "sounds/spells/exorcism.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\exorcism.wav"
    },
    {
        Q, 8, "sounds/spells/flame_shield.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\flamshld.wav"
    },
    {
        Q, 8, "sounds/spells/haste.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\haste.wav"
    },
    {
        Q, 8, "sounds/spells/healing.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\heal.wav"
    },
    {
        Q, 8, "sounds/spells/holy_vision.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\holyvisn.wav"
    },
    {
        Q, 8, "sounds/spells/blizzard.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\icestorm.wav"
    },
    {
        Q, 8, "sounds/spells/invisibility.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\invisibl.wav"
    },
    {
        Q, 8, "sounds/spells/eye_of_kilrogg.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\iokilrog.wav"
    },
    {
        Q, 8, "sounds/spells/polymorph.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\morph.wav"
    },
    {
        Q, 8, "sounds/spells/slow.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\slow.wav"
    },
    {
        Q, 8, "sounds/spells/lightning.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\thunder.wav"
    },
    {
        Q, 8, "sounds/spells/touch_of_darkness.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\touchdrk.wav"
    },
    {
        Q, 8, "sounds/spells/unholy_armor.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\unhlyarm.wav"
    },
    {
        Q, 8, "sounds/spells/whirlwind.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\spells\\whrlwind.wav"
    },
    // teron_gorefiend
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\tepissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\tepissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\tepissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\tewhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\tewhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\tewhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\teyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\teyessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/teron_gorefiend/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\teron\\teyessr3.wav"
    },
    // troll
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/annoyed/1.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\troll\\trpissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/annoyed/2.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\troll\\trpissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/annoyed/3.wav", 1, 1, 0,
        0, "War2Dat.mpq", "Gamesfx\\troll\\trpissd3.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/selected/1.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\troll\\trwhat1.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/selected/2.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\troll\\trwhat2.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/selected/3.wav", 1, 1,
        0, 0, "War2Dat.mpq", "Gamesfx\\troll\\trwhat3.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/acknowledgement/1.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\troll\\tryessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/acknowledgement/2.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\troll\\tryessr2.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/acknowledgement/3.wav",
        1, 1, 0, 0, "War2Dat.mpq", "Gamesfx\\troll\\tryessr3.wav"
    },
    {
        Q, 8, "sounds/orc/units/troll_axethrower-berserker/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\troll\\trready.wav"
    },
    // turalyon
    {
        Q, 8, "sounds/human/units/turalyon/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tupissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tupissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/annoyed/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tupissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/selected/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tuwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/selected/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tuwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/selected/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tuwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tuyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tuyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/turalyon/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\turalyon\\tuyessr3.wav"
    },
    // wizard
    {
        Q, 8, "sounds/human/units/mage/annoyed/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzpissd1.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/annoyed/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzpissd2.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/annoyed/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzpissd3.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/selected/1.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzwhat1.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/selected/2.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzwhat2.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/selected/3.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzwhat3.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\wizard\\wzyessr1.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/acknowledgement/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\wizard\\wzyessr2.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/acknowledgement/3.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\wizard\\wzyessr3.wav"
    },
    {
        Q, 8, "sounds/human/units/mage/ready.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Gamesfx\\wizard\\wzready.wav"
    },
    // zeppelin
    {
        Q, 8, "sounds/orc/units/goblin_zeppelin/annoyed/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\zeppelin\\gbpissd1.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_zeppelin/annoyed/2.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\zeppelin\\gbpissd2.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_zeppelin/acknowledgement/1.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\zeppelin\\gbyessr1.wav"
    },
    {
        Q, 8, "sounds/orc/units/goblin_zeppelin/ready.wav", 1, 1, 0, 0,
        "War2Dat.mpq", "Gamesfx\\zeppelin\\gbready.wav"
    },
    // Sfx
    {Q, 8, "sounds/ui/click.wav", 1, 1, 0, 0, "War2Dat.mpq", "Sfx\\Button.wav"},
    {
        Q, 8, "sounds/ui/highclick.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Sfx\\numbers.wav"
    },
    {
        Q, 8, "sounds/ui/statsthump.wav", 1, 1, 0, 0, "War2Dat.mpq",
        "Sfx\\rank.wav"
    },
    {Q, 8, "sounds/human/act.wav", 1, 1, 0, 0, "War2Dat.mpq", "Sfx\\hact.wav"},
    {Q, 8, "sounds/orc/act.wav", 1, 1, 0, 0, "War2Dat.mpq", "Sfx\\oact.wav"},

    // Delete temporary archive
    {Q, 8, "", 1, 0, 0, 0, "War2Dat.mpq", "DELETE"},

    /////// VIDEOS
    ///////////////////////////////////////////////////////////////////

    {Q, 8, "videos/human-1", 0, 2, 0, 0, "install.exe", "Smk\\Smoke_M.smk"},
    {Q, 8, "videos/human-2", 0, 2, 0, 0, "install.exe", "Smk\\Zepp_M.smk"},
    {Q, 8, "videos/human-3", 0, 2, 0, 0, "install.exe", "Smk\\Ships_M.smk"},
    {Q, 8, "videos/human-4", 0, 2, 0, 0, "install.exe", "Smk\\HVict_M.smk"},
    {Q, 8, "videos/orc-1", 0, 2, 0, 0, "install.exe", "Smk\\Burn_M.smk"},
    {Q, 8, "videos/orc-2", 0, 2, 0, 0, "install.exe", "Smk\\Turtle_M.smk"},
    {Q, 8, "videos/orc-3", 0, 2, 0, 0, "install.exe", "Smk\\Demn_M.smk"},
    {Q, 8, "videos/orc-4", 0, 2, 0, 0, "install.exe", "Smk\\OVict_M.smk"},
    {Q, 8, "videos/gameintro", 0, 2, 0, 0, "install.exe", "Smk\\Intro_M.smk"},
    {Q, 8, "videos/logo", 0, 2, 0, 0, "install.exe", "Smk\\blizzard.smk"},
    {Q, 8, "videos/exp-1", 0, 2, 0, 0, "install.exe", "Smk\\IntroX_M.smk"},
    {Q, 8, "videos/human-exp-2", 0, 2, 0, 0, "install.exe", "Smk\\HVicX_M.smk"},
    {Q, 8, "videos/orc-exp-2", 0, 2, 0, 0, "install.exe", "Smk\\OrcX_M.smk"},

    /////// BNE MAPS
    //////////////////////////////////////////////////////////////////

    {
        Q, 8, "maps/All You Need BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\All You Need BNE.pud"
    },
    {
        Q, 8, "maps/Ant Trails BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Ant Trails BNE.pud"
    },
    {
        Q, 8, "maps/Big Rock Candy Mountain BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Big Rock Candy Mountain BNE.pud"
    },
    {
        Q, 8, "maps/Cramped BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Cramped BNE.pud"
    },
    {
        Q, 8, "maps/Crosshair BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Crosshair BNE.pud"
    },
    {
        Q, 8, "maps/Dark Paths BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Dark Paths BNE.pud"
    },
    {
        Q, 8, "maps/Dark Peninsula BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Dark Peninsula BNE.pud"
    },
    {
        Q, 8, "maps/Forsaken Isles BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Forsaken Isles BNE.pud"
    },
    {
        Q, 8, "maps/Frosty Fjords BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Frosty Fjords BNE.pud"
    },
    {
        Q, 8, "maps/Gold Rush BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Gold Rush BNE.pud"
    },
    {
        Q, 8, "maps/Great White North BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Great White North BNE.pud"
    },
    {
        Q, 8, "maps/Isolation BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Isolation BNE.pud"
    },
    {
        Q, 8, "maps/Kaboom BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Kaboom BNE.pud"
    },
    {
        Q, 8, "maps/More Precious than Gold BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\More Precious than Gold BNE.pud"
    },
    {
        Q, 8, "maps/Mud in Your Eye BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Mud in Your Eye BNE.pud"
    },
    {
        Q, 8, "maps/Murky River BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Murky River BNE.pud"
    },
    {
        Q, 8, "maps/Rose Petal BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Rose Petal BNE.pud"
    },
    {
        Q, 8, "maps/Schwartzwald BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Schwartzwald BNE.pud"
    },
    {
        Q, 8, "maps/Skirmish BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Skirmish BNE.pud"
    },
    {
        Q, 8, "maps/Stir Crazy BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Stir Crazy BNE.pud"
    },
    {
        Q, 8, "maps/Taiga BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Taiga BNE.pud"
    },
    {
        Q, 8, "maps/The River Kwai BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\The River Kwai BNE.pud"
    },
    {
        Q, 8, "maps/Training Ground BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Training Ground BNE.pud"
    },
    {
        Q, 8, "maps/Widow's End BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Widow's End BNE.pud"
    },
    {
        Q, 8, "maps/Winding ways BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Winding ways BNE.pud"
    },
    {
        Q, 8, "maps/World Domination BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\World Domination BNE.pud"
    },
    {
        Q, 8, "maps/Classic/A continent to explore.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\A continent to explore.pud"
    },
    {
        Q, 8, "maps/Classic/Bridge to bridge combat.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Bridge to bridge combat.pud"
    },
    {
        Q, 8, "maps/Classic/Critter attack!.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Critter attack!.pud"
    },
    {
        Q, 8, "maps/Classic/Cross the streams.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Cross the streams.pud"
    },
    {
        Q, 8, "maps/Classic/Crossover.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Crossover.pud"
    },
    {
        Q, 8, "maps/Classic/Death in the middle.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Death in the middle.pud"
    },
    {
        Q, 8, "maps/Classic/Fierce ocean combat.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Fierce ocean combat.pud"
    },
    {
        Q, 8, "maps/Classic/Garden of War.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Garden of War.pud"
    },
    {
        Q, 8, "maps/Classic/Gold mines.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Gold mines.pud"
    },
    {
        Q, 8, "maps/Classic/Gold Separates East & West.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Gold Separates East & West.pud"
    },
    {
        Q, 8, "maps/Classic/High seas combat.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\High seas combat.pud"
    },
    {
        Q, 8, "maps/Classic/Islands in the stream.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Islands in the stream.pud"
    },
    {
        Q, 8, "maps/Classic/Mine the center.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Mine the center.pud"
    },
    {
        Q, 8, "maps/Classic/Mysterious Dragon Isle.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Mysterious Dragon Isle.pud"
    },
    {
        Q, 8, "maps/Classic/No way out of this maze.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\No way out of this maze.pud"
    },
    {
        Q, 8, "maps/Classic/Nowhere to run or hide.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Nowhere to run or hide.pud"
    },
    {
        Q, 8, "maps/Classic/Oil is the key.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Oil is the key.pud"
    },
    {
        Q, 8, "maps/Classic/One way in, one way out.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\One way in, one way out.pud"
    },
    {
        Q, 8, "maps/Classic/Opposing city-states.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Opposing city-states.pud"
    },
    {
        Q, 8, "maps/Classic/Plains of snow.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Plains of snow.pud"
    },
    {
        Q, 8, "maps/Classic/River fork.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\River fork.pud"
    },
    {
        Q, 8, "maps/Classic/Rivers.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Rivers.pud"
    },
    {
        Q, 8, "maps/Classic/Skull Isle.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Skull Isle.pud"
    },
    {
        Q, 8, "maps/Classic/The four corners.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\The four corners.pud"
    },
    {
        Q, 8, "maps/Classic/The spiral.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\The spiral.pud"
    },
    {
        Q, 8, "maps/Classic/Three ways to cross.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Three ways to cross.pud"
    },
    {
        Q, 8, "maps/Classic/Unyielding stone fortresses.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Unyielding stone fortresses.pud"
    },
    {
        Q, 8, "maps/Classic/X marks the spot.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\X marks the spot.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/3vs3.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\3vs3.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/3vs5.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\3vs5.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Arena.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Arena.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Atols.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Atols.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Battle_1.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Battle_1.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Battle_2.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Battle_2.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/BigEars.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\BigEars.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/BlackGld.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\BlackGld.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Collapse.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Collapse.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Crowded.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Crowded.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Diamond.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Diamond.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Dup.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Dup.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Friends.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Friends.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Fun4Three.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Fun4Three.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Gauntlet.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Gauntlet.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Hell.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Hell.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Hourglas.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Hourglas.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Icewall.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Icewall.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Ironcros.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Ironcros.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Isle.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Isle.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/JimLand.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\JimLand.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Kanthar.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Kanthar.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Khing.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Khing.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/MntnPass.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\MntnPass.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Passes.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Passes.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Plots.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Plots.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Raiders.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Raiders.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Ring.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Ring.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/RiversX.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\RiversX.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/RockMaze.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\RockMaze.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/SeaWar.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\SeaWar.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Shared.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Shared.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Tandalos.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Tandalos.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/TheRiver.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\TheRiver.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/theSiege.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\theSiege.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Tourney.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Tourney.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/TwinHrbr.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\TwinHrbr.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Up4Grabs.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Up4Grabs.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Us.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Us.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Web.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\Web.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/WizWar.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Expansion\\WizWar.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/4_step.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\4_step.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Anarchy.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Anarchy.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Burn_It.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Burn_It.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Chess.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Chess.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/DeadMeet.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\DeadMeet.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Falsie.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Falsie.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/FireRing.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\FireRing.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Football.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Football.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Fortress.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Fortress.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/GrtWall.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\GrtWall.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Heroes1.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Heroes1.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Heroes2.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Heroes2.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Invasion.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Invasion.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Jail.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Jail.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/MagIsle.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\MagIsle.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Massacre.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Massacre.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Midland.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Midland.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/MinasTir.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\MinasTir.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Onslaugh.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Onslaugh.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Rescue.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Rescue.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Sacrific.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Sacrific.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Sparta.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Sparta.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Stone.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Stone.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Suicide.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Suicide.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Time.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Time.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/TrenchWar.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\TrenchWar.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/WaterRes.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\WaterRes.pud"
    },
    {
        Q, 8, "maps/Classic/Expansion/Scenario/Wish.pud", 0, 4, 0, 0,
        "install.exe", "maps\\Classic\\Expansion\\Scenario\\Wish.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Alamo.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Alamo.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Channel.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Channel.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Death.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Death.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Dragon.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Dragon.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Icebrdge.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Icebrdge.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Islands.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Islands.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Land_Sea.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Land_Sea.pud"
    },
    {
        Q, 8, "maps/Classic/Scenario/Mutton.pud", 0, 4, 0, 0, "install.exe",
        "maps\\Classic\\Scenario\\Mutton.pud"
    },
    {
        Q, 8, "maps/ladder/Arctic Circle BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Arctic Circle BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Bridge to bridge combat BNE.pud", 0, 4, 0, 0,
        "install.exe", "maps\\ladder\\Bridge to bridge combat BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Fierce ocean combat BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Fierce ocean combat BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Forest Trail BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Forest Trail BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Frog Legs BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Frog Legs BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Garden of war BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Garden of war BNE.pud"
    },
    {
        Q, 8, "maps/ladder/High seas combat BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\High seas combat BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Mine in the center BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Mine in the center BNE.pud"
    },
    {
        Q, 8, "maps/ladder/No way out of this maze BNE.pud", 0, 4, 0, 0,
        "install.exe", "maps\\ladder\\No way out of this maze BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Plains of snow BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Plains of snow BNE.pud"
    },
    {
        Q, 8, "maps/ladder/Skull isle BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\Skull isle BNE.pud"
    },
    {
        Q, 8, "maps/ladder/The four corners BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\The four corners BNE.pud"
    },
    {
        Q, 8, "maps/ladder/The spiral BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\ladder\\The spiral BNE.pud"
    },
    {
        Q, 8, "maps/scenario/A Tight Spot BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\A Tight Spot BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Bombs Away BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Bombs Away BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Fire in the Water BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Fire in the Water BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Horse Shoe Island BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Horse Shoe Island BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Ice Fortress BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Ice Fortress BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Instant Action BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Instant Action BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Invasion BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Invasion BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Opposites Attract BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Opposites Attract BNE.pud"
    },
    {
        Q, 8, "maps/scenario/Ramparts BNE.pud", 0, 4, 0, 0, "install.exe",
        "maps\\scenario\\Ramparts BNE.pud"
    },

    /////// BNE MUSIC
    //////////////////////////////////////////////////////////////////

    {
        Q, 8, "music/Human Battle 1.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HUMAN1.WAV"
    },
    {
        Q, 8, "music/Human Battle 2.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HUMAN2.WAV"
    },
    {
        Q, 8, "music/Human Battle 3.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HUMAN3.WAV"
    },
    {
        Q, 8, "music/Human Battle 4.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HUMAN4.WAV"
    },
    {
        Q, 8, "music/Human Battle 5.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HUMAN5.WAV"
    },
    {
        Q, 8, "music/Human Battle 6.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HUMAN6.WAV"
    },
    {
        Q, 8, "music/Orc Battle 1.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ORC1.WAV"
    },
    {
        Q, 8, "music/Orc Battle 2.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ORC2.WAV"
    },
    {
        Q, 8, "music/Orc Battle 3.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ORC3.WAV"
    },
    {
        Q, 8, "music/Orc Battle 4.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ORC4.WAV"
    },
    {
        Q, 8, "music/Orc Battle 5.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ORC5.WAV"
    },
    {
        Q, 8, "music/Orc Battle 6.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ORC6.WAV"
    },
    {
        Q, 8, "music/Human Briefing.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HWARROOM.WAV"
    },
    {
        Q, 8, "music/Orc Briefing.wav", 8, 0, 0, 0, "install.exe",
        "Music\\OWARROOM.WAV"
    },
    {
        Q, 8, "music/Human Victory.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HVICTORY.WAV"
    },
    {
        Q, 8, "music/Orc Victory.wav", 8, 0, 0, 0, "install.exe",
        "Music\\OVICTORY.WAV"
    },
    {
        Q, 8, "music/Human Defeat.wav", 8, 0, 0, 0, "install.exe",
        "Music\\HDEFEAT.WAV"
    },
    {
        Q, 8, "music/Orc Defeat.wav", 8, 0, 0, 0, "install.exe",
        "Music\\ODEFEAT.WAV"
    },
    {
        Q, 8, "music/Main Menu.wav", 8, 0, 0, 0, "install.exe",
        "Music\\OWARROOM.WAV"
    },
    {
        Q, 8, "music/I'm a Medieval Man.wav", 8, 0, 0, 0, "install.exe",
        "Music\\DISCOWC.WAV"
    },

#undef __
#undef _2
};

// puds that are in their own file
static std::array<std::filesystem::path, 8> OriginalPuds = {

    "../alamo.pud",    "../channel.pud",  "../death.pud",
    "../dragon.pud",   "../icebrdge.pud", "../islands.pud",
    "../land_sea.pud", "../mutton.pud"

};

static std::array<std::filesystem::path, 71> ExpansionPuds = {
    "../puds/multi/3vs3.pud",       "../puds/multi/3vs5.pud",
    "../puds/multi/arena.pud",      "../puds/multi/atols.pud",
    "../puds/multi/battle_1.pud",   "../puds/multi/battle_2.pud",
    "../puds/multi/blackgld.pud",   "../puds/multi/collapse.pud",
    "../puds/multi/crowded.pud",    "../puds/multi/diamond.pud",
    "../puds/multi/dup.pud",        "../puds/multi/ears.pud",
    "../puds/multi/friends.pud",    "../puds/multi/funfor3.pud",
    "../puds/multi/gauntlet.pud",   "../puds/multi/hell.pud",
    "../puds/multi/hourglas.pud",   "../puds/multi/icewall.pud",
    "../puds/multi/ironcros.pud",   "../puds/multi/isles.pud",
    "../puds/multi/jimland.pud",    "../puds/multi/kanthar.pud",
    "../puds/multi/king.pud",       "../puds/multi/mntnpass.pud",
    "../puds/multi/passes.pud",     "../puds/multi/plots.pud",
    "../puds/multi/raiders.pud",    "../puds/multi/ring.pud",
    "../puds/multi/riverx.pud",     "../puds/multi/rockmaze.pud",
    "../puds/multi/shared.pud",     "../puds/multi/siege.pud",
    "../puds/multi/tandalos.pud",   "../puds/multi/theriver.pud",
    "../puds/multi/tourney.pud",    "../puds/multi/twinhrbr.pud",
    "../puds/multi/up4grabs.pud",   "../puds/multi/us.pud",
    "../puds/multi/waratsea.pud",   "../puds/multi/web.pud",
    "../puds/multi/wizard.pud",     "../puds/single/4_step.pud",
    "../puds/single/anarchy.pud",   "../puds/single/burn_it.pud",
    "../puds/single/deadmeat.pud",  "../puds/single/falsie.pud",
    "../puds/single/firering.pud",  "../puds/single/fortress.pud",
    "../puds/single/grtwall.pud",   "../puds/single/heroes1.pud",
    "../puds/single/heroes2.pud",   "../puds/single/invasion.pud",
    "../puds/single/magisle.pud",   "../puds/single/massacre.pud",
    "../puds/single/midland.pud",   "../puds/single/minastir.pud",
    "../puds/single/onslaugh.pud",  "../puds/single/rescue.pud",
    "../puds/single/sacrific.pud",  "../puds/single/sparta.pud",
    "../puds/single/s_stone.pud",   "../puds/single/trench.pud",
    "../puds/single/tym.pud",       "../puds/single/waterres.pud",
    "../puds/single/wish.pud",      "../puds/strange/chess.pud",
    "../puds/strange/football.pud", "../puds/strange/jail.pud",
    "../puds/strange/suicide.pud"

};

static const std::string BNEPuds[] = {
    "maps/All You Need BNE.pud",
    "maps/Ant Trails BNE.pud",
    "maps/Big Rock Candy Mountain BNE.pud",
    "maps/Cramped BNE.pud",
    "maps/Crosshair BNE.pud",
    "maps/Dark Paths BNE.pud",
    "maps/Dark Peninsula BNE.pud",
    "maps/Forsaken Isles BNE.pud",
    "maps/Frosty Fjords BNE.pud",
    "maps/Gold Rush BNE.pud",
    "maps/Great White North BNE.pud",
    "maps/Isolation BNE.pud",
    "maps/Kaboom BNE.pud",
    "maps/More Precious than Gold BNE.pud",
    "maps/Mud in Your Eye BNE.pud",
    "maps/Murky River BNE.pud",
    "maps/Rose Petal BNE.pud",
    "maps/Schwartzwald BNE.pud",
    "maps/Skirmish BNE.pud",
    "maps/Stir Crazy BNE.pud",
    "maps/Taiga BNE.pud",
    "maps/The River Kwai BNE.pud",
    "maps/Training Ground BNE.pud",
    "maps/Widow's End BNE.pud",
    "maps/Winding ways BNE.pud",
    "maps/World Domination BNE.pud",
    "maps/Classic/A continent to explore.pud",
    "maps/Classic/Bridge to bridge combat.pud",
    "maps/Classic/Critter attack!.pud",
    "maps/Classic/Cross the streams.pud",
    "maps/Classic/Crossover.pud",
    "maps/Classic/Death in the middle.pud",
    "maps/Classic/Fierce ocean combat.pud",
    "maps/Classic/Garden of War.pud",
    "maps/Classic/Gold mines.pud",
    "maps/Classic/Gold Separates East & West.pud",
    "maps/Classic/High seas combat.pud",
    "maps/Classic/Islands in the stream.pud",
    "maps/Classic/Mine the center.pud",
    "maps/Classic/Mysterious Dragon Isle.pud",
    "maps/Classic/No way out of this maze.pud",
    "maps/Classic/Nowhere to run or hide.pud",
    "maps/Classic/Oil is the key.pud",
    "maps/Classic/One way in, one way out.pud",
    "maps/Classic/Opposing city-states.pud",
    "maps/Classic/Plains of snow.pud",
    "maps/Classic/River fork.pud",
    "maps/Classic/Rivers.pud",
    "maps/Classic/Skull Isle.pud",
    "maps/Classic/The four corners.pud",
    "maps/Classic/The spiral.pud",
    "maps/Classic/Three ways to cross.pud",
    "maps/Classic/Unyielding stone fortresses.pud",
    "maps/Classic/X marks the spot.pud",
    "maps/Classic/Expansion/3vs3.pud",
    "maps/Classic/Expansion/3vs5.pud",
    "maps/Classic/Expansion/Arena.pud",
    "maps/Classic/Expansion/Atols.pud",
    "maps/Classic/Expansion/Battle_1.pud",
    "maps/Classic/Expansion/Battle_2.pud",
    "maps/Classic/Expansion/BigEars.pud",
    "maps/Classic/Expansion/BlackGld.pud",
    "maps/Classic/Expansion/Collapse.pud",
    "maps/Classic/Expansion/Crowded.pud",
    "maps/Classic/Expansion/Diamond.pud",
    "maps/Classic/Expansion/Dup.pud",
    "maps/Classic/Expansion/Friends.pud",
    "maps/Classic/Expansion/Fun4Three.pud",
    "maps/Classic/Expansion/Gauntlet.pud",
    "maps/Classic/Expansion/Hell.pud",
    "maps/Classic/Expansion/Hourglas.pud",
    "maps/Classic/Expansion/Icewall.pud",
    "maps/Classic/Expansion/Ironcros.pud",
    "maps/Classic/Expansion/Isle.pud",
    "maps/Classic/Expansion/JimLand.pud",
    "maps/Classic/Expansion/Kanthar.pud",
    "maps/Classic/Expansion/Khing.pud",
    "maps/Classic/Expansion/MntnPass.pud",
    "maps/Classic/Expansion/Passes.pud",
    "maps/Classic/Expansion/Plots.pud",
    "maps/Classic/Expansion/Raiders.pud",
    "maps/Classic/Expansion/Ring.pud",
    "maps/Classic/Expansion/RiversX.pud",
    "maps/Classic/Expansion/RockMaze.pud",
    "maps/Classic/Expansion/SeaWar.pud",
    "maps/Classic/Expansion/Shared.pud",
    "maps/Classic/Expansion/Tandalos.pud",
    "maps/Classic/Expansion/TheRiver.pud",
    "maps/Classic/Expansion/theSiege.pud",
    "maps/Classic/Expansion/Tourney.pud",
    "maps/Classic/Expansion/TwinHrbr.pud",
    "maps/Classic/Expansion/Up4Grabs.pud",
    "maps/Classic/Expansion/Us.pud",
    "maps/Classic/Expansion/Web.pud",
    "maps/Classic/Expansion/WizWar.pud",
    "maps/Classic/Expansion/Scenario/4_step.pud",
    "maps/Classic/Expansion/Scenario/Anarchy.pud",
    "maps/Classic/Expansion/Scenario/Burn_It.pud",
    "maps/Classic/Expansion/Scenario/Chess.pud",
    "maps/Classic/Expansion/Scenario/DeadMeet.pud",
    "maps/Classic/Expansion/Scenario/Falsie.pud",
    "maps/Classic/Expansion/Scenario/FireRing.pud",
    "maps/Classic/Expansion/Scenario/Football.pud",
    "maps/Classic/Expansion/Scenario/Fortress.pud",
    "maps/Classic/Expansion/Scenario/GrtWall.pud",
    "maps/Classic/Expansion/Scenario/Heroes1.pud",
    "maps/Classic/Expansion/Scenario/Heroes2.pud",
    "maps/Classic/Expansion/Scenario/Invasion.pud",
    "maps/Classic/Expansion/Scenario/Jail.pud",
    "maps/Classic/Expansion/Scenario/MagIsle.pud",
    "maps/Classic/Expansion/Scenario/Massacre.pud",
    "maps/Classic/Expansion/Scenario/Midland.pud",
    "maps/Classic/Expansion/Scenario/MinasTir.pud",
    "maps/Classic/Expansion/Scenario/Onslaugh.pud",
    "maps/Classic/Expansion/Scenario/Rescue.pud",
    "maps/Classic/Expansion/Scenario/Sacrific.pud",
    "maps/Classic/Expansion/Scenario/Sparta.pud",
    "maps/Classic/Expansion/Scenario/Stone.pud",
    "maps/Classic/Expansion/Scenario/Suicide.pud",
    "maps/Classic/Expansion/Scenario/Time.pud",
    "maps/Classic/Expansion/Scenario/TrenchWar.pud",
    "maps/Classic/Expansion/Scenario/WaterRes.pud",
    "maps/Classic/Expansion/Scenario/Wish.pud",
    "maps/Classic/Scenario/Alamo.pud",
    "maps/Classic/Scenario/Channel.pud",
    "maps/Classic/Scenario/Death.pud",
    "maps/Classic/Scenario/Dragon.pud",
    "maps/Classic/Scenario/Icebrdge.pud",
    "maps/Classic/Scenario/Islands.pud",
    "maps/Classic/Scenario/Land_Sea.pud",
    "maps/Classic/Scenario/Mutton.pud",
    "maps/ladder/Arctic Circle BNE.pud",
    "maps/ladder/Bridge to bridge combat BNE.pud",
    "maps/ladder/Fierce ocean combat BNE.pud",
    "maps/ladder/Forest Trail BNE.pud",
    "maps/ladder/Frog Legs BNE.pud",
    "maps/ladder/Garden of war BNE.pud",
    "maps/ladder/High seas combat BNE.pud",
    "maps/ladder/Mine in the center BNE.pud",
    "maps/ladder/No way out of this maze BNE.pud",
    "maps/ladder/Plains of snow BNE.pud",
    "maps/ladder/Skull isle BNE.pud",
    "maps/ladder/The four corners BNE.pud",
    "maps/ladder/The spiral BNE.pud",
    "maps/scenario/A Tight Spot BNE.pud",
    "maps/scenario/Bombs Away BNE.pud",
    "maps/scenario/Fire in the Water BNE.pud",
    "maps/scenario/Horse Shoe Island BNE.pud",
    "maps/scenario/Ice Fortress BNE.pud",
    "maps/scenario/Instant Action BNE.pud",
    "maps/scenario/Invasion BNE.pud",
    "maps/scenario/Opposites Attract BNE.pud",
    "maps/scenario/Ramparts BNE.pud",
};

typedef struct _grouped_graphic_ {
    size_t X;         // X offset
    size_t Y;         // Y offset
    size_t Width;     // width of image
    size_t Height;    // height of image
    std::string Name; // name
} GroupedGraphic;

static const GroupedGraphic GroupedGraphicsList[][60] = {
    // group 0 (widgets)
    {
        // 0 and 1 are the same
        {0, 0 * 144, 106, 28, "button-grayscale-grayed"},
        {0, 1 * 144, 106, 28, "button-grayscale-normal"},
        {0, 2 * 144, 106, 28, "button-grayscale-pressed"},
        // 3 and 4 are the same
        {0, 3 * 144, 128, 20, "button-thin-medium-grayed"},
        {0, 4 * 144, 128, 20, "button-thin-medium-normal"},
        {0, 5 * 144, 128, 20, "button-thin-medium-pressed"},
        // 6 and 7 are the same
        {0, 6 * 144, 80, 20, "button-thin-small-grayed"},
        {0, 7 * 144, 80, 20, "button-thin-small-normal"},
        {0, 8 * 144, 80, 20, "button-thin-small-pressed"},
        {0, 9 * 144, 106, 28, "button-small-grayed"},
        {0, 10 * 144, 106, 28, "button-small-normal"},
        {0, 11 * 144, 106, 28, "button-small-pressed"},
        {0, 12 * 144, 164, 28, "button-medium-grayed"},
        {0, 13 * 144, 164, 28, "button-medium-normal"},
        {0, 14 * 144, 164, 28, "button-medium-pressed"},
        {0, 15 * 144, 224, 28, "button-large-grayed"},
        {0, 16 * 144, 224, 28, "button-large-normal"},
        {0, 17 * 144, 224, 28, "button-large-pressed"},
        {0, 18 * 144, 19, 19, "radio-grayed"},
        {0, 19 * 144, 19, 19, "radio-normal-unselected"},
        {0, 20 * 144, 19, 19, "radio-pressed-unselected"},
        {0, 21 * 144, 19, 19, "radio-normal-selected"},
        {0, 22 * 144, 19, 19, "radio-pressed-selected"},
        {0, 23 * 144, 17, 17, "checkbox-grayed"},
        {0, 24 * 144, 17, 17, "checkbox-normal-unselected"},
        {0, 25 * 144, 17, 17, "checkbox-pressed-unselected"},
        {0, 26 * 144, 17, 20, "checkbox-normal-selected"},
        {0, 27 * 144, 17, 20, "checkbox-pressed-selected"},
        {0, 28 * 144, 19, 20, "up-arrow-grayed"},
        {0, 29 * 144, 19, 20, "up-arrow-normal"},
        {0, 30 * 144, 19, 20, "up-arrow-pressed"},
        {0, 31 * 144, 19, 20, "down-arrow-grayed"},
        {0, 32 * 144, 19, 20, "down-arrow-normal"},
        {0, 33 * 144, 19, 20, "down-arrow-pressed"},
        {0, 34 * 144, 20, 19, "left-arrow-grayed"},
        {0, 35 * 144, 20, 19, "left-arrow-normal"},
        {0, 36 * 144, 20, 19, "left-arrow-pressed"},
        {0, 37 * 144, 20, 19, "right-arrow-grayed"},
        {0, 38 * 144, 20, 19, "right-arrow-normal"},
        {0, 39 * 144, 20, 19, "right-arrow-pressed"},
        {0, 40 * 144, 17, 17, "slider-knob"},
        {0, 41 * 144 + 20, 19, 124, "vslider-bar-grayed"},
        {0, 42 * 144 + 20, 19, 124, "vslider-bar-normal"},
        {20, 43 * 144, 172, 19, "hslider-bar-grayed"},
        {20, 44 * 144, 172, 19, "hslider-bar-normal"},
        {0, 45 * 144, 300, 18, "pulldown-bar-grayed"},
        {0, 46 * 144, 300, 18, "pulldown-bar-normal"},
        // 47 and 48 are the same
        {0, 47 * 144, 80, 15, "button-verythin-grayed"},
        {0, 48 * 144, 80, 15, "button-verythin-normal"},
        {0, 49 * 144, 80, 15, "button-verythin-pressed"},
        // NB: the following 3 sizes are incorrect for human
        {0, 50 * 144, 37, 24, "folder-up-grayed"},
        {0, 51 * 144, 37, 24, "folder-up-normal"},
        {0, 52 * 144, 37, 24, "folder-up-pressed"},
        {0, 0, 0, 0, ""},
    }
};

/**
**  Names for localized versions.
*/
unsigned char Names[] = {
    0xDF, 0x01, 0xC0, 0x03, 0xC1, 0x03, 0xC9, 0x03, 0xCF, 0x03, 0xD7, 0x03,
    0xDC, 0x03, 0xE5, 0x03, 0xEE, 0x03, 0xF5, 0x03, 0xFA, 0x03, 0x07, 0x04,
    0x18, 0x04, 0x1D, 0x04, 0x2A, 0x04, 0x32, 0x04, 0x3C, 0x04, 0x55, 0x04,
    0x64, 0x04, 0x73, 0x04, 0x7F, 0x04, 0x86, 0x04, 0x90, 0x04, 0x98, 0x04,
    0xA8, 0x04, 0xBC, 0x04, 0xC4, 0x04, 0xCC, 0x04, 0xDC, 0x04, 0xED, 0x04,
    0xFC, 0x04, 0x0C, 0x05, 0x1A, 0x05, 0x2A, 0x05, 0x3A, 0x05, 0x45, 0x05,
    0x57, 0x05, 0x58, 0x05, 0x62, 0x05, 0x63, 0x05, 0x64, 0x05, 0x76, 0x05,
    0x83, 0x05, 0x9A, 0x05, 0xAA, 0x05, 0xB8, 0x05, 0xBF, 0x05, 0xC8, 0x05,
    0xD7, 0x05, 0xDE, 0x05, 0xF0, 0x05, 0xF1, 0x05, 0xFA, 0x05, 0x01, 0x06,
    0x09, 0x06, 0x1C, 0x06, 0x23, 0x06, 0x24, 0x06, 0x2D, 0x06, 0x34, 0x06,
    0x3C, 0x06, 0x41, 0x06, 0x4A, 0x06, 0x59, 0x06, 0x66, 0x06, 0x6D, 0x06,
    0x7D, 0x06, 0x89, 0x06, 0x95, 0x06, 0x9D, 0x06, 0xA8, 0x06, 0xB9, 0x06,
    0xCA, 0x06, 0xD9, 0x06, 0xE6, 0x06, 0xF5, 0x06, 0x02, 0x07, 0x0C, 0x07,
    0x17, 0x07, 0x29, 0x07, 0x3B, 0x07, 0x49, 0x07, 0x55, 0x07, 0x60, 0x07,
    0x75, 0x07, 0x86, 0x07, 0x95, 0x07, 0xA4, 0x07, 0xB1, 0x07, 0xC4, 0x07,
    0xD5, 0x07, 0xDA, 0x07, 0xE5, 0x07, 0xEC, 0x07, 0xF5, 0x07, 0xFF, 0x07,
    0x09, 0x08, 0x1E, 0x08, 0x31, 0x08, 0x43, 0x08, 0x53, 0x08, 0x66, 0x08,
    0x77, 0x08, 0x87, 0x08, 0x93, 0x08, 0x9D, 0x08, 0xA2, 0x08, 0xA3, 0x08,
    0xBC, 0x08, 0xD5, 0x08, 0xEC, 0x08, 0x03, 0x09, 0x1C, 0x09, 0x35, 0x09,
    0x4E, 0x09, 0x67, 0x09, 0x87, 0x09, 0xA7, 0x09, 0xC5, 0x09, 0xE3, 0x09,
    0xFF, 0x09, 0x1B, 0x0A, 0x35, 0x0A, 0x4F, 0x0A, 0x6A, 0x0A, 0x85, 0x0A,
    0x9E, 0x0A, 0xB7, 0x0A, 0xD3, 0x0A, 0xEF, 0x0A, 0x0B, 0x0B, 0x27, 0x0B,
    0x3D, 0x0B, 0x4E, 0x0B, 0x5E, 0x0B, 0x72, 0x0B, 0x8B, 0x0B, 0xA1, 0x0B,
    0xB4, 0x0B, 0xCB, 0x0B, 0xE7, 0x0B, 0x03, 0x0C, 0x17, 0x0C, 0x27, 0x0C,
    0x38, 0x0C, 0x4D, 0x0C, 0x5E, 0x0C, 0x6B, 0x0C, 0x80, 0x0C, 0x92, 0x0C,
    0xA3, 0x0C, 0xBA, 0x0C, 0xCC, 0x0C, 0xDF, 0x0C, 0xF2, 0x0C, 0x04, 0x0D,
    0x12, 0x0D, 0x27, 0x0D, 0x35, 0x0D, 0x4D, 0x0D, 0x4E, 0x0D, 0x5A, 0x0D,
    0x62, 0x0D, 0x69, 0x0D, 0x72, 0x0D, 0x79, 0x0D, 0x82, 0x0D, 0x89, 0x0D,
    0x92, 0x0D, 0x99, 0x0D, 0xA2, 0x0D, 0xA9, 0x0D, 0xB2, 0x0D, 0xB9, 0x0D,
    0xC2, 0x0D, 0xC9, 0x0D, 0xD3, 0x0D, 0xDB, 0x0D, 0xE5, 0x0D, 0xED, 0x0D,
    0xF7, 0x0D, 0xFF, 0x0D, 0x09, 0x0E, 0x11, 0x0E, 0x24, 0x0E, 0x33, 0x0E,
    0x3E, 0x0E, 0x49, 0x0E, 0x59, 0x0E, 0x6B, 0x0E, 0x7D, 0x0E, 0x8D, 0x0E,
    0x9D, 0x0E, 0xA9, 0x0E, 0xB5, 0x0E, 0xC2, 0x0E, 0xCE, 0x0E, 0xDB, 0x0E,
    0xE8, 0x0E, 0xF5, 0x0E, 0x02, 0x0F, 0x10, 0x0F, 0x1E, 0x0F, 0x31, 0x0F,
    0x46, 0x0F, 0x5C, 0x0F, 0x72, 0x0F, 0x85, 0x0F, 0x9B, 0x0F, 0xB0, 0x0F,
    0xC3, 0x0F, 0xD8, 0x0F, 0xED, 0x0F, 0x03, 0x10, 0x19, 0x10, 0x2F, 0x10,
    0x44, 0x10, 0x59, 0x10, 0x6F, 0x10, 0x82, 0x10, 0x97, 0x10, 0xAD, 0x10,
    0xC3, 0x10, 0xD8, 0x10, 0xEB, 0x10, 0x00, 0x11, 0x15, 0x11, 0x2B, 0x11,
    0x40, 0x11, 0x55, 0x11, 0x62, 0x11, 0x6F, 0x11, 0x7C, 0x11, 0x88, 0x11,
    0x94, 0x11, 0xA0, 0x11, 0xAC, 0x11, 0xB9, 0x11, 0xC6, 0x11, 0xD3, 0x11,
    0xE0, 0x11, 0xEB, 0x11, 0xF7, 0x11, 0x02, 0x12, 0x03, 0x12, 0x16, 0x12,
    0x21, 0x12, 0x2C, 0x12, 0x36, 0x12, 0x40, 0x12, 0x49, 0x12, 0x52, 0x12,
    0x5B, 0x12, 0x64, 0x12, 0x6C, 0x12, 0x74, 0x12, 0x7F, 0x12, 0x8A, 0x12,
    0x93, 0x12, 0x9C, 0x12, 0xA9, 0x12, 0xB6, 0x12, 0xC1, 0x12, 0xD6, 0x12,
    0xE2, 0x12, 0xEE, 0x12, 0xFB, 0x12, 0x08, 0x13, 0x17, 0x13, 0x1B, 0x13,
    0x2A, 0x13, 0x3C, 0x13, 0x51, 0x13, 0x62, 0x13, 0x73, 0x13, 0x87, 0x13,
    0x98, 0x13, 0xB2, 0x13, 0xC4, 0x13, 0xD8, 0x13, 0xEF, 0x13, 0x00, 0x14,
    0x0F, 0x14, 0x1F, 0x14, 0x31, 0x14, 0x44, 0x14, 0x57, 0x14, 0x6C, 0x14,
    0x80, 0x14, 0x94, 0x14, 0xA9, 0x14, 0xC0, 0x14, 0xDC, 0x14, 0xF3, 0x14,
    0x0D, 0x15, 0x26, 0x15, 0x3E, 0x15, 0x4F, 0x15, 0x72, 0x15, 0x8B, 0x15,
    0x9E, 0x15, 0xB4, 0x15, 0xC6, 0x15, 0xDB, 0x15, 0xEB, 0x15, 0xFC, 0x15,
    0x16, 0x16, 0x25, 0x16, 0x3B, 0x16, 0x52, 0x16, 0x69, 0x16, 0x80, 0x16,
    0x92, 0x16, 0xA1, 0x16, 0xB4, 0x16, 0xC9, 0x16, 0xDF, 0x16, 0xF7, 0x16,
    0x0B, 0x17, 0x25, 0x17, 0x40, 0x17, 0x5C, 0x17, 0x77, 0x17, 0x92, 0x17,
    0xAB, 0x17, 0xC1, 0x17, 0xD6, 0x17, 0xF5, 0x17, 0x0D, 0x18, 0x25, 0x18,
    0x44, 0x18, 0x6A, 0x18, 0x8A, 0x18, 0xA9, 0x18, 0xC8, 0x18, 0xE7, 0x18,
    0x07, 0x19, 0x29, 0x19, 0x40, 0x19, 0x5A, 0x19, 0x7A, 0x19, 0x98, 0x19,
    0xBC, 0x19, 0xD9, 0x19, 0xFE, 0x19, 0x1F, 0x1A, 0x3A, 0x1A, 0x5D, 0x1A,
    0x80, 0x1A, 0x95, 0x1A, 0xA2, 0x1A, 0xB3, 0x1A, 0xBC, 0x1A, 0xCD, 0x1A,
    0xDB, 0x1A, 0xE8, 0x1A, 0xFE, 0x1A, 0x12, 0x1B, 0x21, 0x1B, 0x2B, 0x1B,
    0x3C, 0x1B, 0x46, 0x1B, 0x54, 0x1B, 0x64, 0x1B, 0x7B, 0x1B, 0x8F, 0x1B,
    0x9C, 0x1B, 0xAF, 0x1B, 0xBD, 0x1B, 0xCD, 0x1B, 0xDC, 0x1B, 0xFC, 0x1B,
    0x17, 0x1C, 0x2D, 0x1C, 0x47, 0x1C, 0x59, 0x1C, 0x73, 0x1C, 0x8A, 0x1C,
    0xA0, 0x1C, 0xBD, 0x1C, 0xD5, 0x1C, 0xE8, 0x1C, 0x02, 0x1D, 0x15, 0x1D,
    0x2C, 0x1D, 0x45, 0x1D, 0x5A, 0x1D, 0x77, 0x1D, 0x8D, 0x1D, 0xA9, 0x1D,
    0xC0, 0x1D, 0xD9, 0x1D, 0xF1, 0x1D, 0xFA, 0x1D, 0x03, 0x1E, 0x0E, 0x1E,
    0x19, 0x1E, 0x36, 0x1E, 0x43, 0x1E, 0x5D, 0x1E, 0x7A, 0x1E, 0x8D, 0x1E,
    0xA3, 0x1E, 0xB5, 0x1E, 0xC6, 0x1E, 0xD1, 0x1E, 0xE6, 0x1E, 0xF3, 0x1E,
    0x04, 0x1F, 0x22, 0x1F, 0x41, 0x1F, 0x5A, 0x1F, 0x60, 0x1F, 0x67, 0x1F,
    0x6F, 0x1F, 0x76, 0x1F, 0x7D, 0x1F, 0x84, 0x1F, 0x8B, 0x1F, 0x95, 0x1F,
    0xA1, 0x1F, 0xA8, 0x1F, 0xAE, 0x1F, 0xB8, 0x1F, 0xC3, 0x1F, 0xCD, 0x1F,
    0xDA, 0x1F, 0xE5, 0x1F, 0xF1, 0x1F, 0xF7, 0x1F, 0xFF, 0x1F, 0x04, 0x20,
    0x0E, 0x20, 0x1D, 0x20, 0x29, 0x20, 0x34, 0x20, 0x53, 0x20, 0x79, 0x20,
    0x93, 0x20, 0xB7, 0x20, 0xD9, 0x20, 0xFE, 0x20, 0x1E, 0x21, 0x3C, 0x21,
    0x54, 0x21, 0x7F, 0x21, 0x9D, 0x21, 0xD1, 0x21, 0x02, 0x22, 0x2C, 0x22,
    0x31, 0x22, 0x37, 0x22, 0x3D, 0x22, 0x42, 0x22, 0x49, 0x22, 0x50, 0x22,
    0x5C, 0x22, 0x68, 0x22, 0x74, 0x22, 0x7B, 0x22, 0x81, 0x22, 0x8E, 0x22,
    0x9B, 0x22, 0xA1, 0x22, 0xA9, 0x22, 0xB0, 0x22, 0xB6, 0x22, 0xBC, 0x22,
    0xC3, 0x22, 0xCA, 0x22, 0xCF, 0x22, 0xD6, 0x22, 0xDB, 0x22, 0xE1, 0x22,
    0xEB, 0x22, 0xF1, 0x22, 0xFB, 0x22, 0x00, 0x23, 0x09, 0x23, 0x14, 0x23,
    0x00, 0x46, 0x6F, 0x6F, 0x74, 0x6D, 0x61, 0x6E, 0x00, 0x47, 0x72, 0x75,
    0x6E, 0x74, 0x00, 0x50, 0x65, 0x61, 0x73, 0x61, 0x6E, 0x74, 0x00, 0x50,
    0x65, 0x6F, 0x6E, 0x00, 0x42, 0x61, 0x6C, 0x6C, 0x69, 0x73, 0x74, 0x61,
    0x00, 0x43, 0x61, 0x74, 0x61, 0x70, 0x75, 0x6C, 0x74, 0x00, 0x4B, 0x6E,
    0x69, 0x67, 0x68, 0x74, 0x00, 0x4F, 0x67, 0x72, 0x65, 0x00, 0x45, 0x6C,
    0x76, 0x65, 0x6E, 0x20, 0x41, 0x72, 0x63, 0x68, 0x65, 0x72, 0x00, 0x54,
    0x72, 0x6F, 0x6C, 0x6C, 0x20, 0x41, 0x78, 0x65, 0x74, 0x68, 0x72, 0x6F,
    0x77, 0x65, 0x72, 0x00, 0x4D, 0x61, 0x67, 0x65, 0x00, 0x44, 0x65, 0x61,
    0x74, 0x68, 0x20, 0x4B, 0x6E, 0x69, 0x67, 0x68, 0x74, 0x00, 0x50, 0x61,
    0x6C, 0x61, 0x64, 0x69, 0x6E, 0x00, 0x4F, 0x67, 0x72, 0x65, 0x2D, 0x4D,
    0x61, 0x67, 0x65, 0x00, 0x44, 0x77, 0x61, 0x72, 0x76, 0x65, 0x6E, 0x20,
    0x44, 0x65, 0x6D, 0x6F, 0x6C, 0x69, 0x74, 0x69, 0x6F, 0x6E, 0x20, 0x53,
    0x71, 0x75, 0x61, 0x64, 0x00, 0x47, 0x6F, 0x62, 0x6C, 0x69, 0x6E, 0x20,
    0x53, 0x61, 0x70, 0x70, 0x65, 0x72, 0x73, 0x00, 0x41, 0x74, 0x74, 0x61,
    0x63, 0x6B, 0x20, 0x50, 0x65, 0x61, 0x73, 0x61, 0x6E, 0x74, 0x00, 0x41,
    0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x50, 0x65, 0x6F, 0x6E, 0x00, 0x52,
    0x61, 0x6E, 0x67, 0x65, 0x72, 0x00, 0x42, 0x65, 0x72, 0x73, 0x65, 0x72,
    0x6B, 0x65, 0x72, 0x00, 0x41, 0x6C, 0x6C, 0x65, 0x72, 0x69, 0x61, 0x00,
    0x54, 0x65, 0x72, 0x6F, 0x6E, 0x20, 0x47, 0x6F, 0x72, 0x65, 0x66, 0x69,
    0x65, 0x6E, 0x64, 0x00, 0x4B, 0x75, 0x72, 0x64, 0x72, 0x61, 0x6E, 0x20,
    0x61, 0x6E, 0x64, 0x20, 0x53, 0x6B, 0x79, 0x27, 0x72, 0x65, 0x65, 0x00,
    0x44, 0x65, 0x6E, 0x74, 0x61, 0x72, 0x67, 0x00, 0x4B, 0x68, 0x61, 0x64,
    0x67, 0x61, 0x72, 0x00, 0x47, 0x72, 0x6F, 0x6D, 0x20, 0x48, 0x65, 0x6C,
    0x6C, 0x73, 0x63, 0x72, 0x65, 0x61, 0x6D, 0x00, 0x48, 0x75, 0x6D, 0x61,
    0x6E, 0x20, 0x4F, 0x69, 0x6C, 0x20, 0x54, 0x61, 0x6E, 0x6B, 0x65, 0x72,
    0x00, 0x4F, 0x72, 0x63, 0x20, 0x4F, 0x69, 0x6C, 0x20, 0x54, 0x61, 0x6E,
    0x6B, 0x65, 0x72, 0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x54, 0x72,
    0x61, 0x6E, 0x73, 0x70, 0x6F, 0x72, 0x74, 0x00, 0x4F, 0x72, 0x63, 0x20,
    0x54, 0x72, 0x61, 0x6E, 0x73, 0x70, 0x6F, 0x72, 0x74, 0x00, 0x45, 0x6C,
    0x76, 0x65, 0x6E, 0x20, 0x44, 0x65, 0x73, 0x74, 0x72, 0x6F, 0x79, 0x65,
    0x72, 0x00, 0x54, 0x72, 0x6F, 0x6C, 0x6C, 0x20, 0x44, 0x65, 0x73, 0x74,
    0x72, 0x6F, 0x79, 0x65, 0x72, 0x00, 0x42, 0x61, 0x74, 0x74, 0x6C, 0x65,
    0x73, 0x68, 0x69, 0x70, 0x00, 0x4F, 0x67, 0x72, 0x65, 0x20, 0x4A, 0x75,
    0x67, 0x67, 0x65, 0x72, 0x6E, 0x61, 0x75, 0x67, 0x68, 0x74, 0x00, 0x00,
    0x44, 0x65, 0x61, 0x74, 0x68, 0x77, 0x69, 0x6E, 0x67, 0x00, 0x00, 0x00,
    0x47, 0x6E, 0x6F, 0x6D, 0x69, 0x73, 0x68, 0x20, 0x53, 0x75, 0x62, 0x6D,
    0x61, 0x72, 0x69, 0x6E, 0x65, 0x00, 0x47, 0x69, 0x61, 0x6E, 0x74, 0x20,
    0x54, 0x75, 0x72, 0x74, 0x6C, 0x65, 0x00, 0x47, 0x6E, 0x6F, 0x6D, 0x69,
    0x73, 0x68, 0x20, 0x46, 0x6C, 0x79, 0x69, 0x6E, 0x67, 0x20, 0x4D, 0x61,
    0x63, 0x68, 0x69, 0x6E, 0x65, 0x00, 0x47, 0x6F, 0x62, 0x6C, 0x69, 0x6E,
    0x20, 0x5A, 0x65, 0x70, 0x70, 0x65, 0x6C, 0x69, 0x6E, 0x00, 0x47, 0x72,
    0x79, 0x70, 0x68, 0x6F, 0x6E, 0x20, 0x52, 0x69, 0x64, 0x65, 0x72, 0x00,
    0x44, 0x72, 0x61, 0x67, 0x6F, 0x6E, 0x00, 0x54, 0x75, 0x72, 0x61, 0x6C,
    0x79, 0x6F, 0x6E, 0x00, 0x45, 0x79, 0x65, 0x20, 0x6F, 0x66, 0x20, 0x4B,
    0x69, 0x6C, 0x72, 0x6F, 0x67, 0x67, 0x00, 0x44, 0x61, 0x6E, 0x61, 0x74,
    0x68, 0x00, 0x4B, 0x6F, 0x72, 0x67, 0x61, 0x74, 0x68, 0x20, 0x42, 0x6C,
    0x61, 0x64, 0x65, 0x66, 0x69, 0x73, 0x74, 0x00, 0x00, 0x43, 0x68, 0x6F,
    0x27, 0x67, 0x61, 0x6C, 0x6C, 0x00, 0x4C, 0x6F, 0x74, 0x68, 0x61, 0x72,
    0x00, 0x47, 0x75, 0x6C, 0x27, 0x64, 0x61, 0x6E, 0x00, 0x55, 0x74, 0x68,
    0x65, 0x72, 0x20, 0x4C, 0x69, 0x67, 0x68, 0x74, 0x62, 0x72, 0x69, 0x6E,
    0x67, 0x65, 0x72, 0x00, 0x5A, 0x75, 0x6C, 0x6A, 0x69, 0x6E, 0x00, 0x00,
    0x53, 0x6B, 0x65, 0x6C, 0x65, 0x74, 0x6F, 0x6E, 0x00, 0x44, 0x61, 0x65,
    0x6D, 0x6F, 0x6E, 0x00, 0x43, 0x72, 0x69, 0x74, 0x74, 0x65, 0x72, 0x00,
    0x46, 0x61, 0x72, 0x6D, 0x00, 0x50, 0x69, 0x67, 0x20, 0x46, 0x61, 0x72,
    0x6D, 0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x42, 0x61, 0x72, 0x72,
    0x61, 0x63, 0x6B, 0x73, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x42, 0x61, 0x72,
    0x72, 0x61, 0x63, 0x6B, 0x73, 0x00, 0x43, 0x68, 0x75, 0x72, 0x63, 0x68,
    0x00, 0x41, 0x6C, 0x74, 0x61, 0x72, 0x20, 0x6F, 0x66, 0x20, 0x53, 0x74,
    0x6F, 0x72, 0x6D, 0x73, 0x00, 0x53, 0x63, 0x6F, 0x75, 0x74, 0x20, 0x54,
    0x6F, 0x77, 0x65, 0x72, 0x00, 0x57, 0x61, 0x74, 0x63, 0x68, 0x20, 0x54,
    0x6F, 0x77, 0x65, 0x72, 0x00, 0x53, 0x74, 0x61, 0x62, 0x6C, 0x65, 0x73,
    0x00, 0x4F, 0x67, 0x72, 0x65, 0x20, 0x4D, 0x6F, 0x75, 0x6E, 0x64, 0x00,
    0x47, 0x6E, 0x6F, 0x6D, 0x69, 0x73, 0x68, 0x20, 0x49, 0x6E, 0x76, 0x65,
    0x6E, 0x74, 0x6F, 0x72, 0x00, 0x47, 0x6F, 0x62, 0x6C, 0x69, 0x6E, 0x20,
    0x41, 0x6C, 0x63, 0x68, 0x65, 0x6D, 0x69, 0x73, 0x74, 0x00, 0x47, 0x72,
    0x79, 0x70, 0x68, 0x6F, 0x6E, 0x20, 0x41, 0x76, 0x69, 0x61, 0x72, 0x79,
    0x00, 0x44, 0x72, 0x61, 0x67, 0x6F, 0x6E, 0x20, 0x52, 0x6F, 0x6F, 0x73,
    0x74, 0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x53, 0x68, 0x69, 0x70,
    0x79, 0x61, 0x72, 0x64, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x68, 0x69,
    0x70, 0x79, 0x61, 0x72, 0x64, 0x00, 0x54, 0x6F, 0x77, 0x6E, 0x20, 0x48,
    0x61, 0x6C, 0x6C, 0x00, 0x47, 0x72, 0x65, 0x61, 0x74, 0x20, 0x48, 0x61,
    0x6C, 0x6C, 0x00, 0x45, 0x6C, 0x76, 0x65, 0x6E, 0x20, 0x4C, 0x75, 0x6D,
    0x62, 0x65, 0x72, 0x20, 0x4D, 0x69, 0x6C, 0x6C, 0x00, 0x54, 0x72, 0x6F,
    0x6C, 0x6C, 0x20, 0x4C, 0x75, 0x6D, 0x62, 0x65, 0x72, 0x20, 0x4D, 0x69,
    0x6C, 0x6C, 0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x46, 0x6F, 0x75,
    0x6E, 0x64, 0x72, 0x79, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x46, 0x6F, 0x75,
    0x6E, 0x64, 0x72, 0x79, 0x00, 0x4D, 0x61, 0x67, 0x65, 0x20, 0x54, 0x6F,
    0x77, 0x65, 0x72, 0x00, 0x54, 0x65, 0x6D, 0x70, 0x6C, 0x65, 0x20, 0x6F,
    0x66, 0x20, 0x74, 0x68, 0x65, 0x20, 0x44, 0x61, 0x6D, 0x6E, 0x65, 0x64,
    0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x42, 0x6C, 0x61, 0x63, 0x6B,
    0x73, 0x6D, 0x69, 0x74, 0x68, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x42, 0x6C,
    0x61, 0x63, 0x6B, 0x73, 0x6D, 0x69, 0x74, 0x68, 0x00, 0x48, 0x75, 0x6D,
    0x61, 0x6E, 0x20, 0x52, 0x65, 0x66, 0x69, 0x6E, 0x65, 0x72, 0x79, 0x00,
    0x4F, 0x72, 0x63, 0x20, 0x52, 0x65, 0x66, 0x69, 0x6E, 0x65, 0x72, 0x79,
    0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x4F, 0x69, 0x6C, 0x20, 0x50,
    0x6C, 0x61, 0x74, 0x66, 0x6F, 0x72, 0x6D, 0x00, 0x4F, 0x72, 0x63, 0x20,
    0x4F, 0x69, 0x6C, 0x20, 0x50, 0x6C, 0x61, 0x74, 0x66, 0x6F, 0x72, 0x6D,
    0x00, 0x4B, 0x65, 0x65, 0x70, 0x00, 0x53, 0x74, 0x72, 0x6F, 0x6E, 0x67,
    0x68, 0x6F, 0x6C, 0x64, 0x00, 0x43, 0x61, 0x73, 0x74, 0x6C, 0x65, 0x00,
    0x46, 0x6F, 0x72, 0x74, 0x72, 0x65, 0x73, 0x73, 0x00, 0x47, 0x6F, 0x6C,
    0x64, 0x20, 0x4D, 0x69, 0x6E, 0x65, 0x00, 0x4F, 0x69, 0x6C, 0x20, 0x50,
    0x61, 0x74, 0x63, 0x68, 0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x53,
    0x74, 0x61, 0x72, 0x74, 0x20, 0x4C, 0x6F, 0x63, 0x61, 0x74, 0x69, 0x6F,
    0x6E, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x74, 0x61, 0x72, 0x74, 0x20,
    0x4C, 0x6F, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x00, 0x48, 0x75, 0x6D,
    0x61, 0x6E, 0x20, 0x47, 0x75, 0x61, 0x72, 0x64, 0x20, 0x54, 0x6F, 0x77,
    0x65, 0x72, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x47, 0x75, 0x61, 0x72, 0x64,
    0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x00, 0x48, 0x75, 0x6D, 0x61, 0x6E,
    0x20, 0x43, 0x61, 0x6E, 0x6E, 0x6F, 0x6E, 0x20, 0x54, 0x6F, 0x77, 0x65,
    0x72, 0x00, 0x4F, 0x72, 0x63, 0x20, 0x43, 0x61, 0x6E, 0x6E, 0x6F, 0x6E,
    0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x00, 0x43, 0x69, 0x72, 0x63, 0x6C,
    0x65, 0x20, 0x6F, 0x66, 0x20, 0x50, 0x6F, 0x77, 0x65, 0x72, 0x00, 0x44,
    0x61, 0x72, 0x6B, 0x20, 0x50, 0x6F, 0x72, 0x74, 0x61, 0x6C, 0x00, 0x52,
    0x75, 0x6E, 0x65, 0x73, 0x74, 0x6F, 0x6E, 0x65, 0x00, 0x57, 0x61, 0x6C,
    0x6C, 0x00, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x53,
    0x77, 0x6F, 0x72, 0x64, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74,
    0x68, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A,
    0x53, 0x77, 0x6F, 0x72, 0x64, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67,
    0x74, 0x68, 0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65,
    0x0A, 0x41, 0x78, 0x65, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74,
    0x68, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A,
    0x41, 0x78, 0x65, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68,
    0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x41,
    0x72, 0x72, 0x6F, 0x77, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74,
    0x68, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A,
    0x41, 0x72, 0x72, 0x6F, 0x77, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67,
    0x74, 0x68, 0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65,
    0x0A, 0x53, 0x70, 0x65, 0x61, 0x72, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E,
    0x67, 0x74, 0x68, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64,
    0x65, 0x0A, 0x53, 0x70, 0x65, 0x61, 0x72, 0x0A, 0x53, 0x74, 0x72, 0x65,
    0x6E, 0x67, 0x74, 0x68, 0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61,
    0x64, 0x65, 0x0A, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x53, 0x68, 0x69,
    0x65, 0x6C, 0x64, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68,
    0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x48,
    0x75, 0x6D, 0x61, 0x6E, 0x20, 0x53, 0x68, 0x69, 0x65, 0x6C, 0x64, 0x0A,
    0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68, 0x20, 0x32, 0x00, 0x55,
    0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x4F, 0x72, 0x63, 0x20, 0x53,
    0x68, 0x69, 0x65, 0x6C, 0x64, 0x0A, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67,
    0x74, 0x68, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65,
    0x0A, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x68, 0x69, 0x65, 0x6C, 0x64, 0x0A,
    0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68, 0x20, 0x32, 0x00, 0x55,
    0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x48, 0x75, 0x6D, 0x61, 0x6E,
    0x20, 0x53, 0x68, 0x69, 0x70, 0x0A, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B,
    0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x48,
    0x75, 0x6D, 0x61, 0x6E, 0x20, 0x53, 0x68, 0x69, 0x70, 0x0A, 0x41, 0x74,
    0x74, 0x61, 0x63, 0x6B, 0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61,
    0x64, 0x65, 0x0A, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x68, 0x69, 0x70, 0x0A,
    0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67,
    0x72, 0x61, 0x64, 0x65, 0x0A, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x68, 0x69,
    0x70, 0x0A, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x32, 0x00, 0x55,
    0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x48, 0x75, 0x6D, 0x61, 0x6E,
    0x20, 0x53, 0x68, 0x69, 0x70, 0x0A, 0x41, 0x72, 0x6D, 0x6F, 0x72, 0x20,
    0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x48, 0x75,
    0x6D, 0x61, 0x6E, 0x20, 0x53, 0x68, 0x69, 0x70, 0x0A, 0x41, 0x72, 0x6D,
    0x6F, 0x72, 0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65,
    0x0A, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x68, 0x69, 0x70, 0x0A, 0x41, 0x72,
    0x6D, 0x6F, 0x72, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64,
    0x65, 0x0A, 0x4F, 0x72, 0x63, 0x20, 0x53, 0x68, 0x69, 0x70, 0x0A, 0x41,
    0x72, 0x6D, 0x6F, 0x72, 0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61,
    0x64, 0x65, 0x0A, 0x43, 0x61, 0x74, 0x61, 0x70, 0x75, 0x6C, 0x74, 0x20,
    0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68, 0x20, 0x31, 0x00, 0x55,
    0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x43, 0x61, 0x74, 0x61, 0x70,
    0x75, 0x6C, 0x74, 0x20, 0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68,
    0x20, 0x32, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x0A, 0x42,
    0x61, 0x6C, 0x6C, 0x69, 0x73, 0x74, 0x61, 0x20, 0x53, 0x74, 0x72, 0x65,
    0x6E, 0x67, 0x74, 0x68, 0x20, 0x31, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61,
    0x64, 0x65, 0x0A, 0x42, 0x61, 0x6C, 0x6C, 0x69, 0x73, 0x74, 0x61, 0x20,
    0x53, 0x74, 0x72, 0x65, 0x6E, 0x67, 0x74, 0x68, 0x20, 0x32, 0x00, 0x45,
    0x6C, 0x76, 0x65, 0x6E, 0x20, 0x52, 0x61, 0x6E, 0x67, 0x65, 0x72, 0x20,
    0x54, 0x72, 0x61, 0x69, 0x6E, 0x69, 0x6E, 0x67, 0x00, 0x52, 0x65, 0x73,
    0x65, 0x61, 0x72, 0x63, 0x68, 0x20, 0x4C, 0x6F, 0x6E, 0x67, 0x62, 0x6F,
    0x77, 0x00, 0x52, 0x61, 0x6E, 0x67, 0x65, 0x72, 0x20, 0x53, 0x63, 0x6F,
    0x75, 0x74, 0x69, 0x6E, 0x67, 0x00, 0x52, 0x61, 0x6E, 0x67, 0x65, 0x72,
    0x20, 0x4D, 0x61, 0x72, 0x6B, 0x73, 0x6D, 0x61, 0x6E, 0x73, 0x68, 0x69,
    0x70, 0x00, 0x54, 0x72, 0x6F, 0x6C, 0x6C, 0x20, 0x42, 0x65, 0x72, 0x73,
    0x65, 0x72, 0x6B, 0x65, 0x72, 0x20, 0x54, 0x72, 0x61, 0x69, 0x6E, 0x69,
    0x6E, 0x67, 0x00, 0x52, 0x65, 0x73, 0x65, 0x61, 0x72, 0x63, 0x68, 0x20,
    0x4C, 0x69, 0x67, 0x68, 0x74, 0x65, 0x72, 0x20, 0x41, 0x78, 0x65, 0x73,
    0x00, 0x42, 0x65, 0x72, 0x73, 0x65, 0x72, 0x6B, 0x65, 0x72, 0x20, 0x53,
    0x63, 0x6F, 0x75, 0x74, 0x69, 0x6E, 0x67, 0x00, 0x42, 0x65, 0x72, 0x73,
    0x65, 0x72, 0x6B, 0x65, 0x72, 0x20, 0x52, 0x65, 0x67, 0x65, 0x6E, 0x65,
    0x72, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x00, 0x55, 0x70, 0x67, 0x72, 0x61,
    0x64, 0x65, 0x20, 0x4F, 0x67, 0x72, 0x65, 0x73, 0x20, 0x74, 0x6F, 0x20,
    0x4F, 0x67, 0x72, 0x65, 0x2D, 0x4D, 0x61, 0x67, 0x65, 0x73, 0x00, 0x55,
    0x70, 0x67, 0x72, 0x61, 0x64, 0x65, 0x20, 0x4B, 0x6E, 0x69, 0x67, 0x68,
    0x74, 0x73, 0x20, 0x74, 0x6F, 0x20, 0x50, 0x61, 0x6C, 0x61, 0x64, 0x69,
    0x6E, 0x73, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x48,
    0x6F, 0x6C, 0x79, 0x20, 0x56, 0x69, 0x73, 0x69, 0x6F, 0x6E, 0x00, 0x53,
    0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x48, 0x65, 0x61, 0x6C, 0x69,
    0x6E, 0x67, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x45,
    0x78, 0x6F, 0x72, 0x63, 0x69, 0x73, 0x6D, 0x00, 0x53, 0x70, 0x65, 0x6C,
    0x6C, 0x20, 0x2D, 0x0A, 0x46, 0x6C, 0x61, 0x6D, 0x65, 0x20, 0x53, 0x68,
    0x69, 0x65, 0x6C, 0x64, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D,
    0x0A, 0x46, 0x69, 0x72, 0x65, 0x62, 0x61, 0x6C, 0x6C, 0x00, 0x53, 0x70,
    0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x53, 0x6C, 0x6F, 0x77, 0x00, 0x53,
    0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x49, 0x6E, 0x76, 0x69, 0x73,
    0x69, 0x62, 0x69, 0x6C, 0x69, 0x74, 0x79, 0x00, 0x53, 0x70, 0x65, 0x6C,
    0x6C, 0x20, 0x2D, 0x0A, 0x50, 0x6F, 0x6C, 0x79, 0x6D, 0x6F, 0x72, 0x70,
    0x68, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x42, 0x6C,
    0x69, 0x7A, 0x7A, 0x61, 0x72, 0x64, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C,
    0x20, 0x2D, 0x0A, 0x45, 0x79, 0x65, 0x20, 0x6F, 0x66, 0x20, 0x4B, 0x69,
    0x6C, 0x72, 0x6F, 0x67, 0x67, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20,
    0x2D, 0x0A, 0x42, 0x6C, 0x6F, 0x6F, 0x64, 0x6C, 0x75, 0x73, 0x74, 0x00,
    0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x52, 0x61, 0x69, 0x73,
    0x65, 0x20, 0x44, 0x65, 0x61, 0x64, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C,
    0x20, 0x2D, 0x0A, 0x44, 0x65, 0x61, 0x74, 0x68, 0x20, 0x43, 0x6F, 0x69,
    0x6C, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x57, 0x68,
    0x69, 0x72, 0x6C, 0x77, 0x69, 0x6E, 0x64, 0x00, 0x53, 0x70, 0x65, 0x6C,
    0x6C, 0x20, 0x2D, 0x0A, 0x48, 0x61, 0x73, 0x74, 0x65, 0x00, 0x53, 0x70,
    0x65, 0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x55, 0x6E, 0x68, 0x6F, 0x6C, 0x79,
    0x20, 0x41, 0x72, 0x6D, 0x6F, 0x72, 0x00, 0x53, 0x70, 0x65, 0x6C, 0x6C,
    0x20, 0x2D, 0x0A, 0x52, 0x75, 0x6E, 0x65, 0x73, 0x00, 0x53, 0x70, 0x65,
    0x6C, 0x6C, 0x20, 0x2D, 0x0A, 0x44, 0x65, 0x61, 0x74, 0x68, 0x20, 0x61,
    0x6E, 0x64, 0x20, 0x44, 0x65, 0x63, 0x61, 0x79, 0x00, 0x00, 0x4C, 0x61,
    0x6E, 0x64, 0x20, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x00, 0x50, 0x61,
    0x73, 0x73, 0x69, 0x76, 0x65, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x33,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x34, 0x00, 0x5F, 0x4F,
    0x72, 0x63, 0x20, 0x34, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20,
    0x35, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x35, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x61, 0x6E, 0x20, 0x36, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x36,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x37, 0x00, 0x5F, 0x4F,
    0x72, 0x63, 0x20, 0x37, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20,
    0x38, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x38, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x61, 0x6E, 0x20, 0x39, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x39,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x31, 0x30, 0x00, 0x5F,
    0x4F, 0x72, 0x63, 0x20, 0x31, 0x30, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61,
    0x6E, 0x20, 0x31, 0x31, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x31, 0x31,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x31, 0x32, 0x00, 0x5F,
    0x4F, 0x72, 0x63, 0x20, 0x31, 0x32, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61,
    0x6E, 0x20, 0x31, 0x33, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x31, 0x33,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x31, 0x34, 0x20, 0x28,
    0x4F, 0x72, 0x61, 0x6E, 0x67, 0x65, 0x29, 0x00, 0x5F, 0x4F, 0x72, 0x63,
    0x20, 0x31, 0x34, 0x20, 0x28, 0x42, 0x6C, 0x75, 0x65, 0x29, 0x00, 0x53,
    0x65, 0x61, 0x20, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x00, 0x41, 0x69,
    0x72, 0x20, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x61, 0x6E, 0x20, 0x31, 0x34, 0x20, 0x28, 0x52, 0x65, 0x64, 0x29,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61, 0x6E, 0x20, 0x31, 0x34, 0x20, 0x28,
    0x57, 0x68, 0x69, 0x74, 0x65, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x61,
    0x6E, 0x20, 0x31, 0x34, 0x20, 0x28, 0x42, 0x6C, 0x61, 0x63, 0x6B, 0x29,
    0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x31, 0x34, 0x20, 0x28, 0x47, 0x72,
    0x65, 0x65, 0x6E, 0x29, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x31, 0x34,
    0x20, 0x28, 0x57, 0x68, 0x69, 0x74, 0x65, 0x29, 0x00, 0x5F, 0x4F, 0x72,
    0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x34, 0x00, 0x5F, 0x4F, 0x72,
    0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x35, 0x00, 0x5F, 0x4F, 0x72,
    0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x37, 0x61, 0x00, 0x5F, 0x4F,
    0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x39, 0x00, 0x5F, 0x4F,
    0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x31, 0x30, 0x00, 0x5F,
    0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x31, 0x32, 0x00,
    0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x36, 0x61,
    0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x36,
    0x62, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20,
    0x31, 0x31, 0x61, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70,
    0x2E, 0x20, 0x31, 0x31, 0x62, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45,
    0x78, 0x70, 0x2E, 0x20, 0x32, 0x61, 0x20, 0x28, 0x52, 0x65, 0x64, 0x29,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x32,
    0x62, 0x20, 0x28, 0x42, 0x6C, 0x61, 0x63, 0x6B, 0x29, 0x00, 0x5F, 0x48,
    0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x32, 0x63, 0x20, 0x28,
    0x59, 0x65, 0x6C, 0x6C, 0x6F, 0x77, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D,
    0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x33, 0x61, 0x20, 0x28, 0x4F, 0x72,
    0x61, 0x6E, 0x67, 0x65, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45,
    0x78, 0x70, 0x2E, 0x20, 0x33, 0x62, 0x20, 0x28, 0x52, 0x65, 0x64, 0x29,
    0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x33,
    0x63, 0x20, 0x28, 0x56, 0x69, 0x6F, 0x6C, 0x65, 0x74, 0x29, 0x00, 0x5F,
    0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x34, 0x61, 0x20,
    0x28, 0x42, 0x6C, 0x61, 0x63, 0x6B, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D,
    0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x34, 0x62, 0x20, 0x28, 0x52, 0x65,
    0x64, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E,
    0x20, 0x34, 0x63, 0x20, 0x28, 0x57, 0x68, 0x69, 0x74, 0x65, 0x29, 0x00,
    0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x35, 0x61,
    0x20, 0x28, 0x47, 0x72, 0x65, 0x65, 0x6E, 0x29, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x35, 0x62, 0x20, 0x28, 0x4F,
    0x72, 0x61, 0x6E, 0x67, 0x65, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20,
    0x45, 0x78, 0x70, 0x2E, 0x20, 0x35, 0x63, 0x20, 0x28, 0x56, 0x69, 0x6F,
    0x6C, 0x65, 0x74, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78,
    0x70, 0x2E, 0x20, 0x35, 0x64, 0x20, 0x28, 0x59, 0x65, 0x6C, 0x6C, 0x6F,
    0x77, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E,
    0x20, 0x36, 0x61, 0x20, 0x28, 0x47, 0x72, 0x65, 0x65, 0x6E, 0x29, 0x00,
    0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x36, 0x62,
    0x20, 0x28, 0x42, 0x6C, 0x61, 0x63, 0x6B, 0x29, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x36, 0x63, 0x20, 0x28, 0x4F,
    0x72, 0x61, 0x6E, 0x67, 0x65, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20,
    0x45, 0x78, 0x70, 0x2E, 0x20, 0x36, 0x64, 0x20, 0x28, 0x52, 0x65, 0x64,
    0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20,
    0x38, 0x61, 0x20, 0x28, 0x57, 0x68, 0x69, 0x74, 0x65, 0x29, 0x00, 0x5F,
    0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x38, 0x62, 0x20,
    0x28, 0x59, 0x65, 0x6C, 0x6C, 0x6F, 0x77, 0x29, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x38, 0x63, 0x20, 0x28, 0x56,
    0x69, 0x6F, 0x6C, 0x65, 0x74, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20,
    0x45, 0x78, 0x70, 0x2E, 0x20, 0x39, 0x61, 0x20, 0x28, 0x42, 0x6C, 0x61,
    0x63, 0x6B, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70,
    0x2E, 0x20, 0x39, 0x62, 0x20, 0x28, 0x52, 0x65, 0x64, 0x29, 0x00, 0x5F,
    0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x39, 0x63, 0x20,
    0x28, 0x47, 0x72, 0x65, 0x65, 0x6E, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D,
    0x20, 0x45, 0x78, 0x70, 0x2E, 0x20, 0x39, 0x64, 0x20, 0x28, 0x57, 0x68,
    0x69, 0x74, 0x65, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78,
    0x70, 0x2E, 0x31, 0x30, 0x61, 0x20, 0x28, 0x56, 0x69, 0x6F, 0x6C, 0x65,
    0x74, 0x29, 0x00, 0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E,
    0x31, 0x30, 0x62, 0x20, 0x28, 0x47, 0x72, 0x65, 0x65, 0x6E, 0x29, 0x00,
    0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31, 0x30, 0x63,
    0x20, 0x28, 0x42, 0x6C, 0x61, 0x63, 0x6B, 0x29, 0x00, 0x5F, 0x48, 0x75,
    0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31, 0x31, 0x61, 0x00, 0x5F, 0x48,
    0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31, 0x31, 0x62, 0x00, 0x5F,
    0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31, 0x32, 0x61, 0x00,
    0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x35, 0x62, 0x00,
    0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x37, 0x61, 0x00,
    0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x37, 0x62, 0x00,
    0x5F, 0x48, 0x75, 0x6D, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x37, 0x63, 0x00,
    0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31, 0x32, 0x61,
    0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31, 0x32,
    0x62, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E, 0x31,
    0x32, 0x63, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E,
    0x31, 0x32, 0x64, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70,
    0x2E, 0x32, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E,
    0x37, 0x62, 0x00, 0x5F, 0x4F, 0x72, 0x63, 0x20, 0x45, 0x78, 0x70, 0x2E,
    0x33, 0x00, 0x00, 0x44, 0x77, 0x61, 0x72, 0x76, 0x65, 0x6E, 0x20, 0x44,
    0x65, 0x6D, 0x6F, 0x20, 0x53, 0x71, 0x75, 0x61, 0x64, 0x00, 0x4F, 0x69,
    0x6C, 0x20, 0x54, 0x61, 0x6E, 0x6B, 0x65, 0x72, 0x00, 0x4F, 0x69, 0x6C,
    0x20, 0x54, 0x61, 0x6E, 0x6B, 0x65, 0x72, 0x00, 0x54, 0x72, 0x61, 0x6E,
    0x73, 0x70, 0x6F, 0x72, 0x74, 0x00, 0x54, 0x72, 0x61, 0x6E, 0x73, 0x70,
    0x6F, 0x72, 0x74, 0x00, 0x42, 0x61, 0x72, 0x72, 0x61, 0x63, 0x6B, 0x73,
    0x00, 0x42, 0x61, 0x72, 0x72, 0x61, 0x63, 0x6B, 0x73, 0x00, 0x53, 0x68,
    0x69, 0x70, 0x79, 0x61, 0x72, 0x64, 0x00, 0x53, 0x68, 0x69, 0x70, 0x79,
    0x61, 0x72, 0x64, 0x00, 0x46, 0x6F, 0x75, 0x6E, 0x64, 0x72, 0x79, 0x00,
    0x46, 0x6F, 0x75, 0x6E, 0x64, 0x72, 0x79, 0x00, 0x42, 0x6C, 0x61, 0x63,
    0x6B, 0x73, 0x6D, 0x69, 0x74, 0x68, 0x00, 0x42, 0x6C, 0x61, 0x63, 0x6B,
    0x73, 0x6D, 0x69, 0x74, 0x68, 0x00, 0x52, 0x65, 0x66, 0x69, 0x6E, 0x65,
    0x72, 0x79, 0x00, 0x52, 0x65, 0x66, 0x69, 0x6E, 0x65, 0x72, 0x79, 0x00,
    0x4F, 0x69, 0x6C, 0x20, 0x50, 0x6C, 0x61, 0x74, 0x66, 0x6F, 0x72, 0x6D,
    0x00, 0x4F, 0x69, 0x6C, 0x20, 0x50, 0x6C, 0x61, 0x74, 0x66, 0x6F, 0x72,
    0x6D, 0x00, 0x4D, 0x61, 0x67, 0x65, 0x20, 0x54, 0x6F, 0x77, 0x65, 0x72,
    0x00, 0x54, 0x65, 0x6D, 0x70, 0x6C, 0x65, 0x20, 0x6F, 0x66, 0x20, 0x74,
    0x68, 0x65, 0x20, 0x44, 0x61, 0x6D, 0x6E, 0x65, 0x64, 0x00, 0x47, 0x75,
    0x61, 0x72, 0x64, 0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x00, 0x47, 0x75,
    0x61, 0x72, 0x64, 0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x00, 0x43, 0x61,
    0x6E, 0x6E, 0x6F, 0x6E, 0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x00, 0x43,
    0x61, 0x6E, 0x6E, 0x6F, 0x6E, 0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x00,
    0x45, 0x79, 0x65, 0x20, 0x6F, 0x66, 0x20, 0x4B, 0x69, 0x6C, 0x72, 0x6F,
    0x67, 0x67, 0x00, 0x45, 0x53, 0x43, 0x00, 0x70, 0x01, 0x54, 0x52, 0x41,
    0x49, 0x4E, 0x20, 0x04, 0x50, 0x01, 0x45, 0x4F, 0x4E, 0x00, 0x70, 0x01,
    0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04, 0x50, 0x01, 0x45, 0x41, 0x53,
    0x41, 0x4E, 0x54, 0x00, 0x61, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20,
    0x04, 0x41, 0x01, 0x58, 0x45, 0x54, 0x48, 0x52, 0x4F, 0x57, 0x45, 0x52,
    0x00, 0x61, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04, 0x41, 0x01,
    0x52, 0x43, 0x48, 0x45, 0x52, 0x00, 0x61, 0x01, 0x54, 0x52, 0x41, 0x49,
    0x4E, 0x20, 0x52, 0x04, 0x41, 0x01, 0x4E, 0x47, 0x45, 0x52, 0x00, 0x61,
    0x01, 0x54, 0x52, 0x04, 0x41, 0x01, 0x49, 0x4E, 0x20, 0x42, 0x45, 0x52,
    0x53, 0x45, 0x52, 0x4B, 0x45, 0x52, 0x00, 0x6B, 0x01, 0x54, 0x52, 0x41,
    0x49, 0x4E, 0x20, 0x04, 0x4B, 0x01, 0x4E, 0x49, 0x47, 0x48, 0x54, 0x00,
    0x6F, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x54, 0x57, 0x4F, 0x2D,
    0x48, 0x45, 0x41, 0x44, 0x45, 0x44, 0x20, 0x04, 0x4F, 0x01, 0x47, 0x52,
    0x45, 0x00, 0x70, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04, 0x50,
    0x01, 0x41, 0x4C, 0x41, 0x44, 0x49, 0x4E, 0x00, 0x6F, 0x01, 0x54, 0x52,
    0x41, 0x49, 0x4E, 0x20, 0x04, 0x4F, 0x01, 0x47, 0x52, 0x45, 0x2D, 0x4D,
    0x41, 0x47, 0x45, 0x00, 0x74, 0x01, 0x04, 0x54, 0x01, 0x52, 0x41, 0x49,
    0x4E, 0x20, 0x44, 0x45, 0x41, 0x54, 0x48, 0x20, 0x4B, 0x4E, 0x49, 0x47,
    0x48, 0x54, 0x00, 0x74, 0x01, 0x04, 0x54, 0x01, 0x52, 0x41, 0x49, 0x4E,
    0x20, 0x43, 0x4C, 0x45, 0x52, 0x49, 0x43, 0x00, 0x74, 0x01, 0x04, 0x54,
    0x01, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x4D, 0x41, 0x47, 0x45, 0x00, 0x67,
    0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04, 0x47, 0x01, 0x52, 0x55,
    0x4E, 0x54, 0x00, 0x66, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04,
    0x46, 0x01, 0x4F, 0x4F, 0x54, 0x4D, 0x41, 0x4E, 0x00, 0x62, 0x01, 0x42,
    0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x42, 0x01, 0x41, 0x4C, 0x4C, 0x49,
    0x53, 0x54, 0x41, 0x00, 0x63, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20,
    0x04, 0x43, 0x01, 0x41, 0x54, 0x41, 0x50, 0x55, 0x4C, 0x54, 0x00, 0x6F,
    0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x4F, 0x01, 0x49, 0x4C,
    0x20, 0x54, 0x41, 0x4E, 0x4B, 0x45, 0x52, 0x00, 0x64, 0x01, 0x42, 0x55,
    0x49, 0x4C, 0x44, 0x20, 0x04, 0x44, 0x01, 0x45, 0x53, 0x54, 0x52, 0x4F,
    0x59, 0x45, 0x52, 0x00, 0x74, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20,
    0x04, 0x54, 0x01, 0x52, 0x41, 0x4E, 0x53, 0x50, 0x4F, 0x52, 0x54, 0x00,
    0x62, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x42, 0x01, 0x41,
    0x54, 0x54, 0x4C, 0x45, 0x53, 0x48, 0x49, 0x50, 0x00, 0x6A, 0x01, 0x42,
    0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x4A, 0x01, 0x55, 0x47, 0x47, 0x45,
    0x52, 0x4E, 0x41, 0x55, 0x47, 0x48, 0x54, 0x00, 0x73, 0x01, 0x42, 0x55,
    0x49, 0x4C, 0x44, 0x20, 0x47, 0x4E, 0x4F, 0x4D, 0x49, 0x53, 0x48, 0x20,
    0x04, 0x53, 0x01, 0x55, 0x42, 0x4D, 0x41, 0x52, 0x49, 0x4E, 0x45, 0x00,
    0x67, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04, 0x47, 0x01, 0x49,
    0x41, 0x4E, 0x54, 0x20, 0x54, 0x55, 0x52, 0x54, 0x4C, 0x45, 0x00, 0x7A,
    0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x47, 0x4F, 0x42, 0x4C, 0x49,
    0x4E, 0x20, 0x04, 0x5A, 0x01, 0x45, 0x50, 0x50, 0x45, 0x4C, 0x49, 0x4E,
    0x00, 0x66, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x46, 0x01,
    0x4C, 0x59, 0x49, 0x4E, 0x47, 0x20, 0x4D, 0x41, 0x43, 0x48, 0x49, 0x4E,
    0x45, 0x00, 0x67, 0x01, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x20, 0x04, 0x47,
    0x01, 0x52, 0x59, 0x50, 0x48, 0x4F, 0x4E, 0x20, 0x52, 0x49, 0x44, 0x45,
    0x52, 0x00, 0x64, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x44,
    0x01, 0x52, 0x41, 0x47, 0x4F, 0x4E, 0x00, 0x64, 0x01, 0x54, 0x52, 0x41,
    0x49, 0x4E, 0x20, 0x04, 0x44, 0x01, 0x57, 0x41, 0x52, 0x56, 0x45, 0x4E,
    0x20, 0x44, 0x45, 0x4D, 0x4F, 0x4C, 0x49, 0x54, 0x49, 0x4F, 0x4E, 0x20,
    0x53, 0x51, 0x55, 0x41, 0x44, 0x00, 0x73, 0x01, 0x54, 0x52, 0x41, 0x49,
    0x4E, 0x20, 0x47, 0x4F, 0x42, 0x4C, 0x49, 0x4E, 0x20, 0x04, 0x53, 0x01,
    0x41, 0x50, 0x50, 0x45, 0x52, 0x53, 0x00, 0x62, 0x01, 0x42, 0x55, 0x49,
    0x4C, 0x44, 0x20, 0x04, 0x42, 0x01, 0x41, 0x52, 0x52, 0x41, 0x43, 0x4B,
    0x53, 0x00, 0x6C, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x4C,
    0x01, 0x55, 0x4D, 0x42, 0x45, 0x52, 0x20, 0x4D, 0x49, 0x4C, 0x4C, 0x00,
    0x61, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x53, 0x54, 0x04, 0x41,
    0x01, 0x42, 0x4C, 0x45, 0x53, 0x00, 0x6F, 0x01, 0x42, 0x55, 0x49, 0x4C,
    0x44, 0x20, 0x04, 0x4F, 0x01, 0x47, 0x52, 0x45, 0x20, 0x4D, 0x4F, 0x55,
    0x4E, 0x44, 0x00, 0x74, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04,
    0x54, 0x01, 0x4F, 0x57, 0x45, 0x52, 0x00, 0x63, 0x01, 0x42, 0x55, 0x49,
    0x4C, 0x44, 0x20, 0x04, 0x43, 0x01, 0x48, 0x55, 0x52, 0x43, 0x48, 0x00,
    0x6C, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x41, 0x04, 0x4C, 0x01,
    0x54, 0x41, 0x52, 0x20, 0x4F, 0x46, 0x20, 0x53, 0x54, 0x4F, 0x52, 0x4D,
    0x53, 0x00, 0x66, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x46,
    0x01, 0x41, 0x52, 0x4D, 0x00, 0x68, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44,
    0x20, 0x41, 0x20, 0x54, 0x4F, 0x57, 0x4E, 0x20, 0x04, 0x48, 0x01, 0x41,
    0x4C, 0x4C, 0x00, 0x68, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x41,
    0x20, 0x47, 0x52, 0x45, 0x41, 0x54, 0x20, 0x04, 0x48, 0x01, 0x41, 0x4C,
    0x4C, 0x00, 0x62, 0x01, 0x04, 0x42, 0x01, 0x55, 0x49, 0x4C, 0x44, 0x20,
    0x4F, 0x49, 0x4C, 0x20, 0x50, 0x4C, 0x41, 0x54, 0x46, 0x4F, 0x52, 0x4D,
    0x00, 0x72, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x4F, 0x49, 0x4C,
    0x20, 0x04, 0x52, 0x01, 0x45, 0x46, 0x49, 0x4E, 0x45, 0x52, 0x59, 0x00,
    0x66, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x46, 0x01, 0x4F,
    0x55, 0x4E, 0x44, 0x52, 0x59, 0x00, 0x77, 0x01, 0x42, 0x55, 0x49, 0x4C,
    0x44, 0x20, 0x04, 0x57, 0x01, 0x41, 0x4C, 0x4C, 0x00, 0x73, 0x01, 0x42,
    0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x53, 0x01, 0x48, 0x49, 0x50, 0x59,
    0x41, 0x52, 0x44, 0x00, 0x73, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20,
    0x42, 0x4C, 0x41, 0x43, 0x4B, 0x04, 0x53, 0x01, 0x4D, 0x49, 0x54, 0x48,
    0x00, 0x63, 0x01, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x54,
    0x4F, 0x20, 0x04, 0x43, 0x01, 0x41, 0x53, 0x54, 0x4C, 0x45, 0x00, 0x66,
    0x01, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x54, 0x4F, 0x20,
    0x04, 0x46, 0x01, 0x4F, 0x52, 0x54, 0x52, 0x45, 0x53, 0x53, 0x00, 0x6B,
    0x01, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x54, 0x4F, 0x20,
    0x04, 0x4B, 0x01, 0x45, 0x45, 0x50, 0x00, 0x73, 0x01, 0x55, 0x50, 0x47,
    0x52, 0x41, 0x44, 0x45, 0x20, 0x54, 0x4F, 0x20, 0x04, 0x53, 0x01, 0x54,
    0x52, 0x4F, 0x4E, 0x47, 0x48, 0x4F, 0x4C, 0x44, 0x00, 0x67, 0x01, 0x55,
    0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x54, 0x4F, 0x20, 0x04, 0x47,
    0x01, 0x55, 0x41, 0x52, 0x44, 0x20, 0x54, 0x4F, 0x57, 0x45, 0x52, 0x00,
    0x63, 0x01, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x54, 0x4F,
    0x20, 0x04, 0x43, 0x01, 0x41, 0x4E, 0x4E, 0x4F, 0x4E, 0x20, 0x54, 0x4F,
    0x57, 0x45, 0x52, 0x00, 0x69, 0x01, 0x42, 0x55, 0x49, 0x4C, 0x44, 0x20,
    0x47, 0x4E, 0x4F, 0x4D, 0x49, 0x53, 0x48, 0x20, 0x04, 0x49, 0x01, 0x4E,
    0x56, 0x45, 0x4E, 0x54, 0x4F, 0x52, 0x00, 0x61, 0x01, 0x42, 0x55, 0x49,
    0x4C, 0x44, 0x20, 0x47, 0x4F, 0x42, 0x4C, 0x49, 0x4E, 0x20, 0x04, 0x41,
    0x01, 0x4C, 0x43, 0x48, 0x45, 0x4D, 0x49, 0x53, 0x54, 0x00, 0x67, 0x01,
    0x42, 0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x47, 0x01, 0x52, 0x59, 0x50,
    0x48, 0x4F, 0x4E, 0x20, 0x41, 0x56, 0x49, 0x41, 0x52, 0x59, 0x00, 0x64,
    0x01, 0x4D, 0x41, 0x4B, 0x45, 0x20, 0x04, 0x44, 0x01, 0x52, 0x41, 0x47,
    0x4F, 0x4E, 0x20, 0x52, 0x4F, 0x4F, 0x53, 0x54, 0x00, 0x6D, 0x01, 0x42,
    0x55, 0x49, 0x4C, 0x44, 0x20, 0x04, 0x4D, 0x01, 0x41, 0x47, 0x45, 0x20,
    0x54, 0x4F, 0x57, 0x45, 0x52, 0x00, 0x74, 0x01, 0x42, 0x55, 0x49, 0x4C,
    0x44, 0x20, 0x04, 0x54, 0x01, 0x45, 0x4D, 0x50, 0x4C, 0x45, 0x20, 0x4F,
    0x46, 0x20, 0x54, 0x48, 0x45, 0x20, 0x44, 0x41, 0x4D, 0x4E, 0x45, 0x44,
    0x00, 0x62, 0x02, 0x04, 0x42, 0x01, 0x52, 0x45, 0x45, 0x44, 0x20, 0x46,
    0x41, 0x53, 0x54, 0x45, 0x52, 0x20, 0x48, 0x4F, 0x52, 0x53, 0x45, 0x53,
    0x00, 0x62, 0x02, 0x04, 0x42, 0x01, 0x52, 0x45, 0x45, 0x44, 0x20, 0x46,
    0x41, 0x53, 0x54, 0x45, 0x52, 0x20, 0x57, 0x4F, 0x4C, 0x56, 0x45, 0x53,
    0x00, 0x77, 0x02, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x53,
    0x04, 0x57, 0x01, 0x4F, 0x52, 0x44, 0x53, 0x20, 0x28, 0x44, 0x61, 0x6D,
    0x61, 0x67, 0x65, 0x20, 0x2B, 0x32, 0x29, 0x00, 0x75, 0x02, 0x04, 0x55,
    0x01, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x54, 0x48, 0x52, 0x4F,
    0x57, 0x49, 0x4E, 0x47, 0x20, 0x41, 0x58, 0x45, 0x53, 0x20, 0x28, 0x44,
    0x61, 0x6D, 0x61, 0x67, 0x65, 0x20, 0x2B, 0x31, 0x29, 0x00, 0x77, 0x02,
    0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x04, 0x57, 0x01, 0x45,
    0x41, 0x50, 0x4F, 0x4E, 0x53, 0x20, 0x28, 0x44, 0x61, 0x6D, 0x61, 0x67,
    0x65, 0x20, 0x2B, 0x32, 0x29, 0x00, 0x75, 0x02, 0x04, 0x55, 0x01, 0x50,
    0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x41, 0x52, 0x52, 0x4F, 0x57, 0x53,
    0x20, 0x28, 0x44, 0x61, 0x6D, 0x61, 0x67, 0x65, 0x20, 0x2B, 0x31, 0x29,
    0x00, 0x68, 0x02, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x53,
    0x04, 0x48, 0x01, 0x49, 0x45, 0x4C, 0x44, 0x53, 0x20, 0x28, 0x41, 0x72,
    0x6D, 0x6F, 0x72, 0x20, 0x2B, 0x32, 0x29, 0x00, 0x68, 0x02, 0x55, 0x50,
    0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x53, 0x04, 0x48, 0x01, 0x49, 0x45,
    0x4C, 0x44, 0x53, 0x20, 0x28, 0x41, 0x72, 0x6D, 0x6F, 0x72, 0x20, 0x2B,
    0x32, 0x29, 0x00, 0x63, 0x02, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45,
    0x20, 0x04, 0x43, 0x01, 0x41, 0x4E, 0x4E, 0x4F, 0x4E, 0x53, 0x20, 0x28,
    0x44, 0x61, 0x6D, 0x61, 0x67, 0x65, 0x20, 0x2B, 0x35, 0x29, 0x00, 0x61,
    0x02, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x53, 0x48, 0x49,
    0x50, 0x20, 0x04, 0x41, 0x01, 0x52, 0x4D, 0x4F, 0x52, 0x20, 0x28, 0x41,
    0x72, 0x6D, 0x6F, 0x72, 0x20, 0x2B, 0x35, 0x29, 0x00, 0x73, 0x02, 0x55,
    0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x53, 0x48, 0x49, 0x50, 0x20,
    0x04, 0x53, 0x01, 0x50, 0x45, 0x45, 0x44, 0x00, 0x72, 0x02, 0x45, 0x4C,
    0x56, 0x45, 0x4E, 0x20, 0x04, 0x52, 0x01, 0x41, 0x4E, 0x47, 0x45, 0x52,
    0x20, 0x54, 0x52, 0x41, 0x49, 0x4E, 0x49, 0x4E, 0x47, 0x00, 0x6C, 0x02,
    0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x4C, 0x01,
    0x4F, 0x4E, 0x47, 0x42, 0x4F, 0x57, 0x20, 0x28, 0x52, 0x61, 0x6E, 0x67,
    0x65, 0x20, 0x2B, 0x31, 0x29, 0x00, 0x73, 0x02, 0x52, 0x41, 0x4E, 0x47,
    0x45, 0x52, 0x20, 0x04, 0x53, 0x01, 0x43, 0x4F, 0x55, 0x54, 0x49, 0x4E,
    0x47, 0x20, 0x28, 0x53, 0x69, 0x67, 0x68, 0x74, 0x3A, 0x39, 0x29, 0x00,
    0x6D, 0x02, 0x52, 0x41, 0x4E, 0x47, 0x45, 0x52, 0x20, 0x04, 0x4D, 0x01,
    0x41, 0x52, 0x4B, 0x53, 0x4D, 0x41, 0x4E, 0x53, 0x48, 0x49, 0x50, 0x20,
    0x28, 0x44, 0x61, 0x6D, 0x61, 0x67, 0x65, 0x20, 0x2B, 0x33, 0x29, 0x00,
    0x62, 0x02, 0x54, 0x52, 0x4F, 0x4C, 0x4C, 0x20, 0x04, 0x42, 0x01, 0x45,
    0x52, 0x53, 0x45, 0x52, 0x4B, 0x45, 0x52, 0x20, 0x54, 0x52, 0x41, 0x49,
    0x4E, 0x49, 0x4E, 0x47, 0x00, 0x61, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41,
    0x52, 0x43, 0x48, 0x20, 0x4C, 0x49, 0x47, 0x48, 0x54, 0x45, 0x52, 0x20,
    0x04, 0x41, 0x01, 0x58, 0x45, 0x53, 0x20, 0x28, 0x52, 0x61, 0x6E, 0x67,
    0x65, 0x20, 0x2B, 0x31, 0x29, 0x00, 0x73, 0x02, 0x42, 0x45, 0x52, 0x53,
    0x45, 0x52, 0x4B, 0x45, 0x52, 0x20, 0x04, 0x53, 0x01, 0x43, 0x4F, 0x55,
    0x54, 0x49, 0x4E, 0x47, 0x20, 0x28, 0x53, 0x69, 0x67, 0x68, 0x74, 0x3A,
    0x39, 0x29, 0x00, 0x72, 0x02, 0x42, 0x45, 0x52, 0x53, 0x45, 0x52, 0x4B,
    0x45, 0x52, 0x20, 0x04, 0x52, 0x01, 0x45, 0x47, 0x45, 0x4E, 0x45, 0x52,
    0x41, 0x54, 0x49, 0x4F, 0x4E, 0x00, 0x63, 0x02, 0x55, 0x50, 0x47, 0x52,
    0x41, 0x44, 0x45, 0x20, 0x04, 0x43, 0x01, 0x41, 0x54, 0x41, 0x50, 0x55,
    0x4C, 0x54, 0x53, 0x20, 0x28, 0x44, 0x61, 0x6D, 0x61, 0x67, 0x65, 0x20,
    0x2B, 0x31, 0x35, 0x29, 0x00, 0x62, 0x02, 0x55, 0x50, 0x47, 0x52, 0x41,
    0x44, 0x45, 0x20, 0x04, 0x42, 0x01, 0x41, 0x4C, 0x4C, 0x49, 0x53, 0x54,
    0x41, 0x53, 0x20, 0x28, 0x44, 0x61, 0x6D, 0x61, 0x67, 0x65, 0x20, 0x2B,
    0x31, 0x35, 0x29, 0x00, 0x61, 0x00, 0x4C, 0x49, 0x47, 0x48, 0x54, 0x4E,
    0x49, 0x4E, 0x47, 0x20, 0x04, 0x41, 0x01, 0x54, 0x54, 0x41, 0x43, 0x4B,
    0x00, 0x66, 0x03, 0x04, 0x46, 0x01, 0x49, 0x52, 0x45, 0x42, 0x41, 0x4C,
    0x4C, 0x00, 0x6C, 0x03, 0x46, 0x04, 0x4C, 0x01, 0x41, 0x4D, 0x45, 0x20,
    0x53, 0x48, 0x49, 0x45, 0x4C, 0x44, 0x00, 0x6F, 0x03, 0x53, 0x4C, 0x04,
    0x4F, 0x01, 0x57, 0x00, 0x69, 0x03, 0x04, 0x49, 0x01, 0x4E, 0x56, 0x49,
    0x53, 0x49, 0x42, 0x49, 0x4C, 0x49, 0x54, 0x59, 0x00, 0x70, 0x03, 0x04,
    0x50, 0x01, 0x4F, 0x4C, 0x59, 0x4D, 0x4F, 0x52, 0x50, 0x48, 0x00, 0x62,
    0x03, 0x04, 0x42, 0x01, 0x4C, 0x49, 0x5A, 0x5A, 0x41, 0x52, 0x44, 0x00,
    0x61, 0x00, 0x54, 0x4F, 0x55, 0x43, 0x48, 0x20, 0x4F, 0x46, 0x20, 0x44,
    0x04, 0x41, 0x01, 0x52, 0x4B, 0x4E, 0x45, 0x53, 0x53, 0x00, 0x64, 0x03,
    0x04, 0x44, 0x01, 0x45, 0x41, 0x54, 0x48, 0x20, 0x41, 0x4E, 0x44, 0x20,
    0x44, 0x45, 0x43, 0x41, 0x59, 0x00, 0x63, 0x03, 0x44, 0x45, 0x41, 0x54,
    0x48, 0x20, 0x04, 0x43, 0x01, 0x4F, 0x49, 0x4C, 0x00, 0x68, 0x03, 0x04,
    0x48, 0x01, 0x41, 0x53, 0x54, 0x45, 0x00, 0x75, 0x03, 0x04, 0x55, 0x01,
    0x4E, 0x48, 0x4F, 0x4C, 0x59, 0x20, 0x41, 0x52, 0x4D, 0x4F, 0x52, 0x00,
    0x72, 0x03, 0x04, 0x52, 0x01, 0x55, 0x4E, 0x45, 0x53, 0x00, 0x77, 0x03,
    0x04, 0x57, 0x01, 0x48, 0x49, 0x52, 0x4C, 0x57, 0x49, 0x4E, 0x44, 0x00,
    0x76, 0x03, 0x48, 0x4F, 0x4C, 0x59, 0x20, 0x04, 0x56, 0x01, 0x49, 0x53,
    0x49, 0x4F, 0x4E, 0x00, 0x68, 0x03, 0x04, 0x48, 0x01, 0x45, 0x41, 0x4C,
    0x49, 0x4E, 0x47, 0x20, 0x28, 0x70, 0x65, 0x72, 0x20, 0x31, 0x20, 0x48,
    0x50, 0x29, 0x00, 0x67, 0x03, 0x04, 0x47, 0x01, 0x52, 0x45, 0x41, 0x54,
    0x45, 0x52, 0x20, 0x48, 0x45, 0x41, 0x4C, 0x49, 0x4E, 0x47, 0x00, 0x65,
    0x03, 0x04, 0x45, 0x01, 0x58, 0x4F, 0x52, 0x43, 0x49, 0x53, 0x4D, 0x00,
    0x65, 0x03, 0x04, 0x45, 0x01, 0x59, 0x45, 0x20, 0x4F, 0x46, 0x20, 0x4B,
    0x49, 0x4C, 0x52, 0x4F, 0x47, 0x47, 0x00, 0x62, 0x03, 0x04, 0x42, 0x01,
    0x4C, 0x4F, 0x4F, 0x44, 0x4C, 0x55, 0x53, 0x54, 0x00, 0x68, 0x03, 0x04,
    0x48, 0x01, 0x41, 0x4C, 0x4C, 0x55, 0x43, 0x49, 0x4E, 0x41, 0x54, 0x45,
    0x00, 0x72, 0x03, 0x04, 0x52, 0x01, 0x41, 0x49, 0x53, 0x45, 0x20, 0x44,
    0x45, 0x41, 0x44, 0x00, 0x70, 0x02, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44,
    0x45, 0x20, 0x4B, 0x4E, 0x49, 0x47, 0x48, 0x54, 0x53, 0x20, 0x54, 0x4F,
    0x20, 0x04, 0x50, 0x01, 0x41, 0x4C, 0x41, 0x44, 0x49, 0x4E, 0x53, 0x00,
    0x6D, 0x02, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x4F, 0x47,
    0x52, 0x45, 0x53, 0x20, 0x54, 0x4F, 0x20, 0x04, 0x4D, 0x01, 0x41, 0x47,
    0x45, 0x53, 0x00, 0x66, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43,
    0x48, 0x20, 0x04, 0x46, 0x01, 0x49, 0x52, 0x45, 0x42, 0x41, 0x4C, 0x4C,
    0x00, 0x6C, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20,
    0x46, 0x04, 0x4C, 0x01, 0x41, 0x4D, 0x45, 0x20, 0x53, 0x48, 0x49, 0x45,
    0x4C, 0x44, 0x00, 0x6F, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43,
    0x48, 0x20, 0x53, 0x4C, 0x04, 0x4F, 0x01, 0x57, 0x00, 0x69, 0x02, 0x52,
    0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x49, 0x01, 0x4E,
    0x56, 0x49, 0x53, 0x49, 0x42, 0x49, 0x4C, 0x49, 0x54, 0x59, 0x00, 0x70,
    0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x50,
    0x01, 0x4F, 0x4C, 0x59, 0x4D, 0x4F, 0x52, 0x50, 0x48, 0x00, 0x62, 0x02,
    0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x42, 0x01,
    0x4C, 0x49, 0x5A, 0x5A, 0x41, 0x52, 0x44, 0x00, 0x64, 0x02, 0x52, 0x45,
    0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x44, 0x01, 0x45, 0x41,
    0x54, 0x48, 0x20, 0x41, 0x4E, 0x44, 0x20, 0x44, 0x45, 0x43, 0x41, 0x59,
    0x00, 0x63, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20,
    0x44, 0x45, 0x41, 0x54, 0x48, 0x20, 0x04, 0x43, 0x01, 0x4F, 0x49, 0x4C,
    0x00, 0x68, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20,
    0x04, 0x48, 0x01, 0x41, 0x53, 0x54, 0x45, 0x00, 0x75, 0x02, 0x52, 0x45,
    0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x55, 0x01, 0x4E, 0x48,
    0x4F, 0x4C, 0x59, 0x20, 0x41, 0x52, 0x4D, 0x4F, 0x52, 0x00, 0x72, 0x02,
    0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x52, 0x01,
    0x55, 0x4E, 0x45, 0x53, 0x00, 0x77, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41,
    0x52, 0x43, 0x48, 0x20, 0x04, 0x57, 0x01, 0x48, 0x49, 0x52, 0x4C, 0x57,
    0x49, 0x4E, 0x44, 0x00, 0x76, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52,
    0x43, 0x48, 0x20, 0x48, 0x4F, 0x4C, 0x59, 0x20, 0x04, 0x56, 0x01, 0x49,
    0x53, 0x49, 0x4F, 0x4E, 0x00, 0x68, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41,
    0x52, 0x43, 0x48, 0x20, 0x04, 0x48, 0x01, 0x45, 0x41, 0x4C, 0x49, 0x4E,
    0x47, 0x00, 0x67, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48,
    0x20, 0x04, 0x47, 0x01, 0x52, 0x45, 0x41, 0x54, 0x45, 0x52, 0x20, 0x48,
    0x45, 0x41, 0x4C, 0x49, 0x4E, 0x47, 0x00, 0x65, 0x02, 0x52, 0x45, 0x53,
    0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x45, 0x01, 0x58, 0x4F, 0x52,
    0x43, 0x49, 0x53, 0x4D, 0x00, 0x65, 0x02, 0x52, 0x45, 0x53, 0x45, 0x41,
    0x52, 0x43, 0x48, 0x20, 0x04, 0x45, 0x01, 0x59, 0x45, 0x20, 0x4F, 0x46,
    0x20, 0x4B, 0x49, 0x4C, 0x52, 0x4F, 0x47, 0x47, 0x00, 0x62, 0x02, 0x52,
    0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x42, 0x01, 0x4C,
    0x4F, 0x4F, 0x44, 0x4C, 0x55, 0x53, 0x54, 0x00, 0x68, 0x02, 0x52, 0x45,
    0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x48, 0x01, 0x41, 0x4C,
    0x4C, 0x55, 0x43, 0x49, 0x4E, 0x41, 0x54, 0x45, 0x00, 0x72, 0x02, 0x52,
    0x45, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x04, 0x52, 0x01, 0x41,
    0x49, 0x53, 0x45, 0x20, 0x44, 0x45, 0x41, 0x44, 0x00, 0x6D, 0x00, 0x04,
    0x4D, 0x01, 0x4F, 0x56, 0x45, 0x00, 0x73, 0x00, 0x04, 0x53, 0x01, 0x54,
    0x4F, 0x50, 0x00, 0x61, 0x00, 0x04, 0x41, 0x01, 0x54, 0x54, 0x41, 0x43,
    0x4B, 0x00, 0x72, 0x00, 0x04, 0x52, 0x01, 0x45, 0x50, 0x41, 0x49, 0x52,
    0x00, 0x68, 0x00, 0x04, 0x48, 0x01, 0x41, 0x52, 0x56, 0x45, 0x53, 0x54,
    0x20, 0x4C, 0x55, 0x4D, 0x42, 0x45, 0x52, 0x2F, 0x4D, 0x49, 0x4E, 0x45,
    0x20, 0x47, 0x4F, 0x4C, 0x44, 0x00, 0x68, 0x00, 0x04, 0x48, 0x01, 0x41,
    0x55, 0x4C, 0x20, 0x4F, 0x49, 0x4C, 0x00, 0x62, 0x00, 0x42, 0x55, 0x49,
    0x4C, 0x44, 0x20, 0x04, 0x42, 0x01, 0x41, 0x53, 0x49, 0x43, 0x20, 0x53,
    0x54, 0x52, 0x55, 0x43, 0x54, 0x55, 0x52, 0x45, 0x00, 0x76, 0x00, 0x42,
    0x55, 0x49, 0x4C, 0x44, 0x20, 0x41, 0x44, 0x04, 0x56, 0x01, 0x41, 0x4E,
    0x43, 0x45, 0x44, 0x20, 0x53, 0x54, 0x52, 0x55, 0x43, 0x54, 0x55, 0x52,
    0x45, 0x00, 0x6F, 0x00, 0x53, 0x45, 0x41, 0x52, 0x43, 0x48, 0x20, 0x46,
    0x4F, 0x52, 0x20, 0x04, 0x4F, 0x01, 0x49, 0x4C, 0x00, 0x67, 0x00, 0x52,
    0x45, 0x54, 0x55, 0x52, 0x4E, 0x20, 0x57, 0x49, 0x54, 0x48, 0x20, 0x04,
    0x47, 0x01, 0x4F, 0x4F, 0x44, 0x53, 0x00, 0x67, 0x00, 0x41, 0x54, 0x54,
    0x41, 0x43, 0x4B, 0x20, 0x04, 0x47, 0x01, 0x52, 0x4F, 0x55, 0x4E, 0x44,
    0x00, 0x74, 0x00, 0x53, 0x04, 0x54, 0x01, 0x41, 0x4E, 0x44, 0x20, 0x47,
    0x52, 0x4F, 0x55, 0x4E, 0x44, 0x00, 0x70, 0x00, 0x04, 0x50, 0x01, 0x41,
    0x54, 0x52, 0x4F, 0x4C, 0x00, 0x75, 0x00, 0x04, 0x55, 0x01, 0x4E, 0x4C,
    0x4F, 0x41, 0x44, 0x20, 0x54, 0x52, 0x41, 0x4E, 0x53, 0x50, 0x4F, 0x52,
    0x54, 0x00, 0x64, 0x00, 0x04, 0x44, 0x01, 0x45, 0x4D, 0x4F, 0x4C, 0x49,
    0x53, 0x48, 0x00, 0x10, 0x00, 0x04, 0x45, 0x53, 0x43, 0x01, 0x20, 0x2D,
    0x20, 0x43, 0x41, 0x4E, 0x43, 0x45, 0x4C, 0x00, 0x10, 0x00, 0x04, 0x45,
    0x53, 0x43, 0x01, 0x20, 0x2D, 0x20, 0x43, 0x41, 0x4E, 0x43, 0x45, 0x4C,
    0x20, 0x43, 0x4F, 0x4E, 0x53, 0x54, 0x52, 0x55, 0x43, 0x54, 0x49, 0x4F,
    0x4E, 0x00, 0x10, 0x00, 0x04, 0x45, 0x53, 0x43, 0x01, 0x20, 0x2D, 0x20,
    0x43, 0x41, 0x4E, 0x43, 0x45, 0x4C, 0x20, 0x55, 0x4E, 0x49, 0x54, 0x20,
    0x54, 0x52, 0x41, 0x49, 0x4E, 0x49, 0x4E, 0x47, 0x00, 0x10, 0x00, 0x04,
    0x45, 0x53, 0x43, 0x01, 0x20, 0x2D, 0x20, 0x43, 0x41, 0x4E, 0x43, 0x45,
    0x4C, 0x20, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x00, 0x4C, 0x65,
    0x76, 0x65, 0x6C, 0x00, 0x41, 0x72, 0x6D, 0x6F, 0x72, 0x3A, 0x00, 0x44,
    0x61, 0x6D, 0x61, 0x67, 0x65, 0x3A, 0x00, 0x52, 0x61, 0x6E, 0x67, 0x65,
    0x3A, 0x00, 0x53, 0x69, 0x67, 0x68, 0x74, 0x3A, 0x00, 0x53, 0x70, 0x65,
    0x65, 0x64, 0x3A, 0x00, 0x4D, 0x61, 0x67, 0x69, 0x63, 0x3A, 0x00, 0x4F,
    0x69, 0x6C, 0x20, 0x4C, 0x65, 0x66, 0x74, 0x3A, 0x00, 0x46, 0x6F, 0x6F,
    0x64, 0x20, 0x55, 0x73, 0x61, 0x67, 0x65, 0x20, 0x00, 0x47, 0x72, 0x6F,
    0x77, 0x6E, 0x3A, 0x00, 0x55, 0x73, 0x65, 0x64, 0x3A, 0x00, 0x54, 0x72,
    0x61, 0x69, 0x6E, 0x69, 0x6E, 0x67, 0x3A, 0x00, 0x55, 0x70, 0x67, 0x72,
    0x61, 0x64, 0x69, 0x6E, 0x67, 0x3A, 0x00, 0x42, 0x75, 0x69, 0x6C, 0x64,
    0x69, 0x6E, 0x67, 0x3A, 0x00, 0x52, 0x65, 0x73, 0x65, 0x61, 0x72, 0x63,
    0x68, 0x69, 0x6E, 0x67, 0x3A, 0x00, 0x47, 0x6F, 0x6C, 0x64, 0x20, 0x4C,
    0x65, 0x66, 0x74, 0x3A, 0x00, 0x50, 0x72, 0x6F, 0x64, 0x75, 0x63, 0x74,
    0x69, 0x6F, 0x6E, 0x20, 0x00, 0x47, 0x6F, 0x6C, 0x64, 0x3A, 0x00, 0x4C,
    0x75, 0x6D, 0x62, 0x65, 0x72, 0x3A, 0x00, 0x4F, 0x69, 0x6C, 0x3A, 0x00,
    0x55, 0x6E, 0x69, 0x74, 0x20, 0x50, 0x74, 0x72, 0x3A, 0x00, 0x43, 0x75,
    0x72, 0x72, 0x65, 0x6E, 0x74, 0x20, 0x4F, 0x72, 0x64, 0x65, 0x72, 0x3A,
    0x00, 0x4E, 0x65, 0x78, 0x74, 0x20, 0x4F, 0x72, 0x64, 0x65, 0x72, 0x3A,
    0x00, 0x25, 0x20, 0x43, 0x6F, 0x6D, 0x70, 0x6C, 0x65, 0x74, 0x65, 0x00,
    0x4E, 0x6F, 0x74, 0x20, 0x65, 0x6E, 0x6F, 0x75, 0x67, 0x68, 0x20, 0x6D,
    0x61, 0x6E, 0x61, 0x20, 0x74, 0x6F, 0x20, 0x63, 0x61, 0x73, 0x74, 0x20,
    0x73, 0x70, 0x65, 0x6C, 0x6C, 0x2E, 0x00, 0x4E, 0x6F, 0x77, 0x68, 0x65,
    0x72, 0x65, 0x20, 0x74, 0x6F, 0x20, 0x72, 0x65, 0x74, 0x75, 0x72, 0x6E,
    0x20, 0x74, 0x6F, 0x2E, 0x2E, 0x2E, 0x63, 0x61, 0x6E, 0x6E, 0x6F, 0x74,
    0x20, 0x72, 0x65, 0x74, 0x75, 0x72, 0x6E, 0x2E, 0x00, 0x43, 0x61, 0x6E,
    0x6E, 0x6F, 0x74, 0x20, 0x63, 0x61, 0x73, 0x74, 0x20, 0x6F, 0x6E, 0x20,
    0x62, 0x75, 0x69, 0x6C, 0x64, 0x69, 0x6E, 0x67, 0x73, 0x2E, 0x00, 0x4E,
    0x6F, 0x74, 0x20, 0x65, 0x6E, 0x6F, 0x75, 0x67, 0x68, 0x20, 0x66, 0x6F,
    0x6F, 0x64, 0x2E, 0x2E, 0x2E, 0x62, 0x75, 0x69, 0x6C, 0x64, 0x20, 0x6D,
    0x6F, 0x72, 0x65, 0x20, 0x66, 0x61, 0x72, 0x6D, 0x73, 0x2E, 0x00, 0x4E,
    0x6F, 0x74, 0x20, 0x65, 0x6E, 0x6F, 0x75, 0x67, 0x68, 0x20, 0x67, 0x6F,
    0x6C, 0x64, 0x2E, 0x2E, 0x2E, 0x6D, 0x69, 0x6E, 0x65, 0x20, 0x6D, 0x6F,
    0x72, 0x65, 0x20, 0x67, 0x6F, 0x6C, 0x64, 0x2E, 0x00, 0x4E, 0x6F, 0x74,
    0x20, 0x65, 0x6E, 0x6F, 0x75, 0x67, 0x68, 0x20, 0x6C, 0x75, 0x6D, 0x62,
    0x65, 0x72, 0x2E, 0x2E, 0x2E, 0x63, 0x68, 0x6F, 0x70, 0x20, 0x6D, 0x6F,
    0x72, 0x65, 0x20, 0x74, 0x72, 0x65, 0x65, 0x73, 0x2E, 0x00, 0x4E, 0x6F,
    0x74, 0x20, 0x65, 0x6E, 0x6F, 0x75, 0x67, 0x68, 0x20, 0x6F, 0x69, 0x6C,
    0x2E, 0x2E, 0x2E, 0x64, 0x72, 0x69, 0x6C, 0x6C, 0x20, 0x66, 0x6F, 0x72,
    0x20, 0x6F, 0x69, 0x6C, 0x2E, 0x00, 0x59, 0x6F, 0x75, 0x20, 0x63, 0x61,
    0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x62, 0x75, 0x69, 0x6C, 0x64, 0x20, 0x6F,
    0x66, 0x66, 0x20, 0x74, 0x68, 0x65, 0x20, 0x6D, 0x61, 0x70, 0x2E, 0x00,
    0x59, 0x6F, 0x75, 0x20, 0x63, 0x61, 0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x62,
    0x75, 0x69, 0x6C, 0x64, 0x20, 0x74, 0x68, 0x65, 0x72, 0x65, 0x2E, 0x00,
    0x59, 0x6F, 0x75, 0x20, 0x6D, 0x75, 0x73, 0x74, 0x20, 0x62, 0x75, 0x69,
    0x6C, 0x64, 0x20, 0x74, 0x68, 0x69, 0x73, 0x20, 0x62, 0x75, 0x69, 0x6C,
    0x64, 0x69, 0x6E, 0x67, 0x20, 0x6F, 0x6E, 0x20, 0x74, 0x68, 0x65, 0x20,
    0x63, 0x6F, 0x61, 0x73, 0x74, 0x2E, 0x00, 0x59, 0x6F, 0x75, 0x20, 0x6D,
    0x75, 0x73, 0x74, 0x20, 0x65, 0x78, 0x70, 0x6C, 0x6F, 0x72, 0x65, 0x20,
    0x74, 0x68, 0x65, 0x72, 0x65, 0x20, 0x66, 0x69, 0x72, 0x73, 0x74, 0x2E,
    0x00, 0x59, 0x6F, 0x75, 0x20, 0x6D, 0x75, 0x73, 0x74, 0x20, 0x62, 0x75,
    0x69, 0x6C, 0x64, 0x20, 0x61, 0x6E, 0x20, 0x6F, 0x69, 0x6C, 0x20, 0x70,
    0x6C, 0x61, 0x74, 0x66, 0x6F, 0x72, 0x6D, 0x20, 0x6F, 0x76, 0x65, 0x72,
    0x20, 0x61, 0x20, 0x70, 0x61, 0x74, 0x63, 0x68, 0x20, 0x6F, 0x66, 0x20,
    0x6F, 0x69, 0x6C, 0x2E, 0x00, 0x59, 0x6F, 0x75, 0x20, 0x63, 0x61, 0x6E,
    0x6E, 0x6F, 0x74, 0x20, 0x62, 0x75, 0x69, 0x6C, 0x64, 0x20, 0x61, 0x20,
    0x74, 0x6F, 0x77, 0x6E, 0x68, 0x61, 0x6C, 0x6C, 0x20, 0x74, 0x6F, 0x6F,
    0x20, 0x6E, 0x65, 0x61, 0x72, 0x20, 0x61, 0x20, 0x67, 0x6F, 0x6C, 0x64,
    0x6D, 0x69, 0x6E, 0x65, 0x2E, 0x00, 0x59, 0x6F, 0x75, 0x20, 0x63, 0x61,
    0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x62, 0x75, 0x69, 0x6C, 0x64, 0x20, 0x74,
    0x6F, 0x6F, 0x20, 0x6E, 0x65, 0x61, 0x72, 0x20, 0x61, 0x20, 0x70, 0x61,
    0x74, 0x63, 0x68, 0x20, 0x6F, 0x66, 0x20, 0x6F, 0x69, 0x6C, 0x2E, 0x00,
    0x44, 0x65, 0x61, 0x64, 0x00, 0x44, 0x79, 0x69, 0x6E, 0x67, 0x00, 0x47,
    0x75, 0x61, 0x72, 0x64, 0x00, 0x4D, 0x6F, 0x76, 0x65, 0x00, 0x50, 0x61,
    0x74, 0x72, 0x6F, 0x6C, 0x00, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x00,
    0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x54, 0x61, 0x72, 0x67, 0x00,
    0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x41, 0x72, 0x65, 0x61, 0x00,
    0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x57, 0x61, 0x6C, 0x6C, 0x00,
    0x44, 0x65, 0x66, 0x65, 0x6E, 0x64, 0x00, 0x53, 0x74, 0x61, 0x6E, 0x64,
    0x00, 0x53, 0x74, 0x61, 0x6E, 0x64, 0x20, 0x41, 0x74, 0x74, 0x61, 0x63,
    0x6B, 0x00, 0x41, 0x74, 0x74, 0x61, 0x63, 0x6B, 0x20, 0x50, 0x6C, 0x61,
    0x63, 0x65, 0x00, 0x42, 0x75, 0x69, 0x6C, 0x64, 0x00, 0x48, 0x61, 0x72,
    0x76, 0x65, 0x73, 0x74, 0x00, 0x52, 0x65, 0x74, 0x75, 0x72, 0x6E, 0x00,
    0x45, 0x6E, 0x74, 0x65, 0x72, 0x00, 0x4C, 0x65, 0x61, 0x76, 0x65, 0x00,
    0x52, 0x65, 0x70, 0x61, 0x69, 0x72, 0x00, 0x43, 0x72, 0x65, 0x61, 0x74,
    0x65, 0x00, 0x44, 0x6F, 0x63, 0x6B, 0x00, 0x4C, 0x61, 0x75, 0x6E, 0x63,
    0x68, 0x00, 0x57, 0x61, 0x69, 0x74, 0x00, 0x42, 0x6F, 0x61, 0x72, 0x64,
    0x00, 0x44, 0x69, 0x73, 0x65, 0x6D, 0x62, 0x61, 0x72, 0x6B, 0x00, 0x54,
    0x72, 0x61, 0x69, 0x6E, 0x00, 0x52, 0x65, 0x73, 0x75, 0x72, 0x72, 0x65,
    0x63, 0x74, 0x00, 0x57, 0x61, 0x69, 0x74, 0x00, 0x4D, 0x6F, 0x76, 0x65,
    0x55, 0x6E, 0x69, 0x74, 0x00, 0x50, 0x61, 0x74, 0x72, 0x6F, 0x6C, 0x55,
    0x6E, 0x69, 0x74, 0x00, 0x4E, 0x6F, 0x6E, 0x65, 0x00,
};

#endif // _WARTOOL_H
