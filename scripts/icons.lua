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
--      icons.ccl - Define the icons.
--
--      (c) Copyright 2001-2004 by Lutz Sammer and Jimmy Salmon
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

--	NOTE:
--		Splitting this file into races is a problem, because all
--		icons are in a single file.


--	FIXME: can be removed: Set the icon size (width height)
SetIconSize( 46, 38)

--=============================================================================
--	Define an icon.
--
--	(define-icon ident 'tileset tileset 'size (x y) type (index file})
--
--	ident	is the name of the icon
--	tileset is the name of the tileset
--	type	is the 'normal
--	index	is the index into the graphic file
--	file	is the filename of the graphic file containing the graphics
--

--=============================================================================
--	Summer Tileset
--=============================================================================

DefineIcon({
  Name = "icon-peasant",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 0,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-peon",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 1,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-footman",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 2,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-grunt",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 3,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-archer",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 4,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-axethrower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 5,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ranger",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 6,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-berserker",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 7,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-knight",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 8,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ogre",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 9,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-paladin",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 10,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ogre-mage",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 11,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-dwarves",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 12,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-goblin-sappers",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 13,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mage",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 14,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-death-knight",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 15,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ballista",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 16,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-catapult",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 17,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-tanker",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 18,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-tanker",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 19,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-transport",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 20,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-transport",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 21,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-destroyer",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 22,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-destroyer",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 23,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-battleship",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 24,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ogre-juggernaught",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 25,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-gnomish-submarine",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 26,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-giant-turtle",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 27,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-gnomish-flying-machine",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 28,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-zeppelin",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 29,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-gryphon-rider",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 30,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-dragon",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 31,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-wise-man",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 32,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ice-bringer",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 33,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-man-of-light",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 34,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-sharp-axe",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 35,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-double-head",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 36,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-daemon",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 37,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-farm",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 38,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-pig-farm",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 39,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-town-hall",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 40,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-great-hall",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 41,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-barracks",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 42,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-barracks",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 43,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-elven-lumber-mill",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 44,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-troll-lumber-mill",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 45,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-blacksmith",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 46,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-blacksmith",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 47,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-shipyard",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 48,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-shipyard",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 49,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-refinery",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 50,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-refinery",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 51,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-foundry",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 52,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-foundry",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 53,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-platform",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 54,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-platform",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 55,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-stables",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 56,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ogre-mound",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 57,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-gnomish-inventor",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 58,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alchemist",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 59,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-watch-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 60,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-watch-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 61,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-church",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 62,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-altar-of-storms",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 63,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mage-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 64,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-temple-of-the-damned",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 65,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-keep",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 66,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-stronghold",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 67,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-castle-upgrade",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 68,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-fortress-upgrade",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 69,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-castle",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 70,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-fortress",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 71,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-gryphon-aviary",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 72,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-dragon-roost",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 73,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-gold-mine",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 74,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-guard-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 75,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-cannon-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 76,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-guard-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 77,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-cannon-tower",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 78,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-oil-patch",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 79,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-dark-portal",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 80,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-circle-of-power",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 81,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-runestone",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 82,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-move-peasant",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 83,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-move-peon",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 84,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-repair",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 85,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-harvest",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 86,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-build-basic",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 87,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-build-advanced",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 88,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peasant",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 89,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peon",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 90,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-cancel",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 91,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-wall",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 92,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-wall",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 93,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-slow",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 94,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-invisibility",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 95,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-haste",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 96,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-runes",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 97,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-unholy-armor",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 98,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-lightning",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 99,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-flame-shield",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 100,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-fireball",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 101,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-touch-of-darkness",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 102,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-death-coil",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 103,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-whirlwind",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 104,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-blizzard",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 105,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-holy-vision",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 106,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-heal",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 107,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-death-and-decay",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 108,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-109",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 109,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-exorcism",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 110,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-eye-of-kilrogg",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 111,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-bloodlust",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 112,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-unknown113",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 113,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-skeleton",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 114,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-critter",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 115,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-sword1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 116,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-sword2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 117,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-sword3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 118,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-battle-axe1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 119,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-battle-axe2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 120,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-battle-axe3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 121,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-122",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 122,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-123",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 123,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-arrow1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 124,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-arrow2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 125,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-arrow3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 126,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 127,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 128,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 129,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-horse1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 130,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-horse2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 131,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-longbow",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 132,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ranger-scouting",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 133,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ranger-marksmanship",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 134,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-light-axes",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 135,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-berserker-scouting",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 136,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-berserker-regeneration",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 137,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-catapult1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 138,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-catapult2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 139,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ballista1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 140,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ballista2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 141,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-demolish",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 142,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-demolish",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 143,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 144,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 145,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 146,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 147,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 148,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 149,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 150,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 151,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 152,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 153,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 154,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 155,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-move",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 156,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-move",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 157,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-return-oil",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 158,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-return-oil",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 159,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-haul-oil",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 160,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-haul-oil",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 161,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-unload",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 162,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-unload",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 163,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 164,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 165,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 166,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield1",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 167,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield2",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 168,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield3",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 169,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-170",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 170,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-171",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 171,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-172",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 172,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-173",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 173,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-174",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 174,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-175",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 175,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-176",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 176,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-177",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 177,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-land",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 178,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-land",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 179,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-stand-ground",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 180,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-stand-ground",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 181,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-attack-ground",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 182,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-attack-ground",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 183,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-naval",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 184,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-naval",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 185,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-quick-blade",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 186,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-female-hero",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 187,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-ugly-guy",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 188,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-evil-knight",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 189,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-beast-cry",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 190,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-flying-angle",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 191,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-fire-breeze",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 192,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-white-mage",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 193,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-fad-man",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 194,
  File = "tilesets/summer/icons.png"})
