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
--	ai_jadeite.lua - Define the Jadeite AI series.
--
--	(c) Copyright 2010 by Kyran Jackson
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

--		This AI currently only works with humans.
-- 		Currently doesn't support ships.

local jadeite_stepping = {} -- Used to identify where the build order is up to.

function AiJadeite_2010()
	-- Setting up the variables.
	if (jadeite_stepping[AiPlayer()] ~= nil) then
		if (jadeite_stepping[AiPlayer()] == 1) then
			-- Standard air attack build.
			AiJadeite_Flyer_2010()
		end
		if (jadeite_stepping[AiPlayer()] == 2) then
			-- Standard footsoldier build.
			AiJadeite_Soldier_2010()
		end
		if (jadeite_stepping[AiPlayer()] == 3) then
			-- Standard knight build.
			AiJadeite_Cavalry_2010()
		end
		if (jadeite_stepping[AiPlayer()] == 4) then
			-- Standard archer build.
			AiJadeite_Shooter_2010()
		end
		if (jadeite_stepping[AiPlayer()] == 5) then
			-- One Hall Power to Keep/Stronghold 
			AiJadeite_Power_2010()
		end
	else
		jadeite_stepping[AiPlayer()] = SyncRand(5)
    end
end

function AiJadeite_Worker_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		AiSet(AiWorker(), 20)
	else
		AiSet(AiCityCenter(), 1)
	end
end

function AiJadeite_Power_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) >= 1) then
			AiSet(AiWorker(), 8)
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 5000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1000)) then
					AiSet(AiSoldier(), 12)	
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) >= 12) then
						AiForce(0, {AiSoldier(), 12})
					end
				else
					AiSet(AiSoldier(), 4)
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) >= 4) then
						AiForce(0, {AiSoldier(), 4})
					end
				end
				AiSet(AiWorker(), 15)
				AiSet(AiFarm(), 5)
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) > 3) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) == 0)) then
					AiSet(AiBlacksmith(), 1)
				else
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 2) then
						AiSet(AiCatapult(), 1)
					end
					AiResearch(AiUpgradeWeapon1())
					AiResearch(AiUpgradeArmor1())
					AiResearch(AiUpgradeArmor2())
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
						AiResearch(AiUpgradeWeapon2())
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
							if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
								AiSet(AiBarracks(), 3)
							end
							if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) <= 3) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) <= 3)) then
								AiSet(AiCavalry(), 10)
							else
								if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) >= 7) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) >= 7)) then
									AiForce(6, {AiCavalry(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage())), AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult())}, true)
									AiAttackWithForce(6)
								elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) >= 1)) then
									AiForce(6, {AiCavalry(), 1}, true)
									AiAttackWithForce(6)
								end
							end
						else
							AiSet(AiStables(), 1)
							AiSet(AiLumberMill(), 1)
							if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
								AiSet(AiFarm(), 6)
							end
						end
					else
						if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
							AiSet(AiBarracks(), 2)
						end
						AiUpgradeTo(AiBetterCityCenter())
					end
				end
			else
				AiSet(AiBarracks(), 1)
				if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
					AiSet(AiBlacksmith(), 1)
					AiResearch(AiUpgradeWeapon1())
					AiResearch(AiUpgradeArmor1())
					AiResearch(AiUpgradeArmor2())
				end
			end
		else
			AiSet(AiFarm(), 1)
		end
	else
		AiSet(AiCityCenter(), 1)
	end
end
		
function AiJadeite_Shooter_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 5) then
		AiSet(AiWorker(), 8)
	end
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
			AiResearch(AiUpgradeMissile1())
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 4) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 4)) then 
					AiResearch(AiUpgradeMissile2())
					AiForce(5, {AiShooter(), 8}, true)
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
							AiResearch(AiUpgradeEliteShooter())
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) then
									AiResearch(AiUpgradeEliteShooter2())
									AiResearch(AiUpgradeEliteShooter3())
								else
									AiUpgradeTo(AiBestCityCenter())
								end
							else
								AiSet(AiStables(), 1)
							end
						else
							AiUpgradeTo(AiBetterCityCenter())
						end	
					else
						AiSet(AiBlacksmith(), 1)
					end
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 8) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 8)) then 
						AiAttackWithForce(5)
					end
				else
					AiSet(AiShooter(), 4)
				end
			else
				AiSet(AiBarracks(), 1)
			end
		else
			AiSet(AiLumberMill(), 1)
		end
	else
		AiSet(AiCityCenter(), 1)
	end
