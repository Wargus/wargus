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
--      ai.lua - Define the AI.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
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


--(define (ai:sleep) () #t)

race1 = "human"
race2 = "orc"

--=============================================================================
--
--  AI helper table, the AI must know where to build units,
--  where to research spells, where to upgrade units.
--  If this is allowed and which dependencies exists, isn't
--  handled here. (see upgrade.lua)
--
--  NOTE: perhaps this could later be used to build the buttons?
--
--  DefineAiHelper(list)
--

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  * Race human.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DefineAiHelper(
  --
  -- Unit can build which buildings.
  --
  {"build", "unit-peasant",
  "unit-farm", "unit-alliance-barracks", "unit-town-hall", "unit-elven-lumber-mill",
  "unit-alliance-blacksmith", "unit-alliance-watch-tower", "unit-human-wall",
  "unit-alliance-shipyard", "unit-alliance-foundry", "unit-human-refinery",
  "unit-inventor", "unit-stables", "unit-mage-tower", "unit-church",
  "unit-gryphon-aviary", "unit-dark-portal", "unit-runestone"},
  {"build", "unit-human-oil-tanker", "unit-alliance-oil-platform"},
  --
  -- Building can train which units.
  --
  {"train", "unit-farm", "unit-critter"},
  {"train", "unit-town-hall", "unit-peasant"},
  {"train", "unit-keep", "unit-peasant"},
  {"train", "unit-castle", "unit-peasant"},
  {"train", "unit-alliance-barracks",
  "unit-footman", "unit-archer", "unit-ranger", "unit-ballista", "unit-knight",
  "unit-paladin"},
  {"train", "unit-inventor",
  "unit-balloon", "unit-dwarves"},
  {"train", "unit-mage-tower", "unit-mage"},
  {"train", "unit-gryphon-aviary", "unit-gryphon-rider"},
  {"train", "unit-alliance-shipyard",
  "unit-human-oil-tanker", "unit-alliance-destroyer", "unit-alliance-transport",
  "unit-alliance-submarine", "unit-battleship"},
  --
  -- Building can upgrade which upgrades.
  --
  {"upgrade", "unit-town-hall", "unit-keep"},
  {"upgrade", "unit-keep", "unit-castle"},
  {"upgrade", "unit-alliance-watch-tower",
  "unit-alliance-guard-tower", "unit-alliance-cannon-tower"},
  --
  -- Building can research which spells or upgrades.
  --
  {"research", "unit-alliance-blacksmith",
  "upgrade-sword1", "upgrade-sword2",
  "upgrade-human-shield1", "upgrade-human-shield2",
  "upgrade-ballista1", "upgrade-ballista2"},
  {"research", "unit-elven-lumber-mill",
  "upgrade-arrow1", "upgrade-arrow2", "upgrade-ranger",
  "upgrade-ranger-scouting", "upgrade-longbow", "upgrade-ranger-marksmanship"},
  {"research", "unit-church",
  "upgrade-paladin", "upgrade-healing", "upgrade-exorcism"},
  {"research", "unit-mage-tower",
  "upgrade-slow", "upgrade-flame-shield", "upgrade-invisibility",
  "upgrade-polymorph", "upgrade-blizzard"},
  {"research", "unit-alliance-foundry",
  "upgrade-human-ship-cannon1", "upgrade-human-ship-cannon2",
  "upgrade-human-ship-armor1", "upgrade-human-ship-armor2"},
  --
  -- Unit can repair which units.
  --
  {"repair", "unit-peasant",
  "unit-farm", "unit-alliance-barracks", "unit-town-hall", "unit-keep", "unit-castle",
  "unit-elven-lumber-mill", "unit-alliance-blacksmith", "unit-alliance-watch-tower",
  "unit-alliance-guard-tower", "unit-alliance-cannon-tower", "unit-human-wall",
  "unit-alliance-shipyard", "unit-alliance-foundry", "unit-human-refinery",
  "unit-inventor", "unit-stables", "unit-mage-tower", "unit-church",
  "unit-gryphon-aviary", "unit-dark-portal", "unit-runestone",
  "unit-alliance-transport"},
  --
  -- Reduce unit limits.
  --
  {"unit-limit", "unit-farm", "food"},
  --
  -- Equivalence of units for the resource manager.
  --
  {"unit-equiv", "unit-town-hall",
  "unit-keep", "unit-castle"},
  {"unit-equiv", "unit-keep",
  "unit-castle"},
  {"unit-equiv", "unit-archer",
  "unit-ranger"},
  {"unit-equiv", "unit-knight",
  "unit-paladin"},
  {"unit-equiv", "unit-peasant"},
  {"unit-equiv", "unit-human-oil-tanker"} )

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  * Race orc.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DefineAiHelper(
  --
  -- Unit can build which buildings.
  --
  {"build", "unit-peon",
  "unit-pig-farm", "unit-mythical-barracks", "unit-great-hall",
  "unit-troll-lumber-mill", "unit-mythical-blacksmith", "unit-mythical-watch-tower",
  "unit-orc-wall", "unit-mythical-shipyard", "unit-mythical-foundry", "unit-orc-refinery",
  "unit-alchemist", "unit-ogre-mound", "unit-temple-of-the-damned",
  "unit-altar-of-storms",
  "unit-dragon-roost", "unit-dark-portal", "unit-runestone"},
  {"build", "unit-orc-oil-tanker", "unit-mythical-oil-platform"},
  --
  -- Building can train which units.
  --
  {"train", "unit-pig-farm", "unit-critter"},
  {"train", "unit-great-hall", "unit-peon"},
  {"train", "unit-stronghold", "unit-peon"},
  {"train", "unit-fortress", "unit-peon"},
  {"train", "unit-mythical-barracks",
  "unit-grunt", "unit-axethrower", "unit-berserker", "unit-catapult", "unit-ogre",
  "unit-ogre-mage"},
  {"train", "unit-alchemist",
  "unit-zeppelin", "unit-goblin-sappers"},
  {"train", "unit-temple-of-the-damned", "unit-death-knight"},
  {"train", "unit-dragon-roost", "unit-dragon"},
  {"train", "unit-mythical-shipyard",
  "unit-orc-oil-tanker", "unit-mythical-destroyer", "unit-mythical-transport",
  "unit-mythical-submarine", "unit-ogre-juggernaught"},
  --
  -- Building can upgrade which upgrades.
  --
  {"upgrade", "unit-great-hall", "unit-stronghold"},
  {"upgrade", "unit-stronghold", "unit-fortress"},
  {"upgrade", "unit-mythical-watch-tower",
  "unit-mythical-guard-tower", "unit-mythical-cannon-tower"},
  --
  -- Building can research which spells or upgrades.
  --
  {"research", "unit-mythical-blacksmith",
  "upgrade-battle-axe1", "upgrade-battle-axe2",
  "upgrade-orc-shield1", "upgrade-orc-shield2",
  "upgrade-catapult1", "upgrade-catapult2"},
  {"research", "unit-troll-lumber-mill",
  "upgrade-throwing-axe1", "upgrade-throwing-axe2", "upgrade-berserker",
  "upgrade-berserker-scouting", "upgrade-light-axes",
  "upgrade-berserker-regeneration"},
  {"research", "unit-altar-of-storms",
  "upgrade-ogre-mage", "upgrade-bloodlust", "upgrade-runes"},
  {"research", "unit-temple-of-the-damned",
  "upgrade-haste", "upgrade-raise-dead", "upgrade-whirlwind",
  "upgrade-unholy-armor", "upgrade-death-and-decay"},
  {"research", "unit-mythical-foundry",
  "upgrade-orc-ship-cannon1", "upgrade-orc-ship-cannon2",
  "upgrade-orc-ship-armor1", "upgrade-orc-ship-armor2"},
  --
  -- Unit can build which units.
  --
  {"repair", "unit-peon",
  "unit-pig-farm", "unit-mythical-barracks", "unit-great-hall", "unit-stronghold",
  "unit-fortress", "unit-troll-lumber-mill", "unit-mythical-blacksmith",
  "unit-mythical-watch-tower", "unit-mythical-guard-tower", "unit-mythical-cannon-tower",
  "unit-orc-wall", "unit-mythical-shipyard", "unit-mythical-foundry", "unit-orc-refinery",
  "unit-alchemist", "unit-ogre-mound", "unit-temple-of-the-damned",
  "unit-altar-of-storms", "unit-dragon-roost", "unit-dark-portal",
  "unit-runestone", "unit-mythical-transport"},
  --
  -- Reduce unit limits.
  --
  {"unit-limit", "unit-pig-farm", "food"},
  --
  -- Equivalence of units for the resource manager.
  --
  {"unit-equiv", "unit-great-hall",
  "unit-stronghold", "unit-fortress"},
  {"unit-equiv", "unit-stronghold",
  "unit-fortress"},
  {"unit-equiv", "unit-axethrower",
  "unit-berserker"},
  {"unit-equiv", "unit-ogre",
  "unit-ogre-mage"},
  {"unit-equiv", "unit-peon"},
  {"unit-equiv", "unit-orc-oil-tanker"} )

--
--  City-center of the current race.
--
function AiCityCenter()
  if (AiGetRace() == race1) then
    return "unit-town-hall"
  else
    return "unit-great-hall"
  end
end

--
--  Better city-center of the current race.
--
function AiBetterCityCenter()
  if (AiGetRace() == race1) then
    return "unit-keep"
  else
    return "unit-stronghold"
  end
end

--
--  Best city-center of the current race.
--
function AiBestCityCenter()
  if (AiGetRace() == race1) then
    return "unit-castle"
  else
    return "unit-fortress"
  end
end

--
--  Worker of the current race.
--
function AiWorker()
  if (AiGetRace() == race1) then
    return "unit-peasant"
  else
    return "unit-peon"
  end
end

--
--  Lumber mill of the current race.
--
function AiLumberMill()
  if (AiGetRace() == race1) then
    return "unit-elven-lumber-mill"
  else
    return "unit-troll-lumber-mill"
  end
end

--
--  Blacksmith of the current race.
--
function AiBlacksmith()
  if (AiGetRace() == race1) then
    return "unit-alliance-blacksmith"
  else
    return "unit-mythical-blacksmith"
  end
end

--
--  Upgrade armor 1 of the current race.
--
function AiUpgradeArmor1()
  if (AiGetRace() == race1) then
    return "upgrade-human-shield1"
  else
    return "upgrade-orc-shield1"
  end
end

--
--  Upgrade armor 2 of the current race.
--
function AiUpgradeArmor2()
  if (AiGetRace() == race1) then
    return "upgrade-human-shield2"
  else
    return "upgrade-orc-shield2"
  end
end

--
--  Upgrade weapon 1 of the current race.
--
function AiUpgradeWeapon1()
  if (AiGetRace() == race1) then
    return "upgrade-sword1"
  else
    return "upgrade-battle-axe1"
  end
end

--
--  Upgrade weapon 2 of the current race.
--
function AiUpgradeWeapon2()
  if (AiGetRace() == race1) then
    return "upgrade-sword2"
  else
    return "upgrade-battle-axe2"
  end
end

--
--  Upgrade missile 1 of the current race.
--
function AiUpgradeMissile1()
  if (AiGetRace() == race1) then
    return "upgrade-arrow1"
  else
    return "upgrade-throwing-axe1"
  end
end

--
--  Upgrade missile 2 of the current race.
--
function AiUpgradeMissile2()
  if (AiGetRace() == race1) then
    return "upgrade-arrow2"
  else
    return "upgrade-throwing-axe2"
  end
end

--
--  Upgrade catapult 1 of the current race.
--
function AiUpgradeCatapult1()
  if (AiGetRace() == race1) then
    return "upgrade-ballista1"
  else
    return "upgrade-catapult1"
  end
end

--
--  Upgrade catapult 2 of the current race.
--
function AiUpgradeCatapult2()
  if (AiGetRace() == race1) then
    return "upgrade-ballista2"
  else
    return "upgrade-catapult2"
  end
end

--
--  Research of the current race.
--
function AiScientific()
  if (AiGetRace() == race1) then
    return "unit-inventor"
  else
    return "unit-alchemist"
  end
end

--
--  Stables of the current race.
--
function AiStables()
  if (AiGetRace() == race1) then
    return "unit-stables"
  else
    return "unit-ogre-mound"
  end
end

--
--  Temple of the current race.
--
function AiTemple()
  if (AiGetRace() == race1) then
    return "unit-church"
  else
    return "unit-altar-of-storms"
  end
end

--
--  Mage tower of the current race.
--
function AiMageTower()
  if (AiGetRace() == race1) then
    return "unit-mage-tower"
  else
    return "unit-temple-of-the-damned"
  end
end

--
--  Airport of the current race.
--
function AiAirport()
  if (AiGetRace() == race1) then
    return "unit-gryphon-aviary"
  else
    return "unit-dragon-roost"
  end
end

--
--  Barracks of the current race.
--
function AiBarracks()
  if (AiGetRace() == race1) then
    return "unit-alliance-barracks"
  else
    return "unit-mythical-barracks"
  end
end

--
--  Soldier of the current race.
--
function AiSoldier()
  if (AiGetRace() == race1) then
    return "unit-footman"
  else
    return "unit-grunt"
  end
end

--
--  Shooter of the current race.
--
function AiShooter()
  if (AiGetRace() == race1) then
    return "unit-archer"
  else
    return "unit-axethrower"
  end
end

--
--  Elite Shooter of the current race.
--
function AiEliteShooter()
  if (AiGetRace() == race1) then
    return "unit-ranger"
  else
    return "unit-berserker"
  end
end

--
--  Cavalry of the current race.
--
function AiCavalry()
  if (AiGetRace() == race1) then
    return "unit-knight"
  else
    return "unit-ogre"
  end
end

--
--  Cavalry mages of the current race.
--
function AiCavalryMage()
  if (AiGetRace() == race1) then
    return "unit-paladin"
  else
    return "unit-ogre-mage"
  end
end

--
--  Mage of the current race.
--
function AiMage()
  if (AiGetRace() == race1) then
    return "unit-mage"
  else
    return "unit-death-knight"
  end
end

--
--  Catapult of the current race.
--
function AiCatapult()
  if (AiGetRace() == race1) then
    return "unit-ballista"
  else
    return "unit-catapult"
  end
end

--
--  Scout of the current race.
--
function AiScout()
  if (AiGetRace() == race1) then
    return "unit-balloon"
  else
    return "unit-zeppelin"
  end
end

--
--  Flyer of the current race.
--
function AiFlyer()
  if (AiGetRace() == race1) then
    return "unit-gryphon-rider"
  else
    return "unit-dragon"
  end
end

--
--  Tower of the current race.
--
function AiTower()
  if (AiGetRace() == race1) then
    return "unit-alliance-watch-tower"
  else
    return "unit-mythical-watch-tower"
  end
end

--
--  Guard-Tower of the current race.
--
function AiGuardTower()
  if (AiGetRace() == race1) then
    return "unit-alliance-guard-tower"
  else
    return "unit-mythical-guard-tower"
  end
end

--
--  Cannon-Tower of the current race.
--
function AiCannonTower()
  if (AiGetRace() == race1) then
    return "unit-alliance-cannon-tower"
  else
    return "unit-mythical-cannon-tower"
  end
end

--
--  Harbor of the current race.
--
function AiHarbor()
  if (AiGetRace() == race1) then
    return "unit-alliance-shipyard"
  else
    return "unit-mythical-shipyard"
  end
end

--
--  Refinery of the current race.
--
function AiRefinery()
  if (AiGetRace() == race1) then
    return "unit-human-refinery"
  else
    return "unit-orc-refinery"
  end
end

--
--  Foundry of the current race.
--
function AiFoundry()
  if (AiGetRace() == race1) then
    return "unit-alliance-foundry"
  else
    return "unit-mythical-foundry"
  end
end

--
--  Ship armor 1 of the current race.
--
function AiUpgradeShipArmor1()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-armor1"
  else
    return "upgrade-orc-ship-armor1"
  end
end

--
--  Ship armor 2 of the current race.
--
function AiUpgradeShipArmor2()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-armor2"
  else
    return "upgrade-orc-ship-armor2"
  end
end

--
--  Ship weapon 1 of the current race.
--
function AiUpgradeShipCannon1()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-cannon1"
  else
    return "upgrade-orc-ship-cannon1"
  end
end

--
--  Ship weapon 2 of the current race.
--
function AiUpgradeShipCannon2()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-cannon2"
  else
    return "upgrade-orc-ship-cannon2"
  end
end

--
--  Platform of the current race.
--
function AiPlatform()
  if (AiGetRace() == race1) then
    return "unit-alliance-oil-platform"
  else
    return "unit-mythical-oil-platform"
  end
end

--
--  Tanker of the current race.
--
function AiTanker()
  if (AiGetRace() == race1) then
    return "unit-human-oil-tanker"
  else
    return "unit-orc-oil-tanker"
  end
end

--
--  Submarine of the current race.
--
function AiSubmarine()
  if (AiGetRace() == race1) then
    return "unit-alliance-submarine"
  else
    return "unit-mythical-submarine"
  end
end

--
--  Destroyer of the current race.
--
function AiDestroyer()
  if (AiGetRace() == race1) then
    return "unit-alliance-destroyer"
  else
    return "unit-mythical-destroyer"
  end
end

--
--  Battleship of the current race.
--
function AiBattleship()
  if (AiGetRace() == race1) then
    return "unit-battleship"
  else
    return "unit-ogre-juggernaught"
  end
end

--
--  Transporter of the current race.
--
function AiTransporter()
  if (AiGetRace() == race1) then
    return "unit-alliance-transport"
  else
    return "unit-mythical-transport"
  end
end

--
--  1st Elite Shooter of the current race.
--
function AiUpgradeEliteShooter()
  if (AiGetRace() == race1) then
    return "upgrade-ranger"
  else
    return "upgrade-berserker"
  end
end

--
--  1st Upgrade of elite Shooter of the current race.
--
function AiUpgradeEliteShooter1()
  if (AiGetRace() == race1) then
    return "upgrade-ranger-scouting"
  else
    return "upgrade-berserker-scouting"
  end
end

--
--  2nd Upgrade of elite Shooter of the current race.
--
function AiUpgradeEliteShooter2()
  if (AiGetRace() == race1) then
    return "upgrade-longbow"
  else
    return "upgrade-light-axes"
  end
end

--
--  3th Upgrade of elite Shooter of the current race.
--
function AiUpgradeEliteShooter3()
  if (AiGetRace() == race1) then
    return "upgrade-ranger-marksmanship"
  else
    return "upgrade-berserker-regeneration"
  end
end

--
--  Upgrade cavalry to cavalry mages of the current race.
--
function AiUpgradeCavalryMage()
  if (AiGetRace() == race1) then
    return "upgrade-paladin"
  else
    return "upgrade-ogre-mage"
  end
end

--
--  1st spell of the cavalry mages of the current race.
--
function AiCavalryMageSpell1()
  if (AiGetRace() == race1) then
    return "upgrade-healing"
  else
    return "upgrade-bloodlust"
  end
end

--
--  2nd spell of the cavalry mages of the current race.
--
function AiCavalryMageSpell2()
  if (AiGetRace() == race1) then
    return "upgrade-exorcism"
  else
    return "upgrade-runes"
  end
end

--
--  1st spell of the mages of the current race.
--
function AiMageSpell1()
  if (AiGetRace() == race1) then
    return "upgrade-slow"
  else
    return "upgrade-haste"
  end
end

--
--  2nd spell of the mages of the current race.
--
function AiMageSpell2()
  if (AiGetRace() == race1) then
    return "upgrade-flame-shield"
  else
    return "upgrade-raise-dead"
  end
end

--
--  3th spell of the mages of the current race.
--
function AiMageSpell3()
  if (AiGetRace() == race1) then
    return "upgrade-invisibility"
  else
    return "upgrade-whirlwind"
  end
end

--
--  4th spell of the mages of the current race.
--
function AiMageSpell4()
  if (AiGetRace() == race1) then
    return "upgrade-polymorph"
  else
    return "upgrade-unholy-armor"
  end
end

--
--  5th spell of the mages of the current race.
--
function AiMageSpell5()
  if (AiGetRace() == race1) then
    return "upgrade-blizzard"
  else
    return "upgrade-death-and-decay"
  end
end



Load("scripts/ai/passive.lua")
Load("scripts/ai/air_attack.lua")
Load("scripts/ai/land_attack.lua")
Load("scripts/ai/sea_attack.lua")


--[[

--=============================================================================
--  This AI script builds only workers and tankers and oil platform.
--  Also if needed a farm.
--
(define ai:orc-03-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep 65535)
    (ai:script ai:orc-03-attack-endloop) ) )

DefineAi('orc-03 "*" "orc-03"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:set-auto-attack #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 2)
    (ai:set  (ai:tanker) 1)
    (ai:wait (ai:worker))	-- start hangs if nothing available

    (ai:need (ai:platform))

    (ai:script ai:orc-03-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and tankers and oil platform.
--		Also if needed a farm.
--		Attacks with soldier and shooter and destroyer.
--
(define ai:hum-04-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep 25000)
    
    (ai:script ai:hum-04-attack-endloop) ) )

DefineAi('hum-04 "*" "hum-04"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 4)
    (ai:set  (ai:tanker) 1)
    (ai:wait (ai:worker))	-- start hangs if nothing available

    (ai:need (ai:platform))

    (ai:force 0 (ai:destroyer) 2 (ai:soldier) 3 (ai:shooter) 4 (ai:transporter) 4)
    (ai:force 1 (ai:destroyer) 2 (ai:soldier) 3 (ai:shooter) 4 (ai:transporter) 4)
    (ai:sleep 27000)

    (ai:force 1 (ai:destroyer) 4 (ai:soldier) 10 (ai:shooter) 8 (ai:transporter) 6)
    (ai:sleep 22000)

    (ai:sleep 22000)

    (ai:sleep 22000)

    (ai:sleep 18000)

    (ai:script ai:hum-04-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and tankers and oil platform.
--		Also if needed a farm.
--		Attacks with soldier and shooter and destroyer.
--
(define ai:orc-04-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep 10500)
    (ai:script ai:orc-04-attack-endloop) ) )

DefineAi('orc-04 "*" "orc-04"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 4)
    (ai:set  (ai:tanker) 1)
    (ai:wait (ai:worker))	-- start hangs if nothing available

    (ai:set  (ai:transporter) 1)
    (ai:force 0 (ai:soldier) 3 (ai:shooter) 4 (ai:destroyer) 2)
    (ai:need (ai:platform))


    (ai:set  (ai:transporter) 2)
    (ai:sleep 15000)
    (ai:force 0 (ai:soldier) 6 (ai:shooter) 5 (ai:destroyer) 2)

    (ai:sleep 15000)

    (ai:sleep 19500)
    (ai:force 0 (ai:soldier) 10 (ai:shooter) 8 (ai:destroyer) 2)

    (ai:sleep 12000)

    (ai:sleep 13500)

    (ai:sleep 30500)

    (ai:script ai:orc-04-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and tankers and oil platform.
--		Also if needed a farm.
--		Attacks with soldier, shooter and destroyer.
--
(define ai:hum-05-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep 18000)

    (ai:sleep 12000)

    (ai:sleep 24000)

    (ai:sleep 14000)

    (ai:script ai:hum-05-attack-endloop) ) )

DefineAi('hum-05 "*" "hum-05"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 4)
    (ai:set  (ai:tanker) 1)
    (ai:set  (ai:transporter) 1)
    (ai:wait (ai:worker))	-- start hangs if nothing available

    (ai:need (ai:platform))

    (ai:force 0 (ai:destroyer) 3 (ai:soldier) 4 (ai:shooter) 3 (ai:transporter) 2)

    (ai:sleep 3000)

    (ai:sleep 4000)

    (ai:sleep 4000)

    (ai:sleep 12000)

    (ai:force 0 (ai:destroyer) 4 (ai:soldier) 12 (ai:shooter) 4 (ai:transporter) 4)


    (ai:sleep 14000)

    (ai:sleep 12000)

    (ai:script ai:hum-05-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers, blacksmith.
--		Also if needed a farm.
--		Upgrades weapon and missile.
--		Attacks with soldier, shooter and cavalrie.
--
(define ai:hum-06-attack-endloop
  '((writes nil "Looping !\n")
    (ai:force 0 (ai:soldier) 0 (ai:shooter) 1 (ai:cavalrie) 1 )
    (ai:sleep 14000)

    (ai:force 0 (ai:soldier) 1 (ai:shooter) 3 (ai:cavalrie) 2 )
    (ai:sleep 11000)

    (ai:force 0 (ai:soldier) 0 (ai:shooter) 3 (ai:cavalrie) 2 )
    (ai:sleep 8000)

    (ai:force 0 (ai:soldier) 0 (ai:shooter) 2 (ai:cavalrie) 2 )
    (ai:sleep 11000)

    (ai:sleep 9000)

    (ai:script ai:hum-06-attack-endloop) ) )

DefineAi('hum-06 "*" "hum-06"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 4)
    (ai:wait (ai:worker))	-- start hangs if nothing available

    (ai:force 0 (ai:soldier) 3 (ai:shooter) 3)
    (ai:sleep 4000)

    (ai:sleep 3000)

    (ai:sleep 4000)

    (ai:need (ai:blacksmith))
    (ai:research (ai:upgrade-missile-1))

    (ai:force 0 (ai:soldier) 4 (ai:shooter) 4)

    (ai:research (ai:upgrade-weapon-1))

    (ai:force 0 (ai:soldier) 6 (ai:shooter) 4)
    (ai:sleep 13000)

    (ai:force 0 (ai:soldier) 1 (ai:shooter) 3 (ai:cavalrie) 3 )
    (ai:sleep 14000)

    (ai:research (ai:upgrade-armor-1))

    (ai:script ai:hum-06-attack-endloop) ))

--=============================================================================
--	This AI script builds only worker and tanker.
--
DefineAi('hum-07 "*" "hum-07"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:set-auto-attack #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 2)
    (ai:set  (ai:tanker) 1)
    (ai:sleep	10000)
    (ai:restart)))

