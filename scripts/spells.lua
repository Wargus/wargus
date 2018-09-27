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
--      (c) Copyright 1998-2014 by Joris Dauphin, Jimmy Salmon, cybermind
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

-- For documentation see stratagus/doc/ccl/ccl.html

DefineBoolFlags("isundead", "organic", "hero", "volatile")

--
--  Speed     : just drawing
--  ShadowFly : Shadow of flying unit (0:big, 1:normal, 2:small)
--  Level     : Increase each time an upgrade is applyed to an unit.
--
DefineVariables("Mana", {Max = 255, Value = 84, Increase = 1, Enable = false}, "Speed", "ShadowFly", {Max = 2},
	"Level", {Max = 1, Value = 1, Increase = 0, Enable = true})

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

CUpgrade:New("upgrade-eye-of-kilrogg-double-head")
CUpgrade:New("upgrade-bloodlust-double-head")
CUpgrade:New("upgrade-runes-double-head")

--[[
-- better display
DefineSpell("spell-suicide-bomber", {
	ShowName = "Demolish", ManaCost = 0, Target = "self",
	Action = {{"demolish", "range", 3, "damage", 400},
		{"spawn-missile", "missile", "missile-normal-spell",
			"end-point",   {"base", "caster"}}},
	"sound-when-cast", "explosion"
})
--]]

DefineSpell("spell-suicide-bomber",
	"showname", _("Demolish"), "manacost", 0, "target", "self", "range", 1,
	"action", {{"demolish", "range", 3, "damage", 400},
		{"spawn-missile", "missile", "missile-normal-spell",
			"end-point",   {"base", "caster"}}},
	"sound-when-cast", "explosion",
	"autocast", {"range", 6, "condition", {"opponent", "only"}},
	"ai-cast", {"range", 6, "condition", {"opponent", "only"}}
)


DefineSpell("spell-holy-vision",
	"showname", _("Holy Vision"),
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
	"showname", _("Healing"),
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
	"autocast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}},
	"ai-cast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}}
)

--[[
local function SpellExorcism(units)	
	local x = GetUnitVariable(units[1], "PosX")
	local y = GetUnitVariable(units[1], "PosY")
	print("aga")
	Exit(0)
	local minDist = 999
	local minUnit = 2
	if (table.getn(units) > 1) then
		local function distance(x1, y1, x2, y2)
			return math.sqrt(x1*x2 + y1*y2)
		end
		for i = 2,table.getn(units) do
			if (units[i] ~= nil) then
				local x2 = GetUnitVariable(units[i], "PosX")
				local y2 = GetUnitVariable(units[i], "PosY")
				local dist = distance(x, y, x2, y2)
				if (dist < minDist) then
					minUnit = i
					minDist = dist
				end
			end
		end
		local x = GetUnitVariable(units[minUnit], "PosX")
		local y = GetUnitVariable(units[minUnit], "PosY")
		return x, y
	else
		return -1, -1
	end
end]]

DefineSpell("spell-exorcism",
	"showname", _("Exorcism"),
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
	"autocast", {"range", 10, "condition", {"opponent", "only"}},
	"ai-cast", {"range", 10, "condition", {"opponent", "only"}}
)

DefineSpell("spell-eye-of-vision",
	"showname", _("eye of vision"),
	"manacost", 70,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-eye-of-vision", "time-to-live", 765},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision",
	"depend-upgrade", "upgrade-eye-of-kilrogg"
)

