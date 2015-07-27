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
--	level06h_ai.lua 
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

local timer
local gametimer

function AiStartAttack()
	SetDiplomacy(0, "allied", 1)
	SetDiplomacy(1, "allied", 0)
	SetDiplomacy(4, "allied", 1)
end

function AiEndAttack()
	if (GameCycle >= 9500) then
		SetDiplomacy(0, "enemy", 1)
		SetDiplomacy(1, "enemy", 0)
		SetDiplomacy(4, "enemy", 1)
		SetDiplomacy(1, "enemy", 4)
	end
	SetDiplomacy(4, "enemy", 1)
end

function AiLevel07()
	if (GetNumUnitsAt(1, "unit-castle", {60, 70}, {70, 80}) < 1) then
	--	if (GetNumUnitsAt(4, AiEliteSoldier(), {65, 85}, {70, 80}) > 0) then
			
		--else
			--ActionDefeat()
		--end
	end
	if (timer == nil) then
		timer = 1
		gametimer = 1
		forceid = 1
		SetDiplomacy(4, "enemy", 0)
		SetDiplomacy(0, "enemy", 4)
		SetDiplomacy(0, "allied", 2)
		SetDiplomacy(2, "allied", 0)
		SetSharedVision(2, true, 0)
		SetSharedVision(0, true, 2)
	end
	if (timer > 0) then
		timer = timer + 1
		if (gametimer < 800) then
		if (timer == 50) then
			CreateUnit("unit-footman", 0, {101, 92})
			CreateUnit("unit-footman", 0, {119, 88})
			CreateUnit("unit-footman", 0, {110, 98})
			CreateUnit("unit-footman", 0, {122, 94})
			CreateUnit(AiWorker(), 0, {67, 87})
			CreateUnit(AiWorker(), 0, {67, 87})
			CreateUnit("unit-footman", 0, {67, 87})
			CreateUnit("unit-grunt", 4, {0, 116})
			CreateUnit("unit-grunt", 4, {0, 117})
			CreateUnit("unit-grunt", 4, {0, 118})
			CreateUnit("unit-grunt", 4, {0, 31})
			CreateUnit("unit-grunt", 4, {0, 30})
			CreateUnit("unit-grunt", 4, {0, 31})
			CreateUnit("unit-axethrower", 4, {1, 116})
			CreateUnit("unit-axethrower", 4, {1, 117})
			CreateUnit("unit-axethrower", 4, {1, 118})
			CreateUnit("unit-grunt", 4, {0, 30})
			CreateUnit("unit-grunt", 4, {0, 29})
			CreateUnit("unit-grunt", 4, {0, 28})
			CreateUnit("unit-grunt", 4, {0, 27})
			CreateUnit("unit-grunt", 4, {0, 26})
		end
		if (timer == 100) then
			CreateUnit("unit-footman", 0, {95, 94})
			CreateUnit("unit-footman", 0, {113, 89})
			CreateUnit("unit-footman", 0, {67, 87})
			CreateUnit(AiWorker(), 0, {67, 87})
			CreateUnit(AiWorker(), 0, {67, 87})		
			CreateUnit("unit-footman", 0, {104, 100})
			CreateUnit("unit-footman", 0, {116, 96})
			CreateUnit("unit-grunt", 4, {0, 115})
			CreateUnit("unit-grunt", 4, {0, 114})
			CreateUnit("unit-grunt", 4, {0, 31})
			CreateUnit("unit-grunt", 4, {0, 32})
			CreateUnit("unit-grunt", 4, {0, 33})
			CreateUnit("unit-axethrower", 4, {1, 33})
			CreateUnit("unit-axethrower", 4, {1, 34})
			CreateUnit("unit-axethrower", 4, {1, 35})
			CreateUnit("unit-grunt", 4, {0, 34})
			CreateUnit("unit-grunt", 4, {0, 35})
		end
		end
		if ((timer > 195) and (timer < 201)) then
			SetDiplomacy(0, "allied", 1)
			SetDiplomacy(1, "allied", 0)
			SetDiplomacy(4, "allied", 1)
			if (AiPlayer() == 4) then
				AiForce(forceid, {AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()), AiShooter(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()))}, true)
				AiAttackWithForce(forceid)
			end
			if (AiPlayer() == 0) then
				AiForce(forceid, {AiSoldier(), 12}, true)
				AiAttackWithForce(forceid)
			end
			SetDiplomacy(0, "enemy", 1)
			SetDiplomacy(1, "enemy", 0)
			SetDiplomacy(4, "enemy", 1)
			if (AiPlayer() == 1) then
				SetDiplomacy(1, "allied", 4)
				SetDiplomacy(1, "allied", 2)	
				AiForce(forceid, {AiEliteSoldier(), 12}, true)
				AiAttackWithForce(forceid)	
				SetDiplomacy(1, "enemy", 4)
				SetDiplomacy(1, "enemy", 2)					
			end
			if (forceid > 8) then
				forceid = 1
			else
				forceid = forceid + 1
			end
		end
		if (timer > 200) then
			timer = 1
		end	
	else
		timer = 1
	end
	if (gametimer > 0) then
		gametimer = gametimer + 1
	else
		gametimer = 1
	end
	if ((gametimer > 240) and (gametimer < 250)) then
		gametimer = 1
	end
	if (gametimer > 1500) then
		gametimer = 600
	end
	-- Mythic Defender
	if ((timer == 101) or (timer == 51) or (timer == 150)) then
	if (AiPlayer() == 0) then
		if (GetNumUnitsAt(AiPlayer(), AiBarracks(), {0, 0}, {256, 256}) >= 4) then
			if (GetNumUnitsAt(AiPlayer(), AiSoldier(), {0, 0}, {256, 256}) >= 4) then
				AiForce(forceid, {AiSoldier(), 20}, true)
				if (GetNumUnitsAt(AiPlayer(), AiSoldier(), {0, 0}, {256, 256}) >= 20) then
					if (GetNumUnitsAt(AiPlayer(), AiBlacksmith(), {0, 0}, {256, 256}) >= 1) then
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeWeapon2())
						AiResearch(AiUpgradeArmor2())
					else
						AiSet(AiBlacksmith(), 1)
					end
					AiStartAttack()
					AiAttackWithForce(forceid)
					AiEndAttack()
				end
			else
				AiSet(AiSoldier(), 4)
			end
		else
			AiSet(AiBarracks(), 1)
		end
	end
	-- Wild Attacker
	if (AiPlayer() == 4) then
		if (GetNumUnitsAt(AiPlayer(), AiBarracks(), {0, 0}, {256, 256}) >= 1) then
			if (GetNumUnitsAt(AiPlayer(), AiSoldier(), {0, 0}, {256, 256}) >= 4) then
				AiForce(forceid, {AiSoldier(), 15}, true)
				AiForce(forceid + 3, {AiShooter(), 10}, true)
				if (GetNumUnitsAt(AiPlayer(), AiSoldier(), {0, 0}, {256, 256}) >= 8) then
					if (GetNumUnitsAt(AiPlayer(), AiBlacksmith(), {0, 0}, {256, 256}) >= 1) then
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeWeapon2())
						AiResearch(AiUpgradeArmor2())
					else
						AiSet(AiBlacksmith(), 1)
					end
					AiStartAttack()
					AiAttackWithForce(forceid)
					;AiAttackWithForce(forceid + 3)
					AiEndAttack()
				end
			else
				AiSet(AiSoldier(), 4)
			end
		else
			AiSet(AiBarracks(), 1)
		end
	end
	end
	-- Order Attacker
	if (AiPlayer() == 1) then
		if ((gametimer > 800) and (gametimer < 805)) then
			CreateUnit(AiEliteSoldier(), 1, {61, 0})
			CreateUnit(AiEliteSoldier(), 1, {62, 0})
			CreateUnit(AiEliteSoldier(), 1, {63, 0})
			CreateUnit(AiEliteSoldier(), 1, {64, 0})
			CreateUnit(AiEliteSoldier(), 1, {65, 0})
			CreateUnit(AiEliteSoldier(), 1, {66, 0})
			CreateUnit(AiEliteSoldier(), 1, {67, 0})
			CreateUnit(AiEliteSoldier(), 1, {68, 0})
			CreateUnit(AiEliteSoldier(), 1, {69, 0})
			CreateUnit(AiEliteSoldier(), 1, {70, 0})
			CreateUnit(AiEliteSoldier(), 1, {71, 0})
			CreateUnit(AiEliteSoldier(), 1, {72, 0})
			CreateUnit(AiEliteSoldier(), 1, {73, 0})
		else
			if ((gametimer > 900) and (timer > 190)) then
				SetDiplomacy(1, "allied", 4)
				SetDiplomacy(1, "allied", 2)	
				AiForce(1, {AiEliteSoldier(), 13}, true)
				AiAttackWithForce(1)
				SetDiplomacy(1, "enemy", 4)
				SetDiplomacy(1, "enemy", 2)				
			end
		end
	end
	if (gametimer < 250) then
		if ((GetNumUnitsAt(0, AiWorker(), {95, 25}, {111, 34}) > 0) or (GameCycle >= 10000)) then
			CenterMap(103, 25)
			ChangeUnitsOwner({90, 10}, {130, 50}, 0, 1)
			CreateUnit(AiSoldier(), 0, {105, 25})
			CreateUnit(AiSoldier(), 0, {104, 26})
			CreateUnit(AiSoldier(), 0, {103, 29})
			CreateUnit(AiSoldier(), 0, {102, 32})
			CreateUnit(AiEliteSoldier(), 1, {105, 23})
			CreateUnit(AiEliteSoldier(), 1, {104, 24})
			CreateUnit(AiEliteSoldier(), 1, {105, 22})
			gametimer = 251
		end
	end
	if (AiPlayer() ~= 1) then
		if (((GameCycle > 13000) and (GameCycle < 13010)) or ((GameCycle > 15000) and (GameCycle < 15010)) or ((GameCycle > 18000) and (GameCycle < 18010)) or ((GameCycle > 20000) and (GameCycle < 20010)) or ((GameCycle > 21000) and (GameCycle < 21010)) or ((GameCycle > 23000) and (GameCycle < 23010)) or ((GameCycle > 25000) and (GameCycle < 25010)) or ((GameCycle > 28000) and (GameCycle < 28010)) or ((GameCycle > 32000) and (GameCycle < 32010)) or ((GameCycle > 36000) and (GameCycle < 36010))) then
			AiStartAttack()
			AiNephrite_Attack_2013()
			AiEndAttack()
		end
	end
end

DefineAi("ai_level06", "*", "ai_level06", AiLevel06)