end

function AiJadeite_Cavalry_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 5) then
		AiSet(AiWorker(), 8)
	end
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) >= 4) then
							AiResearch(AiUpgradeWeapon1())
							AiResearch(AiUpgradeArmor1())
							AiResearch(AiUpgradeWeapon2())
							AiResearch(AiUpgradeArmor2())
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) == 0) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
									AiUpgradeTo(AiBestCityCenter())
								else
									AiSet(AiLumberMill(), 1)
								end
							else
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) >= 8) then
									AiAttackWithForce(4)
								else
									AiForce(4, {AiCavalry(), 10}, true)
								end
								if (GetPlayerData(AiPlayer(), "UnitTypesCount",AiTemple()) >= 1) then
									AiResearch(AiUpgradeCavalryMage())
									AiResearch(AiCavalryMageSpell1())
								else
									AiSet(AiTemple(), 1)
								end
							end
						else
							--AiSet(AiSoldier(), 1)
							AiSet(AiCavalry(), 4)
						end
					else
						AiSet(AiStables(), 1)
					end
				else
					AiUpgradeTo(AiBetterCityCenter())
				end
			else
				AiSet(AiBlacksmith(), 1)
			end
		else
			AiSet(AiBarracks(), 1)
		end
	else
		AiSet(AiCityCenter(), 1)
	end
end


function AiJadeite_Soldier_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 5) then
		AiSet(AiWorker(), 8)
	end
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) >= 4) then
				AiForce(3, {AiSoldier(), 12}, true)
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) >= 8) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeWeapon2())
						AiResearch(AiUpgradeArmor2())
					else
						AiSet(AiBlacksmith(), 1)
					end
					AiAttackWithForce(3)
				end
			else
				AiSet(AiSoldier(), 4)
			end
		else
			AiSet(AiBarracks(), 1)
		end
	else
		AiSet(AiCityCenter(), 1)
	end
end

function AiJadeite_Flyer_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) >= 1) then
		AiSet(AiAirport(), 3)
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) <= 3) then
			AiSet(AiFlyer(), 10)
		else
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) >= 5) then
				AiForce(2, {AiFlyer(), 12}, true)
				AiAttackWithForce(2)
			else
				AiForce(2, {AiFlyer(), 2}, true)
				AiAttackWithForce(2)
			end
		end
	else
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) then
									AiSet(AiAirport(), 1)
								else
									AiUpgradeTo(AiBestCityCenter())
								end
							else
								AiSet(AiBlacksmith(), 1)
							end	
						else
							AiSet(AiLumberMill(), 1)
						end
					else
						AiSet(AiStables(), 1)
					end
				else
					AiUpgradeTo(AiBetterCityCenter())
				end
			else
				AiSet(AiBarracks(), 1)
			end
		else
			AiSet(AiCityCenter(), 1)
			AiSet(AiWorker(), 8)
		end
	end
end

DefineAi("ai_jadeite_2010", "*", "ai_jadeite_2010", AiJadeite_2010)
DefineAi("ai_jadeite_soldier_2010", "*", "ai_jadeite_soldier_2010", AiJadeite_Soldier_2010)
DefineAi("ai_jadeite_cavalry_2010", "*", "ai_jadeite_cavalry_2010", AiJadeite_Cavalry_2010)
DefineAi("ai_jadeite_shooter_2010", "*", "ai_jadeite_shooter_2010", AiJadeite_Shooter_2010)
DefineAi("ai_jadeite_worker_2010", "*", "ai_jadeite_worker_2010", AiJadeite_Worker_2010)
DefineAi("ai_jadeite_power_2010", "*", "ai_jadeite_power_2010", AiJadeite_Power_2010)
DefineAi("ai_jadeite_flyer_2010", "*", "ai_jadeite_flyer_2010", AiJadeite_Flyer_2010)
