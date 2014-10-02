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
--	(c) Copyright 2011-2012 by Kyran Jackson
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

-- 		Currently doesn't support ships.

local timer
local redribbon_stepping -- Used to identify where the build order is up to.
local blueribbon_stepping -- Used to identify where the build order is up to.


function AiRedRibbon_Research_2012()
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
				AiResearch(AiUpgradeMissile1())
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 1) then
						AiResearch(AiUpgradeMissile2())
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) >= 1) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) >= 1) then
							AiResearch(AiUpgradeEliteShooter())
							AiResearch(AiUpgradeEliteShooter1())
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
end

function AiBlueRibbon_2012()
	-- Setting up the variables.
	if (blueribbon_stepping ~= nil) then
	else
		-- print ("Setting up the variables.")
		BlueLeader = AiPlayer()
		-- Timer related
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitMinutemanNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitYeomanNum = 0
		UnitHeroRiderNum = 0
		UnitMageNum = 0
		UnitMinutemanNum = 0
		UnitHeroSoldierNum = 0
		UnitHeroShooterNum = 0
		blueribbon_stepping = 7
		SetPlayerData(BlueLeader, "Resources", "oil", 5000)
    end
	-- Let's check out our surroundings.
	if ((timer == 50) or (timer == 99)) then
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitMinutemanNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitYeomanNum = 0
		UnitHeroRiderNum = 0
		UnitMageNum = 0
		UnitMinutemanNum = 0
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
		end
		if ((GetNumUnitsAt(BlueTemp, AiEliteShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, AiShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, AiLonerShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, AiHeroShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0)) then
			if (GetNumUnitsAt(BlueLeader, AiBarracks(), {(BlueBarracks2_x - 3), (BlueBarracks2_y - 3)}, {(BlueBarracks2_x + 3), (BlueBarracks2_y + 3)}) > 0) then
				if (GetNumUnitsAt(BlueTemp, AiEliteShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					UnitRangerNum = GetNumUnitsAt(BlueTemp, AiEliteShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
					for UnitUpto = BlueLeader,UnitRangerNum do
						CreateUnit(AiEliteShooter(), BlueLeader, {BlueBarracks2_x, BlueBarracks2_y})
					end
				end
				if (GetNumUnitsAt(BlueTemp, AiShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
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
				if (GetNumUnitsAt(BlueTemp, AiLonerShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					UnitYeomanNum = GetNumUnitsAt(BlueTemp, AiLonerShooter(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2})
					for UnitUpto = BlueLeader,(UnitYeomanNum) do
						CreateUnit(AiLonerShooter(), BlueLeader, {BlueBarracks2_x, BlueBarracks2_y})
					end
				end
			end
		end
		if (GetNumUnitsAt(BlueLeader, AiMageTower(), {(BlueMageTower_x - 3), (BlueMageTower_y - 3)}, {(BlueMageTower_x + 3), (BlueMageTower_y + 3)}) > 0) then
			if ((GetNumUnitsAt(BlueTemp, "unit-caanoo-wiseman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, "unit-mage", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0)) then
				UnitMageNum = (GetNumUnitsAt(BlueTemp, "unit-caanoo-wiseman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) + GetNumUnitsAt(BlueTemp, "unit-mage", {0, 0}, {92, 256}) )
				for UnitUpto = BlueLeader,UnitMageNum do
					CreateUnit("unit-mage", BlueLeader, {BlueMageTower_x, BlueMageTower_y})
				end
			end
			if (GetNumUnitsAt(BlueTemp, AiFodder(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				UnitMinutemanNum = (GetNumUnitsAt(BlueTemp, AiFodder(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) + GetNumUnitsAt(BlueTemp, "unit-mage", {0, 0}, {92, 256}) )
				for UnitUpto = BlueLeader,UnitMinutemanNum do
					CreateUnit(AiFodder(), BlueLeader, {BlueMageTower_x, BlueMageTower_y})
				end
			end
		end
		if (GetNumUnitsAt(BlueLeader, AiBarracks(), {(BlueBarracks3_x - 3), (BlueBarracks3_y - 3)}, {(BlueBarracks3_x + 3), (BlueBarracks3_y + 3)}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiCavalry(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
				UnitKnightNum = GetNumUnitsAt(BlueTemp, AiCavalry(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitKnightNum do
					CreateUnit(AiCavalry(), BlueLeader, {BlueBarracks3_x, BlueBarracks3_y})
				end
			end
			if (GetNumUnitsAt(BlueTemp, AiCavalryMage(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
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
				UnitBallistaNum = GetNumUnitsAt(BlueTemp, AiCatapult(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitBallistaNum do
					CreateUnit(AiCatapult(), BlueLeader, {BlueBarracks4_x, BlueBarracks4_y})
				end
			end
		end
		if (GetNumUnitsAt(BlueLeader, AiScientific(), {(BlueInventor_x - 3), (BlueInventor_y - 3)}, {(BlueInventor_x + 3), (BlueInventor_y + 3)}) > 0) then
			if (GetNumUnitsAt(BlueTemp, AiSuicideBomber(), {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
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
		AiForce(1, {AiFlyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer())}, true)
		AiAttackWithForce(1)
		AiNephrite_Attack_2013()
	end
	if (timer == 100) then
		timer = 0
	end
	if ((timer == 75) or (timer == 25)) then
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitMageNum = 0
		UnitMinutemanNum = 0
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
		AiForce(1, {AiFodder(), UnitMinutemanNum, AiSuicideBomber(), UnitDwarvesNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitFootmanNum, AiShooter(), UnitArcherNum, AiEliteShooter(), UnitRangerNum, AiCavalry(), UnitKnightNum, AiCavalryMage(), UnitPaladinNum, AiCatapult(), UnitCatapultNum}, true)
		if (AiCheckForce(1)) then 
			AiAttackWithForce(1)
		end
	end
	AiRedRibbon_Research_2012()
	if ((timer == 35) or (timer == 85)) then
		AiNephrite_Flush_2013()
	end
end

function AiBlue1()
	if (BlueTeam1_2014 == true) then
		timer = timers[ftm_team[AiPlayer()]]
	end
	if (BlueTeam1_x1 == nil) then
		BlueTeam1_2014 = true
		BlueTeam1 = AiPlayer()
		BlueTeam1_x1 = ftm_team_x1[AiPlayer()]
		BlueTeam1_y1 = ftm_team_y1[AiPlayer()]
		BlueTeam1_x2 = ftm_team_x2[AiPlayer()]
		BlueTeam1_y2 = ftm_team_y2[AiPlayer()]
		BlueTeam1_xw = ftm_team_startx[AiPlayer()]
		BlueTeam1_yw = ftm_team_starty[AiPlayer()]
		if (BlueTeam1_Order ~= nil) then else
			if (ftm_team_ordery[AiPlayer()] == "Down") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					BlueTeam1_Order = "Top-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					BlueTeam1_Order = "Top-Left"
				end
			elseif (ftm_team_ordery[AiPlayer()] == "Up") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					BlueTeam1_Order = "Bottom-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					BlueTeam1_Order = "Bottom-Left"
				end
			else
				BlueTeam1_Order = "Wise"
			end
		end
		timer = 1
	else
		if (BlueTeam1Dead ~= true) then
			if ((GetPlayerData(BlueTeam1, "UnitTypesCount", "unit-caanoo-wiseman") > 0) and (GameCycle > 500)) then
				AiBlue1_Basic()
			end
		end
	end
end

function AiBlue2()
	if (BlueTeam2_2014 == true) then
		timer = timers[ftm_team[AiPlayer()]]
	end
	if (BlueTeam2_x1 == nil) then
		BlueTeam2_2014 = true
		BlueTeam2 = AiPlayer()
		BlueTeam2_x1 = ftm_team_x1[AiPlayer()]
		BlueTeam2_y1 = ftm_team_y1[AiPlayer()]
		BlueTeam2_x2 = ftm_team_x2[AiPlayer()]
		BlueTeam2_y2 = ftm_team_y2[AiPlayer()]
		BlueTeam2_xw = ftm_team_startx[AiPlayer()]
		BlueTeam2_yw = ftm_team_starty[AiPlayer()]
		if (BlueTeam2_Order ~= nil) then else
			if (ftm_team_ordery[AiPlayer()] == "Down") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					BlueTeam2_Order = "Top-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					BlueTeam2_Order = "Top-Left"
				end
			elseif (ftm_team_ordery[AiPlayer()] == "Up") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					BlueTeam2_Order = "Bottom-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					BlueTeam2_Order = "Bottom-Left"
				end
			else
				BlueTeam2_Order = "Wise"
			end
		end
		timer = 1
	else
		if (BlueTeam1Dead ~= true) then
			if ((GetPlayerData(BlueTeam2, "UnitTypesCount", "unit-caanoo-wiseman") > 0) and (GameCycle > 500)) then
				AiBlue2_Basic()
			end
		end
	end
end

function AiBlue2_Basic()
	if (Blue2Temp_x ~= nil) then else
		if (BlueTeam2_Order ~= nil) then else
			BlueTeam2_Order = "Top-Right"
		end
		if (BlueTeam2_Order == "Top-Right") then
			-- Top-Right means start at top, go right.
			Blue2Temp_x = BlueTeam2_x1
			Blue2Temp_y = BlueTeam2_y1
		elseif (BlueTeam2_Order == "Top-Left") then
			Blue2Temp_x = BlueTeam2_x2
			Blue2Temp_y = BlueTeam2_y1
		elseif (BlueTeam2_Order == "Bottom-Right") then
			Blue2Temp_x = BlueTeam2_x1
			Blue2Temp_y = BlueTeam2_y2
		elseif (BlueTeam2_Order == "Bottom-Left") then
			Blue2Temp_x = BlueTeam2_x2
			Blue2Temp_y = BlueTeam2_y2
		elseif (BlueTeam2_Order == "Wise") then
			Blue2Temp_x = BlueTeam2_xw
			Blue2Temp_y = BlueTeam2_yw
		end
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
			if (BlueTeam2_Order == "Top-Right") then
				if (Blue2Temp_x == BlueTeam2_x2) then
					if (Blue2Temp_y == BlueTeam2_y2) then
						-- Oh shit, I've used up all my spaces.
						Blue2Temp_x = BlueTeam2_x1
						Blue2Temp_y = BlueTeam2_y1
					else
						Blue2Temp_x = BlueTeam2_x1
						Blue2Temp_y = Blue2Temp_y + 1
					end
				else
					Blue2Temp_x = Blue2Temp_x + 1
				end
			end
			if (BlueTeam2_Order == "Top-Left") then
				if (Blue2Temp_x == BlueTeam2_x1) then
					if (Blue2Temp_y == BlueTeam2_y2) then
						-- Oh shit, I've used up all my spaces.
						Blue2Temp_x = BlueTeam2_x1
						Blue2Temp_y = BlueTeam2_y1
					else
						Blue2Temp_x = BlueTeam2_x2
						Blue2Temp_y = Blue2Temp_y + 1
					end
				else
					Blue2Temp_x = Blue2Temp_x - 1
				end
			end
			if (BlueTeam2_Order == "Bottom-Right") then
				if (Blue2Temp_x == BlueTeam2_x2) then
					if (Blue2Temp_y == BlueTeam2_y1) then
						-- Oh shit, I've used up all my spaces.
						Blue2Temp_x = BlueTeam2_x1
						Blue2Temp_y = BlueTeam2_y2
					else
						Blue2Temp_x = BlueTeam2_x1
						Blue2Temp_y = Blue2Temp_y - 1
					end
				else
					Blue2Temp_x = Blue2Temp_x + 1
				end
			end
			if (BlueTeam2_Order == "Bottom-Left") then
				if (Blue2Temp_x == BlueTeam2_x1) then
					if (Blue2Temp_y == BlueTeam2_y1) then
						-- Oh shit, I've used up all my spaces.
						Blue2Temp_x = BlueTeam2_x1
						Blue2Temp_y = BlueTeam2_y2
					else
						Blue2Temp_x = BlueTeam2_x2
						Blue2Temp_y = Blue2Temp_y - 1
					end
				else
					Blue2Temp_x = Blue2Temp_x - 1
				end
			end
		end
		Blue2Step = 0
	end
end

function AiBlue1_Basic()
	if (Blue1Temp_x ~= nil) then else
		if (BlueTeam1_Order ~= nil) then else
			BlueTeam1_Order = "Top-Right"
		end
		if (BlueTeam1_Order == "Top-Right") then
			-- Top-Right means start at top, go right.
			Blue1Temp_x = BlueTeam1_x1
			Blue1Temp_y = BlueTeam1_y1
		elseif (BlueTeam1_Order == "Top-Left") then
			Blue1Temp_x = BlueTeam1_x2
			Blue1Temp_y = BlueTeam1_y1
		elseif (BlueTeam1_Order == "Bottom-Right") then
			Blue1Temp_x = BlueTeam1_x1
			Blue1Temp_y = BlueTeam1_y2
		elseif (BlueTeam1_Order == "Bottom-Left") then
			Blue1Temp_x = BlueTeam1_x2
			Blue1Temp_y = BlueTeam1_y2
		elseif (BlueTeam1_Order == "Wise") then
			Blue1Temp_x = BlueTeam1_xw
			Blue1Temp_y = BlueTeam1_yw
		end
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
			if (BlueTeam1_Order == "Top-Right") then
				if (Blue1Temp_x == BlueTeam1_x2) then
					if (Blue1Temp_y == BlueTeam1_y2) then
						-- Oh shit, I've used up all my spaces.
						Blue1Temp_x = BlueTeam1_x1
						Blue1Temp_y = BlueTeam1_y1
					else
						Blue1Temp_x = BlueTeam1_x1
						Blue1Temp_y = Blue1Temp_y + 1
					end
				else
					Blue1Temp_x = Blue1Temp_x + 1
				end
			end
			if (BlueTeam1_Order == "Top-Left") then
				if (Blue1Temp_x == BlueTeam1_x1) then
					if (Blue1Temp_y == BlueTeam1_y2) then
						-- Oh shit, I've used up all my spaces.
						Blue1Temp_x = BlueTeam1_x1
						Blue1Temp_y = BlueTeam1_y1
					else
						Blue1Temp_x = BlueTeam1_x2
						Blue1Temp_y = Blue1Temp_y + 1
					end
				else
					Blue1Temp_x = Blue1Temp_x - 1
				end
			end
			if (BlueTeam1_Order == "Bottom-Right") then
				if (Blue1Temp_x == BlueTeam1_x2) then
					if (Blue1Temp_y == BlueTeam1_y1) then
						-- Oh shit, I've used up all my spaces.
						Blue1Temp_x = BlueTeam1_x1
						Blue1Temp_y = BlueTeam1_y2
					else
						Blue1Temp_x = BlueTeam1_x1
						Blue1Temp_y = Blue1Temp_y - 1
					end
				else
					Blue1Temp_x = Blue1Temp_x + 1
				end
			end
			if (BlueTeam1_Order == "Bottom-Left") then
				if (Blue1Temp_x == BlueTeam1_x1) then
					if (Blue1Temp_y == BlueTeam1_y1) then
						-- Oh shit, I've used up all my spaces.
						Blue1Temp_x = BlueTeam1_x1
						Blue1Temp_y = BlueTeam1_y2
					else
						Blue1Temp_x = BlueTeam1_x2
						Blue1Temp_y = Blue1Temp_y - 1
					end
				else
					Blue1Temp_x = Blue1Temp_x - 1
				end
			end
		end
		Blue1Step = 0
	end
end

function AiRedRibbon_2012()
	-- Setting up the variables.
	if (redribbon_stepping ~= nil) then
		--AddMessage("Stepping is nill.")
	else
		-- print ("Setting up the variables.")
		RedLeader = AiPlayer()
		-- Timer related
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitSkeletonNum = 0
		UnitEliteShooterNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitGoblinSappersNum = 0
		UnitEliteRiderNum = 0
		UnitOgreMageNum = 0
		UnitNomadNum = 0
		UnitFlyerNum = 0
		UnitWorkerNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
		timer = 1
		Blue2Mana = 0
		Blue1Mana = 0
		Red1Mana = 0
		Red1Mana = 0
		redribbon_stepping = 7
		SetPlayerData(RedLeader, "Resources", "oil", 5000)
    end
	timer = timer + 1
	if (timer == 100) then
		timer = 0
	end
	if ((timer == 49) or (timer == 99)) then
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitSkeletonNum = 0
		UnitEliteShooterNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitNomadNum = 0
		UnitGoblinSappersNum = 0
		UnitEliteRiderNum = 0
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
		end
		if ((GetNumUnitsAt(RedTemp, AiEliteShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, AiShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, AiLonerShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)  or (GetNumUnitsAt(RedTemp, AiHeroShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)) then
			if (GetNumUnitsAt(RedLeader, AiBarracks(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)}) > 0) then
				if (GetNumUnitsAt(RedTemp, AiEliteShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					UnitBerserkerNum = GetNumUnitsAt(RedTemp, AiEliteShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitBerserkerNum - 1) do
						CreateUnit(AiEliteShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				if (GetNumUnitsAt(RedTemp, AiShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					UnitAxethrowerNum = GetNumUnitsAt(RedTemp, AiShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitAxethrowerNum - 1) do
						CreateUnit(AiShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				if (GetNumUnitsAt(RedTemp, AiHeroShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					UnitEliteShooterNum = GetNumUnitsAt(RedTemp, AiHeroShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitEliteShooterNum - 1) do
						CreateUnit(AiHeroShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				if (GetNumUnitsAt(RedTemp, AiLonerShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					UnitNomadNum = GetNumUnitsAt(RedTemp, AiLonerShooter(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitNomadNum - 1) do
						CreateUnit(AiLonerShooter(), RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
			end
		end
		if ((GetNumUnitsAt(RedTemp, "unit-caanoo-wiseskeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, AiMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)) then
			UnitDeathKnightNum = (GetNumUnitsAt(RedTemp, "unit-caanoo-wiseskeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) + GetNumUnitsAt(RedTemp, AiMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}))
			for UnitUpto = RedLeader,(UnitDeathKnightNum - 1) do
				CreateUnit(AiMage(), RedLeader, {RedMageTower_x, RedMageTower_y})
			end
		end
		if (GetNumUnitsAt(RedTemp, AiFodder(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			UnitSkeletonNum = GetNumUnitsAt(RedTemp, AiFodder(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
			for UnitUpto = RedLeader,(UnitSkeletonNum - 1) do
				CreateUnit(AiFodder(), RedLeader, {RedMageTower_x, RedMageTower_y})
			end
		end
		if (GetNumUnitsAt(RedLeader, AiBarracks(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)}) > 0) then
			if (GetNumUnitsAt(RedTemp, AiCavalry(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				if (GetNumUnitsAt(RedLeader, "unit-orcbarracks", {RedBarracks3_x - 3, RedBarracks3_y - 3}, {RedBarracks3_x + 3, RedBarracks3_y + 3}) > 0) then
					UnitOgreNum = GetNumUnitsAt(RedTemp, AiCavalry(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
					for UnitUpto = RedLeader,(UnitOgreNum - 1) do
						CreateUnit(AiCavalry(), RedLeader, {RedBarracks3_x, RedBarracks3_y})
					end
				end
			end
			if (GetNumUnitsAt(RedTemp, AiCavalryMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				UnitOgreMageNum = GetNumUnitsAt(RedTemp, AiCavalryMage(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitOgreMageNum - 1) do
					CreateUnit(AiCavalryMage(), RedLeader, {RedBarracks3_x, RedBarracks3_y})
				end
			end
			if (GetNumUnitsAt(RedTemp, AiHeroRider(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
				UnitEliteRiderNum = GetNumUnitsAt(RedTemp, AiHeroRider(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitEliteRiderNum - 1) do
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
				UnitCatapultNum = GetNumUnitsAt(RedTemp, AiCatapult(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
				for UnitUpto = RedLeader,(UnitCatapultNum - 1) do
					CreateUnit(AiCatapult(), RedLeader, {RedBarracks4_x, RedBarracks4_y})
				end
			end
		end
		if (GetNumUnitsAt(RedTemp, AiSuicideBomber(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			UnitGoblinSappersNum = GetNumUnitsAt(RedTemp, AiSuicideBomber(), {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2})
			for UnitUpto = RedLeader,(UnitGoblinSappersNum - 1) do
				CreateUnit(AiSuicideBomber(), RedLeader, {RedInventor_x, RedInventor_y})
			end
		end
		-- Not having a value for UnitNum will cause a crash.
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
			UnitEliteShooterNum = GetNumUnitsAt(RedLeader, AiHeroShooter(), {(RedBarracks2_x - 3), (RedBarracks2_y - 3)}, {(RedBarracks2_x + 3), (RedBarracks2_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiCavalry(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)}) > 0) then
			UnitOgreNum = GetNumUnitsAt(RedLeader, AiCavalry(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)})
		end
		if (GetNumUnitsAt(RedLeader, AiCavalryMage(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)}) > 0) then
			UnitOgreMageNum = GetNumUnitsAt(RedLeader, AiCavalryMage(), {(RedBarracks3_x - 3), (RedBarracks3_y - 3)}, {(RedBarracks3_x + 3), (RedBarracks3_y + 3)})
		end
		AiForce(1, {AiFodder(), UnitSkeletonNum, AiSuicideBomber(), UnitGoblinSappersNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitGruntNum, AiShooter(), UnitAxethrowerNum, AiEliteShooter(), UnitBerserkerNum, AiCavalry(), UnitOgreNum, AiCavalryMage(), UnitOgreMageNum, AiCatapult(), UnitCatapultNum}, true)
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
	if (GetPlayerData(BlueLeader, "UnitTypesCount", AiHarbor()) < 1) then
		if (GetPlayerData(BlueLeader, "UnitTypesCount", AiTanker()) > 0) then
			KillUnit(AiTanker(), BlueLeader)
		end
		if (GetPlayerData(BlueLeader, "UnitTypesCount", AiPlatform()) > 0) then
			KillUnit(AiPlatform(), BlueLeader)
		end
	end
	AiRedRibbon_Research_2012()
	if ((timer == 35) or (timer == 85)) then
		AiNephrite_Flush_2013()
	end
end

function AiRed1_2012()
	if (RedTeam1_2014 == true) then
		timer = timers[ftm_team[AiPlayer()]]
	end
	if (RedTeam1_x1 == nil) then
		RedTeam1_2014 = true
		RedTeam1 = AiPlayer()
		RedTeam1_x1 = ftm_team_x1[AiPlayer()]
		RedTeam1_y1 = ftm_team_y1[AiPlayer()]
		RedTeam1_x2 = ftm_team_x2[AiPlayer()]
		RedTeam1_y2 = ftm_team_y2[AiPlayer()]
		RedTeam1_xw = ftm_team_startx[AiPlayer()]
		RedTeam1_yw = ftm_team_starty[AiPlayer()]
		if (RedTeam1_Order ~= nil) then else
			if (ftm_team_ordery[AiPlayer()] == "Down") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					RedTeam1_Order = "Top-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					RedTeam1_Order = "Top-Left"
				end
			elseif (ftm_team_ordery[AiPlayer()] == "Up") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					RedTeam1_Order = "Bottom-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					RedTeam1_Order = "Bottom-Left"
				end
			else
				RedTeam1_Order = "Wise"
			end
		end
		timer = 1
	else
		if ((GetPlayerData(RedTeam1, "UnitTypesCount", "unit-caanoo-wiseskeleton") > 0) and (GameCycle > 500)) then
			AiRed1_Basic_2012()
		end
	end
end

function AiRed2_2012()
	if (RedTeam2_2014 == true) then
		timer = timers[ftm_team[AiPlayer()]]
	end
	if (RedTeam2_x1 == nil) then
		RedTeam2_2014 = true
		RedTeam2 = AiPlayer()
		RedTeam2_x1 = ftm_team_x1[AiPlayer()]
		RedTeam2_y1 = ftm_team_y1[AiPlayer()]
		RedTeam2_x2 = ftm_team_x2[AiPlayer()]
		RedTeam2_y2 = ftm_team_y2[AiPlayer()]
		RedTeam2_xw = ftm_team_startx[AiPlayer()]
		RedTeam2_yw = ftm_team_starty[AiPlayer()]
		if (RedTeam2_Order ~= nil) then else
			if (ftm_team_ordery[AiPlayer()] == "Down") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					RedTeam2_Order = "Top-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					RedTeam2_Order = "Top-Left"
				end
			elseif (ftm_team_ordery[AiPlayer()] == "Up") then 
				if (ftm_team_orderx[AiPlayer()] == "Right") then
					RedTeam2_Order = "Bottom-Right"
				elseif (ftm_team_orderx[AiPlayer()] == "Left") then
					RedTeam2_Order = "Bottom-Left"
				end
			else
				RedTeam2_Order = "Wise"
			end
		end
		timer = 1
		redribbon_stepping = 7
	else
		if ((GetPlayerData(RedTeam2, "UnitTypesCount", "unit-caanoo-wiseskeleton") > 0) and (GameCycle > 500)) then
			AiRed2_Basic_2012()
		end
	end
end

function AiRed2_Basic_2012()
	if (Red2Temp_x ~= nil) then else
		if (RedTeam2_Order ~= nil) then else
			RedTeam2_Order = "Top-Right"
		end
		if (RedTeam2_Order == "Top-Right") then
			-- Top-Right means start at top, go right.
			Red2Temp_x = RedTeam2_x1
			Red2Temp_y = RedTeam2_y1
		elseif (RedTeam2_Order == "Top-Left") then
			Red2Temp_x = RedTeam2_x2
			Red2Temp_y = RedTeam2_y1
		elseif (RedTeam2_Order == "Bottom-Right") then
			Red2Temp_x = RedTeam2_x1
			Red2Temp_y = RedTeam2_y2
		elseif (RedTeam2_Order == "Bottom-Left") then
			Red2Temp_x = RedTeam2_x2
			Red2Temp_y = RedTeam2_y2
		elseif (RedTeam2_Order == "Wise") then
			Red2Temp_x = RedTeam2_xw
			Red2Temp_y = RedTeam2_yw
		end
		Red2Step = 0
		Red2Mana = 150
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
			if (RedTeam2_Order == "Top-Right") then
				if (Red2Temp_x == RedTeam2_x2) then
					if (Red2Temp_y == RedTeam2_y2) then
						-- Oh shit, I've used up all my spaces.
						Red2Temp_x = RedTeam2_x1
						Red2Temp_y = RedTeam2_y1
					else
						Red2Temp_x = RedTeam2_x1
						Red2Temp_y = Red2Temp_y + 1
					end
				else
					Red2Temp_x = Red2Temp_x + 1
				end
			end
			if (RedTeam2_Order == "Top-Left") then
				if (Red2Temp_x == RedTeam2_x1) then
					if (Red2Temp_y == RedTeam2_y2) then
						-- Oh shit, I've used up all my spaces.
						Red2Temp_x = RedTeam2_x1
						Red2Temp_y = RedTeam2_y1
					else
						Red2Temp_x = RedTeam2_x2
						Red2Temp_y = Red2Temp_y + 1
					end
				else
					Red2Temp_x = Red2Temp_x - 1
				end
			end
			if (RedTeam2_Order == "Bottom-Right") then
				if (Red2Temp_x == RedTeam2_x2) then
					if (Red2Temp_y == RedTeam2_y1) then
						-- Oh shit, I've used up all my spaces.
						Red2Temp_x = RedTeam2_x1
						Red2Temp_y = RedTeam2_y2
					else
						Red2Temp_x = RedTeam2_x1
						Red2Temp_y = Red2Temp_y - 1
					end
				else
					Red2Temp_x = Red2Temp_x + 1
				end
			end
			if (RedTeam2_Order == "Bottom-Left") then
				if (Red2Temp_x == RedTeam2_x1) then
					if (Red2Temp_y == RedTeam2_y1) then
						-- Oh shit, I've used up all my spaces.
						Red2Temp_x = RedTeam2_x1
						Red2Temp_y = RedTeam2_y2
					else
						Red2Temp_x = RedTeam2_x2
						Red2Temp_y = Red2Temp_y - 1
					end
				else
					Red2Temp_x = Red2Temp_x - 1
				end
			end
		end
		Red2Step = 0
	end
end

function AiRed1_Basic_2012()
	if (Red1Temp_x ~= nil) then else
		if (RedTeam1_Order ~= nil) then else
			RedTeam1_Order = "Top-Right"
		end
		if (RedTeam1_Order == "Top-Right") then
			-- Top-Right means start at top, go right.
			Red1Temp_x = RedTeam1_x1
			Red1Temp_y = RedTeam1_y1
		elseif (RedTeam1_Order == "Top-Left") then
			Red1Temp_x = RedTeam1_x2
			Red1Temp_y = RedTeam1_y1
		elseif (RedTeam1_Order == "Bottom-Right") then
			Red1Temp_x = RedTeam1_x1
			Red1Temp_y = RedTeam1_y2
		elseif (RedTeam1_Order == "Bottom-Left") then
			Red1Temp_x = RedTeam1_x2
			Red1Temp_y = RedTeam1_y2
		elseif (RedTeam1_Order == "Wise") then
			Red1Temp_x = RedTeam1_xw
			Red1Temp_y = RedTeam1_yw
		end
		Red1Step = 0
		Red1Mana = 150
	end
	if ((timer == 25) or (timer == 75)) then
		Red1Mana = Red1Mana + 52
	end
	if ((timer == 50) or (timer == 98)) then
		Red1Mana = Red1Mana + 53
	end
	if (((RedTeam1_x2 - RedTeam1_x1)*(RedTeam1_y2 - RedTeam1_y1)) < 19) then
		if (GetNumUnitsAt(RedTeam1, AiFodder(), {RedTeam1_x1, RedTeam1_y1}, {RedTeam1_x2, RedTeam1_y2}) < 4) then
			if ((Red1Mana > 20) and (Red1Mana < 40)) then
				CreateUnit(AiFodder(), RedTeam1, {Red1Temp_x, Red1Temp_y})
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
					if ((GetPlayerData(RedTeam1, "UnitTypesCount", AiEliteShooter()) == 0) and ((Red1Mana > 90) and (Red1Mana < 190))) then
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
			if (RedTeam1_Order == "Top-Right") then
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
			if (RedTeam1_Order == "Top-Left") then
				if (Red1Temp_x == RedTeam1_x1) then
					if (Red1Temp_y == RedTeam1_y2) then
						-- Oh shit, I've used up all my spaces.
						Red1Temp_x = RedTeam1_x1
						Red1Temp_y = RedTeam1_y1
					else
						Red1Temp_x = RedTeam1_x2
						Red1Temp_y = Red1Temp_y + 1
					end
				else
					Red1Temp_x = Red1Temp_x - 1
				end
			end
			if (RedTeam1_Order == "Bottom-Right") then
				if (Red1Temp_x == RedTeam1_x2) then
					if (Red1Temp_y == RedTeam1_y1) then
						-- Oh shit, I've used up all my spaces.
						Red1Temp_x = RedTeam1_x1
						Red1Temp_y = RedTeam1_y2
					else
						Red1Temp_x = RedTeam1_x1
						Red1Temp_y = Red1Temp_y - 1
					end
				else
					Red1Temp_x = Red1Temp_x + 1
				end
			end
			if (RedTeam1_Order == "Bottom-Left") then
				if (Red1Temp_x == RedTeam1_x1) then
					if (Red1Temp_y == RedTeam1_y1) then
						-- Oh shit, I've used up all my spaces.
						Red1Temp_x = RedTeam1_x1
						Red1Temp_y = RedTeam1_y2
					else
						Red1Temp_x = RedTeam1_x2
						Red1Temp_y = Red1Temp_y - 1
					end
				else
					Red1Temp_x = Red1Temp_x - 1
				end
			end
		end
		Red1Step = 0
	end
end

DefineAi("ai_redribbon_2012", "*", "ai_redribbon_2012", AiRedRibbon_2012)
DefineAi("ai_red2", "*", "ai_red2", AiRed2_2012)
DefineAi("ai_red1", "*", "ai_red1", AiRed1_2012)
DefineAi("ai_blueribbon_2012", "*", "ai_blueribbon_2012", AiBlueRibbon_2012)
DefineAi("ai_blue2", "*", "ai_blue2", AiBlue2)
DefineAi("ai_blue1", "*", "ai_blue1", AiBlue1)