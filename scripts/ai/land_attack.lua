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
--      land_attack.lua - Strong land attack. By José Ignacio Rodríguez and Carlo Almario
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

local end_loop_funcs = {
  function() DebugPrint("Looping !\n") return false end,

-- EXPANSION AND DEFENSE

  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiLumberMill()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,

  function() return AiForce(0, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 8, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 10, AiCavalry(), 0, AiCavalryMage(), 20, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiFlyer(), 4}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,

  function() return AiWaitForce(7) end,
  function() return AiAttackWithForce(7) end,
  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,
  function() stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = 0; return false end,
}

local land_funcs = {
  function() return AiSleep(AiGetSleepCycles()) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiSet(AiWorker(), 1) end,
  function() return AiWait(AiCityCenter()) end,
  function() return AiWait(AiWorker()) end, -- start hangs if nothing available

  function() return AiSet(AiWorker(), 4) end, -- 4

  function() return AiNeed(AiBarracks()) end,
  function() return AiSet(AiWorker(), 8) end, -- 8
  function() return AiWait(AiBarracks()) end,
  function() return AiSet(AiBlacksmith(), 1) end,
  function() return AiResearch(AiUpgradeWeapon1()) end,
  function() return AiResearch(AiUpgradeArmor1()) end,
  function() return AiResearch(AiUpgradeWeapon2()) end,
  function() return AiResearch(AiUpgradeArmor2()) end,

-- FAST AND FURIOUS
  function() return AiForce(1, {AiSoldier(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

-- SECOND FAST ATTACK
  function() return AiForce(1, {AiSoldier(), 4}) end,
  function() return AiWaitForce(1) end,
  function() return AiSet(AiWorker(), 12) end,
  function() return AiAttackWithForce(1) end,

-- PREPARING FIRST SERIOUS ATTACK

  function() return AiSet(AiBarracks(), 2) end,
  function() return AiForce(1, {AiSoldier(), 16}) end,
  function() return AiForce(0, {AiSoldier(), 4}) end,
  function() return AiSet(AiWorker(), 20) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

-- NOW UPGRADING

  function() return AiUpgradeTo(AiBetterCityCenter()) end,
  function() return AiWait(AiBetterCityCenter()) end,
  function() return AiSet(AiWorker(), 25) end,
  function() return AiNeed(AiStables()) end,

-- BUILDING A DEFENSE
 function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 2, AiCavalryMage(), 0, AiCatapult(), 0}) end,

 function() return AiNeed(AiLumberMill()) end,
 function() return AiWait(AiLumberMill()) end,
 function() return AiUpgradeTo(AiBestCityCenter()) end,
 function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 2, AiCavalry(), 2, AiCavalryMage(), 0, AiCatapult(), 0}) end,
 function() return AiSet(AiWorker(), 30) end,
 function() return AiWait(AiBestCityCenter()) end,

-- UPGRADING CAVALRY STUFF

  function() return AiNeed(AiTemple()) end,
  function() return AiResearch(AiUpgradeCavalryMage()) end,
  function() return AiResearch(AiCavalryMageSpell1()) end,

-- PREPARING SECOND ATTACK

  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 10, AiCatapult(), 0}) end,
  function() return AiForce(5, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 8, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 6, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 4, AiCatapult(), 0}) end,
  function() return AiForce(8, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 3, AiCatapult(), 1}) end,
  function() return AiSet(AiWorker(), 35) end,
  function() return AiForce(0, {AiSoldier(), 0}) end,
  function() return AiWaitForce(0) end,
  function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 2, AiCavalry(), 0, AiCavalryMage(), 4, AiCatapult(), 0}) end,

-- EXPANSION

  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiBarracks()) end,

-- ATTACK!!

  function() return AiWaitForce(4) end,
  function() return AiAttackWithForce(4) end,
--  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
--  function() return AiForce(5, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
--  function() return AiForce(6, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(7) end,
  function() return AiAttackWithForce(7) end,
--  function() return AiForce(7, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(8) end,
  function() return AiAttackWithForce(8) end,
  function() return AiAttackWithForce(7) end,
  function() return AiAttackWithForce(6) end,
  function() return AiAttackWithForce(5) end,
  function() return AiAttackWithForce(4) end,
--  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiForce(8, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 22, AiCatapult(), 0}) end,
  function() return AiForce(5, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 18, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 14, AiCatapult(), 0}) end,
  function() return AiSet(AiWorker(), 40) end,

  function() return AiWaitForce(4) end,
  function() return AiAttackWithForce(4) end,
  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
  function() return AiForce(5, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,


-- EXPANSION

  function() return AiSet(AiWorker(), 45) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,

-- UPGRADING SHOOTERS

  function() return AiResearch(AiUpgradeEliteShooter()) end,
  function() return AiResearch(AiUpgradeEliteShooter1()) end,
  function() return AiResearch(AiUpgradeEliteShooter2()) end,
  function() return AiResearch(AiUpgradeEliteShooter3()) end,

  function() return AiSet(AiWorker(), 40) end,
  function() return AiNeed(AiCityCenter()) end,

-- SECOND BIG WAVE

  function() return AiForce(4, {AiSoldier(), 0, AiEliteShooter(), 5, AiCavalry(), 0, AiCavalryMage(), 12, AiCatapult(), 0}) end,
  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 5, AiCavalry(), 0, AiCavalryMage(), 10, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 2, AiCavalry(), 0, AiCavalryMage(), 5, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 1, AiCavalry(), 0, AiCavalryMage(), 3, AiCatapult(), 0}) end,

  function() return AiWaitForce(4) end,
  function() return AiAttackWithForce(4) end,
  function() return AiForce(4, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(7) end,
  function() return AiAttackWithForce(7) end,
  function() return AiAttackWithForce(6) end,
  function() return AiAttackWithForce(5) end,
  function() return AiAttackWithForce(4) end,

  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,

-- EXPANSION, AGAIN

  function() return AiNeed(AiAirport()) end,
  function() return AiNeed(AiAirport()) end,

  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,

  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,

-- AEREAL UNITS
  function() return AiNeed(AiAirport()) end,
  function() return AiWait(AiAirport()) end,

  function() return AiForce(5, {AiFlyer(), 3}) end,

-- THIRD ATTACK

  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 10, AiCavalry(), 0, AiCavalryMage(), 15, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 20, AiCatapult(), 0}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,
  function() return AiWaitForce(7) end,
  function() return AiAttackWithForce(7) end,
  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,


  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,

-- ANOTHER EXPANSION, ANOTHER BIG ATTACK

  function() return AiNeed(AiBarracks()) end,
  function() return AiNeed(AiBarracks()) end,

  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 15, AiCavalry(), 0, AiCavalryMage(), 40, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 10, AiCavalry(), 0, AiCavalryMage(), 20, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiFlyer(), 4}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,
  function() return AiWaitForce(7) end,
  function() return AiAttackWithForce(7) end,
  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0, AiFlyer(), 0}) end,

-- LITTLE DEFENSE

  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,


  -- Everything researched...

  function() return AiLoop(end_loop_funcs, stratagus.gameData.AIState.loop_index) end,
}

function AiLandAttack() AiLoop(land_funcs, stratagus.gameData.AIState.index); end

DefineAi("wc2-land-attack", "*", "wc2-land-attack", AiLandAttack)

