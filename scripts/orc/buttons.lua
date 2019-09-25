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
--      buttons.ccl - Define the", "unit-buttons of the orc race.
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

-- general commands -- almost all units have it -------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peon",
  Action = "move", Popup = "popup-orc-commands",
  Key = "m", Hint = _("~!MOVE"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-peon",
    "unit-fad-man", "unit-double-head",
    "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade", "unit-ice-bringer",
    "unit-evil-knight", "unit-skeleton", "unit-eye-of-vision", "unit-dragon",
    "unit-zeppelin", "unit-death-knight", "unit-fire-breeze",
    "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield1",
  Action = "stop", Popup = "popup-orc-commands",
  Key = "s", Hint = _("~!STOP"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-peon",
    "unit-fad-man", "unit-double-head",
    "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade", "unit-ice-bringer",
    "unit-evil-knight", "unit-skeleton", "unit-eye-of-vision", "unit-dragon",
    "unit-zeppelin", "unit-death-knight", "unit-fire-breeze",
    "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield2",
  Action = "stop", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-shield1"},
  Key = "s", Hint = _("~!STOP"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield3",
  Action = "stop", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-shield2"},
  Key = "s", Hint = _("~!STOP"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe1",
  Action = "attack", Popup = "popup-orc-commands",
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-peon",
    "unit-fad-man", "unit-double-head",
    "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade", "unit-ice-bringer",
    "unit-evil-knight", "unit-skeleton", "unit-dragon", "unit-fire-breeze",
    "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe2",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-battle-axe1"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-battle-axe2"},
  Key = "a", Hint = _("~!ATTACK"), Popup = "popup-orc-commands",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-throwing-axe1",
  Action = "attack", Popup = "popup-orc-commands",
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-axethrower", "unit-berserker", "unit-sharp-axe"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-throwing-axe2",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-throwing-axe1"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-axethrower", "unit-berserker", "unit-sharp-axe"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-throwing-axe3",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-throwing-axe2"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-axethrower", "unit-berserker", "unit-sharp-axe"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult1",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-catapult1"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult2",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-catapult2"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-catapult"} } )

if (wargus.extensions) then
DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-patrol-land",
  Action = "patrol", Popup = "popup-orc-commands",
  Key = "p", Hint = _("~!PATROL"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-fad-man",
    "unit-double-head", "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade",
    "unit-skeleton", "unit-dragon", "unit-fire-breeze", "orc-group", "unit-daemon",
    "unit-zeppelin", "unit-eye-of-vision"} } )
else
DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-patrol-land",
  Action = "patrol", Popup = "popup-orc-commands",
  Key = "p", Hint = _("~!PATROL"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-fad-man",
    "unit-double-head", "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade",
    "unit-skeleton", "unit-dragon", "unit-fire-breeze", "orc-group", "unit-daemon"} } )
end
DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-patrol-naval",
  Action = "explore",
  Key = "x", Hint = _("E~!XPLORE"), Popup = "popup-orc-commands",
  ForUnit = {"unit-zeppelin", "unit-eye-of-vision"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-orc-stand-ground",
  Action = "stand-ground", Popup = "popup-orc-commands",
  Key = "t", Hint = _("S~!TAND GROUND"),
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-fad-man",
    "unit-double-head", "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade",
    "unit-skeleton", "unit-dragon", "unit-fire-breeze", "unit-orc-submarine",
    "unit-ogre-juggernaught", "unit-orc-destroyer", "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-orc-attack-ground",
  Action = "attack-ground", Popup = "popup-orc-commands",
  Key = "g", Hint = _("ATTACK ~!GROUND"),
  ForUnit = {"unit-catapult", "unit-ogre-juggernaught", "orc-group"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-orc-demolish",
  Action = "cast-spell", Value = "spell-suicide-bomber",
  Allowed = "check-true",
  Key = "d", Hint = _("~!DEMOLISH"),
  ForUnit = {"unit-goblin-sappers"} } )

-- ogre-mage specific actions -------------------------------------------------

