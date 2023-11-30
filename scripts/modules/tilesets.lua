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

local tilesets = {
                  ["classic"]     = { "summer", "swamp", "wasteland", "winter"},
                  ["highgrounds"] = { "summer", "wasteland", "winter"}, -- swamp has no highground tiles
                  labels      = {
                                  ["default"]   = _("Map Default"),
                                  ["summer"]    = _("Summer"),
                                  ["swamp"]     = _("Swamp"),
                                  ["wasteland"] = _("Wasteland"),
                                  ["winter"]    = _("Winter")
                                },
                  scripts = {
                              ["summer"]    = "scripts/tilesets/summer.lua",
                              ["swamp"]     = "scripts/tilesets/swamp.lua",
                              ["wasteland"] = "scripts/tilesets/wasteland.lua",
                              ["winter"]    = "scripts/tilesets/winter.lua"
                  }
}

function tilesets:getLabels(isHighgroundsEnabled, isMapDefaultAllowed)

  local currentList = self["classic"]
  if isHighgroundsEnabled then
    currentList = self["highgrounds"]
  end
  
  local result = {}

  if isMapDefaultAllowed then
    table.insert(result, self.labels["default"])
  end
  for i,tileset in ipairs(currentList) do
    table.insert(result, self.labels[tileset])
  end
  return result
end

function tilesets:getTilesetByLabel(label)
  for k,v in pairs(self.labels) do
    if v == label then
      return k
    end
  end
  return "default"
end

function tilesets:getScriptFor(tileset)
  return self.scripts[tileset]
end

-- Tileset's dropDownList helper
function tilesets:dropDown_switchSets(dropDownList, isHighgroundsEnabled, isMapDefaultAllowed)
  local prev = dropDownList:getSelectedItem()
  dropDownList:setList(self:getLabels(isHighgroundsEnabled, isMapDefaultAllowed))
  dropDownList:setSelectedItem(prev)
end

return tilesets
