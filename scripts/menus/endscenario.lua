function RunEndScenarioMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("End Scenario"), 128, 11)
  local b = menu:addFullButton(_("~!Restart Scenario"), "r", 16, 40 + (36 * 0),
    function() RunRestartConfirmMenu() end)
  if (IsNetworkGame()) then
    b:setEnabled(false)
  end
  menu:addFullButton(_("~!Surrender"), "s", 16, 40 + (36 * 1),
    function() RunSurrenderConfirmMenu() end)
  menu:addFullButton(_("~!Quit to Menu"), "q", 16, 40 + (36 * 2),
    function() RunQuitToMenuConfirmMenu() end)
  menu:addFullButton(_("E~!xit Program"), "x", 16, 40 + (36 * 3),
    function() RunExitConfirmMenu() end)
  menu:addFullButton(_("Previous (~<Esc~>)"), "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunRestartConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Are you sure you"), 128, 11)
  menu:addLabel(_("want to restart"), 128, 11 + (24 * 1))
  menu:addLabel(_("the scenario?"), 128, 11 + (24 * 2))
  menu:addFullButton(_("~!Restart Scenario"), "r", 16, 11 + (24 * 3) + 29,
    function() StopGame(GameRestart); menu:stopAll() end)
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunSurrenderConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Are you sure you"), 128, 11)
  menu:addLabel(_("want to surrender"), 128, 11 + (24 * 1))
  menu:addLabel(_("to your enemies?"), 128, 11 + (24 * 2))
  menu:addFullButton(_("~!Surrender"), "s", 16, 11 + (24 * 3) + 29,
    function() ActionDefeat(); end)
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunQuitToMenuConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Are you sure you"), 128, 11)
  menu:addLabel(_("want to quit to"), 128, 11 + (24 * 1))
  menu:addLabel(_("the main menu?"), 128, 11 + (24 * 2))
  menu:addFullButton(_("~!Quit to Menu"), "q", 16, 11 + (24 * 3) + 29,
    function() StopMusic(); StopGame(GameQuitToMenu); Editor.Running = EditorNotRunning; menu:stopAll() end)
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunExitConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Are you sure you"), 128, 11)
  menu:addLabel(_("want to exit"), 128, 11 + (24 * 1))
  menu:addLabel(_("Stratagus?"), 128, 11 + (24 * 2))
  menu:addFullButton(_("E~!xit Program"), "x", 16, 11 + (24 * 3) + 29,
    function() Exit(0) end)
  menu:addFullButton(_("Cancel (~<Esc~>)"), "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

