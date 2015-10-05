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

local jadeite_stepping = {} -- Used to identify where the build order is up to.
local jadeite_cavalry = {} -- Used to identify if cavalry have been upgraded.
local jadeite_archers = {} -- Used to identify if archers have been upgraded.
local jadeite_attacker = {} -- Used to make sure the attack command isn't called too often.
local jadeite_builder = {} -- Used to make sure the build command isn't called too often.

function AiJadeite_Variable_2010(variable, value)
	if (value == nil) then value = true end
	if (variable == "archers") then
		jadeite_archers[AiPlayer()] = value
	elseif (variable == "cavalry") then
		jadeite_cavalry[AiPlayer()] = value
	end
end

function AiJadeite_Ticker_2010(timer)
	if (timer ~= nil) then
		jadeite_builder[AiPlayer()] = timer
	end
	if ((jadeite_attacker[AiPlayer()] == nil) or (jadeite_attacker[AiPlayer()] < 0)) then
		AiJadeite_Reset_2010(0)
	elseif (jadeite_attacker[AiPlayer()] > 0) then
		AiJadeite_Reset_2010(jadeite_attacker[AiPlayer()] - 1)
	end
	if ((jadeite_builder[AiPlayer()] == nil) or (jadeite_builder[AiPlayer()] < 0)) then
		AiJadeite_Ticker_2010(0)
	elseif (jadeite_builder[AiPlayer()] > 0) then
		AiJadeite_Ticker_2010(jadeite_builder[AiPlayer()] - 1)
	end
end

function AiJadeite_Reset_2010(timer)
	if (timer == nil) then
		timer = 10
	end
	jadeite_attacker[AiPlayer()] = timer
end

function AiJadeite_Intermittent_2010(cycle)
	if (cycle == nil) then cycle = 0 end
	if (cycle >= 0) then AiJadeite_Ticker_2010() end
	if (GameDefinition["Map"]["Type"] == "Coastal") then
		if (GameCycle > cycle + 10000) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiHarbor()) == 0) then
				AiJadeite_Build_2010(AiHarbor())
			end
		elseif (GameCycle > cycle + 15000) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFoundry()) == 0) then
				AiJadeite_Build_2010(AiFoundry())
			end
		end
	elseif ((GameDefinition["Map"]["Type"] == "Islands") or (GameDefinition["Map"]["Type"] == "Island")) then
		if (GameCycle > cycle + 5000) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiHarbor()) == 0) then
				AiJadeite_Build_2010(AiHarbor())
			end
		elseif (GameCycle > cycle + 10000) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFoundry()) == 0) then
				AiJadeite_Build_2010(AiFoundry())
				AiJadeite_Build_2010(AiHarbor(), 2)
			end
		end
	end
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 5) and ((GameCycle > cycle + 500) and (GameCycle < cycle + 5000))) then
		AiSet(AiWorker(), 8)
		if (GameCycle > cycle + 4500) then
			AiSet(AiFarm(), 8)
		end
		
	elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 10) and ((GameCycle > cycle + 5000) and (GameCycle < cycle + 6000)) and (GetPlayerData(AiPlayer(), "Resources", "gold") > cycle + 2000)) then
		AiSet(AiWorker(), 12)
	elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 15) and ((GameCycle > cycle + 10000) and (GameCycle < cycle + 11000))) then
		AiSet(AiWorker(), 20)
	end
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiTanker()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiPlatform()) == 0)) then
		AiJadeite_Build_2010(AiPlatform(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiTanker()))
		AiJadeite_Build_2010(AiRefinery())
	end
	if ((GameCycle < cycle + 1000) and (jadeite_stepping[AiPlayer()] ~= 5)) then
		jadeite_stepping[AiPlayer()] = 5
	elseif (((GameCycle > cycle + 4000) and (GameCycle < cycle + 4050)) or ((GameCycle > cycle + 6000) and (GameCycle < cycle + 6050)) or ((GameCycle > cycle + 8000) and (GameCycle < cycle + 8050)) or ((GameCycle > cycle + 10000) and (GameCycle < cycle + 10050)) or ((GameCycle > cycle + 15000) and (GameCycle < cycle + 15050)) or ((GameCycle > cycle + 20000) and (GameCycle < cycle + 20050)) or ((GameCycle > cycle + 25000) and (GameCycle < cycle + 25050)) or ((GameCycle > cycle + 30000) and (GameCycle < 30050)) or ((GameCycle > cycle + 40000) and (GameCycle < 40050)) or ((GameCycle > cycle + 50000) and (GameCycle < 50050)) or ((GameCycle > cycle + 60000) and (GameCycle < 60050)) or ((GameCycle > cycle + 70000) and (GameCycle < 70050)) or ((GameCycle > cycle + 80000) and (GameCycle < 80050)) or ((GameCycle > cycle + 90000) and (GameCycle < 90050)) or ((GameCycle > cycle + 100000) and (GameCycle < 100050)) or ((GameCycle > cycle + 110000) and (GameCycle < 120050)) or ((GameCycle > cycle + 130000) and (GameCycle < 130050)) or ((GameCycle > cycle + 140000) and (GameCycle < 140050)) or ((GameCycle > cycle + 150000) and (GameCycle < 150050)) or ((GameCycle > cycle + 160000) and (GameCycle < 160050))) then
		jadeite_stepping[AiPlayer()] = SyncRand(6)
	--	AiNephrite_Attack_2013("force")
		if (jadeite_stepping[AiPlayer()] == 1) then
			jadeite_stepping[AiPlayer()] = SyncRand(6)
		end
	--	AiNephrite_Attack_2013("force")
	end