--=============================================================================
--	This AI script builds only workers, blacksmith.
--		Also if needed a farm.
--		Upgrades weapon and missile.
--		Attacks with soldier, shooter and cavalrie.
--
(define ai:hum-08-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep 16000)
    (ai:force 0 (ai:soldier) 1 (ai:shooter) 4 (ai:cavalrie) 3 (ai:catapult) 1)

    (ai:sleep 14000)

    (ai:sleep 12000)

    (ai:script ai:hum-08-attack-endloop) ) )

DefineAi('hum-08 "*" "hum-08"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:worker) 3)
    (ai:wait (ai:worker))	-- start hangs if nothing available

    (ai:force 0 (ai:soldier) 5 (ai:shooter) 4)
    (ai:sleep 14000)

    (ai:force 0 (ai:soldier) 5 (ai:shooter) 5 (ai:cavalrie) 3)
    (ai:sleep 10000)

    (ai:sleep 15000)

    (ai:research (ai:upgrade-cavalrie-mage))
    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:upgrade-missile-1))
    (ai:force 0 (ai:soldier) 2 (ai:shooter) 5 (ai:cavalrie) 4 (ai:catapult) 1)
    (ai:sleep 15000)

    (ai:research (ai:upgrade-weapon-1))
    (ai:research (ai:upgrade-armor-1))

    (ai:sleep 21000)

    (ai:research (ai:upgrade-elite-shooter))
    (ai:sleep 12000)

    (ai:script ai:hum-08-attack-endloop) ))

