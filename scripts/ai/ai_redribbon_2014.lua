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
	ftm_cost_gold = {}
	ftm_cost_wood = {}
	ftm_cost_oil = {}
	ftm_origin_x = {}
	ftm_origin_y = {}
	ftm_choice = {} -- Who gets spawned in next.
	ftm_index_start = {}
	ftm_index_end = {}
	ftm_unit[1] = "unit-footman"
	ftm_origin[1] = "unit-human-barracks"
	ftm_cost_gold[1] = 2500
	ftm_cost_wood[1] = 0
	ftm_cost_oil[1] = 0
	ftm_origin_x[1] = 1
	ftm_origin_y[1] = 1
	ftm_unit[2] = "unit-arthor-literios"
	ftm_origin[2] = "unit-human-barracks"
	ftm_cost_gold[2] = 10000
	ftm_cost_wood[2] = 0
	ftm_cost_oil[2] = 10000
	ftm_origin_x[2] = 1
	ftm_origin_y[2] = 1
	ftm_unit[3] = "unit-archer"
	ftm_origin[3] = "unit-human-barracks"
	ftm_cost_gold[3] = 2000
	ftm_cost_wood[3] = 0
	ftm_cost_oil[3] = 500
	ftm_origin_x[3] = 1
	ftm_origin_y[3] = 1
	ftm_unit[4] = "unit-ranger"
	ftm_origin[4] = "unit-human-barracks"
	ftm_cost_gold[4] = 2000
	ftm_cost_wood[4] = 0
	ftm_cost_oil[4] = 2500
	ftm_origin_x[4] = 1
	ftm_origin_y[4] = 1
	ftm_unit[5] = "unit-female-hero"
	ftm_origin[5] = "unit-human-barracks"
	ftm_cost_gold[5] = 5000
	ftm_cost_wood[5] = 5000
	ftm_cost_oil[5] = 10000
	ftm_origin_x[5] = 1
	ftm_origin_y[5] = 1
	ftm_unit[6] = "unit-knight"
	ftm_origin[6] = "unit-human-barracks"
	ftm_cost_gold[6] = 7500
	ftm_cost_wood[6] = 0
	ftm_cost_oil[6] = 0
	ftm_origin_x[6] = 1
	ftm_origin_y[6] = 1
	ftm_unit[7] = "unit-paladin"
	ftm_origin[7] = "unit-human-barracks"
	ftm_cost_gold[7] = 7500
	ftm_cost_wood[7] = 0
	ftm_cost_oil[7] = 5000
	ftm_origin_x[7] = 1
	ftm_origin_y[7] = 1
	ftm_unit[8] = "unit-knight-rider"
	ftm_origin[8] = "unit-human-barracks"
	ftm_cost_gold[8] = 10000
	ftm_cost_wood[8] = 0
	ftm_cost_oil[8] = 10000
	ftm_origin_x[8] = 1
	ftm_origin_y[8] = 1
	ftm_unit[9] = "unit-ballista"
	ftm_origin[9] = "unit-human-barracks"
	ftm_cost_gold[9] = 2500
	ftm_cost_wood[9] = 10000
	ftm_cost_oil[9] = 0
	ftm_origin_x[9] = 1
	ftm_origin_y[9] = 1
	ftm_unit[10] = "unit-attack-peasant"
	ftm_origin[10] = "unit-town-hall"
	ftm_cost_gold[10] = 750
	ftm_cost_wood[10] = 750
	ftm_cost_oil[10] = 0
	ftm_origin_x[10] = 1
	ftm_origin_y[10] = 1
	ftm_unit[11] = "unit-dwarves"
	ftm_origin[11] = "unit-inventor"
	ftm_cost_gold[11] = 3000
	ftm_cost_wood[11] = 5000
	ftm_cost_oil[11] = 3000
	ftm_origin_x[11] = 1
	ftm_origin_y[11] = 1
	ftm_unit[12] = "unit-yeoman"
	ftm_origin[12] = "unit-town-hall"
	ftm_cost_gold[12] = 2500
	ftm_cost_wood[12] = 2500
	ftm_cost_oil[12] = 0
	ftm_origin_x[12] = 1
	ftm_origin_y[12] = 1
	ftm_unit[13] = "unit-gryphon-rider"
	ftm_origin[13] = "unit-gryphon-aviary"
	ftm_cost_gold[13] = 2500
	ftm_cost_wood[13] = 5000
	ftm_cost_oil[13] = 5000
	ftm_origin_x[13] = 1
	ftm_origin_y[13] = 1
	ftm_unit[14] = "unit-mage"
	ftm_origin[14] = "unit-mage-tower"
	ftm_cost_gold[14] = 2500
	ftm_cost_wood[14] = 2500
	ftm_cost_oil[14] = 5000
	ftm_origin_x[14] = 1
	ftm_origin_y[14] = 1
	ftm_unit[15] = "unit-peasant"
	ftm_origin[15] = "unit-town-hall"
	ftm_cost_gold[15] = 500
	ftm_cost_wood[15] = 2000
	ftm_cost_oil[15] = 0
	ftm_origin_x[15] = 1
	ftm_origin_y[15] = 1
	
	for i=1, 15 do
		ftm_cost_gold[30+i] = ftm_cost_gold[0+i]
		ftm_cost_wood[30+i] = ftm_cost_wood[0+i]
		ftm_cost_oil[30+i] = ftm_cost_oil[0+i]
		ftm_cost_gold[50+i] = ftm_cost_gold[0+i]
		ftm_cost_wood[50+i] = ftm_cost_wood[0+i]
		ftm_cost_oil[50+i] = ftm_cost_oil[0+i]
		ftm_cost_gold[80+i] = ftm_cost_gold[0+i]
		ftm_cost_wood[80+i] = ftm_cost_wood[0+i]
		ftm_cost_oil[80+i] = ftm_cost_oil[0+i]
	end
	
	ftm_unit[31] = "unit-footman"
	ftm_origin[31] = "unit-human-barracks"
	ftm_origin_x[31] = 6
	ftm_origin_y[31] = 83
	ftm_unit[32] = "unit-arthor-literios"
	ftm_origin[32] = "unit-human-barracks"
	ftm_cost[32] = 200
	ftm_origin_x[32] = 6
	ftm_origin_y[32] = 83
	ftm_unit[33] = "unit-archer"
	ftm_origin[33] = "unit-human-barracks"
	ftm_cost[33] = 25
	ftm_origin_x[33] = 6
	ftm_origin_y[33] = 83
	ftm_unit[34] = "unit-ranger"
	ftm_origin[34] = "unit-human-barracks"
	ftm_cost[34] = 50
	ftm_origin_x[34] = 6
	ftm_origin_y[34] = 83
	ftm_unit[35] = "unit-female-hero"
	ftm_origin[35] = "unit-human-barracks"
	ftm_cost[35] = 200
	ftm_origin_x[35] = 6
	ftm_origin_y[35] = 83
	ftm_unit[36] = "unit-knight"
	ftm_origin[36] = "unit-human-barracks"
	ftm_cost[36] = 75
	ftm_origin_x[36] = 6
	ftm_origin_y[36] = 83
	ftm_unit[37] = "unit-paladin"
	ftm_origin[37] = "unit-human-barracks"
	ftm_cost[37] = 125
	ftm_origin_x[37] = 6
	ftm_origin_y[37] = 83
	ftm_unit[38] = "unit-knight-rider"
	ftm_origin[38] = "unit-human-barracks"
	ftm_cost[38] = 200
	ftm_origin_x[38] = 6
	ftm_origin_y[38] = 83
	ftm_unit[39] = "unit-ballista"
	ftm_origin[39] = "unit-human-barracks"
	ftm_cost[39] = 125
	ftm_origin_x[39] = 6
	ftm_origin_y[39] = 83
	ftm_unit[40] = "unit-attack-peasant"
	ftm_origin[40] = "unit-town-hall"
	ftm_cost[40] = 15
	ftm_origin_x[40] = 6
	ftm_origin_y[40] = 89
	ftm_unit[41] = "unit-dwarves"
	ftm_origin[41] = "unit-inventor"
	ftm_cost[41] = 1
	ftm_origin_x[41] = 23
	ftm_origin_y[41] = 92
	ftm_unit[42] = "unit-yeoman"
	ftm_origin[42] = "unit-town-hall"
	ftm_cost[42] = 50
	ftm_origin_x[42] = 6
	ftm_origin_y[42] = 89
	ftm_unit[43] = "unit-gryphon-rider"
	ftm_origin[43] = "unit-gryphon-aviary"
	ftm_cost[43] = 1
	ftm_origin_x[43] = 31
	ftm_origin_y[43] = 92
	ftm_unit[44] = "unit-mage"
	ftm_origin[44] = "unit-mage-tower"
	ftm_cost[44] = 100
	ftm_origin_x[44] = 27
	ftm_origin_y[44] = 92
	ftm_unit[45] = "unit-peasant"
	ftm_origin[45] = "unit-town-hall"
	ftm_cost[45] = 25
	ftm_origin_x[45] = 6
	ftm_origin_y[45] = 89
	
	ftm_unit[51] = "unit-grunt"
	ftm_origin[51] = "unit-orc-barracks"
	ftm_cost[51] = 25
	ftm_origin_x[51] = 1
	ftm_origin_y[51] = 1
	ftm_unit[52] = "unit-quick-blade"
	ftm_origin[52] = "unit-orc-barracks"
	ftm_cost[52] = 200
	ftm_origin_x[52] = 1
	ftm_origin_y[52] = 1
	ftm_unit[53] = "unit-axethrower"
	ftm_origin[53] = "unit-orc-barracks"
	ftm_cost[53] = 25
	ftm_origin_x[53] = 1
	ftm_origin_y[53] = 1
	ftm_unit[54] = "unit-berserker"
	ftm_origin[54] = "unit-orc-barracks"
	ftm_cost[54] = 50
	ftm_origin_x[54] = 1
	ftm_origin_y[54] = 1
	ftm_unit[55] = "unit-sharp-axe"
	ftm_origin[55] = "unit-orc-barracks"
	ftm_cost[55] = 200
	ftm_origin_x[55] = 1
	ftm_origin_y[55] = 1
	ftm_unit[56] = "unit-ogre"
	ftm_origin[56] = "unit-orc-barracks"
	ftm_cost[56] = 75
	ftm_origin_x[56] = 1
	ftm_origin_y[56] = 1
	ftm_unit[57] = "unit-ogre-mage"
	ftm_origin[57] = "unit-orc-barracks"
	ftm_cost[57] = 125
	ftm_origin_x[57] = 1
	ftm_origin_y[57] = 1
	ftm_unit[58] = "unit-knight-rider"
	ftm_origin[58] = "unit-orc-barracks"
	ftm_cost[58] = 200
	ftm_origin_x[58] = 1
	ftm_origin_y[58] = 1
	ftm_unit[59] = "unit-catapult"
	ftm_origin[59] = "unit-orc-barracks"
	ftm_cost[59] = 125
	ftm_origin_x[59] = 1
	ftm_origin_y[59] = 1
	ftm_unit[60] = "unit-skeleton"
	ftm_origin[60] = "unit-great-hall"
	ftm_cost_gold[60] = 750
	ftm_cost_wood[60] = 0
	ftm_cost_oil[60] = 250
	ftm_origin_x[60] = 1
	ftm_origin_y[60] = 1
	ftm_unit[61] = "unit-goblin-sappers"
	ftm_origin[61] = "unit-alchemist"
	ftm_cost[61] = 100
	ftm_origin_x[61] = 1
	ftm_origin_y[61] = 1
	ftm_unit[62] = "unit-nomad"
	ftm_origin[62] = "unit-great-hall"
	ftm_cost[62] = 50
	ftm_origin_x[62] = 1
	ftm_origin_y[62] = 1
	ftm_unit[63] = "unit-dragon"
	ftm_origin[63] = "unit-dragon-roost"
	ftm_cost[63] = 150
	ftm_origin_x[63] = 1
	ftm_origin_y[63] = 1
	ftm_unit[64] = "unit-death-knight"
	ftm_origin[64] = "unit-temple-of-the-damned"
	ftm_cost[64] = 100
	ftm_origin_x[64] = 1
	ftm_origin_y[64] = 1
	ftm_unit[65] = "unit-peon"
	ftm_origin[65] = "unit-great-hall"
	ftm_cost[65] = 25
	ftm_origin_x[65] = 255
	ftm_origin_y[65] = 1
		
	ftm_unit[81] = "unit-grunt"
	ftm_origin[81] = "unit-orc-barracks"
	ftm_cost[81] = 25
	ftm_origin_x[81] = 78
	ftm_origin_y[81] = 55
	ftm_unit[82] = "unit-quick-blade"
	ftm_origin[82] = "unit-orc-barracks"
	ftm_cost[82] = 200
	ftm_origin_x[82] = 78
	ftm_origin_y[82] = 55
	ftm_unit[83] = "unit-axethrower"
	ftm_origin[83] = "unit-orc-barracks"
	ftm_cost[83] = 25
	ftm_origin_x[83] = 78
	ftm_origin_y[83] = 55
	ftm_unit[84] = "unit-berserker"
	ftm_origin[84] = "unit-orc-barracks"
	ftm_cost[84] = 50
	ftm_origin_x[84] = 78
	ftm_origin_y[84] = 55
	ftm_unit[85] = "unit-sharp-axe"
	ftm_origin[85] = "unit-orc-barracks"
	ftm_cost[85] = 200
	ftm_origin_x[85] = 78
	ftm_origin_y[85] = 55
	ftm_unit[86] = "unit-ogre"
	ftm_origin[86] = "unit-orc-barracks"
	ftm_cost[86] = 75
	ftm_origin_x[86] = 78
	ftm_origin_y[86] = 55
	ftm_unit[87] = "unit-ogre-mage"
	ftm_origin[87] = "unit-orc-barracks"
	ftm_cost[87] = 125
	ftm_origin_x[87] = 78
	ftm_origin_y[87] = 55
	ftm_unit[88] = "unit-knight-rider"
	ftm_origin[88] = "unit-orc-barracks"
	ftm_cost[88] = 200
	ftm_origin_x[88] = 78
	ftm_origin_y[88] = 55
	ftm_unit[89] = "unit-catapult"
	ftm_origin[89] = "unit-orc-barracks"
	ftm_cost[89] = 125
	ftm_origin_x[89] = 78
	ftm_origin_y[89] = 55
	ftm_unit[90] = "unit-skeleton"
	ftm_origin[90] = "unit-great-hall"
	ftm_cost_gold[90] = 750
	ftm_cost_wood[90] = 0
	ftm_cost_oil[90] = 250
	ftm_origin_x[90] = 81
	ftm_origin_y[90] = 86
	ftm_unit[91] = "unit-goblin-sappers"
	ftm_origin[91] = "unit-alchemist"
	ftm_cost[91] = 1
	ftm_origin_x[91] = 89
	ftm_origin_y[91] = 62
	ftm_unit[92] = "unit-nomad"
	ftm_origin[92] = "unit-great-hall"
	ftm_cost[92] = 50
	ftm_origin_x[92] = 81
	ftm_origin_y[92] = 86
	ftm_unit[93] = "unit-dragon"
	ftm_origin[93] = "unit-dragon-roost"
	ftm_cost[93] = 1
	ftm_origin_x[93] = 89
	ftm_origin_y[93] = 58
	ftm_unit[94] = "unit-death-knight"
	ftm_origin[94] = "unit-temple-of-the-damned"
	ftm_cost[94] = 100
	ftm_origin_x[94] = 89
	ftm_origin_y[94] = 54
	ftm_unit[95] = "unit-peon"
	ftm_origin[95] = "unit-great-hall"
	ftm_cost[95] = 25
	ftm_origin_x[95] = 81
	ftm_origin_y[95] = 86

	ftm_choice[0] = 3
	ftm_choice[1] = 2
	
    for i=0, 15 do
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
	
	-- AiRed Setup
	
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
	end
