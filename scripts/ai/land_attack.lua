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
--      land_attack.lua - Define the land attack AI.
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
--      $Id$

ai_land_attack_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
ai_land_attack_end_loop_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

local player

local end_loop_funcs = {
  function() print("Looping !") return false end,
  function() return AiForce(0, {AiSoldier(), 1, AiEliteShooter(), 2, AiCavalryMage(), 4, AiCatapult(), 1, AiMage(), 4}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiEliteShooter(), 2, AiCavalryMage(), 4, AiCatapult(), 1, AiMage(), 2}) end,
  function() return AiForce(2, {AiFlyer(), 1}) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,
  function() return AiSleep(500) end,
  function() ai_land_attack_end_loop_func[player] = 0; return false end,
}

function AiLandAttackEndloop()
  local ret

  while (true) do
    ret = end_loop_funcs[ai_land_attack_end_loop_func[player]]()
    if (ret) then
      break
    end
    ai_land_attack_end_loop_func[player] = ai_land_attack_end_loop_func[player] + 1
  end
  return true
end

local land_funcs = {
  function() AiDebug(false) return false end,
  function() return AiSleep(AiGetSleepCycles()) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiSet(AiWorker(), 1) end,
  function() return AiWait(AiCityCenter()) end,
  function() return AiWait(AiWorker()) end, -- start hangs if nothing available

  function() return AiSet(AiWorker(), 4) end,
  function() return AiNeed(AiLumberMill()) end,
  function() return AiNeed(AiBarracks()) end,
  function() return AiForce(0, {AiSoldier(), 2}) end,
  function() return AiForce(1, {AiSoldier(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSet(AiWorker(), 9) end,
  function() return AiSleep(500) end,
  function() return AiNeed(AiBlacksmith()) end,
  function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 1}) end,
  function() return AiForce(1, {AiSoldier(), 2, AiShooter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiResearch(AiUpgradeWeapon1()) end,
  function() return AiResearch(AiUpgradeArmor1()) end,
  function() return AiResearch(AiUpgradeMissile1()) end,
  function() return AiResearch(AiUpgradeWeapon2()) end,
  function() return AiResearch(AiUpgradeArmor2()) end,
  function() return AiResearch(AiUpgradeMissile2()) end,
  function() return AiNeed(AiBarracks()) end,

  function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2}) end,
  function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiSet(AiWorker(), 15) end,
  function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2}) end,
  function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCatapult(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiUpgradeTo(AiBetterCityCenter()) end,
  function() return AiWait(AiBetterCityCenter()) end,

  function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCatapult(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiStables()) end,
  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,
    
  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiBarracks()) end,
  function() return AiUpgradeTo(AiBestCityCenter()) end,
  function() return AiSet(AiWorker(), 19) end,
  function() return AiWait(AiBestCityCenter()) end,

  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTemple()) end,
  function() return AiResearch(AiUpgradeCavalryMage()) end,
  function() return AiResearch(AiCavalryMageSpell1()) end,
  function() return AiResearch(AiCavalryMageSpell2()) end,

  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 0, AiCavalryMage(), 5, AiCatapult(), 1}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 0, AiCavalryMage(), 3, AiCatapult(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiMageTower()) end,
  function() return AiResearch(AiMageSpell4()) end,
  function() return AiResearch(AiMageSpell5()) end,

  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalryMage(), 6, AiCatapult(), 3, AiMage(), 2}) end,
  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalryMage(), 2, AiCatapult(), 1, AiMage(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiResearch(AiMageSpell1()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiResearch(AiMageSpell3()) end,

  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalryMage(), 6, AiCatapult(), 1, AiMage(), 5}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalryMage(), 2, AiCatapult(), 1, AiMage(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiAirport()) end,

  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalryMage(), 6, AiCatapult(), 1, AiMage(), 5}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalryMage(), 2, AiCatapult(), 1, AiMage(), 1}) end,
  function() return AiForce(2, {AiFlyer(), 1}) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,

  function() return AiSleep(500) end,
  function() return AiResearch(AiUpgradeEliteShooter()) end,
  function() return AiResearch(AiUpgradeEliteShooter1()) end,
  function() return AiResearch(AiMageSpell2()) end,
  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 0, AiEliteShooter(), 2, AiCavalryMage(), 6, AiCatapult(), 1, AiMage(), 5}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 0, AiEliteShooter(), 2, AiCavalryMage(), 2, AiCatapult(), 1, AiMage(), 1}) end,
  function() return AiForce(2, {AiFlyer(), 1}) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiScientific()) end,
  function() return AiResearch(AiUpgradeEliteShooter2()) end,

  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 0, AiEliteShooter(), 2, AiCavalryMage(), 6, AiCatapult(), 1, AiMage(), 5}) end,
  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 0, AiEliteShooter(), 2, AiCavalryMage(), 2, AiCatapult(), 1, AiMage(), 1}) end,
  function() return AiForce(2, {AiFlyer(), 1}) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiResearch(AiUpgradeCatapult1()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiResearch(AiUpgradeCatapult2()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiSet(AiWorker(), 25) end,

  -- Everything researched...

  function() return AiLandAttackEndloop() end,
}

function AiLandAttack()
  local ret

  player = AiPlayer() + 1

  while (true) do
--    print("Executing land_funcs[" .. ai_land_attack_func[player] .. "]")
    ret = land_funcs[ai_land_attack_func[player]]()
    if (ret) then
      break
    end
    ai_land_attack_func[player] = ai_land_attack_func[player] + 1
  end
end

DefineAi("wc2-land-attack", "*", "land-attack", AiLandAttack)

