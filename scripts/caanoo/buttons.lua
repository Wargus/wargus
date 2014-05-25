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
--      (c) Copyright 2011 by Kyran Jackson
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

DefineAllow("unit-caanoo-wiseskeleton", "AAAAAAAAAAAAAAAA")
	
DefineButton( { Pos = 7, Level = 0, Icon = "icon-build-basic",
	Action = "button", Value = 1,
	Key = "b", Hint = "~!BUILD BASIC STRUCTURE",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-build-advanced",
	Action = "button", Value = 2,
	Key = "v", Hint = "BUILD AD~!VANCED STRUCTURE",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )
	
-- Basic Units
	
DefineButton( { Pos = 3, Level = 1, Icon = "icon-grunt",
	Action = "cast-spell", Value = "spell-unit-grunt",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "g", Hint = "~!GRUNT",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )
	
DefineButton( { Pos = 2, Level = 1, Icon = "icon-axethrower",
	Action = "cast-spell", Value = "spell-unit-axethrower",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "a", Hint = "TROLL ~!AXETHROWER",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 1, Level = 1, Icon = "icon-ogre",
	Action = "cast-spell", Value = "spell-unit-ogre",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "o", Hint = "~!OGRE",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 4, Level = 1, Icon = "icon-ogre-mage",
	Action = "cast-spell", Value = "spell-unit-ogre-mage",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "m", Hint = "OGRE ~!MAGE",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 5, Level = 1, Icon = "icon-berserker",
	Action = "cast-spell", Value = "spell-unit-berserker",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "b", Hint = "~!BERSERKER",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 6, Level = 1, Icon = "icon-quick-blade",
	Action = "cast-spell", Value = "spell-unit-quick-blade",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "b", Hint = "~!BLADE",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 7, Level = 1, Icon = "icon-fad-man",
	Action = "cast-spell", Value = "spell-unit-fad-man",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "r", Hint = "~!RIDER",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 8, Level = 1, Icon = "icon-sharp-axe",
	Action = "cast-spell", Value = "spell-unit-sharp-axe",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "s", Hint = "~!SHARP",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "ESC", Hint = "~<ESC~> CANCEL",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	

-- Advanced Units

DefineButton( { Pos = 2, Level = 2, Icon = "icon-goblin-sappers",
	Action = "cast-spell", Value = "spell-unit-goblin-sappers",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "s", Hint = "GOBLIN ~!SAPPERS",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	

DefineButton( { Pos = 1, Level = 2, Icon = "icon-death-knight",
	Action = "cast-spell", Value = "spell-unit-death-knight",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "k", Hint = "DEATH ~!KNIGHT",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	

DefineButton( { Pos = 3, Level = 2, Icon = "icon-catapult",
	Action = "cast-spell", Value = "spell-unit-catapult",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "c", Hint = "~!CATAPULT",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	

DefineButton( { Pos = 4, Level = 2, Icon = "icon-peon",
	Action = "cast-spell", Value = "spell-unit-peon",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "p", Hint = "~!PEON",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
	
DefineButton( { Pos = 6, Level = 2, Icon = "icon-skeleton",
	Action = "cast-spell", Value = "spell-unit-skeleton",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "u", Hint = "~!UNDEAD",
	ForUnit = {"unit-caanoo-wiseskeleton", "unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 8, Level = 2, Icon = "icon-dragon",
	Action = "cast-spell", Value = "spell-unit-dragon",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "d", Hint = "~!DRAGON",
	ForUnit = {"unit-caanoo-wiseskeleton", "unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "ESC", Hint = "~<ESC~> CANCEL",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
		


DefineAllow("unit-caanoo-wiseman", "AAAAAAAAAAAAAAAA")
	
DefineButton( { Pos = 7, Level = 0, Icon = "icon-build-basic",
	Action = "button", Value = 1,
	Key = "b", Hint = "~!BUILD BASIC STRUCTURE",
	ForUnit = {"unit-caanoo-wiseman"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-build-advanced",
	Action = "button", Value = 2,
	Key = "v", Hint = "BUILD AD~!VANCED STRUCTURE",
	ForUnit = {"unit-caanoo-wiseman"} } )
	
-- Basic Units
	
DefineButton( { Pos = 3, Level = 1, Icon = "icon-footman",
	Action = "cast-spell", Value = "spell-unit-footman",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "f", Hint = "~!FOOTMAN",
	ForUnit = {"unit-caanoo-wiseman"} } )
	
DefineButton( { Pos = 6, Level = 1, Icon = "icon-ugly-guy",
	Action = "cast-spell", Value = "spell-unit-arthor-literios",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "d", Hint = "~!DANATH",
	ForUnit = {"unit-caanoo-wiseman"} } )
	
DefineButton( { Pos = 2, Level = 1, Icon = "icon-archer",
	Action = "cast-spell", Value = "spell-unit-archer",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "a", Hint = "~!ARCHER",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 1, Level = 1, Icon = "icon-knight",
	Action = "cast-spell", Value = "spell-unit-knight",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "k", Hint = "~!KNIGHT",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 4, Level = 1, Icon = "icon-paladin",
	Action = "cast-spell", Value = "spell-unit-paladin",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "p", Hint = "~!PALADIN",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 5, Level = 1, Icon = "icon-ranger",
	Action = "cast-spell", Value = "spell-unit-ranger",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "r", Hint = "~!RANGER",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 7, Level = 1, Icon = "icon-knight-rider",
	Action = "cast-spell", Value = "spell-unit-knight-rider",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "h", Hint = "~!HERO",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 8, Level = 1, Icon = "icon-female-hero",
	Action = "cast-spell", Value = "spell-unit-female-hero",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "a", Hint = "~!ALLERIA",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "ESC", Hint = "~<ESC~> CANCEL",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
-- Advanced Units

DefineButton( { Pos = 2, Level = 2, Icon = "icon-dwarves",
	Action = "cast-spell", Value = "spell-unit-dwarves",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "d", Hint = "~!DWARVES",
	ForUnit = {"unit-caanoo-wiseman"} } )	

DefineButton( { Pos = 1, Level = 2, Icon = "icon-mage",
	Action = "cast-spell", Value = "spell-unit-mage",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "m", Hint = "~!MAGE",
	ForUnit = {"unit-caanoo-wiseman"} } )	

DefineButton( { Pos = 3, Level = 2, Icon = "icon-ballista",
	Action = "cast-spell", Value = "spell-unit-ballista",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "b", Hint = "~!BALLISTA",
	ForUnit = {"unit-caanoo-wiseman"} } )	

DefineButton( { Pos = 4, Level = 2, Icon = "icon-peasant",
	Action = "cast-spell", Value = "spell-unit-peasant",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "p", Hint = "~!PEASANT",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
DefineButton( { Pos = 8, Level = 2, Icon = "icon-gryphon-rider",
	Action = "cast-spell", Value = "spell-unit-gryphon-rider",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "g", Hint = "~!GRYPHON",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	

	
	
DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "ESC", Hint = "~<ESC~> CANCEL",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
-- Oathbreaker
	


DefineAllow("unit-caanoo-oathbreaker",	"AAAAAAAAAAAAAAAA")
		
DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peasant",
	Action = "move",
	Key = "m", Hint = "~!MOVE",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman", "unit-human-adventurer"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
	Action = "stop",
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman", "unit-human-adventurer"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
	Action = "stop",
	Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield1"},
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-human-adventurer"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
	Action = "stop",
	Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield2"},
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-human-adventurer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword1",
	Action = "attack",
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman", "unit-human-adventurer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword2",
	Action = "attack",
	Allowed = "check-upgrade", AllowArg = {"upgrade-sword1"},
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-human-adventurer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword3",
	Action = "attack",
	Allowed = "check-upgrade", AllowArg = {"upgrade-sword2"},
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-human-adventurer"} } )
  
DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-patrol-land",
	Action = "patrol",
	Key = "p", Hint = "~!PATROL",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman", "unit-human-adventurer"} } )
  
DefineButton( { Pos = 5, Level = 0, Icon = "icon-human-stand-ground",
	Action = "stand-ground",
	Key = "t", Hint = "S~!TAND GROUND",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman", "unit-human-adventurer"} } )
		
DefineButton( { Pos = 7, Level = 0, Icon = "icon-ranger",
	Action = "cast-spell", Value = "spell-buildpoint-townhall",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "r", Hint = "~!RANGER",
	ForUnit = {"unit-human-adventurer"} } )	
	
-- ORC general buttons

DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peon",
	Action = "move",
	Key = "m", Hint = "~!MOVE",
	ForUnit = {"unit-caanoo-wiseskeleton"}})

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield1",
	Action = "stop",
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-wiseskeleton"}})
	
DefineButton( { Pos = 3, Level = 0, Icon = "icon-battle-axe1",
	Action = "attack",
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-wiseskeleton"}})
	
DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-patrol-land",
	Action = "patrol",
	Key = "p", Hint = "~!PATROL",
	ForUnit = {"unit-caanoo-wiseskeleton"}})
	
DefineButton( { Pos = 5, Level = 0, Icon = "icon-orc-stand-ground",
	Action = "stand-ground",
	Key = "t", Hint = "S~!TAND GROUND",
	ForUnit = {"unit-caanoo-wiseskeleton"}})
	
DefineAllow("unit-caanoo-pioneer",	"AAAAAAAAAAAAAAAA")
		
DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peasant",
	Action = "move",
	Key = "m", Hint = "~!MOVE",
	ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
	Action = "stop",
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword1",
	Action = "attack",
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 7, Level = 0, Icon = "icon-build-basic",
	Action = "button", Value = 1,
	Key = "b", Hint = "~!BUILD BASIC STRUCTURE",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-build-advanced",
	Action = "button", Value = 2,
	Key = "v", Hint = "BUILD AD~!VANCED STRUCTURE",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-repair",
	Action = "repair",
	Key = "r", Hint = "~!REPAIR",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
	Action = "harvest",
	Key = "h", Hint = "~!HARVEST LUMBER/MINE GOLD",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-return-goods-peasant",
	Action = "return-goods",
	Key = "g", Hint = "RETURN WITH ~!GOODS",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 1, Level = 1, Icon = "icon-farm",
	Action = "build", Value = "unit-caanoo-farm",
	Key = "f", Hint = "BUILD ~!FARM",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 4, Level = 1, Icon = "icon-elven-lumber-mill",
  Action = "build", Value = "unit-caanoo-lumber-mill",
  Key = "l", Hint = "BUILD ~!LUMBER MILL",
  ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 2, Level = 1, Icon = "icon-human-barracks",
	Action = "build", Value = "unit-caanoo-barracks",
	Key = "b", Hint = "BUILD ~!BARRACKS",
	ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 3, Level = 1, Icon = "icon-town-hall",
	Action = "build", Value = "unit-caanoo-townhall",
	Key = "h", Hint = "BUILD TOWN ~!HALL",
	ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 4, Level = 2, Icon = "icon-gnomish-inventor",
  Action = "build", Value = "unit-caanoo-inventor",
  Key = "i", Hint = "BUILD GNOMISH ~!INVENTOR",
  ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 5, Level = 2, Icon = "icon-stables",
  Action = "build", Value = "unit-caanoo-stables",
  Key = "a", Hint = "BUILD ST~!ABLES",
  ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 6, Level = 2, Icon = "icon-mage-tower",
  Action = "build", Value = "unit-caanoo-mage-tower",
  Key = "m", Hint = "BUILD ~!MAGE TOWER",
  ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 7, Level = 2, Icon = "icon-church",
  Action = "build", Value = "unit-caanoo-church",
  Key = "c", Hint = "BUILD ~!CHURCH",
  ForUnit = {"unit-caanoo-pioneer"} } )
  
DefineButton( { Pos = 5, Level = 1, Icon = "icon-human-blacksmith",
  Action = "build", Value = "unit-caanoo-blacksmith",
  Key = "s", Hint = "BUILD BLACK~!SMITH",
  ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 8, Level = 2, Icon = "icon-gryphon-aviary",
  Action = "build", Value = "unit-caanoo-gryphon-aviary",
  Key = "g", Hint = "BUILD ~!GRYPHON AVIARY",
  ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "ESC", Hint = "~<ESC~> CANCEL",
  ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "ESC", Hint = "~<ESC~> CANCEL",
  ForUnit = {"unit-caanoo-pioneer"} } )

DefineAllow("unit-caanoo-blacksmith", "AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-lumber-mill", "AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-farm",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-barracks",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-stables",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-mage-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-church",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-gryphon-aviary",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-caanoo-townhall",	"AAAAAAAAAAAAAAAA")
			
DefineButton( { Pos = 1, Level = 0, Icon = "icon-peasant",
	Action = "train-unit", Value = "unit-peasant",
	Allowed = "check-no-research",
	Key = "p", Hint = "TRAIN ~!PEASANT",
	ForUnit = {"unit-caanoo-townhall"} } )
	
DefineButton( { Pos = 2, Level = 0, Icon = "icon-peasant",
	Action = "train-unit", Value = "unit-caanoo-pioneer",
	Allowed = "check-no-research",
	Key = "f", Hint = "TRAIN ~!PEASANT",
	ForUnit = {"unit-caanoo-townhall"} } )

if (wargus.extensions) then
do
DefineButton( { Pos = 5, Level = 0, Icon = "icon-harvest",
	Action = "harvest",
	Key = "h", Hint = "SET ~!HARVEST LUMBER/MINE GOLD",
	ForUnit = {"unit-caanoo-townhall"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-move-peasant",
	Action = "move",
	Key = "m", Hint = "SET ~!MOVE",
	ForUnit = {"unit-caanoo-townhall"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-human-shield1",
	Action = "stop",
	Key = "z", Hint = "SET ~!ZTOP",
	ForUnit = {"unit-caanoo-townhall"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-sword1",
	Action = "attack",
	Key = "e", Hint = "S~!ET ATTACK",
	ForUnit = {"unit-caanoo-townhall"} } )
end
end