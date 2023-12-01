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
--      (c) Copyright 2001-2016 by Lutz Sammer, Jimmy Salmon and Kyran Jackson.
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

DefineRaceNames(
   "race", {
      "name", "human",
      "display", _("Human"),
      "visible"},
   "race", {
      "name", "orc",
      "display", _("Orc"),
      "visible"},
   "race", {
      "name", "neutral",
      "display", _("Neutral")
})

if (OldCreateUnit == nil) then
  OldCreateUnit = CreateUnit

  local t = {
    {"unit-town-hall", "unit-great-hall"},
    {"unit-keep", "unit-stronghold"},
    {"unit-castle", "unit-fortress"},
    {"unit-peasant", "unit-peon"},
    {"unit-elven-lumber-mill", "unit-troll-lumber-mill"},
    {"unit-human-blacksmith", "unit-orc-blacksmith"},
    {"unit-inventor", "unit-alchemist"},
    {"unit-stables", "unit-ogre-mound"},
    {"unit-church", "unit-altar-of-storms"},
    {"unit-mage-tower", "unit-temple-of-the-damned"},
    {"unit-gryphon-aviary", "unit-dragon-roost"},
    {"unit-human-barracks", "unit-orc-barracks"},
    {"unit-farm", "unit-pig-farm"},
    {"unit-yeoman", "unit-nomad"},
    {"unit-footman", "unit-grunt"},
    {"unit-archer", "unit-axethrower"},
    {"unit-ranger", "unit-berserker"},
    {"unit-knight", "unit-ogre"},
    {"unit-paladin", "unit-ogre-mage"},
    {"unit-mage", "unit-death-knight"},
    {"unit-dwarves", "unit-goblin-sappers"},
    {"unit-ballista", "unit-catapult"},
    {"unit-ballista-super", "unit-catapult-super"},
    {"unit-balloon", "unit-zeppelin"},
    {"unit-gryphon-rider", "unit-dragon"},
    {"unit-human-watch-tower", "unit-orc-watch-tower"},
    {"unit-human-guard-tower", "unit-orc-guard-tower"},
    {"unit-human-cannon-tower", "unit-orc-cannon-tower"},
    {"unit-human-guard-tower-super", "unit-orc-guard-tower-super"},
    {"unit-human-cannon-tower-super", "unit-orc-cannon-tower-super"},
    {"unit-caanoo-wiseman", "unit-caanoo-wiseskeleton"},
    {"unit-human-shipyard", "unit-orc-shipyard"},
    {"unit-human-refinery", "unit-orc-refinery"},
    {"unit-human-foundry", "unit-orc-foundry"},
    {"unit-human-oil-platform", "unit-orc-oil-platform"},
    {"unit-human-oil-tanker", "unit-orc-oil-tanker"},
    {"unit-human-submarine", "unit-orc-submarine"},
    {"unit-human-destroyer", "unit-orc-destroyer"},
    {"unit-battleship", "unit-ogre-juggernaught"},
    {"unit-human-transport", "unit-orc-transport"},
    {"unit-attack-peasant", "unit-skeleton"}
  }

  HumanEquivalent = {}
  OrcEquivalent = {}

  for i=1,table.getn(t) do
    HumanEquivalent[t[i][2]] = t[i][1]
    OrcEquivalent[t[i][1]] = t[i][2]
  end
end

-- Convert a unit type to the equivalent for a different race
function ConvertUnitType(unittype, race)
  local equiv

  if (race == "human") then
    equiv = HumanEquivalent[unittype]
  else
    equiv = OrcEquivalent[unittype]
  end

  if (equiv ~= nil) then
    return equiv
  else
    return unittype
  end
end

-- Convert unit type to the player's race
function CreateUnit(unittype, player, pos)
  if (GameCycle ~= 0) then
    return OldCreateUnit(unittype, player, pos)
  end

  -- Don't add any units in 1 peasant only mode
  if (GameSettings.NumUnits == 1 and player ~= 15) then
    return
  end

  -- Leave neutral the way it is
  if (player == 15) then
    return OldCreateUnit(unittype, player, pos)
  end

  if (Players[player].Type == PlayerNobody) then
    return nil
  end

  unittype = ConvertUnitType(unittype, GetPlayerData(player, "RaceName"))

  return OldCreateUnit(unittype, player, pos)
end

