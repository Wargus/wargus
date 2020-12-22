local ARGS=...

Load("scripts/stratagus.lua")
SetTitleScreens({})
CustomStartup = function() end

local function usage()
  print("Single player startup file for Wargus. Options are passed as comma-separated pairs")
  print("\t[map=[map.smp]]")
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
     Load(mapfile)
     if gameType ~= SettingsGameTypeMapDefault then
        SinglePlayerTriggers = function()
           AddTrigger(
              function()
                 for id=1,15 do
                    if GetNumOpponents(id) > 0 and GetPlayerData(id, "TotalNumUnits") > 0 then
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
           -- TODO: report to AI server training data?
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
     GameSettings.GameType = gameType
     GameSettings.NetGameType = 1 -- single player game
     Load(mapname)
     RunMap(mapname)
  end
end
