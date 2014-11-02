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
--	(c) Copyright 2014 by Kyran Jackson
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

local X
local Y

function SetPlayerFtM2014(player, race, faction, gold, wood, oil, startx, starty, istart, iend, teamx1, teamy1, teamx2, teamy2, match, aispawner, aibot)
	if (match == nil) then match = 8 end
	if (aispawner == nil) then aispawner = "ai_redribbon_2014" end
	if (aibot == nil) then aibot = "ai_red_2014" end
	SetupPlayer(player, race, aispawner, gold, wood, oil, startx, starty)
	SetupPlayer(player+match, race, aibot, gold, wood, oil, startx, starty)
	ftm_faction[player] = faction
	ftm_faction[player+match] = faction
	ftm_team[player] = player
	ftm_team[player+match] = player
	ftm_team_x1[player+match] = 0
	ftm_team_y1[player+match] = 0
	ftm_team_x2[player+match] = 1024
	ftm_team_y2[player+match] = 1024
	if (teamx1 ~= nil) then
		ftm_team_x1[player+match] = teamx1
		if (teamy1 ~= nil) then
			ftm_team_y1[player+match] = teamy1
			if (teamx2 ~= nil) then
				ftm_team_x2[player+match] = teamx2
				if (teamy2 ~= nil) then
					ftm_team_y2[player+match] = teamy2
				end
			end
		end
	end
	ftm_choice[player] = player + match
	if (istart ~= nil) then
		ftm_index_start[player] = istart
		if (iend ~= nil) then
			ftm_index_end[player] = iend
		end
	end
	ftm_team_startx[player+match] = startx
	ftm_team_starty[player+match] = starty
end

