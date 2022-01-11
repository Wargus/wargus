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
--      units.lua - Define the used unit-types.
--
--      (c) Copyright 1998-2005 by Lutz Sammer and Jimmy Salmon
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

UnitTypeFiles = {}

function ShadowDefinition(scale)
   if wc2.preferences.UseFancyShadows then
      return {"offset", {3, 21}, "scale", 1}
   else
      return {"file", "missiles/unit_shadow.png", "size", {32, 32}, "offset", {-3 * (scale + 1), 10 * (scale + 1)}, "sprite-frame", scale}
   end
end

-- animations for units need to spawn the appropriate death revealer when the
-- death animation starts. These monkey patches on DefineAnimations and
-- DefineUnitType take care of inserting the appropriate spawn in the Death
-- animation of each unit
local OldDefineUnitType = DefineUnitType
local OldDefineAnimations = DefineAnimations

local animationspecs = {}
function DefineAnimations(name, tbl)
   animationspecs[name] = tbl
end
local function tableShallowCopy(tbl)
   res = {}
   for k,v in pairs(tbl) do
      res[k] = v
   end
   return res
end
function DefineUnitType(name, tbl)
   local sight = tbl["SightRange"]
   local size = tbl["TileSize"][1]
   local animName = tbl["Animations"]
   local animSpec = animationspecs[animName]
   if animSpec == nil then
      error("No animation " .. animName .. " defined for unit " .. name)
   end
   local animDeath = animSpec["Death"]
   local corpse = tbl["Corpse"]
   local explodeWhenKilled = tbl["ExplodeWhenKilled"]
   local vanishes = tbl["Vanishes"] or tbl["Revealer"]
   if (animDeath or corpse or explodeWhenKilled) and not vanishes and sight > 0 then
      -- the unit has a Death animation or a corpse and is not itself a corpse
      -- that vanishes, so we want to spawn a dead vision revealer.
      animSpec = tableShallowCopy(animSpec) -- shallow copy of the anim table, because we'll replace the Death anim
      if animDeath ~= nil then
         animDeath = tableShallowCopy(animDeath) -- shallow copy of the death animations, because we'll insert the dead vision
      else
         animDeath = {"wait 1"} -- we need to wait 1 otherwise we won't finish
      end

      -- we just redefine always. the existing unit and animation will be
      -- overridden with the same values
      local deadVisionName = "unit-dead-vision-" .. size .. "-" .. sight
      OldDefineAnimations("animations-dead-vision", { Still = { "frame 0", "wait 80", "set-var SightRange.Max = 1", "wait 80", "die" } })
      OldDefineUnitType(deadVisionName, {
                           Name = "Reveal Death Location " .. size .. "-" .. sight,
                           TileSize = {size, size},
                           BoxSize = {size, size},
                           SightRange = sight,
                           Indestructible = true, NonSolid = true, SelectableByRectangle = false,
                           BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
                           Animations = "animations-dead-vision", Icon = "icon-holy-vision",
                           Speed = 0, HitPoints = 1, Priority = 0, Type = tbl["Type"], VisibleUnderFog = true,
                           Revealer = true, Vanishes = true, DetectCloak = false, Sounds = {}})

      table.insert(animDeath, 1, "spawn-unit " .. deadVisionName .. " 0 0 0 l.this")
      animSpec["Death"] = animDeath

      local unitAnimName = animName .. "-size-" .. size .. "-sight-" .. sight
      OldDefineAnimations(unitAnimName, animSpec)
      tbl["Animations"] = unitAnimName
      -- print("Updating Death animation with revealer " .. deadVisionName .. " for " .. name .. " with " .. unitAnimName)
   else
      -- print("NOT updating Death animation with revealer for " .. name)
      OldDefineAnimations(animName, animSpec)
   end

   return OldDefineUnitType(name, tbl)
end

-- Load the animations for the units.
Load("scripts/anim.lua")

--=============================================================================
--	Define unit-types.
--
--	NOTE: Save can generate this table.
--
DefineUnitType("unit-nothing-22", { Name = _("Nothing 22"),
  Animations = "animations-building", Icon = "icon-cancel",
  Speed = 99,
  HitPoints = 10,
  DrawLevel = 0,
  TileSize = {0, 0}, BoxSize = {0, 0},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Sounds = {} } )

DefineUnitType("unit-nothing-24", { Name = _("Nothing 24"),
  Animations = "animations-building", Icon = "icon-cancel",
  Costs = {"time", 60, "gold", 400},
  Speed = 99,
  HitPoints = 60,
  DrawLevel = 10,
  TileSize = {1, 1}, BoxSize = {63, 63},
  SightRange = 4, ComputerReactionRange = 20, PersonReactionRange = 10,
  Armor = 2, BasicDamage = 9, PiercingDamage = 1, Missile = "missile-none",
  MaxAttackRange = 1,
  Priority = 40,
  Type = "naval",
  SeaUnit = true,
  SelectableByRectangle = true,
  Sounds = {} } )

