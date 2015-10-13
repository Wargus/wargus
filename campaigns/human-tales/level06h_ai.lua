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

function AiLevel06()
	if (timer == nil) then
		timer = 1
	end
	if (timer > 0) then
		timer = timer + 1
		if (timer == 50) then
			QuickTrain(0, AiSoldier(0), 101, 92)
			QuickTrain(0, AiSoldier(0), 119, 88)
			QuickTrain(0, AiSoldier(0), 110, 98)
			QuickTrain(0, AiSoldier(0), 122, 94)
			QuickTrain(0, AiWorker(0), 67, 87)
			QuickTrain(0, AiWorker(0), 67, 87)
			QuickTrain(0, AiSoldier(0), 67, 87)
			CreateUnit("unit-grunt", 3, {0, 116})
			CreateUnit("unit-grunt", 3, {0, 117})
			CreateUnit("unit-grunt", 3, {0, 118})
			CreateUnit("unit-grunt", 3, {0, 31})
			CreateUnit("unit-grunt", 3, {0, 30})
			CreateUnit("unit-grunt", 3, {0, 31})
			CreateUnit("unit-axethrower", 3, {1, 116})
			CreateUnit("unit-axethrower", 3, {1, 117})
			CreateUnit("unit-axethrower", 3, {1, 118})
			CreateUnit("unit-grunt", 3, {0, 30})
			CreateUnit("unit-grunt", 3, {0, 29})
			CreateUnit("unit-grunt", 3, {0, 28})
			CreateUnit("unit-grunt", 3, {0, 27})
			CreateUnit("unit-grunt", 3, {0, 26})
		elseif (timer == 100) then
			QuickTrain(0, AiSoldier(0), 95, 94)
			QuickTrain(0, AiSoldier(0), 113, 89)
			QuickTrain(0, AiSoldier(0), 67, 87)
			QuickTrain(0, AiWorker(0), 67, 87)
			QuickTrain(0, AiWorker(0), 67, 87)
			QuickTrain(0, AiSoldier(0), 104, 100)
			QuickTrain(0, AiSoldier(0), 116, 96)			
			CreateUnit("unit-grunt", 3, {0, 115})
			CreateUnit("unit-grunt", 3, {0, 114})
			CreateUnit("unit-grunt", 3, {0, 31})
			CreateUnit("unit-grunt", 3, {0, 32})
			CreateUnit("unit-grunt", 3, {0, 33})
			CreateUnit("unit-axethrower", 3, {1, 33})
			CreateUnit("unit-axethrower", 3, {1, 34})
			CreateUnit("unit-axethrower", 3, {1, 35})
			CreateUnit("unit-grunt", 3, {0, 34})
			CreateUnit("unit-grunt", 3, {0, 35})
		end
	end
	if (timer > 200) then
		timer = 1
	elseif ((timer < 125) and (timer > 75)) then
		MoveArmyQuick(3, 71, 0, 0, 32, 5)
		MoveArmyQuick(3, 71, 0, 1, 117, 5)
		MoveArmyQuick(0, 81, 102, 80, 8, 5)
	end
	if ((GetNumUnitsAt(0, AiWorker(), {95, 25}, {111, 34}) > 0) and (GameCycle >= 10000)) then
		--CenterMap(103, 25)
		ChangeUnitsOwner({90, 10}, {130, 50}, 0, 1)
		CreateUnit(AiSoldier(), 0, {105, 25})
		CreateUnit(AiSoldier(), 0, {104, 26})
		CreateUnit(AiSoldier(), 0, {103, 29})
		CreateUnit(AiSoldier(), 0, {102, 32})
		CreateUnit(AiEliteSoldier(), 1, {105, 23})
		CreateUnit(AiEliteSoldier(), 1, {104, 24})
		CreateUnit(AiEliteSoldier(), 1, {105, 22})
	elseif ((GameCycle > 10000) and (GameCycle < 35000)) then
		AiRedRibbon_2014()
		MoveArmyQuick(1, 73, 66, 106, 76, 10)
		MoveArmyQuick(1, 106, 66, 109, 7, 10)
		MoveArmyQuick(1, 106, 66, 86, 9, 10)
		MoveArmyQuick(1, 81, 102, 74, 70, 5)
	elseif ((GameCycle > 35000) and (GameCycle < 35100)) then
		CreateUnit(AiEliteSoldier(), 1, {61, 0})
		CreateUnit(AiEliteSoldier(), 1, {62, 0})
		CreateUnit(AiEliteSoldier(), 1, {63, 0})
		CreateUnit(AiEliteSoldier(), 1, {64, 0})
	else
		AiRedRibbon_Common_2014()
	end
end

DefineAi("ai_level06", "*", "ai_level06", AiLevel06)
