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
--      ai.lua - Define the AI.
--
--      (c) Copyright 2004 by Jimmy Salmon and Crestez Leonard
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
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--      $Id$

--=============================================================================
--  This AI script builds only workers and tankers and oil platform.
--  Also if needed a farm.
--

local player

function AiLoop(loop_funcs, loop_pos)
    local ret

    player = AiPlayer() + 1
    while (true) do
    	ret = loop_funcs[loop_pos[player]]()
	if (ret) then
	    break
	end
	loop_pos[player] = loop_pos[player] + 1
    end
    return true
end

--[[ ORC 03 campaign AI]]--

InitFuncs:add(function()
  orc_03_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  orc_03_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local orc_03_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(65535) end,
    function() orc_03_loop_pos[player] = 0; return false end,
}
	
local orc_03_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 2) end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiWait(AiWorker()) end,
    function() return AiNeed(AiPlatform()) end,
    function() return AiLoop(orc_03_loop_funcs, orc_03_loop_pos) end,
}

function AiOrc03() return AiLoop(orc_03_funcs, orc_03_pos) end
DefineAi("orc-03", "*", "orc-03", AiOrc03)

--[[ human 04 campaign AI]]--
--	This AI script builds only workers and tankers and oil platform.
--		Also if needed a farm.
--		Attacks with soldier and shooter and destroyer.

InitFuncs:add(function()
  hum_04_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_04_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_04_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(25000) end,
    function() hum_04_loop_pos[player] = 0; return false end,
}
	
local hum_04_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 4) end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiWait(AiWorker()) end,
    function() return AiNeed(AiPlatform()) end,
	function() return AiSet(AiTransporter(), 4) end,
    function() return AiForce(0, {AiDestroyer(), 2, AiSoldier(), 3, AiShooter(), 4}) end,
    function() return AiForce(1, {AiDestroyer(), 2, AiSoldier(), 3, AiShooter(), 4}) end,
    function() return AiSleep(27000) end,
	function() return AiSet(AiTransporter(), 6) end,
    function() return AiForce(1, {AiDestroyer(), 4, AiSoldier(), 10, AiShooter(), 8}) end,
    function() return AiSleep(22000) end,
    function() return AiSleep(22000) end,
    function() return AiSleep(18000) end,
    function() return AiLoop(hum_04_loop_funcs, hum_04_loop_pos) end,
}

function AiHuman04() return AiLoop(hum_04_funcs, hum_04_pos) end
DefineAi("hum-04", "*", "hum-04", AiHuman04)

--[[ orc 04 campaign AI]]--
--	This AI script builds only workers and tankers and oil platform.
--		Also if needed a farm.
--		Attacks with soldier and shooter and destroyer.

InitFuncs:add(function()
  orc_04_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  orc_04_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local orc_04_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(10500) end,
    function() orc_04_loop_pos[player] = 0; return false end,
}
	
local orc_04_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 4) end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiWait(AiWorker()) end,
    function() return AiSet(AiTransporter(), 1) end,
    function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 4, AiDestroyer(), 2}) end,
    function() return AiNeed(AiPlatform()) end,
    function() return AiSet(AiTransporter(), 2) end,
    function() return AiSleep(15000) end,
    function() return AiForce(0, {AiSoldier(), 6, AiShooter(), 5, AiDestroyer(), 2}) end,
    function() return AiSleep(15000) end,
    function() return AiSleep(19500) end,
    function() return AiForce(0, {AiSoldier(), 10, AiShooter(), 8, AiDestroyer(), 2}) end,
    function() return AiSleep(12000) end,
    function() return AiSleep(13500) end,
    function() return AiSleep(30500) end,
    function() return AiLoop(orc_04_loop_funcs, orc_04_loop_pos) end,
}

function AiOrc04() return AiLoop(orc_04_funcs, orc_04_pos) end
DefineAi("orc-04", "*", "orc-04", AiOrc04)

