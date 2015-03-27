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
--	ai_nephrite_2013.lua - Nephrite AI 2013
--
--	(c) Copyright 2012-2013 by Kyran Jackson
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

-- This edition was started on 11/11/2013.

local nephrite_build = {} -- What the AI is going to build.
local nephrite_attackbuffer = {} -- The AI attacks when it has this many units.
local nephrite_attackforce = {}
local nephrite_wait = {} -- How long the AI waits for the next attack.
local nephrite_increment = {} -- How large the attack force is increased by.
local nephrite_modifier_cav = {}
local nephrite_modifier_archer = {}

function AiNephrite_Setup_2013()
	nephrite_build[AiPlayer()] = "Footman"
	nephrite_attackbuffer[AiPlayer()] = 8
	nephrite_wait[AiPlayer()] = 100
	nephrite_attackforce[AiPlayer()] = 1
	nephrite_modifier_cav[AiPlayer()] = 1
	nephrite_modifier_archer[AiPlayer()] = 1
	nephrite_increment[AiPlayer()] = 0.1
end

function AiNephrite_2013()
	AiJadeite_Set_Name_2010("Nephrite")
	if (nephrite_attackforce[AiPlayer()] ~= nil) then
		if ((nephrite_wait[AiPlayer()] < 3) or (nephrite_wait[AiPlayer()] == 11) or (nephrite_wait[AiPlayer()] == 21) or (nephrite_wait[AiPlayer()] == 21) or (nephrite_wait[AiPlayer()] == 31) or (nephrite_wait[AiPlayer()] == 41) or (nephrite_wait[AiPlayer()] == 51) or (nephrite_wait[AiPlayer()] == 61) or (nephrite_wait[AiPlayer()] == 71) or (nephrite_wait[AiPlayer()] == 81) or (nephrite_wait[AiPlayer()] == 91) or (nephrite_wait[AiPlayer()] == 101)) then
			AiNephrite_Flush_2013()
		end
		AiNephrite_Pick_2013()
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) >= 1) then
			if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 800) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 200)) then
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBetterCityCenter()) > 0) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) == 0)) then
					if ((GetPlayerData(AiPlayer(), "Resources", "gold") > 2500) and (GetPlayerData(AiPlayer(), "Resources", "wood") > 1200)) then
						AiNephrite_Train_2013()
					end
				else
					AiNephrite_Train_2013()
				end
			elseif (GameCycle >= 5000) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 20) then
					AiSet(AiWorker(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) + 1)
				end
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) > 0) then
					AiNephrite_Train_2013()
				end
			end
		end
		if (nephrite_wait[AiPlayer()] < 2) then
			AiNephrite_Attack_2013()
			--AiForce(0, {AiSoldier(), 2})
		else
			nephrite_wait[AiPlayer()] = nephrite_wait[AiPlayer()] - 1
		end
		AiNephrite_Research_2013()
		AiNephrite_Expand_2013()
	else
		AiNephrite_Setup_2013()
    end
end

function AiNephrite_Flush_2013()
	AiSet(AiBarracks(), 0)
	AiSet(AiCityCenter(), 0)
	AiSet(AiFarm(), 1)
	AiSet(AiBlacksmith(), 0)
	AiSet(AiLumberMill(), 0)
	AiSet(AiStables(), 0)
	AiSet(AiWorker(), 0)
	AiSet(AiCatapult(), 0)
	AiSet(AiShooter(), 0)
	AiSet(AiCavalry(), 0)
	AiSet(AiSoldier(), 0)
end

function AiNephrite_Pick_2013()
	-- What am I going to build next?
	nephrite_build[AiPlayer()] = SyncRand(4)
	if (nephrite_build[AiPlayer()] == 1) then
		if ((nephrite_modifier_archer[AiPlayer()] == 0) or ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter())/2) > (GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())))) then
			nephrite_build[AiPlayer()] = "Knight"
		else
			nephrite_build[AiPlayer()] = "Archer"
		end
	elseif (nephrite_build[AiPlayer()] == 2) then
		nephrite_build[AiPlayer()] = "Knight"
	elseif ((nephrite_build[AiPlayer()] == 3) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) >= 2)) then
		nephrite_build[AiPlayer()] = "Catapult"
	else
		nephrite_build[AiPlayer()] = "Knight"
	end
	if ((nephrite_modifier_cav[AiPlayer()] == 0) and (nephrite_build[AiPlayer()] == "Knight")) then
		nephrite_build[AiPlayer()] = "Footman"
	end
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) > 0) then
		if ((((GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) > ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker())) * 2)) or (GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) < 10))) then
			AiSet(AiWorker(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()))
		end
	end
