local ARGS=...

Load("scripts/stratagus.lua")
SetTitleScreens({})
CustomStartup = function() end

local function usage()
  print("Single player startup file for Wargus. Options are passed as comma-separated pairs")
  print("\t[map=[map.smp]]")
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

  local aiscriptNames = {}
  if aiscripts ~= nil then
     for scriptname in string.gmatch(aiscripts, "([^:]+)") do
        table.insert(aiscriptNames, scriptname)
     end
  end

  if (aiPlayerNum == nil) then
    aiPlayerNum = 2
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
     local playerIds = {}
     if gameType ~= SettingsGameTypeMapDefault then
        SinglePlayerTriggers = function()
           AddTrigger(
              function()
                 for id=1,15 do
                    if GameCycle < 100000 and -- do not overextend games
                       (GetNumOpponents(id) > 0 and
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
                       return false
                    end
                 end
                 -- when there is only AI players left that have units, but no opponents, we're done
                 return true
              end,
              function() return ActionVictory() end)
        end
        ActionVictory = OldActionVictory
        RunResultsMenu = function()
        end
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
     GameSettings.NoFogOfWar = true
     GameSettings.RevealMap = 2
     GameSettings.GameType = gameType
     GameSettings.NetGameType = 1 -- single player game
     print(mapname, mapfile)
     -- Load(mapname)
     -- RunMap(mapname)
     Load(mapfile)
     RunMap(mapfile)
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