DefineIcon({
  Name = "icon-knight-rider",
  Tileset = "tileset-summer",
  Size = {46, 38},
  Index = 195,
  File = "tilesets/summer/icons.png"})

--=============================================================================
--	Winter Tileset
--=============================================================================

DefineIcon({
  Name = "icon-peasant",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 0,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-peon",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 1,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-footman",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 2,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-grunt",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 3,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-archer",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 4,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-axethrower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 5,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ranger",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 6,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-berserker",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 7,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-knight",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 8,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ogre",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 9,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-paladin",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 10,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ogre-mage",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 11,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-dwarves",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 12,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-goblin-sappers",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 13,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mage",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 14,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-death-knight",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 15,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ballista",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 16,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-catapult",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 17,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-tanker",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 18,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-tanker",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 19,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-transport",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 20,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-transport",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 21,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-destroyer",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 22,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-destroyer",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 23,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-battleship",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 24,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ogre-juggernaught",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 25,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-gnomish-submarine",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 26,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-giant-turtle",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 27,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-gnomish-flying-machine",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 28,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-zeppelin",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 29,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-gryphon-rider",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 30,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-dragon",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 31,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-wise-man",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 32,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ice-bringer",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 33,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-man-of-light",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 34,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-sharp-axe",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 35,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-double-head",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 36,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-daemon",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 37,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-farm",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 38,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-pig-farm",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 39,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-town-hall",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 40,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-great-hall",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 41,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-barracks",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 42,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-barracks",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 43,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-elven-lumber-mill",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 44,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-troll-lumber-mill",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 45,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-blacksmith",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 46,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-blacksmith",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 47,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-shipyard",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 48,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-shipyard",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 49,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-refinery",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 50,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-refinery",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 51,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-foundry",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 52,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-foundry",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 53,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-platform",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 54,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-platform",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 55,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-stables",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 56,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ogre-mound",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 57,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-gnomish-inventor",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 58,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alchemist",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 59,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-watch-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 60,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-watch-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 61,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-church",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 62,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-altar-of-storms",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 63,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mage-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 64,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-temple-of-the-damned",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 65,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-keep",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 66,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-stronghold",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 67,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-castle-upgrade",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 68,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-fortress-upgrade",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 69,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-castle",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 70,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-fortress",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 71,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-gryphon-aviary",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 72,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-dragon-roost",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 73,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-gold-mine",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 74,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-guard-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 75,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-cannon-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 76,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-guard-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 77,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-cannon-tower",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 78,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-oil-patch",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 79,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-dark-portal",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 80,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-circle-of-power",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 81,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-runestone",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 82,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-move-peasant",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 83,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-move-peon",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 84,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-repair",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 85,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-harvest",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 86,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-build-basic",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 87,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-build-advanced",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 88,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peasant",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 89,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peon",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 90,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-cancel",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 91,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-wall",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 92,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-wall",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 93,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-slow",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 94,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-invisibility",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 95,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-haste",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 96,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-runes",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 97,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-unholy-armor",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 98,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-lightning",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 99,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-flame-shield",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 100,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-fireball",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 101,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-touch-of-darkness",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 102,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-death-coil",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 103,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-whirlwind",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 104,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-blizzard",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 105,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-holy-vision",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 106,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-heal",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 107,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-death-and-decay",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 108,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-109",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 109,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-exorcism",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 110,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-eye-of-kilrogg",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 111,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-bloodlust",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 112,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-unknown113",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 113,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-skeleton",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 114,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-critter",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 115,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-sword1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 116,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-sword2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 117,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-sword3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 118,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-battle-axe1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 119,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-battle-axe2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 120,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-battle-axe3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 121,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-122",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 122,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-123",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 123,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-arrow1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 124,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-arrow2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 125,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-arrow3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 126,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 127,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 128,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 129,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-horse1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 130,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-horse2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 131,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-longbow",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 132,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ranger-scouting",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 133,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ranger-marksmanship",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 134,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-light-axes",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 135,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-berserker-scouting",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 136,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-berserker-regeneration",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 137,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-catapult1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 138,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-catapult2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 139,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ballista1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 140,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ballista2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 141,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-demolish",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 142,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-demolish",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 143,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 144,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 145,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 146,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 147,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 148,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 149,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 150,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 151,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 152,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 153,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 154,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 155,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-move",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 156,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-move",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 157,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-return-oil",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 158,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-return-oil",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 159,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-haul-oil",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 160,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-haul-oil",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 161,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-unload",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 162,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-unload",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 163,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 164,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 165,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 166,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield1",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 167,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield2",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 168,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield3",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 169,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-170",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 170,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-171",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 171,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-172",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 172,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-173",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 173,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-174",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 174,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-175",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 175,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-176",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 176,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-177",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 177,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-land",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 178,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-land",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 179,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-stand-ground",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 180,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-stand-ground",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 181,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-attack-ground",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 182,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-attack-ground",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 183,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-naval",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 184,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-naval",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 185,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-quick-blade",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 186,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-female-hero",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 187,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-ugly-guy",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 188,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-evil-knight",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 189,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-beast-cry",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 190,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-flying-angle",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 191,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-fire-breeze",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 192,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-white-mage",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 193,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-fad-man",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 194,
  File = "tilesets/winter/icons.png"})
