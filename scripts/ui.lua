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
--	ui.ccl		-	Define the user interface
--
--	(c) Copyright 2000,2002 by Lutz Sammer
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

Load("ccl/human/ui.lua")
Load("ccl/orc/ui.lua")

DefineCursor("cursor-glass", "any",
    "image", "ui/cursors/magnifying_glass.png",
    "hot-spot", {11, 11}, "size", {34, 35} )
DefineCursor("cursor-cross", "any",
    "image", "ui/cursors/small_green_cross.png",
    "hot-spot", { 8,  8}, "size", {18, 18} )
DefineCursor("cursor-scroll", "any",
    "image", "ui/cursors/cross.png", "hot-spot", {15, 15}, "size", {32, 32} )
DefineCursor("cursor-arrow-e", "any",
    "image", "ui/cursors/arrow_E.png", "hot-spot", {22, 10}, "size", {32, 24} )
DefineCursor("cursor-arrow-ne", "any",
    "image", "ui/cursors/arrow_NE.png", "hot-spot", {20,  2}, "size", {32, 24} )
DefineCursor("cursor-arrow-n", "any",
    "image", "ui/cursors/arrow_N.png", "hot-spot", {12,  2}, "size", {32, 24} )
DefineCursor("cursor-arrow-nw", "any",
    "image", "ui/cursors/arrow_NW.png", "hot-spot", { 2,  2}, "size", {32, 24} )
DefineCursor("cursor-arrow-w", "any",
    "image", "ui/cursors/arrow_W.png", "hot-spot", { 4, 10}, "size", {32, 24} )
DefineCursor("cursor-arrow-s", "any",
    "image", "ui/cursors/arrow_S.png", "hot-spot", {12, 22}, "size", {32, 24} )
DefineCursor("cursor-arrow-sw", "any",
    "image", "ui/cursors/arrow_SW.png", "hot-spot", { 2, 18}, "size", {32, 24} )
DefineCursor("cursor-arrow-se", "any",
    "image", "ui/cursors/arrow_SE.png", "hot-spot", {20, 18}, "size", {32, 24} )
