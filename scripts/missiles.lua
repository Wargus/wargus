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
--      missiles.lua - Define the used missiles.
--
--      (c) Copyright 1998-2004 by Lutz Sammer, Fabrice Rossi,
--                                 Jimmy Salmon and Crestez Leonard
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

DefineMissileType("missile-lightning",
  { File = "missiles/lightning.png", Size = {32, 32}, Frames = 30, NumDirections = 9,
  Class = "missile-class-point-to-point-with-hit", Sleep = 1, Speed = 16, Range = 1,
  DrawLevel = 50 } )

DefineMissileType("missile-griffon-hammer",
  { File = "missiles/gryphon_hammer.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  ImpactSound = "fireball hit",
  Class = "missile-class-point-to-point-bounce", NumBounces = 3, Sleep = 1, Speed = 16, Range = 2,
  DrawLevel = 50, ImpactMissile = "missile-explosion", SplashFactor = 2 } )

DefineMissileType("missile-dragon-breath",
  { File = "missiles/dragon_breath.png", Size = {32, 32}, Frames = 5, NumDirections = 9,
  ImpactSound = "fireball hit",
  Class = "missile-class-point-to-point-bounce", NumBounces = 3, Sleep = 1, Speed = 16, Range = 2,
  DrawLevel = 70, ImpactMissile = "missile-explosion", SplashFactor = 2 } )

DefineMissileType("missile-fireball",
  { File = "missiles/fireball.png", Size = {32, 32}, Frames = 5, NumDirections = 9,
  ImpactSound = "fireball hit",
  DrawLevel = 50, Class = "missile-class-point-to-point-bounce", NumBounces = 5, Sleep = 1, Speed = 16, Range = 2,
  ImpactMissile = "missile-explosion", SplashFactor = 2 } )

