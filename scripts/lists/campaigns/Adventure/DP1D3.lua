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
	GameDefinition["Briefing"]["Backdrop"] = "magickomplex"
	BundleAction("Chat", "Drago Payne", "What's all this?")
elseif (GameDefinition["Briefing"]["Active"] == 1) then
	BundleAction("Chat", "Scott Campbell", "Our recruitment table. You already agreed that we need to recruit more people this term.")
elseif (GameDefinition["Briefing"]["Active"] == 2) then
	BundleAction("Chat", "Drago Payne", "What will be our pitch? Join Yellow, we'll take anyone!")
elseif (GameDefinition["Briefing"]["Active"] == 3) then
	BundleAction("Chat", "Scott Campbell", "That sounds a little desperate.")
elseif (GameDefinition["Briefing"]["Active"] == 4) then
	BundleAction("Chat", "Drago Payne", "We are desperate.")
elseif (GameDefinition["Briefing"]["Active"] == 5) then
	BundleAction("Chat", "Scott Campbell", "Here comes someone. Join Yellow! We'll take anyone, even you!")
elseif (GameDefinition["Briefing"]["Active"] == 6) then
	BundleAction("Chat", "Shane Wolfe", "What's that suppose to mean?")
elseif (GameDefinition["Briefing"]["Active"] == 7) then
	BundleAction("Chat", "Drago Payne", "It means we have no standards. We even let girls join.")
elseif (GameDefinition["Briefing"]["Active"] == 8) then
	BundleAction("Chat", "Shane Wolfe", "Were you declining before or after you let the girls join?")
elseif (GameDefinition["Briefing"]["Active"] == 9) then
	BundleAction("Chat", "Drago Payne", "Shortly afterwards we had a nasty breakout of the cooties. We've been rebuilding ever since.")
elseif (GameDefinition["Briefing"]["Active"] == 10) then
	BundleAction("Chat", "Scott Campbell", "When was this?")
elseif (GameDefinition["Briefing"]["Active"] == 11) then
	BundleAction("Chat", "Shane Wolfe", "Is this the only house that has no standards.")
elseif (GameDefinition["Briefing"]["Active"] == 12) then
	BundleAction("Chat", "Scott Campbell", "Green doesn't, Blue doesn't. I think Red is the only one that has 'em.")
elseif (GameDefinition["Briefing"]["Active"] == 13) then
	BundleAction("Chat", "Shane Wolfe", "So there is Red, Blue, Green and Yellow. Are there any others?")
elseif (GameDefinition["Briefing"]["Active"] == 14) then
	BundleAction("Chat", "Scott Campbell", "None that matter.")
elseif (GameDefinition["Briefing"]["Active"] == 15) then
	BundleAction("Chat", "Shane Wolfe", "Why would I join your house?")
elseif (GameDefinition["Briefing"]["Active"] == 16) then
	BundleAction("Chat", "Drago Payne", "Our common room as you can see is at a central location. Sharing a wall with the tuckshop, our common room is a short walk from the library, computer labs, and most classrooms. In addition, seniors can claim one of the many lockers in our private house change rooms.")
elseif (GameDefinition["Briefing"]["Active"] == 17) then
	BundleAction("Chat", "Scott Campbell", "You can take a look inside if you want. There's also the auxiliary room, and the hallway leads to the change rooms.")
elseif (GameDefinition["Briefing"]["Active"] == 18) then
	BundleAction("Chat", "Shane Wolfe", "Thanks, I'll do that.")
elseif (GameDefinition["Briefing"]["Active"] == 19) then
	BundleAction("Chat", "Drago Payne", "They'll never join if you let them inside first.")
elseif (GameDefinition["Briefing"]["Active"] == 20) then
	BundleAction("Chat", "Scott Campbell", "Maybe we should have setup in-front of the library.")
elseif (GameDefinition["Briefing"]["Active"] == 21) then
	BundleAction("Chat", "Drago Payne", "No one is going to mistake the library for our common room.")
