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
				for i=1,15 do
					if ((aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] == 0) or (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] == "summon") or (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] == "spawn")) then
						if (AiRed_Check_Unit_2014(AiPlayer(), i) == true) then
							if (AiRed_Check_Building_2014(ftm_team[AiPlayer()], i) == true) then
								if ((aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= "summon") and (aiftm_action[AiPlayer()][aiftm_index[AiPlayer()]] ~= "spawn")) then
									AiRed_Spawn_2014(AiPlayer(), i)
									AiRed_GridChange_2014(AiPlayer())
								else
									AiRed_Spawn_2014(AiPlayer(), i, nil, aiftm_x_to[AiPlayer()][aiftm_index[AiPlayer()]], aiftm_y_to[AiPlayer()][aiftm_index[AiPlayer()]])
								end
								AiRed_Resources_Remove_2014(AiPlayer(), (UnitDatabase[ftm_team[AiPlayer()]][i]["CastGold"]), (UnitDatabase[ftm_team[AiPlayer()]][i]["CastWood"]), (UnitDatabase[ftm_team[AiPlayer()]][i]["CastOil"]))
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
	elseif ((aiftm_action[player][aiftm_index[player]] == "ai_red_2014") or (aiftm_action[player][0] == "ai_red_2014") or ((aiftm_action[player][10] == "ai_red_2014") and( aiftm_index[player] > 9))) then
		AiRed_2014()
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

function AiCharacter_Set_Name_2015(name)
	if (name == nil) then
		if (GameDefinition["Player"][GameDefinition["Map"][AiPlayer()]["Team"]][GameDefinition["Map"][AiPlayer()]["Player"]]["Name"] ~= nil) then
			AiJadeite_Set_Name_2010(GameDefinition["Player"][GameDefinition["Map"][AiPlayer()]["Team"]][GameDefinition["Map"][AiPlayer()]["Player"]]["Name"])
		end
	else
		AiJadeite_Set_Name_2010(name)
	end
end

function AiLucas_2015()
	AiCharacter_Set_Name_2015("Lucas Kage")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiShane_FtM_2015(AiPlayer())
	elseif (GameDefinition["Name"] == "Skirmish") then
		AiLucas_Skirmish_2015()
	end
end

function AiShane_2015()
	AiCharacter_Set_Name_2015("Shane Wolfe")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiShane_FtM_2015(AiPlayer())
	end
end

function AiAya_2015()
	AiCharacter_Set_Name_2015("Aya Kalang")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiAya_FtM_2015(AiPlayer())
	end
end

function AiNathan_2015()
	AiCharacter_Set_Name_2015("Nathan Withers")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiAya_FtM_2015(AiPlayer())
	elseif (GameDefinition["Name"] == "Skirmish") then
		AiNathan_Skirmish_2015()
	end
end

function AiKiah_2015()
	AiCharacter_Set_Name_2015("Kiah Stone")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiAya_FtM_2015(AiPlayer())
	elseif (GameDefinition["Name"] == "Skirmish") then
		AiLucas_Skirmish_2015()
	end
end

function AiSandria_2015()
	AiCharacter_Set_Name_2015("Sandria Fields")
	-- Sandria will be an easy, archer player.
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiAya_FtM_2015(AiPlayer())
	else -- if skirmish
		if (GameCycle > 100) then
			AiJadeite_Shooter_2010()
		end
	end
end

function AiLucas_Skirmish_2015()
	if ((GameDefinition["Map"]["Name"] == "Northern Swamp") or (GameDefinition["Map"]["Name"] == "Southern Swamp")) then
		AiLucas_Skirmish_Northern_Swamp_2015()
	else
		AiLucas_Skirmish_Standard_2015()
	end
end

function AiNathan_Skirmish_2015()
	if ((GameDefinition["Map"]["Name"] == "Northern Swamp") or (GameDefinition["Map"]["Name"] == "Southern Swamp")) then
		AiNathan_Skirmish_Northern_Swamp_2015()
	else
		AiLucas_Skirmish_Standard_2015()
	end
end

function AiSandria_Skirmish_2015()

end

function UnitNear(player, unit, x, y, area)
	if (area == nil) then area = 3 end
	if (GetNumUnitsAt(player, unit, {x-area, y-area}, {x+area, y+area}) > 0) then 
		return true
	else
		return false
	end
end

function MoveUnitQuick(player, unit, tox, toy, fromx, fromy, area)
	if (UnitNear(player, unit, fromx, fromy, area) == true) then 
		if (area == nil) then area = SyncRand(3) end
		OrderUnit(player, unit, {fromx-area,fromy-area,fromx+area,fromy+area}, {tox-area,toy-area,tox+area,toy+area}, "move")
		return true
	else
		return false
	end
end

