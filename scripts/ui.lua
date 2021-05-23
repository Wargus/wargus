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
--      ui.lua - Define the user interface
--
--      (c) Copyright 2000-2007 by Lutz Sammer and Jimmy Salmon
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

Load("scripts/widgets.lua")

--
--  Define Decorations.
--
if (CanAccessFile("ui/health2.png")) then
	DefineSprites({Name = "sprite-health", File = "ui/health2.png", Offset = {0, -4}, Size = {31, 4}})

	DefineDecorations({Index = "HitPoints", HideNeutral = true, CenterX = true, ShowOpponent=true,
		OffsetPercent = {50, 100}, Method = {"sprite", {"sprite-health"}}})
end

if (CanAccessFile("ui/mana2.png")) then
	DefineSprites({Name = "sprite-mana", File = "ui/mana2.png", Offset = {0, -1}, Size = {31, 4}})

	DefineDecorations({Index = "Mana", HideNeutral = true, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
	DefineDecorations({Index = "Transport", HideNeutral = true, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
	DefineDecorations({Index = "Research", HideNeutral = true, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
	DefineDecorations({Index = "Training", HideNeutral = true, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
	DefineDecorations({Index = "UpgradeTo", HideNeutral = true, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
	DefineDecorations({Index = "GiveResource", ShowWhenMax = true, HideNeutral = false, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
	DefineDecorations({Index = "CarryResource", HideNeutral = false, CenterX = true,OffsetPercent = {50, 100},Method = {"sprite", {"sprite-mana"}}})
end
DefineSprites({Name = "sprite-spell", File = "ui/bloodlust,haste,slow,invisible,shield.png", Offset = {1, 1}, Size = {16, 16}})


DefineDecorations({Index = "Bloodlust", ShowOpponent = true,
  Offset = {0, 0}, Method = {"static-sprite", {"sprite-spell", 0}}})
DefineDecorations({Index = "Haste", ShowOpponent = true,
  Offset = {16, 0}, Method = {"static-sprite", {"sprite-spell", 1}}})
DefineDecorations({Index = "Slow", ShowOpponent = true,
  Offset = {16, 0}, Method = {"static-sprite", {"sprite-spell", 2}}})
DefineDecorations({Index = "Invisible", ShowOpponent = true,
  Offset = {32, 0}, Method = {"static-sprite", {"sprite-spell", 3}}})
DefineDecorations({Index = "UnholyArmor", ShowOpponent = true,
  Offset = {48, 0}, Method = {"static-sprite", {"sprite-spell", 4}}})

--
--  Define Panels
--
local info_panel_x = 0
local info_panel_y = 160


local min_damage = Div(ActiveUnitVar("PiercingDamage", "Value", "Initial"), 2)
local max_damage = Add(ActiveUnitVar("PiercingDamage", "Value", "Initial"), ActiveUnitVar("BasicDamage", "Value", "Initial"))
local damage_bonus = Sub(ActiveUnitVar("PiercingDamage", "Value", "Type"),
							ActiveUnitVar("PiercingDamage", "Value", "Initial"));


DefinePanelContents(
-- Default presentation. ------------------------
  {
  Ident = "panel-general-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "game",
  Contents = {
	{ Pos = {8, 51}, Condition = {ShowOpponent = false, HideNeutral = true},
		More = {"LifeBar", {Variable = "HitPoints", Height = 7, Width = 50}}
	},
	{ Pos = {35, 61}, Condition = {ShowOpponent = false, HideNeutral = true},
		More = {"FormattedText2", {
			Font = "small", Variable = "HitPoints", Format = "%d/%d",
			Component1 = "Value", Component2 = "Max", Centered = true}}
	},

	{ Pos = {114, 11}, More = {"Text", {Text = Line(1, UnitName("Active"), 110, "game"), Centered = true}} },
	{ Pos = {114, 25}, More = {"Text", {Text = Line(2, UnitName("Active"), 110, "game"), Centered = true}} },

-- Ressource Left
	{ Pos = {88, 86}, Condition = {ShowOpponent = false, GiveResource = "only", Build = "false"},
		More = {"Text", {Text = Concat(function() return _(ResourcesOnUI[GetUnitVariable(-1, "GiveResourceType", "Value") + 1]) end, String(ActiveUnitVar("GiveResource", "Value"))), Centered = true}}
	},

-- Construction
	{ Pos = {12, 153}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
		More = {"CompleteBar", {Variable = "Build", Width = 152, Height = 14, Border = false}}
	},
	{ Pos = {50, 155}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
		More = {"Text", _("% Complete")}},
	{ Pos = {107, 78}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
		More = {"Icon", {Unit = "Worker"}}}


  } },
-- Supply Building constructed.----------------
  {
  Ident = "panel-building-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "game",
  Condition = {ShowOpponent = false, HideNeutral = true, Center = "false", Build = "false", Supply = "only", Training = "false", UpgradeTo = "false"},
  Contents = {
-- Food building
	{ Pos = {100, 71}, More = {"Text", _("Usage~|")} },
	{ Pos = {100, 86},
          More = {
             "Text",
             {
                Text = Concat(_("Supply~|: "),
                              String(PlayerData(ActiveUnitVar("Player", "Value"), "Supply", "")))
             }
          }
        },
	{ Pos = {100, 102},
          More = {
             "Text",
             {
                Text = Concat(_("Demand~|: "),
                              If(GreaterThan(
                                    PlayerData(ActiveUnitVar("Player", "Value"), "Demand", ""),
                                    PlayerData(ActiveUnitVar("Player", "Value"), "Supply", "")),
                                 InverseVideo(String(PlayerData(ActiveUnitVar("Player", "Value"), "Demand", ""))),
                                 String(PlayerData(ActiveUnitVar("Player", "Value"), "Demand", ""))))
             }
          }
        }
  } },
  -- Center
  {
  Ident = "panel-center-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "game",
  Condition = {ShowOpponent = false, HideNeutral = true, Center = "only", Build = "false", Supply = "only", Training = "false", UpgradeTo = "false"},
  Contents = {
	{ Pos = {16, 71}, More = {"Text", _("Production")} },
	{ Pos = {85, 86}, More = { "Text", {Text = Concat(_("Gold~|: 100"), 
									If(GreaterThan(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "gold"), 100),
										InverseVideo(Concat("+", String(Sub(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "gold"), 100)))),
										"" ))}}
    },
	{ Pos = {85, 102}, Condition = {WoodImprove = "only"}, More = { "Text", {Text = Concat(_("Lumber~|: 100"), 
									If(GreaterThan(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "wood"), 100),
										InverseVideo(Concat("+", String(Sub(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "wood"), 100)))),
										"" ))}}
    },
	{ Pos = {85, 118}, Condition = {OilImprove = "only"}, More = { "Text", {Text = Concat(_("Oil~|: 100"), 
									If(GreaterThan(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "oil"), 100),
										InverseVideo(Concat("+", String(Sub(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "oil"), 100)))),
										"" ))}}
    },

  } },
  --res inmprovement
   {
  Ident = "panel-resimrove-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "game",
  Condition = {ShowOpponent = false, HideNeutral = true, Center = "false", Build = "false", Training = "false", UpgradeTo = "false", Research = "false"},
  Contents = {
	{ Pos = {16, 86}, Condition = {WoodImprove = "only"}, More = {"Text", _("Production")} },
	{ Pos = {16, 86}, Condition = {OilImprove = "only"}, More = {"Text", _("Production")} },
	{ Pos = {85, 102}, Condition = {WoodImprove = "only"}, More = { "Text", {Text = Concat(_("Lumber~|: 100"), 
									If(GreaterThan(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "wood"), 100),
										InverseVideo(Concat("+", String(Sub(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "wood"), 100)))),
										"" ))}}
    },
	{ Pos = {85, 102}, Condition = {OilImprove = "only"}, More = { "Text", {Text = Concat(_("Oil~|: 100"), 
									If(GreaterThan(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "oil"), 100),
										InverseVideo(Concat("+", String(Sub(PlayerData(ActiveUnitVar("Player", "Value"), "Incomes", "oil"), 100)))),
										"" ))}}
    },

  } },
-- All own unit -----------------
  {
  Ident = "panel-all-unit-contents",
  Pos = {info_panel_x, info_panel_y},
  DefaultFont = "game",
  Condition = {ShowOpponent = false, HideNeutral = true, Build = "false"},
  Contents = {
	{ Pos = {100, 86}, Condition = {BasicDamage = "only"},
		More = {"Text", {Text = Concat(_("Damage~|: "), String(min_damage), "-", String(max_damage),
								If(Equal(0, damage_bonus), "",
									InverseVideo(Concat("+", String(damage_bonus)))) )}}

	},
	{ Pos = {100, 86}, Condition = {PiercingDamage = "only"},
		More = {"Text", {Text = Concat(_("Damage~|: "), String(min_damage), "-", String(max_damage),
								If(Equal(0, damage_bonus), "",
									InverseVideo(Concat("+", String(damage_bonus)))) )}}

	},
	{ Pos = {100, 86}, Condition = {BasicDamage = "only", PiercingDamage = "only"},
		More = {"Text", {Text = Concat(_("Damage~|: "), String(min_damage), "-", String(max_damage),
								If(Equal(0, damage_bonus), "",
									InverseVideo(Concat("+", String(damage_bonus)))) )}}

	},
	{ Pos = {100, 71}, Condition = {PiercingDamage = "only", Armor = "only", Building = "only"},
		More = {"Text", {
					Text = _("Armor~|: "), Variable = "Armor", Stat = true}}
	},
	{ Pos = {100, 118}, Condition = {SightRange = "only", PiercingDamage = "only", Armor = "only", Building = "only"},
		More = {"Text", {Text = _("Sight~|: "), Variable = "SightRange", Stat = true}}
	},
	{ Pos = {100, 102}, Condition = {AttackRange = "only"},
		More = {"Text", {
					Text = _("Range~|: "), Variable = "AttackRange" , Stat = true}}
	},
-- Research
	{ Pos = {12, 153}, Condition = {Research = "only"},
		More = {"CompleteBar", {Variable = "Research", Width = 152, Height = 14, Border = false}}
	},
	{ Pos = {100, 86}, Condition = {Research = "only"}, More = {"Text", _("Researching~|:")}},
	{ Pos = {50, 154}, Condition = {Research = "only"}, More = {"Text", _("% Complete")}},
-- Training
	{ Pos = {12, 153}, Condition = {Training = "only"},
		More = {"CompleteBar", {Variable = "Training", Width = 152, Height = 14, Border = false}}
	},
	{ Pos = {50, 154}, Condition = {Training = "only"}, More = {"Text", _("% Complete")}},
-- Upgrading To
	{ Pos = {12, 153}, Condition = {UpgradeTo = "only"},
		More = {"CompleteBar", {Variable = "UpgradeTo", Width = 152, Height = 14, Border = false}}
	},
	{ Pos = {100,  86}, More = {"Text", _("Upgrading~|:")}, Condition = {UpgradeTo = "only"} },
	{ Pos = {50, 154}, More = {"Text", _("% Complete")}, Condition = {UpgradeTo = "only"} },
-- Resource Carry
	{ Pos = {100, 149}, Condition = {CarryResource = "only"},
		More = {"FormattedText2", {Format = _("Carry~|: %d %s"), Variable = "CarryResource",
				Component1 = "Value", Component2 = "Name"}}
	}

  } },
-- Attack Unit -----------------------------
  {
  Ident = "panel-attack-unit-contents",
  Pos = {info_panel_x, info_panel_y},
  DefaultFont = "game",
  Condition = {ShowOpponent = true, HideNeutral = true, Building = "false", Build = "false"},
  Contents = {
-- Unit caracteristics
	{ Pos = {154, 41},
		More = {"FormattedText", {Variable = "Level", Format = _("Level ~|~<%d~>")}}
	},
	{ Pos = {154, 56}, Condition = {ShowOpponent = false},
		More = {"FormattedText2", {Centered = true, 
			Variable1 = "Xp", Variable2 = "Kill", Format = _("XP:~<%d~> Kills:~|~<%d~>")}}
	},
	{ Pos = {100, 71}, Condition = {Armor = "only"},
		More = {"Text", {
					Text = _("Armor~|: "), Variable = "Armor", Stat = true}}
	},
	{ Pos = {100, 118}, Condition = {SightRange = "only"},
		More = {"Text", {Text = _("Sight~|: "), Variable = "SightRange", Stat = true}}
	},
	{ Pos = {100, 133}, Condition = {Speed = "only"},
		More = {"Text", {Text = _("Speed~|: "), Variable = "Speed", Stat = true}}
	},
	-- Mana
	{ Pos = {100, 148}, Condition = {Mana = "only"},
		More = {"Text", {Text = _("Mana~|: ")}}
	},
	{ Pos = {103, 148}, Condition = {Mana = "only"},
		More = {"CompleteBar", {Color = "light-blue", Variable = "Mana", Height = 14, Width = 60, Border = true}}
	},
	{ Pos = {126, 149}, More = {"Text", {Variable = "Mana", Centered = true}}, Condition = {Mana = "only"} }} })

Load("scripts/human/ui.lua")
Load("scripts/orc/ui.lua")

wargus.playlist = { "music/Orc Briefing" .. wargus.music_extension }

UI.MessageFont = Fonts["game"]
UI.MessageScrollSpeed = 5

UI.EditorSettingsAreaTopLeft.x = UI.InfoPanel.X
UI.EditorSettingsAreaTopLeft.y = UI.InfoPanel.Y
UI.EditorSettingsAreaBottomRight.x = UI.MapArea.X
UI.EditorSettingsAreaBottomRight.y = UI.ButtonPanel.Y

UI.EditorButtonAreaTopLeft.x = UI.ButtonPanel.X
UI.EditorButtonAreaTopLeft.y = UI.ButtonPanel.Y
UI.EditorButtonAreaBottomRight.x = UI.MapArea.X
UI.EditorButtonAreaBottomRight.y = UI.MapArea.EndY

DefineCursor({
  Name = "cursor-glass",
  Race = "any",
  File = "ui/cursors/magnifying_glass.png",
  HotSpot = {11, 11},
  Size = {34, 35}})
DefineCursor({
  Name = "cursor-cross",
  Race = "any",
  File = "ui/cursors/small_green_cross.png",
  HotSpot = { 8,  8},
  Size = {18, 18}})
if (CanAccessFile("ui/cursors/cross.png")) then
  DefineCursor({
	Name = "cursor-scroll",
	Race = "any",
	File = "ui/cursors/cross.png",
	HotSpot = {15, 15},
	Size = {32, 32}})
end
DefineCursor({
  Name = "cursor-arrow-e",
  Race = "any",
  File = "ui/cursors/arrow_E.png",
  HotSpot = {22, 10},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-ne",
  Race = "any",
  File = "ui/cursors/arrow_NE.png",
  HotSpot = {20,  2},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-n",
  Race = "any",
  File = "ui/cursors/arrow_N.png",
  HotSpot = {12,  2},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-nw",
  Race = "any",
  File = "ui/cursors/arrow_NW.png",
  HotSpot = { 2,  2},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-w",
  Race = "any",
  File = "ui/cursors/arrow_W.png",
  HotSpot = { 4, 10},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-s",
  Race = "any",
  File = "ui/cursors/arrow_S.png",
  HotSpot = {12, 22},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-sw",
  Race = "any",
  File = "ui/cursors/arrow_SW.png",
  HotSpot = { 2, 18},
  Size = {32, 24}})
DefineCursor({
  Name = "cursor-arrow-se",
  Race = "any",
  File = "ui/cursors/arrow_SE.png",
  HotSpot = {20, 18},
  Size = {32, 24}})

function GetRGBA(r, g, b, a)
        return b + g*0x100 + r*0x10000 + a*0x1000000
end

PopupFont = "small"

local HumanPopupBackgroundColor = GetRGBA(0,32,96, 208)
local HumanPopupBorderColor = GetRGBA(192,192,255, 160)
local OrcPopupBackgroundColor = GetRGBA(96,0,0, 192)
local OrcPopupBorderColor = GetRGBA(168,140,16, 160)

if (wc2.preferences.ShowButtonPopups) then
	DefinePopup({
		Ident = "popup-commands",
		BackgroundColor = GetRGBA(128,128,128, 160),
		BorderColor = GetRGBA(192,192,255, 160),
		Contents = {
				{ 	Margin = {1, 1}, 
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = GetRGBA(192,192,255, 160)}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1},
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				}, 
		}	
	})

	DefinePopup({
		Ident = "popup-human-commands",
		BackgroundColor = HumanPopupBackgroundColor,
		BorderColor = HumanPopupBorderColor,
		Contents = {
				{ 	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				}, 
				-- Move  hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "move"},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "move"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<ALT~>-click to defend unit."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				{ 	Condition = {ButtonAction = "move"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<SHIFT~>-click to make waypoints."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				-- Repair hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "repair"},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "repair"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<CTRL~>-click on button enables/disables auto-repair of damaged buildings."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				}
		}	
	})

	DefinePopup({
		Ident = "popup-human-building",
		BackgroundColor = HumanPopupBackgroundColor,
		BorderColor = HumanPopupBorderColor,
		Contents = {
				{	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	More = {"Costs"}, HighlightColor = "full-red",
				}, 
				{ 	Condition = {HitPoints = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Hit Points: "), Variable = "HitPoints", Font = PopupFont}}
				}, 
				{ 	Condition = {Armor = "only", AttackRange = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Armor: "), Variable = "Armor", Font = PopupFont}}
				},
				{ 	Condition = {BasicDamage = "only", AttackRange = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Font = PopupFont, Text = Concat(_("Damage~|: "), 
								String(Div(TypeVar("PiercingDamage", "Value", "Initial"), 2)), "-", 
								String(Add(TypeVar("PiercingDamage", "Value", "Initial"), TypeVar("BasicDamage", "Value", "Initial"))),
								If(Equal(0, Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial"))), "",
									InverseVideo(Concat("+", String(Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial")))))) )}}
				}, 
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				-- Multi-build hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "build"},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "build"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<SHIFT~>-click could be used to make a building queue."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				}
		}	
	})

	DefinePopup({
		Ident = "popup-human-unit",
		BackgroundColor = HumanPopupBackgroundColor,
		BorderColor = HumanPopupBorderColor,
		Contents = {
				{	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	More = {"Costs"}, HighlightColor = "full-red",
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	Condition = {HitPoints = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Hit Points: "), Variable = "HitPoints", Font = PopupFont}}
				},
				{ 	HighlightColor = "full-red",
					More = {"Variable", {Text = _("Armor: "), Variable = "Armor", Font = PopupFont}}
				},
				{ 	Condition = {SightRange = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Sight: "), Variable = "SightRange", Font = PopupFont}}
				},
				{ 	HighlightColor = "full-red",
					More = {"Variable", {Text = _("Range: "), Variable = "AttackRange", Font = PopupFont}}
				},
				{ 	Condition = {BasicDamage = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Font = PopupFont, Text = Concat(_("Damage~|: "), 
								String(Div(TypeVar("PiercingDamage", "Value", "Initial"), 2)), "-", 
								String(Add(TypeVar("PiercingDamage", "Value", "Initial"), TypeVar("BasicDamage", "Value", "Initial"))),
								If(Equal(0, Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial"))), "",
									InverseVideo(Concat("+", String(Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial")))))) )}}
				},
				
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
		}	
	})
	
	DefinePopup({
		Ident = "popup-human-upgrade",
		BackgroundColor = HumanPopupBackgroundColor,
		BorderColor = HumanPopupBorderColor,
		Contents = {
				{	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	More = {"Costs"}, HighlightColor = "full-red",
				},
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				-- Auto-cast hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "cast-spell"},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "cast-spell"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<CTRL~>-click on button enables/disables auto-cast ability."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				}
		}	
	})

	DefinePopup({
		Ident = "popup-orc-commands",
		BackgroundColor = OrcPopupBackgroundColor,
		BorderColor = OrcPopupBorderColor,
		Contents = {
				{ 	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				}, 
				-- Move  hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "move"},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "move"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<ALT~>-click to defend unit."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				{ 	Condition = {ButtonAction = "move"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<SHIFT~>-click to make waypoints."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				-- Repair hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "repair"},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "repair"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<CTRL~>-click on button enables/disables auto-repair of damaged buildings."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				}
		}	
	})
	
	DefinePopup({
		Ident = "popup-orc-building",
		BackgroundColor = OrcPopupBackgroundColor,
		BorderColor = OrcPopupBorderColor,
		Contents = {
				{	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				}, 
				{ 	More = {"Costs"}, HighlightColor = "full-red",
				}, 
				{ 	Condition = {HitPoints = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Hit Points: "), Variable = "HitPoints", Font = PopupFont}}
				}, 
				{ 	Condition = {Armor = "only", AttackRange = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Armor: "), Variable = "Armor", Font = PopupFont}}
				},
				{ 	Condition = {BasicDamage = "only", AttackRange = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Font = PopupFont, Text = Concat(_("Damage~|: "), 
								String(Div(TypeVar("PiercingDamage", "Value", "Initial"), 2)), "-", 
								String(Add(TypeVar("PiercingDamage", "Value", "Initial"), TypeVar("BasicDamage", "Value", "Initial"))),
								If(Equal(0, Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial"))), "",
									InverseVideo(Concat("+", String(Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial")))))) )}}
				}, 
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				-- Multi-build hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "build"},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "build"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<SHIFT~>-click could be used to make a building queue."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				}
		}	
	})
	
	DefinePopup({
		Ident = "popup-orc-unit",
		BackgroundColor = OrcPopupBackgroundColor,
		BorderColor = OrcPopupBorderColor,
		Contents = {
				{	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				}, 
				{ 	More = {"Costs"}, HighlightColor = "full-red",
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				}, 
				{ 	Condition = {HitPoints = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Hit Points: "), Variable = "HitPoints", Font = PopupFont}}
				},
				{ 	HighlightColor = "full-red",
					More = {"Variable", {Text = _("Armor: "), Variable = "Armor", Font = PopupFont}}
				},
				{ 	Condition = {SightRange = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Text = _("Sight: "), Variable = "SightRange", Font = PopupFont}}
				},
				{ 	HighlightColor = "full-red",
					More = {"Variable", {Text = _("Range: "), Variable = "AttackRange", Font = PopupFont}}
				},
				{ 	Condition = {BasicDamage = "only"}, HighlightColor = "full-red",
					More = {"Variable", {Font = PopupFont, Text = Concat(_("Damage~|: "), 
								String(Div(TypeVar("PiercingDamage", "Value", "Initial"), 2)), "-", 
								String(Add(TypeVar("PiercingDamage", "Value", "Initial"), TypeVar("BasicDamage", "Value", "Initial"))),
								If(Equal(0, Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial"))), "",
									InverseVideo(Concat("+", String(Sub(TypeVar("PiercingDamage", "Value", "Type"),
							TypeVar("PiercingDamage", "Value", "Initial")))))) )}}
				},
				
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
		}	
	})
	
	DefinePopup({
		Ident = "popup-orc-upgrade",
		BackgroundColor = OrcPopupBackgroundColor,
		BorderColor = OrcPopupBorderColor,
		Contents = {
				{	Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
				}, 
				{ 	Margin = {1, 1},
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	More = {"Costs"}, HighlightColor = "full-red",
				},
				-- Description
				{ 	Margin = {1, 1}, Condition = {HasDescription = true}, 
					More = {"Line", {Width = 0, Height = 1, Color = HumanPopupBorderColor}}
				}, 
				{ 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "full-red",
					More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
				},
				-- Auto-cast hint
				{ 	Margin = {1, 1}, Condition = {ButtonAction = "cast-spell"},
					More = {"Line", {Width = 0, Height = 1, Color = OrcPopupBorderColor}}
				},
				{ 	Condition = {ButtonAction = "cast-spell"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
					More = {"Text", {Text = _("~<CTRL~>-click on button enables/disables auto-cast ability."), MaxWidth = Video.Width / 5, Font = PopupFont}}
				}
		}	
	})
end
