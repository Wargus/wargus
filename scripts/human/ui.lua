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
--      ui.lua - Define the human user interface
--
--      (c) Copyright 2001-2004 by Lutz Sammer and Jimmy Salmon
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

DefineCursor({
  Name = "cursor-point",
  Race = "human",
  File = "ui/human/cursors/human_gauntlet.png",
  HotSpot = { 3,  2},
  Size = {28, 32}})
DefineCursor({
  Name = "cursor-green-hair",
  Race = "human",
  File = "ui/human/cursors/green_eagle.png",
  HotSpot = {15, 15},
  Size = {32, 32}})
DefineCursor({
  Name = "cursor-yellow-hair",
  Race = "human",
  File = "ui/human/cursors/yellow_eagle.png",
  HotSpot = {15, 15},
  Size = {32, 32}})
DefineCursor({
  Name = "cursor-red-hair",
  Race = "human",
  File = "ui/human/cursors/red_eagle.png",
  HotSpot = {15, 15},
  Size = {32, 32}})

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--	* Race human.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function HumanScreen(screen_width, screen_height)
  local info_panel_x = 0
  local info_panel_y = 160

  DefineUI("human", screen_width, screen_height,
    "normal-font-color", "white",
    "reverse-font-color", "yellow",

    "filler", {
      File = "graphics/ui/human/" .. screen_width .. "x" .. screen_height .. "/filler-right.png",
      Pos = { screen_width - 16, 0}},
    "filler", {
      File = "graphics/ui/human/" .. screen_width .. "x" .. screen_height .. "/resource.png",
      Pos = {176, 0}},
    "filler", {
      File = "graphics/ui/human/" .. screen_width .. "x" .. screen_height .. "/statusline.png",
      Pos = {176, screen_height - 16}},
    "filler", {
      File = "graphics/ui/human/menubutton.png",
      Pos = {0, 0}},
    "filler", {
      File = "graphics/ui/human/minimap.png",
      Pos = {0, 24}},

    "resources", {
      "gold", { File = "graphics/ui/gold,wood,oil,mana.png", Frame = 0,
        Pos = { 176 + 0, 0}, Size = {14, 14}, TextPos = { 176 + 0 + 18, 1}},
      "wood", { File = "graphics/ui/gold,wood,oil,mana.png", Frame = 1,
        Pos = { 176 + 75, 0}, Size = {14, 14}, TextPos = { 176 + 75 + 18, 1}},
      "oil", { File = "graphics/ui/gold,wood,oil,mana.png", Frame = 2,
        Pos = { 176 + 150, 0}, Size = {14, 14}, TextPos = { 176 + 150 + 18, 1}},
      "food", { File = "graphics/ui/food.png", Frame = 0,
        Pos = { screen_width - 16 - 138, 0}, Size = {14, 14}, TextPos = { (screen_width - 16 - 138) + 18, 1}},
      "score", { File = "graphics/ui/score.png", Frame = 0,
        Pos = { screen_width - 16 - 68, 0}, Size = {14, 14}, TextPos = { (screen_width - 16 - 68) + 18, 1}}},

    "info-panel", {
      "panel", {
        "file", "graphics/ui/human/infopanel.png",
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
          "style", "icon"},
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
        "file", "graphics/ui/human/" ..
          screen_width .. "x" .. screen_height ..
          "/buttonpanel.png",
        "pos", {0, 336}},
      "icons", {
        {"pos", {  9, 340}, "style", "icon"},
        {"pos", { 65, 340}, "style", "icon"},
        {"pos", {121, 340}, "style", "icon"},
        {"pos", {  9, 387}, "style", "icon"},
        {"pos", { 65, 387}, "style", "icon"},
        {"pos", {121, 387}, "style", "icon"},
        {"pos", {  9, 434}, "style", "icon"},
        {"pos", { 65, 434}, "style", "icon"},
        {"pos", {121, 434}, "style", "icon"}},
      "auto-cast-border-color", {0, 0, 252},
    },

    "map-area", {
      Pos = {176, 16},
      Size = {
        screen_width - 176 - 16,
        screen_height - 16 - 16}},

    "menu-panel", {
      "menu-button", {
        Pos = {24, 2},
        Caption = "Menu (~<F10~>)",
        Style = "main"},
      "network-menu-button", {
        Pos = {6, 2},
        Caption = "Menu",
        Style = "network"},
      "network-diplomacy-button", {
        Pos = {90, 2},
        Caption = "Diplomacy",
        Style = "network"},
    },

    "minimap", {
      Pos = {0 + 24, 24 + 2},
      Size = {128, 128}},

    "status-line", {
      TextPos = {2 + 176, 2 + screen_height - 16},
      Font = "game",
      Width = screen_width - 16 - 2 - 176},

    "cursors", {
      Point = "cursor-point",
      Glass = "cursor-glass",
      Cross = "cursor-cross",
      Yellow = "cursor-yellow-hair",
      Green = "cursor-green-hair",
      Red = "cursor-red-hair",
      Scroll = "cursor-scroll",
      ArrowE = "cursor-arrow-e",
      ArrowNE = "cursor-arrow-ne",
      ArrowN = "cursor-arrow-n",
      ArrowNW = "cursor-arrow-nw",
      ArrowW = "cursor-arrow-w",
      ArrowSW = "cursor-arrow-sw",
      ArrowS = "cursor-arrow-s",
      ArrowSE = "cursor-arrow-se"},

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
