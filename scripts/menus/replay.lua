function RunReplayGameMenu()
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Select Game", 352 / 2, 11)

  local browser = menu:addBrowser("~logs/", "%.log%.?g?z?$",
    (352 - 18 - 288) / 2, 11 + 98, 306, 108)

  local reveal = menu:addCheckBox("Reveal Map", 23, 264, function() end)

  menu:addHalfButton("~!OK", "o", 48, 308,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      InitGameVariables()
      StartReplay("~logs/" .. browser:getSelectedItem(), reveal:isMarked())
      InitGameSettings()
      SetPlayerData(GetThisPlayer(), "RaceName", "orc")
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", 198, 308, function() menu:stop() end)

  menu:run()
end

function RunSaveReplayMenu()
  local menu = WarGameMenu(panel(3))
  menu:setSize(384, 256)
  menu:setPosition((Video.Width - 384) / 2, (Video.Height - 256) / 2)

  menu:addLabel("Save Replay", 384 / 2, 11)

  local t = menu:addTextInputField("game.log",
    (384 - 300 - 18) / 2, 11 + 36, 318)

  local browser = menu:addBrowser("~logs", ".log$",
    (384 - 300 - 18) / 2, 11 + 36 + 22, 318, 126)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (384 / 3) - 106 - 10, 256 - 16 - 27,
    -- FIXME: use a confirm menu if the file exists already
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- append .log
      if (string.find(name, ".log$") == nil) then
        name = name .. ".log"
      end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      SaveReplay(name)
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (384 / 3) - 106 - 10, 256 - 16 - 27,
    function() menu:stop() end)

  menu:run()
end
