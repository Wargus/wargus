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
--      network.lua - Define the menu for network game.
--
--      (c) Copyright 2005-2016 by François Beerten, Jimmy Salmon, Pali Rohár
--								   and Cybermind.
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

  menu:addLabel(_("Error:"), 144, 11)

  local l = MultiLineLabel(errmsg)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.CENTER)
  l:setVerticalAlignment(MultiLineLabel.CENTER)
  l:setLineWidth(270)
  l:setWidth(270)
  l:setHeight(41)
  l:setBackgroundColor(dark)
  menu:add(l, 9, 38)

  local btn = menu:addHalfButton("~!OK", "o", 92, 80, function() menu:stop() end)
  btn:requestFocus()

  menu:run()
end

function RunJoiningMapMenu(optRace, optReady)
  -- Security: The map name is checked by the stratagus engine.
  Load(NetworkMapName)
  local numplayers = 0
  for i,v in ipairs(Map.Info.PlayerType) do
    if v == PlayerPerson then
      numplayers = numplayers + 1
    end
  end

  local menu = CreateOnlineLobby(NetworkMapName, numplayers, false)

  local joincounter = 0
  local delay = 4
  local function listen()
    NetworkProcessClientRequest()
    menu:updateOptions()
    state = GetNetworkState()
    -- FIXME: don't use numbers
    if delay > 0 then
      delay = delay - 1
    elseif delay == 0 then
      if (optRace == "human" or optRace == "Human") then
        menu.option_race:setSelected(1)
        menu.option_race.callback(menu.option_race)
        optRace = ""
      elseif (optRace == "orc" or optRace == "Orc") then
        menu.option_race:setSelected(2)
        menu.option_race.callback(menu.option_race)
        optRace = ""
      end
    end
    if (state == 15) then -- ccs_started, server started the game
      joincounter = joincounter + 1
      if (joincounter == 30) then
        NetworkGamePrepareGameSettings()
        RunMap(NetworkMapName)
        menu:stop()
      end
    elseif (state == 10) then -- ccs_unreachable
      ErrorMenu(_("Cannot reach server"))
      menu:stop()
    end
  end
  local listener = LuaActionListener(listen)
  menu:addLogicCallback(listener)

  if optReady then
    LocalSetupState.Ready[NetLocalHostsSlot] = bool2int(true)
    menu.checkbox_ready:setMarked(true)
  end

  menu:run()
end

function RunJoiningGameMenu(optRace, optReady)
  local menu = nil
  if (optRace and optReady) then
    menu = WarMenu(_("Joining Game"))
  else
    menu = WarMenu(nil, panel(4), false)
    menu:setSize(288, 128)
    menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
    menu:setDrawMenusUnder(true)
  end

  menu:addLabel(_("Connecting to server"), 144, 11)

  local percent = 0

  local sb = StatBoxWidget(258, 30)
  sb:setCaption(_("Connecting..."))
  sb:setPercent(percent)
  menu:add(sb, 15, 38)
  sb:setBackgroundColor(dark)

  local startedRcvMap = false

  local function checkconnection()
    NetworkProcessClientRequest()
    if startedRcvMap then
      percent = percent + 100 / (120 * GetGameSpeed()) -- 48 seconds * fps
    else
      percent = percent + 100 / (24 * GetGameSpeed()) -- 24 seconds * fps
    end
    sb:setPercent(percent)
    local state = GetNetworkState()
    -- FIXME: do not use numbers
    if (state == 3) then -- ccs_mapinfo
      -- got ICMMap => load map
      RunJoiningMapMenu(optRace, optReady)
      menu:stop(0) -- joining through local server menu
    elseif (state == 4) then -- ccs_badmap
      ErrorMenu(_("Map not available"))
      menu:stop(1)
    elseif (state == 10) then -- ccs_unreachable
      ErrorMenu(_("Cannot reach server"))
      menu:stop(1)
    elseif (state == 12) then -- ccs_nofreeslots
      ErrorMenu(_("Server is full"))
      menu:stop(1)
    elseif (state == 13) then -- ccs_serverquits
      ErrorMenu(_("Server gone"))
      menu:stop(1)
    elseif (state == 16) then -- ccs_incompatibleengine
      ErrorMenu(_("Incompatible engine version"))
      menu:stop(1)
    elseif (state == 17) then -- ccs_incompatibleluafiles
      ErrorMenu(_("Incompatible lua files"))
      menu:stop(1)
    elseif (state == 18) then -- ccs_needmap
      if not startedRcvMap then
        percent = 0
        startedRcvMap = true
      end
      sb:setCaption("Get " .. NetworkMapFragmentName)
    end
  end
  local listener = LuaActionListener(checkconnection)
  menu:addLogicCallback(listener)

  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 92, 80,
    function() menu:stop(1) end)

  return menu:run()
