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
--	(c) Copyright 2015 by Kyran Jackson
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

function SetPlayerGame2015(player, race, ai, faction, gold, wood, oil, startx, starty, varA1, varA2, varB1, varB2, varC1, varC2)
	if (ai == "surprise") then
		repeat
			temp = SyncRand(5) + SyncRand(5)
			if (temp == 0) then
				ai = "Land Attack"
			elseif (temp == 1) then
				ai = "Jadeite"
			elseif (temp == 2) then
				ai = "Morga"
			elseif (temp == 3) then
				ai = "Flau"
			elseif (temp == 4) then
				ai = "Kyurene"
			elseif (temp == 5) then
				ai = "Nephrite"
			elseif (temp == 6) then
				ai = "Regulus"
			elseif (temp == 7) then
				ai = "Flau"
			end
		until (ai ~= "surprise")
		ai = "Morga"
	end
	SetupPlayer(player, race, ai, gold, wood, oil, startx, starty)
	-- Check game type.
	if (player ~= nil) then
		-- if Gametype = Frontlines
		ftm_team_x1[player] = 0
		ftm_team_y1[player] = 0
		ftm_team_x2[player] = 1024
		ftm_team_y2[player] = 1024
		if (varA1 ~= nil) then
			ftm_team_x1[player] = varA1
			if (varA2 ~= nil) then
				ftm_team_y1[player] = varA2
				if (varB1 ~= nil) then
					ftm_team_x2[player] = varB1
					if (varB2 ~= nil) then
						ftm_team_y2[player] = varB2
					end
				end
			end
		end
		ftm_team[player] = varC1
		ftm_team_startx[player] = startx
		ftm_team_starty[player] = starty
		ftm_faction[player] = faction
	end
end

function AiFrontlines_2015()
	for player = 0, 15 do
		if ((ftm_faction[AiPlayer()] == ftm_faction[player]) and (player ~= AiPlayer())) then
			if (GameDefinition["Version"] == "Advanced") then
				-- Teleport the unit!
				if ((timers[AiPlayer()] == 1) or (timers[AiPlayer()] == 11) or (timers[AiPlayer()] == 21) or (timers[AiPlayer()] == 31) or (timers[AiPlayer()] == 41) or (timers[AiPlayer()] == 51) or (timers[AiPlayer()] == 61) or (timers[AiPlayer()] == 71) or (timers[AiPlayer()] == 81) or (timers[AiPlayer()] == 91) or (timers[AiPlayer()] == 101) or (timers[AiPlayer()] == 111) or (timers[AiPlayer()] == 121) or (timers[AiPlayer()] == 131) or (timers[AiPlayer()] == 141) or (timers[AiPlayer()] == 151) or (timers[AiPlayer()] == 161) or (timers[AiPlayer()] == 171) or (timers[AiPlayer()] == 181) or (timers[AiPlayer()] == 191) or
				(timers[AiPlayer()] == 6) or (timers[AiPlayer()] == 16) or (timers[AiPlayer()] == 26) or (timers[AiPlayer()] == 36) or (timers[AiPlayer()] == 46) or (timers[AiPlayer()] == 56) or (timers[AiPlayer()] == 66) or (timers[AiPlayer()] == 76) or (timers[AiPlayer()] == 86) or (timers[AiPlayer()] == 96) or (timers[AiPlayer()] == 106) or (timers[AiPlayer()] == 116) or (timers[AiPlayer()] == 126) or (timers[AiPlayer()] == 136) or (timers[AiPlayer()] == 146) or (timers[AiPlayer()] == 156) or (timers[AiPlayer()] == 166) or (timers[AiPlayer()] == 176) or (timers[AiPlayer()] == 186) or (timers[AiPlayer()] == 196)) then
					for index = 1, 15 do
						if ((GetPlayerData(player, "RaceName") == "orc") or (GetPlayerData(player, "RaceName") == "wild")) then temp = 50 else temp = 0 end
						if (GetNumUnitsAt(player, ftm_unit[index+temp], {ftm_team_x1[player], ftm_team_y1[player]}, {ftm_team_x2[player], ftm_team_y2[player]}) > 0) then
							KillUnitAt(ftm_unit[index+temp], player, 1, {ftm_team_x1[player], ftm_team_y1[player]}, {ftm_team_x2[player], ftm_team_y2[player]})
							CreateUnit(ftm_unit[index+temp], AiPlayer(), {ftm_team_startx[AiPlayer()], ftm_team_starty[AiPlayer()]})
							break
						end
					end
				end
			else
				-- Change unit ownership!
				ChangeUnitsOwner({ftm_team_x1[player], ftm_team_y1[player]}, {ftm_team_x2[player], ftm_team_y2[player]}, player, AiPlayer())
			end
		end
	end
	if ((timers[AiPlayer()] == nil) or (timers[AiPlayer()] < 1)) then
		timers[AiPlayer()] = 50
	elseif (timers[AiPlayer()] == 23) then
		if (GetPlayerData(AiPlayer(), "TotalNumUnits") > 0) then
			for player = 0, 15 do
				if (ftm_faction[AiPlayer()] ~= ftm_faction[player]) then
					for index = 1, 15 do
						if (GetNumUnitsAt(AiPlayer(), ftm_unit[index], {0,0}, {mapinfo.w,mapinfo.h}) > 0) then
							OrderUnit(AiPlayer(), ftm_unit[index], {0,0,mapinfo.w,mapinfo.h}, {ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]],ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]]}, "attack")
						end
						if (GetNumUnitsAt(AiPlayer(), ftm_unit[index+50], {0,0}, {mapinfo.w,mapinfo.h}) > 0) then
							OrderUnit(AiPlayer(), ftm_unit[index+50], {0,0,mapinfo.w,mapinfo.h}, {ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]],ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]]}, "attack")
						end
					end
					break
				end
			end
		end
		timers[AiPlayer()] = timers[AiPlayer()] - 1
	elseif (timers[AiPlayer()] == 1) then
		repeat
			timers[AiPlayer()] = SyncRand(25) + SyncRand(25)
		until timers[AiPlayer()] > 25
	else
		timers[AiPlayer()] = timers[AiPlayer()] - 1
	end
