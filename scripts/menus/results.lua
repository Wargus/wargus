local hvictory = "ui/human/victory.png"
local hdefeat =  "ui/human/defeat.png"
local ovictory = "ui/orc/victory.png"
local odefeat =  "ui/orc/defeat.png"

function RunResultsMenu()
  local background
  local result
  local human = (GetPlayerData(GetThisPlayer(), "RaceName") == "human")

  if (GameResult == GameVictory) then
    result = "Victory!"
    if (human) then
      background = hvictory
    else
      background = ovictory
    end
  elseif (GameResult == GameDefeat) then
    result = "Defeat!"
    if (human) then
      background = hdefeat
    else
      background = odefeat
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

  local menu = WarMenu(nil, background)
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  local names_font = Fonts["small-title"]
  local top_offset = 57
  local bottom_offset = 178
  local description_offset = 30

  local c = 0
  for i=0,7 do
    if (GetPlayerData(i, "TotalUnits") > 0 ) then
      c = c + 1
    end
  end

  local line_spacing = (432 - bottom_offset - description_offset) / c

  menu:addLabel("Outcome", offx + 106, offy + top_offset)
  menu:addLabel(result, offx + 106, offy + top_offset + 21, Fonts["large-title"])

  menu:addLabel("Units", offx + 50, offy + bottom_offset, Fonts["large"], true)
  menu:addLabel("Buildings", offx + 140, offy + bottom_offset, Fonts["large"], true)
  menu:addLabel("Gold", offx + 230, offy + bottom_offset, Fonts["large"], true)
  menu:addLabel("Wood", offx + 320, offy + bottom_offset, Fonts["large"], true)
  menu:addLabel("Oil", offx + 410, offy + bottom_offset, Fonts["large"], true)
  menu:addLabel("Kills", offx + 500, offy + bottom_offset, Fonts["large"], true)
  menu:addLabel("Razings", offx + 590, offy + bottom_offset, Fonts["large"], true)

  c = 0
  for i=0,7 do
    if (GetPlayerData(i, "TotalUnits") > 0 ) then
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
      menu:addLabel(name, offx + 320,
        offy + bottom_offset + description_offset + 26 + line_spacing * c + 5,
        names_font, true)
      menu:addLabel(GetPlayerData(i, "TotalUnits"), offx + 10 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)
      menu:addLabel(GetPlayerData(i, "TotalBuildings"), offx + 100 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)
      menu:addLabel(GetPlayerData(i, "TotalResources", "gold"), offx + 190 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)
      menu:addLabel(GetPlayerData(i, "TotalResources", "wood"), offx + 280 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)
      menu:addLabel(GetPlayerData(i, "TotalResources", "oil"), offx + 370 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)
      menu:addLabel(GetPlayerData(i, "TotalKills"), offx + 460 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)
      menu:addLabel(GetPlayerData(i, "TotalRazings"), offx + 550 + 40,
        offy + bottom_offset + description_offset + line_spacing * c + 5,
        Fonts["large"], true)

      c = c + 1
    end
  end

  menu:addFullButton("~!Save Replay", "s", offx + 200, offy + 480,
    function() RunSaveReplayMenu() end)

  menu:addFullButton("~!Continue", "c", offx + 450, offy + 480,
    function() menu:stop() end)

  menu:run()
end

