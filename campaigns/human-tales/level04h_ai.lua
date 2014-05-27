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
--	level04o_ai.lua 
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

function AiLevel04()
	if (GetPlayerData(GetThisPlayer(), "TotalNumUnits") > 0) then
		if (GetNumUnitsAt(AiPlayer(), "unit-human-shipyard", {0, 0}, {64, 64}) > 0) then
			if ((GetNumUnitsAt(AiPlayer(), "unit-human-guard-tower", {0, 0}, {64, 64}) > 2) or (GetNumUnitsAt(AiPlayer(), "unit-human-watch-tower", {0, 0}, {64, 64}) > 0)) then
				if (GetNumUnitsAt(AiPlayer(), "unit-human-destroyer", {0, 0}, {64, 64}) > 1) then
					-- AiForce(1, {AiSubmarine(), 0, AiDestroyer(), 4, AiBattleship(), 0, AiScout(), 0})
					-- if (GetNumUnitsAt(AiPlayer(), "unit-battleship", {0, 0}, {64, 64}) > 0) then
						-- AiAttackWithForce(1)
						-- AiSet(AiPlatform(), 2)
					-- end
					-- AiAttackWithForce(1)
					if (GetNumUnitsAt(AiPlayer(), "unit-human-destroyer", {0, 0}, {64, 64}) > 1) then
						AiSet(AiDestroyer(), 4)
					end
				else
					-- AiSet(AiHarbor(), 2)
					AiSet(AiDestroyer(), 2)
					AiSet(AiTanker(), 2)
					AiSet(AiPlatform(), 1)
				end
			else
				AiNeed(AiTower())
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-human-watch-tower", {0, 0}, {64, 64}) > 0) then
				AiUpgradeTo(AiGuardTower())
			end
		else
			if (GetNumUnitsAt(AiPlayer(), "unit-elven-lumber-mill", {0, 0}, {64, 64}) > 0) then
				AiSet(AiHarbor(), 1)
			else
				AiSet(AiLumberMill(), 1)
			end
		end
	end
end

DefineAi("ai_level04", "*", "ai_level04", AiLevel04)

function AiLevel04sea()
	if (GetPlayerData(GetThisPlayer(), "TotalNumUnits") > 0) then
		if (GetNumUnitsAt(AiPlayer(), "unit-orc-shipyard", {0, 0}, {64, 64}) > 0) then
			--AiForce(3, {AiDestroyer(), 4})
			--AiForceRole(3, "defend")
			AiSet(AiDestroyer(), 3)
			AiSet(AiWorker(), 5)
			if (GetNumUnitsAt(AiPlayer(), "unit-orc-foundry", {0, 0}, {64, 64}) > 0) then
				if (GetNumUnitsAt(AiPlayer(), "unit-orc-transport", {0, 0}, {64, 64}) > 0) then
					if (GetNumUnitsAt(AiPlayer(), "unit-grunt", {0, 0}, {64, 64}) < 5) then
						AiSet(AiSoldier(), 10)
					else
						AiSet(AiShooter(), 10)
					end
				else
					AiSet(AiTransporter(), 1)
				end
				--if (GetNumUnitsAt(AiPlayer(), "unit-orc-watch-tower", {0, 0}, {64, 64}) > 0) then
				--	AiUpgradeTo(AiGuardTower())
				--end
				if (GetNumUnitsAt(AiPlayer(), "unit-orc-oil-platform", {0, 0}, {64, 64}) > 0) then
					if (GetNumUnitsAt(AiPlayer(), "unit-orc-destroyer", {0, 0}, {64, 64}) < 2) then
						--AiForce(1, {AiDestroyer(), 4})
					else
						--AiAttackWithForce(1)
					end
				else
					AiSet(AiTanker(), 1)
					AiNeed(AiPlatform())
				end
			else
				AiSet(AiFoundry(), 1)
			end
		else
			if (GetNumUnitsAt(AiPlayer(), "unit-troll-lumber-mill", {0, 0}, {64, 64}) > 0) then
				AiSet(AiHarbor(), 1)
			else
				AiSet(AiLumberMill(), 1)
			end
		end
	end
end

DefineAi("ai_level04sea", "*", "ai_level04sea", AiLevel04sea)

function AiLevel04land()
	if (GetNumUnitsAt(AiPlayer(), "unit-great-hall", {0, 0}, {256, 256}) >= 1) then
		if (GetNumUnitsAt(AiPlayer(), "unit-orc-barracks", {0, 0}, {256, 256}) >= 1) then
			if (GetNumUnitsAt(AiPlayer(), "unit-grunt", {0, 0}, {256, 256}) >= 4) then
				if (GetNumUnitsAt(AiPlayer(), "unit-grunt", {0, 0}, {256, 256}) >= 12) then
					AiForce(3, {AiSoldier(), 12}, true)
					AiAttackWithForce(3)
				else
					AiSet(AiSoldier(), 14)
				end
				if (GetNumUnitsAt(AiPlayer(), "unit-grunt", {0, 0}, {256, 256}) >= 8) then
					if (GetNumUnitsAt(AiPlayer(), "unit-orc-blacksmith", {0, 0}, {256, 256}) >= 1) then
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeWeapon2())
						AiResearch(AiUpgradeArmor2())
					else
						AiSet(AiBlacksmith(), 1)
					end
				end
			else
				AiSet(AiSoldier(), 4)
			end
		else
			AiSet(AiBarracks(), 1)
		end
	else
		AiSet(AiCityCenter(), 1)
		AiSet(AiWorker(), 8)
	end
end

DefineAi("ai_level04land", "*", "ai_level04land", AiLevel04land)