DefineButton( { Pos = 7, Level = 0, Icon = "icon-eye-of-kilrogg",
  Action = "cast-spell", Value = "spell-eye-of-vision", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
  Key = "k", Hint = _("EYE OF ~!KILROGG"),
  ForUnit = {"unit-ogre-mage", "unit-fad-man"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-bloodlust",
  Action = "cast-spell", Value = "spell-bloodlust", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-bloodlust"},
  Key = "b", Hint = _("~!BLOODLUST"),
  ForUnit = {"unit-ogre-mage", "unit-fad-man"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-runes",
  Action = "cast-spell", Value = "spell-runes", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-runes"},
  Key = "r", Hint = _("~!RUNES"),
  ForUnit = {"unit-ogre-mage", "unit-fad-man"} } )

-- cho'gall specific actions --- same as ogre mage but it has them always -----

DefineButton( { Pos = 7, Level = 0, Icon = "icon-eye-of-kilrogg",
  Action = "cast-spell", Value = "spell-eye-of-vision-double-head",
  Allowed = "check-true", Popup = "popup-orc-upgrade",
  Key = "e", Hint = _("~!EYE OF KILROGG"),
  ForUnit = {"unit-double-head"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-bloodlust",
  Action = "cast-spell", Value = "spell-bloodlust-double-head",
  Allowed = "check-true", Popup = "popup-orc-upgrade",
  Key = "b", Hint = _("~!BLOODLUST"),
  ForUnit = {"unit-double-head"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-runes",
  Action = "cast-spell", Value = "spell-runes-double-head",
  Allowed = "check-true", Popup = "popup-orc-upgrade",
  Key = "r", Hint = _("~!RUNES"),
  ForUnit = {"unit-double-head"} } )

-- death-knight specific actions ----------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-touch-of-darkness",
  Action = "attack", Popup = "popup-orc-commands",
  Key = "a", Hint = _("TOUCH OF D~!ARKNESS"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-death-coil",
  Action = "cast-spell", Value = "spell-death-coil", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-death-coil"},
  Key = "c", Hint = _("DEATH ~!COIL"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-haste",
  Action = "cast-spell", Value = "spell-haste", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-haste"},
  Key = "h", Hint = _("~!HASTE"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-raise-dead",
  Action = "cast-spell", Value = "spell-raise-dead", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-raise-dead"},
  Key = "r", Hint = _("~!RAISE DEAD"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-whirlwind",
  Action = "cast-spell", Value = "spell-whirlwind", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-whirlwind"},
  Key = "w", Hint = _("~!WHIRLWIND"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-unholy-armor",
  Action = "cast-spell", Value = "spell-unholy-armor", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-unholy-armor"},
  Key = "u", Hint = _("~!UNHOLY ARMOR"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-death-and-decay",
  Action = "cast-spell", Value = "spell-death-and-decay", Popup = "popup-orc-upgrade",
  Allowed = "check-upgrade", AllowArg = {"upgrade-death-and-decay"},
  Key = "d", Hint = _("~!DEATH AND DECAY"),
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

-- peon specific actions ------------------------------------------------------

DefineButton( { Pos = 4, Level = 0, Icon = "icon-repair",
  Action = "repair", Popup = "popup-orc-commands",
  Key = "r", Hint = _("~!REPAIR"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
  Action = "harvest", Popup = "popup-orc-commands",
  Key = "h", Hint = _("~!HARVEST LUMBER/MINE GOLD"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-return-goods-peon",
  Action = "return-goods", Popup = "popup-orc-commands",
  Key = "g", Hint = _("RETURN WITH ~!GOODS"),
  ForUnit = {"unit-peon"} } )

-- build basic/advanced structs -----------------------------------------------

DefineButton( { Pos = 7, Level = 0, Icon = "icon-build-basic",
  Action = "button", Value = 1, Popup = "popup-orc-commands",
  Key = "b", Hint = _("~!BUILD BASIC STRUCTURE"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-build-advanced",
  Action = "button", Value = 2, Popup = "popup-orc-commands",
  Allowed = "check-units-or", AllowArg = {"unit-troll-lumber-mill", "unit-stronghold"},
  Key = "v", Hint = _("BUILD AD~!VANCED STRUCTURE"),
  ForUnit = {"unit-peon"} } )

-- simple buildings orc -------------------------------------------------------

DefineButton( { Pos = 1, Level = 1, Icon = "icon-pig-farm",
  Action = "build", Value = "unit-pig-farm", Popup = "popup-orc-building",
  Key = "f", Hint = _("BUILD PIG ~!FARM"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 1, Icon = "icon-orc-barracks",
  Action = "build", Value = "unit-orc-barracks", Popup = "popup-orc-building",
  Key = "b", Hint = _("BUILD ~!BARRACKS"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 3, Level = 1, Icon = "icon-great-hall",
  Action = "build", Value = "unit-great-hall", Popup = "popup-orc-building",
  Key = "h", Hint = _("BUILD GREAT ~!HALL"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 1, Icon = "icon-troll-lumber-mill",
  Action = "build", Value = "unit-troll-lumber-mill", Popup = "popup-orc-building",
  Key = "l", Hint = _("BUILD TROLL ~!LUMBER MILL"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 1, Icon = "icon-orc-blacksmith",
  Action = "build", Value = "unit-orc-blacksmith", Popup = "popup-orc-building",
  Key = "s", Hint = _("BUILD BLACK~!SMITH"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 7, Level = 1, Icon = "icon-orc-watch-tower",
  Action = "build", Value = "unit-orc-watch-tower", Popup = "popup-orc-building",
  Key = "t", Hint = _("BUILD ~!TOWER"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 8, Level = 1, Icon = "icon-orc-wall",
  Action = "build", Value = "unit-orc-wall", Popup = "popup-orc-building",
  Allowed = "check-network",
  Key = "w", Hint = _("BUILD ~!WALL"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0, Popup = "popup-orc-commands",
  Key = "ESC", Hint = _("~<ESC~> CANCEL"),
  ForUnit = {"unit-peon"} } )

-- orc advanced buildings -----------------------------------------------------

DefineButton( { Pos = 1, Level = 2, Icon = "icon-orc-shipyard",
  Action = "build", Value = "unit-orc-shipyard", Popup = "popup-orc-building",
  Key = "s", Hint = _("BUILD ~!SHIPYARD"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 2, Icon = "icon-orc-foundry",
  Action = "build", Value = "unit-orc-foundry", Popup = "popup-orc-building",
  Key = "f", Hint = _("BUILD ~!FOUNDRY"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 3, Level = 2, Icon = "icon-orc-refinery",
  Action = "build", Value = "unit-orc-refinery", Popup = "popup-orc-building",
  Key = "r", Hint = _("BUILD ~!REFINERY"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 2, Icon = "icon-alchemist",
  Action = "build", Value = "unit-alchemist", Popup = "popup-orc-building",
  Key = "a", Hint = _("BUILD GOBLIN ~!ALCHEMIST"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 2, Icon = "icon-ogre-mound",
  Action = "build", Value = "unit-ogre-mound", Popup = "popup-orc-building",
  Key = "o", Hint = _("BUILD ~!OGRE MOUND"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 6, Level = 2, Icon = "icon-temple-of-the-damned",
  Action = "build", Value = "unit-temple-of-the-damned", Popup = "popup-orc-building",
  Key = "t", Hint = _("BUILD ~!TEMPLE OF THE DAMNED"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 7, Level = 2, Icon = "icon-altar-of-storms",
  Action = "build", Value = "unit-altar-of-storms", Popup = "popup-orc-building",
  Key = "l", Hint = _("BUILD A~!LTAR OF STORMS"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 8, Level = 2, Icon = "icon-dragon-roost",
  Action = "build", Value = "unit-dragon-roost", Popup = "popup-orc-building",
  Key = "d", Hint = _("BUILD ~!DRAGON ROOST"),
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
  Action = "button", Value = 0, Popup = "popup-orc-commands",
  Key = "ESC", Hint = _("~<ESC~> CANCEL"),
  ForUnit = {"unit-peon"} } )

-- orc buildings commands -----------------------------------------------------

if (wargus.extensions) then
DefineButton( { Pos = 1, Level = 0, Icon = "icon-critter",
  Action = "train-unit", Value = "unit-critter", Popup = "popup-orc-unit",
  Key = "c", Hint = _("TRAIN ~!CRITTER"),
  ForUnit = {"unit-pig-farm"} } )
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-peon",
  Action = "train-unit", Value = "unit-peon", Popup = "popup-orc-unit",
  Allowed = "check-no-research",
  Key = "p", Hint = _("TRAIN ~!PEON"),
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress"} } )

-- strong hold upgrades -------------------------------------------------------

DefineButton( { Pos = 2, Level = 0, Icon = "icon-stronghold",
  Action = "upgrade-to", Value = "unit-stronghold",
  Allowed = "check-upgrade-to", Popup = "popup-orc-building",
  Key = "s", Hint = _("UPGRADE TO ~!STRONGHOLD"),
  ForUnit = {"unit-great-hall"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-fortress-upgrade",
  Action = "upgrade-to", Value = "unit-fortress",
  Allowed = "check-upgrade-to", Popup = "popup-orc-building",
  Key = "f", Hint = _("UPGRADE TO ~!FORTRESS"),
  ForUnit = {"unit-stronghold"} } )

if (wargus.extensions) then
do
DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
  Action = "harvest", Popup = "popup-orc-commands",
  Key = "h", Hint = _("SET ~!HARVEST LUMBER/MINE GOLD"),
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-move-peon",
  Action = "move", Popup = "popup-orc-commands",
  Key = "m", Hint = _("SET ~!MOVE"),
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress",
    "unit-orc-barracks", "unit-temple-of-the-damned", "unit-dragon-roost",
    "unit-alchemist"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-orc-shield1",
  Action = "stop", Popup = "popup-orc-commands",
  Key = "z", Hint = _("SET ~!ZTOP"),
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress",
    "unit-orc-barracks", "unit-temple-of-the-damned", "unit-dragon-roost",
    "unit-alchemist"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-battle-axe1",
  Action = "attack", Popup = "popup-orc-commands",
  Key = "e", Hint = _("S~!ET ATTACK"),
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress",
    "unit-orc-barracks", "unit-temple-of-the-damned", "unit-dragon-roost",
    "unit-alchemist"} } )
end
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-grunt",
  Action = "train-unit", Value = "unit-grunt", Popup = "popup-orc-unit",
  Key = "g", Hint = _("TRAIN ~!GRUNT"),
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-axethrower",
  Action = "train-unit", Value = "unit-axethrower", Popup = "popup-orc-unit",
  Key = "a", Hint = _("TRAIN ~!AXETHROWER"),
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-berserker",
  Action = "train-unit", Value = "unit-berserker", Popup = "popup-orc-unit",
  Key = "b", Hint = _("TRAIN ~!BERSERKER"),
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult",
  Action = "train-unit", Value = "unit-catapult", Popup = "popup-orc-unit",
  Key = "c", Hint = _("BUILD ~!CATAPULT"),
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-ogre",
  Action = "train-unit", Value = "unit-ogre",
  Key = "o", Hint = _("TRAIN TWO-HEADED ~!OGRE"), Popup = "popup-orc-unit",
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-ogre-mage",
  Action = "train-unit", Value = "unit-ogre-mage", Popup = "popup-orc-unit",
  Key = "o", Hint = _("TRAIN ~!OGRE MAGE"),
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-zeppelin",
  Action = "train-unit", Value = "unit-zeppelin", Popup = "popup-orc-unit",
  Key = "z", Hint = _("BUILD GOBLIN ~!ZEPPELIN"),
  ForUnit = {"unit-alchemist"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-goblin-sappers",
  Action = "train-unit", Value = "unit-goblin-sappers", Popup = "popup-orc-unit",
  Key = "s", Hint = _("TRAIN GOBLIN ~!SAPPERS"),
  ForUnit = {"unit-alchemist"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-death-knight",
  Action = "train-unit", Value = "unit-death-knight", Popup = "popup-orc-unit",
  Key = "t", Hint = _("~!TRAIN DEATH KNIGHT"),
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-dragon",
  Action = "train-unit", Value = "unit-dragon", Popup = "popup-orc-unit",
  Key = "d", Hint = _("BUILD ~!DRAGON"),
  ForUnit = {"unit-dragon-roost"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-orc-oil-tanker",
  Action = "train-unit", Value = "unit-orc-oil-tanker",
  Key = "o", Hint = _("BUILD ~!OIL TANKER"),
  ForUnit = {"unit-orc-shipyard"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-destroyer",
  Action = "train-unit", Value = "unit-orc-destroyer", Popup = "popup-orc-unit",
  Key = "d", Hint = _("BUILD ~!DESTROYER"),
  ForUnit = {"unit-orc-shipyard"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-transport",
  Action = "train-unit", Value = "unit-orc-transport", Popup = "popup-orc-unit",
  Key = "t", Hint = _("BUILD ~!TRANSPORT"),
  ForUnit = {"unit-orc-shipyard"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-giant-turtle",
  Action = "train-unit", Value = "unit-orc-submarine", Popup = "popup-orc-unit",
  Key = "g", Hint = _("BUILD ~!GIANT TURTLE"),
  ForUnit = {"unit-orc-shipyard"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-ogre-juggernaught",
  Action = "train-unit", Value = "unit-ogre-juggernaught", Popup = "popup-orc-unit",
  Key = "j", Hint = _("BUILD ~!JUGGERNAUHGT"),
  ForUnit = {"unit-orc-shipyard"} } )

if (wargus.extensions) then
-----------------------------------------------------
DefineButton( { Pos = 6, Level = 0, Icon = "icon-orc-ship-haul-oil",
  Action = "harvest", Popup = "popup-orc-commands",
  Key = "h", Hint = _("SET ~!HAUL OIL"),
  ForUnit = {"unit-orc-shipyard"} } )
-----------------------------------------------------
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-orc-guard-tower",
  Action = "upgrade-to", Value = "unit-orc-guard-tower", Popup = "popup-orc-building",
  Key = "g", Hint = _("UPGRADE TO ~!GUARD TOWER"),
  ForUnit = {"unit-orc-watch-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-cannon-tower",
  Action = "upgrade-to", Value = "unit-orc-cannon-tower", Popup = "popup-orc-building",
  Key = "c", Hint = _("UPGRADE TO ~!CANNON TOWER"),
  ForUnit = {"unit-orc-watch-tower"} } )

-- ships ----------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-orc-ship-move",
  Action = "move", Popup = "popup-orc-commands",
  Key = "m", Hint = _("~!MOVE"),
  ForUnit = {"unit-orc-oil-tanker", "unit-orc-submarine",
    "unit-ogre-juggernaught", "unit-orc-destroyer", "unit-orc-transport"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-ship-armor1",
  Action = "stop", Popup = "popup-orc-commands",
  Key = "s", Hint = _("~!STOP"),
  ForUnit = {"unit-orc-oil-tanker", "unit-orc-submarine",
    "unit-ogre-juggernaught", "unit-orc-destroyer", "unit-orc-transport"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-unload",
  Action = "unload", Popup = "popup-orc-commands",
  Key = "u", Hint = _("~!UNLOAD"),
  ForUnit = {"unit-orc-transport"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-oil-platform",
  Action = "build", Value = "unit-orc-oil-platform", Popup = "popup-orc-building",
  Key = "b", Hint = _("~!BUILD OIL PLATFORM"),
  ForUnit = {"unit-orc-oil-tanker"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-orc-ship-haul-oil",
  Action = "harvest", Popup = "popup-orc-commands",
  Key = "h", Hint = _("~!HAUL OIL"),
  ForUnit = {"unit-orc-oil-tanker"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-orc-ship-return-oil",
  Action = "return-goods", Popup = "popup-orc-commands",
  Key = "g", Hint = _("RETURN WITH ~!GOODS"),
  ForUnit = {"unit-orc-oil-tanker"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-ship-cannon1",
  Action = "attack", Popup = "popup-orc-commands",
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-orc-submarine", "unit-ogre-juggernaught", "unit-orc-destroyer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-ship-cannon2",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-ship-cannon1"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-orc-submarine", "unit-ogre-juggernaught", "unit-orc-destroyer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-ship-cannon3",
  Action = "attack", Popup = "popup-orc-commands",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-ship-cannon2"},
  Key = "a", Hint = _("~!ATTACK"),
  ForUnit = {"unit-orc-submarine", "unit-ogre-juggernaught", "unit-orc-destroyer"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-patrol-naval",
  Action = "patrol", Popup = "popup-orc-commands",
  Key = "p", Hint = _("~!PATROL"),
  ForUnit = {"unit-orc-submarine", "unit-ogre-juggernaught", "unit-orc-destroyer"} } )

if (wargus.extensions) then
do
DefineButton( { Pos = 7, Level = 0, Icon = "icon-orc-ship-move",
  Action = "move", Popup = "popup-orc-commands",
  Key = "m", Hint = _("SET ~!MOVE"),
  ForUnit = {"unit-orc-shipyard"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-orc-ship-armor1",
  Action = "stop", Popup = "popup-orc-commands",
  Key = "z", Hint = _("SET ~!ZTOP"),
  ForUnit = {"unit-orc-shipyard"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-orc-ship-cannon1",
  Action = "attack", Popup = "popup-orc-commands",
  Key = "e", Hint = _("S~!ET ATTACK"),
  ForUnit = {"unit-orc-shipyard"} } )
end
end

-- upgrades -------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-battle-axe2",
  Action = "research", Value = "upgrade-battle-axe1", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "w", Hint = _("UPGRADE ~!WEAPONS (Damage +2)"),
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-battle-axe3",
  Action = "research", Value = "upgrade-battle-axe2", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "w", Hint = _("UPGRADE ~!WEAPONS (Damage +2)"),
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield2",
  Action = "research", Value = "upgrade-orc-shield1", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "s", Hint = _("UPGRADE ~!SHIELDS (Armor +2)"),
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield3",
  Action = "research", Value = "upgrade-orc-shield2", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "s", Hint = _("UPGRADE ~!SHIELDS (Armor +2)"),
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult1",
  Action = "research", Value = "upgrade-catapult1", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "c", Hint = _("UPGRADE ~!CATAPULT (Damage +15)"),
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult2",
  Action = "research", Value = "upgrade-catapult2", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "c", Hint = _("UPGRADE ~!CATAPULT (Damage +15)"),
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-throwing-axe2",
  Action = "research", Value = "upgrade-throwing-axe1", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "u", Hint = _("~!UPGRADE THROWING AXE (Damage +1)"),
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-throwing-axe3",
  Action = "research", Value = "upgrade-throwing-axe2", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "u", Hint = _("~!UPGRADE THROWING AXE (Damage +1)"),
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-berserker",
  Action = "research", Value = "upgrade-berserker", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "b", Hint = _("TROLL ~!BERSERKER TRAINING"),
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-berserker-scouting",
  Action = "research", Value = "upgrade-berserker-scouting", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "s", Hint = _("BERSERKER ~!SCOUTING (Sight:9)"),
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-light-axes",
  Action = "research", Value = "upgrade-light-axes", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "a", Hint = _("RESEARCH LIGHTER ~!AXES (Range +1)"),
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-berserker-regeneration",
  Action = "research", Value = "upgrade-berserker-regeneration", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "r", Hint = _("BERSERKER ~!REGENERATION"),
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-ogre-mage",
  Action = "research", Value = "upgrade-ogre-mage", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "m", Hint = _("UPGRADES OGRES TO ~!MAGES"),
  ForUnit = {"unit-altar-of-storms"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-bloodlust",
  Action = "research", Value = "upgrade-bloodlust", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "b", Hint = _("RESEARCH ~!BLOODLUST"),
  ForUnit = {"unit-altar-of-storms"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-runes",
  Action = "research", Value = "upgrade-runes", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "r", Hint = _("RESEARCH ~!RUNES"),
  ForUnit = {"unit-altar-of-storms"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-haste",
  Action = "research", Value = "upgrade-haste", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "h", Hint = _("RESEARCH ~!HASTE"),
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-skeleton",
  Action = "research", Value = "upgrade-raise-dead", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "r", Hint = _("RESEARCH ~!RAISE DEAD"),
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-whirlwind",
  Action = "research", Value = "upgrade-whirlwind", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "w", Hint = _("RESEARCH ~!WHIRLWIND"),
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-unholy-armor",
  Action = "research", Value = "upgrade-unholy-armor", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "u", Hint = _("RESEARCH ~!UNHOLY ARMOR"),
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-death-and-decay",
  Action = "research", Value = "upgrade-death-and-decay", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "d", Hint = _("RESEARCH ~!DEATH AND DECAY"),
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-orc-ship-cannon2",
  Action = "research", Value = "upgrade-orc-ship-cannon1", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "c", Hint = _("UPGRADE ~!CANNONS (Damage +5)"),
  ForUnit = {"unit-orc-foundry"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-orc-ship-cannon3",
  Action = "research", Value = "upgrade-orc-ship-cannon2", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "c", Hint = _("UPGRADE ~!CANNONS (Damage +5)"),
  ForUnit = {"unit-orc-foundry"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-ship-armor2",
  Action = "research", Value = "upgrade-orc-ship-armor1", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "a", Hint = _("UPGRADE SHIP ~!ARMOR (Armor +5)"),
  ForUnit = {"unit-orc-foundry"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-ship-armor3",
  Action = "research", Value = "upgrade-orc-ship-armor2", Popup = "popup-orc-upgrade",
  Allowed = "check-single-research",
  Key = "a", Hint = _("UPGRADE SHIP ~!ARMOR (Armor +5)"),
  ForUnit = {"unit-orc-foundry"} } )
