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
--	ui.ccl		-	Define the human user interface
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

DefineCursor("cursor-point", "human",
    "image", "ui/human/cursors/human_gauntlet.png",
    "hot-spot", { 3,  2}, "size", {28, 32} )
DefineCursor("cursor-green-hair", "human",
    "image", "ui/human/cursors/green_eagle.png",
    "hot-spot", {15, 15}, "size", {32, 32} )
DefineCursor("cursor-yellow-hair", "human",
    "image", "ui/human/cursors/yellow_eagle.png",
    "hot-spot", {15, 15}, "size", {32, 32} )
DefineCursor("cursor-red-hair", "human",
    "image", "ui/human/cursors/red_eagle.png",
    "hot-spot", {15, 15}, "size", {32, 32} )

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--	* Race human.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function HumanScreen(screen_width, screen_height)
  info_panel_x = 0
  info_panel_y = 160
  icon_size = {46, 38}

  DefineUI("human", screen_width, screen_height,
    "normal-font-color", "white",
    "reverse-font-color", "yellow",

    "filler", {
      "file", "graphics/ui/human/" ..
        screen_width .. "x" .. screen_height ..
        "/filler-right.png",
      "pos", { screen_width - 16, 0}},

    "resource-line", {
      "graphics/ui/human/" ..
        screen_width .. "x" .. screen_height ..
        "/resource.png",
      176, 0},

    "resources", {
      "gold", { "file", "graphics/ui/gold,wood,oil,mana.png", "row", 0,
        "pos", { 176 + 0, 0}, "size", {14, 14}, "text-pos", { 176 + 0 + 18, 1}},
      "wood", { "file", "graphics/ui/gold,wood,oil,mana.png", "row", 1,
        "pos", { 176 + 75, 0}, "size", {14, 14}, "text-pos", { 176 + 75 + 18, 1}},
      "oil", { "file", "graphics/ui/gold,wood,oil,mana.png", "row", 2,
        "pos", { 176 + 150, 0}, "size", {14, 14}, "text-pos", { 176 + 150 + 18, 1}},
      "food", { "file", "graphics/ui/food.png", "row", 0,
        "pos", { screen_width - 16 - 138, 0}, "size", {14, 14}, "text-pos", { (screen_width - 16 - 138) + 18, 1}},
      "score", { "file", "graphics/ui/score.png", "row", 0,
        "pos", { screen_width - 16 - 68, 0}, "size", {14, 14}, "text-pos", { (screen_width - 16 - 68) + 18, 1}}},

    "info-panel", {
      "panel", {
        "file", "graphics/ui/human/infopanel.png",
        "pos", { info_panel_x, info_panel_y},
        "size", {176, 176}
      },
      "selected", {
        "single", {
          "icon", {
            "pos", {  6, 166}, "size", icon_size}},
        "multiple", {
          "icons", {
            { "pos", {  6, 166}, "size", icon_size},
            { "pos", { 62, 166}, "size", icon_size},
            { "pos", {118, 166}, "size", icon_size},
            { "pos", {  6, 220}, "size", icon_size},
            { "pos", { 62, 220}, "size", icon_size},
            { "pos", {118, 220}, "size", icon_size},
            { "pos", {  6, 274}, "size", icon_size},
            { "pos", { 62, 274}, "size", icon_size},
            { "pos", {118, 274}, "size", icon_size}},
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
            "pos", { info_panel_x + 107, info_panel_y + 8 + 70},
            "size", icon_size}},
        "multiple", {
          "icons", {
            { "pos", {  6, 216}, "size", icon_size},
            { "pos", { 62, 216}, "size", icon_size},
            { "pos", {118, 216}, "size", icon_size},
            { "pos", {  6, 263}, "size", icon_size},
            { "pos", { 62, 263}, "size", icon_size},
            { "pos", {118, 263}, "size", icon_size}}}
      },
      "upgrading", {
        "text", {
          "text", "Upgrading:",
          "font", "game",
          "pos", { info_panel_x + 29, info_panel_y + 8 + 78}},
        "icon", {
          "pos", { info_panel_x + 107, info_panel_y + 8 + 70},
          "size", icon_size},
      },
      "researching", {
        "text", {
          "text", "Researching:",
          "font", "game",
          "pos", { info_panel_x + 16, info_panel_y + 8 + 78}},
        "icon", {
          "pos", { info_panel_x + 107, info_panel_y + 8 + 70},
          "size", icon_size}
      },
      "transporting", {
        "icons", {
          { "pos", {  6, 220}, "size", icon_size},
          { "pos", { 62, 220}, "size", icon_size},
          { "pos", {118, 220}, "size", icon_size},
          { "pos", {  6, 274}, "size", icon_size},
          { "pos", { 62, 274}, "size", icon_size},
          { "pos", {118, 274}, "size", icon_size}}
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
        "file", "graphics/ui/human/" ..
          screen_width .. "x" .. screen_height ..
          "/buttonpanel.png",
        "pos", {0, 336}},
      "icons", {
        {"pos", {  6, 337}, "size", icon_size},
        {"pos", { 62, 337}, "size", icon_size},
        {"pos", {118, 337}, "size", icon_size},
        {"pos", {  6, 384}, "size", icon_size},
        {"pos", { 62, 384}, "size", icon_size},
        {"pos", {118, 384}, "size", icon_size},
        {"pos", {  6, 431}, "size", icon_size},
        {"pos", { 62, 431}, "size", icon_size},
        {"pos", {118, 431}, "size", icon_size}}
    },

    "map-area", {
      "pos", {176, 16},
      "size", {
        (32 * math.floor((screen_width - 176 - 16) / 32)),
        (32 * math.floor((screen_height - 16 - 16) / 32))}},

    "menu-panel", {
      "panel", {
        "file", "graphics/ui/human/menubutton.png",
        "pos", {0, 0}},
      "menu-button", {
        "pos", {24, 2},
        "size", {128, 19},
        "caption", "Menu (~<F10~>)",
        "style", "main"},
      "network-menu-button", {
        "pos", {6, 2},
        "size", {80, 19},
        "caption", "Menu",
        "style", "network"},
      "network-diplomacy-button", {
        "pos", {90, 2},
        "size", {80, 19},
        "caption", "Diplomacy",
        "style", "network"},
    },

    "minimap", {
      "file", "graphics/ui/human/minimap.png",
      "panel-pos", {0, 24},
      "pos", {0 + 24, 24 + 2},
      "size", {128, 128}},

    "status-line", {
      "file", "graphics/ui/human/" ..
        screen_width .. "x" .. screen_height ..
        "/statusline.png",
      "pos", { 176, screen_height - 16},
      "text-pos", { 2 + 176, 2 + screen_height - 16},
      "font", "game"},

    "cursors", {
      "point", "cursor-point",
      "glass", "cursor-glass",
      "cross", "cursor-cross",
      "yellow", "cursor-yellow-hair",
      "green", "cursor-green-hair",
      "red", " cursor-red-hair",
      "scroll", " cursor-scroll",
      "arrow-e", " cursor-arrow-e",
      "arrow-ne", " cursor-arrow-ne",
      "arrow-n", " cursor-arrow-n",
      "arrow-nw", " cursor-arrow-nw",
      "arrow-w", " cursor-arrow-w",
      "arrow-sw", " cursor-arrow-sw",
      "arrow-s", " cursor-arrow-s",
      "arrow-se", " cursor-arrow-se"},

    "menu-panels", {
      "panel1", "graphics/ui/human/panel_1.png",
      "panel2", "graphics/ui/human/panel_2.png",
      "panel3", "graphics/ui/human/panel_3.png",
      "panel4", "graphics/ui/human/panel_4.png",
      "panel5", "graphics/ui/human/panel_5.png"},

    "victory-background", "graphics/ui/human/victory.png",
    "defeat-background", "graphics/ui/human/defeat.png")
end

HumanScreen(640, 480)
HumanScreen(800, 600)
HumanScreen(1024, 768)
HumanScreen(1280, 960)
HumanScreen(1600, 1200)