end

function AiNephrite_Attack_2013(command)
	if (nephrite_attackforce[AiPlayer()] ~= nil) then
		--AddMessage("It is time to attack.")
		if ((command == "force") or ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroRider()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiFodder()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiMage()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) >= nephrite_attackbuffer[AiPlayer()])) then
			--AddMessage("Attacking with force 1.")
			AiForce(nephrite_attackforce[AiPlayer()], {AiFodder(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFodder()), AiSuicideBomber(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSuicideBomber()), AiDestroyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiDestroyer()), AiBattleship(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiBattleship()), AiTransporter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiTransporter()), AiEliteSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteSoldier()), AiHeroRider(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroRider()), AiHeroSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroSoldier()), AiMage(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiMage()), AiFlyer(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiFlyer()), AiBones(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiBones()), AiHeroShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiHeroShooter()), AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()), AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()), AiCavalry(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalryMage()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())), AiShooter(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiEliteShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()))}, true)
			AiAttackWithForce(nephrite_attackforce[AiPlayer()])
			nephrite_wait[AiPlayer()] = 150
			if (nephrite_attackforce[AiPlayer()] >= 8) then
				nephrite_attackforce[AiPlayer()] = 1
				nephrite_attackbuffer[AiPlayer()] = nephrite_attackbuffer[AiPlayer()] + nephrite_increment[AiPlayer()]
				AiForce(0, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0})
				AiForce(1, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(2, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(3, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(4, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(5, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(6, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(7, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(8, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
				AiForce(9, {AiEliteSoldier(), 0, AiHeroRider(), 0, AiHeroSoldier(), 0, AiMage(), 0, AiFlyer(), 0, AiBones(), 0, AiHeroShooter(), 0, AiCatapult(), 0, AiSoldier(), 0, AiCavalry(), 0, AiShooter(), 0}, true)
			else
				nephrite_attackforce[AiPlayer()] = nephrite_attackforce[AiPlayer()] + 1
			end
		end
	else
		AiNephrite_Setup_2013()
	end
end

function AiNephrite_Expand_2013()
	-- New in Nephrite 2013 is the expand function.
	if (GetPlayerData(AiPlayer(), "Resources", "gold") < 4000) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) == 0) then
			AiSet(AiCityCenter(), 1)
		end
	elseif (GetPlayerData(AiPlayer(), "Resources", "gold") < 8000) then
		if (GameCycle >= 6000) then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()) < 2) then
				AiSet(AiCityCenter(), 2)
			end
		end
	end
	if (GetPlayerData(AiPlayer(), "Resources", "gold") > 1000) then
		if ((GetPlayerData(AiPlayer(), "TotalNumUnits") / GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm())) > 4.5) then
			AiSet(AiFarm(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) + 1))
		end
	end
	if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiFarm()) >= 1) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 0) then
			if (GetPlayerData(AiPlayer(), "Resources", "gold") > 1000) then
				AiSet(AiBarracks(), 1)
			end
		elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 1) then
			if (GameCycle >= 5000) then
				if (GetPlayerData(AiPlayer(), "Resources", "gold") > 2000) then
					AiSet(AiWorker(), 12)
					AiSet(AiBarracks(), 2)
				end
			end
		elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 2) then
			if (GetPlayerData(AiPlayer(), "Resources", "gold") > 4000) then
				AiSet(AiWorker(), 16)
				AiSet(AiBarracks(), 3)
			end
		elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 3) then
			if (GameCycle >= 10000) then
				if (GetPlayerData(AiPlayer(), "Resources", "gold") > 12000) then
					AiSet(AiWorker(), 20)
					AiSet(AiBarracks(), 4)
				end
			end
		elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 4) then
			if (GetPlayerData(AiPlayer(), "Resources", "gold") > 16000) then
				AiSet(AiWorker(), 25)
				AiSet(AiBarracks(), 5)
			end
		elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) == 5) then
			if (GetPlayerData(AiPlayer(), "Resources", "gold") > 32000) then
				AiSet(AiWorker(), 30)
				AiSet(AiBarracks(), 6)
			end
		elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 5) then
			if (((GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) / GetPlayerData(AiPlayer(), "TotalResources", "gold")) > 1200) and (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) < 8)) then
				AiSet(AiBarracks(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) + 1))
			end
		end
	end
end
	
