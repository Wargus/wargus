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
    "race", 0,
    "name", "human",
    "display", "Human",
    "visible"},
  "race", {
    "race", 1,
    "name", "orc",
    "display", "Orc",
    "visible"},
  "race", {
    "race", 2,
    "name", "neutral",
    "display", "Neutral"})

DefineTilesetWcNames(
  "tileset-summer", "tileset-winter", "tileset-wasteland", "tileset-swamp")

DefineConstructionWcNames(
  "construction-none", "construction-none", "construction-none", "construction-none",
  "construction-none", "construction-none", "construction-land",
  "construction-human-shipyard", "construction-orc-shipyard",
  "construction-human-oil-well", "construction-orc-oil-well",
  "construction-human-refinery", "construction-orc-refinery",
  "construction-human-foundry", "construction-orc-foundry", "construction-wall",
  "construction-land2")

DefineUnitTypeWcNames(
    "unit-footman", "unit-grunt", "unit-peasant", "unit-peon", "unit-ballista",
    "unit-catapult", "unit-knight", "unit-ogre", "unit-archer", "unit-axethrower",
    "unit-mage", "unit-death-knight", "unit-paladin", "unit-ogre-mage",
    "unit-dwarves", "unit-goblin-sappers", "unit-peasant",
    "unit-peon", "unit-ranger", "unit-berserker", "unit-female-hero",
    "unit-evil-knight", "unit-flying-angle", "unit-fad-man",
    "unit-white-mage", "unit-beast-cry", "unit-human-oil-tanker",
    "unit-orc-oil-tanker", "unit-human-transport", "unit-orc-transport",
    "unit-human-destroyer", "unit-orc-destroyer", "unit-battleship",
    "unit-ogre-juggernaught", "unit-nothing-22", "unit-fire-breeze",
    "unit-nothing-24", "unit-nothing-25", "unit-human-submarine",
    "unit-orc-submarine", "unit-balloon", "unit-zeppelin",
    "unit-gryphon-rider", "unit-dragon", "unit-knight-rider", "unit-eye-of-vision",
    "unit-arthor-literios", "unit-quick-blade", "unit-knight-rider", "unit-double-head",
    "unit-wise-man", "unit-ice-bringer", "unit-man-of-light", "unit-sharp-axe",
    "unit-skeleton", "unit-skeleton", "unit-daemon", "unit-critter",
    "unit-farm", "unit-pig-farm", "unit-human-barracks", "unit-orc-barracks",
    "unit-church", "unit-altar-of-storms", "unit-human-watch-tower",
    "unit-orc-watch-tower", "unit-stables", "unit-ogre-mound",
    "unit-inventor", "unit-alchemist", "unit-gryphon-aviary",
    "unit-dragon-roost", "unit-human-shipyard", "unit-orc-shipyard",
    "unit-town-hall", "unit-great-hall", "unit-elven-lumber-mill",
    "unit-troll-lumber-mill", "unit-human-foundry", "unit-orc-foundry",
    "unit-mage-tower", "unit-temple-of-the-damned", "unit-human-blacksmith",
    "unit-orc-blacksmith", "unit-human-refinery", "unit-orc-refinery",
    "unit-human-oil-platform", "unit-orc-oil-platform", "unit-keep",
    "unit-stronghold", "unit-castle", "unit-fortress", "unit-gold-mine",
    "unit-oil-patch", "unit-human-start-location", "unit-orc-start-location",
    "unit-human-guard-tower", "unit-orc-guard-tower", "unit-human-cannon-tower",
    "unit-orc-cannon-tower", "unit-circle-of-power", "unit-dark-portal",
    "unit-runestone", "unit-human-wall", "unit-orc-wall", "unit-dead-body",
    "unit-destroyed-1x1-place", "unit-destroyed-2x2-place",
    "unit-destroyed-3x3-place", "unit-destroyed-4x4-place",
    "unit-peasant", "unit-peon", "unit-peasant", "unit-peon", "unit-human-oil-tanker", "unit-orc-oil-tanker")

