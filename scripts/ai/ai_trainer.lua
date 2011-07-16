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
--	ai_trainer.lua - Define the AI.
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

local player -- The AI Player
local stepping -- Used to identify where the build order is up to.
local base -- Boolean variable to decide whether or not the AI maintains a base.
local gametime -- Decides where the game is up to.

function AiTrainer()
	-- Setting up the variables.
	if (stepping ~= nil) then
	else
		-- print ("Setting up the variables.")
		player = AiPlayer() + 1
		stepping = math.random(3, 5)
		if (stepping == 5) then
			stepping = 6
		end
		gametime = 5
    	end

	if (base == 0) then
		-- Do I need to rebuild some of my basic structures?
		--AiSet(AiCityCenter(), 1)
		--AiSet(AiWorker(), 4)
		--AiSet(AiBarracks(), 1)
	end
	-- Let's check out our surroundings.

	-- Have any of our agents established build points? Are they safe?
	-- ChangeUnitsOwner({0, 0}, {500, 500}, 2, 0)

	-- Have any of the enemy's agents established build points? Are they defended?

	-- Have any of my allies betrayed me?

	-- Does anyone want to ally? Is it in my best interests to?
	--SetDiplomacy(1, "allied", 2)
	--SetDiplomacy(2, "allied", 1)
	--SetSharedVision(1, true, 2)
	--SetSharedVision(2, true, 1)
	
	-- Do I need to build anything?
	
	if (((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) == 0) and (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) == 0) and (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) == 0)) or (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) == 0)) then
		base = 0
		if (GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) == 0) then
			print("I need a town hall.")
		end
		if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) == 0) then
			print("I need a barracks.")
		end
	else
		base = 1
		if (gametime == 0) then
			if (GetNumUnitsAt(AiPlayer(), "unit-peasant", {0, 0}, {256, 256}) >= 3) then
				-- // This requires gold to be above a certain point too.
				-- Time to build an army.
				stepping = 2
			end
			if (GetNumUnitsAt(AiPlayer(), "unit-footman", {0, 0}, {256, 256}) >= 2) then
				stepping = 2
				gametime = 1
			end
		else
			if (gametime == 1) then
				if (GetNumUnitsAt(AiPlayer(), "unit-footman", {0, 0}, {256, 256}) >= 8) then
					stepping = 3
				end
				if (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1) then
					gametime = 2
				end
			else
			--	stepping = 4
			end
		end
	end
	if (stepping == 1) then
		-- Standard worker build.
		--AiNeed(AiWorker())
		AiNeed("unit-caanoo-townhall")
		if ((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1)) then
			AiSet(AiWorker(), 20)
		else
			AiSet(AiCityCenter(), 1)
		end
	end
	if (stepping == 2) then
		-- Standard air attack build.
		if (GetNumUnitsAt(AiPlayer(), "unit-gryphon-aviary", {0, 0}, {256, 256}) >= 1) then
			AiSet(AiAirport(), 3)
			if (GetNumUnitsAt(AiPlayer(), "unit-gryphon-rider", {0, 0}, {256, 256}) <= 3) then
				print("Build air force.")
				AiSet(AiFlyer(), 10)
			else
				if (GetNumUnitsAt(AiPlayer(), "unit-gryphon-rider", {0, 0}, {256, 256}) >= 5) then
					AiForce(2, {AiFlyer(), 12})
					AiAttackWithForce(2)
				else
					AiForce(2, {AiFlyer(), 2})
					AiAttackWithForce(2)
				end
			end
		else
			print("I need to build up a base.")
			if ((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1)) then
				if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
					if (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1) then
						if (GetNumUnitsAt(AiPlayer(), "unit-stables", {0, 0}, {256, 256}) >= 1) then
							if (GetNumUnitsAt(AiPlayer(), "unit-elven-lumber-mill", {0, 0}, {256, 256}) >= 1) then
								if (GetNumUnitsAt(AiPlayer(), "unit-human-blacksmith", {0, 0}, {256, 256}) >= 1) then
									if (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) then
										print("Building an airport.")
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
	if (stepping == 3) then
		-- Standard footsoldier build.
		if ((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1)) then
			if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
			--print("hi")
				if (GetNumUnitsAt(AiPlayer(), "unit-footman", {0, 0}, {256, 256}) >= 4) then
				--print("ho")
					AiForce(3, {AiSoldier(), 12})
					if (GetNumUnitsAt(AiPlayer(), "unit-footman", {0, 0}, {256, 256}) >= 8) then
						if (GetNumUnitsAt(AiPlayer(), "unit-human-blacksmith", {0, 0}, {256, 256}) >= 1) then
							print("upgrade")
							AiResearch(AiUpgradeWeapon1())
							AiResearch(AiUpgradeArmor1())
							AiResearch(AiUpgradeWeapon2())
							AiResearch(AiUpgradeArmor2())
						else
							AiSet(AiBlacksmith(), 1)
						end
						print("attack")
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
			AiSet(AiWorker(), 8)
		end
	end
	if (stepping == 4) then
		-- Standard knight build.
		if ((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1)) then
			if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
				if (GetNumUnitsAt(AiPlayer(), "unit-human-blacksmith", {0, 0}, {256, 256}) >= 1) then
					if (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1) then
						if (GetNumUnitsAt(AiPlayer(), "unit-stables", {0, 0}, {256, 256}) >= 1) then
						print("I have some stables..")
							if ((GetNumUnitsAt(AiPlayer(), "unit-knight", {0, 0}, {256, 256}) >= 4) or (GetNumUnitsAt(AiPlayer(), "unit-paladin", {0, 0}, {256, 256}) >= 4)) then
								print("I have more then four knights.")
								AiResearch(AiUpgradeWeapon1())
								AiResearch(AiUpgradeArmor1())
								AiResearch(AiUpgradeWeapon2())
								AiResearch(AiUpgradeArmor2())
								if (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) == 0) then
									print("I need a castle.")
									if (GetNumUnitsAt(AiPlayer(), "unit-elven-lumber-mill", {0, 0}, {256, 256}) >= 1) then
										AiUpgradeTo(AiBestCityCenter())
									else
										AiSet(AiLumberMill(), 1)
										print("I need a mill.")
									end
								else
									if ((GetNumUnitsAt(AiPlayer(), "unit-knight", {0, 0}, {256, 256}) >= 8) or (GetNumUnitsAt(AiPlayer(), "unit-paladin", {0, 0}, {256, 256}) >= 8)) then
										print("I have more then eight knights.")
										AiAttackWithForce(4)
									else
										AiForce(4, {AiCavalry(), 10})
									end
									if (GetNumUnitsAt(AiPlayer(), "unit-church", {0, 0}, {256, 256}) >= 1) then
										AiResearch(AiUpgradeCavalryMage())
										AiResearch(AiCavalryMageSpell1())
									else
										AiSet(AiTemple(), 1)
									end
								end
							else
								--AiNeed(AiCavalry())
								AiSet(AiSoldier(), 0)
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
			AiSet(AiWorker(), 8)
		end
	end
	if (stepping == 5) then
		-- Standard archer build. [BROKEN, UNITS DONT UPGRADE]
		if ((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1)) then
			if (GetNumUnitsAt(AiPlayer(), "unit-elven-lumber-mill", {0, 0}, {256, 256}) >= 1) then
				AiUpgradeMissile1()
				if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
					print("hi")
					if ((GetNumUnitsAt(AiPlayer(), "unit-archer", {0, 0}, {256, 256}) >= 4) or (GetNumUnitsAt(AiPlayer(), "unit-archer", {0, 0}, {256, 256}) >= 4)) then 
						AiUpgradeMissile2()
						print("ho")
						AiForce(5, {AiShooter(), 8})
						if (GetNumUnitsAt(AiPlayer(), "unit-human-blacksmith", {0, 0}, {256, 256}) >= 1) then
							if (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1) then
								AiUpgradeEliteShooter()
								if (GetNumUnitsAt(AiPlayer(), "unit-stables", {0, 0}, {256, 256}) >= 1) then
									if (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) then
										AiUpgradeEliteShooter2()
										AiUpgradeEliteShooter3()
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
						if ((GetNumUnitsAt(AiPlayer(), "unit-archer", {0, 0}, {256, 256}) >= 8) or (GetNumUnitsAt(AiPlayer(), "unit-archer", {0, 0}, {256, 256}) >= 8)) then 
							print("attack")
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
			AiSet(AiWorker(), 8)
		end
	end
	if (stepping == 6) then
		-- One Hall Power to Keep/Stronghold 
		if ((GetNumUnitsAt(AiPlayer(), "unit-town-hall", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-castle", {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1)) then
			if (GetNumUnitsAt(AiPlayer(), "unit-farm", {0, 0}, {256, 256}) >= 1) then
				AiSet(AiWorker(), 8)
				if (GetNumUnitsAt(AiPlayer(), "unit-human-barracks", {0, 0}, {256, 256}) >= 1) then
					-- Should build some defences...
					AiSet(AiSoldier(), 4)
					AiSet(AiWorker(), 15)
					--AiSet("unit-farm", 5)
					if ((GetNumUnitsAt(AiPlayer(), "unit-peasant", {0, 0}, {256, 256}) == 3) or (GetNumUnitsAt(AiPlayer(), "unit-human-blacksmith", {0, 0}, {256, 256}) == 0)) then
						AiSet(AiBlacksmith(), 1)
					else
						AiSet(AiCatapult(), 1)
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeArmor2())
						--print("???")
						if (GetNumUnitsAt(AiPlayer(), "unit-keep", {0, 0}, {256, 256}) >= 1) then
							print("I have a keep.")
							AiResearch(AiUpgradeWeapon2())
							if (GetNumUnitsAt(AiPlayer(), "unit-stables", {0, 0}, {256, 256}) >= 1) then
								AiSet(AiBarracks(), 3)
								if ((GetNumUnitsAt(AiPlayer(), "unit-knight", {0, 0}, {256, 256}) <= 3) and (GetNumUnitsAt(AiPlayer(), "unit-paladin", {0, 0}, {256, 256}) <= 3)) then
									print("Build cavalry.")
									AiSet(AiCavalry(), 10)
								else
									if ((GetNumUnitsAt(AiPlayer(), "unit-knight", {0, 0}, {256, 256}) >= 7) or (GetNumUnitsAt(AiPlayer(), "unit-paladin", {0, 0}, {256, 256}) >= 7)) then
										AiForce(6, {AiCavalry(), 12, AiCatapult(), 1})
										AiAttackWithForce(6)
										stepping = 4
									else
										AiForce(6, {AiCavalry(), 1})
										AiAttackWithForce(6)
									end
								end
							else
								print("Need some stables.")
								AiSet(AiStables(), 1)
								--AiSet(AiLumberMill(), 1)
								AiSet("unit-farm", 6)
							end
						else
							AiSet(AiBarracks(), 2)
							AiUpgradeTo(AiBetterCityCenter())
						end
					end
				else
					AiSet(AiBarracks(), 1)
				end
			else
				AiSet("unit-farm", 1)
			end
		else
			AiSet(AiCityCenter(), 1)
		end
	end
	--print (stepping)
	--print (gametime)
end

DefineAi("ai_trainer", "*", "ai_trainer", AiTrainer)

