--  (c) Copyright 2005-2006 by François Beerten and Jimmy Salmon

function bool2int(boolvalue)
  if boolvalue == true then
    return 1
  else
    return 0
  end
end

function int2bool(int)
  if int == 0 then
    return false
  else
    return true
  end
end

function ErrorMenu(errmsg)
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Error:", 144, 11)

  local l = MultiLineLabel(errmsg)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.CENTER)
  l:setVerticalAlignment(MultiLineLabel.CENTER)
  l:setLineWidth(270)
  l:setWidth(270)
  l:setHeight(41)
  l:setBackgroundColor(dark)
  menu:add(l, 9, 38)

  menu:addHalfButton("~!OK", "o", 92, 80, function() menu:stop() end)

  menu:run()
end

function addPlayersList(menu, numplayers)
  local i
  local players_name = {}
  local players_state = {}
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local numplayers_text

  menu:writeLargeText("Players", sx * 11, sy*3)
  for i=1,8 do
    players_name[i] = menu:writeText("Player"..i, sx * 11, sy*4 + i*18)
    players_state[i] = menu:writeText("Preparing", sx * 11 + 80, sy*4 + i*18)
  end
  numplayers_text = menu:writeText("Open slots : " .. numplayers - 1, sx *11, sy*4 + 144)

  local function updatePlayers()
    local connected_players = 0
    local ready_players = 0
    players_state[1]:setCaption("Creator")
    players_name[1]:setCaption(Hosts[0].PlyName)
    for i=2,8 do
      if Hosts[i-1].PlyName == "" then
        players_name[i]:setCaption("")
        players_state[i]:setCaption("")
      else
        connected_players = connected_players + 1
        if ServerSetupState.Ready[i-1] == 1 then
          ready_players = ready_players + 1
          players_state[i]:setCaption("Ready")    
        else
          players_state[i]:setCaption("Preparing")
        end
        players_name[i]:setCaption(Hosts[i-1].PlyName)
     end
    end
    numplayers_text:setCaption("Open slots : " .. numplayers - 1 - connected_players)
    numplayers_text:adjustSize()
    return (connected_players > 0 and ready_players == connected_players)
  end

  return updatePlayers
end


joincounter = 0

function RunJoiningMapMenu(s)
  local menu
  local listener  
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local numplayers = 3
  local state
  local d

  menu = WarMenu("Joining game: Map")

  menu:writeLargeText("Map", sx, sy*3)
  menu:writeText("File:", sx, sy*3+30)
  maptext = menu:writeText(NetworkMapName, sx+50, sy*3+30)
  menu:writeText("Players:", sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText("Description:", sx, sy*3+70)
  descr = menu:writeText(description, sx+20, sy*3+90)

  local fow = menu:addCheckBox("Fog of war", sx, sy*3+120, function() end)
  fow:setMarked(true)
  ServerSetupState.FogOfWar = 1
  fow:setEnabled(false)
  local revealmap = menu:addCheckBox("Reveal map", sx, sy*3+150, function() end)
  revealmap:setEnabled(false)
  
  menu:writeText("Units:", sx, sy*11)
  local units = menu:addDropDown({"Map Default", "One Peasant Only"}, sx + 100, sy*11,
    function(dd) end)
  units:setSize(190, 20)
  units:setEnabled(false)

  menu:writeText("Resources:", sx, sy*11+25)
  local resources = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, sx + 100, sy*11+25,
    function(dd) end)
  resources:setSize(190, 20)
  resources:setEnabled(false)

  local OldPresentMap = PresentMap
  PresentMap = function(desc, nplayers, w, h, id)
    numplayers = nplayers
    players:setCaption(""..nplayers)
    players:adjustSize()
    descr:setCaption(desc)
    descr:adjustSize()
    OldPresentMap(desc, nplayers, w, h, id)
  end

  -- Security: The map name is checked by the stratagus engine.
  Load(NetworkMapName)
  local function readycb(dd)
     LocalSetupState.Ready[NetLocalHostsSlot] = bool2int(dd:isMarked())
  end
  menu:addCheckBox("~!Ready", sx*11,  sy*14, readycb)

  local updatePlayersList = addPlayersList(menu, numplayers)

  joincounter = 0
  local function listen()
    NetworkProcessClientRequest()
    fow:setMarked(int2bool(ServerSetupState.FogOfWar))
    GameSettings.NoFogOfWar = not int2bool(ServerSetupState.FogOfWar)
    revealmap:setMarked(int2bool(ServerSetupState.RevealMap))
    GameSettings.RevealMap = ServerSetupState.RevealMap
    units:setSelected(ServerSetupState.UnitsOption)
    GameSettings.NumUnits = ServerSetupState.UnitsOption
    resources:setSelected(ServerSetupState.ResourcesOption)
    GameSettings.Resources = ServerSetupState.ResourcesOption
    updatePlayersList()
    state = GetNetworkState()
    -- FIXME: don't use numbers
    if (state == 15) then -- ccs_started, server started the game
      SetThisPlayer(1)
      joincounter = joincounter + 1
      if (joincounter == 30) then
        SetFogOfWar(fow:isMarked())
        if revealmap:isMarked() == true then
          RevealMap()
        end
        NetworkGamePrepareGameSettings()
        RunMap(NetworkMapName)
        PresentMap = OldPresentMap
        menu:stop()
      end
    elseif (state == 10) then -- ccs_unreachable
      ErrorMenu("Cannot reach server")
      menu:stop()
    end
  end
  listener = LuaActionListener(listen)
  menu:addLogicCallback(listener)

  menu:addFullButton("~!Cancel", "c", Video.Width / 2 - 100, Video.Height - 100,
    function() NetworkDetachFromServer(); menu:stop() end)

  menu:run()
