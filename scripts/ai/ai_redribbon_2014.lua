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

local ftm_unit = {}
local ftm_origin = {}
local ftm_cost = {}
local ftm_origin_x = {}
local ftm_origin_y = {}

local ftm_team = {}
local ftm_team_x1 = {}
local ftm_team_y1 = {}
local ftm_team_x2 = {}
local ftm_team_y2 = {}

local ftm_choice = {} -- Who gets spawned in next.

local timer = {}

function AiRedRibbon_Setup_2014()
	ftm_unit[1] = "unit-footman"
	ftm_origin[1] = "unit-human-barracks"
	ftm_cost[1] = 25
	ftm_origin_x[1] = 150
	ftm_origin_y[1] = 150
	ftm_unit[2] = "unit-arthor-literios"
	ftm_origin[2] = "unit-human-barracks"
	ftm_cost[2] = 200
	ftm_origin_x[2] = 150
	ftm_origin_y[2] = 150
	ftm_unit[3] = "unit-archer"
	ftm_origin[3] = "unit-human-barracks"
	ftm_cost[3] = 25
	ftm_origin_x[3] = 150
	ftm_origin_y[3] = 150
	ftm_unit[4] = "unit-ranger"
	ftm_origin[4] = "unit-human-barracks"
	ftm_cost[4] = 50
	ftm_origin_x[4] = 150
	ftm_origin_y[4] = 150
	ftm_unit[5] = "unit-female-hero"
	ftm_origin[5] = "unit-human-barracks"
	ftm_cost[5] = 200
	ftm_origin_x[5] = 150
	ftm_origin_y[5] = 150
	ftm_unit[6] = "unit-knight"
	ftm_origin[6] = "unit-human-barracks"
	ftm_cost[6] = 75
	ftm_origin_x[6] = 150
	ftm_origin_y[6] = 150
	ftm_unit[7] = "unit-paladin"
	ftm_origin[7] = "unit-human-barracks"
	ftm_cost[7] = 125
	ftm_origin_x[7] = 150
	ftm_origin_y[7] = 150
	ftm_unit[8] = "unit-knight-rider"
	ftm_origin[8] = "unit-human-barracks"
	ftm_cost[8] = 200
	ftm_origin_x[8] = 150
	ftm_origin_y[8] = 150
	ftm_unit[9] = "unit-ballista"
	ftm_origin[9] = "unit-human-barracks"
	ftm_cost[9] = 125
	ftm_origin_x[9] = 150
	ftm_origin_y[9] = 150
	ftm_unit[10] = "unit-attack-peasant"
	ftm_origin[10] = "unit-town-hall"
	ftm_cost[10] = 15
	ftm_origin_x[10] = 255
	ftm_origin_y[10] = 1
	ftm_unit[11] = "unit-dwarves"
	ftm_origin[11] = "unit-inventor"
	ftm_cost[11] = 150
	ftm_origin_x[11] = 150
	ftm_origin_y[11] = 150
	ftm_unit[12] = "unit-yeoman"
	ftm_origin[12] = "unit-town-hall"
	ftm_cost[12] = 50
	ftm_origin_x[12] = 255
	ftm_origin_y[12] = 1
	ftm_unit[13] = "unit-gryphon-rider"
	ftm_origin[13] = "unit-gryphon-aviary"
	ftm_cost[13] = 150
	ftm_origin_x[13] = 150
	ftm_origin_y[13] = 150
	ftm_unit[14] = "unit-mage"
	ftm_origin[14] = "unit-mage-tower"
	ftm_cost[14] = 100
	ftm_origin_x[14] = 150
	ftm_origin_y[14] = 150
	ftm_unit[15] = "unit-peasant"
	ftm_origin[15] = "unit-town-hall"
	ftm_cost[15] = 25
	ftm_origin_x[15] = 255
	ftm_origin_y[15] = 1
	
	
	

	CreateUnit("unit-human-barracks", 1, {149, 149})
	
	ftm_team[0] = 1
	ftm_team[1] = 2
	ftm_team[2] = 2
	ftm_team_x1[2] = 0
	ftm_team_y1[2] = 0
	ftm_team_x2[2] = 256
	ftm_team_y2[2] = 256
	ftm_team[3] = 1
	
	ftm_choice[0] = 3
	ftm_choice[1] = 2
	
	timer[0] = 1
	timer[1] = 1
end

function AiRedRibbon_2014()
	if (ftm_unit[1] == nil) then
		AiRedRibbon_Setup_2014()
	end
	AiNephrite_Expand_2013()
	if ((timer[AiPlayer()] == 50) or (timer[AiPlayer()] == 100)) then
		if (ftm_team[AiPlayer()] == ftm_team[ftm_choice[AiPlayer()]]) then
			for i=1,15 do
				if ((GetNumUnitsAt(AiPlayer(), ftm_origin[i], {(ftm_origin_x[i] - 3), (ftm_origin_y[i] - 3)}, {(ftm_origin_x[i] + 3), (ftm_origin_y[i] + 3)}) > 0) and (GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) > 0)) then
					AddMessage(ftm_unit[i])
					for j=1,GetNumUnitsAt(ftm_choice[AiPlayer()], ftm_unit[i], {ftm_team_x1[ftm_choice[AiPlayer()]], ftm_team_y1[ftm_choice[AiPlayer()]]}, {ftm_team_x2[ftm_choice[AiPlayer()]], ftm_team_y2[ftm_choice[AiPlayer()]]}) do
						CreateUnit(ftm_unit[i], AiPlayer(), {ftm_origin_x[i], ftm_origin_y[i]})
					end
				end
			end
			AiNephrite_Attack_2013()
		end
	elseif ((timer[AiPlayer()] == 25) or (timer[AiPlayer()] == 75)) then
		AiNephrite_Attack_2013()
	elseif ((timer[AiPlayer()] == 35) or (timer[AiPlayer()] == 85)) then
		AiNephrite_Flush_2013()
	elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 0)) then
		AiNephrite_Research_2013()
	end
	timer[AiPlayer()] = timer[AiPlayer()] + 1
	if (timer[AiPlayer()] == 101) then
		timer[AiPlayer()] = 1
	end
end

DefineAi("ai_redribbon_2014", "*", "ai_redribbon_2014", AiRedRibbon_2014)