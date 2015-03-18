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
--	(c) Copyright 2015 by Kyran Jackson
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
--      Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--

-- Classic Ais
DefineAi("Passive", "*", "wc2-skirmish", AiPassive)
DefineAi("Land Attack", "*", "wc2-skirmish", AiLandAttack)
DefineAi("Sea Attack", "*", "wc2-skirmish", AiSeaAttack)
DefineAi("Air Attack", "*", "wc2-skirmish", AiAirAttack)

-- Jadeite Ais
DefineAi("Jadeite", "*", "wc2-skirmish", AiJadeite_2010)
DefineAi("Morga", "*", "wc2-skirmish", AiJadeite_Soldier_2010)
DefineAi("Balm", "*", "wc2-skirmish", AiJadeite_Power_2010)
DefineAi("Flau", "*", "wc2-skirmish", AiJadeite_Cavalry_2010)
DefineAi("Iguara", "*", "wc2-skirmish", AiJadeite_Flyer_2010)
DefineAi("Kyurene", "*", "wc2-skirmish", AiJadeite_Shooter_2010)

-- Nephrite Ais
DefineAi("Nephrite", "*", "wc2-skirmish", AiNephrite_2013)
DefineAi("Tesuni", "*", "wc2-skirmish", AiNephrite_NoCav_2013)
DefineAi("Regulus", "*", "wc2-skirmish", AiNephrite_2012)
DefineAi("Soul", "*", "wc2-skirmish", AiNephrite_NoCav_2012)

-- Zoisite Ais
DefineAi("Zoisite", "*", "wc2-skirmish", AiZoisite_2013)