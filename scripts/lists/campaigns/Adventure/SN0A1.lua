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

if (GameDefinition["Briefing"]["Active"] == true) then
	GameDefinition["Briefing"]["Title"] = ""
	GameDefinition["Briefing"]["Objectives"] = nil
	GameDefinition["Map"]["Name"] = "Mythic Introduction"
	GameDefinition["Map"]["File"] = "SN0A1"
	GameDefinition["Map"]["Type"] = ".lua"
	GameDefinition["Map"]["Path"] = "scripts/lists/campaigns/Adventure/"
	local menu = MenuScreen()
	BriefingAction("Backdrop", "backdrops/seichan.png", menu)
	CharacterAction("Sandria Fields", "Pose", "Neutral", "Happy")
	BundleAction("Chat", "Sandria Fields", "Papers?")
elseif (GameDefinition["Briefing"]["Active"] == 1) then
	BundleAction("Chat", "Sandria Fields", "You have been commissioned to take charge of the Frontier Force.")
elseif (GameDefinition["Briefing"]["Active"] == 2) then
	BundleAction("Chat", "Sandria Fields", "Standing orders are to police the remote regions of the Blardnegs.")
elseif (GameDefinition["Briefing"]["Active"] == 3) then
	BundleAction("Chat", "Sandria Fields", "The Blardnegs comprises of the area south of the dividing range, starting at the cheerful Swamps of Despair.")
elseif (GameDefinition["Briefing"]["Active"] == 4) then
	BundleAction("Chat", "Sandria Fields", "We are currently at my castle.")
elseif (GameDefinition["Briefing"]["Active"] == 5) then
	BundleAction("Chat", "Sandria Fields", "To the east is the Desert Fortress.")
elseif (GameDefinition["Briefing"]["Active"] == 6) then
	BundleAction("Chat", "Sandria Fields", "And this is Genesis Castle, home of Baron Jadeite.")
elseif (GameDefinition["Briefing"]["Active"] == 7) then
	BundleAction("Chat", "Sandria Fields", "Your Frontier Force will deal with everything south of the baron's lands.")
elseif (GameDefinition["Briefing"]["Active"] == 8) then
	BundleAction("Chat", "Sandria Fields", "Any questions?")
elseif (GameDefinition["Briefing"]["Active"] == 9) then
	BundleAction("Chat", "Sandria Fields", "Good. You will report to Genesis Castle. Additional orders will be dispatched to you there.")
elseif (GameDefinition["Briefing"]["Active"] == 10) then
	GameDefinition["Map"]["Name"] = "SN1A1"
	GameDefinition["Briefing"]["Active"] = true
	LoadScript()
end