DefineSpell("spell-eye-of-vision-double-head",
	"showname", _("eye of vision"),
	"manacost", 70,
	"range", 6,
	"target", "position",
		"action", {{"summon", "unit-type", "unit-eye-of-vision", "time-to-live", 765},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "eye of vision"
)

DefineSpell("spell-haste",
	"showname", _("haste"),
	"manacost", 50,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {Haste = 1000, Slow = 0}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Haste", {ExactValue = 0}
	},
	"sound-when-cast", "haste",
	"depend-upgrade", "upgrade-haste",
	"autocast", {"range", 6, "combat", "only", "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"range", 6, "combat", "only", "condition", {"Coward", "false", "alliance", "only"}}
)

DefineSpell("spell-slow",
	"showname", _("slow"),
	"manacost", 50,
	"range", 10,
	"target", "unit",
	"action", {{"adjust-variable", {Slow = 1000, Haste = 0}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Slow", {ExactValue = 0}},
	"sound-when-cast", "slow",
	"depend-upgrade", "upgrade-slow",
	"autocast", {"range", 10, "condition", {"Coward", "false", "opponent", "only"}},
	"ai-cast", {"range", 10, "combat", "only", "condition", {"Coward", "false", "opponent", "only"}}
)

DefineSpell("spell-bloodlust",
	"showname", _("bloodlust"),
	"manacost", 50,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {Bloodlust = 1000}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"organic", "only",
		"Bloodlust", {ExactValue = 0}},
	"sound-when-cast", "bloodlust",
	"depend-upgrade", "upgrade-bloodlust",
	"autocast", {"range", 6, "attacker", "only", "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"range", 6, "attacker", "only", "condition", {"Coward", "false", "alliance", "only"}}
)

DefineSpell("spell-bloodlust-double-head",
	"showname", _("bloodlust"),
	"manacost", 50,
	"range", 6,
	"target", "unit",
	"action", {{"adjust-variable", {Bloodlust = 1000}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"organic", "only",
		"Bloodlust", {ExactValue = 0}},
	"sound-when-cast", "bloodlust",
	"autocast", {"range", 6, "attacker", "only", "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"range", 6, "attacker", "only", "condition", {"Coward", "false", "alliance", "only"}}
)

DefineSpell("spell-invisibility",
	"showname", _("invisibility"),
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
	"depend-upgrade", "upgrade-invisibility",
	"autocast", {"range", 6, "condition", {"AirUnit", "only", "alliance", "only"}},
	"ai-cast", {"range", 6, "combat", "false", "condition", {"LandUnit", "false", "alliance", "only"}}
)

local function SpellUnholyArmor(spell, unit, x, y, target)
	if target ~= -1 then
		if GetUnitBoolFlag(target, "volatile") == true then
			DamageUnit(-1, target, 99999)
		else
			DamageUnit(-1, target, math.max(1, math.floor(GetUnitVariable(target, "HitPoints", "Value") / 2)))
			SetUnitVariable(target, "UnholyArmor", 500, "Max")
			SetUnitVariable(target, "UnholyArmor", 500, "Value")
			SetUnitVariable(target, "UnholyArmor", 1, "Enable")
		end
	end
	return false
end

DefineSpell("spell-unholy-armor",
	"showname", _("unholyarmor"),
	"manacost", 100,
	"range", 6,
	"target", "unit",
	"action", {{"lua-callback", SpellUnholyArmor},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"UnholyArmor", {MaxValue = 10}},
	"sound-when-cast", "unholy armor",
	"depend-upgrade", "upgrade-unholy-armor",
	"autocast", {"attacker", "only", "range", 9, "priority", {"Points", true}, "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"attacker", "only", "range", 9, "priority", {"Points", true}, "condition", {"Coward", "false", "alliance", "only"}}
)

DefineSpell("spell-flame-shield",
	"showname", _("flame shield"),
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
	"condition", {"Building", "false", "AirUnit", "false"},
	"sound-when-cast", "flame shield",
	"depend-upgrade", "upgrade-flame-shield",
	"autocast", {"range", 6, "attacker", "only", "condition", {"Coward", "false"}}
)

DefineSpell("spell-polymorph",
	"showname", _("polymorph"),
	"manacost", 200,
	"range", 10,
	"target", "unit",
	"action", {{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}},
			{"polymorph", "new-form", "unit-critter", "player-neutral"}},
	"condition", {"organic", "only"},
	"sound-when-cast", "polymorph",
	"depend-upgrade", "upgrade-polymorph",
	--  Only cast on the strongest units!!!
	"autocast", {"range", 10, "priority", {"HitPoints", true}, "condition", {"opponent", "only", "HitPoints", {MinValuePercent = 50}}},
	"ai-cast", {"range", 10, "priority", {"HitPoints", true}, "condition", {"opponent", "only", "HitPoints", {MinValuePercent = 50}}}
)

local function SpellBlizzard(units)
	if (table.getn(units) > 1) then
		local p2 = Players[GetUnitVariable(units[1], "Player")]
		local arunits = {}
		local enemy = 2
		local costs = {}
		for i = 2,table.getn(units) do
			costs[i] = 0
			local p1 = Players[GetUnitVariable(units[i], "Player")]
			if (p1.Index == p2.Index or p1:IsAllied(p2)) then
			else
				costs[i] = costs[i] + GetUnitVariable(units[i], "Priority")
				arunits = GetUnitsAroundUnit(units[i], 5, true)
				for j = 1,table.getn(arunits) do
					if (arunits[j] ~= units[1]) then
						local p3 = Players[GetUnitVariable(arunits[j], "Player")]
						if (p3.Index == p2.Index or p3:IsAllied(p2)) then
							costs[i] = costs[i] - GetUnitVariable(arunits[j], "Priority")
						else
							costs[i] = costs[i] + GetUnitVariable(arunits[j], "Priority")
						end
					end
				end
			end
		end
		for i = 3,table.getn(costs) do
			if costs[i] > costs[enemy] then
				enemy = i
			end
		end
		if (costs[enemy] > 20) then
			local x = GetUnitVariable(units[enemy], "PosX")
			local y = GetUnitVariable(units[enemy], "PosY")
			x = x + math.floor(UnitManager:GetSlotUnit(units[enemy]).Type.TileWidth / 2)
			y = y + math.floor(UnitManager:GetSlotUnit(units[enemy]).Type.TileHeight / 2)
			return x, y
		else 
			return -1, -1
		end
	else
		return -1, -1
	end
end

DefineSpell("spell-blizzard",
	"showname", _("blizzard"),
	"manacost", 25,
	"range", 12,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-blizzard",
		 "fields", 5,
		 "shards", 11,
		 --  128=4*32=4 tiles
		 "start-offset-x", -128,
		 "start-offset-y", -128}},
	"sound-when-cast", "blizzard",
	"depend-upgrade", "upgrade-blizzard",
	"autocast", {"range", 12, "priority", {"Priority", true}, "combat", "only", "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 12, "priority", {"Priority", true}, "combat", "only", "position-autocast", SpellBlizzard}
)

DefineSpell("spell-death-and-decay",
	"showname", _("death and decay"),
	"manacost", 25,
	"range", 12,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-death-and-decay",
		"fields", 5, "shards", 11}},
	"sound-when-cast", "death and decay",
	"depend-upgrade", "upgrade-death-and-decay",
	"autocast", {"range", 12, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 12, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard}
)

DefineSpell("spell-fireball",
	"showname", _("fireball"),
	"manacost", 100,
	"range", 8,
	"target", "position",
	"action", {{"spawn-missile", "missile", "missile-fireball", "damage", 20}},
	"sound-when-cast", "fireball throw",
	"depend-upgrade", "upgrade-fireball",
	"autocast", {"range", 8, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 8, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard}
)

DefineSpell("spell-runes",
	"showname", _("runes"),
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
	"condition", {
		"Building", "false",
	},
	"sound-when-cast", "touch of darkness",
	"depend-upgrade", "upgrade-runes"
--	"autocast", {range 10)
)

DefineSpell("spell-runes-double-head",
	"showname", _("runes"),
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
	"condition", {
		"Building", "false",
	},
	"sound-when-cast", "touch of darkness"
--	"autocast", {range 10)
)

local function SpellDeathCoil(units)		
	if (table.getn(units) > 1) then
		local maxUnit = 2
		for i = 2,table.getn(units) do
			if (units[i] ~= nil and GetUnitVariable(units[i], "HitPoints") > GetUnitVariable(units[maxUnit], "HitPoints")) then
				maxUnit = i
			end
		end
		
		local x = GetUnitVariable(units[maxUnit], "PosX")
		local y = GetUnitVariable(units[maxUnit], "PosY")
		return x, y
	else
		return -1, -1
	end
end

DefineSpell("spell-death-coil",
	"showname", _("death coil"),
	"manacost", 100,
	"range", 10,
	"target", "position",
	"action", {{"spawn-missile", "missile", "missile-death-coil", "damage", 50}},
	"sound-when-cast", "death coil",
	"depend-upgrade", "upgrade-death-coil",
	
	"autocast", {"range", 10, "condition", {"organic", "only", "opponent", "only"}, "position-autocast", SpellDeathCoil},
	"ai-cast", {"range", 10, "condition", {"organic", "only", "opponent", "only"}, "position-autocast", SpellDeathCoil}
)

DefineSpell("spell-raise-dead",
	"showname", _("raise dead"),
	"manacost", 50,
	"range", 6,
	"repeat-cast",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-skeleton", "time-to-live", 3600, "require-corpse"},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"depend-upgrade", "upgrade-raise-dead",
	"autocast", {"range", 6, "corpse", "only", "priority", {"Distance", false}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 6, "corpse", "only", "priority", {"Distance", false}, "position-autocast", SpellBlizzard}
)

DefineSpell("spell-whirlwind",
	"showname", _("whirlwind"),
	"manacost", 100,
	"range", 12,
	"target", "position",
	"action", {
		{"spawn-missile", "ttl", 800, "damage", 3, "missile", "missile-whirlwind",
		 "start-point", {"base", "target", "add-x", 0, "add-y", 0},
		 "end-point",   {"base", "target", "add-x", 0, "add-y", 0}}},
	"sound-when-cast", "whirlwind",
	"depend-upgrade", "upgrade-whirlwind",
	"autocast", {"range", 12, "priority", {"Priority", true}, "condition", {"Building", "only", "opponent", "only"}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 12, "priority", {"Priority", true}, "condition", {"Building", "only", "opponent", "only"}, "position-autocast", SpellBlizzard}
)

Load("scripts/caanoo/spells.lua")