end

function AiRed_Resources_2014(t, g, w, o)
	g = GetPlayerData(t, "Resources", "gold") + g
	w = GetPlayerData(t, "Resources", "wood") + w
	o = GetPlayerData(t, "Resources", "oil") + o
	SetPlayerData(t, "Resources", "gold", g)
	SetPlayerData(t, "Resources", "wood", w)
	SetPlayerData(t, "Resources", "oil", o)
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

function AiRedRibbon_Common_2014()
	AiRed_Resources_2014(ftm_choice[AiPlayer()], 100, 50, 50)
	if ((timers[AiPlayer()] == 35) or (timers[AiPlayer()] == 85)) then
		AiNephrite_Flush_2013()
	elseif (timers[AiPlayer()] == 1) then	
		for i=0,15 do
			if (ftm_faction[AiPlayer()] == ftm_faction[i]) then
				SetSharedVision(AiPlayer(), true, i)
				SetSharedVision(i, true, AiPlayer())
				SetDiplomacy(AiPlayer(), "allied", i)
				SetDiplomacy(i, "allied", AiPlayer())
			else
				SetSharedVision(AiPlayer(), false, i)
				SetSharedVision(i, false, AiPlayer())
				SetDiplomacy(AiPlayer(), "enemy", i)
				SetDiplomacy(i, "enemy", AiPlayer())
			end
		end
	end
	AiRedRibbon_Research_2012()
	timers[AiPlayer()] = timers[AiPlayer()] + 1
	if (timers[AiPlayer()] == 101) then
		timers[AiPlayer()] = 1
	end
