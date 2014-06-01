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
--	ai_redribbon.lua - Define the AI.
--
--	(c) Copyright 2011 by Kyran Jackson
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

--local Red2Mana -- Red2's mana.
--local Red2Temp_x
--local Red2Temp_y



local RedLeader -- The AI Player
local redribbon_stepping -- Used to identify where the build order is up to.

function AiRedRibbon()
	-- Setting up the variables.
	if (redribbon_stepping ~= nil) then
		--AddMessage("Stepping is nill.")
	else
		-- print ("Setting up the variables.")
		RedLeader = AiPlayer()
		-- Timer related
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitBerserkerNum = 0
		--AddMessage("Setting up the variables.")
		UnitCatapultNum = 0
		UnitOgreMageNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
		UnitHeroRiderNum = 0
		UnitGoblinSappersNum = 0
		timer = 1
		Blue2Mana = 0
		Blue1Mana = 0
		Red1Mana = 0
		Red1Mana = 0
		redribbon_stepping = 7
		SetPlayerData(RedLeader, "Resources", "oil", 5000)
    end
	timer = timer + 1
	-- Let's check out our surroundings.
	
	if (timer == 100) then
		timer = 0
	end
	if ((timer == 49) or (timer == 99)) then
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitSkeletonNum = 0
		UnitHeroShooterNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitGoblinSappersNum = 0
		UnitHeroRiderNum = 0
		UnitOgreMageNum = 0
		UnitFlyerNum = 0
		UnitWorkerNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
		if (players == 2) then
		else
			if (timer == 49) then
				RedTemp = RedTeam1
				RedTemp_x1 = RedTeam1_x1
				RedTemp_y1 = RedTeam1_y1
				RedTemp_x2 = RedTeam1_x2
				RedTemp_y2 = RedTeam1_y2
			else
				RedTemp = RedTeam2
				RedTemp_x1 = RedTeam2_x1
				RedTemp_y1 = RedTeam2_y1
				RedTemp_x2 = RedTeam2_x2
				RedTemp_y2 = RedTeam2_y2
			end
		end
		-- If the RedTemp is out of range of the map it'll cause a crash.
		if (GetNumUnitsAt(RedLeader, AiBarracks(), {(RedBarracks1_x - 3), (RedBarracks1_y - 3)}, {(RedBarracks1_x + 3), (RedBarracks1_y + 3)}) > 0) then
			if (GetNumUnitsAt(RedTemp, AiSoldier(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				--AddMessage("Spawn Red Footmen!")
				UnitGruntNum = GetNumUnitsAt(RedTemp, AiSoldier(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
				--print("Spawning " + UnitGruntNum + " grunts.")
				for UnitUpto = RedLeader,(UnitGruntNum - 1) do
					CreateUnit(AiSoldier(), RedLeader, {RedBarracks1_x, RedBarracks1_y})
				end
			end	
			if (GetNumUnitsAt(RedTemp, AiHeroSoldier(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				UnitHeroSoldierNum = GetNumUnitsAt(RedTemp, AiHeroSoldier(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
				for UnitUpto = RedLeader,UnitHeroSoldierNum do
					CreateUnit(AiHeroSoldier(), RedLeader, {RedBarracks1_x, RedBarracks1_y})
				end
			end
		else
			--AddMessage("I can't train any more grunts!")
		end
		if ((GetNumUnitsAt(RedTemp, AiEliteShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, AiShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)) then
			if (GetNumUnitsAt(RedLeader, AiBarracks(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)}) > 0) then
				if (GetNumUnitsAt(RedTemp, AiEliteShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					--AddMessage("Spawn Red Rangers!")
					UnitBerserkerNum = GetNumUnitsAt(RedTemp, AiEliteShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					--print("Spawning " + UnitBerserkerNum + " berserkers.")
					for UnitUpto = RedLeader,(UnitBerserkerNum - 1) do
						CreateUnit(AiEliteShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				if (GetNumUnitsAt(RedTemp, AiShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					--AddMessage("Spawn Red Archers!")
					UnitAxethrowerNum = GetNumUnitsAt(RedTemp, AiShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitAxethrowerNum - 1) do
						CreateUnit(AiShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				if (GetNumUnitsAt(RedTemp, AiHeroShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					UnitHeroShooterNum = GetNumUnitsAt(RedTemp, AiHeroShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitHeroShooterNum - 1) do
						CreateUnit(AiHeroShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				
			else
				--AddMessage("I can't train any more axethrowers!")
			end
		end
		if ((GetNumUnitsAt(RedTemp, "unit-caanoo-wiseskeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, AiMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)) then
			--AddMessage("Spawn Red Mages!")
			UnitDeathKnightNum = (GetNumUnitsAt(RedTemp, "unit-caanoo-wiseskeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) + GetNumUnitsAt(RedTemp, AiMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}))
			for UnitUpto = RedLeader,(UnitDeathKnightNum - 1) do
				CreateUnit(AiMage(), RedLeader, {RedMageTower_x, RedMageTower_y})
			end
		end
		if (GetNumUnitsAt(RedTemp, "unit-skeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			UnitSkeletonNum = GetNumUnitsAt(RedTemp, "unit-skeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
			for UnitUpto = RedLeader,(UnitSkeletonNum - 1) do
				CreateUnit("unit-skeleton", RedLeader, {RedMageTower_x, RedMageTower_y})
			end
		end
		if (GetNumUnitsAt(RedLeader, AiBarracks(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)}) > 0) then
			if (GetNumUnitsAt(RedTemp, AiCavalry(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				--AddMessage("Spawn Red Knights!")
				if (GetNumUnitsAt(RedLeader, "unit-orcbarracks", {RedBarracks3_x - 3, RedBarracks3_y - 3}, {RedBarracks3_x + 3, RedBarracks3_y + 3}) > 0) then
					UnitOgreNum = GetNumUnitsAt(RedTemp, AiCavalry(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitOgreNum - 1) do
						CreateUnit(AiCavalry(), RedLeader, {RedBarracks3_x, RedBarracks3_y})
					end
				end
			end
			if (GetNumUnitsAt(RedTemp, AiCavalryMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				--AddMessage("Spawn Red Paladins!")
				UnitOgreMageNum = GetNumUnitsAt(RedTemp, AiCavalryMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitOgreMageNum - 1) do
					CreateUnit(AiCavalryMage(), RedLeader, {RedBarracks3_x, RedBarracks3_y})
				end
			end
			if (GetNumUnitsAt(RedTemp, AiHeroRider(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				UnitHeroRiderNum = GetNumUnitsAt(RedTemp, AiHeroRider(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitHeroRiderNum - 1) do
					CreateUnit(AiHeroRider(), RedLeader, {RedBarracks3_x, RedBarracks3_y})
				end
			end
		end	
		if  ((GetNumUnitsAt(RedLeader, AiBestCityCenter(), {(RedTownHall_x - 3), (RedTownHall_y - 3)}, {(RedTownHall_x + 3), (RedTownHall_y + 3)}) > 0) or (GetNumUnitsAt(RedLeader, AiBetterCityCenter(), {(RedTownHall_x - 3), (RedTownHall_y - 3)}, {(RedTownHall_x + 3), (RedTownHall_y + 3)}) > 0) or (GetNumUnitsAt(RedLeader, AiCityCenter(), {(RedTownHall_x - 3), (RedTownHall_y - 3)}, {(RedTownHall_x + 3), (RedTownHall_y + 3)}) > 0)) then
			if (GetNumUnitsAt(RedTemp, AiWorker(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				UnitWorkerNum = GetNumUnitsAt(RedTemp, AiWorker(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitWorkerNum - 1) do
					CreateUnit(AiWorker(), RedLeader, {RedTownHall_x, RedTownHall_y})
				end
			end
		end
		if (GetNumUnitsAt(RedLeader, AiAirport(), {(RedFlyerBuilding_x - 3), (RedFlyerBuilding_y - 3)}, {(RedFlyerBuilding_x + 3), (RedFlyerBuilding_y + 3)}) > 0) then
			if (GetNumUnitsAt(RedTemp, AiFlyer(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				UnitFlyerNum = GetNumUnitsAt(RedTemp, AiFlyer(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitFlyerNum - 1) do
					CreateUnit(AiFlyer(), RedLeader, {RedFlyerBuilding_x, RedFlyerBuilding_y})
				end
			end
		end
		if (GetNumUnitsAt(RedLeader, AiBarracks(), {(RedBarracks4_x - 3), (RedBarracks4_y - 3)}, {(RedBarracks4_x + 3), (RedBarracks4_y + 3)}) > 0) then
			if (GetNumUnitsAt(RedTemp, AiCatapult(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				--AddMessage("Spawn Red Ballistas!")
				UnitCatapultNum = GetNumUnitsAt(RedTemp, AiCatapult(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitCatapultNum - 1) do
					CreateUnit(AiCatapult(), RedLeader, {RedBarracks4_x, RedBarracks4_y})
				end
			end
		end
		if (GetNumUnitsAt(RedTemp, AiSuicideBomber(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			--AddMessage("Spawn Red Dwarves!")
			UnitGoblinSappersNum = GetNumUnitsAt(RedTemp, AiSuicideBomber(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
			for UnitUpto = RedLeader,(UnitGoblinSappersNum - 1) do
				CreateUnit(AiSuicideBomber(), RedLeader, {RedInventor_x, RedInventor_y})
			end
		end
		-- Not having a value for UnitNum will cause a crash.
		--AiForce(0, {AiFlyer(), UnitFlyerNum, AiHeroShooter(), UnitHeroShooterNum, "unit-skeleton", UnitSkeletonNum, AiSuicideBomber(), UnitGoblinSappersNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitGruntNum, AiShooter(), UnitAxethrowerNum, AiEliteShooter(), UnitBerserkerNum, AiCavalry(), UnitOgreNum, AiCavalryMage(), UnitOgreMageNum, AiCatapult(), UnitCatapultNum})
		--if (AiCheckForce(0)) then 
		--	AiAttackWithForce(0)
		--end
		AiForce(1, {AiFlyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer())}, true)
		AiAttackWithForce(1)
		AiNephrite_Attack_2013()
	end
	if ((timer == 75) or (timer == 25)) then
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitGoblinSappersNum = 0
		UnitOgreMageNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
		if (GetNumUnitsAt(RedLeader, AiSoldier(), {(RedBarracks1_x - 3), (RedBarracks1_y - 3)}, {(RedBarracks1_x + 3), (RedBarracks1_y + 3)}) > 0) then
			UnitGruntNum = GetNumUnitsAt(RedLeader, AiSoldier(), {(RedBarracks1_x - 3), (RedBarracks1_y - 3)}, {(RedBarracks1_x + 3), (RedBarracks1_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)}) > 0) then
			UnitAxethrowerNum = GetNumUnitsAt(RedLeader, AiShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiEliteShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)}) > 0) then
			UnitBerserkerNum = GetNumUnitsAt(RedLeader, AiEliteShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiHeroShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)}) > 0) then
			UnitHeroShooterNum = GetNumUnitsAt(RedLeader, AiHeroShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiCavalry(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)}) > 0) then
			UnitOgreNum = GetNumUnitsAt(RedLeader, AiCavalry(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiCavalryMage(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)}) > 0) then
			UnitOgreMageNum = GetNumUnitsAt(RedLeader, AiCavalryMage(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)})
		end
		AiForce(1, {AiSuicideBomber(), UnitGoblinSappersNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitGruntNum, AiShooter(), UnitAxethrowerNum, AiEliteShooter(), UnitBerserkerNum, AiCavalry(), UnitOgreNum, AiCavalryMage(), UnitOgreMageNum, AiCatapult(), UnitCatapultNum}, true)
		if (AiCheckForce(1)) then 
			AiAttackWithForce(1)
		end
	end
	if (GetPlayerData(RedLeader, "UnitTypesCount", AiHarbor()) < 1) then
		if (GetPlayerData(RedLeader, "UnitTypesCount", AiTanker()) > 0) then
			KillUnit(AiTanker(), RedLeader)
		end
		if (GetPlayerData(RedLeader, "UnitTypesCount", AiPlatform()) > 0) then
			KillUnit(AiPlatform(), RedLeader)
		end
	end
	if (GetPlayerData(BlueLeader, "UnitTypesCount", AiHarbor()) < 1)then
		if (GetPlayerData(BlueLeader, "UnitTypesCount", AiTanker()) > 0) then
			KillUnit(AiTanker(), BlueLeader)
		end
		if (GetPlayerData(BlueLeader, "UnitTypesCount", AiPlatform()) > 0) then
			KillUnit(AiPlatform(), BlueLeader)
		end
	end
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 0) then
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) >= 1) then
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
								if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) >= 1) then
									AiResearch(AiUpgradeCavalryMage())
									AiResearch(AiCavalryMageSpell1())
								else
									AiSet(AiTemple(), 1)
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
			AiSet(AiWorker(), 8)
		end
	end
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiMage()) > 0) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiMageTower()) > 0) then
			AiResearch(AiMageSpell1())
			AiResearch(AiMageSpell2())
			AiResearch(AiMageSpell3())
			AiResearch(AiMageSpell4())
			AiResearch(AiMageSpell5())
		else
			AiSet(AiMageTower(), 1)
		end
	end
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()) > 0) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
				AiResearch(AiUpgradeCatapult1())
				AiResearch(AiUpgradeCatapult2())
			else
				AiSet(AiBlacksmith(), 1)
			end
		else
			AiSet(AiBarracks(), 1)
		end
	end
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 0) then
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) >= 1) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1)) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) >= 1) then
				AiUpgradeMissile1()
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
						AiUpgradeMissile2()
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
							AiResearch(AiUpgradeEliteShooter())
							AiResearch(AiUpgradeEliteShooter1())
							AiResearch(AiUpgradeMissile1())
							AiResearch(AiUpgradeMissile2())
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
				else
					AiSet(AiBarracks(), 1)
				end
			else
				AiSet(AiLumberMill(), 1)
			end
		else
			AiSet(AiCityCenter(), 1)
			AiSet(AiWorker(), 8)
		end
	end
	if ((timer == 35) or (timer == 85)) then
		AiNephrite_Flush_2013()
	end
	AiNephrite_Expand_2013()
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) > 0)) then
		AiNephrite_Research_2013()
	end
end

function AiRed1()
	if ((GetPlayerData(RedTeam1, "UnitTypesCount", "unit-caanoo-wiseskeleton") > 0) and (GameCycle > 500)) then
		AiRed1_Basic()
	end
end

function AiRed2()
	if ((GetPlayerData(RedTeam1, "UnitTypesCount", "unit-caanoo-wiseskeleton") > 0) and (GameCycle > 500)) then
		AiRed2_Basic()
	end
end

function AiRed2_Basic()
	if (Red2Temp_x ~= nil) then
	else
		Red2Temp_x = RedTeam2_x1
		Red2Temp_y = RedTeam2_y1
		Red2Step = 0
		Red2Mana = 140
	end
	if ((timer == 25) or (timer == 75)) then
			Red2Mana = Red2Mana + 105
	end
	if (redribbon_stepping > 7) then
		if (Red2Mana > (150*6)) then
			AiForce(0, {AiSoldier(), 7}, true)
			AiAttackWithForce(0)
		end 
		if (Red2Mana > (150*7)) then
			if (redribbon_stepping == 8) then
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1, RedTeam2_y1})
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 1, RedTeam2_y1})
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 2, RedTeam2_y1})
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 3, RedTeam2_y1})
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 4, RedTeam2_y1})
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 5, RedTeam2_y1})
				CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 6, RedTeam2_y1})
				Red2Mana = (Red2Mana - (150 * 7))
				redribbon_stepping = 9
			else
				if (redribbon_stepping == 9) then
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 7, RedTeam2_y1})
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 1, RedTeam2_y1 + 1})
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 2, RedTeam2_y1 + 1})
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 3, RedTeam2_y1 + 1})
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 4, RedTeam2_y1 + 1})
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 5, RedTeam2_y1 + 1})
					CreateUnit("unit-ogre", AiPlayer(), {RedTeam2_x1 + 6, RedTeam2_y1 + 1})
					Red2Mana = (Red2Mana - (150 * 7))
					redribbon_stepping = 10
				end
			end
		end
	else
		if (GetNumUnitsAt(RedTeam2, "unit-ogre", {RedTeam2_x1, RedTeam2_y1}, {RedTeam2_x2, RedTeam2_y2}) < 8) then
			if (GetNumUnitsAt(RedTeam2, "unit-grunt", {RedTeam2_x1, RedTeam2_y1}, {RedTeam2_x2, RedTeam2_y2}) < 16) then
				if (Red2Mana > 49) then
					if ((Red2Mana > 75) and (Red2Mana < 95)) then
						CreateUnit("unit-axethrower", RedTeam2, {Red2Temp_x, Red2Temp_y})
					else
						CreateUnit("unit-grunt", RedTeam2, {Red2Temp_x, Red2Temp_y})
					end
					Red2Mana = Red2Mana - 50
					Red2Step = 1
				end
			else
				if (Red2Mana > 149) then
					CreateUnit("unit-ogre", RedTeam2, {Red2Temp_x, Red2Temp_y})
					Red2Mana = Red2Mana - 150
					Red2Step = 1
				end
			end
		else
			if ((Red2Mana > 289) and (Red2Mana < 599)) then
				CreateUnit("unit-ogre-mage", RedTeam2, {Red2Temp_x, Red2Temp_y})
				Red2Mana = Red2Mana - 250
				Red2Step = 1
			else
				if (Red2Mana > 249) then
					CreateUnit("unit-catapult", RedTeam2, {Red2Temp_x, Red2Temp_y})
					Red2Mana = Red2Mana - 250
					Red2Step = 1
				end
			end
		end
	end
	if (Red2Step == 1) then
		if (Red2Temp_x ~= nil) then
			if (Red2Temp_x == RedTeam2_x2) then
				if (Red2Temp_y == RedTeam2_y2) then
					-- Oh shit, I've used up all my spaces.
					redribbon_stepping = 8
				else
					Red2Temp_x = RedTeam2_x1
					Red2Temp_y = Red2Temp_y + 1
				end
			else
				Red2Temp_x = Red2Temp_x + 1
			end
		end
		Red2Step = 0
	end
