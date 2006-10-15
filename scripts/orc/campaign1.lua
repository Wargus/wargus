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
  CreateMapStep("campaigns/orc/level01o.smp"),
  CreateMapStep("campaigns/orc/level02o.smp"),
  CreateMapStep("campaigns/orc/level03o.smp"),
  CreateMapStep("campaigns/orc/level04o.smp"),
  CreateMapStep("campaigns/orc/level05o.smp"),
  CreateMapStep("campaigns/orc/level06o.smp"),
  CreateMapStep("campaigns/orc/level07o.smp"),
  CreateMapStep("campaigns/orc/level08o.smp"),
  CreateMapStep("campaigns/orc/level09o.smp"),
  CreateMapStep("campaigns/orc/level10o.smp"),
  CreateMapStep("campaigns/orc/level11o.smp"),
  CreateMapStep("campaigns/orc/level12o.smp"),
  CreateMapStep("campaigns/orc/level13o.smp"),
  CreateMapStep("campaigns/orc/level14o.smp")
}

--[[
DefineCampaign("orc", "name", "~!Orc campaign",
  "campaign", {
	"show-picture", {
	  "image", "../campaigns/orc/interface/Act_I_-_Seas_of_Blood.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act I"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Seas of Blood"}},
	"play-level", "campaigns/orc/level01o.smp",
	"play-level", "campaigns/orc/level02o.smp",
	"play-level", "campaigns/orc/level03o.smp",
	"play-level", "campaigns/orc/level04o.smp",
	"show-picture", {
	  "image", "../campaigns/orc/interface/Act_II_-_Khaz_Modan.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act II"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Khaz Modan"}},
	"play-level", "campaigns/orc/level05o.smp",
	"play-level", "campaigns/orc/level06o.smp",
	"play-level", "campaigns/orc/level07o.smp",
	"show-picture", {
	  "image", "../campaigns/orc/interface/Act_III_-_Quel'Thalas.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act III"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Quel'Thalas"}},
	"play-level", "campaigns/orc/level08o.smp",
	"play-level", "campaigns/orc/level09o.smp",
	"play-level", "campaigns/orc/level10o.smp",
	"play-level", "campaigns/orc/level11o.smp",
	"show-picture", {
	  "image", "../campaigns/orc/interface/Act_IV_-_Tides_of_Darkness.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "ACT IV"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", (480 / 2) - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Tides of Darkness"}},
	"play-level", "campaigns/orc/level12o.smp",
	"play-level", "campaigns/orc/level13o.smp",
	"play-level", "campaigns/orc/level14o.smp" } )
]]
