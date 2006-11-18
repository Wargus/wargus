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
--      (c) Copyright 2001-2004 by Lutz Sammer and Jimmy Salmon
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
--      $Id$

DefineRaceNames(
  "race", {
    "name", "human",
    "display", "Human",
    "visible"},
  "race", {
    "name", "orc",
    "display", "Orc",
    "visible"},
  "race", {
    "name", "neutral",
    "display", "Neutral"})

Load("scripts/wc2-config.lua")


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
    {"unit-footman", "unit-grunt"},
    {"unit-archer", "unit-axethrower"},
    {"unit-ranger", "unit-berserker"},
    {"unit-knight", "unit-ogre"},
    {"unit-paladin", "unit-ogre-mage"},
    {"unit-mage", "unit-death-knight"},
    {"unit-ballista", "unit-catapult"},
    {"unit-balloon", "unit-zeppelin"},
    {"unit-gryphon-rider", "unit-dragon"},
    {"unit-human-watch-tower", "unit-orc-watch-tower"},
    {"unit-human-guard-tower", "unit-orc-guard-tower"},
    {"unit-human-cannon-tower", "unit-orc-cannon-tower"},
    {"unit-human-shipyard", "unit-orc-shipyard"},
    {"unit-human-refinery", "unit-orc-refinery"},
    {"unit-human-foundry", "unit-orc-foundry"},
    {"unit-human-oil-platform", "unit-orc-oil-platform"},
    {"unit-human-oil-tanker", "unit-orc-oil-tanker"},
    {"unit-human-submarine", "unit-orc-submarine"},
    {"unit-human-destroyer", "unit-orc-destroyer"},
    {"unit-battleship", "unit-ogre-juggernaught"},
    {"unit-human-transport", "unit-orc-transport"}
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


if (OldSetPlayerData == nil) then
  OldSetPlayerData = SetPlayerData
end

-- Override with game settings
function SetPlayerData(player, data, arg1, arg2)
  local res = {arg2, arg2, arg2}

  if (data == "RaceName") then
    if (ThisPlayer ~= nil and ThisPlayer.Index == player) then
      if (GameSettings.Presets[0].Race == 1) then
        arg1 = "human"
      elseif (GameSettings.Presets[0].Race == 2) then
        arg1 = "orc"
      end
    end
  elseif (data == "Resources") then
    if (GameSettings.Resources == 1) then
      res = {2000, 1000, 1000}
    elseif (GameSettings.Resources == 2) then
      res = {5000, 2000, 2000}
    elseif (GameSettings.Resources == 3) then
      res = {10000, 5000, 5000}
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
end

if (OldDefinePlayerTypes == nil) then
  OldDefinePlayerTypes = DefinePlayerTypes
end

function DefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8)
  local p = {p1, p2, p3, p4, p5, p6, p7, p8}
  local foundperson = false
  local nump = GameSettings.Opponents
  if (nump == 0) then nump = 8 end

  -- FIXME: should randomly pick players to use
  for i=1,8 do
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

  OldDefinePlayerTypes(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])
end

