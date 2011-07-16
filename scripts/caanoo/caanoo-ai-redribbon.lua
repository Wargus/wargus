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

local RedLeader -- The AI Player
local Redribbon_stepping -- Used to identify where the build order is up to.


function AiRedRibbon()
	-- Setting up the variables.
	if (Redribbon_stepping ~= nil) then
	else
		-- print ("Setting up the variables.")
		RedLeader = AiPlayer()
		BlueLeader = 1
		redribbon_stepping = 7
		RedTeam1 = 3
		RedTeam1_x1 = 64
		RedTeam1_y1 = 244
		RedTeam1_x2 = 71
		RedTeam1_y2 = 248
		RedTeam2 = 4
		RedTeam2_x1 = 25
		RedTeam2_y1 = 241
		RedTeam2_x2 = 32
		RedTeam2_y2 = 245
		RedTemp_x1 = RedTeam1_x1
		RedTemp_y1 = RedTeam1_y1
		RedTemp_x2 = RedTeam1_x2
		RedTemp_y2 = RedTeam1_y2
		RedBarracks1_x = 76
		RedBarracks1_y = 232
		RedBarracks2_x = 25
		RedBarracks2_y = 234
		RedBarracks3_x = 14
		RedBarracks3_y = 235
		RedBarracks4_x = 85
		RedBarracks4_y = 231
		BlueTeam1 = 2
		BlueTeam2 = 5
		-- Timer related
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitOgreMageNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
		UnitGoblinSappersNum = 0
    end
	print(timer)
	-- Let's check out our surroundings.
	if ((timer == 50) or (timer == 100)) then
		if (timer == 50) then
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
		if (GetNumUnitsAt(RedTemp, "unit-grunt", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			if (GetNumUnitsAt(RedLeader, "unit-orc-barracks", {RedBarracks1_x - 3, RedBarracks1_y - 3}, {RedBarracks1_x + 3, RedBarracks1_y + 3}) > 0) then
				AddMessage("Spawn Red Footmen!")
				UnitGruntNum = GetNumUnitsAt(RedTemp, "unit-grunt", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
				--print("Spawning " + UnitGruntNum + " grunts.")
				for UnitUpto = RedLeader,(UnitGruntNum - 1) do
					CreateUnit("unit-grunt", RedLeader, {RedBarracks1_x, RedBarracks1_y})
				end
			else
				AddMessage("I can't train any more grunts!")
			end
		end
		if ((GetNumUnitsAt(RedTemp, "unit-berserker", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, "unit-axethrower", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)) then
			if (GetNumUnitsAt(RedLeader, "unit-orcbarracks", {RedBarracks2_x - 3, RedBarracks2_y - 3}, {RedBarracks2_x + 3, RedBarracks2_y + 3}) > 0) then
				if (GetNumUnitsAt(RedTemp, "unit-berserker", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					AddMessage("Spawn Red Rangers!")
					UnitBerserkerNum = GetNumUnitsAt(RedTemp, "unit-berserker", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
					--print("Spawning " + UnitBerserkerNum + " berserkers.")
					for UnitUpto = RedLeader,(UnitBerserkerNum - 1) do
						CreateUnit("unit-berserker", RedLeader, {RedBarracks2_x, RedBarracks2_y})
					end
				end
				if (GetNumUnitsAt(RedTemp, "unit-axethrower", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
					AddMessage("Spawn Red Archers!")
					UnitAxethrowerNum = GetNumUnitsAt(RedTemp, "unit-axethrower", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
					for UnitUpto = RedLeader,(UnitAxethrowerNum - 1) do
						CreateUnit("unit-axethrower", RedLeader, {RedBarracks3_x, RedBarracks3_y})
					end
				end
			else
				AddMessage("I can't train any more axethrowers!")
			end
		end
		if ((GetNumUnitsAt(RedTemp, "unit-caanoo-wiseskeleton", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) or (GetNumUnitsAt(RedTemp, "unit-death-knight", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0)) then
			AddMessage("Spawn Red Mages!")
			UnitDeathKnightNum = (GetNumUnitsAt(RedTemp, "unit-caanoo-wiseman", {0, 0}, {92, 256}) + GetNumUnitsAt(RedTemp, "unit-death-knight", {0, 0}, {92, 256}) )
			for UnitUpto = RedLeader,UnitDeathKnightNum do
				CreateUnit("unit-death-knight", RedLeader, {9, 248})
			end
		end
		if (GetNumUnitsAt(RedTemp, "unit-ogre", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			AddMessage("Spawn Red Knights!")
			UnitOgreNum = GetNumUnitsAt(RedTemp, "unit-ogre", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
			for UnitUpto = RedLeader,(UnitOgreNum - 1) do
				CreateUnit("unit-ogre", RedLeader, {RedBarracks3_x, RedBarracks3_y})
			end
		end
		if (GetNumUnitsAt(RedTemp, "unit-ogre-mage", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			AddMessage("Spawn Red Paladins!")
			UnitOgreMageNum = GetNumUnitsAt(RedTemp, "unit-ogre-mage", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
			for UnitUpto = RedLeader,(UnitOgreMageNum - 1) do
				CreateUnit("unit-ogre-mage", RedLeader, {RedBarracks3_x, RedBarracks3_y})
			end
		end
		if (GetNumUnitsAt(RedTemp, "unit-catapult", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			AddMessage("Spawn Red Ballistas!")
			UnitCatapultNum = GetNumUnitsAt(RedTemp, "unit-catapult", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
			for UnitUpto = RedLeader,(UnitCatapultNum - 1) do
				CreateUnit("unit-catapult", RedLeader, {RedBarracks4_x, RedBarracks4_y})
			end
		end
		if (GetNumUnitsAt(RedTemp, "unit-goblin-sappers", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) > 0) then
			AddMessage("Spawn Red Dwarves!")
			UnitGoblinSappersNum = GetNumUnitsAt(RedTemp, "unit-goblin-sappers", {RedTemp_x1, RedTemp_y1}, {RedTemp_x2, RedTemp_y2}) 
			for UnitUpto = RedLeader,(UnitGoblinSappersNum - 1) do
				CreateUnit("unit-goblin-sappers", RedLeader, {91, 249})
			end
		end
		AiForce(0, {"unit-goblin-sappers", UnitGoblinSappersNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitGruntNum, AiShooter(), (UnitAxethrowerNum + UnitBerserkerNum), AiEliteShooter(), (UnitAxethrowerNum + UnitBerserkerNum), AiCavalry(), (UnitOgreMageNum + UnitOgreNum), AiCavalryMage(), (UnitOgreNum + UnitOgreMageNum), AiCatapult(), UnitCatapultNum})
		AiAttackWithForce(0)
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitGoblinSappersNum = 0
		UnitOgreMageNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
	end
	if ((timer == 75) or (timer == 25)) then
		print("hi")
		if (GetNumUnitsAt(RedLeader, "unit-footman", {5, 24}, {12, 31}) > 0) then
			UnitGruntNum = GetNumUnitsAt(RedLeader, "unit-footman", {5, 24}, {12, 31})
		end
		if (GetNumUnitsAt(RedLeader, "unit-axethrower", {80, 30}, {80, 30}) > 0) then
			UnitAxethrowerNum = GetNumUnitsAt(RedLeader, "unit-axethrower", {80, 30}, {80, 30})
		end
		if (GetNumUnitsAt(RedLeader, "unit-berserker", {80, 30}, {80, 30}) > 0) then
			UnitBerserkerNum = GetNumUnitsAt(RedLeader, "unit-berserker", {80, 30}, {80, 30})
		end
		if (GetNumUnitsAt(RedLeader, "unit-ogre", {63, 24}, {71, 32}) > 0) then
			UnitOgreNum = GetNumUnitsAt(RedLeader, "unit-ogre", {63, 24}, {71, 32})
		end
		if (GetNumUnitsAt(RedLeader, "unit-ogre-mage", {63, 24}, {71, 32}) > 0) then
			UnitOgreMageNum = GetNumUnitsAt(RedLeader, "unit-ogre-mage", {63, 24}, {71, 32})
		end
		AiForce(1, {"unit-goblin-sappers", UnitGoblinSappersNum, AiMage(), UnitDeathKnightNum, AiSoldier(), UnitGruntNum, AiShooter(), (UnitAxethrowerNum + UnitBerserkerNum), AiEliteShooter(), (UnitAxethrowerNum + UnitBerserkerNum), AiCavalry(), (UnitOgreMageNum + UnitOgreNum), AiCavalryMage(), (UnitOgreNum + UnitOgreMageNum), AiCatapult(), UnitCatapultNum})
		AiAttackWithForce(1)
		UnitGruntNum = 0
		UnitAxethrowerNum = 0
		UnitBerserkerNum = 0
		UnitCatapultNum = 0
		UnitGoblinSappersNum = 0
		UnitOgreMageNum = 0
		UnitOgreNum = 0
		UnitDeathKnightNum = 0
	end
end

DefineAi("ai_redribbon", "*", "ai_redribbon", AiRedRibbon)

