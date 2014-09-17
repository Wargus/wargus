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
--	ai_redribbon.lua - Define the AI.
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

function AiRedRibbon_Setup_2014()
	timers = {}
	ftm_team = {}
	ftm_team_startx = {}
	ftm_team_starty = {}
	ftm_team_x1 = {}
	ftm_team_y1 = {}
	ftm_team_x2 = {}
    ftm_team_y2 = {}
	ftm_unit = {}
	ftm_origin = {}
	ftm_cost = {}
	ftm_origin_x = {}
	ftm_origin_y = {}
	ftm_choice = {} -- Who gets spawned in next.
	ftm_index_start = {}
	ftm_index_end = {}
	ftm_unit[1] = "unit-footman"
	ftm_origin[1] = "unit-human-barracks"
	ftm_cost[1] = 25
	ftm_origin_x[1] = 1
	ftm_origin_y[1] = 1
	ftm_unit[2] = "unit-arthor-literios"
	ftm_origin[2] = "unit-human-barracks"
	ftm_cost[2] = 200
	ftm_origin_x[2] = 1
	ftm_origin_y[2] = 1
	ftm_unit[3] = "unit-archer"
	ftm_origin[3] = "unit-human-barracks"
	ftm_cost[3] = 25
	ftm_origin_x[3] = 1
	ftm_origin_y[3] = 1
	ftm_unit[4] = "unit-ranger"
	ftm_origin[4] = "unit-human-barracks"
	ftm_cost[4] = 50
	ftm_origin_x[4] = 1
	ftm_origin_y[4] = 1
	ftm_unit[5] = "unit-female-hero"
	ftm_origin[5] = "unit-human-barracks"
	ftm_cost[5] = 200
	ftm_origin_x[5] = 1
	ftm_origin_y[5] = 1
	ftm_unit[6] = "unit-knight"
	ftm_origin[6] = "unit-human-barracks"
	ftm_cost[6] = 75
	ftm_origin_x[6] = 1
	ftm_origin_y[6] = 1
	ftm_unit[7] = "unit-paladin"
	ftm_origin[7] = "unit-human-barracks"
	ftm_cost[7] = 125
	ftm_origin_x[7] = 1
	ftm_origin_y[7] = 1
	ftm_unit[8] = "unit-knight-rider"
	ftm_origin[8] = "unit-human-barracks"
	ftm_cost[8] = 200
	ftm_origin_x[8] = 1
	ftm_origin_y[8] = 1
	ftm_unit[9] = "unit-ballista"
	ftm_origin[9] = "unit-human-barracks"
	ftm_cost[9] = 125
	ftm_origin_x[9] = 1
	ftm_origin_y[9] = 1
	ftm_unit[10] = "unit-attack-peasant"
	ftm_origin[10] = "unit-town-hall"
	ftm_cost[10] = 15
	ftm_origin_x[10] = 1
	ftm_origin_y[10] = 1
	ftm_unit[11] = "unit-dwarves"
	ftm_origin[11] = "unit-inventor"
	ftm_cost[11] = 1
	ftm_origin_x[11] = 1
	ftm_origin_y[11] = 1
	ftm_unit[12] = "unit-yeoman"
	ftm_origin[12] = "unit-town-hall"
	ftm_cost[12] = 50
	ftm_origin_x[12] = 1
	ftm_origin_y[12] = 1
	ftm_unit[13] = "unit-gryphon-rider"
	ftm_origin[13] = "unit-gryphon-aviary"
	ftm_cost[13] = 1
	ftm_origin_x[13] = 1
	ftm_origin_y[13] = 1
	ftm_unit[14] = "unit-mage"
	ftm_origin[14] = "unit-mage-tower"
	ftm_cost[14] = 100
	ftm_origin_x[14] = 1
	ftm_origin_y[14] = 1
	ftm_unit[15] = "unit-peasant"
	ftm_origin[15] = "unit-town-hall"
	ftm_cost[15] = 25
	ftm_origin_x[15] = 1
	ftm_origin_y[15] = 1
	
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
	ftm_cost[60] = 15
	ftm_origin_x[60] = 1
	ftm_origin_y[60] = 1
	ftm_unit[61] = "unit-goblin-sappers"
	ftm_origin[61] = "unit-alchemist"
	ftm_cost[61] = 1
	ftm_origin_x[61] = 1
	ftm_origin_y[61] = 1
	ftm_unit[62] = "unit-nomad"
	ftm_origin[62] = "unit-great-hall"
	ftm_cost[62] = 50
	ftm_origin_x[62] = 1
	ftm_origin_y[62] = 1
	ftm_unit[63] = "unit-dragon"
	ftm_origin[63] = "unit-dragon-roost"
	ftm_cost[63] = 1
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
	
	ftm_team[0] = 1000
	ftm_team[1] = 2000
	ftm_team[2] = 3000
	ftm_team_x1[2] = 0
	ftm_team_y1[2] = 0
	ftm_team_x2[2] = 256
	ftm_team_y2[2] = 256
	ftm_team[3] = 4000
	ftm_team_x1[3] = 0
	ftm_team_y1[3] = 0
	ftm_team_x2[3] = 256
	ftm_team_y2[3] = 256
	ftm_team_startx[0] = 1
	ftm_team_starty[0] = 1
	ftm_team_startx[1] = 1
	ftm_team_starty[1] = 1
	ftm_team_startx[2] = 1
	ftm_team_starty[2] = 1
	ftm_team_startx[3] = 1
	ftm_team_starty[3] = 1
	
	ftm_choice[0] = 3
	ftm_choice[1] = 2
	
	timers[0] = 1
	timers[1] = 1
	
	ftm_index_start[0] = 51
	ftm_index_end[0] = 65
	ftm_index_start[1] = 1
	ftm_index_end[1] = 15
end

function AiRedRibbon_2014()
	--if (ftm_unit ~= {}) then
		--AiRedRibbon_Setup_2014()
	--end
	if ((timers[AiPlayer()] == 50) or (timers[AiPlayer()] == 100)) then
		AddMessage("Time to spawn in.")
		if (ftm_team[AiPlayer()] == ftm_team[ftm_choice[AiPlayer()]]) then
			for i=ftm_index_start[AiPlayer()],ftm_index_end[AiPlayer()] do
				if ((GetNumUnitsAt(AiPlayer(), ftm_origin[i], {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (((ftm_origin[i] == AiCityCenter()) or (ftm_origin[i] == AiBetterCityCenter()) or (ftm_origin[i] == AiBestCityCenter())) and ((GetNumUnitsAt(AiPlayer(), AiCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(AiPlayer(), AiBetterCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) or (GetNumUnitsAt(AiPlayer(), AiBestCityCenter(), {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0)))) then
					if (GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) > 0) then
						AddMessage(ftm_unit[i])
						for j=1,GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) do
							CreateUnit(ftm_unit[i], AiPlayer(), {ftm_origin_x[i], ftm_origin_y[i]})
						end
					end
				end
			end
			AiNephrite_Attack_2013()
		end
	elseif ((timers[AiPlayer()] == 35) or (timers[AiPlayer()] == 85)) then
		AiNephrite_Flush_2013()
	elseif (timers[AiPlayer()] == 1) then	
		for i=0,3 do
			if (ftm_team[AiPlayer()] == ftm_team[i]) then
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

DefineAi("ai_redribbon_2014", "*", "ai_redribbon_2014", AiRedRibbon_2014)