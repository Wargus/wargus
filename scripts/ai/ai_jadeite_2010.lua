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
local jadeite_cavalry = {} -- Used to identify if cavalry have been upgraded.
local jadeite_archers = {} -- Used to identify if archers have been upgraded.
local jadeite_attacker = {} -- Used to make sure the attack command isn't called too often.

function AiJadeite_Intermittent_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 5) then
		AiSet(AiWorker(), 8)
	end
	if ((jadeite_attacker[AiPlayer()] == nil) or (jadeite_attacker[AiPlayer()] < 0)) then
		jadeite_attacker[AiPlayer()] = 0
	elseif (jadeite_attacker[AiPlayer()] > 0) then
		jadeite_attacker[AiPlayer()] = jadeite_attacker[AiPlayer()] - 1
	end
	if ((GameCycle < 1000) and (jadeite_stepping[AiPlayer()] ~= 5)) then
		jadeite_stepping[AiPlayer()] = 5
	elseif (((GameCycle > 4000) and (GameCycle < 4050)) or ((GameCycle > 6000) and (GameCycle < 6050)) or ((GameCycle > 8000) and (GameCycle < 8050)) or ((GameCycle > 10000) and (GameCycle < 10050)) or ((GameCycle > 15000) and (GameCycle < 15050)) or ((GameCycle > 20000) and (GameCycle < 20050)) or ((GameCycle > 25000) and (GameCycle < 25050)) or ((GameCycle > 30000) and (GameCycle < 30050)) or ((GameCycle > 40000) and (GameCycle < 40050)) or ((GameCycle > 50000) and (GameCycle < 50050)) or ((GameCycle > 60000) and (GameCycle < 60050)) or ((GameCycle > 70000) and (GameCycle < 70050)) or ((GameCycle > 80000) and (GameCycle < 80050)) or ((GameCycle > 90000) and (GameCycle < 90050)) or ((GameCycle > 100000) and (GameCycle < 100050)) or ((GameCycle > 110000) and (GameCycle < 120050)) or ((GameCycle > 130000) and (GameCycle < 130050)) or ((GameCycle > 140000) and (GameCycle < 140050)) or ((GameCycle > 150000) and (GameCycle < 150050)) or ((GameCycle > 160000) and (GameCycle < 160050))) then
		jadeite_stepping[AiPlayer()] = SyncRand(6)
	--	AiNephrite_Attack_2013("force")
		if (jadeite_stepping[AiPlayer()] == 1) then
			jadeite_stepping[AiPlayer()] = SyncRand(6)
		end
	--	AiNephrite_Attack_2013("force")
	end
end

function AiJadeite_Reset_2010(timer)
	if (timer == nil) then
		timer = 10
	end
	jadeite_attacker[AiPlayer()] = timer
end

function AiJadeite_2010()
	-- Setting up the variables.
	AiJadeite_Set_Name_2010("Jadeite")
	if (jadeite_stepping[AiPlayer()] ~= nil) then
		if (jadeite_stepping[AiPlayer()] == 1) then
			-- Standard air attack build.
			AiJadeite_Flyer_2010()
		elseif (jadeite_stepping[AiPlayer()] == 2) then
			-- Standard footsoldier build.
			AiJadeite_Soldier_2010()
		elseif (jadeite_stepping[AiPlayer()] == 3) then
			-- Standard knight build.
			AiJadeite_Cavalry_2010()
		elseif (jadeite_stepping[AiPlayer()] == 4) then
			-- Standard archer build.
			AiJadeite_Shooter_2010()
		elseif (jadeite_stepping[AiPlayer()] == 5) then
			-- One Hall Power to Keep/Stronghold 
			AiJadeite_Power_2010()
		elseif (jadeite_stepping[AiPlayer()] == 6) then
			-- Peasant build.
			AiJadeite_Worker_2010()
		else
			jadeite_stepping[AiPlayer()] = SyncRand(5)
		end
	else
		jadeite_stepping[AiPlayer()] = SyncRand(5)
    end
end

function AiJadeite_Worker_2010()
	AiJadeite_Intermittent_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		AiSet(AiWorker(), 20)
	else
		AiSet(AiCityCenter(), 1)
	end
end