--[[ Human 05 campaign ai ]]--
--	This AI script builds only workers and tankers and oil platform.
--		Also if needed a farm.
--		Attacks with soldier, shooter and destroyer.

InitFuncs:add(function()
  hum_05_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_05_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_05_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(18000) end,
    function() return AiSleep(12000) end,
    function() return AiSleep(24000) end,
    function() return AiSleep(14000) end,
    function() hum_05_loop_pos[player] = 0; return false end,
}
	
local hum_05_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 4) end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiSet(AiTransporter(), 1) end,
    function() return AiWait(AiWorker()) end,
    function() return AiNeed(AiPlatform()) end,
    function() return AiForce(0, {AiDestroyer(), 3, AiSoldier(), 4, AiShooter(), 3}) end,
	function() return AiSet(AiTransporter(), 3) end,
    function() return AiSleep(3000) end,
    function() return AiSleep(4000) end,
    function() return AiSleep(4000) end,
    function() return AiSleep(12000) end,
    function() return AiForce(0, {AiDestroyer(), 4, AiSoldier(), 12, AiShooter(), 4}) end,
	function() return AiSet(AiTransporter(), 7) end,
    function() return AiSleep(14000) end,
    function() return AiSleep(12000) end,
    function() return AiLoop(hum_05_loop_funcs, hum_05_loop_pos) end,
}

function AiHuman05() return AiLoop(hum_05_funcs, hum_05_pos) end
DefineAi("hum-05", "*", "hum-05", AiHuman05)

--[[ Human 06 campaign ai ]]--
--	This AI script builds only workers, blacksmith.
--		Also if needed a farm.
--		Upgrades weapon and missile.
--		Attacks with soldier, shooter and cavalrie.

InitFuncs:add(function()
  hum_06_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_06_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_06_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 1, AiCavalry(), 1}) end,
    function() return AiSleep(14000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 3, AiCavalry(), 2}) end,
    function() return AiSleep(11000) end,
    function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 3, AiCavalry(), 2}) end,
    function() return AiSleep(8000) end,
    function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 2, AiCavalry(), 2}) end,
    function() return AiSleep(11000) end,
    function() return AiSleep(9000) end,
    function() hum_06_loop_pos[player] = 0; return false end,
}
	
local hum_06_funcs = {
    function() AiDebug(false) return false end,

    function() return AiSet(AiWorker(), 4) end,
    function() return AiWait(AiWorker()) end,
    function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 3}) end,
    function() return AiSleep(4000) end,
    function() return AiSleep(3000) end,
    function() return AiSleep(4000) end,
    function() return AiNeed(AiBlacksmith()) end,
    function() return AiResearch(AiUpgradeMissile1()) end,
    function() return AiForce(0, {AiSoldier(), 4, AiShooter(), 4}) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiForce(0, {AiSoldier(), 6, AiShooter(), 4}) end,
    function() return AiSleep(13000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 3, AiCavalry(), 3}) end,
    function() return AiSleep(14000) end,
    function() return AiResearch(AiUpgradeArmor1()) end,
    function() return AiLoop(hum_06_loop_funcs, hum_06_loop_pos) end,
}

function AiHuman06() return AiLoop(hum_06_funcs, hum_06_pos) end
DefineAi("hum-06", "*", "hum-06", AiHuman06)

--[[ Human 07 campaign ai]]--
--	This AI script builds only worker and tanker.
--
InitFuncs:add(function()
  hum_07_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_07_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 2) end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiSleep(10000) end,
    function() hum_07_pos[player] = 1; return false end,
}

function AiHuman07() return AiLoop(hum_07_funcs, hum_07_pos) end
DefineAi("hum-07", "*", "hum-07", AiHuman07)

--=============================================================================
--	This AI script builds only workers, blacksmith.
--		Also if needed a farm.
--		Upgrades weapon and missile.
--		Attacks with soldier, shooter and cavalrie.
InitFuncs:add(function()
  hum_08_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_08_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_08_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(16000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 4, AiCavalry(), 3, AiCatapult(), 1}) end,
    function() return AiSleep(14000) end,
    function() return AiSleep(12000) end,
    function() hum_08_loop_pos[player] = 0; return false end,
}
	
