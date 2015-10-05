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
	if (ftm_choice == nil) then AiRedRibbon_Setup_2014() end
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
		if ((GameDefinition["Name"] == "Frontlines") or (GameDefinition["Name"] == "Front Lines")) then
			--ftm_team_x1[player] = 0
			--ftm_team_y1[player] = 0
			--ftm_team_x2[player] = 255
			--ftm_team_y2[player] = 255
			
			ftm_team_x1[player] = 43
			ftm_team_y1[player] = 0
			ftm_team_x2[player] = 80
			ftm_team_y2[player] = 127
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
		elseif (GameDefinition["Name"] == "Escape") then
			ftm_team_x1[player] = varA1
			ftm_team_y1[player] = varA2
			ftm_team_x2[player] = varB1
			ftm_team_y2[player] = varB2
		end
	end
end

function AiEscape_2015()

end

function AiFrontlines_2015()
	for player = 0, 15 do
		if ((ftm_faction[AiPlayer()] == ftm_faction[player]) and (player ~= AiPlayer())) then
			if (GameDefinition["Version"] == "Advanced") then
				-- Teleport the unit!
				if ((timers[AiPlayer()] == 1) or (timers[AiPlayer()] == 11) or (timers[AiPlayer()] == 21) or (timers[AiPlayer()] == 31) or (timers[AiPlayer()] == 41) or (timers[AiPlayer()] == 51) or (timers[AiPlayer()] == 61) or (timers[AiPlayer()] == 71) or (timers[AiPlayer()] == 81) or (timers[AiPlayer()] == 91) or (timers[AiPlayer()] == 101) or (timers[AiPlayer()] == 111) or (timers[AiPlayer()] == 121) or (timers[AiPlayer()] == 131) or (timers[AiPlayer()] == 141) or (timers[AiPlayer()] == 151) or (timers[AiPlayer()] == 161) or (timers[AiPlayer()] == 171) or (timers[AiPlayer()] == 181) or (timers[AiPlayer()] == 191) or
				(timers[AiPlayer()] == 6) or (timers[AiPlayer()] == 16) or (timers[AiPlayer()] == 26) or (timers[AiPlayer()] == 36) or (timers[AiPlayer()] == 46) or (timers[AiPlayer()] == 56) or (timers[AiPlayer()] == 66) or (timers[AiPlayer()] == 76) or (timers[AiPlayer()] == 86) or (timers[AiPlayer()] == 96) or (timers[AiPlayer()] == 106) or (timers[AiPlayer()] == 116) or (timers[AiPlayer()] == 126) or (timers[AiPlayer()] == 136) or (timers[AiPlayer()] == 146) or (timers[AiPlayer()] == 156) or (timers[AiPlayer()] == 166) or (timers[AiPlayer()] == 176) or (timers[AiPlayer()] == 186) or (timers[AiPlayer()] == 196)) then
					for index = 1, 15 do
						if (GetNumUnitsAt(player, UnitDatabase[GetPlayerData(player, "RaceName")][index]["Unit"], {ftm_team_x1[player], ftm_team_y1[player]}, {ftm_team_x2[player], ftm_team_y2[player]}) > 0) then
							KillUnitAt(UnitDatabase[GetPlayerData(player, "RaceName")][index]["Unit"], player, 1, {ftm_team_x1[player], ftm_team_y1[player]}, {ftm_team_x2[player], ftm_team_y2[player]})
							CreateUnit(UnitDatabase[GetPlayerData(player, "RaceName")][index]["Unit"], AiPlayer(), {ftm_team_startx[AiPlayer()], ftm_team_starty[AiPlayer()]})
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
						if (GetNumUnitsAt(AiPlayer(), UnitDatabase["human"][index]["Unit"], {0,0}, {mapinfo.w,mapinfo.h}) > 0) then
							OrderUnit(AiPlayer(), UnitDatabase["human"][index]["Unit"], {0,0,mapinfo.w,mapinfo.h}, {ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]],ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]]}, "attack")
						end
						if (GetNumUnitsAt(AiPlayer(), UnitDatabase["orc"][index]["Unit"], {0,0}, {mapinfo.w,mapinfo.h}) > 0) then
							OrderUnit(AiPlayer(), UnitDatabase["orc"][index]["Unit"], {0,0,mapinfo.w,mapinfo.h}, {ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]],ftm_team_startx[ftm_team[player]],ftm_team_starty[ftm_team[player]]}, "attack")
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
	elseif (GameDefinition["Name"] == "Escape") then
		AiLucas_Escape_2015()
	end
end

function AiShane_2015()
	AiCharacter_Set_Name_2015("Shane Wolfe")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiShane_FtM_2015(AiPlayer())
	elseif (GameDefinition["Name"] == "Escape") then
		AiShane_Escape_2015()
	else
		AiShane_Skirmish_2015()
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
	elseif (GameDefinition["Name"] == "Escape") then
		AiNathan_Escape_2015()
	end
end

function AiRufus_2015()
	AiCharacter_Set_Name_2015("Rufus Norcross")
	if (GameDefinition["Name"] == "Escape") then
		AiRufus_Escape_2015()
	end
end

function AiKiah_2015()
	AiCharacter_Set_Name_2015("Kiah Stone")
	--Check game type.
	if (GameDefinition["Name"] == "For the Motherland") then
		AiAya_FtM_2015(AiPlayer())
	elseif (GameDefinition["Name"] == "Skirmish") then
		AiLucas_Skirmish_2015()
	elseif (GameDefinition["Name"] == "Escape") then
		AiKiah_Escape_2015()
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

function AiNathan_Escape_2015()
	if (GameDefinition["Map"]["Name"] == "Seawill Forests") then
		AiNathan_Escape_Seawill_Forests_2015()
	end
end

function AiRufus_Escape_2015()
	if (GameDefinition["Map"]["Name"] == "Seawill Forests") then
		AiRufus_Escape_Seawill_Forests_2015()
	end
end

function AiShane_Escape_2015()
	if (GameDefinition["Map"]["Name"] == "Shameful Display") then
		if (GameCycle < 50) then
			AiForce(0, {AiFodder(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFodder())})
		elseif ((UnitNear(2, AiSoldier(2), 26, 108, 10) == true) or (UnitNear(2, AiSoldier(2), 74, 106, 10) == true) or (UnitNear(2, AiSoldier(2), 101, 117, 10) == true)) then
			AiNephrite_Attack_2013("force")
		end
	elseif (GameDefinition["Map"]["Name"] == "Seawill Forests") then
		AiShane_Escape_Seawill_Forests_2015()
	end
end

function AiKiah_Escape_2015()
	if (GameDefinition["Map"]["Name"] == "Shameful Display") then
		AiKiah_Escape_Shameful_Display_2015()
	end
end

function AiLucas_Skirmish_2015()
	if ((GameDefinition["Map"]["Name"] == "Northern Swamp") or (GameDefinition["Map"]["Name"] == "Southern Swamp")) then
		AiLucas_Skirmish_Northern_Swamp_2015()
	elseif (GameDefinition["Map"]["Name"] == "Reclaiming Genesis Castle") then
		AiLucas_Skirmish_Reclaiming_Genesis_2015()
	else
		AiLucas_Skirmish_Standard_2015()
	end
end

function TransferResource(from, to, resource)
	if ((resource ~= nil) and (from ~= nil) and (to ~= nil)) then
		if (resource[2] == nil) then resource[2] = GetPlayerData(from, "Resources", resource[1]) end
		if (resource[2] <= GetPlayerData(from, "Resources", resource[1])) then
			SetPlayerData(to, "Resources", resource[1], GetPlayerData(to, "Resources", resource[1]) + resource[2])
			SetPlayerData(from, "Resources", resource[1], GetPlayerData(from, "Resources", resource[1]) - resource[2])
			return true
		else
			return false
		end
	else
		return false
	end