--=============================================================================
--	This AI script builds only worker and tanker.
--
DefineAi('hum-09 "*" "hum-09"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f) (ai:set-auto-attack #f) (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 2)
    (ai:set  (ai:tanker) 1)
    (ai:sleep	10000)
    (ai:restart)))

--=============================================================================
--	This AI script builds only worker and tanker.
--		Upgrades very much.
--		Attacks with land units and water units.
--
(define ai:hum-10-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep	5000)
    (ai:force 0 (ai:soldier) 4 (ai:shooter) 4 (ai:cavalrie) 4 (ai:catapult) 1 (ai:transporter) 1)

    (ai:sleep	6000)
    (ai:force 0 (ai:destroyer) 3 (ai:battleship) 1)

    (ai:sleep	5000)

    (ai:script ai:hum-10-attack-endloop) ) )

DefineAi('hum-10 "*" "hum-10"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:force-role 0 'defend) (ai:force-role 1 'defend)
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:worker) 7)
    (ai:set  (ai:tanker) 3)
    (ai:wait (ai:worker))	-- Wait for the workers

    (ai:set  (ai:transporter) 1)
    (ai:force 0 (ai:destroyer) 2 (ai:transporter) 1)
    (ai:sleep	6000)
    (ai:force 0 (ai:soldier) 4 (ai:shooter) 4
      (ai:destroyer) 2 (ai:transporter) 1)

    (ai:research (ai:upgrade-cavalrie-mage))
    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:mage-spell-1))
    (ai:research (ai:mage-spell-2))
    (ai:research (ai:upgrade-missile-1))

    (ai:force 0 (ai:soldier) 4 (ai:shooter) 4 (ai:transporter) 1 (ai:destroyer) 2)

    (ai:research (ai:upgrade-weapon-1))
    (ai:sleep	4000)
    (ai:research (ai:upgrade-armor-1))

    (ai:sleep	5000)
    (ai:force 0 (ai:destroyer) 3 (ai:battleship) 1)
    (ai:research (ai:upgrade-missile-2))
    (ai:research (ai:upgrade-weapon-2))

    (ai:research (ai:upgrade-ship-cannon-1))
    (ai:sleep	3000)
    (ai:research (ai:upgrade-armor-2))
    (ai:research (ai:upgrade-ship-armor-1))
    (ai:research (ai:upgrade-elite-shooter))

    (ai:research (ai:upgrade-catapult-1))
    (ai:research (ai:upgrade-ship-cannon-2))
    (ai:research (ai:upgrade-ship-armor-2))
    (ai:research (ai:upgrade-elite-shooter-1))
    (ai:force 0 (ai:soldier) 1 (ai:shooter) 2 (ai:mage) 1)
    (ai:sleep	5000)
    (ai:research (ai:upgrade-elite-shooter-2))
    (ai:research (ai:upgrade-elite-shooter-3))

    (ai:sleep	5000)

    (ai:script ai:hum-10-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers.
--		Upgrades very much.
--		Attacks with land units.
--
(define ai:hum-11-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep	12000)
    (ai:force 0 (ai:soldier) 1 (ai:shooter) 1 (ai:cavalrie) 1 (ai:catapult) 1
	(ai:mage) 3)

    (ai:sleep	8000)
    (ai:force 0 (ai:soldier) 1 (ai:shooter) 1 (ai:cavalrie) 1 (ai:catapult) 1
	(ai:mage) 3)

    (ai:sleep	13000)

    (ai:script ai:hum-11-attack-endloop) ) )

