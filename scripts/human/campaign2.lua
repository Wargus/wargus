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
--	campaign2.ccl	-	Define the human campaign 2.
--
--	(c) Copyright 2002 by Lutz Sammer
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
--	Define the campaign
--
--	(define-campagin 'ident 'name "name" 'campaign { elements)
DefineCampaign("human-exp", "name", "H~!uman expansion levels",
  "campaign", {
	"show-picture", {
	  "image", "campaigns/human-exp/interface/Act_I_-_A_Time_for_Heroes.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act I"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "A Time for Heroes"}},
	"play-level", "campaigns/human-exp/levelx01h.cm",
	"play-level", "campaigns/human-exp/levelx02h.cm",
	"play-level", "campaigns/human-exp/levelx03h.cm",
	"show-picture", {
	  "image", "campaigns/human-exp/interface/Act_II_-_Draenor,_the_Red_World.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act II"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Draenor, The Red World"}},
	"play-level", "campaigns/human-exp/levelx04h.cm",
	"play-level", "campaigns/human-exp/levelx05h.cm",
	"play-level", "campaigns/human-exp/levelx06h.cm",
	"show-picture", {
	  "image", "campaigns/human-exp/interface/Act_III_-_War_in_the_Shadows.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act III"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "War in the Shadows"}},
	"play-level", "campaigns/human-exp/levelx07h.cm",
	"play-level", "campaigns/human-exp/levelx08h.cm",
	"play-level", "campaigns/human-exp/levelx09h.cm",
	"show-picture", {
	  "image", "campaigns/human-exp/interface/Act_IV_-_The_Measure_of_Valor.png",
	  "fade-in", 30 * 2,
	  "fade-out", 30 * 2,
	  "display-time", 30 * 10,
	  "text", {
	    "font", "large-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 67,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "Act IV"},
	  "text", {
	    "font", "small-title",
	    "x", 640 / 2,
	    "y", 480 / 2 - 25,
	    "width", 640,
	    "height", 0,
	    "align", "center",
	    "text", "The Measure of Valor"}},
	"play-level", "campaigns/human-exp/levelx10h.cm",
	"play-level", "campaigns/human-exp/levelx11h.cm",
	"play-level", "campaigns/human-exp/levelx12h.cm" } )
