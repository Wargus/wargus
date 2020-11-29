function RunHelpMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Help Menu"), 128, 11)
  menu:addFullButton(_("Keystroke ~!Help"), "h", 16, 40 + 36*0,
    function() RunKeystrokeHelpMenu() end)
  menu:addFullButton(_("~!Tips"), "t", 16, 40 + 36*1,
    function() RunTipsMenu() end)
  menu:addFullButton(_("Previous (~<Esc~>)"), "escape", 128 - (224 / 2), 248,
    function() menu:stop() end)

  menu:run(false)
end

local keystrokes = {
  {"Alt-F", _("- toggle full screen")},
  {"Alt-G", _("- toggle grab mouse")},
  {"Ctrl-S", _("- mute sound")},
  {"Ctrl-M", _("- mute music")},
  {"+", _("- increase game speed")},
  {"-", _("- decrease game speed")},
  {"Ctrl-P", _("- pause game")},
  {"PAUSE", _("- pause game")},
  {"PRINT", _("- make screen shot")},
  {"Alt-H", _("- help menu")},
  {"Alt-R", _("- restart scenario")},
  {"Alt-Q", _("- quit to main menu")},
  {"Alt-X", _("- quit game")},
  {"Alt-B", _("- toggle expand map")},
  {"Alt-M", _("- game menu")},
  {"ENTER", _("- write a message")},
  {"SPACE", _("- goto last event")},
  {"TAB", _("- hide/unhide terrain")},
  {"Ctrl-T", _("- track unit")},
  {"Alt-I", _("- find idle peon")},
  {"Alt-C", _("- center on selected unit")},
  {"Alt-V", _("- next view port")},
  {"Ctrl-V", _("- previous view port")},
  {"^", _("- select nothing")},
  {"#", _("- select group")},
  {"##", _("- center on group")},
  {"Ctrl-#", _("- define group")},
  {"Shift-#", _("- add to group")},
  {"Alt-#", _("- add to alternate group")},
  {"F2-F4", _("- recall map position")},
  {"Shift F2-F4", _("- save map postition")},
  {"F5", _("- game options")},
  {"F6", _("- speed options")},
  {"F7", _("- sound options")},
  {"F8", _("- preferences")},
  {"F9", _("- diplomacy")},
  {"F10", _("- game menu")},
  {"BACKSPACE", _("- game menu")},
  {"F11", _("- save game")},
  {"F12", _("- load game")},
}

function RunKeystrokeHelpMenu()
  local menu = WarGameMenu(panel(5))
  menu:resize(352, 352)

  local c = Container()
  c:setOpaque(false)

  for i=1,table.getn(keystrokes) do
    local l = Label(keystrokes[i][1])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 0, 20 * (i - 1))
    local l = Label(keystrokes[i][2])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 80, 20 * (i - 1))
  end

  local s = ScrollArea()
  c:setSize(320 - s:getScrollbarWidth(), 20 * table.getn(keystrokes))
  s:setBaseColor(dark)
  s:setBackgroundColor(dark)
  s:setForegroundColor(clear)
  s:setSize(320, 216)
  s:setContent(c)
  menu:add(s, 16, 60)

  menu:addLabel(_("Keystroke Help Menu"), 352 / 2, 11)
  menu:addFullButton(_("Previous (~<Esc~>)"), "escape",
    (352 / 2) - (224 / 2), 352 - 40, function() menu:stop() end)

  menu:run(false)
end

local tips = {
  _("You can select all of your currently visible units of the same type by holding down the CTRL key and selecting a unit or by \"double clicking\" on a unit."),
  _("The more workers you have collecting resources, the faster your economy will grow."),
  _("Building more than one barracks will let you train more units faster."),
  _("Use your workers to repair damaged buildings."),
  _("Explore your surroundings early in the game."),

  _("You can demolish trees and rocks."),
  _("Keep all workers working. Use ALT-I to find idle workers."),
  _("You can make units automatically cast spells by selecting a unit, holding down CTRL and clicking on the spell icon.  CTRL click again to turn off."),

  -- Shift tips
  _("You can give an unit an order which is executed after it finishes the current work, if you hold the SHIFT key."),
  _("You can give way points, if you press the SHIFT key, while you click right for the move command."),
  _("You can order a worker to build one building after the other, if you hold the SHIFT key, while you place the building."),
  _("You can build many of the same building, if you hold the ALT and SHIFT keys while you place the buildings."),

  _("Use CTRL-V or ALT-V to cycle through the viewport configuration, you can then monitor your base and lead an attack."),

  _("Know a useful tip?  Then add it here!"),
}

function RunTipsMenu()
  local menu = WarGameMenu(panel(2))
  menu:resize(288, 256)

  menu:addLabel(_("Tips"), 144, 11)

  local l = MultiLineLabel()
  l:setFont(Fonts["game"])
  l:setSize(260, 128)
  l:setLineWidth(260)
  menu:add(l, 14, 35)

  function l:prevTip()
    wc2.preferences.TipNumber = wc2.preferences.TipNumber - 1
    if (wc2.preferences.TipNumber < 1) then
      wc2.preferences.TipNumber = table.getn(tips)
    end
    SavePreferences()
  end
  function l:nextTip()
    wc2.preferences.TipNumber = wc2.preferences.TipNumber + 1
    if (wc2.preferences.TipNumber > table.getn(tips)) then
      wc2.preferences.TipNumber = 1
    end
    SavePreferences()
  end
  function l:updateCaption()
    self:setCaption(tips[wc2.preferences.TipNumber])
  end

  if (wc2.preferences.TipNumber == 0) then
    l:nextTip()
  end
  l:updateCaption()

  local showtips = {}
  showtips = menu:addImageCheckBox(_("Show tips at startup"), 14, 256 - 75, offi, offi2, oni, oni2,
    function()
      wc2.preferences.ShowTips = showtips:isMarked()
      SavePreferences()
    end)
  showtips:setMarked(wc2.preferences.ShowTips)

  menu:addHalfButton(_("~!Next Tip"), "n", 14, 256 - 40,
    function() l:nextTip(); l:updateCaption() end)
  menu:addHalfButton(_("Close (~<Esc~>)"), "escape", 168, 256 - 40,
    function() l:nextTip(); menu:stop() end)

  menu:run(false)
end