end

function RunJoinIpMenu()
  local menu = WarMenu(nil, panel(5), false)
  local serverlist = nil
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)
  menu:addLabel(_("Servers: "), 176, 20)
  local servers = {}
  local function ServerListUpdate()
    servers = {}
    if (wc2.preferences.ServerList ~= nil) then
      for i=1,table.getn(wc2.preferences.ServerList)/2 do
        servers[i]=tostring(wc2.preferences.ServerList[(i-1)*2+1].." | "..tostring(wc2.preferences.ServerList[(i-1)*2+2]))
      end
    end
    local newlyDiscovered = NetworkDiscoverServers(true)
    for i,v in ipairs(newlyDiscovered) do
       table.insert(servers, v .. " | (auto-discovered)")
    end
    if serverlist == nil then
       serverlist = menu:addImageListBox(20, 50, 300, 120, servers)
    else
       serverlist:setList(servers)
    end
  end
  ServerListUpdate()
  menu:addFullButton(_("Co~!nnect"), "n", 60, 180, function()
      local selectedserver = servers[serverlist:getSelected() + 1]
      local ip = string.match(selectedserver, "[0-9\.]+")
      print("Joining " .. ip)
      NetworkDiscoverServers(false)
      NetworkSetupServerAddress(ip)
      NetworkInitClientConnect()
      if (RunJoiningGameMenu() ~= 0) then
        -- connect failed, don't leave this menu
        return
      end
    end)
  menu:addFullButton(_("~!Add server"), "a", 60, 210, function() RunAddServerMenu(); ServerListUpdate() end)
  -- We need to stop this from loading when there are no servers.
  menu:addFullButton(_("~!Edit server"), "a", 60, 240, function()
      if serverlist:getSelected() ~= nil then
        RunEditServerMenu(serverlist:getSelected()); ServerListUpdate()
      end
    end)
  menu:addFullButton(_("~!Delete server"), "d", 60, 270, function()
      if serverlist:getSelected() ~= nil then
        table.remove(wc2.preferences.ServerList, serverlist:getSelected()*2+1)
        table.remove(wc2.preferences.ServerList, serverlist:getSelected()*2+1)
        SavePreferences()
        ServerListUpdate()
      end
  end)

  local counter = 30
  local listener = LuaActionListener(function(s)
        if counter == 0 then
           counter = 300
           ServerListUpdate()
        else
           counter = counter - 1
        end
  end)
  menu:addLogicCallback(listener)

  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", 60, 300, function() menu:stop() end)
  menu:run()
end

function RunEditServerMenu(number)
  local menu = WarMenu(nil, panel(2), false)
  menu:setSize(288, 256)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 256) / 2)
  menu:setDrawMenusUnder(true)
  menu:addLabel(_("Edit server"), 144, 11)
  menu:addLabel(_("Server IP: "), 20, 31, Fonts["game"], false)
  local serverIp = menu:addTextInputField("localhost", 30, 51, 212)
  serverIp:setText(wc2.preferences.ServerList[number*2+1])
  menu:addLabel(_("Description: "), 20, 81, Fonts["game"], false)
  local serverDescr = menu:addTextInputField("", 30, 101, 212)
  serverDescr:setText(wc2.preferences.ServerList[number*2+2])
  menu:addHalfButton("~!OK", "o", 15, 210, function(s)
      if (NetworkSetupServerAddress(serverIp:getText()) ~= 0) then
        ErrorMenu(_("Invalid server name"))
        return
      end
      wc2.preferences.ServerList[number*2+1] = serverIp:getText()
      wc2.preferences.ServerList[number*2+2] = serverDescr:getText()
      SavePreferences()
      menu:stop()
    end)
  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 164, 210, function() menu:stop() end)
  menu:run()
end

function RunAddServerMenu()
  local menu = WarMenu(nil, panel(2), false)
  menu:setSize(288, 256)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 256) / 2)
  menu:setDrawMenusUnder(true)
  menu:addLabel(_("Add server"), 144, 11)
  menu:addLabel(_("Server IP: "), 20, 31, Fonts["game"], false)
  local serverIp = menu:addTextInputField("localhost", 30, 51, 212)
  menu:addLabel(_("Description: "), 20, 81, Fonts["game"], false)
  local serverDescr = menu:addTextInputField("", 30, 101, 212)
  menu:addHalfButton("~!OK", "o", 15, 210, function(s)
      if (NetworkSetupServerAddress(serverIp:getText()) ~= 0) then
        ErrorMenu(_("Invalid server name"))
        return
      end
      table.insert(wc2.preferences.ServerList, serverIp:getText())
      table.insert(wc2.preferences.ServerList, serverDescr:getText())
      SavePreferences()
      menu:stop()
    end)
  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 164, 210, function() menu:stop() end)
  menu:run()
