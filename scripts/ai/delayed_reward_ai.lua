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

sumEnemyScores = function(ply)
   local sum = 0
   local cntEnemies = 0
   local thisPly = Players[ply]
   for i=0,15 do
      if i ~= ply then
         if thisPly:IsEnemy(Players[i]) then
            cntEnemies = cntEnemies + 1
            sum = sum + getScore(i)
         end
      end
   end
   return math.floor(sum / cntEnemies)
end

getScore = function(i)
   -- return GetPlayerData(i, "Score") +
   return GetPlayerData(i, "TotalKills") * 2 + GetPlayerData(i, "TotalRazings") * 4 + GetPlayerData(i, "TotalUnits") + GetPlayerData(i, "TotalBuildings") -- +
      -- (GetPlayerData(i, "TotalResources", "gold") / 1000) + (GetPlayerData(i, "TotalResources", "wood") / 1000) + (GetPlayerData(i, "TotalResources", "oil") / 1000)
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
   "unit-altar-of-storms", "unit-temple-of-the-damned", "unit-dragon-roost", "unit-orc-barracks",
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

function dbg(x, y, z)
   -- print(x, y, z)
end

requestResearch = function(name)
   return AiResearch(name)
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
   dbg(ply, "attack", idx.ForceSize)
   idx.ForceSize = 0
   return AiAttackWithForce(1)
end

doSleep = function()
   local ply = AiPlayer()
   idx = stratagus.gameData.AIState.index[ply + 1]
   dbg(ply, "sleep")
   return AiSleep(50)
end

requestBuild = function(unittype, etaScale, onlyOne, isUpgrade, assignToForce)
   AiSleep(10)
   local ply = AiPlayer()
   local idx = stratagus.gameData.AIState.index[ply + 1]
   dbg(ply, unittype)

   -- local totalBuildings = GetPlayerData(ply, "TotalBuildings")
   -- if totalBuildings == 0 then
   --    -- only allow city center as the first building
   --    if unittype ~= AiCityCenter() then
   --       return false
   --    end
   -- end

   -- if idx.buildETA[unittype] ~= nil and idx.buildETA[unittype] ~= 0 then
   --    -- we only allow the AI to build one unit per type at a time
   --    return false
   -- end

   local currentUnitCount = GetPlayerData(ply, "UnitTypesCount", unittype)
   -- if onlyOne and (currentUnitCount > 0) then
   --    return false
   -- end

   -- local goldCost = GetUnitTypeData(unittype, "Costs", "gold")
   -- local goldAvail = GetPlayerData(ply, "Resources", "gold")
   -- if goldAvail < goldCost then
   --    return false
   -- end

   -- local woodCost = GetUnitTypeData(unittype, "Costs", "wood")
   -- local woodAvail = GetPlayerData(ply, "Resources", "wood")
   -- if woodAvail < woodCost then
   --    return false
   -- end

   -- local oilCost = GetUnitTypeData(unittype, "Costs", "oil")
   -- local oilAvail = GetPlayerData(ply, "Resources", "oil")
   -- if oilAvail < oilCost then
   --    return false
   -- end

   -- the micro-AI in C handles supply and demand automatically, but we want to
   -- give the external agent more control
   -- local demand = GetUnitTypeData(unittype, "Demand")
   -- local supply = GetPlayerData(ply, "Supply")
   -- if supply < demand then
   --    return false
   -- end

   -- if not CheckDependency(ply, unittype) then
   --    return false
   -- end

   -- we do not allow queueing for the AI. A production unit must be available
   -- immediately, otherwise our probability for spawning is off
   -- local producers = unitToBuilderMap[unittype]
   -- if producers == nil then
   --    return false
   -- end
   -- local availableSlots = 0
   -- for _,producer in ipairs(producers) do
   --    availableSlots = availableSlots + GetPlayerData(ply, "UnitTypesCount", producer)
   --    for i,v in ipairs(builderToUnitsMap[producer]) do
   --       if idx.buildETA[v] and idx.buildETA[v] > 0 then
   --          availableSlots = availableSlots - 1
   --       end
   --    end
   -- end
   -- if availableSlots <= 0 then
   --    return false
   -- end

   -- for buildings we will get a scale, to account for workers to walk to the
   -- build location. This means the probability for buildings is less reliable,
   -- but that's ok
   -- local timeCost = GetUnitTypeData(unittype, "Costs", "time")
   -- if etaScale == nil then
   --    etaScale = 1
   -- end
   -- idx.buildETA[unittype] = GameCycle + (etaScale * 6 * timeCost)
   if isUpgrade then
      return AiUpgradeTo(unittype)
   elseif assignToForce then
      -- idx.ForceSize = idx.ForceSize + goldCost + woodCost + oilCost
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

