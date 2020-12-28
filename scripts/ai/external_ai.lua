-- This implements an external AI agent. The implementation requests a
-- connection to an agent that can handle AI requests. On initialization, the
-- agent is informed of the size of the environment (i.e., the number of game
-- state variables it will receive) and the number of actions available to
-- it. The agent has no further information, so if the actions associated with a
-- number change, any trained models are invalid. On each step, the agent is
-- sent the reward for the last step and the current environment. It responds
-- with the next action to take.
--
-- The wire protocol is extremely simple:
--
-- C2S: InumOfStateVars numOfActions
--
-- C2S: Rreward
--
-- C2S: Svar1 var2 var3 ... varN
--
-- S2C: num
--
-- C2S: E0 / E1 / E2 (defeated, draw, victory)

local countEnemyUnits = function(ply, unitGetter)
   local cnt = 0
   local thisPly = Players[ply]
   for i=0,15 do
      if i ~= ply then
         if thisPly:IsEnemy(Players[i]) then
            cnt = cnt + GetPlayerData(i, "UnitTypesCount", unitGetter(GetPlayerData(i, "RaceName")))
         end
      end
   end
   return cnt
end

local stateVariables = {
   function(ply) return GameCycle end,

   -- function(ply) return AreEnemyUnitsNearBuildings() end,

   function(ply) return GetPlayerData(ply, "Resources", "gold") end,
   function(ply) return GetPlayerData(ply, "Resources", "wood") end,
   function(ply) return GetPlayerData(ply, "Resources", "oil") end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiWorker()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiSoldier()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiShooter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiCavalry()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiMage()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiCatapult()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiFlyer()) end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiGuardTower()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiCannonTower()) end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiCityCenter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBetterCityCenter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBestCityCenter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiLumberMill()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBlacksmith()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiScientific()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiStables()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiTemple()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiMageTower()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiAirport()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBarracks()) end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiHarbor()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiRefinery()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiFoundry()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiPlatform()) end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiTanker()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiSubmarine()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiDestroyer()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBattleship()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiTransporter()) end,

   -- for enemies, count only battle units
   function(ply) return countEnemyUnits(ply, AiSoldier) end,
   function(ply) return countEnemyUnits(ply, AiShooter) end,
   function(ply) return countEnemyUnits(ply, AiCavalry) end,
   function(ply) return countEnemyUnits(ply, AiMage) end,
   function(ply) return countEnemyUnits(ply, AiCatapult) end,
   function(ply) return countEnemyUnits(ply, AiFlyer) end,
   function(ply) return countEnemyUnits(ply, AiSubmarine) end,
   function(ply) return countEnemyUnits(ply, AiDestroyer) end,
   function(ply) return countEnemyUnits(ply, AiBattleship) end,
}

