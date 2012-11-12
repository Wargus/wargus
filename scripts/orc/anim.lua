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
--      anim.lua - The orc unit animation definitions.
--
--      (c) Copyright 2000-2005 by Josh Cogliati, Lutz Sammer,
--                                 and Jimmy Salmon
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

--
-- grunt, beast-cry, and quick-blade
--

local GruntStill = UnitStill
local GruntMove = {"unbreakable begin","frame 0", "move 3", "wait 2", "frame 5", "move 3", "wait 1",
    "frame 5", "move 3", "wait 2", "frame 10", "move 2", "wait 1",
    "frame 10", "move 3", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 3", "wait 2", "frame 15", "move 3", "wait 1",
    "frame 15", "move 3", "wait 2", "frame 20", "move 2", "wait 1",
    "frame 20", "move 3", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",}
local GruntDeath = {"unbreakable begin", "frame 45", "wait 3", "frame 50", "wait 3", "frame 55", "wait 100",
    "frame 55", "unbreakable end", "wait 1",}

DefineAnimations("animations-grunt", {
  Still = GruntStill,
  Move = GruntMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound grunt-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = GruntDeath,
})

DefineAnimations("animations-beast-cry", {
  Still = GruntStill,
  Move = GruntMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound grom-hellscream-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = GruntDeath,
})

DefineAnimations("animations-quick-blade", {
  Still = GruntStill,
  Move = GruntMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound korgath-bladefist-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = GruntDeath,
})


DefineAnimations("animations-peon", {
  Still = UnitStill,
  Move = {"unbreakable begin", "frame 0", "move 3", "wait 2", "frame 5", "move 3", "wait 1",
    "frame 5", "move 3", "wait 2", "frame 10", "move 2", "wait 1",
    "frame 10", "move 3", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 3", "wait 2", "frame 15", "move 3", "wait 1",
    "frame 15", "move 3", "wait 2", "frame 20", "move 2", "wait 1",
    "frame 20", "move 3", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound peon-attack", "wait 5", "frame 45", "wait 3",
    "frame 25", "wait 7", "frame 25", "unbreakable end", "wait 1",},
  Harvest_wood = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "sound tree-chopping", "wait 5", "frame 45", "wait 3",
    "frame 25", "wait 7", "frame 25", "unbreakable end", "wait 1",},
  Repair = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "sound peon-attack", "wait 5", "frame 45", "wait 3",
    "frame 25", "wait 7", "frame 25", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 50", "wait 3", "frame 55", "wait 3", "frame 60", "wait 100",
    "frame 60", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-catapult", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1",},
  Move = {"unbreakable begin","frame 0", "wait 1", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 5", "move 2", "wait 2",
    "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 15", "attack", "sound catapult-attack","wait 4",
    "frame 10", "wait 4", "frame 15", "wait 3", "frame 10", "wait 2", "frame 15", "wait 2",
    "frame 10", "wait 30", "frame 15", "wait 4", "frame 15", "wait 100", "frame 0", "wait 50", "frame 0", "unbreakable end", "wait 1",},
})


--
-- ogre, ogre-mage, fad-man, and double-head
--

local OgreStill = UnitStill
local OgreMove = {"unbreakable begin","frame 0", "move 3", "wait 1", "frame 5", "move 3", "wait 1",
    "frame 5", "move 3", "wait 1", "frame 10", "move 2", "wait 1",
    "frame 10", "move 3", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 3", "wait 1", "frame 15", "move 3", "wait 1",
    "frame 15", "move 3", "wait 1", "frame 20", "move 2", "wait 1",
    "frame 20", "move 3", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",}
local OgreDeath = {"unbreakable begin", "frame 45", "wait 3", "frame 50", "wait 3", "frame 55", "wait 100",
    "frame 60", "wait 200", "frame 65", "wait 200", "frame 65", "unbreakable end", "wait 1",}

DefineAnimations("animations-ogre", {
  Still = OgreStill,
  Move = OgreMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound ogre-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = OgreDeath,
})

DefineAnimations("animations-ogre-mage", {
  Still = OgreStill,
  Move = OgreMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound ogre-mage-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = OgreDeath,
})

DefineAnimations("animations-fad-man", {
  Still = OgreStill,
  Move = OgreMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound dentarg-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = OgreDeath,
})

DefineAnimations("animations-double-head", {
  Still = OgreStill,
  Move = OgreMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound cho-gall-attack", "wait 5", "frame 0", "wait 10",
    "frame 0", "unbreakable end", "wait 1",},
  Death = OgreDeath,
})