DefineIconWcNames(
    "icon-peasant", "icon-peon", "icon-footman", "icon-grunt", "icon-archer",
    "icon-axethrower", "icon-ranger", "icon-berserker", "icon-knight", "icon-ogre",
    "icon-paladin", "icon-ogre-mage", "icon-dwarves", "icon-goblin-sappers", "icon-mage",
    "icon-death-knight", "icon-ballista", "icon-catapult", "icon-human-oil-tanker",
    "icon-orc-oil-tanker", "icon-human-transport", "icon-orc-transport",
    "icon-human-destroyer", "icon-orc-destroyer", "icon-battleship",
    "icon-ogre-juggernaught", "icon-gnomish-submarine", "icon-giant-turtle",
    "icon-gnomish-flying-machine", "icon-zeppelin", "icon-gryphon-rider",
    "icon-dragon", "icon-wise-man", "icon-ice-bringer", "icon-man-of-light",
    "icon-sharp-axe", "icon-double-head", "icon-daemon", "icon-farm", "icon-pig-farm",
    "icon-town-hall", "icon-great-hall", "icon-human-barracks", "icon-orc-barracks",
    "icon-elven-lumber-mill", "icon-troll-lumber-mill", "icon-human-blacksmith",
    "icon-orc-blacksmith", "icon-human-shipyard", "icon-orc-shipyard",
    "icon-human-refinery", "icon-orc-refinery", "icon-human-foundry",
    "icon-orc-foundry", "icon-human-oil-platform", "icon-orc-oil-platform",
    "icon-stables", "icon-ogre-mound", "icon-gnomish-inventor", "icon-alchemist",
    "icon-human-watch-tower", "icon-orc-watch-tower", "icon-church",
    "icon-altar-of-storms", "icon-mage-tower", "icon-temple-of-the-damned", "icon-keep",
    "icon-stronghold", "icon-castle-upgrade", "icon-fortress-upgrade", "icon-castle",
    "icon-fortress", "icon-gryphon-aviary", "icon-dragon-roost", "icon-gold-mine",
    "icon-human-guard-tower", "icon-human-cannon-tower", "icon-orc-guard-tower",
    "icon-orc-cannon-tower", "icon-oil-patch", "icon-dark-portal",
    "icon-circle-of-power", "icon-runestone", "icon-move-peasant", "icon-move-peon",
    "icon-repair", "icon-harvest", "icon-build-basic", "icon-build-advanced",
    "icon-return-goods-peasant", "icon-return-goods-peon", "icon-cancel",
    "icon-human-wall", "icon-orc-wall", "icon-slow", "icon-invisibility", "icon-haste",
    "icon-runes", "icon-unholy-armor", "icon-lightning", "icon-flame-shield",
    "icon-fireball", "icon-touch-of-darkness", "icon-death-coil", "icon-whirlwind",
    "icon-blizzard", "icon-holy-vision", "icon-heal", "icon-death-and-decay", "icon-109",
    "icon-exorcism", "icon-eye-of-kilrogg", "icon-bloodlust", "icon-unknown113",
    "icon-skeleton", "icon-critter", "icon-sword1", "icon-sword2", "icon-sword3",
    "icon-battle-axe1", "icon-battle-axe2", "icon-battle-axe3", "icon-122",
    "icon-123", "icon-arrow1", "icon-arrow2", "icon-arrow3", "icon-throwing-axe1",
    "icon-throwing-axe2", "icon-throwing-axe3", "icon-horse1", "icon-horse2",
    "icon-longbow", "icon-ranger-scouting", "icon-ranger-marksmanship",
    "icon-light-axes", "icon-berserker-scouting", "icon-berserker-regeneration",
    "icon-catapult1", "icon-catapult2", "icon-ballista1", "icon-ballista2",
    "icon-human-demolish", "icon-orc-demolish", "icon-human-ship-cannon1",
    "icon-human-ship-cannon2", "icon-human-ship-cannon3", "icon-orc-ship-cannon1",
    "icon-orc-ship-cannon2", "icon-orc-ship-cannon3", "icon-orc-ship-armor1",
    "icon-orc-ship-armor2", "icon-orc-ship-armor3", "icon-human-ship-armor1",
    "icon-human-ship-armor2", "icon-human-ship-armor3", "icon-orc-ship-move",
    "icon-human-ship-move", "icon-orc-ship-return-oil", "icon-human-ship-return-oil",
    "icon-orc-ship-haul-oil", "icon-human-ship-haul-oil", "icon-human-unload",
    "icon-orc-unload", "icon-human-shield1", "icon-human-shield2", "icon-human-shield3",
    "icon-orc-shield1", "icon-orc-shield2", "icon-orc-shield3", "icon-170", "icon-171",
    "icon-172", "icon-173", "icon-174", "icon-175", "icon-176", "icon-177",
    "icon-human-patrol-land", "icon-orc-patrol-land", "icon-human-stand-ground",
    "icon-orc-stand-ground", "icon-human-attack-ground", "icon-orc-attack-ground",
    "icon-human-patrol-naval", "icon-orc-patrol-naval", "icon-quick-blade",
    "icon-female-hero", "icon-ugly-guy", "icon-evil-knight", "icon-beast-cry",
    "icon-flying-angle", "icon-fire-breeze", "icon-white-mage", "icon-fad-man",
    "icon-knight-rider")

