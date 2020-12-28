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
            if unitGetter then
               cnt = cnt + GetPlayerData(i, "UnitTypesCount", unitGetter(GetPlayerData(i, "RaceName")))
            else
               cnt = cnt + GetPlayerData(i, "TotalNumUnits")
            end
         end
      end
   end
   return cnt
end

local sumEnemyScores = function(ply)
   local sum = 0
   local thisPly = Players[ply]
   for i=0,15 do
      if i ~= ply then
         if thisPly:IsEnemy(Players[i]) then
            sum = sum + getScore(i)
         end
      end
   end
   return cnt
end

local getScore = function(ply)
   -- return GetPlayerData(i, "Score") +
   return GetPlayerData(i, "TotalKills") + GetPlayerData(i, "TotalRazings") + GetPlayerData(i, "TotalUnits") + GetPlayerData(i, "TotalBuildings") + (GetPlayerData(i, "TotalResources") / 10000)
end

local builderToUnitsMap = {}
builderToUnitsMap["unit-human-barracks"] = {"unit-footman", "unit-archer", "unit-knight", "unit-ballista"}
builderToUnitsMap["unit-gryphon-aviary"] = {"unit-gryphon-rider"}
builderToUnitsMap["unit-mage-tower"] = {"unit-mage"}
builderToUnitsMap["unit-orc-barracks"] = {"unit-grunt", "unit-axethrower", "unit-ogre", "unit-catapult"}
builderToUnitsMap["unit-dragon-roost"] = {"unit-dragon"}
builderToUnitsMap["unit-temple-of-the-damned"] = {"unit-death-knight"}
builderToUnitsMap["unit-peasant"] = {
   "unit-town-hall", "unit-elven-lumber-mill", "unit-human-blacksmith", "unit-inventor", "unit-stables",
   "unit-church", "unit-mage-tower", "unit-gryphon-aviary", "unit-human-barracks", "unit-human-watch-tower",
   "unit-human-shipyard", "unit-human-refinery", "unit-human-foundry", "unit-farm"
}
builderToUnitsMap["unit-peon"] = {
   "unit-great-hall", "unit-troll-lumber-mill", "unit-orc-blacksmith", "unit-alchemist", "unit-ogre-mound",
   "unit-altar-of-storms", "unit-temple-of-the-damned-tower", "unit-dragon-roost", "unit-orc-barracks",
   "unit-orc-watch-tower", "unit-orc-shipyard", "unit-orc-refinery", "unit-orc-foundry", "unit-pig-farm"
}
builderToUnitsMap["unit-town-hall"] = {"unit-peasant", "unit-keep"}
builderToUnitsMap["unit-keep"] = {"unit-peasant", "unit-castle"}
builderToUnitsMap["unit-castle"] = {"unit-peasant"}
builderToUnitsMap["unit-great-hall"] = {"unit-peon", "unit-stronghold"}
builderToUnitsMap["unit-stronghold"] = {"unit-peon", "unit-fortress"}
builderToUnitsMap["unit-fortress"] = {"unit-peon"}
builderToUnitsMap["unit-human-watch-tower"] = {"unit-human-guard-tower", "unit-human-cannon-tower"}
builderToUnitsMap["unit-orc-watch-tower"] = {"unit-orc-guard-tower", "unit-orc-cannon-tower"}
builderToUnitsMap["unit-human-shipyard"] = {
   "unit-human-submarine", "unit-human-transport", "unit-human-destroyer", "unit-battleship"
}
builderToUnitsMap["unit-orc-shipyard"] = {
   "unit-orc-submarine", "unit-orc-transport", "unit-orc-destroyer", "unit-ogre-juggernaught"
}
local unitToBuilderMap = {}
for _builder,_units in pairs(builderToUnitsMap) do
   for _,_unit in ipairs(_units) do
      if unitToBuilderMap[_unit] == nil then
         unitToBuilderMap[_unit] = {}
      end
      table.insert(unitToBuilderMap[_unit], _builder)
   end
end

requestResearch = function(name)
   -- TODO
end

