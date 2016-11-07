local ARGS=...

Load("scripts/stratagus.lua")
SetTitleScreens({})
CustomStartup = function() end

local function usage()
  print("Server startup file for Wargus options. Options are passed as comma-separated pairs")
  print("\t[server|client]")
  print("\t[dedicated] -- only valid for server, computer becomes an extra player")
  print("\t[numplayers=[number of connections to wait for before game starts]]")
  print("\t[ip=server-ip] -- only valid for client")
  print("\t[race=(orc|human)]")
  print("\t[map=[map.smp]] -- only valid for server")
  print("\t[player=[nickname]]")
  print("\t[fow=(1|0)] -- only valid for server")
  print("\t[units=1] -- only valid for server (1 is for one peasant only)")
  print("\t[resources=(Low|Medium|High)] -- only valid for server")
  print("\t[reveal=(0|1)] -- only valid for server")
  print("\nAll options must be passed comma-separated. For example:")
  print("\twargus -c multiplayer -G server,race=human,map=islands.smp.gz,numplayers=2,resources=High,units=1")
  print("\t\t... will start a server that waits for one more player.")
  print("\twargus -c multiplayer -G client,race=orc,ip=192.168.1.100")
  print("\t\t... will start a client that connects to 192.168.1.100 and is immediately ready.\n\n\n")
  print("\twargus -c multiplayer -G server,dedicated,map=islands.smp.gz,numplayers=3")
  print("\t\t... will start a dedicated server with an AI player that waits for 3 human player clients.")
end

if (ARGS == "help") then
  usage()
else
  local isServer = string.match(ARGS,"(server)")
  local isDedicated = string.match(ARGS,"(dedicated)")
  local isClient = string.match(ARGS,"(client)")
  if (not (isClient or isServer)) then
    print("ERROR: Must say if client or server\n")
    usage()
    return
  end
  local ip = string.match(ARGS,"ip=([^,]+)")
  local racename = string.match(ARGS,"race=([^,]+)") or "default"
  local resources= string.match(ARGS,"resources=([^,]+)") or "default"
  local units = string.match(ARGS,"units=([^,]+)") or "default"
  local mapfile = string.match(ARGS,"map=([^,]+)")
  local nickname = string.match(ARGS,"player=([^,]+)")
  local numplayers = tonumber(string.match(ARGS,"numplayers=([^,]+)"))
  local fow = tonumber(string.match(ARGS,"fow=([^,]+)"))
  local reveal = tonumber(string.match(ARGS,"reveal=([^,]+)"))

  if (nickname) then SetLocalPlayerName(nickname) end

  if (isServer) then
    if (not (mapfile and numplayers)) then
      print ("ERROR: Server must at least pass map and number of players\n")
      usage()
      return
    end

    CustomStartup = function()
      InitGameSettings()
      InitNetwork1()
      local playerCount = 0
      local OldPresentMap = PresentMap
      PresentMap = function(desc, nplayers, w, h, id)
        description = desc
        OldPresentMap(desc, nplayers, w, h, id)
      end
      local oldDefinePlayerTypes = DefinePlayerTypes
      DefinePlayerTypes = function(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16)
        local ps = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16}
        playerCount = 0

        for _, s in pairs(ps) do
          if s == "person" then
            playerCount = playerCount + 1
          end
        end
        oldDefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16)
      end
      Load(mapfile)
      if (playerCount == 0) then
        print("ERROR: could not open map " .. mapfile)
        return
      end
      if (playerCount == 1) then
        print("ERROR: not a multiplayer map " .. mapfile)
        return
      end
      if isDedicated then
        -- no confirmation on AI-only server, just exit
        ActionVictory = OldActionVictory
        RunResultsMenu = function() end
        numplayers = numplayers + 1
      end
      RunServerMultiGameMenu(mapfile, description, playerCount,
        {race = racename,
          autostartNum = numplayers,
          dedicated = isDedicated,
          resources = resources,
          units = units,
          fow = fow,
          revealmap = reveal})
    end
  else
    if (not ip) then
      print ("ERROR: Client must at least pass server ip\n")
      usage()
      return
    end
    CustomStartup = function()
      InitGameSettings()
      InitNetwork1()
      NetworkSetupServerAddress(ip)
      NetworkInitClientConnect()
      RunJoiningGameMenu(racename, true)
    end
  end
end