DefineUnitType("unit-nothing-25", { Name = _("Nothing 25"),
  Animations = "animations-building", Icon = "icon-cancel",
  Costs = {"time", 60, "gold", 400},
  Speed = 99,
  HitPoints = 60,
  DrawLevel = 10,
  TileSize = {1, 1}, BoxSize = {63, 63},
  SightRange = 4, ComputerReactionRange = 20, PersonReactionRange = 10,
  Armor = 2, BasicDamage = 9, PiercingDamage = 1, Missile = "missile-none",
  MaxAttackRange = 1,
  Priority = 40,
  Type = "naval",
  SeaUnit = true,
  SelectableByRectangle = true,
  Sounds = {} } )

DefineUnitType("unit-nothing-30", { Name = _("Nothing 30"),
  Animations = "animations-building", Icon = "icon-cancel",
  Speed = 99,
  HitPoints = 0,
  Indestructible = 1,
  DrawLevel = 10,
  TileSize = {0, 0}, BoxSize = {0, 0},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Sounds = {} } )

DefineUnitType("unit-nothing-36", { Name = _("Nothing 36"),
  Animations = "animations-building", Icon = "icon-cancel",
  Speed = 99,
  HitPoints = 0,
  Indestructible = 1,
  DrawLevel = 10,
  TileSize = {0, 0}, BoxSize = {0, 0},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Sounds = {} } )

DefineUnitType("unit-daemon", { Name = _("Daemon"),
  Image = {"file", "neutral/units/daemon.png", "size", {72, 72}},
  Shadow = ShadowDefinition(1),
  Animations = "animations-daemon", Icon = "icon-daemon",
  Costs = {"time", 70, "gold", 500, "oil", 50},
  NeutralMinimapColor = {192, 0, 0},
  Speed = 14,
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  Type = "fly",
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  AirUnit = true,
  DetectCloak = true,
  organic = true,
  SelectableByRectangle = true,
  Sounds = {
    "selected", "daemon-selected",
--    "acknowledge", "daemon-acknowledge",
--    "ready", "daemon-ready",
    "help", "basic orc voices help 1",
    "dead", "daemon-dead"} } )


UnitTypeFiles["unit-critter"] = {summer = "tilesets/summer/neutral/units/critter.png",
  winter = "tilesets/winter/neutral/units/critter.png",
  wasteland = "tilesets/wasteland/neutral/units/critter.png",
  swamp = "tilesets/swamp/neutral/units/critter.png"}

DefineUnitType("unit-critter", { Name = _("Critter"),
  Image = {"size", {32, 32}},
  Animations = "animations-critter", Icon = "icon-critter",
  NeutralMinimapColor = {192, 192, 192},
  Speed = 3,
  HitPoints = 5,
  DrawLevel = 35,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 2, ComputerReactionRange = 20, PersonReactionRange = 10,
  BasicDamage = 80, PiercingDamage = 0, Missile = "missile-critter-explosion",
  MaxAttackRange = 1,
  Priority = 37,
  Points = 1,
  Demand = 1,
  Type = "land",
  RightMouseAction = "move",
  CanTargetLand = true,
  LandUnit = true,
  RandomMovementProbability = 100,
  ClicksToExplode = 10,
  organic = true,
  Sounds = {
    "selected", "critter-selected",
--    "acknowledge", "critter-acknowledge",
--    "ready", "critter-ready",
    "help", "critter-help",
    "dead", "critter-dead"} } )


UnitTypeFiles["unit-gold-mine"] = {summer = "tilesets/summer/neutral/buildings/gold_mine.png",
  winter = "tilesets/winter/neutral/buildings/gold_mine.png",
  wasteland = "tilesets/wasteland/neutral/buildings/gold_mine.png",
  swamp = "tilesets/swamp/neutral/buildings/gold_mine.png"}

