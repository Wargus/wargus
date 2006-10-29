function RunObjectivesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Objectives", 128, 11, Fonts["large"], true)

  local objectives = ""
  table.foreachi(Objectives, function(k,v) objectives = objectives .. v .. "\n" end)

  local l = MultiLineLabel(objectives)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(228)
  l:adjustSize()
  menu:add(l, 14, 38)

  menu:addFullButton("~!OK", "o", 16, 288 - 40, function() menu:stop() end)

  menu:run()
end

