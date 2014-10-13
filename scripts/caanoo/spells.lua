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

Load("scripts/ai/ai_redribbon_2014.lua")
AiRedRibbon_Setup_Units_2014()

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

DefineSpell("spell-unit-footman",
	"showname", "Footman",
	"res-cost", {0, ftm_cost_gold[1], ftm_cost_wood[1], ftm_cost_oil[1], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-footman", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-yeoman",
	"showname", "Yeoman",
	"res-cost", {0, ftm_cost_gold[12], ftm_cost_wood[12], ftm_cost_oil[12], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-yeoman", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-archer",
	"showname", "Archer",
	"res-cost", {0, ftm_cost_gold[3], ftm_cost_wood[3], ftm_cost_oil[3], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-archer", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-ballista",
	"showname", "Ballista",
	"res-cost", {0, ftm_cost_gold[9], ftm_cost_wood[9], ftm_cost_oil[9], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ballista", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-knight",
	"showname", "Knight",
	"res-cost", {0, ftm_cost_gold[6], ftm_cost_wood[6], ftm_cost_oil[6], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-knight", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-female-hero",
	"showname", "Hero Archer",
	"res-cost", {0, ftm_cost_gold[5], ftm_cost_wood[5], ftm_cost_oil[5], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-female-hero", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-knight-rider",
	"showname", "Hero Horseman",
	"res-cost", {0, ftm_cost_gold[8], ftm_cost_wood[8], ftm_cost_oil[8], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-knight-rider", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-arthor-literios",
	"showname", "Hero Soldier",
	"res-cost", {0, ftm_cost_gold[2], ftm_cost_wood[2], ftm_cost_oil[2], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-arthor-literios", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-sharp-axe",
	"showname", "Hero Axethrower",
	"res-cost", {0, ftm_cost_gold[55], ftm_cost_wood[55], ftm_cost_oil[55], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-sharp-axe", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-mage",
	"showname", "Mage",
	"res-cost", {0, ftm_cost_gold[14], ftm_cost_wood[14], ftm_cost_oil[14], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-mage", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-paladin",
	"showname", "Paladin",
	"res-cost", {0, ftm_cost_gold[7], ftm_cost_wood[7], ftm_cost_oil[7], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-paladin", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-dwarves",
	"showname", "Dwarves",
	"res-cost", {0, ftm_cost_gold[11], ftm_cost_wood[11], ftm_cost_oil[11], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-dwarves", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-peasant",
	"showname", "Peasant",
	"res-cost", {0, ftm_cost_gold[15], ftm_cost_wood[15], ftm_cost_oil[15], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-peasant", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-ranger",
	"showname", "Ranger",
	"res-cost", {0, ftm_cost_gold[4], ftm_cost_wood[4], ftm_cost_oil[4], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ranger", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-gryphon-rider",
	"showname", "Gryphon Rider",
	"res-cost", {0, ftm_cost_gold[13], ftm_cost_wood[13], ftm_cost_oil[13], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-gryphon-rider", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-attack-peasant",
	"showname", "Minuteman",
	"res-cost", {0, ftm_cost_gold[10], ftm_cost_wood[10], ftm_cost_oil[10], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-attack-peasant", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

-- Spawn Orc Units

DefineSpell("spell-unit-fad-man",
	"showname", "Hero Horseman",
	"res-cost", {0, ftm_cost_gold[58], ftm_cost_wood[58], ftm_cost_oil[58], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-fad-man", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-peon",
	"showname", "Peon",
	"res-cost", {0, ftm_cost_gold[65], ftm_cost_wood[65], ftm_cost_oil[65], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-peon", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-grunt",
	"showname", "Grunt",
	"res-cost", {0, ftm_cost_gold[51], ftm_cost_wood[51], ftm_cost_oil[51], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-grunt", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-axethrower",
	"showname", "Troll Axethrower",
	"res-cost", {0, ftm_cost_gold[53], ftm_cost_wood[53], ftm_cost_oil[53], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-axethrower", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-catapult",
	"showname", "Catapult",
	"res-cost", {0, ftm_cost_gold[59], ftm_cost_wood[59], ftm_cost_oil[59], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-catapult", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-ogre",
	"showname", "Ogre",
	"res-cost", {0, ftm_cost_gold[56], ftm_cost_wood[56], ftm_cost_oil[56], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ogre", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-death-knight",
	"showname", "Death Knight",
	"res-cost", {0, ftm_cost_gold[64], ftm_cost_wood[64], ftm_cost_oil[64], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-death-knight", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-ogre-mage",
	"showname", "Ogre Mage",
	"res-cost", {0, ftm_cost_gold[57], ftm_cost_wood[57], ftm_cost_oil[57], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-ogre-mage", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-dragon",
	"showname", "Dragon",
	"res-cost", {0, ftm_cost_gold[63], ftm_cost_wood[63], ftm_cost_oil[63], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-dragon", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-quick-blade",
	"showname", "Hero Soldier",
	"res-cost", {0, ftm_cost_gold[52], ftm_cost_wood[52], ftm_cost_oil[52], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-quick-blade", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)


DefineSpell("spell-unit-goblin-sappers",
	"showname", "Goblin Sappers",
	"res-cost", {0, ftm_cost_gold[61], ftm_cost_wood[61], ftm_cost_oil[61], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-goblin-sappers", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-berserker",
	"showname", "Berserker",
	"res-cost", {0, ftm_cost_gold[54], ftm_cost_wood[54], ftm_cost_oil[54], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-berserker", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-skeleton",
	"showname", "Skeleton",
	"res-cost", {0, ftm_cost_gold[60], ftm_cost_wood[60], ftm_cost_oil[60], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-skeleton", "time-to-live", 99000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-unit-nomad",
	"showname", "Nomad",
	"res-cost", {0, ftm_cost_gold[62], ftm_cost_wood[62], ftm_cost_oil[62], 0, 0, 0},
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-nomad", "time-to-live", 99000},
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