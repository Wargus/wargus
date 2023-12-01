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
--      winter.ccl - Define the winter tileset.
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
003x            light ice
004x            dark ice
005x            light snow
006x            dark snow
007x            forest
008x            mountains
009x            human wall
00ax            orc walls
00bx            human walls
00cx            orc walls


boundary tiles:
09..            orc wall
08..            human wall
07..            forest and snow
06..            dark snow and snow
05..            ice and snow
04..            mount and ice
03..            dark ice and ice
02..            water and ice
01..            dark water and water

Extended tileset

solid tiles:
101x  solid cliff
102x  solid ramp

boundary tiles:
11..            cliff and dark ice lowground
12..            cliff and dark snow lowground
13..            cliff and water lowground
14..            ice highground and cliff
15..            snow highground and cliff
16..            ice highground and dark ice lowground
17..            ice highground and dark snow lowground
18..            ice highground and light water lowground
19..            snow highground and dark ice lowground
1A..            snow highground and dark snow lowground
1B..            snow highground and light water lowground
1C..            ramp and cliff
1D..            ramp and dark ice lowground
1E..            ramp and dark snow lowground
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
DefineTileset("name", "Winter",
  "image", "tilesets/winter/terrain/winter.png",
  -- Slots descriptions
  "slots", {
            "special", {  -- Can't be in pud
                        "top-one-tree", 121, "mid-one-tree", 122, "bot-one-tree", 123,
                        "removed-tree", 126,
                        "top-one-rock", 156, "mid-one-rock", 157, "bot-one-rock", 158,
                        "removed-rock", 161, },
            "solid", { "unused", {}},                                                                     -- 000
            "solid", { "light-water", "water",
                      { 319, 320, 320, 321,   0, 322, 323, 324}},                                         -- 010
            "solid", { "dark-water", "water",
                      { 325, 326, 326, 327,   0, 328, 329, 330}},                                         -- 020
            "solid", { "light-ice", "land", "no-building",
                      { 331, 332, 333,   0, 334, 335, 336, 337, 338, 339, 334, 338}},                     -- 030
            "solid", { "dark-ice", "land", "no-building",
                      { 340, 341, 342,   0, 343, 344, 345, 346, 347, 348, 343, 347}},                     -- 040
            "solid", { "light-snow", "land",
                      { 349, 350, 351,   0, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363}}, -- 050
            "solid", { "dark-snow", "land",
                      { 364, 365, 366,   0, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378}}, -- 060
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
            "solid", { "unused", {}},                                                                     -- 0D0
            "solid", { "unused", {}},                                                                     -- 0E0
            "solid", { "unused", {}},                                                                     -- 0F0
            "mixed", { "dark-water", "light-water", "water",
                      { 291, 292},            -- 100
                      { 293, 294},            -- 110
                      { 295, 296, 297},       -- 120
                      { 298, 299},            -- 130
                      { 300, 301, 302},       -- 140
                      { 303, 304},            -- 150
                      { 305, 305},            -- 160
                      { 306, 307},            -- 170
                      { 308, 309},            -- 180
                      { 310, 311, 312},       -- 190
                      { 313, 313},            -- 1A0
                      { 314, 315, 316},       -- 1B0
                      { 317, 317},            -- 1C0
                      { 318, 318},            -- 1D0
                      {},                     -- 1E0
                      {}},                    -- 1F0
            "mixed", { "light-water", "light-ice", "coast",
                      { 199, 200},            -- 200
                      { 201, 202},            -- 210
                      { 203, 204, 205},       -- 220
                      { 206, 207},            -- 230
                      { 208, 209, 210},       -- 240
                      { 211, 211},            -- 250
                      { 212, 213},            -- 260
                      { 214, 215},            -- 270
                      { 216, 216},            -- 280
                      { 217, 218, 219},       -- 290
                      { 220, 221},            -- 2A0
                      { 222, 223, 224},       -- 2B0
                      { 225, 226},            -- 2C0
                      { 227, 228},            -- 2D0
                      {},                     -- 2E0
                      {}},                    -- 2F0
            "mixed", { "dark-ice", "light-ice", "land", "no-building",
                      { 175, 176},            -- 300
                      { 177, 178},            -- 310
                      { 179, 180, 179},       -- 320
                      { 181, 182},            -- 330
                      { 183, 184, 183},       -- 340
                      { 185, 186},            -- 350
                      { 187, 187},            -- 360
                      { 188, 189},            -- 370
                      { 190, 191},            -- 380
                      { 192, 193, 192},       -- 390
                      { 194, 194},            -- 3A0
                      { 195, 196, 195},       -- 3B0
                      { 197, 197},            -- 3C0
                      { 198, 198},            -- 3D0
                      {},                     -- 3E0
                      {}},                    -- 3F0
            "mixed", { "rocks", "light-ice", "land", "rock", "unpassable",
                      { 145, 168},            -- 400
                      { 137, 162},            -- 410
                      { 159, 171},            -- 420
                      { 142, 166},            -- 430
                      { 144, 167},            -- 440
                      { 149, 170},            -- 450
                      { 146},                 -- 460
                      { 139, 164},            -- 470
                      { 148, 169},            -- 480
                      { 138, 163},            -- 490
                      { 147},                 -- 4A0
                      { 141, 165},            -- 4B0
                      { 143},                 -- 4C0
                      { 140},                 -- 4D0
                      {},                     -- 4E0
                      {}},                    -- 4F0
            "mixed", { "light-ice", "light-snow", "land", "no-building",
                      { 259, 260},            -- 500
                      { 261, 262},            -- 510
                      { 263, 264, 265},       -- 520
                      { 266, 267},            -- 530
                      { 268, 269, 270},       -- 540
                      { 271, 272},            -- 550
                      { 273, 274},            -- 560
                      { 275, 276},            -- 570
                      { 277, 278},            -- 580
                      { 279, 280, 281},       -- 590
                      { 282, 283},            -- 5A0
                      { 284, 285, 286},       -- 5B0
                      { 287, 288},            -- 5C0
                      { 289, 290},            -- 5D0
                      {},                     -- 5E0
                      {}},                    -- 5F0
            "mixed", { "dark-snow", "light-snow", "land",
                      { 231, 232},            -- 600
                      { 233, 234},            -- 610
                      { 235, 236, 237},       -- 620
                      { 238, 239},            -- 630
                      { 240, 241, 242},       -- 640
                      { 243, 244},            -- 650
                      { 245, 245},            -- 660
                      { 246, 247},            -- 670
                      { 248, 249},            -- 680
                      { 250, 251, 252},       -- 690
                      { 253, 253},            -- 6A0
                      { 254, 255, 256},       -- 6B0
                      { 258, 258},            -- 6C0
                      { 257, 257},            -- 6D0
                      {},                     -- 6E0
                      {}},                    -- 6F0
            "mixed", { "forest", "light-snow", "land", "forest", "unpassable",
                      { 110, 133},            -- 700
                      { 102, 127},            -- 710
                      { 124, 134},            -- 720
                      { 107, 131},            -- 730
                      { 109, 132},            -- 740
                      { 114, 114},            -- 750
                      { 111, 111},            -- 760
                      { 104, 129},            -- 770
                      { 113, 113},            -- 780
                      { 103, 128},            -- 790
                      { 112, 112},            -- 7A0
                      { 106, 130},            -- 7B0
                      { 108, 108},            -- 7C0
                      { 105, 105},            -- 7D0
                      {},                     -- 7E0
                      {}},                    -- 7F0
            "mixed", { "human-wall", "dark-snow", "land", "human", "wall", "unpassable",
                      {  17,   0,  53,   0,  89},                 -- 800
                      {  18,   0,  54,   0,  90},                 -- 810
                      {  19,   0,  55,   0,  91},                 -- 820
                      {  20,   0,  56,   0,  92},                 -- 830
                      {  21,  22,   0,  57,  58,   0,  94,  99},  -- 840
                      {  23,   0,  59,   0,  93},                 -- 850
                      {  24,   0,  60,   0,  94},                 -- 860
                      {  25,   0,  61,   0,  95},                 -- 870
                      {  26,   0,  62,   0,  96},                 -- 880
                      {  27,  28,   0,  63,  64,   0,  97, 100},  -- 890
                      {  29,   0,  65,   0,  97},                 -- 8A0
                      {  30,   0,  66,   0,  98},                 -- 8B0
                      {  31,   0,  67,   0,  99},                 -- 8C0
                      {  32,   0,  68,   0, 100},                 -- 8D0
                      {},                                         -- 8E0
                      {}},                                        -- 8F0
            "mixed", { "orc-wall", "dark-snow", "land", "wall", "unpassable",
                      {  35,   0,  71,   0,  89},                 -- 900
                      {  36,   0,  72,   0,  90},                 -- 910
                      {  37,   0,  73,   0,  91},                 -- 920
                      {  38,   0,  74,   0,  92},                 -- 930
                      {  39,  40,   0,  75,  76,   0,  94,  99},  -- 940
                      {  41,   0,  77,   0,  93},                 -- 950
                      {  42,   0,  78,   0,  94},                 -- 960
                      {  43,   0,  79,   0,  95},                 -- 970
                      {  44,   0,  80,   0,  96},                 -- 980
                      {  45,  46,   0,  81,  82,   0,  97, 100},  -- 990
                      {  47,   0,  83,   0,  97},                 -- 9A0
                      {  48,   0,  84,   0,  98},                 -- 9B0
                      {  49,   0,  85,   0,  99},                 -- 9C0
                      {  50,   0,  86,   0, 100}},                -- 9D0
  })

