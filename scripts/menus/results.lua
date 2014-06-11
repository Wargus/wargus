local hvictory = "ui/human/victory.png"
local hdefeat =  "ui/human/defeat.png"
local ovictory = "ui/orc/victory.png"
local odefeat =  "ui/orc/defeat.png"

local humanRanks = {
  0, "Servant",
  2000, "Peasant",
  5000, "Squire",
  8000, "Footman",
  18000, "Corporal",
  28000, "Sergeant",
  40000, "Lieutenant",
  55000, "Captain",
  70000, "Major",
  85000, "Knight",
  105000, "General",
  125000, "Admiral",
  145000, "Marshall",
  165000, "Lord",
  185000, "Grand Admiral",
  205000, "Highlord",
  230000, "Thundergod",
  255000, "God",
  280000, "Designer",
}

local orcRanks = {
  0, "Slave",
  2000, "Peon",
  5000, "Rogue",
  8000, "Grunt",
  18000, "Slasher",
  28000, "Marauder",
  40000, "Commander",
  55000, "Captain",
  70000, "Major",
  85000, "Knight",
  105000, "General",
  125000, "Master",
  145000, "Marshall",
  165000, "Chieftain",
  185000, "Overlord",
  205000, "War Chief",
  230000, "Demigod",
  255000, "God",
  280000, "Designer",
}