if (OldSetAiType == nil) then
  OldSetAiType = SetAiType
end

function SetAiType(player, aiscript)
	if (GameSettings.Presets[player].AIScript == "Map Default" or
		GameSettings.Presets[player].AIScript == _("Map Default") or GameSettings.Presets[player].AIScript == "") then
		OldSetAiType(player, aiscript)
	else
		OldSetAiType(player, GameSettings.Presets[player].AIScript)
	end
end

if (OldSetPlayerData == nil) then
  OldSetPlayerData = SetPlayerData
end

--Define Player Data.
function SetupPlayer(player, race, ai, gold, wood, oil, x, y)
	if (race == "man") then race = "human" end
	SetStartView(player, x, y)
	SetPlayerData(player, "Resources", "wood", wood)
	SetPlayerData(player, "Resources", "gold", gold)
	SetPlayerData(player, "Resources", "oil", oil)
	SetPlayerData(player, "RaceName", race)
	SetAiType(player, ai)
	if (GameDefinition["Map"][player]["Team"] ~= nil) then
		for index = 0, 15 do
			if ((GameDefinition["Map"][index]["Team"] ~= nil) and (GameDefinition["Map"][player]["Team"] == GameDefinition["Map"][index]["Team"])) then
				SetSharedVision(player, true, index)
				SetDiplomacy(player, "allied", index)
			else
				SetSharedVision(player, false, index)
				SetDiplomacy(player, "enemy", index)
			end
		end
	end
end

function SetMapTeams(player, team, position)
	GameDefinition["Map"][player]["Team"] = team
	GameDefinition["Map"][player]["Player"] = position	
end

function SpawnUnits(player, unit, x, y, width, height)
	SpawnUnitSquare(player, unit, x, y, width, height)
end

function SpawnUnitSquare(player, unit, x, y, width, height)
	for loopx = 0, width-1 do
		for loopy = 0, height-1 do
			CreateUnit(unit, player, {(x+loopx), (y+loopy)})
		end
	end
end

function OrderUnits(player, unit, fromx, fromy, width, height, tox, toy, order)
	OrderUnitSquare(player, unit, fromx, fromy, width, height, tox, toy, order)
end

function OrderUnitSquare(player, unit, fromx, fromy, width, height, tox, toy, order)
	if (order == nil) then order = "move" end
	if (height == nil) then height = 1 end
	if (width == nil) then width = 1 end
	for loopx = 0, width-1 do
		for loopy = 0, height-1 do
			if (GetNumUnitsAt(player, unit, {fromx+loopx,fromy+loopy}, {fromx+loopx,fromy+loopy}) > 0) then
				OrderUnit(player, unit, {fromx+loopx,fromy+loopy,fromx+loopx,fromy+loopy}, {tox+width,toy+loopy,tox+width,toy+loopy}, order)
			end
		end
	end
end