end

function TransferResources(from, to, resource1, resource2, resource3)
	if (resource1 ~= nil) then
		TransferResource(from, to, resource1)
	end
	if (resource2 ~= nil) then
		TransferResource(from, to, resource2)
	end
	if (resource3 ~= nil) then
		TransferResource(from, to, resource3)
	end
end

function AiShane_Skirmish_2015()
	if (GameDefinition["Map"]["Name"] == "Dunath Plains") then
		if (GameCycle < 1500) then
			AiSet(AiFarm(), 10)
			AiSet(AiWorker(), 5)
			AiSet(AiBarracks(), 1)
			AiJadeite_Variable_2010("archers", true)
		else
			AiJadeite_Force_2010(0, AiEliteShooter(), 5)
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFodder()) > 4) then
				AiJadeite_Upgrade_2010(AiSoldier())
			end
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 4) then
				AiJadeite_Upgrade_2010(AiShooter())
			end
			if (ArmyNear(1, 9, 6, 5) == true) then
				AiJadeite_Attack_2010(3, true)
				if ((CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] < 9) and (GetPlayerData(1, "UnitTypesCount", AiSoldier(1)) > 6) and (UnitNear(4, AiCityCenter(4), 9, 6, 5)) and ((GetPlayerData(1, "UnitTypesCount", AiSoldier(1)) > GetPlayerData(4, "UnitTypesCount", AiSoldier(4)) + GetPlayerData(4, "UnitTypesCount", AiFodder(4))))) then
					if ((GetPlayerData(6, "UnitTypesCount", AiEliteShooter(6)) > 6) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] < 10)) then
						BundleAction("Game", "Lucas Kage", "Sit tight, I'm sending help.")
					else
						BundleAction("Game", "Lucas Kage", "I'm sorry, I can't help you. My forces have been decimated.")
					end
					CampaignDataSetup("Lucas Kage", 9)
				end
			elseif (ArmyNear(4, 100, 100, 25) == true) then
				AiJadeite_Attack_2010(3, true)
				if ((ArmyNear(4, 100, 100, 10) == true) and (UnitNear(4, AiCityCenter(4), 9, 6, 5)) and (UnitNear(6, AiCityCenter(6), 111, 25, 5)) and ((GetPlayerData(6, "UnitTypesCount", AiFodder(6)) > 4) or (GetPlayerData(6, "UnitTypesCount", AiEliteShooter(6)) > 6)) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] < 10)) then
					SetGamePaused(true)
					if ((CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] > 0) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] < 9)) then
						BundleAction("Game", "Lucas Kage", "Now is the time, Mythic.")
						BundleAction("Game", "Lucas Kage", "Let us assault the enemy fortifications.")
					else
						BundleAction("Game", "Lucas Kage", "The calvary has arrived.")
						BundleAction("Game", "Lucas Kage", "Let's crush these Wild scum together.")
					end
					BundleAction("Game", "Lucas Kage", "Stick close to the rangers.")
					SetGamePaused(false)
					CampaignDataSetup("Lucas Kage", 10)
				end
			end
			AiJadeite_Intermittent_2010()
			AiSet(AiWorker(), 5)
			AiJadeite_Force_2010(3, AiFodder(), 20, AiShooter(), 10)
			TransferResources(14, 6, {"gold"}, {"wood"}, {"oil"})
		end
		if ((UnitNear(14, AiCityCenter(14), 9, 6, 5)) and (UnitNear(4, AiHeroSoldier(4), 111, 25, 115)) and (UnitNear(6, AiCityCenter(6), 111, 25, 5)) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] == 0)) then
			if (GameCycle < 10000) then
				BundleAction("Game", "Sandria Fields", "Hello Mythic. Good of you to come.")
				BundleAction("Game", "Sandria Fields", "Together we'll be able about to drive these Wild scum out of Dunath.")
				BundleAction("Game", "Sandria Fields", "If you need a headquarters, there is one you can use to the west.")
			else
				BundleAction("Game", "Lucas Kage", "Oh, hi Myth.")
				BundleAction("Game", "Lucas Kage", "Nice of you to finally arrive.")
				BundleAction("Game", "Lucas Kage", "The townsfolk are waiting for you at the town hall to the west.")
			end
			CampaignDataSetup("Lucas Kage", 1)
		elseif ((UnitNear(4, AiCityCenter(4), 9, 6, 5)) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] < 5) and (ArmyNear(4, 100, 100, 25) ~= true)) then
			if (GameCycle < 15000) then
				if (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] == 0) then
					BundleAction("Game", "Lucas Kage", "Greetings Mythic. It is good you have finally arrived.")
					BundleAction("Game", "Lucas Kage", "Together we'll be able about to drive these Wild scum out of Dunath.")
					BundleAction("Game", "Lucas Kage", "They have been tearing our stores down and raiding our supplies.")
				else
					BundleAction("Game", "Lucas Kage", "Those Wild marauders have been tearing our farms and stealing our supplies.")
				end
				BundleAction("Game", "Lucas Kage", "The first thing you are going to want to do is to replace the four farmsteads that were lost.")
				BundleAction("Game", "Lucas Kage", "Without them you wont have the supplies needed to fight back.")
			else
				BundleAction("Game", "Lucas Kage", "You made it, finally.")
				BundleAction("Game", "Lucas Kage", "I don't have time to explain the situation.")
				BundleAction("Game", "Lucas Kage", "Just build a barracks and four farmsteads.")
				BundleAction("Game", "Lucas Kage", "You'll need them to gather minutemen.")
			end
			BundleAction("Game", "Lucas Kage", "Assign three workers to collect lumber. Tell the remaining ones mine gold.")
			CampaignDataSetup("Lucas Kage", 5)
		elseif ((GetPlayerData(4, "UnitTypesCount", AiFarm(4)) > 2) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] == 5)) then
			if (GetPlayerData(4, "UnitTypesCount", AiBarracks(4)) == 0) then
				BundleAction("Game", "Lucas Kage", "Think about building a barracks. That would allow you to recruit minutemen.")
				CampaignDataSetup("Lucas Kage", 6)
			else
				BundleAction("Game", "Lucas Kage", "Minutemen are townsfolk who have undergone combat training, and can be equiped with improved weapons from the blacksmith.")
				CampaignDataSetup("Lucas Kage", 8)
			end
		elseif ((GetPlayerData(4, "UnitTypesCount", AiBarracks(4)) > 0) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] == 6)) then
			BundleAction("Game", "Lucas Kage", "You can train minutemen at this barracks. It shouldn't take more than a minute.")
			CampaignDataSetup("Lucas Kage", 7)
		elseif ((GetPlayerData(4, "UnitTypesCount", AiFodder(4)) > 5) and (GetPlayerData(4, "UnitTypesCount", AiBlacksmith(4)) == 0) and (CampaignData["Lucas Kage"]["Dunath Plains"]["Magic"] == 7)) then
			BundleAction("Game", "Lucas Kage", "Think about building a blacksmith. You'll be able to equip your minutemen with better weapons and armour.")
			CampaignDataSetup("Lucas Kage", 8)
		end
	end
end

function AiLucas_Escape_2015()
	if (GameDefinition["Map"]["Name"] == "Shameful Display") then
		AiLucas_Escape_Shameful_Display_2015()
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
	if ((GetPlayerData(player, "UnitTypesCount", unit) > 0) and (GetNumUnitsAt(player, unit, {x-area, y-area}, {x+area, y+area}) > 0)) then 
		return true
	else
		return false
	end
end

function ArmyNear(player, x, y, area)
	local t = {AiHeroSoldier(player), AiShooter(player), AiEliteShooter(player), AiSoldier(player), AiCatapult(player), AiFodder(player)}
	for i=1, 6 do
		if (UnitNear(player, t[i], x, y, area) == true) then
			return true
		end
	end