local hum_08_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 3) end,
    function() return AiWait(AiWorker()) end,
    function() return AiForce(0, {AiSoldier(), 5, AiShooter(), 4}) end,
    function() return AiSleep(14000) end,
    function() return AiForce(0, {AiSoldier(), 5, AiShooter(), 5, AiCavalry(), 3}) end,
    function() return AiSleep(10000) end,
    function() return AiSleep(15000) end,
    function() return AiResearch(AiUpgradeCavalryMage()) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiUpgradeMissile1()) end,
    function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 5, AiCavalry(), 4, AiCatapult(), 1}) end,
    function() return AiSleep(15000) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiResearch(AiUpgradeArmor1()) end,
    function() return AiSleep(21000) end,
    function() return AiResearch(AiUpgradeEliteShooter()) end,
    function() return AiSleep(12000) end,
    function() return AiLoop(hum_08_loop_funcs, hum_08_loop_pos) end,
}

function AiHuman08() return AiLoop(hum_08_funcs, hum_08_pos) end
DefineAi("hum-08", "*", "hum-08", AiHuman08)

--=============================================================================
--	This AI script builds only worker and tanker.
--
InitFuncs:add(function()
  hum_09_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_09_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 2) end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiSleep(10000) end,
    function() hum_09_pos[player] = 1; return false end,
}

function AiHuman09() return AiLoop(hum_09_funcs, hum_09_pos) end
DefineAi("hum-09", "*", "hum-09", AiHuman09)

--=============================================================================
--	This AI script builds only worker and tanker.
--		Upgrades very much.
--		Attacks with land units and water units.
--

InitFuncs:add(function()
  hum_10_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_10_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_10_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(5000) end,
    function() return AiForce(0, {AiSoldier(), 4, AiShooter(), 4, AiCavalry(), 4,
	    AiCatapult(), 1}) end,
	function() return AiSet(AiTransporter(), 1) end,
    function() return AiSleep(6000) end,
    function() return AiForce(0, {AiDestroyer(), 3, AiBattleship(), 1}) end,
    function() return AiSleep(5000) end,
    function() hum_10_loop_pos[player] = 0; return false end,
}
	
local hum_10_funcs = {
    function()
	AiDebug(false)
	AiForceRole(0, "defend")
	AiForceRole(1, "defend")
	return false
    end,
    function() return AiSet(AiWorker(), 7) end,
    function() return AiSet(AiTanker(), 3) end,
    function() return AiWait(AiWorker()) end,

    function() return AiSet(AiTransporter(), 1) end,
    function() return AiForce(0, {AiDestroyer(), 2}) end,
    function() return AiSleep(6000) end,
    function() return AiForce(0, {AiSoldier(), 4, AiShooter(), 4,
	    AiDestroyer(), 2}) end,

    function() return AiResearch(AiUpgradeCavalryMage()) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiMageSpell1()) end,
    function() return AiResearch(AiMageSpell2()) end,
    function() return AiResearch(AiUpgradeMissile1()) end,
 
    function() return AiSet(AiTransporter(), 2) end,
    function() return AiForce(0, {AiSoldier(), 4, AiShooter(), 4, AiDestroyer(), 2}) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiSleep(4000) end,
    function() return AiResearch(AiUpgradeArmor1()) end,

    function() return AiSleep(5000) end,
    function() return AiForce(0, {AiDestroyer(), 3, AiBattleship(), 1}) end,
    function() return AiResearch(AiUpgradeMissile2()) end,
    function() return AiResearch(AiUpgradeWeapon2()) end,

    function() return AiResearch(AiUpgradeShipCannon1()) end,
    function() return AiSleep(3000) end,
    function() return AiResearch(AiUpgradeArmor2()) end,
    function() return AiResearch(AiUpgradeShipArmor1()) end,
    function() return AiResearch(AiUpgradeEliteShooter()) end,

    function() return AiResearch(AiUpgradeCatapult1()) end,
    function() return AiResearch(AiUpgradeShipCannon2()) end,
    function() return AiResearch(AiUpgradeShipArmor2()) end,
    function() return AiResearch(AiUpgradeEliteShooter1()) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiMage(), 1}) end,
    function() return AiSleep(5000) end,
    function() return AiResearch(AiUpgradeEliteShooter2()) end,
    function() return AiResearch(AiUpgradeEliteShooter3()) end,

    function() return AiSleep(5000) end,
    function() return AiLoop(hum_10_loop_funcs, hum_10_loop_pos) end,
}

