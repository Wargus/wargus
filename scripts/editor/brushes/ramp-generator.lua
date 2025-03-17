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
--     (c) Copyright 2025 by Alyokhin
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


local rampsDirections = {"North", "NorthEast", "SouthEast", "South", "SouthWest", "NorthWest"}
local rampsAssemblyParts = {"complete", "side-1", "middle", "side-2"}

--[[
Each ramp tile is coded as follows:

  'xxxx'
  where first two positions is:
    h + (c, l) -- highground to cliff or lowground
    c + l      -- cliff to lowground
    r + (c, l) -- ramp-side to cliff or lowground
    R + (h, l) -- ramp to highground or lowground
    L + _      -- solid lowground
    R + _      -- solid ramp
    C + _      -- solid cliff

  Third is direction:
    [0..D] or '_' for solid tiles
  
  Fourth is number of tile in the subslot:
    [0..F]
  --]]

local rampsTemplate = {
  ["North"] = {
    ["complete"] = {
      {'0000', 'Rl70', 'RlB0', 'RlB0', 'RlB0', 'Rl30', '0000'},
      {'0000', 'rl9E', 'R__0', 'R__0', 'R__0', 'rl4E', '0000'},
      {'L__4', 'rl96', 'R__0', 'R__0', 'R__0', 'rl46', 'L__4'},
      {'cl70', 'rl98', 'R__0', 'R__0', 'R__0', 'rl48', 'cl30'},
      {'hlBB', 'Rh24', 'Rh20', 'Rh20', 'Rh20', 'Rh26', 'hlBE'}
    },
    ["side-1"] = {
      {'0000', 'Rl70'},
      {'0000', 'rl9E'},
      {'L__4', 'rl96'},
      {'cl70', 'rl98'},
      {'hlBB', 'Rh24'}
    },
    ["middle"] = {
      {'RlB0'},
      {'R__0'},
      {'R__0'},
      {'R__0'},
      {'Rh20'}
    },
    ["side-2"] = {
      {'Rl30', '0000'},
      {'rl4E', '0000'},
      {'rl46', 'L__4'},
      {'rl48', 'cl30'},
      {'Rh26', 'hlBE'}
    }
  },
  ["NorthEast"] = {
    ["complete"] = {
      {'0000', '0000', 'L__4', 'Rl70', 'Rl30', '0000', '0000'},
      {'L__4', 'rl70', 'rlB0', 'rlD0', 'RlC0', 'Rl30', '0000'},
      {'RhA2', 'rlD0', 'R__0', 'R__0', 'R__0', 'Rl40', '0000'},
      {'Rh10', 'RhA0', 'R__0', 'R__0', 'R__0', 'RlC0', 'Rl30'},
      {'0000', 'Rh90', 'R__0', 'R__0', 'rc60', 'rl2B', 'rl0B'},
      {'0000', 'Rh10', 'RhA6', 'rc20', 'rl00', 'cl00', '0000'},
      {'0000', '0000', 'hcC0', 'hl3D', 'cl00', 'L__4', '0000'}
    },
    ["side-1"] = {
      {'0000', '0000', 'L__4', 'Rl70', 'Rl30'},
      {'L__4', 'rl70', 'rlB0', 'rlD0', '0000'},
      {'RhA2', 'rlD0', '0000', '0000', '0000'}
    },
    ["middle"] = {
      {'0000', '0000', '0000', '0000', 'RlC0', 'Rl30'},
      {'0000', '0000', 'R__0', 'R__0', 'R__0', 'Rl40'},
      {'Rh10', 'RhA0', 'R__0', 'R__0', 'R__0', 'RlC0'},
      {'0000', 'Rh92', 'R__0', 'R__0', '0000', '0000'},
      {'0000', 'Rh10', '0000', '0000', '0000', '0000'}
    },
    ["side-2"] = {
      {'0000', '0000', '0000', '0000', 'Rl30'},
      {'0000', '0000', 'rc60', 'rl2B', 'rl0B'},
      {'RhA6', 'rc20', 'rl00', 'cl00', '0000'},
      {'hcC0', 'hl3D', 'cl00', 'L__4', '0000'}
    }
  },
  ["SouthEast"] = {
    ["complete"] = {
      {'0000', '0000', '0000', 'hc60', 'hc20', '0000', '0000'},
      {'0000', '0000', 'Rh70', 'RhD5', 'rc30', 'cl60', '0000'},
      {'0000', 'Rh70', 'RhD0', 'R__0', 'rcC0', 'rl36', 'L__4'},
      {'hc60', 'RhD3', 'R__0', 'R__0', 'R__0', 'rlC0', 'rl30'},
      {'hc00', 'rc10', 'rcA0', 'R__0', 'R__0', 'R__0', 'Rl40'},
      {'cl60', 'cl20', 'rl10', 'rcA0', 'R__0', 'Rl60', 'Rl00'},
      {'cl00', 'L__4', 'cl10', 'rl10', 'Rl20', 'Rl00', '0000'}
    },
    ["side-1"] = {
      {'hc60', 'RhD3', '0000', '0000', '0000'},
      {'hc00', 'rc10', 'rcA0', '0000', '0000'},
      {'cl60', 'cl20', 'rl10', 'rcA0', '0000'},
      {'cl00', 'L__4', 'cl10', 'rl10', 'Rl20'}
    },
    ["middle"] = {
      {'0000', 'Rh70', '0000', '0000', '0000', '0000'},
      {'Rh70', 'RhD0', 'R__0', '0000', '0000', '0000'},
      {'0000', 'R__0', 'R__0', 'R__0', '0000', '0000'},
      {'0000', '0000', 'R__0', 'R__0', 'R__0', '0000'},
      {'0000', '0000', '0000', 'R__0', 'Rl60', 'Rl00'},
      {'0000', '0000', '0000', '0000', 'Rl00', '0000'}
    },
    ["side-2"] = {
      {'hc60', 'hc20', '0000', '0000'},
      {'RhD5', 'rc30', 'cl60', '0000'},
      {'0000', 'rcC0', 'rl36', 'L__4'},
      {'0000', '0000', 'rlC0', 'rl30'},
      {'0000', '0000', '0000', 'Rl40'}
    }
  },
  ["South"] = {
    ["complete"] = {
      {'hc20', 'RhB4', 'RhB0', 'RhB0', 'RhB0', 'RhB6', 'hc20'},
      {'C__0', 'rc90', 'R__0', 'R__0', 'R__0', 'rc40', 'C__0'},
      {'clA0', 'rc92', 'R__0', 'R__0', 'R__0', 'rc40', 'cl60'},
      {'cl10', 'rl9B', 'R__0', 'R__0', 'R__0', 'rl4B', 'cl00'},
      {'L__4', 'rl94', 'R__0', 'R__0', 'R__0', 'rl44', 'L__4'},
      {'0000', 'Rl10', 'Rl20', 'Rl20', 'Rl20', 'Rl00', '0000'}
    },
    ["side-1"] = {
      {'hc20', 'RhB4'},
      {'C__0', 'rc90'},
      {'clA0', 'rc90'},
      {'cl10', 'rl9B'},
      {'L__4', 'rl94'},
      {'0000', 'Rl10'}
    },
    ["middle"] = {
      {'RhB0'},
      {'R__0'},
      {'R__0'},
      {'R__0'},
      {'R__0'},
      {'Rl20'}
    },
    ["side-2"] = {
      {'RhB6', 'hc20'},
      {'rc40', 'C__0'},
      {'rc40', 'cl60'},
      {'rl4B', 'cl00'},
      {'rl44', 'L__4'},
      {'Rl00', '0000'}
    }
  },
  ["SouthWest"] = {
    ["complete"] = {
      {'0000', '0000', 'hc20', 'hcA0', '0000', '0000', '0000'},
      {'0000', 'clA0', 'rc70', 'RhC3', 'Rh30', '0000', '0000'},
      {'L__4', 'rl76', 'rcD0', 'R__0', 'RhC0', 'Rh30', '0000'},
      {'rl70', 'rlD0', 'R__0', 'R__0', 'R__0', 'RhC5', 'hcA0'},
      {'Rl90', 'R__0', 'R__0', 'R__0', 'rc60', 'rc00', 'hc10'},
      {'Rl10', 'RlA0', 'R__0', 'rc60', 'rl00', 'cl20', 'clA0'},
      {'0000', 'Rl10', 'Rl20', 'rl03', 'cl00', 'L__4', 'cl10'}
    },
    ["side-1"] = {
      {'0000', '0000', 'hc20', 'hcA0'},
      {'0000', 'clA0', 'rc70', 'RhC3'},
      {'L__4', 'rl76', 'rcD0', '0000'},
      {'rl70', 'rlD0', '0000', '0000'},
      {'Rl90', '0000', '0000', '0000'}
    },
    ["middle"] = {
      {'0000', '0000', '0000', '0000', 'Rh30', '0000'},
      {'0000', '0000', '0000', 'R__0', 'RhC0', 'Rh30'},
      {'0000', '0000', 'R__0', 'R__0', 'R__0', '0000'},
      {'0000', 'R__0', 'R__0', 'R__0', '0000', '0000'},
      {'Rl10', 'RlA0', 'R__0', '0000', '0000', '0000'},
      {'0000', 'Rl10', '0000', '0000', '0000', '0000'}
    },
    ["side-2"] = {
      {'0000', '0000', '0000', 'RhC5', 'hcA0'},
      {'0000', '0000', 'rc60', 'rc00', 'hc10'},
      {'0000', 'rc60', 'rl00', 'cl20', 'clA0'},
      {'Rl20', 'rl03', 'cl00', 'L__4', 'cl10'},
    }
  },
  ["NorthWest"] = {
    ["complete"] = {
      {'0000', '0000', 'Rl70', 'Rl30', 'L__4', '0000', '0000'},
      {'0000', 'Rl70', 'RlD0', 'rlC0', 'rlB0', 'rl30', 'L__4'},
      {'0000', 'Rl90', 'R__0', 'R__0', 'R__0', 'rlC3', 'Rh62'},
      {'Rl70', 'RlD0', 'R__0', 'R__0', 'R__0', 'Rh60', 'Rh00'},
      {'rl1B', 'rl28', 'rcA0', 'R__0', 'R__0', 'Rh40', '0000'},
      {'0000', 'cl10', 'rl10', 'rc20', 'Rh66', 'Rh00', '0000'},
      {'0000', 'L__4', 'cl10', 'hl7D', 'hcD0', '0000', '0000'}
    },
    ["side-1"] = {
      {'Rl70', 'Rl30', 'L__4', '0000', '0000'},
      {'0000', 'rlC0', 'rlB0', 'rl30', 'L__4'},
      {'0000', '0000', '0000', 'rlC0', 'Rh62'}
    },
    ["middle"] = {
      {'Rl70', 'RlD0', '0000', '0000', '0000', '0000'},
      {'Rl90', 'R__0', 'R__0', 'R__0', '0000', '0000'},
      {'RlD0', 'R__0', 'R__0', 'R__0', 'Rh60', 'Rh00'},
      {'0000', '0000', 'R__0', 'R__0', 'Rh40', '0000'},
      {'0000', '0000', '0000', '0000', 'Rh00', '0000'}
    },
    ["side-2"] = {
      {'Rl70', '0000', '0000', '0000', '0000'},      
      {'rl1B', 'rl28', 'rcA0', '0000', '0000'},
      {'0000', 'cl10', 'rl10', 'rc20', 'Rh66'},
      {'0000', 'L__4', 'cl10', 'hl7D', 'hcD0'}
    }
  }
}

