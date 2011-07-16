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
--		caanoo-unit-oathbreaker.lua	-	Define the Oathbreaker hero
--
--		(c) Copyright 2011 by Kyran Jackson
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
--      Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--

DefineUnitType("unit-caanoo-wiseskeleton", { Name = "Wise Skeleton",
	Image = {"file", "orc/units/death_knight.png", "size", {72, 72}},
	Animations = "animations-death-knight", Icon = "icon-evil-knight",
	Costs = {"time", 120, "gold", 1200},
	Speed = 8,
	HitPoints = 60,
	DrawLevel = 40,
	MaxMana = 500,
	TileSize = {1, 1}, BoxSize = {39, 39},
	SightRange = 9, ComputerReactionRange = 11, PersonReactionRange = 9,
	BasicDamage = 0, PiercingDamage = 9, Missile = "missile-touch-of-death",
	MaxAttackRange = 3,
	Priority = 70,
	Points = 100,
	Demand = 1,
	Type = "land",
	RightMouseAction = "attack",
	CanAttack = true,
	CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
	CanCastSpell = {
		"spell-death-coil",
		"spell-haste",
		"spell-raise-dead",
		"spell-whirlwind",
		"spell-unholy-armor",
		"spell-death-and-decay"},
	LandUnit = true,
	Coward = true,
	isundead = true,
	organic = true,
	SelectableByRectangle = true,
	Sounds = {
		"selected", "death-knight-selected",
		"acknowledge", "death-knight-acknowledge",
		"ready", "death-knight-ready",
		"help", "basic orc voices help 1",
		"dead", "basic orc voices dead"} } )

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
	
DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "\27", Hint = "~<ESC~> CANCEL",
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

DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "\27", Hint = "~<ESC~> CANCEL",
	ForUnit = {"unit-caanoo-wiseskeleton"} } )	
		
DefineUnitType("unit-caanoo-wiseman", { Name = "Wise Man",
	Image = {"file", "human/units/mage.png", "size", {72, 72}},
	Animations = "animations-mage", Icon = "icon-mage",
	Costs = {"time", 120, "gold", 1200},
	Speed = 8,
	HitPoints = 60,
	DrawLevel = 40,
	MaxMana = 500,
	TileSize = {1, 1}, BoxSize = {33, 33},
	SightRange = 9, ComputerReactionRange = 11, PersonReactionRange = 9,
	BasicDamage = 0, PiercingDamage = 9, Missile = "missile-lightning",
	MaxAttackRange = 2,
	Priority = 70,
	Points = 100,
	Demand = 1,
	Type = "land",
	RightMouseAction = "attack",
	CanAttack = true,
	CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
	CanCastSpell = {
		"spell-fireball",
		"spell-slow",
		"spell-flame-shield",
		"spell-invisibility",
		"spell-polymorph",
		"spell-blizzard"},
	LandUnit = true,
	Coward = true,
	organic = true,
	SelectableByRectangle = true,
	Sounds = {
		"selected", "mage-selected",
		"acknowledge", "mage-acknowledge",
		"ready", "mage-ready",
		"help", "basic human voices help 1",
		"dead", "basic human voices dead"} } )

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
	
DefineButton( { Pos = 9, Level = 1, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "\27", Hint = "~<ESC~> CANCEL",
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

DefineButton( { Pos = 9, Level = 2, Icon = "icon-cancel",
	Action = "button", Value = 0,
	Key = "\27", Hint = "~<ESC~> CANCEL",
	ForUnit = {"unit-caanoo-wiseman"} } )	
	
-- Oathbreaker
	
DefineUnitType("unit-caanoo-oathbreaker", {
	Name = "Oathbreaker",
	Image = {"file", "human/units/footman.png", "size", {72, 72}},
	Animations = "animations-footman", Icon = "icon-footman",
	Costs = {"time", 60, "gold", 600},
	Speed = 10,
	HitPoints = 60,
	DrawLevel = 40,
	TileSize = {1, 1}, BoxSize = {31, 31},
	SightRange = 4, ComputerReactionRange = 6, PersonReactionRange = 4,
	Armor = 2, BasicDamage = 6, PiercingDamage = 3, Missile = "missile-none",
	MaxAttackRange = 1,
	Priority = 60,
	Points = 50,
	Demand = 1,
	CanCastSpell = {"spell-buildpoint-townhall"},
	MaxMana = 160,
	Corpse = "unit-human-dead-body",
	Type = "land",
	RightMouseAction = "attack",
	CanAttack = true,
	CanTargetLand = true,
	LandUnit = true,
	organic = true,
	SelectableByRectangle = true,
	Sounds = {
		"selected", "footman-selected",
		"acknowledge", "footman-acknowledge",
		"ready", "footman-ready",
		"help", "basic human voices help 1",
		"dead", "basic human voices dead"} } )

DefineAllow("unit-caanoo-oathbreaker",	"AAAAAAAAAAAAAAAA")
		
DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peasant",
	Action = "move",
	Key = "m", Hint = "~!MOVE",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
	Action = "stop",
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
	Action = "stop",
	Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield1"},
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-oathbreaker"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
	Action = "stop",
	Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield2"},
	Key = "s", Hint = "~!STOP",
	ForUnit = {"unit-caanoo-oathbreaker"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword1",
	Action = "attack",
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword2",
	Action = "attack",
	Allowed = "check-upgrade", AllowArg = {"upgrade-sword1"},
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-oathbreaker"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword3",
	Action = "attack",
	Allowed = "check-upgrade", AllowArg = {"upgrade-sword2"},
	Key = "a", Hint = "~!ATTACK",
	ForUnit = {"unit-caanoo-oathbreaker"} } )
  
DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-patrol-land",
	Action = "patrol",
	Key = "p", Hint = "~!PATROL",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman"} } )
  
DefineButton( { Pos = 5, Level = 0, Icon = "icon-human-stand-ground",
	Action = "stand-ground",
	Key = "t", Hint = "S~!TAND GROUND",
	ForUnit = {"unit-caanoo-oathbreaker", "unit-caanoo-wiseman"} } )
		
DefineButton( { Pos = 7, Level = 0, Icon = "icon-town-hall",
	Action = "cast-spell", Value = "spell-buildpoint-townhall",
	Allowed = "check-upgrade", AllowArg = {"upgrade-eye-of-kilrogg"},
	Key = "k", Hint = "EYE OF ~!KILROGG",
	ForUnit = {"unit-caanoo-oathbreaker"} } )
	
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