DefineAi('hum-11 "*" "hum-11"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:sleep (ai:get-sleep-cycles)))
    (ai:set  (ai:worker) 8)
    (ai:wait (ai:worker))	-- Wait for the workers

    (ai:sleep	6000)
    (ai:force 0 (ai:soldier) 2 (ai:shooter) 2 (ai:cavalrie) 2)

    (ai:sleep	6000)

    (ai:sleep	7000)
    (ai:force 0 (ai:soldier) 2 (ai:shooter) 2 (ai:cavalrie) 2)

    (ai:sleep	5000)
    (ai:force 0 (ai:soldier) 1 (ai:shooter) 1 (ai:cavalrie) 2 (ai:catapult) 1)
    (ai:research (ai:upgrade-missile-1))
    (ai:research (ai:upgrade-weapon-1))
    (ai:research (ai:upgrade-armor-1))

    (ai:sleep	6000)
    (ai:force 0 (ai:soldier) 1 (ai:shooter) 1 (ai:cavalrie) 1 (ai:catapult) 1	(ai:mage) 3)

    (ai:sleep	9000)

    (ai:sleep	7000)
    (ai:research (ai:upgrade-elite-shooter))
    (ai:research (ai:upgrade-elite-shooter-1))
    (ai:sleep	13000)


    (ai:research (ai:upgrade-elite-shooter-2))
    (ai:research (ai:mage-spell-1))

    (ai:research (ai:upgrade-cavalrie-mage))
    (ai:sleep	7000)
    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:mage-spell-2))
    (ai:research (ai:upgrade-weapon-2))
    (ai:sleep	12000)

    (ai:research (ai:upgrade-armor-2))
    (ai:research (ai:mage-spell-3))
    (ai:research (ai:mage-spell-4))
    (ai:research (ai:upgrade-catapult-1))

    (ai:sleep	8000)

    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:mage-spell-5))
    (ai:sleep	13000)


    (ai:script ai:hum-11-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and tankers.
--		Upgrades very much.
--		Attacks with land and water units.
--
(define ai:hum-12-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep	10000)
    (ai:force 0 (ai:soldier) 2 (ai:cavalrie) 10 (ai:mage) 2)

    (ai:sleep	5000)

    (ai:sleep	7000)
    (ai:force 0 (ai:destroyer) 2 (ai:battleship) 2 (ai:submarine) 5
	(ai:scout) 2) 

    (ai:script ai:hum-12-attack-endloop) ) )

