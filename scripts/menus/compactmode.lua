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
--      compactmode.lua
--
--      (c) Copyright 2011 by Kyran Jackson
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

function RunSelectScenarioMenu()
  buttonStatut = 0

    local menu = WarMenu(nil, panel(5), false)
    menu:setSize(Video.Width, Video.Height)
    -- Should offset.
    menu:setPosition(0, 0)
    menu:setDrawMenusUnder(true)
  
    menu:addLabel("Select Scenario", Video.Width/2, 15)

    local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$",
      Video.Width/40, Video.Height/5, 306, Video.Height/2)

    local l = menu:addLabel(browser:getSelectedItem(), 24, 260, Fonts["game"], false)

    local function cb(s)
      l:setCaption(browser:getSelectedItem())
      l:adjustSize()
    end
    browser:setActionCallback(cb)

    menu:addHalfButton("~!OK", "o", Video.Width/6 - 3, Video.Height - 33,
      function()
        local cap = l:getCaption()

        if (browser:getSelected() < 0) then
          return
        end
        buttonStatut = 1
        mapname = browser.path .. cap
        menu:stop()
      end)
    menu:addHalfButton("~!Cancel", "c", Video.Width/2 + 3, Video.Height - 33,
      function() buttonStatut = 2; menu:stop() end)

  menu:run()
end


function RunSinglePlayerGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local d
  local race
  local resources
  local opponents
  local numunits
  local gametype
  local mapl
  local descriptionl

  -- Compact Mode
	
  menu:addLabel("Scenario:", offx + 16, offy + 360, Fonts["game"], false)
  mapl = menu:addLabel(string.sub(mapname, 6), offx + 16, offy + 360 + 24, Fonts["game"], false)
  descriptionl = menu:addLabel("descriptionl", offx + 16 + 70, offy + 360, Fonts["game"], false)

  menu:addLabel("~<Singleplayer~>", offx + 640/2 + 12 + 60, offy + 192 - 30)
  menu:addHalfButton("~!Start", "s", 0, 30 + 55 + 28*4,
    function()
      GameSettings.Presets[0].Race = race:getSelected()
      GameSettings.Resources = resources:getSelected()
      -- GameSettings.Opponents = opponents:getSelected()
      GameSettings.NumUnits = numunits:getSelected()
      GameSettings.GameType = gametype:getSelected() - 1
      RunMap(mapname)
      menu:stop()
    end)
  menu:addHalfButton("M~!ap", "a", 0 + 107*1, 30 + 55 + 28*4,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)
  menu:addHalfButton("~!Cancel", "c", 0 + 107*2, 30 + 55 + 28*4, function() menu:stop() end)
  
  menu:addLabel("~<Race:~>", 10, 30 + 55 + 28*0, Fonts["game"], false)
  race = menu:addDropDown({"Map Default", "Human", "Orc"}, 95 , 28 + 55 + 28*0,
    function(dd) end)
  race:setSize(142, 20)

  menu:addLabel("~<Resources:~>", 10, 30+ 55 + 28*1, Fonts["game"], false)
  resources = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, 95, 28 + 55 + 28*1,
    function(dd) end)
  resources:setSize(142, 20)

  menu:addLabel("~<Units:~>", 10, 30 + 55 + 28*2, Fonts["game"], false)
  numunits = menu:addDropDown({"Map Default", "One Peasant"}, 95, 28 + 55 + 28*2,
    function(dd) end)
  numunits:setSize(142, 20)

    --local opponents_list = {"Map Default", "1 Opponent", "2 Opponents",
    --  "3 Opponents", "4 Opponents", "5 Opponents", "6 Opponents", "7 Opponents"}
  
    --menu:addLabel("~<Opponents:~>", 10, 30 + 30 + 30*3, Fonts["game"], false)
    --opponents = menu:addDropDown(opponents_list, 95, 28 + 30 + 30*3,
    --  function(dd) end)
    --opponents:setSize(142, 20)

  menu:addLabel("~<Game Type:~>", 10, 30 + 55 + 28*3, Fonts["game"], false)
  gametype = menu:addDropDown({"Map Default", "Melee", "Free for All", "Top vs Bottom", "Left vs Right", "Man vs Machine"}, 95, 28 + 55 + 28*3,
    function(dd) end)
  gametype:setSize(142, 20)

  function MapChanged()
    mapl:setCaption(string.sub(mapname, 6))
    mapl:adjustSize()

    descriptionl:setCaption(mapinfo.description ..
      " (" .. mapinfo.w .. " x " .. mapinfo.h .. ")")
    descriptionl:adjustSize()

    local o = {}
    for i=1,mapinfo.nplayers do
      table.insert(o, opponents_list[i])
    end
    opponents:setList(o)
  end

  GetMapInfo(mapname)
  MapChanged()

  menu:run()
