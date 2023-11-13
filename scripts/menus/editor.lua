
--  Menu for new map to edit
local function RunEditorNewMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local tilesets = {
                    current         = "classic",
                    ["classic"]     = { "summer", "swamp", "wasteland", "winter"},
                    ["highgrounds"] = { "summer", "wasteland", "winter"}, -- swamp has no highground tilesets
                    ["labels"]      = {
                                        ["summer"]    = _("Summer"),
                                        ["swamp"]     = _("Swamp"),
                                        ["wasteland"] = _("Wasteland"),
                                        ["winter"]    = _("Winter")
                                      },
                    getLabels = function(self, list)
                      local result = {}
                      for i,tileset in ipairs(self[list]) do
                        table.insert(result, self["labels"][tileset])
                      end
                      return result
                    end
                   }

  local mapSizes = {"32", "64", "96", "128", "160", "192", "224", "256", "512", "1024"}
  local tilesetLabel = _("TileSet: ")
  local sizeLabel = _("Size:")

  menu:addLabel(_("Map description:"), offx + 208, offy + 104 + 32 * 0, Fonts["game"], false)
  local mapDescription = menu:addTextInputField("", offx + 208, offy + 104 + 32 * 1, 200)

  menu:addLabel(sizeLabel, offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  local mapSizex = menu:addDropDown(mapSizes, offx + 208 + CFont:Get("game"):Width(sizeLabel) + 10, offy + 104 + 32 * 2, function() end)
  mapSizex:setWidth(50)
  mapSizex:setSelected(3)
  menu:addLabel("x", offx + 208 + CFont:Get("game"):Width(sizeLabel) + 70, offy + 104 + 32 * 2, Fonts["game"], false)
  local mapSizey = menu:addDropDown(mapSizes, offx + 208 + CFont:Get("game"):Width(sizeLabel) + 90, offy + 104 + 32 * 2, function() end)
  mapSizey:setWidth(50)
  mapSizey:setSelected(3)

  menu:addLabel(tilesetLabel, offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)
  local dropDownTileset = menu:addDropDown(tilesets:getLabels("classic"), offx + 208 + CFont:Get("game"):Width(tilesetLabel) + 10, offy + 104 + 32 * 3, function() end)

  local highgroundsCheckBox = menu:addImageCheckBox(_("Enable highgrounds"), offx + 208 + 10, offy + 104 + 32 * 4, offi, offi2, oni, oni2, function() end)

  highgroundsCheckBox:setActionCallback( 
    function()
      local tilesetsList = {
        [true] = "highgrounds",
        [false] = "classic"
      }
      local newSet = tilesetsList[highgroundsCheckBox:isMarked()]
      local prevSet = tilesetsList[not highgroundsCheckBox:isMarked()]


      local selectedTileset = tilesets[prevSet][dropDownTileset:getSelected() + 1]
      
      dropDownTileset:setList(tilesets:getLabels(newSet))
      tilesets.current = newSet

      for i,v in ipairs(tilesets[newSet]) do
        if v == selectedTileset then
          dropDownTileset:setSelected(i - 1)
          return
        end
      end
      dropDownTileset:setSelected(0) -- defaul summer
    end
  )
    
  menu:addFullButton(_("~!New map"), "n", offx + 208, offy + 104 + 36 * 6,
    function()
      -- TODO : check value
      Map.Info.Description = mapDescription:getText()
      Map.Info.MapWidth = mapSizes[1 + mapSizex:getSelected()]
      Map.Info.MapHeight = mapSizes[1 + mapSizey:getSelected()]
      Map.Info.Preamble = ""
      Map.Info.Postamble = ""
      MapEnableHighgrounds(highgroundsCheckBox:isMarked())

      LoadTileModels("scripts/tilesets/" .. tilesets[tilesets.current][1 + dropDownTileset:getSelected()] .. ".lua")
      menu:stop()
      StartEditor(nil)
      RunEditorMenu()
    end)
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", offx + 208, offy + 104 + 36 * 7, function() menu:stop(1); RunEditorMenu() end)
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
    labelMapName:setCaption(_("File : ") .. string.sub(mapname, 6))
    labelMapName:adjustSize()

    labelNbPlayer:setCaption(_("Players : ") .. mapinfo.nplayers)
    labelNbPlayer:adjustSize()

    labelDescription:setCaption(_("Scenario : ") .. mapinfo.description)
    labelDescription:adjustSize()

    labelMapSize:setCaption(_("Size : ") .. mapinfo.w .. " x " .. mapinfo.h)
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
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", offx + 208, offy + 104 + 36 * 6, function() menu:stop(1); RunEditorMenu() end)

  GetMapInfo(mapname)
  MapChanged()
  return menu:run()
end

-- root of the editor menu
function RunEditorMenu()
  wargus.playlist = { "music/Orc Briefing" .. wargus.music_extension }
  SetDefaultRaceView()

  if not (IsMusicPlaying()) then
    PlayMusic("music/Orc Briefing" .. wargus.music_extension)
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"]) -- Copyright information.
  
  menu:addLabel(_("~<Map Editor~>"), offx + 320, offy + 212 - 25)
  local buttonNewMap =
  menu:addFullButton(_("~!New map"), "n", offx + 208, offy + 104 + 36*3, function() RunEditorNewMapMenu(); menu:stop() end)
  menu:addFullButton(_("~!Load map"), "l", offx + 208, offy + 104 + 36*4, function() RunEditorLoadMapMenu(); menu:stop() end)
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", offx + 208, offy + 104 + 36*5, function() menu:stop() end)
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
editorMapName = "game.smp"
function RunEditorSaveMenu()
  local menu = WarGameMenu(panel(3))

  menu:resize(384, 256)

  menu:addLabel(_("Save Game"), 384 / 2, 11)

  local t = menu:addTextInputField(editorMapName,
    (384 - 300 - 18) / 2, 11 + 36, 318)

  local browser = menu:addBrowser("maps", ".smp.gz$",
    (384 - 300 - 18) / 2, 11 + 36 + 22, 318, 126)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 384 - ((384 - 300 - 18) / 2) - 106, 256 - 16 - 27, function() menu:stop() end)
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
            editorMapName = name
          end)
        confirm:addHalfButton("~!No", "n", 3 * (300 / 3) - 116, 120 - 16 - 27, function() confirm:stop() end)
        confirm:run(false)
      else
        RunEditorSaveMap(browser, name, menu)
        editorMapName = name
      end
    end)

  menu:run(false)
