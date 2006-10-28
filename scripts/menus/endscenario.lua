function RunEndScenarioMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("End Scenario", 128, 11)
  local b = menu:addFullButton("~!Restart Scenario", "r", 16, 40 + (36 * 0),
    function() RunRestartConfirmMenu() end)
  if (IsNetworkGame()) then
    b:setEnabled(false)
  end
  menu:addFullButton("~!Surrender", "s", 16, 40 + (36 * 1),
    function() RunSurrenderConfirmMenu() end)
  menu:addFullButton("~!Quit to Menu", "q", 16, 40 + (36 * 2),
    function() RunQuitToMenuConfirmMenu() end)
  menu:addFullButton("E~!xit Program", "x", 16, 40 + (36 * 3),
    function() RunExitConfirmMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunRestartConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128, 11)
  menu:addLabel("want to restart", 128, 11 + (24 * 1))
  menu:addLabel("the scenario?", 128, 11 + (24 * 2))
  menu:addFullButton("~!Restart Scenario", "r", 16, 11 + (24 * 3) + 29,
    function() StopGame(GameRestart); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunSurrenderConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128, 11)
  menu:addLabel("want to surrender", 128, 11 + (24 * 1))
  menu:addLabel("to your enemies?", 128, 11 + (24 * 2))
  menu:addFullButton("~!Surrender", "s", 16, 11 + (24 * 3) + 29,
    function() StopGame(GameDefeat); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunQuitToMenuConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128, 11)
  menu:addLabel("want to quit to", 128, 11 + (24 * 1))
  menu:addLabel("the main menu?", 128, 11 + (24 * 2))
  menu:addFullButton("~!Quit to Menu", "q", 16, 11 + (24 * 3) + 29,
    function() StopGame(GameQuitToMenu); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

function RunExitConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128, 11)
  menu:addLabel("want to exit", 128, 11 + (24 * 1))
  menu:addLabel("Stratagus?", 128, 11 + (24 * 2))
  menu:addFullButton("E~!xit Program", "x", 16, 11 + (24 * 3) + 29,
    function() Exit(0) end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 16, 248,
    function() menu:stop() end)

  menu:run(false)
end