end

function CreateOnlineLobby(map, numplayers, isserver)
  local menu
  local playerTable = {HBox({ _("Players") }),}
  local playerNames = {"", "AI"}

  local function updatePlayerNamesFromHosts()
    local changed = false
    for i=0,PlayerMax-1 do
      if (playerNames[i + 3] or Hosts[i].PlyName ~= "") and playerNames[i + 3] ~= Hosts[i].PlyName then
        changed = true
        playerNames[i + 3] = Hosts[i].PlyName
      end
    end
    if changed then
      for i=1,PlayerMax do
        if menu.player_dropdown[i] then
          local idx = menu.player_dropdown[i]:getSelected()
          menu.player_dropdown[i]:setList(playerNames)
          menu.player_dropdown[i]:setSelected(idx)
        end
      end
    end
  end

  local function updatePlayerSelectionFromHosts()
    for i=1,PlayerMax do
      local name = Hosts[i - 1].PlyName
      if name ~= "" then
        local no = Hosts[i - 1].PlyNr
        local dd = menu.player_dropdown[no + 1]
        menu.player_team[no + 1]:setSelected(ServerSetupState.ServerGameSettings.Presets[no].Team + 1)
        if playerNames[dd:getSelected() + 1] ~= name then
          -- select this name in the appropriate drop down
          local j = 1
          while j <= #playerNames do
            if playerNames[j] == name then
              dd:setSelected(j - 1)
              break
            end
            j = j + 1
          end
          -- deselect this name in any other drop down
          for k=1,PlayerMax do
            local ddo = menu.player_dropdown[k]
            if ddo and ddo ~= dd and ddo:getSelected() == j - 1 then
              ddo:setSelected(0)
            end
          end
        end
      end
    end
  end

  local function updateAIPlayersSelection()
    local opponents = ServerSetupState.Opponents
    for i,dd in ipairs(menu.player_dropdown) do
      if dd and dd:getSelected() < 2 then
        if opponents > 0 then
          dd:setSelected(1)
          opponents = opponents - 1
        else
          dd:setSelected(0)
        end
      end
    end
  end

  local function updatePlayerListFromHosts()
    updatePlayerNamesFromHosts()
    updatePlayerSelectionFromHosts()
    updateAIPlayersSelection()
  end

  local function assignMissingHumanPlayersToDropdowns()
    -- figure out which human players are not assigned to a visible dropdown
    local playerNameSet = {}
    for i=1,PlayerMax do
      local dd = menu.player_dropdown[i]
      if dd then
        playerNameSet[playerNames[dd:getSelected() + 1]] = true
      end
    end
    local missingPlayers = {}
    for i=3,#playerNames do
      if not playerNameSet[playerNames[i]] then
        missingPlayers[#missingPlayers + 1] = playerNames[i]
      end
    end

    -- assign an non-assigned players to some dropdown that has one
    for i=1,#missingPlayers do
      local missingPlayerName = missingPlayers[i]
      for j=1,PlayerMax do
        local dd = menu.player_dropdown[j]
        if dd and dd:getSelected() < 2 then
          -- this one is open or AI, assign the missing player here
          for k=0,PlayerMax do
            if Hosts[k].PlyName == missingPlayerName then
              Hosts[k].PlyNr = j
              break
            end
          end
          break
        end
      end
    end
  end

  local function calculateAiPlayers()
    local ai_players = 0
    for i=1,PlayerMax do
      local dd = menu.player_dropdown[i]
      if dd and dd:getSelected() == 1 then
        ai_players = ai_players + 1
      end
    end
    if ServerSetupState.Opponents ~= ai_players then
      ServerSetupState.Opponents = ai_players
      NetworkServerResyncClients()
    end
  end

  local teams = {""}
  for i=1,PlayerMax do
    if Map.Info.PlayerType[i - 1] == PlayerPerson then
      playerTable[i + 1] = HBox({
        LDropDown(playerNames, function(dd)
          local newIdx = dd:getSelected()
          if newIdx < 2 then
            -- nothing to do, this is now an open slot or an AI
          else
            local newName = playerNames[newIdx + 1]
            -- figure out our own player index
            local playerIndex
            for i=1,PlayerMax do
              if menu.player_dropdown[i] == dd then
                playerIndex = i
                break
              end
            end
            
            -- figure out which host to assign this new player index to
            for i=0,PlayerMax-1 do
              if Hosts[i].PlyName == newName then
                Hosts[i].PlyNr = playerIndex - 1
                break
              end
            end
            
            -- deselect this human player from all other dropdowns
            for i=1,PlayerMax do
              if i ~= playerIndex then -- not ourselves
                local dd = menu.player_dropdown[i]
                if dd and dd:getSelected() > 1 then -- a human player
                  if playerNames[dd:getSelected() + 1] == newName then -- same human player
                    dd:setSelected(0) -- just open this slot again
                  end
                end
              end
            end
          end
          assignMissingHumanPlayersToDropdowns()
          calculateAiPlayers()
          NetworkServerResyncClients()
        end):id("player_dropdown[" .. i .. "]"):withWidth(100),
        LDropDown(teams, function(dd)
           local playerIndex
           for i=1,PlayerMax do
              if menu.player_team[i] == dd then
                 ServerSetupState.ServerGameSettings.Presets[i - 1].Team = dd:getSelected() - 1
                 NetworkServerResyncClients()
                 break
              end
           end
        end):id("player_team[" .. i .. "]"):withWidth(Fonts["large"]:Width(tostring(PlayerMax))* 2),
        LLabel("", "game"):id("player_status[" .. i .. "]"),
      })
      teams[#teams + 1] = tostring(#teams)
    else
      playerTable[i + 1] = LLabel(string.format(_("Slot %d unavailable"), i), "small")
    end
  end

  menu = WarMenuWithLayout(_("Create MultiPlayer game"), nil, VBox({
    LFiller(),
    HBox({ -- screen split
      LFiller(),
      VBox({ -- game properties
        HBox({ _("Map") }),
        HBox({ LLabel(_("File:"), "game"), LLabel(map, "game") }),
        HBox({ LLabel(_("Players:"), "game"), LLabel(numplayers, "game") }),
        HBox({ LLabel(_("Description:"), "game"), LLabel(_("Unknown map"), "game") }),
        VBox({ -- game options
          LCheckBox(_("Fog of war"), function(dd)
            ServerSetupState.FogOfWar = bool2int(dd:isMarked())
            NetworkServerResyncClients()
          end):id("option_fow"),
          HBox({
            LLabel(_("Terrain:"), "game"),
            LDropDown({_("Hidden"), _("Known"), _("Explored")}, function(dd) 
              ServerSetupState.RevealMap = dd:getSelected()
              NetworkServerResyncClients()
            end):id("option_terrain"):withWidth(120),
          }),
          HBox({
            LLabel(_("~<Your Race:~>"), "game"),
            LDropDown({_("Map Default"), _("Human"), _("Orc")}, function(dd)
              if isserver then
                ServerSetupState.Race[0] = dd:getSelected() - 1
                NetworkServerResyncClients()
              else
                LocalSetupState.Race[Hosts[NetLocalHostsSlot].PlyNr] = race:getSelected() - 1
              end
            end):id("option_race"):withWidth(120),
          }),
          HBox({
            LLabel(_("Units:"), "game"),
            LDropDown({_("Map Default"), _("One Peasant Only")}, function(dd)
              ServerSetupState.UnitsOption = dd:getSelected() - 1
              NetworkServerResyncClients()
            end):id("option_units"):withWidth(120),
          }),
          HBox({
            LLabel(_("Resources:"), "game"),
            LDropDown({_("Map Default"), _("Low"), _("Medium"), _("High")}, function(dd)
              ServerSetupState.ResourcesOption = dd:getSelected() - 1
              NetworkServerResyncClients()
            end):id("option_resources"):withWidth(120),
          }),
          LCheckBox(_("Dedicated AI Server:"), function (dd)
            if dd:isMarked() then
              -- 2 == closed
              ServerSetupState.CompOpt[0] = 2
            else
              -- 0 == available
              ServerSetupState.CompOpt[0] = 0
            end
            NetworkServerResyncClients()
          end):id("option_dedicated_ai_server"),
        }), -- end of game options
      }), -- end of game properties
      LFiller(),
      VBox(playerTable):withPadding(2, true),
      LFiller(),
    }), -- end of screen split
    LFiller(),
    HBox({
      LFiller(),
      LButton(_("Cancel (~<Esc~>)"), "escape", function()
        InitGameSettings()
        if isserver then
          OnlineService.stopadvertising()
        else
          NetworkDetachFromServer()
        end
        menu:stop()
      end),
      LCheckBox(_("~!Ready"), function(dd)
        LocalSetupState.Ready[NetLocalHostsSlot] = bool2int(dd:isMarked())
      end):id("checkbox_ready"),
      LButton(_("~!Start Game"), "s", function()
        NetworkServerStartGame()
        NetworkGamePrepareGameSettings()
        RunMap(map)
        menu:stop()
      end):id("button_start_game"),
      LFiller(),
    }),
  }):withPadding(4, true))

  for i=1,PlayerMax do
     if menu.player_team[i] then
        menu.player_team[i]:setList(teams)
     end
  end

  menu.button_start_game:setEnabled(false)
  if isserver then
    menu.checkbox_ready:setEnabled(false)
    menu.checkbox_ready:setVisible(false)
  else
    for i=1,PlayerMax do
      if menu.player_dropdown[i] then
        menu.player_dropdown[i]:setEnabled(false)
      end
    end
    menu.checkbox_ready:setVisible(true)
    menu.button_start_game:setVisible(false)
    menu.option_fow:setEnabled(false)
    menu.option_terrain:setEnabled(false)
    menu.option_units:setEnabled(false)
    menu.option_resources:setEnabled(false)
    menu.option_dedicated_ai_server:setEnabled(false)
  end

  function menu:updateOptions()
    self.option_fow:setMarked(int2bool(ServerSetupState.FogOfWar))
    self.option_terrain:setSelected(ServerSetupState.RevealMap)
    self.option_units:setSelected(ServerSetupState.UnitsOption + 1)
    self.option_resources:setSelected(ServerSetupState.ResourcesOption + 1)
    self.option_dedicated_ai_server:setMarked(ServerSetupState.CompOpt[0] == 2) -- host is closed
    updatePlayerListFromHosts()
  end

  return menu
end

function RunServerMultiGameMenu(map, description, numplayers, options)
  local menu = CreateOnlineLobby(map, numplayers, true)

  NetworkMapName = map

  options = options or {fow = 1}
  local optRace = options.race
  local optResources = options.resources
  local optUnits = options.units
  local optAiPlayerNum = options.aiPlayerNum or 0
  local optAutostartNum = options.autostartNum
  local optDedicated = options.dedicated

  NetworkInitServerConnect(numplayers)

  ServerSetupState.FogOfWar = 1
  ServerSetupState.Opponents = optAiPlayerNum

  local startIn = -10
  local function updateStartButton(ready)
    local readyplayers = 1
    for i=2,PlayerMax do
      if ServerSetupState.Ready[i-1] == 1 then
        readyplayers = readyplayers + 1
      end
    end
    if startIn < -1 then
      startIn = startIn + 1
    else
      if optDedicated then
        menu.option_dedicated_ai_server:setMarked(true)
        menu.option_dedicated_ai_server.callback(menu.option_dedicated_ai_server)
        optDedicated = false
      elseif (optRace == "human" or optRace == "Human") then
        menu.option_race:setSelected(1)
        menu.option_race.callback(menu.option_race)
        optRace = ""
      elseif (optRace == "orc" or optRace == "Orc") then
        menu.option_race:setSelected(2)
        menu.option_race.callback(menu.option_race)
        optRace = ""
      elseif (optResources == "low" or optResources == "Low") then
        menu.option_resources:setSelected(1)
        menu.option_resources.callback(menu.option_resources)
        optResources = ""
      elseif (optResources == "medium" or optResources == "Medium") then
        menu.option_resources:setSelected(2)
        menu.option_resources.callback(menu.option_resources)
        optResources = ""
      elseif (optResources == "high" or optResources == "High") then
        menu.option_resources:setSelected(3)
        menu.option_resources.callback(menu.option_resources)
        optResources = ""
      elseif (optUnits == "1") then
        menu.option_units:setSelected(1)
        menu.option_units.callback(menu.option_units)
        optUnits= ""
      elseif (options.fow == 0) then
        menu.option_fow:setMarked(options.fow)
        menu.option_fow.callback(options.fow)
        options.fow = -1
      elseif options.revealmap and options.revealmap ~= -1 then
        menu.option_terrain:setSelected(options.revealmap)
        menu.option_terrain.callback(menu.option_terrain)
        options.revealmap = -1
      elseif (optAutostartNum) then
        if (optAutostartNum <= readyplayers) then
          if (startIn < 0) then
            startIn = 100
          else
            startIn = startIn - 1
            if (startIn == 0) then
              menu.button_start_game.callback()
            end
          end
          menu.button_start_game:setEnabled(true)
          menu.button_start_game:setCaption("Start in " .. startIn / 2)
          print("Starting in " .. startIn / 2)
        end
      else
        menu.button_start_game:setEnabled(ready)
      end
    end
  end

  local function updateFromNetwork()
    local connected_players = 0
    local ready_players = 0
    local ai_players = 0

    for i=0,PlayerMax-1 do
      if Hosts[i].PlyName ~= "" then
        if i > 0 then
          connected_players = connected_players + 1
        end
        local label = menu.player_status[Hosts[i].PlyNr + 1]
        if i == 0 then
          label:setCaption(_("Creator"))
        elseif ServerSetupState.Ready[i] == 1 then
          ready_players = ready_players + 1
          label:setCaption(_("Ready"))
        else
          label:setCaption(_("Preparing"))
        end
        label:adjustSize()
      end

      local dd = menu.player_dropdown[i + 1]
      if dd then
        local selIdx = dd:getSelected()
        if selIdx < 2 then
          menu.player_status[i + 1]:setCaption("")
          if selIdx == 1 then
            ai_players = ai_players + 1
          end
        end
      end
    end
    -- only 1 player in this map or
    -- all connected players are ready or
    -- we could play against AI
    return numplayers == 1 or (connected_players > 0 and ready_players == connected_players) or (connected_players == 0 and ai_players > 0)
  end

  local counter = 10
  local listener = LuaActionListener(function(s)
    if counter == 0 then
      counter = 10
      menu:updateOptions()
      updateStartButton(updateFromNetwork())
    else
      counter = counter - 1
    end
  end)
  menu:addLogicCallback(listener)
  OnlineService.startadvertising()

  menu:run()
end

function RunCreateMultiGameMenu(s)
  local menu
  local map = "No Map"
  local description = "No map"
  local mapfile = "maps/skirmish/multiplayer/(2)timeless-isle.smp.gz"
  local playerCount = 1
  local sx = Video.Width / 20
  local sy = Video.Height / 20

  menu = WarMenu(_("Create MultiPlayer game"))

  menu:writeText(_("File:"), sx, sy*3+30)
  local maptext = menu:writeText(mapfile, sx+50, sy*3+30)
  menu:writeText(_("Players:"), sx, sy*3+50)
  local players = menu:writeText(playerCount, sx+70, sy*3+50)
  menu:writeText(_("Description:"), sx, sy*3+70)
  local descr = menu:writeText(description, sx+20, sy*3+90)

  local OldPresentMap = PresentMap
  PresentMap = function(desc, nplayers, w, h, id)
    description = desc
    descr:setCaption(desc)
    descr:adjustSize()
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
    players:setCaption(""..playerCount)
    players:adjustSize()
    oldDefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16)
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

  local createFunc = function(s)
     if (browser:getSelected() < 0) then
        return
     end
     RunServerMultiGameMenu(mapfile, description, playerCount)
     menu:stop()
  end

  browser:setDoubleClickAction(createFunc)

  menu:addFullButton(_("~!Create Game"), "c", sx, sy*11, createFunc)

  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", sx, sy*12+25,
    function() menu:stop() end)

  menu:run()
  PresentMap = OldPresentMap
  DefinePlayerTypes = oldDefinePlayerTypes