DefineMissileType("missile-flame-shield",
  { File = "missiles/flame_shield.png", Size = {32, 48}, Frames = 6, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-flame-shield", Sleep = 2, Speed = 4, Range = 1 } )

DefineMissileType("missile-blizzard",
  { File = "missiles/blizzard.png", Size = {32, 32}, Frames = 4, NumDirections = 1, ImpactSound = "fireball hit",
  Class = "missile-class-point-to-point-with-hit", Sleep = 1, BlizzardSpeed = 4, Speed = 16, Range = 1,
  DrawLevel = 100 } )

DefineMissileType("missile-death-and-decay",
  { File = "missiles/death_and_decay.png", Size = {32, 32}, Frames = 8, NumDirections = 1,
  DrawLevel = 100, Class = "missile-class-stay", Sleep = 1, Speed = 0, Range = 1 } )

DefineMissileType("missile-big-cannon",
  { File = "missiles/big_cannon.png", Size = {16, 16}, Frames = 20, NumDirections = 9,
  DrawLevel = 50, ImpactSound = "explosion",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 16, Range = 2,
  ImpactMissile = "missile-cannon-tower-explosion", SplashFactor = 4 } )

DefineMissileType("missile-exorcism",
  { File = "missiles/exorcism.png", Size = {48, 48}, Frames = 10, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-point-to-point", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-heal-effect",
  { File = "missiles/heal_effect.png", Size = {48, 48}, Frames = 10, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-touch-of-death",
  { File = "missiles/touch_of_death.png", Size = {32, 32}, Frames = 30, NumDirections = 9,
  DrawLevel = 50, Class = "missile-class-point-to-point-with-hit", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-rune",
  { File = "missiles/rune.png", Size = {16, 16}, Frames = 4, NumDirections = 1,
  DrawLevel = 20, Class = "missile-class-land-mine", Sleep = 5, Speed = 16, Range = 1,
  ImpactMissile = "missile-explosion", CanHitOwner = true } )

DefineMissileType("missile-whirlwind",
  { File = "missiles/tornado.png", Size = {56, 56}, Frames = 4, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-whirlwind", Sleep = 1, Speed = 2, Range = 2 } )

DefineMissileType("missile-catapult-rock",
  { File = "missiles/catapult_rock.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  ImpactSound = "explosion",
  DrawLevel = 50, Class = "missile-class-parabolic", Sleep = 1, Speed = 8, Range = 2,
  ImpactMissile = "missile-impact", SplashFactor = 4 } )

DefineMissileType("missile-ballista-bolt",
  { File = "missiles/ballista_bolt.png", Size = {64, 64}, Frames = 5, NumDirections = 9,
  DrawLevel = 50, ImpactSound = "explosion",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 8, Range = 2,
  ImpactMissile = "missile-impact", SplashFactor = 4 } )

DefineMissileType("missile-arrow",
  { File = "missiles/arrow.png", Size = {40, 40}, Frames = 5, NumDirections = 9,
  DrawLevel = 50, ImpactSound = "bow hit",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 32, Range = 0 } )

DefineMissileType("missile-axe",
  { File = "missiles/axe.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  ImpactSound = "bow hit",
  DrawLevel = 50, Class = "missile-class-point-to-point", Sleep = 1, Speed = 32, Range = 0 } )

DefineMissileType("missile-submarine-missile",
  { File = "missiles/submarine_missile.png", Size = {40, 40}, Frames = 5, NumDirections = 9,
  ImpactSound = "explosion",
  DrawLevel = 50, Class = "missile-class-point-to-point", Sleep = 1, Speed = 16, Range = 1,
  ImpactMissile = "missile-impact" } )

DefineMissileType("missile-turtle-missile",
  { File = "missiles/turtle_missile.png", Size = {40, 40}, Frames = 5, NumDirections = 9,
  DrawLevel = 50, ImpactSound = "explosion",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 16, Range = 1,
  ImpactMissile = "missile-impact" } )

DefineMissileType("missile-small-fire",
  { File = "missiles/small_fire.png", Size = {32, 48}, Frames = 6, NumDirections = 1,
  DrawLevel = 45, Class = "missile-class-fire", Sleep = 8, Speed = 16, Range = 1 } )

DefineMissileType("missile-big-fire",
  { File = "missiles/big_fire.png", Size = {48, 48}, Frames = 10, NumDirections = 1,
  DrawLevel = 45, Class = "missile-class-fire", Sleep = 8, Speed = 16, Range = 1 } )

DefineMissileType("missile-impact",
  { File = "missiles/ballista-catapult_impact.png", Size = {48, 48}, Frames = 10, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-normal-spell",
  { File = "missiles/normal_spell.png", Size = {32, 32}, Frames = 6, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 5, Speed = 0, Range = 1 } )

DefineMissileType("missile-explosion",
  { File = "missiles/explosion.png", Size = {64, 64}, Frames = 20, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-small-cannon",
  { File = "missiles/cannon.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  DrawLevel = 50, ImpactSound = "explosion",
  Class = "missile-class-parabolic", Sleep = 1, Speed = 22, Range = 2,
  ImpactMissile = "missile-cannon-explosion", SplashFactor = 3 } )

DefineMissileType("missile-cannon-explosion",
  { File = "missiles/cannon_explosion.png", Size = {32, 32}, Frames = 4, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-cannon-tower-explosion",
  { File = "missiles/cannon-tower_explosion.png", Size = {32, 32}, Frames = 4, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-daemon-fire",
  { File = "missiles/daemon_fire.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  DrawLevel = 70, ImpactSound = "fireball hit",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-green-cross",
  { File = "missiles/green_cross.png", Size = {32, 32}, Frames = 4, NumDirections = 1,
  DrawLevel = 150, Class = "missile-class-cycle-once", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-none",
  { Size = {32, 32}, DrawLevel = 50,
  Class = "missile-class-none", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-death-coil",
  { File = "missiles/touch_of_death.png", Size = {32, 32}, Frames = 30, NumDirections = 9,
  DrawLevel = 50, Class = "missile-class-death-coil", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-hit",
  { Size = {15, 15}, DrawLevel = 150,
  Class = "missile-class-hit", Sleep = 1, Speed = 1, Range = 16 } )

DefineMissileType("missile-critter-explosion",
  { File = "missiles/catapult_rock.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  ImpactSound = "explosion", DrawLevel = 50,
  Class = "missile-class-hit", Sleep = 1, Speed = 16, Range = 2,
  ImpactMissile = "missile-impact", CanHitOwner = true } )

DefineBurningBuilding(
  {"percent", 0, "missile", "missile-big-fire"},
  {"percent", 50, "missile", "missile-small-fire"},
  {"percent", 75 } -- no missile
)