function GameDefinitionSetup(name, version, revision, map, topography)
	if (name == "initialise") then
		GameDefinition = {}
		GameDefinition["Briefing"] = {}
		GameDefinition["Map"] = {}
		GameDefinition["Results"] = {}
		for player = 0, 15 do
			GameDefinition["Map"][player] = {}
		end
		GameDefinition["Player"] = {}
		for team = 1, 4 do
			GameDefinition["Player"][team] = {}
			for player = 1, 8 do
				-- GameDefinition["Player"][1][1]["Name"] = Shane Wolfe
				-- GameDefinition["Player"][1][1]["Race"] = Human
				-- GameDefinition["Player"][1][1]["Position"] = 8
				GameDefinition["Player"][team][player] = {}
				GameDefinition["Player"][team][player]["Name"] = nil
				GameDefinition["Player"][team][player]["Race"] = nil
				GameDefinition["Player"][team][player]["Position"] = nil
			end
		end
	end
	if ((name == "reset") or (name == "initialise")) then
		GameDefinition["Name"] = "Skirmish"
		GameDefinition["Version"] = "Modern"
		GameDefinition["Revision"] = 1
		GameDefinition["Map"]["Name"] = "None"
		GameDefinition["Map"]["Topography"] = "None"
		GameDefinition["Briefing"]["Active"] = true
		GameDefinition["Briefing"]["Width"] = 800
		GameDefinition["Briefing"]["Height"] = 600
		GameDefinition["Briefing"]["Objectives"] = {"No", "Objectives"}
		GameDefinition["Briefing"]["Title"] = "No Title"
		GameDefinition["Briefing"]["Character"] = " "
		GameDefinition["Briefing"]["Sync"] = " "
		GameDefinition["Results"]["Player"] = "Mythic"
		GameDefinition["Results"]["Enemy"] = "Wild"
		local races = {'Mythic', 'Wild'}
		for racesCount = 1, #races do
			GameDefinition["Results"][races[racesCount]] = {}
			GameDefinition["Results"][races[racesCount]]["InfantryCurrent"]  = 0
			GameDefinition["Results"][races[racesCount]]["InfantryTotal"]    = 0
			GameDefinition["Results"][races[racesCount]]["ArtilleryCurrent"] = 0
			GameDefinition["Results"][races[racesCount]]["ArtilleryTotal"]   = 0
			GameDefinition["Results"][races[racesCount]]["CavalryCurrent"]   = 0
			GameDefinition["Results"][races[racesCount]]["CavalryTotal"]     = 0
		end
		if (Video.Width > GameDefinition["Briefing"]["Width"]) then
			GameDefinition["Briefing"]["X"] = (Video.Width / 2) - (GameDefinition["Briefing"]["Width"] / 2)
		else
			GameDefinition["Briefing"]["X"] = 0
		end
		if (Video.Height > GameDefinition["Briefing"]["Height"]) then
			GameDefinition["Briefing"]["Y"] = (Video.Height / 2) - (GameDefinition["Briefing"]["Height"] / 2)
		else
			GameDefinition["Briefing"]["Y"] = 0
		end
	elseif (version ~= nil) then
		if (revision == nil) then revision = 1 end
		GameDefinition["Name"] = name
		if ((GameDefinition["Version"] == "Classic") and (version == "Modern")) then else
			GameDefinition["Version"] = version
		end
		GameDefinition["Revision"] = revision
		if (map ~= nil) then
			GameDefinition["Map"]["Name"] = map
			if (map ~= nil) then
			--	GameDefinition["Map"]["Path"] = path
			end
			if (topography ~= nil) then
				-- Land, Coastal, Islands
				GameDefinition["Map"]["Topography"] = topography
			end
		end
	end
end

function CampaignDataSetup(name, map, variable, value)
	if (name == nil) then
		CampaignData = {}
	else
		if (map == nil) then
			CampaignData[name] = {}
		elseif (type(map) == "number") then
			CampaignData[name][GameDefinition["Map"]["Name"]]["Magic"] = map
		else
			if (variable == nil) then
				CampaignData[name][map] = {}
				CampaignData[name][map]["Magic"] = 0
			else
				CampaignData[name][map][variable] = value
			end
		end	
	end
end

CampaignDataSetup()
CampaignDataSetup("Lucas Kage")
CampaignDataSetup("Lucas Kage", "Dunath Plains")
GameDefinitionSetup("initialise")

-- Override with game settings
function SetPlayerData(player, data, arg1, arg2)
  if (GameCycle ~= 0) then
    return OldSetPlayerData(player, data, arg1, arg2)
  end

  local res = {arg2, arg2, arg2}

  if (data == "RaceName") then
    if (GameSettings.Presets[player].Race == 0) then
        arg1 = "human"
      elseif (GameSettings.Presets[player].Race == 1) then
        arg1 = "orc"
      end
  elseif (data == "Resources") then
    if (GameSettings.Presets[player].Type == PlayerNobody) then
      res = {0, 0, 0}
    elseif (GameSettings.Resources == 1) then
      res = {2000, 1000, 1000}
    elseif (GameSettings.Resources == 2) then
      res = {5000, 2000, 2000}
    elseif (GameSettings.Resources == 3) then
      res = {10000, 5000, 5000}
	 elseif (GameSettings.Resources == 4) then
      res = {30000, 15000, 10000}
    end
    if (arg1 == "gold") then
      arg2 = res[1]
    elseif (arg1 == "wood") then
      arg2 = res[2]
    elseif (arg1 == "oil") then
      arg2 = res[3]
    end
  end

  OldSetPlayerData(player, data, arg1, arg2)

  -- If this is 1 peasant mode add the peasant now
  if (data == "RaceName") then
    if (GameSettings.NumUnits == 1) then
      if (player ~= 15 and Players[player].Type ~= PlayerNobody) then
        local unittype = ConvertUnitType("unit-peasant", GetPlayerData(player, "RaceName"))
        OldCreateUnit(unittype, player, {Players[player].StartPos.x, Players[player].StartPos.y})
      end
    end
  end
