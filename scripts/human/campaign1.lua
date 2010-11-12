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
--      campaign1.ccl - Define the human campaign 1.
--
--      (c) Copyright 2002-2006 by Lutz Sammer and Jimmy Salmon
--      (c) Copyright 2010      by Pali Rohár
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
  CreatePictureStep("campaigns/human/interface/Act_I_-_Shores_of_Lordareon.png", "sounds/human/act.wav", "Act I", "The Shores of Lordareon"),
  CreateMapStep("campaigns/human/level01h.smp"),
  CreateMapStep("campaigns/human/level02h.smp"),
  CreateMapStep("campaigns/human/level03h.smp"),
  CreateMapStep("campaigns/human/level04h.smp"),

  CreatePictureStep("campaigns/human/interface/Act_II_-_Khaz_Modan.png", "sounds/human/act.wav", "Act II", "Khaz Modan"),
  CreateVideoStep("videos/human-1.ogv"),
  CreateMapStep("campaigns/human/level05h.smp"),
  CreateMapStep("campaigns/human/level06h.smp"),
  CreateMapStep("campaigns/human/level07h.smp"),

  CreatePictureStep("campaigns/human/interface/Act_III_-_The_Northlands.png", "sounds/human/act.wav", "Act III", "The Northlands"),
  CreateVideoStep("videos/human-2.ogv"),
  CreateMapStep("campaigns/human/level08h.smp"),
  CreateMapStep("campaigns/human/level09h.smp"),
  CreateMapStep("campaigns/human/level10h.smp"),

  CreatePictureStep("campaigns/human/interface/Act_IV_-_Return_to_Azeroth.png", "sounds/human/act.wav", "Act IV", "Return to Azeroth"),
  CreateVideoStep("videos/human-3.ogv"),
  CreateMapStep("campaigns/human/level11h.smp"),
  CreateMapStep("campaigns/human/level12h.smp"),
  CreateMapStep("campaigns/human/level13h.smp"),
  CreateMapStep("campaigns/human/level14h.smp"),
  CreateVideoStep("videos/human-4.ogv"),
  CreateVictoryStep("graphics/ui/human/The_End.png", "campaigns/human/victory.txt", { "campaigns/human/victory.wav" })
}

campaign_menu = { 1, 3, 4, 5, 6, 9, 10, 11, 14, 15, 16, 19, 20, 21, 22 }

