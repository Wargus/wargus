SetPlayerData(GetThisPlayer(), "RaceName", "orc")

-- Global useful objects for menus  ----------
dark = Color(38, 38, 78)
clear = Color(200, 200, 120)
black = Color(0, 0, 0)

bckground = CGraphic:New("ui/Menu_background_without_title.png")
bckground:Load()
bckground:Resize(Video.Width, Video.Height)
backgroundWidget = ImageWidget(bckground)

g_hbln = CGraphic:New("ui/human/widgets/button-large-normal.png")
g_hbln:Load()
g_hblp = CGraphic:New("ui/human/widgets/button-large-pressed.png")
g_hblp:Load()
g_hblg = CGraphic:New("ui/human/widgets/button-large-grayed.png")
g_hblg:Load()

g_hbsn = CGraphic:New("ui/human/widgets/button-small-normal.png")
g_hbsn:Load()
g_hbsp = CGraphic:New("ui/human/widgets/button-small-pressed.png")
g_hbsp:Load()
g_hbsg = CGraphic:New("ui/human/widgets/button-small-grayed.png")
g_hbsg:Load()

g_obln = CGraphic:New("ui/orc/widgets/button-large-normal.png")
g_obln:Load()
g_oblp = CGraphic:New("ui/orc/widgets/button-large-pressed.png")
g_oblp:Load()
g_oblg = CGraphic:New("ui/orc/widgets/button-large-grayed.png")
g_oblg:Load()

g_obsn = CGraphic:New("ui/orc/widgets/button-small-normal.png")
g_obsn:Load()
g_obsp = CGraphic:New("ui/orc/widgets/button-small-pressed.png")
g_obsp:Load()
g_obsg = CGraphic:New("ui/orc/widgets/button-small-grayed.png")
g_obsg:Load()

local hpanels = {
  "ui/human/panel_1.png",
  "ui/human/panel_2.png",
  "ui/human/panel_3.png",
  "ui/human/panel_4.png",
  "ui/human/panel_5.png"
}

local opanels = {
  "ui/orc/panel_1.png",
  "ui/orc/panel_2.png",
  "ui/orc/panel_3.png",
  "ui/orc/panel_4.png",
  "ui/orc/panel_5.png"
}

function panel(n)
  if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
    return hpanels[n]
  else
    return opanels[n]
  end
end