end

function AiRed1_Basic()
	if (Red1Temp_x ~= nil) then
	else
		Red1Temp_x = RedTeam1_x1
		Red1Temp_y = RedTeam1_y1
		Red1Step = 0
		Red1Mana = 140
	end
	if ((timer == 25) or (timer == 75)) then
		Red1Mana = Red1Mana + 52
	end
	if ((timer == 50) or (timer == 98)) then
		Red1Mana = Red1Mana + 53
	end
	if (((RedTeam1_x2 - RedTeam1_x1)*(RedTeam1_y2 - RedTeam1_y1)) < 19) then
		if (GetNumUnitsAt(RedTeam1, "unit-skeleton", {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) < 4) then
			if ((Red1Mana > 20) and (Red1Mana < 40)) then
				CreateUnit("unit-skeleton", RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 20
				Red1Step = 1
			end
		end
		if (GetNumUnitsAt(RedTeam1, "unit-catapult", {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) > 4) then
			if (Red1Mana > 250) then
				CreateUnit(AiCavalryMage(), RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 250
				Red1Step = 1
			elseif ((Red1Mana > 100) and (Red1Mana < 120) and (GetPlayerData(RedTeam1, "UnitTypesCount", AiEliteShooter()) == 0)) then
				CreateUnit(AiEliteShooter(), RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 100
				Red1Step = 1
			elseif ((Red1Mana > 50) and (Red1Mana < 70) and (GetPlayerData(RedTeam1, "UnitTypesCount", AiShooter()) < 4)) then
				CreateUnit("unit-axethrower", RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 50
				Red1Step = 1
			end
		else
			if (Red1Mana > 250) then
				CreateUnit("unit-catapult", RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 250
				Red1Step = 1
			end
		end
	elseif (GetNumUnitsAt(RedTeam1, "unit-ogre", {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) < 8) then
		if (GetNumUnitsAt(RedTeam1, "unit-grunt", {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) < 22) then
			if ((GetNumUnitsAt(RedTeam1, "unit-grunt", {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) < 5) or (GetNumUnitsAt(RedTeam1, AiCavalryMage(), {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) > 0)) then
				if (Red1Mana > 49) then
					if ((GetPlayerData(RedLeader, "UnitTypesCount", AiEliteShooter()) == 0) and ((Red1Mana > 90) and (Red1Mana < 190))) then
						CreateUnit(AiEliteShooter(), RedTeam1, {Red1Temp_x, Red1Temp_y})
						Red1Mana = Red1Mana - 100
					else
						if ((Red1Mana > 75) and (Red1Mana < 95)) then
							CreateUnit("unit-axethrower", RedTeam1, {Red1Temp_x, Red1Temp_y})
						else
							CreateUnit("unit-grunt", RedTeam1, {Red1Temp_x, Red1Temp_y})
						end
						Red1Mana = Red1Mana - 50
					end
					Red1Step = 1
				end
			else
				if (Red1Mana > 250) then
					CreateUnit(AiCavalryMage(), RedTeam1, {Red1Temp_x, Red1Temp_y})
					Red1Mana = Red1Mana - 250
					Red1Step = 1
				end
			end
		else
			if (Red1Mana > 149) then
				CreateUnit("unit-ogre", RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 150
				Red1Step = 1
			end
		end
	else
		if ((Red1Mana > 289) and (Red1Mana < 599)) then
			CreateUnit("unit-ogre-mage", RedTeam1, {Red1Temp_x, Red1Temp_y})
			Red1Mana = Red1Mana - 250
			Red1Step = 1
		else
			if (Red1Mana > 249) then
				CreateUnit("unit-catapult", RedTeam1, {Red1Temp_x, Red1Temp_y})
				Red1Mana = Red1Mana - 250
				Red1Step = 1
			end
		end
	end
	if (Red1Step == 1) then
		if (Red1Temp_x ~= nil) then
			if (Red1Temp_x == RedTeam1_x2) then
				if (Red1Temp_y == RedTeam1_y2) then
					-- Oh shit, I've used up all my spaces.
					Red1Temp_x = RedTeam1_x1
					Red1Temp_y = RedTeam1_y1
				else
					Red1Temp_x = RedTeam1_x1
					Red1Temp_y = Red1Temp_y + 1
				end
			else
				Red1Temp_x = Red1Temp_x + 1
			end
		end
		Red1Step = 0
	end
end

DefineAi("ai_redribbon", "*", "ai_redribbon", AiRedRibbon)
DefineAi("ai_red2", "*", "ai_red2", AiRed2)
DefineAi("ai_red1", "*", "ai_red1", AiRed1)
