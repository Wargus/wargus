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
--      buttons.ccl - Define the unit-buttons of the human race.
--
--      (c) Copyright 2001-2003 by Vladi Belperchinov-Shabanski and Lutz Sammer
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

------------------------------------------------------------------------------
--	Define", "unit-button.
--
--	DefineButton( { Pos = n, Level = n 'icon ident Action = name ['value value]
--		['allowed check ['values]] Key = key, Hint = hint 'for-unit", "units)
--

-- general commands -- almost all", "units have it -------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peasant",
  Action = "move",
  Key = "m", Hint = _("~!MOVE"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-peasant",
    "unit-female-hero",
    "unit-flying-angel", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-white-mage", "unit-balloon",
    "unit-gryphon-rider", "unit-mage", "unit-critter",
    "human-group"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
  Action = "stop",
  Key = "s", Hint = _("~!STOP"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-peasant",
    "unit-female-hero",
    "unit-flying-angel", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-white-mage", "unit-balloon",
    "unit-gryphon-rider", "unit-mage", "unit-critter",
    "human-group"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield1"},
  Key = "s", Hint = _("~!STOP"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield2"},
  Key = "s", Hint = _("~!STOP"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword1",
  Action = "attack",
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-peasant",
    "unit-female-hero",
    "unit-flying-angel", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-white-mage", "unit-gryphon-rider", "human-group"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-sword1"},
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-sword2"},
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow1",
  Action = "attack",
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-archer", "unit-ranger", "unit-female-hero"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow1"},
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-archer", "unit-ranger", "unit-female-hero"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow3",
  Action = "attack", Popup = "popup-human-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow2"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-archer", "unit-ranger", "unit-female-hero"} } )

if (wargus.extensions) then
DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-patrol-land",
  Action = "patrol",
  Key = "p", Hint = _("~!PATROL"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-female-hero",
    "unit-flying-angel", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-gryphon-rider", "human-group",
    "unit-balloon"} } )
