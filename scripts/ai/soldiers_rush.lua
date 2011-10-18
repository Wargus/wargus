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
--      soldiers_rush.lua - Define the soldiers rush AI.
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
--      $Id: soldiers_rush.lua,v 1.2 2004/01/14 22:06:18 mponsen Exp $

ai_soldiers_rush_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
ai_soldiers_rush_end_loop_func = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

local player

local end_loop_funcs = {
  function() return AiForce(1, {AiSoldier(), 5}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,
  function() return AiSleep(500) end,
  function() ai_soldiers_rush_end_loop_func[player] = 0; return false end,
}

function AiSoldiersRushEndloop()
  local ret

  while (true) do
    ret = end_loop_funcs[ai_soldiers_rush_end_loop_func[player]]()
    if (ret) then
      break
    end
    ai_soldiers_rush_end_loop_func[player] = ai_soldiers_rush_end_loop_func[player] + 1
  end
  return true
end

local soldiers_funcs = {
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
  function() return AiNeed(AiBarracks()) end,	
  function() return AiResearch(AiUpgradeWeapon1()) end,
  function() return AiResearch(AiUpgradeArmor1()) end,
  function() return AiResearch(AiUpgradeWeapon2()) end,
  function() return AiResearch(AiUpgradeArmor2()) end,
  function() return AiSleep(500) end,
  function() return AiForce(0, {AiSoldier(), 4}) end,
  function() return AiForce(1, {AiSoldier(), 10}) end,
  function() return AiWaitForce(1) end,
  function() return AiAttackWithForce(1) end,
  function() return AiSoldiersRushEndloop() end,
}

function AiSoldiersRush()
  local ret

  player = AiPlayer() + 1

  while (true) do
    ret = soldiers_funcs[ai_soldiers_rush_func[player]]()
    if (ret) then
      break
    end
    ai_soldiers_rush_func[player] = ai_soldiers_rush_func[player] + 1
  end
end

DefineAi("wc2-soldiers-rush", "*", "soldiers-rush", AiSoldiersRush)