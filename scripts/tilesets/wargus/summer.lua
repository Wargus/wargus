--       _________ __                 __
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      summer.ccl - Define the summer tileset.
--
--     (c) Copyright 2000-2022 by Lutz Sammer, Jimmy Salmon and Alyokhin
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

--=============================================================================
--	Define a tileset

--[[

Base tileset

solid tiles:
001x            light water
002x            dark water
003x            light coast
004x            dark coast
005x            light ground/grass
006x            dark ground/grass
007x            forest
008x            mountains
009x            human wall
00ax            orc walls
00bx            human walls
00cx            orc walls


boundry tiles:
09..            orc wall
08..            human wall
07..            forest and grass
06..            dark grass and grass
05..            coast and grass
04..            mount and coast
03..            dark coast and coast
02..            water and coast
01..            dark water and water

Extended tileset

solid tiles:
101x  solid cliff
102x  solid ramp

boundry tiles:
11..            cliff and dark coast lowground
12..            cliff and dark grass lowground
13..            cliff and water lowground
14..            coast highground and cliff
15..            grass highground and cliff
16..            coast highground and dark coast lowground
17..            coast highground and dark grass lowground
18..            coast highground and light water lowground
19..            grass highground and dark coast lowground
1A..            grass highground and dark grass lowground
1B..            grass highground and light water lowground
1C..            ramp and cliff
1D..            ramp and dark coast lowground
1E..            ramp and dark grass lowground
1F..            ramp and highgrounds
21..            ramp and lowgrounds


where .. is:

filled  clear
0x      Dx      upper left
1x      Cx      upper right
2x      Bx      upper half
3x      Ax      lower left
4x      9x      left half
7x      6x      lower right
8x      5x      upper left, lower right

--]]


