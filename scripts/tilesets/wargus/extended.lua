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
--     (c) Copyright 2023-2025 by Alyokhin
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
        comma separated list of flags which are common for all tiles in this slot

      dst:
        single argument (number or table) at position 1.
        index of defined tile (or set of indexes). Each slot consist of 16 tiles only.
        For extended tileset indexes must be greater than already defined.
        Each slot's indexes set starts from xxx0 and ended with xxxF (where description of xxx see in PUD format explanation)

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
  
  local lowgroundWeakGround   = seed.lowgroundWeakGround
  local lowgroundSolidGround  = seed.lowgroundSolidGround
  local highgroundWeakGround  = seed.highgroundWeakGround
  local highgroundSolidGround = seed.highgroundSolidGround
  local getRampSrcSlot        = seed.getRampSrcSlot
  local getRampSrc            = seed.getRampSrc
  local generators            = seed.generators
  local cliffGen              = generators.cliffs

  local dim     = -1
  local lighten = 1

  local function tableToString(toPrint) -- used for testing purposes

    if type(toPrint) ~= "table" then
        return toPrint
    end

    local result = "{"
    local firstIn = true
    for i,v in ipairs(toPrint) do
        if firstIn == false then
            result = result .. ", "
        end
        firstIn = false
        
        if type(v) == "table" then
            v = tableToString(v)
        elseif type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        result = result .. v
    end
    return result .. "}"
  end

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
  generators.utils.srcTilesLst = getListOfTilesWithoutExceptions

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
  generators.utils.colorsFor = getColors

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
    for i, colorsRange in ipairs(args) do
      local wrkRange
      if type(colorsRange) == "table" then -- a range
        wrkRange = {unpack(colorsRange)} -- make a copy of table
      else -- a single color
        wrkRange = colorsRange
      end
    
      repeat
        local done = false
        local idxFrom = 1
        local idxTo = 2

        local exception = checkForExceptionColor(wrkRange, exceptionPairs, direction)
        if exception ~= nil then

          local shiftDelta = exception[idxTo] - exception[idxFrom];
          if shiftDelta ~= 0 then
            table.insert(result, {"shift", shiftDelta, exception[idxFrom]})
          end

          if type(wrkRange) == "table" then
            if wrkRange[idxFrom] < exception[idxFrom] then
              table.insert(colors, {wrkRange[idxFrom], exception[idxFrom] - 1})
            end
            wrkRange[idxFrom] = exception[idxFrom] + 1
            if (wrkRange[idxTo] < wrkRange[idxFrom] ) then
              done = true
            end
          else
            done = true
          end

        else
          table.insert(colors, wrkRange)
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
  generators.utils.Lighten = Lighten

  local function Dim(colorSet, ...)
    local subSets = {...}
    return shiftBrightness_byStep(dim, colorSet["exceptions"], getColors(colorSet, unpack(subSets)))
  end
  generators.utils.Dim = Dim

  local function multi_insertTo(dstTable, ...)
    local insertValues = {...}
      for i, value in ipairs(insertValues) do
        table.insert(dstTable, value)
      end
  end
  
  local function cleanRocksAndDimShadows(baseTerrain)
    local result = {}
    if cliffGen.cleanRocks ~= nil then
      result = {cliffGen.cleanRocks(getColors, baseTerrain)}
    else
      result = {{"remove", getColors(cliffGen.colors, "remove-toCleanRocks")}}

      if baseTerrain == "weak-ground" then
        multi_insertTo(result, Dim(cliffGen.colors, "shadows-onRocks"))
      else
        for i, range in ipairs(cliffGen.colors["convertable-shadows-onRocks"]) do
          for j, convertedColors in ipairs(convertColors(range["from"], range["to"])) do
            table.insert(result, convertedColors)
          end
        end
        -- shadows are already dimmed in the convertColors()
      end
    end

    return unpack(result)

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

      multi_insertTo(result, cleanRocksAndDimShadows(baseTerrain))
 
    end
    return unpack(result)
  end

  local function makeHighGroundEdge(groundType, slot)
    return generators:makeHighGroundEdge(groundType, slot)
  end

  local function makeRampEdge(slot)
    return srcTilesLst(getRampSrcSlot("for-edges"), (0xD0 - slot)), generators:makeRampEdge()
  end

  local function makeRampToHighGround(groundType, slot, isMask, edgeSlot)
    return generators:makeRampToHighGround(groundType, slot, isMask, edgeSlot)
  end

  local function makeRampToLowGround(groundType, slot)
    return generators:makeRampToLowGround(groundType, slot)
  end

  local function genSolidRampSeq(dstSlot, srcSlot, modifier)

    local layout = {["main"] = {0, 0x2}, ["separator"] = 0x3, ["fillers"] = {0x4, 0xB}}
    local function subslot(slotIdx)
      return {
        ["main"]      = {"range", slotIdx + layout["main"][1], slotIdx + layout["main"][2]},
        ["separator"] = slotIdx + layout["main"][2] + 0x1,
        ["fillers"]   = {"range",  slotIdx + layout["fillers"][1], slotIdx + layout["fillers"][2]}
      }
    end

    local result = {
      {subslot(dstSlot)["main"], {subslot(srcSlot)["main"], modifier}},
      {subslot(dstSlot)["separator"], {0x0000}},
      {subslot(dstSlot)["fillers"], {subslot(srcSlot)["fillers"], modifier}}
    }
    return unpack(result)
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

  local function genUpperLevelToLowGroundSeq(dstSlot, upperLevelType, lowGroundType, genTable)

    local function parse(slotToParse, dstBaseSlot)
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

    for i, slotData in ipairs(genTable) do
      if type(slotData) ~= "table" then break end

      local src
      local dst, slot, cliffs = parse(slotData, dstSlot)
      if slot == nil then
        src = {0x0000} -- separator
      else
        if upperLevelType == "ramp-side" then
          src = {"layers",  cliffGen.baseTilesFor[lowGroundType][slot],
                            {getCliffsTiles(cliffs, lowGroundType)},
                            {makeRampEdge(slot)}}
        else -- highgrounds
          src = {"layers",  cliffGen.baseTilesFor[lowGroundType][slot],
                            {getCliffsTiles(cliffs, lowGroundType)},
                            makeHighGroundEdge(upperLevelType, slot)}
        end
        if cliffs == nil then
          table.remove(src, 3) -- remove {getCliffsTiles(cliffs, lowGroundType)} from src
        end
      end
      table.insert(result, {dst, src})
    end
    return unpack(result)
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

    local dstSlots = TilesetSlotsIdx["subslots-layout"]["highground"]["to-lowground"]
    local genTable = {
      -- 0x00
      {["dst"] = dstSlots["upper-left-filled"]["main"],
       ["src"] = {["cliffs"] = {"pick", 0x40, 0x41}}},

      -- 0x10
      {["dst"] = dstSlots["upper-right-filled"]["main"],
       ["src"] = {["cliffs"] = 0x90}},

      -- 0x30
      {["dst"] = dstSlots["lower-left-filled"]["main"],
       ["src"] = {["cliffs"] = 0x30}},
        --  
      {["dst"] = dstSlots["lower-left-filled"]["separator-1"]},
        --
      {["dst"] = dstSlots["lower-left-filled"]["with-rock-lower-right-clear"],
       ["src"] = {["cliffs"] = 0x60}},
        
      -- 0x40
      {["dst"] = dstSlots["left-half-filled"]["main"],
       ["src"] = {["cliffs"] = {"special", "singleRockUp", "singleRockBot", "removedRock"}}},

      -- 0x70
      {["dst"] = dstSlots["lower-right-filled"]["main"],
       ["src"] = {["cliffs"] = 0x70}},
        --  
      {["dst"] = dstSlots["lower-right-filled"]["separator-1"]},
        --
      {["dst"] = dstSlots["lower-right-filled"]["with-rock-lower-left-clear"],
       ["src"] = {["cliffs"] = 0xA0}},
        
      -- 0x90
      {["dst"] = dstSlots["right-half-filled"]["main"],
       ["src"] = {["cliffs"] = {"special", "singleRockMid", "singleRockBot", "removedRock"}}},
        
      -- 0xB0
      {["dst"] = dstSlots["upper-half-clear"]["with-rock-lower-half-filled"],
       ["src"] = {["cliffs"] = 0xB0}},
        --
      {["dst"] = dstSlots["upper-half-clear"]["separator-1"]},
        --
      {["dst"] = dstSlots["upper-half-clear"]["with-rock-lower-left-filled"],
       ["src"] = {["cliffs"] = 0x90}},
        --
      {["dst"] = dstSlots["upper-half-clear"]["separator-2"]},
        --
      {["dst"] = dstSlots["upper-half-clear"]["with-rock-lower-right-filled"],
       ["src"] = {["cliffs"] = 0x70}},
        --
      {["dst"] = dstSlots["upper-half-clear"]["separator-3"]},
        --
      {["dst"] = dstSlots["upper-half-clear"]["with-rock-upper-left-clear"],
       ["src"] = {["cliffs"] = 0xD0}},
        --
      {["dst"] = dstSlots["upper-half-clear"]["separator-4"]},
        --
      {["dst"] = dstSlots["upper-half-clear"]["with-rock-upper-right-clear"],
       ["src"] = {["cliffs"] = 0xC0}},

      -- 0xC0
      {["dst"] = dstSlots["upper-right-clear"]["main"],
       ["src"] = {["cliffs"] = 0xB0}},
        --
      {["dst"] = dstSlots["upper-right-clear"]["separator-1"]},
        --
      {["dst"] = dstSlots["upper-right-clear"]["with-rock-upper-right-clear"],
       ["src"] = {["cliffs"] = 0xC0}},
        --
      {["dst"] = dstSlots["upper-right-clear"]["separator-2"]},
        --
      {["dst"] = dstSlots["upper-right-clear"]["without-rock"],
       ["src"] = {}},
        
      -- 0xD0
      {["dst"] = dstSlots["upper-left-clear"]["main"],
       ["src"] = {["cliffs"] = 0xB0}},
        --
      {["dst"] = dstSlots["upper-left-clear"]["separator-1"]},
        --
      {["dst"] = dstSlots["upper-left-clear"]["with-rock-upper-left-clear"],
       ["src"] = {["cliffs"] = 0xD0}},
        --
      {["dst"] = dstSlots["upper-left-clear"]["separator-2"]},
        --
      {["dst"] = dstSlots["upper-left-clear"]["without-rock"],
       ["src"] = {}},
    }
    return genUpperLevelToLowGroundSeq(dstSlot, highGroundType, lowGroundType, genTable)
  end

  local function genRampSideToLowGroundSeq(dstSlot, lowGroundType)
  --[[
      This generates sequence of {dstRange, srcRange} where:

      {dstRange, {"layers", cliffGen.baseTilesFor[lowGroundType][slot],
                            {getCliffsTiles(cliffs, lowGroundType)},
                            {makeRampEdge(0x00)}}},
      Or
      {dstRange, {"layers", cliffGen.baseTilesFor[lowGroundType][slot],
                            {makeRampEdge(0x00)}}},
      Or
      {dstRange, {0x0000}}
  --]]
    local dstSlots = TilesetSlotsIdx["subslots-layout"]["ramp-side"]["to-lowground"]
    local genTable = {
      -- 0x00
      {["dst"] = dstSlots["upper-left-filled"]["with-rock-lower-right-clear"],
       ["src"] = {["cliffs"] = 0x60}},
        --
      {["dst"] = dstSlots["upper-left-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-left-filled"]["with-rock-upper-right-filled"],
       ["src"] = {["cliffs"] = 0x10}},
        --
      {["dst"] = dstSlots["upper-left-filled"]["separator-2"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-left-filled"]["without-rock"],
       ["src"] = {}},

      -- 0x10
      {["dst"] = dstSlots["upper-right-filled"]["with-rock-lower-left-clear"],
       ["src"] = {["cliffs"] = 0xA0}},
        --
      {["dst"] = dstSlots["upper-right-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-right-filled"]["with-rock-upper-left-filled"],
       ["src"] = {["cliffs"] = 0x00}},
        --
      {["dst"] = dstSlots["upper-right-filled"]["separator-2"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-right-filled"]["without-rock"],
       ["src"] = {}},

      -- 0x20
      {["dst"] = dstSlots["upper-half-filled"]["with-rock-upper-half-filled"],
       ["src"] = {["cliffs"] = 0x20}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["with-rock-upper-left-filled"],
       ["src"] = {["cliffs"] = 0x00}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["separator-2"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["with-rock-upper-right-filled"],
       ["src"] = {["cliffs"] = 0x10}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["separator-3"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["with-rock-lower-right-filled"],
       ["src"] = {["cliffs"] = 0x70}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["separator-4"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["with-rock-lower-left-filled"],
       ["src"] = {["cliffs"] = 0x30}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["separator-5"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-half-filled"]["without-rock"],
       ["src"] = {}},

      -- 0x30
      {["dst"] = dstSlots["lower-left-filled"]["with-rock-lower-left-filled"],
       ["src"] = {["cliffs"] = 0x30}},
        --
      {["dst"] = dstSlots["lower-left-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["lower-left-filled"]["with-rock-upper-left-filled"],
       ["src"] = {["cliffs"] = 0x00}},
        --
      {["dst"] = dstSlots["lower-left-filled"]["separator-2"], {0x0000}},
        --
      {["dst"] = dstSlots["lower-left-filled"]["without-rock"],
       ["src"] = {}},

      -- 0x40
      {["dst"] = dstSlots["left-half-filled"]["with-rock-left-half-filled"],
       ["src"] = {["cliffs"] = {"pick", 0x40, 0x41}}},
        --
      {["dst"] = dstSlots["left-half-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["left-half-filled"]["with-rock-upper-center-filled"],
       ["src"] = {["cliffs"] = {"special", "singleRockBot"}}},
        --
      {["dst"] = dstSlots["left-half-filled"]["separator-2"], {0x0000}},
        --
      {["dst"] = dstSlots["left-half-filled"]["with-rock-lower-center-filled"],
       ["src"] = {["cliffs"] = {"special", "singleRockUp"}}},
        --
      {["dst"] = dstSlots["left-half-filled"]["separator-3"], {0x0000}},
        --
      {["dst"] = dstSlots["left-half-filled"]["with-rock-upper-right-clear"],
       ["src"] = {["cliffs"] = {"pick", 0xC0}}},
        --
      {["dst"] = dstSlots["left-half-filled"]["separator-4"], {0x0000}},
        --
      {["dst"] = dstSlots["left-half-filled"]["with-rock-lower-right-clear"],
       ["src"] = {["cliffs"] = {"pick", 0x60}}},
        --
      {["dst"] = dstSlots["left-half-filled"]["separator-5"], {0x0000}},
        --
      {["dst"] = dstSlots["left-half-filled"]["without-rock"],
       ["src"] = {["cliffs"] = {"special", "removedRock"}}},

      -- 0x60
      {["dst"] = dstSlots["lower-right-clear"]["with-rock-lower-right-clear"],
       ["src"] = {["cliffs"] = {"pick", 0x60}}},
        --
      {["dst"] = dstSlots["lower-right-clear"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["lower-right-clear"]["without-rock"],
       ["src"] = {}},

      -- 0x70
      {["dst"] = dstSlots["lower-right-filled"]["with-rock-lower-right-filled"],
       ["src"] = {["cliffs"] = 0x70}},
        --
      {["dst"] = dstSlots["lower-right-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["lower-right-filled"]["with-rock-upper-right-filled"],
       ["src"] = {["cliffs"] = 0x10}},
        --
      {["dst"] = dstSlots["lower-right-filled"]["separator-2"], {0x0000}},
        --
      {["dst"] = dstSlots["lower-right-filled"]["without-rock"],
       ["src"] = {}},

      -- 0x90
      {["dst"] = dstSlots["right-half-filled"]["with-rock-right-half-filled"],
       ["src"] = {["cliffs"] = 0x90}},
        --
      {["dst"] = dstSlots["right-half-filled"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["right-half-filled"]["with-rock-upper-center-filled"],
       ["src"] = {["cliffs"] = {"special", "singleRockBot"}}},
        --
      {["dst"] = dstSlots["right-half-filled"]["separator-2"], {0x0005}},
        --
      {["dst"] = dstSlots["right-half-filled"]["with-rock-lower-center-filled"],
       ["src"] = {["cliffs"] = {"pick", 0x71}}},
        --
      {["dst"] = dstSlots["right-half-filled"]["separator-3"], {0x0000}},
        --
      {["dst"] = dstSlots["right-half-filled"]["with-rock-upper-left-clear"],
       ["src"] = {["cliffs"] = {"pick", 0xD0}}},
        --
      {["dst"] = dstSlots["right-half-filled"]["separator-4"], {0x0000}},
        --
      {["dst"] = dstSlots["right-half-filled"]["with-rock-lower-left-clear"],
       ["src"] = {["cliffs"] = {"pick", 0xA0}}},
        --
      {["dst"] = dstSlots["right-half-filled"]["separator-5"], {0x0000}},
        --
      {["dst"] = dstSlots["right-half-filled"]["without-rock"],
       ["src"] = {}},

      -- 0xA0
      {["dst"] = dstSlots["lower-left-clear"]["with-rock-lower-left-clear"],
       ["src"] = {["cliffs"] = {"pick", 0xA0}}},
        --
      {["dst"] = dstSlots["lower-left-clear"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["lower-left-clear"]["without-rock"],
       ["src"] = {}},

      -- 0xB0
      {["dst"] = dstSlots["upper-half-clear"]["with-rock"],
       ["src"] = {["cliffs"] = 0xB0}},
      
      -- 0xC0
      {["dst"] = dstSlots["upper-right-clear"]["with-rocks"],
       ["src"] = {["cliffs"] = 0xB0}},
        --
      {["dst"] = dstSlots["upper-right-clear"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-right-clear"]["without-rock"],
       ["src"] = {}},

      -- 0xD0
      {["dst"] = dstSlots["upper-left-clear"]["with-rocks"],
       ["src"] = {["cliffs"] = 0xB0}},
        --
      {["dst"] = dstSlots["upper-left-clear"]["separator-1"], {0x0000}},
        --
      {["dst"] = dstSlots["upper-left-clear"]["without-rock"],
       ["src"] = {}}
    }
    
    return genUpperLevelToLowGroundSeq(dstSlot, "ramp-side", lowGroundType, genTable)
  end

  local function genRampToHighGroundSeq(dstSlot, highgroundType)
    local function parseDst(subslotToParse, dstBaseSlot)
      local dst = {}
      local slot
      if type(subslotToParse) == "table" then
        if #subslotToParse == 1 then
          dst = {"slot", dstBaseSlot + subslotToParse[1]}
        else
          dst = {"range", dstBaseSlot + subslotToParse[1], dstBaseSlot + subslotToParse[2]}
        end
        slot = bitAND(subslotToParse[1], 0xF0)
      elseif type(subslotToParse) == "number" then
        dst = {dstBaseSlot + subslotToParse}
        slot = bitAND(subslotToParse, 0xF0)
      end
      return dst
    end


    local dst = TilesetSlotsIdx["subslots-layout"]["ramp"]["to-highground"]
    
    local result = {
      -- 0x00 upper left filled
      {parseDst(dst["upper-left-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x00)},
      -- 0x10 upper right filled
      {parseDst(dst["upper-right-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x10)},
      -- 0x20 upper half filled
      {parseDst(dst["upper-half-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x20)},
      {parseDst(dst["upper-half-filled"]["separator-1"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-half-filled"]["with-rock-upper-left-filled"], dstSlot), 
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0x20, "edgeMask", 0x00)}, "unpassable"},
      {parseDst(dst["upper-half-filled"]["separator-2"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-half-filled"]["with-rock-upper-right-filled"], dstSlot), 
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0x20, "edgeMask", 0x10)}, "unpassable"},
      -- 0x30 lower left filled
      {parseDst(dst["lower-left-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x30)},
      -- 0x40 left half filled
      {parseDst(dst["left-half-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x40)},
      -- 0x60 lower right clear
      {parseDst(dst["lower-right-clear"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x60)},
      {parseDst(dst["lower-right-clear"]["separator-1"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["lower-right-clear"]["with-weak-lowground-upper-half-filled"], dstSlot), 
          {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0],
                      {getCliffsTiles(0xB0, "weak-ground")},
                      makeRampToHighGround(highgroundType, 0x60, "edgeMask", 0x20)}, "unpassable"},
      {parseDst(dst["lower-right-clear"]["separator-2"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["lower-right-clear"]["with-solid-lowground-upper-half-filled"], dstSlot), 
          {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0],
                    {getCliffsTiles(0xB0, "solid-ground")},
                    makeRampToHighGround(highgroundType, 0x60, "edgeMask", 0x20)}, "unpassable"},
      {parseDst(dst["lower-right-clear"]["separator-3"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["lower-right-clear"]["with-rock-lower-left-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0x60, "edgeMask", 0x30)}, "unpassable"},
      -- 0x70 lower right filed
      {parseDst(dst["lower-right-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x70)},
      -- 0x90 right half filled
      {parseDst(dst["right-half-filled"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0x90)},
      -- 0xA0 lower left clear
      {parseDst(dst["lower-left-clear"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0xA0)},
      {parseDst(dst["lower-left-clear"]["separator-1"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["lower-left-clear"]["with-weak-lowground-upper-half-filled"], dstSlot),
          {"layers", cliffGen.baseTilesFor["weak-ground"][0xB0],
                    {getCliffsTiles(0xB0, "weak-ground")},
                    makeRampToHighGround(highgroundType, 0xA0, "edgeMask", 0x20)}, "unpassable"},
      {parseDst(dst["lower-left-clear"]["separator-2"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["lower-left-clear"]["with-solid-lowground-upper-half-filled"], dstSlot),
          {"layers", cliffGen.baseTilesFor["solid-ground"][0xB0],
                    {getCliffsTiles(0xB0, "solid-ground")},
                    makeRampToHighGround(highgroundType, 0xA0, "edgeMask", 0x20)}, "unpassable"},
      {parseDst(dst["lower-left-clear"]["separator-3"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["lower-left-clear"]["with-rock-lower-right-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xA0, "edgeMask", 0x70)}, "unpassable"},
      -- 0xB0 upper half clear
      {parseDst(dst["upper-half-clear"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0xB0)},
      {parseDst(dst["upper-half-clear"]["separator-1"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-half-clear"]["with-rock-lower-left-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xB0, "edgeMask", 0x30)}, "unpassable"},
      {parseDst(dst["upper-half-clear"]["separator-2"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-half-clear"]["with-rock-lower-right-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xB0, "edgeMask", 0x70)}, "unpassable"},
      -- 0xC0 upper right clear
      {parseDst(dst["upper-right-clear"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0xC0)},
      {parseDst(dst["upper-right-clear"]["separator-1"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-right-clear"]["with-rock-upper-left-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xC0, "edgeMask", 0x00)}, "unpassable"},
      {parseDst(dst["upper-right-clear"]["separator-2"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-right-clear"]["with-rock-lower-right-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xC0, "edgeMask", 0x70)}, "unpassable"},
      -- 0xD0 upper left clear
      {parseDst(dst["upper-left-clear"]["main"], dstSlot), makeRampToHighGround(highgroundType, 0xD0)},
      {parseDst(dst["upper-left-clear"]["separator-1"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-left-clear"]["with-rock-lower-left-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xD0, "edgeMask", 0x30)}, "unpassable"},
      {parseDst(dst["upper-left-clear"]["separator-2"], dstSlot), {0x0000}},-- separator
      {parseDst(dst["upper-left-clear"]["with-rock-upper-right-filled"], dstSlot),
          {"layers", {getCliffsTiles("fully-filled")},
                      makeRampToHighGround(highgroundType, 0xD0, "edgeMask", 0x10)}, "unpassable"}
    }
    return unpack(result)
  end

  local function genRampToLowGroundSeq(dstSlot, lowgroundType, subSlots)
    local result = {}
    for i, slot in ipairs(subSlots) do

      local rangeWidth = 2
      if slot == 0x20 or slot == 0x40 or slot == 0x90 or slot == 0xB0 then 
        rangeWidth = 3
      end
                                     
      local rngBeg = dstSlot + slot
      local rngEnd = rngBeg + rangeWidth - 1
      -- (transition to weak lowground)
      table.insert(result, {{"range", rngBeg, rngEnd}, makeRampToLowGround(lowgroundType, slot)})
    end
    return unpack(result)
  end
 
  local function dst(base, mixed)
    return TilesetSlotsIdx:get(base, mixed)
  end

  GenerateExtendedTileset(
  --  "image", "",
    "slots",  {
                "solid", {"cliff", "land", "unpassable", "no-building",
                          {{"slot", dst("cliff")},
                            {getCliffsTiles("fully-filled")}}},

                "solid", {"ramp", "land", "no-building",
                          genSolidRampSeq(dst("ramp"),
                                          getRampSrcSlot(),
                                          Lighten(getRampSrc(), "base", "shadows"))},
                                         
                "mixed", {"cliff", lowgroundWeakGround, "land", "unpassable", "no-building",
                          genDstSrcSeq(dst("cliff", "weak-lowground"),
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", cliffGen.baseTilesFor["weak-ground"][slot],
                                                                         {getCliffsTiles(slot, "weak-ground")}}
                                       end)},

                "mixed", {"cliff", lowgroundSolidGround, "land", "unpassable", "no-building",
                          genDstSrcSeq(dst("cliff", "solid-lowground"),
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", cliffGen.baseTilesFor["solid-ground"][slot],
                                                                         {getCliffsTiles(slot, "solid-ground")}}
                                       end)},

                "mixed", {highgroundWeakGround, "cliff", "land", "unpassable", "no-building",
                          genDstSrcSeq(dst("weak-highground", "cliff"),
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", {getCliffsTiles("fully-filled")},
                                                                         makeHighGroundEdge("weak-ground", slot)}
                                       end)},

                "mixed", {highgroundSolidGround, "cliff", "land", "unpassable", "no-building",
                          genDstSrcSeq(dst("solid-highground", "cliff"),
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", {getCliffsTiles("fully-filled")},
                                                                         makeHighGroundEdge("solid-ground", slot)}
                                       end)},

                "mixed", {highgroundWeakGround, lowgroundWeakGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(dst("weak-highground", "weak-lowground"),
                                                "weak-ground",
                                                "weak-ground")},

                "mixed", {highgroundWeakGround, lowgroundSolidGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(dst("weak-highground", "solid-lowground"),
                                                "weak-ground",
                                                "solid-ground")},

                "mixed", {highgroundSolidGround, lowgroundWeakGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(dst("solid-highground", "weak-lowground"),
                                                "solid-ground",
                                                "weak-ground")},

                "mixed", {highgroundSolidGround, lowgroundSolidGround, "land", "unpassable", "no-building",
                          genHighToLowGroundSeq(dst("solid-highground", "solid-lowground"),
                                                "solid-ground",
                                                "solid-ground")},

                "mixed", {"ramp-side", "cliff", "land", "unpassable", "no-building",
                          genDstSrcSeq(dst("ramp-side", "cliff"),
                                       {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0},
                                       function (slot) return {"layers", {getCliffsTiles("fully-filled")},
                                                                         {makeRampEdge(slot)}}
                                       end)},

                "mixed", {"ramp-side", lowgroundWeakGround, "land", "unpassable", "no-building",
                          genRampSideToLowGroundSeq(dst("ramp-side", "weak-lowground"),"weak-ground")},

                "mixed", {"ramp-side", lowgroundSolidGround, "land", "unpassable", "no-building",
                          genRampSideToLowGroundSeq(dst("ramp-side", "solid-lowground"),"solid-ground")},

                "mixed", {"ramp", highgroundWeakGround, "land", "no-building",
                          genRampToHighGroundSeq(dst("ramp", "weak-highground"), "weak-ground")},

                "mixed", {"ramp", highgroundSolidGround, "land", "no-building",
                          genRampToHighGroundSeq(dst("ramp", "solid-highground"), "solid-ground")},

                "mixed", {"ramp", lowgroundWeakGround, "land", "no-building",
                         genRampToLowGroundSeq(dst("ramp", "weak-lowground"),
                                               "weak-ground",
                                               {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0})},

                "mixed", {"ramp", lowgroundSolidGround, "land", "no-building",
                         genRampToLowGroundSeq(dst("ramp", "solid-lowground"),
                                               "solid-ground",
                                               {0x00, 0x10, 0x20, 0x30, 0x40, 0x60, 0x70, 0x90, 0xA0, 0xB0, 0xC0, 0xD0})}
                }
  )
end