end

function RunJoiningGameMenu(s)
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Connecting to server", 144, 11)

  local percent = 0

  local sb = StatBoxWidget(258, 30)
  sb:setCaption("Connecting...")
  sb:setPercent(percent)
  menu:add(sb, 15, 38)
  sb:setBackgroundColor(dark)

  local function checkconnection() 
    NetworkProcessClientRequest()
    percent = percent + 100 / (24 * GetGameSpeed()) -- 24 seconds * fps
    sb:setPercent(percent)
    local state = GetNetworkState()
    -- FIXME: do not use numbers
    if (state == 3) then -- ccs_mapinfo
      -- got ICMMap => load map
      RunJoiningMapMenu()
      menu:stop(0)
    elseif (state == 4) then -- ccs_badmap
      ErrorMenu("Map not available")
      menu:stop(1)
    elseif (state == 10) then -- ccs_unreachable
      ErrorMenu("Cannot reach server")
      menu:stop(1)
    elseif (state == 12) then -- ccs_nofreeslots
      ErrorMenu("Server is full")
      menu:stop(1)
    elseif (state == 13) then -- ccs_serverquits
      ErrorMenu("Server gone")
      menu:stop(1)
    elseif (state == 16) then -- ccs_incompatibleengine
      ErrorMenu("Incompatible engine version")
      menu:stop(1)
    elseif (state == 17) then -- ccs_incompatiblenetwork
      ErrorMenu("Incompatible netowrk version")
      menu:stop(1)
    end
  end
  local listener = LuaActionListener(checkconnection)
  menu:addLogicCallback(listener)

  menu:addHalfButton("Cancel (~<Esc~>)", "escape", 92, 80,
    function() menu:stop(1) end)

  menu:run()
end

function RunJoinIpMenu()
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Enter server IP-address:", 144, 11)
  local server = menu:addTextInputField("localhost", 40, 38, 212)

  menu:addHalfButton("~!OK", "o", 24, 80,
    function(s) 
      -- FIXME: allow port ("localhost:1234")
      if (NetworkSetupServerAddress(server:getText()) ~= 0) then
        ErrorMenu("Invalid server name")
        return
      end
      NetworkInitClientConnect() 
      if (RunJoiningGameMenu() ~= 0) then
        -- connect failed, don't leave this menu
        return
      end
      menu:stop() 
    end
  )
  menu:addHalfButton("~!Cancel", "c", 154, 80, function() menu:stop() end)

  menu:run()
end

