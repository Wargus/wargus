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

hpanel1 = "ui/human/panel_1.png"
hpanel2 = "ui/human/panel_2.png"
hpanel3 = "ui/human/panel_3.png"
hpanel4 = "ui/human/panel_4.png"
hpanel5 = "ui/human/panel_5.png"

opanel1 = "ui/orc/panel_1.png"
opanel2 = "ui/orc/panel_2.png"
opanel3 = "ui/orc/panel_3.png"
opanel4 = "ui/orc/panel_4.png"
opanel5 = "ui/orc/panel_5.png"

hvictory = "ui/human/victory.png"
hdefeat = "ui/human/defeat.png"
ovictory = "ui/orc/victory.png"
odefeat = "ui/orc/defeat.png"


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
    b:setNormalImage(g_hbln)
    b:setPressedImage(g_hblp)
    b:setDisabledImage(g_hblg)
    b:setSize(224, 28)
    return b
  end

  function menu:addHalfButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    b:setNormalImage(g_hbsn)
    b:setPressedImage(g_hbsp)
    b:setDisabledImage(g_hbsg)
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

function WarMenu(title, background)
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
    bgg:Resize(Video.Width, Video.Height)
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


-- Define the different menus ----------

function RunResultsMenu()
  local menu
  local background = hdefeat
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local result

  if GameResult == GameVictory then
    result = "Victory !"
    background = hvictory
  elseif GameResult == GameDraw then
    result = "Draw !"
  elseif GameResult == GameDefeat then
    result = "Defeat !"
    background = hdefeat
  else 
    return
  end

  menu = WarMenu("Results", background)
  menu:writeLargeText(result, sx*6, sy*5)

  menu:writeText("Player", sx*3, sy*7)
  menu:writeText("Units", sx*6, sy*7)
  menu:writeText("Buildings", sx*8, sy*7)
  menu:writeText("Kills", sx*10, sy*7)
  menu:writeText("Razings", sx*12, sy*7)

  for i=0,7 do
    if (GetPlayerData(i, "TotalUnits") > 0 ) then
      menu:writeText(i .. " ".. GetPlayerData(i, "Name"), sx*3, sy*(8+i))
      menu:writeText(GetPlayerData(i, "TotalUnits"), sx*6, sy*(8+i))
      menu:writeText(GetPlayerData(i, "TotalBuildings"), sx*8, sy*(8+i))
      menu:writeText(GetPlayerData(i, "TotalKills"), sx*10, sy*(8+i))
      menu:writeText(GetPlayerData(i, "TotalRazings"), sx*12, sy*(8+i))     
    end
  end

  menu:run()
end

function RunMap(map, objective, fow, revealmap)
  if objective == nil then
    current_objective = default_objective
  else
    current_objective = objective
  end
  loop = true
  while (loop) do
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
end

mapname = "maps/default.smp.gz"

function RunSelectScenarioMenu()
  local menu = WarMenu(nil, hpanel5)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)

  menu:addLabel("Select scenario", 176, 8)

  local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$",
    24, 140, 300, 108, mapname)

  local l = menu:addLabel(browser:getSelectedItem(), 24, 260, Fonts["game"], false)

  local function cb(s)
    l:setCaption(browser:getSelectedItem())
    l:adjustSize()
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("OK", 0, 48, 318,
    function()
      mapname = browser.path .. l:getCaption()
      menu:stop()
    end)
  menu:addHalfButton("Cancel", 0, 198, 318,
    function() menu:stop() end)

  menu:run()
end

difficulty = 5
mapresources = 5
startingresources = 5

function RunSinglePlayerGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local d

  menu:addLabel("Scenario:", offx + 16, offy + 380, Fonts["game"], false)
  mapl = menu:addLabel(string.sub(mapname, 6), offx + 16, offy + 380 + 24, Fonts["game"], false)

  menu:addLabel("~<Single Player Game Setup~>", offx + 640/2 + 12, offy + 192)
  menu:addFullButton("S~!elect Scenario", "e", offx + 640 - 224 - 16, offy + 360 + 36*0,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        mapl:setCaption(string.sub(mapname, 6))
        mapl:adjustSize()
      end
    end)
  menu:addFullButton("~!Start Game", "s", offx + 640 - 224 - 16, offy + 360 + 36*1, function() RunMap(mapname) end)
  menu:addFullButton("~!Cancel Game", "c", offx + 640 - 224 - 16, offy + 360 + 36*2, function() menu:stop() end)

  menu:addLabel("~<Your Race:~>", offx + 40, offy + (10 + 240) - 20, Fonts["game"], false)
  d = menu:addDropDown({"Map Default", "Human", "Orc"}, offx + 40, offy + 10 + 240,
    function(dd) end)
  d:setSize(152, 20)

  menu:addLabel("~<Resources:~>", offx + 220, offy + (10 + 240) - 20, Fonts["game"], false)
  d = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, offx + 220, offy + 10 + 240,
    function(dd) end)
  d:setSize(152, 20)

  menu:addLabel("~<Units:~>", offx + 640 - 224 - 16, offy + (10 + 240) - 20, Fonts["game"], false)
  d = menu:addDropDown({"Map Default", "One Peasant Only"}, offx + 640 - 224 - 16, offy + 10 + 240,
    function(dd) end)
  d:setSize(190, 20)

  menu:addLabel("~<Opponents:~>", offx + 40, offy + (10 + 300) - 20, Fonts["game"], false)
  d = menu:addDropDown({"Map Default", "1 Opponent", "2 Opponents", "3 Opponents", "4 Opponents", "5 Opponents", "6 Opponents", "7 Opponents"}, offx + 40, offy + 10 + 300,
    function(dd) end)
  d:setSize(152, 20)

  menu:addLabel("~<Game Type:~>", offx + 220, offy + (10 + 300) - 20, Fonts["game"], false)
  d = menu:addDropDown({"Use map settings", "Melee", "Free for all", "Top vs bottom", "Left vs right", "Man vs Machine"}, offx + 220, offy + 10 + 300,
    function(dd) end)
  d:setSize(152, 20)

  menu:run()