--
-- axethrower, berserker, and sharp-axe
--

local AxeThrowerStill = UnitStill
local AxeThrowerMove = {"unbreakable begin","frame 0", "move 3", "wait 2", "frame 5", "move 3", "wait 1",
    "frame 5", "move 3", "wait 2", "frame 10", "move 2", "wait 1",
    "frame 10", "move 3", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 3", "wait 2", "frame 15", "move 3", "wait 1",
    "frame 15", "move 3", "wait 2", "frame 20", "move 2", "wait 1",
    "frame 20", "move 3", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",}
local AxeThrowerDeath = {"unbreakable begin", "frame 45", "wait 3", "frame 50", "wait 3", "frame 55", "wait 100",
    "frame 55", "unbreakable end", "wait 1",}

DefineAnimations("animations-axethrower", {
  Still = AxeThrowerStill,
  Move = AxeThrowerMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound axethrower-attack", "wait 12",
    "frame 0", "wait 52", "frame 0", "unbreakable end", "wait 1",},
  Death = AxeThrowerDeath,
})

DefineAnimations("animations-berserker", {
  Still = AxeThrowerStill,
  Move = AxeThrowerMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound berserker-attack", "wait 12",
    "frame 0", "wait 52", "frame 0", "unbreakable end", "wait 1",},
  Death = AxeThrowerDeath,
})

DefineAnimations("animations-sharp-axe", {
  Still = AxeThrowerStill,
  Move = AxeThrowerMove,
  Attack = {"unbreakable begin", "frame 25", "wait 3", "frame 30", "wait 3", "frame 35", "wait 3",
    "frame 40", "attack", "sound zuljin-attack", "wait 12",
    "frame 0", "wait 52", "frame 0", "unbreakable end", "wait 1",},
  Death = AxeThrowerDeath,
})


--
-- death-knight, evil-knight, and ice-bringer
--

local DeathKnightStill = UnitStill
local DeathKnightMove = {"unbreakable begin","frame 0", "move 3", "wait 2", "frame 5", "move 3", "wait 2",
    "frame 5", "move 4", "wait 2", "frame 10", "move 3", "wait 2",
    "frame 10", "move 3", "wait 2", "frame 15", "move 3", "wait 2",
    "frame 15", "move 4", "wait 2", "frame 20", "move 3", "wait 2",
    "frame 20", "move 3", "wait 2", "frame 0", "move 3", "unbreakable end", "wait 1",}
local DeathKnightDeath = {"unbreakable begin", "frame 45", "wait 5", "frame 50", "wait 5", "frame 55", "wait 5",
    "frame 60", "wait 5", "frame 60", "unbreakable end", "wait 1",}

DefineAnimations("animations-death-knight", {
  Still = DeathKnightStill,
  Move = DeathKnightMove,
  Attack = {"unbreakable begin", "frame 25", "wait 5", "frame 30", "wait 5",
    "frame 35", "attack", "sound death-knight-attack", "wait 7",
    "frame 40", "wait 5", "frame 0", "wait 17", "frame 0", "unbreakable end", "wait 1",},
  Death = DeathKnightDeath,
})

DefineAnimations("animations-evil-knight", {
  Still = DeathKnightStill,
  Move = DeathKnightMove,
  Attack = {"unbreakable begin", "frame 25", "wait 5", "frame 30", "wait 5",
    "frame 35", "attack", "sound teron-gorefiend-attack", "wait 7",
    "frame 40", "wait 5", "frame 0", "wait 17", "frame 0", "unbreakable end", "wait 1",},
  Death = DeathKnightDeath,
})