end

function AiJadeite_Upgrade_2010(unit, number)
	if (number == nil) then number = 0 else number = number - 1 end
	if ((unit == AiEliteShooter()) and (jadeite_archers[AiPlayer()] == nil)) then unit = AiShooter() end
	if ((unit == AiCavalryMage()) and (jadeite_cavalry[AiPlayer()] == nil)) then unit = AiCavalry() end
	if ((unit == AiUpgradeCavalryMage()) and (jadeite_cavalry[AiPlayer()] == nil)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) > 0) then
			AiResearch(AiUpgradeCavalryMage())
			AiJadeite_Attack_2010(4)
			AiJadeite_Ticker_2010(10)
			jadeite_cavalry[AiPlayer()] = true
		else
			AiJadeite_Build_2010(AiTemple())
		end
	elseif ((((unit == AiUpgradeEliteShooter())) and (jadeite_archers[AiPlayer()] == nil))) then
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0)) then
			AiResearch(AiUpgradeEliteShooter())
			AiJadeite_Attack_2010(5)
			AiJadeite_Ticker_2010(10)
			jadeite_archers[AiPlayer()] = true
		else
			AiJadeite_Build_2010(AiBetterCityCenter(), 1, false, AiLumberMill())
		end
	elseif (unit == AiShooter()) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0) then
			AiJadeite_Upgrade_2010(AiUpgradeMissile1())
			AiJadeite_Upgrade_2010(AiUpgradeMissile2())
			AiJadeite_Upgrade_2010(AiUpgradeEliteShooter())
		else
			AiJadeite_Build_2010(AiLumberMill())
		end
	elseif (unit == AiEliteShooter()) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) then
			AiJadeite_Upgrade_2010(AiUpgradeEliteShooter2())
			AiJadeite_Upgrade_2010(AiUpgradeEliteShooter3())
			if (GetPlayerData(AiPlayer(), "Resources", "gold") > 10000) then
				AiJadeite_Upgrade_2010(AiUpgradeEliteShooter1())
			end
		else
			AiJadeite_Build_2010(AiBestCityCenter())
		end
	elseif (unit == AiSoldier()) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
			AiJadeite_Upgrade_2010(AiUpgradeArmor1())
			AiJadeite_Upgrade_2010(AiUpgradeWeapon1())
			AiJadeite_Upgrade_2010(AiUpgradeArmor2())
			AiJadeite_Upgrade_2010(AiUpgradeWeapon2())
		else
			AiJadeite_Build_2010(AiBlacksmith())
		end
	elseif (unit == AiCavalry()) then
		AiJadeite_Upgrade_2010(AiSoldier())
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
			AiJadeite_Upgrade_2010(AiUpgradeCavalryMage())
		else
			AiJadeite_Build_2010(AiStables())
		end
	elseif (unit == AiCavalryMage()) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) > 0) then
			AiJadeite_Upgrade_2010(AiCavalryMageSpell1())
			AiJadeite_Upgrade_2010(AiCavalryMageSpell2())
		else
			AiJadeite_Build_2010(AiTemple())
		end
	elseif (unit == AiCatapult()) then
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0)) then
			AiJadeite_Upgrade_2010(AiUpgradeCatapult1())
			AiJadeite_Upgrade_2010(AiUpgradeCatapult2())
		else
			AiJadeite_Build_2010(AiBlacksmith(), 1, false, AiBarracks())
		end
	elseif ((unit == AiBattleship()) or (unit == AiDestroyer())) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFoundry()) > 0) then
			AiJadeite_Upgrade_2010(AiUpgradeShipArmor1())
			AiJadeite_Upgrade_2010(AiUpgradeShipCannon1())
			AiJadeite_Upgrade_2010(AiUpgradeShipArmor2())
			AiJadeite_Upgrade_2010(AiUpgradeShipCannon2())
		else
			AiJadeite_Build_2010(AiFoundry())
		end
	elseif ((unit == AiGuardTower()) or (unit == AiCannonTower)) then
		AiUpgradeTo(unit)
	else
		AiResearch(unit)
	end