end

function MoveNavySafe(player, tox, toy, fromx, fromy, area, enemy, action)
	if ((enemy == nil) or (((GetNumUnitsAt(enemy, AiBattleship(enemy), {tox-area-10, toy-area-10}, {tox+area+10, toy+area+10}) == 0) or (GetNumUnitsAt(player, AiBattleship(player), {fromx-area, fromy-area}, {fromx+area, fromy+area}) > 1)) and (GetNumUnitsAt(enemy, AiTransporter(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2) and (GetNumUnitsAt(enemy, AiDestroyer(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2) and (GetNumUnitsAt(enemy, AiSubmarine(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) == 0))) then
		if (MoveNavyQuick(player, tox, toy, fromx, fromy, area, action) == true) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function MoveArmySafe(player, tox, toy, fromx, fromy, area, enemy, action)
	if (((GetNumUnitsAt(enemy, AiSoldier(enemy), {tox-area-10, toy-area-10}, {tox+area+10, toy+area+10}) == 0) or (GetNumUnitsAt(player, AiSoldier(player), {fromx-area, fromy-area}, {fromx+area, fromy+area}) > 2)) and (GetNumUnitsAt(enemy, AiCavalryMage(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2) and (GetNumUnitsAt(enemy, AiEliteShooter(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2) and (GetNumUnitsAt(enemy, AiShooter(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2) and (GetNumUnitsAt(enemy, AiCatapult(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2) and (GetNumUnitsAt(enemy, AiCavalry(enemy), {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) < 2)) then
		if (MoveArmyQuick(player, tox, toy, fromx, fromy, area, action) == true) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function FollowNavyQuick(player, tox, toy, fromx, fromy, area, ally, action)
	if (ally ~= nil) then
		local n = {AiDestroyer(ally), AiTransporter(ally), AiSubmarine(ally), AiBattleship(ally)}
		if ((GetNumUnitsAt(ally, n[1], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, n[2], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, n[3], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, n[4], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0)) then
			if (MoveNavyQuick(player, tox, toy, fromx, fromy, area, action) == true) then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function FollowArmyQuick(player, tox, toy, fromx, fromy, area, ally, action)
	if (ally ~= nil) then
		local a = {AiHeroSoldier(ally), AiShooter(ally), AiEliteShooter(ally), AiSoldier(ally), AiCatapult(ally)}
		if ((GetNumUnitsAt(ally, a[1], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, a[2], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, a[3], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, a[4], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0) or (GetNumUnitsAt(ally, a[5], {tox-area-5, toy-area-5}, {tox+area+5, toy+area+5}) > 0)) then
			if (MoveArmyQuick(player, tox, toy, fromx, fromy, area, action) == true) then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function MoveNavyQuick(player, tox, toy, fromx, fromy, area, action)
	local n = {AiDestroyer(player), AiTransporter(player), AiSubmarine(player), AiBattleship(player)}
	for i=1, 4 do
		MoveUnitQuick(player, n[i], tox, toy, fromx, fromy, area, action)
	end
	if ((UnitNear(player, n[1], fromx, fromy, area) == true) or (UnitNear(player, n[2], fromx, fromy, area) == true) or (UnitNear(player, n[3], fromx, fromy, area) == true) or (UnitNear(player, n[4], fromx, fromy, area) == true))	then 
		return true
	else
		return false
	end
end

function MoveArmyQuick(player, tox, toy, fromx, fromy, area, action)
	local a = {AiHeroSoldier(player), AiShooter(player), AiEliteShooter(player), AiSoldier(player), AiCatapult(player)}
	for i=1, 5 do
		MoveUnitQuick(player, a[i], tox, toy, fromx, fromy, area, action)
	end
		if ((UnitNear(player, a[1], fromx, fromy, area) == true) or (UnitNear(player, a[2], fromx, fromy, area) == true) or (UnitNear(player, a[3], fromx, fromy, area) == true) or (UnitNear(player, a[4], fromx, fromy, area) == true) or (UnitNear(player, a[5], fromx, fromy, area) == true))	then 
		return true
	else
		return false
	end
end

function MoveUnitQuick(player, unit, tox, toy, fromx, fromy, area, action)
	if (area ~= 1) then 
	--	tox = tox + SyncRand(3) - SyncRand(3) 
	--	toy = toy + SyncRand(3) - SyncRand(3) 
	end
	if (unit == AiTransporter(player)) then action = "move" end
	if (action == nil) then 
		for j=0, 15 do
			if (GetPlayerData(j, "TotalNumUnits") > 0) then
				local t = {AiHeroSoldier(j), AiShooter(j), AiEliteShooter(j), AiSoldier(j), AiCatapult(j)}
				local b = {AiFarm(j)}
				local n = {AiDestroyer(player), AiTransporter(player), AiSubmarine(player), AiBattleship(player)}
				for i=1, 5 do
					if (((t[i] ~= nil) and (GetNumUnitsAt(j, t[i], {tox, toy}, {tox, toy}) > 0)) or ((b[i] ~= nil) and (GetNumUnitsAt(j, b[i], {tox, toy}, {tox, toy}) > 0)) or ((n[i] ~= nil) and (GetNumUnitsAt(j, n[i], {tox, toy}, {tox, toy}) > 0))) then
						action = "move"
						break
					end
				end
			end
		end
		if (action == nil) then 
			action = "attack" 
		end
	end
	if (UnitNear(player, unit, fromx, fromy, area) == true) then 
		if (area == nil) then area = SyncRand(3) end
		OrderUnit(player, unit, {fromx-area,fromy-area,fromx+area,fromy+area}, {tox,toy,tox,toy}, action)
		return true
	else
		return false
	end
end

function MoveNavyGrid(player, to, from, area, enemy, ally, action)
	for j=1, 4 do
		if ((from[j] ~= nil) and (from[j][1] ~= nil) and (from[j][2] ~= nil)) then
			if     (((ally ~= nil) and (to[1] ~= nil) and (to[1][1] ~= nil) and (to[1][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), to[1][1], to[1][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[2] ~= nil) and (to[2][1] ~= nil) and (to[2][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), to[2][1], to[2][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[3] ~= nil) and (to[3][1] ~= nil) and (to[3][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), to[3][1], to[3][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[4] ~= nil) and (to[4][1] ~= nil) and (to[4][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), to[4][1], to[4][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (FollowNavyQuick(AiPlayer(), from[j][1], from[j][2], from[j][1], from[j][2], area, ally) == true) then return false
			-- go back
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[1] ~= nil) and (from[1][1] ~= nil) and (from[1][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), from[1][1], from[1][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[2] ~= nil) and (from[2][1] ~= nil) and (from[2][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), from[2][1], from[2][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[3] ~= nil) and (from[3][1] ~= nil) and (from[3][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), from[3][1], from[3][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[4] ~= nil) and (from[4][1] ~= nil) and (from[4][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), from[4][1], from[4][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (to[j][1] ~= nil) and (to[j][2] ~= nil)) and (FollowNavyQuick(AiPlayer(), to[j][1], to[j][2], to[j][1], to[j][2], area, ally) == true)) then return false
			else
				for i=1, 4 do
					if (((from[i] ~= nil) and (to[j] ~= nil) and (from[i][1] ~= nil) and (from[i][2] ~= nil)  and (to[j][1] ~= nil) and (to[j][2] ~= nil)) and (MoveNavySafe(AiPlayer(), to[j][1], to[j][2], from[i][1], from[i][2], area, enemy, action) == true)) then 
						break
					end
				end
			end
		end
	end
end

function MoveArmyGrid(player, to, from, area, enemy, ally, action)
	local ji = {}
	repeat ji[1] = SyncRand(4) + 1 until (ji[1] ~= 0)
	repeat ji[2] = SyncRand(4) + 1 until ((ji[1] ~= ji[2]) and (ji[2] ~= 0))
	repeat ji[3] = SyncRand(4) + 1 until ((ji[1] ~= ji[3]) and (ji[2] ~= ji[3]) and (ji[3] ~= 0))
	repeat ji[4] = SyncRand(4) + 1 until ((ji[1] ~= ji[4]) and (ji[2] ~= ji[4]) and (ji[3] ~= ji[4]) and (ji[4] ~= 0))
	for j=1, 4 do
		if ((from[j] ~= nil) and (from[j][1] ~= nil) and (from[j][2] ~= nil)) then
			if     (((ally ~= nil) and (to[ji[1]] ~= nil) and (to[ji[1]][1] ~= nil) and (to[ji[1]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), to[ji[1]][1], to[ji[1]][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[ji[2]] ~= nil) and (to[ji[2]][1] ~= nil) and (to[ji[2]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), to[ji[2]][1], to[ji[2]][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[ji[3]] ~= nil) and (to[ji[3]][1] ~= nil) and (to[ji[3]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), to[ji[3]][1], to[ji[3]][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[ji[4]] ~= nil) and (to[ji[4]][1] ~= nil) and (to[ji[4]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), to[ji[4]][1], to[ji[4]][2], from[j][1], from[j][2], area + 2, ally) == true)) then return true
			elseif (FollowArmyQuick(AiPlayer(), from[j][1], from[j][2], from[j][1], from[j][2], area, ally) == true) then return false
			-- go back
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[ji[1]] ~= nil) and (from[ji[1]][1] ~= nil) and (from[ji[1]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), from[ji[1]][1], from[ji[1]][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[ji[2]] ~= nil) and (from[ji[2]][1] ~= nil) and (from[ji[2]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), from[ji[2]][1], from[ji[2]][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[ji[3]] ~= nil) and (from[ji[3]][1] ~= nil) and (from[ji[3]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), from[ji[3]][1], from[ji[3]][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (from[ji[4]] ~= nil) and (from[ji[4]][1] ~= nil) and (from[ji[4]][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), from[ji[4]][1], from[ji[4]][2], to[j][1], to[j][2], area + 2, ally) == true)) then return true
			elseif (((ally ~= nil) and (to[j] ~= nil) and (to[j][1] ~= nil) and (to[j][2] ~= nil)) and (FollowArmyQuick(AiPlayer(), to[j][1], to[j][2], to[j][1], to[j][2], area, ally) == true)) then return false
			else
				for i=1, 4 do
					if (((from[ji[i]] ~= nil) and (to[j] ~= nil) and (from[ji[i]][1] ~= nil) and (from[ji[i]][2] ~= nil)  and (to[j][1] ~= nil) and (to[j][2] ~= nil)) and (MoveArmySafe(AiPlayer(), to[j][1], to[j][2], from[ji[i]][1], from[ji[i]][2], area, enemy, action) == true)) then 
						break
					end
				end
			end
		end
	end
end

function TeleportUnit(toplayer, tounit, topos, fromplayer, fromunit, frompos, fromdelete, area)
	if (GetNumUnitsAt(toplayer, tounit, {topos[1], topos[2]}, {topos[1], topos[2]}) == 0) then 
		if (GetPlayerData(fromplayer, "UnitTypesCount", fromunit) > 0) then
			if (GetNumUnitsAt(fromplayer, fromunit, {frompos[1], frompos[2]}, {frompos[1], frompos[2]}) > 0) then 
				CreateUnit(tounit, toplayer, {topos[1], topos[2]})
				if (fromdelete == true) then
					KillUnitAt(fromunit, fromplayer, 1, frompos[1], frompos[2])
				end
				return true
			elseif (GetNumUnitsAt(fromplayer, fromunit, {frompos[1] - 1, frompos[2] - 1}, {frompos[1] + 1, frompos[2] + 1}) > 0) then
				if (area == nil) then area = 1 end
				MoveUnitQuick(fromplayer, fromunit, frompos[1], frompos[2], frompos[1], frompos[2], area, "move")
			end
		end
	end
end

function AiNathan_Escape_Seawill_Forests_2015()
	local NathanEnemy = 4 -- Who we want to avoid.
	local NathanAlly = 0 -- Who we want to follow.
	if (NathanTimer == nil) then 
		NathanTimer = 20
	elseif (NathanTimer < 1) then 
		NathanTimer = 40
	else 
		NathanTimer = NathanTimer - 1 
	end
	if (GameCycle < 50) then
		OrderUnitSquare(AiPlayer(), AiDestroyer(), 7, 184, 1, 3, 4, 125)
		OrderUnitSquare(AiPlayer(), AiDestroyer(), 10, 184, 1, 3, 75, 180)
		OrderUnitSquare(AiPlayer(), AiHeroSoldier(), 28, 32, 1, 1, 60, 92)
	elseif (GameCycle < 100) then
		OrderUnitSquare(AiPlayer(), AiSoldier(), 29, 34, 1, 3, 50, 93)
		OrderUnitSquare(AiPlayer(), AiSoldier(), 27, 37, 1, 3, 107, 71)
	elseif ((GameCycle > 200) and (GameCycle < 300)) then
		OrderUnitSquare(AiPlayer(), AiSoldier(), 27, 31, 3, 1, 53, 79)
	elseif ((UnitNear(4, AiHeroSoldier(4), 61, 91, 6) == true) and (GetPlayerData(4, "UnitTypesCount", AiSoldier(4)) == 0)) then
		SetDiplomacy(3, "allied", 6)
		AiForce(3, {AiHeroSoldier(AiPlayer()), 1, AiSoldier(AiPlayer()), 3}, false)
		AiAttackWithForce(3)
		NathanTimer = 40
		SetDiplomacy(3, "enemy", 6)
	elseif ArmyNear(4, 61, 91, 7) then
		MoveUnitQuick(AiPlayer(), AiHeroSoldier(), 28, 32, 60, 92, 15, "move")
		if (UnitNear(4, AiHeroSoldier(4), 61, 91, 6) == true) then
			MoveUnitQuick(AiPlayer(), AiSoldier(), 61, 91, 61, 91, 30)
		else
			MoveUnitQuick(AiPlayer(), AiSoldier(), 61, 91, 61, 91, 15)
		end
	elseif ArmyNear(4, 45, 96, 3) then
		MoveUnitQuick(AiPlayer(), AiSoldier(), 45, 96, 61, 91, 20)
	elseif ArmyNear(4, 70, 105, 6) then
		MoveUnitQuick(AiPlayer(), AiSoldier(), 70, 105, 64, 91, 3)
	elseif ((GameCycle > 400) and (GameCycle < 500)) then
		OrderUnitSquare(AiPlayer(), AiSoldier(), 28, 34, 1, 3, 72, 86, "move")
	elseif ((GameCycle > 600) and (GameCycle < 700)) then
		OrderUnitSquare(AiPlayer(), AiSoldier(), 28, 34, 1, 3, 37, 24)
		OrderUnitSquare(AiPlayer(), AiSoldier(), 27, 30, 3, 1, 99, 104)
	elseif ((GameCycle > 800) and (GameCycle < 900)) then
		MoveUnitQuick(AiPlayer(), AiSoldier(), 25, 80, 27, 35, 1, "move")
	elseif ((GameCycle > 900) and (GameCycle < 1000)) then
		OrderUnitSquare(AiPlayer(), AiSoldier(), 29, 34, 1, 3, 50, 93)
		OrderUnitSquare(AiPlayer(), AiSoldier(), 27, 31, 3, 1, 53, 79)
		OrderUnitSquare(AiPlayer(), AiSoldier(), 28, 34, 1, 3, 72, 86, "move")
		OrderUnitSquare(AiPlayer(), AiSoldier(), 27, 29, 3, 1, 91, 42)
	elseif (NathanTimer == 40) then
		if (MoveNavyGrid(AiPlayer(), {{7, 157},{51, 166},{74, 156},{108, 157}}, {{14, 133},{50, 137},{83, 134},{117, 132}}, 20, NathanEnemy, NathanAlly) == true) then
		elseif (MoveNavyGrid(AiPlayer(), {{14, 133},{50, 137},{83, 134},{117, 132}}, {{7, 157},{51, 166},{74, 156},{108, 157}}, 20, NathanEnemy, NathanAlly) == true) then
		end
	elseif (NathanTimer == 30) then
		if (MoveNavyGrid(AiPlayer(), {{9, 180},{52, 179},{81, 178},{115, 175}}, {{7, 157},{51, 166},{74, 156},{108, 157}}, 20, NathanEnemy, NathanAlly) == true) then
		elseif (MoveNavyGrid(AiPlayer(), {{7, 157},{51, 166},{74, 156},{108, 157}}, {{9, 180},{52, 179},{81, 178},{115, 175}}, 20, NathanEnemy, NathanAlly) == true) then
		end
	elseif ((NathanTimer == 1) and (GameCycle > 6000)) then
		for NathanX=1,4 do
			if (MoveArmyGrid(AiPlayer(), {{NathanX*25, 25},{NathanX*25, 50},{NathanX*25, 75},{NathanX*25, 100}}, {{NathanX*25+100, 25},{NathanX*25+75, 50},{NathanX*25+50, 75},{NathanX*25+25, 25}}, 40, NathanAlly, NathanEnemy) == true) then
			end
		end
	elseif ((NathanTimer == 20) and (GameCycle > 6000)) then
		for NathanX=1,4 do
			if (MoveArmyGrid(AiPlayer(), {{NathanX*25+25, 100},{NathanX*25+25, 75},{NathanX*25+25, 50},{NathanX*25+25, 25}}, {{NathanX*25, 25},{NathanX*25, 50},{NathanX*25, 75},{NathanX*25, 100}}, 40, NathanAlly, NathanEnemy) == true) then
			end
		end
	end
end

function AiRufus_Escape_Seawill_Forests_2015()
	local RufusEnemy = 3
	local RufusAlly = 4
	if (RufusTimer == nil) then 
		RufusTimer = 30
	elseif (RufusTimer < 1) then 
		RufusTimer = 15
	else 
		RufusTimer = RufusTimer - 1 
	end
	if ((GameCycle > 0) and (GameCycle < 150)) then
		AiForce(0, {AiDestroyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiDestroyer()), AiTransporter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiTransporter())})
		if (MoveUnitQuick(AiPlayer(), AiDestroyer(AiPlayer()), 84, 125, 96, 188, 0, "move") == true) then
		elseif (MoveUnitQuick(AiPlayer(), AiTransporter(AiPlayer()), 89, 123, 99, 188, 0, "move") == true) then
		elseif (MoveUnitQuick(AiPlayer(), AiDestroyer(AiPlayer()), 90, 125, 102, 188, 0, "move") == true) then
		end
	elseif ((UnitNear(AiPlayer(), AiTransporter(AiPlayer()), 90, 123, 5) == true) and (GameCycle > 1000) and (GameCycle < 1500)) then
		if (GetPlayerData(4, "UnitTypesCount", AiSoldier(4)) ~= 3) then
			for i=1,3 do
				TeleportUnit(4, AiSoldier(4), {90 - i, 122}, AiPlayer(), AiTransporter(AiPlayer()), {90 - i, 123}, false, 3)
			end
		elseif (GetPlayerData(4, "UnitTypesCount", AiHeroSoldier(4)) == 0) then
			TeleportUnit(4, AiHeroSoldier(4), {90 - 4, 122}, AiPlayer(), AiTransporter(AiPlayer()), {90 - 4, 123}, false, 3)
		elseif (UnitNear(AiPlayer(), AiTransporter(AiPlayer()), 90-4, 123, 1) == true) then
			MoveUnitQuick(AiPlayer(), AiTransporter(AiPlayer()), 87, 125, 90-4, 123, 1, "move")
		elseif (UnitNear(4, AiHeroSoldier(4), 86, 122, 0) == true) then
			MoveUnitQuick(4, AiHeroSoldier(4), 82+1, 117+0, 86, 122, 0, "move")
		elseif (UnitNear(4, AiSoldier(4), 87, 122, 0) == true) then
			MoveUnitQuick(4, AiSoldier(4), 82+0, 117+2, 87, 122, 0, "move")
		elseif (UnitNear(4, AiSoldier(4), 88, 122, 0) == true) then
			MoveUnitQuick(4, AiSoldier(4), 82+2, 117+2, 88, 122, 0, "move")
		elseif (UnitNear(4, AiSoldier(4), 89, 122, 0) == true) then
			MoveUnitQuick(4, AiSoldier(4), 82+4, 117+2, 89, 122, 0, "move")
		end
	elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()) == 0) and (UnitNear(RufusEnemy, AiDestroyer(RufusEnemy), 93, 150, 8) == true) and (TeleportUnit(AiPlayer(), AiCatapult(), {93, 150}, AiPlayer(), AiTransporter(), {93, 150}, false, 3) == true)) then
	elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()) == 0) and (UnitNear(RufusEnemy, AiDestroyer(RufusEnemy), 108, 151, 8) == true) and (TeleportUnit(AiPlayer(), AiCatapult(), {108, 151}, AiPlayer(), AiTransporter(), {108, 151}, false, 3) == true)) then
	elseif 	(RufusTimer == 1) then
		if (GameCycle > 1500) then
			if (MoveNavyGrid(AiPlayer(), {{120, 133},{101, 145},{86, 144},{68, 129}}, {{88, 126}}, 8, RufusEnemy, RufusAlly) == true) then
			elseif (MoveNavyGrid(AiPlayer(), {{73, 146},{48, 134},{102, 152}}, {{68, 129}}, 10, RufusEnemy, RufusAlly) == true) then
			elseif (MoveNavyGrid(AiPlayer(), {{73, 146},{103, 53},{71, 157},{108, 58}}, {{86, 144}}, 10, RufusEnemy, RufusAlly) == true) then
			elseif (MoveNavyGrid(AiPlayer(), {{78, 153},{106, 157}}, {{101, 145}, {120, 133}}, 10, RufusEnemy, RufusAlly) == true) then
			elseif (MoveNavyGrid(AiPlayer(), {{64, 171},{81, 171},{69, 156},{44, 149}}, {{78, 153},{106, 157},{73, 146},{103, 53}}, 10, RufusEnemy, RufusAlly) == true) then
			elseif (MoveNavyGrid(AiPlayer(), {{42, 175},{66, 184},{77, 182}}, {{48, 134},{102, 152},{71, 157},{108, 58}}, 10, RufusEnemy, RufusAlly) == true) then
			elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()) == 1) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiDestroyer()) == 0)) then
				 if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiTransporter()) == 1) and (GameCycle < 3700)) then
					AiJadeite_Force_2010(0, {AiDestroyer(), 0})
					AiJadeite_Force_2010(1, {AiTransporter(), 1, AiCatapult(), 1})
					AiJadeite_Attack_2010(1)
				 else
					SetSharedVision(AiPlayer(), false, RufusAlly)
				 end
			end
		end
	end
end

function AiShane_Escape_Seawill_Forests_2015()
	local ShaneEnemy = 3
	local ShaneAlly = 4
	if (ShaneTimer == nil) then 
		ShaneTimer = 15
	elseif (ShaneTimer < 1) then 
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) == 0) then
			ShaneTimer = 50
		else
			ShaneTimer = 10
		end
	else 
		ShaneTimer = ShaneTimer - 1 
	end
	if (GameCycle < 50) then
		MoveUnitQuick(AiPlayer(), AiEliteShooter(AiPlayer()), 107, 72, 85, 82, 10, "move")
	elseif (GameCycle < 2000) then
	elseif ((GameCycle > 3900) and (GameCycle < 4000)) then
		MoveUnitQuick(AiPlayer(), AiEliteShooter(AiPlayer()), 85, 82, 107, 72, 10)
	elseif (ShaneTimer == 1) then 
		if (MoveArmyGrid(AiPlayer(), {{28, 39},{47, 43},{34, 62},{32, 34}}, {{55, 57}}, 5, ShaneEnemy, ShaneAlly) == true) then
		
		--76, 63
		elseif (MoveArmyGrid(AiPlayer(), {{124, 35},{97, 24},{94, 4}}, {{114, 8}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{39, 73},{34, 62},{8, 79},{26, 80}}, {{30, 73}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{67, 3},{67, 18},{94, 4},{89, 20}}, {{75, 8}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{85, 12},{54, 13}}, {{67, 3},{67, 18}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{40, 2},{67, 3},{67, 18},{53, 13}}, {{69, 33}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{55, 57},{32, 35},{69, 33},{53, 13}}, {{47, 43}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{74, 69},{104, 74},{97, 100},{60, 90}}, {{87, 82}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{77, 59},{55, 57},{55, 79},{85, 81}}, {{65, 67},{74, 69}}, 4, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{114, 7},{85, 13},{85, 13}}, {{94, 4},{98, 23}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{105, 57}}, {{123, 58}}, 4, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{123, 58}}, {{121, 72}}, 4, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{107, 73},{87, 79}}, {{116, 83}}, 4, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{116, 82},{102, 105}}, {{103, 97}}, 4, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{78, 111},{106, 115},{113, 97},{86, 79}}, {{102, 101}}, 8, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{2, 2},{49, 11},{37, 3}}, {{26, 3},{13, 16},{17, 7},{37, 3}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{10, 45},{13, 44},{10, 32},{28, 39}}, {{8, 55},{14, 53},{20, 54},{24, 54}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{14, 18},{23, 17},{32, 18},{26, 3}}, {{10, 45},{13, 44},{10, 32},{28, 39}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{27, 106},{72, 109},{80, 119},{19, 102}}, {{35, 114},{43, 116},{56, 119},{69, 112}}, 4, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{30, 95},{12, 100}}, {{19, 102},{27, 104},{32, 108}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{44, 96},{25, 80}}, {{30, 95}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{9, 80},{30, 73},{37, 74}}, {{25, 80}, {23, 77}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{25, 79},{8, 55}}, {{9, 80}}, 5, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{12, 100},{27, 105},{73, 109},{24, 80}}, {{1, 108},{39, 116},{30, 95},{56, 120}}, 3, ShaneEnemy, ShaneAlly) == true) then
		elseif (MoveArmyGrid(AiPlayer(), {{12, 100},{30, 95}}, {{2, 108},{26, 104},{19, 102}}, 5, ShaneEnemy, ShaneAlly) == true) then
		-- go back
		elseif (MoveArmyGrid(AiPlayer(), {{2, 108},{26, 104},{19, 102}}, {{12, 100},{30, 95}}, 5, ShaneEnemy, ShaneAlly) == true) then
		end
	end
end

function AiLucas_Escape_Shameful_Display_2015()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroSoldier()) > 0) then
		if (LucasTimer == nil) then 
			LucasTimer = 30
			AiForce(0, {AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()), AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier())})
		elseif (LucasTimer < 1) then 
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) == 0) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) == 0) then
					LucasTimer = 5
				else
					LucasTimer = 10
				end
			else
				if (GetPlayerData(4, "UnitTypesCount", AiHeroSoldier(4)) == 0) then
					LucasTimer = 7
				else
					LucasTimer = 16
				end
			end
		else 
			LucasTimer = LucasTimer - 1 
		end
		if (LucasTimer == 1) then
			if (GameCycle < 1000) then LucasSize = 3 elseif (GameCycle < 2000) then LucasSize = 4 elseif (GameCycle < 4000) then LucasSize = 5 elseif (GameCycle < 8000) then LucasSize = 6 elseif (GameCycle < 15000) then LucasSize = 10 elseif (GameCycle < 20000) then LucasSize = 20 end
			if (MoveArmySafe(AiPlayer(), 6, 55, 1, 68, 1, 2) == true) then 
			-- Move forward!
			elseif (MoveArmySafe(AiPlayer(), 23, 113, 46, 123, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 36, 35, 40, 53, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 4, 2, 41, 3, 1, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 41, 3, 35, 34, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 116, 76, 107, 100, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 105, 116, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 60, 86, 79, 84, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 83, 76, 79, 84, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 79, 84, 80, 93, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 91, 76, 80, 93, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 0, 0, 8, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 125, 1, 102, 41, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 49, 18, 53, 30, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 2, 1, 11, 25, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 119, 77, 107, 99, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 120, 61, 119, 77, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 124, 42, 120, 61, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 123, 2, 124, 42, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 11, 25, 7, 36, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 7, 36, 6, 57, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 6, 57, 20, 78, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 0, 0, 0, 0, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 0, 0, 0, 0, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 0, 0, 0, 0, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 40, 35, 35, 64, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 45, 91, 91, 77, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 84, 109, 9, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 107, 78, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 78, 116, 77, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 116, 77, 105, 64, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 105, 64, 102, 41, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 102, 41, 90, 33, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 90, 33, 75, 17, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 4, 102, 9, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 124, 44, 119, 61, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 123, 5, 104, 40, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 104, 40, 125, 43, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 33, 24, 10, 26, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 49, 16, 33, 24, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 53, 30, 36, 35, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 20, 78, 10, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 35, 64, 20, 78, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 124, 41, 116, 61, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 116, 61, 116, 76, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 91, 77, 79, 84, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 105, 62, 91, 77, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 115, 76, 119, 94, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 54, 67, 58, 79, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 67, 58, 54, 67, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 41, 54, 54, 67, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 45, 91, 62, 88, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 35, 81, 45, 91, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 39, 54, 35, 81, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 13, 69, 35, 81, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 116, 78, 91, 89, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 120, 61, 116, 71, 3, 2) == true) then 
			-- Move back!
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 80, 93, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 80, 93, 79, 110, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 79, 110, 43, 102, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 43, 102, 8, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 104, 115, 81, 108, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 44, 101, 12, 90, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 34, 35, 36, 35, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 41, 3, 49, 16, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 1, 2, 49, 16, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 8, 91, 10, 90, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 34, 64, 45, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 91, 77, 90, 90, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 61, 87, 90, 90, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 90, 90, 107, 100, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 90, 77, 105, 64, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 75, 17, 49, 20, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 10, 90, 28, 101, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 28, 101, 28, 112, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 28, 112, 17, 123, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 2, 2, 49, 18, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 13, 89, 4, 91, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 4, 91, 3, 102, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 3, 102, 17, 112, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 104, 115, 10, 90, 5, 2) == true) then
			elseif (MoveArmySafe(AiPlayer(), 6, 56, 1, 75, 5, 2) == true) then
			elseif (MoveArmySafe(AiPlayer(), 11, 90, 6, 55, 1, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 86, 92, 79, 85, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 86, 92, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 79, 84, 53, 107, LucasSize, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 91, 91, 82, 77, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 119, 94, 82, 77, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 42, 123, 17, 122, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 54, 108, 42, 123, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 83, 107, 54, 108, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 62, 88, 54, 67, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 13, 89, 35, 81, 3, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 105, 114, 83, 107, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 105, 114, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 35, 64, 34, 81, 2, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 41, 54, 35, 64, 2, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 60, 88, 11, 90, 2, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 54, 72, 60, 87, 2, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 34, 81, 60, 87, 2, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 46, 91, 34, 81, 2, 2) == true) then 
			end
		elseif ((UnitNear(4, AiHeroSoldier(4), 35, 82, 2) == true) or (UnitNear(4, AiSoldier(4), 32, 75, 2) == true) or (UnitNear(4, AiShooter(4), 35, 64, 2) == true)) then
			if (MoveArmyQuick(AiPlayer(), 35, 65, 25, 87, 25) == true) then 
			elseif (MoveArmyQuick(AiPlayer(), 35, 65, 25, 107, 25) == true) then 
			end
		elseif (UnitNear(4, AiHeroSoldier(4), 62, 87, 6)) then
			if (MoveArmyQuick(AiPlayer(), 62, 87, 25, 107, 25) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 54, 68, 62, 87, 5, 2) == true) then 
			elseif (MoveArmyQuick(AiPlayer(), 62, 87, 25, 87, 25) == true) then 
			end
		elseif ((LucasTimer > 14) and ((UnitNear(4, AiHeroSoldier(4), 35, 64, 8)) or (UnitNear(4, AiHeroSoldier(4), 32, 75, 8)) or (UnitNear(4, AiHeroSoldier(4), 61, 88, 8)) or (UnitNear(4, AiHeroSoldier(4), 56, 77, 8)))) then
			if (MoveArmySafe(AiPlayer(), 60, 88, 17, 122, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 36, 82, 20, 78, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 35, 64, 34, 81, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 41, 53, 54, 73, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 66, 59, 54, 73, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 41, 54, 35, 64, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 60, 88, 11, 90, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 54, 72, 60, 87, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 34, 81, 60, 87, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 46, 91, 34, 81, 4, 2) == true) then 
			end
		elseif ((UnitNear(4, AiHeroSoldier(4), 57, 111, 3) == true) or (UnitNear(4, AiHeroSoldier(4), 70, 114, 4) == true) or (UnitNear(4, AiHeroSoldier(4), 105, 115, 8) == true) or (UnitNear(4, AiHeroSoldier(4), 24, 24, 25) == true)) then
			if (MoveArmySafe(AiPlayer(), 42, 123, 17, 122, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 79, 84, 54, 73, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 104, 114, 11, 89, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 104, 114, 28, 102, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 54, 108, 42, 123, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 83, 107, 54, 108, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 105, 114, 83, 107, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 105, 114, 4, 2) == true) then 
			elseif (MoveArmySafe(AiPlayer(), 107, 100, 80, 88, 5, 2) == true) then 
			end
		end
	end