DefineAnimations("animations-ice-bringer", {
  Still = DeathKnightStill,
  Move = DeathKnightMove,
  Attack = {"unbreakable begin", "frame 25", "wait 5", "frame 30", "wait 5",
    "frame 35", "attack", "sound gul-dan-attack", "wait 7",
    "frame 40", "wait 5", "frame 0", "wait 17", "frame 0", "unbreakable end", "wait 1",},
  Death = DeathKnightDeath,
})


DefineAnimations("animations-goblin-sappers", {
  Still = UnitStill,
  Move = {"unbreakable begin", "frame 0", "move 3", "wait 1", "frame 10", "move 3", "wait 1",
    "frame 10", "move 2", "wait 1", "frame 25", "move 3", "wait 2",
    "frame 25", "move 3", "wait 1", "frame 40", "move 2", "wait 1",
    "frame 40", "move 3", "wait 1", "frame 55", "move 3", "wait 1",
    "frame 55", "move 2", "wait 1", "frame 65", "move 3", "wait 2",
    "frame 65", "move 3", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 15", "wait 3",
    "frame 30", "attack", "sound goblin-sappers-attack", "wait 5",
    "frame 45", "wait 3", "frame 0", "wait 13", "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 5", "wait 3", "frame 20", "wait 3", "frame 35", "wait 3",
    "frame 50", "wait 3", "frame 60", "wait 3", "frame 70", "wait 3",
    "frame 70", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-orc-oil-tanker", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1",},
  Move = {"unbreakable begin", "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "attack", "wait 30",
    "frame 0", "wait 99", "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 5", "wait 50", "frame 10", "wait 50", "frame 10", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-orc-transport", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1",},
  Move = {"unbreakable begin", "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "attack", "wait 119",
    "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 5", "wait 50", "frame 10", "wait 50", "frame 10", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-troll-destroyer", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1", },
  Move = {"unbreakable begin", "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "attack", "sound troll-destroyer-attack", "wait 119",
    "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 5", "wait 50", "frame 10", "wait 50", "frame 10", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-ogre-juggernaught", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1", },
  Move = {"unbreakable begin", "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 2",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 2",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 2",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "attack", "sound ogre-juggernaught-attack", "wait 127",
    "frame 0", "wait 102", "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 5", "wait 50", "frame 10", "wait 50", "frame 10", "unbreakable end", "wait 1",},
})


--
-- dragon, fire-breeze
--

local DragonStill = {"frame 0", "wait 6", "frame 5", "wait 6", "frame 10", "wait 6",
    "frame 15", "wait 6",}
local DragonMove = {"unbreakable begin", "frame 0", "wait 1", "frame 0", "move 6", "wait 2",
    "frame 5", "move 6", "wait 2", "frame 5", "move 3", "wait 1",
    "frame 10", "move 5", "wait 2", "frame 10", "move 3", "wait 1",
    "frame 15", "move 6", "wait 2",
    "frame 0", "move 3", "unbreakable end", "wait 1",}
local DragonDeath = {"unbreakable begin", "frame 25", "wait 5", "frame 30", "wait 5", "frame 35", "wait 5",
    "frame 40", "wait 5", "frame 45", "wait 5", "frame 45", "unbreakable end", "wait 1",}

DefineAnimations("animations-dragon", {
  Still = DragonStill,
  Move = DragonMove,
  Attack = {"unbreakable begin", "frame 0", "wait 6", "frame 5", "wait 6",
    "frame 10", "wait 6", "frame 15", "wait 6", "frame 15", "wait 1",
    "frame 20", "attack", "sound dragon-attack", "wait 20",
    "frame 0", "wait 6", "frame 5", "wait 6", "frame 10", "wait 6",
    "frame 15", "wait 6", "frame 0", "wait 6", "frame 5", "wait 6",
    "frame 10", "wait 6", "frame 15", "wait 6", "frame 0", "wait 6",
    "frame 5", "wait 6", "frame 10", "wait 6", "frame 15", "wait 6",
    "frame 0", "wait 6", "frame 5", "wait 6", "frame 10", "wait 6",
    "frame 15", "wait 6", "frame 0", "wait 6", "frame 5", "wait 6",
    "frame 10", "wait 6", "frame 15", "wait 6", "frame 0", "wait 6",
    "frame 5", "wait 6", "frame 10", "wait 6", "frame 15", "wait 6",
    "frame 0", "unbreakable end", "wait 1",},
  Death = DragonDeath
})