function AiHuman10() return AiLoop(hum_10_funcs, hum_10_pos) end
DefineAi("hum-10", "*", "hum-10", AiHuman10)

--=============================================================================
--	This AI script builds only workers.
--		Upgrades very much.
--		Attacks with land units.

InitFuncs:add(function()
  hum_11_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_11_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_11_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(12000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 1,
	    AiCavalry(), 1, AiCatapult(), 1, AiMage(), 3}) end,
    function() return AiSleep(8000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 1,
	    AiCavalry(), 1, AiCatapult(), 1, AiMage(), 3}) end,
    function() return AiSleep(13000) end,
    function() hum_11_loop_pos[player] = 0; return false end,
}
	
local hum_11_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiWorker(), 8) end,
    function() return AiWait(AiWorker()) end,
    function() return AiSleep(6000) end,
    function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 2, AiCavalry(), 2}) end,
    function() return AiSleep(6000) end,
    function() return AiSleep(7000) end,
    function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 2, AiCavalry(), 2}) end,
    function() return AiSleep(5000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 1, AiCavalry(), 2, AiCatapult(), 1}) end,
    function() return AiResearch(AiUpgradeMissile1()) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiResearch(AiUpgradeArmor1()) end,
    function() return AiSleep(6000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 1,
	    AiCavalry(), 1, AiCatapult(), 1, AiMage(), 3}) end,
    function() return AiSleep(9000) end,
    function() return AiSleep(7000) end,
    function() return AiResearch(AiUpgradeEliteShooter()) end,
    function() return AiResearch(AiUpgradeEliteShooter1()) end,
    function() return AiSleep(13000) end,
    function() return AiResearch(AiUpgradeEliteShooter2()) end,
    function() return AiResearch(AiMageSpell1()) end,
    function() return AiResearch(AiUpgradeCavalryMage()) end,
    function() return AiSleep(7000) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiMageSpell2()) end,
    function() return AiResearch(AiUpgradeWeapon2()) end,
    function() return AiSleep(12000) end,
    function() return AiResearch(AiUpgradeArmor2()) end,
    function() return AiResearch(AiMageSpell3()) end,
    function() return AiResearch(AiMageSpell4()) end,
    function() return AiResearch(AiUpgradeCatapult1()) end,
    function() return AiSleep(8000) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiMageSpell5()) end,
    function() return AiSleep(13000) end,
    function() return AiLoop(hum_11_loop_funcs, hum_11_loop_pos) end,
}

function AiHumam11() return AiLoop(hum_11_funcs, hum_11_pos) end
DefineAi("hum-11", "*", "hum-11", AiHumam11)

--=============================================================================
--	This AI script builds only workers and tankers.
--		Upgrades very much.
--		Attacks with land and water units.


InitFuncs:add(function()
  hum_12_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_12_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_12_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(10000) end,
    function() return AiForce(0, {AiSoldier(), 2, AiCavalry(), 10, AiMage(), 2}) end,
    function() return AiSleep(5000) end,
    function() return AiSleep(7000) end,
    function() return AiForce(0, {AiDestroyer(), 2, AiBattleship(), 2, AiSubmarine(), 5, AiScout(), 2}) end,
    function() hum_12_loop_pos[player] = 0; return false end,
}
	
