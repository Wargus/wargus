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
--      (c) Copyright 2000-2023 by Lutz Sammer, Jimmy Salmon and Alyokhin
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
003x            light dirt
004x            dark dirt
005x            light ground
006x            dark ground
007x            forest
008x            mountains
009x            human wall
00ax            orc walls
00bx            human walls
00cx            orc walls


boundary tiles:
09..            orc wall
08..            human wall
07..            forest and ground
06..            dark ground and ground
05..            dirt and ground
04..            mount and dirt
03..            dark dirt and dirt
02..            water and dirt
01..            dark water and water

Extended tileset

solid tiles:
101x  solid cliff
102x  solid ramp

boundary tiles:
11..            cliff and dark dirt lowground
12..            cliff and dark ground lowground
13..            cliff and water lowground
14..            dirt highground and cliff
15..            ground highground and cliff
16..            dirt highground and dark dirt lowground
17..            dirt highground and dark ground lowground
18..            dirt highground and light water lowground
19..            ground highground and dark dirt lowground
1A..            ground highground and dark ground lowground
1B..            ground highground and light water lowground
1C..            ramp and cliff
1D..            ramp and dark dirt lowground
1E..            ramp and dark ground lowground
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
--  (define-tileset ident class name image palette slots animations)
--
DefineTileset("name", "Wasteland",
  "image", "tilesets/wasteland/terrain/wasteland.png",
  -- Slots descriptions
  "slots", {  
            "special", {
                        "top-one-tree", 121, "mid-one-tree", 122, "bot-one-tree", 123,
                        "removed-tree", 126,
                        "top-one-rock", 158, "mid-one-rock", 159, "bot-one-rock", 160,
                        "removed-rock", 163, },
            "solid", { "unused", {}},                                                                     -- 000
            "solid", { "light-water", "water",
                      { 324, 325, 325, 326,   0, 324, 325, 325}},                                         -- 010
            "solid", { "dark-water", "water",
                      { 327, 328, 328, 329,   0, 327, 328, 328}},                                         -- 020
            "solid", { "light-dirt", "land", "no-building",
                      { 330, 331, 332,   0, 333, 334, 335, 336, 337, 338, 334, 336}},                     -- 030
            "solid", { "dark-dirt", "land", "no-building",
                      { 339, 340, 341,   0, 342, 343, 344, 345, 342, 343, 340, 341}},                     -- 040
            "solid", { "light-ground", "land",
                      { 346, 347, 348,   0, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360}}, -- 050
            "solid", { "dark-ground", "land",
                      { 261, 262, 263,   0, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372}}, -- 060
            "solid", { "forest", "land", "forest", "unpassable",
                      { 125, 137, 138}},                                                                  -- 070
            "solid", { "rocks", "land", "rock", "unpassable",
                      { 162, 174, 175, 176}},                                                             -- 080
            "solid", { "human-closed-wall", "land", "human", "wall", "unpassable",
                      {  16,   0,  52,   0,  88}},                                                        -- 090
            "solid", { "orc-closed-wall", "land", "wall", "unpassable",
                      {  34,   0,  70,   0,  88}},                                                        -- 0A0
            "solid", { "human-open-wall", "land", "human", "wall", "unpassable",
                      {  33,   0,  69,   0, 101}},                                                        -- 0B0
            "solid", { "orc-open-wall", "land", "wall", "unpassable",
                      {  51,   0,  87,   0, 101}},                                                        -- 0C0
            "solid", { "unused",
              {}},                                                                                        -- 0D0
            "solid", { "unused",
              {}},                                                                                        -- 0E0
            "solid", { "unused",
              {}},                                                                                        -- 0F0
            "mixed", { "dark-water", "light-water", "water",
                      { 296, 296},              -- 100
                      { 297, 297},              -- 110
                      { 298, 299, 300},         -- 120
                      { 301, 301},              -- 130
                      { 302, 303, 304},         -- 140
                      { 305, 306},              -- 150
                      { 307, 308},              -- 160
                      { 309, 309},              -- 170
                      { 310, 311},              -- 180
                      { 312, 313, 314},         -- 190
                      { 315, 316},              -- 1A0
                      { 317, 318, 319},         -- 1B0
                      { 320, 321},              -- 1C0
                      { 322, 323},              -- 1D0
                      {},                       -- 1E0
                      {}},                      -- 1F0
            "mixed", { "light-water", "light-dirt", "coast",
                      { 201, 202},              -- 200
                      { 203, 204},              -- 210
                      { 205, 206, 207},         -- 220
                      { 208, 209},              -- 230
                      { 210, 211, 212},         -- 240
                      { 213, 213},              -- 250
                      { 214, 215},              -- 260
                      { 216, 217},              -- 270
                      { 218, 218},              -- 280
                      { 219, 220, 221},         -- 290
                      { 222, 223},              -- 2A0
                      { 224, 225, 226},         -- 2B0
                      { 227, 228},              -- 2C0
                      { 229, 230},              -- 2D0
                      {},                       -- 2E0
                      {}},                      -- 2F0
            "mixed", { "dark-dirt", "light-dirt", "land", "no-building",
                      { 177, 177},              -- 300
                      { 178, 178},              -- 310
                      { 179, 180, 181},         -- 320
                      { 182, 182},              -- 330
                      { 183, 184, 185},         -- 340
                      { 186, 187},              -- 350
                      { 188, 188},              -- 360
                      { 189, 189},              -- 370
                      { 190, 191},              -- 380
                      { 192, 193, 194},         -- 390
                      { 195, 195},              -- 3A0
                      { 196, 197, 198},         -- 3B0
                      { 199, 199},              -- 3C0
                      { 200, 200},              -- 3D0
                      {},                       -- 3E0
                      {}},                      -- 3F0
            "mixed", { "rocks", "light-dirt", "land", "rock", "unpassable",
                      { 147, 170},              -- 400
                      { 139, 164},              -- 410
                      { 161, 173},              -- 420
                      { 144, 168},              -- 430
                      { 146, 169},              -- 440
                      { 151, 172},              -- 450
                      { 148},                   -- 460
                      { 141, 166},              -- 470
                      { 150, 171},              -- 480
                      { 140, 165},              -- 490
                      { 149},                   -- 4A0
                      { 143, 167},              -- 4B0
                      { 145},                   -- 4C0
                      { 142},                   -- 4D0
                      {},                       -- 4E0
                      {}},                      -- 4F0
            "mixed", { "light-dirt", "light-ground", "land", "no-building",
                      { 264, 265},              -- 500
                      { 266, 267},              -- 510
                      { 268, 269, 270},         -- 520
                      { 271, 272},              -- 530
                      { 273, 274, 275},         -- 540
                      { 276, 277},              -- 550
                      { 278, 279},              -- 560
                      { 280, 281},              -- 570
                      { 282, 283},              -- 580
                      { 284, 285, 286},         -- 590
                      { 287, 288},              -- 5A0
                      { 289, 290, 291},         -- 5B0
                      { 292, 293},              -- 5C0
                      { 294, 295},              -- 5D0
                      {},                       -- 5E0
                      {}},                      -- 5F0
            "mixed", { "dark-ground", "light-ground", "land",
                      { 233, 234},              -- 600
                      { 235, 236},              -- 610
                      { 237, 238, 239},         -- 620
                      { 240, 241},              -- 630
                      { 242, 243, 244},         -- 640
                      { 245, 246},              -- 650
                      { 247, 247},              -- 660
                      { 248, 249},              -- 670
                      { 250, 251},              -- 680
                      { 252, 253, 254},         -- 690
                      { 255, 255},              -- 6A0
                      { 256, 257, 258},         -- 6B0
                      { 259, 259},              -- 6C0
                      { 260, 260},              -- 6D0
                      {},                       -- 6E0
                      {}},                      -- 6F0
            "mixed", { "forest", "light-ground", "land", "forest", "unpassable",
                      { 110, 134},              -- 700
                      { 102, 127},              -- 710
                      { 124, 136},              -- 720
                      { 107, 131},              -- 730
                      { 109, 133},              -- 740
                      { 114, 114},              -- 750
                      { 111, 111},              -- 760
                      { 104, 129},              -- 770
                      { 113, 113},              -- 780
                      { 103, 128},              -- 790
                      { 112, 135},              -- 7A0
                      { 106, 130},              -- 7B0
                      { 108, 132},              -- 7C0
                      { 105, 105},              -- 7D0
                      {},                       -- 7E0
                      {}},                      -- 7F0
            "mixed", { "human-wall", "human-wall", "land", "human", "wall", "unpassable",
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
            "mixed", { "orc-wall", "orc-wall", "land", "wall", "unpassable",
                      {  35,   0,  71,   0,  89},                 -- 900
                      {  36,   0,  72,   0,  90},                 -- 910
                      {  37,   0,  73,   0,  91},                 -- 920
                      {  38,   0,  74,   0,  92},                 -- 930
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
  ["lightDirt"]               = 0x0030,
  ["darkDirt"]                = 0x0040,
  ["lightGround"]             = 0x0050,
  ["darkGround"]              = 0x0060,
  ["forest"]                  = 0x0070,
  ["mountains"]               = 0x0080,
  -- boundary tiles
  ["darkWater-lightWater"]    = 0x0100,
  ["lightWater-lightDirt"]    = 0x0200,
  ["darkDirt-lightDirt"]      = 0x0300,
  ["mountains-lightDirt"]     = 0x0400,
  ["lightDirt-lightGround"]   = 0x0500,
  ["darkGround-lightGround"]  = 0x0600,
  ["forest-lightGround"]      = 0x0700
}

local lightGround = {
  ["shadows"]         = {{17, 21}},
  ["decorations"]     = {{52, 63}, {73, 78}},
  ["base"]            = {{22, 27}},
  ["all"]             = {"base", "decorations", "shadows"},
  ["exceptions"]      = {{nil, 17}, {27, nil}, {63, nil}}
}

local lightDirt = {
  ["shadows"]             = {80, {86, 88}},
  ["decorations"]         = {{74, 77}},
  ["base"]                = {{64, 70}, {81, 85}},
  ["all"]                 = {"base", "shadows", "decorations"},
  ["light-shadows"]       = {80},
  ["exceptions"]          = {{64, 64}, {65, 65}, {66, 66}, {67, 67}, {68, 68}, {69, 69}, {70, 70}, {85, nil}, {86, 80}, {87, 86}}
}

local water = {
  ["base"]                   = {{32, 37}},
  ["cycling"]                = {{38, 47}},
  ["cycling-coast-boundary"] = {{64, 70}},
  ["all"]                    = {"base", "cycling"}
}


local getRampSrcSlot = function(slotType)
  if slotType == "for-edges" then 
    return 0x0500 -- light-dirt and light-ground boundary
  else -- solid
    return 0x0050 -- light-ground
  end
end

local getRampSrc = function()
  return lightGround
end

local generators = {}

generators.cliffs = {
  colors = {
    ["remove-toCleanRocks"]         = lightDirt["base"],
    ["shadows-onRocks"]             = lightDirt["light-shadows"],
    ["convertable-shadows-onRocks"] = { -- shadows which could be converted from light weak ground to dark solid ground. Possible values: {range} or color
                                        { ["from"] = 80, ["to"] = 19 }
                                      },
    ["exceptions"]                  = lightDirt["exceptions"]
  },
  baseTilesFor = {
    ["weak-ground"] =  {
                        [0x00] = {0x0042, 0x0044, 0x0045, 0x0046, 0x0047},
                        [0x10] = {0x0042, 0x0044, 0x0045, 0x0046},
                        [0x20] = {0x0040, 0x0041, 0x0042},
                        [0x30] = {0x0044, 0x0045, 0x0046},
                        [0x40] = {0x0040, 0x0041, 0x0042},
                        [0x60] = {0x0040, 0x0041},
                        [0x70] = {0x0044, 0x0045, 0x0046},
                        [0x90] = {0x0040, 0x0041, 0x0042},
                        [0xA0] = {0x0040, 0x0041},
                        [0xB0] = {0x0044, 0x0045, 0x0046},
                        [0xC0] = {0x0040, 0x0041},
                        [0xD0] = {0x0041, 0x0042}
                       },
    ["solid-ground"] = {
                        [0x00] = {0x0060, 0x0061, 0x0062, 0x0067, 0x0069, 0x006A},
                        [0x10] = {0x0060, 0x0061, 0x0067, 0x0067, 0x0069, 0x006A},
                        [0x20] = {0x0060, 0x0061, 0x0062, 0x006A},
                        [0x30] = {0x0064, 0x0067, 0x0068, 0x0069, 0x006A, 0x006C},
                        [0x40] = {0x0060, 0x0061, 0x0062},
                        [0x60] = {0x0060, 0x0061},
                        [0x70] = {0x0064, 0x0067, 0x0068, 0x0069, 0x006A, 0x006C},
                        [0x90] = {0x0060, 0x0061, 0x0062},
                        [0xA0] = {0x0061, 0x0062},
                        [0xB0] = {0x0064, 0x0067, 0x0068, 0x0069, 0x006A, 0x006C},
                        [0xC0] = {0x0060, 0x0061, 0x0062},
                        [0xD0] = {0x0060, 0x0061, 0x0062}
                       },
    ["cliff"]         = nil,
    ["cliff-special"] = { -- tile index in the source image
                          ["singleRockUp"]  = 158,
                          ["singleRockMid"] = 159,
                          ["singleRockBot"] = 160,
                          ["removedRock"]   = 163
                        },
    ["cliff-edges-exceptions"] = {
                                  [0x0200] =  {
                                              },
                                  [0x0500] =  {
                                              }
                                 }
  },
  cleanRocks = nil -- local function to clean rocks (if present)
}

  -- functions --
generators.utils = { -- pointers to utility functions from extended.lua
  srcTilesLst = nil,
  colorsFor   = nil, -- parser for ground colors. Declared in the extended.lua
  Lighten     = nil,
  Dim         = nil
}

function generators:makeHighGroundEdge(groundType, slot) -- local function to make HG edge tiles (if present)
  local cBottom = 1
  local cTop    = 2
  local layers = {}

  -- solid-ground layer (also basement for weak ground)
  layers[cBottom] = {self.utils.srcTilesLst(0x0500, (0xD0 - slot)), {"remove", self.utils.colorsFor(lightDirt, "base", "shadows")}}

  if groundType == "weak-ground" then
    layers[cTop] = {self.utils.srcTilesLst(0x0200, (0xD0 - slot)), {"remove", self.utils.colorsFor(water)}}
  end

  return unpack(layers)
end

function generators:makeRampEdge()
  return  {"remove", self.utils.colorsFor(lightDirt, "base", "shadows")}, self.utils.Lighten(lightGround, "base")
end

function generators:makeRampToHighGround(groundType, slot, isMask, edgeSlot) -- local function to make transition from ramp to HG tiles (if present)

  local cBottom = 1
  local currLayer = cBottom

  local layers = {{}} -- there is a single (bottom) layer
  
  if isMask == "edgeMask" then
   
    layers[cBottom] = {self.utils.srcTilesLst(0x0500, edgeSlot), {"remove", self.utils.colorsFor(lightDirt, "base", "shadows")}}
    currLayer = currLayer + 1

    if groundType == "weak-ground" then
      layers[currLayer] = {self.utils.srcTilesLst(0x0200, edgeSlot), {"remove", self.utils.colorsFor(water)}}
      currLayer = currLayer + 1
    end

    local convertEdges = {
      [0x20 .. 0x00] = 0x10,
      [0x20 .. 0x10] = 0x00,
      [0x60 .. 0x20] = 0x30,
      [0x60 .. 0x30] = 0x20,
      [0xA0 .. 0x20] = 0x70,
      [0xA0 .. 0x70] = 0x20,
      [0xB0 .. 0x30] = 0x70,
      [0xB0 .. 0x70] = 0x30,
      [0xC0 .. 0x00] = 0xB0,
      [0xC0 .. 0x70] = 0x40,
      [0xD0 .. 0x30] = 0x90,
      [0xD0 .. 0x10] = 0xB0
    }
    edgeSlot = 0xD0 - convertEdges[slot .. edgeSlot]

    local colorsToRemove = {
      ["weak-ground"]  = {"base"},
      ["solid-ground"] = {"base", "shadows"}
    }

    layers[currLayer] = {{"slot", 0x0500 + edgeSlot}, {"remove", self.utils.colorsFor(lightDirt, unpack(colorsToRemove[groundType]))},
                                                      self.utils.Lighten(lightGround, "base","shadows")}
    return unpack(layers)

  else -- without edge
    if groundType == "weak-ground" then
      return {{"slot", 0x0500 + (0xD0 - slot)}, self.utils.Lighten(lightGround, "base")}
    else -- "solid-ground"
      return {"layers", {"slot", 0x0050},
                        {{"slot", 0x0500 + (0xD0 - slot)}, {"remove", self.utils.colorsFor(lightDirt, "base", "shadows")},
                                                            self.utils.Lighten(lightGround, "base")}}
    end
  end
end

function generators:makeRampToLowGround(groundType, slot) -- local function to make transition from ramp to LG tiles (if present)

  local lowground = {
    ["weak-ground"]   = {
                          ["src"]             = {"slot", 0x0040},
                          ["colorsToRemove"]  = {"base"}
                        },
    ["solid-ground"]  = {
                          ["src"]             = {"slot", 0x0060},
                          ["colorsToRemove"]  = {"base", "shadows"}
                        }
  }

  return {"layers", lowground[groundType].src,
                    {{"slot", 0x0500 + (0xD0 - slot)}, {"remove", self.utils.colorsFor(lightDirt, unpack(lowground[groundType].colorsToRemove))},
                                                        self.utils.Lighten(lightGround, "base", "shadows")}}

end

local extendedTilesetSeed = {

  lowgroundWeakGround             = "dark-dirt",
  lowgroundSolidGround            = "dark-ground",
  highgroundWeakGround            = "highground-dirt",
  highgroundSolidGround           = "highground-ground",

  getRampSrcSlot                  = getRampSrcSlot,
  getRampSrc                      = getRampSrc,

  generators                      = generators,

  dim                             = -1,
  lighten                         =  1
}

if IsHighgroundsEnabled() then
  Load("scripts/tilesets/wargus/extended.lua")
  ExtendTileset(extendedTilesetSeed)
end


BuildTilesetTables()

SetColorCycleAll(true)
ClearAllColorCyclingRange()
AddColorCyclingRange(38, 47) -- water
AddColorCyclingRange(64, 70) -- water coast boundary
AddColorCyclingRange(240, 244) -- icon

wargus.tileset = "wasteland"
Load("scripts/scripts.lua")

