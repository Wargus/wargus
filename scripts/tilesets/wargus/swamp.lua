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
--      swamp.ccl - Define the orc swamp tileset.
--
--      (c) Copyright 2000-2003 by Lutz Sammer and Jimmy Salmon
--
--      This program is free software-- you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation-- either version 2 of the License, or
--      (at your option) any later version.
--
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY-- without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--
--      You should have received a copy of the GNU General Public License
--      along with this program-- if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

--=============================================================================
--  Define a tileset

--[[

Base tileset

solid tiles:
001x            light water
002x            dark water
003x            light mud
004x            dark mud
005x            light dry mud
006x            dark dry mud
007x            forest
008x            mountains
009x            human wall
00ax            orc walls
00bx            human walls
00cx            orc walls


boundary tiles:
09..            orc wall
08..            human wall
07..            forest and dry mud
06..            dark dry mud and dry mud
05..            mud and dry mud
04..            mount and mud
03..            dark mud and mud
02..            water and mud
01..            dark water and water

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
--  (define-tileset ident class name image palette slots animations)
--
DefineTileset("name", "Swamp",
  "image", "tilesets/swamp/terrain/swamp.png",
  -- Slots descriptions
  "slots", { 
            "special", {    -- Can't be in pud
                        "top-one-tree", 121, "mid-one-tree", 122, "bot-one-tree", 123,
                        "removed-tree", 126,
                        "top-one-rock", 155, "mid-one-rock", 156, "bot-one-rock", 157,
                        "removed-rock", 161 },
            "solid", { "unused",
                      {}},                                                                                -- 000
            "solid", { "light-water", "water",
                      { 330, 331, 331, 332}},                                                             -- 010
            "solid", { "dark-water", "water",
                      { 333, 334, 334, 335}},                                                             -- 020
            "solid", { "light-mud", "land", "no-building",
                      { 336, 337, 338,   0, 339, 340, 341, 342, 343, 344}},                               -- 030
            "solid", { "dark-mud", "land", "no-building",
                      { 345, 346, 347,   0, 348, 349, 350, 351, 352, 353}},                               -- 040
            "solid", { "light-dry-mud", "land",
                      { 354, 355, 356,   0, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368}}, -- 050
            "solid", { "dark-dry-mud", "land",
                      { 369, 370, 371,   0, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383}}, -- 060
            "solid", { "forest", "land", "forest", "unpassable",
                      { 125, 135, 136}},                                                                  -- 070
            "solid", { "rocks", "land", "rock", "unpassable",
                      { 160, 172, 173, 174}},                                                             -- 080
            "solid", { "human-closed-wall", "land", "human", "wall", "unpassable",
                      {  16,   0,  52,   0,  88}},                                                        -- 090
            "solid", { "orc-closed-wall", "land", "wall", "unpassable",
                      {  34,   0,  70,   0,  88}},                                                        -- 0A0
            "solid", { "human-open-wall", "land", "human", "wall", "unpassable",
                      {  33,   0,  69,   0, 101}},                                                        -- 0B0
            "solid", { "orc-open-wall", "land", "wall", "unpassable",
                      {  51,   0,  87,   0, 101}},                                                        -- 0C0
            "solid", { "unused",
                      {}},                                                                                -- 0D0
            "solid", { "unused",
                      {}},                                                                                -- 0E0
            "solid", { "unused",
                      {}},                                                                                -- 0F0
            "mixed", { "dark-water", "light-water", "water",
                      { 302, 302},              -- 100
                      { 303, 303},              -- 110
                      { 304, 305, 306},         -- 120
                      { 307, 307},              -- 130
                      { 308, 309, 310},         -- 140
                      { 311, 312},              -- 150
                      { 313, 314},              -- 160
                      { 315, 315},              -- 170
                      { 316, 317},              -- 180
                      { 318, 319, 320},         -- 190
                      { 321, 322},              -- 1A0
                      { 323, 324, 325},         -- 1B0
                      { 326, 327},              -- 1C0
                      { 328, 329},              -- 1D0
                      {},                       -- 1E0
                      {}},                      -- 1F0
            "mixed", { "light-water", "light-mud", "coast",
                      { 207, 208},              -- 200
                      { 209, 210},              -- 210
                      { 211, 212, 213},         -- 220
                      { 214, 215},              -- 230
                      { 216, 217, 218},         -- 240
                      { 219, 219},              -- 250
                      { 220, 221},              -- 260
                      { 222, 223},              -- 270
                      { 224, 224},              -- 280
                      { 225, 226, 227},         -- 290
                      { 228, 229},              -- 2A0
                      { 230, 231, 232},         -- 2B0
                      { 233, 234},              -- 2C0
                      { 235, 236},              -- 2D0
                      {},                       -- 2E0
                      {}},                      -- 2F0
            "mixed", { "dark-mud", "light-mud", "land", "no-building",
                      { 175, 176},              -- 300
                      { 177, 178},              -- 310
                      { 179, 180, 181},         -- 320
                      { 182, 183},              -- 330
                      { 184, 185, 186},         -- 340
                      { 187, 188},              -- 350
                      { 189, 190},              -- 360
                      { 191, 192},              -- 370
                      { 193, 194},              -- 380
                      { 195, 196, 197},         -- 390
                      { 198, 199},              -- 3A0
                      { 200, 201, 202},         -- 3B0
                      { 203, 204},              -- 3C0
                      { 205, 206},              -- 3D0
                      {},                       -- 3E0
                      {}},                      -- 3F0
            "mixed", { "rocks", "light-mud", "land", "rock", "unpassable",
                      { 145, 168},              -- 400
                      { 137, 162},              -- 410
                      { 159, 171},              -- 420
                      { 142, 166},              -- 430
                      { 144, 167},              -- 440
                      { 149, 170},              -- 450
                      { 146},                   -- 460
                      { 139, 164},              -- 470
                      { 148, 169},              -- 480
                      { 138, 163},              -- 490
                      { 147},                   -- 4A0
                      { 141, 165},              -- 4B0
                      { 143},                   -- 4C0
                      { 140},                   -- 4D0
                      {},                       -- 4E0
                      {}},                      -- 4F0
            "mixed", { "light-mud", "light-dry-mud", "land", "no-building",
                      { 270, 271},              -- 500
                      { 272, 273},              -- 510
                      { 274, 275, 276},         -- 520
                      { 277, 278},              -- 530
                      { 279, 280, 281},         -- 540
                      { 282, 283},              -- 550
                      { 284, 285},              -- 560
                      { 286, 287},              -- 570
                      { 288, 289},              -- 580
                      { 290, 291, 292},         -- 590
                      { 293, 294},              -- 5A0
                      { 295, 296, 297},         -- 5B0
                      { 298, 299},              -- 5C0
                      { 300, 301},              -- 5D0
                      {},                       -- 5E0
                      {}},                      -- 5F0
            "mixed", { "dark-dry-mud", "light-dry-mud", "land",
                      { 239, 240},              -- 600
                      { 241, 242},              -- 610
                      { 243, 244, 245},         -- 620
                      { 246, 247},              -- 630
                      { 248, 249, 250},         -- 640
                      { 251, 252},              -- 650
                      { 253, 253},              -- 660
                      { 254, 255},              -- 670
                      { 256, 257},              -- 680
                      { 258, 259, 260},         -- 690
                      { 261, 261},              -- 6A0
                      { 262, 263, 264},         -- 6B0
                      { 265, 265} ,             -- 6C0
                      { 266, 266},              -- 6D0
                      {},                       -- 6E0
                      {}},                      -- 6F0
            "mixed", { "forest", "light-dry-mud", "land", "forest", "unpassable",
                      { 110, 133},              -- 700
                      { 102, 127},              -- 710
                      { 124, 134},              -- 720
                      { 107, 131},              -- 730
                      { 109, 132},              -- 740
                      { 114, 114},              -- 750
                      { 111, 111},              -- 760
                      { 104, 129},              -- 770
                      { 113, 113},              -- 780
                      { 103, 128},              -- 790
                      { 112, 112},              -- 7A0
                      { 106, 130},              -- 7B0
                      { 108, 108},              -- 7C0
                      { 105, 105},              -- 7D0
                      {},                       -- 7E0
                      {}},                      -- 7F0
            "mixed", { "human-wall", "dark-dry-mud", "land", "human", "wall", "unpassable",
                      {  17,   0,  53,   0,  89},                 -- 800
                      {  18,   0,  54,   0,  90},                 -- 810
                      {  19,   0,  55,   0,  91},                 -- 820
                      {  20,   0,  56,   0,  92},                 -- 830
                      {  21,  22,   0,  57,  58,   0,  93,  95},  -- 840
                      {  23,   0,  59,   0,  94},                 -- 850
                      {  24,   0,  60,   0,  93},                 -- 860
                      {  25,   0,  61,   0,  96},                 -- 870
                      {  26,   0,  62,   0,  97},                 -- 880
                      {  27,  28,   0,  63,  64,   0,  98,  99},  -- 890
                      {  29,   0,  65,   0,  98},                 -- 8A0
                      {  30,   0,  66,   0, 100},                 -- 8B0
                      {  31,   0,  67,   0,  95},                 -- 8C0
                      {  32,   0,  68,   0,  99},                 -- 8D0
                      {},                                         -- 8E0
                      {}},                                        -- 8F0
            "mixed", { "orc-wall", "dark-dry-mud", "land", "wall", "unpassable",
                      {  35,   0,  71,   0,  89},                 -- 900
                      {  36,   0,  73,   0,  90},                 -- 910
                      {  37,   0,  73,   0,  91},                 -- 920
                      {  38,   0,  77,   0,  92},                 -- 930
                      {  39,  40,   0,  75,  76,   0,  93,  95},  -- 940
                      {  41,   0,  77,   0,  94},                 -- 950
                      {  42,   0,  78,   0,  93},                 -- 960
                      {  43,   0,  79,   0,  96},                 -- 970
                      {  44,   0,  80,   0,  97},                 -- 980
                      {  45,  46,   0,  81,  82,   0,  98,  99},  -- 990
                      {  47,   0,  83,   0,  98},                 -- 9A0
                      {  48,   0,  84,   0, 100},                 -- 9B0
                      {  49,   0,  85,   0,  95},                 -- 9C0
                      {  50,   0,  86,   0,  99}}                 -- 9D0
  })

local slotIdx = {
  -- solid tiles
    ["lightWater"]              = 0x0010,
    ["darkWater"]               = 0x0020,
    ["lightMud"]                = 0x0030,
    ["darkMud"]                 = 0x0040,
    ["lightDryMud"]             = 0x0050,
    ["darkDryMud"]              = 0x0060,
    ["forest"]                  = 0x0070,
    ["mountains"]               = 0x0080,
  -- boundary tiles
    ["darkWater-lightWater"]    = 0x0100,
    ["lightWater-lightMud"]     = 0x0200,
    ["darkMud-lightMud"]        = 0x0300,
    ["mountains-lightMud"]      = 0x0400,
    ["lightMud-lightDryMud"]    = 0x0500,
    ["darkDryMud-lightDryMud"]  = 0x0600,
    ["forest-snow"]             = 0x0700
}

BuildTilesetTables()

SetColorCycleAll(true)
ClearAllColorCyclingRange()
AddColorCyclingRange(5, 9) -- water
AddColorCyclingRange(38, 47) -- water coast boundary
AddColorCyclingRange(88, 95) -- building
AddColorCyclingRange(240, 244) -- icon

wargus.tileset = "swamp"
Load("scripts/scripts.lua")