end

function RunEditorResizeMap(browser, name, menu, w, h, x, y)
  local saved = EditorResizeMap(browser.path .. name, w, h, x, y)
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
function RunEditorEnlargeMenu()
  local menu = WarGameMenu(panel(3))

  menu:resize(384, 256)

  menu:addLabel(_("Save Resized Map"), 384 / 2, 11)

  menu:addLabel("Resize:", (384 - 300 - 18) / 2 - 106, 36)
  local sz = menu:addTextInputField("128x128+0+0", (384 - 300 - 18) / 2, 36)

  local t = menu:addTextInputField("game.smp",
    (384 - 300 - 18) / 2, 14 + 36, 318)

  local browser = menu:addBrowser("maps", ".smp.gz$",
    (384 - 300 - 18) / 2, 14 + 36 + 22, 318, 123)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 384 - ((384 - 300 - 18) / 2) - 106, 256 - 16 - 27, function() menu:stop() end)
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

      local newWidth = 0
      local newHeight = 0
      local xOffset = 0
      local yOffset = 0
      for w, h, x, y in string.gmatch(sz:getText(), "(%d+)x(%d+)+(%d+)+(%d+)") do
         newWidth = tonumber(w)
         newHeight = tonumber(h)
         xOffset = tonumber(x)
         yOffset = tonumber(y)
      end

      if (browser:exists(name .. ".gz")) then
        local confirm = WarGameMenu(panel(3))
        confirm:resize(300,120)
        confirm:addLabel(name, 300 / 2, 11)
        confirm:addLabel(_("File exists, are you sure ?"), 300 / 2, 31)
        confirm:addHalfButton("~!Yes", "y", 1 * (300 / 3) - 90, 120 - 16 - 27,
          function()
            confirm:stop()
            RunEditorResizeMap(browser, name, menu, newWidth, newHeight, xOffset, yOffset)
          end)
        confirm:addHalfButton("~!No", "n", 3 * (300 / 3) - 116, 120 - 16 - 27, function() confirm:stop() end)
        confirm:run(false)
      else
        RunEditorResizeMap(browser, name, menu, newWidth, newHeight, xOffset, yOffset)
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
  local sizeX = 500
  local sizeY = 480
  local menu = WarGameMenu(panel(5), 500, 480)

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
  local types1 = {_("Neutral"), _("Nobody"), _("Computer"), _("Person"), _("Rescue-passive"), _("Rescue-active")}
  local racenames = {"human", "orc"}
  local racenames1 = {_("Human"),_("Orc")}
  local aiList = {}
  for i,v in ipairs(AIStrategyTypes) do
    if i > 1 then
      aiList[#aiList + 1] = v
    end
  end

  menu:addLabel("#", 15, 36)
  menu:addLabel(_("Type"), offxType, 36)
  menu:addLabel(_("Race"), offxRace, 36)
  menu:addLabel(_("AI"), offxAI, 36)
  menu:addLabel(_("Gold"), offxGold, 36)
  menu:addLabel(_("Lumber"), offxLumber, 36)
  menu:addLabel(_("Oil"), offxOil, 36)

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

    playersProp[1 + i].type = menu:addDropDown(types1, offxType - 40, offy_i, function() updateProp(index) end)
    playersProp[1 + i].type:setSelected(Map.Info.PlayerType[i] - 2)
    playersProp[1 + i].type:setWidth(115)

    playersProp[1 + i].race = menu:addDropDown(racenames1, offxRace - 20, offy_i, function() end)
    playersProp[1 + i].race:setSelected(Players[i].Race)
    playersProp[1 + i].race:setWidth(65)

    playersProp[1 + i].ai = menu:addDropDown(aiList, offxAI - 65, offy_i, function() end)
    for j = 1,table.getn(aiList) do
      if (aiList[j] == Players[i].AiName) then playersProp[1 + i].ai:setSelected(j - 1) end
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
        Players[i].AiName = aiList[1 + playersProp[1 + i].ai:getSelected()]
        Players[i].Resources[1] = playersProp[1 + i].gold:getText()
        Players[i].Resources[2] = playersProp[1 + i].lumber:getText()
        Players[i].Resources[3] = playersProp[1 + i].oil:getText()
      end
      menu:stop()
    end)

  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 3 * (sizeX / 4) - 106 - 10, sizeY - 16 - 27,
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
  local dropDownTileset = menu:addDropDown(list, 145, 36 * 4, function() end)
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

  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 3 * (sizeX / 3) - 106 - 10, sizeY - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

