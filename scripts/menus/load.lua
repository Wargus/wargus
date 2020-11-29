function LoadGame(s)
  LoadGameFile = nil
  currentCampaign = nil
  local loop = true

  while (loop) do
    InitGameVariables()
    StartSavedGame(s)
    if (GameResult ~= GameRestart) then
      loop = false
	end
  end

  RunResultsMenu()

  InitGameSettings()
  SetDefaultRaceView()

  if (GameResult == GameVictory) then
    IncreaseCampaignState(currentCampaign)
  end

  if currentCampaign ~= nil then
	GameSettings.Difficulty = wc2.preferences.LastDifficulty
    if GameResult == GameVictory then
      position = position + 1
    elseif (GameResult == GameDefeat) then
    elseif (GameResult == GameDraw) then
    elseif (GameResult == GameNoResult) then
      return
    else
      RunCampaignSubmenu(currentCampaign, currentRace, currentExp) -- quit to menu
      return
    end
    RunCampaign(currentCampaign)
  end
end

function AddLoadGameItems(menu)
  menu:addLabel(_("Load Game"), 384 / 2, 11)
  local browser = menu:addBrowser("~save", "^.*%.sav%.?g?z?$",
    (384 - 300 - 18) / 2, 11 + (36 * 1.5), 318, 126)

  menu:addHalfButton(_("~!Load"), "l", (384 - 300 - 18) / 2, 256 - 16 - 27,
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
  menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 384 - ((384 - 300 - 18) / 2) - 106, 256 - 16 - 27,
    function() menu:stop(1); end)
end

function RunLoadGameMenu()
  local menu = WarMenu(nil, panel(3), false)
  menu:setSize(384, 256)
  menu:setPosition((Video.Width - 384) / 2, (Video.Height - 256) / 2)
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = false
  menu:run()
end

function RunGameLoadGameMenu()
  local menu = WarGameMenu(panel(3))
  menu:resize(384, 256)
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = true
  menu:run(false)
end