function AiJadeite_Power_2010()
	AiJadeite_Set_Name_2010("Balm")
	AiJadeite_Intermittent_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) >= 1) then
			AiSet(AiWorker(), 8)
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if (jadeite_attacker[AiPlayer()] == 0) then
					if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 5000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1000)) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) < 5) then
							AiForce(0, {AiSoldier(), 12})
							AddMessage("defend with 12 footmen")
							AiSet(AiFarm(), 8)
							AiJadeite_Reset_2010(25)
						end
					else
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) < 2) then
							AiForce(0, {AiSoldier(), 4})
							AddMessage("defend with 4 footmen")
							AiJadeite_Reset_2010(50)
						end
					end
				end
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) > 3) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) == 0)) then
					AiSet(AiBlacksmith(), 1)
					AiSet(AiWorker(), 15)
					AiSet(AiFarm(), 5)
				else
					if (jadeite_attacker[AiPlayer()] == 5) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 2) then
							AiForce(6, {AiCatapult(), 1}, true)
						end
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeArmor2())
					end
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
						AiResearch(AiUpgradeWeapon2())
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
							if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
								AiSet(AiBarracks(), 3)
							end
							if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) < 2) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) < 2)) then
								if (jadeite_cavalry[AiPlayer()] == nil) then
									AiForce(6, {AiCavalry(), 10}, true)
								else
									AiForce(6, {AiCavalryMage(), 10}, true)
								end
								AddMessage("Build 10 cav")
							else
								if (jadeite_attacker[AiPlayer()] == 0) then
									if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 6) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 6)) then
										AiForce(6, {AiCavalryMage(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage())), AiCavalry(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())), AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult())}, true)
										AiAttackWithForce(6)
										AiJadeite_Cavalry_2010()
										AddMessage("Attack with cav and catapult")
									elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 0)) then
										if (jadeite_cavalry[AiPlayer()] == nil) then
											AiForce(6, {AiCavalry(), 1}, true)
										else
											AiForce(6, {AiCavalryMage(), 1}, true)
										end
										AiAttackWithForce(6)
										AddMessage("Attack with whatever")
									end
									AiJadeite_Reset_2010(50)
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
	AiJadeite_Set_Name_2010("Kyurene")
	AiJadeite_Intermittent_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
			AiResearch(AiUpgradeMissile1())
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 4) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) >= 4)) then 
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
							AiResearch(AiUpgradeEliteShooter())
							if (jadeite_archers[AiPlayer()] == nil) then
								AiAttackWithForce(5)
								jadeite_archers[AiPlayer()] = true
								AiSet(AiBarracks(), 3)
							end
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
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) > 11) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 12)) then 
						if (jadeite_attacker[AiPlayer()] == 0) then
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 2) then
								AiJadeite_Reset_2010(25)
							else
								AiJadeite_Reset_2010(50)
							end
							AiAttackWithForce(5)
						end
					elseif (jadeite_attacker[AiPlayer()] == 0) then
						AiJadeite_Reset_2010(25)
						if (jadeite_archers[AiPlayer()] ~= nil) then
							AiForce(5, {AiEliteShooter(), 10}, true)
						else
							AiForce(5, {AiShooter(), 8}, true)
							AiSet(AiFarm(), 6)
						end
					end
				else
					if (jadeite_attacker[AiPlayer()] == 0) then
						if (jadeite_archers[AiPlayer()] ~= nil) then
							AiForce(0, {AiEliteShooter(), 4}, true)
						else
							AiForce(0, {AiShooter(), 4}, true)
						end
						AiJadeite_Reset_2010(25)
						AiSet(AiFarm(), 4)
						AiResearch(AiUpgradeMissile2())
					end
				end
			else
				AiSet(AiBarracks(), 1)
			end
		else
			AiSet(AiLumberMill(), 1)
			AiSet(AiFarm(), 2)
		end
	else
		AiSet(AiCityCenter(), 1)
	end
end