DefineAi('hum-12 "*" "hum-12"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:force-role 0 'defend) (ai:force-role 1 'attack)
      (ai:force-role 2 'defend) (ai:force-role 3 'attack)
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:tanker) 3)
    (ai:set  (ai:worker) 7)
    (ai:wait (ai:worker))	-- Wait for the workers

    (ai:need (ai:platform))
    (ai:set  (ai:transporter) 2)

    (ai:force 0 (ai:soldier) 2)

    (ai:sleep	2000)

    (ai:force 0 (ai:destroyer) 2 (ai:battleship) 2 (ai:submarine) 4) 

    (ai:sleep	3000)
    
    (ai:force 0 (ai:soldier) 1 (ai:cavalrie) 10 (ai:mage) 2)

    (ai:research (ai:mage-spell-1))
    (ai:research (ai:upgrade-cavalrie-mage))
    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:mage-spell-2))
    (ai:research (ai:mage-spell-3))
    (ai:research (ai:mage-spell-4))
    (ai:research (ai:cavalrie-mage-spell-2))
    (ai:research (ai:mage-spell-5))
    (ai:research (ai:upgrade-ship-cannon-1))
    (ai:research (ai:upgrade-ship-armor-1))
    (ai:sleep	4000)

    (ai:force 0 (ai:destroyer) 2 (ai:battleship) 2 (ai:submarine) 4) 

    (ai:research (ai:upgrade-ship-cannon-2))
    (ai:research (ai:upgrade-ship-armor-2))
    (ai:research (ai:upgrade-catapult-1))
    (ai:research (ai:upgrade-catapult-2))
    (ai:sleep	6000)

    (ai:force 0 (ai:destroyer) 2 (ai:battleship) 2 (ai:submarine) 5) 

    (ai:sleep	7000)

    (ai:sleep	5000)

    (ai:force 0
	      (ai:soldier) 1 (ai:cavalrie) 10 (ai:mage) 2 (ai:catapult) 1
	      (ai:destroyer) 2 (ai:battleship) 2 (ai:submarine) 5 (ai:scout) 2) 

    (ai:research (ai:upgrade-missile-1))
    (ai:research (ai:upgrade-weapon-1))
    (ai:research (ai:upgrade-armor-1))
    (ai:research (ai:upgrade-missile-2))

    (ai:research (ai:upgrade-elite-shooter))
    (ai:research (ai:upgrade-elite-shooter-1))
    (ai:research (ai:upgrade-elite-shooter-2))
    (ai:research (ai:upgrade-elite-shooter-3))
    (ai:research (ai:upgrade-weapon-2))
    (ai:research (ai:upgrade-armor-2))

    (ai:script ai:hum-12-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and tankers.
--		Upgrades very much.
--		Attacks with land and air units.
--
(define ai:hum-13-attack-endloop
  '((writes nil "Looping !\n")

    (ai:sleep	12000)
    (ai:force 0 (ai:cavalrie) 3 (ai:mage) 2 (ai:shooter) 1 (ai:catapult) 2)

    (ai:sleep	14000)
    (ai:force 0 (ai:flyer) 4)
    (ai:sleep	14000)

    (ai:script ai:hum-13-attack-endloop) ) )