--
--	(define-tileset ident class name image palette slots animations)
-- 
DefineTileset("name", "Forest",
  "image", "tilesets/summer/terrain/summer.png",
  -- Slots descriptions
  "slots", { 
            "special", {		-- Can't be in pud
                        "top-one-tree", 121, 
                        "mid-one-tree", 122, 
                        "bot-one-tree", 123,
                        "removed-tree", 126,
                        "top-one-rock", 161, 
                        "mid-one-rock", 162, 
                        "bot-one-rock", 163,
                        "removed-rock", 166 },
            "solid", { "unused", {}},								  -- 000
            "solid", { "light-water", "water",
                      { 328, 329, 329, 330}},				  -- 010
            "solid", { "dark-water", "water",
                      { 331, 332, 332, 333}},				  -- 020
            "solid", { "light-coast", "land", "no-building",
                      { 334, 335, 336,   0, 337, 338, 339, 340, 341, 342, 343, 344}},	                    -- 030
            "solid", { "dark-coast", "land", "no-building",
                      { 345, 346, 347,   0, 348, 349, 350, 351, 352, 353, 354, 355}},	                    -- 040
            "solid", { "light-grass", "land",
                      { 356, 357, 356,   0, 358, 359, 360, 361, 362, 363, 358, 359, 358, 359, 358, 359}},	-- 050
            "solid", { "dark-grass", "land",
                      { 364, 365, 364,   0, 366, 367, 368, 369, 370, 371, 366, 367, 366, 367, 366, 367}},	-- 060
            "solid", { "forest", "land", "forest", "unpassable",
                      { 125, 127, 128}},							-- 070
            "solid", { "rocks", "land", "rock", "unpassable",
                      { 165, 177, 178, 179}},					-- 080
            "solid", { "human-closed-wall", "land", "human", "wall", "unpassable",
                      {  16,   0,  52,   0,  88}},		-- 090
            "solid", { "orc-closed-wall", "land", "wall", "unpassable",
                      {  34,   0,  70,   0,  88}},		-- 0A0
            "solid", { "human-open-wall", "land", "human", "wall", "unpassable",
                      {  33,   0,  69,   0, 101}},		-- 0B0
            "solid", { "orc-open-wall", "land", "wall", "unpassable",
                      {  51,   0,  87,   0, 101}},		-- 0C0
            "solid", { "unused", {}},								  -- 0D0
            "solid", { "unused", {}},								  -- 0E0
            "solid", { "unused", {}},								  -- 0F0
            "mixed", { "dark-water", "light-water", "water",
                      { 300, 301},							-- 100
                      { 302, 303},							-- 110
                      { 304, 305, 306},					-- 120
                      { 307, 308},							-- 130
                      { 309, 310, 311},					-- 140
                      { 312, 313},							-- 150
                      { 314, 314},							-- 160
                      { 315, 316},							-- 170
                      { 317, 318},							-- 180
                      { 319, 320, 321},					-- 190
                      { 322, 322},							-- 1A0
                      { 323, 324, 325},					-- 1B0
                      { 326, 326},							-- 1C0
                      { 327, 327},							-- 1D0
                      {},									      -- 1E0
                      {}},								      -- 1F0
            "mixed", { "light-water", "light-coast", "coast",
                      { 206, 207},							-- 200
                      { 208, 209},							-- 210
                      { 210, 211, 212},					-- 220
                      { 213, 214},							-- 230
                      { 215, 216, 217},					-- 240
                      { 218, 218},							-- 250
                      { 219, 220},							-- 260
                      { 221, 222},							-- 270
                      { 223, 223},							-- 280
                      { 224, 225, 226},					-- 290
                      { 227, 228},							-- 2A0
                      { 229, 230, 231},					-- 2B0
                      { 232, 233},							-- 2C0
                      { 234, 235},							-- 2D0
                      {},									      -- 2E0
                      {}},								      -- 2F0
            "mixed", { "dark-coast", "light-coast", "land", "no-building",
                      { 180, 180},							-- 300
                      { 181, 182},							-- 310
                      { 183, 184, 185},					-- 320
                      { 186, 186,   0,   0,   0,   0,   0,   0, 187},			-- 330
                      { 188, 189, 190},					-- 340
                      { 191, 192},							-- 350
                      { 193, 193},							-- 360
                      { 194, 194},							-- 370
                      { 195, 196},							-- 380
                      { 197, 198, 199},					-- 390
                      { 200, 200},							-- 3A0
                      { 201, 202, 203},					-- 3B0
                      { 204, 204},							-- 3C0
                      { 205, 205},							-- 3D0
                      {},									      -- 3E0
                      {}},								      -- 3F0
            "mixed", { "rocks", "light-coast", "land", "rock", "unpassable",
                      { 150, 173},							-- 400
                      { 142, 167},							-- 410
                      { 164, 176},							-- 420
                      { 147, 171},							-- 430
                      { 149, 172,   0,   0,   0,   0,   0,   0,   0,   0,   0, 187},	-- 440
                      { 154, 175},							-- 450
                      { 151},								    -- 460
                      { 144, 169},							-- 470
                      { 153, 174},							-- 480
                      { 143, 168},							-- 490
                      { 152},								    -- 4A0
                      { 146, 170},							-- 4B0
                      { 148},								    -- 4C0
                      { 145},								    -- 4D0
                      {},									      -- 4E0
                      {}},								      -- 4F0
            "mixed", { "light-coast", "light-grass", "land", "no-building",
                      { 270, 271},							-- 500
                      { 272, 273},							-- 510
                      { 274, 275, 276},					-- 520
                      { 277, 278},							-- 530
                      { 279, 280, 281},					-- 540
                      { 282, 283},							-- 550
                      { 284, 284},							-- 560
                      { 285, 286},							-- 570
                      { 287, 288},							-- 580
                      { 289, 290, 291},					-- 590
                      { 292, 292},							-- 5A0
                      { 293, 294, 295},					-- 5B0
                      { 296, 297},							-- 5C0
                      { 298, 299},							-- 5D0
                      {},									      -- 5E0
                      {}},								      -- 5F0
            "mixed", { "dark-grass", "light-grass", "land",
                      { 238, 239},							-- 600
                      { 240, 241},							-- 610
                      { 242, 243, 244},					-- 620
                      { 245, 246},							-- 630
                      { 247, 248, 249},					-- 640
                      { 250, 251},							-- 650
                      { 252, 253},							-- 660
                      { 254, 255},							-- 670
                      { 256, 257},							-- 680
                      { 258, 259, 260},					-- 690
                      { 261, 262},							-- 6A0
                      { 263, 264, 265},					-- 6B0
                      { 266, 267},							-- 6C0
                      { 268, 269},							-- 6D0
                      {},									      -- 6E0
                      {}},								      -- 6F0
            "mixed", { "forest", "light-grass", "land", "forest", "unpassable",
                      { 129, 110},							-- 700
                      { 102, 130},							-- 710
                      { 124, 131},							-- 720
                      { 107, 132},							-- 730
                      { 133, 109},							-- 740
                      { 139, 138},							-- 750
                      { 111, 111},							-- 760
                      { 104, 136},							-- 770
                      { 140, 141},							-- 780
                      { 103, 135},							-- 790
                      { 112, 112},							-- 7A0
                      { 106, 134},							-- 7B0
                      { 137, 137},							-- 7C0
                      { 105, 105},							-- 7D0
                      {},									      -- 7E0
                      {}},								      -- 7F0
            "mixed", { "human-wall", "dark-grass", "land", "human", "wall", "unpassable",
                      {  17,   0,  53,   0,  89},						      -- 800
                      {  18,   0,  54,   0,  90},						      -- 810
                      {  19,   0,  55,   0,  91},						      -- 820
                      {  20,   0,  56,   0,  92},						      -- 830
                      {  21,  22,   0,  57,  58,   0,  93,  95},	-- 840
                      {  23,   0,  59,   0,  94},						      -- 850
                      {  24,   0,  60,   0,  93},						      -- 860
                      {  25,   0,  61,   0,  96},						      -- 870
                      {  26,   0,  62,   0,  97},						      -- 880
                      {  27,  28,   0,  63,  64,   0,  98,  99},	-- 890
                      {  29,   0,  65,   0,  98},						      -- 8A0
                      {  30,   0,  66,   0, 100},						      -- 8B0
                      {  31,   0,  67,   0,  95},						      -- 8C0
                      {  32,   0,  68,   0,  99},						      -- 8D0
                      {},									                        -- 8E0
                      {}},								                        -- 8F0
            "mixed", { "orc-wall", "dark-grass", "land", "wall", "unpassable",
                      {  35,   0,  71,   0,  89},						      -- 900
                      {  36,   0,  72,   0,  90},						      -- 910
                      {  37,   0,  73,   0,  91},						      -- 920
                      {  38,   0,  74,   0,  92},						      -- 930
                      {  39,  40,   0,  75,  76,   0,  93,  95},	-- 940
                      {  41,   0,  77,   0,  94},						      -- 950
                      {  42,   0,  78,   0,  93},						      -- 960
                      {  43,   0,  79,   0,  96},						      -- 970
                      {  44,   0,  80,   0,  97},						      -- 980
                      {  45,  46,   0,  81,  82,   0,  98,  99},	-- 990
                      {  47,   0,  83,   0,  98},						      -- 9A0
                      {  48,   0,  84,   0, 100},						      -- 9B0
                      {  49,   0,  85,   0,  95},						      -- 9C0
                      {  50,   0,  86,   0,  99}}						      -- 9D0
  })

