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

function AiJadeite_Upgrade_2010(unit)
	if ((unit == AiCavalry()) and (jadeite_cavalry[AiPlayer()] == nil)) then
		AiResearch(AiUpgradeCavalryMage())
		AiJadeite_Attack_2010(4)
		AiJadeite_Reset_2010(300)
		jadeite_cavalry[AiPlayer()] = true
	end
	if ((unit == AiShooter()) and (jadeite_archers[AiPlayer()] == nil)) then
		AiResearch(AiUpgradeEliteShooter())
		AiJadeite_Attack_2010(5)
		AiJadeite_Reset_2010(300)
		jadeite_archers[AiPlayer()] = true
	end
end

function AiJadeite_Attack_2010(force)
	if (jadeite_attacker[AiPlayer()] == 0) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 2) then
			AiJadeite_Reset_2010(25)
		else
			AiJadeite_Reset_2010(50)
		end
		AiAttackWithForce(force)
	end
end

function AiJadeite_Force_2010(force, unit1, quantity1, unit2, quantity2, unit3, quantity3)
	if (jadeite_attacker[AiPlayer()] == 0) then
		if (((unit1 == AiSoldier()) or (unit2 == AiSoldier()) or (unit3 == AiSoldier())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 0)) then AiJadeite_Build_2010(AiBarracks()) end
		if (((unit1 == AiCavalry()) or (unit2 == AiCavalry()) or (unit3 == AiCavalry())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) == 0)) then AiJadeite_Build_2010(AiStables()) end
		if (((unit1 == AiCavalryMage()) or (unit2 == AiCavalryMage()) or (unit3 == AiCavalryMage())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) == 0)) then AiJadeite_Build_2010(AiTemple()) end
		if (((unit1 == AiShooter()) or (unit2 == AiShooter()) or (unit3 == AiShooter())) and ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) == 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 0))) then AiJadeite_Build_2010(AiLumberMill(), 1, false, AiBarracks()) end
		if (((unit1 == AiEliteShooter()) or (unit2 == AiEliteShooter()) or (unit3 == AiEliteShooter())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) == 0)) then AiJadeite_Build_2010(AiBestCityCenter()) end
		if (quantity1 == nil) then quantity1 = 1 end
		if (quantity2 == nil) then quantity2 = 1 end
		if (quantity3 == nil) then quantity3 = 1 end
		if (jadeite_cavalry[AiPlayer()] ~= nil) then
			if (unit1 == AiCavalry()) then unit1 = AiCavalryMage() end
			if (unit2 == AiCavalry()) then unit2 = AiCavalryMage() end
			if (unit3 == AiCavalry()) then unit3 = AiCavalryMage() end
			if (unit1 == AiShooter()) then unit1 = AiEliteShooter() end
			if (unit2 == AiShooter()) then unit2 = AiEliteShooter() end
			if (unit3 == AiShooter()) then unit3 = AiEliteShooter() end
		else
			if (unit1 == AiCavalryMage()) then unit1 = AiCavalry() end
			if (unit2 == AiCavalryMage()) then unit2 = AiCavalry() end
			if (unit3 == AiCavalryMage()) then unit3 = AiCavalry() end
			if (unit1 == AiEliteShooter()) then unit1 = AiShooter() end
			if (unit2 == AiEliteShooter()) then unit2 = AiShooter() end
			if (unit3 == AiEliteShooter()) then unit3 = AiShooter() end
		end		
		if (unit2 == nil) then
			AiForce(force, {unit1, quantity1})
		elseif (unit3 == nil) then
			AiForce(force, {unit1, quantity1, unit2, quantity2})
		else
			AiForce(force, {unit1, quantity1, unit2, quantity2, unit3, quantity3})
		end
		AiJadeite_Reset_2010(1)
	end
end