DefineAi('hum-13 "*" "hum-13"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)      
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:tanker) 2)
    (ai:set  (ai:worker) 5)
    (ai:wait (ai:worker))	-- Wait for the workers

    (ai:need (ai:platform))
    (ai:set  (ai:transporter) 2)

    (ai:force 0 (ai:cavalrie) 3 (ai:mage) 2)

    (ai:research (ai:mage-spell-1))
    (ai:research (ai:upgrade-cavalrie-mage))
    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:mage-spell-2))
    (ai:research (ai:mage-spell-3))
    (ai:research (ai:mage-spell-4))
    (ai:research (ai:cavalrie-mage-spell-2))

    (ai:sleep	4000)

    (ai:force 0 (ai:cavalrie) 4 (ai:mage) 2 (ai:shooter) 1)
    (ai:sleep	12000)

    (ai:sleep	15000)

    (ai:research (ai:mage-spell-5))
    (ai:research (ai:upgrade-ship-cannon-1))
    (ai:research (ai:upgrade-ship-armor-1))
    (ai:research (ai:upgrade-ship-cannon-2))
    (ai:research (ai:upgrade-ship-armor-2))
    (ai:force 0 (ai:cavalrie) 3 (ai:shooter) 1 (ai:mage) 2 (ai:catapult) 1)
    (ai:sleep	15000)

    (ai:force 0 (ai:flyer) 4)
    (ai:sleep	20000)

    (ai:sleep	14000)

    (ai:sleep	18000)

    (ai:research (ai:upgrade-catapult-1))
    (ai:research (ai:upgrade-catapult-2))
    (ai:research (ai:upgrade-missile-1))
    (ai:research (ai:upgrade-weapon-1))
    (ai:research (ai:upgrade-armor-1))
    (ai:research (ai:upgrade-missile-2))
    (ai:research (ai:upgrade-elite-shooter))

    (ai:script ai:hum-13-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and ogres.
--
(define ai:hum-14-orange-attack-endloop
  '((writes nil "Looping !\n")
    (ai:script ai:hum-14-orange-attack-endloop) ) )