function EditScript(filename)
   local contents
   local preamble = filename:sub(-#"preamble") == "preamble"
   if preamble then
      contents = Map.Info.Preamble
   else
      contents = Map.Info.Postamble
   end
   if contents == "" then
      if CanAccessFile(filename) then
         contents = GetFileContent(filename)
      else
         if preamble then
            contents = [[
-- Stratagus preamble script.
-- Use this script to set up anything that needs to run before the map is loaded.
-- Commonly, this would be things like patching functions that place units, define
-- players etc to modify the behaviour of these functions.

if Editor.Running == EditorNotRunning then
  -- Add code here
end
]]
         else
            contents = [[
-- Stratagus postamble script.
-- Use this script to set up anything after the map is loaded. Commonly this would
-- be adding triggers or customizing players, their alliances or similar things.

if Editor.Running == EditorNotRunning then
  -- Add code here
end
]]
         end
      end
   end
   local menu = WarMenu()
   local menubox = VBox({
         HBox({
               LFiller(),
               LLabel(filename),
               LFiller(),
         }):withPadding(5),
         LTextBox(contents):expanding():id("textbox"),
         HBox({
               LFiller(),
               LHalfButton(_("Accept"), nil, function()
                              if preamble then
                                 Map.Info.Preamble = menu.textbox:getText()
                              else
                                 Map.Info.Postamble = menu.textbox:getText()
                              end
               end),
               LHalfButton(_("Close"), nil, function() menu:stop() end),
         }):withPadding(5)
   }):withPadding(10)
   menubox:addWidgetTo(menu, true)
   menu:run()
end

--
--  Main menu in editor.
--
function RunInEditorMenu()
   local menu

   local function EditPreamble()
      EditScript(mapname .. ".preamble")
   end

   local function EditPostamble()
      EditScript(mapname .. ".postamble")
   end

   menu = WarMenuWithLayout(
      panel(1),
      VBox({
            HBox({
                  LFiller(),
                  LLabel(_("Editor Menu")),
                  LFiller(),
            }):withPadding(5),
            LFiller(),
            HBox({
                  LHalfButton(_("Help (~<F1~>)"), "f1", RunEditorHelpMenu),
                  LFiller(),
                  LHalfButton(_("Save (~<F11~>)"), "f11", RunEditorSaveMenu),
            }),
            LButton(_("Map Properties (~<F5~>)"), "f5", RunEditorMapProperties),
            LButton(_("Player Properties (~<F6~>)"), "f6", RunEditorPlayerProperties),
            LButton(_("~!Resize Map"), "r", RunEditorEnlargeMenu),
            HBox({
                  LHalfButton(_("Pr~!eamble"), "e", EditPreamble),
                  LFiller():expanding(),
                  LHalfButton(_("~!Postamble"), "p", EditPostamble)
            }),
            LLabel(""),
            LButton(_("E~!xit to Menu"), "x", function() Editor.Running = EditorNotRunning; menu:stopAll(); end),
            LButton(_("Return to Editor (~<Esc~>)"), "escape", function() menu:stop() end),
      }):withPadding({10, 8})
   )
   menu:run(false)
end

--
--  Function to edit unit properties in Editor
--
function EditUnitProperties(units)
  local function ShowResources(labelWidget, textWidget, selectedUnits)
    local resource = nil
    local amount = -1
    for i,unit in ipairs(selectedUnits) do
      local type = GetUnitVariable(unit, "Ident")
      local r = GetUnitTypeData(type, "GivesResource")
      if #r > 0 then
        local held = GetUnitVariable(unit, "ResourcesHeld")
        if not resource then
          resource = r
          amount = held
        elseif resource == r then
          if amount == -1 then
            amount = held
          else
            amount = "<different amounts>"
          end
        else
          resource = ""
          break
        end
      else
        resource = ""
        break
      end
    end
    if #resource > 0 then
      labelWidget:setCaption(resource)
      textWidget:setText(amount)
    else
      labelWidget:setCaption("no resource")
      textWidget:setText("n/a")
    end
  end

  local function ShowLifePercent(textWidget, selectedUnits)
    local pct = 0
    for i,unit in ipairs(selectedUnits) do
      local hp = GetUnitVariable(unit, "HitPoints")
      local maxHp = GetUnitTypeData(GetUnitVariable(unit, "Ident"), "HitPoints")
      local unitPct = math.floor((hp / maxHp) * 10) * 10
      if pct == 0 then
        pct = unitPct
      elseif pct ~= unitPct then
        pct = -1
      end
    end
    if pct >= 0 then
      textWidget:setText("" .. pct)
    else
      textWidget:setText("<different amounts>")
    end
  end

  local function ShowPlayer(playerDropdown, selectedUnits)
    playerDropdown:setSelected(GetUnitVariable(units[1], "Player"))
  end

  local function ShowRectangle(label, selectedUnits)
    local pos = {100000, 100000, 0, 0}
    for i,unit in ipairs(selectedUnits) do
      local posx = GetUnitVariable(unit, "PosX")
      local posy = GetUnitVariable(unit, "PosY")
      pos[1] = math.min(pos[1], posx)
      pos[2] = math.min(pos[2], posy)
      pos[3] = math.max(pos[3], posx)
      pos[4] = math.max(pos[4], posy)
    end
    label:setCaption("Units in {" .. pos[1] .. "," .. pos[2] .. "}, {" .. pos[3] .. "," .. pos[4] .. "}")
  end

  local menu = WarMenu(nil, panel(5), {Video.Width * 0.9, Video.Height * 0.6})

  local unitstrings = {}
  local function UpdateAll(selectedUnits)
    local prevSelectionIdx
    for i,unit in ipairs(units) do
      if selectedUnits[1] == unit then
        prevSelectionIdx = i - 1
      end
      unitstrings[i] = GetUnitVariable(unit, "Ident") .. " at " .. GetUnitVariable(unit, "PosX") .. "," .. GetUnitVariable(unit, "PosY") .. " from player " .. (GetUnitVariable(unit, "Player") + 1)
    end
    menu.unitlist:setList(unitstrings)
    if #selectedUnits == 1 then
      menu.unitlist:setSelected(prevSelectionIdx)
    end
    ShowResources(menu.resourceName, menu.resource, selectedUnits)
    ShowLifePercent(menu.lifepct, selectedUnits)
    ShowPlayer(menu.owner, selectedUnits)
    ShowRectangle(menu.location, selectedUnits)
  end

  local function GetSelectedUnits()
    local idx = menu.unitlist:getSelected() + 1
    local selectedUnits
    if idx == 0 then
      return units
    else
      return {units[idx]}
    end
  end

  local function LifeCallback()
    print("Life setting: " .. menu.lifepct:getText())
    local lifepct = tonumber(menu.lifepct:getText())
    print(lifepct)
    if lifepct then
      for i,unit in ipairs(GetSelectedUnits()) do
        SetUnitVariable(unit, "HitPoints", GetUnitTypeData(GetUnitVariable(unit, "Ident"), "HitPoints") * lifepct / 100)
      end
    end
  end

  local function ResourceCallback()
    print("Resource " .. menu.resourceName:getCaption() ..  " setting: " .. menu.resource:getText())
    resource = tonumber(menu.resource:getText())
    print(resource)
    if resource then
      for i,unit in ipairs(GetSelectedUnits()) do
        SetResourcesHeld(unit, resource)
      end
    end
  end

  local menubox = VBox({
    HBox({
      LListBox(300, 200, unitstrings, function(w) UpdateAll(GetSelectedUnits()) end):expanding():id("unitlist"),
      VBox({
        LLabel("Units in {n/a, n/a}, {n/a, n/a}"):id("location"),
        HBox({
          LLabel("Owner: "),
          LDropDown({"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"}, function (dd)
            for i,unit in ipairs(GetSelectedUnits()) do
              SetUnitVariable(unit, "Player", dd:getSelected())
            end
            UpdateAll(GetSelectedUnits())
          end):id("owner")
        }),
        HBox({
          LLabel("Life %: "),
          LTextInputField("n/a"):id("lifepct"),
        }),
        HBox({
          LLabel("No resource"):id("resourceName"),
          LTextInputField("n/a"):id("resource"),
        }),
      })
    }),
    HBox({
      LFiller(),
      LHalfButton(_("Ok"), nil, function()
        LifeCallback()
        ResourceCallback()
        menu:stop()
      end),
      LHalfButton(_("Close"), nil, function() menu:stop() end),
    }):withPadding(5)
  }):withPadding(10)
  menubox:addWidgetTo(menu, true)

  local lastIdx = 0
  menu:addLogicCallback(LuaActionListener(function()
    local selIdx = menu.unitlist:getSelected()
    if selIdx ~= lastIdx then
      lastIdx = selIdx
      UpdateAll(GetSelectedUnits())
    end
  end))
  menu.lifepct:setActionCallback(LifeCallback)
  menu.resource:setActionCallback(ResourceCallback)

  UpdateAll(units)

  menu:run(false)
end