local getResourceValue = function(ply, resource)
   local amt = GetPlayerData(ply, "Resources", resource)
   if amt == 0 then
      return 0
   elseif amt <= 1000 then
      return math.floor(amt / 100) -- 0..10
   elseif amt <= 3100 then
      return 10 + math.floor((amt - 1000) / 300) -- 10..17
   elseif amt <= 4000 then
      return 18
   elseif amt <= 5000 then
      return 19
   else
      return 20
   end
end

local boxUnitCountValues = function(cnt)
   if cnt <= 10 then
      return cnt -- 0..10
   elseif cnt <= 34 then
      return 10 + math.floor((cnt - 10) / 4) -- 10..16
   else
      return 17
   end
end

local stateVariables = {
   -- return three states for game cycle: late game (2), mid game (1), early game (0)
   function(ply) if GameCycle > 60000 then return 2 elseif GameCycle > 20000 then return 1 else return 0 end end,

   function(ply) return getResourceValue(ply, "gold") end,
   function(ply) return getResourceValue(ply, "wood") end,
   function(ply) return getResourceValue(ply, "oil") end,

   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiWorker())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiSoldier())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiShooter())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiCavalry())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiMage())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiCatapult())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiFlyer())) end,

   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiGuardTower())) end,
   function(ply) return boxUnitCountValues(GetPlayerData(ply, "UnitTypesCount", AiCannonTower())) end,

   -- function(ply) return GetPlayerData(ply, "UnitTypesCount", AiFarm()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiCityCenter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBetterCityCenter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBestCityCenter()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiMageTower()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiAirport()) end,
   function(ply) return GetPlayerData(ply, "UnitTypesCount", AiBarracks()) end,

   -- these buildings are only needed once, so we only return 0 or 1
   function(ply) return math.min(GetPlayerData(ply, "UnitTypesCount", AiLumberMill()), 1) end,
   function(ply) return math.min(GetPlayerData(ply, "UnitTypesCount", AiBlacksmith()), 1) end,
   function(ply) return math.min(GetPlayerData(ply, "UnitTypesCount", AiScientific()), 1) end,
   function(ply) return math.min(GetPlayerData(ply, "UnitTypesCount", AiStables()), 1) end,
   function(ply) return math.min(GetPlayerData(ply, "UnitTypesCount", AiTemple()), 1) end,

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
   function(ply) return boxUnitCountValues(countEnemyUnits(ply, AiSoldier)) end,
   function(ply) return boxUnitCountValues(countEnemyUnits(ply, AiShooter)) end,
   function(ply) return boxUnitCountValues(countEnemyUnits(ply, AiCavalry)) end,
   function(ply) return boxUnitCountValues(countEnemyUnits(ply, AiMage)) end,
   function(ply) return boxUnitCountValues(countEnemyUnits(ply, AiCatapult)) end,
   function(ply) return boxUnitCountValues(countEnemyUnits(ply, AiFlyer)) end,
   -- function(ply) return countEnemyUnits(ply, AiSubmarine) end,
   -- function(ply) return countEnemyUnits(ply, AiDestroyer) end,
   -- function(ply) return countEnemyUnits(ply, AiBattleship) end,
}

-- last actions are part of the state. because actions have delayed effects,
-- making them part of the state should allow the agent to learn that
-- eventually actions will have an outcome

Queue = {}
Queue.__index = Queue
function Queue:new(cap)
   local qu = {}
   setmetatable(qu, Queue)
   qu.head = 1
   qu.cap = cap
   qu.size = 0
   qu.data = {}
   return qu
end

function Queue:push(el)
   local head = self.head
   local size = self.size
   local cap = self.cap
   local newIndex = (self.head - 1 + size) % cap + 1
   if size == cap then
      self:pop() -- remove front item if we're now larger than cap
   end
   self.size = self.size + 1
   self.data[newIndex] = el
end

function Queue:peek(idx)
   if idx == nil then
      idx = self.head
   else
      idx = idx - 1 + self.head
   end
   return self.data[((idx - 1) % self.cap) + 1]
end

function Queue:pop()
   local head = self.head
   local size = self.size
   local cap = self.cap
   local el = self.data[head]
   self.data[head] = nil

   self.size = size - 1
   if size == 0 then
      head = 1 -- reset to front when we're emtpy
   elseif head == self.cap then
      self.head = 1
   else
      self.head = head + 1
   end
   return el
end

