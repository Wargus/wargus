--      (c) Copyright 2010      by Pali Rohár
	
function Briefing(title, objs, bg, text, voices)
  local menu = WarMenu(nil, bg)

  StopMusic()

  Objectives = objs

  menu:addLabel(title, (70 + 340) / 2 * Video.Width / 640, 28 * Video.Height / 480,
    Fonts["large"], true)

  local t = LoadBuffer(text)
  t = "\n\n\n\n\n\n\n\n\n\n\n\n\n" .. t .. "\n\n\n\n\n\n\n\n\n\n\n\n\n"
  local sw = ScrollingWidget(320, 170 * Video.Height / 480)
  sw:setBackgroundColor(Color(0,0,0,0))
  sw:setSpeed(0.38)
  local l = MultiLineLabel(t)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(320)
  l:adjustSize()
  sw:add(l, 0, 0)
  menu:add(sw, 70 * Video.Width / 640, 80 * Video.Height / 480)

  menu:addLabel("Objectives:", 372 * Video.Width / 640, 306 * Video.Height / 480, Fonts["large"], false)

  local objectives = ""
  table.foreachi(objs, function(k,v) objectives = objectives .. v .. "\n" end)

  local l = MultiLineLabel(objectives)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(250 * Video.Width / 640)
  l:adjustSize()
  menu:add(l, 372 * Video.Width / 640, (306 * Video.Height / 480) + 30)

  local voice = 0
  local channel = -1

  menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
    function()
      if (channel ~= -1) then
        voice = table.getn(voices)
        StopChannel(channel)
      end
      menu:stop()
      MusicStopped()
    end)


  function PlayNextVoice()
    voice = voice + 1
    if (voice <= table.getn(voices)) then
      channel = PlaySoundFile(voices[voice], PlayNextVoice);
    else
      channel = -1
    end
  end
  PlayNextVoice()

  local speed = GetGameSpeed()
  SetGameSpeed(30)

  menu:run()

  SetGameSpeed(speed)
end

function CreatePictureStep(bg, sound, title, text)
  return function()
    PlayMusic(sound)
    local menu = WarMenu(nil, bg)
    local offx = (Video.Width - 640) / 2
    local offy  = (Video.Height - 480) / 2
    menu:addLabel(title, offx + 320, offy + 240 - 67, Fonts["large-title"], true)
    menu:addLabel(text, offx + 320, offy + 240 - 25, Fonts["small-title"], true)
    menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
      function() menu:stop() end)
    menu:run()
    GameResult = GameVictory
  end
end

function CreateMapStep(map)
  return function()
    Load(map)
    RunMap(map)
  end
end

function CreateVideoStep(video)
  return function()
    PlayMovie(video)
    GameResult = GameVictory
  end
end

function CampaignButtonTitle(race, exp, i)
  local name

  name = "campaigns/" .. race

  if (exp == "exp") then
    name = name .. "-exp"
  end

  name = name .. "/level"

  if (exp == "exp") then
    name = name .. "x"
  end

  if (i<10) then
    name = name .. "0"
  end

  name = name .. i
  
  if (race == "orc") then
    name = name .. "o"
  else
    name = name .. "h"
  end

  name = name .. "_c2.sms"
  title = ""
  Load(name)

  if ( string.len(title) > 20 ) then
	  title = string.sub(title, 1, 19) .. "..."
  end

  return title
end

function RunCampaignSubmenu(campaign, race, exp)
  Load(campaign)

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  local show_buttons = table.getn(campaign_menu)
  local half = math.ceil(show_buttons/2)

  for i=1,half do
    menu:addFullButton(CampaignButtonTitle(race, exp, i), ".", offx + 98, offy + 100 + (36 * i),
      function() position = campaign_menu[i]; currentCampaign = campaign; RunCampaign(campaign); menu:stop(); RunCampaignSubmenu(campaign, race, exp) end)
  end

  for i=1+half,show_buttons do
    menu:addFullButton(CampaignButtonTitle(race, exp, i), ".", offx + 326, offy + 100 + (36 * (i - half)),
      function() position = campaign_menu[i]; currentCampaign = campaign; RunCampaign(campaign); menu:stop(); RunCampaignSubmenu(campaign, race, exp) end)
  end

  menu:addFullButton("~!Cancel", "c", offx + 208, offy + 212 + (36 * 5),
    function() menu:stop(); RunCampaignGameMenu() end)

  menu:run()

end

function RunCampaign(campaign)
  Load(campaign)

  if (campaign ~= currentCampaign or position == nil) then
    position = 1
  end

  currentCampaign = campaign

  while (position <= table.getn(campaign_steps)) do
    campaign_steps[position]()
    if (GameResult == GameVictory) then
      position = position + 1
    elseif (GameResult == GameDefeat) then
    elseif (GameResult == GameDraw) then
    else
      break -- quit to menu
    end
  end

  currentCampaign = nil
end

function RunCampaignGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addFullButton("~!Human campaign", "h", offx + 208, offy + 212 + (36 * 0),
    function() RunCampaignSubmenu("scripts/human/campaign1.lua", "human", ""); menu:stop() end)
  menu:addFullButton("~!Orc campaign", "o", offx + 208, offy + 212 + (36 * 1),
    function() RunCampaignSubmenu("scripts/orc/campaign1.lua", "orc", ""); menu:stop() end)

  if (expansion == true) then
    menu:addFullButton("~!Human expansion levels", "h", offx + 208, offy + 212 + (36 * 2),
      function() RunCampaignSubmenu("scripts/human/campaign2.lua", "human", "exp"); menu:stop() end)
    menu:addFullButton("~!Orc expansion levels", "o", offx + 208, offy + 212 + (36 * 3),
      function() RunCampaignSubmenu("scripts/orc/campaign2.lua", "orc", "exp"); menu:stop() end)
  end

  menu:addFullButton("~!Cancel", "c", offx + 208, offy + 212 + (36 * 5),
    function() menu:stop() end)

  menu:run()
end