function AiJadeite_Build_2010(unit, quantity, force, unit2)
	if (quantity == nil) then quantity = 1 end
	if (force ~= true) then
		if (unit == AiCityCenter()) then
			force = true
		else 
			if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0)) then
				if (((unit == AiFarm()) or  unit == AiBarracks()) or (unit == AiLumberMill()) or (unit == AiBlacksmith())) then
					force = true
				else
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) or ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) and (unit ~= AiBetterCityCenter()))) then
							if ((unit == AiStables()) or (unit == AiScientific())) then
								force = true
							else
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
									if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0)) then
										if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) and (unit ~= AiBestCityCenter())) then
											force = true
										else
											AiUpgradeTo(AiBestCityCenter())
										end
									else
										AiSet(AiBlacksmith(), 1)
										AiSet(AiLumberMill(), 1)
									end
								
								else
									if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) < 2) then
										AiSet(AiFarm(), 2)
									else
										AiSet(AiStables(), 1)
									end
								end
							end
						else
							AiUpgradeTo(AiBetterCityCenter())
						end
					else
						AiSet(AiBarracks(), 1)
					end
				end
			else
				AiSet(AiCityCenter(), 1)
			end
		end
	end
	if (force == true) then
		AiSet(unit, quantity)
		if (unit2 ~= nil) then AiSet(unit2, 1) end
	end
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
		if (GameCycle > 5000) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 20) then
				AiSet(AiWorker(), 20)
				AiJadeite_Build_2010(AiFarm(), 5)
			end
		else
			AiSet(AiWorker(), 5)
		end
	else
		AiJadeite_Build_2010(AiCityCenter(), 1)
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
							AiJadeite_Build_2010(AiFarm(), 8)
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
					AiJadeite_Build_2010(AiBlacksmith(), 1)
					AiSet(AiWorker(), 15)
					AiJadeite_Build_2010(AiFarm(), 5)
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
								AiJadeite_Build_2010(AiBarracks(), 3)
							end
							if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) < 2) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) < 2)) then
								if (jadeite_cavalry[AiPlayer()] == nil) then
									AiForce(6, {AiCavalry(), 10}, true)
								else
									AiForce(6, {AiCavalryMage(), 10}, true)
								end
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
							AiJadeite_Build_2010(AiStables(), 1)
							AiJadeite_Build_2010(AiLumberMill(), 1)
							if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
								AiJadeite_Build_2010(AiFarm(), 6)
							end
						end
					else
						if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
							AiJadeite_Build_2010(AiBarracks(), 2)
						end
						AiUpgradeTo(AiBetterCityCenter())
					end
				end
			else
				AiJadeite_Build_2010(AiBarracks(), 1)
				if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
					AiJadeite_Build_2010(AiBlacksmith(), 1)
					AiResearch(AiUpgradeWeapon1())
					AiResearch(AiUpgradeArmor1())
					AiResearch(AiUpgradeArmor2())
				end
			end
		else
			AiJadeite_Build_2010(AiFarm(), 1)
		end
	else
		AiJadeite_Build_2010(AiCityCenter(), 1)
	end
end
		