function AiNathan_Skirmish_Northern_Swamp_2015()
	if (GameDefinition["Map"]["Name"] == "Northern Swamp") then
		if (GameCycle < 2500) then
			if (GameCycle < 200) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 11, 68, 1, 3, 96, 45, "attack")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 18, 72, 3, 1, 97, 46, "attack")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 24, 74, 3, 1, 102, 46, "attack")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 29, 74, 3, 1, 107, 46, "attack")
				OrderUnitSquare(AiPlayer(), AiShooter(), 10, 68, 1, 3, 95, 45, "move")
				OrderUnitSquare(AiPlayer(), AiShooter(), 18, 73, 3, 1, 98, 46, "move")
				OrderUnitSquare(AiPlayer(), AiShooter(), 24, 75, 3, 1, 103, 46, "move")
				OrderUnitSquare(AiPlayer(), AiShooter(), 29, 75, 3, 1, 108, 46, "move")
			elseif ((GameCycle > 1100) and (GameCycle < 1800)) then
				MoveUnitQuick(AiPlayer(), AiCavalry(), 108, 28, 3, 92, 3)
				MoveUnitQuick(AiPlayer(), AiCavalry(), 104, 28, 15, 100, 3)
			elseif ((GameCycle > 1800) and (GameCycle < 2500)) then
				MoveUnitQuick(AiPlayer(), AiSoldier(), 108, 27, 96, 45, 3)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 104, 27, 97, 46, 3)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 101, 27, 102, 46, 3)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 98, 27, 107, 46, 3)
				if (GameCycle > 1900) then
					MoveUnitQuick(AiPlayer(), AiShooter(), 108, 28, 96, 46, 3)
					MoveUnitQuick(AiPlayer(), AiShooter(), 104, 28, 97, 47, 3)
					MoveUnitQuick(AiPlayer(), AiShooter(), 101, 28, 102, 47, 3)
					MoveUnitQuick(AiPlayer(), AiShooter(), 98, 28, 107, 47, 3)
				end
			end
		end
	elseif (GameDefinition["Map"]["Name"] == "Southern Swamp") then
		if (GameCycle < 2500) then
			if (GameCycle < 100) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 44, 95, 1, 3, 26, 62, "move")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 53, 95, 1, 3, 49, 74, "move")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 48, 97, 2, 1, 34, 62, "move")
			elseif ((GameCycle > 400) and (GameCycle < 500)) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 48, 96, 2, 1, 61, 62, "move")
			elseif ((GameCycle > 600) and (GameCycle < 700)) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 48, 95, 2, 1, 65, 88, "move")
			elseif ((GameCycle > 700) and (GameCycle < 2400)) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiScout()) > 0) then
					if (MoveUnitQuick(AiPlayer(), AiScout(), 30, 59, 48, 90) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 24, 46, 30, 59) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 21, 72, 24, 46) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 35, 43, 21, 72) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 41, 69, 35, 43) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 66, 8, 41, 69) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 66, 8, 18, 72, 3) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 39, 55, 18, 53, 3) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiScout(), 41, 69, 39, 55) == true) then 
					end
				elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiScientific()) > 0) then
					CreateUnit(AiScout(), AiPlayer(), {48, 90})
					SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 500)
					SetPlayerData(AiPlayer(), "Resources", "wood", GetPlayerData(AiPlayer(), "Resources", "wood") - 100)
				end
			elseif ((GameCycle > 2400) and (GameCycle < 2500)) then
				MoveUnitQuick(AiPlayer(), AiCavalry(), 26, 64, 48, 96, 5)
			end
		elseif ((UnitNear(4, AiFlyer(4), 10, 117, 10) == true) and (UnitNear(4, AiCavalry(4), 10, 117, 10) == false) and (UnitNear(4, AiShooter(4), 10, 117, 10) == false) and (UnitNear(4, AiSoldier(4), 10, 117, 10) == false)) then
			MoveUnitQuick(AiPlayer(), AiCavalry(), 43, 103, 10, 117, 10)
		elseif ((GetPlayerData(4, "UnitTypesCount", AiBetterCityCenter(4)) == 0) and (GetPlayerData(0, "UnitTypesCount", AiBetterCityCenter(0)) == 0)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) ~= 0) then
				if (GetPlayerData(AiPlayer(), "Resources", "gold") > 2499) then
					CreateUnit(AiFlyer(), AiPlayer(), {39, 120})
					SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 2500)
					if (GetPlayerData(AiPlayer(), "Resources", "gold") < 5000) then
						AiNephrite_Attack_2013("force")
					end
				end
			end
		elseif (((UnitNear(4, AiCavalry(4), 35, 115, 25) == true) or (UnitNear(4, AiSoldier(4), 41, 101, 15) == true) or (UnitNear(4, AiShooter(4), 41, 101, 15) == true) or (UnitNear(4, AiEliteShooter(4), 41, 101, 15) == true)) or ((UnitNear(0, AiCavalry(0), 41, 101, 15) == true) or (UnitNear(0, AiSoldier(0), 41, 101, 15) == true) or (UnitNear(0, AiShooter(0), 41, 101, 15) == true) or (UnitNear(0, AiEliteShooter(0), 41, 101, 15) == true))) then 
			-- Enemy is going for my base!
			if (UnitNear(4, AiCavalry(4), 41, 101, 15) == true) then
				MoveUnitQuick(AiPlayer(), AiCavalry(), 42, 103, 24, 63, 8)
				MoveUnitQuick(AiPlayer(), AiCavalry(), 42, 103, 51, 76, 8)
			else
				MoveUnitQuick(AiPlayer(), AiCavalry(), 19, 30, 24, 63, 8)
				MoveUnitQuick(AiPlayer(), AiCavalry(), 19, 30, 51, 76, 8)
			end
			MoveUnitQuick(AiPlayer(), AiCavalry(), 42, 103, 100, 58, 20)
			MoveUnitQuick(AiPlayer(), AiCavalry(), 42, 103, 102, 26, 15)
		elseif (UnitNear(AiPlayer(), AiGuardTower(), 30, 62, 2) == true) then 
			-- First line of defence.
			if ((UnitNear(0, AiWorker(0), 70, 88, 10) == true) or (UnitNear(4, AiWorker(4), 70, 88, 10) == true)) then 
				-- Enemy forces are using middle gold mine.
				MoveUnitQuick(AiPlayer(), AiSoldier(), 74, 86, 49, 71, 8)
			elseif (UnitNear(AiPlayer(), AiCavalry(), 48, 96, 5)) then
				MoveUnitQuick(AiPlayer(), AiCavalry(), 26, 64, 48, 96, 5)
			end
		elseif (UnitNear(AiPlayer(), AiGuardTower(), 46, 70, 2) == true) then 
			-- Second line of defence.
			if ((UnitNear(0, AiWorker(0), 70, 88, 10) == true) or (UnitNear(4, AiWorker(4), 70, 88, 10) == true)) then 
				-- Enemy forces are using middle gold mine.
				MoveUnitQuick(AiPlayer(), AiCavalry(), 72, 87, 51, 68, 2)
			elseif (UnitNear(AiPlayer(), AiCavalry(), 44, 96, 2)) then
				MoveUnitQuick(AiPlayer(), AiCavalry(), 51, 68, 44, 96, 2)
			elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) > 0) then
				if (MoveUnitQuick(AiPlayer(), AiFlyer(), 65, 80, 39, 120) == true) then 
				elseif (MoveUnitQuick(AiPlayer(), AiFlyer(), 69, 32, 65, 80) == true) then 
				elseif (MoveUnitQuick(AiPlayer(), AiFlyer(), 53, 18, 69, 32) == true) then 
				elseif (MoveUnitQuick(AiPlayer(), AiFlyer(), 57, 0, 53, 18) == true) then 
				end
			elseif ((GetPlayerData(AiPlayer(), "Resources", "gold") > 2500) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) > 0)) then
				CreateUnit(AiFlyer(), AiPlayer(), {39, 120})
				SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 2500)
			end
		else
		
		end
	end
	if (GetPlayerData(4, "UnitTypesCount", AiFlyer(4)) > 0) then
		if ((((GetPlayerData(AiPlayer(), "Resources", "gold") > 2500) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) == 0)) or ((GetPlayerData(AiPlayer(), "Resources", "gold") > 7500) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) < (GetPlayerData(4, "UnitTypesCount", AiFlyer(4)))))) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) > 0)) then
			CreateUnit(AiFlyer(), AiPlayer(), {39, 120})
			SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 2500)
		end
		AiJadeite_Force_2010(0, AiShooter(), 6, AiFlyer(), GetPlayerData(4, "UnitTypesCount", AiFlyer(4)))
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiScout()) > 0) then
			if (MoveUnitQuick(AiPlayer(), AiScout(), 2, 67, 46, 89) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 4, 11, 2, 67) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 15, 1, 4, 11) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 53, 7, 15, 1) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 74, 45, 53, 7) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 99, 69, 74, 45) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 27, 93, 99, 69) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiScout(), 46, 89, 68, 6, 5) == true) then 
			end
		elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiScientific()) > 0) and (GetPlayerData(4, "UnitTypesCount", AiFlyer(4)) == 3)) then
			CreateUnit(AiScout(), AiPlayer(), {46, 89})
			SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 500)
			SetPlayerData(AiPlayer(), "Resources", "wood", GetPlayerData(AiPlayer(), "Resources", "wood") - 100)
		end
	elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) > 2) then
		if (MoveUnitQuick(AiPlayer(), AiFlyer(), 2, 125, 35, 117, 20) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiFlyer(), 0, 0, 5, 30, 5) == true) then 
		else
			MoveUnitQuick(AiPlayer(), AiFlyer(), 0, 0, 5, 122, 5)
		end
	elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
		AiJadeite_Cavalry_2010()
	else
		AiJadeite_Flyer_2010()
	end
