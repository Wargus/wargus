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
--      ui.lua - Define the orc user interface
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

  local ui = {
    "info-panel", {
      "panels", {"panel-general-contents", "panel-attack-unit-contents",
                "panel-all-unit-contents", "panel-building-contents"},
      "completed-bar", {
        "color", {48, 100, 4}
      }
    }
  }
end

UI.NormalFontColor = "yellow"
UI.ReverseFontColor = "white"

b = CFiller:new_local()
b.G = CGraphic:New("ui/orc/infopanel.png", 176, 176)
b.X = 0
b.Y = 160
UI.Fillers:push_back(b)

function AddFiller(file, x, y)
	b = CFiller:new_local()
	b.G = CGraphic:New(file)
	b.X = x
	b.Y = y
	UI.Fillers:push_back(b)
end

AddFiller("ui/orc/" .. Video.Width .. "x" .. Video.Height  .. "/filler-right.png", Video.Width - 16, 0)
AddFiller("ui/orc/" .. Video.Width  .. "x" .. Video.Height .. "/resource.png", 176, 0)
AddFiller("ui/orc/" .. Video.Width  .. "x" .. Video.Height .. "/statusline.png", 176, Video.Height - 16)
AddFiller("ui/orc/" .. Video.Width .. "x" .. Video.Height .. "/buttonpanel.png", 0, 336)
AddFiller("ui/orc/menubutton.png", 0, 0)
AddFiller("ui/orc/minimap.png", 0, 24)

UI.InfoPanel.X = 0
UI.InfoPanel.Y = 160

b = CUIButton:new()
b.X = 9
b.Y = 160 + 9
b.Style = FindButtonStyle("icon")
UI.SingleSelectedButton = b

function AddSelectedButton(x, y)
	b = CUIButton:new_local()
	b.X = x
	b.Y = y
	b.Style = FindButtonStyle("icon")
	UI.SelectedButtons:push_back(b)
end

AddSelectedButton(9, 160 + 9)
AddSelectedButton(65, 160 + 9)
AddSelectedButton(121, 160 + 9)
AddSelectedButton(9, 160 + 63)
AddSelectedButton(65, 160 + 63)
AddSelectedButton(121, 160 + 63)
AddSelectedButton(9, 160 + 17)
AddSelectedButton(65, 160 + 17)
AddSelectedButton(121, 160 + 17)

UI.MaxSelectedFont = Fonts["game"]
UI.MaxSelectedTextX = 10
UI.MaxSelectedTextY = 160 + 10

b = CUIButton:new()
b.X = 110
b.Y = 160 + 11 + 70
b.Style = FindButtonStyle("icon")
UI.SingleTrainingButton = b

function AddTrainingButton(x, y)
	b = CUIButton:new_local()
	b.X = x
	b.Y = y
	b.Style = FindButtonStyle("icon")
	UI.TrainingButtons:push_back(b)
end

AddTrainingButton(9, 219)
AddTrainingButton(65, 219)
AddTrainingButton(121, 219)
AddTrainingButton(9, 266)
AddTrainingButton(65, 266)
AddTrainingButton(121, 266)

b = CUIButton:new()
b.X = 110
b.Y = 160 + 11 + 70
b.Style = FindButtonStyle("icon")
UI.UpgradingButton = b

b = CUIButton:new()
b.X = 110
b.Y = 160 + 11 + 70
b.Style = FindButtonStyle("icon")
UI.ResearchingButton = b

function AddTransportingButton(x, y)
	b = CUIButton:new_local()
	b.X = x
	b.Y = y
	b.Style = FindButtonStyle("icon")
	UI.TransportingButtons:push_back(b)
end

AddTransportingButton(9, 223)
AddTransportingButton(65, 223)
AddTransportingButton(121, 223)
AddTransportingButton(9, 277)
AddTransportingButton(65, 277)
AddTransportingButton(121, 277)

function AddButtonPanelButton(x, y)
	b = CUIButton:new_local()
	b.X = x
	b.Y = y
	b.Style = FindButtonStyle("icon")
	UI.ButtonPanel.Buttons:push_back(b)
end

