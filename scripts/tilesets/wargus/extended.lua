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
--     (c) Copyright 2023 by Alyokhin
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
--  Define a tileset
--
--  (define-tileset ident class name image palette slots animations)
--

--[[

Base tileset
001x            light water
002x            dark water
003x            weak ground
004x            dark weak ground
005x            solid ground
006x            dark solid ground
007x            forest
008x            mountains
009x            human wall
00ax            orc walls
00bx            human walls
00cx            orc walls

boundry tiles

09..            orc wall
08..            human wall
07..            forest and solid ground
06..            dark solid and solid ground
05..            weak ground and solid ground
04..            mount and weak ground
03..            dark weak ground and weak ground
02..            water and weak ground
01..            dark water and water

Extended tileset

101x  solid cliff
102x  solid ramp

boundry tiles

11..            cliff and dark weak lowground
12..            cliff and dark solid lowground
13..            cliff and water lowground
14..            weak highground and cliff
15..            solid highground and cliff
16..            weak highground and dark weak lowground
17..            weak highground and dark solid lowground
18..            weak highground and light water lowground
19..            solid highground and dark weak lowground
1A..            solid highground and dark solid lowground
1B..            solid highground and light water lowground
1C..            ramp and cliff
1D..            ramp and dark weak lowground
1E..            ramp and dark solid lowground
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
            Remove certain colors from tiles images
          usage:    {"remove", colors[, colors]..}
                  where 'colors':
                          color       -- single color
                          {from, to}  -- range of colors

          "remove-all-except"
            Remove all colors from tiles images except given certain colors
          usage:    {"remove-all-except", colors[, colors]..}
                  where 'colors':
                          color       -- single color
                          {from, to}  -- range of colors

          "shift"
            Shift certain colors from tiles images by a given increment
          usage   {"shift", inc, colors[, colors]..}
                  where   'inc':
                        increment (positive or negative) to be implemented on the colors
                      'colors':
                        color       -- single color
                        {from, to}  -- range of colors

          "flip"
            Flip images
          usage:    {"flip", direction}
                  where 'direction':
                        "vertical"
                        "horizontal"
                        "both"

          "chroma-key"
            Compose set of images with images from src_range. Are taken consecutively one for each from src_range.
            If pixel from src image has chroma key color it will be replaced by pixel from src2 image
          usage:    {"chroma-key", src_range2, key_colors[, key_colors]..}
                  where 'src_range2': (set of images to compose with images from src_range. Are taken consecutively one for each from src_range)
                        {tile}                                  -- tile index (within main tileset) to get graphic from
                        {tile[, tile]...}}                      -- set of tiles indexes (within main tileset) to get graphics from
                        {"img"|"img-base", image[, image]...}   -- set of numbers of frames from the extended (or base tileset) "image" file.
                        {["img"|"img-base",] "range", from, to} -- if "img" then from frame to frame (for "image"),
                                                                -- otherwise indexes from tile to tile (within main tileset) to get graphics from
                        {"slot", slot_num}                      -- f.e. {"slot", 0x0430} - to take graphics continuously from tiles with indexes of slot 0x0430
                    'key_colors': (chroma keys)
                        color       -- single color
                        {from, to}  -- range of colors

      additional-flags-list:
        strings which started from position 3
        comma separated list of additional flags for this range of tiles
--]]