end

function AiLucas_Skirmish_Northern_Swamp_2015()
	-- We should make it that if Sandria has Lucas playing, the Wilds attack Sandria instead.
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiScout()) > 0) then
		if (MoveUnitQuick(AiPlayer(), AiScout(), 121, 32, 105, 8) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 19, 43, 121, 32) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 16, 58, 19, 43) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 57, 62, 16, 58) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 64, 112, 57, 62) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 8, 116, 64, 112) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 22, 102, 8, 116) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 121, 123, 22, 102) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 118, 7, 121, 123) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 6, 47, 118, 7) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 39, 8, 6, 47) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 39, 3, 39, 8) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 44, 3, 39, 3) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 67, 99, 44, 3) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 105, 8, 67, 99) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 67, 8, 105, 8) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 115, 80, 67, 8) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 13, 77, 115, 80) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 91, 50, 13, 77) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 113, 6, 91, 50) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 105, 8, 113, 6) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 19, 43, 122, 114) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 105, 8, 103, 19) == true) then 
		elseif (MoveUnitQuick(AiPlayer(), AiScout(), 115, 80, 91, 96) == true) then 
		end
	elseif ((GetPlayerData(AiPlayer(), "Resources", "gold") > 2000) and (GameCycle > 2250) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiScientific()) > 0)) then
		if (AiPlayer() == 0) then
			if (GameDefinition["Map"]["Name"] == "Northern Swamp") then
				CreateUnit(AiScout(), AiPlayer(), {105, 8})
			else
				CreateUnit(AiScout(), AiPlayer(), {103, 19})
			end
			SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 500)
			SetPlayerData(AiPlayer(), "Resources", "wood", GetPlayerData(AiPlayer(), "Resources", "wood") - 100)
		elseif (AiPlayer() == 2) then
			if (GameDefinition["Map"]["Name"] == "Northern Swamp") then
				CreateUnit(AiScout(), AiPlayer(), {122, 114})
			else
				CreateUnit(AiScout(), AiPlayer(), {91, 96})
			end
			SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 500)
			SetPlayerData(AiPlayer(), "Resources", "wood", GetPlayerData(AiPlayer(), "Resources", "wood") - 100)
		end
	end
	if (GetPlayerData(AiPlayer(), "Name") == "Kiah Stone") then
		if ((GameCycle < 2500) and (GameDefinition["Map"]["Name"] == "Northern Swamp")) then
			if (GameCycle < 200) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 112, 70, 3, 1, 108, 47, "attack")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 98, 75, 3, 1, 104, 47, "attack")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 94, 75, 3, 1, 101, 47, "attack")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 82, 73, 3, 1, 98, 47, "attack")
				OrderUnitSquare(AiPlayer(), AiShooter(), 112, 71, 3, 1, 108, 48, "move")
				OrderUnitSquare(AiPlayer(), AiShooter(), 98, 76, 3, 1, 104, 48, "move")
				OrderUnitSquare(AiPlayer(), AiShooter(), 94, 76, 3, 1, 101, 48, "move")
				OrderUnitSquare(AiPlayer(), AiShooter(), 82, 74, 3, 1, 98, 48, "move")
			elseif ((GameCycle > 1300) and (GameCycle < 1800)) then
				MoveUnitQuick(AiPlayer(), AiCavalry(), 108, 26, 112, 95, 5)
				MoveUnitQuick(AiPlayer(), AiCavalry(), 104, 26, 106, 87, 5)
			elseif ((GameCycle > 1800) and (GameCycle < 2500)) then
				MoveUnitQuick(AiPlayer(), AiSoldier(), 108, 27, 108, 47, 5)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 104, 27, 104, 47, 5)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 101, 27, 101, 47, 5)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 98, 27, 98, 47, 5)
				if (GameCycle > 1900) then
					MoveUnitQuick(AiPlayer(), AiShooter(), 108, 28, 108, 48, 5)
					MoveUnitQuick(AiPlayer(), AiShooter(), 104, 28, 104, 48, 5)
					MoveUnitQuick(AiPlayer(), AiShooter(), 101, 28, 101, 48, 5)
					MoveUnitQuick(AiPlayer(), AiShooter(), 98, 28, 98, 48, 5)
				end
			end
		elseif (GameDefinition["Map"]["Name"] == "Southern Swamp") then
			if (GameCycle < 100) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 105, 86, 1, 3, 99, 65, "move")
				OrderUnitSquare(AiPlayer(), AiSoldier(), 93, 91, 1, 3, 91, 60, "move")
			elseif ((GameCycle > 400) and (GameCycle < 500)) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 89, 91, 1, 3, 79, 74, "move")
			elseif (((GameCycle > 1100) and (GameCycle < 1200)) or ((GameCycle > 4500) and (GameCycle < 4600)) or ((GameCycle > 6500) and (GameCycle < 6600)) or ((GameCycle > 9800) and (GameCycle < 9900)) or ((GameCycle > 14600) and (GameCycle < 15000))) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 101, 86, 1, 3, 67, 87, "move")
				MoveUnitQuick(AiPlayer(), AiCavalry(), 99, 68, 103, 87, 6)
				MoveUnitQuick(AiPlayer(), AiCavalry(), 96, 68, 91, 92, 6)
				if (GameCycle > 14600) then
					MoveUnitQuick(AiPlayer(), AiEliteShooter(), 99, 68, 103, 87, 5)
					MoveUnitQuick(AiPlayer(), AiEliteShooter(), 96, 68, 91, 92, 5)
				end
			elseif (GameCycle < 5000) then
				AiJadeite_Cavalry_2010()
			elseif ((GetPlayerData(4, "UnitTypesCount", AiBetterCityCenter(4)) == 0) and (GetPlayerData(0, "UnitTypesCount", AiBetterCityCenter(0)) == 0)) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) ~= 0) then
					if (GetPlayerData(AiPlayer(), "Resources", "gold") > 2499) then
						CreateUnit(AiFlyer(), AiPlayer(), {102, 90})
						SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 2500)
						if (GetPlayerData(AiPlayer(), "Resources", "gold") < 5000) then
							AiNephrite_Attack_2013("force")
						end
					end
				end
			elseif (GetPlayerData(15, "UnitTypesCount", "unit-gold-mine") < 0) then
				-- Only one mine left.
				if (GetPlayerData(0, "UnitTypesCount", AiBarracks(0)) == 0) then
					if ((GetPlayerData(4, "UnitTypesCount", AiCavalry(4)) < 4) and (GetPlayerData(4, "UnitTypesCount", AiEliteShooter(4)) < 4) and (GetPlayerData(4, "UnitTypesCount", AiSoldier(4)) < 4)) then
						-- Attack Player 4!
						if (UnitNear(AiPlayer(), AiEliteShooter(), 98, 89, 8)) then
							MoveUnitQuick(AiPlayer(), AiEliteShooter(), 20, 26, 98, 89, 8)
							MoveUnitQuick(AiPlayer(), AiCavalry(), 20, 26, 98, 89, 8)
							AiNephrite_Attack_2013("force")
						end
					end
				else
					MoveUnitQuick(AiPlayer(), AiEliteShooter(), 71, 88, 98, 89, 4)
					MoveUnitQuick(AiPlayer(), AiCavalry(), 71, 88, 98, 89, 4)
				end
			elseif (UnitNear(AiPlayer(), AiGuardTower(), 95, 62, 1) == true) then 
				-- First line of defence.
				if ((GameCycle > 16100) and (GameCycle < 16100)) then
					MoveUnitQuick(AiPlayer(), AiEliteShooter(), 99, 68, 103, 87, 6)
					MoveUnitQuick(AiPlayer(), AiEliteShooter(), 96, 68, 91, 92, 6)
				elseif (((GameCycle > 10500) and (GameCycle < 10600)) or ((GameCycle > 11000) and (GameCycle < 11100)) or ((GameCycle > 12000) and (GameCycle < 12100)) or ((GameCycle > 13000) and (GameCycle < 13100)) or ((GameCycle > 14000) and (GameCycle < 14100)) or ((GameCycle > 15000) and (GameCycle < 15100)) or ((GameCycle > 25000) and (GameCycle < 25100))) then
					AiNephrite_Attack_2013("force")
				elseif ((GameCycle > 10500) and (GameCycle < 17000)) then
					AiLucas_Skirmish_Standard_2015()
				else
					AiJadeite_Shooter_2010()
				end
			elseif (((UnitNear(0, AiCavalry(0), 100, 90, 10) == true) or (UnitNear(0, AiEliteShooter(0), 100, 90, 10) == true)) or ((UnitNear(4, AiCavalry(4), 100, 90, 10) == true) or (UnitNear(4, AiEliteShooter(4), 100, 90, 10) == true))) then 
				-- Fall back to defend the barracks.
				MoveUnitQuick(AiPlayer(), AiCavalry(), 100, 77, 79, 71, 6)
				MoveUnitQuick(AiPlayer(), AiEliteShooter(), 100, 77, 79, 71, 6)
				MoveUnitQuick(AiPlayer(), AiEliteShooter(), 100, 77, 79, 71, 6)
			elseif ((UnitNear(AiPlayer(), AiGuardTower(), 80, 70, 2) == true) and (((UnitNear(0, AiCavalry(0), 80, 70, 10) == true) or (UnitNear(0, AiEliteShooter(0), 80, 70, 10) == true)) or ((UnitNear(4, AiCavalry(4), 80, 70, 10) == true) or (UnitNear(4, AiEliteShooter(4), 80, 70, 10) == true)))) then 
				-- Second line of defence.
				MoveUnitQuick(AiPlayer(), AiCavalry(), 82, 76, 91, 92, 6)
				MoveUnitQuick(AiPlayer(), AiEliteShooter(), 82, 76, 91, 92, 6)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 82, 76, 99, 83, 2)
				MoveUnitQuick(AiPlayer(), AiEliteShooter(), 82, 76, 99, 83, 2)
				MoveUnitQuick(AiPlayer(), AiCavalry(), 82, 76, 98, 77, 3)
			end
		end
	else
		if ((GetPlayerData(2, "UnitTypesCount", AiFlyer(2)) > 0) or (GetPlayerData(3, "UnitTypesCount", AiFlyer(3)) > 0)) then 
			if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) < 6) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) < 6)) then
				AiJadeite_Force_2010(0, AiShooter(), 6, AiSoldier(), 1)
				AiJadeite_Upgrade_2010(AiShooter())
			else
				AiJadeite_Upgrade_2010(AiEliteShooter())
			end
			if ((UnitNear(3, AiFlyer(3), 59, 5, 5) == true) or (UnitNear(2, AiFlyer(2), 59, 5, 5) == true)) then 
				MoveUnitQuick(AiPlayer(), AiShooter(), 62, 7, 109, 20, 6)
				MoveUnitQuick(AiPlayer(), AiShooter(), 67, 3, 103, 40, 2)
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) == 0) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) > 0) then
						CreateUnit(AiFlyer(), AiPlayer(), {123, 19})
						SetPlayerData(AiPlayer(), "Resources", "gold", GetPlayerData(AiPlayer(), "Resources", "gold") - 2500)
					end
				else
					MoveUnitQuick(AiPlayer(), AiFlyer(), 66, 5, 123, 19, 4)
					MoveUnitQuick(AiPlayer(), AiFlyer(), 66, 5, 123, 3, 4)
				end
			end
		else
			if (GameDefinition["Map"]["Name"] == "Southern Swamp") then
				if (GameCycle < 100) then
					OrderUnitSquare(AiPlayer(), AiSoldier(), 108, 26, 2, 1, 101, 42, "move")
				elseif (GameCycle < 200) then
					OrderUnitSquare(AiPlayer(), AiSoldier(), 114, 26, 2, 1, 107, 43, "move")
				elseif (GameCycle < 300) then
					OrderUnitSquare(AiPlayer(), AiSoldier(), 108, 25, 2, 1, 94, 41, "move")
				elseif (GameCycle < 400) then
					OrderUnitSquare(AiPlayer(), AiSoldier(), 113, 25, 2, 1, 109, 43, "move")
				elseif (GameCycle < 500) then
					OrderUnitSquare(AiPlayer(), AiSoldier(), 110, 25, 1, 2, 112, 46, "move")
				elseif (GameCycle < 600) then
					OrderUnitSquare(AiPlayer(), AiSoldier(), 115, 25, 1, 2, 111, 46, "move")
				elseif (UnitNear(AiPlayer(), AiWorker(), 106, 58, 15)) then 
					-- Workers are leaving the base.
					if ((UnitNear(2, AiGuardTower(2), 95, 62, 2) == true) or (UnitNear(2, AiGuardTower(2), 80, 70, 2) == true)) then 
						-- First or second enemy line of defence is still up.
						MoveUnitQuick(AiPlayer(), AiWorker(), 101, 13, 106, 58, 15)
					elseif ((UnitNear(3, AiGuardTower(3), 30, 62, 2) == true) or (UnitNear(3, AiGuardTower(3), 46, 70, 2) == true) or (UnitNear(2, AiSoldier(2), 80, 70, 5) == true) or (UnitNear(3, AiSoldier(3), 80, 70, 5) == true) or (UnitNear(3, AiCavalry(3), 80, 70, 5) == true) or (UnitNear(2, AiCavalry(2), 80, 70, 5) == true)) then 
						-- Enemy grunts defending middle gold mine, or left side defences are still up.
						MoveUnitQuick(AiPlayer(), AiWorker(), 87, 19, 106, 68, 20)
						AiNephrite_Attack_2013("force")
					end
				elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) > 0) then
					if (MoveUnitQuick(AiPlayer(), AiFlyer(), 123, 3, 66, 5, 5) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiFlyer(), 124, 20, 123, 3, 5) == true) then 
					elseif (MoveUnitQuick(AiPlayer(), AiFlyer(), 127, 127, 124, 20, 5) == true) then 
					elseif (UnitNear(2, AiFarm(2), 122, 126, 1)) then 
					else
					end
				elseif (UnitNear(AiPlayer(), AiCatapult(), 112, 43, 8)) then 
					MoveUnitQuick(AiPlayer(), AiSoldier(), 97, 45, 110, 43, 4)
				elseif (UnitNear(AiPlayer(), AiCavalry(), 103, 55, 10)) then 
					MoveUnitQuick(AiPlayer(), AiSoldier(), 102, 57, 97, 45, 4)
				elseif (UnitNear(AiPlayer(), AiCavalry(), 112, 20, 1)) then 
					MoveUnitQuick(AiPlayer(), AiCavalry(), 108, 35, 112, 20, 5)
					MoveUnitQuick(AiPlayer(), AiCatapult(), 108, 35, 112, 20, 5)
				elseif (UnitNear(3, AiScout(3), 66, 8, 4) == true) then
					MoveUnitQuick(AiPlayer(), AiShooter(), 63, 8, 112, 42)
					MoveUnitQuick(AiPlayer(), AiEliteShooter(), 63, 8, 112, 42)
				end
			end
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 14) then
				AiLucas_Skirmish_Standard_2015(0, 0, 6, 2)
			else
				AiLucas_Skirmish_Standard_2015(1, 0, 8, 2)
			end
		end
	end