function AiJadeite_Cavalry_2010()
	AiJadeite_Set_Name_2010("Flau")
	AiJadeite_Intermittent_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 3) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 3)) then	
							AiResearch(AiUpgradeWeapon1())
							AiResearch(AiUpgradeArmor1())
							AiResearch(AiUpgradeWeapon2())
							AiResearch(AiUpgradeArmor2())
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) > 0) then
									if (jadeite_cavalry[AiPlayer()] == true) then
										if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 11) then
											AiForce(4, {AiCavalryMage(), 10}, true)
											jadeite_cavalry[AiPlayer()] = false
										end
									else
										AiResearch(AiUpgradeCavalryMage())
										if (jadeite_cavalry[AiPlayer()] == nil) then
											AiAttackWithForce(4)
											jadeite_cavalry[AiPlayer()] = true
											AiSet(AiBarracks(), 3)
											AiJadeite_Reset_2010(300)
										end
									end
									AiResearch(AiCavalryMageSpell1())
									AiResearch(AiCavalryMageSpell2())
								else
									AiSet(AiTemple(), 1)
									AiSet(AiFarm(), 7)
								end
							else
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0) then
									AiUpgradeTo(AiBestCityCenter())
									AiSet(AiBarracks(), 2)
								else
									AiSet(AiLumberMill(), 1)
								end
							end
							if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 11) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 11)) then	
								if (jadeite_attacker[AiPlayer()] == 0) then
									if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 2) then
										AiJadeite_Reset_2010(25)
									else
										AiJadeite_Reset_2010(50)
									end
									AiAttackWithForce(4)
								end
							else
								if (jadeite_attacker[AiPlayer()] == 0) then
									AiJadeite_Reset_2010(25)
									if (jadeite_cavalry[AiPlayer()] ~= nil) then
										AiForce(4, {AiCavalryMage(), 10}, true)
									else
										AiForce(4, {AiCavalry(), 8}, true)
									end
								end
							end
						else
							if (jadeite_attacker[AiPlayer()] == 0) then
								if (jadeite_cavalry[AiPlayer()] ~= nil) then
									AiForce(0, {AiCavalryMage(), 4}, true)
								else
									AiForce(0, {AiCavalry(), 4}, true)
								end
								AiJadeite_Reset_2010(25)
								AiSet(AiFarm(), 4)
							end
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
	AiJadeite_Set_Name_2010("Morga")
	AiJadeite_Intermittent_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) >= 4) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 12) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeWeapon2())
						AiResearch(AiUpgradeArmor2())
						AiSet(AiBarracks(), 3)
						AiSet(AiFarm(), 8)
					else
						AiSet(AiBlacksmith(), 1)
						AiSet(AiBarracks(), 2)
					end
					if (jadeite_attacker[AiPlayer()] == 0) then
						AiAttackWithForce(3)
						AiJadeite_Reset_2010(25)
					end
				else
					if (jadeite_attacker[AiPlayer()] == 0) then
						AiForce(3, {AiSoldier(), 10}, true)
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 2) then
							AiJadeite_Reset_2010(25)
						else
							AiJadeite_Reset_2010(50)
						end
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) < 7) then
							AiSet(AiFarm(), 6)
						end
					end
				end
			else
				if (jadeite_attacker[AiPlayer()] == 0) then
					AiForce(0, {AiSoldier(), 4}, true)
					AiJadeite_Reset_2010(25)
					AiSet(AiFarm(), 4)
				end
			end
		else
			AiSet(AiBarracks(), 1)
		end
	else
		AiSet(AiCityCenter(), 1)
	end
end

function AiJadeite_Flyer_2010()
	AiJadeite_Set_Name_2010("Iguara")
	AiJadeite_Intermittent_2010()
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) >= 1) then
		if (jadeite_attacker[AiPlayer()] == 0) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) <= 3) then
				AiSet(AiFlyer(), 12)
				AiJadeite_Reset_2010(25)
				AiSet(AiAirport(), 3)
			else
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) > 8) then
					AiForce(2, {AiFlyer(), 12}, true)
					AiAttackWithForce(2)
					AiJadeite_Reset_2010(50)
				else
					AiForce(2, {AiFlyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer())}, true)
					AiAttackWithForce(2)
					AiJadeite_Reset_2010(100)
				end
			end
		end
	else
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1)) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) then
									if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) >= 1) then
									else
										AiSet(AiAirport(), 1)
									end
								else
									AiUpgradeTo(AiBestCityCenter())
									AiSet(AiFarm(), 5)
								end
							else
								AiSet(AiBlacksmith(), 1)
								AiSet(AiFarm(), 4)
							end	
						else
							AiSet(AiLumberMill(), 1)
						end
					else
						AiSet(AiStables(), 1)
						AiSet(AiFarm(), 3)
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
			AiSet(AiFarm(), 2)
		end
	end
end

function AiJadeite_Set_Name_2010(name)
	if ((GameCycle < 100) and (GetPlayerData(AiPlayer(), "Name") == "Computer")) then
		SetPlayerData(AiPlayer(), "Name", name)
	end
end

DefineAi("ai_jadeite_2010", "*", "ai_jadeite_2010", AiJadeite_2010)
DefineAi("ai_jadeite_soldier_2010", "*", "ai_jadeite_soldier_2010", AiJadeite_Soldier_2010)
DefineAi("ai_jadeite_cavalry_2010", "*", "ai_jadeite_cavalry_2010", AiJadeite_Cavalry_2010)
DefineAi("ai_jadeite_shooter_2010", "*", "ai_jadeite_shooter_2010", AiJadeite_Shooter_2010)
DefineAi("ai_jadeite_worker_2010", "*", "ai_jadeite_worker_2010", AiJadeite_Worker_2010)
DefineAi("ai_jadeite_power_2010", "*", "ai_jadeite_power_2010", AiJadeite_Power_2010)
DefineAi("ai_jadeite_flyer_2010", "*", "ai_jadeite_flyer_2010", AiJadeite_Flyer_2010)