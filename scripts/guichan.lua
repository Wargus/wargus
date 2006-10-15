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

function RunMap(map, objective, fow, revealmap)
  if objective == nil then
    Objectives = DefaultObjectives
  else
    Objectives = objective
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
  local menu = WarMenu(nil, hpanel5, false)
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
end

function RunMultiPlayerGameMenu()
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
  menu:addFullButton("S~!how Credits", "h", offx + 208, offy + 104 + 36*6, RunShowCreditsMenu)

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