end

function AiJadeite_Attack_2010(force, coerce)
	if (force == nil) then
		for i=1, 7 do
			AiJadeite_Attack_2010(i, true)
		end
	else
		if (coerce == nil) then coerce = false end
		if ((jadeite_attacker[AiPlayer()] == 0) and (((coerce == false) and (AiWaitForce(force) == false)) or (coerce == true))) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 2) then
				AiJadeite_Reset_2010(50)
			else
				AiJadeite_Reset_2010(100)
			end
			if (GameDefinition["Name"] == "Front Lines") then
				for index = 1, 15 do
					if (GetNumUnitsAt(AiPlayer(), UnitDatabase[GetPlayerData(AiPlayer(), "RaceName")][index]["Unit"], {0,0}, {mapinfo.w,mapinfo.h}) > 0) then
						OrderUnit(AiPlayer(), UnitDatabase[GetPlayerData(AiPlayer(), "RaceName")][index]["Unit"], {ftm_team_x1[ftm_team[AiPlayer()]],ftm_team_y1[ftm_team[AiPlayer()]],ftm_team_x2[ftm_team[AiPlayer()]],ftm_team_y2[ftm_team[AiPlayer()]]}, {ftm_team_x1[AiPlayer()], ftm_team_y1[AiPlayer()], ftm_team_x2[AiPlayer()], ftm_team_y2[AiPlayer()]}, "move")
					end
				end
				--OrderUnit(AiPlayer(), AiSoldier(), {ftm_team_x1[ftm_team[AiPlayer()]],ftm_team_y1[ftm_team[AiPlayer()]],ftm_team_x2[ftm_team[AiPlayer()]],ftm_team_y2[ftm_team[AiPlayer()]]}, {ftm_team_x1[AiPlayer()], ftm_team_y1[AiPlayer()], ftm_team_x2[AiPlayer()], ftm_team_y2[AiPlayer()]}, "move")
			else
				AiAttackWithForce(force)
				if (force ~= 7) then
					AiJadeite_Attack_2010(7)
				end
			end
		end
	end
end