end

function AiPlayer_Check_2015(player, ai)
	if (((ai == nil) and ((GetPlayerData(AiPlayer(), "Name") == "Computer") or (GetPlayerData(AiPlayer(), "Name") == "Land Attack") or
		(GetPlayerData(AiPlayer(), "Name") == "Jadeite") or (GetPlayerData(AiPlayer(), "Name") == "Morga") or 
		(GetPlayerData(AiPlayer(), "Name") == "Flau") or (GetPlayerData(AiPlayer(), "Name") == "Kyurene") or
		(GetPlayerData(AiPlayer(), "Name") == "Nephrite") or (GetPlayerData(AiPlayer(), "Name") == "Regulus") or
		(GetPlayerData(AiPlayer(), "Name") == "Zoisite"))) or (GetPlayerData(AiPlayer(), "Name") == ai)) then
		return true
	end
end

function AiRed_2015()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWise()) > 0) and (GameCycle > 500)) then
		if ((timers[ftm_team[AiPlayer()]] == 50) or (timers[ftm_team[AiPlayer()]] == 99) or (timers[ftm_team[AiPlayer()]] == 25) or (timers[ftm_team[AiPlayer()]] == 75)) then
		else
			if ((aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= 0) and (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= "summon") and (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= "spawn")) then
				-- Actions
				AiRed_Action_2015(AiPlayer())
			else	
				-- Spawn
				for i=ftm_index_start[ftm_team[AiPlayer()]],ftm_index_end[ftm_team[AiPlayer()]] do
					if ((aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] == 0) or (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] == "summon") or (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] == "spawn")) then
						if (AiRed_Check_Unit_2014(AiPlayer(), i) == true) then
							if (AiRed_Check_Building_2014(AiPlayer(), i) == true) then
								if ((aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= "summon") and (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= "spawn")) then
									AiRed_Spawn_2014(AiPlayer(), i)
									AiRed_GridChange_2014(AiPlayer())
								else
									AiRed_Spawn_2014(AiPlayer(), i, nil, aiftm_x_to[AiPlayer()][aiftm_index[AiPlayer()]], aiftm_y_to[AiPlayer()][aiftm_index[AiPlayer()]])
								end
								AiRed_Resources_Remove_2014(AiPlayer(), (ftm_cost_gold[i]), (ftm_cost_wood[i]), (ftm_cost_oil[i]))
							end
							aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] = "next"
						end
					end
				end
			end
		end
	elseif ((ftm_team_tempx[AiPlayer()] < 2) and (GameCycle > 100)) then
		AiRed_GridSetup_2014(AiPlayer())
	end
end