end

function RunMultiPlayerGameMenu(s)
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = ((Video.Height - 480) / 2) - 70

  local function FixMusic()
    wargus.playlist = { "music/Orc Briefing" .. wargus.music_extension }
    SetDefaultRaceView()

    if not (IsMusicPlaying()) then
      PlayMusic("music/Orc Briefing" .. wargus.music_extension)
    end
  end
  InitGameSettings()
  InitNetwork1()

  menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"]) -- Copyright information.

  menu:addLabel(_("~<Multiplayer Network Game~>"), offx + 640/2 + 12, offy + 192)

  menu:writeText(_("Nickname :"), 208 + offx, 248 + offy)
  local nick = menu:addTextInputField(GetLocalPlayerName(), offx + 298, 244 + offy)

  menu:writeText(_("Password :"), 208 + offx, 248 + offy + 28)
  local pass = menu:addTextInputField("", offx + 298, 244 + offy + 28)
  pass:setPassword(true);

  local loginBtn = menu:addHalfButton(_("Go ~!Online"), "o", 208 + offx, 298 + (36 * 0) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        wc2.preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      if string.len(pass:getText()) == 0 then
         ErrorMenu("Please enter your password")
      else
         OnlineService.setup({ ShowError = ErrorMenu })
         OnlineService.connect(wc2.preferences.OnlineServer, wc2.preferences.OnlinePort)
         OnlineService.login(nick:getText(), pass:getText())
         RunOnlineMenu()
      end
  end)
  local signupLabel = menu:addLabel(
     _("Sign up"),
     loginBtn:getWidth() + loginBtn:getX() + loginBtn:getWidth() / 2,
     loginBtn:getY() + loginBtn:getHeight() / 4)
  local signUpCb = function(evt, btn, cnt)
     if evt == "mouseClick" then

        local signUpMenu
        signUpMenu = WarMenuWithLayout(panel(1), VBox({
              LFiller(),

              VBox({
                    LFiller(),
                    "Choose a username and password to sign up to",
                    wc2.preferences.OnlineServer,
                    "Don't choose a password you are using elsewhere.",
                    "The password is sent to the server using the same",
                    "method that the original Battle.net clients used,",
                    "which can be broken. The server will store your",
                    "username, password hash, last login time, last IP,",
                    "and game stats (wins/losses/draws. By signing up,",
                    "you agree to this data storage.",
                    LFiller(),
              }),

              HBox({
                    "Username:",
                    LTextInputField(""):expanding():id("newnick"),
              }):withPadding(5),

              HBox({
                    "Password:",
                    LTextInputField(""):expanding():id("newpass"),
              }):withPadding(5),

              HBox({
                    LFiller(),
                    LButton("~!OK", "o", function()
                               if string.len(signUpMenu.newpass:getText()) == 0 then
                                  ErrorMenu("Please choose a password for the new account")
                               else
                                  if signUpMenu.newnick:getText() ~= GetLocalPlayerName() then
                                     SetLocalPlayerName(signUpMenu.newnick:getText())
                                     nick:setText(signUpMenu.newnick:getText())
                                     wc2.preferences.PlayerName = signUpMenu.newnick:getText()
                                     SavePreferences()
                                  end
                                  OnlineService.setup({ ShowError = ErrorMenu })
                                  OnlineService.connect(wc2.preferences.OnlineServer, wc2.preferences.OnlinePort)
                                  OnlineService.signup(signUpMenu.newnick:getText(), signUpMenu.newpass:getText())
                                  RunOnlineMenu()
                               end
                               signUpMenu:stop()
                    end),
                    LButton("~!Cancel", "c", function()
                               signUpMenu:stop()
                    end),
                    LFiller()
              }):withPadding(5),

              LFiller(),

        }):withPadding(5))

        signUpMenu:run()
     end
  end
  local signUpListener = LuaActionListener(signUpCb)
  signupLabel:addMouseListener(signUpListener)

  menu:addFullButton(_("~!Join Local Game"), "j", 208 + offx, 298 + (36 * 2) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        wc2.preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunJoinIpMenu()
      FixMusic()
    end)
  menu:addFullButton(_("~!Create Game"), "c", 208 + offx, 298 + (36 * 3) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        wc2.preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunCreateMultiGameMenu()
      FixMusic()
    end)

  menu:addFullButton(_("Previous Menu (~<Esc~>)"), "escape", 208 + offx, 298 + (36 * 5) + offy,
    function() menu:stop() end)

  menu:run()

  ExitNetwork1()