elseif (GameDefinition["Briefing"]["Active"] == 22) then
	BundleAction("Chat", "Scott Campbell", "I'll go make sure he doesn't see anything he shouldn't.")
elseif (GameDefinition["Briefing"]["Active"] == 23) then
	BundleAction("Chat", "Drago Payne", "Okay, I'll wait here and eat my lunch.")
elseif (GameDefinition["Briefing"]["Active"] == 24) then
	GameDefinition["Briefing"]["Active"] = 25
	Load(GameDefinition["Map"]["Path"] .. GameDefinition["Map"]["Name"] .. GameDefinition["Map"]["Type"])
elseif (GameDefinition["Briefing"]["Active"] == 25) then
	BundleAction("Chat", "Yukiko Robinson", "Gah! This is impossible! I don't have enough! You, Drago! I hear you're in love with me.")
elseif (GameDefinition["Briefing"]["Active"] == 26) then
	BundleAction("Chat", "Drago Payne", "What?")
elseif (GameDefinition["Briefing"]["Active"] == 27) then
	BundleAction("Chat", "Yukiko Robinson", "You're in Yellow?")
elseif (GameDefinition["Briefing"]["Active"] == 28) then
	BundleAction("Chat", "Drago Payne", "Yeah? You looking to join?")
elseif (GameDefinition["Briefing"]["Active"] == 29) then
	BundleAction("Chat", "Yukiko Robinson", "What class?")
elseif (GameDefinition["Briefing"]["Active"] == 30) then
	BundleAction("Chat", "Drago Payne", "Huh? Oh, 11A.")
elseif (GameDefinition["Briefing"]["Active"] == 31) then
	BundleAction("Chat", "Yukiko Robinson", "Bingo! We have a winner! You're in the smart class, so you can join the drama team.")
elseif (GameDefinition["Briefing"]["Active"] == 32) then
	BundleAction("Chat", "Drago Payne", "Why should I?")
elseif (GameDefinition["Briefing"]["Active"] == 33) then
	BundleAction("Chat", "Yukiko Robinson", "It's simple. I'm the drama president, so you'll join because you love me.")
elseif (GameDefinition["Briefing"]["Active"] == 34) then
	BundleAction("Chat", "Drago Payne", "Oh, so you're the loud annoying one.")
elseif (GameDefinition["Briefing"]["Active"] == 35) then
	BundleAction("Chat", "Yukiko Robinson", "You are a grouchy person, Drago. I'm sure I'll find an appropriate part for you. Practice is here tomorrow. Don't be late.")
elseif (GameDefinition["Briefing"]["Active"] == 36) then
	GameDefinition["Briefing"]["Active"] = 37
	Load(GameDefinition["Map"]["Path"] .. GameDefinition["Map"]["Name"] .. GameDefinition["Map"]["Type"])
elseif (GameDefinition["Briefing"]["Active"] == 37) then
	BundleAction("Chat", "Scott Campbell", "Our entire lunch is gone, and we didn't recruit a single person. I heard White House tripled their number. I didn't even know there was a White House before today.")
elseif (GameDefinition["Briefing"]["Active"] == 38) then
	BundleAction("Chat", "Drago Payne", "No only that, but I managed to recruited into a stupid drama club.")
elseif (GameDefinition["Briefing"]["Active"] == 39) then
	BundleAction("Chat", "Scott Campbell", "The recruiter got recruited? How did you manage that?")
elseif (GameDefinition["Briefing"]["Active"] == 40) then
	BundleAction("Chat", "Drago Payne", "Don't ask.")
else
	GameDefinition["Map"]["Name"] = "DP1D3"
	GameDefinition["Briefing"]["Active"] = true
	Load(GameDefinition["Map"]["Path"] .. GameDefinition["Map"]["Name"] .. GameDefinition["Map"]["Type"])
end

--[[
"Oh, so you're the loud annoying one."

"The entire lunch gone, and we didn't recruit a single person. On the other hand, White House tripled their number. I didn't even know there was a White House."
"How big were White House before if they were able to double their number?"
"Not only didn't we recruit anyone, but we got recruited into some stupid drama club."
]]