local makeAiHistoryFunc = function(i)
   return function(ply)
      local idx = stratagus.gameData.AIState.index[ply + 1]
      local act = idx.actionHistory:peek(i)
      if act == nil then
         return 0
      else
         return act
      end
   end
end
local AiActionHistorySize = 40
for i=1,AiActionHistorySize,1 do
   stateVariables[#stateVariables + 1] = makeAiHistoryFunc(i)
end

-- each "action" the processor asks for is actually an AI loop to do for a while
local actions = {
   -- sleep should be action 0, for nothing
   { function() return doSleep() end },

   -- { function() return requestBuilding(AiFarm()) end },
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

   { function() return requestResearch(AiUpgradeArmor1()) end },
   { function() return requestResearch(AiUpgradeArmor2()) end },
   { function() return requestResearch(AiUpgradeWeapon1()) end },
   { function() return requestResearch(AiUpgradeWeapon2()) end },
   { function() return requestResearch(AiUpgradeMissile1()) end },
   { function() return requestResearch(AiUpgradeMissile2()) end },
   { function() return requestResearch(AiUpgradeCatapult1()) end },
   { function() return requestResearch(AiUpgradeCatapult2()) end },
   { function() return requestResearch(AiUpgradeEliteShooter()) end },
   { function() return requestResearch(AiUpgradeEliteShooter1()) end },
   { function() return requestResearch(AiUpgradeEliteShooter2()) end },
   { function() return requestResearch(AiUpgradeEliteShooter3()) end },

   { function() return doAttack(1) end },
}

local prepareStepArgs = function(playerIndex)
   idx = stratagus.gameData.AIState.index[playerIndex]

   local env = {}
   for i=1,#stateVariables do
      table.insert(env, stateVariables[i](playerIndex - 1))
   end

   return 0, env
end

local MakeAi = function(port)
   return function()
      local playerIndex = AiPlayer() + 1

      local idx = stratagus.gameData.AIState.index[playerIndex] -- currently active state

      if type(idx) == "number" then
         -- starting the game, establishing connection to agent
         -- TODO: make configurable
         socket = AiProcessorSetup("127.0.0.1", port, #stateVariables, #actions)
         idx = {
            Socket = socket,
            LastReward = 0,
            ActionIndex = 0,
            LoopIndex = 0,
            LastKillings = 0,
            ForceSize = 0, -- current number of requested units in force
            attack = 0, -- current value of underway attack forces
            punishment = 0,
            buildETA = {}, -- current ETAs for build/train requests
            actionHistory = Queue:new(AiActionHistorySize),
         }
         stratagus.gameData.AIState.index[playerIndex] = idx

         -- make sure we report end of game before quitting
         local makeWrapper = function(cb)
            return function()
               next_reward, env = prepareStepArgs(playerIndex)
               if GetNumOpponents(playerIndex - 1) == 0 then -- win
                  print("WIN")
                  next_reward = next_reward + 1000
               elseif GetPlayerData(playerIndex - 1, "TotalNumUnits") == 0 then -- loss
                  -- we punish the AI less if it put up a good fight -- -1000..-500
                  improvement = math.min(GetPlayerData(playerIndex - 1, "TotalKills") + GetPlayerData(playerIndex - 1, "TotalRazings") * 2, 500)
                  next_reward = next_reward - 1000 + improvement
               else -- draw, reward a little bit for kills and razings -- 0..50
                  next_reward = next_reward + math.min(GetPlayerData(playerIndex - 1, "TotalKills") + GetPlayerData(playerIndex - 1, "TotalRazings") * 2, 50)
               end
               AiProcessorEnd(idx.Socket, next_reward, env)
               return cb()
            end
         end
         local originalActionVictory = ActionVictory
         ActionVictory = makeWrapper(function()
               ActionVictory = originalActionVictory
               return originalActionVictory()
         end)
         local originalActionDefeat = ActionDefeat
         ActionDefeat = makeWrapper(function()
               ActionDefeat = originalActionDefeat
               return originalActionDefeat()
         end)
      elseif idx.ActionIndex == 0 then
         -- ask agent what to do next
         next_reward, env = prepareStepArgs(playerIndex)
         dbg("Reward", next_reward)
         idx.ActionIndex = AiProcessorStep(idx.Socket, next_reward, env)
         idx.actionHistory:push(idx.ActionIndex)
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
   end
end

DefineAi("delayed-reward-ai-9292", "*", "delayed-reward-ai-9292", MakeAi(9292))
DefineAi("delayed-reward-ai-9293", "*", "delayed-reward-ai-9293", MakeAi(9293))
DefineAi("delayed-reward-ai-9294", "*", "delayed-reward-ai-9294", MakeAi(9294))
