function RunReplayGameMenu()
  local menu = WarMenu(nil, hpanel5, false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Select Game", 352 / 2, 11)

  local browser = menu:addBrowser("~logs/", "%.log%.?g?z?$",
    (352 - 18 - 288) / 2, 11 + 98, 306, 108)

  local reveal = menu:addCheckBox("Reveal Map", 23, 264, function() end)

  menu:addHalfButton("~!OK", "o", 48, 308,
    function()
      StartReplay("~logs/" .. browser:getSelectedItem(), reveal:isMarked())
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", 198, 308, function() menu:stop() end)

  menu:run()
end

