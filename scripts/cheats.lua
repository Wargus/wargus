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
--      wc2.lua - WC2 compatibility level
--
--      (c) Copyright 2001-2011 by Lutz Sammer, Jimmy Salmon and Pali Rohár
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

InitFuncs:add(function()
  speedcheat = false
  godcheat = false
end)

function HandleCheats(str)
  local resources = { "gold", "wood", "oil" }

  if (str == "there is no aliens level") then
    -- FIXME: no function yet
    AddMessage("enabled cheat")

  elseif (str == "hatchet") then
	for i = 0,PlayerMax - 1 do
		SetSpeedResourcesHarvest(i, "wood", 5200 / 2)
	end
    AddMessage("Wow -- I got jigsaw!")

  elseif (str == "glittering prizes") then
    SetPlayerData(GetThisPlayer(), "Resources", "gold",
      GetPlayerData(GetThisPlayer(), "Resources", "gold") + 12000)
    SetPlayerData(GetThisPlayer(), "Resources", "wood",
      GetPlayerData(GetThisPlayer(), "Resources", "wood") + 5000)
    SetPlayerData(GetThisPlayer(), "Resources", "oil",
      GetPlayerData(GetThisPlayer(), "Resources", "oil") + 5000)
    AddMessage("!!! :)")

  elseif (str == "on screen") then
    RevealMap()

  elseif (str == "showpath") then
    RevealMap()

  elseif (str == "fow on") then
    SetFogOfWar(true)

  elseif (str == "fow off") then
    SetFogOfWar(false)

  elseif (str == "fast debug") then
    for i = 0,PlayerMax - 1 do
		  for j = 1,table.getn(resources) do
			SetSpeedResourcesHarvest(i, resources[j], 1000)
			SetSpeedResourcesReturn(i, resources[j], 1000)
		  end
		  SetSpeedBuild(i, 1000)
		  SetSpeedTrain(i, 1000)
		  SetSpeedUpgrade(i, 1000)
		  SetSpeedResearch(i, 1000)
	  end
    AddMessage("FAST DEBUG SPEED")

  elseif (str == "normal debug") then
    for i = 0,PlayerMax - 1 do
		  for j = 1,table.getn(resources) do
			SetSpeedResourcesHarvest(i, resources[j], 100)
			SetSpeedResourcesReturn(i, resources[j], 100)
		  end
		  SetSpeedBuild(i, 100)
		  SetSpeedTrain(i, 100)
		  SetSpeedUpgrade(i, 100)
		  SetSpeedResearch(i, 100)
	  end
    AddMessage("NORMAL DEBUG SPEED")

  elseif (str == "make it so") then
    if (speedcheat) then
      speedcheat = false
      for i = 0,PlayerMax - 1 do
		  for j = 1,table.getn(resources) do
			SetSpeedResourcesHarvest(i, resources[j], 100)
			SetSpeedResourcesReturn(i, resources[j], 100)
		  end
		  SetSpeedBuild(i, 100)
		  SetSpeedTrain(i, 100)
		  SetSpeedUpgrade(i, 100)
		  SetSpeedResearch(i, 100)
	  end
      AddMessage("NO SO!")
    else
      speedcheat = true
      for i = 0,PlayerMax - 1 do
		  for j = 1,table.getn(resources) do
			SetSpeedResourcesHarvest(i, resources[j], 1000)
			SetSpeedResourcesReturn(i, resources[j], 1000)
		  end
		  SetSpeedBuild(i, 1000)
		  SetSpeedTrain(i, 1000)
		  SetSpeedUpgrade(i, 1000)
		  SetSpeedResearch(i, 1000)
	  end
      for i = 1,table.getn(resources) do
        SetPlayerData(GetThisPlayer(), "Resources", resources[i],
          GetPlayerData(GetThisPlayer(), "Resources", resources[i]) + 32000)
      end
      AddMessage("SO!")
    end

  elseif (str == "unite the clans") then
    ActionVictory()

  elseif (str == "you pitiful worm") then
    ActionDefeat()

  elseif (str == "it is a good day to die") then
    if (godcheat) then
      godcheat = false
      SetGodMode(false)
      AddMessage("God Mode OFF")
    else
      godcheat = true
      SetGodMode(true)
      AddMessage("God Mode ON")
    end

  elseif (str == "fill mana") then
    t = GetUnits("any")
    for i = 1,table.getn(t) do
		if (GetUnitVariable(t[i], "Mana", "Enable") == 1) then
			SetUnitVariable(t[i], "Mana", 255, "Value")
		end
    end

  elseif (str == "disco") then
    StopMusic()
    PlayMusic("music/I'm a Medieval Man" .. wargus.music_extension)
    AddMessage("enabled cheat")

  else
    return false
  end
  return true
end
