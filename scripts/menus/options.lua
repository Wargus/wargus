function RunGameOptionsMenu()
  local menu = WarGameMenu(hpanel1)

  menu:addLabel("Game Options", 128, 11)
  menu:addFullButton("Sound (~<F7~>)", "f7", 16, 40 + 36*0,
    function() end)
  menu:addFullButton("Speeds (~<F8~>)", "f8", 16, 40 + 36*1,
    function() end)
  menu:addFullButton("Preferences (~<F9~>)", "f9", 16, 40 + 36*2,
    function() end)
  menu:addFullButton("~!Diplomacy", "d", 16, 40 + 36*3,
    function() end)
  menu:addFullButton("Previous (~<Esc~>", "escape", 128 - (224 / 2), 245,
    function() menu:stop() end)

  menu:run(false)
end

