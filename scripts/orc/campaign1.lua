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
--      campaign1.ccl - Define the orc campaign 1.
--
--      (c) Copyright 2002-2006 by Lutz Sammer and Jimmy Salmon
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

--=============================================================================
--	Define the campaign

campaign_steps = {
  CreatePictureStep("../campaigns/orc/interface/Act_I_-_Seas_of_Blood.png", "../sounds/orc/act.wav", "Act I", "Seas of Blood"),
  CreateMapStep("campaigns/orc/level01o.smp"),
  CreateMapStep("campaigns/orc/level02o.smp"),
  CreateMapStep("campaigns/orc/level03o.smp"),
  CreateMapStep("campaigns/orc/level04o.smp"),

  CreatePictureStep("../campaigns/orc/interface/Act_II_-_Khaz_Modan.png", "../sounds/orc/act.wav", "Act II", "Khaz Modan"),
  CreateMapStep("campaigns/orc/level05o.smp"),
  CreateMapStep("campaigns/orc/level06o.smp"),
  CreateMapStep("campaigns/orc/level07o.smp"),

  CreatePictureStep("../campaigns/orc/interface/Act_III_-_Quel'Thalas.png", "../sounds/orc/act.wav", "Act III", "Quel'Thalas"),
  CreateMapStep("campaigns/orc/level08o.smp"),
  CreateMapStep("campaigns/orc/level09o.smp"),
  CreateMapStep("campaigns/orc/level10o.smp"),
  CreateMapStep("campaigns/orc/level11o.smp"),

  CreatePictureStep("../campaigns/orc/interface/Act_IV_-_Tides_of_Darkness.png", "../sounds/orc/act.wav", "Act IV", "Tides of Darkness"),
  CreateMapStep("campaigns/orc/level12o.smp"),
  CreateMapStep("campaigns/orc/level13o.smp"),
  CreateMapStep("campaigns/orc/level14o.smp")
}

campaign_menu = { 1, 3, 4, 5, 6, 8, 9, 10, 12, 13, 14, 15, 17, 18 }