DefineAnimations("animations-fire-breeze", {
  Still = DragonStill,
  Move = DragonMove,
  Attack = {"unbreakable begin", "frame 0", "wait 6", "frame 5", "wait 6",
    "frame 10", "wait 6", "frame 15", "wait 6", "frame 15", "wait 1",
    "frame 20", "attack", "sound deathwing-attack", "wait 20",
    "frame 0", "wait 6", "frame 5", "wait 6", "frame 10", "wait 6",
    "frame 15", "wait 6", "frame 0", "wait 6", "frame 5", "wait 6",
    "frame 10", "wait 6", "frame 15", "wait 6", "frame 0", "wait 6",
    "frame 5", "wait 6", "frame 10", "wait 6", "frame 15", "wait 6",
    "frame 0", "wait 6", "frame 5", "wait 6", "frame 10", "wait 6",
    "frame 15", "wait 6", "frame 0", "wait 6", "frame 5", "wait 6",
    "frame 10", "wait 6", "frame 15", "wait 6", "frame 0", "wait 6",
    "frame 5", "wait 6", "frame 10", "wait 6", "frame 15", "wait 6",
    "frame 0", "unbreakable end", "wait 1",},
  Death = DragonDeath
})


DefineAnimations("animations-orc-submarine", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1",},
  Move = {"unbreakable begin", "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 2",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 2",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 1", "frame 0", "move 2", "wait 1",
    "frame 0", "move 2", "wait 2", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 5", "wait 10", "frame 10", "wait 25",
    "frame 10", "attack", "sound giant-turtle-attack", "wait 25",
    "frame 5", "wait 25", "frame 0", "wait 29", "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 0", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-goblin-zeppelin", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1",},
  Move = {"unbreakable begin", "frame 0", "move 4", "wait 1", "frame 0", "move 3", "wait 1",
    "frame 0", "move 3", "wait 1", "frame 0", "move 3", "wait 1",
    "frame 0", "move 3", "wait 1", "frame 0", "move 4", "wait 1",
    "frame 0", "move 3", "wait 1", "frame 0", "move 3", "wait 1",
    "frame 0", "move 3", "wait 1", "frame 0", "move 3", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-eye-of-vision", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1", },
  Move = {"unbreakable begin", "frame 0", "move 8", "wait 1", "frame 0", "move 8", "wait 1",
    "frame 0", "move 8", "wait 1", "frame 0", "move 8", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-skeleton", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1", },
  Move = {"unbreakable begin", "frame 0", "move 3", "wait 2", "frame 10", "move 3", "wait 2",
    "frame 10", "move 3", "wait 1", "frame 25", "move 2", "wait 2",
    "frame 25", "move 3", "wait 3", "frame 0", "move 2", "wait 1",
    "frame 0", "move 3", "wait 2", "frame 40", "move 3", "wait 2",
    "frame 40", "move 3", "wait 1", "frame 55", "move 2", "wait 2",
    "frame 55", "move 3", "wait 2", "frame 0", "move 2", "unbreakable end", "wait 1", },
  Attack = {"unbreakable begin", "frame 15", "wait 4", "frame 30", "wait 4",
    "frame 45", "attack", "sound skeleton-attack", "wait 4",
    "frame 60", "wait 4", "frame 0", "wait 18", "frame 0", "unbreakable end", "wait 1", },
  Death = {"unbreakable begin", "frame 5", "wait 3", "frame 20", "wait 3", "frame 35", "wait 3",
    "frame 50", "wait 3", "frame 65", "wait 3", "frame 65", "unbreakable end", "wait 1", },
})


DefineAnimations("animations-orc-guard-tower", {
  Still = BuildingStill,
  Attack = {"unbreakable begin", "frame 0", "attack", "wait 59",
    "frame 0", "unbreakable end", "wait 1",},
})

--------
--	Cannon Tower, Cannon Tower
DefineAnimations("animations-orc-cannon-tower", {
  Still = BuildingStill,
  Attack = {"unbreakable begin", "frame 0", "attack", "wait 150",
    "frame 0", "unbreakable end", "wait 1",},
})

