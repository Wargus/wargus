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
--      layout.lua - Layout of tileset slots
--
--     (c) Copyright 2024 by Alyokhin
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
@FIXME: adjust to the actual indexes

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

boundary tiles

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

boundary tiles

11..            cliff and dark weak lowground
12..            cliff and dark solid lowground
13..            cliff and water lowground
14..            weak highground and cliff
15..            solid highground and cliff
16..            weak highground and dark weak lowground
17..            weak highground and dark solid lowground
18..            weak highground and light water lowground  -- FIXME: not implemented yet
19..            solid highground and dark weak lowground
1A..            solid highground and dark solid lowground
1B..            solid highground and light water lowground -- FIXME: not implemented yet
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
local TilesetSubslotsLayout = {}

TilesetSlotsIdx = {
  ["solid"] = {
    ["light-water"]         = 0x0010,
    ["dark-water"]          = 0x0020,
    ["light-weak-ground"]   = 0x0030,
    ["dark-weak-ground"]    = 0x0040,
    ["light-solid-ground"]  = 0x0050,
    ["dark-solid-ground"]   = 0x0060,
    ["forest"]              = 0x0070,
    ["rocks"]               = 0x0080,
    ["human-wall-open"]     = 0x0090,
    ["orc-wall-open"]       = 0x00A0,
    ["human-wall-closed"]   = 0x00B0,
    ["orc-wall-closed"]     = 0x00C0,
    -- extended:
    ["cliff"]               = 0x1010, -- FIXME: check if it possible to swich on 0x00D0
    ["ramp"]                = 0x1020  -- FIXME: check if it possible to swich on 0x00E0
  },
  ["mixed"] = {
    ["dark-water"]        = { ["light-water"]        = 0x0100 },
    ["light-water"]       = { ["light-weak-ground"]  = 0x0200 },
    ["dark-weak-ground"]  = { ["light-weak-ground"]  = 0x0300 },
    ["rocks"]             = { ["light-weak-ground"]  = 0x0400 },
    ["light-weak-ground"] = { ["dark-solid-ground"]  = 0x0500 },
    ["dark-solid-ground"] = { ["light-solid-ground"] = 0x0600 },
    ["forest"]            = { ["light-solid-ground"] = 0x0700 },
    ["human-wall"]        = { ["dark-solid-ground"]  = 0x0800 }, -- FIXME: check if it's really DARK
    ["orc-wall"]          = { ["dark-solid-ground"]  = 0x0900 }, -- FIXME: check if it's really DARK
    -- extended:
    ["cliff"]             = { ["weak-lowground"]     = 0x1100,
                              ["solid-lowground"]    = 0x1200 },
    ["weak-highground"]   = { ["cliff"]              = 0x1400,
                              ["weak-lowground"]     = {0x1600,
                                                        ["subslots"] = {}},
                              ["solid-lowground"]    = {0x1700,
                                                        ["subslots"] = {}} },
    ["solid-highground"]  = { ["cliff"]              = 0x1500,
                              ["weak-lowground"]     = {0x1900,
                                                        ["subslots"] = {}},
                              ["solid-lowground"]    = {0x1A00,
                                                        ["subslots"] = {}} },
    ["ramp-side"]         = { ["cliff"]              = 0x1C00,
                              ["weak-lowground"]     = {0x1D00,
                                                        ["subslots"] = {}},
                              ["solid-lowground"]    = {0x1E00,
                                                        ["subslots"] = {}} },
    ["ramp"]              = { ["highgrounds"]        = 0x1F00,  -- FIXME: separate highgrounds
                              ["weak-highground"]    = {0x1F00,
                                                        ["subslots"] = {}},
                              ["solid-highground"]   = {0x1F00,
                                                        ["subslots"] = {}},
                              ["lowgrounds"]         = 0x2100 }  -- FIXME: separate lowgrounds
  },
  ["subslots-layout"] = TilesetSubslotsLayout
}

