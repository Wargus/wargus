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

UnitTypeFiles["unit-caanoo-townhall"] = {summer = "tilesets/summer/human/buildings/town_hall.png",
	winter = "tilesets/winter/human/buildings/town_hall.png",
	wasteland = "tilesets/summer/human/buildings/town_hall.png",
	swamp = "tilesets/swamp/human/buildings/town_hall.png"}

DefineUnitType("unit-caanoo-townhall", { Name = "Town Hall",
	Image = {"size", {128, 128}},
	Animations = "animations-building", Icon = "icon-town-hall",
	Costs = {"time", 255, "gold", 1200, "wood", 800},
	RepairHp = 4,
	RepairCosts = {"gold", 1, "wood", 1},
	Construction = "construction-land",
	Speed = 0,
	HitPoints = 1200,
	DrawLevel = 20,
	TileSize = {4, 4}, BoxSize = {126, 126},
	SightRange = 1,
	Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
	Priority = 35, AnnoyComputerFactor = 45,
	Points = 200,
	Supply = 1,
	Corpse = "unit-destroyed-4x4-place",
	ExplodeWhenKilled = "missile-explosion",
	Type = "land",
	Building = true, VisibleUnderFog = true,
	BuildingRules = { { "ontop", { Type = "unit-buildpoint-townhall", ReplaceOnDie = false, ReplaceOnBuild = true} } },
	CanStore = {"wood", "gold"},
	Sounds = {
		"selected", "town-hall-selected",
		"help", "basic human voices help 2",
		"dead", "building destroyed"} } )

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
