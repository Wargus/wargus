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
--	level03o_ai.lua 
--
--	(c) Copyright 2012 by Kyran Jackson
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
	if (GetPlayerData(GetThisPlayer(), "TotalNumUnits") > 0) then
		AiSet(AiWorker(), 3)
		AiSet(AiHarbor(), 1)
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 20) then
			AiSet(AiShooter(), 0)
			Aiset(AiSoldier(), 0)
			AiNephrite_Attack_2013()
		else
			if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 3) then
					AiSet(AiWorker(), 0)
					AiForce(3, {AiSoldier(), 12, AiShooter(), 6}, true)
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 11) then
						AiAttackWithForce(3)
						AiSet(AiWorker(), 12)
					end
				else
					AiSet(AiWorker(), 8)
					AiSet(AiSoldier(), 4)
					AiSet(AiShooter(), 6)
				end
			else
				AiSet(AiWorker(), 6)
				AiSet(AiBarracks(), 1)
				if (GetNumUnitsAt(AiPlayer(), AiEliteShooter(), {0, 0}, {256, 256}) >= 4) then
					AiForce(2, {AiShooter(), 4})
					AiAttackWithForce(2)
				end
			end
		end

	end
end

DefineAi("ai_level03", "*", "ai_level03", AiLevel03)