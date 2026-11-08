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
--      upgrade.ccl - Define the human dependencies and upgrades.
--
--      (c) Copyright 2014 by Kyran Jackson
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

DefineModifier("upgrade-sword1",
  {"Level", 1},
  {"PiercingDamage", 2},
  {"apply-to", "unit-caanoo-oathbreaker"}, {"apply-to", "unit-human-adventurer"}, {"apply-to", "unit-order-paladin"})

DefineModifier("upgrade-sword2",
  {"Level", 1},
  {"PiercingDamage", 2},
  {"apply-to", "unit-caanoo-oathbreaker"}, {"apply-to", "unit-human-adventurer"}, {"apply-to", "unit-order-paladin"})

DefineModifier("upgrade-arrow1",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-yeoman"})

DefineModifier("upgrade-arrow2",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-yeoman"})

DefineModifier("upgrade-human-shield1",
  {"Level", 1},
  {"Armor", 2},
  {"apply-to", "unit-caanoo-oathbreaker"}, {"apply-to", "unit-human-adventurer"}, {"apply-to", "unit-order-paladin"})

DefineModifier("upgrade-human-shield2",
  {"Level", 1},
  {"Armor", 2},
  {"apply-to", "unit-caanoo-oathbreaker"}, {"apply-to", "unit-human-adventurer"}, {"apply-to", "unit-order-paladin"})

DefineModifier("upgrade-longbow",
  {"Level", 1},
  {"SightRange", 1},
  {"AttackRange", 1},
  {"apply-to", "unit-yeoman"})

DefineModifier("upgrade-ranger-scouting",
  {"Level", 1},
  {"SightRange", 3},
  {"apply-to", "unit-yeoman"})

DefineModifier("upgrade-ranger-marksmanship",
  {"Level", 1},
  {"PiercingDamage", 3},
  {"apply-to", "unit-yeoman"})

DefineModifier("upgrade-holy-vision",
  {"Level", 1},
  {"apply-to", "unit-order-paladin"})

DefineModifier("upgrade-healing",
  {"Level", 1},
  {"apply-to", "unit-order-paladin"})

DefineModifier("upgrade-exorcism",
  {"Level", 1},
  {"apply-to", "unit-order-paladin"})
  
DefineModifier("upgrade-throwing-axe1",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-nomad"})

DefineModifier("upgrade-throwing-axe2",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-nomad"})

DefineModifier("upgrade-light-axes",
  {"Level", 1},
  {"SightRange", 1},
  {"AttackRange", 1},
  {"apply-to", "unit-nomad"})

DefineModifier("upgrade-berserker-scouting",
  {"Level", 1},
  {"SightRange", 3},
  {"apply-to", "unit-nomad"})

DefineModifier("upgrade-berserker-regeneration",
  {"Level", 1},
  {"regeneration-rate", 1},
  {"apply-to", "unit-nomad"})