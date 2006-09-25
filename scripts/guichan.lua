-- Global useful objects for menus  ----------
dark = Color(38, 38, 78, 130)
clear = Color(200, 200, 120)
black = Color(0, 0, 0)

bckground = CGraphic:New("ui/Menu_background_without_title.png")
bckground:Load()
bckground:Resize(Video.Width, Video.Height)
backgroundWidget = ImageWidget(bckground)

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

  function menu:addFullButton(caption, hotkey, x, y, callback, size)
    -- FIXME: use ImageButton
    return self:addButton(caption, hotkey, x, y, callback, {224, 28})
  end

  function menu:addHalfButton(caption, hotkey, x, y, callback)
    -- FIXME: use ImageButton
    return self:addButton(caption, hotkey, x, y, callback, {106, 28})
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

  function menu:addBrowser(path, filter, x, y, w, h, lister)
    local mapslist = {}
    local u = 1
    local fileslist
    local i
    local f
    if lister == nil then
       lister = ListFilesInDirectory
    end
    fileslist = lister(path)
    for i,f in fileslist do
      if (string.find(f, filter)) then
        mapslist[u] = f
        u = u + 1
      end
    end

    local bq = self:addListBox(x, y, w, h, mapslist)
    bq.getSelectedItem = function(self)
      if (self:getSelected() < 0) then
        return self.itemslist[1]
      end
      return self.itemslist[self:getSelected() + 1]
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

function RunSubMenu(s)
  local menu
  menu = WarMenu(_("Empty sub menu"))
  menu:run()
end

function RunResultsMenu()
  local menu
  local background = "graphics/screens/menu.png"
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local result

  if GameResult == GameVictory then
    result = _("Victory !")
    background = "graphics/screens/victory.png"
  elseif GameResult == GameDraw then
    result = _("Draw !")
  elseif GameResult == GameDefeat then
    result = _("Defeat !")
    background = "graphics/screens/defeat.png"
  else 
    return
  end

  menu = WarMenu(_("Results"), background)
  menu:writeLargeText(result, sx*6, sy*5)

  menu:writeText(_("Player"), sx*3, sy*7)
  menu:writeText(_("Units"), sx*6, sy*7)
  menu:writeText(_("Buildings"), sx*8, sy*7)
  menu:writeText(_("Kills"), sx*10, sy*7)
  menu:writeText(_("Razings"), sx*12, sy*7)

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

difficulty = 5
mapresources = 5
startingresources = 5

function RunSinglePlayerGameMenu()
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

function RunShowCreditsMenu()
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


RunProgramStartMenu()

