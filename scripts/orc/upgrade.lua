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

local upgrades = {
  {"upgrade-battle-axe1", "icon-battle-axe2",
    {   200,   500,   100,     0,     0,     0,     0}},
  {"upgrade-battle-axe2", "icon-battle-axe3",
    {   250,  1500,   300,     0,     0,     0,     0}},
  {"upgrade-throwing-axe1", "icon-throwing-axe2",
    {   200,   300,   300,     0,     0,     0,     0}},
  {"upgrade-throwing-axe2", "icon-throwing-axe3",
    {   250,   900,   500,     0,     0,     0,     0}},
  {"upgrade-orc-shield1", "icon-orc-shield2",
    {   200,   300,   300,     0,     0,     0,     0}},
  {"upgrade-orc-shield2", "icon-orc-shield3",
    {   250,   900,   500,     0,     0,     0,     0}},
  {"upgrade-orc-ship-cannon1", "icon-orc-ship-cannon2",
    {   200,   700,   100,  1000,     0,     0,     0}},
  {"upgrade-orc-ship-cannon2", "icon-orc-ship-cannon3",
    {   250,  2000,   250,  3000,     0,     0,     0}},
  {"upgrade-orc-ship-armor1", "icon-orc-ship-armor2",
    {   200,   500,   500,     0,     0,     0,     0}},
  {"upgrade-orc-ship-armor2", "icon-orc-ship-armor3",
    {   250,  1500,   900,     0,     0,     0,     0}},
  {"upgrade-catapult1", "icon-catapult1",
    {   250,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-catapult2", "icon-catapult2",
    {   250,  4000,     0,     0,     0,     0,     0}},
  {"upgrade-berserker", "icon-berserker",
    {   250,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-light-axes", "icon-light-axes",
    {   250,  2000,     0,     0,     0,     0,     0}},
  {"upgrade-berserker-scouting", "icon-berserker-scouting",
    {   250,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-berserker-regeneration", "icon-berserker-regeneration",
    {   250,  3000,     0,     0,     0,     0,     0}},
  {"upgrade-ogre-mage", "icon-ogre-mage",
    {   250,  1000,     0,     0,     0,     0,     0}},
  {"upgrade-eye-of-kilrogg", "icon-eye-of-kilrogg",
    {     0,     0,     0,     0,     0,     0,     0}},
  {"upgrade-bloodlust", "icon-bloodlust",
    {   100,  1000,     0,     0,     0,     0,     0}},
  {"upgrade-raise-dead", "icon-skeleton",
    {   100,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-death-coil", "icon-death-coil",
    {   100,     0,     0,     0,     0,     0,     0}},
  {"upgrade-whirlwind", "icon-whirlwind",
    {   150,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-haste", "icon-haste",
    {   100,   500,     0,     0,     0,     0,     0}},
  {"upgrade-unholy-armor", "icon-unholy-armor",
    {   200,  2500,     0,     0,     0,     0,     0}},
  {"upgrade-runes", "icon-runes",
    {   150,  1000,     0,     0,     0,     0,     0}},
  {"upgrade-death-and-decay", "icon-death-and-decay",
    {   200,  2000,     0,     0,     0,     0,     0}},
}

for i = 1,table.getn(upgrades) do
  u = CUpgrade:New(upgrades[i][1])
  u.Icon = Icons[upgrades[i][2]]
  for j = 1,table.getn(upgrades[i][3]) do
    u.Costs[j - 1] = upgrades[i][3][j]
  end
end


--	NOTE: Save can generate this table.

DefineModifier("upgrade-battle-axe1",
  {"Level", 1},
  {"PiercingDamage", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-battle-axe2",
  {"Level", 1},
  {"PiercingDamage", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-throwing-axe1",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"},
  {"apply-to", "unit-sharp-axe"})

DefineModifier("upgrade-throwing-axe2",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"},
  {"apply-to", "unit-sharp-axe"})

DefineModifier("upgrade-orc-shield1",
  {"Level", 1},
  {"Armor", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-orc-shield2",
  {"Level", 1},
  {"Armor", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-ogre"}, {"apply-to", "unit-ogre-mage"},
  {"apply-to", "unit-goblin-sappers"}, {"apply-to", "unit-quick-blade"},
  {"apply-to", "unit-beast-cry"}, {"apply-to", "unit-fad-man"},
  {"apply-to", "unit-double-head"})

DefineModifier("upgrade-orc-ship-cannon1",
  {"Level", 1},
  {"PiercingDamage", 5},
  {"apply-to", "unit-orc-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-orc-submarine"})

DefineModifier("upgrade-orc-ship-cannon2",
  {"Level", 1},
  {"PiercingDamage", 5},
  {"apply-to", "unit-orc-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-orc-submarine"})

DefineModifier("upgrade-orc-ship-armor1",
  {"Level", 1},
  {"Armor", 5},
  {"apply-to", "unit-orc-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-orc-transport"})

DefineModifier("upgrade-orc-ship-armor2",
  {"Level", 1},
  {"Armor", 5},
  {"apply-to", "unit-orc-destroyer"}, {"apply-to", "unit-ogre-juggernaught"},
  {"apply-to", "unit-orc-transport"})

DefineModifier("upgrade-catapult1",
  {"Level", 1},
  {"PiercingDamage", 15},
  {"apply-to", "unit-catapult"})

DefineModifier("upgrade-catapult2",
  {"Level", 1},
  {"PiercingDamage", 15},
  {"apply-to", "unit-catapult"})

DefineModifier("upgrade-berserker",
  {"apply-to", "unit-axethrower"}, {"convert-to", "unit-berserker"})

DefineModifier("upgrade-light-axes",
  {"Level", 1},
  {"SightRange", 1},
  {"AttackRange", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"})

DefineModifier("upgrade-berserker-scouting",
  {"Level", 1},
  {"SightRange", 3},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"})

DefineModifier("upgrade-berserker-regeneration",
  {"Level", 1},
  {"regeneration-rate", 1},
  {"apply-to", "unit-axethrower"}, {"apply-to", "unit-berserker"})

DefineModifier("upgrade-ogre-mage",
  {"Level", 1},
  {"apply-to", "unit-ogre"}, {"convert-to", "unit-ogre-mage"})

DefineModifier("upgrade-eye-of-kilrogg",
  {"Level", 1},
  {"apply-to", "unit-ogre-mage"})

DefineModifier("upgrade-bloodlust",
  {"Level", 1},
  {"apply-to", "unit-ogre-mage"})

DefineModifier("upgrade-runes",
  {"Level", 1},
  {"apply-to", "unit-ogre-mage"})

DefineModifier("upgrade-raise-dead",
  {"Level", 1},
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-death-coil",
  {"Level", 1},
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-whirlwind",
  {"Level", 1},
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-haste",
  {"Level", 1},
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-unholy-armor",
  {"Level", 1},
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

DefineModifier("upgrade-death-and-decay",
  {"Level", 1},
  {"apply-to", "unit-death-knight"}, {"apply-to", "unit-ice-bringer"},
  {"apply-to", "unit-evil-knight"})

--	NOTE: Save can generate this table.

InitFuncs:add(function()
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
  DefineAllow("unit-orc-transport",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-destroyer",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-ogre-juggernaught",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-fire-breeze",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-submarine",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-zeppelin",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-dragon",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-eye-of-vision",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-quick-blade",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-double-head",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-ice-bringer",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-sharp-axe",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-pig-farm",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-barracks",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-altar-of-storms",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-watch-tower",	"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-ogre-mound",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-alchemist",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-dragon-roost",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-shipyard",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-great-hall",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-troll-lumber-mill",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-foundry",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-temple-of-the-damned",	"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-blacksmith",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-refinery",		"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-oil-platform",	"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-stronghold",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-fortress",			"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-start-location",	"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-guard-tower",	"AAAAAAAAAAAAAAAA")
  DefineAllow("unit-orc-cannon-tower",	"AAAAAAAAAAAAAAAA")
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
end)

--	NOTE: Save can generate this table.

--- orc land forces
DefineDependency("unit-axethrower",
  {"unit-troll-lumber-mill"})
DefineDependency("unit-catapult",
  {"unit-orc-blacksmith", "unit-troll-lumber-mill"})
DefineDependency("unit-berserker",
  {"upgrade-berserker", "unit-troll-lumber-mill"})
DefineDependency("unit-ogre",
  {"unit-ogre-mound", "unit-orc-blacksmith"})
DefineDependency("unit-ogre-mage",
  {"upgrade-ogre-mage", "unit-ogre-mound", "unit-orc-blacksmith"})

--	- orc naval forces
DefineDependency("unit-orc-submarine",
  {"unit-alchemist"})
DefineDependency("unit-orc-transport",
  {"unit-orc-foundry"})
DefineDependency("unit-ogre-juggernaught",
  {"unit-orc-foundry"})

--	- orc air forces
DefineDependency("unit-zeppelin",
  {"unit-troll-lumber-mill"})

--- orc buildings
DefineDependency("unit-orc-guard-tower",
  {"unit-troll-lumber-mill"})
DefineDependency("unit-orc-cannon-tower",
  {"unit-orc-blacksmith"})
DefineDependency("unit-orc-shipyard",
  {"unit-troll-lumber-mill"})
DefineDependency("unit-orc-foundry",
  {"unit-orc-shipyard"})
DefineDependency("unit-orc-refinery",
  {"unit-orc-shipyard"})
DefineDependency("unit-stronghold",
  {"unit-orc-barracks"})
DefineDependency("unit-alchemist",
  {"unit-stronghold"},
  "or", {"unit-fortress"})
DefineDependency("unit-ogre-mound",
  {"unit-stronghold"},
  "or", {"unit-fortress"})
DefineDependency("unit-fortress",
  {"unit-ogre-mound", "unit-orc-blacksmith", "unit-troll-lumber-mill"})
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
  {"unit-stronghol", "upgrade-berserker"}, "or", {"unit-fortress", "upgrade-berserker"})
DefineDependency("upgrade-berserker-regeneration",
  {"unit-stronghol", "upgrade-berserker"}, "or", {"unit-fortress", "upgrade-berserker"})
DefineDependency("upgrade-light-axes",
  {"unit-stronghol", "upgrade-berserker"}, "or", {"unit-fortress", "upgrade-berserker"})

--- orc spells
-- DefineDependency("upgrade-eye-of-kilrogg",
--   {"upgrade-ogre-mage"})
DefineDependency("upgrade-bloodlust",
  {"upgrade-ogre-mage"})
DefineDependency("upgrade-runes",
  {"upgrade-ogre-mage"})

