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
--	caanoo-spells.lua	-	Define the extra spells.
--
--	(c) Copyright 2011 by Kyran Jackson
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



DefineSpell("spell-buildpoint-townhall",
	"showname", "Townhall Foundation",
	"manacost", 70,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-buildpoint-townhall", "time-to-live", 5000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

-- Spawn Human Units

DefineSpell("spell-unit-footman",
	"showname", "Footman",
	"manacost", 50,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-footman", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-archer",
	"showname", "Archer",
	"manacost", 50,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-archer", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ballista",
	"showname", "Ballista",
	"manacost", 250,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ballista", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-knight",
	"showname", "Knight",
	"manacost", 150,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-knight", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-mage",
	"showname", "Mage",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-mage", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-paladin",
	"showname", "Paladin",
	"manacost", 250,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-paladin", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-dwarves",
	"showname", "Dwarves",
	"manacost", 300,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-dwarves", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ranger",
	"showname", "Ranger",
	"manacost", 100,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ranger", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

-- Spawn Orc Units

DefineSpell("spell-unit-grunt",
	"showname", "Grunt",
	"manacost", 50,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-grunt", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-axethrower",
	"showname", "Troll Axethrower",
	"manacost", 50,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-axethrower", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-catapult",
	"showname", "Catapult",
	"manacost", 250,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-catapult", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ogre",
	"showname", "Ogre",
	"manacost", 150,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ogre", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-death-knight",
	"showname", "Death Knight",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-death-knight", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ogre-mage",
	"showname", "Ogre Mage",
	"manacost", 250,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ogre-mage", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-goblin-sappers",
	"showname", "Goblin Sappers",
	"manacost", 300,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-goblin-sappers", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-berserker",
	"showname", "Berserker",
	"manacost", 100,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-berserker", "time-to-live", 55000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)
