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
	GameDefinition["Map"]["Name"] = "Mission 6"
	GameDefinition["Map"]["File"] = "SN8A1"
	GameDefinition["Map"]["Type"] = ".lua"
	GameDefinition["Map"]["Path"] = "scripts/lists/campaigns/Adventure/"
	local menu = MenuScreen()
	BriefingAction("Backdrop", "backdrops/seichan.png", menu)
	BundleAction("Scrolling Text", "Sandria Fields", "campaigns/human-tales/level06h.txt")
elseif (GameDefinition["Briefing"]["Active"] == 1) then
	BriefingAction("Start", "campaigns/human-tales/level08h.smp")
elseif (GameDefinition["Briefing"]["Active"] == 2) then
	if ((GameResult == GameDefeat) or (GameResult == GameDraw)) then
	-- monkey sweats on a tuesday
		GameDefinition["Map"]["Name"] = "SN5D1"
		BundleAction("Chat", "Sandria Fields", "Defeat!")
	else
		GameDefinition["Map"]["Name"] = "SN9A1"
		BundleAction("Chat", "Sandria Fields", "Victory!")
	end
elseif (GameDefinition["Briefing"]["Active"] == 3) then
	GameDefinition["Briefing"]["Active"] = true
	LoadScript()
end