local hum_12_funcs = {
    function()
	AiDebug(false) 
	AiForceRole(0, "defend")
	AiForceRole(1, "attack")
	AiForceRole(2, "defend")
	AiForceRole(3, "attack")
	return false
    end,
    function() return AiSet(AiTanker(), 3) end,
    function() return AiSet(AiWorker(), 7) end,
    function() return AiWait(AiWorker()) end,
    function() return AiNeed(AiPlatform()) end,
    
    function() return AiSet(AiTransporter(), 2) end,
    function() return AiForce(0, {AiSoldier(), 2}) end,
    function() return AiSleep(2000) end,
    function() return AiForce(0, {AiDestroyer(), 2, AiBattleship(), 2, AiSubmarine(), 4}) end,
    function() return AiSleep(3000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiCavalry(), 10, AiMage(), 2}) end,

    function() return AiResearch(AiMageSpell1()) end,
    function() return AiResearch(AiUpgradeCavalryMage()) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiMageSpell2()) end,
    function() return AiResearch(AiMageSpell3()) end,
    function() return AiResearch(AiMageSpell4()) end,
    function() return AiResearch(AiCavalryMageSpell2()) end,
    function() return AiResearch(AiMageSpell5()) end,
    function() return AiResearch(AiUpgradeShipCannon1()) end,
    function() return AiResearch(AiUpgradeShipArmor1()) end,
    function() return AiSleep(4000) end,

    function() return AiForce(0, {AiDestroyer(), 2, AiBattleship(), 2, AiSubmarine(), 4}) end,
    function() return AiResearch(AiUpgradeShipCannon2()) end,
    function() return AiResearch(AiUpgradeShipArmor2()) end,
    function() return AiResearch(AiUpgradeCatapult1()) end,
    function() return AiResearch(AiUpgradeCatapult2()) end,
    function() return AiSleep(6000) end,

    function() return AiForce(0, {AiDestroyer(), 2, AiBattleship(), 2, AiSubmarine(), 5}) end,
    function() return AiSleep(7000) end,
    function() return AiSleep(5000) end,
    function() return AiForce(0, {AiSoldier(), 1, AiCavalry(), 10, AiMage(), 2, AiCatapult(), 1,
	    AiDestroyer(), 2, AiBattleship(), 2, AiSubmarine(), 5, AiScout(), 2}) end,

    function() return AiResearch(AiUpgradeMissile1()) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiResearch(AiUpgradeArmor1()) end,
    function() return AiResearch(AiUpgradeMissile2()) end,
    function() return AiResearch(AiUpgradeEliteShooter()) end,
    function() return AiResearch(AiUpgradeEliteShooter1()) end,
    function() return AiResearch(AiUpgradeEliteShooter2()) end,
    function() return AiResearch(AiUpgradeEliteShooter3()) end,
    function() return AiResearch(AiUpgradeWeapon2()) end,
    function() return AiResearch(AiUpgradeArmor2()) end,
    function() return AiLoop(hum_12_loop_funcs, hum_12_loop_pos) end,
}

function AiHuman12() return AiLoop(hum_12_funcs, hum_12_pos) end
DefineAi("hum-12", "*", "hum-12", AiHuman12)

--=============================================================================
--	This AI script builds only workers and tankers.
--		Upgrades very much.
--		Attacks with land and air units.

InitFuncs:add(function()
  hum_13_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_13_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_13_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(12000) end,
    function() return AiForce(0, {AiCavalry(), 3, AiMage(), 2, AiShooter(), 1, AiCatapult(), 2}) end,
    function() return AiSleep(14000) end,
    function() return AiForce(0, {AiFlyer(), 4}) end,
    function() return AiSleep(14000) end,
    function() hum_13_loop_pos[player] = 0; return false end,
}
	