DefineIcon({
  Name = "icon-knight-rider",
  Tileset = "tileset-winter",
  Size = {46, 38},
  Index = 195,
  File = "tilesets/winter/icons.png"})

--=============================================================================
--	Wasteland Tileset
--=============================================================================

DefineIcon({
  Name = "icon-peasant",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 0,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-peon",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 1,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-footman",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 2,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-grunt",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 3,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-archer",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 4,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-axethrower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 5,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ranger",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 6,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-berserker",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 7,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-knight",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 8,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ogre",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 9,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-paladin",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 10,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ogre-mage",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 11,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-dwarves",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 12,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-goblin-sappers",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 13,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mage",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 14,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-death-knight",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 15,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ballista",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 16,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-catapult",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 17,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-tanker",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 18,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-tanker",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 19,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-transport",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 20,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-transport",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 21,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-destroyer",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 22,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-destroyer",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 23,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-battleship",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 24,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ogre-juggernaught",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 25,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-gnomish-submarine",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 26,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-giant-turtle",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 27,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-gnomish-flying-machine",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 28,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-zeppelin",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 29,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-gryphon-rider",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 30,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-dragon",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 31,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-wise-man",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 32,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ice-bringer",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 33,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-man-of-light",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 34,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-sharp-axe",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 35,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-double-head",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 36,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-daemon",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 37,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-farm",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 38,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-pig-farm",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 39,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-town-hall",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 40,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-great-hall",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 41,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-barracks",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 42,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-barracks",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 43,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-elven-lumber-mill",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 44,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-troll-lumber-mill",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 45,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-blacksmith",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 46,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-blacksmith",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 47,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-shipyard",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 48,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-shipyard",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 49,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-refinery",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 50,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-refinery",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 51,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-foundry",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 52,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-foundry",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 53,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-platform",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 54,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-platform",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 55,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-stables",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 56,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ogre-mound",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 57,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-gnomish-inventor",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 58,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alchemist",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 59,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-watch-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 60,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-watch-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 61,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-church",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 62,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-altar-of-storms",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 63,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mage-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 64,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-temple-of-the-damned",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 65,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-keep",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 66,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-stronghold",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 67,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-castle-upgrade",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 68,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-fortress-upgrade",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 69,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-castle",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 70,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-fortress",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 71,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-gryphon-aviary",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 72,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-dragon-roost",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 73,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-gold-mine",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 74,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-guard-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 75,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-cannon-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 76,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-guard-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 77,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-cannon-tower",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 78,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-oil-patch",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 79,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-dark-portal",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 80,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-circle-of-power",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 81,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-runestone",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 82,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-move-peasant",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 83,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-move-peon",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 84,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-repair",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 85,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-harvest",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 86,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-build-basic",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 87,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-build-advanced",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 88,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peasant",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 89,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peon",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 90,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-cancel",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 91,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-wall",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 92,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-wall",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 93,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-slow",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 94,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-invisibility",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 95,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-haste",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 96,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-runes",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 97,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-unholy-armor",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 98,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-lightning",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 99,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-flame-shield",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 100,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-fireball",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 101,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-touch-of-darkness",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 102,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-death-coil",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 103,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-whirlwind",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 104,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-blizzard",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 105,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-holy-vision",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 106,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-heal",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 107,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-death-and-decay",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 108,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-109",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 109,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-exorcism",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 110,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-eye-of-kilrogg",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 111,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-bloodlust",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 112,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-unknown113",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 113,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-skeleton",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 114,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-critter",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 115,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-sword1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 116,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-sword2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 117,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-sword3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 118,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-battle-axe1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 119,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-battle-axe2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 120,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-battle-axe3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 121,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-122",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 122,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-123",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 123,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-arrow1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 124,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-arrow2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 125,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-arrow3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 126,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 127,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 128,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 129,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-horse1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 130,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-horse2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 131,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-longbow",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 132,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ranger-scouting",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 133,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ranger-marksmanship",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 134,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-light-axes",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 135,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-berserker-scouting",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 136,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-berserker-regeneration",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 137,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-catapult1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 138,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-catapult2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 139,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ballista1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 140,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ballista2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 141,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-demolish",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 142,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-demolish",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 143,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 144,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 145,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 146,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 147,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 148,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 149,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 150,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 151,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 152,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 153,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 154,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 155,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-move",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 156,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-move",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 157,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-return-oil",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 158,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-return-oil",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 159,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-haul-oil",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 160,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-haul-oil",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 161,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-unload",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 162,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-unload",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 163,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 164,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 165,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 166,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield1",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 167,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield2",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 168,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield3",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 169,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-170",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 170,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-171",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 171,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-172",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 172,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-173",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 173,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-174",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 174,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-175",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 175,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-176",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 176,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-177",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 177,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-land",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 178,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-land",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 179,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-stand-ground",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 180,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-stand-ground",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 181,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-attack-ground",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 182,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-attack-ground",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 183,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-naval",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 184,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-naval",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 185,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-quick-blade",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 186,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-female-hero",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 187,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-ugly-guy",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 188,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-evil-knight",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 189,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-beast-cry",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 190,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-flying-angle",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 191,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-fire-breeze",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 192,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-white-mage",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 193,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-fad-man",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 194,
  File = "tilesets/wasteland/icons.png"})