function AiRedRibbon_Setup_Units_2014()
	ftm_unit = {}
	ftm_origin = {}
	ftm_category = {}
	ftm_class = {}
	ftm_rank = {}
	ftm_cost_gold = {}
	ftm_cost_wood = {}
	ftm_cost_oil = {}
	ftm_origin_x = {}
	ftm_origin_y = {}
	AiRedRibbon_Define_Unit_2014(1, "unit-footman", "unit-human-barracks", "ground", "melee", "standard", 2500, 0, 0)
	AiRedRibbon_Define_Unit_2014(2, "unit-arthor-literios", "unit-human-barracks", "ground", "melee", "hero", 2500, 0, 17500)
	AiRedRibbon_Define_Unit_2014(3, "unit-archer", "unit-human-barracks", "ground", "ranged", "standard", 1000, 1500, 0)
	AiRedRibbon_Define_Unit_2014(4, "unit-ranger", "unit-human-barracks", "ground", "ranged", "elite", 1000, 1500, 2500)
	AiRedRibbon_Define_Unit_2014(5, "unit-female-hero", "unit-human-barracks", "ground", "ranged", "hero", 1000, 9000, 10000)
	AiRedRibbon_Define_Unit_2014(6, "unit-knight", "unit-human-barracks", "ground", "melee", "standard", 7500, 0, 0)
	AiRedRibbon_Define_Unit_2014(7, "unit-paladin", "unit-human-barracks", "ground", "melee", "elite", 7500, 0, 5000)
	AiRedRibbon_Define_Unit_2014(8, "unit-knight-rider", "unit-human-barracks", "ground", "melee", "hero", 7500, 0, 12500)
	AiRedRibbon_Define_Unit_2014(9, "unit-ballista", "unit-human-barracks", "ground", "ranged", "elite", 2500, 10000, 0)
	AiRedRibbon_Define_Unit_2014(10, "unit-attack-peasant", "unit-town-hall", "ground", "melee", "fodder", 1000, 500, 0)
	AiRedRibbon_Define_Unit_2014(11, "unit-dwarves", "unit-inventor", "ground", "melee", "attacker", 2500, 4000, 2500)
	AiRedRibbon_Define_Unit_2014(12, "unit-yeoman", "unit-town-hall", "ground", "ranged", "defender", 1000, 4000, 0)
	AiRedRibbon_Define_Unit_2014(13, "unit-gryphon-rider", "unit-gryphon-aviary", "air", "ranged", "attacker", 2500, 5000, 5000)
	AiRedRibbon_Define_Unit_2014(14, "unit-mage", "unit-mage-tower", "ground", "ranged", "attacker", 2500, 2500, 5000)
	AiRedRibbon_Define_Unit_2014(15, "unit-peasant", "unit-town-hall", "ground", "worker", "defender", 1000, 1500, 0)
	AiRedRibbon_Define_Unit_2014(51, "unit-grunt", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(52, "unit-quick-blade", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(53, "unit-axethrower", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(54, "unit-berserker", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(55, "unit-sharp-axe", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(56, "unit-ogre", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(57, "unit-ogre-mage", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(58, "unit-fad-man", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(59, "unit-catapult", "unit-orc-barracks")
	AiRedRibbon_Define_Unit_2014(60, "unit-skeleton", "unit-great-hall")
	AiRedRibbon_Define_Unit_2014(61, "unit-goblin-sappers", "unit-alchemist")
	AiRedRibbon_Define_Unit_2014(62, "unit-nomad", "unit-great-hall")
	AiRedRibbon_Define_Unit_2014(63, "unit-dragon", "unit-dragon-roost")
	AiRedRibbon_Define_Unit_2014(64, "unit-death-knight", "unit-temple-of-the-damned")
	AiRedRibbon_Define_Unit_2014(65, "unit-peon", "unit-great-hall")
	for i = 1, 15 do
		AiRedRibbon_Define_Origin_2014(i, 0, 0)
		AiRedRibbon_Define_Unit_2014(30+i, ftm_unit[i], ftm_origin[i], ftm_category[i], ftm_class[i], ftm_rank[i], ftm_cost_gold[i], ftm_cost_wood[i], ftm_cost_oil[i], ftm_origin_x[i], ftm_origin_y[i])
		AiRedRibbon_Define_Origin_2014(50+i, 0, 0)
		AiRedRibbon_Define_Attributes_2014(50+i, ftm_category[i], ftm_class[i], ftm_rank[i])
		AiRedRibbon_Define_Cost_2014(50+i, ftm_cost_gold[i], ftm_cost_wood[i], ftm_cost_oil[i])
		AiRedRibbon_Define_Unit_2014(80+i, ftm_unit[50+i], ftm_origin[50+i], ftm_category[50+i], ftm_class[50+i], ftm_rank[50+i], ftm_cost_gold[50+i], ftm_cost_wood[50+i], ftm_cost_oil[50+i], ftm_origin_x[50+i], ftm_origin_y[50+i])
	end
	-- Cost override.
	AiRedRibbon_Define_Cost_2014(58, 7500, 0, 17500)
	AiRedRibbon_Define_Cost_2014(60, 750, 0, 250)
	AiRedRibbon_Define_Cost_2014(88, 7500, 0, 17500)
	AiRedRibbon_Define_Cost_2014(90, 750, 0, 250)
end

function AiRedRibbon_Define_Unit_2014(i, unit, origin, category, class, rank, gold, wood, oil, x, y)
	if (category ~= nil) then
		ftm_category[i] = category
	else
		ftm_category[i] = ""
	end
	if (class ~= nil) then
		ftm_class[i] = class
	else
		ftm_class[i] = ""
	end
	if (rank ~= nil) then
		ftm_rank[i] = rank
	else
		ftm_rank[i] = ""
	end
	ftm_unit[i] = unit
	if ((gold ~= nil) or (wood ~= nil) or (oil ~= nil)) then
		AiRedRibbon_Define_Cost_2014(i, gold, wood, oil)
	end
	if ((x ~= nil) or (y ~= nil) or (origin ~= nil)) then
		AiRedRibbon_Define_Origin_2014(i, x, y, origin)
	else
		ftm_origin_x[i] = 0
		ftm_origin_y[i] = 0
	end
end

function AiRedRibbon_Define_Cost_2014(i, gold, wood, oil)
	if (gold ~= nil) then
		ftm_cost_gold[i] = gold
	else
		ftm_cost_gold[i] = 0
	end
	if (wood ~= nil) then
		ftm_cost_wood[i] = wood
	else
		ftm_cost_wood[i] = 0
	end
	if (oil ~= nil) then
		ftm_cost_oil[i] = oil
	else
		ftm_cost_oil[i] = 0
	end
end

function AiRedRibbon_Auto_Origin_2014(player, target, x, y, class)
	-- Class will be something like ground, air, etcetera.
	for i=ftm_index_start[player], ftm_index_end[player] do
		if (ftm_origin[i] == target) then
			AiRedRibbon_Define_Origin_2014(i, x, y)
		end
		if ((target == "all") or (ftm_unit[i] == target) or (ftm_class[i] == target) or (ftm_rank[i] == target) or (ftm_category[i] == target)) then
			AiRedRibbon_Define_Origin_2014(i, x, y, class)
		end
	end
end

function AiRedRibbon_Define_Attributes_2014(i, category, class, rank)
	if (category ~= nil) then
		ftm_category[i] = category
	end
	if (class ~= nil) then
		ftm_class[i] = class
	end
	if (rank ~= nil) then
		ftm_rank[i] = rank
	end
end

function AiRedRibbon_Define_Origin_2014(i, x, y, building)
	if (x ~= nil) then
		ftm_origin_x[i] = x
	end
	if (y ~= nil) then
		ftm_origin_y[i] = y
	end
	if (building ~= nil) then
		ftm_origin[i] = building
	end
end

function AiRedRibbon_Setup_2014()
	timers = {}
	ftm_faction = {}
	ftm_team = {}
	ftm_team_startx = {}
	ftm_team_starty = {}
	ftm_team_tempx = {}
	ftm_team_tempy = {}
	ftm_team_orderx = {}
	ftm_team_ordery = {}
	ftm_team_x1 = {}
	ftm_team_y1 = {}
	ftm_team_x2 = {}
    ftm_team_y2 = {}
	ftm_unit = {}
	ftm_origin = {}
	-- Delete following line.
	ftm_cost = {}
	ftm_choice = {} -- Who gets spawned in next.
	ftm_index_start = {}
	ftm_index_end = {}
	AiRedRibbon_Setup_Units_2014()
	ftm_choice[0] = 3
	ftm_choice[1] = 2
	aiftm_unit = {}
	aiftm_quantity = {}
	aiftm_loop = {}
	aiftm_terminate = {}
	aiftm_index = {}
	aiftm_mana = {}
	for i = 0, 15 do
		aiftm_unit[i] = {}
		aiftm_quantity[i] = {}
		aiftm_index[i] = 0
		aiftm_terminate[i] = 15
		aiftm_loop[i] = 0
		aiftm_mana[i] = 0
		for j = 0, 15 do
			aiftm_unit[i][j] = 0
			aiftm_quantity[i][j] = 0
		end
		timers[i] = 1
		ftm_faction[i] = 10
		ftm_team[i] = 10
		ftm_index_start[i] = 1
		ftm_index_end[i] = 1
		ftm_team_tempx[i] = 0
		ftm_team_tempy[i] = 0
		ftm_team_x1[i] = 0
		ftm_team_y1[i] = 0
		ftm_team_x2[i] = 256
		ftm_team_y2[i] = 256
		ftm_team_startx[i] = 1
		ftm_team_starty[i] = 1
		ftm_team_orderx[i] = "Start Location"
		ftm_team_ordery[i] = "Start Location"
	end
	ftm_index_start[0] = 51
	ftm_index_end[0] = 65
	ftm_index_start[1] = 1
	ftm_index_end[1] = 15
end

function AiRed_Resources_2014(t, g, w, o)
	g = GetPlayerData(t, "Resources", "gold") + g
	w = GetPlayerData(t, "Resources", "wood") + w
	o = GetPlayerData(t, "Resources", "oil") + o
	SetPlayerData(t, "Resources", "gold", g)
	SetPlayerData(t, "Resources", "wood", w)
	SetPlayerData(t, "Resources", "oil", o)
end
	
function AiRed_Resources_Remove_2014(i, gold, wood, oil)
	SetPlayerData(i, "Resources", "gold", (GetPlayerData(AiPlayer(), "Resources", "gold") - gold))
	SetPlayerData(i, "Resources", "wood", (GetPlayerData(AiPlayer(), "Resources", "wood") - wood))
	SetPlayerData(i, "Resources", "oil", (GetPlayerData(AiPlayer(), "Resources", "oil") - oil))
end
	
function AiRedRibbon_2014()
	if ((timers[AiPlayer()] == 50) or (timers[AiPlayer()] == 100)) then
		if (ftm_team[AiPlayer()] == ftm_team[ftm_choice[AiPlayer()]]) then
			for i=ftm_index_start[AiPlayer()],ftm_index_end[AiPlayer()] do
				if ((GetNumUnitsAt(AiPlayer(), ftm_origin[i], {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (((ftm_origin[i] == AiCityCenter()) or (ftm_origin[i] == AiBetterCityCenter()) or (ftm_origin[i] == AiBestCityCenter())) and ((GetNumUnitsAt(AiPlayer(), AiCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(AiPlayer(), AiBetterCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(AiPlayer(), AiBestCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0)))) then
					if (GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) > 0) then
						for j=1,GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) do
							CreateUnit(ftm_unit[i], AiPlayer(), {ftm_origin_x[i], ftm_origin_y[i]})
						end
					end
				end
			end
			AiNephrite_Attack_2013()
		end
	end
	AiRedRibbon_Common_2014()
end

function AiRedRibbon_Diplomacy_Neutral_2014(a,b,n)
	for i=a,b do
		SetSharedVision(i, false, n)
		SetSharedVision(n, false, i)
		SetDiplomacy(n, "allied", i)
		SetDiplomacy(i, "allied", n)
	end
end

function AiRedRibbon_Diplomacy_2014(a, b)
	for i=a,b do
		for j=a,b do
			if (ftm_faction[i] == ftm_faction[j]) then
				SetSharedVision(j, true, i)
				SetSharedVision(i, true, j)
				SetDiplomacy(j, "allied", i)
				SetDiplomacy(i, "allied", j)
			else
				SetSharedVision(j, false, i)
				SetSharedVision(i, false, j)
				SetDiplomacy(j, "enemy", i)
				SetDiplomacy(i, "enemy", j)
			end
		end
	end
end

function AiRedRibbon_Common_2014()
	AiRed_Resources_2014(ftm_choice[AiPlayer()], 100, 50, 50)
	if ((timers[AiPlayer()] == 35) or (timers[AiPlayer()] == 85)) then
		AiNephrite_Flush_2013()
	--elseif (ftm_faction[ftm_choice[AiPlayer()]] ~= ftm_faction[AiPlayer()]) then	
	--	AiRedRibbon_Diplomacy_2014(0, 15)
	end
	AiRedRibbon_Research_2012()
	timers[AiPlayer()] = timers[AiPlayer()] + 1
	if (timers[AiPlayer()] == 101) then
		timers[AiPlayer()] = 1
	end
end

function AiRedRibbon_Spawn_2014(a, b, e, n)
	if ((timers[AiPlayer()] == a) or (timers[AiPlayer()] == b)) then
		X = e
		Y = n
	end
end

function AiRedRibbon_Survival_2014()
	if ((timers[AiPlayer()] >= 36) and (timers[AiPlayer()] <= 39) or (timers[AiPlayer()] >= 86) and (timers[AiPlayer()] <= 89)) then
		AiRedRibbon_Spawn_2014(36, 86, 0, 0)
		AiRedRibbon_Spawn_2014(38, 88, 0, 96)
		AiRedRibbon_Spawn_2014(37, 87, 96, 96)
		AiRedRibbon_Spawn_2014(39, 89, 96, 0)
		if (ftm_team[AiPlayer()] == ftm_team[ftm_choice[AiPlayer()]]) then
			for i=ftm_index_start[AiPlayer()],ftm_index_end[AiPlayer()] do
				if (GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) > 0) then
					for j=1,GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) do
						CreateUnit(ftm_unit[i], AiPlayer(), {X, Y})
					end
				end
			end
			AiNephrite_Attack_2013()
		end
	end
	AiRedRibbon_Common_2014()
	AiNephrite_2013()
end

function AiRed_2014()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWise()) > 0) and (GameCycle > 500)) then
		if ((timers[ftm_team[AiPlayer()]] == 50) or (timers[ftm_team[AiPlayer()]] == 99) or (timers[ftm_team[AiPlayer()]] == 25) or (timers[ftm_team[AiPlayer()]] == 75)) then
		else 
			for i=ftm_index_start[ftm_team[AiPlayer()]],ftm_index_end[ftm_team[AiPlayer()]] do
				if (((aiftm_unit[AiPlayer()][aiftm_index[AiPlayer()]] == ftm_unit[i]) or (aiftm_unit[AiPlayer()][aiftm_index[AiPlayer()]] == ftm_rank[i]) or (aiftm_unit[AiPlayer()][aiftm_index[AiPlayer()]] == ftm_category[i]) or (aiftm_unit[AiPlayer()][aiftm_index[AiPlayer()]] == ftm_category[i])) and (GetPlayerData(AiPlayer(), "Resources", "oil") > (aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]*ftm_cost_oil[i])) and (GetPlayerData(AiPlayer(), "Resources", "wood") > (aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]*ftm_cost_wood[i])) and (GetPlayerData(AiPlayer(), "Resources", "gold") > (aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]*ftm_cost_gold[i]))) then
				if (((GetNumUnitsAt(ftm_team[AiPlayer()], ftm_origin[i], {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (((ftm_origin[i] == AiCityCenter()) or (ftm_origin[i] == AiBetterCityCenter()) or (ftm_origin[i] == AiBestCityCenter())) and ((GetNumUnitsAt(ftm_team[AiPlayer()], AiCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(ftm_team[AiPlayer()], AiBetterCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(ftm_team[AiPlayer()], AiBestCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0)))) or (ftm_origin[i] == AiWise())) then
						for j=1, aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]] do
							CreateUnit(ftm_unit[i], AiPlayer(), {ftm_team_tempx[AiPlayer()], ftm_team_tempy[AiPlayer()]})
							if (ftm_team_orderx[AiPlayer()] == "Right") then
								if (ftm_team_tempx[AiPlayer()] == ftm_team_x2[AiPlayer()]) then
									ftm_team_tempx[AiPlayer()] = ftm_team_x1[AiPlayer()]
									if (ftm_team_ordery[AiPlayer()] == "Down") then
										if (ftm_team_tempy[AiPlayer()] == ftm_team_y2[AiPlayer()]) then
											ftm_team_tempy[AiPlayer()] = ftm_team_y1[AiPlayer()]
										else
											ftm_team_tempy[AiPlayer()] = ftm_team_tempy[AiPlayer()] + 1
										end
									elseif (ftm_team_ordery[AiPlayer()] == "Up") then
										if (ftm_team_tempy[AiPlayer()] == ftm_team_y1[AiPlayer()]) then
											ftm_team_tempy[AiPlayer()] = ftm_team_y2[AiPlayer()]
										else
											ftm_team_tempy[AiPlayer()] = ftm_team_tempy[AiPlayer()] - 1
										end
									end
								else
									ftm_team_tempx[AiPlayer()] = ftm_team_tempx[AiPlayer()] + 1
								end
							end
							if (ftm_team_orderx[AiPlayer()] == "Left") then
								if (ftm_team_tempx[AiPlayer()] == ftm_team_x1[AiPlayer()]) then
									ftm_team_tempx[AiPlayer()] = ftm_team_x2[AiPlayer()]
									if (ftm_team_ordery[AiPlayer()] == "Down") then
										if (ftm_team_tempy[AiPlayer()] == ftm_team_y2[AiPlayer()]) then
											ftm_team_tempy[AiPlayer()] = ftm_team_y1[AiPlayer()]
										else
											ftm_team_tempy[AiPlayer()] = ftm_team_tempy[AiPlayer()] + 1
										end
									elseif (ftm_team_ordery[AiPlayer()] == "Up") then
										if (ftm_team_tempy[AiPlayer()] == ftm_team_y1[AiPlayer()]) then
											ftm_team_tempy[AiPlayer()] = ftm_team_y2[AiPlayer()]
										else
											ftm_team_tempy[AiPlayer()] = ftm_team_tempy[AiPlayer()] - 1
										end
									end
								else
									ftm_team_tempx[AiPlayer()] = ftm_team_tempx[AiPlayer()] - 1
								end
							end
						end
						AiRed_Resources_Remove_2014(AiPlayer(), (ftm_cost_gold[i]*aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]), (ftm_cost_wood[i]*aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]), (ftm_cost_oil[i]*aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]))
					end
					if (aiftm_index[AiPlayer()] == aiftm_terminate[AiPlayer()]) then
						aiftm_index[AiPlayer()] = aiftm_loop[AiPlayer()]
					else
						aiftm_index[AiPlayer()] = aiftm_index[AiPlayer()] + 1
					end
				end
			end
		end
	elseif ((ftm_team_tempx[AiPlayer()] < 2) and (GameCycle > 100)) then
		if (ftm_team_ordery[AiPlayer()] == "Down") then
			ftm_team_tempy[AiPlayer()] = ftm_team_y1[AiPlayer()]
		elseif (ftm_team_orderx[AiPlayer()] == "Up") then
			ftm_team_tempy[AiPlayer()] = ftm_team_y2[AiPlayer()]
		else
			ftm_team_tempy[AiPlayer()] = ftm_team_starty[AiPlayer()]
		end
		if (ftm_team_orderx[AiPlayer()] == "Right") then
			ftm_team_tempx[AiPlayer()] = ftm_team_x1[AiPlayer()]
		elseif (ftm_team_orderx[AiPlayer()] == "Left") then
			ftm_team_tempx[AiPlayer()] = ftm_team_x2[AiPlayer()]
		else
			ftm_team_tempx[AiPlayer()] = ftm_team_startx[AiPlayer()]
		end	
	end
end

function AiRed_Strategy_Insert_2014(i, j, unit, quantity)
	aiftm_unit[i][j] = unit
	if (quantity ~= nil) then
		aiftm_quantity[i][j] = quantity
	else
		aiftm_quantity[i][j] = 1
	end
end

function AiRed_Strategy_2014(i, Loop, Terminate, Quantity, Unit0, Unit1, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10, Unit11, Unit12, Unit13, Unit14, Unit15, Unit16, Unit17, Unit18, Unit19, Unit20)
	aiftm_loop[i] = Loop
	aiftm_terminate[i] = Terminate
	for j=0, Terminate do
		aiftm_quantity[i][j] = Quantity
	end
	aiftm_unit[i][0] = Unit0
	aiftm_unit[i][1] = Unit1
	aiftm_unit[i][2] = Unit2
	aiftm_unit[i][3] = Unit3
	aiftm_unit[i][4] = Unit4
	aiftm_unit[i][5] = Unit5
	aiftm_unit[i][6] = Unit6
	aiftm_unit[i][7] = Unit7
	aiftm_unit[i][8] = Unit8
	aiftm_unit[i][9] = Unit9
	aiftm_unit[i][10] = Unit10
	aiftm_unit[i][11] = Unit11
	aiftm_unit[i][12] = Unit12
	aiftm_unit[i][13] = Unit13
	aiftm_unit[i][14] = Unit14
	aiftm_unit[i][15] = Unit15
	aiftm_unit[i][16] = Unit16
	aiftm_unit[i][17] = Unit17
	aiftm_unit[i][18] = Unit18
	aiftm_unit[i][19] = Unit19
	aiftm_unit[i][20] = Unit20
end

function AiRed_Strategy_Extend_2014(i, j, k, Unit0, Quantity0, Unit1, Quantity1, Unit2, Quantity2, Unit3, Quantity3, Unit4, Quantity4, Unit5, Quantity5, Unit6, Quantity6, Unit7, Quantity7, Unit8, Quantity8, Unit9, Quantity9, Unit10, Quantity10)
	AiRed_Strategy_Insert_2014(i, j, Unit0, Quantity0)
	if ((j+1 <= k) and (Unit1 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+1, Unit1, Quantity1) end
	if ((j+2 <= k) and (Unit2 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+2, Unit2, Quantity2) end
	if ((j+3 <= k) and (Unit3 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+3, Unit3, Quantity3) end
	if ((j+4 <= k) and (Unit4 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+4, Unit4, Quantity4) end
	if ((j+5 <= k) and (Unit5 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+5, Unit5, Quantity5) end
	if ((j+6 <= k) and (Unit6 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+6, Unit6, Quantity6) end
	if ((j+7 <= k) and (Unit7 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+7, Unit7, Quantity7) end
	if ((j+8 <= k) and (Unit8 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+8, Unit8, Quantity8) end
	if ((j+9 <= k) and (Unit9 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+9, Unit9, Quantity9) end
	if ((j+10 <= k) and (Unit10 ~= nil)) then AiRed_Strategy_Insert_2014(i, j+10, Unit10, Quantity10) end
	aiftm_terminate[i] = k
end

function AiRed_Strategy_Alliance_Support_2014(i)
	AiRed_Strategy_2014(i, 18, 27, 1, "unit-footman", "unit-footman", "unit-footman", "unit-archer", "unit-archer", "unit-peasant", "unit-ranger", "unit-footman", "unit-footman", "unit-footman", "unit-archer", "unit-footman", "unit-archer", "unit-archer", "unit-footman", "unit-footman", "unit-paladin", "unit-knight", "unit-knight", "unit-mage", "unit-arthor-literios")
	AiRed_Strategy_Extend_2014(i, 21, 28, "unit-archer", 1, "unit-footman", 3, "unit-knight", 1, "unit-knight", 1, "unit-archer", 1, "unit-archer", 1, "unit-footman", 2, "unit-female-hero", 1)
end

function AiRed_Strategy_Alliance_Mass_2014(i)
	AiRed_Strategy_2014(i, 9, 4, 2, "unit-footman", "unit-footman", "unit-footman", "unit-footman", "unit-archer")
	AiRed_Strategy_Extend_2014(i, 5, 15, "unit-ranger", 1, "unit-peasant", 1, "unit-archer", 1, "unit-footman", 1, "unit-yeoman", 1, "unit-footman", 2, "unit-knight", 1, "unit-footman", 1, "unit-archer", 1, "unit-footman", 1, "unit-paladin", 1)
	AiRed_Strategy_Extend_2014(i, 16, 18, "unit-mage", 1, "unit-female-hero", 1, "unit-footman", 2)
end

function AiRed_Strategy_Horde_Mass_2014(i)
	AiRed_Strategy_2014(i, 1, 4, 3, "unit-skeleton", "unit-skeleton", "unit-skeleton", "unit-skeleton", "unit-skeleton")
	AiRed_Strategy_Extend_2014(i, 5, 15, "unit-goblin-sappers", 1, "unit-peon", 2, "unit-axethrower", 4, "unit-grunt", 2, "unit-nomad", 1, "unit-skeleton", 2, "unit-grunt", 2, "unit-catapult", 1, "unit-grunt", 2, "unit-grunt", 2, "unit-berserker", 1)
	AiRed_Strategy_Extend_2014(i, 16, 18, "unit-ogre-mage", 1, "unit-ogre", 1, "unit-grunt", 2)
end

function AiRed_Strategy_Horde_Economy_2014(i)
	AiRed_Strategy_2014(i, 6, 8, 1, "unit-grunt", "unit-grunt", "unit-grunt", "unit-peon", "unit-peon", "unit-berserker", "unit-grunt", "unit-grunt", "unit-grunt")
	AiRed_Strategy_Extend_2014(i, 9, 17, "unit-ogre-mage", 1, "unit-axethrower", 1, "unit-grunt", 3, "unit-nomad", 1, "unit-axethrower", 1, "unit-ogre", 1, "unit-catapult", 1, "unit-grunt", 2, "unit-axethrower", 2)
	AiRed_Strategy_Extend_2014(i, 18, 26, "unit-axethrower", 2, "unit-ogre", 1, "unit-dragon", 1, "unit-dragon", 1, "unit-grunt", 2, "unit-axethrower", 2, "unit-grunt", 1, "unit-grunt", 1, "unit-quick-blade", 1)
end

DefineAi("ai_redribbon_2014", "*", "ai_redribbon_2014", AiRedRibbon_2014)
DefineAi("ai_redribbon_survival_2014", "*", "ai_redribbon_survival_2014", AiRedRibbon_Survival_2014)
DefineAi("ai_red_2014", "*", "ai_red_2014", AiRed_2014)