end

function RunOnlineMenu()
   local counter = 0

   local menu = WarMenu("Online")

   local margin = 10
   local btnHeight = 36
   local listWidth = 100

   local userLabel = menu:addLabel(_("Users"), margin, margin, nil, false)
   local userList = {}
   local users = menu:addImageListBox(
      userLabel:getX(),
      userLabel:getY() + userLabel:getHeight(),
      listWidth,
      Video.Height / 4,
      userList
   )

   local friendLabel = menu:addLabel(_("Friends"), margin, users:getY() + users:getHeight() + margin, nil, false)
   local friends = menu:addImageListBox(
      friendLabel:getX(),
      friendLabel:getY() + friendLabel:getHeight(),
      users:getWidth(),
      users:getHeight(),
      {}
   )

   local channelLabel = menu:addLabel(_("Channels"), margin, friends:getY() + friends:getHeight() + margin, nil, false)
   local channelList = {}
   local selectedChannelIdx = -1
   local channels = menu:addImageListBox(
      channelLabel:getX(),
      channelLabel:getY() + channelLabel:getHeight(),
      users:getWidth(),
      users:getHeight(),
      channelList
   )
   local channelSelectCb = function()
      OnlineService.joinchannel(channelList[channels:getSelected() + 1])
   end
   channels:setActionCallback(channelSelectCb)

   local gamesLabel = menu:addLabel(_("Games"), users:getX() + users:getWidth() + margin, userLabel:getY(), nil, false)
   local gamesObjectList = {}
   local gamesList = {}
   local games = menu:addImageListBox(
      gamesLabel:getX(),
      gamesLabel:getY() + gamesLabel:getHeight(),
      Video.Width - (users:getX() + users:getWidth() + margin) - margin,
      100,
      gamesList
   )

   local messageLabel = menu:addLabel(_("Chat"), games:getX(), games:getY() + games:getHeight() + margin, nil, false)
   local messageList = {}
   local messages = menu:addListBox(
      messageLabel:getX(),
      messageLabel:getY() + messageLabel:getHeight(),
      games:getWidth(),
      Video.Height - (margin + messageLabel:getY() + messageLabel:getHeight()) - (btnHeight * 2) - (margin * 2),
      messageList
   )

   local input = menu:addTextInputField(
      "",
      messages:getX(),
      messages:getY() + messages:getHeight() + margin,
      messages:getWidth()
   )
   input:setActionCallback(function()
         counter = 1
         OnlineService.sendmessage(input:getText())
         input:setText("")
   end)
   local createGame = menu:addFullButton(
      _("~!Create Game"),
      "c",
      input:getX(),
      input:getY() + btnHeight,
      function()
         RunCreateMultiGameMenu()
      end
   )
   createGame:setWidth((Video.Width - margin * 4 - listWidth) / 3)
   local joinGame = menu:addFullButton(
      _("~!Join Game"),
      "j",
      createGame:getX() + createGame:getWidth() + margin,
      createGame:getY(),
      function()
         local selectedGame = gamesObjectList[games:getSelected() + 1]
         if selectedGame then
            local ip, port
            for k, v in string.gmatch(selectedGame.Host, "([0-9\.]+):(%d+)") do
               ip = k
               port = tonumber(v)
            end
            print("Attempting to join " .. ip .. ":" .. port)
            NetworkSetupServerAddress(ip, port)
            NetworkInitClientConnect()
            OnlineService.punchNAT(selectedGame.Creator)
            if (RunJoiningGameMenu() ~= 0) then
               -- connect failed, don't leave this menu
               return
            end
         else
            ErrorMenu(_("No game selected"))
         end
      end
   )
   joinGame:setWidth(createGame:getWidth())
   local prevMenuBtn = menu:addFullButton(
      _("~!Previous Menu"),
      "p",
      joinGame:getX() + joinGame:getWidth() + margin,
      joinGame:getY(),
      function()
         OnlineService.disconnect()
         menu:stop()
      end
   )
   prevMenuBtn:setWidth(createGame:getWidth())

   local AddUser = function(name)
      table.insert(userList, name)
      users:setList(userList)
      menu:setDirty(true)
   end

   local ClearUsers = function()
      for i,v in ipairs(userList) do
         table.remove(userList, i)
      end
      users:setList(userList)
      menu:setDirty(true)
   end

   local RemoveUser = function(name)
      for i,v in ipairs(userList) do
         if v == name then
            table.remove(userList, i)
         end
      end
      users:setList(userList)
      menu:setDirty(true)
   end

   local SetFriends = function(...)
      friendsList = {}
      for i,v in ipairs(arg) do
         table.insert(friendsList, v.Name .. "|" .. v.Product .. "(" .. v.Status .. ")")
      end
      friends:setList(friendsList)
      menu:setDirty(true)
   end

   local SetGames = function(...)
      gamesList = {}
      gamesObjectList = {}
      for i,game in ipairs(arg) do
         table.insert(gamesList, game.Map .. " " .. game.Creator .. ", type: " .. game.Type .. game.Settings .. ", slots: " .. game.MaxPlayers)
         table.insert(gamesObjectList, game)
      end
      games:setList(gamesList)
      menu:setDirty(true)
   end

   local SetChannels = function(...)
      channelList = {}
      for i,v in ipairs(arg) do
         table.insert(channelList, v)
      end
      channels:setList(channelList)
      channels:setSelected(selectedChannelIdx)
      menu:setDirty(true)
   end

   local SetActiveChannel = function(name)
      ClearUsers()
      local index = {}
      for k,v in pairs(channelList) do
         if v == name then
            selectedChannelIdx = k - 1
            return
         end
      end
      selectedChannelIdx = -1
   end

   local AddMessage = function(str, pre, suf)
      for line in string.gmatch(str, "([^".. string.char(10) .."]+)") do
        if pre and suf then
          table.insert(messageList, pre .. line .. suf)
        else
          table.insert(messageList, line)
        end
      end
      messages:setList(messageList)
      messages:scrollToBottom()
      menu:setDirty(true)
   end

   local ShowInfo = function(errmsg)
      AddMessage(errmsg, "~<", "~>")
   end

   local lastError = nil
   local ShowError = function(errmsg)
      AddMessage(errmsg, "~red~", "~>")
      lastError = errmsg
   end

   local ShowUserInfo = function(info)
      local s = {"UserInfo", string.char(10)}
      for k, v in pairs(info) do
         s[#s+1] = string.char(10)
         s[#s+1] = k
         s[#s+1] = ": "
         s[#s+1] = v
      end
      s = table.concat(s)
      ShowError(s)
   end

   OnlineService.setup({
         AddUser = AddUser,
         RemoveUser = RemoveUser,
         SetFriends = SetFriends,
         SetGames = SetGames,
         SetChannels = SetChannels,
         SetActiveChannel = SetActiveChannel,
         ShowChat = AddMessage,
         ShowInfo = ShowInfo,
         ShowError = ShowError,
         ShowUserInfo = ShowUserInfo
   })

   -- check if we're connected, exit this menu if connection fails
   local goonline = true
   local timer = 10
   function checkLogin()
      if goonline then
         if timer > 0 then
            timer = timer - 1
         else
            timer = 10
            result = OnlineService.status()
            if result == "connected" then
               goonline = false
            elseif result ~= "connecting" then
               if lastError then
                  ErrorMenu(lastError)
               else
                  ErrorMenu(result)
               end
               menu:stop()
            end
         end
      end
  end
  local listener = LuaActionListener(function(s) checkLogin() end)
  menu:addLogicCallback(listener)

  menu:run()
end