function RunResultsMenu()
  local background
  local result
  local human = (GetPlayerData(GetThisPlayer(), "RaceName") == "human")
  local ranksTable
  if (human) then
	ranksTable = humanRanks
	--Load("scripts/human/ui.lua")
  else
	ranksTable = orcRanks
	--Load("scripts/orc/ui.lua")
  end
  -- background and music
  if (GameResult == GameVictory) then
	SetPlayerData(GetThisPlayer(), "Score", GetPlayerData(GetThisPlayer(), "Score") + 500)
    result = "Victory!"
    if (human) then
      background = hvictory
      PlayMusic("music/Human Victory.ogg")
    else
      background = ovictory
      PlayMusic("music/Orc Victory.ogg")
    end
  elseif (GameResult == GameDefeat) then
    result = "Defeat!"
    if (human) then
      background = hdefeat
      PlayMusic("music/Human Defeat.ogg")
    else
      background = odefeat
      PlayMusic("music/Orc Defeat.ogg")
    end
  elseif (GameResult == GameDraw) then
    result = "Draw!"
    if (human) then
      background = hdefeat
    else
      background = odefeat
    end
  else
    return -- quit to menu
  end
  
  local top_offset = 20
  local bottom_offset = 84
  local description_offset = 30
  
   -- menu setup
  local menu = WarMenu(nil, background)
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  
  -- score and rank
  
  local results_score = GetPlayerData(GetThisPlayer(), "Score")
  local currentRank = ranksTable[2]
  local currentRankNumber = 1
  if (currentCampaign ~= nil and currentState ~= nil) then
	local subtable = nil
	for i = 1, table.getn(wc2.preferences.CampaignBestScores) / 2 do
		if wc2.preferences.CampaignBestScores[i*2 - 1] == currentCampaign then
			subtable = wc2.preferences.CampaignBestScores[i*2]
		end
	end
	if (subtable ~= nil) then
		for i=1,currentState - 1 do
			if (subtable[i] ~= nil) then
				results_score = results_score + subtable[i]
			end
		end
	end
  end
  for i = 1, table.getn(ranksTable) / 2 do
	if results_score > ranksTable[i*2 - 1] then
		currentRank = ranksTable[i*2]
		currentRankNumber = i
	else
		break
	end
  end
  local currentLevelRanking = StatBoxWidget(100, 10)
  currentLevelRanking:setCaption("")
  
  if (currentRank == "Designer") then
	currentLevelRanking:setPercent(100)
  else
	currentLevelRanking:setPercent((results_score - ranksTable[currentRankNumber*2-1])*100/(ranksTable[currentRankNumber*2 + 1] - ranksTable[currentRankNumber*2-1]))
  end
  
  currentLevelRanking:setBackgroundColor(black)
  currentLevelRanking:setForegroundColor(Color(0, 0, 215))
  currentLevelRanking:setVisible(false)
  currentLevelRanking:setBaseColor(Color(215, 215, 215))
  menu:add(currentLevelRanking, offx + 280, offy + top_offset + 39)
  
  local currentOverallRanking = StatBoxWidget(100, 10)
  currentOverallRanking:setCaption("")
  currentOverallRanking:setPercent(currentRankNumber*100/ (table.getn(ranksTable) / 2))
  currentOverallRanking:setBackgroundColor(black)
  currentOverallRanking:setForegroundColor(Color(215, 0, 0))
  currentOverallRanking:setVisible(false)
  currentOverallRanking:setBaseColor(Color(215, 215, 215))
  menu:add(currentOverallRanking, offx + 280, offy + top_offset + 50)
  -- player label and color setup
  local playerCount = 0      -- overall number of players
  local playerLabels = {}    -- all player name labels
  local playerColorIndex = {
	{166, 0, 0},     -- red
	{0, 36, 150},    -- blue
	{20, 134, 93},   -- green
	{130, 16, 77},   -- violet
	{189, 89, 16},   -- orange
	{93, 93, 93},    -- black
	{182, 182, 182}, -- white
	{195, 195, 0}    -- yellow
  }
  local playerColors = {}
  local playerNumbers = {}
  
  if (not IsNetworkGame()) then
      SetDefaultPlayerNames()
    end
  for i = 0,7 do
    if (GetPlayerData(i, "TotalUnits") > 0 ) then
		playerCount = playerCount + 1
		local name = GetPlayerData(i, "Name")
		if (ThisPlayer.Index == i) then
			name = name .. " - You"
		  elseif (ThisPlayer:IsAllied(Players[i])) then
			name = name .. " - Ally"
		  elseif (ThisPlayer:IsEnemy(Players[i])) then
			name = name .. " - Enemy"
		  else
			name = name .. " - Neutral"
		  end 
		playerLabels[playerCount] = menu:addLabel(name, offx + 320, offy + 82 + playerCount*42, Fonts["game"], true)
		playerLabels[playerCount]:setVisible(false)
		playerColors[playerCount] = Color(playerColorIndex[i+1][1], playerColorIndex[i+1][2], playerColorIndex[i+1][3])
		playerNumbers[playerCount] = i
    end
  end
  
  local length = 0
  local captionLabels = {}
  local captionOffsets = {}
  -- Label setup part
  captionLabels[1] = menu:addLabel(_("Units:"), offx + 42, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[1] = 0
  length = length + captionLabels[1]:getWidth() + 20
  
  captionLabels[2] = menu:addLabel(_("Buildings:"), offx + 120, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[2] = length
  length = length + captionLabels[2]:getWidth() + 20
  captionLabels[3] = menu:addLabel(_("Gold:"), offx + 202, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[3] = length
  length = length + captionLabels[3]:getWidth() + 20
  captionLabels[4] = menu:addLabel(_("Lumber:"), offx + 281, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[4] = length
  length = length + captionLabels[4]:getWidth() + 20
  captionLabels[5] = menu:addLabel(_("Oil:"), offx + 361, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[5] = length
  length = length + captionLabels[5]:getWidth() + 20
  captionLabels[6] = menu:addLabel(_("Kills:"), offx + 442, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[6] = length
  length = length + captionLabels[6]:getWidth() + 20
  captionLabels[7] = menu:addLabel(_("Razings:"), offx + 520, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[7] = length
  length = length + captionLabels[7]:getWidth() + 20
  captionLabels[8] = menu:addLabel(_("Score:"), offx + 600, offy + bottom_offset, Fonts["game"], true)
  captionOffsets[8] = length

  for i=1,table.getn(captionLabels) do
	captionLabels[i]:setVisible(false)
  end
  
  local counterWidgets = {}
  -- StatBoxWidget setup part
  for i=1,table.getn(captionLabels) do
	counterWidgets[i] = {}
	for j=1,playerCount do
		counterWidgets[i][j] = StatBoxWidget(70, 20)
		counterWidgets[i][j]:setCaption("")
		counterWidgets[i][j]:setPercent(0)
		counterWidgets[i][j]:setBackgroundColor(black)
		counterWidgets[i][j]:setForegroundColor(playerColors[j])
		counterWidgets[i][j]:setVisible(false)
		counterWidgets[i][j]:setFont(Fonts["game"])
		counterWidgets[i][j]:setBaseColor(Color(215, 215, 0))
		menu:add(counterWidgets[i][j], offx + 8 + 80* (i - 1), offy + 60 + 42*j)
	end
  end

  local r_stage = 0
  local r_stats_stage = 0
  local counter = 0
  local wait = 24
  local statStageWait = 0 
  local scoreWait = 24 
  
  local function ResultsShowPlayerStage(stage)
	captionLabels[stage]:setVisible(true)
	for j=1,playerCount do
		counterWidgets[stage][j]:setVisible(true)
	end
  end
  
  -- player tickers
  local p_counters = {}
  for i=1,table.getn(captionLabels) do
	p_counters[i] = {}
	  for j = 1,playerCount do
		p_counters[i][j] = 0
	  end
  end
  local playerStatData = {}                                   -- All player data
  local maxStagePlayer = {1, 1, 1, 1, 1, 1, 1, 1}             -- hold the player earned maximum score of every stat
  local defaultStatSpeeds = {2, 2, 457, 457, 457, 2, 2, 79}  -- default statbox speeds
  local statSpeed = {}       -- speed of stat increasing
  local decrCoeff = 70       -- maximum count of ticks for statbox
  for i=1,table.getn(captionLabels) do
	playerStatData[i] = {}
	for j=1,playerCount do
		if (i == 1) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalUnits")
		elseif (i == 2) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalBuildings")
		elseif (i == 3) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalResources", "gold")
		elseif (i == 4) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalResources", "wood")
		elseif (i == 5) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalResources", "oil")
		elseif (i == 6) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalKills")
		elseif (i == 7) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "TotalRazings")
		elseif (i == 8) then
			playerStatData[i][j] = GetPlayerData(playerNumbers[j], "Score")
		end
	end
	for j=1,playerCount do
		if (playerStatData[i][j] > playerStatData[i][(maxStagePlayer[i])]) then
			maxStagePlayer[i] = j
		end
	end
	statSpeed[i] = math.max(defaultStatSpeeds[i], playerStatData[i][(maxStagePlayer[i])] / decrCoeff)
  end
  
  local regenWidget = StatBoxWidget(1, 1)
  menu:add(regenWidget, -50, -50)
  local ticking = false
  local currect_player_score = 0
  local currect_player_score_label = menu:addLabel(currect_player_score, offx + 530, offy + top_offset + 21, Fonts["small-title"], true)
  currect_player_score_label:setVisible(false)
  local function ResultsMainLoop()
	regenWidget:setPercent(GameCycle)
	if (statStageWait > 0) then -- waiting
		statStageWait = statStageWait - 1
	end
	if (wait > 0) then -- waiting
		wait = wait - 1
		return
	end
	if (r_stage == 0) then -- Results
		menu:addLabel("Outcome", offx + 114, offy + top_offset)
		menu:addLabel(result, offx + 114, offy + top_offset + 21, Fonts["large-title"])
		StopAllChannels()
		PlaySound("statsthump", true)
		wait = 24
		r_stage = r_stage + 1 -- next stage
	elseif (r_stage == 1) then -- Rank
		menu:addLabel("Rank", offx + 330, offy + top_offset)
		menu:addLabel(currentRank, offx + 330, offy + top_offset + 21)
		StopAllChannels()
		PlaySound("statsthump", true)
		wait = 24
		currentLevelRanking:setVisible(true)
		currentOverallRanking:setVisible(true)
		r_stage = r_stage + 1 -- next stage
	elseif (r_stage == 2) then -- Your score
		if (ticking == false) then
			menu:addLabel("Score", offx + 546, offy + top_offset)
			StopAllChannels()
			PlaySound("statsthump", true)
			currect_player_score_label:setVisible(true)
			ticking = true
		else
			if currect_player_score < results_score then
				currect_player_score = currect_player_score + results_score / 10
				currect_player_score_label:setCaption(tostring(math.floor(currect_player_score)))
				currect_player_score_label:adjustSize()
				scoreWait = scoreWait - 2
				wait = 1
				PlaySound("highclick", true)
			else
				currect_player_score_label:setCaption(tostring(math.floor(results_score)))
				currect_player_score_label:adjustSize()
				wait = math.max(scoreWait, 2)
				r_stage = r_stage + 1 -- next stage
				ticking = false
			end
		end
	elseif (r_stage == 3) then -- Stats
		-- show player labels
		for j=1,playerCount do
			playerLabels[j]:setVisible(true)
		end
		ticking = false
		if (statStageWait == 0 and r_stats_stage < table.getn(captionLabels)) then
			-- advance to next stage
			StopAllChannels()
			PlaySound("statsthump", true)
			r_stats_stage = r_stats_stage + 1
			ResultsShowPlayerStage(r_stats_stage)
			statStageWait = 24
		end
		for i=1, r_stats_stage do
			for j=1,playerCount do
				if playerStatData[i][j] > 0 then 
					if  p_counters[i][j] < playerStatData[i][j] then
						ticking = true
						p_counters[i][j] = p_counters[i][j] + statSpeed[i]
						if (p_counters[i][j] > playerStatData[i][j]) then
							p_counters[i][j] = playerStatData[i][j]
						end
						counterWidgets[i][j]:setPercent(math.min(100, p_counters[i][j]*100/playerStatData[i][(maxStagePlayer[i])]))
						counterWidgets[i][j]:setCaption(math.floor(p_counters[i][j]))
					end
				else
					counterWidgets[i][j]:setCaption("0")
				end
			end
		end
		if (ticking) then
			PlaySound("highclick", true)
		elseif r_stats_stage == table.getn(captionLabels) then
			r_stage = r_stage + 1 -- exit
		end
		wait = 1
	elseif (r_stage == 4) then -- just stop
		wait = 24
	end
  end

  local screenUpdate = LuaActionListener(ResultsMainLoop)

  menu:addLogicCallback(screenUpdate)

  menu:addFullButton("~!Save Replay", "s", offx + 150, offy + 440,
    function() RunSaveReplayMenu() end)

  menu:addContinueButton("~!Continue", "c", offx + 400, offy + 440,
    function() 
		StopMusic()
		menu:stop() 
	end)

  local speed = GetGameSpeed()
  SetGameSpeed(30)

  menu:run()

  SetGameSpeed(speed)
end