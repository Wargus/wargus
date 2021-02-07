local ARGS=...

Load("scripts/stratagus.lua")
SetTitleScreens({})
CustomStartup = function() end

local function usage()
  print("Single player startup file for Wargus. Options are passed as comma-separated pairs")
  print("\t[map=[map.smp]]")
  print("\t[reveal] -- reveal the map")
  print("\t[repeat=cnt] -- repeat the game cnt times")
  print("\t[type=[0,1,2]] -- default, machine vs machine, machine vs machine training")
  print("\t[aiplayers=[number of ai players]]")
  print("\t[aiscripts=[colon-separated list of aiscripts, assigned to AIs in order]]")
  print("\nAll options must be passed comma-separated. An example:")
  print("\twargus -c singleplaer -G map=islands.smp.gz,aiplayers=2")
end

if (ARGS == "help") then
  usage()
else
  local mapfile = string.match(ARGS,"map=([^,]+)")
  local aiPlayerNum = tonumber(string.match(ARGS,"aiplayers=([^,]+)"))
  local gameType = tonumber(string.match(ARGS,"type=([^,]+)"))
  local aiscripts = string.match(ARGS,"aiscripts=([^,]+)")
  local rept = tonumber(string.match(ARGS,"repeat=([^,]+)"))
  local doReveal = string.match(ARGS,"(reveal)")

  local aiscriptNames = {}
  if aiscripts ~= nil then
     for scriptname in string.gmatch(aiscripts, "([^:]+)") do
        table.insert(aiscriptNames, scriptname)
     end
  end

  if (aiPlayerNum == nil) then
     aiPlayerNum = 1
  else
     aiPlayerNum = aiPlayerNum - 1
  end

  if gameType == 1 then
     gameType = SettingsGameTypeMachineVsMachine
  elseif gameType == 2 then
     gameType = SettingsGameTypeMachineVsMachineTraining
  else
     gameType = SettingsGameTypeMapDefault
  end

  CustomStartup = function()
     InitGameSettings()
     GameSettings.GameType = gameType
     local playerUnitCounts = {}
     if gameType ~= SettingsGameTypeMapDefault then
        -- this is one of the machine vs machine games, so let the AI fight it out
        doReveal = true
        SinglePlayerTriggers = function()
           AddTrigger(
              function()
                 local stuckPlayers = true
                 for id=0,14 do
                    if GetPlayerData(id, "TotalBuildings") > 0 and GetNumOpponents(id) == 0 then
                       print("Player " .. id + 1 .. " is stuck with no opponents")
                       -- no opponents means we don't have anything else to do, we're stuck
                    elseif (GameCycle >= 60000) and (GameCycle % 20000 == 0) then
                       local cnts = playerUnitCounts[id +  1]
                       local newTotals = GetPlayerData(id, "TotalUnits") + GetPlayerData(id, "TotalBuildings")
                       local newCurrent = GetPlayerData(id, "TotalNumUnits") + GetPlayerData(id, "NumBuildings")
                       if cnts == nil then
                          playerUnitCounts[id + 1] = { newTotals, newCurrent }
                          stuckPlayers = false
                       elseif newTotals > 0 and newCurrent > 0 then
                          if newTotals == cnts[1] and newCurrent == cnts[2] then
                             -- nothing at all happened in the last 20000 cycles, nothing was build and nothing destroyed, this player seems stuck
                             print("Player " .. id + 1 .. " is stuck")
                          else
                             -- if even one of the players is still building or destroying stuff, we're not yet stuck
                             cnts[1] = newTotals
                             cnts[2] = newCurrent
                             stuckPlayers = false
                          end
                       end
                    elseif (GetNumOpponents(id) > 0 and
                            (GetPlayerData(id, "UnitTypesCount", "unit-peasant") > 0 or
                             GetPlayerData(id, "UnitTypesCount", "unit-peon") > 0 or
                             (GetPlayerData(id, "Resources", "gold") > 600 and
                              (GetPlayerData(id, "UnitTypesCount", "unit-town-hall") > 0) or
                              (GetPlayerData(id, "UnitTypesCount", "unit-great-hall") > 0) or
                              (GetPlayerData(id, "UnitTypesCount", "unit-keep") > 0) or
                              (GetPlayerData(id, "UnitTypesCount", "unit-stronghold") > 0) or
                              (GetPlayerData(id, "UnitTypesCount", "unit-castle") > 0) or
                              (GetPlayerData(id, "UnitTypesCount", "unit-fortress") > 0)))) then
                       -- players with a worker or a city center and enough money for a worker are alive
                       stuckPlayers = false
                    end
                 end
                 if stuckPlayers then
                    print("Game ends at GameCycle", GameCycle)
                 end
                 return stuckPlayers -- game ends only when all players are stuck (i.e., dead, have no opponents left, or cannot build anymore)
              end,
              function() return ActionVictory() end)
        end
        ActionVictory = OldActionVictory
        RunResultsMenu = function()
        end
     end

     -- forcibly disable all players save the required ones
     for i=0,14 do
        GameSettings.Presets[i].Type = PlayerNobody
     end

     GameSettings.Presets[aiPlayerNum + 1].Type = PlayerPerson
     GameSettings.Presets[aiPlayerNum + 1].PlayerColor = aiPlayerNum + 1
     for i=0,aiPlayerNum do
        -- race is default
        -- teams are established based on game type
        GameSettings.Presets[i].Type = PlayerComputer
        GameSettings.Presets[i].PlayerColor = i
        if aiscriptNames[i + 1] ~= nil then
           GameSettings.Presets[i].AIScript = aiscriptNames[i + 1]
        end
     end
     GameSettings.Difficulty = 1 -- easy mode
     if doReveal then
        GameSettings.NoFogOfWar = true
        GameSettings.RevealMap = 2
     end
     GameSettings.GameType = gameType
     GameSettings.NetGameType = 1 -- single player game
     if mapfile then
        Load(mapfile)
        RunMap(mapfile)
     else
        Load(mapname)
        RunMap(mapname)
     end
  end

  if rept then
     local actualCustomStartup = CustomStartup
     CustomStartup = function()
        for i=1,rept do
           print("Repeat " .. i)
           actualCustomStartup()
        end
     end
  end
end