end

-- May stop the other Ais from working!
function AiLucas_Skirmish_Standard_2015(defendmelee, defendrange, attackmelee, attackrange)
	if (defendmelee == nil) then defendmelee = 2 end
	if (defendrange == nil) then defendrange = 0 end
	if (attackmelee == nil) then attackmelee = 5 end
	if (attackrange == nil) then attackrange = 1 end
	-- Defend
	if ((GameCycle > 15000) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0)) then
		AiJadeite_Force_2010(0, AiCavalry(), 2 + defendmelee, AiShooter(), 1 + defendrange)
	elseif (GameCycle > 7500) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
			AiJadeite_Force_2010(0, AiCavalry(), 2 + defendmelee, AiShooter(), 1 + defendrange, AiSoldier(), 0)
		else
			AiJadeite_Force_2010(0, AiSoldier(), 2 + defendmelee, AiShooter(), 1 + defendrange)
		end
	elseif (GameCycle > 2500) then
		AiJadeite_Build_2010(AiGuardTower())
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
			AiJadeite_Force_2010(0, AiCavalry(), 2 + defendmelee, AiShooter(), 0 + defendrange)
		else
			AiJadeite_Force_2010(0, AiSoldier(), 2 + defendmelee, AiShooter(), 0 + defendrange)
		end
	end
	-- Attack
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) or (GetPlayerData(AiPlayer(), "Resources", "gold") > 5000)) then
		if (GameCycle > 15000) then
			AiJadeite_Force_2010(3, AiCavalry(), 10, AiShooter(), 4, AiCatapult(), 1)
		elseif (GameCycle > 7500) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
				AiJadeite_Force_2010(3, AiCavalry(), 5 + attackmelee, AiShooter(), 3 + attackrange, AiCatapult(), attackrange)
			else
				if (attackrange < 2) then
					AiJadeite_Force_2010(3, AiSoldier(), 1 + attackmelee, AiShooter(), 2 + attackrange)
				else
					AiJadeite_Force_2010(3, AiSoldier(), 1 + attackmelee, AiShooter(), 1 + attackrange, AiCatapult(), attackrange)
				end
			end
		else
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
				AiJadeite_Force_2010(3, AiCavalry(), 5 + attackmelee, AiShooter(), attackrange, AiCatapult(), attackrange)
			else
				AiJadeite_Force_2010(3, AiSoldier(), 5 + attackmelee, AiShooter(), attackrange)
			end
		end
		AiJadeite_Attack_2010(3)
	end
	-- Buildings and Upgrades
	AiJadeite_Intermittent_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 2) then 
		if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 5000) or (GameCycle > 5000)) then
			AiJadeite_Upgrade_2010(AiCavalryMage())
		else
			AiJadeite_Upgrade_2010(AiSoldier())
		end
	end
	if (((GameCycle > 15000) and (GetPlayerData(AiPlayer(), "Resources", "gold") > 3000)) or (attackrange > 1)) then
		AiJadeite_Upgrade_2010(AiShooter())
		AiJadeite_Upgrade_2010(AiCatapult())
	elseif (GameCycle > 2500) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then 
			AiJadeite_Build_2010(AiBarracks(), 2)
		end
	elseif (GameCycle < 500) then
		AiJadeite_Force_2010(0, AiSoldier(), 2)
	end