AddButtonPanelButton(9, 340)
AddButtonPanelButton(65, 340)
AddButtonPanelButton(121, 340)
AddButtonPanelButton(9, 387)
AddButtonPanelButton(65, 387)
AddButtonPanelButton(121, 387)
AddButtonPanelButton(9, 434)
AddButtonPanelButton(65, 434)
AddButtonPanelButton(121, 434)

UI.ButtonPanel.AutoCastBorderColorRGB = CColor(0, 0, 252)

UI.MapArea.X = 176
UI.MapArea.Y = 16
UI.MapArea.EndX = Video.Width - 16 - 1
UI.MapArea.EndY = Video.Height - 16 - 1

UI.MapArea.ScrollPaddingLeft = 192
UI.MapArea.ScrollPaddingRight = 192
UI.MapArea.ScrollPaddingTop = 192
UI.MapArea.ScrollPaddingBottom = 192

UI.Minimap.X = 24
UI.Minimap.Y = 24 + 2
UI.Minimap.W = 128
UI.Minimap.H = 128

UI.StatusLine.TextX = 2 + 176
UI.StatusLine.TextY = Video.Height + 2 - 16
UI.StatusLine.Width = Video.Width - 16 - 2 - 176
UI.StatusLine.Font = Fonts["game"]

-- gold
UI.Resources[0].G = CGraphic:New("ui/gold,wood,oil,mana.png", 14, 14)
UI.Resources[0].IconFrame = 0
UI.Resources[0].IconX = 176 + 0
UI.Resources[0].IconY = 0
UI.Resources[0].TextX = 176 + 0 + 18
UI.Resources[0].TextY = 1

-- wood
UI.Resources[1].G = CGraphic:New("ui/gold,wood,oil,mana.png", 14, 14)
UI.Resources[1].IconFrame = 1
UI.Resources[1].IconX = 176 + 75
UI.Resources[1].IconY = 0
UI.Resources[1].TextX = 176 + 75 + 18
UI.Resources[1].TextY = 1

-- oil
UI.Resources[2].G = CGraphic:New("ui/gold,wood,oil,mana.png", 14, 14)
UI.Resources[2].IconFrame = 2
UI.Resources[2].IconX = 176 + 150
UI.Resources[2].IconY = 0
UI.Resources[2].TextX = 176 + 150 + 18
UI.Resources[2].TextY = 1

-- food
UI.Resources[FoodCost].G = CGraphic:New("ui/food.png", 14, 14)
UI.Resources[FoodCost].IconFrame = 0
UI.Resources[FoodCost].IconX = Video.Width - 16 - 138
UI.Resources[FoodCost].IconY = 0
UI.Resources[FoodCost].TextX = Video.Width - 16 - 138 + 18
UI.Resources[FoodCost].TextY = 1

-- score
UI.Resources[ScoreCost].G = CGraphic:New("ui/score.png", 14, 14)
UI.Resources[ScoreCost].IconFrame = 0
UI.Resources[ScoreCost].IconX = Video.Width - 16 - 68
UI.Resources[ScoreCost].IconY = 0
UI.Resources[ScoreCost].TextX = Video.Width - 16 - 68 + 18
UI.Resources[ScoreCost].TextY = 1

UI.MenuButton.X = 24
UI.MenuButton.Y = 2
UI.MenuButton.Text = "Menu (~<F10~>)"
UI.MenuButton.Style = FindButtonStyle("main")

UI.NetworkMenuButton.X = 6
UI.NetworkMenuButton.Y = 2
UI.NetworkMenuButton.Text = "Menu"
UI.NetworkMenuButton.Style = FindButtonStyle("network")

UI.NetworkDiplomacyButton.X = 90
UI.NetworkDiplomacyButton.Y = 2
UI.NetworkDiplomacyButton.Text = "Diplomacy"
UI.NetworkDiplomacyButton.Style = FindButtonStyle("network")

function AddMenuPanel(ident, file)
	b = CMenuPanel:new_local()
	b.Ident = ident
	b.G = CGraphic:New(file)
	UI.MenuPanels:push_back(b)
end

AddMenuPanel("panel1", "ui/orc/panel_1.png")
AddMenuPanel("panel2", "ui/orc/panel_2.png")
AddMenuPanel("panel3", "ui/orc/panel_3.png")
AddMenuPanel("panel4", "ui/orc/panel_4.png")
AddMenuPanel("panel5", "ui/orc/panel_5.png")