function RunServerMultiGameMenu(map, description, numplayers)
  local menu
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local startgame
  local d

  menu = WarMenu("Create MultiPlayer game")

  menu:writeLargeText("Map", sx, sy*3)
  menu:writeText("File:", sx, sy*3+30)
  maptext = menu:writeText(map, sx+50, sy*3+30)
  menu:writeText("Players:", sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText("Description:", sx, sy*3+70)
  descr = menu:writeText("Unknown map", sx+20, sy*3+90)

  local function fowCb(dd)
    ServerSetupState.FogOfWar = bool2int(dd:isMarked()) 
    NetworkServerResyncClients()
    GameSettings.NoFogOfWar = not dd:isMarked()
  end
  local fow = menu:addCheckBox("Fog of war", sx, sy*3+120, fowCb)
  fow:setMarked(true)
  local function revealMapCb(dd)
    ServerSetupState.RevealMap = bool2int(dd:isMarked()) 
    NetworkServerResyncClients()
    GameSettings.RevealMap = bool2int(dd:isMarked())
  end
  local revealmap = menu:addCheckBox("Reveal map", sx, sy*3+150, revealMapCb)
  
  menu:writeText("Units:", sx, sy*11)
  d = menu:addDropDown({"Map Default", "One Peasant Only"}, sx + 100, sy*11,
    function(dd)
      GameSettings.NumUnits = dd:getSelected()
      ServerSetupState.UnitsOption = GameSettings.NumUnits
      NetworkServerResyncClients()
    end)
  d:setSize(190, 20)

  menu:writeText("Resources:", sx, sy*11+25)
  d = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, sx + 100, sy*11+25,
    function(dd)
      GameSettings.Resources = dd:getSelected()
      ServerSetupState.ResourcesOption = GameSettings.Resources
      NetworkServerResyncClients()
    end)
  d:setSize(190, 20)

  local updatePlayers = addPlayersList(menu, numplayers)

  NetworkMapName = map
  NetworkInitServerConnect(numplayers)
  ServerSetupState.FogOfWar = 1
  startgame = menu:addFullButton("~!Start Game", "s", sx * 11,  sy*14, 
    function(s)    
      SetFogOfWar(fow:isMarked())
      if revealmap:isMarked() == true then
        RevealMap()
      end
      NetworkServerStartGame() 
      NetworkGamePrepareGameSettings()
      RunMap(map)
      menu:stop()
    end
  )
  startgame:setVisible(false)
  local waitingtext = menu:writeText("Waiting for players", sx*11, sy*14)
  local function updateStartButton(ready) 
    startgame:setVisible(ready)
    waitingtext:setVisible(not ready)
  end

  local listener = LuaActionListener(function(s) updateStartButton(updatePlayers()) end)
  menu:addLogicCallback(listener)

  menu:addFullButton("~!Cancel", "c", Video.Width / 2 - 100, Video.Height - 100,
    function() menu:stop() end)

  menu:run()
end

function RunCreateMultiGameMenu(s)
  local menu
  local map = "No Map"
  local description = "No map"
  local mapfile = "maps/default.smp"
  local numplayers = 3
  local sx = Video.Width / 20
  local sy = Video.Height / 20

  menu = WarMenu("Create MultiPlayer game")

  menu:writeText("File:", sx, sy*3+30)
  maptext = menu:writeText(mapfile, sx+50, sy*3+30)
  menu:writeText("Players:", sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText("Description:", sx, sy*3+70)
  descr = menu:writeText(description, sx+20, sy*3+90)

  local OldPresentMap = PresentMap
  PresentMap = function(desc, nplayers, w, h, id)
    numplayers = nplayers
    players:setCaption(""..numplayers)
    players:adjustSize()
    description = desc
    descr:setCaption(desc)
    descr:adjustSize()
    OldPresentMap(desc, nplayers, w, h, id)
  end

  Load(mapfile)
  local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$", sx*10, sy*2+20, sx*8, sy*11)
  local function cb(s)
    mapfile = browser.path .. browser:getSelectedItem()
    Load(mapfile)
    maptext:setCaption(mapfile)
    maptext:adjustSize()
  end
  browser:setActionCallback(cb)
  
  menu:addFullButton("~!Create Game", "c", sx,  sy*11, 
    function(s)    
      if (browser:getSelected() < 0) then
        return
      end
      RunServerMultiGameMenu(mapfile, description, numplayers)
      menu:stop()
    end
  )
  menu:run()
  PresentMap = OldPresentMap
end

function RunCreateJoinMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  InitGameSettings()
  InitNetwork1()

  menu:addFullButton("~!Join Game", "j", 208 + offx, 320 + (36 * 0) + offy,
    function()
      RunJoinIpMenu()
      menu:stop()
    end)
  menu:addFullButton("~!Create Game", "c", 208 + offx, 320 + (36 * 1) + offy,
    function()
      RunCreateMultiGameMenu()
      menu:stop()
    end)

  menu:addFullButton("~!Previous Menu", "p", 208 + offx, 320 + (36 * 2) + offy,
    function() menu:stop() end)

  menu:run()

  ExitNetwork1()
end

function RunMultiPlayerGameMenu(s)
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Enter your name:", 288 / 2, 11)

  local nick = menu:addTextInputField(GetLocalPlayerName(), 40, 38, 212)

  menu:addHalfButton("~!OK", "o", 24, 80,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunCreateJoinMenu()
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", 154, 80, function() menu:stop() end)

  menu:run()
end