requestBuilding = function(unittype, onlyOne, isUpgrade)
   return requestBuild(unittype, 3, onlyOne, isUpgrade)
end

requestUnit = function(unittype, force)
   if force then
      return requestBuild(unittype, 2, false, false, force)
   else
      return requestBuild(unittype, 2, false, false, false)
   end
end

doAttack = function(force)
   local ply = AiPlayer()
   idx = stratagus.gameData.AIState.index[ply + 1]
   idx.attack = idx.attack + idx.ForceSize + GameCycle
   idx.ForceSize = 0
   return AiAttackWithForce(1)
end

requestBuild = function(unittype, etaScale, onlyOne, isUpgrade, assignToForce)
   local ply = AiPlayer()

   local idx = stratagus.gameData.AIState.index[ply + 1]
   if idx.buildETA[unittype] ~= nil and idx.buildETA[unittype] ~= 0 then
      -- we only allow the AI to build one unit per type at a time
      return false
   end

   local currentUnitCount = GetPlayerData(ply, "UnitTypesCount", unittype)
   if onlyOne and (currentUnitCount > 0) then
      return false
   end

   local goldCost = GetUnitTypeData(unittype, "Costs", "gold")
   local goldAvail = GetPlayerData(ply, "Resources", "gold")
   if goldAvail < goldCost then
      return false
   end

   local woodCost = GetUnitTypeData(unittype, "Costs", "wood")
   local woodAvail = GetPlayerData(ply, "Resources", "wood")
   if woodAvail < woodCost then
      return false
   end

   local oilCost = GetUnitTypeData(unittype, "Costs", "oil")
   local oilAvail = GetPlayerData(ply, "Resources", "oil")
   if oilAvail < oilCost then
      return false
   end

   -- the micro-AI in C handles supply and demand automatically, but we want to
   -- give the external agent more control
   local demand = GetUnitTypeData(unittype, "Demand")
   local supply = GetPlayerData(ply, "Supply")
   if supply < demand then
      return false
   end

   if not CheckDependency(ply, unittype) then
      return false
   end

   -- we do not allow queueing for the AI. A production unit must be available
   -- immediately, otherwise our probability for spawning is off
   local producers = unitToBuilderMap[unittype]
   local availableSlots = 0
   for _,producer in ipairs(producers) do
      availableSlots = availableSlots + GetPlayerData(ply, "UnitTypesCount", producer)
      for i,v in ipairs(builderToUnitsMap[producer]) do
         if idx.buildETA[v] and idx.buildETA[v] > 0 then
            availableSlots = availableSlots - 1
         end
      end
   end
   if availableSlots <= 0 then
      return false
   end

   -- always request a bit of sleep, so that the build can get queued
   AiSleep(10)

   -- for buildings we will get a scale, to account for workers to walk to the
   -- build location. This means the probability for buildings is less reliable,
   -- but that's ok
   local timeCost = GetUnitTypeData(unittype, "Costs", "time")
   if etaScale == nil then
      etaScale = 1
   end
   idx.buildETA[unittype] = GameCycle + (etaScale * 6 * timeCost)
   if isUpgrade then
      return AiUpgradeTo(unittype)
   elseif assignToForce then
      idx.ForceSize = idx.ForceSize + goldCost + woodCost + oilCost
      return AiForce(assignToForce, {unittype, currentUnitCount + 1})
   else
      return AiSet(unittype, currentUnitCount + 1)
   end
end

local getSpawnProbability = function(ply, unittype)
   idx = stratagus.gameData.AIState.index[ply + 1]
   if idx.buildETA[unittype] == nil or idx.buildETA[unittype] == 0 then
      return 0
   end

   local pending = AiGetPendingBuilds(unittype)
   if pending == 0 then
      -- no builds pending, reset the probability, the unit either spawned or the build cancelled
      idx.buildETA[unittype] = 0
      return 0
   end

   local cyclesLeft = idx.buildETA[unittype] - GameCycle
   if cyclesLeft > 0 then
      return 10000 / cyclesLeft
   else
      -- no cycles left, no more chance of spawning the unit
      idx.buildETA[unittype] = 0
      return 0
   end
