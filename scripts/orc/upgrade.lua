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
--	upgrade.ccl	-	Define the orcish dependencies and upgrades.
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

DefineUpgrade("upgrade-battle-axe1", "icon", "icon-battle-axe2",
  "costs", {   200,   500,   100,     0,     0,     0,     0})
DefineUpgrade("upgrade-battle-axe2", "icon", "icon-battle-axe3",
  "costs", {   250,  1500,   300,     0,     0,     0,     0})
DefineUpgrade("upgrade-throwing-axe1", "icon", "icon-throwing-axe2",
  "costs", {   200,   300,   300,     0,     0,     0,     0})
DefineUpgrade("upgrade-throwing-axe2", "icon", "icon-throwing-axe3",
  "costs", {   250,   900,   500,     0,     0,     0,     0})
DefineUpgrade("upgrade-orc-shield1", "icon", "icon-mythical-shield2",
  "costs", {   200,   300,   300,     0,     0,     0,     0})
DefineUpgrade("upgrade-orc-shield2", "icon", "icon-mythical-shield3",
  "costs", {   250,   900,   500,     0,     0,     0,     0})
DefineUpgrade("upgrade-orc-ship-cannon1", "icon", "icon-mythical-ship-cannon2",
  "costs", {   200,   700,   100,  1000,     0,     0,     0})
DefineUpgrade("upgrade-orc-ship-cannon2", "icon", "icon-mythical-ship-cannon3",
  "costs", {   250,  2000,   250,  3000,     0,     0,     0})
DefineUpgrade("upgrade-orc-ship-armor1", "icon", "icon-mythical-ship-armor2",
  "costs", {   200,   500,   500,     0,     0,     0,     0})
DefineUpgrade("upgrade-orc-ship-armor2", "icon", "icon-mythical-ship-armor3",
  "costs", {   250,  1500,   900,     0,     0,     0,     0})
