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
--		(c) Copyright 2015 by Kyran Jackson
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

GameDefinition["Briefing"]["Title"] = ""
GameDefinition["Briefing"]["Objectives"] = nil
GameDefinition["Map"]["File"] = "RR1F1"
GameDefinition["Map"]["Type"] = ".lua"
GameDefinition["Map"]["Path"] = "scripts/lists/campaigns/Adventure/"

if (GameDefinition["Briefing"]["Active"] == true) then
	-- Friendly match with Red House.
	-- TODO: Allow the player to bring allies to this match.
	GameDefinition["Briefing"]["Backdrop"] = "magickomplex"
	CharacterAction("Aya Kalang", "Pose", "Neutral", "Happy")
	BundleAction("Chat", "Aya Kalang", "What is it?")
elseif (GameDefinition["Briefing"]["Active"] == 1) then
	BundleAction("Chat", "Drago Payne", "I challenge you to a friendly Conquest match.")
elseif (GameDefinition["Briefing"]["Active"] == 2) then
	GameDefinition["Map"]["File"] = "(2)nicks-duel"
	GameDefinition["Map"]["Path"] = "maps/ftm/"
	GameDefinition["Map"]["Type"] = ".smp"
	BundleAction("Chat", "Aya Kalang", "Sure Drago, I have time for that.")
	GameDefinition["Player"][1][1]["Name"] = "Drago Pain"
	GameDefinition["Player"][2][1]["Name"] = "Shane Wolfe"
	BriefingAction("Start")
elseif (GameDefinition["Briefing"]["Active"] == 3) then


elseif (GameDefinition["Briefing"]["Active"] == 4) then
	GameDefinition["Map"]["File"] = "DP1D2"
	GameDefinition["Briefing"]["Active"] = true
	Load(GameDefinition["Map"]["Path"] .. GameDefinition["Map"]["File"] .. GameDefinition["Map"]["Type"])
end