function AiRed_Action_2015(player)
	if ((aiftm_action[player][aiftm_index[player]] == "skip") or (aiftm_action[player][aiftm_index[player]] == "next") or
		((aiftm_action[player][aiftm_index[player]] == "wait") and (GameCycle >= aiftm_quantity[player][aiftm_index[player]])) or 
		((aiftm_action[player][aiftm_index[player]] == "gold") and (GetPlayerData(player, "Resources", "gold") >= aiftm_quantity[player][aiftm_index[player]])) or 
		((aiftm_action[player][aiftm_index[player]] == "wood") and (GetPlayerData(player, "Resources", "wood") >= aiftm_quantity[player][aiftm_index[player]])) or 
		((aiftm_action[player][aiftm_index[player]] == "oil") and (GetPlayerData(player, "Resources", "oil") >= aiftm_quantity[player][aiftm_index[player]]))) then
		if (((aiftm_action[player][aiftm_index[player]] == "skip") or (aiftm_action[player][aiftm_index[player]] == "next")) and (aiftm_quantity[player][aiftm_index[player]] > 1)) then
			aiftm_quantity[player][aiftm_index[player]] = aiftm_quantity[player][aiftm_index[player]] - 1
			if ((aiftm_unit[player][aiftm_index[player]] ~= nil) and (aiftm_action[player][aiftm_index[player]] == "next")) then
				aiftm_action[player][aiftm_index[player]] = "summon"
			end
		else
			AiRed_Increment_2014(player)
		end
	elseif ((aiftm_action[player][aiftm_index[player]] == "attack") or (aiftm_action[player][aiftm_index[player]] == "move") or (aiftm_action[player][aiftm_index[player]] == "patrol") or (aiftm_action[player][aiftm_index[player]] == "attack area") or (aiftm_action[player][aiftm_index[player]] == "move area") or (aiftm_action[player][aiftm_index[player]] == "patrol area")) then
		if ((aiftm_y_from[player][aiftm_index[player]] == nil) or (aiftm_x_from[player][aiftm_index[player]] == nil)) then
			OrderUnit(player, aiftm_unit[player][aiftm_index[player]], {0,0,mapinfo.w,mapinfo.h}, {aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]],aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]]}, aiftm_action[player][aiftm_index[player]])
		else
			if ((aiftm_action[player][aiftm_index[player]] == "attack area") or (aiftm_action[player][aiftm_index[player]] == "move area") or (aiftm_action[player][aiftm_index[player]] == "patrol area")) then
				if (aiftm_action[player][aiftm_index[player]] == "attack area") then aiftm_action[player][aiftm_index[player]] = "attack" end
				if (aiftm_action[player][aiftm_index[player]] == "move area") then aiftm_action[player][aiftm_index[player]] = "move" end
				if (aiftm_action[player][aiftm_index[player]] == "patrol area") then aiftm_action[player][aiftm_index[player]] = "patrol" end
				OrderUnit(player, aiftm_unit[player][aiftm_index[player]], {aiftm_x_from[player][aiftm_index[player]]-7,aiftm_y_from[player][aiftm_index[player]]-7,aiftm_x_from[player][aiftm_index[player]]+7,aiftm_y_from[player][aiftm_index[player]]+7}, {aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]],aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]]}, aiftm_action[player][aiftm_index[player]])
			else
				OrderUnit(player, aiftm_unit[player][aiftm_index[player]], {aiftm_x_from[player][aiftm_index[player]],aiftm_y_from[player][aiftm_index[player]],aiftm_x_from[player][aiftm_index[player]],aiftm_y_from[player][aiftm_index[player]]}, {aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]],aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]]}, aiftm_action[player][aiftm_index[player]])
			end
		end
		aiftm_action[player][aiftm_index[player]] = "skip"
	--elseif ((aiftm_action[player][aiftm_index[player]] == "attack all") or (aiftm_action[player][aiftm_index[player]] == "move all") or (aiftm_action[player][aiftm_index[player]] == "patrol all")) then
	--	OrderUnit(player, aiftm_unit[player][aiftm_index[player]], {0,0,mapinfo.w,mapinfo.h}, {aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]],aiftm_x_to[player][aiftm_index[player]],aiftm_y_to[player][aiftm_index[player]]}, aiftm_action[player][aiftm_index[player]])
	--	aiftm_action[player][aiftm_index[player]] = "skip"
	elseif (aiftm_action[player][aiftm_index[player]] == "loop") then
		aiftm_index[player] = aiftm_quantity[player][aiftm_index[player]]
	end
end

function AiRed_Strategy_Action_2015(i, j, action, quantity, unit, x_to, y_to, x_from, y_from)
	-- i, j, "Gold", 5000
	-- i, j, "Oil", 5000
	-- i, j, "Move", 1, "unit-caanoo-wiseman", tox, toy, fromx, fromy
	-- i, j, "Attack", "All", "Fodder"
	if (quantity == nil) then
		quantity = 1
	end
	aiftm_action[i][j] = action
	aiftm_quantity[i][j] = quantity
	if (unit ~= nil) then
		aiftm_x_to[i][j] = x_to
		aiftm_y_to[i][j] = y_to
		aiftm_x_from[i][j] = x_from
		aiftm_y_from[i][j] = y_from
		AiRed_Strategy_Insert_2015(i, j, 1, unit)
	end
end

function AiRed_Strategy_Insert_2015(i, j, slot, unit, option1, option2)
	if (option2 == nil) then
		option2 = unit
		if (option1 == nil) then
			option1 = unit
		end
	end
	if (slot == 2) then
		aiftm_unit2[i][j] = unit
		aiftm_unit2_option1[i][j] = option1
		aiftm_unit2_option2[i][j] = option2
	elseif (slot == 3) then
		aiftm_unit3[i][j] = unit
		aiftm_unit3_option1[i][j] = option1
		aiftm_unit3_option2[i][j] = option2
	else
		aiftm_unit[i][j] = unit
		aiftm_unit_option1[i][j] = option1
		aiftm_unit_option2[i][j] = option2
	end
end

function AiRed_Strategy_Choice_2015(i, j, unit, or1, unit2, or2, unit3, slot)
	if (slot == nil) then
		slot = 1
	end
	if (unit2 == nil) then
		if (type (or1) == "string") then
			AiRed_Strategy_Insert_2014(i, j, unit)
		else
			AiRed_Strategy_Insert_2014(i, j, unit, or1)
		end
	else
		aiftm_unit[i][j] = unit
		if ((or1 == "and") and (or1 == "and")) then 
			AiRed_Strategy_Insert_2015(i, j, slot, unit, unit2, unit3)
		elseif ((or1 == "or") and (or1 == "or")) then 
			AiRed_Strategy_Insert_2015(i, j, 1, unit)
			AiRed_Strategy_Insert_2015(i, j, 2, unit2)
			AiRed_Strategy_Insert_2015(i, j, 3, unit3)
		elseif ((or1 == "and") and (or1 == "or")) then 
			AiRed_Strategy_Insert_2015(i, j, 1, unit, unit2)
			AiRed_Strategy_Insert_2015(i, j, 2, unit3)
		elseif ((or1 == "or") and (or1 == "and")) then 
			AiRed_Strategy_Insert_2015(i, j, 1, unit)
			AiRed_Strategy_Insert_2015(i, j, 2, unit2, unit3)
		end
	end
end

function AiShane_2015()
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiShane_FtM_2015(AiPlayer())
	end
end

function AiAya_2015()
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiAya_FtM_2015(AiPlayer())
	end
end

