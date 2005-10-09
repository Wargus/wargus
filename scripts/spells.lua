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
--      spells.lua - The spells.
--
--      (c) Copyright 1998-2005 by Joris Dauphin and Jimmy Salmon.
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
--      $Id$

-- For documentation see stratagus/doc/ccl/ccl.html

DefineBoolFlags("isundead", "organic", "hero", "volatile")

--
--  Speed     : just drawing
--  ShadowFly : Shadow of flying unit (0:big, 1:normal, 2:small)
--  Level     : Increase each time an upgrade is applyed to an unit.
--
DefineVariables("Speed", "ShadowFly", {Max = 2}, "Level")

--  Declare some unit types used in spells. This is quite accetable, the other
--  way would be to define can-cast-spell outside unit definitions, not much of an improvement.
DefineUnitType("unit-revealer", {})
DefineUnitType("unit-eye-of-vision", {})
DefineUnitType("unit-critter", {})
DefineUnitType("unit-skeleton", {})
DefineUnitType("unit-circle-of-power", {})

-- And declare upgrade for dependency...
-- For human
CUpgrade:New("upgrade-holy-vision")
CUpgrade:New("upgrade-healing")
CUpgrade:New("upgrade-exorcism")
CUpgrade:New("upgrade-flame-shield")
CUpgrade:New("upgrade-fireball")
CUpgrade:New("upgrade-slow")
CUpgrade:New("upgrade-invisibility")
CUpgrade:New("upgrade-polymorph")
CUpgrade:New("upgrade-blizzard")
-- For orc
CUpgrade:New("upgrade-eye-of-kilrogg")
CUpgrade:New("upgrade-bloodlust")
CUpgrade:New("upgrade-raise-dead")
CUpgrade:New("upgrade-death-coil")
CUpgrade:New("upgrade-whirlwind")
CUpgrade:New("upgrade-haste")
CUpgrade:New("upgrade-unholy-armor")
CUpgrade:New("upgrade-runes")
CUpgrade:New("upgrade-death-and-decay")

--[[
-- better display
DefineSpell("spell-suicide-bomber", {
	ShowName = "Demolish", ManaCost = 0, Target = "self",
	Action = {{"demolish", "range", 1, "damage", 400},
		{"spawn-missile", "missile", "missile-normal-spell",
			"end-point",   {"base", "caster"}}},
	SoundWhenCast = "holy vision"
})
--]]

DefineSpell("spell-suicide-bomber",
	"showname", "Demolish", "manacost", 0, "target", "self",
	"action", {{"demolish", "range", 1, "damage", 400},
		{"spawn-missile", "missile", "missile-normal-spell",
			"end-point",   {"base", "caster"}}},
	"sound-when-cast", "holy vision"
)


DefineSpell("spell-holy-vision",
	"showname", "Holy Vision",
	"manacost", 70,
	"range", "infinite",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-revealer", "time-to-live", 25},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "holy vision",
	"depend-upgrade", "upgrade-holy-vision"
)

DefineSpell("spell-healing",
	"showname", "Healing",
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
	"depend-upgrade", "upgrade-healing",
	"autocast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}}
)

DefineSpell("spell-exorcism",
	"showname", "Exorcism",
	"manacost", 4,
	"range", 10,
	"target", "unit",
	"action", {{"adjust-vitals", "hit-points", -1},
		{"spawn-missile", "missile", "missile-exorcism",
			"start-point", {"base", "target"}}},
	"condition", {
		"isundead", "only",
		"Building", "false", -- any undead buildings?
	},
	"sound-when-cast", "exorcism",
	"depend-upgrade", "upgrade-exorcism",
	"autocast", {"range", 10, "condition", {"Coward", "false", "alliance", "false"}}
)

DefineSpell("spell-eye-of-vision",
	"showname", "eye of vision",
	"manacost", 70,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-eye-of-vision", "time-to-live", 5000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", "upgrade-eye-of-kilrogg"
)

DefineSpell("spell-haste",
	"showname", "haste",
	"manacost", 50,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {Haste = 1000, Slow = 0}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Haste", {MaxValue = 10} -- FIXME: proper value?
	},
	"sound-when-cast", "haste",
	"depend-upgrade", "upgrade-haste",
	"autocast", {"range", 6, "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"range", 6, "combat", "only", "condition", {"Coward", "false", "alliance", "only"}}
)

