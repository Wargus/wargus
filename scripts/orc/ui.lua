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
--	ui.ccl		-	Define the orc user interface
--
--	(c) Copyright 2001-2003 by Lutz Sammer and Jimmy Salmon
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

DefineCursor({
  Name = "cursor-point",
  Race = "orc",
  File = "ui/orc/cursors/orcish_claw.png",
  HotSpot = { 3,  2},
  Size = {26, 32}})
DefineCursor({
  Name = "cursor-green-hair",
  Race = "orc",
  File = "ui/orc/cursors/green_crosshairs.png",
  HotSpot = {15, 15},
  Size = {32, 32}})
DefineCursor({
  Name = "cursor-yellow-hair",
  Race = "orc",
  File = "ui/orc/cursors/yellow_crosshairs.png",
  HotSpot = {15, 15},
  Size = {32, 32}})
DefineCursor({
  Name = "cursor-red-hair",
  Race = "orc",
  File = "ui/orc/cursors/red_crosshairs.png",
  HotSpot = {15, 15},
  Size = {32, 32}})

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--	* Race orc.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function OrcScreen(screen_width, screen_height)
  local info_panel_x = 0
  local info_panel_y = 160

  DefineUI("orc", screen_width, screen_height,
    "normal-font-color", "yellow",
    "reverse-font-color", "white",

    "filler", {
      "file", "graphics/ui/orc/" ..
        screen_width .. "x" .. screen_height ..
        "/filler-right.png",
      "pos", { screen_width - 16, 0}},

    "resource-line", {
      "graphics/ui/orc/" ..
        screen_width .. "x" .. screen_height ..
        "/resource.png",
      176, 0},

    "resources", {
      "gold", { "file", "graphics/ui/gold,wood,oil,mana.png", "frame", 0,
        "pos", { 176 + 0, 0}, "size", {14, 14}, "text-pos", { 176 + 0 + 18, 1}},
      "wood", { "file", "graphics/ui/gold,wood,oil,mana.png", "frame", 1,
        "pos", { 176 + 75, 0}, "size", {14, 14}, "text-pos", { 176 + 75 + 18, 1}},
      "oil", { "file", "graphics/ui/gold,wood,oil,mana.png", "frame", 2,
        "pos", { 176 + 150, 0}, "size", {14, 14}, "text-pos", { 176 + 150 + 18, 1}},
      "food", { "file", "graphics/ui/food.png", "frame", 0,
        "pos", { screen_width - 16 - 138, 0}, "size", {14, 14}, "text-pos", { (screen_width - 16 - 138) + 18, 1}},
      "score", { "file", "graphics/ui/score.png", "frame", 0,
        "pos", { screen_width - 16 - 68, 0}, "size", {14, 14}, "text-pos", { (screen_width - 16 - 68) + 18, 1}}},

    "info-panel", {
      "panel", {
        "file", "graphics/ui/orc/infopanel.png",
        "pos", { info_panel_x, info_panel_y},
        "size", {176, 176}
      },
      "selected", {
        "single", {
          "icon", {
            "pos", {  9, 169}, "style", "icon"}},
        "multiple", {
          "icons", {
            { "pos", {  9, 169}, "style", "icon"},
            { "pos", { 65, 169}, "style", "icon"},
            { "pos", {121, 169}, "style", "icon"},
            { "pos", {  9, 223}, "style", "icon"},
            { "pos", { 65, 223}, "style", "icon"},
            { "pos", {121, 223}, "style", "icon"},
            { "pos", {  9, 277}, "style", "icon"},
            { "pos", { 65, 277}, "style", "icon"},
            { "pos", {121, 277}, "style", "icon"}},
          "max-text", {
            "font", "game",
            "pos", { info_panel_x + 10, info_panel_y + 10}}}
      },
      "training", {
        "single", {
          "text", {
            "text", "Training:",
            "font", "game",
            "pos", { info_panel_x + 37, info_panel_y + 8 + 78}},
          "icon", {
            "pos", { info_panel_x + 110, info_panel_y + 11 + 70},
            "style", "icon"}},
        "multiple", {
          "icons", {
            { "pos", {  9, 219}, "style", "icon"},
            { "pos", { 65, 219}, "style", "icon"},
            { "pos", {121, 219}, "style", "icon"},
            { "pos", {  9, 266}, "style", "icon"},
            { "pos", { 65, 266}, "style", "icon"},
            { "pos", {121, 266}, "style", "icon"}}}
      },
      "upgrading", {
        "text", {
          "text", "Upgrading:",
          "font", "game",
          "pos", { info_panel_x + 29, info_panel_y + 8 + 78}},
        "icon", {
          "pos", { info_panel_x + 110, info_panel_y + 11 + 70},
          "style", "icon"}
      },
      "researching", {
        "text", {
          "text", "Researching:",
          "font", "game",
          "pos", { info_panel_x + 16, info_panel_y + 8 + 78}},
        "icon", {
          "pos", { info_panel_x + 110, info_panel_y + 11 + 70},
          "style", "icon"}
      },
      "transporting", {
        "icons", {
          { "pos", {  9, 223}, "style", "icon"},
          { "pos", { 65, 223}, "style", "icon"},
          { "pos", {121, 223}, "style", "icon"},
          { "pos", {  9, 277}, "style", "icon"},
          { "pos", { 65, 277}, "style", "icon"},
          { "pos", {121, 277}, "style", "icon"}}
      },
      "completed-bar", {
        "color", {48, 100, 4},
        "pos", { 12, 313},
        "size", {152, 14},
        "text", {
          "text", "% Complete",
          "font", "game",
          "pos", { 50, 313}}
      }
    },

    "button-panel", {
      "panel", {
        "file", "graphics/ui/orc/" ..
          screen_width .. "x" .. screen_height ..
          "/buttonpanel.png",
        "pos", {0, 336}},
      "icons", {
        { "pos", {  9, 340}, "style", "icon"},
        { "pos", { 65, 340}, "style", "icon"},
        { "pos", {121, 340}, "style", "icon"},
        { "pos", {  9, 387}, "style", "icon"},
        { "pos", { 65, 387}, "style", "icon"},
        { "pos", {121, 387}, "style", "icon"},
        { "pos", {  9, 434}, "style", "icon"},
        { "pos", { 65, 434}, "style", "icon"},
        { "pos", {121, 434}, "style", "icon"}},
      "auto-cast-border-color", {0, 0, 252},
    },

    "map-area", {
      "pos", {176, 16},
      "size", {
        screen_width - 176 - 16,
        screen_height - 16 - 16}},

    "menu-panel", {
      "panel", {
        "file", "graphics/ui/orc/menubutton.png",
        "pos", {0, 0}},
      "menu-button", {
        "pos", {24, 2},
        "caption", "Menu (~<F10~>)",
        "style", "main"},
      "network-menu-button", {
        "pos", {6, 2},
        "caption", "Menu",
        "style", "network"},
      "network-diplomacy-button", {
        "pos", {90, 2},
        "caption", "Diplomacy",
        "style", "network"}
    },

    "minimap", {
      "file", "graphics/ui/orc/minimap.png",
      "panel-pos", {0, 24},
      "pos", {0 + 24, 24 + 2},
      "size", {128, 128}},

    "status-line", {
      "file", "graphics/ui/orc/" ..
        screen_width .. "x" .. screen_height ..
        "/statusline.png",
      "pos", { 176, screen_height - 16},
      "text-pos", {2 + 176, 2 + screen_height - 16},
      "font", "game"},

    "cursors", {
      "point", "cursor-point",
      "glass", "cursor-glass",
      "cross", "cursor-cross",
      "yellow", "cursor-yellow-hair",
      "green", "cursor-green-hair",
      "red", "cursor-red-hair",
      "scroll", "cursor-scroll",
      "arrow-e", "cursor-arrow-e",
      "arrow-ne", "cursor-arrow-ne",
      "arrow-n", "cursor-arrow-n",
      "arrow-nw", "cursor-arrow-nw",
      "arrow-w", "cursor-arrow-w",
      "arrow-sw", "cursor-arrow-sw",
      "arrow-s", "cursor-arrow-s",
      "arrow-se", "cursor-arrow-se"},

    "menu-panels", {
      "panel1", "graphics/ui/orc/panel_1.png",
      "panel2", "graphics/ui/orc/panel_2.png",
      "panel3", "graphics/ui/orc/panel_3.png",
      "panel4", "graphics/ui/orc/panel_4.png",
      "panel5", "graphics/ui/orc/panel_5.png"},

    "victory-background", "graphics/ui/orc/victory.png",
    "defeat-background", "graphics/ui/orc/defeat.png")
end

OrcScreen(640, 480)
OrcScreen(800, 600)
OrcScreen(1024, 768)
OrcScreen(1280, 960)
OrcScreen(1600, 1200)
