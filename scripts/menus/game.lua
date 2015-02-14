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
    menu:setPosition(176 + (Video.Width - 176 - menu:getWidth()) / 2,
      (Video.Height - menu:getHeight()) / 2)
  end

  menu:resize(256, 288)
  menu:setBorderSize(0)
  menu:setDrawMenusUnder(true)

  AddMenuHelpers(menu)

  return menu
end



function RunGameMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel(_("Game Menu"), 128, 11)

  menu:addHalfButton(_("Save (~<F11~>)"), "f11", 16, 40,
    function() RunSaveMenu() end)
  menu:addHalfButton(_("Load (~<F12~>)"), "f12", 16 + 12 + 106, 40,
    function() RunGameLoadGameMenu() end)
  menu:addFullButton(_("Options (~<F5~>)"), "f5", 16, 40 + 36*1,
    function() RunGameOptionsMenu() end)
  menu:addFullButton(_("Help (~<F1~>)"), "f1", 16, 40 + 36*2,
    function() RunHelpMenu() end)
  menu:addFullButton(_("Scenario ~!Objectives"), "o", 16, 40 + 36*3,
    function() RunObjectivesMenu() end)
  menu:addFullButton(_("~!End Scenario"), "e", 16, 40 + 36*4,
    function() RunEndScenarioMenu() end)
  menu:addFullButton(_("Return to Game (~<Esc~>)"), "escape", 16, 288 - 40,
    function() menu:stop() end)

  menu:run(false)
end