local hum_13_funcs = {
    function() AiDebug(false) return false end,
    function() return AiSet(AiTanker(), 2) end,
    function() return AiSet(AiWorker(), 5) end,
    function() return AiWait(AiWorker()) end,
    function() return AiNeed(AiPlatform()) end,
    function() return AiSet(AiTransporter(), 2) end,
    function() return AiForce(0, {AiCavalry(), 3, AiMage(), 2}) end,

    function() return AiResearch(AiMageSpell1()) end,
    function() return AiResearch(AiUpgradeCavalryMage()) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiMageSpell2()) end,
    function() return AiResearch(AiMageSpell3()) end,
    function() return AiResearch(AiMageSpell4()) end,
    function() return AiResearch(AiCavalryMageSpell2()) end,
    function() return AiSleep(4000) end,
    function() return AiForce(0, {AiCavalry(), 4, AiMage(), 2, AiShooter(), 1}) end,

    function() return AiSleep(12000) end,
    function() return AiSleep(15000) end,
    function() return AiResearch(AiMageSpell5()) end,
    function() return AiResearch(AiUpgradeShipCannon1()) end,
    function() return AiResearch(AiUpgradeShipArmor1()) end,
    function() return AiResearch(AiUpgradeShipCannon2()) end,
    function() return AiResearch(AiUpgradeShipArmor2()) end,
    function() return AiForce(0, {AiCavalry(), 3, AiShooter(), 1, AiMage(), 2, AiCatapult(), 1}) end,

    function() return AiSleep(15000) end,
    function() return AiForce(0, {AiFlyer(), 4}) end,
    function() return AiSleep(20000) end,
    function() return AiSleep(14000) end,
    function() return AiSleep(18000) end,

    function() return AiResearch(AiUpgradeCatapult1()) end,
    function() return AiResearch(AiUpgradeCatapult2()) end,
    function() return AiResearch(AiUpgradeMissile1()) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiResearch(AiUpgradeArmor1()) end,
    function() return AiResearch(AiUpgradeMissile2()) end,
    function() return AiResearch(AiUpgradeEliteShooter()) end,
    function() return AiLoop(hum_13_loop_funcs, hum_13_loop_pos) end,
}

function AiHuman13() return AiLoop(hum_13_funcs, hum_13_pos) end
DefineAi("hum-13", "*", "hum-13", AiHuman13)

--=============================================================================
--	This AI script builds only workers and ogres.