end

if (OldDefinePlayerTypes == nil) then
  OldDefinePlayerTypes = DefinePlayerTypes
end

function DefineCustomMapRules()

end

function DefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
  if (IsSkirmishClassic == true or IsNetworkGame()==true or GameSettings.NetGameType == 2 or Editor.Running==4 or GameSettings.GameType==-1 or currentCampaign ~= nil) then
	  local p = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15}
	  local foundperson = false
	  local nump = GameSettings.Opponents
	  if (nump == 0) then nump = 15 end

	  -- FIXME: should randomly pick players to use
	  for i=1,15 do
		if (p[i] == "person" or p[i] == "computer") then
		  if (p[i] == "person" and foundperson == false) then
			foundperson = true
		  else
			if (nump == 0) then
			  p[i] = "nobody"
			else
			  nump = nump - 1
			end
		  end
		end
	  end
	  OldDefinePlayerTypes(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15])
  else
	local plrsnmb = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
		for i=0,15 do
			if GameSettings.Presets[i].Type == PlayerPerson then
				plrsnmb[i+1]="person"
			elseif GameSettings.Presets[i].Type == PlayerComputer then
				plrsnmb[i+1]="computer"
			elseif GameSettings.Presets[i].Type == PlayerRescuePassive then
				plrsnmb[i+1]="rescue-passive"
			elseif GameSettings.Presets[i].Type == PlayerRescueActive then
				plrsnmb[i+1]="rescue-active"
			elseif GameSettings.Presets[i].Type == PlayerNeutral then
				plrsnmb[i+1]="nobody"
			elseif GameSettings.Presets[i].Type == -1 then
				plrsnmb[i+1]=nil
			end
		end
		OldDefinePlayerTypes(plrsnmb[1], plrsnmb[2], plrsnmb[3], plrsnmb[4], plrsnmb[5], plrsnmb[6], plrsnmb[7], plrsnmb[8],
			plrsnmb[9], plrsnmb[10], plrsnmb[11], plrsnmb[12], plrsnmb[13], plrsnmb[14], plrsnmb[15])
		mapinfo.playertypes[1] = plrsnmb[1]
		mapinfo.playertypes[2] = plrsnmb[2]
		mapinfo.playertypes[3] = plrsnmb[3]
		mapinfo.playertypes[4] = plrsnmb[4]
		mapinfo.playertypes[5] = plrsnmb[5]
		mapinfo.playertypes[6] = plrsnmb[6]
		mapinfo.playertypes[7] = plrsnmb[7]
		mapinfo.playertypes[8] = plrsnmb[8]
		mapinfo.playertypes[9] = plrsnmb[9]
		mapinfo.playertypes[10] = plrsnmb[10]
		mapinfo.playertypes[11] = plrsnmb[11]
		mapinfo.playertypes[12] = plrsnmb[12]
		mapinfo.playertypes[13] = plrsnmb[13]
		mapinfo.playertypes[14] = plrsnmb[14]
		mapinfo.playertypes[15] = plrsnmb[15]
	end
end

if OldLoadTileModels == nil then
	OldLoadTileModels = LoadTileModels
end

Load("scripts/tilesets/tilesetsList.lua") -- Load tilesets helper

function LoadTileModels(tileset)
  DefineCustomMapRules()
  if (GameCycle ~= 0) then
    return OldLoadTileModels(tileset)
  end
  if (GameSettings.Tileset == nil 
  	  or GameSettings.Tileset == "default") then
    return OldLoadTileModels(tileset)
  end
  OldLoadTileModels(Tilesets:getScriptFor(GameSettings.Tileset))
end

-- Called by Stratagus when unloading a mod.

function CleanModGame_Lua()

end

-- Called by Stratagus when a game is restarted
function StartCustomGame_Lua()

end

-- Called by Stratagus when a game finished
function CleanCustomGame_Lua()

end

function StartModGame_Lua()

end

function CleanGame_Lua()
	print("game ends")
	ReInitAiGameData()	
	CleanCustomGame_Lua()
	StartModGame_Lua()
end