function AddMenuHelpers(menu)
  function menu:addCentered(widget, x, y)
    self:add(widget, x - widget:getWidth() / 2, y)
  end

  function menu:addLabel(text, x, y, font, center)
    local label = Label(text)
    if (font == nil) then font = Fonts["large"] end
    label:setFont(font)
    label:adjustSize()
    if (center == nil or center == true) then -- center text by default
      x = x - label:getWidth() / 2
    end
    self:add(label, x, y)

    return label
  end

  function menu:writeText(text, x, y)
    return self:addLabel(text, x, y, Fonts["game"], false)
  end

  function menu:writeLargeText(text, x, y)
    return self:addLabel(text, x, y, Fonts["large"], false)
  end

  function menu:addButton(caption, hotkey, x, y, callback, size)
    local b = ButtonWidget(caption)
    b:setHotKey(hotkey)
    b:setActionCallback(callback)
    if (size == nil) then size = {200, 24} end
    b:setSize(size[1], size[2])
    b:setBackgroundColor(dark)
    b:setBaseColor(dark)
    self:add(b, x, y)
    return b
  end

  function menu:addImageButton(caption, hotkey, x, y, callback)
    local b = ImageButton(caption)
    b:setHotKey(hotkey)
    b:setActionCallback(callback)
    self:add(b, x, y)
    return b
  end

  function menu:addFullButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
      b:setNormalImage(g_hbln)
      b:setPressedImage(g_hblp)
      b:setDisabledImage(g_hblg)
    else
      b:setNormalImage(g_obln)
      b:setPressedImage(g_oblp)
      b:setDisabledImage(g_oblg)
    end
    b:setSize(224, 28)
    return b
  end

  function menu:addHalfButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
      b:setNormalImage(g_hbsn)
      b:setPressedImage(g_hbsp)
      b:setDisabledImage(g_hbsg)
    else
      b:setNormalImage(g_obsn)
      b:setPressedImage(g_obsp)
      b:setDisabledImage(g_obsg)
    end
    b:setSize(106, 28)
    return b
  end

  function menu:addSlider(min, max, w, h, x, y, callback)
    local b = Slider(min, max)
    b:setBaseColor(dark)
    b:setForegroundColor(clear)
    b:setBackgroundColor(clear)
    b:setSize(w, h)
    b:setActionCallback(function(s) callback(b, s) end)
    self:add(b, x, y)
    return b
  end

  function menu:addListBox(x, y, w, h, list)
    local bq = ListBoxWidget(w, h)
    bq:setList(list)
    bq:setBaseColor(black)
    bq:setForegroundColor(clear)
    bq:setBackgroundColor(dark)
    bq:setFont(Fonts["game"])
    self:add(bq, x, y)   
    bq.itemslist = list
    return bq
  end

  function menu:addBrowser(path, filter, x, y, w, h, default)
    -- Create a list of all dirs and files in a directory
    local function listfiles(path)
      local dirlist = {}
      local i
      local f
      local u = 1

      local dirs = ListDirsInDirectory(path)
      for i,f in dirs do
        dirlist[u] = f .. "/"
        u = u + 1
      end

      local fileslist = ListFilesInDirectory(path)
      for i,f in fileslist do
        if (string.find(f, filter)) then
          dirlist[u] = f
          u = u + 1
        end
      end

      return dirlist
    end

    local bq = self:addListBox(x, y, w, h, {})
    bq.origpath = path
    bq.actioncb = nil

    -- The directory changed, update the list
    local function updatelist()
      bq.itemslist = listfiles(bq.path)
      if (bq.path ~= bq.origpath) then
        table.insert(bq.itemslist, 1, "../")
      end
      bq:setList(bq.itemslist)
    end

    -- Change to the default directory and select the default file
    if (default == nil) then
      bq.path = path
      updatelist()
    else
      local i
      for i=string.len(default)-1,1,-1 do
        if (string.sub(default, i, i) == "/") then
          bq.path = string.sub(default, 1, i)
          updatelist()

          local f = string.sub(default, i + 1)
          for i=1,table.getn(bq.itemslist) do
            if (bq.itemslist[i] == f) then
              bq:setSelected(i - 1)
            end
          end
          break
        end
      end
    end

    function bq:getSelectedItem()
      if (self:getSelected() < 0) then
        return self.itemslist[1]
      end
      return self.itemslist[self:getSelected() + 1]
    end

    -- If a directory was clicked change dirs
    -- Otherwise call the user's callback
    local function cb(s)
      local f = bq:getSelectedItem()
      if (f == "../") then
        local i
        for i=string.len(bq.path)-1,1,-1 do
          if (string.sub(bq.path, i, i) == "/") then
            bq.path = string.sub(bq.path, 1, i)
            updatelist()
            break
          end
        end
      elseif (string.sub(f, string.len(f)) == '/') then
        bq.path = bq.path .. f
        updatelist()
      else
        if (bq.actioncb ~= nil) then
          bq:actioncb(s)
        end
      end
    end
    bq:setActionCallback(cb)

    bq.oldSetActionCallback = bq.setActionCallback
    function bq:setActionCallback(cb)
      bq.actioncb = cb
    end

    return bq
  end

  function menu:addCheckBox(caption, x, y, callback)
    local b = CheckBox(caption)
    b:setBaseColor(clear)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
    b:setActionCallback(function(s) callback(b, s) end)
    b:setFont(Fonts["game"])
    self:add(b, x, y)
    return b
  end

  function menu:addRadioButton(caption, group, x, y, callback)
    local b = RadioButton(caption, group)
    b:setBaseColor(dark)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
    b:setActionCallback(callback)
    self:add(b, x, y)
    return b
  end

  function menu:addDropDown(list, x, y, callback)
    local dd = DropDownWidget()
    dd:setFont(Fonts["game"])
    dd:setList(list)
    dd:setActionCallback(function(s) callback(dd, s) end)
    dd:setBaseColor(dark)
    dd:setForegroundColor(clear)
    dd:setBackgroundColor(dark)
    self:add(dd, x, y)
    return dd
  end

  function menu:addTextInputField(text, x, y, w)
    local b = TextField(text)
    b:setActionCallback(function() end) --FIXME: remove this?
    b:setFont(Fonts["game"])
    b:setBaseColor(clear)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
    if (w == nil) then w = 100 end
    b:setSize(w, 18)
    self:add(b, x, y)
    return b
  end
end

