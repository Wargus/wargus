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
--	ai_zoisite_2013.lua - Define the Jadeite AI series.
--
--	(c) Copyright 2013 by Kyran Jackson
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

-- THIS IS CRASHING STILL, must be Cav one...
function AiZoisite_2013()
	if ((GameCycle >= 100000) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1)) then
		AiNephrite_2013()
	else
		if ((GameCycle >= 500) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1)) then
			AiJadeite_Cavalry_2010()
		end
		if ((GetPlayerData(AiPlayer(), "Resources", "gold") < 2500) and (GetPlayerData(AiPlayer(), "Resources", "wood") < 1500) and (GameCycle < 1000)) then
			AiNephrite_Flush_2013()
			AiJadeite_Soldier_2010()
		else
			AiJadeite_Power_2010()
		end
		if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 800000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 400000)) then
			if (GameCycle > 8000) then
				AiNephrite_Expand_2013()
				if (GameCycle > 10000) then
					AiNephrite_Research_2013()
				end
			end
		end
	end
	if (GameCycle < 200) then
		SetPlayerData(AiPlayer(), "Name", "Zoisite")
	end
end

DefineAi("ai_zoisite_2013", "*", "wc2-skirmish", AiZoisite_2013)