function AiJadeite_Force_2010(force, unit1, quantity1, unit2, quantity2, unit3, quantity3)
	if (quantity1 == nil) then quantity1 = 1 end
	if (quantity2 == nil) then quantity2 = 1 end
	if (quantity3 == nil) then quantity3 = 1 end
	if (((GameDefinition["Map"]["Topography"] == "Islands") or (GameDefinition["Map"]["Topography"] == "Island")) or ((GameDefinition["Map"]["Topography"] == "Coastal") and (GameCycle > 25000) and (GameCycle < 30000))) then
		if (((unit1 == AiBattleship()) or (unit2 == AiBattleship()) or (unit3 == AiBattleship())) or ((unit1 == AiTransporter()) or (unit2 == AiTransporter()) or (unit3 == AiTransporter())) or ((unit1 == AiDestroyer()) or (unit2 == AiDestroyer()) or (unit3 == AiDestroyer()))) then elseif (force ~= 0) then
			if (unit2 == nil) then
				unit2 = AiTransporter()
				if (quantity1 > 8) then
					quantity2 = 2
				else
					quantity2 = 1
				end
			elseif (unit3 == nil) then
				unit3 = AiTransporter()
				if (quantity1 + quantity2 > 6) then
					quantity3 = 2
				else
					quantity3 = 1
				end
			else
				unit4 = AiTransporter()
				if (quantity1 + quantity2 > 6) then
					quantity4 = 2
				else
					quantity4 = 1
				end
			end
			if ((jadeite_builder[AiPlayer()] == 0) and (force ~= 7) and (GetPlayerData(AiPlayer(), "UnitTypesCount", unit1) > 6)) then
				if (GameCycle > 30000) then
					AiJadeite_Force_2010(7, AiDestroyer(), 4, AiBattleship(), 1, AiScout(), 1)
				elseif (GameCycle > 25000) then
					AiJadeite_Force_2010(7, AiDestroyer(), 4, AiScout(), 1)
				elseif (GameCycle > 10000) then
					AiJadeite_Force_2010(7, AiDestroyer(), 2)
				elseif (GameCycle > 5000) then
					AiJadeite_Force_2010(7, AiDestroyer(), 1)
				end
			end
		end
	end
	if (((unit1 == AiBattleship()) or (unit2 == AiBattleship()) or (unit3 == AiBattleship()) or (unit1 == AiTransporter()) or (unit2 == AiTransporter()) or (unit3 == AiTransporter()) or (unit4 == AiTransporter())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFoundry()) == 0)) then AiJadeite_Build_2010(AiFoundry()) end
	if (jadeite_builder[AiPlayer()] == 0) then
		if (((unit1 == AiCatapult()) or (unit2 == AiCatapult()) or (unit3 == AiCatapult())) and ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) == 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 0))) then AiJadeite_Build_2010(AiBlacksmith(), 1, false, AiBarracks()) end
		if (((unit1 == AiScout()) or (unit2 == AiScout()) or (unit3 == AiScout())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiScientific()) == 0)) then AiJadeite_Build_2010(AiScientific()) end
		if (((unit1 == AiDestroyer()) or (unit2 == AiDestroyer()) or (unit3 == AiDestroyer())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiHarbor()) == 0)) then AiJadeite_Build_2010(AiHarbor()) end
		if (((unit1 == AiSoldier()) or (unit2 == AiSoldier()) or (unit3 == AiSoldier()) or (unit1 == AiFodder()) or (unit2 == AiFodder()) or (unit3 == AiFodder())) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 0)) then AiJadeite_Build_2010(AiBarracks()) end
		if (((unit1 == AiCavalry()) or (unit2 == AiCavalry()) or (unit3 == AiCavalry())) and ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) == 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) == 0))) then AiJadeite_Build_2010(AiStables(), 1, false, AiBlacksmith()) end
		if ((unit1 == AiCavalryMage()) or (unit2 == AiCavalryMage()) or (unit3 == AiCavalryMage())) then 
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) == 0) then
				AiJadeite_Build_2010(AiTemple()) 
			elseif (jadeite_cavalry[AiPlayer()] == nil) then 
				AiJadeite_Upgrade_2010(AiUpgradeCavalryMage()) 
			end
		end
		if (((unit1 == AiShooter()) or (unit2 == AiShooter()) or (unit3 == AiShooter())) and ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) == 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 0))) then AiJadeite_Build_2010(AiLumberMill(), 1, false, AiBarracks()) end
		if ((unit1 == AiEliteShooter()) or (unit2 == AiEliteShooter()) or (unit3 == AiEliteShooter())) then
			if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) == 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) == 0)) then 
				AiJadeite_Build_2010(AiBestCityCenter(), 1, AiLumberMill()) 
			elseif (jadeite_archers[AiPlayer()] == nil) then 
				AiJadeite_Upgrade_2010(AiUpgradeEliteShooter()) 
			end
		end
		if (jadeite_cavalry[AiPlayer()] ~= nil) then
			if (unit1 == AiCavalry()) then unit1 = AiCavalryMage() end
			if (unit2 == AiCavalry()) then unit2 = AiCavalryMage() end
			if (unit3 == AiCavalry()) then unit3 = AiCavalryMage() end
		else
			if (unit1 == AiCavalryMage()) then unit1 = AiCavalry() end
			if (unit2 == AiCavalryMage()) then unit2 = AiCavalry() end
			if (unit3 == AiCavalryMage()) then unit3 = AiCavalry() end
		end		
		if (jadeite_archers[AiPlayer()] ~= nil) then
			if (unit1 == AiShooter()) then unit1 = AiEliteShooter() end
			if (unit2 == AiShooter()) then unit2 = AiEliteShooter() end
			if (unit3 == AiShooter()) then unit3 = AiEliteShooter() end
		else
			if (unit1 == AiEliteShooter()) then unit1 = AiShooter() end
			if (unit2 == AiEliteShooter()) then unit2 = AiShooter() end
			if (unit3 == AiEliteShooter()) then unit3 = AiShooter() end
		end
		if (unit2 == nil) then
			AiForce(force, {unit1, quantity1}, false)
		elseif (unit3 == nil) then
			AiForce(force, {unit1, quantity1, unit2, quantity2}, true)
		elseif (unit4 == nil) then
			AiForce(force, {unit1, quantity1, unit2, quantity2, unit3, quantity3}, true)
		else
			AiForce(force, {unit1, quantity1, unit2, quantity2, unit3, quantity3, unit4, quantity4}, true)
		end
		AiJadeite_Ticker_2010(5)
	end