DefineSpell("spell-slow",
	"showname", "slow",
	"manacost", 50,
	"range", 10,
	"target", "unit",
	"action", {{"adjust-variable", {Slow = 1000, Haste = 0}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Slow", {MaxValue = 10}},
	"sound-when-cast", "slow",
	"depend-upgrade", "upgrade-slow",
	"autocast", {"range", 10, "condition", {"Coward", "false", "alliance", "false"}},
	"ai-cast", {"range", 10, "combat", "only", "condition", {"Coward", "false", "alliance", "false"}}
)

DefineSpell("spell-bloodlust",
	"showname", "bloodlust",
	"manacost", 50,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {Bloodlust = 1000}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"organic", "only",
		"Bloodlust", {MaxValue = 10}},
	"sound-when-cast", "bloodlust",
	"depend-upgrade", "upgrade-bloodlust",
	"autocast", {"range", 6, "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"range", 6, "combat", "only", "condition", {"Coward", "false", "alliance", "only"}}
)

DefineSpell("spell-invisibility",
	"showname", "invisibility",
	"manacost", 200,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {Invisible = 2000}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Invisible", {MaxValue = 10}},
	"sound-when-cast", "invisibility",
	"depend-upgrade", "upgrade-invisibility"
--	"autocast", {"range", 6, "condition", {"Coward", "false"}},
)

DefineSpell("spell-unholy-armor",
	"showname", "unholyarmor",
	"manacost", 100,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {UnholyArmor = 500}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"UnholyArmor", {MaxValue = 10}},
	"sound-when-cast", "unholy armor",
	"depend-upgrade", "upgrade-unholy-armor"
--	"autocast", {range 6 condition (Coward false alliance only)},
)

DefineSpell("spell-flame-shield",
	"showname", "flame shield",
	"manacost", 50,
	"range", 6,
	"target", "unit",
	"action", {
		{"spawn-missile", "missile", "missile-flame-shield", "ttl", 600, "damage", 1},
		{"spawn-missile", "missile", "missile-flame-shield", "ttl", 607, "damage", 1},
		{"spawn-missile", "missile", "missile-flame-shield", "ttl", 614, "damage", 1},
		{"spawn-missile", "missile", "missile-flame-shield", "ttl", 621, "damage", 1},
		{"spawn-missile", "missile", "missile-flame-shield", "ttl", 628, "damage", 1}
	},
	-- I think it's better if we can cast it multiple times and the effects stack.
	-- Can be casted, and is effective on both allies and enemies
	"condition", {"Building", "false"},
	"sound-when-cast", "flame shield",
	"depend-upgrade", "upgrade-flame-shield"
--	"autocast", {range 6 condition (Coward false)},
)

DefineSpell("spell-polymorph",
	"showname", "polymorph",
	"manacost", 200,
	"range", 10,
	"target", "unit",
	"action", {{"polymorph", "new-form", "unit-critter", "player-neutral"},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {"organic", "only"},
	"sound-when-cast", "polymorph",
	"depend-upgrade", "upgrade-polymorph"
	--  Only cast on the strongest units!!!
--	"autocast", {range 10 condition (alliance false min-hp-percent 75)},
)

DefineSpell("spell-blizzard",
	"showname", "blizzard",
	"manacost", 25,
	"range", 12,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-blizzard",
		 "fields", 5,
		 "shards", 10,
		 "damage", 10,
		 --  128=4*32=4 tiles
		 "start-offset-x", -128,
		 "start-offset-y", -128}},
	"sound-when-cast", "blizzard",
	"depend-upgrade", "upgrade-blizzard"
--	"autocast", {range 12)
)

DefineSpell("spell-death-and-decay",
	"showname", "death and decay",
	"manacost", 25,
	"range", 12,
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-death-and-decay",
		"fields", 5, "shards", 10, "damage", 10}},
	"sound-when-cast", "death and decay",
	"depend-upgrade", "upgrade-death-and-decay"
--	"autocast", {range 12)
)

DefineSpell("spell-fireball",
	"showname", "fireball",
	"manacost", 100,
	"range", 8,
	"target", "position",
	"action", {{"spawn-missile", "missile", "missile-fireball", "damage", 20}},
	"sound-when-cast", "fireball throw",
	"depend-upgrade", "upgrade-fireball"
--	"autocast", {range 8)
)

DefineSpell("spell-runes",
	"showname", "runes",
	"manacost", 200,
	"range", 10,
	"target", "position",
	"action", {
		{"spawn-missile", "ttl", 2000, "damage", 50, "missile", "missile-rune",
		 "start-point", {"base", "target", "add-x", 0, "add-y", 0},
		 "end-point",   {"base", "target", "add-x", 0, "add-y", 0}},
		{"spawn-missile", "ttl", 2000, "damage", 50, "missile", "missile-rune",
		 "start-point", {"base", "target", "add-x", 32, "add-y", 0},
		 "end-point",   {"base", "target", "add-x", 32, "add-y", 0}},
		{"spawn-missile", "ttl", 2000, "damage", 50, "missile", "missile-rune",
		 "start-point", {"base", "target", "add-x", 0, "add-y", 32},
		 "end-point",   {"base", "target", "add-x", 0, "add-y", 32}},
		{"spawn-missile", "ttl", 2000, "damage", 50, "missile", "missile-rune",
		 "start-point", {"base", "target", "add-x", -32, "add-y", 0},
		 "end-point",   {"base", "target", "add-x", -32, "add-y", 0}},
		{"spawn-missile", "ttl", 2000, "damage", 50, "missile", "missile-rune",
		 "start-point", {"base", "target", "add-x", 0, "add-y", -32},
		 "end-point",   {"base", "target", "add-x", 0, "add-y", -32}},
	},
	"sound-when-cast", "runes",
	"depend-upgrade", "upgrade-runes"
--	"autocast", {range 10)
)

DefineSpell("spell-death-coil",
	"showname", "death coil",
	"manacost", 100,
	"range", 10,
	"target", "position", -- FIXME position or organic target
	"action", {{"spawn-missile", "missile", "missile-death-coil", "damage", 50}},
--	"condition", {"UnitTypeflag", {"true", "organic"}},
	"sound-when-cast", "death coil",
	"depend-upgrade", "upgrade-death-coil"
--	"autocast", {"range", 6}
)

DefineSpell("spell-raise-dead",
	"showname", "raise dead",
	"manacost", 50,
	"range", 6,
	"repeat-cast",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-skeleton", "time-to-live", 3600, "require-corpse"},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-raise-dead"
--	"autocast", {"range", 6}
)

DefineSpell("spell-whirlwind",
	"showname", "whirlwind",
	"manacost", 100,
	"range", 12,
	"target", "position",
	"action", {
		{"spawn-missile", "ttl", 800, "damage", 3, "missile", "missile-whirlwind",
		 "start-point", {"base", "target", "add-x", 0, "add-y", 0},
		 "end-point",   {"base", "target", "add-x", 0, "add-y", 0}}},
	"sound-when-cast", "whirlwind",
	"depend-upgrade", "upgrade-whirlwind"
--	"autocast", {range 12)
)