DefineUpgrade("upgrade-catapult1", "icon", "icon-catapult1",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-catapult2", "icon", "icon-catapult2",
  "costs", {   250,  4000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-berserker", "icon", "icon-berserker",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-light-axes", "icon", "icon-light-axes",
  "costs", {   250,  2000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-berserker-scouting", "icon", "icon-berserker-scouting",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-berserker-regeneration",
  "icon", "icon-berserker-regeneration",
  "costs", {   250,  3000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-ogre-mage", "icon", "icon-ogre-mage",
  "costs", {   250,  1000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-eye-of-kilrogg", "icon", "icon-eye-of-kilrogg",
  "costs", {     0,     0,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-bloodlust", "icon", "icon-bloodlust",
  "costs", {   100,  1000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-raise-dead", "icon", "icon-skeleton",
  "costs", {   100,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-death-coil", "icon", "icon-death-coil",
  "costs", {   100,     0,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-whirlwind", "icon", "icon-whirlwind",
  "costs", {   150,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-haste", "icon", "icon-haste",
  "costs", {   100,   500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-unholy-armor", "icon", "icon-unholy-armor",
  "costs", {   200,  2500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-runes", "icon", "icon-runes",
  "costs", {   150,  1000,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-death-and-decay", "icon", "icon-death-and-decay",
  "costs", {   200,  2000,     0,     0,     0,     0,     0})

--	NOTE: Save can generate this table.

DefineModifier("upgrade-battle-axe1",
  {"piercing-damage", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-battle-axe2",
  {"piercing-damage", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-throwing-axe1",
  {"piercing-damage", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"},
  {"apply-to", "unit-sharp-axe"})

DefineModifier("upgrade-throwing-axe2",
  {"piercing-damage", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"},
  {"apply-to", "unit-sharp-axe"})

DefineModifier("upgrade-orc-shield1",
  {"armor", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-orc-shield2",
  {"armor", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-orc-ship-cannon1",
  {"piercing-damage", 5},
  {"apply-to", "unit-mythical-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-mythical-submarine"})

DefineModifier("upgrade-orc-ship-cannon2",
  {"piercing-damage", 5},
  {"apply-to", "unit-mythical-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-mythical-submarine"})

DefineModifier("upgrade-orc-ship-armor1",
  {"armor", 5},
  {"apply-to", "unit-mythical-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-mythical-transport"})

DefineModifier("upgrade-orc-ship-armor2",
  {"armor", 5},
  {"apply-to", "unit-mythical-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-mythical-transport"})

DefineModifier("upgrade-catapult1",
  {"piercing-damage", 15},
  {"apply-to", "unit-catapult"})

DefineModifier("upgrade-catapult2",
  {"piercing-damage", 15},
  {"apply-to", "unit-catapult"})

DefineModifier("upgrade-berserker",
  {"apply-to", "unit-axethrower"}, {"convert-to unit-berserker"})

DefineModifier("upgrade-light-axes",
  {"sight-range", 1},
  {"attack-range", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"})

DefineModifier("upgrade-berserker-scouting",
  {"sight-range", 3},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"})

DefineModifier("upgrade-berserker-regeneration",
  {"regeneration-rate", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"})

DefineModifier("upgrade-ogre-mage",
  {"apply-to", "unit-ogre"}, {"convert-to unit-ogre-mage"})

DefineModifier("upgrade-eye-of-kilrogg",
  {"apply-to", "unit-ogre-mage"})

DefineModifier("upgrade-bloodlust",
  {"apply-to", "unit-ogre-mage"})

DefineModifier("upgrade-runes",
  {"apply-to", "unit-ogre-mage"})

DefineModifier("upgrade-raise-dead",
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-death-coil",
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-whirlwind",
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-haste",
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-unholy-armor",
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-death-and-decay",
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

--	NOTE: Save can generate this table.

DefineAllow("unit-grunt",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-peon",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-catapult",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ogre",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-axethrower",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-death-knight",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ogre-mage",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-goblin-sappers",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-berserker",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-evil-knight",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-fad-man",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-beast-cry",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-oil-tanker",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-transport",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-destroyer",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ogre-juggernaught",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-fire-breeze",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-submarine",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-zeppelin",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-dragon",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-eye-of-vision",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-quick-blade",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-double-head",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ice-bringer",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-sharp-axe",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-pig-farm",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-barracks",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-altar-of-storms",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-watch-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-ogre-mound",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-alchemist",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-dragon-roost",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-shipyard",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-great-hall",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-troll-lumber-mill",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-foundry",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-temple-of-the-damned",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-blacksmith",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-refinery",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-oil-platform",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-stronghold",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-fortress",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-start-location",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-guard-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-mythical-cannon-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-wall",			"AAAAAAAAAAAAAAAA")

--- upgrades

DefineAllow("upgrade-battle-axe1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-battle-axe2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-throwing-axe1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-throwing-axe2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-shield1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-shield2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-ship-cannon1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-ship-cannon2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-ship-armor1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-ship-armor2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-catapult1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-catapult2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-berserker",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-light-axes",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-berserker-scouting",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-berserker-regeneration",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-ogre-mage",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-eye-of-kilrogg",		"RRRRRRRRRRRRRRRR")
DefineAllow("upgrade-bloodlust",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-raise-dead",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-death-coil",		"RRRRRRRRRRRRRRRR")
DefineAllow("upgrade-whirlwind",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-haste",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-unholy-armor",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-runes",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-death-and-decay",		"AAAAAAAAAAAAAAAA")

--	NOTE: Save can generate this table.

--- orc land forces
DefineDependency("unit-axethrower",
  {"unit-troll-lumber-mill"})
DefineDependency("unit-catapult",
  {"unit-mythical-blacksmith", "unit-troll-lumber-mill"})
DefineDependency("unit-berserker",
  {"upgrade-berserker", "unit-troll-lumber-mill"})
DefineDependency("unit-ogre",
  {"unit-ogre-mound", "unit-mythical-blacksmith"})
DefineDependency("unit-ogre-mage",
  {"upgrade-ogre-mage", "unit-ogre-mound", "unit-mythical-blacksmith"})

--	- orc naval forces
DefineDependency("unit-mythical-submarine",
  {"unit-alchemist"})
DefineDependency("unit-mythical-transport",
  {"unit-mythical-foundry"})
DefineDependency("unit-ogre-juggernaught",
  {"unit-mythical-foundry"})

--	- orc air forces
DefineDependency("unit-zeppelin",
  {"unit-troll-lumber-mill"})

--- orc buildings
DefineDependency("unit-mythical-guard-tower",
  {"unit-troll-lumber-mill"})
DefineDependency("unit-mythical-cannon-tower",
  {"unit-mythical-blacksmith"})
DefineDependency("unit-mythical-shipyard",
  {"unit-troll-lumber-mill"})
DefineDependency("unit-mythical-foundry",
  {"unit-mythical-shipyard"})
DefineDependency("unit-orc-refinery",
  {"unit-mythical-shipyard"})
DefineDependency("unit-stronghold",
  {"unit-mythical-barracks"})
DefineDependency("unit-alchemist",
  {"unit-stronghold"},
  "or", {"unit-fortress"})
DefineDependency("unit-ogre-mound",
  {"unit-stronghold"},
  "or", {"unit-fortress"})
DefineDependency("unit-fortress",
  {"unit-ogre-mound", "unit-mythical-blacksmith", "unit-troll-lumber-mill"})
DefineDependency("unit-altar-of-storms",
  {"unit-fortress"})
DefineDependency("unit-temple-of-the-damned",
  {"unit-fortress"})
DefineDependency("unit-dragon-roost",
  {"unit-fortress"})

--- orc upgrades/research
DefineDependency("upgrade-battle-axe2",
  {"upgrade-battle-axe1"})
DefineDependency("upgrade-throwing-axe2",
  {"upgrade-throwing-axe1"})
DefineDependency("upgrade-orc-shield2",
  {"upgrade-orc-shield1"})
DefineDependency("upgrade-catapult2",
  {"upgrade-catapult1"})
DefineDependency("upgrade-orc-ship-cannon2",
  {"upgrade-orc-ship-cannon1"})
DefineDependency("upgrade-orc-ship-armor2",
  {"upgrade-orc-ship-armor1"})
DefineDependency("upgrade-berserker",
  {"unit-stronghold"},
  "or", {"unit-fortress"})
DefineDependency("upgrade-berserker-scouting",
  {"unit-fortress upgrade-berserker"})
DefineDependency("upgrade-berserker-regeneration",
  {"unit-fortress", "upgrade-berserker"})
DefineDependency("upgrade-light-axes",
  {"unit-fortress", "upgrade-berserker"})

--- orc spells
DefineDependency("upgrade-eye-of-kilrogg",
  {"upgrade-ogre-mage"})
DefineDependency("upgrade-bloodlust",
  {"upgrade-ogre-mage"})
DefineDependency("upgrade-runes",
  {"upgrade-ogre-mage"})