function WarMenu(title, background, resize)
  local menu
  local exitButton
  local bg
  local bgg

  menu = MenuScreen()

  if background == nil then
    bg = backgroundWidget
  else
    bgg = CGraphic:New(background)
    bgg:Load()
    if (resize == nil or resize == true) then
      bgg:Resize(Video.Width, Video.Height)
    end
    bg = ImageWidget(bgg)
  end
  menu:add(bg, 0, 0)

  AddMenuHelpers(menu)

  if title then
    menu:addLabel(title, Video.Width / 2, Video.Height / 20, Fonts["large"])
  end

  return menu
end

-- Default configurations -------
Widget:setGlobalFont(Fonts["large"])


DefaultObjectives = {"-Destroy the enemy"}
Objectives = DefaultObjectives


-- Define the different menus ----------

function InitGameSettings()
  GameSettings.NetGameType = 1
  for i=0,PlayerMax-1 do
    GameSettings.Presets[i].Race = -1
    GameSettings.Presets[i].Team = -1
    GameSettings.Presets[i].Type = -1
  end
  GameSettings.Resources = -1
  GameSettings.NumUnits = -1
  GameSettings.Opponents = -1
  GameSettings.Terrain = -1
  GameSettings.GameType = -1
  GameSettings.NoFogOfWar = false
  GameSettings.RevealMap = 0
end
InitGameSettings()

function RunMap(map, objective, fow, revealmap)
  if objective == nil then
    Objectives = DefaultObjectives
  else
    Objectives = objective
  end
  loop = true
  while (loop) do
    InitGameVariables()
    if fow ~= nil then
      SetFogOfWar(fow)
    end
    if revealmap == true then
       RevealMap()
    end
    StartMap(map)
    if GameResult ~= GameRestart then
      loop = false
    end
  end
  RunResultsMenu(s)

  InitGameSettings()
  SetPlayerData(GetThisPlayer(), "RaceName", "orc")
end

mapname = "maps/default.smp.gz"
local mapinfo = {
  playertypes = {nil, nil, nil, nil, nil, nil, nil, nil},
  description = "",
  nplayers = 1,
  w = 32,
  h = 32,
  id = 0
}

function GetMapInfo(mapname)
  local OldDefinePlayerTypes = DefinePlayerTypes
  local OldPresentMap = PresentMap

  function DefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8)
    mapinfo.playertypes[1] = p1
    mapinfo.playertypes[2] = p2
    mapinfo.playertypes[3] = p3
    mapinfo.playertypes[4] = p4
    mapinfo.playertypes[5] = p5
    mapinfo.playertypes[6] = p6
    mapinfo.playertypes[7] = p7
    mapinfo.playertypes[8] = p8

    mapinfo.nplayers = 0
    for i=0,8 do
      local t = mapinfo.playertypes[i]
      if (t == "person" or t == "computer") then
        mapinfo.nplayers = mapinfo.nplayers + 1
      end
    end
  end

  function PresentMap(description, nplayers, w, h, id)
    mapinfo.description = description
    -- nplayers includes rescue-passive and rescue-active
    -- calculate the real nplayers in DefinePlayerTypes
    --mapinfo.nplayers = nplayers
    mapinfo.w = w
    mapinfo.h = h
    mapinfo.id = id
  end

  Load(mapname)

  DefinePlayerTypes = OldDefinePlayerTypes
  PresentMap = OldPresentMap
end