-- each "action" the processor asks for is actually an AI loop to do for a while
local actions = {
   {  -- get a worker
      function() return AiNeed(AiCityCenter()) end,
      function() return AiSet(AiWorker(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiWorker()) + 1) end,
      function() return AiWait(AiCityCenter()) end,
      function() return AiWait(AiWorker()) end,
   },
   {  -- get another barracks
      function() return AiSet(AiBarracks(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiBarracks()) + 1) end,
   },
   -- more buildings
   {  -- get a soldier
      function() return AiNeed(AiBarracks()) end,
      function() return AiForce(1, {AiSoldier(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + 1}) end,
   },
   {  -- get an archer
      function() return AiNeed(AiBarracks()) end,
      function() return AiNeed(AiLumberMill()) end,
      function() return AiForce(1, {AiShooter(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + 1}) end,
   },
   {  -- get a knight
      function() return AiNeed(AiBarracks()) end,
      function() return AiNeed(AiLumberMill()) end,
      function() return AiNeed(AiBlacksmith()) end,
      function() return AiUpgradeTo(AiBetterCityCenter()) end,
      function() return AiNeed(AiStables()) end,
      function() return AiForce(1, {AiCavalry(), GetPlayerData(AiPlayer(), "UnitTypesCount", AiSoldier()) + 1}) end,
   },
   -- more units
   -- {  -- so some research
   --    function() return AiNeed(AiBlacksmith()) end,
   --    function() return AiWait(AiBlacksmith()) end,
   --    function() return AiResearch(AiUpgradeWeapon1()) end,
   --    function() return AiResearch(AiUpgradeArmor1()) end,
   -- },
   -- more research?
   { -- wait a bit
      function() return AiWaitForce(1) end,
   },
   { -- attack
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,
   },
}

local prepareStepArgs = function(playerIndex)
   idx = stratagus.gameData.AIState.index[playerIndex]

   -- score is the wc2 score and the diff in unit count => building and killing units good, loosing units bad
   local score = GetPlayerData(playerIndex - 1, "Score")
   local curUnitCount = GetPlayerData(playerIndex - 1, "TotalNumUnits")
   local unitDiff = curUnitCount - idx.LastUnitCount
   idx.LastUnitCount = curUnitCount
   score = score + (unitDiff * 10)

   local next_reward = score - idx.LastReward
   idx.LastReward = score

   local env = {}
   for i=1,#stateVariables do
      table.insert(env, stateVariables[i](playerIndex - 1))
   end

   return next_reward, env
end

DefineAi("external-ai", "*", "external-ai", function()
            local playerIndex = AiPlayer() + 1

            local idx = stratagus.gameData.AIState.index[playerIndex] -- currently active state

            if type(idx) == "number" then
               -- starting the game, establishing connection to agent
               -- TODO: make configurable
               socket = AiProcessorSetup("127.0.0.1", 9293, #stateVariables, #actions)
               idx = {
                  Socket = socket,
                  LastReward = 0,
                  ActionIndex = 0,
                  LoopIndex = 0,
                  LastUnitCount = 0,
               }
               stratagus.gameData.AIState.index[playerIndex] = idx

               -- make sure we report end of game before quitting
               local originalActionVictory = ActionVictory
               local wrapper = function()
                  ActionVictory = originalActionVictory
                  next_reward, env = prepareStepArgs(playerIndex)
                  if GetPlayerData(playerIndex - 1, "TotalNumUnits") == 0 then
                     -- reward for living longer
                     next_reward = (next_reward - 1000) + (GameCycle / 1000)
                  else
                     next_reward = next_reward + 5000
                  end
                  AiProcessorEnd(idx.Socket, next_reward, env)
                  return originalActionVictory()
               end
               ActionVictory = wrapper

               local originalActionDefeat = ActionDefeat
               local wrapper = function()
                  ActionDefeat = originalActionDefeat
                  next_reward, env = prepareStepArgs(playerIndex)
                  if GetPlayerData(playerIndex - 1, "TotalNumUnits") == 0 then
                     -- reward for living longer
                     next_reward = (next_reward - 1000) + (GameCycle / 1000)
                  else
                     next_reward = next_reward + 5000
                  end
                  AiProcessorEnd(idx.Socket, next_reward, env)
                  return originalActionDefeat()
               end
               ActionDefeat = wrapper

            elseif idx.ActionIndex == 0 then
               -- ask agent what to do next
               next_reward, env = prepareStepArgs(playerIndex)
               idx.ActionIndex = AiProcessorStep(idx.Socket, next_reward, env) + 1
               idx.LoopIndex = 1

            else
               -- work on action that the agent requested
               local actionLoop = actions[idx.ActionIndex]
               local loopIdx = idx.LoopIndex
               while not actionLoop[loopIdx]() do
                  loopIdx = loopIdx + 1
                  if loopIdx > #actionLoop then
                     break
                  end
               end
               if loopIdx > #actionLoop then
                  -- done with this action, ask the agent for the next one
                  idx.ActionIndex = 0
               else
                  idx.LoopIndex = loopIdx
               end
            end

            return true
end)
