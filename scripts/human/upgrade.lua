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
--	upgrade.ccl	-	Define the human dependencies and upgrades.
--
--	(c) Copyright 2001-2003 by Lutz Sammer
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

--	NOTE: Save can generate this table.

DefineUpgrade("upgrade-sword1", "icon", "icon-sword2",
  "costs", {   200,   800,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-sword2", "icon", "icon-sword3",
  "costs", {   250,  2400,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-arrow1", "icon", "icon-arrow2",
  "costs", {   200,   300,   300,     0,     0,     0,     0})
DefineUpgrade("upgrade-arrow2", "icon", "icon-arrow3",
  "costs", {   250,   900,   500,     0,     0,     0,     0})

DefineUpgrade("upgrade-human-shield1", "icon", "icon-human-shield2",
  "costs", {   200,   300,   300,     0,     0,     0,     0})
DefineUpgrade("upgrade-human-shield2", "icon", "icon-human-shield3",
  "costs", {   250,   900,   500,     0,     0,     0,     0})

DefineUpgrade("upgrade-human-ship-cannon1", "icon", "icon-human-ship-cannon2",
  "costs", {   200,   700,   100,  1000,     0,     0,     0})
DefineUpgrade("upgrade-human-ship-cannon2", "icon", "icon-human-ship-cannon3",
  "costs", {   250,  2000,   250,  3000,     0,     0,     0})
DefineUpgrade("upgrade-human-ship-armor1", "icon", "icon-human-ship-armor2",
  "costs", {   200,   500,   500,     0,     0,     0,     0})
DefineUpgrade("upgrade-human-ship-armor2", "icon", "icon-human-ship-armor3",
  "costs", {   250,  1500,   900,     0,     0,     0,     0})

DefineUpgrade("upgrade-ballista1", "icon", "icon-ballista1",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-ballista2", "icon", "icon-ballista2",
  "costs", {   250,  4000,     0,     0,     0,     0,     0})

DefineUpgrade("upgrade-ranger", "icon", "icon-ranger",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-longbow", "icon", "icon-longbow",
  "costs", {   250,  2000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-ranger-scouting", "icon", "icon-ranger-scouting",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-ranger-marksmanship", "icon", "icon-ranger-marksmanship",
  "costs", {   250,  2500,     0,     0,     0,     0,     0})

DefineUpgrade("upgrade-paladin", "icon", "icon-paladin",
  "costs", {   250,  1000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-holy-vision", "icon", "icon-holy-vision",
  "costs", {     0,     0,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-healing", "icon", "icon-heal",
  "costs", {   200,  1000,     0,     0,     0,     0,     0})
if (extensions) then
DefineUpgrade("upgrade-area-healing", "icon", "icon-heal",
  "costs", {   400,  2000,     0,     0,     0,     0,     0})
end
DefineUpgrade("upgrade-exorcism", "icon", "icon-exorcism",
  "costs", {   200,  2000,     0,     0,     0,     0,     0})

DefineUpgrade("upgrade-flame-shield", "icon", "icon-flame-shield",
  "costs", {   100,  1000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-fireball", "icon", "icon-fireball",
  "costs", {     0,     0,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-slow", "icon", "icon-slow",
  "costs", {   100,   500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-invisibility", "icon", "icon-invisibility",
  "costs", {   200,  2500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-polymorph", "icon", "icon-critter",
  "costs", {   200,  2000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-blizzard", "icon", "icon-blizzard",
  "costs", {   200,  2000,     0,     0,     0,     0,     0})

--	NOTE: Save can generate this table.

DefineModifier("upgrade-sword1",
  {"Level", 1},
  {"PiercingDamage", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"}, {"apply-to", "unit-paladin"},
  {"apply-to", "unit-dwarves"}, {"apply-to", "unit-arthor-literios"}, {"apply-to", "unit-wise-man"},
  {"apply-to", "unit-man-of-light"}, {"apply-to", "unit-knight-rider"})

DefineModifier("upgrade-sword2",
  {"Level", 1},
  {"PiercingDamage", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"}, {"apply-to", "unit-paladin"},
  {"apply-to", "unit-dwarves"}, {"apply-to", "unit-arthor-literios"}, {"apply-to", "unit-wise-man"},
  {"apply-to", "unit-man-of-light"}, {"apply-to", "unit-knight-rider"})

DefineModifier("upgrade-arrow1",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-archer"}, {"apply-to", "unit-ranger"}, {"apply-to", "unit-female-hero"})

DefineModifier("upgrade-arrow2",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-archer"}, {"apply-to", "unit-ranger"}, {"apply-to", "unit-female-hero"})

DefineModifier("upgrade-human-shield1",
  {"Level", 1},
  {"Armor", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"}, {"apply-to", "unit-paladin"},
  {"apply-to", "unit-dwarves"}, {"apply-to", "unit-arthor-literios"}, {"apply-to", "unit-wise-man"},
  {"apply-to", "unit-man-of-light"}, {"apply-to", "unit-knight-rider"})

DefineModifier("upgrade-human-shield2",
  {"Level", 1},
  {"Armor", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"}, {"apply-to", "unit-paladin"},
  {"apply-to", "unit-dwarves"}, {"apply-to", "unit-arthor-literios"}, {"apply-to", "unit-wise-man"},
  {"apply-to", "unit-man-of-light"}, {"apply-to", "unit-knight-rider"})

DefineModifier("upgrade-human-ship-cannon1",
  {"Level", 1},
  {"PiercingDamage", 5},
  {"apply-to", "unit-human-destroyer"}, {"apply-to", "unit-battleship"},
  {"apply-to", "unit-human-submarine"})

DefineModifier("upgrade-human-ship-cannon2",
  {"Level", 1},
  {"PiercingDamage", 5},
  {"apply-to", "unit-human-destroyer"}, {"apply-to", "unit-battleship"},
  {"apply-to", "unit-human-submarine"})

DefineModifier("upgrade-human-ship-armor1",
  {"Level", 1},
  {"Armor", 5},
  {"apply-to", "unit-human-destroyer"}, {"apply-to", "unit-battleship"},
  {"apply-to", "unit-human-transport"})

DefineModifier("upgrade-human-ship-armor2",
  {"Level", 1},
  {"Armor", 5},
  {"apply-to", "unit-human-destroyer"}, {"apply-to", "unit-battleship"},
  {"apply-to", "unit-human-transport"})

DefineModifier("upgrade-ballista1",
  {"Level", 1},
  {"PiercingDamage", 15},
  {"apply-to", "unit-ballista"})

DefineModifier("upgrade-ballista2",
  {"Level", 1},
  {"PiercingDamage", 15},
  {"apply-to", "unit-ballista"})

DefineModifier("upgrade-ranger",
  {"apply-to", "unit-archer"}, {"convert-to", "unit-ranger"})

DefineModifier("upgrade-longbow",
  {"Level", 1},
  {"SightRange", 1},
  {"AttackRange", 1},
  {"apply-to", "unit-archer"}, {"apply-to", "unit-ranger"})

DefineModifier("upgrade-ranger-scouting",
  {"Level", 1},
  {"SightRange", 3},
  {"apply-to", "unit-archer"}, {"apply-to", "unit-ranger"})

DefineModifier("upgrade-ranger-marksmanship",
  {"Level", 1},
  {"PiercingDamage", 3},
  {"apply-to", "unit-archer"}, {"apply-to", "unit-ranger"})

DefineModifier("upgrade-paladin",
  {"apply-to", "unit-knight"}, {"convert-to", "unit-paladin"})

DefineModifier("upgrade-holy-vision",
  {"Level", 1},
  {"apply-to", "unit-paladin"})

DefineModifier("upgrade-healing",
  {"Level", 1},
  {"apply-to", "unit-paladin"})

if (extensions) then
DefineModifier("upgrade-area-healing",
  {"Level", 1},
  {"apply-to", "unit-paladin"})
end

DefineModifier("upgrade-exorcism",
  {"Level", 1},
  {"apply-to", "unit-paladin"})

DefineModifier("upgrade-flame-shield",
  {"Level", 1},
  {"apply-to", "unit-mage"}, {"apply-to", "unit-white-mage"})

DefineModifier("upgrade-fireball",
  {"Level", 1},
  {"apply-to", "unit-mage"}, {"apply-to", "unit-white-mage"})

DefineModifier("upgrade-slow",
  {"Level", 1},
  {"apply-to", "unit-mage"}, {"apply-to", "unit-white-mage"})

DefineModifier("upgrade-invisibility",
  {"Level", 1},
  {"apply-to", "unit-mage"}, {"apply-to", "unit-white-mage"})

DefineModifier("upgrade-polymorph",
  {"Level", 1},
  {"apply-to", "unit-mage"}, {"apply-to", "unit-white-mage"})

DefineModifier("upgrade-blizzard",
  {"Level", 1},
  {"apply-to", "unit-mage"}, {"apply-to", "unit-white-mage"})

--	NOTE: Save can generate this table.

--- units

DefineAllow("unit-footman",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-peasant",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ballista",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-knight",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-archer",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mage",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-paladin",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-dwarves",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ranger",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-female-hero",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-flying-angel",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-white-mage",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-oil-tanker",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-transport",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-destroyer",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-battleship",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-submarine",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-balloon",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-gryphon-rider",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-knight-rider",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-arthor-literios",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-wise-man",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-man-of-light",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-farm",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-barracks",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-church",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-watch-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-stables",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-inventor",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-gryphon-aviary",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-shipyard",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-town-hall",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-elven-lumber-mill",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-foundry",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mage-tower",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-blacksmith",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-refinery",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-oil-platform",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-keep",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-castle",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-start-location",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-guard-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-cannon-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-wall",			"AAAAAAAAAAAAAAAA")

--- upgrades

DefineAllow("upgrade-sword1",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-sword2",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-arrow1",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-arrow2",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-shield1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-shield2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-ship-cannon1",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-ship-cannon2",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-ship-armor1",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-ship-armor2",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-ballista1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-ballista2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-ranger",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-longbow",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-ranger-scouting",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-ranger-marksmanship",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-paladin",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-holy-vision",		"RRRRRRRRRRRRRRRR")
DefineAllow("upgrade-healing",			"AAAAAAAAAAAAAAAA")
if (extensions) then
DefineAllow("upgrade-area-healing",		"FFFFFFFFFFFFFFFF")
-- JOHNS: engine didn't support it yet
--DefineAllow("upgrade-area-healing",		"AAAAAAAAAAAAAAAA")
end
DefineAllow("upgrade-exorcism",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-flame-shield",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-fireball",			"RRRRRRRRRRRRRRRR")
DefineAllow("upgrade-slow",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-invisibility",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-polymorph",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-blizzard",			"AAAAAAAAAAAAAAAA")

--	NOTE: Save can generate this table.

--- human land forces
DefineDependency("unit-archer",
  {"unit-elven-lumber-mill"})
DefineDependency("unit-ballista",
  {"unit-human-blacksmith", "unit-elven-lumber-mill"})
DefineDependency("unit-knight",
  {"unit-stables", "unit-human-blacksmith"})
DefineDependency("unit-ranger",
  {"upgrade-ranger", "unit-elven-lumber-mill"})
DefineDependency("unit-paladin",
  {"upgrade-paladin", "unit-stables", "unit-human-blacksmith"})

--- human naval forces
DefineDependency("unit-human-submarine",
  {"unit-inventor"})
DefineDependency("unit-human-transport",
  {"unit-human-foundry"})
DefineDependency("unit-battleship",
  {"unit-human-foundry"})

--	- human air forces
DefineDependency("unit-balloon",
  {"unit-elven-lumber-mill"})

--- human buildings
DefineDependency("unit-human-guard-tower",
  {"unit-elven-lumber-mill"})
DefineDependency("unit-human-cannon-tower",
  {"unit-human-blacksmith"})
DefineDependency("unit-human-shipyard",
  {"unit-elven-lumber-mill"})
DefineDependency("unit-human-foundry",
  {"unit-human-shipyard"})
DefineDependency("unit-human-refinery",
  {"unit-human-shipyard"})
DefineDependency("unit-keep",
  {"unit-human-barracks"})
DefineDependency("unit-inventor",
  {"unit-castle"},
  "or", {"unit-keep"})
DefineDependency("unit-stables",
  {"unit-castle"},
  "or", {"unit-keep"})
DefineDependency("unit-castle",
  {"unit-stables", "unit-human-blacksmith", "unit-elven-lumber-mill"})
DefineDependency("unit-mage-tower",
  {"unit-castle"})
DefineDependency("unit-church",
  {"unit-castle"})
DefineDependency("unit-gryphon-aviary",
  {"unit-castle"})

--- human upgrades/research
DefineDependency("upgrade-sword2",
  {"upgrade-sword1"})
DefineDependency("upgrade-arrow2",
  {"upgrade-arrow1"})
DefineDependency("upgrade-human-shield2",
  {"upgrade-human-shield1"})
DefineDependency("upgrade-ballista2",
  {"upgrade-ballista1"})
DefineDependency("upgrade-human-ship-cannon2",
  {"upgrade-human-ship-cannon1"})
DefineDependency("upgrade-human-ship-armor2",
  {"upgrade-human-ship-armor1"})
DefineDependency("upgrade-ranger",
  {"unit-keep"},
  "or", {"unit-castle"})
DefineDependency("upgrade-longbow",
  {"unit-castle", "upgrade-ranger"})
DefineDependency("upgrade-ranger-scouting",
  {"unit-castle", "upgrade-ranger"})
DefineDependency("upgrade-ranger-marksmanship",
  {"unit-castle", "upgrade-ranger"})

--- human spells
DefineDependency("upgrade-holy-vision",
  {"upgrade-paladin"})
DefineDependency("upgrade-healing",
  {"upgrade-paladin"})
if (extensions) then
DefineDependency("upgrade-area-healing",
  {"upgrade-paladin", "upgrade-healing"})
end
DefineDependency("upgrade-exorcism",
  {"upgrade-paladin"})
