function Briefing(title, objs, bg, text, voices)
  local menu = WarMenu(nil, bg)

  menu:addLabel(title, (70 + 340) / 2 * Video.Width / 640, 28 * Video.Height / 480,
    Fonts["large"], true)

  menu:addLabel("Objectives:", 372 * Video.Width / 640, 306 * Video.Height / 480, Fonts["large"], false)

  objectives = ""
  table.foreachi(objs, function(k,v) objectives = objectives .. v .. "\n" end)

  local l = MultiLineLabel(objectives)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(250 * Video.Width / 640)
  l:adjustSize()
  menu:add(l, 372 * Video.Width / 640, (306 * Video.Height / 480) + 30)

  menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
    function() menu:stop() end)

  menu:run()
end

function CreateMapStep(map)
  return function()
    Load(map)
    RunMap(map)
  end
end

function RunCampaign(campaign)
  Load(campaign)

  if (position == nil) then
    position = 1
  end

  while (position <= table.getn(campaign_steps)) do
    campaign_steps[position]()
    if (GameResult == GameVictory) then
      position = position + 1
    end
  end
end

function RunCampaignGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addFullButton("~!Human campaign", "h", offx + 208, offy + 212 + (36 * 0),
    function() RunCampaign("scripts/human/campaign1.lua") end)
  menu:addFullButton("H~!uman expansion levels", "u", offx + 208, offy + 212 + (36 * 1),
    function() RunCampaign("scripts/human/campaign2.lua") end)
  menu:addFullButton("~!Orc campaign", "o", offx + 208, offy + 212 + (36 * 2),
    function() RunCampaign("scripts/orc/campaign1.lua") end)
  menu:addFullButton("O~!rc expansion levels", "r", offx + 208, offy + 212 + (36 * 3),
    function() RunCampaign("scripts/orc/campaign2.lua") end)

  menu:addFullButton("~!Cancel", "c", offx + 208, offy + 212 + (36 * 5),
    function() menu:stop() end)

  menu:run()
end

