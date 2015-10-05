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
GameDefinition["Map"]["File"] = "DP1D1"
GameDefinition["Map"]["Type"] = ".lua"
GameDefinition["Map"]["Path"] = "scripts/lists/campaigns/Adventure/"

if (GameDefinition["Briefing"]["Active"] == true) then
	GameDefinition["Briefing"]["Backdrop"] = "magickomplex"
	CharacterAction("Drago Payne", "Pose", "Neutral", "Happy")
	BundleAction("Chat", "Drago Payne", "What's that?")
--	BundleAction("Chat", "Drago Payne", "Apple Carrot Cheese Cake Money Bags Microphone Double Triple Five Six Seven Two This Is A Fantastic Song Hello Hello")
elseif (GameDefinition["Briefing"]["Active"] == 1) then
	CharacterAction("Scott Campbell", "Pose", "Neutral", "Happy")
	BundleAction("Chat", "Scott Campbell", "The class roster for this term. Some have been reconfigured.")
elseif (GameDefinition["Briefing"]["Active"] == 2) then
	BundleAction("Chat", "Drago Payne", "Why would they bother? It's the last term.")
elseif (GameDefinition["Briefing"]["Active"] == 3) then
	BundleAction("Chat", "Scott Campbell", "I guess the classes would have been too big. Let's see, yep, I'm still in 11A.")
elseif (GameDefinition["Briefing"]["Active"] == 4) then
	BundleAction("Chat", "Drago Payne", "What am I in?")
elseif (GameDefinition["Briefing"]["Active"] == 5) then
	BundleAction("Chat", "Scott Campbell", "Same, I don't think anyone got moved. Lucky for you Yuki is still in our class. There's also this new kid, Yutaka.")
elseif (GameDefinition["Briefing"]["Active"] == 6) then
	BundleAction("Chat", "Drago Payne", "The rumour was that I liked Suki, not Yuki. I don't even know who Yuki is.")
elseif (GameDefinition["Briefing"]["Active"] == 7) then
	BundleAction("Chat", "Scott Campbell", "She's the loud annoying one.")
elseif (GameDefinition["Briefing"]["Active"] == 8) then
	BundleAction("Chat", "Drago Payne", "That doesn't narrow it down.")
elseif (GameDefinition["Briefing"]["Active"] == 9) then
	BundleAction("Chat", "Scott Campbell", "I'm afraid that Suki been moved to 11B.")
elseif (GameDefinition["Briefing"]["Active"] == 10) then
	BundleAction("Chat", "Drago Payne", "I was hoping that everyone would have forgotten about that rumour by now.")
elseif (GameDefinition["Briefing"]["Active"] == 11) then
	BundleAction("Chat", "Scott Campbell", "I wish I could forget.")
elseif (GameDefinition["Briefing"]["Active"] == 12) then
	GameDefinition["Map"]["Name"] = "DP1D2"
	GameDefinition["Briefing"]["Active"] = true
	Load(GameDefinition["Map"]["Path"] .. GameDefinition["Map"]["Name"] .. GameDefinition["Map"]["Type"])
end