function AiNephrite_Research_2013()
	-- New in Nephrite 2013 is the research function.
	-- TODO: Add captapult
	if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) >= 1) then
		if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) == 0) then
			AiSet(AiBlacksmith(), 1)
		else
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) == 0) then
				AiUpgradeTo(AiBestCityCenter())
			else
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiTemple()) == 0) then
					AiSet(AiTemple(), 1)
				else
					AiResearch(AiUpgradeCavalryMage())
					AiResearch(AiCavalryMageSpell1())
				end
			end
			if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) >= 1) then
				AiResearch(AiUpgradeWeapon1())
				AiResearch(AiUpgradeArmor1())
				if ((GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry())) >= 2) then
					AiResearch(AiUpgradeArmor2())
					AiResearch(AiUpgradeWeapon2())
				end
			end
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) >= 1) then
				if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiLumberMill()) == 0) then
					AiSet(AiLumberMill(), 1)
				else
					AiResearch(AiUpgradeMissile1())
					AiResearch(AiUpgradeMissile2())
					if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) == 0) then
						AiSet(AiStables(), 1)
					else
						if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBestCityCenter()) == 0) then
							AiUpgradeTo(AiBestCityCenter())
						else
							AiResearch(AiUpgradeEliteShooter())
							AiResearch(AiUpgradeEliteShooter2())
							AiResearch(AiUpgradeEliteShooter3())
						end
					end	
				end
			end
		end
	end
end

function AiNephrite_Train_2013()
	if (nephrite_build[AiPlayer()] == "Worker") then
		AiSet(AiWorker(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiCityCenter()))
	elseif (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) > 0) then
		if (nephrite_build[AiPlayer()] == "Footman") then
			AiSet(AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()))
		elseif (nephrite_build[AiPlayer()] == "Catapult") then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
				AiSet(AiCatapult(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCatapult()) + 1)
			else
				AiSet(AiBlacksmith(), 1)
			end
		elseif (nephrite_build[AiPlayer()] == "Archer") then
			AiSet(AiShooter(), (GetPlayerData(AiPlayer(), "UnitTypesCount", AiShooter()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks())))
		elseif (nephrite_build[AiPlayer()] == "Knight") then
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiStables()) > 0) then
				AiSet(AiCavalry(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiCavalry()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()))
			else
				AiSet(AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()))
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
end

function AiNephrite_NoCav_2013()
	AiJadeite_Set_Name_2010("Tesuni")
	if (nephrite_attackforce[AiPlayer()] ~= nil) then
		AiNephrite_2013()
		if (nephrite_attackbuffer[AiPlayer()] > 20) then
			nephrite_attackbuffer[AiPlayer()] = 10
		end
	else
		nephrite_attackforce[AiPlayer()] = 1
		nephrite_build[AiPlayer()] = "Soldier"
		nephrite_attackbuffer[AiPlayer()] = 1
		nephrite_wait[AiPlayer()] = 100
		nephrite_modifier_cav[AiPlayer()] = 0
		nephrite_modifier_archer[AiPlayer()] = 1
		nephrite_increment[AiPlayer()] = 1
	end
end

function AiNephrite_Level5()
	AiSet(AiLumberMill(), 1)
	if (nephrite_attackforce[AiPlayer()] ~= nil) then
		if (GetPlayerData(AiPlayer(), "Resources", "gold") > 1000) then
			AiNephrite_Train_2013()
			AiNephrite_Pick_2013()
			if (nephrite_wait[AiPlayer()] < 2) then
				AiNephrite_Attack_2013()
			else
				nephrite_wait[AiPlayer()] = nephrite_wait[AiPlayer()] - 1
			end
			AiNephrite_Research_2013()
			if (GetPlayerData(AiPlayer(), "UnitTypesCount", AiBlacksmith()) > 0) then
				AiNephrite_Expand_2013()
			end
		else
			AiNephrite_Attack_2013()
		end
	else
		nephrite_attackforce[AiPlayer()] = 1
		nephrite_build[AiPlayer()] = "Archer"
		nephrite_attackbuffer[AiPlayer()] = 6
		nephrite_wait[AiPlayer()] = 100
		nephrite_modifier_cav[AiPlayer()] = 0
		nephrite_modifier_archer[AiPlayer()] = 1
		nephrite_increment[AiPlayer()] = 0
	end
end

DefineAi("ai_nephrite_2013", "*", "ai_nephrite_2013", AiNephrite_2013)
DefineAi("ai_nephrite_nocav_2013", "*", "ai_nephrite_nocav_2013", AiNephrite_NoCav_2013)

