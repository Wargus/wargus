--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--			  T H E   W A R   B E G I N S
--	   Stratagus - A free fantasy real time strategy game engine
--
--	buttons.ccl	-	Define the", "unit-buttons of the orc race.
--
--	(c) Copyright 2001-2003 by Vladi Belperchinov-Shabanski and Lutz Sammer
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
--	$Id$

-- general commands -- almost all units have it -------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peon",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-peon",
    "unit-fad-man", "unit-double-head",
    "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade", "unit-ice-bringer",
    "unit-evil-knight", "unit-skeleton", "unit-eye-of-vision", "unit-dragon",
    "unit-zeppelin", "unit-death-knight", "unit-fire-breeze",
    "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-shield1",
  Action = "stop",
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-peon",
    "unit-fad-man", "unit-double-head",
    "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade", "unit-ice-bringer",
    "unit-evil-knight", "unit-skeleton", "unit-eye-of-vision", "unit-dragon",
    "unit-zeppelin", "unit-death-knight", "unit-fire-breeze",
    "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-shield2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-shield1"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-shield3",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-shield2"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-peon",
    "unit-fad-man", "unit-double-head",
    "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade", "unit-ice-bringer",
    "unit-evil-knight", "unit-skeleton", "unit-dragon", "unit-fire-breeze",
    "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-battle-axe1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-battle-axe2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-quick-blade",
    "unit-beast-cry", "unit-fad-man", "unit-double-head"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-throwing-axe1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-axethrower", "unit-berserker", "unit-sharp-axe"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-throwing-axe2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-throwing-axe1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-axethrower", "unit-berserker", "unit-sharp-axe"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-throwing-axe3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-throwing-axe2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-axethrower", "unit-berserker", "unit-sharp-axe"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult1",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-catapult1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-catapult2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-catapult"} } )

if (extensions) then
DefineButton( { Pos = 4, Level = 0, Icon = "icon-mythical-patrol-land",
  Action = "patrol",
  Key = "p", Hint = "~!PATROL",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-fad-man",
    "unit-double-head", "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade",
    "unit-skeleton", "unit-dragon", "unit-fire-breeze", "orc-group", "unit-daemon",
    "unit-zeppelin", "unit-eye-of-vision"} } )
else
DefineButton( { Pos = 4, Level = 0, Icon = "icon-mythical-patrol-land",
  Action = "patrol",
  Key = "p", Hint = "~!PATROL",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-fad-man",
    "unit-double-head", "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade",
    "unit-skeleton", "unit-dragon", "unit-fire-breeze", "orc-group", "unit-daemon"} } )
end