end

function AddLoadGameItems(menu)
  menu:addLabel("Load Game", Video.Width/2, 15)
  local browser = menu:addBrowser("~save", "^.*%.sav%.?g?z?$",
    Video.Width/40, Video.Height/5, 306, Video.Height/2)

  menu:addHalfButton("~!Load", "l", Video.Width/6 - 3, Video.Height - 33,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      LoadGameFile = "~save/" .. browser:getSelectedItem()
      if (menu.ingame) then
        StopGame(GameNoResult)
        menu:stopAll()
      else
        menu:stop()
      end
    end)
  menu:addHalfButton("~!Cancel", "c", Video.Width/2 + 3, Video.Height - 33, function() menu:stop() end)
end

function RunLoadGameMenu()
  local menu = WarMenu(nil, panel(3), false)
  menu:setSize(Video.Width, Video.Height)
  -- Should offset.
  menu:setPosition(0, 0)
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = false
  menu:run()
end

function RunReplayGameMenu()
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(Video.Width, Video.Height)
  -- Should offset.
  menu:setPosition(0, 0)
  menu:setDrawMenusUnder(true)
  
  menu:addLabel("Replay Game", Video.Width/2, 15)
  local browser = menu:addBrowser("~logs/", "%.log%.?g?z?$",
    Video.Width/40, Video.Height/5, 306, Video.Height/2)
	
  local reveal = menu:addCheckBox("Reveal Map", Video.Width/40, Video.Height - 60, function() end)
  
  menu:addHalfButton("~!OK", "o", Video.Width/6 - 3, Video.Height - 33,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      InitGameVariables()
      StartReplay("~logs/" .. browser:getSelectedItem(), reveal:isMarked())
      InitGameSettings()
      SetPlayerData(GetThisPlayer(), "RaceName", "orc")
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", Video.Width/2 + 3, Video.Height - 33, function() menu:stop() end)
  
  menu:run()
end

function RunMultiPlayerGameMenu(s)
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local nick

  local function FixMusic()
    wargus.playlist = { "music/Orc Briefing.ogg" }
    SetPlayerData(GetThisPlayer(), "RaceName", "orc")

    if not (IsMusicPlaying()) then
        PlayMusic("music/Orc Briefing.ogg")
    end
  end

  InitGameSettings()
  InitNetwork1()

  menu:addLabel("~<Multiplayer~>", offx + 640/2 + 12 + 60, offy + 192 - 30)

  menu:writeText(_("Nickname :"), 208 + offx, 264 + offy - 50)
  nick = menu:addTextInputField(GetLocalPlayerName(), offx + 298, 260 + offy - 50)

  menu:addFullButton("~!Join Game", "j", 208 + offx, 320 + (36 * 0) + offy - 80,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunJoinIpMenu()
      FixMusic()
    end)
  menu:addFullButton("~!Create Game", "c", 208 + offx, 320 + (36 * 1) + offy - 80,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunCreateMultiGameMenu()
      FixMusic()
    end)

  menu:addFullButton("~!Previous Menu", "p", 208 + offx, 320 + (36 * 2) + offy - 80,
    function() menu:stop() end)

  menu:run()

  ExitNetwork1()
end