--[[
  local menu
  local maptext
  local descr
  local numplayers = 2
  local players
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local map = "islandwar.smp"

  menu = WarMenu(_("Start Game"))

  menu:writeLargeText(_("Map"), sx, sy*3)
  menu:writeText(_("File:"), sx, sy*3+30)
  maptext = menu:writeText(map, sx+50, sy*3+30)
  menu:writeText(_("Players:"), sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText(_("Description:"), sx, sy*3+70)
  descr = menu:writeText(description, sx+20, sy*3+90)

  local fow = menu:addCheckBox(_("Fog of war"), sx, sy*3+120, function() end)
  fow:setMarked(preferences.FogOfWar)
  local revealmap = menu:addCheckBox(_("Reveal map"), sx, sy*3+150, function() end)
  
  menu:writeText(_("Difficulty:"), sx, sy*11)
  menu:addDropDown({_("easy"), _("normal"), _("hard")}, sx + 90, sy*11 + 7,
    function(dd) difficulty = (5 - dd:getSelected()*2) end)
  menu:writeText(_("Map richness:"), sx, sy*11+25)
  menu:addDropDown({_("high"), _("normal"), _("low")}, sx + 110, sy*11+25 + 7,
    function(dd) mapresources = (5 - dd:getSelected()*2) end)
  menu:writeText(_("Starting resources:"), sx, sy*11+50)
  menu:addDropDown({_("high"), _("normal"), _("low")}, sx + 150, sy*11+50 + 7,
    function(dd) startingresources = (5 - dd:getSelected()*2) end)

  local OldPresentMap = PresentMap
  PresentMap = function(description, nplayers, w, h, id)
    print(description)
    numplayers = nplayers
    players:setCaption(""..nplayers)
    descr:setCaption(description)
    OldPresentMap(description, nplayers, w, h, id)
  end
 
  Load("maps/"..map)
  local browser = menu:addBrowser("maps/", "^.*%.smp$",  sx*10, sy*2+20, sx*8, sy*11)
  local function cb(s)
    print(browser:getSelectedItem())
    maptext:setCaption(browser:getSelectedItem())
    Load("maps/" .. browser:getSelectedItem())
    map = browser:getSelectedItem()
  end
  browser:setActionCallback(cb)

  local function startgamebutton(s)
    print("Starting map -------")
    RunMap("maps/" .. map, nil, fow:isMarked(), revealmap:isMarked())
    PresentMap = OldPresentMap
    menu:stop()
  end
  menu:addButton(_("Start"), 0,  sx * 11,  sy*14, startgamebutton)

  menu:run()
  PresentMap = OldPresentMap
]]
end

function RunMultiPlayerGameMenu()
end

function RunCampaignGameMenu()
end

function RunReplayGameMenu()
--[[
  local menu
  menu = WarMenu(_("Show a Replay"))

  local browser = menu:addBrowser("~logs/", ".log$", 300, 100, 300, 200)

  local reveal = menu:addCheckBox(_("Reveal map"), 100, 250, function() end)

  function startreplaybutton(s)
    print("Starting map -------")
    StartReplay("~logs/" .. browser:getSelectedItem(), reveal:isMarked())
    menu:stop()
  end

  menu:addButton(_("~!Start"), "s", 100, 300, startreplaybutton)

  menu:run()
]]
end


function RunLoadGameMenu()
--[[
  local menu
  local b

  menu = WarMenu(_("Load Game"))
  local browser = menu:addBrowser("~save", ".sav.gz$", 300, 100, 300, 200)
    function startgamebutton(s)
      print("Starting saved game")
      currentCampaign = nil
      loop = true
      while (loop) do
        StartSavedGame("~save/" .. browser:getSelectedItem())
        if (GameResult ~= GameRestart) then
          loop = false
        end
      end
      RunResultsMenu()
      if currentCampaign ~= nil then
         if GameResult == GameVictory then
            position = position + 1
         elseif GameResult == GameDefeat then
            position = position
         else
            currentCampaign = nil
            return
         end
         RunCampaign(currentCampaign)
      end
    menu:stop()
  end
  menu:addButton(_("Start"), 0, 100, 300, startgamebutton)

  menu:run()
]]
end

function SetVideoSize(width, height)
  Video:ResizeScreen(width, height)
  bckground:Resize(Video.Width, Video.Height)
  backgroundWidget = ImageWidget(bckground)
  Load("scripts/ui.lua")
  preferences.VideoWidth = Video.Width
  preferences.VideoHeight = Video.Height
  SavePreferences()
end

function BuildOptionsMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 352) / 2
  local offy = (Video.Height - 352) / 2
  local b

  menu:addLabel("Global Options", offx + 176, offy + 11)
  menu:addLabel("Video Resolution", offx + 16, offy + 44, Fonts["game"], false)

  b = menu:addCheckBox("640 x 480", offx + 16, offy + 65 + 26*0,
    function() SetVideoSize(640, 480) menu:stop(1) end)
  if (Video.Width == 640) then b:setMarked(true) end
  b = menu:addCheckBox("800 x 600", offx + 16, offy + 65 + 26*1,
    function() SetVideoSize(800, 600) menu:stop(1) end)
  if (Video.Width == 800) then b:setMarked(true) end
  b = menu:addCheckBox("1024 x 768", offx + 16, offy + 65 + 26*2,
    function() SetVideoSize(1024, 768) menu:stop(1) end)
  if (Video.Width == 1024) then b:setMarked(true) end
  b = menu:addCheckBox("1280 x 960", offx + 16, offy + 65 + 26*3,
    function() SetVideoSize(1280, 960) menu:stop(1) end)
  if (Video.Width == 1280) then b:setMarked(true) end
  b = menu:addCheckBox("1600 x 1200", offx + 16, offy + 65 + 26*4,
    function() SetVideoSize(1600, 960) menu:stop(1) end)
  if (Video.Width == 1600) then b:setMarked(true) end

  b = menu:addCheckBox("Fullscreen", offx + 17, offy + 65 + 26*5,
    function()
      ToggleFullScreen()
      preferences.VideoFullScreen = Video.FullScreen
      SavePreferences()
    end)
  b:setMarked(Video.FullScreen)

  menu:addHalfButton("~!OK", "o", offx + 123, offy + 309, function() menu:stop() end)

  return menu:run()