end

function AiShane_FtM_2015(player)
	if ((GameCycle < 50) or (aiftm_action[player][aiftm_index[player]] == "loop")) then
		--Check map.
		if (GameDefinition["Map"]["Name"] == "Rockfort Arena") then
			AiShane_FtM_Rockfort_Arena_2015(player)
		elseif (GameDefinition["Map"]["Name"] == "One Way Through") then
			AiShane_FtM_One_Way_Through_2015(player)
		elseif (GameDefinition["Map"]["Name"] == "Nick's Duel") then
			AiShane_FtM_Nicks_Duel_2015(player)
		else
			AiRed_Strategy_Action_2015(player, 0, "ai_red_2014")
		end
	end
	AiRed_2015()
end

function AiAya_FtM_2015(player)
	-- Sandria will be a hard, archer player.
	if ((GameCycle < 50) or (aiftm_action[player][aiftm_index[player]] == "loop")) then
		--Check map.
		if (GameDefinition["Map"]["Name"] == "Rockfort Arena") then
			AiAya_FtM_Rockfort_Arena_2015(player)
		elseif (GameDefinition["Map"]["Name"] == "One Way Through") then
			AiAya_FtM_One_Way_Through_2015(player)
		elseif (GameDefinition["Map"]["Name"] == "Nick's Duel") then
			AiAya_FtM_Nicks_Duel_2015(player)
		end
	end
	AiRed_2015()
