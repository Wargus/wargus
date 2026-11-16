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

DefineUnitType("unit-buildpoint-townhall", {})
DefineUnitType("unit-footman", {})
DefineUnitType("unit-archer", {})
DefineUnitType("unit-ballista", {})
DefineUnitType("unit-knight", {})
DefineUnitType("unit-mage", {})
DefineUnitType("unit-paladin", {})
DefineUnitType("unit-nomad", {})
DefineUnitType("unit-yeoman", {})
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
	"sound-when-cast", "eye of vision"
)


-- Spawn Human Units

unit = "unit-footman"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-footman",
	"showname", "Footman",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-yeoman"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-yeoman",
	"showname", "Yeoman",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-archer"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-archer",
	"showname", "Archer",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-ballista"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-ballista",
	"showname", "Ballista",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-knight"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-knight",
	"showname", "Knight",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-female-hero"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-female-hero",
	"showname", "Hero Archer",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-knight-rider"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-knight-rider",
	"showname", "Hero Horseman",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-arthor-literios"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-arthor-literios",
	"showname", "Hero Soldier",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-mage"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-mage",
	"showname", "Mage",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-paladin"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-paladin",
	"showname", "Paladin",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-dwarves"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-dwarves",
	"showname", "Dwarves",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-peasant"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-peasant",
	"showname", "Peasant",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-ranger"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-ranger",
	"showname", "Ranger",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-gryphon-rider"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-gryphon-rider",
	"showname", "Gryphon Rider",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-attack-peasant"
index = UnitDatabaseSetup("human", unit)
DefineSpell("spell-unit-attack-peasant",
	"showname", "Minuteman",
	"res-cost", {0, UnitDatabase["human"][index]["CastGold"], UnitDatabase["human"][index]["CastWood"], UnitDatabase["human"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

-- Spawn Orc Units

unit = "unit-sharp-axe"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-sharp-axe",
	"showname", "Hero Axethrower",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-fad-man"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-fad-man",
	"showname", "Hero Horseman",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-peon"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-peon",
	"showname", "Peon",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-grunt"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-grunt",
	"showname", "Grunt",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-axethrower"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-axethrower",
	"showname", "Troll Axethrower",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-catapult"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-catapult",
	"showname", "Catapult",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-ogre"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-ogre",
	"showname", "Ogre",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-death-knight"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-death-knight",
	"showname", "Death Knight",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-ogre-mage"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-ogre-mage",
	"showname", "Ogre Mage",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-dragon"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-dragon",
	"showname", "Dragon",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-quick-blade"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-quick-blade",
	"showname", "Hero Soldier",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-goblin-sappers"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-goblin-sappers",
	"showname", "Goblin Sappers",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-berserker"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-berserker",
	"showname", "Berserker",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-skeleton"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-skeleton",
	"showname", "Skeleton",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

unit = "unit-nomad"
index = UnitDatabaseSetup("orc", unit)
DefineSpell("spell-unit-nomad",
	"showname", "Nomad",
	"res-cost", {0, UnitDatabase["orc"][index]["CastGold"], UnitDatabase["orc"][index]["CastWood"], UnitDatabase["orc"][index]["CastOil"], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", unit, "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
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