else
DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-patrol-land",
  Action = "patrol",
  Key = "p", Hint = _("~!PATROL"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-female-hero",
    "unit-flying-angel", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-gryphon-rider", "human-group"} } )
end
DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-patrol-naval",
  Action = "explore",
  Key = "x", Hint = _("E~!XPLORE"), Popup = "popup-human-commands",
  ForUnit = {"unit-balloon"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-human-stand-ground",
  Action = "stand-ground",
  Key = "t", Hint = _("S~!TAND GROUND"), Popup = "popup-human-commands",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer", "unit-paladin", "unit-attack-peasant",
    "unit-dwarves", "unit-ranger", "unit-ballista", "unit-female-hero",
    "unit-flying-angel", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-gryphon-rider", "human-group",
    "unit-human-submarine", "unit-battleship", "unit-human-destroyer"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-attack-ground",
  Action = "attack-ground",
  Key = "g", Hint = _("ATTACK ~!GROUND"), Popup = "popup-human-commands",
  ForUnit = {"unit-ballista", "unit-battleship", "human-group"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-human-demolish",
  Action = "cast-spell", Value = "spell-suicide-bomber",
  Allowed = "check-true", Popup = "popup-human-commands",
  Key = "d", Hint = _("~!DEMOLISH"),
  ForUnit = {"unit-dwarves"} } )

-- paladin specific actions ---------------------------------------------------

DefineButton( { Pos = 7, Level = 0, Icon = "icon-holy-vision",
  Action = "cast-spell", Value = "spell-holy-vision", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-holy-vision"},
  Key = "v", Hint = _("HOLY ~!VISION"),
  ForUnit = {"unit-paladin", "unit-knight-rider",
    "unit-man-of-light"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-heal",
  Action = "cast-spell", Value = "spell-healing", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-healing"},
  Key = "h", Hint = _("~!HEALING (per 1 HP)"),
  ForUnit = {"unit-paladin", "unit-knight-rider",
    "unit-man-of-light"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-exorcism",
  Action = "cast-spell", Value = "spell-exorcism", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-exorcism"},
  Key = "e", Hint = _("~!EXORCISM"),
  ForUnit = {"unit-paladin", "unit-knight-rider",
    "unit-man-of-light"} } )

-- mage specific actions ------------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-lightning",
  Action = "attack", Popup = "popup-human-commands",
  Key = "a", Hint = _("LIGHTNING ~!ATTACK"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-fireball",
  Action = "cast-spell", Value = "spell-fireball", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-fireball"},
  Key = "f", Hint = _("~!FIREBALL"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-slow",
  Action = "cast-spell", Value = "spell-slow", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-slow"},
  Key = "o", Hint = _("SL~!OW"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-flame-shield",
  Action = "cast-spell", Value = "spell-flame-shield", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-flame-shield"},
  Key = "l", Hint = _("F~!LAME SHIELD"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-invisibility",
  Action = "cast-spell", Value = "spell-invisibility", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-invisibility"},
  Key = "i", Hint = _("~!INVISIBILITY"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-polymorph",
  Action = "cast-spell", Value = "spell-polymorph", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-polymorph"},
  Key = "p", Hint = _("~!POLYMORPH"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-blizzard",
  Action = "cast-spell", Value = "spell-blizzard", Popup = "popup-human-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-blizzard"},
  Key = "b", Hint = _("~!BLIZZARD"),
  ForUnit = {"unit-mage", "unit-white-mage"} } )

-- peasant specific actions ---------------------------------------------------

DefineButton( { Pos = 4, Level = 0, Icon = "icon-repair",
  Action = "repair", Popup = "popup-human-commands",
  Key = "r", Hint = _("~!REPAIR"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
  Action = "harvest", Popup = "popup-human-commands",
  Key = "h", Hint = _("~!HARVEST LUMBER/MINE GOLD"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-return-goods-peasant",
  Action = "return-goods", Popup = "popup-human-commands",
  Key = "g", Hint = _("RETURN WITH ~!GOODS"),
  ForUnit = {"unit-peasant"} } )

-- build basic/advanced structs -----------------------------------------------

DefineButton( { Pos = 7, Level = 0, Icon = "icon-build-basic",
  Action = "button", Value = 1, Popup = "popup-human-commands",
  Key = "b", Hint = _("~!BUILD BASIC STRUCTURE"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-build-advanced",
  Action = "button", Value = 2, Popup = "popup-human-commands",
  Allowed = "check-units-or", AllowArg = {"unit-elven-lumber-mill", "unit-keep"},
  Key = "v", Hint = _("BUILD AD~!VANCED STRUCTURE"),
  ForUnit = {"unit-peasant"} } )

-- simple buildings human -----------------------------------------------------

DefineButton( { Pos = 1, Level = 1, Icon = "icon-farm",
  Action = "build", Value = "unit-farm", Popup = "popup-human-building",
  Key = "f", Hint = _("BUILD ~!FARM"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 2, Level = 1, Icon = "icon-human-barracks",
  Action = "build", Value = "unit-human-barracks", Popup = "popup-human-building",
  Key = "b", Hint = _("BUILD ~!BARRACKS"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 3, Level = 1, Icon = "icon-town-hall",
  Action = "build", Value = "unit-town-hall", Popup = "popup-human-building",
  Key = "h", Hint = _("BUILD TOWN ~!HALL"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 4, Level = 1, Icon = "icon-elven-lumber-mill",
  Action = "build", Value = "unit-elven-lumber-mill", Popup = "popup-human-building",
  Key = "l", Hint = _("BUILD ELVEN ~!LUMBER MILL"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 5, Level = 1, Icon = "icon-human-blacksmith",
  Action = "build", Value = "unit-human-blacksmith", Popup = "popup-human-building",
  Key = "s", Hint = _("BUILD BLACK~!SMITH"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 7, Level = 1, Icon = "icon-human-watch-tower",
  Action = "build", Value = "unit-human-watch-tower", Popup = "popup-human-building",
  Key = "t", Hint = _("BUILD ~!TOWER"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 8, Level = 1, Icon = "icon-human-wall",
  Action = "build", Value = "unit-human-wall", Popup = "popup-human-building",
  Allowed = "check-network",
  Key = "w", Hint = _("BUILD ~!WALL"),
  ForUnit = {"unit-peasant"} } )

  DefineButton( { Pos = 8, Level = 1, Icon = "icon-human-wall",
  Action = "build", Value = "unit-human-wall", Popup = "popup-human-building",
  Allowed = "check-debug", AllowArg = {"single-player-walls"},
  Key = "w", Hint = _("BUILD ~!WALL"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0, Popup = "popup-human-commands",
  Key = "ESC", Hint = _("~<ESC~> CANCEL"),
  ForUnit = {"unit-peasant"} } )

-- human advanced buildings ---------------------------------------------------

DefineButton( { Pos = 1, Level = 2, Icon = "icon-human-shipyard",
  Action = "build", Value = "unit-human-shipyard", Popup = "popup-human-building",
  Key = "s", Hint = _("BUILD ~!SHIPYARD"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 2, Level = 2, Icon = "icon-human-foundry",
  Action = "build", Value = "unit-human-foundry", Popup = "popup-human-building",
  Key = "f", Hint = _("BUILD ~!FOUNDRY"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 3, Level = 2, Icon = "icon-human-refinery",
  Action = "build", Value = "unit-human-refinery", Popup = "popup-human-building",
  Key = "r", Hint = _("BUILD ~!REFINERY"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 4, Level = 2, Icon = "icon-gnomish-inventor",
  Action = "build", Value = "unit-inventor", Popup = "popup-human-building",
  Key = "i", Hint = _("BUILD GNOMISH ~!INVENTOR"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 5, Level = 2, Icon = "icon-stables",
  Action = "build", Value = "unit-stables", Popup = "popup-human-building",
  Key = "a", Hint = _("BUILD ST~!ABLES"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 6, Level = 2, Icon = "icon-mage-tower",
  Action = "build", Value = "unit-mage-tower", Popup = "popup-human-building",
  Key = "m", Hint = _("BUILD ~!MAGE TOWER"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 7, Level = 2, Icon = "icon-church",
  Action = "build", Value = "unit-church", Popup = "popup-human-building",
  Key = "c", Hint = _("BUILD ~!CHURCH"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 8, Level = 2, Icon = "icon-gryphon-aviary",
  Action = "build", Value = "unit-gryphon-aviary", Popup = "popup-human-building",
  Key = "g", Hint = _("BUILD ~!GRYPHON AVIARY"),
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
  Action = "button", Value = 0, Popup = "popup-human-commands",
  Key = "ESC", Hint = _("~<ESC~> CANCEL"),
  ForUnit = {"unit-peasant"} } )

-- buildings commands ---------------------------------------------------------

if (wargus.extensions) then
DefineButton( { Pos = 1, Level = 0, Icon = "icon-critter",
  Action = "train-unit", Value = "unit-critter", Popup = "popup-human-unit",
  Key = "c", Hint = _("TRAIN ~!CRITTER"),
  ForUnit = {"unit-farm"} } )
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-peasant",
  Action = "train-unit", Value = "unit-peasant",
  Allowed = "check-no-research",
  Key = "p", Hint = _("TRAIN ~!PEASANT"), Popup = "popup-human-unit",
  ForUnit = {"unit-town-hall", "unit-keep", "unit-castle"} } )

-- town hall upgrades ---------------------------------------------------------

DefineButton( { Pos = 2, Level = 0, Icon = "icon-keep",
  Action = "upgrade-to", Value = "unit-keep", Popup = "popup-human-building",
  Allowed = "check-upgrade-to",
  Key = "k", Hint = _("UPGRADE TO ~!KEEP"),
  ForUnit = {"unit-town-hall"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-castle-upgrade",
  Action = "upgrade-to", Value = "unit-castle", Popup = "popup-human-building",
  Allowed = "check-upgrade-to",
  Key = "c", Hint = _("UPGRADE TO ~!CASTLE"),
  ForUnit = {"unit-keep"} } )

if (wargus.extensions) then
do
DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
  Action = "harvest", Popup = "popup-human-commands",
  Key = "h", Hint = _("SET ~!HARVEST LUMBER/MINE GOLD"),
  ForUnit = {"unit-town-hall", "unit-keep", "unit-castle"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-move-peasant",
  Action = "move",
  Key = "m", Hint = _("SET ~!MOVE"), Popup = "popup-human-commands",
  ForUnit = {"unit-town-hall", "unit-keep", "unit-castle", "unit-human-barracks",
    "unit-mage-tower", "unit-gryphon-aviary", "unit-inventor"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-human-shield1",
  Action = "stop",
  Key = "z", Hint = _("SET ~!ZTOP"), Popup = "popup-human-commands",
  ForUnit = {"unit-town-hall", "unit-keep", "unit-castle", "unit-human-barracks",
    "unit-mage-tower", "unit-gryphon-aviary", "unit-inventor"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-sword1",
  Action = "attack",
  Key = "e", Hint = _("S~!ET ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-town-hall", "unit-keep", "unit-castle", "unit-human-barracks",
    "unit-mage-tower", "unit-gryphon-aviary", "unit-inventor"} } )
end
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-peasant",
  Action = "train-unit", Value = "unit-attack-peasant", Popup = "popup-human-unit",
  Key = "m", Hint = _("TRAIN ~!MINUTEMAN"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-footman",
  Action = "train-unit", Value = "unit-footman", Popup = "popup-human-unit",
  Key = "f", Hint = _("TRAIN ~!FOOTMAN"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-archer",
  Action = "train-unit", Value = "unit-archer", Popup = "popup-human-unit",
  Key = "a", Hint = _("TRAIN ~!ARCHER"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-ranger",
  Action = "train-unit", Value = "unit-ranger", Popup = "popup-human-unit",
  Key = "r", Hint = _("TRAIN ~!RANGER"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-ballista",
  Action = "train-unit", Value = "unit-ballista", Popup = "popup-human-unit",
  Key = "b", Hint = _("BUILD ~!BALLISTA"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-knight",
  Action = "train-unit", Value = "unit-knight", Popup = "popup-human-unit",
  Key = "k", Hint = _("TRAIN ~!KNIGHT"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-paladin",
  Action = "train-unit", Value = "unit-paladin", Popup = "popup-human-unit",
  Key = "p", Hint = _("TRAIN ~!PALADIN"),
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-gnomish-flying-machine",
  Action = "train-unit", Value = "unit-balloon", Popup = "popup-human-unit",
  Key = "f", Hint = _("BUILD GNOMISH ~!FLYING MACHINE"),
  ForUnit = {"unit-inventor"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-dwarves",
  Action = "train-unit", Value = "unit-dwarves", Popup = "popup-human-unit",
  Key = "d", Hint = _("TRAIN ~!DWARVEN DEMOLITION SQUAD"),
  ForUnit = {"unit-inventor"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-mage",
  Action = "train-unit", Value = "unit-mage", Popup = "popup-human-unit",
  Key = "t", Hint = _("~!TRAIN MAGE"),
  ForUnit = {"unit-mage-tower"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-gryphon-rider",
  Action = "train-unit", Value = "unit-gryphon-rider", Popup = "popup-human-unit",
  Key = "g", Hint = _("TRAIN ~!GRYPHON RIDER"),
  ForUnit = {"unit-gryphon-aviary"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-human-oil-tanker",
  Action = "train-unit", Value = "unit-human-oil-tanker", Popup = "popup-human-unit",
  Key = "o", Hint = _("BUILD ~!OIL TANKER"),
  ForUnit = {"unit-human-shipyard"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-destroyer",
  Action = "train-unit", Value = "unit-human-destroyer", Popup = "popup-human-unit",
  Key = "d", Hint = _("BUILD ~!DESTROYER"),
  ForUnit = {"unit-human-shipyard"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-transport",
  Action = "train-unit", Value = "unit-human-transport", Popup = "popup-human-unit",
  Key = "t", Hint = _("BUILD ~!TRANSPORT"),
  ForUnit = {"unit-human-shipyard"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-gnomish-submarine",
  Action = "train-unit", Value = "unit-human-submarine", Popup = "popup-human-unit",
  Key = "s", Hint = _("BUILD GNOMISH ~!SUBMARINE"),
  ForUnit = {"unit-human-shipyard"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-battleship",
  Action = "train-unit", Value = "unit-battleship", Popup = "popup-human-unit",
  Key = "b", Hint = _("BUILD ~!BATTLESHIP"),
  ForUnit = {"unit-human-shipyard"} } )

if (wargus.extensions) then
-----------------------------------------------------
DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-ship-haul-oil",
  Action = "harvest", Popup = "popup-human-commands",
  Key = "h", Hint = _("SET ~!HAUL OIL"),
  ForUnit = {"unit-human-shipyard"} } )
-----------------------------------------------------
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-human-guard-tower",
  Action = "upgrade-to", Value = "unit-human-guard-tower", Popup = "popup-human-building",
  Key = "g", Hint = _("UPGRADE TO ~!GUARD TOWER"),
  ForUnit = {"unit-human-watch-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-cannon-tower",
  Action = "upgrade-to", Value = "unit-human-cannon-tower", Popup = "popup-human-building",
  Key = "c", Hint = _("UPGRADE TO ~!CANNON TOWER"),
  ForUnit = {"unit-human-watch-tower"} } )

-- ships ----------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-human-ship-move",
  Action = "move",
  Key = "m", Hint = _("~!MOVE"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-oil-tanker",
    "unit-human-submarine", "unit-battleship", "unit-human-destroyer",
    "unit-human-transport"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-ship-armor1",
  Action = "stop",
  Key = "s", Hint = _("~!STOP"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-oil-tanker",
    "unit-human-submarine", "unit-battleship", "unit-human-destroyer",
    "unit-human-transport"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-unload",
  Action = "unload",
  Key = "u", Hint = _("~!UNLOAD"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-transport"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-oil-platform",
  Action = "build", Value = "unit-human-oil-platform", Popup = "popup-human-building",
  Key = "b", Hint = _("~!BUILD OIL PLATFORM"),
  ForUnit = {"unit-human-oil-tanker"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-human-ship-haul-oil",
  Action = "harvest",
  Key = "h", Hint = _("~!HAUL OIL"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-oil-tanker"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-ship-return-oil",
  Action = "return-goods",
  Key = "g", Hint = _("RETURN WITH ~!GOODS"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-oil-tanker"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-ship-cannon1",
  Action = "attack",
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-submarine", "unit-battleship", "unit-human-destroyer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-ship-cannon2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-ship-cannon1"},
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-submarine", "unit-battleship", "unit-human-destroyer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-ship-cannon3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-ship-cannon2"},
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-submarine", "unit-battleship", "unit-human-destroyer"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-patrol-naval",
  Action = "patrol",
  Key = "p", Hint = _("~!PATROL"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-submarine", "unit-battleship", "unit-human-destroyer"} } )

if (wargus.extensions) then
do
DefineButton( { Pos = 7, Level = 0, Icon = "icon-human-ship-move",
  Action = "move",
  Key = "m", Hint = _("SET ~!MOVE"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-shipyard"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-human-ship-armor1",
  Action = "stop",
  Key = "z", Hint = _("SET ~!ZTOP"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-shipyard"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-human-ship-cannon1",
  Action = "attack",
  Key = "e", Hint = _("S~!ET ATTACK"), Popup = "popup-human-commands",
  ForUnit = {"unit-human-shipyard"} } )
end
end

-- upgrades -------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-sword2",
  Action = "research", Value = "upgrade-sword1", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "w", Hint = _("UPGRADE S~!WORDS (Damage +2)"),
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-sword3",
  Action = "research", Value = "upgrade-sword2", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "w", Hint = _("UPGRADE S~!WORDS (Damage +2)"),
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
  Action = "research", Value = "upgrade-human-shield1", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "s", Hint = _("UPGRADE ~!SHIELDS (Armor +2)"),
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
  Action = "research", Value = "upgrade-human-shield2", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "s", Hint = _("UPGRADE ~!SHIELDS (Armor +2)"),
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-ballista1",
  Action = "research", Value = "upgrade-ballista1", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "b", Hint = _("UPGRADE ~!BALLISTA (Damage +15)"),
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-ballista2",
  Action = "research", Value = "upgrade-ballista2", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "b", Hint = _("UPGRADE ~!BALLISTA (Damage +15)"),
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow2",
  Action = "research", Value = "upgrade-arrow1", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "u", Hint = _("~!UPGRADE ARROWS (Damage +1)"),
  ForUnit = {"unit-elven-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow3",
  Action = "research", Value = "upgrade-arrow2", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "u", Hint = _("~!UPGRADE ARROWS (Damage +1)"),
  ForUnit = {"unit-elven-lumber-mill"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-ranger",
  Action = "research", Value = "upgrade-ranger", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "r", Hint = _("ELVEN ~!RANGER TRAINING"),
  ForUnit = {"unit-elven-lumber-mill"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-ranger-scouting",
  Action = "research", Value = "upgrade-ranger-scouting", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "s", Hint = _("RANGER ~!SCOUTING (Sight:9)"),
  ForUnit = {"unit-elven-lumber-mill"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-longbow",
  Action = "research", Value = "upgrade-longbow", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "l", Hint = _("RESEARCH ~!LONGBOW (Range +1)"),
  ForUnit = {"unit-elven-lumber-mill"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-ranger-marksmanship",
  Action = "research", Value = "upgrade-ranger-marksmanship", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "m", Hint = _("RANGER ~!MARKSMANSHIP (Damage +3)"),
  ForUnit = {"unit-elven-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-paladin",
  Action = "research", Value = "upgrade-paladin", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "p", Hint = _("UPGRADES KNIGHTS TO ~!PALADINS"),
  ForUnit = {"unit-church"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-heal",
  Action = "research", Value = "upgrade-healing", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "h", Hint = _("RESEARCH ~!HEALING"),
  ForUnit = {"unit-church"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-exorcism",
  Action = "research", Value = "upgrade-exorcism", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "e", Hint = _("RESEARCH ~!EXORCISM"),
  ForUnit = {"unit-church"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-slow",
  Action = "research", Value = "upgrade-slow", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "o", Hint = _("RESEARCH SL~!OW"),
  ForUnit = {"unit-mage-tower"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-flame-shield",
  Action = "research", Value = "upgrade-flame-shield", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "l", Hint = _("RESEARCH F~!LAME SHIELD"),
  ForUnit = {"unit-mage-tower"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-invisibility",
  Action = "research", Value = "upgrade-invisibility", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "i", Hint = _("RESEARCH ~!INVISIBILITY"),
  ForUnit = {"unit-mage-tower"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-polymorph",
  Action = "research", Value = "upgrade-polymorph", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "p", Hint = _("RESEARCH ~!POLYMORPH"),
  ForUnit = {"unit-mage-tower"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-blizzard",
  Action = "research", Value = "upgrade-blizzard", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "b", Hint = _("RESEARCH ~!BLIZZARD"),
  ForUnit = {"unit-mage-tower"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-human-ship-cannon2",
  Action = "research", Value = "upgrade-human-ship-cannon1", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "c", Hint = _("UPGRADE ~!CANNONS (Damage +5)"),
  ForUnit = {"unit-human-foundry"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-human-ship-cannon3",
  Action = "research", Value = "upgrade-human-ship-cannon2", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "c", Hint = _("UPGRADE ~!CANNONS (Damage +5)"),
  ForUnit = {"unit-human-foundry"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-ship-armor2",
  Action = "research", Value = "upgrade-human-ship-armor1", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "a", Hint = _("UPGRADE SHIP ~!ARMOR (Armor +5)"),
  ForUnit = {"unit-human-foundry"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-ship-armor3",
  Action = "research", Value = "upgrade-human-ship-armor2", Popup = "popup-human-upgrade",
  Allowed = "check-single-research",
  Key = "a", Hint = _("UPGRADE SHIP ~!ARMOR (Armor +5)"),
  ForUnit = {"unit-human-foundry"} } )
