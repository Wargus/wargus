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
--      tilesets.lua - Define the used tilesets.
--
--      (c) Copyright 1998-2004 by Lutz Sammer and Jimmy Salmon
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

--=============================================================================
--	Load the different tileset definitions
--
--	FIXME: need a way to automatic load all available tileset definitions

Load("scripts/wc2-config.lua")

DefineTileset("tileset-summer", "class", "summer", "name", "Forest",
  "file", "scripts/tilesets/summer.lua")
DefineTileset("tileset-winter", "class", "winter", "name", "Winter",
  "file", "scripts/tilesets/winter.lua")
DefineTileset("tileset-wasteland", "class", "wasteland", "name", "Wasteland",
  "file", "scripts/tilesets/wasteland.lua")
if (expansion) then
  DefineTileset("tileset-swamp", "class", "swamp", "name", "Swamp",
    "file", "scripts/tilesets/swamp.lua")
else
  DefineTileset("tileset-swamp", "class", "swamp", "name", "Swamp",
    "file", "scripts/tilesets/dummy-swamp.lua")
end
