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
--      anim.lua - The unit animation definitions.
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
--      $Id$


UnitStill = {"frame 0", "wait 4", "random-goto 99 no-rotate", "random-rotate 1", "label no-rotate", "wait 1",}
BuildingStill = {"frame 0", "wait 4", "frame 0", "wait 1",}

Load("scripts/human/anim.lua")
Load("scripts/orc/anim.lua")


DefineAnimations("animations-daemon", {
  Still = {"frame 0", "wait 4", "frame 5", "wait 4", "frame 10", "wait 4",
    "frame 15", "wait 4",},
  Move = {"unbreakable begin", "frame 0", "move 3", "wait 1", "frame 0", "move 3", "wait 1",
    "frame 5", "move 2", "wait 1", "frame 5", "move 3", "wait 1",
    "frame 10", "move 2", "wait 1", "frame 10", "move 3", "wait 1",
    "frame 10", "move 3", "wait 1", "frame 15", "move 2", "wait 1",
    "frame 15", "move 3", "wait 1", "frame 20", "move 3", "wait 1",
    "frame 20", "move 3", "wait 1", "frame 0", "move 2", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "wait 4", "frame 5", "wait 4",
    "frame 10", "wait 4", "frame 15", "wait 4", "frame 20", "wait 4",
    "frame 20", "wait 1", "frame 25", "wait 4", "frame 30", "wait 4",
    "frame 35", "wait 4", "frame 40", "attack", "wait 4",
    "frame 45", "wait 4", "frame 0", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 50", "wait 5", "frame 55", "wait 5", "frame 60", "wait 5",
    "frame 65", "wait 5", "frame 65", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-critter", {
  Still = {"frame 0", "wait 4", "frame 0", "wait 1",},
  Move = {"unbreakable begin", "frame 0", "move 2", "wait 2", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "move 2", "wait 3", "frame 0", "move 2", "wait 3",
    "frame 0", "unbreakable end", "wait 1",},
  Attack = {"unbreakable begin", "frame 0", "attack", "unbreakable end", "wait 1",},
  Death = {"unbreakable begin", "frame 5", "wait 200", "frame 5", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-building", {
  Still = BuildingStill,
  Research = BuildingStill,
  Train = BuildingStill,
  Upgrade = BuildingStill,
})


DefineAnimations("animations-dead-body", {
  Death = {"unbreakable begin", "frame 5", "wait 200", "frame 10", "wait 200", "frame 15", "wait 200",
    "frame 20", "wait 200", "frame 25", "wait 200", "frame 25", "unbreakable end", "wait 1",},
})


DefineAnimations("animations-destroyed-place", {
  Death = {"unbreakable begin", "frame 0", "wait 200", "frame 1", "wait 200", "frame 1", "unbreakable end", "wait 1", },
})