function AiShane_FtM_2015(player)
	if ((GameCycle < 50) or (aiftm_action[player][aiftm_index[player]] == "loop")) then
		--Check map.
		if (GameDefinition["Map"]["Name"] == "Rockfort Arena") then
			AiShane_FtM_Rockfort_Arena_2015(player)
		elseif (GameDefinition["Map"]["Name"] == "One Way Through") then
			AiShane_FtM_One_Way_Through_2015(player)
		end
	end
	AiRed_2015()
end

function AiAya_FtM_2015(player)
	if ((GameCycle < 50) or (aiftm_action[player][aiftm_index[player]] == "loop")) then
		--Check map.
		if (GameDefinition["Map"]["Name"] == "Rockfort Arena") then
			AiAya_FtM_Rockfort_Arena_2015(player)
		elseif (GameDefinition["Map"]["Name"] == "One Way Through") then
			--AiAya_FtM_One_Way_Through_2015(player)
		end
	end
	AiRed_2015()
end

function AiShane_FtM_One_Way_Through_2015(player)
	aiftm_terminate[player] = 1000
	x = ftm_team_x1[player]
	y = ftm_team_y1[player]
	AiRed_Strategy_Action_2015(player, 0, "summon", 1, AiEliteShooter(), x, y+1)
	-- 1
	AiRed_Strategy_Action_2015(player, 2, "summon", 1, AiSoldier(), x+1, y)
	AiRed_Strategy_Action_2015(player, 3, "summon", 1, AiSoldier(), x+2, y)
	AiRed_Strategy_Action_2015(player, 4, "summon", 1, AiCavalryMage(), x, y)
	AiRed_Strategy_Action_2015(player, 5, "summon", 1, AiEliteShooter(), x+2, y+1)
	AiRed_Strategy_Action_2015(player, 6, "summon", 1, AiMage(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 7, "summon", 1, AiHeroRider(), x+1, y+2)
	AiRed_Strategy_Action_2015(player, 8, "summon", 1, AiCatapult(), x, y+2)
	AiRed_Strategy_Action_2015(player, 9, "summon", 1, AiFlyer(), x+2, y+2)
	if (player == 14) then
		AiRed_Strategy_Action_2015(player, 1, "attack", 1, AiEliteShooter(), x-1, y-1, x, y+1)
		AiRed_Strategy_Action_2015(player, 10, "attack", 1, AiSoldier(), x+3, y-1, x+2, y)
		AiRed_Strategy_Action_2015(player, 11, "attack", 1, AiSoldier(), x+2, y-1, x+1, y)
		AiRed_Strategy_Action_2015(player, 12, "attack", 1, AiCavalryMage(), x+1, y-1, x, y)
		AiRed_Strategy_Action_2015(player, 19, "skip", 1)
		AiRed_Strategy_Action_2015(player, 33, "summon", 5, AiLonerShooter(), 4, 15)
		AiRed_Strategy_Action_2015(player, 34, "summon", 10, AiShooter(), 0, 12)
		AiRed_Strategy_Action_2015(player, 35, "summon", 5, AiSoldier(), 0, 17)
		AiRed_Strategy_Action_2015(player, 36, "attack", 10, AiShooter(), 60, 45)
		AiRed_Strategy_Action_2015(player, 37, "attack", 5, AiSoldier(), 61, 46)
		AiRed_Strategy_Action_2015(player, 38, "summon", 1, "hero", x+1, y+1)
	elseif (player == 13) then
		AiRed_Strategy_Action_2015(player, 1, "summon", 1, AiShooter(), x+1, y+1)
		AiRed_Strategy_Action_2015(player, 10, "skip", 1)
		AiRed_Strategy_Action_2015(player, 11, "skip", 1)
		AiRed_Strategy_Action_2015(player, 12, "skip", 1)
		AiRed_Strategy_Action_2015(player, 19, "move", 1, AiShooter(), x+1, y, x+1, y+1)
		AiRed_Strategy_Action_2015(player, 33, "summon", 5, AiLonerShooter(), 50, 60)
		AiRed_Strategy_Action_2015(player, 34, "summon", 5, AiShooter(), 50, 60)
		AiRed_Strategy_Action_2015(player, 35, "summon", 5, AiSoldier(), 50, 60)
		AiRed_Strategy_Action_2015(player, 36, "attack", 5, AiShooter(), 1, 23)
		AiRed_Strategy_Action_2015(player, 37, "attack", 5, AiSoldier(), 2, 24)
		AiRed_Strategy_Action_2015(player, 38, "summon", 1, "hero", 50, 60)
	end
	AiRed_Strategy_Action_2015(player, 13, "skip", 15)
	AiRed_Strategy_Action_2015(player, 14, "move", 1, AiSoldier(), 35, 33, x+2, y)
	AiRed_Strategy_Action_2015(player, 15, "move", 1, AiEliteShooter(), x+2, y, x+2, y+1)
	AiRed_Strategy_Action_2015(player, 16, "summon", 1, AiHeroRider(), x+2, y+1)
	AiRed_Strategy_Action_2015(player, 17, "summon", 1, AiFlyer(), x, y+2)
	AiRed_Strategy_Action_2015(player, 18, "move", 1, AiSoldier(), 33, 35, x+1, y)
	AiRed_Strategy_Action_2015(player, 20, "summon", 1, AiHeroRider(), x+1, y+1)
	AiRed_Strategy_Action_2015(player, 21, "move", 1, AiCavalryMage(), 34, 34, x, y)
	AiRed_Strategy_Action_2015(player, 22, "move", 1, AiEliteShooter(), x, y, x, y+1)
	AiRed_Strategy_Action_2015(player, 23, "summon", 1, AiCatapult(), x, y+1)
	AiRed_Strategy_Action_2015(player, 24, "summon", 1, AiFlyer(), x+2, y)
	AiRed_Strategy_Action_2015(player, 25, "move", 1, AiShooter(), 50, 41, x+1, y)
	AiRed_Strategy_Action_2015(player, 26, "summon", 1, AiHeroRider(), x+1, y)
	AiRed_Strategy_Action_2015(player, 27, "move", 1, AiEliteShooter(), 41, 50, x+2, y)
	AiRed_Strategy_Action_2015(player, 28, "summon", 1, AiHeroRider(), x+2, y)
	AiRed_Strategy_Action_2015(player, 29, "move", 1, AiEliteShooter(), 40, 51, x, y)
	AiRed_Strategy_Action_2015(player, 30, "summon", 1, AiHeroShooter(), x, y)
	AiRed_Strategy_Action_2015(player, 31, "summon", 1, AiFlyer(), x, y)
	AiRed_Strategy_Action_2015(player, 32, "skip", 10)
	AiRed_Strategy_Action_2015(player, 39, "loop", 28)
end

function AiAya_FtM_Rockfort_Arena_2015(player)
	aiftm_terminate[player] = 1000
	x = ftm_team_x1[player]
	y = ftm_team_y1[player]
	if (player == 8) then
		AiRed_Strategy_Action_2015(player, 0, "move", 1, AiWise(), 4, 2, x+1, y+1)
		AiRed_Strategy_Action_2015(player, 19, "move", 1, AiWise(), x+4, y+1)
		AiRed_Strategy_Action_2015(player, 66, "move", 1, AiWise(), x+4, y+1)
		AiRed_Strategy_Action_2015(player, 67, "move area", 10, AiSoldier(), 47, 47, x+6, y+9)
		AiRed_Strategy_Action_2015(player, 68, "move area", 10, AiLonerShooter(), 47, 47, x+6, y+9)
	elseif (player == 9) then
		AiRed_Strategy_Action_2015(player, 0, "move", 1, AiWise(), x-1, y+1)
		AiRed_Strategy_Action_2015(player, 19, "move", 1, AiWise(), x-2, y+1)
		AiRed_Strategy_Action_2015(player, 66, "move", 1, AiWise(), x-2, y+1)
		AiRed_Strategy_Action_2015(player, 67, "move area", 10, AiSoldier(), 47, 47, x-6, y+9)
		AiRed_Strategy_Action_2015(player, 68, "move area", 10, AiLonerShooter(), 47, 47, x-6, y+9)
	elseif (player == 10) then
		AiRed_Strategy_Action_2015(player, 0, "move", 1, AiWise(), 4, 93, x+1, y+1)
	elseif (player == 11) then
		AiRed_Strategy_Action_2015(player, 0, "move", 1, AiWise(), 91, 93, x+1, y+1)
	end
	if ((player == 8) or (player == 9)) then
		AiRed_Strategy_Action_2015(player, 24, "move", 1, AiShooter(), x, y+26, x, y+1)
		AiRed_Strategy_Action_2015(player, 29, "move", 1, AiShooter(), x+1, y+26, x+1, y)
		AiRed_Strategy_Action_2015(player, 31, "move", 1, AiShooter(), x+2, y+26, x+2, y)
		AiRed_Strategy_Action_2015(player, 36, "move", 1, AiShooter(), x-1, y+26, x+1, y+2)
		AiRed_Strategy_Action_2015(player, 38, "move", 1, AiShooter(), x-2, y+26, x, y+2)
		AiRed_Strategy_Action_2015(player, 41, "move", 1, AiShooter(), x-3, y+26, x+2, y+2)
		AiRed_Strategy_Action_2015(player, 48, "move", 1, AiEliteShooter(), x-1, y+25, x+1, y+2)
		AiRed_Strategy_Action_2015(player, 49, "move", 1, AiEliteShooter(), x-2, y+25, x, y+2)
		AiRed_Strategy_Action_2015(player, 50, "move", 1, AiEliteShooter(), x-3, y+25, x+2, y+2)
		AiRed_Strategy_Action_2015(player, 60, "move", 1, AiWise(), x, y+11)
		AiRed_Strategy_Action_2015(player, 62, "summon", 5, AiLonerShooter(), x, y+10)
		AiRed_Strategy_Action_2015(player, 63, "summon", 5, AiSoldier(), x, y+10)
		AiRed_Strategy_Action_2015(player, 65, "summon", 5, AiSoldier(), x, y+10)
		AiRed_Strategy_Action_2015(player, 71, "attack area", 10, AiSoldier(), 15, 87, 47, 47)
		AiRed_Strategy_Action_2015(player, 72, "attack area", 5, AiLonerShooter(), 16, 86, 47, 47)
		AiRed_Strategy_Action_2015(player, 73, "attack area", 10, AiSoldier(), 80, 84, 16, 86)
		AiRed_Strategy_Action_2015(player, 74, "attack area", 5, AiLonerShooter(), 80, 84, 16, 86)
	elseif ((player == 10) or (player == 11)) then
	
	end
	AiRed_Strategy_Action_2015(player, 1, "summon", 1, AiCatapult(), x+1, y+1)
	AiRed_Strategy_Action_2015(player, 2, "summon", 1, AiShooter(), x+1, y+2)
	AiRed_Strategy_Action_2015(player, 3, "attack", 1, AiShooter(), x+1, y+3, x+1, y+2)
	AiRed_Strategy_Action_2015(player, 4, "summon", 1, AiShooter(), x, y+2)
	AiRed_Strategy_Action_2015(player, 5, "attack", 1, AiShooter(), x, y+3, x, y+2)
	AiRed_Strategy_Action_2015(player, 6, "summon", 1, AiShooter(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 7, "attack", 1, AiShooter(), x+2, y+3, x+2, y+2)
	AiRed_Strategy_Action_2015(player, 8, "skip", 1)
	AiRed_Strategy_Action_2015(player, 9, "summon", 1, AiEliteShooter(), x, y)
	AiRed_Strategy_Action_2015(player, 10, "attack", 1, AiEliteShooter(), x-1, y-1, x, y)
	AiRed_Strategy_Action_2015(player, 11, "skip", 1)
	AiRed_Strategy_Action_2015(player, 12, "summon", 1, AiShooter(), x, y+1)
	AiRed_Strategy_Action_2015(player, 13, "attack", 1, AiShooter(), x-1, y, x, y+1)
	AiRed_Strategy_Action_2015(player, 14, "skip", 1)
	AiRed_Strategy_Action_2015(player, 15, "summon", 1, AiShooter(), x+1, y)
	AiRed_Strategy_Action_2015(player, 16, "attack", 1, AiShooter(), x+1, y-1, x+1, y)
	AiRed_Strategy_Action_2015(player, 17, "summon", 1, AiShooter(), x+2, y)
	AiRed_Strategy_Action_2015(player, 18, "attack", 1, AiShooter(), x+2, y-1, x+2, y)
	-- 19
	AiRed_Strategy_Action_2015(player, 20, "attack", 1, AiEliteShooter(), x, y-1, x, y)
	AiRed_Strategy_Action_2015(player, 21, "summon", 1, AiHeroRider(), x+2, y+1)
	AiRed_Strategy_Action_2015(player, 22, "attack", 1, AiHeroRider(), x+3, y, x+2, y+1)
	AiRed_Strategy_Action_2015(player, 23, "summon", 1, AiFlyer(), x-1, y-1)
	-- 24
	AiRed_Strategy_Action_2015(player, 25, "summon", 1, AiHeroShooter(), x, y+1)
	AiRed_Strategy_Action_2015(player, 26, "oil", 12000)
	AiRed_Strategy_Action_2015(player, 27, "gold", 4000)
	AiRed_Strategy_Action_2015(player, 28, "wood", 6000)
	-- 29
	AiRed_Strategy_Action_2015(player, 30, "summon", 1, AiFlyer(), x+1, y+1)
	-- 31
	AiRed_Strategy_Action_2015(player, 32, "skip", 5)
	AiRed_Strategy_Action_2015(player, 33, "summon", 1, AiEliteShooter(), x+1, y)
	AiRed_Strategy_Action_2015(player, 34, "summon", 1, AiEliteShooter(), x+2, y)
	AiRed_Strategy_Action_2015(player, 35, "move", 1, AiHeroRider(), x+2, y+1)
	-- 36
	AiRed_Strategy_Action_2015(player, 37, "skip", 5)
	-- 38
	AiRed_Strategy_Action_2015(player, 39, "skip", 5)
	AiRed_Strategy_Action_2015(player, 40, "summon", 1, AiEliteShooter(), x, y+2)
	-- 41
	AiRed_Strategy_Action_2015(player, 42, "summon", 1, AiEliteShooter(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 43, "summon", 1, AiEliteShooter(), x+1, y+2)
	AiRed_Strategy_Action_2015(player, 44, "summon", 1, AiFlyer(), x+1, y-1)
	AiRed_Strategy_Action_2015(player, 45, "summon", 1, AiFlyer(), x, y+1)
	AiRed_Strategy_Action_2015(player, 46, "skip", 10)
	AiRed_Strategy_Action_2015(player, 47, "oil", 25000)
	-- 48
	-- 49
	-- 50
	AiRed_Strategy_Action_2015(player, 51, "skip", 1)
	AiRed_Strategy_Action_2015(player, 52, "summon", 1, AiHeroShooter(), x+1, y+2)
	AiRed_Strategy_Action_2015(player, 53, "skip", 1)
	AiRed_Strategy_Action_2015(player, 54, "summon", 1, AiHeroShooter(), x, y+2)
	AiRed_Strategy_Action_2015(player, 55, "skip", 1)
	AiRed_Strategy_Action_2015(player, 56, "summon", 1, AiHeroShooter(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 57, "skip", 10)
	AiRed_Strategy_Action_2015(player, 58, "summon", 1, "hero", x+1, y+1)
	AiRed_Strategy_Action_2015(player, 59, "summon", 5, AiLonerShooter(), x+1, y+1)
	-- 60
	AiRed_Strategy_Action_2015(player, 61, "skip", 20)
	-- 62
	-- 63
	AiRed_Strategy_Action_2015(player, 64, "skip", 10)
	-- 65
	-- 66
	-- 67
	-- 68
	AiRed_Strategy_Action_2015(player, 69, "skip", 20)
	AiRed_Strategy_Action_2015(player, 70, "summon", 1, "hero", x+1, y+1)
	-- 71
	-- 72
	-- 73
	-- 74
	AiRed_Strategy_Action_2015(player, 75, "loop", 58)
end

function AiShane_FtM_Rockfort_Arena_2015(player)
	ftm_team_orderx[player] = "Left"
	ftm_team_ordery[player] = "Down"
	aiftm_terminate[player] = 1000
	if ((player == 10) or (player == 11)) then
		y = 91
		y2 = 91
	else
		y = 0
		y2 = -45
	end
	if ((player == 9) or (player == 11)) then
		AiRed_Strategy_Action_2015(player, 0, "move", 1, AiWise(), 91, 2+y, 93, 2+y)
		AiRed_Strategy_Action_2015(player, 1, "summon", 1, AiEliteShooter(), 92, 2+y)
		AiRed_Strategy_Action_2015(player, 2, "summon", 1, AiShooter(), 92, 3+y)
		AiRed_Strategy_Action_2015(player, 3, "summon", 1, AiCavalryMage(), 92, 1+y)
		AiRed_Strategy_Insert_2015(player, 4, 1, AiCatapult())
		AiRed_Strategy_Action_2015(player, 5, "summon", 1, AiFlyer(), 94, 0+y)
		AiRed_Strategy_Action_2015(player, 6, "oil", 7000)
		AiRed_Strategy_Insert_2015(player, 7, 1, AiMage())
		AiRed_Strategy_Action_2015(player, 8, "oil", 7000)
		AiRed_Strategy_Insert_2015(player, 9, 1, AiMage())
		AiRed_Strategy_Insert_2015(player, 10, 1, AiHeroRider())
		AiRed_Strategy_Insert_2015(player, 11, 1, AiCatapult())
		AiRed_Strategy_Action_2015(player, 12, "summon", 1, AiHeroSoldier(), 94, 2+y)
		AiRed_Strategy_Action_2015(player, 13, "move", 1, AiWise(), 90, 2+y, 91, 2+y)
		AiRed_Strategy_Action_2015(player, 14, "summon", 1, AiFlyer(), 94, 2+y)
		AiRed_Strategy_Action_2015(player, 15, "move", 1, AiEliteShooter(), 52, 26+y, 92, 2+y)
		AiRed_Strategy_Action_2015(player, 16, "summon", 1, AiHeroSoldier(), 92, 2+y)
		AiRed_Strategy_Action_2015(player, 17, "move", 1, AiShooter(), 51, 26+y, 92, 3+y)
		AiRed_Strategy_Action_2015(player, 18, "summon", 1, AiHeroShooter(), 92, 3+y)
		AiRed_Strategy_Action_2015(player, 19, "move", 1, AiCavalryMage(), 52, 27+y, 92, 1+y)
		AiRed_Strategy_Action_2015(player, 20, "summon", 1, AiHeroShooter(), 92, 1+y)
		AiRed_Strategy_Action_2015(player, 21, "summon", 1, AiFlyer(), 92, 0+y)
		AiRed_Strategy_Action_2015(player, 22, "summon", 1, AiFlyer(), 92, 2+y)
		if (player == 9) then
			AiRed_Strategy_Action_2015(player, 23, "move", 1, AiWise(), 79, 9+y)
			AiRed_Strategy_Action_2015(player, 24, "skip")
			AiRed_Strategy_Action_2015(player, 25, "skip")
			AiRed_Strategy_Action_2015(player, 26, "skip")
			AiRed_Strategy_Action_2015(player, 27, "skip")
			AiRed_Strategy_Action_2015(player, 28, "skip")
			AiRed_Strategy_Action_2015(player, 29, "summon", 1, AiSoldier(), 78, 10+y)
			AiRed_Strategy_Action_2015(player, 30, "summon", 1, AiSoldier(), 79, 10+y)
			AiRed_Strategy_Action_2015(player, 31, "summon", 1, AiSoldier(), 80, 10+y)
			AiRed_Strategy_Action_2015(player, 32, "summon", 1, AiSoldier(), 81, 10+y)
			AiRed_Strategy_Action_2015(player, 33, "summon", 1, AiSoldier(), 82, 10+y)
			AiRed_Strategy_Action_2015(player, 34, "summon", 1, AiSoldier(), 76, 10+y)
			AiRed_Strategy_Action_2015(player, 35, "summon", 1, AiSoldier(), 77, 10+y)
			AiRed_Strategy_Action_2015(player, 36, "skip")
			for xy=0,6 do
				AiRed_Strategy_Action_2015(player, 37+xy, "summon", 1, AiShooter(), 76+xy, 11+y)
			end
			AiRed_Strategy_Action_2015(player, 44, "skip")
			AiRed_Strategy_Action_2015(player, 45, "skip")
			AiRed_Strategy_Action_2015(player, 46, "skip")
			AiRed_Strategy_Action_2015(player, 47, "move", 1, AiSoldier(), 51, 27+y, 76, 10+y)
			AiRed_Strategy_Action_2015(player, 48, "move", 1, AiSoldier(), 50, 27+y, 77, 10+y)
			AiRed_Strategy_Action_2015(player, 49, "move", 1, AiSoldier(), 49, 27+y, 78, 10+y)
			AiRed_Strategy_Action_2015(player, 50, "move", 1, AiSoldier(), 48, 27+y, 79, 10+y)
			AiRed_Strategy_Action_2015(player, 51, "move", 1, AiSoldier(), 47, 27+y, 80, 10+y)
			AiRed_Strategy_Action_2015(player, 52, "move", 1, AiSoldier(), 46, 27+y, 81, 10+y)
			AiRed_Strategy_Action_2015(player, 53, "move", 1, AiSoldier(), 45, 27+y, 82, 10+y)
			AiRed_Strategy_Action_2015(player, 54, "skip", 10)
			AiRed_Strategy_Action_2015(player, 55, "move", 1, AiShooter(), 80, 26+y, 76, 11+y)
			AiRed_Strategy_Action_2015(player, 56, "move", 1, AiShooter(), 50, 26+y, 77, 11+y)
			AiRed_Strategy_Action_2015(player, 57, "move", 1, AiShooter(), 49, 26+y, 78, 11+y)
			AiRed_Strategy_Action_2015(player, 58, "move", 1, AiShooter(), 48, 26+y, 79, 11+y)
			AiRed_Strategy_Action_2015(player, 59, "move", 1, AiShooter(), 47, 26+y, 80, 11+y)
			AiRed_Strategy_Action_2015(player, 60, "move", 1, AiShooter(), 46, 26+y, 81, 11+y)
			AiRed_Strategy_Action_2015(player, 61, "move", 1, AiShooter(), 45, 26+y, 82, 11+y)
			AiRed_Strategy_Action_2015(player, 62, "skip", 5)
			AiRed_Strategy_Action_2015(player, 63, "summon", 3, "hero", 78, 5+y)
			AiRed_Strategy_Action_2015(player, 64, "attack", 1, AiShooter(), 6, 87)
			AiRed_Strategy_Action_2015(player, 65, "attack", 1, AiSoldier(), 6, 88)
			AiRed_Strategy_Action_2015(player, 66, "loop", 23)
		else
			AiRed_Strategy_Action_2015(player, 23, "move", 1, AiWise(), 79, 90, 90, 93)
			AiRed_Strategy_Action_2015(player, 24, "skip", 5)
			for xy=1,10 do
				AiRed_Strategy_Action_2015(player, 24+xy, "summon", 1, AiShooter(), 78, 85+xy)
				AiRed_Strategy_Action_2015(player, 34+xy, "move", 1, AiShooter(), 64, 67+xy, 78, 85+xy)
				AiRed_Strategy_Action_2015(player, 45+xy, "patrol", 1, AiShooter(), 78, 67+xy, 64, 67+xy)
			end
			AiRed_Strategy_Action_2015(player, 45, "skip", 10)
			-- Moving something which isn't there crashes the game.
			AiRed_Strategy_Action_2015(player, 56, "move", 1, AiWise(), 89, 78, 79, 90)
			AiRed_Strategy_Action_2015(player, 57, "attack", 1, AiShooter(), 91, 26, 53, 90)
			AiRed_Strategy_Action_2015(player, 58, "attack", 1, AiCavalryMage(), 91, 26)
			AiRed_Strategy_Action_2015(player, 59, "attack", 1, AiEliteShooter(), 91, 26)
			AiRed_Strategy_Action_2015(player, 60, "skip", 2)
			AiRed_Strategy_Action_2015(player, 61, "summon", 1, AiFodder(), 85, 78)
			AiRed_Strategy_Action_2015(player, 62, "summon", 1, AiFodder(), 85, 79)
			for xy=0,6 do
				AiRed_Strategy_Action_2015(player, 63+xy, "summon", 1, AiFodder(), 91-xy, 77)
				AiRed_Strategy_Action_2015(player, 72+xy, "summon", 1, AiFodder(), 84-xy, 80)
				AiRed_Strategy_Action_2015(player, 79+xy, "summon", 1, AiFodder(), 84-xy, 79)
			end
			AiRed_Strategy_Action_2015(player, 70, "move", 1, AiWise(), 81, 82, 89, 78)
			AiRed_Strategy_Action_2015(player, 71, "skip", 5)
			AiRed_Strategy_Action_2015(player, 86, "move", 1, AiWise(), 91, 93)
			AiRed_Strategy_Action_2015(player, 87, "skip", 10)
			-- Begin loop.
			for xy=0,4 do
				AiRed_Strategy_Action_2015(player, 88+xy, "summon", 1, AiSoldier(), 90, 91+xy)
				AiRed_Strategy_Action_2015(player, 93+xy, "summon", 1, AiSoldier(), 89, 91+xy)
				AiRed_Strategy_Action_2015(player, 98+xy, "summon", 1, AiSoldier(), 88, 91+xy)
				AiRed_Strategy_Action_2015(player, 103+xy, "summon", 1, AiSoldier(), 87, 91+xy)
				AiRed_Strategy_Action_2015(player, 108+xy, "summon", 1, AiFodder(), 86, 91+xy)
			end
			AiRed_Strategy_Action_2015(player, 113, "summon", 1, AiLonerShooter(), 85, 95)
			AiRed_Strategy_Action_2015(player, 114, "summon", 1, AiLonerShooter(), 85, 94)
			AiRed_Strategy_Action_2015(player, 115, "attack", 1, AiSoldier(), 93, 26)
			AiRed_Strategy_Action_2015(player, 116, "attack", 1, AiLonerShooter(), 93, 26)
			AiRed_Strategy_Action_2015(player, 117, "attack", 1, AiFodder(), 93, 26)
			AiRed_Strategy_Action_2015(player, 118, "move", 1, AiWise(), 89, 78)
			AiRed_Strategy_Action_2015(player, 119, "skip", 10)
			AiRed_Strategy_Action_2015(player, 120, "loop", 60)
		end
	end
end


DefineAi("ai_red_2015", "*", "ai_red_2015", AiRed_2015)
DefineAi("ai_frontlines_2015", "*", "ai_frontlines_2015", AiFrontlines_2015)
DefineAi("Shane Wolfe", "*", "ai_red_2015", AiShane_2015)
DefineAi("Aya Kalang", "*", "ai_red_2015", AiAya_2015)