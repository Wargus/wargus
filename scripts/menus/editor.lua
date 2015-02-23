
--  Menu for new map to edit
local function RunEditorNewMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local tilesets = { "summer", "swamp", "wasteland", "winter"}
  local mapSizes = {"32", "64", "96", "128", "256"}

  menu:addLabel("Map description :", offx + 208, offy + 104 + 32 * 0, Fonts["game"], false)
  local mapDescription = menu:addTextInputField("", offx + 208, offy + 104 + 32 * 1, 200)
  menu:addLabel("TileSet : ", offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  local dropDownTileset = menu:addDropDown(tilesets, offx + 208 + 60, offy + 104 + 32 * 2, function() end)

  menu:addLabel("Size :", offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)
  local mapSizex = menu:addDropDown(mapSizes, offx + 208 + 50, offy + 104 + 32 * 3, function() end)
  mapSizex:setWidth(50)
  menu:addLabel("x", offx + 208 + 110, offy + 104 + 32 * 3, Fonts["game"], false)
  local mapSizey = menu:addDropDown(mapSizes, offx + 208 + 125, offy + 104 + 32 * 3, function() end)
  mapSizey:setWidth(50)

  menu:addFullButton("~!New map", "n", offx + 208, offy + 104 + 36 * 5,
    function()
      -- TODO : check value
      Map.Info.Description = mapDescription:getText()
      Map.Info.MapWidth = mapSizes[1 + mapSizex:getSelected()]
      Map.Info.MapHeight = mapSizes[1 + mapSizey:getSelected()]
      LoadTileModels("scripts/tilesets/" .. tilesets[1 + dropDownTileset:getSelected()] .. ".lua")
      menu:stop()
      StartEditor(nil)
      RunEditorMenu()
    end)
  menu:addFullButton("~!Cancel", "c", offx + 208, offy + 104 + 36 * 6, function() menu:stop(1); RunEditorMenu() end)
  return menu:run()
end

-- Menu for loading map to edit
local function RunEditorLoadMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local labelMapName
  local labelDescription
  local labelNbPlayer
  local labelMapSize

  -- update label content
  local function MapChanged()
    labelMapName:setCaption(_("File      : ") .. string.sub(mapname, 6))
    labelMapName:adjustSize()

    labelNbPlayer:setCaption(_("Players  : ") .. mapinfo.nplayers)
    labelNbPlayer:adjustSize()

    labelDescription:setCaption(_("Scenario : ") .. mapinfo.description)
    labelDescription:adjustSize()

    labelMapSize:setCaption(_("Size      : ") .. mapinfo.w .. " x " .. mapinfo.h)
    labelMapSize:adjustSize()
  end

  labelMapName = menu:addLabel("", offx + 208, offy + 104 + 36 * 0, Fonts["game"], false)
  labelDescription = menu:addLabel("", offx + 208, offy + 104 + 32 * 1, Fonts["game"], false)
  labelNbPlayer = menu:addLabel("", offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  labelMapSize = menu:addLabel("", offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)

  menu:addFullButton(_("~!Select map"), "s", offx + 208, offy + 104 + 36 * 4,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)

  menu:addFullButton(_("~!Edit map"), "e", offx + 208, offy + 104 + 36 * 5, function() menu:stop(); StartEditor(mapname); RunEditorMenu() end)
  menu:addFullButton(_("~!Cancel"), "c", offx + 208, offy + 104 + 36 * 6, function() menu:stop(1); RunEditorMenu() end)

  GetMapInfo(mapname)
  MapChanged()
  return menu:run()
end

-- root of the editor menu
function RunEditorMenu()
  wargus.playlist = { "music/Main Menu" .. wargus.music_extension }
  SetDefaultRaceView()

  if not (IsMusicPlaying()) then
    PlayMusic("music/Main Menu" .. wargus.music_extension)
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  if (wargus.tales == false) then
    menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"]) -- Copyright information.
  end
  
  menu:addLabel(_("~<Map Editor~>"), offx + 320, offy + 212 - 25)
  local buttonNewMap =
  menu:addFullButton(_("~!New map"), "n", offx + 208, offy + 104 + 36*3, function() RunEditorNewMapMenu(); menu:stop() end)
  menu:addFullButton(_("~!Load map"), "l", offx + 208, offy + 104 + 36*4, function() RunEditorLoadMapMenu(); menu:stop() end)
  menu:addFullButton(_("~!Cancel"), "c", offx + 208, offy + 104 + 36*5, function() menu:stop() end)
  return menu:run()
end

function RunEditorSaveMap(browser, name, menu)
  local saved = EditorSaveMap(browser.path .. name)
  if (saved == -1) then
    local confirm = WarGameMenu(panel(3))
    confirm:resize(300,120)
    confirm:addLabel(_("Cannot save map to file:"), 300 / 2, 11)
    confirm:addLabel(browser.path .. name, 300 / 2, 31)
    confirm:addHalfButton("~!OK", "o", 1 * (300 / 3), 120 - 16 - 27, function() confirm:stop() end)
    confirm:run(false)
  else
    UI.StatusLine:Set(_("Saved map to: ") .. browser.path .. name)
    menu:stop()
  end
end

--
--  Save map from the editor
--
function RunEditorSaveMenu()
  local menu = WarGameMenu(panel(3))

  menu:resize(384, 256)

  menu:addLabel(_("Save Game"), 384 / 2, 11)

  local t = menu:addTextInputField("game.smp",
    (384 - 300 - 18) / 2, 11 + 36, 318)

  local browser = menu:addBrowser("maps", ".smp.gz$",
    (384 - 300 - 18) / 2, 11 + 36 + 22, 318, 126)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton(_("~!Cancel"), "c", 384 - ((384 - 300 - 18) / 2) - 106, 256 - 16 - 27, function() menu:stop() end)
  menu:addHalfButton(_("~!Save"), "s", (384 - 300 - 18) / 2, 256 - 16 - 27,
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- strip .gz
      if (string.find(name, ".gz$") ~= nil) then
        name = string.sub(name, 1, string.len(name) - 3)
      end
      -- append .smp
      if (string.find(name, ".smp$") == nil) then
        name = name .. ".smp"
      end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      if (browser:exists(name .. ".gz")) then
        local confirm = WarGameMenu(panel(3))
        confirm:resize(300,120)
        confirm:addLabel(name, 300 / 2, 11)
        confirm:addLabel(_("File exists, are you sure ?"), 300 / 2, 31)
        confirm:addHalfButton("~!Yes", "y", 1 * (300 / 3) - 90, 120 - 16 - 27,
          function()
            confirm:stop()
            RunEditorSaveMap(browser, name, menu)
          end)
        confirm:addHalfButton("~!No", "n", 3 * (300 / 3) - 116, 120 - 16 - 27, function() confirm:stop() end)
        confirm:run(false)
      else
        RunEditorSaveMap(browser, name, menu)
      end
    end)

  menu:run(false)
end

--
--  Load a other map to edit.
--
function RunEditorLoadMenu()
-- TODO : fill this function correctly
--[[
--  RunSelectScenarioMenu()
--  if (buttonStatut == 1) then
--    EditorLoadMap(mapname)
--    StartEditor(mapname)
--  end
--]]
end

--
--  Change player properties from the editor
--
function RunEditorPlayerProperties()
-- TODO : manage edition.
-- TODO : find a correct background menu
  local menu = WarGameMenu()
  local sizeX = 500
  local sizeY = 480

  menu:resize(sizeX, sizeY)
  menu:addLabel(_("Players properties"), sizeX / 2, 11)

  local offxPlayer = 15
  local offxType = 70
  local offxRace = 170
  local offxAI = 285
  local offxGold = 375
  local offxLumber = 425
  local offxOil = 470

  local types = {"neutral", "nobody", "computer", "person", "rescue-passive", "rescue-active"}
  local racenames = {"human", "orc"}
  local ais = {"wc2-passive", "wc2-sea-attack", "wc2-land-attack", "wc2-air-attack"}

  menu:addLabel("#", 15, 36)
  menu:addLabel("Type", offxType, 36)
  menu:addLabel("Race", offxRace, 36)
  menu:addLabel("AI", offxAI, 36)
  menu:addLabel("Gold", offxGold, 36)
  menu:addLabel("Lumber", offxLumber, 36)
  menu:addLabel("Oil", offxOil, 36)

  local playersProp = {nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil}
  for i = 0, 14 do
    local playerLine = {
      type = nil,
      race = nil,
      ai = nil,
      gold = nil,
      lumber = nil,
      oil = nil
    }
    local offy_i = 36 + 25 * (i + 1)
    local index = i -- use for local function

    local function updateProp(ind)
      local b = (playersProp[1 + ind].type:getSelected() ~= 1) -- != nobody
      playersProp[1 + ind].race:setVisible(b)
      playersProp[1 + ind].ai:setVisible(b)
      playersProp[1 + ind].gold:setVisible(b)
      playersProp[1 + ind].lumber:setVisible(b)
      playersProp[1 + ind].oil:setVisible(b)
    end

    playersProp[1 + i] = playerLine

    menu:addLabel("p" .. (i + 1), offxPlayer, offy_i)

    playersProp[1 + i].type = menu:addDropDown(types, offxType - 40, offy_i, function() updateProp(index) end)
    playersProp[1 + i].type:setSelected(Map.Info.PlayerType[i] - 2)
    playersProp[1 + i].type:setWidth(115)

    playersProp[1 + i].race = menu:addDropDown(racenames, offxRace - 20, offy_i, function() end)
    playersProp[1 + i].race:setSelected(Players[i].Race)
    playersProp[1 + i].race:setWidth(65)

    playersProp[1 + i].ai = menu:addDropDown(ais, offxAI - 65, offy_i, function() end)
    for j = 0,3 do
      if (ais[1 + j] == Players[i].AiName) then playersProp[1 + i].ai:setSelected(j) end
    end
    playersProp[1 + i].ai:setWidth(130)

    playersProp[1 + i].gold = menu:addTextInputField(Players[i].Resources[1], offxGold - 20, offy_i, 40)
    playersProp[1 + i].lumber = menu:addTextInputField(Players[i].Resources[2], offxLumber - 20, offy_i, 40)
    playersProp[1 + i].oil = menu:addTextInputField(Players[i].Resources[3], offxOil - 20, offy_i, 40)
    updateProp(i)
  end

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 4) - 106 - 10, sizeY - 16 - 27,
    function()
      for i = 0, 14 do
        Map.Info.PlayerType[i] = playersProp[1 + i].type:getSelected() + 2
        Players[i].Race = playersProp[1 + i].race:getSelected()
        Players[i].AiName = ais[1 + playersProp[1 + i].ai:getSelected()]
        Players[i].Resources[1] = playersProp[1 + i].gold:getText()
        Players[i].Resources[2] = playersProp[1 + i].lumber:getText()
        Players[i].Resources[3] = playersProp[1 + i].oil:getText()
      end
      menu:stop()
    end)

  menu:addHalfButton(_("~!Cancel"), "c", 3 * (sizeX / 4) - 106 - 10, sizeY - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Change player properties from the editor
--
function RunEditorMapProperties()
-- TODO : manage edition of all properties.
  local menu = WarGameMenu(panel(3))

  local sizeX = 384
  local sizeY = 256

  menu:resize(sizeX, sizeY)
  menu:addLabel(_("Map properties"), sizeX / 2, 11)

  menu:addLabel(_("Map descritption : "), 45, 11 + 36, nil, false)
  local desc = menu:addTextInputField(Map.Info.Description, 15, 36 * 2, 350)

  menu:addLabel(_("Size    : ") .. Map.Info.MapWidth .. " x " .. Map.Info.MapHeight, 45, 36 * 3, nil, false)
--  menu:addLabel("Size : ", 15, 36 * 3, nil, false)
--  local sizeX = menu:addTextInputField(Map.Info.MapWidth, 75, 36 * 3, 50)
--  menu:addLabel(" x ", 130, 36 * 3, nil, false)
--  local sizeY = menu:addTextInputField(Map.Info.MapHeight, 160, 36 * 3, 50)

  menu:addLabel(_("Tileset : "), 45, 36 * 4, nil, false)

  local list = { _("Summer"), _("Swamp"), _("Wasteland"), _("Winter")}
  local dropDownTileset = menu:addDropDown(list, 130, 36 * 4, function() end)
  for i = 0,3 do
    if (list[1 + i] == Map.Tileset.Name) then dropDownTileset:setSelected(i)
    end
  end
  dropDownTileset:setEnabled(false) -- TODO : manage this properties

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 3) - 106 - 10, sizeY - 16 - 27,
    function()
      Map.Info.Description = desc:getText()
      -- TODO : Add others properties
      menu:stop()
    end
    )

  menu:addHalfButton(_("~!Cancel"), "c", 3 * (sizeX / 3) - 106 - 10, sizeY - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Main menu in editor.
--
function RunInEditorMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Editor Menu"), 128, 11)

  menu:addHalfButton(_("Save (~<F11~>)"), "f11", 16, 40, RunEditorSaveMenu)
  local buttonEditorLoad = -- To be removed when enabled.
  menu:addHalfButton(_("Load (~<F12~>)"), "f12", 16 + 118, 40, RunEditorLoadMenu)
  menu:addFullButton(_("Map Properties (~<F5~>)"), "f5", 16, 40 + 36 * 1, RunEditorMapProperties)
  menu:addFullButton(_("Player Properties (~<F6~>)"), "f6", 16, 40 + 36 * 2, RunEditorPlayerProperties)

  buttonEditorLoad:setEnabled(false) -- To be removed when enabled.

  menu:addFullButton(_("E~!xit to Menu"), "x", 16, 40 + 36 * 4,
    function() Editor.Running = EditorNotRunning; menu:stopAll(); end)
  menu:addFullButton(_("Return to Editor (~<Esc~>)"), "escape", 16, 288 - 40,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Function to edit unit properties in Editor
--
function EditUnitProperties()

  if (GetUnitUnderCursor() == nil) then
    return;
  end
  local menu = WarGameMenu(panel(1))
  local sizeX = 256
  local sizeY = 200 -- 288

  menu:resize(sizeX, sizeY)
  menu:addLabel(_("Unit properties"), sizeX / 2, 11)

  if (GetUnitUnderCursor().Type.GivesResource == 0) then
    menu:addLabel(_("Artificial Intelligence"), sizeX / 2, 11 + 36)
    local activeCheckBox = menu:addImageCheckBox("Active", 15, 11 + 72, offi, offi2, oni, oni2)
    activeCheckBox:setMarked(GetUnitUnderCursor().Active)

    menu:addHalfButton("~!Ok", "o", 24, sizeY - 40,
      function() GetUnitUnderCursor().Active = activeCheckBox:isMarked();  menu:stop() end)
  else
    local resourceName = {"gold", "lumber", "oil"}
    local resource = GetUnitUnderCursor().Type.GivesResource - 1
    menu:addLabel(_("Amount of ") .. resourceName[1 + resource] .. " :", 24, 11 + 36, nil, false)
	local resourceValue = menu:addTextInputField(GetUnitUnderCursor().ResourcesHeld, sizeX / 2 - 30, 11 + 36 * 2, 60)

    menu:addHalfButton("~!Ok", "o", 24, sizeY - 40,
      function() GetUnitUnderCursor().ResourcesHeld = resourceValue:getText();  menu:stop() end)
  end
  menu:addHalfButton(_("~!Cancel"), "c", 134, sizeY - 40,
    function() menu:stop() end)
  menu:run(false)
end