end

function AiKiah_Escape_Shameful_Display_2015()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroSoldier()) > 0) then
		if (MoveArmyQuick(AiPlayer(), 7, 55, 7, 7, 9) == true) then 
		--elseif (MoveArmyQuick(AiPlayer(), 105, 40, 118, 7, 9) == true) then 
		elseif ((UnitNear(0, AiHeroSoldier(0), 2, 2, 5) == true) or (UnitNear(0, AiHeroSoldier(0), 124, 2, 5) == true) or (UnitNear(4, AiHeroSoldier(4), 2, 2, 3) == true) or (UnitNear(4, AiHeroSoldier(4), 124, 2, 3) == true)) then
			if (LucasTimer == 5) then
				SetDiplomacy(2, "allied", 0)
				SetDiplomacy(0, "allied", 2)
				SetDiplomacy(2, "allied", 8)
				SetDiplomacy(8, "allied", 2)
			elseif (LucasTimer == 4) then
				AiForce(1, {AiEliteSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteSoldier()), AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()), AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()), AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult())}, true)
				AiAttackWithForce(1)
				AiAttackWithForce(0)
			elseif (LucasTimer < 4) then
				SetDiplomacy(2, "enemy", 0)
				SetDiplomacy(0, "enemy", 2)
				SetDiplomacy(2, "enemy", 8)
				SetDiplomacy(8, "enemy", 2)
				MoveArmyQuick(AiPlayer(), 113, 28, 78, 112, 3, "patrol")
			end
		elseif ((GameCycle > 5000) and (GameCycle < 5100)) then
			AiForce(0, {AiEliteSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteSoldier()), AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()), AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()), AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult())}, true)
		elseif (GameCycle < 1000) then
			-- South Left Pass
			if (GameCycle < 100) then
				MoveUnitQuick(AiPlayer(), AiSoldier(), 0, 71, 53, 55, 0)
				MoveUnitQuick(AiPlayer(), AiCatapult(), 3, 70, 56, 53, 1)
			elseif (GameCycle < 200) then
				OrderUnitSquare(AiPlayer(), AiShooter(), 53, 54, 2, 1, 0, 70)
				OrderUnitSquare(AiPlayer(), AiShooter(), 55, 54, 2, 1, 14, 70)
			elseif (GameCycle < 300) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 54, 55, 2, 1, 13, 72)
			elseif (GameCycle < 400) then
				MoveUnitQuick(AiPlayer(), AiSoldier(), 0, 70, 56, 55, 0)
			end
			-- South Middle Pass
			if (GameCycle < 100) then
				MoveUnitQuick(AiPlayer(), AiSoldier(), 51, 77, 61, 57, 0)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 58, 76, 64, 57, 0)
				MoveUnitQuick(AiPlayer(), AiCatapult(), 54, 74, 64, 55, 1)
			elseif ((GameCycle > 300) and (GameCycle < 330)) then
				OrderUnitSquare(AiPlayer(), AiShooter(), 61, 56, 2, 1, 50, 76)
				OrderUnitSquare(AiPlayer(), AiShooter(), 63, 56, 2, 1, 57, 74)
			elseif ((GameCycle > 600) and (GameCycle < 700)) then
				MoveUnitQuick(AiPlayer(), AiSoldier(), 41, 53, 60, 55, 8)
			end
			-- Middle Island Pass
			if ((GameCycle > 500) and (GameCycle < 550)) then
				OrderUnitSquare(AiPlayer(), AiShooter(), 70, 64, 4, 1, 63, 59)
				OrderUnitSquare(AiPlayer(), AiSoldier(), 77, 69, 4, 1, 102, 63)
			elseif ((GameCycle > 600) and (GameCycle < 650)) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 70, 65, 4, 1, 63, 60)
				OrderUnitSquare(AiPlayer(), AiShooter(), 77, 68, 4, 1, 102, 62)
				MoveUnitQuick(AiPlayer(), AiCatapult(), 68, 57, 74, 64, 1)
				MoveUnitQuick(AiPlayer(), AiCatapult(), 105, 61, 81, 68, 1)
			end
		else
			if ((UnitNear(0, AiHeroSoldier(0), 100, 100, 25) == true) or (UnitNear(4, AiHeroSoldier(4), 100, 100, 25) == true)) then
				if (LucasTimer == 6) then
					MoveArmyQuick(AiPlayer(), 114, 68, 105, 64, 1)
				elseif (LucasTimer == 4) then
					MoveArmyQuick(AiPlayer(), 114, 27, 100, 67, 1)
				elseif (LucasTimer == 3) then
					MoveArmyQuick(AiPlayer(), 72, 54, 99, 72, 1)
				elseif (LucasTimer == 2) then
					MoveArmyQuick(AiPlayer(), 104, 44, 102, 64, 1)
				elseif (LucasTimer == 5) then
					MoveArmyQuick(AiPlayer(), 115, 76, 103, 67, 1)
				end
			end
			if ((UnitNear(0, AiHeroSoldier(0), 119, 61, 5) == true) or (UnitNear(4, AiHeroSoldier(4), 119, 61, 5) == true)) then
				MoveArmyQuick(AiPlayer(), 119, 26, 65, 56, 5, "patrol")
			end
			if ((UnitNear(4, AiSoldier(4), 10, 26, 11) == true) or (UnitNear(4, AiHeroSoldier(4), 10, 26, 11) == true) or (UnitNear(0, AiSoldier(0), 10, 37, 11) == true) or (UnitNear(0, AiHeroSoldier(0), 10, 26, 11) == true)) then
				MoveUnitQuick(AiPlayer(), AiShooter(), 8, 21, 8, 54, 8)
				MoveUnitQuick(AiPlayer(), AiCatapult(), 9, 20, 8, 54, 8)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 10, 23, 8, 54, 8)
				MoveUnitQuick(AiPlayer(), AiHeroSoldier(), 11, 21, 8, 54, 8)
				MoveUnitQuick(AiPlayer(), AiShooter(), 8, 25, 14, 71, 3)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 11, 24, 14, 71, 3)
				MoveUnitQuick(AiPlayer(), AiShooter(), 9, 22, 1, 76, 3)
				MoveUnitQuick(AiPlayer(), AiSoldier(), 10, 21, 1, 76, 3)
				MoveUnitQuick(AiPlayer(), AiCatapult(), 9, 23, 1, 76, 3)
			elseif ((UnitNear(4, AiHeroSoldier(4), 32, 25, 8) == true) or (UnitNear(4, AiHeroSoldier(4), 50, 15, 8) == true) or (UnitNear(4, AiHeroSoldier(4), 39, 3, 3) == true) or (UnitNear(0, AiSoldier(0), 50, 15, 8) == true) or (UnitNear(0, AiHeroSoldier(0), 39, 3, 3) == true)) then
				MoveArmyQuick(AiPlayer(), 7, 55, 9, 22, 9)
				MoveArmyQuick(AiPlayer(), 48, 10, 68, 59, 9)
			elseif ((UnitNear(4, AiSoldier(4), 3, 76, 3) == true) or (UnitNear(4, AiShooter(4), 3, 76, 3) == true) or (UnitNear(0, AiSoldier(0), 17, 72, 5) == true) or (UnitNear(0, AiShooter(0), 17, 72, 5) == true)) then 
				-- Left Paths
				if ((UnitNear(4, AiSoldier(4), 3, 76, 3) == true) or (UnitNear(4, AiShooter(4), 3, 76, 3) == true) or (UnitNear(0, AiSoldier(0), 3, 76, 3) == true) or (UnitNear(0, AiShooter(0), 3, 76, 3) == true)) then 
					-- South Left 1 Path
					if ((UnitNear(AiPlayer(), AiSoldier(), 3, 69, 3) == true) or (UnitNear(AiPlayer(), AiShooter(), 3, 69, 3) == true)) then 
						MoveUnitQuick(AiPlayer(), AiShooter(), 1, 74, 14, 71, 3)
						MoveUnitQuick(AiPlayer(), AiSoldier(), 1, 76, 14, 71, 3)
					end
				elseif ((UnitNear(4, AiSoldier(4), 17, 72, 5) == true) or (UnitNear(4, AiShooter(4), 17, 72, 5) == true) or (UnitNear(0, AiSoldier(0), 17, 72, 5) == true) or (UnitNear(0, AiShooter(0), 17, 72, 5) == true)) then 
					-- South Left 2 Path
					MoveUnitQuick(AiPlayer(), AiShooter(), 14, 69, 1, 76, 3)
					MoveUnitQuick(AiPlayer(), AiCatapult(), 14, 71, 1, 76, 3)
				end
				if ((UnitNear(AiPlayer(), AiHeroSoldier(), 92, 45, 35) == true) or (UnitNear(AiPlayer(), AiHeroSoldier(), 87, 87, 35) == true)) then 
					MoveUnitQuick(AiPlayer(), AiShooter(), 8, 52, 106, 62, 3)
					MoveUnitQuick(AiPlayer(), AiCatapult(), 8, 50, 106, 62, 3)
					MoveUnitQuick(AiPlayer(), AiSoldier(), 6, 56, 106, 62, 3)
				end
				if ((UnitNear(4, AiHeroSoldier(4), 10, 76, 11) == true) and (GameCycle < 5000)) then
					MoveUnitQuick(AiPlayer(), AiShooter(), 9, 52, 66, 59, 5)
					MoveUnitQuick(AiPlayer(), AiCatapult(), 7, 50, 66, 59, 5)
					MoveUnitQuick(AiPlayer(), AiSoldier(), 6, 56, 66, 59, 5)
					MoveUnitQuick(AiPlayer(), AiHeroSoldier(), 8, 53, 66, 59, 5)
				end
			else 
				SetDiplomacy(2, "enemy", 0)
				SetDiplomacy(0, "enemy", 2)
				SetDiplomacy(2, "enemy", 8)
				SetDiplomacy(8, "enemy", 2)
			end
		end
	else
		AiForce(1, {AiEliteSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteSoldier()), AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()), AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()), AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult())}, true)
		AiAttackWithForce(1)
		AiAttackWithForce(0)
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
				OrderUnitSquare(AiPlayer(), AiShooter(), 10, 68, 1, 3, 95, 45)
				OrderUnitSquare(AiPlayer(), AiShooter(), 18, 73, 3, 1, 98, 46)
				OrderUnitSquare(AiPlayer(), AiShooter(), 24, 75, 3, 1, 103, 46)
				OrderUnitSquare(AiPlayer(), AiShooter(), 29, 75, 3, 1, 108, 46)
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
				OrderUnitSquare(AiPlayer(), AiSoldier(), 44, 95, 1, 3, 26, 62)
				OrderUnitSquare(AiPlayer(), AiSoldier(), 53, 95, 1, 3, 49, 74)
				OrderUnitSquare(AiPlayer(), AiSoldier(), 48, 97, 2, 1, 34, 62)
			elseif ((GameCycle > 400) and (GameCycle < 500)) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 48, 96, 2, 1, 61, 62)
			elseif ((GameCycle > 600) and (GameCycle < 700)) then
				OrderUnitSquare(AiPlayer(), AiSoldier(), 48, 95, 2, 1, 65, 88)
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