end

function AiJadeite_Build_2010(unit, quantity, force, unit2)
	if (quantity == nil) then quantity = 1 end
	if (force ~= true) then
		if (unit == AiCityCenter()) then
			force = true
		else 
			if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0)) then
				if ((unit == AiFarm()) or (unit == AiBarracks()) or (unit == AiLumberMill()) or (unit == AiBlacksmith())) then
					force = true
				elseif ((unit == AiTower()) or (unit == AiGuardTower()) or (unit == AiCannonTower())) then
					if (unit == AiTower()) then
						unit = AiTower()
						force = true
					elseif ((unit == AiGuardTower()) and (GetNumUnitsAt(AiPlayer(), AiGuardTower(), {0, 0}, {mapinfo.w, mapinfo.h}) < quantity)) then	
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTower()) > 0)) then
							AiSet(AiTower(), 0)
							AiJadeite_Upgrade_2010(AiGuardTower())
						else	
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0) then
								AiSet(AiTower(), 1)
							else
								AiSet(AiLumberMill(), 1)
							end
						end
					elseif ((unit == AiCannonTower()) and (GetNumUnitsAt(AiPlayer(), AiCannonTower(), {0, 0}, {mapinfo.w, mapinfo.h}) < quantity)) then
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTower()) > 0)) then
							AiJadeite_Upgrade_2010(AiCannonTower())
							AiSet(AiTower(), 0)
						else
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
								AiSet(AiTower(), 1)
							else
								AiSet(AiBlacksmith(), 1)
							end
						end
					end
				else
					if ((unit == AiPlatform()) or (unit == AiHarbor()) or (unit == AiRefinery()) or (unit == AiFoundry())) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0) then
							AiSet(AiTanker(), 2)
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiHarbor()) > 0) then
								force = true
							else
								AiSet(AiHarbor(), 1)
							end
						else
							AiSet(AiLumberMill(), 1)
						end
					elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0)) then
							if ((unit == AiStables()) or (unit == AiScientific())) then
								force = true
							elseif (unit == AiBetterCityCenter()) then
								force = false
								if (unit2 ~= nil) then AiSet(unit2, 1) end
							else
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
									if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0)) then
										if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) then
											if (unit == AiBestCityCenter()) then
												force = false
												if (unit2 ~= nil) then AiSet(unit2, 1) end
											else
												force = true
											end
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
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) >= 1) then
			AiSet(AiWorker(), 8)
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 5000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1000)) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) < 5) then
						AiJadeite_Force_2010(0, AiSoldier(), 12)
						AiJadeite_Build_2010(AiFarm(), 8)
					end
				else
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) < 2) then
						AiJadeite_Force_2010(0, AiSoldier(), 4)
					end
				end
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) > 3) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) == 0)) then
					AiJadeite_Build_2010(AiBlacksmith(), 1)
					AiSet(AiWorker(), 15)
					AiJadeite_Build_2010(AiFarm(), 5)
				else
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 2) then
						AiJadeite_Force_2010(6, AiCatapult(), 1)
					end
					AiJadeite_Upgrade_2010(AiSoldier())
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
							if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 3000) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1500)) then
								AiJadeite_Build_2010(AiBarracks(), 3)
							end
							if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) < 2) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) < 2)) then
								AiJadeite_Force_2010(6, AiCavalry(), 2)
							else
								if (jadeite_builder[AiPlayer()] == 0) then
									if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 6) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 6)) then
										AiJadeite_Cavalry_2010()
									elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 0)) then
										AiJadeite_Attack_2010(6)
										AiJadeite_Force_2010(6, AiCavalry(), 7)
									end
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
				end
			end
		else
			AiJadeite_Build_2010(AiFarm(), 1)
		end
	else
		AiJadeite_Build_2010(AiCityCenter(), 1)
	end
	AiJadeite_Ticker_2010()
