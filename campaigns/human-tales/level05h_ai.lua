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
--	level05o_ai.lua 
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

function AiLevel05a()
	if (GetPlayerData(4, "UnitTypesCount", "unit-stronghold") == 0) then
		if (GetNumUnitsAt(6, "unit-arthor-literios", {85, 50}, {90, 60}) >= 1) then
			ActionVictory()
		end
	else
		if (GetPlayerData(AiPlayer(), "TotalNumUnits") > 0) then
			if (GetNumUnitsAt(AiPlayer(), AiShooter(), {0, 0}, {256, 256}) >= 8) then
				AiForce(1, {AiShooter(), 8})
				AiAttackWithForce(1)
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-balloon", {0, 0}, {256, 256}) < 1) then
				CreateUnit("unit-balloon", 0, {52, 1})
				AiForce(6, {"unit-balloon", 1})
				AiAttackWithForce(6)
			end	
			if (GetNumUnitsAt(AiPlayer(), AiShooter(), {0, 0}, {256, 256}) < 1) then
				CreateUnit("unit-archer", 0, {1, 0})
				CreateUnit("unit-archer", 0, {0, 0})
				CreateUnit("unit-archer", 0, {1, 1})
				CreateUnit("unit-archer", 0, {0, 1})
				CreateUnit("unit-archer", 0, {1, 0})
				CreateUnit("unit-archer", 0, {0, 0})
				CreateUnit("unit-archer", 0, {1, 1})
				CreateUnit("unit-archer", 0, {0, 1})
				AiForce(1, {AiShooter(), 8})
				AiAttackWithForce(1)
			end
			if (GetNumUnitsAt(AiPlayer(), AiSoldier(), {0, 0}, {256, 256}) >= 36) then
				AiForce(2, {AiSoldier(), 36})
				AiAttackWithForce(2)
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-ballista", {0, 0}, {256, 256}) < 1) then	
				CreateUnit("unit-ballista", 0, {1, 1})
				CreateUnit("unit-ballista", 0, {0, 1})
				AiForce(5, {"unit-ballista", 2})
				AiAttackWithForce(5)
			end
			if (GetNumUnitsAt(AiPlayer(), AiSoldier(), {0, 0}, {256, 256}) < 1) then
				CreateUnit("unit-footman", 0, {8, 0})
				CreateUnit("unit-footman", 0, {9, 0})
				CreateUnit("unit-footman", 0, {9, 1})
				CreateUnit("unit-footman", 0, {8, 0})
				CreateUnit("unit-footman", 0, {9, 0})
				CreateUnit("unit-footman", 0, {8, 1})
				CreateUnit("unit-footman", 0, {9, 1})
				AiForce(2, {AiSoldier(), 8})
				AiAttackWithForce(2)
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-paladin", {0, 0}, {256, 256}) < 1) then
				CreateUnit("unit-paladin", 0, {9, 0})
				CreateUnit("unit-paladin", 0, {8, 0})
				AiForce(5, {"unit-paladin", 2})
				AiAttackWithForce(5)
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-human-destroyer", {0, 0}, {256, 256}) < 1) then
				CreateUnit("unit-human-destroyer", 0, {45, 0})
				CreateUnit("unit-human-destroyer", 0, {44, 0})
				CreateUnit("unit-human-destroyer", 0, {43, 1})
				CreateUnit("unit-human-destroyer", 0, {45, 1})
				CreateUnit("unit-human-destroyer", 0, {43, 0})
				CreateUnit("unit-human-destroyer", 0, {44, 1})
				AiForce(3, {"unit-human-destroyer", 6})
				AiAttackWithForce(3)
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-battleship", {0, 0}, {256, 256}) < 1) then
				CreateUnit("unit-battleship", 0, {46, 0})
				AiForce(8, {"unit-battleship", 1})
				AiAttackWithForce(8)
			end	
			if (GetNumUnitsAt(AiPlayer(), "unit-battleship", {0, 0}, {256, 256}) >= 4) then
				AiForce(4, {"unit-battleship", 4})
				AiAttackWithForce(4)
			end	
		end
	end
end

function AiLevel05c()
	if ((GetNumUnitsAt(1, "unit-grunt", {0, 0}, {38, 45}) < 1) and (GetNumUnitsAt(4, "unit-grunt", {0, 0}, {38, 15}) < 1) and (GetPlayerData(AiPlayer(), "UnitTypesCount", "unit-peasant") < 4)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", "unit-elven-lumber-mill") == 0) then
			CreateUnit("unit-elven-lumber-mill", 2, {15, 0})
		end
		CreateUnit("unit-peasant", 2, {16, 0})
		CreateUnit("unit-peasant", 2, {16, 0})
		CreateUnit("unit-peasant", 2, {16, 0})
		CreateUnit("unit-peasant", 2, {16, 0})
		--SetPlayerData(2, "Resources", "gold", (GetPlayerData(2, "TotalResources", "gold") + 1000))
		--SetPlayerData(2, "Resources", "wood", (GetPlayerData(2, "TotalResources", "wood") + 1000))
		--CreateUnit("unit-buildpoint-tower", 2, {3, 15})
		--CreateUnit("unit-buildpoint-tower", 2, {5, 15})
		--CreateUnit("unit-buildpoint-tower", 2, {7, 15})
		--CreateUnit("unit-buildpoint-tower", 2, {31, 5})
		--CreateUnit("unit-buildpoint-tower", 2, {28, 12})
		--AiSet("unit-human-watch-tower", 5)
	else
		AiNephrite_Level5()
		SetPlayerData(2, "Resources", "gold", 5000)
		--if (GetNumUnitsAt(2, "unit-peasant", {2, 44}, {96, 96}) == 0) then
		ChangeUnitsOwner({0, 45}, {96, 96}, 2, 6)
		KillUnit("unit-peasant", 6);
		--elseif (GetNumUnitsAt(2, "unit-peasant", {59, 0}, {96, 96}) == 0) then
		--	ChangeUnitsOwner({60, 0}, {96, 96}, 2, 6)
		--end
	end
end

function AiLevel05()
	if (AiPlayer() == 0) then
		AiLevel05a()
	else
		AiLevel05c()
	end
end

DefineAi("ai_level05", "*", "ai_level05", AiLevel05)