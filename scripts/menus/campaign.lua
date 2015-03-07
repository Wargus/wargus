--       _________ __                 __
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      campaign.lua - Define the menu for campaigns.
--
--      (c) Copyright 2006-2015 by Jimmy Salmon, Pali Rohár and cybermind
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

function Briefing(title, objs, bg, text, voices)
  if (CurrentCampaignRace ~= nil) then
    SetPlayerData(GetThisPlayer(), "RaceName", CurrentCampaignRace)
  end

  local menu = WarMenu(nil, bg)

  wargus.playlist = {}
  if (CurrentCampaignRace == "human") then
    PlayMusic("music/Human Briefing" .. wargus.music_extension)
    Load("scripts/human/ui.lua")
  elseif (CurrentCampaignRace == "orc") then
    PlayMusic("music/Orc Briefing" .. wargus.music_extension)
    Load("scripts/orc/ui.lua")
  else
    StopMusic()
  end

  Objectives = objs

  if (title ~= nil) then
    menu:addLabel(title, (70 + 340) / 2 * Video.Width / 640, 28 * Video.Height / 480, Fonts["large"], true)
  end

  local t = LoadBuffer(text)
  t = "\n\n\n\n\n\n\n\n\n\n" .. t .. "\n\n\n\n\n\n\n\n\n\n\n\n\n"
  local sw = ScrollingWidget(320, 170 * Video.Height / 480)
  sw:setBackgroundColor(Color(0,0,0,0))
  sw:setSpeed(0.28)
  local l = MultiLineLabel(t)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setVerticalAlignment(MultiLineLabel.TOP)
  l:setLineWidth(320)
  l:adjustSize()
  sw:add(l, 0, 0)
  menu:add(sw, 70 * Video.Width / 640, 80 * Video.Height / 480)

  if (objs ~= nil) then
    menu:addLabel(_("Objectives:"), 372 * Video.Width / 640, 306 * Video.Height / 480, Fonts["large"], false)

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

  menu:addContinueButton(_("~!Continue"), "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
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

function GetCampaignState(campaign)
  -- Loaded saved game could have other old state
  -- Make sure that we use saved state from config file
  if (campaign == nil) then
	return nil
  end
  Load("preferences.lua")
  for i = 1, table.getn(wc2.preferences.CampaignProgress) do
	if wc2.preferences.CampaignProgress[i*2 - 1] == campaign then
		return wc2.preferences.CampaignProgress[i*2]
	end
  end
  return nil
end

function IncreaseCampaignState(campaign)
  -- Loaded saved game could have other old state
  -- Make sure that we use saved state from config file
  if (campaign == nil) then
	return
  end
  Load("preferences.lua")
  if (wc2.preferences.CampaignBestScores ~= nil) then
	for i = 1, table.getn(wc2.preferences.CampaignBestScores) / 2 do
		if wc2.preferences.CampaignBestScores[i*2 - 1] == campaign then
			local subtable = wc2.preferences.CampaignBestScores[i*2]
			if subtable[currentState] == nil then
				table.insert(subtable, currentState, GetPlayerData(GetThisPlayer(), "Score"))
			elseif subtable[currentState] < GetPlayerData(GetThisPlayer(), "Score") then
				subtable[currentState] = GetPlayerData(GetThisPlayer(), "Score")
			end					
		end
	end
  end
  for i = 1, table.getn(wc2.preferences.CampaignProgress) do
	if wc2.preferences.CampaignProgress[i*2 - 1] == campaign then
		if (wc2.preferences.CampaignProgress[i*2] == currentState and currentState < table.getn(CampaignMapTitleList)) then
			wc2.preferences.CampaignProgress[i*2] = wc2.preferences.CampaignProgress[i*2] + 1
		end
	end
  end
  currentState = currentState + 1
  -- Make sure that we immediately save state
  SavePreferences()
end

function CreatePictureStep(bg, sound, title, text)
  return function()
    SetPlayerData(GetThisPlayer(), "RaceName", CurrentCampaignRace)
    wargus.playlist = {}
    PlayMusic(sound)
    local menu = WarMenu(nil, bg, false)
    local offx = (Video.Width - 640) / 2
    local offy  = (Video.Height - 480) / 2
    menu:addLabel(title, offx + 320, offy + 240 - 67, Fonts["small-title"], true)
    menu:addLabel(text, offx + 320, offy + 240 - 25, Fonts["large-title"], true)
    menu:addHalfButton(_("~!Continue"), "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
      function()  menu:stop() end)
    menu:run()
    GameResult = GameVictory
  end
end

function CreateMapStep(map)
  return function()
    Load(map)
    RunMap(map)
    if (GameResult == GameVictory) then
      IncreaseCampaignState(currentCampaign)
    end
  end
end

function CreateVideoStep(video)
  return function()
	local menu = WarMenu(nil, nil, false)
    PlayMovie(video)
	menu:run(false)
    GameResult = GameVictory
  end
end

function CreateVictoryStep(bg, text, voices)
  return function()
    Briefing(nil, nil, bg, text, voices)
    GameResult = GameVictory
  end
end

function CampaignButtonTitle(i)
  title = "Ending - Victory"
  if (CurrentCampaignPath ~= nil and CampaignMapTitleList ~= nil) then
	
	Load(CurrentCampaignPath .. CampaignMapTitleList[i])
	if ( string.len(title) > 80 ) then
	  title = string.sub(title, 1, 80) .. "..."
	end

	return title
  end
  return nil
end

function CampaignButtonFunction(campaign, i, menu)
    position = campaign_menu[i]
    currentCampaign = campaign
    currentState = i
	menu:stop()
    RunCampaign(campaign)
end

function RunCampaignSubmenu(campaign)
  if (campaign == nil) then
	return
  end
  Load(campaign)
  
  -- Add new best scores
  local inList = false
  for i = 1, table.getn(wc2.preferences.CampaignBestScores) do
	if wc2.preferences.CampaignBestScores[i*2 - 1] == campaign then
		inList = true
		break
	end
  end
  if not inList then
	table.insert(wc2.preferences.CampaignBestScores, campaign)
	table.insert(wc2.preferences.CampaignBestScores, {})
	SavePreferences()
  end
  -- Add new progress
  inList = false
  for i = 1, table.getn(wc2.preferences.CampaignProgress) do
	if wc2.preferences.CampaignProgress[i*2 - 1] == campaign then
		inList = true
		break
	end
  end
  if not inList then
	table.insert(wc2.preferences.CampaignProgress, campaign)
	table.insert(wc2.preferences.CampaignProgress, 1)
	SavePreferences()
  end
 
  wargus.playlist = { "music/Main Menu" .. wargus.music_extension }
  SetDefaultRaceView()

  if not (IsMusicPlaying()) then
    PlayMusic("music/Main Menu" .. wargus.music_extension)
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local difficulty_types = {_("Easy"), _("Normal"), _("Hard"),_("Nightmare"),_("Hell")}
  
  menu:addLabel(_("~<Mission list~>"), offx + 640/2 + 12, offy + 45)

  local missionList = {}
  for i = 1, GetCampaignState(campaign) do
	missionList[i] = CampaignButtonTitle(i)
  end
  local missionListBox = menu:addListBox(offx + 80, offy + 100, 480, 250, missionList)
  menu:addLabel(_("~<AI Difficulty:~>"), offx + 80, offy + 214 + (36 * 4), Fonts["game"], false)
  difficulty = menu:addDropDown(difficulty_types, offx + 200, offy + 212 + (36 * 4),
    function(dd) end)
  difficulty:setSize(170, 20)
  difficulty:setSelected(1)
  
  local goButton = menu:addFullButton(_("~!Play mission"), "p", offx + 208, offy + 212 + (36 * 5),  
			function() 
				GameSettings.Difficulty = difficulty:getSelected() + 1
				wc2.preferences.LastDifficulty = GameSettings.Difficulty
				SavePreferences()
				return CampaignButtonFunction(campaign, missionListBox:getSelected() + 1, menu) 
			end)
  local function UpdateGo()
	if missionListBox:getSelected() ~= -1 then
		 goButton:setVisible(true)
	else
		goButton:setVisible(false)
	end
  end
  goButton:setVisible(false)
  local listener = LuaActionListener(UpdateGo)
  menu:addLogicCallback(listener)
  menu:addFullButton(_("~!Previous Menu"), "p", offx + 208, offy + 212 + (36 * 6),
    function()  menu:stop(1); RunSinglePlayerTypeMenu(); currentCampaign = nil; currentState = nil; end)

  if (wargus.tales == false) then
    menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"]) -- Copyright information.
  end
  
  menu:run()

end

function RunCampaign(campaign)
  Load(campaign)

  if (CurrentCampaignRace == "human") then
    Load("scripts/human/ui.lua")
  elseif (CurrentCampaignRace == "orc") then
    Load("scripts/orc/ui.lua")
  end

  if (campaign ~= currentCampaign or position == nil) then
    position = 1
  end

  currentCampaign = campaign

  while (position <= table.getn(campaign_steps)) do
	GameSettings.Difficulty = wc2.preferences.LastDifficulty
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
  
  RunCampaignSubmenu()

  currentCampaign = nil
end