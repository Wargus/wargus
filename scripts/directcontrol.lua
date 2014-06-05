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
--	(c) Copyright 2014 by Kyran Jackson
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
--      Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--

local Northing
local Easting

function DirectControl(Direction)
	if (Northing == nil) then
		Northing = 0
	end
	if (Easting == nil) then
		Easting = 0
	end
	if (Direction == "North") then
		Northing = Northing + 1
	end
	if (Direction == "South") then
		Northing = Northing - 1
	end
	if (Direction == "East") then
		Easting = Easting + 1
	end
	if (Direction == "West") then
		Easting = Easting - 1
	end
	if ((Direction == "West") or (Direction == "East") or (Direction == "South") or (Direction == "North")) then
		CenterMap(64+(19*Easting), 62-(18*Northing))
	end
end