function AiJadeite_Shooter_2010()
	AiJadeite_Set_Name_2010("Ranger Attack Ai")
	AiJadeite_Intermittent_2010()
	--[[
	jadeite_attacker[AiPlayer()] = 0
	AiJadeite_Build_2010(AiBetterCityCenter())
	--AiJadeite_Force_2010(5, AiCavalry(), 10)
	]]
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
			AiResearch(AiUpgradeMissile1())
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
						AiJadeite_Upgrade_2010(AiShooter())
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) then
								AiResearch(AiUpgradeEliteShooter2())
								AiResearch(AiUpgradeEliteShooter3())
							else
								AiUpgradeTo(AiBestCityCenter())
							end
						else
							AiJadeite_Build_2010(AiStables(), 1)
						end
					else
						AiUpgradeTo(AiBetterCityCenter())
					end	
				else
					AiJadeite_Build_2010(AiBlacksmith(), 1)
				end
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 6) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) >= 6)) then 
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) > 11) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 15)) then 
						AiJadeite_Attack_2010(5)
					elseif (jadeite_attacker[AiPlayer()] == 0) then
						AiJadeite_Reset_2010(25)
						if (jadeite_archers[AiPlayer()] ~= nil) then
							AiForce(5, {AiEliteShooter(), 10}, true)
						else
							AiForce(5, {AiShooter(), 6}, true)
							AiJadeite_Build_2010(AiFarm(), 5)
						end
					end
				else
					if (jadeite_attacker[AiPlayer()] == 0) then
						if (jadeite_archers[AiPlayer()] ~= nil) then
							AiForce(0, {AiEliteShooter(), 6}, true)
						else
							AiForce(0, {AiShooter(), 6}, true)
						end
						AiJadeite_Reset_2010(2525)
						AiJadeite_Build_2010(AiFarm(), 4)
						AiResearch(AiUpgradeMissile2())
					end
				end
			else
				AiJadeite_Build_2010(AiBarracks(), 1)
			end
		else
			AiJadeite_Build_2010(AiBarracks(), 1)
			AiJadeite_Build_2010(AiLumberMill(), 1)
			AiJadeite_Build_2010(AiFarm(), 2)
		end
	else
		AiJadeite_Build_2010(AiCityCenter(), 1)
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
						if ((GameCycle > 10000) or ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 3) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 3))) then	
							AiResearch(AiUpgradeWeapon1())
							AiResearch(AiUpgradeArmor1())
							AiResearch(AiUpgradeWeapon2())
							AiResearch(AiUpgradeArmor2())
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) > 0) then
									AiJadeite_Upgrade_2010(AiCavalry())
									AiResearch(AiCavalryMageSpell1())
									AiResearch(AiCavalryMageSpell2())
								else
									AiJadeite_Build_2010(AiTemple(), 1)
									AiJadeite_Build_2010(AiFarm(), 7)
								end
							else
								AiJadeite_Build_2010(AiBestCityCenter())
							end
							if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 11) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 11)) then	
								AiJadeite_Attack_2010(4)
							else
								AiJadeite_Force_2010(4, AiCavalry(), 12)
							end
						else
							AiJadeite_Force_2010(0, AiCavalry(), 4)
							AiJadeite_Build_2010(AiFarm(), 4)
						end
					else
						AiJadeite_Build_2010(AiStables(), 1)
					end
				else
					AiUpgradeTo(AiBetterCityCenter())
				end
			else
				AiJadeite_Build_2010(AiBlacksmith(), 1)
			end
		else
			AiJadeite_Build_2010(AiBarracks(), 1)
		end
	else
		AiJadeite_Build_2010(AiCityCenter(), 1)
	end
end

function AiJadeite_Soldier_2010()
	AiJadeite_Set_Name_2010("Morga")
	AiJadeite_Intermittent_2010()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 3) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 12) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeWeapon2())
						AiResearch(AiUpgradeArmor2())
						AiJadeite_Build_2010(AiBarracks(), 3)
						AiJadeite_Build_2010(AiFarm(), 8)
					else
						AiJadeite_Build_2010(AiBlacksmith(), 1)
						AiJadeite_Build_2010(AiBarracks(), 2)
					end
					AiJadeite_Attack_2010(3)
				else	
					AiJadeite_Force_2010(3, AiSoldier(), 10)
					AiJadeite_Build_2010(AiFarm(), 6)
				end
			else
				AiJadeite_Force_2010(0, AiSoldier(), 4)
				AiJadeite_Build_2010(AiFarm(), 4)
			end
		else
			AiJadeite_Build_2010(AiBarracks(), 1)
		end
	else
		AiJadeite_Build_2010(AiCityCenter(), 1)
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
				AiJadeite_Build_2010(AiAirport(), 3)
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
										AiJadeite_Build_2010(AiAirport(), 1)
									end
								else
									AiUpgradeTo(AiBestCityCenter())
									AiJadeite_Build_2010(AiFarm(), 5)
								end
							else
								AiJadeite_Build_2010(AiBlacksmith(), 1)
								AiJadeite_Build_2010(AiFarm(), 4)
							end	
						else
							AiJadeite_Build_2010(AiLumberMill(), 1)
						end
					else
						AiJadeite_Build_2010(AiStables(), 1)
						AiJadeite_Build_2010(AiFarm(), 3)
					end
				else
					AiUpgradeTo(AiBetterCityCenter())
				end
			else
				AiJadeite_Build_2010(AiBarracks(), 1)
			end
		else
			AiJadeite_Build_2010(AiCityCenter(), 1)
			AiSet(AiWorker(), 8)
			AiJadeite_Build_2010(AiFarm(), 2)
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