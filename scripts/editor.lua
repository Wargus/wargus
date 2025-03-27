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

--	Set which icons to display
SetEditorSelectIcon("icon-human-patrol-land")
SetEditorUnitsIcon("icon-footman")
SetEditorStartUnit("unit-human-start-location")

-- To prevent overlaps with controls
SetScrollMargins(2, 2, 2, 2);

--
--	editor-unit-types a sorted list of unit-types for the editor.
--	FIXME: this is only a temporary hack, for better sorted units.
--
local editor_types = {
   -- "unit-human-start-location",

--   "unit-bat",
--   "unit-fox",
--   "unit-rebels-cabin1",
--   "unit-rebels-cabin2",
--   "unit-rebels-cabin3",
   "--" .. _("Human Land Units"),
   "unit-peasant",
   "unit-footman",
   "unit-archer",
   "unit-ranger",
   "unit-knight",
   "unit-paladin",
   "unit-mage",
   "unit-dwarves",
   "unit-ballista",

   "--" .. _("Human Sea Units"),
   "unit-human-oil-tanker",
   "unit-human-transport",
   "unit-human-destroyer",
   "unit-battleship",
   "unit-human-submarine",

   "--" .. _("Human Air Units"),
   "unit-balloon",
   "unit-gryphon-rider",

   "--" .. _("Human Land Buildings"),
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

   "--" .. _("Human Shore Buildings"),
   "unit-human-shipyard",
   "unit-human-foundry",
   "unit-human-refinery",
   "unit-human-oil-platform",

   "--" .. _("Human Heroes"),
   "unit-female-hero",
   "unit-flying-angel",
   "unit-white-mage",
   "unit-knight-rider",
   "unit-arthor-literios",
   "unit-wise-man",
   "unit-man-of-light",

--- - - - - - - - - - - - - - - - - - -
   -- "unit-orc-start-location",
   "--" .. _("Orc Land Units"), 
   "unit-peon",
   "unit-grunt",
   "unit-axethrower",
   "unit-berserker",
   "unit-ogre",
   "unit-ogre-mage",
   "unit-death-knight",
   "unit-goblin-sappers",
   "unit-catapult",

   "--" .. _("Orc Sea Units"), 
   "unit-orc-oil-tanker",
   "unit-orc-transport",
   "unit-orc-destroyer",
   "unit-ogre-juggernaught",
   "unit-orc-submarine",

   "--" .. _("Orc Air Units"), 
   "unit-eye-of-vision",
   "unit-zeppelin",
   "unit-dragon",

   "--" .. _("Orc Land Buildings"), 
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

   "--" .. _("Orc Shore Buildings"), 
   "unit-orc-shipyard",
   "unit-orc-foundry",
   "unit-orc-refinery",
   "unit-orc-oil-platform",

   "--" .. _("Orc Heroes"), 
   "unit-evil-knight",
   "unit-fad-man",
   "unit-beast-cry",
   "unit-fire-breeze",
   "unit-quick-blade",
   "unit-ice-bringer",
   "unit-double-head",
   "unit-sharp-axe",

--- - - - - - - - - - - - - - - - - - -

   "--" .. _("Neutral Buildings"),
   "unit-gold-mine",
   "unit-oil-patch",
   "unit-dark-portal",
   "unit-circle-of-power",
   "unit-runestone",

   "--" .. _("Neutral Units"),
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


local keystrokes = {
   {"Ctrl-t", "cycle active tool"},
   {"Ctrl-f", "toggle full screen"},
   {"Ctrl-m", "cycle mirror editing"},
   {"Ctrl-x", "exit"},
   {"Ctrl-q", "quit to menu"},
   {"Ctrl-z", "undo"},
   {"Ctrl-y", "redo"},
   {"backspace", "remove unit under cursor"},
   {"0", "unit under cursor to last player (neutral)"},
   {"1-9", "unit under cursor to player 1-9"},
   {"Alt+0-6", "unit under cursor to player 10-16"},
   {"g", "toggle map grid"},
   {"-/+", "change elevation level to assign (brush)"},
   {"[/]", "change brush size"},
   {"</>", "change elevation level to highlight"},
   {"F5", "Map properties"},
   {"F6", "Player properties"},
   {"F11", "Save map"},
   {"F12", "Load map"},
   {"Rightclick", "Tile mode: Deselect current tile"},
   {"Rightclick", "Unit mode: Deselect current unit"},
   {"Rightclick", "Select mode: Edit unit under cursor"},
   {"Alt+click", "Tile mode when no tile is selected: Modify tile under cursor"},
   {"Ctrl+click", "Tile mode when no tile is selected: Select tile under cursor"}
 }
 
 function RunEditorHelpMenu()
   local menu = WarGameMenu(panel(5))
   menu:resize(352, 352)

   local c = Container()
   c:setOpaque(false)

   for i=1,table.getn(keystrokes) do
      local l = Label(keystrokes[i][1])
      l:setFont(Fonts["game"])
      l:adjustSize()
      c:add(l, 0, 20 * (i - 1))
      local l = Label(keystrokes[i][2])
      l:setFont(Fonts["game"])
      l:adjustSize()
      c:add(l, 80, 20 * (i - 1))
   end

   local s = ScrollArea()
   c:setSize(640, 20 * table.getn(keystrokes))
   s:setBaseColor(dark)
   s:setBackgroundColor(dark)
   s:setForegroundColor(clear)
   s:setSize(320, 216)
   s:setContent(c)
   menu:add(s, 16, 60)

   menu:addLabel(_("Keystroke Help Menu"), 352 / 2, 11)
   menu:addFullButton(_("Previous (~<Esc~>)"), "escape",
      (352 / 2) - (224 / 2), 352 - 40, function() menu:stop() end)

   menu:run(false)
 end
 