DefineIcon({
  Name = "icon-knight-rider",
  Tileset = "tileset-wasteland",
  Size = {46, 38},
  Index = 195,
  File = "tilesets/wasteland/icons.png"})

--=============================================================================
--	Orcish swamp Tileset
--=============================================================================

DefineIcon({
  Name = "icon-peasant",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 0,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-peon",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 1,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-footman",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 2,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-grunt",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 3,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-archer",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 4,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-axethrower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 5,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ranger",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 6,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-berserker",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 7,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-knight",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 8,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ogre",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 9,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-paladin",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 10,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ogre-mage",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 11,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-dwarves",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 12,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-goblin-sappers",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 13,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mage",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 14,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-death-knight",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 15,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ballista",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 16,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-catapult",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 17,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-tanker",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 18,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-tanker",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 19,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-transport",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 20,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-transport",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 21,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-destroyer",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 22,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-destroyer",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 23,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-battleship",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 24,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ogre-juggernaught",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 25,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-gnomish-submarine",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 26,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-giant-turtle",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 27,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-gnomish-flying-machine",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 28,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-zeppelin",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 29,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-gryphon-rider",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 30,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-dragon",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 31,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-wise-man",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 32,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ice-bringer",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 33,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-man-of-light",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 34,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-sharp-axe",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 35,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-double-head",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 36,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-daemon",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 37,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-farm",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 38,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-pig-farm",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 39,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-town-hall",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 40,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-great-hall",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 41,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-barracks",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 42,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-barracks",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 43,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-elven-lumber-mill",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 44,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-troll-lumber-mill",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 45,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-blacksmith",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 46,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-blacksmith",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 47,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-shipyard",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 48,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-shipyard",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 49,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-refinery",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 50,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-refinery",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 51,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-foundry",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 52,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-foundry",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 53,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-oil-platform",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 54,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-oil-platform",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 55,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-stables",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 56,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ogre-mound",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 57,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-gnomish-inventor",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 58,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alchemist",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 59,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-watch-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 60,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-watch-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 61,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-church",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 62,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-altar-of-storms",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 63,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mage-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 64,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-temple-of-the-damned",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 65,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-keep",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 66,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-stronghold",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 67,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-castle-upgrade",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 68,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-fortress-upgrade",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 69,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-castle",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 70,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-fortress",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 71,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-gryphon-aviary",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 72,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-dragon-roost",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 73,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-gold-mine",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 74,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-guard-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 75,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-cannon-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 76,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-guard-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 77,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-cannon-tower",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 78,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-oil-patch",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 79,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-dark-portal",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 80,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-circle-of-power",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 81,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-runestone",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 82,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-move-peasant",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 83,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-move-peon",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 84,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-repair",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 85,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-harvest",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 86,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-build-basic",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 87,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-build-advanced",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 88,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peasant",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 89,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-return-goods-peon",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 90,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-cancel",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 91,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-wall",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 92,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-wall",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 93,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-slow",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 94,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-invisibility",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 95,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-haste",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 96,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-runes",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 97,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-unholy-armor",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 98,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-lightning",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 99,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-flame-shield",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 100,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-fireball",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 101,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-touch-of-darkness",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 102,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-death-coil",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 103,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-whirlwind",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 104,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-blizzard",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 105,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-holy-vision",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 106,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-heal",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 107,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-death-and-decay",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 108,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-109",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 109,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-exorcism",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 110,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-eye-of-kilrogg",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 111,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-bloodlust",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 112,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-unknown113",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 113,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-skeleton",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 114,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-critter",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 115,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-sword1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 116,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-sword2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 117,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-sword3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 118,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-battle-axe1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 119,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-battle-axe2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 120,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-battle-axe3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 121,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-122",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 122,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-123",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 123,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-arrow1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 124,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-arrow2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 125,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-arrow3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 126,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 127,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 128,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-throwing-axe3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 129,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-horse1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 130,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-horse2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 131,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-longbow",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 132,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ranger-scouting",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 133,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ranger-marksmanship",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 134,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-light-axes",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 135,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-berserker-scouting",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 136,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-berserker-regeneration",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 137,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-catapult1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 138,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-catapult2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 139,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ballista1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 140,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ballista2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 141,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-demolish",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 142,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-demolish",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 143,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 144,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 145,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-cannon3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 146,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 147,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 148,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-cannon3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 149,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 150,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 151,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-armor3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 152,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 153,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 154,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-armor3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 155,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-move",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 156,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-move",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 157,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-return-oil",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 158,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-return-oil",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 159,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-ship-haul-oil",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 160,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-ship-haul-oil",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 161,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-unload",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 162,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-unload",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 163,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 164,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 165,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-shield3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 166,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield1",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 167,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield2",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 168,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-shield3",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 169,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-170",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 170,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-171",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 171,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-172",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 172,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-173",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 173,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-174",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 174,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-175",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 175,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-176",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 176,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-177",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 177,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-land",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 178,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-land",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 179,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-stand-ground",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 180,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-stand-ground",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 181,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-attack-ground",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 182,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-attack-ground",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 183,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-alliance-patrol-naval",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 184,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-mythical-patrol-naval",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 185,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-quick-blade",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 186,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-female-hero",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 187,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-ugly-guy",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 188,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-evil-knight",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 189,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-beast-cry",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 190,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-flying-angle",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 191,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-fire-breeze",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 192,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-white-mage",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 193,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-fad-man",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 194,
  File = "tilesets/swamp/icons.png"})
DefineIcon({
  Name = "icon-knight-rider",
  Tileset = "tileset-swamp",
  Size = {46, 38},
  Index = 195,
  File = "tilesets/swamp/icons.png"})

--=============================================================================
--	Define an icon alias.
--
--	DefineIconAlias(alias, icon)
--
--	alias	Is the new alias name.
--	icon	Must be an already existing icon name.
--
DefineIconAlias("icon-raise-dead", "icon-skeleton")
DefineIconAlias("icon-polymorph", "icon-critter")