InitFuncs:add(function()
  hum_14_orange_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_14_orange_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_14_orange_loop_funcs = {
    function() print("Looping !") return false end,
    function() hum_14_orange_loop_pos[player] = 0; return false end,
}
	
local hum_14_orange_funcs = {
    function()
	AiDebug(false)
	AiForceRole(0, "defend");
	AiForceRole(1, "attack");
	return false end,
    function() return AiSet(AiWorker(), 5) end,
    function() return AiWait(AiWorker()) end,
    function() return AiForce(0, {AiCavalry(), 15}) end,
    function() return AiLoop(hum_14_orange_loop_funcs, hum_14_orange_loop_pos) end,
}

function AiHuman14Orange() return AiLoop(hum_14_orange_funcs, hum_14_orange_pos) end
DefineAi("hum-14-orange", "*", "hum-14-orange", AiHuman14Orange)

--=============================================================================
--	This AI script builds nothing.
--		Does only upgrades.
--
InitFuncs:add(function()
  hum_14_red_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_14_red_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_14_red_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(30000) end,
    function() return AiSleep(30000) end,
    function() hum_14_red_loop_pos[player] = 0; return false end,
}
	
local hum_14_red_funcs = {
    function()
	AiDebug(false)
	AiForceRole(0, "defend");
	AiForceRole(1, "attack");
	return false end,
    function() return AiResearch(AiMageSpell1()) end,
    function() return AiResearch(AiMageSpell2()) end,
    function() return AiResearch(AiMageSpell3()) end,
    function() return AiResearch(AiMageSpell4()) end,
    function() return AiResearch(AiMageSpell5()) end,
    function() return AiLoop(hum_14_red_loop_funcs, hum_14_red_loop_pos) end,
}

function AiHuman14Red() return AiLoop(hum_14_red_funcs, hum_14_red_pos) end
DefineAi("hum-14-red", "*", "hum-14-red", AiHuman14Red)

--=============================================================================
--	This AI script builds only workers and dragons.
--		Does only air attacks.
--
--	FIXME: This AI should only collect GOLD.
InitFuncs:add(function()
  hum_14_white_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_14_white_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_14_white_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiForce(0, {AiFlyer(), 10}) end,
    function() return AiSleep(19000) end,
    function() return AiSleep(20000) end,
    function() return AiForce(1, {AiFlyer(), 12}) end,
    function() return AiSleep(21000) end,
    function() return AiSleep(20000) end,
    function() hum_14_white_loop_pos[player] = 0; return false end,
}
	
local hum_14_white_funcs = {
    function()
	AiDebug(false)
	AiForceRole(0, "defend");
	AiForceRole(1, "attack");
	return false end,
    function() return AiSet(AiWorker(), 9) end,
    function() return AiWait(AiWorker()) end,
    function() return AiForce(1, {AiFlyer(), 10}) end,
    function() return AiSleep(64000) end,
    function() return AiSleep(12000) end,
    function() return AiSleep(18000) end,
    function() return AiLoop(hum_14_white_loop_funcs, hum_14_white_loop_pos) end,
}

function AiHuman14White() return AiLoop(hum_14_white_funcs, hum_14_white_pos) end
DefineAi("hum-14-white", "*", "hum-14-white", AiHuman14White)

--=============================================================================
--	This AI script builds only tanker.
--		Does only upgrades.
--
--	FIXME: This AI should only collect GOLD.
--
--
InitFuncs:add(function()
  hum_14_black_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  hum_14_black_loop_pos = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local hum_14_black_loop_funcs = {
    function() print("Looping !") return false end,
    function() return AiSleep(30000) end,
    function() hum_14_black_loop_pos[player] = 0; return false end,
}
	
local hum_14_black_funcs = {
    function()
	AiDebug(false)
	AiForceRole(0, "defend");
	AiForceRole(1, "attack");
	return false end,
    function() return AiSet(AiTanker(), 1) end,
    function() return AiResearch(AiUpgradeCavalryMage()) end,
    function() return AiResearch(AiCavalryMageSpell1()) end,
    function() return AiResearch(AiCavalryMageSpell2()) end,
    function() return AiResearch(AiMageSpell1()) end,
    function() return AiResearch(AiMageSpell2()) end,
    function() return AiResearch(AiMageSpell3()) end,
    function() return AiResearch(AiMageSpell4()) end,
    function() return AiResearch(AiMageSpell5()) end,
    function() return AiResearch(AiUpgradeWeapon1()) end,
    function() return AiResearch(AiUpgradeArmor1()) end,
    function() return AiResearch(AiUpgradeWeapon2()) end,
    function() return AiResearch(AiUpgradeArmor2()) end,
    function() return AiResearch(AiUpgradeEliteShooter()) end,
    function() return AiResearch(AiUpgradeEliteShooter1()) end,
    function() return AiResearch(AiUpgradeEliteShooter2()) end,
    function() return AiResearch(AiUpgradeEliteShooter3()) end,
    function() return AiResearch(AiUpgradeShipCannon1()) end,
    function() return AiResearch(AiUpgradeShipArmor1()) end,
    function() return AiResearch(AiUpgradeShipCannon2()) end,
    function() return AiResearch(AiUpgradeShipArmor2()) end,
    function() return AiLoop(hum_14_black_loop_funcs, hum_14_black_loop_pos) end,
}

function AiHuman14Black() return AiLoop(hum_14_black_funcs, hum_14_black_pos) end
DefineAi("hum-14-black", "*", "hum-14-black", AiHuman14Black)
