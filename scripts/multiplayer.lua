local ARGS=...

Load("scripts/stratagus.lua")
SetTitleScreens({})
CustomStartup = function() end

local function usage()
   print("Server startup file for Wargus options. Options are passed as comma-separated pairs")
   print("\t[server|client]")
   print("\t[numplayers=[number of connections to wait for before game starts]]")
   print("\t[ip=server-ip]")
   print("\t[race=(orc|human)]")
   print("\t[map=[map.smp]]")
   print("\t[player=[nickname]]")
   print("\nAll options must be passed comma-separated. For example:")
   print("\twargus -c multiplayer -G server,race=human,map=islands.smp.gz,numplayers=2")
   print("\t\t... will start a server that waits for one more player.")
   print("\twargus -c multiplayer -G client,race=orc,ip=192.168.1.100")
   print("\t\t... will start a client that connects to 192.168.1.100 and is immediately ready.\n\n\n")
end

if (ARGS == "help") then
   usage()
else
   local isServer = string.match(ARGS,"(server)")
   local isClient = string.match(ARGS,"(client)")
   if (not (isClient or isServer)) then
      print("ERROR: Must say if client or server\n")
      usage()
      return
   end
   local ip = string.match(ARGS,"ip=([^,]+)")
   local racename = string.match(ARGS,"race=([^,]+)") or "default"
   local mapfile = string.match(ARGS,"map=([^,]+)")
   local nickname = string.match(ARGS,"player=([^,]+)")
   local numplayers = tonumber(string.match(ARGS,"numplayers=([^,]+)"))

   if (nickname) then SetLocalPlayerName(nickname) end

   NoRandomPlacementMultiplayer = 1

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
	 RunServerMultiGameMenu(mapfile, description, playerCount, racename, numplayers)
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
	 RunJoiningGameMenu(race, true)
      end
   end
end
