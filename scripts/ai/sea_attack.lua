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
--      sea_attack.lua - Define the sea attack AI.
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

InitFuncs:add(function()
  ai_sea_attack_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  ai_sea_attack_end_loop_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
end)

local player

local end_loop_sea_funcs = {
  function() DebugPrint("Looping !\n"); return false end,
  function() return AiForce(1, {AiDestroyer(), 6, AiBattleship(), 7, AiScout(), 1}) end,
  function() return AiForce(2, {AiSoldier(), 4, AiCavalry(), 4, AiCatapult(), 4, AiTransporter(), 2}) end,
  function() return AiWaitForce(1) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,
  function() return AiSleep(500) end,
  function() ai_sea_attack_end_loop_func[player] = 0; return false end,
}

function AiSeaAttackEndloop()
  local ret

  while (true) do
    ret = end_loop_sea_funcs[ai_sea_attack_end_loop_func[player]]()
    if (ret) then
      break
    end
    ai_sea_attack_end_loop_func[player] = ai_sea_attack_end_loop_func[player] + 1
  end
  return true
end

local sea_funcs = {
  function() AiDebug(false) return false end,
  function() return AiSleep(AiGetSleepCycles()) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiSet(AiWorker(), 1) end,
  function() return AiWait(AiCityCenter()) end,
  function() return AiWait(AiWorker()) end,  -- start hangs if nothing is available

  function() return AiSet(AiWorker(), 9) end,
  function() return AiNeed(AiLumberMill()) end,
  function() return AiNeed(AiBarracks()) end,
  function() return AiForce(0, {AiSoldier(), 3}) end,
  function() return AiForceRole(0, "defend") end,
  function() return AiWaitForce(0) end,

  function() return AiNeed(AiHarbor()) end,
  function() return AiUpgradeTo(AiBetterCityCenter()) end,
  function() return AiNeed(AiRefinery()) end,
  function() return AiNeed(AiScientific()) end,
  function() return AiSet(AiWorker(), 15) end,
  function() return AiSet(AiTanker(), 1) end,
  function() return AiNeed(AiPlatform()) end,
  function() return AiWait(AiBetterCityCenter()) end,

  function() return AiSet(AiTanker(), 3) end,
  function() return AiForce(1, {AiSubmarine(), 3}) end,
  function() return AiWaitForce(1) end,  -- wait until attack force is ready
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiFoundry()) end,
  function() return AiResearch(AiUpgradeShipArmor1()) end,
  function() return AiResearch(AiUpgradeShipArmor2()) end,
  function() return AiSet(AiTanker(), 4) end,
  function() return AiForce(1, {AiSubmarine(), 4}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiHarbor()) end,
  function() return AiNeed(AiBlacksmith()) end,
  function() return AiForce(1, {AiSubmarine(), 5, AiScout(), 1}) end,
  function() return AiWaitForce(1) end,  -- wait until attack force is ready
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiResearch(AiUpgradeCatapult1()) end,
  function() return AiNeed(AiStables()) end,
  function() return AiForce(0, {AiSoldier(), 3, AiCatapult(), 1, AiScout(), 1}) end,
  function() return AiForce(1, {AiSubmarine(), 1, AiDestroyer(), 2, AiBattleship(), 1, AiScout(), 2}) end,
  function() return AiSleep(3000) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiForce(0, {AiSoldier(), 3, AiCatapult(), 1, AiScout(), 1}) end,
  function() return AiForce(3, {AiDestroyer(), 1, AiScout(), 1}) end,
  function() return AiForceRole(3, "defend") end,
  function() return AiForce(1, {AiSubmarine(), 1, AiDestroyer(), 2, AiBattleship(), 2, AiScout(), 2}) end,
  function() return AiForce(2, {AiCatapult(), 2, AiTransporter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiResearch(AiUpgradeCatapult2()) end,
  function() return AiResearch(AiUpgradeShipCannon1()) end,
  function() return AiForce(0, {AiSoldier(), 3, AiCatapult(), 1, AiScout(), 1}) end,
  function() return AiForce(3, {AiDestroyer(), 1, AiBattleship(), 1, AiScout(), 1}) end,
  function() return AiForce(1, {AiSubmarine(), 1, AiDestroyer(), 2, AiBattleship(), 3, AiScout(), 1}) end,
  function() return AiForce(2, {AiCavalry(), 1, AiCatapult(), 3, AiTransporter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiResearch(AiUpgradeShipCannon2()) end,
  function() return AiNeed(AiCityCenter()) end,
  function() return AiForce(0, {AiSoldier(), 3, AiCatapult(), 1, AiScout(), 1}) end,
  function() return AiForce(3, {AiDestroyer(), 1, AiBattleship(), 1, AiScout(), 1}) end,
  function() return AiForce(1, {AiSubmarine(), 1, AiDestroyer(), 3, AiBattleship(), 4, AiScout(), 1}) end,
  function() return AiForce(2, {AiCavalry(), 3, AiCatapult(), 3, AiTransporter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiNeed(AiHarbor()) end,
  function() return AiResearch(AiUpgradeWeapon1()) end,
  function() return AiResearch(AiUpgradeArmor1()) end,
  function() return AiResearch(AiUpgradeWeapon2()) end,
  function() return AiResearch(AiUpgradeArmor2()) end,
  function() return AiSet(AiTanker(), 5) end,
  function() return AiForce(0, {AiSoldier(), 3, AiCatapult(), 1, AiScout(), 1}) end,
  function() return AiForce(3, {AiDestroyer(), 1, AiBattleship(), 1, AiScout(), 1}) end,
  function() return AiForce(1, {AiSubmarine(), 1, AiDestroyer(), 4, AiBattleship(), 5, AiScout(), 1}) end,
  function() return AiForce(2, {AiCavalry(), 3, AiCatapult(), 3, AiTransporter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,

  function() return AiSleep(500) end,
  function() return AiForce(0, {AiSoldier(), 3, AiCatapult(), 1, AiScout(), 1}) end,
  function() return AiForce(3, {AiDestroyer(), 1, AiBattleship(), 1, AiScout(), 1}) end,
  function() return AiForce(1, {AiSubmarine(), 1, AiDestroyer(), 5, AiBattleship(), 6, AiScout(), 1}) end,
  function() return AiForce(2, {AiCavalry(), 3, AiCatapult(), 3, AiTransporter(), 1}) end,
  function() return AiWaitForce(1) end,
  function() return AiWaitForce(2) end,
  function() return AiAttackWithForce(1) end,
  function() return AiAttackWithForce(2) end,

  function() return AiSleep(500) end,
  function() return AiSeaAttackEndloop() end,
}

function AiSeaAttack()
  local ret

  player = AiPlayer() + 1

  while (true) do
    DebugPrint("Executing sea_funcs[" .. ai_sea_attack_func[player] .. "]\n")
    ret = sea_funcs[ai_sea_attack_func[player]]()
    if (ret) then
      break
    end
    ai_sea_attack_func[player] = ai_sea_attack_func[player] + 1
  end
end

DefineAi("wc2-sea-attack", "*", "wc2-sea-attack", AiSeaAttack)