end
		
function AiJadeite_Shooter_2010()
	AiJadeite_Set_Name_2010("Kyurene")
	AiJadeite_Intermittent_2010()
	if ((GameCycle < 20000) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) == 0)) then
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
				AiJadeite_Upgrade_2010(AiShooter())
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
						if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
							if (GameCycle > 5000) then
								AiJadeite_Upgrade_2010(AiEliteShooter())
							end
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) == 0) then
									AiJadeite_Build_2010(AiBestCityCenter())
								end
							else
								AiJadeite_Build_2010(AiStables(), 1)
							end
						else
							AiJadeite_Build_2010(AiBetterCityCenter())
						end	
					else
						AiJadeite_Build_2010(AiBlacksmith(), 1)
					end
					if (((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) > 3) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 3)) and ((GetPlayerData(AiPlayer(), "Resources", "gold") > 1200) and (GetPlayerData(AiPlayer(), "Resources", "gold") > 800))) then 
						AiJadeite_Attack_2010(5)
						AiJadeite_Force_2010(5, AiShooter(), 10)
					else
						AiJadeite_Force_2010(0, AiShooter(), 4)
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) < 4) then
							AiJadeite_Build_2010(AiFarm(), 5)
						end
					end
				else
					AiJadeite_Build_2010(AiBarracks(), 1)
				end
			else
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) < 2) then
					AiJadeite_Build_2010(AiFarm(), 2)
				end
				AiJadeite_Build_2010(AiLumberMill(), 1)
			end
		else
			AiJadeite_Build_2010(AiCityCenter(), 1)
		end
	elseif (GameCycle < 20100) then
		AiJadeite_Attack_2010()
	else
		if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 2000) and (GetPlayerData(AiPlayer(), "Resources", "gold") > 1000)) then
			AiJadeite_Force_2010(4, AiShooter(), 10, AiSoldier(), 5, AiCatapult(), 2)
			AiJadeite_Attack_2010(4)
		end
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
									AiJadeite_Upgrade_2010(AiUpgradeCavalryMage())
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
			AiJadeite_Force_2010(0, AiSoldier(), 4)
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 3) then
				AiJadeite_Force_2010(3, AiSoldier(), 8)
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) > 7) and ((GameDefinition["Map"]["Type"] ~= "Islands") or ((GameDefinition["Map"]["Type"] == "Islands") and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTransporter()) > 0)))) then
					AiJadeite_Attack_2010(3)
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
						AiJadeite_Upgrade_2010(AiSoldier())
						AiJadeite_Build_2010(AiBarracks(), 3)
						AiJadeite_Build_2010(AiFarm(), 8)
					else
						AiJadeite_Build_2010(AiBlacksmith(), 1)
						AiJadeite_Build_2010(AiBarracks(), 2)
					end
				elseif (GetPlayerData(AiPlayer(), "Resources", "gold") > 2000) then
					AiJadeite_Build_2010(AiFarm(), 6)
				end
			else
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
	-- Working fine! 21/07/2015
	AiDebugPlayer("self")
	AiJadeite_Set_Name_2010("Iguara")
	AiJadeite_Intermittent_2010(2000)
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiAirport()) >= 1) then
		if (jadeite_builder[AiPlayer()] == 0) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) < 2) then
				AiJadeite_Force_2010(0, AiFlyer(), 2)
				AiJadeite_Build_2010(AiAirport(), 3)
			else
				AiJadeite_Force_2010(2, AiFlyer(), 8)
				AiJadeite_Attack_2010(2)
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