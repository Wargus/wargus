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
--	constructions.ccl	-	Define the human constructions.
--
--	(c) Copyright 2001,2003 by Lutz Sammer and Jimmy Salmon
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

--=============================================================================
--	Define a construction.
--
--	(define-construction ident 'files '(tileset-name filename ..)
--	    'size '(x y))

local files = {summer = "human/buildings/shipyard_construction_site.png",
  winter = "tilesets/winter/human/buildings/shipyard_construction_site.png",
  wasteland = "human/buildings/shipyard_construction_site.png",
  swamp = "tilesets/swamp/human/buildings/shipyard_construction_site.png"}

DefineConstruction("construction-human-shipyard", {
  Files = {
    File = files[tileset],
    Size = {96, 96}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 25,
    File = "construction",
    Frame = 1},
   {Percent = 50,
    File = "main",
    Frame = 1}}
})

local files = {summer = "tilesets/summer/human/buildings/oil_well_construction_site.png",
  winter = "tilesets/winter/human/buildings/oil_well_construction_site.png",
  wasteland = "tilesets/wasteland/human/buildings/oil_well_construction_site.png",
  swamp = "tilesets/swamp/human/buildings/oil_platform_construction_site.png"}

DefineConstruction("construction-human-oil-well", {
  Files = {
    File = files[tileset],
    Size = {96, 96}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 25,
    File = "construction",
    Frame = 1},
   {Percent = 50,
    File = "main",
    Frame = 1}}
})

local files = {summer = "human/buildings/refinery_construction_site.png",
  winter = "tilesets/winter/human/buildings/refinery_construction_site.png",
  wasteland = "human/buildings/refinery_construction_site.png",
  swamp = "tilesets/swamp/human/buildings/refinery_construction_site.png"}

DefineConstruction("construction-human-refinery", {
  Files = {
    File = files[tileset],
    Size = {96, 96}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 25,
    File = "construction",
    Frame = 1},
   {Percent = 50,
    File = "main",
    Frame = 1}}
})

local files = {summer = "human/buildings/foundry_construction_site.png",
  winter = "tilesets/winter/human/buildings/foundry_construction_site.png",
  wasteland = "human/buildings/foundry_construction_site.png",
  swamp = "tilesets/swamp/human/buildings/foundry_construction_site.png"}

DefineConstruction("construction-human-foundry", {
  Files = {
    File = files[tileset],
    Size = {96, 96}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 25,
    File = "construction",
    Frame = 1},
   {Percent = 50,
    File = "main",
    Frame = 1}}
})
