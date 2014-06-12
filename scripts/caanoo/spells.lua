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
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

--  Declare some unit types used in spells. This is quite acceptable, the other
--  way would be to define can-cast-spell outside unit definitions, not much of an improvement.
DefineUnitType("unit-buildpoint-townhall", {})
DefineUnitType("unit-footman", {})
DefineUnitType("unit-archer", {})
DefineUnitType("unit-ballista", {})
DefineUnitType("unit-knight", {})
DefineUnitType("unit-mage", {})
DefineUnitType("unit-paladin", {})
DefineUnitType("unit-dwarves", {})
DefineUnitType("unit-dragon", {})
DefineUnitType("unit-female-hero", {})
DefineUnitType("unit-ranger", {})
DefineUnitType("unit-sharp-axe", {})
DefineUnitType("unit-grunt", {})
DefineUnitType("unit-gryphon-rider", {})
DefineUnitType("unit-peasant", {})
DefineUnitType("unit-peon", {})
DefineUnitType("unit-axethrower", {})
DefineUnitType("unit-catapult", {})
DefineUnitType("unit-ogre", {})
DefineUnitType("unit-death-knight", {})
DefineUnitType("unit-ogre-mage", {})
DefineUnitType("unit-goblin-sappers", {})
DefineUnitType("unit-berserker", {})
DefineUnitType("unit-arthor-literios", {})
DefineUnitType("unit-quick-blade", {})
DefineUnitType("unit-knight-rider", {})
DefineUnitType("unit-fad-man", {})
DefineUnitType("unit-attack-peasant", {})

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
	"manacost", 25,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-footman", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-archer",
	"showname", "Archer",
	"manacost", 25,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-archer", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ballista",
	"showname", "Ballista",
	"manacost", 125,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ballista", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-knight",
	"showname", "Knight",
	"manacost", 75,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-knight", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-female-hero",
	"showname", "Hero Archer",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-female-hero", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-knight-rider",
	"showname", "Hero Horseman",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-knight-rider", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-fad-man",
	"showname", "Hero Horseman",
	"manacost", 250,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-fad-man", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-arthor-literios",
	"showname", "Hero Soldier",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-arthor-literios", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-sharp-axe",
	"showname", "Hero Axethrower",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-sharp-axe", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-mage",
	"showname", "Mage",
	"manacost", 100,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-mage", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-paladin",
	"showname", "Paladin",
	"manacost", 125,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-paladin", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-dwarves",
	"showname", "Dwarves",
	"manacost", 150,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-dwarves", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-peasant",
	"showname", "Peasant",
	"manacost", 25,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-peasant", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ranger",
	"showname", "Ranger",
	"manacost", 50,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ranger", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-gryphon-rider",
	"showname", "Gryphon Rider",
	"manacost", 150,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-gryphon-rider", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-attack-peasant",
	"showname", "Minuteman",
	"manacost", 10,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-attack-peasant", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

-- Spawn Orc Units

DefineSpell("spell-unit-peon",
	"showname", "Peon",
	"manacost", 25,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-peon", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-grunt",
	"showname", "Grunt",
	"manacost", 25,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-grunt", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-axethrower",
	"showname", "Troll Axethrower",
	"manacost", 25,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-axethrower", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-catapult",
	"showname", "Catapult",
	"manacost", 125,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-catapult", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ogre",
	"showname", "Ogre",
	"manacost", 75,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ogre", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-death-knight",
	"showname", "Death Knight",
	"manacost", 100,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-death-knight", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-ogre-mage",
	"showname", "Ogre Mage",
	"manacost", 125,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ogre-mage", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-dragon",
	"showname", "Dragon",
	"manacost", 125,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-dragon", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-quick-blade",
	"showname", "Hero Soldier",
	"manacost", 200,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-quick-blade", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)


DefineSpell("spell-unit-goblin-sappers",
	"showname", "Goblin Sappers",
	"manacost", 150,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-goblin-sappers", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-berserker",
	"showname", "Berserker",
	"manacost", 50,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-berserker", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)

DefineSpell("spell-unit-skeleton",
	"showname", "Skeleton",
	"manacost", 10,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-skeleton", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", ""
)




-- Meh


DefineSpell("spell-aid",
	"showname", "First Aid",
	"manacost", 6,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-vitals", "hit-points", 1},
		{"spawn-missile", "missile", "missile-heal-effect",
			"start-point", {"base", "target"}}},
	"condition", {
		"organic", "only",
		"Building", "false",
		"HitPoints", {MaxValuePercent = 100}
	},
	"sound-when-cast", "healing",
	"autocast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}}
)