function ExtendTileset(seed)

  local rampSrc_baseIdx = seed.rampSrc_baseIdx
  local rampEdgeSrc_baseIdx = seed.rampEdgeSrc_baseIdx

  local rampSrc = seed.rampSrc

  local lowgroundWeakGround = seed.lowgroundWeakGround
  local lowgroundSolidGround = seed.lowgroundSolidGround
  local highgroundWeakGround = seed.highgroundWeakGround
  local highgroundSolidGround = seed.highgroundSolidGround
  local cliffGen = seed.cliffGen

  local dim = seed.dim
  local lighten = seed.lighten

  local function getListOfTilesWithoutExceptions(baseSlot, subSlot)

    if cliffGen.baseTilesFor["cliff-edges-exceptions"][baseSlot][subSlot] == nil then
      return {"slot", baseSlot + subSlot}
    end

    local result = {}
    for tileIdx = 0, 0xF, 1 do
        local isException = false
        for i,exception in ipairs(cliffGen.baseTilesFor["cliff-edges-exceptions"][baseSlot][subSlot]) do
            if tileIdx == exception then
                isException = true
                break
            end
        end
        if not isException then
          table.insert(result, baseSlot + subSlot + tileIdx)
        end
    end
    return result
  end
  local srcTilesLst = getListOfTilesWithoutExceptions
  cliffGen.utils.srcTilesLst = getListOfTilesWithoutExceptions

  local function getColors(colorSet, ...)
    local args = {...}
    local returnValue = {}

    if #args == 0 then args = colorSet["all"] end -- if no subset given, then use "all" subset

    for i, range in ipairs(args) do
      if colorSet[range] ~= nil then
        for ii, inRangeValue in ipairs(colorSet[range]) do
          table.insert(returnValue, inRangeValue)
        end
      end
    end
    return unpack(returnValue)
  end
  local colorsFor = getColors -- alias
  cliffGen.utils.colorsFor = getColors

  local function convertColors(rangeFrom, rangeTo)
    if rangeFrom == nil or rangeTo == nil then
      return nil
    end
    if type(rangeFrom) == "table" and #rangeFrom < 2 then
      return nil
    end
    if type(rangeTo) == "table" and #rangeTo < 2 then
      return nil
    end

    local result = {}

    local srcColors = {}
    if type(rangeFrom) == "table" then
        for color = rangeFrom[1], rangeFrom[2] do
            table.insert(srcColors, color)
        end
    else
        table.insert(srcColors, rangeFrom)
    end

    local dstColor = rangeTo
    local dstInc = 0
    if type(rangeTo) == "table" then
      dstColor = rangeTo[1]
      dstInc  = (rangeTo[2] - rangeTo[1] + 1) / #srcColors
    end

    for i, srcColor in ipairs(srcColors) do
      local shiftValue = math.floor(dstColor + 0.5) - srcColor
      table.insert(result, {"shift", shiftValue, srcColor})
      dstColor = dstColor + dstInc
    end

    return result
  end

  local function checkForExceptionColor(range, exceptionPairs, direction)
    if exceptionPairs == nil then return nil end

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

          if type(range) == "table" then
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
    return shiftBrightness_byStep(lighten, colorSet["exceptions"], getColors(colorSet, unpack(subSets)))
  end
  cliffGen.utils.Lighten = Lighten

  local function Dim(colorSet, ...)
    local subSets = {...}
    return shiftBrightness_byStep(dim, colorSet["exceptions"], getColors(colorSet, unpack(subSets)))
  end
  cliffGen.utils.Dim = Dim

  local function cleanRocksAndDimShadows(baseTerrain, resultAsTable)
    local result = {}
    if cliffGen.cleanRocks ~= nil then
      result = {cliffGen.cleanRocks(getColors, baseTerrain)}
    else
      result = {{"remove", getColors(cliffGen.colors, "remove-toCleanRocks")}}

      if baseTerrain == "weak-ground" then
        table.insert(result, Dim(cliffGen.colors, "shadows-onRocks"))
      else
        for i, range in ipairs(cliffGen.colors["convertable-shadows-onRocks"]) do
          for j, convertedColors in ipairs(convertColors(range["from"], range["to"])) do
            table.insert(result, convertedColors)
          end
        end
        -- shadows are already dimmed in the convertColors()
      end
    end

    if resultAsTable == true then
      return result
    else
      return unpack(result)
    end
  end

  local function getCliffsTiles(slot, baseTerrain)
    --[[
    where:
    slot:
      0xD0
      {"pick", 0xD0, 0xD1}
      "fully-filled"
      {"special", "singleRockUp", "singleRockMid", "singleRockBot", "removedRock"}
    baseTerrain: (optional)
       "weak-ground"
       "solid-ground"
    --]]
    local result = {}
    local rocksOnWeakGrnd  = 0x0400
    local rocksFullyFilled = 0x0080

    if cliffGen.baseTilesFor["cliff"] == nil then -- in case if we have to generate cliffs from rocks
      if slot == "fully-filled" then
        return {"slot", rocksFullyFilled}

      elseif type(slot) == "table" then
        if slot[1] == "pick" then
          local tiles = {}
          for i,tile in ipairs(slot) do
            if i > 1 then
              if tile >= 0x00 and tile <= 0xDF then
                table.insert(tiles, tile + rocksOnWeakGrnd)
              end
            end
          end
          table.insert(result, tiles)

        elseif slot[1] == "special" then
          local tiles = {"img-base"}

          for i,tile in ipairs(slot) do
            if i > 1 then table.insert(tiles, cliffGen.baseTilesFor["cliff-special"][tile]) end
          end
          table.insert(result, tiles)

        else
          table.insert(result, {0x0000}) -- something goes wrong
        end

      elseif type(slot) == "number" and slot >= 0x00 and slot <= 0xD0 then
        table.insert(result, {"slot", rocksOnWeakGrnd + slot})
      else
        table.insert(result, {0x0000}) -- something goes wrong
      end

      for i,v in ipairs(cleanRocksAndDimShadows(baseTerrain, true)) do
        table.insert(result, v)
      end

    end
    return unpack(result)
  end

  local function makeHighGroundEdge(groundType, slot)
    return cliffGen:makeHighGroundEdge(groundType, slot)
  end

  local function makeRampEdge(slot)
    return srcTilesLst(rampEdgeSrc_baseIdx, (0xD0 - slot)), cliffGen:makeRampEdge()
  end

  local function makeRampToHighGround(groundType, slot, isMask, edgeSlot)
    return cliffGen:makeRampToHighGround(groundType, slot, isMask, edgeSlot)
  end

  local function makeRampToLowGround(groundType, slot)
    return cliffGen:makeRampToLowGround(groundType, slot)
  end

  local function genDstSrcSeq(dstSlot, subSlots, src)
    result = {}

    for i, slot in ipairs(subSlots) do
      table.insert(result, {{"slot", dstSlot + slot}, src(slot)})
    end
    return unpack(result)
  end

  local function bitAND(op1, op2)
    local p, result = 1, 0
    while op1 > 0 and op2 > 0 do
        local rop1, rop2 = op1 % 2, op2 % 2
        if rop1 + rop2 > 1 then result = result + p end
        op1, op2, p = (op1 - rop1) / 2, (op2 - rop2) / 2, p * 2
    end
    return result
  end

  local function genHighToLowGroundSeq(dstSlot, highGroundType, lowGroundType)
    --[[
        This generates sequence of {dstRange, srcRange} where:

        {dstRange, {"layers", cliffGen.baseTilesFor[lowGroundType][slot],
                              {getCliffsTiles(cliffs, lowGroundType)},
                              makeHighGroundEdge(highGroundType, slot)}},
        Or
        {dstRange, {"layers", cliffGen.baseTilesFor[lowGroundType][slot],
                              makeHighGroundEdge(highGroundType, slot)}},
        Or
        {dstRange, {0x0000}}
    --]]

    local genTable = {
      {["dst"] = {0x00},        ["src"] = {["cliffs"] = {"pick", 0x40, 0x41}}}, -- upper left filled

      {["dst"] = {0x10},        ["src"] = {["cliffs"] = 0x90}}, -- upper right filled

      {["dst"] = {0x30, 0x3B},  ["src"] = {["cliffs"] = 0x30}}, -- lower left filled
      {["dst"] = 0x3C},  -- separator
      {["dst"] = {0x3D, 0x3F},  ["src"] = {["cliffs"] = 0x60}}, -- (with rock lower right clear)

      {["dst"] = {0x40},        ["src"] = {["cliffs"] = {"special", "singleRockUp", "singleRockBot", "removedRock"}}}, -- left half filled

      {["dst"] = {0x70, 0x7B},  ["src"] = {["cliffs"] = 0x70}}, -- lower right filled
      {["dst"] = 0x7C},  -- separator
      {["dst"] = {0x7D, 0x7F},  ["src"] = {["cliffs"] = 0xA0}}, -- (with rock lower left clear)

      {["dst"] = {0x90},        ["src"] = {["cliffs"] = {"special", "singleRockMid", "singleRockBot", "removedRock"}}}, -- right half filled

      {["dst"] = {0xB0, 0xB3},  ["src"] = {["cliffs"] = 0xB0}}, -- upper half clear (with rock lower half filled)
      {["dst"] = 0xB4},  -- separator
      {["dst"] = {0xB5, 0xB6},  ["src"] = {["cliffs"] = 0x90}}, -- (with rock lower left filled)
      {["dst"] = 0xB7},  -- separator
      {["dst"] = {0xB8, 0xB9},  ["src"] = {["cliffs"] = 0x70}}, -- (with rock lower right filled)
      {["dst"] = 0xBA},  -- separator
      {["dst"] = {0xBB, 0xBC},  ["src"] = {["cliffs"] = 0xD0}}, -- (with rock upper left clear)
      {["dst"] = 0xBD},  -- separator
      {["dst"] = {0xBE, 0xBF},  ["src"] = {["cliffs"] = 0xC0}}, -- (with rock upper right clear)

      {["dst"] = {0xC0, 0xC3},  ["src"] = {["cliffs"] = 0xB0}}, -- upper right clear
      {["dst"] = 0xC4},  -- separator
      {["dst"] = {0xC5, 0xC6},  ["src"] = {["cliffs"] = 0xC0}}, -- (with rock upper right clear)
      {["dst"] = 0xC7},  -- separator
      {["dst"] = {0xC8, 0xC9},  ["src"] = {}}, -- (without rock)

      {["dst"] = {0xD0, 0xD3},  ["src"] = {["cliffs"] = 0xB0}}, -- upper left clear
      {["dst"] = 0xD4},  -- separator
      {["dst"] = {0xD5, 0xD6},  ["src"] = {["cliffs"] = 0xD0}}, -- (with rock upper left clear)
      {["dst"] = 0xD7},  -- separator
      {["dst"] = {0xD8, 0xD9},  ["src"] = {}}, -- (without rock)

      parse = function(slotToParse, dstBaseSlot)
        local dst = {}
        local slot
        if type(slotToParse["dst"]) == "table" then
          if #slotToParse["dst"] == 1 then
            dst = {"slot", dstBaseSlot + slotToParse["dst"][1]}
          else
            dst = {"range", dstBaseSlot + slotToParse["dst"][1], dstBaseSlot + slotToParse["dst"][2]}
          end
          slot = bitAND(slotToParse["dst"][1], 0xF0)
        elseif type(slotToParse["dst"]) == "number" then
          dst = {dstBaseSlot + slotToParse["dst"]}
          slot = bitAND(slotToParse["dst"], 0xF0)
        end

        local cliffs
        if slotToParse["src"] ~= nil then
          cliffs = slotToParse["src"]["cliffs"]
        else
          slot = nil
          cliffs = nil
        end

        return dst, slot, cliffs
      end
    }
    local result = {}

    for i, slotData in ipairs(genTable) do
      if type(slotData) ~= "table" then break end

      local src
      local dst, slot, cliffs = genTable.parse(slotData, dstSlot)
      if slot == nil then
        src = {0x0000} -- separator
      else
        src = {"layers",  cliffGen.baseTilesFor[lowGroundType][slot],
                          {getCliffsTiles(cliffs, lowGroundType)},
                          makeHighGroundEdge(highGroundType, slot)}
        if cliffs == nil then
          table.remove(src, 3) -- remove {getCliffsTiles(cliffs, lowGroundType)} from src
        end
      end
      table.insert(result, {dst, src})
    end
    return unpack(result)
  end

  local function genRampToLowGroundSeq(dstSlot, subSlots)
    local result = {}
    for i, slot in ipairs(subSlots) do

      local rangeWidth = 2
      if slot == 0x20 or slot == 0x40 or slot == 0x90 or slot == 0xB0 then 
        rangeWidth = 3
      end
                                     
      local rngBeg = dstSlot + slot
      local rngEnd = rngBeg + rangeWidth - 1
      -- (transition to weak lowground)
      table.insert(result, {{"range", rngBeg, rngEnd}, makeRampToLowGround("weak-ground", slot)})

       -- separator
      rngEnd = rngEnd + 1
      table.insert(result, {rngEnd, {0x0000}})

      -- (transition to solid lowground)
      rngBeg = rngEnd + 1
      rngEnd = rngBeg + rangeWidth - 1
      table.insert(result, {{"range", rngBeg, rngEnd}, makeRampToLowGround("solid-ground", slot)})
    end
    return unpack(result)
  end

  GenerateExtendedTileset(
  --  "image", "",
    "slots",  {
                "solid", {"cliff", "land", "unpassable", "no-building",
                          {{"slot", 0x1010}, {getCliffsTiles("fully-filled")}}},
                "solid", {"ramp", "land", "no-building",
                          {{"slot", 0x1020}, {{"slot", rampSrc_baseIdx + 0x00}, Lighten(rampSrc, "base", "shadows")}}},
                "mixed", {"cliff", lowgroundWeakGround, "land", "unpassable", "no-building",
                          genDstSrcSeq(0x1100,
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", cliffGen.baseTilesFor["weak-ground"][slot],
                                                                         {getCliffsTiles(slot, "weak-ground")}}
                                       end)},

                "mixed", {"cliff", lowgroundSolidGround, "land", "unpassable", "no-building",
                          genDstSrcSeq(0x1200,
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", cliffGen.baseTilesFor["solid-ground"][slot],
                                                                         {getCliffsTiles(slot, "solid-ground")}}
                                       end)},

                "mixed", {highgroundWeakGround, "cliff", "land", "unpassable", "no-building",
                          genDstSrcSeq(0x1400,
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", {getCliffsTiles("fully-filled")},
                                                                         makeHighGroundEdge("weak-ground", slot)}
                                       end)},

                "mixed", {highgroundSolidGround, "cliff", "land", "unpassable", "no-building",
                          genDstSrcSeq(0x1500,
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", {getCliffsTiles("fully-filled")},
                                                                         makeHighGroundEdge("solid-ground", slot)}
                                       end)},

                "mixed", {highgroundWeakGround, lowgroundWeakGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(0x1600, "weak-ground", "weak-ground")},

                "mixed", {highgroundWeakGround, lowgroundSolidGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(0x1700, "weak-ground", "solid-ground")},

                "mixed", {highgroundSolidGround, lowgroundWeakGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(0x1900, "solid-ground", "weak-ground")},

                "mixed", {highgroundSolidGround, lowgroundSolidGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(0x1A00, "solid-ground", "solid-ground")},

                "mixed", {"ramp", "cliff", "land", "unpassable", "no-building",
                          genDstSrcSeq(0x1C00,
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", {getCliffsTiles("fully-filled")},
                                                                         {makeRampEdge(slot)}}
                                       end)},

                "mixed", {"ramp", lowgroundWeakGround, "land", "unpassable", "no-building",
                  -- [0x1D00] upper left filled
                            -- (with rock lower right clear)
                          {{"range", 0x1D00, 0x1D01}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x00], -- {0x0046},
                                                                 {getCliffsTiles(0x60, "weak-ground")},
                                                                 {makeRampEdge(0x00)}}},
                          {0x1D02, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1D03, 0x1D09}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x00], -- {0x0046, 0x004A},
                                                                 {getCliffsTiles(0x10, "weak-ground")},
                                                                 {makeRampEdge(0x00)}}},
                          {0x1D0A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D0B, 0x1D0F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x00], -- {0x0044, 0x0046, 0x0049, 0x004A},
                                                                 {makeRampEdge(0x00)}}},
                  -- [0x1D10] upper right filled
                            -- (with rock lower left clear)
                          {{"range", 0x1D10, 0x1D11}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x10], -- {0x0044},
                                                                 {getCliffsTiles(0xA0, "weak-ground")},
                                                                 {makeRampEdge(0x10)}}},
                          {0x1D12, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1D13, 0x1D19}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x10], -- {0x0044, 0x0049},
                                                                 {getCliffsTiles(0x00, "weak-ground")},
                                                                 {makeRampEdge(0x10)}}},
                          {0x1D1A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D1B, 0x1D1F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x10], -- {0x0044, 0x0046, 0x0049, 0x004A},
                                                                 {makeRampEdge(0x10)}}},
                  -- [0x1D20] upper half filled
                            -- (with rock upper half filled)
                          {{"range", 0x1D20, 0x1D22}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x20], -- {"range", 0x0044, 0x004B},
                                                                 {getCliffsTiles(0x20, "weak-ground")},
                                                                 {makeRampEdge(0x20)}}},
                          {0x1D23, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {0x1D24, {"layers", cliffGen.baseTilesFor["weak-ground"][0x20], -- {0x0044},
                                              {getCliffsTiles(0x00, "weak-ground")},
                                              {makeRampEdge(0x20)}}},
                          {0x1D25, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {0x1D26, {"layers", cliffGen.baseTilesFor["weak-ground"][0x20], -- {0x0044},
                                              {getCliffsTiles(0x10, "weak-ground")},
                                              {makeRampEdge(0x20)}}},
                          {0x1D27, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x1D28, 0x1D29}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x20], -- {"range", 0x0044, 0x004B},
                                                                 {getCliffsTiles(0x70, "weak-ground")},
                                                                 {makeRampEdge(0x20)}}},
                          {0x1D2A, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x1D2B, 0x1D2C}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x20], -- {"range", 0x0044, 0x004B},
                                                                 {getCliffsTiles(0x30, "weak-ground")},
                                                                 {makeRampEdge(0x20)}}},
                          {0x1D2D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D2E, 0x1D2F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x20], -- {"range", 0x0044, 0x004B},
                                                                 {makeRampEdge(0x20)}}},
                  -- [0x1D30] lower left filled
                            -- (with rock lower left filled)
                          {{"range", 0x1D30, 0x1D34}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x30], -- {0x0046, 0x004A},
                                                                 {getCliffsTiles(0x30, "weak-ground")},
                                                                 {makeRampEdge(0x30)}}},
                          {0x1D35, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1D36, 0x1D39}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x30], -- {0x0046, 0x004A},
                                                                 {getCliffsTiles(0x00, "weak-ground")},
                                                                 {makeRampEdge(0x30)}}},
                          {0x1D3A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D3B, 0x1D3F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x30], -- {0x0046, 0x004A},
                                                                 {makeRampEdge(0x30)}}},
                  -- [0x1D40] left half filled
                            -- (with rock left half filled)
                          {{"range", 0x1D40, 0x1D42}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x40], -- {0x0044, 0x0045, 0x0046},
                                                                 {getCliffsTiles({"pick", 0x40, 0x41}, "weak-ground")},
                                                                 {makeRampEdge(0x40)}}},
                          {0x1D43, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1D44, {"layers", cliffGen.baseTilesFor["weak-ground"][0x40], -- {0x0044},
                                              {getCliffsTiles({"special", "singleRockBot"}, "weak-ground")},
                                              {makeRampEdge(0x40)}}},
                          {0x1D45, {0x0000}}, -- separator
                            -- (with rock lower center filled)
                          {0x1D46, {"layers", cliffGen.baseTilesFor["weak-ground"][0x40], -- {0x0045},
                                              {getCliffsTiles({"special", "singleRockUp"}, "weak-ground")},
                                              {makeRampEdge(0x40)}}},
                          {0x1D47, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x1D48, 0x1D49}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x40], -- {0x0044},
                                                                 {getCliffsTiles({"pick", 0xC0}, "weak-ground")},
                                                                 {makeRampEdge(0x40)}}},
                          {0x1D4A, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x1D4B, 0x1D4C}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x40], -- {0x0044},
                                                                 {getCliffsTiles({"pick", 0x60}, "weak-ground")},
                                                                 {makeRampEdge(0x40)}}},
                          {0x1D4D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D4E, 0x1D4F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x40], -- {0x0044, 0x0045},
                                                                 {getCliffsTiles({"special", "removedRock"}, "weak-ground")},
                                                                 {makeRampEdge(0x40)}}},
                  -- [0x1D60] lower right clear
                            -- (with rock lower right clear)
                          {{"range", 0x1D60, 0x01D61}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x60], -- {0x0044},
                                                                  {getCliffsTiles({"pick", 0x60}, "weak-ground")},
                                                                  {makeRampEdge(0x60)}}},
                          {0x1D62, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D63, 0x1D64}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x60], -- {0x0044},
                                                                 {makeRampEdge(0x60)}}},
                  -- [0x1D70] lower right filled
                            -- (with rock lower right filled)
                          {{"range", 0x1D70, 0x1D74}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x70], -- {0x0044, 0x0049},
                                                                 {getCliffsTiles(0x70, "weak-ground")},
                                                                 {makeRampEdge(0x70)}}},
                          {0x1D75, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1D76, 0x1D79}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x70], -- {0x0044, 0x0049},
                                                                 {getCliffsTiles(0x10, "weak-ground")},
                                                                 {makeRampEdge(0x70)}}},
                          {0x1D7A, {0x0000}}, -- separator
                          -- lower right filled (without rock)
                          {{"range", 0x1D7B, 0x1D7F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x70], -- {0x0044, 0x0049},
                                                                 {makeRampEdge(0x70)}}},
                  -- [0x1D90] right half filled
                            -- (with rock right half filled)
                          {{"range", 0x1D90, 0x1D92}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x90], -- {0x0044, 0x0045, 0x0046, 0x0049, 0x004A},
                                                                 {getCliffsTiles(0x90, "weak-ground")},
                                                                 {makeRampEdge(0x90)}}},
                          {0x1D93, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1D94, {"layers", cliffGen.baseTilesFor["weak-ground"][0x90], -- {0x0044},
                                              {getCliffsTiles({"special", "singleRockBot"}, "weak-ground")},
                                              {makeRampEdge(0x90)}}},
                          {0x1D95, {0x0005}}, -- separator
                            -- (with rock lower center filled)
                          {0x1D96, {"layers", cliffGen.baseTilesFor["weak-ground"][0x90], -- {0x0044},
                                              {getCliffsTiles({"pick", 0x71}, "weak-ground")},
                                              {makeRampEdge(0x90)}}},
                          {0x1D97, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1D98, 0x1D99}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x90], -- {0x0044},
                                                                 {getCliffsTiles({"pick", 0xD0}, "weak-ground")},
                                                                 {makeRampEdge(0x90)}}},
                          {0x1D9A, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x1D9B, 0x1D9C}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x90], -- {0x0044},
                                                                 {getCliffsTiles({"pick", 0xA0}, "weak-ground")},
                                                                 {makeRampEdge(0x90)}}},
                          {0x1D9D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1D9E, 0x1D9F}, {"layers", cliffGen.baseTilesFor["weak-ground"][0x90], -- {0x0044, 0x0045},
                                                                 {getCliffsTiles({"special", "removedRock"}, "weak-ground")},
                                                                 {makeRampEdge(0x90)}}},
                  -- [0x1DA0] lower left clear
                            -- (with rock lower left clear)
                          {{"range", 0x1DA0, 0x1DA1}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xA0], -- {0x0046},
                                                                 {getCliffsTiles({"pick", 0xA0}, "weak-ground")},
                                                                 {makeRampEdge(0xA0)}}},
                          {0x1DA2, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1DA3, 0x1DA4}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xA0], -- {0x0046},
                                                                 {makeRampEdge(0xA0)}}},
                  -- [0x1DB0] upper half clear
                          {{"slot", 0x1DB0}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0], -- {"range", 0x0044, 0x004B},
                                                        {getCliffsTiles(0xB0, "weak-ground")},
                                                        {makeRampEdge(0xB0)}}},
                  -- [0x1DC0] upper right clear
                          {{"range", 0x1DC0, 0x1DC3}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xC0], -- {0x0046},
                                                                 {getCliffsTiles(0xB0, "weak-ground")},
                                                                 {makeRampEdge(0xC0)}}},
                          {0x1DC4, {0x0000}}, -- separator
                            -- (without rocks)
                          {{"range", 0x1DC5, 0x1DC6}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xC0], -- {0x004A},
                                                                 {makeRampEdge(0xC0)}}},
                  -- [0x1DD0] upper left clear
                          {{"range", 0x1DD0, 0x1DD3}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xD0], -- {0x0044, 0x0049},
                                                                 {getCliffsTiles(0xB0, "weak-ground")},
                                                                 {makeRampEdge(0xD0)}}},
                          {0x1DD4, {0x0000}}, -- separator
                            -- (without rocks)
                          {{"range", 0x1DD5, 0x1DD6}, {"layers", cliffGen.baseTilesFor["weak-ground"][0xD0], -- {0x0044},
                                                                 {makeRampEdge(0xD0)}}}},

                "mixed", {"ramp", lowgroundSolidGround, "land", "unpassable", "no-building",
                  -- [0x1E00] upper left filled
                            -- (with rock lower right clear)
                          {{"range", 0x1E00, 0x1E01}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x00], -- {0x0068},
                                                                 {getCliffsTiles(0x60, "solid-ground")},
                                                                 {makeRampEdge(0x00)}}},
                          {0x1E02, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1E03, 0x1E09}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x00], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x10, "solid-ground")},
                                                                 {makeRampEdge(0x00)}}},
                          {0x1E0A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E0B, 0x1E0F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x00], -- {0x0065, 0x0068, 0x0069},
                                                                 {makeRampEdge(0x00)}}},
                  -- [0x1E10] upper right filled
                            -- (with rock lower left clear)
                          {{"range", 0x1E10, 0x1E11}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x10], -- {0x0068},
                                                                 {getCliffsTiles(0xA0, "solid-ground")},
                                                                 {makeRampEdge(0x10)}}},
                          {0x1E12, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1E13, 0x1E19}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x10], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x00, "solid-ground")},
                                                                 {makeRampEdge(0x10)}}},
                          {0x1E1A, {0x0000}}, -- separator
                          -- upper right filled (without rock)
                          {{"range", 0x1E1B, 0x1E1F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x10], -- {0x0065, 0x0068, 0x0069},
                                                                 {makeRampEdge(0x10)}}},
                  -- [0x1E20] upper half filled
                            -- (with rock upper half filled)
                          {{"range", 0x1E20, 0x1E22}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x20], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x20, "solid-ground")},
                                                                 {makeRampEdge(0x20)}}},
                          {0x1E23, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {0x1E24, {"layers", cliffGen.baseTilesFor["solid-ground"][0x20], -- {0x0068},
                                              {getCliffsTiles(0x00, "solid-ground")},
                                              {makeRampEdge(0x20)}}},
                          {0x1E25, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {0x1E24, {"layers", cliffGen.baseTilesFor["solid-ground"][0x20], -- {0x0068},
                                              {getCliffsTiles(0x10, "solid-ground")},
                                              {makeRampEdge(0x20)}}},
                          {0x1E27, {0x0000}}, -- separator
                            -- (with rock lower right filled)
                          {{"range", 0x1E28, 0x1E29}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x20], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x70, "solid-ground")},
                                                                 {makeRampEdge(0x20)}}},
                          {0x1E2A, {0x0000}}, -- separator
                            -- (with rock lower left filled)
                          {{"range", 0x1E2b, 0x1E2C}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x20], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x30, "solid-ground")},
                                                                 {makeRampEdge(0x20)}}},
                          {0x1E2D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E2E, 0x1E2F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x20], -- {0x0068, 0x0069},
                                                                 {makeRampEdge(0x20)}}},
                  -- [0x1E30] lower left filled
                            -- (with rock lower left filled)
                          {{"range", 0x1E30, 0x1E34}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x30], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x30, "solid-ground")},
                                                                 {makeRampEdge(0x30)}}},
                          {0x1E35, {0x0000}}, -- separator
                            -- (with rock upper left filled)
                          {{"range", 0x1E36, 0x1E39}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x30], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x00, "solid-ground")},
                                                                 {makeRampEdge(0x30)}}},
                          {0x1E3A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E3B, 0x1E3F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x30], -- {0x0068, 0x0069},
                                                                 {makeRampEdge(0x30)}}},
                  -- [0x1E40] left half filled
                            -- (with rock left half filled)
                          {{"range", 0x1E40, 0x1E42}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x40], -- {0x0065, 0x0068, 0x0069},
                                                                 {getCliffsTiles({"pick", 0x40, 0x41}, "solid-ground")},
                                                                 {makeRampEdge(0x40)}}},
                          {0x1E43, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1E44, {"layers", cliffGen.baseTilesFor["solid-ground"][0x40], -- {0x0065},
                                              {getCliffsTiles({"special", "singleRockBot"}, "solid-ground")},
                                              {makeRampEdge(0x40)}}},
                          {0x1E45, {0x0000}}, -- separator
                            -- (with rock lower center filled)
                          {0x1E46, {"layers", cliffGen.baseTilesFor["solid-ground"][0x40], -- {0x0068},
                                              {getCliffsTiles({"special", "singleRockUp"}, "solid-ground")},
                                              {makeRampEdge(0x40)}}},
                          {0x1E47, {0x0000}}, -- separator
                            -- (with rock upper right clear)
                          {{"range", 0x1E48, 0x1E49}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x40], -- {0x0065},
                                                                 {getCliffsTiles({"pick", 0xC0}, "solid-ground")},
                                                                 {makeRampEdge(0x40)}}},
                          {0x1E4A, {0x0000}}, -- separator
                            -- (with rock lower right clear)
                          {{"range", 0x1E4B, 0x1E4C}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x40], -- {0x0065},
                                                                 {getCliffsTiles({"pick", 0x60}, "solid-ground")},
                                                                 {makeRampEdge(0x40)}}},
                          {0x1E4D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E4E, 0x1E4F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x40], -- {0x0065},
                                                                 {getCliffsTiles({"special", "removedRock"}, "solid-ground")},
                                                                 {makeRampEdge(0x40)}}},
                  -- [0x1E60] lower right clear
                            -- (with rock lower right clear)
                          {{"range", 0x1E60, 0x1E61}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x60], -- {0x0069},
                                                                 {getCliffsTiles({"pick", 0x60}, "solid-ground")},
                                                                 {makeRampEdge(0x60)}}},
                          {0x1E62, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E63, 0x1E64}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x60], -- {0x0069},
                                                                 {makeRampEdge(0x60)}}},
                  -- [0x1E70] lower right filled
                            -- (with rock lower right filled)
                          {{"range", 0x1E70, 0x1E74}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x70], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x70, "solid-ground")},
                                                                 {makeRampEdge(0x70)}}},
                          {0x1E75, {0x0000}}, -- separator
                            -- (with rock upper right filled)
                          {{"range", 0x1E76, 0x1E79}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x70], -- {0x0068, 0x0069},
                                                                 {getCliffsTiles(0x10, "solid-ground")},
                                                                 {makeRampEdge(0x70)}}},
                          {0x1E7A, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E7B, 0x1E7F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x70], -- {0x0068, 0x0069},
                                                                 {makeRampEdge(0x70)}}},
                  -- [0x1E90] right half filled
                            -- (with rock right half filled)
                          {{"range", 0x1E90, 0x1E92}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x90], -- {0x0065, 0x0068, 0x0069},
                                                                 {getCliffsTiles(0x90, "solid-ground")},
                                                                 {makeRampEdge(0x90)}}},
                          {0x1E93, {0x0000}}, -- separator
                            -- (with rock upper center filled)
                          {0x1E94, {"layers", cliffGen.baseTilesFor["solid-ground"][0x90], -- {0x0065},
                                              {getCliffsTiles({"special", "singleRockBot"}, "solid-ground")},
                                              {makeRampEdge(0x90)}}},
                          {0x1E95, {0x0000}}, -- separator
                            -- (with rock lower center filled)
                          {0x1E96, {"layers", cliffGen.baseTilesFor["solid-ground"][0x90], -- {0x0068},
                                              {getCliffsTiles({"pick", 0x71}, "solid-ground")},
                                              {makeRampEdge(0x90)}}},
                          {0x1E97, {0x0000}}, -- separator
                            -- (with rock upper left clear)
                          {{"range", 0x1E98, 0x1E99}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x90], -- {0x0065},
                                                                 {getCliffsTiles({"pick", 0xD0}, "solid-ground")},
                                                                 {makeRampEdge(0x90)}}},
                          {0x1E9A, {0x0000}}, -- separator
                            -- (with rock lower left clear)
                          {{"range", 0x1E9B, 0x1E9C}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x90], -- {0x0065},
                                                                 {getCliffsTiles({"pick", 0xA0}, "solid-ground")},
                                                                 {makeRampEdge(0x90)}}},
                          {0x1E9D, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1E9E, 0x1E9F}, {"layers", cliffGen.baseTilesFor["solid-ground"][0x90], -- {0x0065, 0x0068},
                                                                 {getCliffsTiles({"special", "removedRock"}, "solid-ground")},
                                                                 {makeRampEdge(0x90)}}},
                  -- [0x1EA0] lower left clear
                            -- (with rock lower left clear)
                          {{"range", 0x1EA0, 0x1EA1}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xA0], -- {0x0068},
                                                                 {getCliffsTiles({"pick", 0xA0}, "solid-ground")},
                                                                 {makeRampEdge(0xA0)}}},
                          {0x1EA2, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1EA3, 0x1EA4}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xA0], -- {0x0068},
                                                                 {makeRampEdge(0xA0)}}},
                  -- [0x1EB0] upper half clear
                          {{"slot", 0x1EB0}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0], -- {0x0065, 0x0068, 0x0069},
                                                        {getCliffsTiles(0xB0, "solid-ground")},
                                                        {makeRampEdge(0xB0)}}},
                  -- [0x1EC0] upper right clear
                          {{"range", 0x1EC0, 0x1EC3}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xC0], -- {0x0060},
                                                                 {getCliffsTiles(0xB0, "solid-ground")},
                                                                 {makeRampEdge(0xC0)}}},
                          {0x1EC4, {0x0000}}, -- separator
                            -- (without rock)
                          {{"range", 0x1EC5, 0x1EC6}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xC0], -- {0x0060},
                                                                 {makeRampEdge(0xC0)}}},
                  -- [0x1ED0] upper left clear
                          {{"range", 0x1ED0, 0x1ED3}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xD0], -- {0x0061},
                                                                 {getCliffsTiles(0xB0, "solid-ground")},
                                                                 {makeRampEdge(0xD0)}}},
                          {0x1ED4, {0x0000}},-- separator
                            -- (without rock)
                          {{"range", 0x1ED5, 0x1ED6}, {"layers", cliffGen.baseTilesFor["solid-ground"][0xD0], -- {0x0061},
                                                                 {makeRampEdge(0xD0)}}}},

                "mixed", {"ramp", "highgrounds", "land", "no-building",
                  -- [0x1F00] upper left filled
                            -- (transition to weak highground)
                          {{"range", 0x1F00, 0x1F01}, makeRampToHighGround("weak-ground", 0x00)},
                          {0x1F02, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F03, 0x1F04}, makeRampToHighGround("solid-ground", 0x00)},
                  -- [0x1F10] upper right filled
                            -- (transition to weak highground)
                          {{"range", 0x1F10, 0x1F11}, makeRampToHighGround("weak-ground", 0x10)},
                          {0x1F12, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F13, 0x1F14}, makeRampToHighGround("solid-ground", 0x10)},
                  -- [0x1F20] upper half filled
                            -- (transition to weak highground)
                          {{"range", 0x1F20, 0x1F22}, makeRampToHighGround("weak-ground", 0x20)},
                          {0x1F23, {0x0000}},-- separator
                            -- (transition to weak highground with rock upper left filled)
                          {0x1F24, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0x20, "edgeMask", 0x00)},
                                    "unpassable"},
                          {0x1F25, {0x0000}},-- separator
                            -- (transition to weak highground with rock upper right filled)
                          {0x1F26, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0x20, "edgeMask", 0x10)},
                                    "unpassable"},
                          {0x1F27, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F28, 0x1F2A}, makeRampToHighGround("solid-ground", 0x20)},
                          {0x1F2B, {0x0000}},-- separator
                            -- (transition to solid highground with rock upper left filled)
                          {0x1F2C, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0x20, "edgeMask", 0x00)},
                                    "unpassable"},
                          {0x1F2D, {0x0000}},-- separator
                            -- (transition to solid highground with rock upper right filled)
                          {0x1F2E, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0x20, "edgeMask", 0x10)},
                                    "unpassable"},
                  -- [0x1F30] lower left filled
                            -- (transition to weak highground)
                          {{"range", 0x1F30, 0x1F31}, makeRampToHighGround("weak-ground", 0x30)},
                          {0x1F32, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F33, 0x1F34}, makeRampToHighGround("solid-ground", 0x30)},
                  -- [0x1F40] left half filled
                            -- (transition to weak highground)
                          {{"range", 0x1F40, 0x1F42}, makeRampToHighGround("weak-ground", 0x40)},
                          {0x1F43, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F44, 0x1F46}, makeRampToHighGround("solid-ground", 0x40)},
                  -- [0x1F60] lower right clear
                            -- (transition to weak highground)
                          {0x1F60, makeRampToHighGround("weak-ground", 0x60)},
                          {0x1F61, {0x0000}},-- separator
                            -- (transition to weak highground with weak lowground upper half filled)
                          {0x1F62, {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "weak-ground")},
                                              makeRampToHighGround("weak-ground", 0x60, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1F63, {0x0000}},-- separator
                            -- (transition to weak highground with solid lowground upper half filled)
                          {0x1F64, {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "solid-ground")},
                                              makeRampToHighGround("weak-ground", 0x60, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1F65, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower left filled)
                          {0x1F66, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0x60, "edgeMask", 0x30)},
                                    "unpassable"},
                          {0x1F67, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F68, 0x1F69}, makeRampToHighGround("solid-ground", 0x60)},
                          {0x1F6A, {0x0000}},-- separator
                            -- (transition to solid highground with weak lowground upper half filled)
                          {0x1F6B, {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "weak-ground")},
                                              makeRampToHighGround("solid-ground", 0x60, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1F6C, {0x0000}},-- separator
                            -- (transition to solid highground with solid lowground upper half filled)
                          {0x1F6D, {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "solid-ground")},
                                              makeRampToHighGround("solid-ground", 0x60, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1F6E, {0x0000}},-- separator
                            -- (transition to solid highground with rock lower left filled)
                          {0x1F6F, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0x60, "edgeMask", 0x30)},
                                    "unpassable"},
                  -- [0x1F70] lower right filed
                            -- (transition to weak highground)
                          {{"range", 0x1F70, 0x1F71}, makeRampToHighGround("weak-ground", 0x70)},
                          {0x1F72, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F73, 0x1F74}, makeRampToHighGround("solid-ground", 0x70)},
                  -- [0x1F90] right half filled
                            -- (transition to weak highground)
                          {{"range", 0x1F90, 0x1F92}, makeRampToHighGround("weak-ground", 0x90)},
                          {0x1F93, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1F94, 0x1F96}, makeRampToHighGround("solid-ground", 0x90)},
                  -- [0x1FA0] lower left clear
                            -- (transition to weak highground)
                          {0x1FA0, makeRampToHighGround("weak-ground", 0xA0)},
                          {0x1FA1, {0x0000}},-- separator
                            -- (transition to weak highground with weak lowground upper half filled)
                          {0x1FA2, {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "weak-ground")},
                                              makeRampToHighGround("weak-ground", 0xA0, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1FA3, {0x0000}},-- separator
                            -- (transition to weak highground with solid lowground upper half filled)
                          {0x1FA4, {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "solid-ground")},
                                              makeRampToHighGround("weak-ground", 0xA0, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1FA5, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower right filled)
                          {0x1FA6, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xA0, "edgeMask", 0x70)},
                                    "unpassable"},
                          {0x1FA7, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1FA8, 0x1FA9}, makeRampToHighGround("solid-ground", 0xA0)},
                          {0x1FAA, {0x0000}},-- separator
                            -- (transition to solid highground with weak lowground upper half filled)
                          {0x1FAB, {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "weak-ground")},
                                              makeRampToHighGround("solid-ground", 0xA0, "edgeMask", 0x20)},
                                    "unpassable"},
                            -- (transition to solid highground with solid lowground upper half filled)
                          {0x1FAC, {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0],
                                              {getCliffsTiles(0xB0, "solid-ground")},
                                              makeRampToHighGround("solid-ground", 0xA0, "edgeMask", 0x20)},
                                    "unpassable"},
                          {0x1FAD, {0x0000}},-- separator
                            -- (transition to solid highground with rock lower right filled)
                          {0x1FAE, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xA0, "edgeMask", 0x70)},
                                    "unpassable"},
                  -- [0x1FB0] upper half clear
                            -- (transition to weak highground)
                          {{"range", 0x1FB0, 0x1FB2}, makeRampToHighGround("weak-ground", 0xB0)},
                          {0x1FB3, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower left filled)
                          {0x1FB4, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xB0, "edgeMask", 0x30)},
                                    "unpassable"},
                          {0x1FB5, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower right filled)
                          {0x1FB6, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xB0, "edgeMask", 0x70)},
                                    "unpassable"},
                          {0x1FB7, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1FB8, 0x1FBA}, makeRampToHighGround("solid-ground", 0xB0)},
                          {0x1FBB, {0x0000}},-- separator
                            -- (transition to solid highground with rock lower left filled)
                          {0x1FBC, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xB0, "edgeMask", 0x30)},
                                    "unpassable"},
                          {0x1FBD, {0x0000}},-- separator
                            -- (transition to solid highground with rock lower right filled)
                          {0x1FBE, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xB0, "edgeMask", 0x70)},
                                    "unpassable"},
                  -- [0x1FC0] upper right clear
                            -- (transition to weak highground)
                          {{"range", 0x1FC0,  0x1FC1}, makeRampToHighGround("weak-ground", 0xC0)},
                          {0x1FC2, {0x0000}},-- separator
                            -- (transition to weak highground with rock upper left filled)
                          {0x1FC3, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xC0, "edgeMask", 0x00)},
                                    "unpassable"},
                          {0x1FC4, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower right filled)
                          {0x1FC5, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xC0, "edgeMask", 0x70)},
                                    "unpassable"},
                          {0x1FC6, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1FC7, 0x1FC8}, makeRampToHighGround("solid-ground", 0xC0)},
                          {0x1FC9, {0x0000}},-- separator
                            -- (transition to solid highground with rock upper left filled)
                          {0x1FCA, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xC0, "edgeMask", 0x00)},
                                    "unpassable"},
                          {0x1FCB, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower right filled)
                          {0x1FCC, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xC0, "edgeMask", 0x70)},
                                    "unpassable"},
                  -- [0x1FD0] upper left clear
                            -- (transition to weak highground)
                          {{"range", 0x1FD0,  0x1FD1}, makeRampToHighGround("weak-ground", 0xD0)},
                          {0x1FD2, {0x0000}},-- separator
                            -- (transition to weak highground with rock lower left filled)
                          {0x1FD3, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xD0, "edgeMask", 0x30)},
                                    "unpassable"},
                          {0x1FD4, {0x0000}},-- separator
                            -- (transition to weak highground with rock upper right filled)
                          {0x1FD5, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("weak-ground", 0xD0, "edgeMask", 0x10)},
                                    "unpassable"},
                          {0x1FD6, {0x0000}},-- separator
                            -- (transition to solid highground)
                          {{"range", 0x1FD7, 0x1FD8}, makeRampToHighGround("solid-ground", 0xD0)},
                          {0x1FD9, {0x0000}},-- separator
                            -- (transition to solid highground with rock lower left filled)
                          {0x1FDA, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xD0, "edgeMask", 0x30)},
                                    "unpassable"},
                          {0x1FDB, {0x0000}},-- separator
                            -- (transition to weak highground with rock upper right filled)
                          {0x1FDC, {"layers", {getCliffsTiles("fully-filled")},
                                              makeRampToHighGround("solid-ground", 0xD0, "edgeMask", 0x10)},
                                    "unpassable"}},

                "mixed", {"ramp", "lowgrounds", "land", "no-building",
                         genRampToLowGroundSeq(0x2100, {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0})}
                }
  )

end
