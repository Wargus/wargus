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
--		ai_nephrite.lua - Define the Nephrite AI.
--
--		(c) Copyright 2012 by Kyran Jackson
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

-- This edition was frozen on 14/12/2012.

local nephrite_stepping -- Used to identify where the build order is up to.
local nephrite_build -- What the AI is going to build.
local nephrite_attackbuffer -- The AI attacks when it has this many units.
local nephrite_wait -- How long the AI waits for the next attack.

function AiNephrite_2012()
	AiJadeite_Set_Name_2010("Regulus")
	if (nephrite_stepping ~= nil) then
	else
		nephrite_stepping = 1
		nephrite_build = "Soldier"
		nephrite_attackbuffer = 5
		nephrite_wait = 0
		nephrite_modifier_cav = 1
		nephrite_modifier_archer = 1
    end
	-- Basic start build. After this is done we'll move onto the adaptive part.
	if (nephrite_stepping == 1) then
		-- One Hall Power to Keep/Stronghold 
		if ((GetNumUnitsAt(AiPlayer(), AiCityCenter(), {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), AiBetterCityCenter(), {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), AiBestCityCenter(), {0, 0}, {256, 256}) >= 1)) then
			if (GetNumUnitsAt(AiPlayer(), AiFarm(), {0, 0}, {256, 256}) >= 1) then
				AiSet(AiWorker(), 8)
				if (GetNumUnitsAt(AiPlayer(), AiBarracks(), {0, 0}, {256, 256}) >= 1) then
					-- Should build some defences...
					AiSet(AiSoldier(), 4)
					AiSet(AiWorker(), 15)
					if ((GetNumUnitsAt(AiPlayer(), AiWorker(), {0, 0}, {256, 256}) == 3) or (GetNumUnitsAt(AiPlayer(), AiBlacksmith(), {0, 0}, {256, 256}) == 0)) then
						AiSet(AiBlacksmith(), 1)
					else
						--AiSet(AiCatapult(), 1)
						AiResearch(AiUpgradeWeapon1())
						AiResearch(AiUpgradeArmor1())
						AiResearch(AiUpgradeArmor2())
						if ((GetNumUnitsAt(AiPlayer(), AiBetterCityCenter(), {0, 0}, {256, 256}) >= 1) or (GetNumUnitsAt(AiPlayer(), AiBestCityCenter(), {0, 0}, {256, 256}) >= 1)) then
							AiResearch(AiUpgradeWeapon2())
							if (GetNumUnitsAt(AiPlayer(), AiStables(), {0, 0}, {256, 256}) >= 1) then
								AiSet(AiBarracks(), 3)
								if (nephrite_modifier_cav == 0) then
									nephrite_stepping = 2
								end
								if ((GetNumUnitsAt(AiPlayer(), AiCavalry(), {0, 0}, {256, 256}) <= 3) and (GetNumUnitsAt(AiPlayer(), AiCavalryMage(), {0, 0}, {256, 256}) <= 3)) then
									AiSet(AiCavalry(), 10)
									AiSet(AiFarm(), 10)
								else
									if ((GetNumUnitsAt(AiPlayer(), AiCavalry(), {0, 0}, {256, 256}) >= 7) or (GetNumUnitsAt(AiPlayer(), AiCavalryMage(), {0, 0}, {256, 256}) >= 7)) then
										--AiForce(6, {AiCavalry(), 12, AiCatapult(), 1})
										AiForce(6, {AiCavalry(), 12}, true)
										AiAttackWithForce(6)
										nephrite_stepping = 2
									else
										AiForce(6, {AiCavalry(), 1}, true)
										AiAttackWithForce(6)
										nephrite_stepping = 2
									end
								end
							else
								AiSet(AiStables(), 1)
								AiSet(AiLumberMill(), 1)
								AiSet(AiFarm(), 7)
							end
						else
							AiSet(AiBarracks(), 2)
							AiUpgradeTo(AiBetterCityCenter())
							AiSet(AiFarm(), 6)
						end
					end
				else
					AiSet(AiBarracks(), 1)
					AiSet(AiFarm(), 5)
				end
			else
				AiSet(AiFarm(), 4)
			end
		else
			AiSet(AiCityCenter(), 1)
		end
	end
	if (nephrite_stepping == 2) then
		-- Stepping 2 is when the AI builds a unit.
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
			if (nephrite_build == "Footman") then
				AiSet(AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + 1)
			elseif (nephrite_build == "Catapult") then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
					--FIXME: Following line crashes the game.
					--AiSet(AiCatapult(), GetPlayerData(AiCatapult(), "UnitTypesCount", AiCatapult()) + 1)
				else
					AiSet(AiBlacksmith(), 1)
				end
			elseif (nephrite_build == "Archer") then
				AiSet(AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) + 1)
			elseif (nephrite_build == "Knight") then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
					AiSet(AiCavalry(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) + 1)
				else
					if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0)) then
						AiSet(AiStables(), 1)
					elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) > 0) then
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) > 0) then
							if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
								AiUpgradeTo(AiBetterCityCenter())
							else
								AiSet(AiBlacksmith(), 1)
							end
						else
							AiSet(AiLumberMill(), 1)
						end
					else
						AiSet(AiCityCenter(), 1)
					end
				end
			end
		else
			AiSet(AiBarracks(), 1)
		end
		nephrite_stepping = 3
	end
	if (nephrite_stepping == 3) then
		-- What am I going to build next?
		nephrite_build = SyncRand(3)
		if (nephrite_build == 3) then
			nephrite_build = "Footman"
		elseif (nephrite_build == 2) then
			if (nephrite_modifier_cav == 0) then
				nephrite_build = "Footman"
			else
				nephrite_build = "Knight"
			end
		elseif (nephrite_build == 1) then
			if (nephrite_modifier_archer == 0) then
				nephrite_build = "Footman"
			else
				nephrite_build = "Archer"
			end
		end
		nephrite_stepping = 4
	end
	if ((nephrite_stepping == 4) and (nephrite_wait < 1)) then
		if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) == nephrite_attackbuffer) then
			AiForce(1, {AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()), AiCavalry(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()), AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter())}, true)
			AiAttackWithForce(1)
			nephrite_wait = 20
		elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) >= nephrite_attackbuffer) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) >= nephrite_attackbuffer) then
				AiForce(2, {AiSoldier(), nephrite_attackbuffer}, true)
				AiAttackWithForce(2)
			elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) >= nephrite_attackbuffer) and (nephrite_modifier_cav > 0)) then
				AiForce(3, {AiCavalry(), nephrite_attackbuffer}, true)
				AiAttackWithForce(3)
			elseif ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= nephrite_attackbuffer) and (nephrite_modifier_archer > 0)) then
				AiForce(4, {AiShooter(), nephrite_attackbuffer}, true)
				AiAttackWithForce(4)
			end
			nephrite_wait = 20
		end
		nephrite_stepping = 2
	else
		nephrite_wait = nephrite_wait - 1
	end
end

function AiNephrite_NoCav_2012()
	AiJadeite_Set_Name_2010("Soul")
	if (nephrite_stepping ~= nil) then
		AiNephrite_2012()
	else
		nephrite_stepping = 1
		nephrite_build = "Soldier"
		nephrite_attackbuffer = 3
		nephrite_wait = 300
		nephrite_modifier_cav = 0
		nephrite_modifier_archer = 0
	end
end

DefineAi("ai_nephrite_2012", "*", "ai_nephrite_2012", AiNephrite_2012)
DefineAi("ai_nephrite_nocav_2012", "*", "ai_nephrite_nocav_2012", AiNephrite_NoCav_2012)