local slotIdx = {
  -- solid tiles
  ["lightWater"]            = 0x0010,
  ["darkWater"]             = 0x0020,
  ["lightIce"]              = 0x0030,
  ["darkIce"]               = 0x0040,
  ["lightSnow"]             = 0x0050,
  ["darkSnow"]              = 0x0060,
  ["forest"]                = 0x0070,
  ["mountains"]             = 0x0080,
  -- boundary tiles
  ["darkWater-lightWater"]  = 0x0100,
  ["lightWater-lightIce"]   = 0x0200,
  ["darkIce-lightIce"]      = 0x0300,
  ["mountains-lightIce"]    = 0x0400,
  ["lightIce-lightSnow"]    = 0x0500,
  ["darkSnow-lightSnow"]    = 0x0600,
  ["forest-snow"]           = 0x0700
}

if IsHighgroundsEnabled() then
  local lightSnow = {
    ["shadows"]         = {{17, 24}},
    ["decorations"]     = {16, 27, 29, {59, 61}, {82, 91}},
    ["base"]            = {{25, 26}},
    ["all"]             = {"base", "decorations", "shadows"},
    ["base-light"]      = {26},
    ["base-dark"]       = {25},
    ["light-shadows"]   = {24},
    ["transition-dark"] = {24},
    ["exceptions"]      = {{16, 16}, {nil, 17}, {27, nil}, {29, 29}, {61, nil}}
  }

  local lightIce = {
    ["shadows"]             = {{33, 36}},
    ["decorations"]         = {{18, 25}, {31, 36}, 54, {63, 71}, 78, 79},
    ["base"]                = {64, {71, 79}},
    ["all"]                 = {"base", "shadows", "decorations"},
    ["exceptions"]          = {{54, nil}, {69, nil}, {nil, 70}, {79, nil}, {37, 64}, {73, 73}, {74, 74}, {75, 75}, {76, 76}},
  }

  local water = {
    ["base"]                   = {{30, 39}},
    ["cycling"]                = {{40, 47}},
    ["cycling-coast-boundary"] = {{48, 54}},
    ["all"]                    = {"base", "cycling", "cycling-coast-boundary"}
  }

  local getRampSrcSlot = function(slotType)
    if slotType == "for-edges" then 
      return 0x0500 -- light-ice and light-snow boundary
    else 
      return 0x0050 -- light-snow
    end
  end

  local getRampSrc = function()
    return lightSnow
  end

  local generators = {}

  generators.cliffs = {
    colors = {
      ["remove-toCleanRocks"]         = lightIce["base"],
      ["shadows-onRocks"]             = {},
      ["convertable-shadows-onRocks"] = { -- shadows which could be converted from light weak ground to dark solid ground. Possible values: {range} or color
                                          { ["from"] = {31, 37}, ["to"] = {18, 24} },
                                          { ["from"] = {65, 69}, ["to"] = {106, 110} }
                                        },
      ["exceptions"]                  = lightIce["exceptions"]
    },
    baseTilesFor = {
      ["weak-ground"] =  {
                          [0x00] = {0x0040, 0x0041},
                          [0x10] = {0x0040, 0x0041},
                          [0x20] = {0x0040},
                          [0x30] = {0x0040, 0x0041},
                          [0x40] = {0x0041},
                          [0x60] = {0x0042},
                          [0x70] = {0x0040, 0x0041},
                          [0x90] = {0x0041},
                          [0xA0] = {0x0042},
                          [0xB0] = {0x0040, 0x0041},
                          [0xC0] = {0x0041},
                          [0xD0] = {0x0042}
                        },
      ["solid-ground"] = {
                          [0x00] = {0x0060, 0x0061},
                          [0x10] = {0x0060, 0x0061},
                          [0x20] = {0x0060},
                          [0x30] = {0x0060, 0x0061},
                          [0x40] = {0x0060},
                          [0x60] = {0x0061},
                          [0x70] = {0x0060, 0x0061},
                          [0x90] = {0x0062},
                          [0xA0] = {0x0060},
                          [0xB0] = {0x0060, 0x0061},
                          [0xC0] = {0x0061},
                          [0xD0] = {0x0062}
                        },
      ["cliff"]         = nil,
      ["cliff-special"] = { -- tile index in the source image
                            ["singleRockUp"]  = 156,
                            ["singleRockMid"] = 157,
                            ["singleRockBot"] = 158,
                            ["removedRock"]   = 161
                          },
      ["cliff-edges-exceptions"] = {
                                    [0x0200] =  {
                                                  [0x20] = {1},
                                                  [0x40] = {2},
                                                  [0x90] = {1}
                                                },
                                    [0x0500] =  {
                                                  [0x20] = {2},
                                                  [0xA0] = {0}
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
    local returnValue = {}

    if groundType == "weak-ground" then
      returnValue = {self.utils.srcTilesLst(0x0200, (0xD0 - slot)), {"remove", self.utils.colorsFor(water)}}
    elseif groundType == "solid-ground" then
      returnValue = {self.utils.srcTilesLst(0x0500, (0xD0 - slot)), {"remove", self.utils.colorsFor(lightIce, "base", "shadows")}}
    end

    return returnValue
  end

  function generators:makeRampEdge()
    return  {"remove", self.utils.colorsFor(lightIce, "base", "shadows")},  self.utils.Lighten(lightSnow, "base", "shadows")
  end

  function generators:makeRampToHighGround(groundType, slot, isMask, edgeSlot) -- local function to make transition from ramp to HG tiles (if present)

    local cBottom = 1
    local currLayer = cBottom

    local layers = {{}} -- there is a single (bottom) layer
    
    if isMask == "edgeMask" then
      if groundType == "weak-ground" then

        layers[currLayer] = {self.utils.srcTilesLst(0x0200, edgeSlot), {"remove", self.utils.colorsFor(water)}}
        currLayer = currLayer + 1

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
      end

      layers[currLayer] = {{"slot", 0x0500 + edgeSlot}, {"remove", self.utils.colorsFor(lightIce, "base", "shadows")},
                                                        {"chroma-key", {"slot", 0x0600 + (0xD0 - slot)}, self.utils.colorsFor(lightSnow, "base")},
                                                         self.utils.Lighten(lightSnow, "base", "transition-dark")}
      return unpack(layers)

    else -- without edge
      if groundType == "weak-ground" then
        layers[cBottom] = {{"slot", 0x0500 + (0xD0 - slot)}, self.utils.Lighten(lightSnow, "base", "transition-dark")}
      elseif groundType == "solid-ground" then
        layers[cBottom] = {{"slot", 0x0600 + (0xD0 - slot)}, self.utils.Lighten(lightSnow, "base", "transition-dark")}
      end

      return unpack(layers)
    end
  end

  function generators:makeRampToLowGround(groundType, slot) -- local function to make transition from ramp to LG tiles (if present)
    if groundType == "weak-ground" then
      return {"layers", {"range", 0x40, 0x42},
                        {{"slot", 0x0500 + (0xD0 - slot)}, {"remove", self.utils.colorsFor(lightIce, "base")},
                                                            self.utils.Dim(lightIce, "shadows"),
                                                            self.utils.Lighten(lightSnow, "base", "transition-dark")}}
    else 
      return {"layers", {{"slot", 0x0600 + (0xD0 - slot)}, self.utils.Lighten(lightSnow,"base")},
                        {0x0200 + (0xD0 - slot), {"remove-all-except", self.utils.colorsFor(water)},
                                                 {"chroma-key", {"slot", 0x0600 + (0xD0 - slot)}, self.utils.colorsFor(water)},
                                                 {"remove", self.utils.colorsFor(lightSnow, "base-light", "transition-dark")}}}
    end
  end

  local extendedTilesetSeed = {

    lowgroundWeakGround   = "dark-ice",
    lowgroundSolidGround  = "dark-snow",
    highgroundWeakGround  = "highground-ice",
    highgroundSolidGround = "highground-snow",
    getRampSrcSlot        = getRampSrcSlot,
    getRampSrc            = getRampSrc,
    generators            = generators,
  }

  Load("scripts/tilesets/wargus/extended.lua")
  ExtendTileset(extendedTilesetSeed)
end

BuildTilesetTables()

SetColorCycleAll(true)
ClearAllColorCyclingRange()
AddColorCyclingRange(40, 47) -- water
AddColorCyclingRange(48, 54) -- water coast boundary
AddColorCyclingRange(205, 207) -- building
AddColorCyclingRange(240, 244) -- icon

wargus.tileset = "winter"
Load("scripts/scripts.lua")