end

function AiRedRibbon_Survival_2014()
	if ((timers[AiPlayer()] >= 36) and (timers[AiPlayer()] <= 39) or (timers[AiPlayer()] >= 86) and (timers[AiPlayer()] <= 89)) then
		if ((timers[AiPlayer()] == 36) or (timers[AiPlayer()] == 86)) then
			X = 0
			Y = 0
		elseif ((timers[AiPlayer()] == 38) or (timers[AiPlayer()] == 88)) then
			X = 0
			Y = 96
		elseif ((timers[AiPlayer()] == 37) or (timers[AiPlayer()] == 87)) then
			X = 96
			Y = 96
		elseif ((timers[AiPlayer()] == 39) or (timers[AiPlayer()] == 89)) then
			X = 96
			Y = 0
		end
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
				if ((aiftm_unit[AiPlayer()][aiftm_index[AiPlayer()]] == ftm_unit[i]) and (GetPlayerData(AiPlayer(), "Resources", "oil") > (aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]*ftm_cost_oil[i])) and (GetPlayerData(AiPlayer(), "Resources", "wood") > (aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]*ftm_cost_wood[i])) and (GetPlayerData(AiPlayer(), "Resources", "gold") > (aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]]*ftm_cost_gold[i]))) then
					if (((GetNumUnitsAt(ftm_team[AiPlayer()], ftm_origin[i], {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (((ftm_origin[i] == AiCityCenter()) or (ftm_origin[i] == AiBetterCityCenter()) or (ftm_origin[i] == AiBestCityCenter())) and ((GetNumUnitsAt(ftm_team[AiPlayer()], AiCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(ftm_team[AiPlayer()], AiBetterCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(ftm_team[AiPlayer()], AiBestCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0)))) or (ftm_origin[i] == AiWise())) then
						for i=1, aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]] do
							CreateUnit(aiftm_unit[AiPlayer()][aiftm_index[AiPlayer()]], AiPlayer(), {ftm_team_tempx[AiPlayer()], ftm_team_tempy[AiPlayer()]})
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
						SetPlayerData(AiPlayer(), "Resources", "gold", (GetPlayerData(AiPlayer(), "Resources", "gold") - (ftm_cost_gold[i]*aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]])))
						SetPlayerData(AiPlayer(), "Resources", "wood", (GetPlayerData(AiPlayer(), "Resources", "wood") - (ftm_cost_wood[i]*aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]])))
						SetPlayerData(AiPlayer(), "Resources", "oil", (GetPlayerData(AiPlayer(), "Resources", "oil") - (ftm_cost_oil[i]*aiftm_quantity[AiPlayer()][aiftm_index[AiPlayer()]])))
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
	--elseif ((GameCycle > 20) and (GameCycle < 100)) then
	--	aiftm_mana[AiPlayer()] = 101
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