end

local getRazingsProbability = function(ply)
   idx = stratagus.gameData.AIState.index[ply + 1]
   if idx.attack == 0 then
      return 0
   end

   local cyclesLeft = idx.attack - GameCycle
   if cyclesLeft > 0 then
      return 1000 / cyclesLeft
   else
      idx.attack = 0
      return 0
   end
end

local stateVariables = {
   function(ply) return getRazingsProbability(ply) end,

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
   function(ply) return getSpawnProbability(ply, AiWorker()) end,
   function(ply) return getSpawnProbability(ply, AiSoldier()) end,
   function(ply) return getSpawnProbability(ply, AiShooter()) end,
   function(ply) return getSpawnProbability(ply, AiCavalry()) end,
   function(ply) return getSpawnProbability(ply, AiMage()) end,
   function(ply) return getSpawnProbability(ply, AiCatapult()) end,
   function(ply) return getSpawnProbability(ply, AiFlyer()) end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiGuardTower()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiCannonTower()) end,
   function(ply) return getSpawnProbability(ply, AiGuardTower()) end,
   function(ply) return getSpawnProbability(ply, AiCannonTower()) end,

   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiFarm()) end,
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
   function(ply) return getSpawnProbability(ply, AiFarm()) end,
   function(ply) return getSpawnProbability(ply, AiCityCenter()) end,
   function(ply) return getSpawnProbability(ply, AiBetterCityCenter()) end,
   function(ply) return getSpawnProbability(ply, AiBestCityCenter()) end,
   function(ply) return getSpawnProbability(ply, AiLumberMill()) end,
   function(ply) return getSpawnProbability(ply, AiBlacksmith()) end,
   function(ply) return getSpawnProbability(ply, AiScientific()) end,
   function(ply) return getSpawnProbability(ply, AiStables()) end,
   function(ply) return getSpawnProbability(ply, AiTemple()) end,
   function(ply) return getSpawnProbability(ply, AiMageTower()) end,
   function(ply) return getSpawnProbability(ply, AiAirport()) end,
   function(ply) return getSpawnProbability(ply, AiBarracks()) end,

   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiHarbor()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiRefinery()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiFoundry()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiPlatform()) end,
   -- function(ply) return getSpawnProbability(ply, AiHarbor()) end,
   -- function(ply) return getSpawnProbability(ply, AiRefinery()) end,
   -- function(ply) return getSpawnProbability(ply, AiFoundry()) end,
   -- function(ply) return getSpawnProbability(ply, AiPlatform()) end,

   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiTanker()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiSubmarine()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiDestroyer()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBattleship()) end,
   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiTransporter()) end,
   -- function(ply) return getSpawnProbability(ply, AiTanker()) end,
   -- function(ply) return getSpawnProbability(ply, AiSubmarine()) end,
   -- function(ply) return getSpawnProbability(ply, AiDestroyer()) end,
   -- function(ply) return getSpawnProbability(ply, AiBattleship()) end,
   -- function(ply) return getSpawnProbability(ply, AiTransporter()) end,

   -- for enemies, count only battle units
   function(ply) return countEnemyUnits(ply, AiSoldier) end,
   function(ply) return countEnemyUnits(ply, AiShooter) end,
   function(ply) return countEnemyUnits(ply, AiCavalry) end,
   function(ply) return countEnemyUnits(ply, AiMage) end,
   function(ply) return countEnemyUnits(ply, AiCatapult) end,
   function(ply) return countEnemyUnits(ply, AiFlyer) end,
   -- function(ply) return countEnemyUnits(ply, AiSubmarine) end,
   -- function(ply) return countEnemyUnits(ply, AiDestroyer) end,
   -- function(ply) return countEnemyUnits(ply, AiBattleship) end,
}