TilesetSubslotsLayout = {
  --[[
    slot format:
      0x[dir][x]
      where:
        [x]   is postion of a tile in the slot
        [dir] is direction:
        filled  clear
          0x      Dx      upper left
          1x      Cx      upper right
          2x      Bx      upper half
          3x      Ax      lower left
          4x      9x      left half
          7x      6x      lower right
          8x      5x      upper left, lower right

      = {0x}      - whole slot (0..F)
      = {0x, 0x}  - range
      = 0x        - single index
  ]]--
  ["highground"] = { 
      ["to-lowground"] = {  ["upper-left-filled"] = { -- 0x00
                                                      ["main"]                          = {0x00}
                                                    },
                            ["upper-right-filled"] = { -- 0x10
                                                      ["main"]                          = {0x10}
                                                    },
                            ["lower-left-filled"] = { -- 0x30
                                                      ["main"]                          = {0x30, 0x3B},
                                                      ["separator-1"]                   = 0x3C,
                                                      ["with-rock-lower-right-clear"]   = {0x3D, 0x3F}
                                                    },
                            ["left-half-filled"]  = { -- 0x40
                                                      ["main"]                          = {0x40},
                                                    },
                            ["lower-right-filled"] = { -- 0x70
                                                      ["main"]                          = {0x70, 0x7B},
                                                      ["separator-1"]                   = 0x7C,
                                                      ["with-rock-lower-left-clear"]    = {0x7D, 0x7F}
                                                    },
                            ["right-half-filled"] = { -- 0x90
                                                      ["main"]                          = {0x90},
                                                    },
                            ["upper-half-clear"]  = { -- 0xB0
                                                      ["with-rock-lower-half-filled"]   = {0xB0, 0xB3},
                                                      ["separator-1"]                   = 0xB4,
                                                      ["with-rock-lower-left-filled"]   = {0xB5, 0xB6},
                                                      ["separator-2"]                   = 0xB7,
                                                      ["with-rock-lower-right-filled"]  = {0xB8, 0xB9},
                                                      ["separator-3"]                   = 0xBA,
                                                      ["with-rock-upper-left-clear"]    = {0xBB, 0xBC},
                                                      ["separator-4"]                   = 0xBD,
                                                      ["with-rock-upper-right-clear"]   = {0xBE, 0xBF}
                                                    },
                            ["upper-right-clear"] = { -- 0xC0
                                                      ["main"]                          = {0xC0, 0xC3},
                                                      ["separator-1"]                   = 0xC4,
                                                      ["with-rock-upper-right-clear"]   = {0xC5, 0xC6},
                                                      ["separator-2"]                   = 0xC7,
                                                      ["without-rock"]                  = {0xC8, 0xC9}
                                                    },
                            ["upper-left-clear"] =  { -- 0xD0
                                                      ["main"]                          = {0xD0, 0xD3},
                                                      ["separator-1"]                   = 0xD4,
                                                      ["with-rock-upper-left-clear"]    = {0xD5, 0xD6},
                                                      ["separator-2"]                   = 0xD7,
                                                      ["without-rock"]                  = {0xD8, 0xD9}
                                                    }}
  },
  ["ramp-side"] = { 
      ["to-lowground"] = {  ["upper-left-filled"] = { -- 0x00
                                                      ["with-rock-lower-right-clear"]   = {0x00, 0x01},
                                                      ["separator-1"]                   = 0x02,
                                                      ["with-rock-upper-right-filled"]  = {0x03, 0x09},
                                                      ["separator-2"]                   = 0x0A,
                                                      ["without-rock"]                  = {0x0B, 0x0F}
                                                    },
                            ["upper-right-filled"] = { -- 0x10
                                                      ["with-rock-lower-left-clear"]    = {0x10, 0x11},
                                                      ["separator-1"]                   = 0x12,
                                                      ["with-rock-upper-left-filled"]   = {0x13, 0x19},
                                                      ["separator-2"]                   = 0x1A,
                                                      ["without-rock"]                  = {0x1B, 0x1F}
                                                    },
                            ["upper-half-filled"] = { -- 0x20
                                                      ["with-rock-upper-half-filled"]   = {0x20, 0x22},
                                                      ["separator-1"]                   = 0x23,
                                                      ["with-rock-upper-left-filled"]   = 0x24,
                                                      ["separator-2"]                   = 0x25,
                                                      ["with-rock-upper-right-filled"]  = 0x26,
                                                      ["separator-3"]                   = 0x27,
                                                      ["with-rock-lower-right-filled"]  = {0x28, 0x29},
                                                      ["separator-4"]                   = 0x2A,
                                                      ["with-rock-lower-left-filled"]   = {0x2B, 0x2C},
                                                      ["separator-5"]                   = 0x2D,
                                                      ["without-rock"]                  = {0x2E, 0x2F}
                                                    },
                            ["lower-left-filled"] = { -- 0x30
                                                      ["with-rock-lower-left-filled"]   = {0x30, 0x34},
                                                      ["separator-1"]                   = 0x35,
                                                      ["with-rock-upper-left-filled"]   = {0x36, 0x39},
                                                      ["separator-2"]                   = 0x3A,
                                                      ["without-rock"]                  = {0x3B, 0x3F}
                                                    },
                            ["left-half-filled"]  = { -- 0x40
                                                      ["with-rock-left-half-filled"]    = {0x40, 0x42},
                                                      ["separator-1"]                   = 0x43,
                                                      ["with-rock-upper-center-filled"] = 0x44,
                                                      ["separator-2"]                   = 0x45,
                                                      ["with-rock-lower-center-filled"] = 0x46,
                                                      ["separator-3"]                   = 0x47,
                                                      ["with-rock-upper-right-clear"]   = {0x48, 0x49},
                                                      ["separator-4"]                   = 0x4A,
                                                      ["with-rock-lower-right-clear"]   = {0x4B, 0x4C},
                                                      ["separator-5"]                   = 0x4D,
                                                      ["without-rock"]                  = {0x4E, 0x4F}
                                                    },
                            ["lower-right-clear"] = { -- 0x60
                                                      ["with-rock-lower-right-clear"]   = {0x60, 0x61},
                                                      ["separator-1"]                   = 0x62,
                                                      ["without-rock"]                  = {0x63, 0x64}
                                                    },
                            ["lower-right-filled"] = { -- 0x70
                                                      ["with-rock-lower-right-filled"]  = {0x70, 0x74},
                                                      ["separator-1"]                   = 0x75,
                                                      ["with-rock-upper-right-filled"]  = {0x76, 0x79},
                                                      ["separator-2"]                   = 0x7A,
                                                      ["without-rock"]                  = {0x7B, 0x7F}
                                                    },
                            ["right-half-filled"] = { -- 0x90
                                                      ["with-rock-right-half-filled"]   = {0x90, 0x92},
                                                      ["separator-1"]                   = 0x93,
                                                      ["with-rock-upper-center-filled"] = 0x94,
                                                      ["separator-2"]                   = 0x95,
                                                      ["with-rock-lower-center-filled"] = 0x96,
                                                      ["separator-3"]                   = 0x97,
                                                      ["with-rock-upper-left-clear"]    = {0x98, 0x99},
                                                      ["separator-4"]                   = 0x9A,
                                                      ["with-rock-lower-left-clear"]    = {0x9B, 0x9C},
                                                      ["separator-5"]                   = 0x9D,
                                                      ["without-rock"]                  = {0x9E, 0x9F}
                                                    },
                            ["lower-left-clear"]  = { -- 0xA0
                                                      ["with-rock-lower-left-clear"]    = {0xA0, 0xA1},
                                                      ["separator-1"]                   = 0xA2,
                                                      ["without-rock"]                  = {0xA3, 0xA4}
                                                    },
                            ["upper-half-clear"]  = { -- 0xB0
                                                      ["with-rock"]                     = {0xB0}
                                                    },
                            ["upper-right-clear"] = { -- 0xC0
                                                      ["with-rocks"]                    = {0xC0, 0xC3},
                                                      ["separator-1"]                   = 0xC4,
                                                      ["without-rock"]                  = {0xC5, 0xC6}
                                                    },
                            ["upper-left-clear"]  = { -- 0xD0
                                                      ["with-rocks"]                    = {0xD0, 0xD3},
                                                      ["separator-1"]                   = 0xD4,
                                                      ["without-rock"]                  = {0xD5, 0xD6}
                                                    }}
  },
  ["ramp"] = {
      ["to-highground"] = { ["upper-left-filled"] = { -- 0x00
                                                      ["main"]                          = {0x00, 0x01}
                                                    },
                            ["upper-right-filled"] = { -- 0x10
                                                      ["main"]                          = {0x10, 0x11}
                                                    },
                            ["upper-half-filled"] = { -- 0x20
                                                      ["main"]                          = {0x20, 0x22},
                                                      ["separator-1"]                   = 0x23,
                                                      ["with-rock-upper-left-filled"]   = 0x24,
                                                      ["separator-2"]                   = 0x25,
                                                      ["with-rock-upper-right-filled"]  = 0x26
                                                    },
                            ["lower-left-filled"] = { -- 0x30
                                                      ["main"]                          = {0x30, 0x31},
                                                    },
                            ["left-half-filled"]  = { -- 0x40
                                                      ["main"]                          = {0x40, 0x42},
                                                    },
                            ["lower-right-clear"] = { -- 0x60
                                                      ["main"]                          = 0x60,
                                                      ["separator-1"]                   = 0x61,
                                                      ["with-weak-lowground-upper-half-filled"]  = 0x62,
                                                      ["separator-2"]                   = 0x63,
                                                      ["with-solid-lowground-upper-half-filled"] = 0x64,
                                                      ["separator-3"]                   = 0x65,
                                                      ["with-rock-lower-left-filled"]   = 0x66
                                                    },
                            ["lower-right-filled"] = { -- 0x70
                                                      ["main"]                          = {0x70, 0x71},
                                                    },
                            ["right-half-filled"] = { -- 0x90
                                                      ["main"]                          = {0x90, 0x92},
                                                    },
                            ["lower-left-clear"]  = { -- 0xA0
                                                      ["main"]                          = 0xA0,
                                                      ["separator-1"]                   = 0xA1,
                                                      ["with-weak-lowground-upper-half-filled"]  = 0xA2,
                                                      ["separator-2"]                   = 0xA3,
                                                      ["with-solid-lowground-upper-half-filled"] = 0xA4,
                                                      ["separator-3"]                   = 0xA5,
                                                      ["with-rock-lower-right-filled"]  = 0xA6
                                                    },
                            ["upper-half-clear"]  = { -- 0xB0
                                                      ["main"]                          = {0xB0, 0xB2},
                                                      ["separator-1"]                   = 0xB3,
                                                      ["with-rock-lower-left-filled"]   = 0xB4,
                                                      ["separator-2"]                   = 0xB5,
                                                      ["with-rock-lower-right-filled"]  = 0xB6
                                                    },
                            ["upper-right-clear"] = { -- 0xC0
                                                      ["main"]                          = {0xC0, 0xC1},
                                                      ["separator-1"]                   = 0xC2,
                                                      ["with-rock-upper-left-filled"]   = 0xC3,
                                                      ["separator-2"]                   = 0xC4,
                                                      ["with-rock-lower-right-filled"]  = 0xC5
                                                    },
                            ["upper-left-clear"] =  { -- 0xD0
                                                      ["main"]                          = {0xD0, 0xD1},
                                                      ["separator-1"]                   = 0xD2,
                                                      ["with-rock-lower-left-filled"]   = 0xD3,
                                                      ["separator-2"]                   = 0xD4,
                                                      ["with-rock-upper-right-filled"]  = 0xD5
                                                    }}
  }
}


