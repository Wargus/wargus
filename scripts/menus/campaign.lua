--      (c) Copyright 2010      by Pali Rohár

function Briefing(title, objs, bg, text, voices)
  SetPlayerData(GetThisPlayer(), "RaceName", currentRace)

  local menu = WarMenu(nil, bg)

  wargus.playlist = {}
  if (currentRace == "human") then
    PlayMusic("music/Human Briefing.ogg")
    Load("scripts/human/ui.lua")
  elseif (currentRace == "orc") then
    PlayMusic("music/Orc Briefing.ogg")
    Load("scripts/orc/ui.lua")
  else
    StopMusic()
  end

  Objectives = objs

  if (title ~= nil) then
    menu:addLabel(title, (70 + 340) / 2 * Video.Width / 640, 28 * Video.Height / 480, Fonts["large"], true)
  end

  local t = LoadBuffer(text)
  t = "\n\n\n\n\n\n" .. t .. "\n\n\n\n\n\n\n\n\n\n\n\n\n"
  local sw = ScrollingWidget(320, 170 * Video.Height / 480)
  sw:setBackgroundColor(Color(0,0,0,0))
  sw:setSpeed(0.28)
  local l = MultiLineLabel(t)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(320)
  l:adjustSize()
  sw:add(l, 0, 0)
  menu:add(sw, 70 * Video.Width / 640, 80 * Video.Height / 480)

  if (objs ~= nil) then
    menu:addLabel("Objectives:", 372 * Video.Width / 640, 306 * Video.Height / 480, Fonts["large"], false)

    local objectives = ""
    table.foreachi(objs, function(k,v) objectives = objectives .. v .. "\n" end)

    local l = MultiLineLabel(objectives)
    l:setFont(Fonts["large"])
    l:setAlignment(MultiLineLabel.LEFT)
    l:setLineWidth(250 * Video.Width / 640)
    l:adjustSize()
    menu:add(l, 372 * Video.Width / 640, (306 * Video.Height / 480) + 30)
  end

  local voice = 0
  local channel = -1

  menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
    function()
      if (channel ~= -1) then
        voice = table.getn(voices)
        StopChannel(channel)
      end
      menu:stop()
      StopMusic()
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

function GetCampaignState(race, exp)
  -- Loaded saved game could have other old state
  -- Make sure that we use saved state from config file
  Load("preferences.lua")
  if (race == "orc" and exp ~= "exp") then
    return wc2.preferences.CampaignOrc
  elseif (race == "human" and exp ~= "exp") then
    return wc2.preferences.CampaignHuman
  elseif (race == "orc" and exp == "exp") then
    return wc2.preferences.CampaignOrcX
  elseif (race == "human" and exp == "exp") then
    return wc2.preferences.CampaignHumanX
  end
  return 1
end

function IncreaseCampaignState(race, exp, state)
  -- Loaded saved game could have other old state
  -- Make sure that we use saved state from config file
  Load("preferences.lua")
  if (race == "orc" and exp ~= "exp") then
    if (state ~= wc2.preferences.CampaignOrc) then return end
    wc2.preferences.CampaignOrc = wc2.preferences.CampaignOrc + 1
  elseif (race == "human" and exp ~= "exp") then
    if (state ~= wc2.preferences.CampaignHuman) then return end
    wc2.preferences.CampaignHuman = wc2.preferences.CampaignHuman + 1
  elseif (race == "orc" and exp == "exp") then
    if (state ~= wc2.preferences.CampaignOrcX) then return end
    wc2.preferences.CampaignOrcX = wc2.preferences.CampaignOrcX + 1
  elseif (race == "human" and exp == "exp") then
    if (state ~= wc2.preferences.CampaignHumanX) then return end
    wc2.preferences.CampaignHumanX = wc2.preferences.CampaignHumanX + 1
  end
  -- Make sure that we immediately save state
  SavePreferences()
end

