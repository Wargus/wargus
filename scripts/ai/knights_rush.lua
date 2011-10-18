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
--      knights_rush.lua - Define the knights rush AI.
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
--      $Id: knights_rush.lua,v 1.2 2004/01/14 22:06:18 mponsen Exp $

ai_knights_rush_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
ai_knights_rush_end_loop_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

local player

local end_loop_funcs = {
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
  function() ai_knights_rush_end_loop_func[player] = 0; return false end,
}

function AiKnightsRushEndloop()
  local ret

  while (true) do
    ret = end_loop_funcs[ai_knights_rush_end_loop_func[player]]()
    if (ret) then
      break
    end
    ai_knights_rush_end_loop_func[player] = ai_knights_rush_end_loop_func[player] + 1
  end
  return true
end

local knights_funcs = {
 function() return AiSleep(AiGetSleepCycles()) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiSet(AiWorker(), 1) end,
  function() return AiWait(AiCityCenter()) end,
  function() return AiWait(AiWorker()) end, -- start hangs if nothing available
  function() return AiSet(AiWorker(), 10) end,
  function() return AiNeed(AiBarracks()) end,
  function() return AiForce(0, {AiSoldier(), 2}) end,
  function() return AiForce(1, {AiSoldier(), 10}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,
  function() return AiSet(AiWorker(), 15) end,
  function() return AiNeed(AiBlacksmith()) end,
  function() return AiWait(AiBlacksmith()) end,
  function() return AiResearch(AiUpgradeWeapon1()) end,
  function() return AiResearch(AiUpgradeArmor1()) end,
  function() return AiResearch(AiUpgradeWeapon2()) end,
  function() return AiResearch(AiUpgradeArmor2()) end,
  function() return AiNeed(AiBarracks()) end,
  function() return AiSet(AiWorker(), 27) end,
  function() return AiForce(0, {AiSoldier(), 6}) end,
  function() return AiUpgradeTo(AiBetterCityCenter()) end,
  function() return AiWait(AiBetterCityCenter()) end,
  function() return AiNeed(AiStables()) end,
  function() return AiNeed(AiLumberMill()) end,
  function() return AiWait(AiStables()) end,
  function() return AiWait(AiLumberMill()) end,
  function() return AiUpgradeTo(AiBestCityCenter()) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiWait(AiBestCityCenter()) end,
  function() return AiNeed(AiTemple()) end,
  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 8, AiCatapult(), 0}) end,
  function() return AiForce(5, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 6, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 5, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 4, AiCatapult(), 0}) end,
  function() return AiForce(8, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 3, AiCatapult(), 0}) end,
  function() return AiForce(0, {AiSoldier(), 0, AiShooter(), 3, AiCavalry(), 0, AiCavalryMage(), 10, AiCatapult(), 0}) end,
  function() return AiWaitForce(4) end,
  function() return AiAttackWithForce(4) end,
  function() return AiForce(4, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
  function() return AiForce(5, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(7) end,
  function() return AiAttackWithForce(7) end,
  function() return AiForce(7, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(8) end,
  function() return AiAttackWithForce(8) end,
  function() return AiForce(8, {AiSoldier(), 0, AiShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiForce(4, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 22, AiCatapult(), 0}) end,
  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 2, AiCavalry(), 0, AiCavalryMage(), 15, AiCatapult(), 0}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 6, AiCavalry(), 0, AiCavalryMage(), 8, AiCatapult(), 0}) end,
  function() return AiWaitForce(4) end,
  function() return AiAttackWithForce(4) end,
  function() return AiForce(4, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(5) end,
  function() return AiAttackWithForce(5) end,
  function() return AiForce(5, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiWaitForce(6) end,
  function() return AiAttackWithForce(6) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 0, AiCatapult(), 0}) end,
  function() return AiSet(AiWorker(), 30) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiSet(AiWorker(), 35) end,
  function() return AiNeed(AiCityCenter()) end,
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
  function() return AiNeed(AiAirport()) end,
  function() return AiNeed(AiAirport()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiCannonTower()) end,
  function() return AiNeed(AiTower()) end,
  function() return AiUpgradeTo(AiGuardTower()) end,
  function() return AiForce(5, {AiFlyer(), 3}) end,
  function() return AiForce(6, {AiSoldier(), 0, AiEliteShooter(), 8, AiCavalry(), 0, AiCavalryMage(), 16, AiCatapult(), 0}) end,
  function() return AiForce(7, {AiSoldier(), 0, AiEliteShooter(), 0, AiCavalry(), 0, AiCavalryMage(), 18, AiCatapult(), 0}) end,
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
  function() return AiKnightsRushEndloop() end,
}

function AiKnightsRush()
  local ret

  player = AiPlayer() + 1

  while (true) do
    ret = knights_funcs[ai_knights_rush_func[player]]()
    if (ret) then
      break
    end
    ai_knights_rush_func[player] = ai_knights_rush_func[player] + 1
  end
end

DefineAi("wc2-knights-rush", "*", "knights-rush", AiKnightsRush)