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
	if (((GameCycle > 44000) and (GameCycle < 44010)) or ((GameCycle > 46000) and (GameCycle < 46010)) or ((GameCycle > 56000) and (GameCycle < 56010)) or ((GameCycle > 53000) and (GameCycle < 53010)) or ((GameCycle > 61000) and (GameCycle < 61010)) or ((GameCycle > 82000) and (GameCycle < 82010)) or ((GameCycle > 47000) and (GameCycle < 47010)) or ((GameCycle > 49000) and (GameCycle < 49010)) or ((GameCycle > 33000) and (GameCycle < 33010)) or ((GameCycle > 35000) and (GameCycle < 35010)) or ((GameCycle > 45000) and (GameCycle < 45010)) or ((GameCycle > 58000) and (GameCycle < 58010)) or ((GameCycle > 42000) and (GameCycle < 42010)) or ((GameCycle > 39000) and (GameCycle < 39010)) or ((GameCycle > 99000) and (GameCycle < 99010)) or ((GameCycle > 86000) and (GameCycle < 86010)) or ((GameCycle > 71000) and (GameCycle < 71010)) or ((GameCycle > 74000) and (GameCycle < 74010)) or ((GameCycle > 79000) and (GameCycle < 79010)) or ((GameCycle > 83500) and (GameCycle < 83510)) or ((GameCycle > 96000) and (GameCycle < 96010)) or ((GameCycle > 1110000) and (GameCycle < 1110010)) or ((GameCycle > 120000) and (GameCycle < 120010)) or ((GameCycle > 13000) and (GameCycle < 13010)) or ((GameCycle > 15000) and (GameCycle < 15010)) or ((GameCycle > 18000) and (GameCycle < 18010)) or ((GameCycle > 20000) and (GameCycle < 20010)) or ((GameCycle > 21000) and (GameCycle < 21010)) or ((GameCycle > 23000) and (GameCycle < 23010)) or ((GameCycle > 25000) and (GameCycle < 25010)) or ((GameCycle > 28000) and (GameCycle < 28010)) or ((GameCycle > 32000) and (GameCycle < 32010)) or ((GameCycle > 36000) and (GameCycle < 36010)) or ((GameCycle > 40000) and (GameCycle < 40010)) or ((GameCycle > 50000) and (GameCycle < 50010)) or ((GameCycle > 55000) and (GameCycle < 55010)) or ((GameCycle > 58000) and (GameCycle < 58010)) or ((GameCycle > 60000) and (GameCycle < 60010)) or ((GameCycle > 65000) and (GameCycle < 65010)) or ((GameCycle > 70000) and (GameCycle < 70010)) or ((GameCycle > 75000) and (GameCycle < 75010)) or ((GameCycle > 78000) and (GameCycle < 78010)) or ((GameCycle > 82000) and (GameCycle < 82010)) or ((GameCycle > 86000) and (GameCycle < 86010))or ((GameCycle > 90000) and (GameCycle < 90010)) or ((GameCycle > 100000) and (GameCycle < 100010))) then
		KillUnitAt("all", 0, 50, {0, 0}, {15, 5});
	end
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
	if ((GetNumUnitsAt(6, "all", {0, 0}, {256, 256}) < 11) and (GetNumUnitsAt(1, "unit-grunt", {0, 0}, {38, 45}) < 1) and (GetNumUnitsAt(4, "unit-grunt", {0, 0}, {38, 15}) < 1) and (GetPlayerData(AiPlayer(), "UnitTypesCount", "unit-peasant") < 4)) then
		--if (GetPlayerData(AiPlayer(), "UnitTypesCount", "unit-elven-lumber-mill") == 0) then
		--	CreateUnit("unit-elven-lumber-mill", 2, {15, 0})
		--end
		CreateUnit(AiWorker(), 2, {16, 0})
		CreateUnit(AiWorker(), 2, {0, 0})
		CreateUnit(AiWorker(), 2, {0, 0})
		CreateUnit(AiWorker(), 2, {0, 0})
		CreateUnit(AiWorker(), 2, {0, 0})
		CreateUnit(AiWorker(), 2, {0, 0})
		SetPlayerData(2, "Resources", "gold", (GetPlayerData(2, "TotalResources", "gold") + 1000))
		--SetPlayerData(2, "Resources", "wood", (GetPlayerData(2, "TotalResources", "wood") + 1000))
		--CreateUnit("unit-buildpoint-tower", 2, {3, 15})
		--CreateUnit("unit-buildpoint-tower", 2, {5, 15})
		--CreateUnit("unit-buildpoint-tower", 2, {7, 15})
		--CreateUnit("unit-buildpoint-tower", 2, {31, 5})
		--CreateUnit("unit-buildpoint-tower", 2, {28, 12})
		--AiSet("unit-human-watch-tower", 5)
		AiNephrite_Level5()
	else
		if ((GetNumUnitsAt(2, "unit-peasant", {0, 90}, {6, 96}) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) == 0) then
				--if (GetNumUnitsAt(2, AiWorker(), {0, 0}, {30, 30}) >= 1) then
				--	KillUnitAt(AiWorker(), 2, 1, {0, 0}, {30, 30})
				--end
				AiNephrite_Flush_2013()
				AiSet(AiCityCenter(), 1)
				SetPlayerData(2, "Resources", "gold", 6000)
				SetPlayerData(2, "Resources", "gold", 6000)
			else
				AiZoisite_2013()
				if (GetNumUnitsAt(2, AiBarracks(), {0, 0}, {30, 30}) >= 1) then
					KillUnitAt(AiBarracks(), 2, 1, {0, 0}, {30, 30})
					AiNephrite_Attack_2013()
				end
				if (GetNumUnitsAt(2, AiLumberMill(), {0, 0}, {30, 30}) >= 1) then
					KillUnitAt(AiLumberMill(), 2, 1, {0, 0}, {30, 30})
					SetPlayerData(2, "Resources", "gold", 1500)
					SetPlayerData(2, "Resources", "gold", 1500)
				end
				if (GetNumUnitsAt(2, AiSoldier(), {0, 70}, {40, 96}) >= 8) then
					AiNephrite_Attack_2013()
				end
			end
			if (GetNumUnitsAt(2, "unit-peasant", {50, 55}, {96, 96}) >= 1) then
			else
				ChangeUnitsOwner({55, 55}, {96, 96}, 2, 6)
			end
		else
			if (GetNumUnitsAt(6, "all", {0, 0}, {256, 256}) < 11) then
				SetPlayerData(2, "Resources", "gold", 1200)
				AiNephrite_Level5()
			end
			if (GetNumUnitsAt(2, "unit-peasant", {0, 35}, {55, 55}) >= 1) then
			else
				ChangeUnitsOwner({0, 45}, {50, 50}, 2, 6)
			end
		end
		KillUnit("unit-peasant", 6)
	end
end

function AiLevel05()
	if (nephrite_attackforce ~= nil) then
		nephrite_attackforce = 5
	end
	if (AiPlayer() == 0) then
		AiLevel05a()
	else
		if (GameCycle > 100000) then
			AiZoisite_2013()
		else
			AiLevel05c()
		end
	end
end

DefineAi("ai_level05", "*", "ai_level05", AiLevel05)