DefineButton( { Pos = 5, Level = 0, Icon = "icon-mythical-stand-ground",
  Action = "stand-ground",
  Key = "t", Hint = "S~!TAND GROUND",
  ForUnit = {"unit-grunt", "unit-ogre", "unit-axethrower", "unit-ogre-mage",
    "unit-goblin-sappers", "unit-berserker", "unit-catapult", "unit-fad-man",
    "unit-double-head", "unit-sharp-axe", "unit-beast-cry", "unit-quick-blade",
    "unit-skeleton", "unit-dragon", "unit-fire-breeze", "unit-mythical-submarine",
    "unit-ogre-juggernaught", "unit-mythical-destroyer", "orc-group", "unit-daemon"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-mythical-attack-ground",
  Action = "attack-ground",
  Key = "g", Hint = "ATTACK ~!GROUND",
  ForUnit = {"unit-catapult", "unit-ogre-juggernaught", "orc-group"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-mythical-demolish",
  Action = "cast-spell", Value = "spell-suicide-bomber",
  Allowed = "check-true",
  Key = "d", Hint = "~!DEMOLISH",
  ForUnit = {"unit-goblin-sappers"} } )

-- ogre-mage specific actions -------------------------------------------------

DefineButton( { Pos = 7, Level = 0, Icon = "icon-eye-of-kilrogg",
  Action = "cast-spell", Value = "spell-eye-of-vision",
  Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
  Key = "k", Hint = "EYE OF ~!KILROGG",
  ForUnit = {"unit-ogre-mage", "unit-fad-man"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-bloodlust",
  Action = "cast-spell", Value = "spell-bloodlust",
  Allowed = "check-upgrade", AllowArg = {"upgrade-bloodlust"},
  Key = "b", Hint = "~!BLOODLUST",
  ForUnit = {"unit-ogre-mage", "unit-fad-man"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-runes",
  Action = "cast-spell", Value = "spell-runes",
  Allowed = "check-upgrade", AllowArg = {"upgrade-runes"},
  Key = "r", Hint = "~!RUNES",
  ForUnit = {"unit-ogre-mage", "unit-fad-man"} } )

-- cho'gall specific actions --- same as ogre mage but it has them always -----

DefineButton( { Pos = 7, Level = 0, Icon = "icon-eye-of-kilrogg",
  Action = "cast-spell", Value = "spell-eye-of-vision",
  Allowed = "check-true",
  Key = "k", Hint = "EYE OF ~!KILROGG",
  ForUnit = {"unit-double-head"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-bloodlust",
  Action = "cast-spell", Value = "spell-bloodlust",
  Allowed = "check-true",
  Key = "b", Hint = "~!BLOODLUST",
  ForUnit = {"unit-double-head"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-runes",
  Action = "cast-spell", Value = "spell-runes",
  Allowed = "check-true",
  Key = "r", Hint = "~!RUNES",
  ForUnit = {"unit-double-head"} } )

-- death-knight specific actions ----------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-touch-of-darkness",
  Action = "attack",
  Key = "a", Hint = "TOUCH OF D~!ARKNESS",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-death-coil",
  Action = "cast-spell", Value = "spell-death-coil",
  Allowed = "check-upgrade", AllowArg = {"upgrade-death-coil"},
  Key = "c", Hint = "DEATH ~!COIL",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-haste",
  Action = "cast-spell", Value = "spell-haste",
  Allowed = "check-upgrade", AllowArg = {"upgrade-haste"},
  Key = "h", Hint = "~!HASTE",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-raise-dead",
  Action = "cast-spell", Value = "spell-raise-dead",
  Allowed = "check-upgrade", AllowArg = {"upgrade-raise-dead"},
  Key = "r", Hint = "~!RAISE DEAD",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-whirlwind",
  Action = "cast-spell", Value = "spell-whirlwind",
  Allowed = "check-upgrade", AllowArg = {"upgrade-whirlwind"},
  Key = "w", Hint = "~!WHIRLWIND",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-unholy-armor",
  Action = "cast-spell", Value = "spell-unholy-armor",
  Allowed = "check-upgrade", AllowArg = {"upgrade-unholy-armor"},
  Key = "u", Hint = "~!UNHOLY ARMOR",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-death-and-decay",
  Action = "cast-spell", Value = "spell-death-and-decay",
  Allowed = "check-upgrade", AllowArg = {"upgrade-death-and-decay"},
  Key = "d", Hint = "~!DEATH AND DECAY",
  ForUnit = {"unit-death-knight", "unit-ice-bringer", "unit-evil-knight"} } )

-- peon specific actions ------------------------------------------------------

DefineButton( { Pos = 4, Level = 0, Icon = "icon-repair",
  Action = "repair",
  Key = "r", Hint = "~!REPAIR",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
  Action = "harvest",
  Key = "h", Hint = "~!HARVEST LUMBER/MINE GOLD",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-return-goods-peon",
  Action = "return-goods",
  Key = "g", Hint = "RETURN WITH ~!GOODS",
  ForUnit = {"unit-peon"} } )

-- build basic/advanced structs -----------------------------------------------

DefineButton( { Pos = 7, Level = 0, Icon = "icon-build-basic",
  Action = "button", Value = 1,
  Key = "b", Hint = "~!BUILD BASIC STRUCTURE",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-build-advanced",
  Action = "button", Value = 2,
  Allowed = "check-units-or", AllowArg = {"unit-troll-lumber-mill", "unit-stronghold"},
  Key = "v", Hint = "BUILD AD~!VANCED STRUCTURE",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-build-advanced",
  Action = "button", Value = 3,
  Allowed = "check-units-and", AllowArg = {"unit-fortress", "unit-temple-of-the-damned",
    "unit-altar-of-storms"},
  Key = "e", Hint = "BUILD SP~!ECIAL STRUCTURE",
  ForUnit = {"unit-peon"} } )

-- simple buildings orc -------------------------------------------------------

DefineButton( { Pos = 1, Level = 1, Icon = "icon-pig-farm",
  Action = "build", Value = "unit-pig-farm",
  Key = "f", Hint = "BUILD PIG ~!FARM",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 1, Icon = "icon-mythical-barracks",
  Action = "build", Value = "unit-mythical-barracks",
  Key = "b", Hint = "BUILD ~!BARRACKS",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 3, Level = 1, Icon = "icon-great-hall",
  Action = "build", Value = "unit-great-hall",
  Key = "h", Hint = "BUILD GREAT ~!HALL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 1, Icon = "icon-troll-lumber-mill",
  Action = "build", Value = "unit-troll-lumber-mill",
  Key = "l", Hint = "BUILD TROLL ~!LUMBER MILL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 1, Icon = "icon-mythical-blacksmith",
  Action = "build", Value = "unit-mythical-blacksmith",
  Key = "s", Hint = "BUILD BLACK~!SMITH",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 7, Level = 1, Icon = "icon-mythical-watch-tower",
  Action = "build", Value = "unit-mythical-watch-tower",
  Key = "t", Hint = "BUILD ~!TOWER",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 8, Level = 1, Icon = "icon-mythical-wall",
  Action = "build", Value = "unit-orc-wall",
  Allowed = "check-network",
  Key = "w", Hint = "BUILD ~!WALL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> CANCEL",
  ForUnit = {"unit-peon"} } )

-- orc advanced buildings -----------------------------------------------------

DefineButton( { Pos = 1, Level = 2, Icon = "icon-mythical-shipyard",
  Action = "build", Value = "unit-mythical-shipyard",
  Key = "s", Hint = "BUILD ~!SHIPYARD",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 2, Icon = "icon-mythical-foundry",
  Action = "build", Value = "unit-mythical-foundry",
  Key = "f", Hint = "BUILD ~!FOUNDRY",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 3, Level = 2, Icon = "icon-mythical-refinery",
  Action = "build", Value = "unit-orc-refinery",
  Key = "r", Hint = "BUILD ~!REFINERY",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 2, Icon = "icon-alchemist",
  Action = "build", Value = "unit-alchemist",
  Key = "a", Hint = "BUILD GOBLIN ~!ALCHEMIST",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 2, Icon = "icon-ogre-mound",
  Action = "build", Value = "unit-ogre-mound",
  Key = "o", Hint = "BUILD ~!OGRE MOUND",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 6, Level = 2, Icon = "icon-temple-of-the-damned",
  Action = "build", Value = "unit-temple-of-the-damned",
  Key = "t", Hint = "BUILD ~!TEMPLE OF THE DAMNED",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 7, Level = 2, Icon = "icon-altar-of-storms",
  Action = "build", Value = "unit-altar-of-storms",
  Key = "l", Hint = "BUILD A~!LTAR OF STORMS",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 8, Level = 2, Icon = "icon-dragon-roost",
  Action = "build", Value = "unit-dragon-roost",
  Key = "d", Hint = "BUILD ~!DRAGON ROOST",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> CANCEL",
  ForUnit = {"unit-peon"} } )

-- orc special buildings ------------------------------------------------------

DefineButton( { Pos = 1, Level = 3, Icon = "icon-dark-portal",
  Action = "build", Value = "unit-dark-portal",
  Allowed = "check-no-network",
  Key = "p", Hint = "BUILD DARK ~!PORTAL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 3, Icon = "icon-runestone",
  Action = "build", Value = "unit-runestone",
  Allowed = "check-no-network",
  Key = "r", Hint = "BUILD ~!RUNESTONE",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 9, Level = 3, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> CANCEL",
  ForUnit = {"unit-peon"} } )

-- orc buildings commands -----------------------------------------------------

if (extensions) then
DefineButton( { Pos = 1, Level = 0, Icon = "icon-critter",
  Action = "train-unit", Value = "unit-critter",
  Key = "c", Hint = "TRAIN ~!CRITTER",
  ForUnit = {"unit-pig-farm"} } )
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-peon",
  Action = "train-unit", Value = "unit-peon",
  Allowed = "check-no-research",
  Key = "p", Hint = "TRAIN ~!PEON",
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress"} } )

-- strong hold upgrades -------------------------------------------------------

DefineButton( { Pos = 2, Level = 0, Icon = "icon-stronghold",
  Action = "upgrade-to", Value = "unit-stronghold",
  Allowed = "check-upgrade-to",
  Key = "s", Hint = "UPGRADE TO ~!STRONGHOLD",
  ForUnit = {"unit-great-hall"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-fortress-upgrade",
  Action = "upgrade-to", Value = "unit-fortress",
  Allowed = "check-upgrade-to",
  Key = "f", Hint = "UPGRADE TO ~!FORTRESS",
  ForUnit = {"unit-stronghold"} } )

if (extensions) then
do
DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
  Action = "harvest",
  Key = "h", Hint = "SET ~!HARVEST LUMBER/MINE GOLD",
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-move-peon",
  Action = "move",
  Key = "m", Hint = "SET ~!MOVE",
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress",
    "unit-mythical-barracks", "unit-temple-of-the-damned", "unit-dragon-roost",
    "unit-alchemist"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-mythical-shield1",
  Action = "stop",
  Key = "z", Hint = "SET ~!ZTOP",
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress",
    "unit-mythical-barracks", "unit-temple-of-the-damned", "unit-dragon-roost",
    "unit-alchemist"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-battle-axe1",
  Action = "attack",
  Key = "e", Hint = "S~!ET ATTACK",
  ForUnit = {"unit-great-hall", "unit-stronghold", "unit-fortress",
    "unit-mythical-barracks", "unit-temple-of-the-damned", "unit-dragon-roost",
    "unit-alchemist"} } )
end
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-grunt",
  Action = "train-unit", Value = "unit-grunt",
  Key = "g", Hint = "TRAIN ~!GRUNT",
  ForUnit = {"unit-mythical-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-axethrower",
  Action = "train-unit", Value = "unit-axethrower",
  Key = "a", Hint = "TRAIN ~!AXETHROWER",
  ForUnit = {"unit-mythical-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-berserker",
  Action = "train-unit", Value = "unit-berserker",
  Key = "b", Hint = "TRAIN ~!BERSERKER",
  ForUnit = {"unit-mythical-barracks"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult",
  Action = "train-unit", Value = "unit-catapult",
  Key = "c", Hint = "BUILD ~!CATAPULT",
  ForUnit = {"unit-mythical-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-ogre",
  Action = "train-unit", Value = "unit-ogre",
  Key = "o", Hint = "TRAIN TWO-HEADED ~!OGRE",
  ForUnit = {"unit-mythical-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-ogre-mage",
  Action = "train-unit", Value = "unit-ogre-mage",
  Key = "o", Hint = "TRAIN ~!OGRE MAGE",
  ForUnit = {"unit-mythical-barracks"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-zeppelin",
  Action = "train-unit", Value = "unit-zeppelin",
  Key = "z", Hint = "BUILD GOBLIN ~!ZEPPELIN",
  ForUnit = {"unit-alchemist"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-goblin-sappers",
  Action = "train-unit", Value = "unit-goblin-sappers",
  Key = "s", Hint = "TRAIN GOBLIN ~!SAPPERS",
  ForUnit = {"unit-alchemist"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-death-knight",
  Action = "train-unit", Value = "unit-death-knight",
  Key = "t", Hint = "~!TRAIN DEATH KNIGHT",
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-dragon",
  Action = "train-unit", Value = "unit-dragon",
  Key = "d", Hint = "BUILD ~!DRAGON",
  ForUnit = {"unit-dragon-roost"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-mythical-oil-tanker",
  Action = "train-unit", Value = "unit-orc-oil-tanker",
  Key = "o", Hint = "BUILD ~!OIL TANKER",
  ForUnit = {"unit-mythical-shipyard"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-destroyer",
  Action = "train-unit", Value = "unit-mythical-destroyer",
  Key = "d", Hint = "BUILD ~!DESTROYER",
  ForUnit = {"unit-mythical-shipyard"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-mythical-transport",
  Action = "train-unit", Value = "unit-mythical-transport",
  Key = "t", Hint = "BUILD ~!TRANSPORT",
  ForUnit = {"unit-mythical-shipyard"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-giant-turtle",
  Action = "train-unit", Value = "unit-mythical-submarine",
  Key = "g", Hint = "BUILD ~!GIANT TURTLE",
  ForUnit = {"unit-mythical-shipyard"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-ogre-juggernaught",
  Action = "train-unit", Value = "unit-ogre-juggernaught",
  Key = "j", Hint = "BUILD ~!JUGGERNAUHGT",
  ForUnit = {"unit-mythical-shipyard"} } )

if (extensions) then
-----------------------------------------------------
DefineButton( { Pos = 6, Level = 0, Icon = "icon-mythical-ship-haul-oil",
  Action = "harvest",
  Key = "h", Hint = "SET ~!HAUL OIL",
  ForUnit = {"unit-mythical-shipyard"} } )
-----------------------------------------------------
end

DefineButton( { Pos = 1, Level = 0, Icon = "icon-mythical-guard-tower",
  Action = "upgrade-to", Value = "unit-mythical-guard-tower",
  Key = "g", Hint = "UPGRADE TO ~!GUARD TOWER",
  ForUnit = {"unit-mythical-watch-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-cannon-tower",
  Action = "upgrade-to", Value = "unit-mythical-cannon-tower",
  Key = "c", Hint = "UPGRADE TO ~!CANNON TOWER",
  ForUnit = {"unit-mythical-watch-tower"} } )

-- ships ----------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-mythical-ship-move",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = {"unit-orc-oil-tanker", "unit-mythical-submarine",
    "unit-ogre-juggernaught", "unit-mythical-destroyer", "unit-mythical-transport"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-ship-armor1",
  Action = "stop",
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-orc-oil-tanker", "unit-mythical-submarine",
    "unit-ogre-juggernaught", "unit-mythical-destroyer", "unit-mythical-transport"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-mythical-unload",
  Action = "unload",
  Key = "u", Hint = "~!UNLOAD",
  ForUnit = {"unit-mythical-transport"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-mythical-oil-platform",
  Action = "build", Value = "unit-mythical-oil-platform",
  Key = "b", Hint = "~!BUILD OIL PLATFORM",
  ForUnit = {"unit-orc-oil-tanker"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-mythical-ship-haul-oil",
  Action = "harvest",
  Key = "h", Hint = "~!HAUL OIL",
  ForUnit = {"unit-orc-oil-tanker"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-mythical-ship-return-oil",
  Action = "return-goods",
  Key = "g", Hint = "RETURN WITH ~!GOODS",
  ForUnit = {"unit-orc-oil-tanker"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-mythical-ship-cannon1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-mythical-submarine", "unit-ogre-juggernaught", "unit-mythical-destroyer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-mythical-ship-cannon2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-ship-cannon1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-mythical-submarine", "unit-ogre-juggernaught", "unit-mythical-destroyer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-mythical-ship-cannon3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-ship-cannon2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-mythical-submarine", "unit-ogre-juggernaught", "unit-mythical-destroyer"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-mythical-patrol-naval",
  Action = "patrol",
  Key = "p", Hint = "~!PATROL",
  ForUnit = {"unit-mythical-submarine", "unit-ogre-juggernaught", "unit-mythical-destroyer"} } )

if (extensions) then
do
DefineButton( { Pos = 7, Level = 0, Icon = "icon-mythical-ship-move",
  Action = "move",
  Key = "m", Hint = "SET ~!MOVE",
  ForUnit = {"unit-mythical-shipyard"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-mythical-ship-armor1",
  Action = "stop",
  Key = "z", Hint = "SET ~!ZTOP",
  ForUnit = {"unit-mythical-shipyard"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-mythical-ship-cannon1",
  Action = "attack",
  Key = "e", Hint = "S~!ET ATTACK",
  ForUnit = {"unit-mythical-shipyard"} } )
end
end

-- upgrades -------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-battle-axe2",
  Action = "research", Value = "upgrade-battle-axe1",
  Allowed = "check-single-research",
  Key = "w", Hint = "UPGRADE ~!WEAPONS (Damage +2)",
  ForUnit = {"unit-mythical-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-battle-axe3",
  Action = "research", Value = "upgrade-battle-axe2",
  Allowed = "check-single-research",
  Key = "w", Hint = "UPGRADE ~!WEAPONS (Damage +2)",
  ForUnit = {"unit-mythical-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-shield2",
  Action = "research", Value = "upgrade-orc-shield1",
  Allowed = "check-single-research",
  Key = "s", Hint = "UPGRADE ~!SHIELDS (Armor +2)",
  ForUnit = {"unit-mythical-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-shield3",
  Action = "research", Value = "upgrade-orc-shield2",
  Allowed = "check-single-research",
  Key = "s", Hint = "UPGRADE ~!SHIELDS (Armor +2)",
  ForUnit = {"unit-mythical-blacksmith"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult1",
  Action = "research", Value = "upgrade-catapult1",
  Allowed = "check-single-research",
  Key = "c", Hint = "UPGRADE ~!CATAPULT (Damage +15)",
  ForUnit = {"unit-mythical-blacksmith"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-catapult2",
  Action = "research", Value = "upgrade-catapult2",
  Allowed = "check-single-research",
  Key = "c", Hint = "UPGRADE ~!CATAPULT (Damage +15)",
  ForUnit = {"unit-mythical-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-throwing-axe2",
  Action = "research", Value = "upgrade-throwing-axe1",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!UPGRADE THROWING AXE (Damage +1)",
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-throwing-axe3",
  Action = "research", Value = "upgrade-throwing-axe2",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!UPGRADE THROWING AXE (Damage +1)",
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-berserker",
  Action = "research", Value = "upgrade-berserker",
  Allowed = "check-single-research",
  Key = "b", Hint = "TROLL ~!BERSERKER TRAINING",
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-berserker-scouting",
  Action = "research", Value = "upgrade-berserker-scouting",
  Allowed = "check-single-research",
  Key = "s", Hint = "BERSERKER ~!SCOUTING (Sight:9)",
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-light-axes",
  Action = "research", Value = "upgrade-light-axes",
  Allowed = "check-single-research",
  Key = "a", Hint = "RESEARCH LIGHTER ~!AXES (Range +1)",
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-berserker-regeneration",
  Action = "research", Value = "upgrade-berserker-regeneration",
  Allowed = "check-single-research",
  Key = "r", Hint = "BERSERKER ~!REGENERATION",
  ForUnit = {"unit-troll-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-ogre-mage",
  Action = "research", Value = "upgrade-ogre-mage",
  Allowed = "check-single-research",
  Key = "m", Hint = "UPGRADES OGRES TO ~!MAGES",
  ForUnit = {"unit-altar-of-storms"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-bloodlust",
  Action = "research", Value = "upgrade-bloodlust",
  Allowed = "check-single-research",
  Key = "b", Hint = "RESEARCH ~!BLOODLUST",
  ForUnit = {"unit-altar-of-storms"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-runes",
  Action = "research", Value = "upgrade-runes",
  Allowed = "check-single-research",
  Key = "r", Hint = "RESEARCH ~!RUNES",
  ForUnit = {"unit-altar-of-storms"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-haste",
  Action = "research", Value = "upgrade-haste",
  Allowed = "check-single-research",
  Key = "h", Hint = "RESEARCH ~!HASTE",
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-skeleton",
  Action = "research", Value = "upgrade-raise-dead",
  Allowed = "check-single-research",
  Key = "r", Hint = "RESEARCH ~!RAISE DEAD",
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-whirlwind",
  Action = "research", Value = "upgrade-whirlwind",
  Allowed = "check-single-research",
  Key = "w", Hint = "RESEARCH ~!WHIRLWIND",
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-unholy-armor",
  Action = "research", Value = "upgrade-unholy-armor",
  Allowed = "check-single-research",
  Key = "u", Hint = "RESEARCH ~!UNHOLY ARMOR",
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-death-and-decay",
  Action = "research", Value = "upgrade-death-and-decay",
  Allowed = "check-single-research",
  Key = "d", Hint = "RESEARCH ~!DEATH AND DECAY",
  ForUnit = {"unit-temple-of-the-damned"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-mythical-ship-cannon2",
  Action = "research", Value = "upgrade-orc-ship-cannon1",
  Allowed = "check-single-research",
  Key = "c", Hint = "UPGRADE ~!CANNONS (Damage +5)",
  ForUnit = {"unit-mythical-foundry"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-mythical-ship-cannon3",
  Action = "research", Value = "upgrade-orc-ship-cannon2",
  Allowed = "check-single-research",
  Key = "c", Hint = "UPGRADE ~!CANNONS (Damage +5)",
  ForUnit = {"unit-mythical-foundry"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-ship-armor2",
  Action = "research", Value = "upgrade-orc-ship-armor1",
  Allowed = "check-single-research",
  Key = "a", Hint = "UPGRADE SHIP ~!ARMOR (Armor +5)",
  ForUnit = {"unit-mythical-foundry"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-mythical-ship-armor3",
  Action = "research", Value = "upgrade-orc-ship-armor2",
  Allowed = "check-single-research",
  Key = "a", Hint = "UPGRADE SHIP ~!ARMOR (Armor +5)",
  ForUnit = {"unit-mythical-foundry"} } )