-- each "action" the processor asks for is actually an AI loop to do for a while
local actions = {
   { function() return requestBuilding(AiFarm()) end },
   { function() return requestBuilding(AiCityCenter(), true) end },
   { function() return requestBuilding(AiBarracks()) end },
   { function() return requestBuilding(AiLumberMill(), true) end },
   { function() return requestBuilding(AiBlacksmith(), true) end },
   { function() return requestBuilding(AiBetterCityCenter(), true, true) end },
   { function() return requestBuilding(AiBestCityCenter(), true, true) end },
   { function() return requestBuilding(AiStables(), true) end },
   { function() return requestBuilding(AiMageTower(), true) end },
   { function() return requestBuilding(AiAirport(), true) end },
   { function() return requestBuilding(AiTemple(), true) end },

   { function() return requestBuilding(AiTower()) end },
   { function() return requestBuilding(AiGuardTower(), false, true) end },
   { function() return requestBuilding(AiCannonTower(), false, true) end },

   { function() return requestUnit(AiWorker()) end },
   { function() return requestUnit(AiSoldier(), 1) end },
   { function() return requestUnit(AiShooter(), 1) end },
   { function() return requestUnit(AiCavalry(), 1) end },
   { function() return requestUnit(AiCatapult(), 1) end },
   { function() return requestUnit(AiFlyer(), 1) end },
   { function() return requestUnit(AiMage(), 1) end },

   -- { function() return requestResearch(AiUpgradeArmor1()) end },
   -- { function() return requestResearch(AiUpgradeArmor2()) end },
   -- { function() return requestResearch(AiUpgradeWeapon1()) end },
   -- { function() return requestResearch(AiUpgradeWeapon2()) end },
   -- { function() return requestResearch(AiUpgradeMissile1()) end },
   -- { function() return requestResearch(AiUpgradeMissile2()) end },
   -- { function() return requestResearch(AiUpgradeCatapult1()) end },
   -- { function() return requestResearch(AiUpgradeCatapult2()) end },
   -- { function() return requestResearch(AiUpgradeEliteShooter()) end },
   -- { function() return requestResearch(AiUpgradeEliteShooter1()) end },
   -- { function() return requestResearch(AiUpgradeEliteShooter2()) end },
   -- { function() return requestResearch(AiUpgradeEliteShooter3()) end },

   { function() return AiSleep(100) end },
   { function() return doAttack(1) end },
}

local prepareStepArgs = function(playerIndex)
   idx = stratagus.gameData.AIState.index[playerIndex]

   local score = getScore(playerIndex - 1) - sumEnemyScores(playerIndex - 1)
   local next_reward = score - idx.LastReward
   idx.LastReward = score

   local env = {}
   for i=1,#stateVariables do
      table.insert(env, stateVariables[i](playerIndex - 1))
   end

   return next_reward, env
end

DefineAi("delayed-reward-ai", "*", "delayed-reward-ai", function()
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
                  LastKillings = 0,
                  ForceSize = 0, -- current number of requested units in force
                  attack = 0, -- current value of underway attack forces
                  buildETA = {} -- current ETAs for build/train requests
               }
               stratagus.gameData.AIState.index[playerIndex] = idx

               -- make sure we report end of game before quitting
               local originalActionVictory = ActionVictory
               local wrapper = function()
                  ActionVictory = originalActionVictory
                  next_reward, env = prepareStepArgs(playerIndex)
                  if GetPlayerData(playerIndex - 1, "TotalNumUnits") > 0 and countEnemyUnits(playerIndex) then
                     next_reward = next_reward + 100 -- lots bonus for winning
                  else
                     next_reward = next_reward - next_reward * 100 -- lots punishment for not winning
                  end
                  AiProcessorEnd(idx.Socket, next_reward, env)
                  return originalActionVictory()
               end
               ActionVictory = wrapper

               local originalActionDefeat = ActionDefeat
               local wrapper = function()
                  ActionDefeat = originalActionDefeat
                  next_reward, env = prepareStepArgs(playerIndex)
                  if GetPlayerData(playerIndex - 1, "TotalNumUnits") > 0 then
                     next_reward = next_reward + 8000
                  else
                     next_reward = next_reward + (GameCycle / 1000)
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