function RunSelectScenarioMenu()
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Select scenario", 176, 8)

  local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$",
    24, 140, 300, 108, mapname)

  local l = menu:addLabel(browser:getSelectedItem(), 24, 260, Fonts["game"], false)

  local function cb(s)
    l:setCaption(browser:getSelectedItem())
    l:adjustSize()
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!OK", "o", 48, 318,
    function()
      mapname = browser.path .. l:getCaption()
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", 198, 318,
    function() menu:stop() end)

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

  menu:addLabel("Scenario:", offx + 16, offy + 360, Fonts["game"], false)
  mapl = menu:addLabel(string.sub(mapname, 6), offx + 16, offy + 360 + 24, Fonts["game"], false)
  descriptionl = menu:addLabel("descriptionl", offx + 16 + 70, offy + 360, Fonts["game"], false)

  menu:addLabel("~<Single Player Game Setup~>", offx + 640/2 + 12, offy + 192)
  menu:addFullButton("S~!elect Scenario", "e", offx + 640 - 224 - 16, offy + 360 + 36*0,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)
  menu:addFullButton("~!Start Game", "s", offx + 640 - 224 - 16, offy + 360 + 36*1,
    function()
      GameSettings.Presets[0].Race = race:getSelected()
      GameSettings.Resources = resources:getSelected()
      GameSettings.Opponents = opponents:getSelected()
      GameSettings.NumUnits = numunits:getSelected()
      GameSettings.GameType = gametype:getSelected() - 1
      RunMap(mapname)
      menu:stop()
    end)
  menu:addFullButton("~!Cancel Game", "c", offx + 640 - 224 - 16, offy + 360 + 36*2, function() menu:stop() end)

  menu:addLabel("~<Your Race:~>", offx + 40, offy + (10 + 240) - 20, Fonts["game"], false)
  race = menu:addDropDown({"Map Default", "Human", "Orc"}, offx + 40, offy + 10 + 240,
    function(dd) end)
  race:setSize(152, 20)

  menu:addLabel("~<Resources:~>", offx + 220, offy + (10 + 240) - 20, Fonts["game"], false)
  resources = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, offx + 220, offy + 10 + 240,
    function(dd) end)
  resources:setSize(152, 20)

  menu:addLabel("~<Units:~>", offx + 640 - 224 - 16, offy + (10 + 240) - 20, Fonts["game"], false)
  numunits = menu:addDropDown({"Map Default", "One Peasant Only"}, offx + 640 - 224 - 16, offy + 10 + 240,
    function(dd) end)
  numunits:setSize(190, 20)

  local opponents_list = {"Map Default", "1 Opponent", "2 Opponents",
    "3 Opponents", "4 Opponents", "5 Opponents", "6 Opponents", "7 Opponents"}

  menu:addLabel("~<Opponents:~>", offx + 40, offy + (10 + 300) - 20, Fonts["game"], false)
  opponents = menu:addDropDown(opponents_list, offx + 40, offy + 10 + 300,
    function(dd) end)
  opponents:setSize(152, 20)

  menu:addLabel("~<Game Type:~>", offx + 220, offy + (10 + 300) - 20, Fonts["game"], false)
  gametype = menu:addDropDown({"Use map settings", "Melee", "Free for all", "Top vs bottom", "Left vs right", "Man vs Machine"}, offx + 220, offy + 10 + 300,
    function(dd) end)
  gametype:setSize(152, 20)

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

function RunMultiPlayerGameMenu()
end

function BuildProgramStartMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addFullButton("~!Single Player Game", "s", offx + 208, offy + 104 + 36*0,
    function() RunSinglePlayerGameMenu(); menu:stop(1) end)
  menu:addFullButton("~!Multi Player Game", "m", offx + 208, offy + 104 + 36*1,
    function() RunMultiPlayerGameMenu(); menu:stop(1) end)
  menu:addFullButton("~!Campaign Game", "c", offx + 208, offy + 104 + 36*2,
    function() RunCampaignGameMenu(); menu:stop(1) end)
  menu:addFullButton("~!Load Game", "l", offx + 208, offy + 104 + 36*3,
    function() RunLoadGameMenu(); menu:stop(1) end)
  menu:addFullButton("~!Replay Game", "r", offx + 208, offy + 104 + 36*4,
    function() RunReplayGameMenu(); menu:stop(1) end)
  menu:addFullButton("~!Options", "o", offx + 208, offy + 104 + 36*5,
    function() RunOptionsMenu(); menu:stop(1) end)
  menu:addFullButton("S~!how Credits", "h", offx + 208, offy + 104 + 36*6, RunShowCreditsMenu)

  menu:addFullButton("E~!xit Program", "x", offx + 208, offy + 104 + 36*8,
    function() menu:stop() end)

  return menu:run()
end

LoadGameFile = nil

function RunProgramStartMenu()
  local continue = 1

  while continue == 1 do
    if (LoadGameFile ~= nil) then
      LoadGame(LoadGameFile)
    end
    continue = BuildProgramStartMenu(menu)
  end
end


Load("scripts/menus/campaign.lua")
Load("scripts/menus/load.lua")
Load("scripts/menus/save.lua")
Load("scripts/menus/replay.lua")
Load("scripts/menus/options.lua")
Load("scripts/menus/credits.lua")
Load("scripts/menus/game.lua")
Load("scripts/menus/help.lua")
Load("scripts/menus/objectives.lua")
Load("scripts/menus/endscenario.lua")
Load("scripts/menus/diplomacy.lua")
Load("scripts/menus/results.lua")


RunProgramStartMenu()