function TilesetSlotsIdx:get(base, mixed)

  local function parseIdx(slot)
    if type(slot) == "table" then -- there is subslots layout in the definition
      return slot[1] -- first member is always the base idx
    else
      return slot
    end
  end

  if mixed then
    return parseIdx(self["mixed"][base][mixed])
  else
    return parseIdx(self["solid"][base])
  end
end

function TilesetSlotsIdx:initSubslots()
  
  TilesetSlotsIdx["subslots-layout"] = TilesetSubslotsLayout

  TilesetSlotsIdx["mixed"]
                 ["ramp-side"]["weak-lowground"]
                 ["subslots"] = TilesetSubslotsLayout["ramp-side"]["to-lowground"]
  TilesetSlotsIdx["mixed"]
                 ["ramp-side"]["solid-lowground"]
                 ["subslots"] = TilesetSubslotsLayout["ramp-side"]["to-lowground"]
  TilesetSlotsIdx["mixed"]
                 ["weak-highground"]["weak-lowground"]
                 ["subslots"] = TilesetSubslotsLayout["highground"]["to-lowground"]
  TilesetSlotsIdx["mixed"]
                 ["weak-highground"]["solid-lowground"]
                 ["subslots"] = TilesetSubslotsLayout["highground"]["to-lowground"]
  TilesetSlotsIdx["mixed"]
                 ["solid-highground"]["weak-lowground"]
                 ["subslots"] = TilesetSubslotsLayout["highground"]["to-lowground"]
  TilesetSlotsIdx["mixed"]
                 ["solid-highground"]["solid-lowground"]
                 ["subslots"] = TilesetSubslotsLayout["highground"]["to-lowground"]
end

TilesetSlotsIdx:initSubslots()