if not TilesetSlotsIdx then
  Load("scripts/tilesets/wargus/layout.lua")
end

local function getCh(src, idx)
  return string.sub(src, idx, idx)
end

local function decodeRampTile(tileCode, highgroundType, lowgroundType)
  --[[
  Each ramp tile is coded as follows:

  'xxxx'
  where first two positions is:
    h + (c, l) -- highground to cliff or lowground
    c + l      -- cliff to lowground
    r + (c, l) -- ramp-side to cliff or lowground
    R + (h, l) -- ramp to highground or lowground
    L + _      -- solid lowground
    R + _      -- solid ramp
    C + _      -- solid cliff

  Third is direction:
    [0..D] or '_' for solid tiles
  
  Fourth is number of tile in the subslot:
    [0..F]

  OR
    '0000' - empty tile
  --]]
  if (tileCode == '0000') then return 0 end

  local dict = {
    [1] = {
            ["h"] = "highground",
            ["c"] = "cliff",
            ["R"] = "ramp",
            ["r"] = "ramp-side",
            ["L"] = "lowground", -- solid
            ["C"] = "cliff" -- solid
          },
    [2] = {
            ["h"] = "highground",
            ["c"] = "cliff",
            ["l"] = "lowground"
          }
  }
  local tileCodeSeq = {}
  for i = 1, tileCode:len() do
    table.insert(tileCodeSeq, getCh(tileCode, i))
  end

  local terrains = {
    ["highground"] = highgroundType,
    ["lowground"] = lowgroundType
  }

  local extendedToBaseTileset = {
    ["weak-lowground"] = "dark-weak-ground",
    ["solid-lowground"] = "dark-solid-ground"
  }

  local terrain1 = dict[1][tileCodeSeq[1]]
  if not terrain1 then return 0 end
  if terrain1 == "lowground" then
    terrain1 = extendedToBaseTileset[terrains[terrain1]] -- solid tile of lowground
  else
    terrain1 = terrains[terrain1] or terrain1
  end

  local terrain2 = dict[2][tileCodeSeq[2]] -- it could be nil
  terrain2 = terrains[terrain2] or terrain2

  local tileType = (terrain1 and terrain2) and "mixed" or "solid"
  
  local dir = tonumber(tileCodeSeq[3], 16)
  if tileType == "mixed" then
    if dir == nil then return 0 end
  else
    dir = 0
  end
  dir = dir * 0x10

  local idx = tonumber(tileCodeSeq[4], 16)
  if idx == nil then return 0 end

    
  --[[
    This is a bit hacky, but these subslots has two types of lowground in the layout
    piece of layout.lua:
    ["ramp"] = {
      ["to-highground"] = {
        ["lower-right-clear"] = {
          ["with-weak-lowground-upper-half-filled"]  = 0x62,
          ["separator-2"]                            = 0x63,
          ["with-solid-lowground-upper-half-filled"] = 0x64,
  ]]--
  if tileCodeSeq[1] == 'R' 
     and  tileCodeSeq[2] == 'h' 
     and (dir == 0x60 or dir == 0xA0) 
     and idx == 2
     and lowgroundType == "solid-lowground" then
    
     idx = idx + 2
  end
  
  local baseSlotIdx = TilesetSlotsIdx:get(terrain1, terrain2)
  return baseSlotIdx + dir + idx
end

local function GenerateRamp(direction, assemblyPart, highgroundType, lowgroundType)

  local result = {}

  for _,row in ipairs(rampsTemplate[direction][assemblyPart]) do
    local decodedRow = {}
    for _,tileCode in ipairs(row) do
      table.insert(decodedRow, decodeRampTile(tileCode, highgroundType, lowgroundType))
    end
    table.insert(result, decodedRow)
  end
  local width = #result[1] or 0
  local height = #result

  return {["width"] = width, ["height"] = height, ["tiles"] = result}
end

local direction = EditorBrush_GetGeneratorOption("direction")
local assemblyPart = EditorBrush_GetGeneratorOption("assembly-part")
local highground = EditorBrush_GetGeneratorOption("highground")
local lowground = EditorBrush_GetGeneratorOption("lowground")

local ramp = GenerateRamp(direction, assemblyPart, highground, lowground)

if ramp then
  EditorBrush_LoadDecorationTiles(ramp)
else
  DebugPrint("Unable to generate ramp.\n")
end