function CreatePictureStep(bg, sound, title, text)
  return function()
    SetPlayerData(GetThisPlayer(), "RaceName", currentRace)
    wargus.playlist = {}
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
    if (GameResult == GameVictory) then
      IncreaseCampaignState(currentRace, currentExp, currentState)
    end
  end
end

function CreateVideoStep(video)
  return function()
    PlayMovie(video)
    GameResult = GameVictory
  end
end

function CreateVictoryStep(bg, text, voices)
  return function()
    Briefing(nil, nil, bg, text, voices)
    GameResult = GameVictory
  end
end

function CampaignButtonTitle(race, exp, i)
  local name = "campaigns/" .. race
  if (exp == "exp") then name = name .. "-exp" end
  name = name .. "/level"
  if (exp == "exp") then name = name .. "x" end
  if (i<10) then name = name .. "0" end
  name = name .. i

  if (race == "orc") then
    name = name .. "o"
  else
    name = name .. "h"
  end

  name = name .. "_c2.sms"

  title = "Ending - Victory"
  Load(name)

  if ( string.len(title) > 20 ) then
	  title = string.sub(title, 1, 19) .. "..."
  end

  return title
end

function CampaignButtonFunction(campaign, race, exp, i, menu)
  return function()
    position = campaign_menu[i]
    currentCampaign = campaign
    currentRace = race
    currentExp = exp
    currentState = i
    menu:stop()
    RunCampaign(campaign)
  end
end

function RunCampaignSubmenu(campaign, race, exp)
  Load(campaign)

  wargus.playlist = { "music/Orc Briefing.ogg" }
  SetPlayerData(GetThisPlayer(), "RaceName", "orc")

  if not (IsMusicPlaying()) then
    PlayMusic("music/Orc Briefing.ogg")
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  local show_buttons = GetCampaignState(race, exp)
  local half = math.ceil(show_buttons/2)

  for i=1,half do
    menu:addFullButton(CampaignButtonTitle(race, exp, i), ".", offx + 98, offy + 64 + (36 * i), CampaignButtonFunction(campaign, race, exp, i, menu))
  end

  for i=1+half,show_buttons do
    menu:addFullButton(CampaignButtonTitle(race, exp, i), ".", offx + 326, offy + 64 + (36 * (i - half)), CampaignButtonFunction(campaign, race, exp, i, menu))
  end

  menu:addFullButton("~!Previous Menu", "p", offx + 208, offy + 212 + (36 * 5),
    function() menu:stop(); currentCampaign = nil; currentRace = nil; currentExp = nil; currentState = nil; RunCampaignGameMenu() end)

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
    elseif (GameResult == GameNoResult) then
      currentCampaign = nil
      return
    else
      break -- quit to menu
    end
  end

  RunCampaignSubmenu(currentCampaign, currentRace, currentExp)

  currentCampaign = nil
end

function RunCampaignGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addLabel("Tides of Darkness", offx + 320, offy + 212 - 25)
  menu:addFullButton("~!Orc campaign", "o", offx + 208, offy + 212 + (36 * 0),
    function() RunCampaignSubmenu("scripts/orc/campaign1.lua", "orc", ""); menu:stop() end)
  menu:addFullButton("~!Human campaign", "h", offx + 208, offy + 212 + (36 * 1),
    function() RunCampaignSubmenu("scripts/human/campaign1.lua", "human", ""); menu:stop() end)

  if (wargus.expansion == true) then
    menu:addLabel("Beyond the Dark Portal", offx + 320, offy + 212 + (36 * 3) - 25)
    menu:addFullButton("O~!rc expansion levels", "r", offx + 208, offy + 212 + (36 * 3),
      function() RunCampaignSubmenu("scripts/orc/campaign2.lua", "orc", "exp"); menu:stop() end)
    menu:addFullButton("H~!uman expansion levels", "u", offx + 208, offy + 212 + (36 * 4),
      function() RunCampaignSubmenu("scripts/human/campaign2.lua", "human", "exp"); menu:stop() end)
  end

  menu:addFullButton("~!Previous Menu", "p", offx + 208, offy + 212 + (36 * 5),
    function() menu:stop() end)

  menu:run()
end

