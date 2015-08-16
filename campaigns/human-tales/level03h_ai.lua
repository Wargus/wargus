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
--		(c) Copyright 2012 by Kyran Jackson
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

function AiLevel03()
	if ((GetPlayerData(GetThisPlayer(), "TotalNumUnits") > 0) and (GameCycle > 300)) then
		AiSet(AiWorker(), 3)
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 20) then
			AiNephrite_Attack_2013()
		else
			if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 3) then
					AiSet(AiWorker(), 0)
					AiForce(3, {AiSoldier(), 12, AiShooter(), 6}, true)
					AiJadeite_Force_2010(3, AiSoldier(), 12, AiShooter(), 6)
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 11) then
						AiJadeite_Attack_2010(3)
						AiSet(AiWorker(), 12)
					end
				else
					AiJadeite_Force_2010(0, AiSoldier(), 4, AiShooter(), 6)
					AiSet(AiWorker(), 8)
					AiSet(AiHarbor(), 1)
				end
			else
				AiSet(AiWorker(), 6)
				AiJadeite_Build_2010(AiBarracks(), 1)
				if ((GetNumUnitsAt(AiPlayer(), AiEliteShooter(), {0, 0}, {256, 256}) >= 4) and (GameCycle < 500)) then
					OrderUnits(AiPlayer(), "unit-ranger", 2, 60, 1, 1, 27, 34, "attack")
					OrderUnits(AiPlayer(), "unit-ranger", 2, 61, 1, 1, 27, 35, "attack")
					OrderUnits(AiPlayer(), "unit-ranger", 0, 58, 1, 1, 27, 31, "attack")
					OrderUnits(AiPlayer(), "unit-ranger", 0, 62, 1, 1, 27, 32, "attack")
				end
			end
		end

	end
end

DefineAi("ai_level03", "*", "ai_level03", AiLevel03)