DefineUnitType("unit-gold-mine", { Name = _("Gold Mine"),
  Image = {"size", {96, 96}},
  Animations = "animations-gold-mine", Icon = "icon-gold-mine",
  NeutralMinimapColor = {255, 255, 0},
  Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-land2",
  Speed = 0,
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-3x3-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
  BuildingRules = { { "distance", { Distance = 3, DistanceType = ">", Type = "unit-town-hall"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-keep"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-castle"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-great-hall"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-stronghold"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-fortress"}}
				  },

  GivesResource = "gold", CanHarvest = true,
  Sounds = {
    "selected", "gold-mine-selected",
--    "acknowledge", "gold-mine-acknowledge",
--    "ready", "gold-mine-ready",
    "help", "gold-mine-help",
    "dead", "building destroyed"} } )


UnitTypeFiles["unit-oil-patch"] = {summer = "tilesets/summer/neutral/buildings/oil_patch.png",
  winter = "tilesets/summer/neutral/buildings/oil_patch.png",
  wasteland = "tilesets/wasteland/neutral/buildings/oil_patch.png",
  swamp = "tilesets/swamp/neutral/buildings/oil_patch.png"}

DefineUnitType("unit-oil-patch", { Name = _("Oil Patch"),
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-oil-patch",
  NeutralMinimapColor = {0, 0, 0},
  Neutral = true,
  Speed = 0,
  HitPoints = 0,
  Indestructible = 1,
  DrawLevel = 5,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "naval",
  Building = true, VisibleUnderFog = true,
  BuildingRules = { { "distance", { Distance = 3, DistanceType = ">", Type = "unit-human-shipyard"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-human-refinery"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-orc-shipyard"}},
					{ "distance", { Distance = 3, DistanceType = ">", Type = "unit-orc-refinery"}}
				  },
  GivesResource = "oil",
  Sounds = {
    "selected", "oil-patch-selected",
--    "acknowledge", "oil-patch-acknowledge",
--    "ready", "oil-patch-ready",
--    "help", "oil-patch-help",
    "dead", "building destroyed"} } )

DefineUnitType("unit-pile-circle", { Name = _("The Pile"),
  Image = {"file", "neutral/buildings/circle_of_power.png", "size", {64, 64}},
  Animations = "animations-building", Icon = "icon-circle-of-power",
  NeutralMinimapColor = {128, 128, 0},
  Neutral = true,
  Speed = 0,
  HitPoints = 0,
  Indestructible = 1,
  DrawLevel = 5,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Sounds = {
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )
	
DefineUnitType("unit-circle-of-power", { Name = _("Circle of Power"),
  Image = {"file", "neutral/buildings/circle_of_power.png", "size", {64, 64}},
  Animations = "animations-building", Icon = "icon-circle-of-power",
  NeutralMinimapColor = {128, 128, 0},
  Neutral = true,
  Speed = 0,
  HitPoints = 0,
  Indestructible = 1,
  DrawLevel = 5,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Sounds = {
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )


UnitTypeFiles["unit-dark-portal"] = {summer = "tilesets/summer/neutral/buildings/dark_portal.png",
  winter = "tilesets/winter/neutral/buildings/dark_portal.png",
  wasteland = "tilesets/wasteland/neutral/buildings/dark_portal.png",
  swamp = "tilesets/swamp/neutral/buildings/dark_portal.png"}

DefineUnitType("unit-dark-portal", { Name = _("Dark Portal"),
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-dark-portal",
  NeutralMinimapColor = {255, 255, 0},
  Costs = {"time", 100, "gold", 3000, "wood", 3000, "oil", 1000},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1, "oil", 1},
  Construction = "construction-land2",
  Speed = 0,
  HitPoints = 5000,
  DrawLevel = 40,
  Mana = {Enable = true},
  TileSize = {4, 4}, BoxSize = {127, 127},
  SightRange = 4,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-4x4-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, BuilderOutside = true,
  Teleporter = true,
  Sounds = {
--    "selected", "dark-portal-selected",
--    "acknowledge", "dark-portal-acknowledge",
--    "ready", "dark-portal-ready",
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )


UnitTypeFiles["unit-runestone"] = {summer = "neutral/buildings/runestone.png",
  winter = "tilesets/winter/neutral/buildings/runestone.png",
  wasteland = "neutral/buildings/runestone.png",
  swamp = "tilesets/swamp/neutral/buildings/runestone.png"}

DefineUnitType("unit-runestone", { Name = _("Runestone"),
  Image = {"size", {64, 64}},
  Animations = "animations-building", Icon = "icon-runestone",
  NeutralMinimapColor = {255, 255, 0},
  Costs = {"time", 175, "gold", 900, "wood", 500},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land2",
  Speed = 0,
  HitPoints = 5000,
  DrawLevel = 40,
  Mana = {Enable = true},
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 4,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 15, AnnoyComputerFactor = 35,
  Points = 150,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, BuilderOutside = true,
  Sounds = {
--    "selected", "runestone-selected",
--    "acknowledge", "runestone-acknowledge",
--    "ready", "runestone-ready",
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

DefineUnitType("unit-human-dead-body", { Name = _("Dead Body"),
  Image = {"file", "neutral/units/corpses.png", "size", {72, 72}},
  Animations = "animations-human-dead-body", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 30,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-orc-dead-body", { Name = _("Dead Body"),
  Image = {"file", "neutral/units/corpses.png", "size", {72, 72}},
  Animations = "animations-orc-dead-body", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 30,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-dead-sea-body", { Name = _("Dead Body"),
  Image = {"file", "neutral/units/corpses.png", "size", {72, 72}},
  Animations = "animations-dead-sea-body", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 30,
  TileSize = {2, 2}, BoxSize = {31, 31},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "naval",
  Vanishes = true,
  Sounds = {} } )


UnitTypeFiles["unit-destroyed-1x1-place"] = {
  summer = "tilesets/summer/neutral/buildings/small_destroyed_site.png",
  winter = "tilesets/winter/neutral/buildings/small_destroyed_site.png",
  wasteland = "tilesets/wasteland/neutral/buildings/small_destroyed_site.png",
  swamp = "tilesets/swamp/neutral/buildings/small_destroyed_site.png"}

DefineUnitType("unit-destroyed-1x1-place", { Name = _("Destroyed 1x1 Place"),
  Image = {"size", {32, 32}},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )


UnitTypeFiles["unit-destroyed-2x2-place"] = {summer = "tilesets/summer/neutral/buildings/destroyed_site.png",
  winter = "tilesets/winter/neutral/buildings/destroyed_site.png",
  wasteland = "tilesets/wasteland/neutral/buildings/destroyed_site.png",
  swamp = "tilesets/swamp/neutral/buildings/destroyed_site.png"}

DefineUnitType("unit-destroyed-2x2-place", { Name = _("Destroyed 2x2 Place"),
  Image = {"size", {64, 64}},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )


UnitTypeFiles["unit-destroyed-3x3-place"] = {summer = "tilesets/summer/neutral/buildings/destroyed_site.png",
  winter = "tilesets/winter/neutral/buildings/destroyed_site.png",
  wasteland = "tilesets/wasteland/neutral/buildings/destroyed_site.png",
  swamp = "tilesets/swamp/neutral/buildings/destroyed_site.png"}

DefineUnitType("unit-destroyed-3x3-place", { Name = _("Destroyed 3x3 Place"),
  Image = {"size", {64, 64}},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

UnitTypeFiles["unit-destroyed-3x3-place-water"] = {summer = "tilesets/summer/neutral/buildings/destroyed_site.png",
  winter = "tilesets/winter/neutral/buildings/destroyed_site.png",
  wasteland = "tilesets/wasteland/neutral/buildings/destroyed_site.png",
  swamp = "tilesets/swamp/neutral/buildings/destroyed_site.png"}

DefineUnitType("unit-destroyed-3x3-place-water", { Name = _("Destroyed 3x3 Place Water"),
  Image = {"size", {64, 64}},
  Animations = "animations-destroyed-place-water", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "naval",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

UnitTypeFiles["unit-destroyed-4x4-place"] = {summer = "tilesets/summer/neutral/buildings/destroyed_site.png",
  winter = "tilesets/winter/neutral/buildings/destroyed_site.png",
  wasteland = "tilesets/wasteland/neutral/buildings/destroyed_site.png",
  swamp = "tilesets/swamp/neutral/buildings/destroyed_site.png"}

DefineUnitType("unit-destroyed-4x4-place", { Name = _("Destroyed 4x4 Place"),
  Image = {"size", {64, 64}},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {4, 4}, BoxSize = {127, 127},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-revealer", { Name = _("Dummy unit"),
  Animations = "animations-building", Icon = "icon-holy-vision",
  Speed = 0,
  HitPoints = 1,
  TileSize = {1, 1}, BoxSize = {1, 1},
  SightRange = 12,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  DecayRate = 1,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Revealer = true,
  DetectCloak = true,
  Sounds = {} } )
 
function AiExploreUnit(unit)
  local unitstruct = UnitManager:GetSlotUnit(unit)
  local player = unitstruct.Player
  if (player.AiEnabled) then
    if (player.Type == PlayerComputer or player.Type == PlayerRescueActive) then
      -- send those balloons flying
      local pos = {GetUnitVariable(unit, "PosX"), GetUnitVariable(unit, "PosY")}
      OrderUnit(player.Index, unitstruct.Type.Ident, pos, {0, 0}, "explore")
    end
  end
end

-- Load the different races
Load("scripts/human/units.lua")
Load("scripts/orc/units.lua")
Load("scripts/caanoo/units.lua")

-- Hardcoded unit-types, moved from Stratagus to games
UnitTypeHumanWall = UnitTypeByIdent("unit-human-wall");
UnitTypeOrcWall = UnitTypeByIdent("unit-orc-wall");

DefineUnitType = OldDefineUnitType
DefineAnimations = OldDefineAnimations