end

function AiShane_FtM_Nicks_Duel_2015(player)
	AiAya_FtM_Nicks_Duel_2015(player)
	-- TODO: This.
end

function AiAya_FtM_Nicks_Duel_2015(player)
	aiftm_terminate[player] = 1000
	x = ftm_team_x1[player]
	y = ftm_team_y1[player]
	if (player == 10) then
		AiRed_Strategy_Action_2015(player, 1, "summon", 1, AiWorker(), x+2, y+1)
		AiRed_Strategy_Action_2015(player, 2, "move", 1, AiWorker(), x+2, y+1, x+2, y+1)
		AiRed_Strategy_Action_2015(player, 12, "move", 1, AiWise(), x+3, y+1)
		AiRed_Strategy_Action_2015(player, 36, "attack", 1, AiSoldier(), 0, 0)
		AiRed_Strategy_Action_2015(player, 38, "move", 1, AiShooter(), 17, 29, x, y)
		AiRed_Strategy_Action_2015(player, 41, "move", 1, AiShooter(), 18, 28, x+2, y)
		AiRed_Strategy_Action_2015(player, 44, "move", 1, AiShooter(), 19, 27, x+2, y+2)
		AiRed_Strategy_Action_2015(player, 47, "move", 1, AiShooter(), 16, 30, x, y+2)
		AiRed_Strategy_Action_2015(player, 50, "attack", 1, AiShooter(), 0, 0)
		AiRed_Strategy_Action_2015(player, 51, "attack", 1, AiCavalryMage(), 0, 0)
	elseif (player == 11) then
		AiRed_Strategy_Action_2015(player, 1, "summon", 1, AiWorker(), x, y+1)
		AiRed_Strategy_Action_2015(player, 2, "move", 1, AiWorker(), x-1, y+1, x, y+1)
		AiRed_Strategy_Action_2015(player, 12, "move", 1, AiWise(), x-1, y+1)
		AiRed_Strategy_Action_2015(player, 36, "attack", 1, AiSoldier(), 31, 31)
		AiRed_Strategy_Action_2015(player, 38, "move", 1, AiShooter(), 13, 2, x, y)
		AiRed_Strategy_Action_2015(player, 41, "move", 1, AiShooter(), 16, 0, x+2, y)
		AiRed_Strategy_Action_2015(player, 44, "move", 1, AiShooter(), 15, 1, x+2, y+2)
		AiRed_Strategy_Action_2015(player, 47, "move", 1, AiShooter(), 14, 2, x, y+2)
		AiRed_Strategy_Action_2015(player, 50, "attack", 1, AiShooter(), 31, 31)
		AiRed_Strategy_Action_2015(player, 51, "attack", 1, AiCavalryMage(), 31, 31)
	end
	AiRed_Strategy_Action_2015(player, 0, "skip", 1)
	-- 1
	-- 2
	AiRed_Strategy_Action_2015(player, 3, "skip", 1)
	AiRed_Strategy_Action_2015(player, 4, "summon", 1, AiShooter(), x, y)
	AiRed_Strategy_Action_2015(player, 5, "attack", 1, AiShooter(), x-1, y-1, x, y)
	AiRed_Strategy_Action_2015(player, 6, "skip", 1)
	AiRed_Strategy_Action_2015(player, 7, "summon", 1, AiShooter(), x+2, y)
	AiRed_Strategy_Action_2015(player, 8, "attack", 1, AiShooter(), x+3, y-1, x+2, y)
	AiRed_Strategy_Action_2015(player, 9, "skip", 1)
	AiRed_Strategy_Action_2015(player, 10, "summon", 1, AiCavalryMage(), x, y+2)
	AiRed_Strategy_Action_2015(player, 11, "attack", 1, AiCavalryMage(), x-1, y+3, x, y+2)
	-- 12
	AiRed_Strategy_Action_2015(player, 13, "summon", 1, AiShooter(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 14, "attack", 1, AiShooter(), x+3, y+3, x+2, y+2)
	AiRed_Strategy_Action_2015(player, 15, "skip", 10)
	AiRed_Strategy_Action_2015(player, 16, "move", 1, AiShooter(), x+2, y+2, x+3, y+3)
	AiRed_Strategy_Action_2015(player, 17, "move", 1, AiCavalryMage(), x, y+2, x-1, y+3)
	AiRed_Strategy_Action_2015(player, 18, "move", 1, AiShooter(), x+2, y, x+3, y-1)
	AiRed_Strategy_Action_2015(player, 19, "move", 1, AiShooter(), x, y, x-1, y-1)
	AiRed_Strategy_Action_2015(player, 20, "summon", 1, AiHeroRider(), x+1, y+1)
	AiRed_Strategy_Action_2015(player, 21, "move", 1, AiWorker(), x+4, y+4)
	AiRed_Strategy_Action_2015(player, 22, "summon", 1, AiShooter(), x+1, y)
	AiRed_Strategy_Action_2015(player, 23, "move", 1, AiHeroRider(), x+1, y+1)
	AiRed_Strategy_Action_2015(player, 24, "summon", 1, AiShooter(), x+1, y+2)
	AiRed_Strategy_Action_2015(player, 25, "summon", 1, AiFodder(), x+1, y-1)
	AiRed_Strategy_Action_2015(player, 26, "summon", 1, AiFlyer(), x-1, y-1)
	AiRed_Strategy_Action_2015(player, 27, "summon", 1, AiHeroRider(), x, y+1)
	AiRed_Strategy_Action_2015(player, 28, "summon", 1, AiFlyer(), x+2, y-1)
	AiRed_Strategy_Action_2015(player, 29, "summon", 1, AiHeroRider(), x+2, y)
	AiRed_Strategy_Action_2015(player, 30, "skip", 10)
	AiRed_Strategy_Action_2015(player, 31, "summon", 9, AiSoldier(), x-4, y+3)
	AiRed_Strategy_Action_2015(player, 32, "skip", 10)
	AiRed_Strategy_Action_2015(player, 33, "summon", 1, AiFlyer(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 34, "summon", 1, AiFlyer(), x-1, y+2)
	AiRed_Strategy_Action_2015(player, 35, "skip", 1)
	-- 36
	AiRed_Strategy_Action_2015(player, 37, "skip", 1)
	-- 38
	AiRed_Strategy_Action_2015(player, 39, "summon", 1, AiHeroShooter(), x, y)
	AiRed_Strategy_Action_2015(player, 40, "skip", 1)
	-- 41
	AiRed_Strategy_Action_2015(player, 42, "summon", 1, AiHeroShooter(), x+2, y)
	AiRed_Strategy_Action_2015(player, 43, "skip", 1)
	-- 44
	AiRed_Strategy_Action_2015(player, 45, "summon", 1, AiHeroShooter(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 46, "skip", 1)
	-- 47
	AiRed_Strategy_Action_2015(player, 48, "summon", 1, AiHeroShooter(), x, y+2)
	AiRed_Strategy_Action_2015(player, 49, "skip", 10)
	-- 50
	-- 51
	AiRed_Strategy_Action_2015(player, 52, "summon", 1, "hero", x+1, y+1)
	AiRed_Strategy_Action_2015(player, 53, "summon", 1,"hero", x+1, y+1)
	AiRed_Strategy_Action_2015(player, 54, "summon", 1, "hero", x+1, y+1)
	AiRed_Strategy_Action_2015(player, 55, "skip", 10)
	AiRed_Strategy_Action_2015(player, 56, "loop", 31)
end

function AiAya_FtM_One_Way_Through_2015(player)
	AiShane_FtM_One_Way_Through_2015(player)
	-- TODO: This!
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
		AiRed_Strategy_Action_2015(player, 19, "move", 1, AiWise(), x+4, y+1)
		AiRed_Strategy_Action_2015(player, 66, "move", 1, AiWise(), x+4, y+1)
		AiRed_Strategy_Action_2015(player, 67, "move area", 10, AiSoldier(), 47, 47, x+6, y-9)
		AiRed_Strategy_Action_2015(player, 68, "move area", 10, AiLonerShooter(), 47, 47, x+6, y-9)
	elseif (player == 11) then
		AiRed_Strategy_Action_2015(player, 0, "move", 1, AiWise(), 91, 93, x+1, y+1)
		AiRed_Strategy_Action_2015(player, 19, "move", 1, AiWise(), x-2, y+1)
		AiRed_Strategy_Action_2015(player, 66, "move", 1, AiWise(), x-2, y+1)
		AiRed_Strategy_Action_2015(player, 67, "move area", 10, AiSoldier(), 47, 47, x-6, y-9)
		AiRed_Strategy_Action_2015(player, 68, "move area", 10, AiLonerShooter(), 47, 47, x-6, y-9)
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
		AiRed_Strategy_Action_2015(player, 24, "move", 1, AiShooter(), x, y-26, x, y+1)
		AiRed_Strategy_Action_2015(player, 29, "move", 1, AiShooter(), x+1, y-26, x+1, y)
		AiRed_Strategy_Action_2015(player, 31, "move", 1, AiShooter(), x+2, y-26, x+2, y)
		AiRed_Strategy_Action_2015(player, 36, "move", 1, AiShooter(), x-1, y-26, x+1, y+2)
		AiRed_Strategy_Action_2015(player, 38, "move", 1, AiShooter(), x-2, y-26, x, y+2)
		AiRed_Strategy_Action_2015(player, 41, "move", 1, AiShooter(), x-3, y-26, x+2, y+2)
		AiRed_Strategy_Action_2015(player, 48, "move", 1, AiEliteShooter(), x-1, y-25, x+1, y+2)
		AiRed_Strategy_Action_2015(player, 49, "move", 1, AiEliteShooter(), x-2, y-25, x, y+2)
		AiRed_Strategy_Action_2015(player, 50, "move", 1, AiEliteShooter(), x-3, y-25, x+2, y+2)
		AiRed_Strategy_Action_2015(player, 60, "move", 1, AiWise(), x, y-11)
		AiRed_Strategy_Action_2015(player, 62, "summon", 5, AiLonerShooter(), x, y-10)
		AiRed_Strategy_Action_2015(player, 63, "summon", 5, AiSoldier(), x, y-10)
		AiRed_Strategy_Action_2015(player, 65, "summon", 5, AiSoldier(), x, y-10)
		AiRed_Strategy_Action_2015(player, 71, "attack area", 10, AiSoldier(), 76, 9, 47, 47)
		AiRed_Strategy_Action_2015(player, 72, "attack area", 5, AiLonerShooter(), 76, 10, 47, 47)
		AiRed_Strategy_Action_2015(player, 73, "attack area", 10, AiSoldier(), 19, 10, 76, 9)
		AiRed_Strategy_Action_2015(player, 74, "attack area", 5, AiLonerShooter(), 19, 9, 76, 10)
	end
	AiRed_Strategy_Action_2015(player, 1, "summon", 1, AiCatapult(), x+1, y+1)
	AiRed_Strategy_Action_2015(player, 2, "summon", 1, AiShooter(), x+1, y+2)
	AiRed_Strategy_Action_2015(player, 3, "attack", 1, AiShooter(), x+1, y+3, x+1, y+2)
	AiRed_Strategy_Action_2015(player, 4, "summon", 1, AiShooter(), x, y+2)
	AiRed_Strategy_Action_2015(player, 5, "attack", 1, AiShooter(), x, y+3, x, y+2)
	AiRed_Strategy_Action_2015(player, 6, "summon", 1, AiShooter(), x+2, y+2)
	AiRed_Strategy_Action_2015(player, 7, "attack", 1, AiShooter(), x+2, y+3, x+2, y+2)
	AiRed_Strategy_Action_2015(player, 8, "skip", 10)
	AiRed_Strategy_Action_2015(player, 9, "summon", 1, AiEliteShooter(), x, y)
	AiRed_Strategy_Action_2015(player, 10, "attack", 1, AiEliteShooter(), x-1, y-1, x, y)
	AiRed_Strategy_Action_2015(player, 10, "attack", 1, AiEliteShooter(), x-1, y-1, x, y)
	AiRed_Strategy_Action_2015(player, 11, "attack", 1, AiShooter(), x+3, y+3, x+1, y+2)
	AiRed_Strategy_Action_2015(player, 12, "summon", 1, AiShooter(), x, y+1)
	AiRed_Strategy_Action_2015(player, 13, "attack", 1, AiShooter(), x-1, y, x, y+1)
	AiRed_Strategy_Action_2015(player, 14, "attack", 1, AiShooter(), x-1, y+3, x, y+2)
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
	AiRed_Strategy_Action_2015(player, 26, "attack", 1, AiShooter(), x+1, y+2, x, y+4)
	AiRed_Strategy_Action_2015(player, 27, "oil", 12000)
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
DefineAi("Sandria Fields", "*", "ai_red_2015", AiSandria_2015)
DefineAi("Lucas Kage", "*", "ai_red_2015", AiLucas_2015)
DefineAi("Kiah Stone", "*", "ai_red_2015", AiKiah_2015)
DefineAi("Nathan Withers", "*", "ai_red_2015", AiNathan_2015)