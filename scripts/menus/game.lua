function WarGameMenu(background)
  local menu = MenuScreen()

  if (background == nil) then
    menu:setOpaque(true)
    menu:setBaseColor(dark)
  else
    local bgg = CGraphic:New(background)
    bgg:Load()
    local bg = ImageWidget(bgg)
    menu:add(bg, 0, 0)
  end

  function menu:resize(w, h)
    menu:setSize(w, h)
    menu:setPosition((Video.Width - menu:getWidth()) / 2,
      (Video.Height - menu:getHeight()) / 2)
  end

  menu:resize(256, 288)
  menu:setBorderSize(1)

  AddMenuHelpers(menu)

  return menu
end



function RunGameMenu()
  local menu = WarGameMenu(hpanel1)

  menu:addLabel("Game Menu", 128, 11)

  menu:addHalfButton("Save (~<F11~>)", "f11", 16, 40,
    function() end)
  menu:addHalfButton("Load (~<F12~>)", "f12", 16 + 12 + 106, 40,
    function() end)
  menu:addFullButton("Options (~<F5~>)", "f5", 16, 40 + 36*1,
    function() end)
  menu:addFullButton("Help (~<F1~>)", "f1", 16, 40 + 36*2,
    function() RunHelpMenu() end)
  menu:addFullButton("Scenario ~!Objectives", "o", 16, 40 + 36*3,
    function() end)
  menu:addFullButton("~!End Scenario", "e", 16, 40 + 36*4,
    function() end)
  menu:addFullButton("Return to Game (~<Esc~>)", "escape", 16, 288 - 40,
    function() menu:stop() end)

  menu:run(false)
end