DefineAi('hum-14-orange "*" "hum-14-orange"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:force-role 0 'defend) (ai:force-role 1 'attack)
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:worker) 5)
    (ai:wait (ai:worker))	-- Wait for the workers

    (ai:force 0 (ai:cavalrie) 15)

    (ai:script ai:hum-14-orange-attack-endloop) ))

--=============================================================================
--	This AI script builds nothing.
--		Does only upgrades.
--
(define ai:hum-14-red-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep	30000)
    (ai:sleep	30000)
    (ai:script ai:hum-14-red-attack-endloop) ) )

DefineAi('hum-14-red "*" "hum-14-red"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:force-role 0 'defend) (ai:force-role 1 'attack)
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:research (ai:mage-spell-1))
    (ai:research (ai:mage-spell-2))
    (ai:research (ai:mage-spell-3))
    (ai:research (ai:mage-spell-4))
    (ai:research (ai:mage-spell-5))

    (ai:script ai:hum-14-red-attack-endloop) ))

--=============================================================================
--	This AI script builds only workers and dragons.
--		Does only air attacks.
--
--	FIXME: This AI should only collect GOLD.
--
(define ai:hum-14-white-attack-endloop
  '((writes nil "Looping !\n")
    (ai:force 0 (ai:flyer) 10)
    (ai:sleep	19000)

    (ai:sleep	20000)

    (ai:force 1 (ai:flyer) 12)

    (ai:sleep	21000)

    (ai:sleep	20000)

    (ai:script ai:hum-14-white-attack-endloop) ) )

