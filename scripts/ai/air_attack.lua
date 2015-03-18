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
--      air_attack.lua - Define the air attack AI.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
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

local end_loop_air_funcs = {
  function() DebugPrint("Looping !\n"); return false end,
  function() return AiForce(1, {AiFlyer(), 2}, true) end,
  function() return AiForce(2, {AiFlyer(), 2}, true) end,
  function() return AiForce(3, {AiFlyer(), 2}, true) end,
  function() return AiForce(4, {AiFlyer(), 2}, true) end,
  function() return AiForce(5, {AiFlyer(), 2}, true) end,
  function() return AiForce(6, {AiFlyer(), 1}, true) end,
  function() return AiWaitForce(5) end,
  function() return AiWaitForce(6) end,  -- wait until attack party is completed
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,
  function() return AiAttackWithForce(3) end,
  function() return AiAttackWithForce(4) end,
  function() return AiAttackWithForce(5) end,
  function() return AiSleep(500) end,
  function() stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = 0; return false end,
}

local air_funcs = {
  function() return AiSleep(AiGetSleepCycles()) end,
  function() AiSetReserve({0,  0, 0, 0,  0, 0, 0}) return false end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiSet(AiWorker(), 1) end,
  function() return AiWait(AiCityCenter()) end,
  function() return AiWait(AiWorker()) end, -- start hangs if nothing is available

  function() return AiSet(AiWorker(), 9) end,
  function() return AiNeed(AiLumberMill()) end,
  function() return AiNeed(AiBarracks()) end,
  function() return AiWait(AiBarracks()) end,
  function() return AiForce(0, {AiSoldier(), 2}) end,
  function() return AiForceRole(0, "defend") end,
  function() return AiWaitForce(0) end,  -- wait until defense is ready

  function() return AiNeed(AiBlacksmith()) end,
  function() return AiUpgradeTo(AiBetterCityCenter()) end,
  function() return AiSet(AiWorker(), 15) end,
  function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 3}) end,
  function() return AiWait(AiBetterCityCenter()) end,

  function() return AiNeed(AiStables()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiUpgradeTo(AiBestCityCenter()) end,
  function() return AiWait(AiBestCityCenter()) end,  -- need this for airport!

  function() return AiNeed(AiAirport()) end,
  function() return AiForce(2, {AiFlyer(), 1}, true) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(2) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiAirport()) end,
  function() return AiForce(2, {AiFlyer(), 2}, true) end,
  function() return AiWaitForce(2) end,

  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiAirport()) end,
  function() return AiSet(AiWorker(), 20) end,
  function() return AiForce(1, {AiFlyer(), 2}, true) end,
  function() return AiAttackWithForce(2) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiForce(2, {AiFlyer(), 1}, true) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiForce(1, {AiFlyer(), 1}, true) end,
  function() return AiForce(2, {AiFlyer(), 2}, true) end,
  function() return AiForce(3, {AiFlyer(), 2}, true) end,
  function() return AiWaitForce(2) end,
  function() return AiWaitForce(3) end,
  function() return AiAttackWithForce(2) end,
  function() return AiAttackWithForce(3) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiForce(1, {AiFlyer(), 2}, true) end,
  function() return AiForce(2, {AiFlyer(), 2}, true) end,
  function() return AiForce(3, {AiFlyer(), 2}, true) end,
  function() return AiWaitForce(2) end,
  function() return AiWaitForce(3) end,
  function() return AiAttackWithForce(2) end,
  function() return AiAttackWithForce(3) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiForce(1, {AiFlyer(), 2}, true) end,
  function() return AiForce(2, {AiFlyer(), 2}, true) end,
  function() return AiForce(3, {AiFlyer(), 3}, true) end,
  function() return AiWaitForce(2) end,
  function() return AiWaitForce(3) end,
  function() return AiAttackWithForce(2) end,
  function() return AiAttackWithForce(3) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiForce(1, {AiFlyer(), 2}, true) end,
  function() return AiForce(2, {AiFlyer(), 3}, true) end,
  function() return AiForce(3, {AiFlyer(), 3}, true) end,
  function() return AiWaitForce(2) end,
  function() return AiWaitForce(3) end,
  function() return AiAttackWithForce(2) end,
  function() return AiAttackWithForce(3) end,

  function() return AiSleep(500) end,
  function() return AiForce(1, {AiFlyer(), 1}, true) end,
  function() return AiForce(2, {AiFlyer(), 2}, true) end,
  function() return AiForce(3, {AiFlyer(), 2}, true) end,
  function() return AiForce(4, {AiFlyer(), 2}, true) end,
  function() return AiForce(5, {AiFlyer(), 2}, true) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(2) end,
  function() return AiAttackWithForce(3) end,
  function() return AiAttackWithForce(4) end,
  function() return AiAttackWithForce(5) end,

  function() return AiSleep(500) end,
  function() return AiLoop(end_loop_air_funcs, stratagus.gameData.AIState.loop_index) end,
}

function AiAirAttack() AiLoop(air_funcs, stratagus.gameData.AIState.index) end

DefineAi("wc2-air-attack", "*", "wc2-air-attack", AiAirAttack)

