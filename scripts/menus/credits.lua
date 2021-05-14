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
--      credits.lua - Define the menu for credits.
--
--      (c) Copyright 2006-2016 by Jimmy Salmon, Pali Rohár and cybermind
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

function RunShowCreditsMenu()
  local menu = WarMenu(nil, "ui/Credits_background.png")
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  local credits = {
	"Wargus developers",
	"  cybermind aka Mistranger",
	"  Kyran Jackson",
	"Stratagus programmers",
	"  cybermind aka Mistranger",
	"  Andrettin",
	"  Joris Dauphin",
	"  Pali Rohar",
	"Code used from Wargus Improvement project by Andrettin",
	"Patches",
	"  DinkyDyeAussie",
	"  Tim Felgentreff",
	"  Bradley Clemetson ",
	"Past Programmers",
	"  Jimmy Salmon",
	"  Francois Beerten",
	"  Nehal Mistry",
	"  Russell Smith",	
	"  Andreas 'Ari' Arens",
	"  Lutz 'Johns' Sammer",
	"  Edgar 'Froese' Toernig",
	"  Crestez Leonard",
	"  Mark Pazolli",
	"  Valery Shchedrin",
	"  Iftikhar Rathore",
	"  Charles K Hardin",
	"  Fabrice Rossi",
	"  DigiCat",
	"  Josh Cogliati",
	"  Patrick Mullen",
	"  Vladi Belperchinov-Shabanski",
	"  Cris Daniluk",
	"  Patrice Fortier",
	"  FT Rathore",
	"  Trent Piepho",
	"  Jon Gabrielson",
	"  Lukas Hejtmanek",
	"  Steinar Hamre",
	"  Ian Farmer",
	"  Sebastian Drews",
	"  Jarek Sobieszek",
	"  Anthony Towns",
	"  Stefan Dirsch",
	"  Al Koskelin",
	"  George J. Carrette",
	"  Dirk 'Guardian' Richartz",
	"  Michael O'Reilly",
	"  Dan Hensley",
	"  Sean McMillian",
	"  Mike Earl",
	"  Ian Turner",
	"  David Slimp",
	"  Iuri Fiedoruk",
	"  Luke Mauldin",
	"  Nathan Adams",
	"  Stephan Rasenberger",
	"  Dave Reed",
	"  Josef Spillner",
	"  James Dessart",
	"  Jan Uerpmann",
	"  Aaron Berger",
	"  Latimerius",
	"  Antonis Chaniotis",
	"  Samuel Hays",
	"  David Martinez Moreno",
	"  Flavio Silvestrow",
	"  Daniel Burrows",
	"  Dave Turner",
	"  Ben Hines",
	"  Kachalov Anton",
	"Past Patch Contributors",
	"  Martin Renold",
	"  Carlos Perello Marin",
	"  Pludov",
	"  Martin Hajduch",
	"  Jeff Binder",
	"  Ludovic",
	"  Juan Pablo",
	"  Phil Hannent",
	"  Alexander MacLean",
	"Italian Translation",
	"  Simone Starace",
	"Russian Translation",
	"  cybermind aka Mistranger",
	"",
	"Code used:",
	"  SDL Copyright by Sam Lantinga",
	"  ZLIB Copyright by Jean-loup Gailly and Mark Adler",
	"  BZ2LIB Copyright by Julian Seward",
	"  PNG Copyright by Glenn Randers-Pehrson",
	"  OGG/Vorbis Copyright by Xiph.org Foundation",
	"  FluidSynth Copyright by Josh Green, Pedro Lopez-Cabanillas, David Henningsson",
	"  Theora codec Copyright by Xiph.org Foundation.",
	"  Guichan Copyright by Per Larsson and Olof Naessen",
	"  tolua++ Copyright by Codenix",
	"  Stacktrace Copyright by Ethan Tira-Thompson and Fredrik Orderud",
	"  MikMod Copyright by Jean-Paul Mikkers (MikMak), Jake Stine (Air Richter) and Frank Loemker",
	"  StormLib Copyright by Ladislav Zezula",
	
	"",
	"",
	"The Stratagus Team thanks all the people who have contributed",
	"patches, bug reports, and ideas.",
	"",
	wargus.Name .. " Homepage: ", wargus.Homepage,
	"Stratagus Homepage: ", GetStratagusHomepage(),
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
  }

  local sw = ScrollingWidget(480, 275)
  menu:add(sw, offx + 140, offy + 80)
  sw:setBackgroundColor(Color(0,0,0,0))
  sw:setActionCallback(function() sw:restart() end)
  for i,f in ipairs(credits) do
    sw:add(Label(f), 0, 24 * (i - 1) + 275)
  end

  menu:addContinueButton(_("~!Continue"), "c", offx + 455, offy + 440,
    function() menu:stop() end)

  local speed = GetGameSpeed()
  SetGameSpeed(30)

  menu:run()

  SetGameSpeed(speed)
end

