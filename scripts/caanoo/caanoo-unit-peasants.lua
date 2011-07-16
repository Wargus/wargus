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
--		caanoo-unit-peasants.lua
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

DefineUnitType("unit-caanoo-pioneer", { Name = "Pioneer",
	Image = {"file", "human/units/peasant.png", "size", {72, 72}},
	DrawLevel = 19,
	Animations = "animations-peasant", Icon = "icon-peasant",
	Costs = {"time", 45, "gold", 400},
	Speed = 10,
	HitPoints = 30,
	DrawLevel = 40,
	TileSize = {1, 1}, BoxSize = {31, 31},
	SightRange = 4, ComputerReactionRange = 6, PersonReactionRange = 4,
	BasicDamage = 3, PiercingDamage = 2, Missile = "missile-none",
	MaxAttackRange = 1,
	Priority = 50,
	Points = 30,
	Demand = 1,
	Corpse = "unit-human-dead-body",
	Type = "land",
	RightMouseAction = "harvest",
	CanAttack = true, RepairRange = 1,
	CanTargetLand = true,
	LandUnit = true,
	Coward = true,
	CanGatherResources = {
		{"file-when-loaded", "human/units/peasant_with_gold.png",
		"resource-id", "gold",
		"resource-capacity", 100,
		"wait-at-resource", 150,
		"wait-at-depot", 150},
		{"file-when-loaded", "human/units/peasant_with_wood.png",
		"resource-id", "wood",
		"resource-capacity", 100,
		"resource-step", 2,
		"wait-at-resource", 24,
		"wait-at-depot", 150,
		"terrain-harvester"}},
	organic = true,
	SelectableByRectangle = true,
	Sounds = {
		"selected", "peasant-selected",
		"acknowledge", "peasant-acknowledge",
		"ready", "peasant-ready",
		"help", "basic human voices help 1",
		"dead", "basic human voices dead"} } )
		
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
	Allowed = "check-units-or", AllowArg = {"unit-elven-lumber-mill", "unit-keep"},
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
	Action = "build", Value = "unit-farm",
	Key = "f", Hint = "BUILD ~!FARM",
	ForUnit = {"unit-caanoo-pioneer"} } )

DefineButton( { Pos = 2, Level = 1, Icon = "icon-human-barracks",
	Action = "build", Value = "unit-human-barracks",
	Key = "b", Hint = "BUILD ~!BARRACKS",
	ForUnit = {"unit-caanoo-pioneer"} } )
	
DefineButton( { Pos = 3, Level = 1, Icon = "icon-town-hall",
	Action = "build", Value = "unit-caanoo-townhall",
	Key = "h", Hint = "BUILD TOWN ~!HALL",
	ForUnit = {"unit-caanoo-pioneer"} } )