DefineAi('hum-14-white "*" "hum-14-white"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:force-role 0 'defend) (ai:force-role 1 'attack)
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:worker) 9)
    (ai:wait (ai:worker))	-- Wait for the workers

    (ai:force 1 (ai:flyer) 10)

    (ai:sleep	64000)

    (ai:sleep	12000)

    (ai:sleep	18000)

    (ai:script ai:hum-14-white-attack-endloop) ))

--=============================================================================
--	This AI script builds only tanker.
--		Does only upgrades.
--
--	FIXME: This AI should only collect GOLD.
--
(define ai:hum-14-black-attack-endloop
  '((writes nil "Looping !\n")
    (ai:sleep	30000)
    (ai:script ai:hum-14-black-attack-endloop) ) )

DefineAi('hum-14-black "*" "hum-14-black"
  '(
    --	Define the main AI script.
    (begin (ai:debug #f)
      (ai:force-role 0 'defend) (ai:force-role 1 'attack)
      (ai:sleep (ai:get-sleep-cycles)))

    (ai:set  (ai:tanker) 1)
    (ai:research (ai:upgrade-cavalrie-mage))
    (ai:research (ai:cavalrie-mage-spell-1))
    (ai:research (ai:cavalrie-mage-spell-2))
    (ai:research (ai:mage-spell-1))
    (ai:research (ai:mage-spell-2))
    (ai:research (ai:mage-spell-3))
    (ai:research (ai:mage-spell-4))
    (ai:research (ai:mage-spell-5))
    (ai:research (ai:upgrade-weapon-1))
    (ai:research (ai:upgrade-armor-1))
    (ai:research (ai:upgrade-weapon-2))
    (ai:research (ai:upgrade-armor-2))
    (ai:research (ai:upgrade-elite-shooter))
    (ai:research (ai:upgrade-elite-shooter-1))
    (ai:research (ai:upgrade-elite-shooter-2))
    (ai:research (ai:upgrade-elite-shooter-3))
    (ai:research (ai:upgrade-ship-cannon-1))
    (ai:research (ai:upgrade-ship-armor-1))
    (ai:research (ai:upgrade-ship-cannon-2))
    (ai:research (ai:upgrade-ship-armor-2))

    (ai:script ai:hum-14-black-attack-endloop) ))
]]
