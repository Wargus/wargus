--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--			  T H E   W A R   B E G I N S
--	   Stratagus - A free fantasy real time strategy game engine
--
--	buttons.ccl	-	Define the general unit-buttons.
--
--	(c) Copyright 2001 by Vladi Belperchinov-Shabanski and Lutz Sammer
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
--	$Id$

-- Load the buttons of all races

Load("ccl/human/buttons.lua")
Load("ccl/orc/buttons.lua")

------------------------------------------------------------------------------
--	Define unit-button.
--
--	DefineButton("pos", n "level", n "icon", ident "action", name ['value value]
--		['allowed check ['values]] "key", key "hint", hint "for-unit", units)
--

-- neutral --------------------------------------------------------------------

if (extensions) then
DefineButton("pos", 1, "level", 0, "icon", "icon-circle-of-power",
  "action", "cast-spell", "value", "spell-circle-of-power",
  "allowed", "check-true",
  "key", "d", "hint", "SET ~!DESTINATION",
  "for-unit", {"unit-dark-portal"})
end

if (extensions) then
DefineButton("pos", 2, "level", 0, "icon", "icon-daemon",
  "action", "train-unit", "value", "unit-daemon",
  "key", "d", "hint", "SUMMON ~!DAEMON",
  "for-unit", {"unit-dark-portal"})
end

-- general cancel button ------------------------------------------------------

DefineButton("pos", 9, "level", 9, "icon", "icon-cancel",
  "action", "cancel",
  "key", "\033", "hint", "~<ESC~> CANCEL",
  "for-unit", {"*"})

DefineButton("pos", 9, "level", 0, "icon", "icon-cancel",
  "action", "cancel-upgrade",
  "key", "\033", "hint", "~<ESC~> CANCEL UPGRADE",
  "for-unit", {"cancel-upgrade"})

DefineButton("pos", 9, "level", 0, "icon", "icon-cancel",
  "action", "cancel-train-unit",
  "key", "\033", "hint", "~<ESC~> CANCEL UNIT TRAINING",
  "for-unit", {"*"})

DefineButton("pos", 9, "level", 0, "icon", "icon-cancel",
  "action", "cancel-build",
  "key", "\033", "hint", "~<ESC~> CANCEL CONSTRUCTION",
  "for-unit", {"cancel-build"})