function AiLucas_Skirmish_Reclaiming_Genesis_2015()
	if (GameCycle < 2000) then
		AiJadeite_Worker_2010()
		if (GameCycle < 1000) then
			if (MoveUnitQuick(AiPlayer(), AiCavalry(), 116, 12, 68, 1) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiCavalry(), 113, 20, 116, 12) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiSoldier(), 82, 17, 67, 1) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiShooter(), 57, 62, 16, 58) == true) then 
			end
		elseif (GameCycle < 1500) then
			if (MoveUnitQuick(AiPlayer(), AiSoldier(), 88, 15, 63, 1) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiShooter(), 88, 11, 62, 0) == true) then 
			elseif (MoveUnitQuick(AiPlayer(), AiCavalry(), 112, 23, 61, 1) == true) then 
			end
		else
			MoveArmyQuick(AiPlayer(), 84, 15, 64, 1, 5)
			AiJadeite_Force_2010(0, AiSoldier(), 4)
		end
	else
		AiLucas_Skirmish_Standard_2015(0, 0, 5, 3)
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
DefineAi("Rufus Norcross", "*", "ai_red_2015", AiRufus_2015)
DefineAi("Lucas Kage", "*", "ai_red_2015", AiLucas_2015)
DefineAi("Kiah Stone", "*", "ai_red_2015", AiKiah_2015)
DefineAi("Nathan Withers", "*", "ai_red_2015", AiNathan_2015)