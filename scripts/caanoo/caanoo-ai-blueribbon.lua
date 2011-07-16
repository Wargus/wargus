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
		RedLeader = 0
		blueribbon_stepping = 7
		BlueTeam1 = 2
		BlueTeam1_x1 = 75
		BlueTeam1_y1 = 16
		BlueTeam1_x2 = 82
		BlueTeam1_y2 = 20
		BlueTeam2 = 5
		BlueTeam2_x1 = 24
		BlueTeam2_y1 = 16
		BlueTeam2_x2 = 31
		BlueTeam2_y2 = 20
		BlueTemp_x1 = BlueTeam1_x1
		BlueTemp_y1 = BlueTeam1_y1
		BlueTemp_x2 = BlueTeam1_x2
		BlueTemp_y2 = BlueTeam1_y2
		RedTeam1 = 3
		RedTeam2 = 4
		-- setup blue enemies
		SetDiplomacy(BlueLeader, "enemy", RedLeader)
		SetDiplomacy(BlueTeam1, "enemy", RedLeader)
		SetDiplomacy(BlueTeam2, "enemy", RedLeader)
		SetSharedVision(BlueLeader, false, RedLeader)
		SetSharedVision(BlueTeam1, false, RedLeader)
		SetSharedVision(BlueTeam2, false, RedLeader)
		SetDiplomacy(BlueLeader, "enemy", RedTeam1)
		SetDiplomacy(BlueTeam1, "enemy", RedTeam1)
		SetDiplomacy(BlueTeam2, "enemy", RedTeam1)
		SetSharedVision(BlueLeader, false, RedTeam1)
		SetSharedVision(BlueTeam1, false, RedTeam1)
		SetSharedVision(BlueTeam2, false, RedTeam1)
		SetDiplomacy(BlueLeader, "enemy", RedTeam2)
		SetDiplomacy(BlueTeam1, "enemy", RedTeam2)
		SetDiplomacy(BlueTeam2, "enemy", RedTeam2)
		SetSharedVision(BlueLeader, false, RedTeam2)
		SetSharedVision(BlueTeam1, false, RedTeam2)
		SetSharedVision(BlueTeam2, false, RedTeam2)
		-- setup blue alliances
		SetDiplomacy(BlueLeader, "allied", BlueTeam1)
		SetDiplomacy(BlueTeam1, "allied", BlueLeader)
		SetSharedVision(BlueLeader, true, BlueTeam1)
		SetSharedVision(BlueTeam1, true, BlueLeader)
		SetDiplomacy(BlueLeader, "allied", BlueTeam2)
		SetDiplomacy(BlueTeam2, "allied", BlueLeader)
		SetSharedVision(BlueLeader, true, BlueTeam2)
		SetSharedVision(BlueTeam2, true, BlueLeader)
		-- setup red enemies
		SetDiplomacy(RedLeader, "enemy", BlueLeader)
		SetDiplomacy(RedTeam1, "enemy", BlueLeader)
		SetDiplomacy(RedTeam2, "enemy", BlueLeader)
		SetSharedVision(RedLeader, false, BlueLeader)
		SetSharedVision(RedTeam1, false, BlueLeader)
		SetSharedVision(RedTeam2, false, RedLeader)
		SetDiplomacy(RedLeader, "enemy", BlueTeam1)
		SetDiplomacy(RedTeam1, "enemy", BlueTeam1)
		SetDiplomacy(RedTeam2, "enemy", BlueTeam1)
		SetSharedVision(RedLeader, false, BlueTeam1)
		SetSharedVision(RedTeam1, false, BlueTeam1)
		SetSharedVision(RedTeam2, false, BlueTeam1)
		SetDiplomacy(RedLeader, "enemy", BlueTeam2)
		SetDiplomacy(RedTeam1, "enemy", BlueTeam2)
		SetDiplomacy(RedTeam2, "enemy", BlueTeam2)
		SetSharedVision(RedLeader, false, BlueTeam2)
		SetSharedVision(RedTeam1, false, BlueTeam2)
		SetSharedVision(RedTeam2, false, BlueTeam2)
		-- setup red alliances
		SetDiplomacy(RedLeader, "allied", RedTeam1)
		SetDiplomacy(RedTeam1, "allied", RedLeader)
		SetSharedVision(RedLeader, true, RedTeam1)
		SetSharedVision(RedTeam1, true, RedLeader)
		SetDiplomacy(RedLeader, "allied", RedTeam2)
		SetDiplomacy(RedTeam2, "allied", RedLeader)
		SetSharedVision(RedLeader, true, RedTeam2)
		SetSharedVision(RedTeam2, true, RedLeader)
		-- Timer related
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitBallistaNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitMageNum = 0
		UnitDwarvesNum = 0
		timer = 1
    end
	-- Let's check out our surroundings.
	timer = timer + 1
	print(timer)
	if ((timer == 50) or (timer == 100)) then
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
		if (GetNumUnitsAt(BlueTemp, "unit-footman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
			if (GetNumUnitsAt(BlueLeader, "unit-human-barracks", {5, 24}, {12, 31}) > 0) then
				AddMessage("Spawn Blue Footmen!")
				UnitFootmanNum = GetNumUnitsAt(BlueTemp, "unit-footman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
				for UnitUpto = BlueLeader,UnitFootmanNum do
					CreateUnit("unit-footman", BlueLeader, {8, 27})
				end
			else
				AddMessage("I can't train any more footmen!")
			end
		end
		if ((GetNumUnitsAt(BlueTemp, "unit-ranger", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, "unit-archer", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0)) then
			if (GetNumUnitsAt(BlueLeader, "unit-human-barracks", {79, 23}, {87, 31}) > 0) then
				if (GetNumUnitsAt(BlueTemp, "unit-ranger", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					AddMessage("Spawn Blue Rangers!")
					UnitRangerNum = GetNumUnitsAt(BlueTemp, "unit-ranger", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
					for UnitUpto = BlueLeader,UnitRangerNum do
						CreateUnit("unit-ranger", BlueLeader, {83, 27})
					end
				end
				if (GetNumUnitsAt(BlueTemp, "unit-archer", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
					AddMessage("Spawn Blue Archers!")
					UnitArcherNum = GetNumUnitsAt(BlueTemp, "unit-archer", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
					for UnitUpto = BlueLeader,UnitArcherNum do
						CreateUnit("unit-archer", BlueLeader, {83, 27})
					end
				end
			else
				AddMessage("I can't train any more archers!")
			end
		end
		if ((GetNumUnitsAt(BlueTemp, "unit-caanoo-wiseman", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) or (GetNumUnitsAt(BlueTemp, "unit-mage", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0)) then
			AddMessage("Spawn Blue Mages!")
			UnitMageNum = (GetNumUnitsAt(BlueTemp, "unit-caanoo-wiseman", {0, 0}, {92, 256}) + GetNumUnitsAt(BlueTemp, "unit-mage", {0, 0}, {92, 256}) )
			for UnitUpto = BlueLeader,UnitMageNum do
				CreateUnit("unit-mage", BlueLeader, {30, 4})
			end
		end
		if (GetNumUnitsAt(BlueTemp, "unit-knight", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
			AddMessage("Spawn Blue Knights!")
			UnitKnightNum = GetNumUnitsAt(BlueTemp, "unit-knight", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
			for UnitUpto = BlueLeader,UnitKnightNum do
				CreateUnit("unit-knight", BlueLeader, {67, 28})
			end
		end
		if (GetNumUnitsAt(BlueTemp, "unit-paladin", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
			AddMessage("Spawn Blue Paladins!")
			UnitPaladinNum = GetNumUnitsAt(BlueTemp, "unit-paladin", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
			for UnitUpto = BlueLeader,UnitPaladinNum do
				CreateUnit("unit-paladin", BlueLeader, {67, 28})
			end
		end
		if (GetNumUnitsAt(BlueTemp, "unit-ballista", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
			AddMessage("Spawn Blue Ballistas!")
			UnitBallistaNum = GetNumUnitsAt(BlueTemp, "unit-ballista", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
			for UnitUpto = BlueLeader,UnitBallistaNum do
				CreateUnit("unit-ballista", BlueLeader, {24, 30})
			end
		end
		if (GetNumUnitsAt(BlueTemp, "unit-dwarves", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) > 0) then
			AddMessage("Spawn Blue Dwarves!")
			UnitDwarvesNum = GetNumUnitsAt(BlueTemp, "unit-dwarves", {BlueTemp_x1, BlueTemp_y1}, {BlueTemp_x2, BlueTemp_y2}) 
			for UnitUpto = BlueLeader,UnitDwarvesNum do
				CreateUnit("unit-dwarves", BlueLeader, {89, 10})
			end
		end
		AiForce(0, {"unit-dwarves", UnitDwarvesNum, AiMage(), UnitMageNum, AiSoldier(), UnitFootmanNum, AiShooter(), (UnitArcherNum + UnitRangerNum), AiEliteShooter(), (UnitArcherNum + UnitRangerNum), AiCavalry(), (UnitPaladinNum + UnitKnightNum), AiCavalryMage(), (UnitKnightNum + UnitPaladinNum), AiCatapult(), UnitBallistaNum})
		AiAttackWithForce(0)
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitMageNum = 0
	end
	if (timer == 100) then
		timer = 0
	end
	if ((timer == 75) or (timer == 25)) then
		print("hi")
		if (GetNumUnitsAt(BlueLeader, "unit-footman", {5, 24}, {12, 31}) > 0) then
			UnitFootmanNum = GetNumUnitsAt(BlueLeader, "unit-footman", {5, 24}, {12, 31})
		end
		if (GetNumUnitsAt(BlueLeader, "unit-archer", {80, 30}, {80, 30}) > 0) then
			UnitArcherNum = GetNumUnitsAt(BlueLeader, "unit-archer", {80, 30}, {80, 30})
		end
		if (GetNumUnitsAt(BlueLeader, "unit-ranger", {80, 30}, {80, 30}) > 0) then
			UnitRangerNum = GetNumUnitsAt(BlueLeader, "unit-ranger", {80, 30}, {80, 30})
		end
		if (GetNumUnitsAt(BlueLeader, "unit-knight", {63, 24}, {71, 32}) > 0) then
			UnitKnightNum = GetNumUnitsAt(BlueLeader, "unit-knight", {63, 24}, {71, 32})
		end
		if (GetNumUnitsAt(BlueLeader, "unit-paladin", {63, 24}, {71, 32}) > 0) then
			UnitPaladinNum = GetNumUnitsAt(BlueLeader, "unit-paladin", {63, 24}, {71, 32})
		end
		AiForce(1, {"unit-dwarves", UnitDwarvesNum, AiMage(), UnitMageNum, AiSoldier(), UnitFootmanNum, AiShooter(), (UnitArcherNum + UnitRangerNum), AiEliteShooter(), (UnitArcherNum + UnitRangerNum), AiCavalry(), (UnitPaladinNum + UnitKnightNum), AiCavalryMage(), (UnitKnightNum + UnitPaladinNum), AiCatapult(), UnitBallistaNum})
		AiAttackWithForce(1)
		UnitFootmanNum = 0
		UnitArcherNum = 0
		UnitRangerNum = 0
		UnitBallistaNum = 0
		UnitDwarvesNum = 0
		UnitPaladinNum = 0
		UnitKnightNum = 0
		UnitMageNum = 0
	end
end

DefineAi("ai_blueribbon", "*", "ai_blueribbon", AiBlueRibbon)