function AiRed_Strategy_Human_Support_2014(i)
	aiftm_unit[i][0] = "unit-peasant"
	aiftm_quantity[i][0] = 1
	aiftm_loop[i] = 10
	aiftm_terminate[i] = 17
	aiftm_unit[i][1] = "unit-footman"
	aiftm_quantity[i][1] = 3
	aiftm_unit[i][2] = "unit-footman"
	aiftm_quantity[i][2] = 3
	aiftm_unit[i][3] = "unit-ranger"
	aiftm_quantity[i][3] = 1
	aiftm_unit[i][4] = "unit-knight"
	aiftm_quantity[i][4] = 1
	aiftm_unit[i][5] = "unit-arthor-literios"
	aiftm_quantity[i][5] = 1
	aiftm_unit[i][6] = "unit-footman"
	aiftm_quantity[i][6] = 2
	aiftm_unit[i][7] = "unit-archer"
	aiftm_quantity[i][7] = 2
	aiftm_unit[i][8] = "unit-footman"
	aiftm_quantity[i][8] = 2
	aiftm_unit[i][9] = "unit-paladin"
	aiftm_quantity[i][9] = 1
	aiftm_unit[i][10] = "unit-knight"
	aiftm_quantity[i][10] = 2
	aiftm_unit[i][11] = "unit-archer"
	aiftm_quantity[i][11] = 2
	aiftm_unit[i][12] = "unit-mage"
	aiftm_quantity[i][12] = 1
	aiftm_unit[i][13] = "unit-footman"
	aiftm_quantity[i][13] = 3
	aiftm_unit[i][14] = "unit-knight"
	aiftm_quantity[i][14] = 1
	aiftm_unit[i][15] = "unit-knight"
	aiftm_quantity[i][15] = 1
	aiftm_unit[i][16] = "unit-archer"
	aiftm_quantity[i][16] = 2
	aiftm_unit[i][17] = "unit-footman"
	aiftm_quantity[i][17] = 2