end

function RunOptionsMenu()
  local continue = 1
  while (continue == 1) do
    continue = BuildOptionsMenu()
  end
end

function RunEditorMenu()
--[[
  local menu
  menu = WarMenu(_("Editor"))

  local browser = menu:addBrowser("maps/", "^.*%.smp$", 300, 100, 300, 200)
  function starteditorbutton(s)
    UI.MenuButton:SetCallback(function() RunEditorIngameMenu() end)
    HandleCommandKey = HandleEditorIngameCommandKey
    StartEditor("maps/" .. browser:getSelectedItem())
    UI.MenuButton:SetCallback(function() RunGameMenu() end)
    HandleCommandKey = HandleIngameCommandKey
    menu:stop()
  end

  menu:addButton(_("Start Editor"), 0, 100, 300, starteditorbutton)

  menu:run()
]]
end

function BuildProgramStartMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addFullButton("~!Single Player Game", "s", offx + 208, offy + 104 + 36*0, RunSinglePlayerGameMenu)
  menu:addFullButton("~!Multi Player Game", "m", offx + 208, offy + 104 + 36*1, RunMultiPlayerGameMenu)
  menu:addFullButton("~!Campaign Game", "c", offx + 208, offy + 104 + 36*2, RunCampaignGameMenu)
  menu:addFullButton("~!Load Game", "l", offx + 208, offy + 104 + 36*3, RunLoadGameMenu)
  menu:addFullButton("~!Replay Game", "r", offx + 208, offy + 104 + 36*4, RunReplayGameMenu)
  menu:addFullButton("~!Options", "o", offx + 208, offy + 104 + 36*5,
    function() RunOptionsMenu(); menu:stop(1) end)
  menu:addFullButton("~!Editor", "e", offx + 208, offy + 104 + 36*6, RunEditorMenu)
  menu:addFullButton("S~!how Credits", "h", offx + 208, offy + 104 + 36*7, RunShowCreditsMenu)

  menu:addFullButton("E~!xit Program", "x", offx + 208, offy + 104 + 36*8,
    function() menu:stop() end)

  return menu:run()
end

function RunProgramStartMenu()
  local continue = 1

  while continue == 1 do
    continue = BuildProgramStartMenu(menu)
  end
end

Load("scripts/menus/credits.lua")
Load("scripts/menus/game.lua")
Load("scripts/menus/help.lua")
Load("scripts/menus/endscenario.lua")
Load("scripts/menus/options.lua")
Load("scripts/menus/diplomacy.lua")

RunProgramStartMenu()

