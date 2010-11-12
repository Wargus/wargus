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
--      editor.lua - Editor configuration and functions.
--
--      (c) Copyright 2002-2004 by Lutz Sammer and Jimmy Salmon
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
--      $Id$


--	Set which icons to display
SetEditorSelectIcon("icon-human-patrol-land")
SetEditorUnitsIcon("icon-footman")


--
--	editor-unit-types a sorted list of unit-types for the editor.
--	FIXME: this is only a temporary hack, for better sorted units.
--
local editor_types = {
   "unit-human-start-location",

   "unit-peasant",
   "unit-footman",
   "unit-archer",
   "unit-ranger",
   "unit-knight",
   "unit-paladin",
   "unit-mage",
   "unit-dwarves",
   "unit-ballista",

   "unit-human-oil-tanker",
   "unit-human-transport",
   "unit-human-destroyer",
   "unit-battleship",
   "unit-human-submarine",

   "unit-balloon",
   "unit-gryphon-rider",

   "unit-town-hall",
   "unit-keep",
   "unit-castle",
   "unit-farm",
   "unit-human-barracks",
   "unit-elven-lumber-mill",
   "unit-human-blacksmith",
   "unit-human-watch-tower",
   "unit-human-guard-tower",
   "unit-human-cannon-tower",
   "unit-inventor",
   "unit-stables",
   "unit-church",
   "unit-mage-tower",
   "unit-gryphon-aviary",

   "unit-human-shipyard",
   "unit-human-foundry",
   "unit-human-refinery",
   "unit-human-oil-platform",

   "unit-female-hero",
   "unit-flying-angel",
   "unit-white-mage",
   "unit-knight-rider",
   "unit-arthor-literios",
   "unit-wise-man",
   "unit-man-of-light",

--- - - - - - - - - - - - - - - - - - -

   "unit-orc-start-location",

   "unit-peon",
   "unit-grunt",
   "unit-axethrower",
   "unit-berserker",
   "unit-ogre",
   "unit-ogre-mage",
   "unit-death-knight",
   "unit-goblin-sappers",
   "unit-catapult",

   "unit-orc-oil-tanker",
   "unit-orc-transport",
   "unit-orc-destroyer",
   "unit-ogre-juggernaught",
   "unit-orc-submarine",

   "unit-eye-of-vision",
   "unit-zeppelin",
   "unit-dragon",

   "unit-great-hall",
   "unit-stronghold",
   "unit-fortress",
   "unit-pig-farm",
   "unit-orc-barracks",
   "unit-troll-lumber-mill",
   "unit-orc-blacksmith",
   "unit-orc-watch-tower",
   "unit-orc-guard-tower",
   "unit-orc-cannon-tower",
   "unit-alchemist",
   "unit-ogre-mound",
   "unit-altar-of-storms",
   "unit-temple-of-the-damned",
   "unit-dragon-roost",

   "unit-orc-shipyard",
   "unit-orc-foundry",
   "unit-orc-refinery",
   "unit-orc-oil-platform",

   "unit-evil-knight",
   "unit-fad-man",
   "unit-beast-cry",
   "unit-fire-breeze",
   "unit-quick-blade",
   "unit-ice-bringer",
   "unit-double-head",
   "unit-sharp-axe",

--- - - - - - - - - - - - - - - - - - -

   "unit-gold-mine",
   "unit-oil-patch",
   "unit-dark-portal",
   "unit-circle-of-power",
   "unit-runestone",

   "unit-skeleton",
   "unit-daemon",
   "unit-critter"

-- Placing this unit-types on map is not (yet?) supported.
--   "unit-dead-body",
--   "unit-destroyed-1x1-place",
--   "unit-destroyed-2x2-place",
--   "unit-destroyed-3x3-place",
--   "unit-destroyed-4x4-place",
}


Editor.UnitTypes:clear()
for key,value in ipairs(editor_types) do
  Editor.UnitTypes:push_back(value)
end