end

function AiRed_Strategy_Orc_Mass_2014(i)
	aiftm_unit[i][0] = "unit-skeleton"
	aiftm_quantity[i][0] = 10
	aiftm_loop[i] = 4
	aiftm_terminate[i] = 14
	aiftm_unit[i][1] = "unit-goblin-sappers"
	aiftm_quantity[i][1] = 1
	aiftm_unit[i][2] = "unit-skeleton"
	aiftm_quantity[i][2] = 5
	aiftm_unit[i][3] = "unit-peon"
	aiftm_quantity[i][3] = 2
	aiftm_unit[i][4] = "unit-axethrower"
	aiftm_quantity[i][4] = 2
	aiftm_unit[i][5] = "unit-grunt"
	aiftm_quantity[i][5] = 2
	aiftm_unit[i][6] = "unit-nomad"
	aiftm_quantity[i][6] = 1
	aiftm_unit[i][7] = "unit-skeleton"
	aiftm_quantity[i][7] = 2
	aiftm_unit[i][8] = "unit-grunt"
	aiftm_quantity[i][8] = 2
	aiftm_unit[i][9] = "unit-catapult"
	aiftm_quantity[i][9] = 1
	aiftm_unit[i][10] = "unit-grunt"
	aiftm_quantity[i][10] = 4
	aiftm_unit[i][11] = "unit-berserker"
	aiftm_quantity[i][11] = 1
	aiftm_unit[i][12] = "unit-ogre"
	aiftm_quantity[i][12] = 1
	aiftm_unit[i][13] = "unit-ogre-mage"
	aiftm_quantity[i][13] = 1
	aiftm_unit[i][14] = "unit-grunt"
	aiftm_quantity[i][14] = 2
