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
--	ranks.ccl	-	Ranks for all of the races.
--
--	(c) Copyright 2002 by Jimmy Salmon.
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
--	Define ranks for a race.
--
--	(define-ranks race (score rank [score rank] ...))
--
--	race	The race to define the ranks for.
--	score	If the player's score is greater than or equal to this number then 
--		the rank is displayed.  Scores are expected to be sorted in 
--		increasing order.
--	rank	The rank that gets displayed.
--

DefineRanks("human", {
0, "Servant",
2000, "Peasant",
5000, "Squire",
8000, "Footman",
18000, "Corporal",
28000, "Sergeant",
40000, "Lieutenant",
55000, "Captain",
70000, "Major",
85000, "Knight",
105000, "General",
125000, "Admiral",
145000, "Marshall",
165000, "Lord",
185000, "Grand Admiral",
205000, "Highlord",
230000, "Thundergod",
255000, "God",
280000, "Designer",
})

DefineRanks("orc", {
0, "Slave",
2000, "Peon",
5000, "Rogue",
8000, "Grunt",
18000, "Slasher",
28000, "Marauder",
40000, "Commander",
55000, "Captain",
70000, "Major",
85000, "Knight",
105000, "General",
125000, "Master",
145000, "Marshall",
165000, "Chieftain",
185000, "Overlord",
205000, "War Chief",
230000, "Demigod",
255000, "God",
280000, "Designer",
})
