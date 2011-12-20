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
--      wasteland.ccl - Define the wasteland tileset.
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
--	Define a tileset
--
--	(define-tileset ident class name image palette slots animations)
--
DefineTileset("name", "Wasteland",
  "image", "tilesets/wasteland/terrain/wasteland.png",
  -- Slots descriptions
  "slots", { "special", {
    "top-one-tree", 121, "mid-one-tree", 122, "bot-one-tree", 123,
    "removed-tree", 126,
    "growing-tree", { -1, -1, },
    "top-one-rock", 158, "mid-one-rock", 159, "bot-one-rock", 160,
    "removed-rock", 163, },
  "solid", { "unused",
    {}},								-- 000
  "solid", { "light-water", "water",
    { 324, 325, 325, 326,   0, 324, 325, 325}},				-- 010
  "solid", { "dark-water", "water",
    { 327, 328, 328, 329,   0, 327, 328, 328}},				-- 020
  "solid", { "light-dirt", "land", "no-building",
    { 330, 331, 332,   0, 333, 334, 335, 336, 337, 338, 334, 336}},	-- 030
  "solid", { "dark-dirt", "land", "no-building",
    { 339, 340, 341,   0, 342, 343, 344, 345, 342, 343, 340, 341}},	-- 040
  "solid", { "light-ground", "land",
    { 346, 347, 348,   0, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360}},-- 050
  "solid", { "dark-ground", "land",
    { 261, 262, 263,   0, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372}},-- 060
  "solid", { "forest", "land", "forest", "unpassable",
    { 125, 137, 138}},							-- 070
  "solid", { "rocks", "land", "rock", "unpassable",
    { 162, 174, 175, 176}},						-- 080
  "solid", { "human-closed-wall", "land", "human", "wall", "unpassable",
    {  16,   0,  52,   0,  88}},					-- 090
  "solid", { "orc-closed-wall", "land", "wall", "unpassable",
    {  34,   0,  70,   0,  88}},					-- 0A0
  "solid", { "human-open-wall", "land", "human", "wall", "unpassable",
    {  33,   0,  69,   0, 101}},					-- 0B0
  "solid", { "orc-open-wall", "land", "wall", "unpassable",
    {  51,   0,  87,   0, 101}},					-- 0C0
  "solid", { "unused",
    {}},								-- 0D0
  "solid", { "unused",
    {}},								-- 0E0
  "solid", { "unused",
    {}},								-- 0F0
  "mixed", { "dark-water", "light-water", "water",
    { 296, 296},							-- 100
    { 297, 297},							-- 110
    { 298, 299, 300},							-- 120
    { 301, 301},							-- 130
    { 302, 303, 304},							-- 140
    { 305, 306},							-- 150
    { 307, 308},							-- 160
    { 309, 309},							-- 170
    { 310, 311},							-- 180
    { 312, 313, 314},							-- 190
    { 315, 316},							-- 1A0
    { 317, 318, 319},							-- 1B0
    { 320, 321},							-- 1C0
    { 322, 323},							-- 1D0
    {},									-- 1E0
    {}},								-- 1F0
  "mixed", { "light-water", "light-dirt", "coast",
    { 201, 202},							-- 200
    { 203, 204},							-- 210
    { 205, 206, 207},							-- 220
    { 208, 209},							-- 230
    { 210, 211, 212},							-- 240
    { 213, 213},							-- 250
    { 214, 215},							-- 260
    { 216, 217},							-- 270
    { 218, 218},							-- 280
    { 219, 220, 221},							-- 290
    { 222, 223},							-- 2A0
    { 224, 225, 226},							-- 2B0
    { 227, 228},							-- 2C0
    { 229, 230},							-- 2D0
    {},									-- 2E0
    {}},								-- 2F0
  "mixed", { "dark-dirt", "light-dirt", "land", "no-building",
    { 177, 177},							-- 300
    { 178, 178},							-- 310
    { 179, 180, 181},							-- 320
    { 182, 182},							-- 330
    { 183, 184, 185},							-- 340
    { 186, 187},							-- 350
    { 188, 188},							-- 360
    { 189, 189},							-- 370
    { 190, 191},							-- 380
    { 192, 193, 194},							-- 390
    { 195, 195},							-- 3A0
    { 196, 197, 198},							-- 3B0
    { 199, 199},							-- 3C0
    { 200, 200},							-- 3D0
    {},									-- 3E0
    {}},								-- 3F0
  "mixed", { "rocks", "light-dirt", "land", "rock", "unpassable",
    { 147, 170},							-- 400
    { 139, 164},							-- 410
    { 161, 173},							-- 420
    { 144, 168},							-- 430
    { 146, 169},							-- 440
    { 151, 172},							-- 450
    { 148},								-- 460
    { 141, 166},							-- 470
    { 150, 171},							-- 480
    { 140, 165},							-- 490
    { 149},								-- 4A0
    { 143, 167},							-- 4B0
    { 145},								-- 4C0
    { 142},								-- 4D0
    {},									-- 4E0
    {}},								-- 4F0
  "mixed", { "light-dirt", "light-ground", "land", "no-building",
    { 264, 265},							-- 500
    { 266, 267},							-- 510
    { 268, 269, 270},							-- 520
    { 271, 272},							-- 530
    { 273, 274, 275},							-- 540
    { 276, 277},							-- 550
    { 278, 279},							-- 560
    { 280, 281},							-- 570
    { 282, 283},							-- 580
    { 284, 285, 286},							-- 590
    { 287, 288},							-- 5A0
    { 289, 290, 291},							-- 5B0
    { 292, 293},							-- 5C0
    { 294, 295},							-- 5D0
    {},									-- 5E0
    {}},								-- 5F0
  "mixed", { "dark-ground", "light-ground", "land",
    { 233, 234},							-- 600
    { 235, 236},							-- 610
    { 237, 238, 239},							-- 620
    { 240, 241},							-- 630
    { 242, 243, 244},							-- 640
    { 245, 246},							-- 650
    { 247, 247},							-- 660
    { 248, 249},							-- 670
    { 250, 251},							-- 680
    { 252, 253, 254},							-- 690
    { 255, 255},							-- 6A0
    { 256, 257, 258},							-- 6B0
    { 259, 259},							-- 6C0
    { 260, 260},							-- 6D0
    {},									-- 6E0
    {}},								-- 6F0
  "mixed", { "forest", "light-ground", "land", "forest", "unpassable",
    { 110, 134},							-- 700
    { 102, 127},							-- 710
    { 124, 136},							-- 720
    { 107, 131},							-- 730
    { 109, 133},							-- 740
    { 114, 114},							-- 750
    { 111, 111},							-- 760
    { 104, 129},							-- 770
    { 113, 113},							-- 780
    { 103, 128},							-- 790
    { 112, 135},							-- 7A0
    { 106, 130},							-- 7B0
    { 108, 132},							-- 7C0
    { 105, 105},							-- 7D0
    {},									-- 7E0
    {}},								-- 7F0
  "mixed", { "human-wall", "human-wall", "land", "human", "wall", "unpassable",
    {  17,   0,  53,   0,  89},						-- 800
    {  18,   0,  54,   0,  90},						-- 810
    {  19,   0,  55,   0,  91},						-- 820
    {  20,   0,  56,   0,  92},						-- 830
    {  21,  22,   0,  57,  58,   0,  93,  95},				-- 840
    {  23,   0,  59,   0,  94},						-- 850
    {  24,   0,  60,   0,  93},						-- 860
    {  25,   0,  61,   0,  96},						-- 870
    {  26,   0,  62,   0,  97},						-- 880
    {  27,  28,   0,  63,  64,   0,  98,  99},				-- 890
    {  29,   0,  65,   0,  98},						-- 8A0
    {  30,   0,  66,   0, 100},						-- 8B0
    {  31,   0,  67,   0,  95},						-- 8C0
    {  32,   0,  68,   0,  99},						-- 8D0
    {},									-- 8E0
    {}},								-- 8F0
  "mixed", { "orc-wall", "orc-wall", "land", "wall", "unpassable",
    {  35,   0,  71,   0,  89},						-- 900
    {  36,   0,  72,   0,  90},						-- 910
    {  37,   0,  73,   0,  91},						-- 920
    {  38,   0,  74,   0,  92},						-- 930
    {  39,  40,   0,  75,  76,   0,  93,  95},				-- 940
    {  41,   0,  77,   0,  94},						-- 950
    {  42,   0,  78,   0,  93},						-- 960
    {  43,   0,  79,   0,  96},						-- 970
    {  44,   0,  80,   0,  97},						-- 980
    {  45,  46,   0,  81,  82,   0,  98,  99},				-- 990
    {  47,   0,  83,   0,  98},						-- 9A0
    {  48,   0,  84,   0, 100},						-- 9B0
    {  49,   0,  85,   0,  95},						-- 9C0
    {  50,   0,  86,   0,  99}}						-- 9D0
  })

BuildTilesetTables()

wargus.tileset = "wasteland"
Load("scripts/scripts.lua")