local lightCoast = {
  ["shadows"]       = {{82, 86}},
  ["decorations"]   = {{69, 78}, {87, 94}},
  ["base"]          = {87, 88},
  ["all"]           = {"decorations", "shadows"},
  ["base-light"]    = {88},
  ["base-dark"]     = {87},
  ["light-shadows"] = {86},
  ["exceptions"]    = {{94, nil}}
}


local extendedTilesetSeed = {

  rampSrc_baseIdx                 = 0x0030, -- light-coast
  rampSrc                         = lightCoast,

  lightWeakGround                 = lightCoast,

  lowgroundWeakGround             = "dark-coast",
  lowgroundSolidGround            = "dark-grass",
  highgroundWeakGround            = "highground-coast",
  highgroundSolidGround           = "highground-grass",

  light_weakGround                = {87, 90},
  light_weakGround_light          =  88,
  light_weakGround_dark           =  87,
  dark_weakGround_dark            =  86,
  light_weakGround_shadows        = {83, 86},
  light_weakGround_light_shadows  =  86,
  dark_ground                     = {19, 23},
  water                           = {29, 56},

  dim                             = -1,
  dim_withGrndTypeConvert         = -67,
  lighten                         =  1
}

Load("scripts/tilesets/wargus/extended.lua")

ExtendTileset(extendedTilesetSeed)


BuildTilesetTables()

SetColorCycleAll(true)
ClearAllColorCyclingRange()
AddColorCyclingRange(38, 47) -- water
AddColorCyclingRange(48, 56) -- water coast boundry
AddColorCyclingRange(240, 244) -- icon

wargus.tileset = "summer"
Load("scripts/scripts.lua")

