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
--	upgrade.lua	-	Define the dependencies and upgrades.
--
--	(c) Copyright 2001 by Lutz Sammer
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

-- Load the different races
Load("scripts/human/upgrade.lua")
Load("scripts/orc/upgrade.lua")

--	NOTE: Save can generate this table.

DefineAllow("unit-nothing-22",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-nothing-24",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-nothing-25",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-nothing-30",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-nothing-36",			"AAAAAAAAAAAAAAAA")

DefineAllow("unit-critter",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-skeleton",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-daemon",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-gold-mine",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-oil-patch",			"AAAAAAAAAAAAAAAA")

DefineAllow("unit-circle-of-power",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-dark-portal",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-runestone",			"AAAAAAAAAAAAAAAA")

DefineAllow("unit-dead-body",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-destroyed-1x1-place",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-destroyed-2x2-place",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-destroyed-3x3-place",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-destroyed-4x4-place",		"AAAAAAAAAAAAAAAA")
