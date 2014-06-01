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
--	ai_blueribbon.lua - Define the AI.
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



local BlueLeader -- The AI Player
local blueribbon_stepping -- Used to identify where the build order is up to.

function AiBlueRibbon()
	-- Setting up the variables.
	if (blueribbon_stepping ~= nil) then
	else
		-- print ("Setting up the variables.")
		BlueLeader = AiPlayer()
		-- Timer related
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitBallistaNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitMageNum = 0
		UnitSkeletonNum = 0
		UnitHeroSoldierNum = 0
		UnitHeroShooterNum = 0
		UnitDwarvesNum = 0
		blueribbon_stepping = 7
		SetPlayerData(BlueLeader, "Resources", "oil", 5000)
    end
	-- Let's check out our surroundings.
	if ((timer == 50) or (timer == 99)) then
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitSkeletonNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitHeroRiderNum = 0
		UnitMageNum = 0
		UnitSkeletonNum = 0
		UnitHeroSoldierNum = 0
		UnitHeroShooterNum = 0
		if (timer == 50) then
			BlueTemp = BlueTeam1
			BlueTemp_x1 = BlueTeam1_x1
			BlueTemp_y1 = BlueTeam1_y1
			BlueTemp_x2 = BlueTeam1_x2
			BlueTemp_y2 = BlueTeam1_y2
		else
			BlueTemp = BlueTeam2
			BlueTemp_x1 = BlueTeam2_x1
			BlueTemp_y1 = BlueTeam2_y1
			BlueTemp_x2 = BlueTeam2_x2
			BlueTemp_y2 = BlueTeam2_y2
		end
		if (GetNumUnitsAt(BlueLeader, AiBarracks(), {BlueBarracks1_x - 3, BlueBarracks1_y - 3}, {BlueBarracks1_x + 3, BlueBarracks1_y + 3}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiSoldier(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				--AddMessage("Spawn Blue Footmen!")
				UnitFootmanNum = GetNumUnitsAt(BlueTemp, AiSoldier(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitFootmanNum do
					CreateUnit(AiSoldier(), BlueLeader, {BlueBarracks1_x, BlueBarracks1_y})
				end
			end
			if (GetNumUnitsAt(BlueTemp, AiHeroSoldier(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				UnitHeroSoldierNum = GetNumUnitsAt(BlueTemp, AiHeroSoldier(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitHeroSoldierNum do
					CreateUnit(AiHeroSoldier(), BlueLeader, {BlueBarracks1_x, BlueBarracks1_y})
				end
			end
		else
			AddMessage("I can't train any more footmen!")
		end
		if ((GetNumUnitsAt(BlueTemp, AiEliteShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, AiShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0)) then
			if (GetNumUnitsAt(BlueLeader, AiBarracks(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)}) > 0) then
				if (GetNumUnitsAt(BlueTemp, AiEliteShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					--AddMessage("Spawn Blue Rangers!")
					UnitRangerNum = GetNumUnitsAt(BlueTemp, AiEliteShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
					for UnitUpto = BlueLeader,UnitRangerNum do
						CreateUnit(AiEliteShooter(), BlueLeader, {BlueBarracks2_x, BlueBarracks2_y})
					end
				end
				if (GetNumUnitsAt(BlueTemp, AiShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					--AddMessage("Spawn Blue Archers!")
					UnitArcherNum = GetNumUnitsAt(BlueTemp, AiShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
					for UnitUpto = BlueLeader,UnitArcherNum do
						CreateUnit(AiShooter(), BlueLeader, {BlueBarracks2_x, BlueBarracks2_y})
					end
				end
				if (GetNumUnitsAt(BlueTemp, AiHeroShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					UnitHeroShooterNum = GetNumUnitsAt(BlueTemp, AiHeroShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2})
					for UnitUpto = BlueLeader,(UnitHeroShooterNum) do
						CreateUnit(AiHeroShooter(), BlueLeader, {BlueBarracks2_x, BlueBarracks2_y})
					end
				end
			else
				AddMessage("I can't train any more archers!")
			end
		end
		if (GetNumUnitsAt(BlueLeader, AiMageTower(), {(BlueMageTower_x - 3), (BlueMageTower_y - 3)}, {(BlueMageTower_x + 3), (BlueMageTower_y + 3)}) > 0) then
			if ((GetNumUnitsAt(BlueTemp, "unit-caanoo-wiseman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, "unit-mage", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0)) then
				--AddMessage("Spawn Blue Mages!")
				UnitMageNum = (GetNumUnitsAt(BlueTemp, "unit-caanoo-wiseman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) + GetNumUnitsAt(BlueTemp, "unit-mage", {0, 0}, {92, 256}) )
				for UnitUpto = BlueLeader,UnitMageNum do
					CreateUnit("unit-mage", BlueLeader, {BlueMageTower_x, BlueMageTower_y})
				end
			end
			if (GetNumUnitsAt(BlueTemp, "unit-skeleton", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				--AddMessage("Spawn Blue Skeletons!")
				UnitSkeletonNum = (GetNumUnitsAt(BlueTemp, "unit-skeleton", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) + GetNumUnitsAt(BlueTemp, "unit-mage", {0, 0}, {92, 256}) )
				for UnitUpto = BlueLeader,UnitSkeletonNum do
					CreateUnit("unit-skeleton", BlueLeader, {BlueMageTower_x, BlueMageTower_y})
				end
			end
		end
		if (GetNumUnitsAt(BlueLeader, AiBarracks(), {(BlueBarracks3_x - 3), (BlueBarracks3_y - 3)}, {(BlueBarracks3_x + 3), (BlueBarracks3_y + 3)}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiCavalry(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				--AddMessage("Spawn Blue Knights!")
				UnitKnightNum = GetNumUnitsAt(BlueTemp, AiCavalry(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitKnightNum do
					CreateUnit(AiCavalry(), BlueLeader, {BlueBarracks3_x, BlueBarracks3_y})
				end
			end
			if (GetNumUnitsAt(BlueTemp, AiCavalryMage(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				--AddMessage("Spawn Blue Paladins!")
				UnitPaladinNum = GetNumUnitsAt(BlueTemp, AiCavalryMage(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitPaladinNum do
					CreateUnit(AiCavalryMage(), BlueLeader, {BlueBarracks3_x, BlueBarracks3_y})
				end
			end
			if (GetNumUnitsAt(BlueTemp, AiHeroRider(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				UnitHeroRiderNum = GetNumUnitsAt(BlueTemp, AiHeroRider(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2})
				for UnitUpto = BlueLeader,(UnitHeroRiderNum) do
					CreateUnit(AiHeroRider(), BlueLeader, {BlueBarracks3_x, BlueBarracks3_y})
				end
			end
		end
		
		if (GetNumUnitsAt(BlueLeader, AiBarracks(), {(BlueBarracks4_x - 3), (BlueBarracks4_y - 3)}, {(BlueBarracks4_x + 3), (BlueBarracks4_y + 3)}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiCatapult(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				--AddMessage("Spawn Blue Ballistas!")
				UnitBallistaNum = GetNumUnitsAt(BlueTemp, AiCatapult(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitBallistaNum do
					CreateUnit(AiCatapult(), BlueLeader, {BlueBarracks4_x, BlueBarracks4_y})
				end
			end
		end
		
		
		
		
		if (GetNumUnitsAt(BlueLeader, AiScientific(), {(BlueInventor_x - 3), (BlueInventor_y - 3)}, {(BlueInventor_x + 3), (BlueInventor_y + 3)}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiSuicideBomber(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				--AddMessage("Spawn Blue Dwarves!")
				UnitDwarvesNum = GetNumUnitsAt(BlueTemp, AiSuicideBomber(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitDwarvesNum do
					CreateUnit(AiSuicideBomber(), BlueLeader, {BlueInventor_x, BlueInventor_y})
				end
			end
		end
		if ((GetNumUnitsAt(BlueLeader, AiBestCityCenter(), {(BlueTownHall_x - 3), (BlueTownHall_y - 3)}, {(BlueTownHall_x + 3), (BlueTownHall_y + 3)}) > 0) or (GetNumUnitsAt(BlueLeader, AiBetterCityCenter(), {(BlueTownHall_x - 3), (BlueTownHall_y - 3)}, {(BlueTownHall_x + 3), (BlueTownHall_y + 3)}) > 0) or (GetNumUnitsAt(BlueLeader, AiCityCenter(), {(BlueTownHall_x - 3), (BlueTownHall_y - 3)}, {(BlueTownHall_x + 3), (BlueTownHall_y + 3)}) > 0)) then
			if (GetNumUnitsAt(BlueTemp, AiWorker(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				UnitWorkerNum = GetNumUnitsAt(BlueTemp, AiWorker(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2})
				for UnitUpto = BlueLeader,(UnitWorkerNum) do
					CreateUnit(AiWorker(), BlueLeader, {BlueTownHall_x, BlueTownHall_y})
				end
			end
		end
		if (GetNumUnitsAt(BlueLeader, AiAirport(), {(BlueFlyerBuilding_x - 3), (BlueFlyerBuilding_y - 3)}, {(BlueFlyerBuilding_x + 3), (BlueFlyerBuilding_y + 3)}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiFlyer(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				UnitFlyerNum = GetNumUnitsAt(BlueTemp, AiFlyer(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2})
				for UnitUpto = BlueLeader,(UnitFlyerNum) do
					CreateUnit(AiFlyer(), BlueLeader, {BlueFlyerBuilding_x, BlueFlyerBuilding_y})
				end
			end
		end
		--AiForce(0, {AiFlyer(), UnitFlyerNum, AiHeroShooter(), UnitHeroShooterNum, "unit-skeleton", UnitSkeletonNum, AiSuicideBomber(), UnitDwarvesNum, AiMage(), UnitMageNum, AiSoldier(), UnitFootmanNum, AiShooter(), (UnitArcherNum + UnitRangerNum), AiEliteShooter(), (UnitArcherNum + UnitRangerNum), AiCavalry(), (UnitPaladinNum + UnitKnightNum), AiCavalryMage(), (UnitKnightNum + UnitPaladinNum), AiCatapult(), UnitBallistaNum})
		--if (AiCheckForce(0)) then 
		--	AiAttackWithForce(0)
		--end
		AiForce(1, {AiFlyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer())}, true)
		AiAttackWithForce(1)
		AiNephrite_Attack_2013()
	end
	if (timer == 100) then
		timer = 0
	end
	if ((timer == 75) or (timer == 25)) then
		-- TODO: Fix this with the proper variables.
		--print("hi")
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitMageNum = 0
		UnitSkeletonNum = 0
		UnitHeroSoldierNum = 0
		UnitHeroShooterNum = 0
		if (GetNumUnitsAt(BlueLeader, AiSoldier(), {(BlueBarracks1_x - 3), (BlueBarracks1_y - 3)}, {(BlueBarracks1_x + 3), (BlueBarracks1_y + 3)}) > 5) then
			UnitFootmanNum = GetNumUnitsAt(BlueLeader, AiSoldier(), {(BlueBarracks1_x - 3), (BlueBarracks1_y - 3)}, {(BlueBarracks1_x + 3), (BlueBarracks1_y + 3)})
		end
		if (GetNumUnitsAt(BlueLeader, AiShooter(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)}) > 5) then
			UnitArcherNum = GetNumUnitsAt(BlueLeader, AiShooter(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(BlueLeader, AiEliteShooter(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)}) > 5) then
			UnitRangerNum = GetNumUnitsAt(BlueLeader, AiEliteShooter(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(BlueLeader, AiHeroShooter(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)}) > 5) then
			UnitHeroShooterNum = GetNumUnitsAt(BlueLeader, AiHeroShooter(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(BlueLeader, AiCavalry(), {(BlueBarracks3_x - 3), (BlueBarracks3_y - 3)}, {(BlueBarracks3_x + 3), (BlueBarracks3_y + 3)}) > 5) then
			UnitKnightNum = GetNumUnitsAt(BlueLeader, AiCavalry(), {(BlueBarracks3_x - 3), (BlueBarracks3_y - 3)}, {(BlueBarracks3_x + 3), (BlueBarracks3_y + 3)})
		end
		if (GetNumUnitsAt(BlueLeader, AiCavalryMage(), {(BlueBarracks3_x - 3), (BlueBarracks3_y - 3)}, {(BlueBarracks3_x + 3), (BlueBarracks3_y + 3)}) > 5) then
			UnitPaladinNum = GetNumUnitsAt(BlueLeader, AiCavalryMage(), {(BlueBarracks3_x - 3), (BlueBarracks3_y - 3)}, {(BlueBarracks3_x + 3), (BlueBarracks3_y + 3)})
		end
		AiForce(1, {AiSuicideBomber(), UnitDwarvesNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitFootmanNum, AiShooter(), UnitArcherNum, AiEliteShooter(), UnitRangerNum, AiCavalry(), UnitKnightNum, AiCavalryMage(), UnitPaladinNum, AiCatapult(), UnitCatapultNum}, true)
		if (AiCheckForce(1)) then 
			AiAttackWithForce(1)
		end
		
		
		
		AiForce(1, {AiSuicideBomber(), UnitDwarvesNum, AiMage(), UnitMageNum, AiSoldier(), UnitFootmanNum, AiShooter(), (UnitArcherNum + UnitRangerNum), AiEliteShooter(), (UnitArcherNum + UnitRangerNum), AiCavalry(), (UnitPaladinNum + UnitKnightNum), AiCavalryMage(), (UnitKnightNum + UnitPaladinNum), AiCatapult(), UnitBallistaNum}, true)
		AiAttackWithForce(1)
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
									AiResearch(AiCavalryMageSpell2())
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

function AiBlue1()
	if ((GetPlayerData(BlueTeam1, "UnitTypesCount", "unit-caanoo-wiseman") > 0) and (GameCycle > 500)) then
		AiBlue1_Basic()
	end
end

function AiBlue2()
	if ((GetPlayerData(BlueTeam1, "UnitTypesCount", "unit-caanoo-wiseman") > 0) and (GameCycle > 500)) then
		AiBlue2_Basic()
	end
end

function AiBlue2_Basic()
	if (Blue2Temp_x ~= nil) then
	else
		Blue2Temp_x = BlueTeam2_x1
		Blue2Temp_y = BlueTeam2_y1
		Blue2Step = 0
		Blue2Mana = 150
	end
	if ((timer == 25) or (timer == 75)) then
		Blue2Mana = Blue2Mana + 53
	end
	if ((timer == 50) or (timer == 98)) then
		Blue2Mana = Blue2Mana + 52
	end
	if (GetNumUnitsAt(BlueTeam2, "unit-knight", {BlueTeam2_x1, BlueTeam2_y1}, {BlueTeam2_x2, BlueTeam2_y2}) < 8) then
		if (GetNumUnitsAt(BlueTeam2, "unit-footman", {BlueTeam2_x1, BlueTeam2_y1}, {BlueTeam2_x2, BlueTeam2_y2}) < 22) then
			if (Blue2Mana > 49) then
				if ((Blue2Mana > 75) and (Blue2Mana < 95)) then
					CreateUnit("unit-archer", BlueTeam2, {Blue2Temp_x, Blue2Temp_y})
				else
					CreateUnit("unit-footman", BlueTeam2, {Blue2Temp_x, Blue2Temp_y})
				end
				Blue2Mana = Blue2Mana - 50
				Blue2Step = 1
			end
		else
			if (Blue2Mana > 149) then
				CreateUnit("unit-knight", BlueTeam2, {Blue2Temp_x, Blue2Temp_y})
				Blue2Mana = Blue2Mana - 150
				Blue2Step = 1
			end
		end
	else
		if ((Blue2Mana > 289) and (Blue2Mana < 599)) then
			CreateUnit("unit-paladin", BlueTeam2, {Blue2Temp_x, Blue2Temp_y})
			Blue2Mana = Blue2Mana - 250
			Blue2Step = 1
		else
			if (Blue2Mana > 249) then
				CreateUnit("unit-ballista", BlueTeam2, {Blue2Temp_x, Blue2Temp_y})
				Blue2Mana = Blue2Mana - 250
				Blue2Step = 1
			end
		end
	end
	if (Blue2Step == 1) then
		if (Blue2Temp_x ~= nil) then
			if (Blue2Temp_x == BlueTeam2_x2) then
				if (Blue2Temp_y == BlueTeam2_y2) then
					-- Oh shit, I've used up all my spaces.
				else
					Blue2Temp_x = BlueTeam2_x1
					Blue2Temp_y = Blue2Temp_y + 1
				end
			else
				Blue2Temp_x = Blue2Temp_x + 1
			end
		end
		Blue2Step = 0
	end
end

function AiBlue1_Basic()
	if (Blue1Temp_x ~= nil) then
	else
		Blue1Temp_x = BlueTeam1_x1
		Blue1Temp_y = BlueTeam1_y1
		Blue1Step = 0
		Blue1Mana = 150
	end
	if ((timer == 25) or (timer == 75)) then
		Blue1Mana = Blue1Mana + 55
	end
	if ((timer == 50) or (timer == 98)) then
		Blue1Mana = Blue1Mana + 53
	end
	if (GetNumUnitsAt(BlueTeam1, "unit-knight", {BlueTeam1_x1, BlueTeam1_y1}, {BlueTeam1_x2, BlueTeam1_y2}) < 8) then
		if (GetNumUnitsAt(BlueTeam1, "unit-footman", {BlueTeam1_x1, BlueTeam1_y1}, {BlueTeam1_x2, BlueTeam1_y2}) < 12) then
			if (Blue1Mana > 49) then
				if ((GetPlayerData(BlueTeam1, "UnitTypesCount", AiEliteShooter()) == 0) and ((Blue1Mana > 90) and (Blue1Mana < 190))) then
					CreateUnit(AiEliteShooter(), BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
					Blue1Mana = Blue1Mana - 100
				else
					if ((Blue1Mana > 80) and (Blue1Mana < 95)) then
						CreateUnit("unit-archer", BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
					else
						CreateUnit("unit-footman", BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
					end
					Blue1Mana = Blue1Mana - 50
				end
				Blue1Step = 1
			end
		else
			if ((GetNumUnitsAt(BlueTeam1, "unit-grunt", {BlueTeam1_x1, BlueTeam1_y1}, {BlueTeam1_x2, BlueTeam1_y2}) < 5) or (GetNumUnitsAt(BlueTeam1, AiCavalryMage(), {BlueTeam1_x1, BlueTeam1_y1}, {BlueTeam1_x2, BlueTeam1_y2}) > 0)) then
				if (Blue1Mana > 149) then
					CreateUnit("unit-knight", BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
					Blue1Mana = Blue1Mana - 150
					Blue1Step = 1
				end
			else
				if (Blue1Mana > 250) then
					CreateUnit(AiCavalryMage(), BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
					Blue1Mana = Blue1Mana - 250
					Blue1Step = 1
				end
			end
		end
	else
		if ((Blue1Mana > 289) and (Blue1Mana < 599)) then
			CreateUnit("unit-paladin", BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
			Blue1Mana = Blue1Mana - 250
			Blue1Step = 1
		else
			if (Blue1Mana > 249) then
				CreateUnit("unit-ballista", BlueTeam1, {Blue1Temp_x, Blue1Temp_y})
				Blue1Mana = Blue1Mana - 250
				Blue1Step = 1
			end
		end
	end
	if (Blue1Step == 1) then
		if (Blue1Temp_x ~= nil) then
			if (Blue1Temp_x == BlueTeam1_x2) then
				if (Blue1Temp_y == BlueTeam1_y2) then
					-- Oh shit, I've used up all my spaces.
				else
					Blue1Temp_x = BlueTeam1_x1
					Blue1Temp_y = Blue1Temp_y + 1
				end
			else
				Blue1Temp_x = Blue1Temp_x + 1
			end
		end
		Blue1Step = 0
	end
end

DefineAi("ai_blueribbon", "*", "ai_blueribbon", AiBlueRibbon)
DefineAi("ai_blue2", "*", "ai_blue2", AiBlue2)
DefineAi("ai_blue1", "*", "ai_blue1", AiBlue1)