end

function AiRed_Strategy_Orc_Economy_2014(i)
	aiftm_unit[i][0] = "unit-grunt"
	aiftm_quantity[i][0] = 6
	aiftm_loop[i] = 4
	aiftm_terminate[i] = 16
	aiftm_unit[i][1] = "unit-peon"
	aiftm_quantity[i][1] = 2
	aiftm_unit[i][2] = "unit-berserker"
	aiftm_quantity[i][2] = 1
	aiftm_unit[i][3] = "unit-ogre-mage"
	aiftm_quantity[i][3] = 1
	aiftm_unit[i][4] = "unit-axethrower"
	aiftm_quantity[i][4] = 2
	aiftm_unit[i][5] = "unit-grunt"
	aiftm_quantity[i][5] = 3
	aiftm_unit[i][6] = "unit-nomad"
	aiftm_quantity[i][6] = 1
	aiftm_unit[i][7] = "unit-axethrower"
	aiftm_quantity[i][7] = 1
	aiftm_unit[i][8] = "unit-ogre"
	aiftm_quantity[i][8] = 1
	aiftm_unit[i][9] = "unit-catapult"
	aiftm_quantity[i][9] = 1
	aiftm_unit[i][10] = "unit-grunt"
	aiftm_quantity[i][10] = 4
	aiftm_unit[i][11] = "unit-grunt"
	aiftm_quantity[i][11] = 3
	aiftm_unit[i][12] = "unit-ogre"
	aiftm_quantity[i][12] = 1
	aiftm_unit[i][13] = "unit-dragon"
	aiftm_quantity[i][13] = 1
	aiftm_unit[i][14] = "unit-grunt"
	aiftm_quantity[i][14] = 4
	aiftm_unit[i][15] = "unit-axethrower"
	aiftm_quantity[i][15] = 1
	aiftm_unit[i][16] = "unit-quick-blade"
	aiftm_quantity[i][16] = 1
end

DefineAi("ai_redribbon_2014", "*", "ai_redribbon_2014", AiRedRibbon_2014)
DefineAi("ai_redribbon_survival_2014", "*", "ai_redribbon_survival_2014", AiRedRibbon_Survival_2014)
DefineAi("ai_red_2014", "*", "ai_red_2014", AiRed_2014)