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
--      extended.lua - Extended tileset generator's instructions.
--
--     (c) Copyright 2022 by Alyokhin
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
--
--	(define-tileset ident class name image palette slots animations)
-- 

--[[

Base tileset
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

boundry tiles

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

101x  solid cliff
102x  solid ramp

boundry tiles

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

--[[
    Usage:


    GenerateExtendedTileset(
    "image", path-to-image-with-tileset-graphic, -- optional for extended tileset
    "slots", {
              slot-type, {"terrain-name", ["terrain-name",] [list-of-flags-for-all-tiles-of-this-slot,]
                          {dst, src[, additional-flags-list]}
                          [, {dst, src[, additional-flags-list]}]
                          ...
                         }
                        ...
              }
            
      where:
      slot-type: 
        "solid" or "mixed"
        Each slot consist of 16 tiles which represent one of terrain type ("solid") 
        or mix of two different solid terrains ("mixed" f.e. gras-coast, water-coast etc.)
        Second "terrain-name" in the slot definition is for mixed type.

      list-of-flags-for-all-tiles-of-this-slot: 
        comma separated list of flags wihich are common for all tiles in this slot

      dst:
        single agrgument (number or table) at position 1.
        index of defined tile (or set of indexes). Each slot consist of 16 tiles only. 
        For extended tileset indexes must be greater than already defined.
        Each slot's indexes set starts from xxx0 and ended with xxxF (where discription of xxx see in PUD format explanation)
        
        'dst' can take one of the following forms:
        tile                    -- single tile index
        {tile[, tile,] ...}     -- set of tile indexes
        {"range", from, to}     -- range of indexes [from, to]
        {"slot", slot_num}      -- whole slot indexes f.e. {"slot", 0x1010} - put src continuously to slot 0x101[0..F] 
                                -- until there is a src (up to 16, if less then fill slot with 0 for absent srcs)

      src:
        single argument (number or table) at position 2.
        Describes where to get graphics for dst. It can be graphics from a tile defined in main tileset,
        or frame from image file defined by "image" field (see above), or it can be generated from
        several graphic frames by composing them as layers (with simple per-pixel manipulations)

        'src' in general looks like:
        { "layers",  { src_range [,{"do_something", parameter}...] }, -- layer 1
                     { src_range [,{"do_something", parameter}...] }, -- layer 2
                     ...
                     { src_range [,{"do_something", parameter}...] }  -- layer n
        }

        "layers" can be omitted if we have a single layer, then src takes this form:
        { src_range [,{"do_something", parameter}...] } 
        or even: 
        src_range                     -- then we just use images from src_range without any manipulations with them

        'src_range' can take one of the following forms:
        tile                                    -- tile index (within main tileset) to get graphic from
        {tile[, tile]...}}                      -- set of tiles indexes (within main tileset) to get graphics from
        {"img"|"img-base", image[, image]...}   -- set of numbers of frames from the extended (or base tileset) "image" file.
        {["img"|"img-base",] "range", from, to} -- if "img" then from frame to frame (for "image"),        
                                                -- otherwise indexes from tile to tile (within main tileset) to get graphics from
        {"slot", slot_num}                      -- f.e. {"slot", 0x0430} - to take graphics continuously from tiles with indexes of slot 0x0430

        'do_something' is a pixel modifier for src images. The form is:
        {"do_something", parameter}
        where 'do_something':
          "remove"
          usage:		{"remove", colors[, colors]..}
                  where 'colors':
                          color		    -- single color
                          {from, to}	-- range of colors

          "remove-all-except"
          usage:		{"remove-all-except", colors[, colors]..}
                  where 'colors':
                          color		    -- single color
                          {from, to}	-- range of colors

          "shift"
          usage		{"shift", inc, colors[, colors]..}
                  where 	'inc':
                        increment (positive or negative) to be implemented on the colors
                      'colors':
                        color		    -- single color
                        {from, to}	-- range of colors

          "flip"
          usage:		{"flip", direction}
                  where 'direction':
                        "vertical"
                        "horizontal"
                        "both"

          "chroma-key"
          usage:		{"chroma-key", src_range2, key_colors[, key_colors]..}
                  where 'src_range2': (set of images to compose with images from src_range. Are taken consecutively one for each from src_range)
                        {tile}                                  -- tile index (within main tileset) to get graphic from
                        {tile[, tile]...}}                      -- set of tiles indexes (within main tileset) to get graphics from
                        {"img"|"img-base", image[, image]...}   -- set of numbers of frames from the extended (or base tileset) "image" file.
                        {["img"|"img-base",] "range", from, to} -- if "img" then from frame to frame (for "image"),        
                                                                -- otherwise indexes from tile to tile (within main tileset) to get graphics from
                        {"slot", slot_num}                      -- f.e. {"slot", 0x0430} - to take graphics continuously from tiles with indexes of slot 0x0430
                    'key_colors': (chroma keys)
                        color		    -- single color
                        {from, to}	-- range of colors

      additional-flags-list:
        strings which started from position 3
        comma separated list of additional flags for this range of tiles
--]]

function ExtendTileset(seed)

  local rampSrc_baseIdx = seed.rampSrc_baseIdx
  local rampSrc_colors = seed.rampSrc_colors

  local lowgroundWeakGround = seed.lowgroundWeakGround
  local lowgroundSolidGround = seed.lowgroundSolidGround
  local highgroundWeakGround = seed.highgroundWeakGround
  local highgroundSolidGround = seed.highgroundSolidGround
  
  local lightWeakGround = seed.lightWeakGround

  local light_weakGround = seed.light_weakGround
  local light_weakGround_light = seed.light_weakGround_light
  local light_weakGround_dark = seed.light_weakGround_dark
  local dark_weakGround_dark = seed.dark_weakGround_dark
  local light_weakGround_shadows = seed.light_weakGround_shadows
  local light_weakGround_light_shadows = seed.light_weakGround_light_shadows
  local dark_ground = seed.dark_ground
  local water = seed.water

  local dim = seed.dim
  local dim_withGrndTypeConvert = seed.dim_withGrndTypeConvert
  local lighten = seed.lighten

  local function getColors(colorSet, ...)
    local args = {...}
    local returnValue = {}
    
    for i, range in ipairs(args) do
      if colorSet[range] ~= nil then
        for ii, inRangeValue in ipairs(colorSet[range]) do
          table.insert(returnValue, inRangeValue)
        end
      end
    end
    return unpack(returnValue)
  end

  local function checkForExceptionColor(range, exceptionPairs, direction)
    local idxFrom = 1
    local idxTo   = 2
  
    if type(range) == "table" then
      for color = range[idxFrom], range[idxTo] do
        local exception = checkForExceptionColor(color, exceptionPairs, direction)
        if exception ~= nil then return exception end
      end
      return nil
    end
  
    local idxFrom, idxTo
    if direction < 0 then
      idxFrom = 2
      idxTo   = 1
    else
      idxFrom = 1
      idxTo   = 2
    end
  
    for i, pair in ipairs(exceptionPairs) do
      if range == pair[idxFrom] then
        if pair[idxTo] ~= nil then
          return {pair[idxFrom], pair[idxTo]}
        else
          return {pair[idxFrom], pair[idxFrom]}
        end
      end
    end
    return nil
  end
  
  local function shiftBrightness_byStep(direction, exceptionPairs, ...)
    local args = {...}
    
    if direction == 0 then return nil end
    direction = direction / math.abs(direction)
  
    local colors = {}
    local result = {}
    for i, range in ipairs(args) do
  
      repeat 
        local done = false
        local idxFrom = 1
        local idxTo = 2
  
        local exception = checkForExceptionColor(range, exceptionPairs, direction)
        if exception ~= nil then
  
          local shiftDelta = exception[idxTo] - exception[idxFrom];
          if shiftDelta ~= 0 then
            table.insert(result, {"shift", shiftDelta, exception[idxFrom]})
          end
  
          if type(range == "table") then
            if range[idxFrom] < exception[idxFrom] then
              table.insert(colors, {range[idxFrom], exception[idxFrom] - 1})
            end
            range[idxFrom] = exception[idxFrom] + 1
            if (range[idxTo] < range[idxFrom] ) then 
              done = true 
            end
          else
            done = true
          end
  
        else
          table.insert(colors, range)
        end
  
      until (done or exception == nil)
  
    end
    table.insert(result, {"shift", direction, unpack(colors)})
    return unpack(result)
  end

  local function Lighten(colorSet, ...)
    local subSets = {...}
    shiftBrightness_byStep(lighten, colorSet["exceptions"], getColors(colorSet, unpack(subSets)))
  end

  local function Dim(colorSet, ...)
    local subSets = {...}
    shiftBrightness_byStep(lighten, colorSet["exceptions"], getColors(colorSet, unpack(subSets)))
  end

  local function removeWeakGroundAndDimShadows(dimValue)
    if dimValue == nil then 
      return {"remove", light_weakGround}, {"shift", dim, light_weakGround_shadows}
    else
      return {"remove", light_weakGround}, {"shift", dimValue, light_weakGround_shadows}
    end
  end

  GenerateExtendedTileset(
  --  "image", "",
    "slots",  {
                "solid", {"cliff", "land", "unpassable", "no-building", 
                          {{"slot", 0x1010}, {"slot", 0x0080}}},
                "solid", {"ramp", "land", "no-building",
                          {{"slot", 0x1020}, {{"slot", rampSrc_baseIdx}, shiftBrightness_byStep(lighten, light_weakGround, light_weakGround_shadows)}}}, --{"shift", lighten, light_weakGround, light_weakGround_shadows}]--}}},
                "mixed", {"cliff", lowgroundWeakGround, "land", "unpassable", "no-building",
                  -- [0x1100] upper left filled
                          {{"slot", 0x1100}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                        {{"slot", 0x0400}, removeWeakGroundAndDimShadows()}}},
                  -- [0x1110] upper right filled
                          {{"slot", 0x1110}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                        {{"slot", 0x0410}, removeWeakGroundAndDimShadows()}}},
                  -- [0x1120] upper half filled
                          {{"slot", 0x1120}, {"layers", {0x0045, 0x0049}, 
                                                        {{"slot", 0x0420}, removeWeakGroundAndDimShadows()}}},
                  -- [0x1123] lower left filled
                          {{"slot", 0x1130}, {"layers", {0x0044, 0x0046, 0x004A},
                                                        {{"slot", 0x0430}, removeWeakGroundAndDimShadows()}}},
                  -- [0x1140] left half filled
                          {{"slot", 0x1140}, {"layers", {0x0049, 0x004A}, 
                                                        {{0x0440, 0x0441}, removeWeakGroundAndDimShadows()}}}, -- last tile in the slot 0x0440 is broken
                  -- [0x1160] lower right clear
                          {{"slot", 0x1160}, {"layers", {0x0049, 0x004A}, 
                                                        {{"slot", 0x0460}, removeWeakGroundAndDimShadows()}}},
                  -- [0x1170] lower right filled
                          {{"slot", 0x1170}, {"layers", {0x0044, 0x0049, 0x004A},
                                                        {{"slot", 0x0470}, removeWeakGroundAndDimShadows()}}},
                  -- [0x1190] right half filled
                          {{"slot", 0x1190}, {"layers", {0x0045, 0x0049},
                                                        {{"slot", 0x0490}, removeWeakGroundAndDimShadows()}}},
                  -- [0x11A0] lower left clear
                          {{"slot", 0x11A0}, {"layers", {"range", 0x0044, 0x0045}, 
                                                        {{"slot", 0x04A0}, removeWeakGroundAndDimShadows()}}},
                  -- [0x11B0] bottom half filled
                          {{"slot", 0x11B0}, {"layers", {0x0044, 0x0045, 0x004A}, 
                                                        {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()}}},
                  -- [0x11C0] upper right clear
                          {{"slot", 0x11C0}, {"layers", {0x0040}, 
                                                        {{"slot", 0x04C0}, removeWeakGroundAndDimShadows()}}},
                  -- [0x11D0] upper left clear
                          {{"slot", 0x11D0}, {"layers", {0x0040}, 
                                                        {{"slot", 0x04D0}, removeWeakGroundAndDimShadows()}}}},

                "mixed", {"cliff", lowgroundSolidGround, "land", "unpassable", "no-building",
                  -- [0x1200] upper left filled
                          {{"slot", 0x1200}, {"layers", {0x0065, 0x0068, 0x0069},
                                                        {{"slot", 0x0400}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x1210] upper right filled
                          {{"slot", 0x1210}, {"layers", {0x0065, 0x0068, 0x0069},
                                                        {{"slot", 0x0410}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x1220] upper half filled
                          {{"slot", 0x1220}, {"layers", {0x0068, 0x0069}, 
                                                        {{"slot", 0x0420}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x1230] lower left filled
                          {{"slot", 0x1230}, {"layers", {0x0065, 0x0068, 0x0069},
                                                        {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x1240] left half filled
                          {{"slot", 0x1240}, {"layers", {0x0060}, 
                                                        {{0x0440, 0x0441}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}}, -- last tile in the slot 0x0440 is broken
                  -- [0x1260] lower right clear
                          {{"slot", 0x1260}, {"layers", {0x0060},
                                                        {{"slot", 0x0460}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x1270] lower right filled
                          {{"slot", 0x1270}, {"layers", {0x0065, 0x0068, 0x0069},
                                                        {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x1290] right half filled
                          {{"slot", 0x1290}, {"layers", {0x0060},
                                                        {{"slot", 0x0490}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x12A0] lower left clear
                          {{"slot", 0x12A0}, {"layers", {0x0061}, 
                                                        {{"slot", 0x04A0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x12B0] bottom half filled
                          {{"slot", 0x12B0}, {"layers", {0x0065, 0x0066, 0x0069}, 
                                                        {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x12C0] upper right clear
                          {{"slot", 0x12C0}, {"layers", {0x0060}, 
                                                        {{"slot", 0x04C0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}},
                  -- [0x12D0] upper left clear
                          {{"slot", 0x12D0}, {"layers", {0x0061}, 
                                                        {{"slot", 0x04D0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)}}}},

                "mixed", {highgroundWeakGround, "cliff", "land", "unpassable", "no-building",
                  -- [0x1400] upper left filled
                          {{"slot", 0x1400}, {"layers", {0x04D0, 0x0080, 0x0081, 0x0082, 0x0083},
                                                        {{"slot", 0x02D0}, {"remove", water}}}},
                  -- [0x1410] upper right filled
                          {{"slot", 0x1410}, {"layers", {0x04C0, 0x0080, 0x0081, 0x0082, 0x0083},
                                                        {{"slot", 0x02C0}, {"remove", water}}}},
                  -- [0x1420] upper half filled
                          {{"slot", 0x1420}, {"layers", {"slot", 0x04B0},
                                                        {{"slot", 0x02B0}, {"remove", water}}}},
                  -- [0x1430] lower left filled
                          {{"slot", 0x1430}, {"layers", {"slot", 0x04A0},
                                                        {{"slot", 0x02A0}, {"remove", water}}}},
                  -- [0x1440] left half filled
                          {{"slot", 0x1440}, {"layers", {"slot", 0x0490},
                                                        {{"slot", 0x0290}, {"remove", water}}}},
                  -- [0x1460] lower right clear
                          {{"slot", 0x1460}, {"layers", {"slot", 0x0470},
                                                        {{"slot", 0x0270}, {"remove", water}}}},
                  -- [0x1470] lower right filled
                          {{"slot", 0x1470}, {"layers", {"slot", 0x0460},
                                                        {{"slot", 0x0260}, {"remove", water}}}},
                  -- [0x1490] right half filled
                          {{"slot", 0x1490}, {"layers", {0x0440, 0x0441}, -- last tile in the slot 0x0440 is broken
                                                        {{"slot", 0x0240}, {"remove", water}}}},
                  -- [0x14A0] lower left clear
                          {{"slot", 0x14A0}, {"layers", {"slot", 0x0430},
                                                        {{"slot", 0x0230}, {"remove", water}}}},
                  -- [0x14B0] bottom half filled
                          {{"slot", 0x14B0}, {"layers", {"slot", 0x0420},
                                                        {{"slot", 0x0220}, {"remove", water}}}},
                  -- [0x14C0] upper right clear
                          {{"slot", 0x14C0}, {"layers", {"slot", 0x0410},
                                                        {{"slot", 0x0210}, {"remove", water}}}},
                  -- [0x14D0] upper left clear
                          {{"slot", 0x14D0}, {"layers", {"slot", 0x0400},
                                                        {{"slot", 0x0200}, {"remove", water}}}}},
                "mixed", {highgroundSolidGround, "cliff", "land", "unpassable", "no-building",
                  -- [0x1500] upper left filled
                          {{"slot", 0x1500}, {"layers", {0x04D0, 0x0080, 0x0081, 0x0082, 0x0083},
                                                        {{"slot", 0x02D0}, {"remove", water}},
                                                        {{"slot", 0x05D0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1510] upper right filled
                          {{"slot", 0x1510}, {"layers", {0x04C0, 0x0080, 0x0081, 0x0082, 0x0083},
                                                        {{"slot", 0x02C0}, {"remove", water}},
                                                        {{"slot", 0x05C0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1520] upper half filled
                          {{"slot", 0x1520}, {"layers", {"slot", 0x04B0},
                                                        {{"slot", 0x02B0}, {"remove", water}},
                                                        {{"slot", 0x05B0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1530] lower left filled
                          {{"slot", 0x1530}, {"layers", {"slot", 0x04A0},
                                                        {{"slot", 0x02A0}, {"remove", water}},
                                                        {{"slot", 0x05A0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1540] left half filled
                          {{"slot", 0x1540}, {"layers", {"slot", 0x0490},
                                                        {{"slot", 0x0290}, {"remove", water}},
                                                        {{"slot", 0x0590}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1560] lower right clear
                          {{"slot", 0x1560}, {"layers", {"slot", 0x0470},
                                                        {{"slot", 0x0270}, {"remove", water}},
                                                        {{"slot", 0x0570}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1570] lower right filled
                          {{"slot", 0x1570}, {"layers", {"slot", 0x0460},
                                                        {{"slot", 0x0260}, {"remove", water}},
                                                        {{"slot", 0x0560}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1590] right half filled
                          {{"slot", 0x1590}, {"layers", {0x0440, 0x0441}, -- last tile in the slot 0x0440 is broken
                                                        {{"slot", 0x0240}, {"remove", water}},
                                                        {{"slot", 0x0540}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x15A0] lower left clear
                          {{"slot", 0x15A0}, {"layers", {"slot", 0x0430},
                                                        {{"slot", 0x0230}, {"remove", water}},
                                                        {{"slot", 0x0530}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x15B0] bottom half filled
                          {{"slot", 0x15B0}, {"layers", {"slot", 0x0420},
                                                        {{"slot", 0x0220}, {"remove", water}},
                                                        {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x15C0] upper right clear
                          {{"slot", 0x15C0}, {"layers", {0x0410},
                                                        {{"slot", 0x0210}, {"remove", water}},
                                                        {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x15D0] upper left clear                         
                          {{"slot", 0x15D0}, {"layers", {0x0400},
                                                        {{"slot", 0x0200}, {"remove", water}},
                                                        {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}}},
                                                        
                "mixed", {highgroundWeakGround, lowgroundWeakGround, "land", "unpassable", "no-building",
                  -- [0x1600] upper left filled
                          {{"slot", 0x1600}, {"layers", {0x0046, 0x004A},
                                                        {{0x0440, 0x0441}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x02D0}, {"remove", water}}}},
                  -- [0x1610] upper right filled
                          {{"slot", 0x1610}, {"layers", {0x0044, 0x0049},
                                                        {{"slot", 0x0490}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x02C0}, {"remove", water}}}},
                  -- [0x1630] lower left filled
                          {{"range", 0x1630, 0x163B}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02A0}, {"remove", water}}}},
                          {0x163C, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x163D, 0x163F}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0460}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02A0}, {"remove", water}}}},
                  -- [0x1640] left half filled
                          {{"slot", 0x1640}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                        {{"img-base", 161, 163, 166}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x0290}, {"remove", water}}}},
                  -- [0x1670] lower right filled
                          {{"range", 0x1670, 0x167B}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0260}, {"remove", water}}}},
                          {0x167C, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x167D, 0x167F}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x04A0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0260}, {"remove", water}}}},
                  -- [0x1690] right half filled
                          {{"slot", 0x1690}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                        {{"img-base", 162, 163, 166}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x0240}, {"remove", water}}}},
                  -- [0x16B0] upper half clear
                            -- (with rock lower half filled)
                          {{"range", 0x16B0, 0x16B3}, {"layers", {"range", 0x0044, 0x004B}, 
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x16B4, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x16B5, 0x16B6}, {"layers", {0x0044}, 
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x16B7, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x16B8, 0x16B9}, {"layers", {0x0044}, 
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x16BA, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x16BB, 0x16BC} , {"layers", {0x0044}, 
                                                                  {{"slot", 0x04D0}, removeWeakGroundAndDimShadows()},
                                                                  {{"slot", 0x0220}, {"remove", water}}}},
                          {0x16BD, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x16BE, 0x16BF} , {"layers", {0x0044}, 
                                                                  {{"slot", 0x04C0}, removeWeakGroundAndDimShadows()},
                                                                  {{"slot", 0x0220}, {"remove", water}}}},
                  -- [0x16C0] upper right clear
                          {{"range", 0x16C0, 0x16C3}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0210}, {"remove", water}}}},
                          {0x16C4, {0x0000}}, -- separator
                            -- (with rock upper right clear) 
                          {{"range", 0x16C5, 0x16C6}, {"layers", {0x0046},
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0210}, {"remove", water}}}},
                          {0x16C7, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x16C8, 0x16C9}, {"layers", {0x0046},
                                                                {{"slot", 0x0210}, {"remove", water}}}},
                  -- [0x16D0] upper left clear
                          {{"range", 0x16D0, 0x16D3}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0200}, {"remove", water}}}},
                          {0x16D4, {0x0000}}, -- separator
                            -- (with rock upper left clear) 
                          {{"range", 0x16D5, 0x16D6}, {"layers", {0x0044},
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0200}, {"remove", water}}}},
                          {0x16D7, {0x0000}}, -- separator
                            -- (without rock) 
                          {{"range", 0x16D8, 0x16D9}, {"layers", {0x0044},
                                                                {{"slot", 0x0200}, {"remove", water}}}}},
                                                                
                "mixed", {highgroundWeakGround, lowgroundSolidGround, "land", "unpassable", "no-building",
                  -- [0x1700] upper left filled
                          {{"slot", 0x1700}, {"layers", {0x0068, 0x0069},
                                                        {{0x0440, 0x0441}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x02D0}, {"remove", water}}}},
                  -- [0x1710] upper right filled
                          {{"slot", 0x1710}, {"layers", {0x0068, 0x0069},
                                                        {{"slot", 0x0490}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x02C0}, {"remove", water}}}},
                  -- [0x1730] lower left filled
                          {{"range", 0x1730, 0x173B}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02A0}, {"remove", water}}}},
                          {0x173C, {0x0000}}, -- separator
                            -- (with rock lower right clear)                                   
                          {{"range", 0x173D, 0x173F}, {"layers", {0x0068, 0x0069},
                                                      {{"slot", 0x0460}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                      {{"slot", 0x02A0}, {"remove", water}}}},
                  -- [0x1740] left half filled
                          {{"slot", 0x1740}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                        {{"img-base", 161, 163, 166}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0290}, {"remove", water}}}},
                  -- [0x1770] lower right filled
                          {{"range", 0x1770, 0x177B}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0260}, {"remove", water}}}},
                          {0x177C, {0x0000}}, -- separator
                            -- (with rock lower left clear)                                   
                          {{"range", 0x177D, 0x177F}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x04A0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0260}, {"remove", water}}}},
                  -- [0x1790] right half filled
                          {{"slot", 0x1790}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                        {{"img-base", 162, 163, 166}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0240}, {"remove", water}}}},
                  -- [0x17B0] upper half clear
                            -- (with rock lower half filled)
                          {{"range", 0x17B0, 0x17B3}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x17B4, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x17B5, 0x17B6}, {"layers", {0x0065}, 
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x17B7, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x17B8, 0x17B9}, {"layers", {0x0065}, 
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x17BA, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x17BB, 0x17BC}, {"layers", {0x0065}, 
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                          {0x17BD, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x17BE, 0x17BF}, {"layers", {0x0065}, 
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}}}},
                  -- [0x17C0] upper right clear
                          {{"range", 0x17C0, 0x17C3}, {"layers", {0x0060},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0210}, {"remove", water}}}},
                          {0x17C4, {0x0000}}, -- separator
                            -- (with rock upper right clear) 
                          {{"range", 0x17C5, 0x17C6}, {"layers", {0x0060},
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0210}, {"remove", water}}}},
                          {0x17C7, {0x0000}}, -- separator
                            -- (without rock) 
                          {{"range", 0x17C8, 0x17C9}, {"layers", {0x0060},
                                                                {{"slot", 0x0210}, {"remove", water}}}},
                  -- [0x17D0] upper left clear
                          {{"range", 0x17D0, 0x17D3}, {"layers", {0x0061},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0200}, {"remove", water}}}},
                          {0x17D4, {0x0000}}, -- separator
                            -- (with rock upper left clear) 
                          {{"range", 0x17D5, 0x17D6}, {"layers", {0x0061},
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0200}, {"remove", water}}}},
                          {0x17D7, {0x0000}}, -- separator
                            -- (without rock) 
                          {{"range", 0x17D8, 0x17D9}, {"layers", {0x0061},
                                                                {{"slot", 0x0200}, {"remove", water}}}}},

                "mixed", {highgroundSolidGround, lowgroundWeakGround, "land", "unpassable", "no-building",
                  -- [0x1900] upper left filled
                          {{"slot", 0x1900}, {"layers", {0x0046, 0x004A},
                                                        {{0x0440, 0x0441}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x02D0}, {"remove", water}},
                                                        {{"slot", 0x05D0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1910] upper right filled
                          {{"slot", 0x1910}, {"layers", {0x0044, 0x0049},
                                                        {{"slot", 0x0490}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x02C0}, {"remove", water}},
                                                        {{"slot", 0x05C0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1930] lower left filled
                          {{"range", 0x1930, 0x193B}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02A0}, {"remove", water}},
                                                                {{"slot", 0x05A0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x193C, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x193D, 0x193F}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0460}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02A0}, {"remove", water}},
                                                                {{"slot", 0x05A0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1940] left half filled
                          {{"slot", 0x1940}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                        {{"img-base", 161, 163, 166}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x0290}, {"remove", water}},
                                                        {{"slot", 0x0590}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1970] lower right filled
                          {{"range", 0x1970, 0x197B}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0260}, {"remove", water}},
                                                                {{"slot", 0x0560}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x197C, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x197D, 0x197F}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x04A0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0260}, {"remove", water}},
                                                                {{"slot", 0x0560}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1990] right half filled
                          {{"slot", 0x1990}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                        {{"img-base", 162, 163, 166}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x0240}, {"remove", water}},
                                                        {{"slot", 0x0540}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x19B0] upper half clear
                            -- (with rock lower half filled)
                          {{"range", 0x19B0, 0x19B3}, {"layers", {"range", 0x0044, 0x004B}, 
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19B4, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x19B5, 0x19B6}, {"layers", {0x0044}, 
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19B7, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x19B8, 0x19B9}, {"layers", {0x0044}, 
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19BA, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x19BB, 0x19BC}, {"layers", {0x0044}, 
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19BD, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x19BE, 0x19BF}, {"layers", {0x0044}, 
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x19C0] upper right clear
                          {{"range", 0x19C0, 0x19C3}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0210}, {"remove", water}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19C4, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x19C5, 0x19C6}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0210}, {"remove", water}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19C7, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x19C8, 0x19C9}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0210}, {"remove", water}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x19D0] upper left clear
                          {{"range", 0x19D0, 0x19D3}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0200}, {"remove", water}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19D4, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x19D5, 0x19D6}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows()},
                                                                {{0x0201}, {"remove", water}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x19D7, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x19D8, 0x19D9}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0200}, {"remove", water}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}}},

                "mixed", {highgroundSolidGround, lowgroundSolidGround, "land", "unpassable", "no-building",
                  -- [0x1A00] upper left filled
                          {{"slot", 0x1A00}, {"layers", {0x0068, 0x0069},
                                                        {{0x0440, 0x0441}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x02D0}, {"remove", water}},
                                                        {{"slot", 0x05D0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1A10] upper right filled
                          {{"slot", 0x1A10}, {"layers", {0x0068, 0x0069},
                                                        {{"slot", 0x0490}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x02C0}, {"remove", water}},
                                                        {{"slot", 0x05C0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1A30] lower left filled
                          {{"range", 0x1A30, 0x1A3B}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02A0}, {"remove", water}},
                                                                {{"slot", 0x05A0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1A3C, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x1A3D, 0x1A3f}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0460}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02A0}, {"remove", water}},
                                                                {{"slot", 0x05A0}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1A40] left half filled
                          {{"slot", 0x1A40}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                        {{"img-base", 161, 163, 166}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0290}, {"remove", water}},
                                                        {{"slot", 0x0590}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1A70] lower right filled
                          {{"range", 0x1A70, 0x1A7B}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0260}, {"remove", water}},
                                                                {{"slot", 0x0560}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1A7C, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x1A7D, 0x1A7F}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x04A0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0260}, {"remove", water}},
                                                                {{"slot", 0x0560}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},                          
                  -- [0x1A90] right half filled
                          {{"slot", 0x1A90}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                        {{"img-base", 162, 163, 166}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0240}, {"remove", water}},
                                                        {{"slot", 0x0540}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1AB0] upper half clear
                            -- (with rock lower half filled)
                          {{"range", 0x1AB0, 0x1AB3}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1AB4, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x1AB5, 0x1AB6}, {"layers", {0x0065}, 
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1AB7, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x1AB8, 0x1AB9}, {"layers", {0x0065}, 
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1ABA, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1ABB, 0x1ABC}, {"layers", {0x0065}, 
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1ABD, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1ABE, 0x1ABF}, {"layers", {0x0065}, 
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0220}, {"remove", water}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1AC0] upper right clear
                          {{"range", 0x1AC0, 0x1AC3}, {"layers", {0x0060},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0210}, {"remove", water}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1AC4, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x1AC5, 0x1AC6}, {"layers", {0x0060},
                                                                {{"slot", 0x04C0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0210}, {"remove", water}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1AC7, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1AC8, 0x1AC9}, {"layers", {0x0060},
                                                                {{"slot", 0x0210}, {"remove", water}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                  -- [0x1AD0] upper left clear
                          {{"range", 0x1AD0, 0x1AD3}, {"layers", {0x0061},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0200}, {"remove", water}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1AD4, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1AD5, 0x1AD6}, {"layers", {0x0061},
                                                                {{"slot", 0x04D0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{0x0201}, {"remove", water}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}},
                          {0x1AD7, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1AD8, 0x1AD9}, {"layers", {0x0061},
                                                                {{"slot", 0x0200}, {"remove", water}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround, light_weakGround_light_shadows}}}}},

                "mixed", {"ramp", "cliff", "land", "unpassable", "no-building",
                  -- [0x1C00] upper left filled
                          {{"slot", 0x1C00}, {"layers", {0x04D0, 0x0080, 0x0081, 0x0082, 0x0083},
                                                        {{"slot", 0x02D0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C10] upper right filled
                          {{"slot", 0x1C10}, {"layers", {0x04C0, 0x0080, 0x0081, 0x0082, 0x0083},
                                                        {{"slot", 0x02C0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C20] upper half filled
                          {{"slot", 0x1C20}, {"layers", {"slot", 0x04B0},
                                                        {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C30] lower left filled
                          {{"slot", 0x1C30}, {"layers", {"slot", 0x04A0},
                                                        {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C40] left half filled
                          {{"slot", 0x1C40}, {"layers", {"slot", 0x0490},
                                                        {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C60] lower right clear
                          {{"slot", 0x1C60}, {"layers", {"slot", 0x0470},
                                                        {{"slot", 0x0270}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C70] lower right filled
                          {{"slot", 0x1C70}, {"layers", {"slot", 0x0460},
                                                        {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1C90] right half filled
                          {{"slot", 0x1C90}, {"layers", {0x0440, 0x0441}, -- last tile in the slot 0x0440 is broken
                                                        {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1CA0] lower left clear
                          {{"slot", 0x1CA0}, {"layers", {"slot", 0x0430},
                                                        {{"slot", 0x0230}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1CB0] bottom half filled
                          {{"slot", 0x1CB0}, {"layers", {"slot", 0x0420},
                                                        {{"slot", 0x0220}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1CC0] upper right clear
                          {{"slot", 0x1CC0}, {"layers", {"slot", 0x0410},
                                                        {{"slot", 0x0210}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1CD0] upper left clear
                          {{"slot", 0x1CD0}, {"layers", {"slot", 0x0400},
                                                        {{"slot", 0x0200}, {"remove", water}, {"shift", lighten, light_weakGround}}}}},

                "mixed", {"ramp", lowgroundWeakGround, "land", "unpassable", "no-building",
                  -- [0x1D00] upper left filled 
                            -- (with rock lower right clear)
                          {{"range", 0x1D00, 0x1D01}, {"layers", {0x0046},
                                                                {{"slot", 0x0460}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02D0}, {"remove", water}}}},
                          {0x1D02, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1D03, 0x1D09}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0410}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02D0}, {"remove", water}}}},
                          {0x1D0A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D0B, 0x1D0F}, {"layers", {0x0044, 0x0046, 0x0049, 0x004A},
                                                                {{"slot", 0x02D0}, {"remove", water}}}},
                  -- [0x1D10] upper right filled 
                            -- (with rock lower left clear)
                          {{"range", 0x1D10, 0x1D11}, {"layers", {0x0044},
                                                                {{"slot", 0x04A0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02C0}, {"remove", water}}}},
                          {0x1D12, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1D13, 0x1D19}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0400}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02C0}, {"remove", water}}}},
                          {0x1D1A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D1B, 0x1D1F}, {"layers", {0x0044, 0x0046, 0x0049, 0x004A},
                                                                {{"slot", 0x02C0}, {"remove", water}}}},
                  -- [0x1D20] upper half filled
                            -- (with rock upper half filled)
                          {{"range", 0x1D20, 0x1D22}, {"layers", {"range", 0x0044, 0x004B},
                                                                {{"slot", 0x0420}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D23, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {0x1D24, {"layers", {0x0044},
                                              {{"slot", 0x0400}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D25, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {0x1D26, {"layers", {0x0044},
                                              {{"slot", 0x0410}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D27, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x1D28, 0x1D29}, {"layers", {"range", 0x0044, 0x004B},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D2A, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x1D2B, 0x1D2C}, {"layers", {"range", 0x0044, 0x004B},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D2D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D2E, 0x1D2F}, {"layers", {"range", 0x0044, 0x004B},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1D30] lower left filled
                            -- (with rock lower left filled)
                          {{"range", 0x1D30, 0x1D34}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D35, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1D36, 0x1D39}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x0400}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D3A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D3B, 0x1D3F}, {"layers", {0x0046, 0x004A},
                                                                {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1D40] left half filled
                            -- (with rock left half filled)
                          {{"range", 0x1D40, 0x1D42}, {"layers", {0x0044, 0x0045, 0x0046}, 
                                                                {{0x0440, 0x0441}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D43, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1D44, {"layers", {0x0044}, 
                                              {{"img-base",163}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D45, {0x0000}}, -- separator
                            -- (with rock lower center filled)
                          {0x1D46, {"layers", {0x0045}, 
                                              {{"img-base",161}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D47, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x1D48, 0x1D49}, {"layers", {0x0044}, 
                                                                {0x04C0, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D4A, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x1D4B, 0x1D4C}, {"layers", {0x0044}, 
                                                                {0x0460, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D4D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D4E, 0x1D4F}, {"layers", {0x0044, 0x0045}, 
                                                                {{"img-base", 166}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1D60] lower right clear 
                            -- (with rock lower right clear)
                          {{"range", 0x1D60, 0x01D61}, {"layers", {0x0044},
                                                                  {0x0460, removeWeakGroundAndDimShadows()},
                                                                  {{"slot", 0x0270}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D62, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D63, 0x1D64}, {"layers", {0x0044},
                                                                {{"slot", 0x0270}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1D70] lower right filled
                            -- (with rock lower right filled)
                          {{"range", 0x1D70, 0x1D74}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D75, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1D76, 0x1D79}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0410}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D7A, {0x0000}}, -- separator
                          -- lower right filled (without rock)
                          {{"range", 0x1D7B, 0x1D7F}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1D90] right half filled
                            -- (with rock right half filled)
                          {{"range", 0x1D90, 0x1D92}, {"layers", {0x0044, 0x0045, 0x0046, 0x0049, 0x004A}, 
                                                                {{"slot", 0x0490}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D93, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1D94, {"layers", {0x0044}, 
                                              {{"img-base",163}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D95, {0x0005}}, -- separator
                            -- (with rock lower center filled)
                          {0x1D96, {"layers", {0x0044}, 
                                              {0x0471, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D97, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1D98, 0x1D99}, {"layers", {0x0044}, 
                                                                {0x04D0, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D9A, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x1D9B, 0x1D9C}, {"layers", {0x0044}, 
                                                                {0x04A0, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1D9D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D9E, 0x1D9F}, {"layers", {0x0044, 0x0045}, 
                                                                {{"img-base", 166}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1DA0] lower left clear
                            -- (with rock lower left clear)
                          {{"range", 0x1DA0, 0x1DA1}, {"layers", {0x0046},
                                                                {0x04A0, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0230}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1DA2, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1DA3, 0x1DA4}, {"layers", {0x0046},
                                                                {{"slot", 0x0230}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1DB0] upper half clear
                          {{"slot", 0x1DB0}, {"layers", {"range", 0x0044, 0x004B}, 
                                                        {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                        {{"slot", 0x0220}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1DC0] upper right clear
                          {{"range", 0x1DC0, 0x1DC3}, {"layers", {0x0046},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0210}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1DC4, {0x0000}}, -- separator
                            -- (without rocks)
                          {{"range", 0x1DC5, 0x1DC6}, {"layers", {0x004A},
                                                                {{"slot", 0x0210}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1DD0] upper left clear
                          {{"range", 0x1DD0, 0x1DD3}, {"layers", {0x0044, 0x0049},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                                                {{"slot", 0x0200}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1DD4, {0x0000}}, -- separator
                            -- (without rocks)
                          {{"range", 0x1DD5, 0x1DD6}, {"layers", {0x0044},
                                                                {{"slot", 0x0200}, {"remove", water}, {"shift", lighten, light_weakGround}}}}},

                "mixed", {"ramp", lowgroundSolidGround, "land", "unpassable", "no-building",
                  -- [0x1E00] upper left filled
                            -- (with rock lower right clear)
                          {{"range", 0x1E00, 0x1E01}, {"layers", {0x0068},
                                                                {{"slot", 0x0460}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02D0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E02, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1E03, 0x1E09}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0410}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02D0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E0A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E0B, 0x1E0F}, {"layers", {0x0065, 0x0068, 0x0069},
                                                                {{"slot", 0x02D0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1E10] upper right filled 
                            -- (with rock lower left clear)
                          {{"range", 0x1E10, 0x1E11}, {"layers", {0x0068},
                                                                {{"slot", 0x04A0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02C0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E12, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1E13, 0x1E19}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0400}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02C0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E1A, {0x0000}}, -- separator
                          -- upper right filled (without rock)
                          {{"range", 0x1E1B, 0x1E1F}, {"layers", {0x0065, 0x0068, 0x0069},
                                                                {{"slot", 0x02C0}, {"remove", water}, {"shift", lighten, light_weakGround}}}}, 
                  -- [0x1E20] upper half filled
                            -- (with rock upper half filled)
                          {{"range", 0x1E20, 0x1E22}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0420}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E23, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {0x1E24, {"layers", {0x0068},
                                              {{"slot", 0x0400}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                              {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E25, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {0x1E24, {"layers", {0x0068},
                                              {{"slot", 0x0410}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                              {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E27, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x1E28, 0x1E29}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E2A, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x1E2b, 0x1E2C}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E2D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E2E, 0x1E2F}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x02B0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1E30] lower left filled
                            -- (with rock lower left filled)
                          {{"range", 0x1E30, 0x1E34}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0430}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E35, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1E36, 0x1E39}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0400}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E3A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E3B, 0x1E3F}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x02A0}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1E40] left half filled
                            -- (with rock left half filled)
                          {{"range", 0x1E40, 0x1E42}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                                {{0x0440, 0x0441}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E43, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1E44, {"layers", {0x0065},
                                              {{"img-base", 163}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                              {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E45, {0x0000}}, -- separator
                            -- (with rock lower center filled)
                          {0x1E46, {"layers", {0x0068},
                                              {{"img-base", 161}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                              {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E47, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x1E48, 0x1E49}, {"layers", {0x0065},
                                                                {0x04C0, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E4A, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x1E4B, 0x1E4C}, {"layers", {0x0065}, 
                                                                {0x0460, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E4D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E4E, 0x1E4F}, {"layers", {0x0065}, 
                                                                {{"img-base", 166}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0290}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1E60] lower right clear
                            -- (with rock lower right clear)
                          {{"range", 0x1E60, 0x1E61}, {"layers", {0x0069},
                                                                {{0x0460}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0270}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E62, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E63, 0x1E64}, {"layers", {0x0069},
                                                                {{"slot", 0x0270}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1E70] lower right filled
                            -- (with rock lower right filled)
                          {{"range", 0x1E70, 0x1E74}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0470}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E75, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1E76, 0x1E79}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0410}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E7A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E7B, 0x1E7F}, {"layers", {0x0068, 0x0069},
                                                                {{"slot", 0x0260}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1E90] right half filled
                            -- (with rock right half filled)
                          {{"range", 0x1E90, 0x1E92}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                                {{"slot", 0x0490}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E93, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1E94, {"layers", {0x0065}, 
                                              {{"img-base",163}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                              {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E95, {0x0000}}, -- separator
                            -- (with rock lower center filled)
                          {0x1E96, {"layers", {0x0068}, 
                                              {0x0471, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                              {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E97, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1E98, 0x1E99}, {"layers", {0x0065}, 
                                                                {0x04D0, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E9A, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x1E9B, 0x1E9C}, {"layers", {0x0065}, 
                                                                {0x04A0, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1E9D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E9E, 0x1E9F}, {"layers", {0x0065, 0x0068}, 
                                                                {{"img-base", 166}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0240}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1EA0] lower left clear
                            -- (with rock lower left clear)
                          {{"range", 0x1EA0, 0x1EA1}, {"layers", {0x0068},
                                                        {{0x04A0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0230}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1EA2, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1EA3, 0x1EA4}, {"layers", {0x0068},
                                                        {{0x04A0, 0x0030}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0230}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1EB0] upper half clear
                          {{"slot", 0x1EB0}, {"layers", {0x0065, 0x0068, 0x0069}, 
                                                        {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                        {{"slot", 0x0220}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1EC0] upper right clear
                          {{"range", 0x1EC0, 0x1EC3}, {"layers", {0x0060},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0210}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1EC4, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1EC5, 0x1EC6}, {"layers", {0x0060},
                                                                {{"slot", 0x0210}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                  -- [0x1ED0] upper left clear
                          {{"range", 0x1ED0, 0x1ED3}, {"layers", {0x0061},
                                                                {{"slot", 0x04B0}, removeWeakGroundAndDimShadows(dim_withGrndTypeConvert)},
                                                                {{"slot", 0x0200}, {"remove", water}, {"shift", lighten, light_weakGround}}}},
                          {0x1ED4, {0x0000}},-- separator
                            -- (without rock)
                          {{"range", 0x1ED5, 0x1ED6}, {"layers", {0x0061},
                                                                {{"slot", 0x0200}, {"remove", water}, {"shift", lighten, light_weakGround}}}}},

                "mixed", {"ramp", "highgrounds", "land", "no-building",
                  -- [0x1F00] upper left filled
                            -- (transition to coast highground)
                          {{"range", 0x1F00, 0x1F01}, {{"slot", 0x03D0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F02, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F03, 0x1F04}, {"layers", {{"slot", 0x03D0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround}}}},
                  -- [0x1F10] upper right filled
                            -- (transition to coast highground)
                          {{"range", 0x1F10, 0x1F11}, {{"slot", 0x03C0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F12, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F13, 0x1F14}, {"layers", {{"slot", 0x03C0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround}}}},
                  -- [0x1F20] upper half filled
                            -- (transition to coast highground)
                          {{"range", 0x1F20, 0x1F22}, {{"slot", 0x03B0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F23, {0x0000}},-- separator
                            -- (transition to coast highground with rock upper left filled)
                          {0x1F24, {"layers", {"slot", 0x0400},
                                              {{"slot", 0x0200}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x03B0}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1F25, {0x0000}},-- separator
                            -- (transition to coast highground with rock upper right filled)
                          {0x1F26, {"layers", {"slot", 0x0410},
                                              {{"slot", 0x0210}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x03B0}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1F27, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F28, 0x1F2A}, {"layers", {{"slot", 0x03B0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround}}}},
                          {0x1F2B, {0x0000}},-- separator
                            -- (transition to grass highground with rock upper left filled)
                          {0x1F2C, {"layers", {"slot", 0x0400},
                                              {{"slot", 0x0200}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x03B0}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x0520}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                          {0x1F2D, {0x0000}},-- separator
                            -- (transition to grass highground with rock upper right filled)
                          {0x1F2E, {"layers", {"slot", 0x0410},
                                              {{"slot", 0x0210}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x03B0}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x0520}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                  -- [0x1F30] lower left filled
                            -- (transition to coast highground)
                          {{"range", 0x1F30, 0x1F31}, {{"slot", 0x03A0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F32, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F33, 0x1F34}, {"layers", {{"slot", 0x03A0}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0530}, {"remove", light_weakGround}}}},
                  -- [0x1F40] left half filled
                            -- (transition to coast highground)
                          {{"range", 0x1F40, 0x1F42}, {{"slot", 0x0390}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F43, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F44, 0x1F46}, {"layers", {{"slot", 0x0390}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0540}, {"remove", light_weakGround}}}},
                  -- [0x1F60] lower right clear
                            -- (transition to coast highground)
                          {0x1F60, {0x0370, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F61, {0x0000}},-- separator
                            -- (transition to coast highground with coast lowground upper half filled)
                          {0x1F62, {"layers", {0x0044},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0370}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1F63, {0x0000}},-- separator
                            -- (transition to coast highground with grass lowground upper half filled)
                          {0x1F64, {"layers", {0x0064},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0370}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1F65, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower left filled)
                          {0x1F66, {"layers", {"slot", 0x0430},
                                              {{"slot", 0x0230}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0370}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1F67, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F68, 0x1F69}, {"layers", {{"slot", 0x0370}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0560}, {"remove", light_weakGround}}}},
                          {0x1F6A, {0x0000}},-- separator
                            -- (transition to grass highground with coast lowground upper half filled)
                          {0x1F6B, {"layers", {0x0044},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0370}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x0560}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                          {0x1F6C, {0x0000}},-- separator
                            -- (transition to grass highground with grass lowground upper half filled)
                          {0x1F6D, {"layers", {0x0064},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0370}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x0560}, {"remove", light_weakGround}}},
                                    "unpassable"},
                          {0x1F6E, {0x0000}},-- separator
                            -- (transition to grass highground with rock lower left filled)
                          {0x1F6F, {"layers", {"slot", 0x0430},
                                              {{"slot", 0x0230}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0370}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x0560}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                  -- [0x1F70] lower right filed
                            -- (transition to coast highground)
                          {{"range", 0x1F70, 0x1F71}, {{"slot", 0x0360}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F72, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F73, 0x1F74}, {"layers", {{"slot", 0x0360}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0570}, {"remove", light_weakGround}}}},
                  -- [0x1F90] right half filled
                            -- (transition to coast highground)
                          {{"range", 0x1F90, 0x1F92}, {{"slot", 0x0340}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1F93, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1F94, 0x1F96}, {"layers", {{"slot", 0x0340}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x0590}, {"remove", light_weakGround}}}},
                  -- [0x1FA0] lower left clear
                            -- (transition to coast highground)
                          {0x1FA0, {0x0330, {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, -- last tile in the slot 0x0330 is broken
                          {0x1FA1, {0x0000}},-- separator
                            -- (transition to coast highground with coast lowground upper half filled)
                          {0x1FA2, {"layers", {0x0044},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {0x0330, 0x0331}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FA3, {0x0000}},-- separator
                            -- (transition to coast highground with grass lowground upper half filled)
                          {0x1FA4, {"layers", {0x0064},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {0x0330, 0x0331}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FA5, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower right filled)
                          {0x1FA6, {"layers", {"slot", 0x0470},
                                              {{"slot", 0x0270}, {"remove", water}, 
                                                                {"chroma-key", {0x0330, 0x0331}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FA7, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1FA8, 0x1FA9}, {"layers", {{0x0330, 0x0331}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x05A0}, {"remove", light_weakGround}}}},
                          {0x1FAA, {0x0000}},-- separator
                            -- (transition to grass highground with coast lowground upper half filled)
                          {0x1FAB, {"layers", {0x0044},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {0x0330, 0x0331}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05A0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                            -- (transition to grass highground with grass lowground upper half filled)
                          {0x1FAC, {"layers", {0x0064},
                                              {{"slot", 0x04B0}, removeWeakGroundAndDimShadows()},
                                              {{"slot", 0x0220}, {"remove", water}, 
                                                                {"chroma-key", {0x0330, 0x0331}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05A0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                          {0x1FAD, {0x0000}},-- separator
                            -- (transition to grass highground with rock lower right filled)
                          {0x1FAE, {"layers", {"slot", 0x0470},
                                              {{"slot", 0x0270}, {"remove", water}, 
                                                                {"chroma-key", {0x0330, 0x0331}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05A0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                  -- [0x1FB0] upper half clear
                            -- (transition to coast highground)
                          {{"range", 0x1FB0, 0x1FB2}, {{"slot", 0x0320}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1FB3, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower left filled)
                          {0x1FB4, {"layers", {"slot", 0x0430},
                                              {{"slot", 0x0230}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0320}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FB5, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower right filled)
                          {0x1FB6, {"layers", {"slot", 0x0470},
                                              {{"slot", 0x0270}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0320}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FB7, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1FB8, 0x1FBA}, {"layers", {{"slot", 0x0320}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x05B0}, {"remove", light_weakGround}}}},
                          {0x1FBB, {0x0000}},-- separator
                            -- (transition to grass highground with rock lower left filled)
                          {0x1FBC, {"layers", {"slot", 0x0430},
                                              {{"slot", 0x0230}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0320}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05B0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                          {0x1FBD, {0x0000}},-- separator
                            -- (transition to grass highground with rock lower right filled)
                          {0x1FBE, {"layers", {"slot", 0x0470},
                                              {{"slot", 0x0270}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0320}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05B0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                  -- [0x1FC0] upper right clear
                            -- (transition to coast highground)
                          {{"range", 0x1FC0,  0x1FC1}, {{"slot", 0x0310}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1FC2, {0x0000}},-- separator
                            -- (transition to coast highground with rock upper left filled)
                          {0x1FC3, {"layers", {"slot", 0x0400},
                                              {{"slot", 0x0200}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0310}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FC4, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower right filled)
                          {0x1FC5, {"layers", {"slot", 0x0470},
                                              {{"slot", 0x0270}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0310}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FC6, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1FC7, 0x1FC8}, {"layers", {{"slot", 0x0310}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x05C0}, {"remove", light_weakGround}}}},
                          {0x1FC9, {0x0000}},-- separator
                            -- (transition to coast grass with rock upper left filled)
                          {0x1FCA, {"layers", {"slot", 0x0400},
                                              {{"slot", 0x0200}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0310}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05C0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                          {0x1FCB, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower right filled)
                          {0x1FCC, {"layers", {"slot", 0x0470},
                                              {{"slot", 0x0270}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0310}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05C0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                  -- [0x1FD0] upper left clear
                            -- (transition to coast highground)
                          {{"range", 0x1FD0,  0x1FD1}, {{"slot", 0x0300}, {"shift", lighten, light_weakGround, dark_weakGround_dark}}},
                          {0x1FD2, {0x0000}},-- separator
                            -- (transition to coast highground with rock lower left filled)
                          {0x1FD3, {"layers", {"slot", 0x0430},
                                              {{"slot", 0x0230}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0300}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FD4, {0x0000}},-- separator
                            -- (transition to coast highground with rock upper right filled)
                          {0x1FD5, {"layers", {"slot", 0x0410},
                                              {{"slot", 0x0210}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0300}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}}}, 
                                    "unpassable"},
                          {0x1FD6, {0x0000}},-- separator
                            -- (transition to grass highground)
                          {{"range", 0x1FD7, 0x1FD8}, {"layers", {{"slot", 0x0300}, {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                                                {{"slot", 0x05D0}, {"remove", light_weakGround}}}},
                          {0x1FD9, {0x0000}},-- separator
                            -- (transition to coast grass with rock lower left filled)
                          {0x1FDA, {"layers", {"slot", 0x0430},
                                              {{"slot", 0x0230}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0300}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05D0}, {"remove", light_weakGround}}}, 
                                    "unpassable"},
                          {0x1FDB, {0x0000}},-- separator
                            -- (transition to coast highground with rock upper right filled)
                          {0x1FDC, {"layers", {"slot", 0x0410},
                                              {{"slot", 0x0210}, {"remove", water}, 
                                                                {"chroma-key", {"slot", 0x0300}, light_weakGround},
                                                                {"shift", lighten, light_weakGround, dark_weakGround_dark}},
                                              {{"slot", 0x05D0}, {"remove", light_weakGround}}}, 
                                    "unpassable"}},
                                              
                "mixed", {"ramp", "lowgrounds", "land", "no-building",
                  -- [0x2100] upper left filled
                            -- (transition to coast lowround)
                          {{"range", 0x2100, 0x2101}, {"layers", {{"slot", 0x03D0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0200, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03D0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2102, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2103, 0x2104}, {"layers", {{"slot", 0x03D0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0200, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03D0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0500}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x2110] upper right filled
                            -- (transition to coast lowground)
                          {{"range", 0x2110, 0x2111}, {"layers", {{"slot", 0x03C0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0210, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03C0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2112, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2113, 0x2114}, {"layers", {{"slot", 0x03C0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0210, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03C0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0510}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x2120] upper half filled
                            -- (transition to coast lowground)
                          {{"range", 0x2120, 0x2122}, {"layers", {{"slot", 0x03B0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0220, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03B0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2123, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2124, 0x2126}, {"layers", {{"slot", 0x03B0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0220, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03B0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0520}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},

                  -- [0x2130] lower left filled
                            -- (transition to coast lowground)
                          {{"range", 0x2130, 0x2131}, {"layers", {{"slot", 0x03A0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0230, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03A0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},                        
                          {0x2132, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2133, 0x2134}, {"layers", {{"slot", 0x03A0}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0230, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x03A0}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0530}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x2140] left half filled
                            -- (transition to coast lowground)
                          {{"range", 0x2140, 0x2142}, {"layers", {{"slot", 0x0390}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0240, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0390}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2143, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2144, 0x2146}, {"layers", {{"slot", 0x0390}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0240, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0390}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0540}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x2160] lower right clear
                            -- (transition to coast lowground)
                          {{"range", 0x2160, 0x2161}, {"layers", {{"slot", 0x0370}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0260, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0370}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2162, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2163, 0x2164}, {"layers", {{"slot", 0x0370}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0260, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0370}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0560}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x2170] lower right filed
                            -- (transition to coast lowground)
                          {{"range", 0x2170, 0x2171}, {"layers", {{"slot", 0x0360}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0270, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0360}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2172, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2173, 0x2174}, {"layers", {{"slot", 0x0360}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0270, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0360}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0570}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x2190] right half filled
                            -- (transition to coast lowground)
                          {{"range", 0x2190, 0x2192}, {"layers", {{"slot", 0x0340}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0290, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0340}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x2193, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x2194, 0x2196}, {"layers", {{"slot", 0x0340}, {"shift", lighten, light_weakGround_light}},
                                                                {0x0290, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0340}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x0590}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x21A0] lower left clear
                            -- (transition to coast lowground)
                          {{"range", 0x21A0, 0x21A1}, {"layers", {{0x0330, 0x0331}, {"shift", lighten, light_weakGround_light}}, -- last tile in the slot 0x0330 is broken
                                                                {0x02A0, {"remove-all-except", water},
                                                                          {"chroma-key", {0x0330, 0x0331}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x21A2, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x21A3, 0x21A4}, {"layers", {{0x0330, 0x0331}, {"shift", lighten, light_weakGround_light}}, -- last tile in the slot 0x0330 is broken
                                                                {0x02A0, {"remove-all-except", water},
                                                                          {"chroma-key", {0x0330, 0x0331}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x05A0}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x21B0] upper half clear
                            -- (transition to coast lowground)
                          {{"range", 0x21B0, 0x21B2}, {"layers", {{"slot", 0x0320}, {"shift", lighten, light_weakGround_light}},
                                                                {0x02B0, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0320}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x21B3, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x21B4, 0x21B6}, {"layers", {{"slot", 0x0320}, {"shift", lighten, light_weakGround_light}},
                                                                {0x02B0, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0320}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x05B0}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x21C0] upper right clear
                            -- (transition to coast lowground)
                          {{"range", 0x21C0, 0x21C1}, {"layers", {{"slot", 0x0310}, {"shift", lighten, light_weakGround_light}},
                                                                {0x02C0, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0310}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x21C2, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x21C3, 0x21C4}, {"layers", {{"slot", 0x0310}, {"shift", lighten, light_weakGround_light}},
                                                                {0x02C0, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0310}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x05C0}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}},
                  -- [0x21D0] upper left clear
                            -- (transition to coast lowground)
                          {{"range", 0x21D0, 0x21D1}, {"layers", {{"slot", 0x0300}, {"shift", lighten, light_weakGround_light}},
                                                                {0x02D0, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0300}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}}}},
                          {0x21D2, {0x0000}},-- separator
                            -- (transition to grass lowground)
                          {{"range", 0x21D3, 0x21D4}, {"layers", {{"slot", 0x0300}, {"shift", lighten, light_weakGround_light}},
                                                                {0x02D0, {"remove-all-except", water},
                                                                          {"chroma-key", {"slot", 0x0300}, water},
                                                                          {"remove", light_weakGround_light, dark_weakGround_dark},
                                                                          {"shift", lighten, light_weakGround_dark}},
                                                                {{"slot", 0x05D0}, {"remove", light_weakGround}, {"shift", dim, dark_ground}}}}}
          }
  )

end