DefineUpgradeWcNames(
  "upgrade-sword1", "upgrade-sword2", "upgrade-battle-axe1", "upgrade-battle-axe2",
  "upgrade-arrow1", "upgrade-arrow2", "upgrade-throwing-axe1",
  "upgrade-throwing-axe2", "upgrade-human-shield1", "upgrade-human-shield2",
  "upgrade-orc-shield1", "upgrade-orc-shield2", "upgrade-human-ship-cannon1",
  "upgrade-human-ship-cannon2", "upgrade-orc-ship-cannon1",
  "upgrade-orc-ship-cannon2", "upgrade-human-ship-armor1",
  "upgrade-human-ship-armor2", "upgrade-orc-ship-armor1", "upgrade-orc-ship-armor2",
  "upgrade-catapult1", "upgrade-catapult2", "upgrade-ballista1", "upgrade-ballista2",
  "upgrade-ranger", "upgrade-longbow", "upgrade-ranger-scouting",
  "upgrade-ranger-marksmanship", "upgrade-berserker", "upgrade-light-axes",
  "upgrade-berserker-scouting", "upgrade-berserker-regeneration",
  "upgrade-ogre-mage", "upgrade-paladin", "upgrade-holy-vision", "upgrade-healing",
  "upgrade-exorcism", "upgrade-flame-shield", "upgrade-fireball", "upgrade-slow",
  "upgrade-invisibility", "upgrade-polymorph", "upgrade-blizzard",
  "upgrade-eye-of-kilrogg", "upgrade-bloodlust", "upgrade-raise-dead",
  "upgrade-death-coil", "upgrade-whirlwind", "upgrade-haste", "upgrade-unholy-armor",
  "upgrade-runes", "upgrade-death-and-decay")

DefineAiWcNames(
  "land-attack", "passive", "orc-03", "hum-04", "orc-04", "hum-05", "orc-05",
  "hum-06", "orc-06", "hum-07", "orc-07", "hum-08", "orc-08", "hum-09", "orc-09",
  "hum-10", "orc-10", "hum-11", "orc-11", "hum-12", "orc-12", "hum-13", "orc-13",
  "hum-14-orange", "orc-14-blue", "sea-attack", "air-attack", "hum-14-red",
  "hum-14-white", "hum-14-black", "orc-14-green", "orc-14-white", "orc-exp-04",
  "orc-exp-05", "orc-exp-07a", "orc-exp-09", "orc-exp-10", "orc-exp-12", "orc-exp-06a",
  "orc-exp-06b", "orc-exp-11a", "orc-exp-11b", "hum-exp-02a-red", "hum-exp-02b-black",
  "hum-exp-02c-yellow", "hum-exp-03a-orange", "hum-exp-03b-red", "hum-exp-03c-violet",
  "hum-exp-04a-black", "hum-exp-04b-red", "hum-exp-04c-white", "hum-exp-05a-green",
  "hum-exp-05b-orange", "hum-exp-05c-violet", "hum-exp-05d-yellow", "hum-exp-06a-green",
  "hum-exp-06b-black", "hum-exp-06c-orange", "hum-exp-06d-red", "hum-exp-08a-white",
  "hum-exp-08b-yellow", "hum-exp-08c-violet", "hum-exp-09a-black", "hum-exp-09b-red",
  "hum-exp-09c-green", "hum-exp-09d-white", "hum-exp-10a-violet", "hum-exp-10b-green",
  "hum-exp-10c-black", "hum-exp-11a", "hum-exp-11b", "hum-exp-12a", "orc-exp-05b",
  "hum-exp-07a", "hum-exp-07b", "hum-exp-07c", "orc-exp-12a", "orc-exp-12b", "orc-exp-12c",
  "orc-exp-12d", "orc-exp-02", "orc-exp-07b", "orc-exp-03",
-- Some additionals scripts
  "gruntrush", "goldfever",
  "fca-01", "fca-02", "fca-03", "fca-04", "fca-05", "fca-06", "fca-07", "fca-08", "fca-09",
  "fca-10", "fca-11", "fca-12", "fca-13", "fca-14", "fca-15", "fca-16", "fca-17", "fca-18",
  "fcm-01", "fcm-02", "fcm-03", "fcm-04", "fcm-05", "fcm-06", "fcm-07", "fcm-08", "fcm-09",
  "fcm-10", "fcm-11", "fcm-12", "fcm-13", "fcm-14", "fcm-15", "fcm-16", "fcm-17", "fcm-18")

SetColorWaterCycleStart(38)
SetColorWaterCycleEnd(47)
SetColorIconCycleStart(240)
SetColorIconCycleEnd(244)
SetColorBuildingCycleStart(205)
SetColorBuildingCycleEnd(207)

Load("scripts/wc2-config.lua")
