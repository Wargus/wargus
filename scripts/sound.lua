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
--      sound.lua - Define the used sounds.
--
--      (c) Copyright 1999-2004 by Fabrice Rossi, Lutz Sammer, and Jimmy Salmon
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

--	Uncomment this to enable threaded sound
--SoundThread()

------------------------------------------------------------------------------
--	Music part

------------------------------------------------------------------------------
--	MusicStopped is called if the current music is finished.
--
--		This is a random music player demo
--

local playlist = {
  "music/default.mod"
}

function MusicStopped()
  if (table.getn(playlist) ~= 0) then
    PlayMusic(playlist[math.random(table.getn(playlist))])
  end
end

------------------------------------------------------------------------------
--	(set-cd-mode!) set how your CD is played.
--		all	plays all tracks
--		random	plays random tracks
--		defined	play according to playlist below
--		off	turns cd player off
--SetCdMode("all")
--SetCdMode("random") 
SetCdMode("defined")
--SetCdMode("off")

------------------------------------------------------------------------------
--	(define-play-sections) set the playlist for different 
--			       sections of the game
--
DefinePlaySections("type", "main-menu",
    "cd", {"order", "all", "tracks", {15}})
DefinePlaySections("race", "human", "type", "game",
    "cd", {"order", "random", "tracks", {3, 4, 5, 6}})
DefinePlaySections("race", "human", "type", "briefing",
    "cd", {"order", "all", "tracks", {7}})
DefinePlaySections("race", "human", "type", "stats-victory",
    "cd", {"order", "all", "tracks", {8}})
DefinePlaySections("race", "human", "type", "stats-defeat",
    "cd", {"order", "all", "tracks", {9}})
DefinePlaySections("race", "orc", "type", "game",
    "cd", {"order", "random", "tracks", {10, 11, 12, 13, 14}})
DefinePlaySections("race", "orc", "type", "briefing",
    "cd", {"order", "all", "tracks", {15}})
DefinePlaySections("race", "orc", "type", "stats-victory",
    "cd", {"order", "all", "tracks", {16}})
DefinePlaySections("race", "orc", "type", "stats-defeat",
    "cd", {"order", "all", "tracks", {17}})

------------------------------------------------------------------------------
--	Define sounds later used
--
sound_click = MakeSound("click", "ui/click.wav")

------------------------------------------------------------------------------
--	Define simple sounds. (FIXME: somebody must clean the order.)
--

------------------------------------------------------------------------------
--	Define simple human sounds.
--
MakeSound("basic human voices ready", "human/basic_voices/ready.wav")
MakeSound("basic human voices help 1", "human/basic_voices/help/1.wav")
MakeSound("basic human voices help 2", "human/basic_voices/help/2.wav")
MakeSound("basic human voices dead", "human/basic_voices/dead.wav")

------------------------------------------------------------------------------
--	Define simple human building.
--

------------------------------------------------------------------------------
--	Define simple orc sounds.
--
MakeSound("basic orc voices ready", "orc/basic_voices/ready.wav")
MakeSound("basic orc voices help 1", "orc/basic_voices/help/1.wav")
MakeSound("basic orc voices help 2", "orc/basic_voices/help/2.wav")
MakeSound("basic orc voices dead", "orc/basic_voices/dead.wav")

------------------------------------------------------------------------------
--	Define simple orc building.
--

------------------------------------------------------------------------------
--	Define simple misc sounds.
--
MakeSound("building construction", "misc/building_construction.wav")
MakeSound("ship sinking", "ships/sinking.wav")
MakeSound("catapult-ballista movement",
	"units/catapult-ballista/acknowledgement/1.wav")

    -- building selection sounds
MakeSound("blacksmith", "buildings/blacksmith.wav")
MakeSound("church-selected", "human/buildings/church.wav")
MakeSound("altar-of-storms-selected", "orc/buildings/altar_of_storms.wav")
MakeSound("stables-selected", "human/buildings/stables.wav")
MakeSound("ogre-mound-selected", "orc/buildings/ogre_mound.wav")
MakeSound("farm-selected", "human/buildings/farm.wav")
MakeSound("pig-farm-selected", "orc/buildings/pig_farm.wav")
MakeSound("gold-mine-selected", "neutral/buildings/gold_mine.wav")
MakeSound("shipyard", "buildings/shipyard.wav")
MakeSound("oil platform", "buildings/oil_platform.wav")
MakeSound("oil refinery", "buildings/oil_refinery.wav")
MakeSound("lumbermill", "buildings/lumbermill.wav")
MakeSound("transport docking", "misc/transport_docking.wav")
MakeSound("burning", "misc/burning.wav")
MakeSound("gryphon-aviary-selected", "human/buildings/gryphon_aviary.wav")
MakeSound("dragon-roost-selected", "orc/buildings/dragon_roost.wav")
MakeSound("foundry", "buildings/foundry.wav")
MakeSound("gnomish-inventor-selected", "human/buildings/gnomish_inventor.wav")
MakeSound("goblin-alchemist-selected", "orc/buildings/goblin_alchemist.wav")
MakeSound("mage-tower-selected", "human/buildings/mage_tower.wav")
MakeSound("temple-of-the-damned-selected",
	"orc/buildings/temple_of_the_damned.wav")
MakeSound("capture (human)", "human/capture.wav")
MakeSound("capture (orc)", "orc/capture.wav")
MakeSound("rescue (human)", "human/rescue.wav")
MakeSound("rescue (orc)", "orc/rescue.wav")
MakeSound("bloodlust", "spells/bloodlust.wav")
MakeSound("death and decay", "spells/death_and_decay.wav")
MakeSound("death coil", "spells/death_coil.wav")
MakeSound("exorcism", "spells/exorcism.wav")
MakeSound("flame shield", "spells/flame_shield.wav")
MakeSound("haste", "spells/haste.wav")
MakeSound("healing", "spells/healing.wav")
MakeSound("holy vision", "spells/holy_vision.wav")
MakeSound("blizzard", "spells/blizzard.wav")
MakeSound("invisibility", "spells/invisibility.wav")
MakeSound("eye of vision", "spells/eye_of_kilrogg.wav")
MakeSound("polymorph", "spells/polymorph.wav")
MakeSound("slow", "spells/slow.wav")
MakeSound("unholy armor", "spells/unholy_armor.wav")
MakeSound("whirlwind", "spells/whirlwind.wav")
    -- ready sounds
MakeSound("peon-ready", "orc/peon/ready.wav")
MakeSound("death-knight-ready", "orc/units/death_knight/ready.wav")
MakeSound("dwarves-ready", "human/units/dwarven_demolition_squad/ready.wav")
MakeSound("elven archer-ranger ready",
	"human/units/elven_archer-ranger/ready.wav")
MakeSound("gnomish-flying-machine-ready",
	"human/units/gnomish_flying_machine/ready.wav")
MakeSound("goblin-sappers-ready", "orc/units/goblin_sappers/ready.wav")
MakeSound("goblin-zeppelin-ready", "orc/units/goblin_zeppelin/ready.wav")
MakeSound("knight-ready", "human/units/knight/ready.wav")
MakeSound("paladin-ready", "human/units/paladin/ready.wav")
MakeSound("ogre-ready", "orc/units/ogre/ready.wav")
MakeSound("ogre-mage-ready", "orc/units/ogre-mage/ready.wav")
MakeSound("ships human ready", "human/ships/ready.wav")
MakeSound("ships orc ready", "orc/ships/ready.wav")
MakeSound("troll axethrower-berserker ready",
	"orc/units/troll_axethrower-berserker/ready.wav")
MakeSound("mage-ready", "human/units/mage/ready.wav")
MakeSound("peasant-ready", "human/units/peasant/ready.wav")
MakeSound("dragon-ready", "orc/units/dragon/ready.wav")

    --------------------------------------------------------------------------
    -- selection sounds
MakeSound("dragon-selected", "orc/units/dragon/selected/1.wav")
MakeSound("gryphon-rider-selected", "human/units/gryphon_rider/selected/1.wav")
MakeSound("sheep selected", "neutral/units/sheep/selected/1.wav")
MakeSound("seal selected", "neutral/units/seal/selected/1.wav")
MakeSound("pig selected", "neutral/units/pig/selected/1.wav")
MakeSound("warthog selected", "neutral/units/warthog/selected/1.wav")
    -- annoyed sounds
MakeSound("sheep annoyed", "neutral/units/sheep/annoyed/1.wav")
MakeSound("seal annoyed", "neutral/units/seal/annoyed/1.wav")
MakeSound("pig annoyed", "neutral/units/pig/annoyed/1.wav")
MakeSound("warthog annoyed", "neutral/units/warthog/annoyed/1.wav")

    --------------------------------------------------------------------------
    -- attack sounds
MakeSound("catapult-ballista attack", "missiles/catapult-ballista_attack.wav")
MakeSound("punch", "missiles/punch.wav")
MakeSound("fireball hit", "missiles/fireball_hit.wav")
MakeSound("fireball throw", "missiles/fireball_throw.wav")
MakeSound("bow throw", "missiles/bow_throw.wav")
MakeSound("bow hit", "missiles/bow_hit.wav")
MakeSound("axe throw", "missiles/axe_throw.wav")
MakeSound("fist", "missiles/fist.wav")
MakeSound("peasant attack", "human/units/peasant/attack.wav")
MakeSound("lightning", "spells/lightning.wav")
MakeSound("touch of darkness", "spells/touch_of_darkness.wav")

------------------------------------------------------------------------------
--	Define sound groups.
    --
    --	Acknowledgment sounds -------------------------------------------------
    --
MakeSound("basic human voices acknowledge",
	{"human/basic_voices/acknowledgement/1.wav",
	"human/basic_voices/acknowledgement/2.wav",
	"human/basic_voices/acknowledgement/3.wav",
	"human/basic_voices/acknowledgement/4.wav"})
MakeSound("basic orc voices acknowledge",
	{"orc/basic_voices/acknowledgement/1.wav",
	"orc/basic_voices/acknowledgement/2.wav",
	"orc/basic_voices/acknowledgement/3.wav",
	"orc/basic_voices/acknowledgement/4.wav"})
MakeSound("peasant-acknowledge",
	{"human/units/peasant/acknowledgement/1.wav",
	"human/units/peasant/acknowledgement/2.wav",
	"human/units/peasant/acknowledgement/3.wav",
	"human/units/peasant/acknowledgement/4.wav"})
MakeSound("knight-acknowledge",
	{"human/units/knight/acknowledgement/1.wav",
	"human/units/knight/acknowledgement/2.wav",
	"human/units/knight/acknowledgement/3.wav",
	"human/units/knight/acknowledgement/4.wav"})
MakeSound("ogre-acknowledge",
	{"orc/units/ogre/acknowledgement/1.wav",
	"orc/units/ogre/acknowledgement/2.wav",
	"orc/units/ogre/acknowledgement/3.wav"})
MakeSound("elven archer-ranger acknowledge",
	{"human/units/elven_archer-ranger/acknowledgement/1.wav",
	"human/units/elven_archer-ranger/acknowledgement/2.wav",
	"human/units/elven_archer-ranger/acknowledgement/3.wav",
	"human/units/elven_archer-ranger/acknowledgement/4.wav"})
MakeSound("troll axethrower-berserker acknowledge",
	{"orc/units/troll_axethrower-berserker/acknowledgement/1.wav",
	"orc/units/troll_axethrower-berserker/acknowledgement/2.wav",
	"orc/units/troll_axethrower-berserker/acknowledgement/3.wav"})
MakeSound("mage-acknowledge",
	{"human/units/mage/acknowledgement/1.wav",
	"human/units/mage/acknowledgement/2.wav",
	"human/units/mage/acknowledgement/3.wav"})
MakeSound("death-knight-acknowledge",
	{"orc/units/death_knight/acknowledgement/1.wav",
	"orc/units/death_knight/acknowledgement/2.wav",
	"orc/units/death_knight/acknowledgement/3.wav"})
MakeSound("paladin-acknowledge",
	{"human/units/paladin/acknowledgement/1.wav",
	"human/units/paladin/acknowledgement/2.wav",
	"human/units/paladin/acknowledgement/3.wav",
	"human/units/paladin/acknowledgement/4.wav"})
MakeSound("ogre-mage-acknowledge",
	{"orc/units/ogre-mage/acknowledgement/1.wav",
	"orc/units/ogre-mage/acknowledgement/2.wav",
	"orc/units/ogre-mage/acknowledgement/3.wav"})
MakeSound("dwarves-acknowledge",
	{"human/units/dwarven_demolition_squad/acknowledgement/1.wav",
	"human/units/dwarven_demolition_squad/acknowledgement/2.wav",
	"human/units/dwarven_demolition_squad/acknowledgement/3.wav",
	"human/units/dwarven_demolition_squad/acknowledgement/4.wav",
	"human/units/dwarven_demolition_squad/acknowledgement/5.wav"})
MakeSound("goblin-sappers-acknowledge",
	{"orc/units/goblin_sappers/acknowledgement/1.wav",
	"orc/units/goblin_sappers/acknowledgement/2.wav",
	"orc/units/goblin_sappers/acknowledgement/3.wav",
	"orc/units/goblin_sappers/acknowledgement/4.wav"})
MakeSound("alleria-acknowledge",
	{"human/units/alleria/acknowledgement/1.wav",
	"human/units/alleria/acknowledgement/2.wav",
	"human/units/alleria/acknowledgement/3.wav"})
MakeSound("teron-gorefiend-acknowledge",
	{"orc/units/teron_gorefiend/acknowledgement/1.wav",
	"orc/units/teron_gorefiend/acknowledgement/2.wav",
	"orc/units/teron_gorefiend/acknowledgement/3.wav"})
MakeSound("kurdan-and-sky-ree-acknowledge",
	{"human/units/kurdan/acknowledgement/1.wav",
	"human/units/kurdan/acknowledgement/2.wav",
	"human/units/kurdan/acknowledgement/3.wav"})
MakeSound("dentarg-acknowledge",
	{"orc/units/dentarg/acknowledgement/1.wav",
	"orc/units/dentarg/acknowledgement/2.wav",
	"orc/units/dentarg/acknowledgement/3.wav"})
MakeSound("khadgar-acknowledge",
	{"human/units/khadgar/acknowledgement/1.wav",
	"human/units/khadgar/acknowledgement/2.wav",
	"human/units/khadgar/acknowledgement/3.wav"})
MakeSound("grom-hellscream-acknowledge",
	{"orc/units/grom_hellscream/acknowledgement/1.wav",
	"orc/units/grom_hellscream/acknowledgement/2.wav",
	"orc/units/grom_hellscream/acknowledgement/3.wav"})
MakeSound("tanker acknowledge",
	{"ships/tanker/acknowledgement/1.wav"})
MakeSound("ships human acknowledge",
	{"human/ships/acknowledgement/1.wav",
	"human/ships/acknowledgement/2.wav",
	"human/ships/acknowledgement/3.wav"})
MakeSound("ships orc acknowledge",
	{"orc/ships/acknowledgement/1.wav",
	"orc/ships/acknowledgement/2.wav",
	"orc/ships/acknowledgement/3.wav"})
MakeSound("deathwing-acknowledge",
	{"orc/units/deathwing/acknowledgement/1.wav",
	"orc/units/deathwing/acknowledgement/2.wav",
	"orc/units/deathwing/acknowledgement/3.wav"})
MakeSound("gnomish-flying-machine-acknowledge",
	{"human/units/gnomish_flying_machine/acknowledgement/1.wav"})
MakeSound("goblin-zeppelin-acknowledge",
	{"orc/units/goblin_zeppelin/acknowledgement/1.wav"})
MakeSound("gryphon-rider-acknowledge",
	{"human/units/gryphon_rider/acknowledgement/2.wav"})
MakeSound("dragon-acknowledge",
	{"orc/units/dragon/acknowledgement/1.wav",
	"orc/units/dragon/acknowledgement/2.wav"})
MakeSound("turalyon-acknowledge",
	{"human/units/turalyon/acknowledgement/1.wav",
	"human/units/turalyon/acknowledgement/2.wav",
	"human/units/turalyon/acknowledgement/3.wav"})
MakeSound("danath-acknowledge",
	{"human/units/danath/acknowledgement/1.wav",
	"human/units/danath/acknowledgement/2.wav",
	"human/units/danath/acknowledgement/3.wav"})
MakeSound("korgath-bladefist-acknowledge",
	{"orc/units/korgath_bladefist/acknowledgement/1.wav",
	"orc/units/korgath_bladefist/acknowledgement/2.wav",
	"orc/units/korgath_bladefist/acknowledgement/3.wav"})
    --
    --	Selection sounds -----------------------------------------------------
    --
MakeSound("basic human voices selected",
	{"human/basic_voices/selected/1.wav",
	"human/basic_voices/selected/2.wav",
	"human/basic_voices/selected/3.wav",
	"human/basic_voices/selected/4.wav",
	"human/basic_voices/selected/5.wav",
	"human/basic_voices/selected/6.wav"})
MakeSound("basic orc voices selected",
	{"orc/basic_voices/selected/1.wav",
	"orc/basic_voices/selected/2.wav",
	"orc/basic_voices/selected/3.wav",
	"orc/basic_voices/selected/4.wav",
	"orc/basic_voices/selected/5.wav",
	"orc/basic_voices/selected/6.wav"})
MakeSound("death knight selected",
	{"orc/units/death_knight/selected/1.wav",
	"orc/units/death_knight/selected/2.wav"})
MakeSound("dwarven demolition squad selected",
	{"human/units/dwarven_demolition_squad/selected/1.wav",
	"human/units/dwarven_demolition_squad/selected/2.wav"})
MakeSound("elven archer-ranger selected",
	{"human/units/elven_archer-ranger/selected/1.wav",
	"human/units/elven_archer-ranger/selected/2.wav",
	"human/units/elven_archer-ranger/selected/3.wav",
	"human/units/elven_archer-ranger/selected/4.wav"})
MakeSound("goblin sappers selected",
	{"orc/units/goblin_sappers/selected/1.wav",
	"orc/units/goblin_sappers/selected/2.wav",
	"orc/units/goblin_sappers/selected/3.wav",
	"orc/units/goblin_sappers/selected/4.wav"})
MakeSound("knight selected",
	{"human/units/knight/selected/1.wav",
	"human/units/knight/selected/2.wav",
	"human/units/knight/selected/3.wav",
	"human/units/knight/selected/4.wav"})
MakeSound("paladin selected",
	{"human/units/paladin/selected/1.wav",
	"human/units/paladin/selected/2.wav",
	"human/units/paladin/selected/3.wav",
	"human/units/paladin/selected/4.wav"})
MakeSound("ogre selected",
	{"orc/units/ogre/selected/1.wav",
	"orc/units/ogre/selected/2.wav",
	"orc/units/ogre/selected/3.wav",
	"orc/units/ogre/selected/4.wav"})
MakeSound("ogre-mage selected",
	{"orc/units/ogre-mage/selected/1.wav",
	"orc/units/ogre-mage/selected/2.wav",
	"orc/units/ogre-mage/selected/3.wav",
	"orc/units/ogre-mage/selected/4.wav"})
MakeSound("ships human selected",
	{"human/ships/selected/1.wav",
	"human/ships/selected/2.wav",
	"human/ships/selected/3.wav"})
MakeSound("ships orc selected",
	{"orc/ships/selected/1.wav",
	"orc/ships/selected/2.wav",
	"orc/ships/selected/3.wav"})
MakeSound("troll axethrower-berserker selected",
	{"orc/units/troll_axethrower-berserker/selected/1.wav",
	"orc/units/troll_axethrower-berserker/selected/2.wav",
	"orc/units/troll_axethrower-berserker/selected/3.wav"})
MakeSound("mage selected",
	{"human/units/mage/selected/1.wav",
	"human/units/mage/selected/2.wav",
	"human/units/mage/selected/3.wav"})
MakeSound("peasant selected",
	{"human/units/peasant/selected/1.wav",
	"human/units/peasant/selected/2.wav",
	"human/units/peasant/selected/3.wav",
	"human/units/peasant/selected/4.wav"})
MakeSound("alleria selected",
	{"human/units/alleria/selected/1.wav",
	"human/units/alleria/selected/2.wav",
	"human/units/alleria/selected/3.wav"})
MakeSound("danath selected",
	{"human/units/danath/selected/1.wav",
	"human/units/danath/selected/2.wav",
	"human/units/danath/selected/3.wav"})
MakeSound("khadgar selected",
	{"human/units/khadgar/selected/1.wav",
	"human/units/khadgar/selected/2.wav",
	"human/units/khadgar/selected/3.wav"})
MakeSound("kurdan selected",
	{"human/units/kurdan/selected/1.wav",
	"human/units/kurdan/selected/2.wav",
	"human/units/kurdan/selected/3.wav"})
MakeSound("turalyon selected",
	{"human/units/turalyon/selected/1.wav",
	"human/units/turalyon/selected/2.wav",
	"human/units/turalyon/selected/3.wav"})
MakeSound("deathwing selected",
	{"orc/units/deathwing/selected/1.wav",
	"orc/units/deathwing/selected/2.wav",
	"orc/units/deathwing/selected/3.wav"})
MakeSound("dentarg selected",
	{"orc/units/dentarg/selected/1.wav",
	"orc/units/dentarg/selected/2.wav",
	"orc/units/dentarg/selected/3.wav"})
MakeSound("grom hellscream selected",
	{"orc/units/grom_hellscream/selected/1.wav",
	"orc/units/grom_hellscream/selected/2.wav",
	"orc/units/grom_hellscream/selected/3.wav"})
MakeSound("korgath bladefist selected",
	{"orc/units/korgath_bladefist/selected/1.wav",
	"orc/units/korgath_bladefist/selected/2.wav",
	"orc/units/korgath_bladefist/selected/3.wav"})
MakeSound("teron gorefiend selected",
	{"orc/units/teron_gorefiend/selected/1.wav",
	"orc/units/teron_gorefiend/selected/2.wav",
	"orc/units/teron_gorefiend/selected/3.wav"})
    --
    --	Annoyed sounds --------------------------------------------------------
    --
MakeSound("basic human voices annoyed",
	{"human/basic_voices/annoyed/1.wav",
	"human/basic_voices/annoyed/2.wav",
	"human/basic_voices/annoyed/3.wav",
	"human/basic_voices/annoyed/4.wav",
	"human/basic_voices/annoyed/5.wav",
	"human/basic_voices/annoyed/6.wav",
	"human/basic_voices/annoyed/7.wav"})
MakeSound("basic orc voices annoyed",
	{"orc/basic_voices/annoyed/1.wav",
	"orc/basic_voices/annoyed/2.wav",
	"orc/basic_voices/annoyed/3.wav",
	"orc/basic_voices/annoyed/4.wav",
	"orc/basic_voices/annoyed/5.wav",
	"orc/basic_voices/annoyed/6.wav",
	"orc/basic_voices/annoyed/7.wav"})
MakeSound("death knight annoyed",
	{"orc/units/death_knight/annoyed/1.wav",
	"orc/units/death_knight/annoyed/2.wav",
	"orc/units/death_knight/annoyed/3.wav"})
MakeSound("dwarven demolition squad annoyed",
	{"human/units/dwarven_demolition_squad/annoyed/1.wav",
	"human/units/dwarven_demolition_squad/annoyed/2.wav",
	"human/units/dwarven_demolition_squad/annoyed/3.wav"})
MakeSound("elven archer-ranger annoyed",
	{"human/units/elven_archer-ranger/annoyed/1.wav",
	"human/units/elven_archer-ranger/annoyed/2.wav",
	"human/units/elven_archer-ranger/annoyed/3.wav"})
MakeSound("gnomish flying machine annoyed",
	{"human/units/gnomish_flying_machine/annoyed/1.wav",
	"human/units/gnomish_flying_machine/annoyed/2.wav",
	"human/units/gnomish_flying_machine/annoyed/3.wav",
	"human/units/gnomish_flying_machine/annoyed/4.wav",
	"human/units/gnomish_flying_machine/annoyed/5.wav"})
MakeSound("goblin sappers annoyed",
	{"orc/units/goblin_sappers/annoyed/1.wav",
	"orc/units/goblin_sappers/annoyed/2.wav",
	"orc/units/goblin_sappers/annoyed/3.wav"})
MakeSound("goblin zeppelin annoyed",
	{"orc/units/goblin_zeppelin/annoyed/1.wav",
	"orc/units/goblin_zeppelin/annoyed/2.wav"})
MakeSound("knight annoyed",
	{"human/units/knight/annoyed/1.wav",
	"human/units/knight/annoyed/2.wav",
	"human/units/knight/annoyed/3.wav"})
MakeSound("paladin annoyed",
	{"human/units/paladin/annoyed/1.wav",
	"human/units/paladin/annoyed/2.wav",
	"human/units/paladin/annoyed/3.wav"})
MakeSound("ogre annoyed",
	{"orc/units/ogre/annoyed/1.wav",
	"orc/units/ogre/annoyed/2.wav",
	"orc/units/ogre/annoyed/3.wav",
	"orc/units/ogre/annoyed/4.wav",
	"orc/units/ogre/annoyed/5.wav"})
MakeSound("ogre-mage annoyed",
	{"orc/units/ogre-mage/annoyed/1.wav",
	"orc/units/ogre-mage/annoyed/2.wav",
	"orc/units/ogre-mage/annoyed/3.wav"})
MakeSound("ships human annoyed",
	{"human/ships/annoyed/1.wav",
	"human/ships/annoyed/2.wav",
	"human/ships/annoyed/3.wav"})
MakeSound("ships orc annoyed",
	{"orc/ships/annoyed/1.wav",
	"orc/ships/annoyed/2.wav",
	"orc/ships/annoyed/3.wav"})
MakeSound("ships submarine annoyed",
	{"human/ships/gnomish_submarine/annoyed/1.wav",
	"human/ships/gnomish_submarine/annoyed/2.wav",
	"human/ships/gnomish_submarine/annoyed/3.wav",
	"human/ships/gnomish_submarine/annoyed/4.wav"})
MakeSound("troll axethrower-berserker annoyed",
	{"orc/units/troll_axethrower-berserker/annoyed/1.wav",
	"orc/units/troll_axethrower-berserker/annoyed/2.wav",
	"orc/units/troll_axethrower-berserker/annoyed/3.wav"})
MakeSound("mage annoyed",
	{"human/units/mage/annoyed/1.wav",
	"human/units/mage/annoyed/2.wav",
	"human/units/mage/annoyed/3.wav"})
MakeSound("peasant annoyed",
	{"human/units/peasant/annoyed/1.wav",
	"human/units/peasant/annoyed/2.wav",
	"human/units/peasant/annoyed/3.wav",
	"human/units/peasant/annoyed/4.wav",
	"human/units/peasant/annoyed/5.wav",
	"human/units/peasant/annoyed/6.wav",
	"human/units/peasant/annoyed/7.wav"})
MakeSound("alleria annoyed",
	{"human/units/alleria/annoyed/1.wav",
	"human/units/alleria/annoyed/2.wav",
	"human/units/alleria/annoyed/3.wav"})
MakeSound("danath annoyed",
	{"human/units/danath/annoyed/1.wav",
	"human/units/danath/annoyed/2.wav",
	"human/units/danath/annoyed/3.wav"})
MakeSound("khadgar annoyed",
	{"human/units/khadgar/annoyed/1.wav",
	"human/units/khadgar/annoyed/2.wav",
	"human/units/khadgar/annoyed/3.wav"})
MakeSound("kurdan annoyed",
	{"human/units/kurdan/annoyed/1.wav",
	"human/units/kurdan/annoyed/2.wav",
	"human/units/kurdan/annoyed/3.wav"})
MakeSound("turalyon annoyed",
	{"human/units/turalyon/annoyed/1.wav",
	"human/units/turalyon/annoyed/2.wav",
	"human/units/turalyon/annoyed/3.wav"})
MakeSound("deathwing annoyed",
	{"orc/units/deathwing/annoyed/1.wav",
	"orc/units/deathwing/annoyed/2.wav",
	"orc/units/deathwing/annoyed/3.wav"})
MakeSound("dentarg annoyed",
	{"orc/units/dentarg/annoyed/1.wav",
	"orc/units/dentarg/annoyed/2.wav",
	"orc/units/dentarg/annoyed/3.wav"})
MakeSound("grom hellscream annoyed",
	{"orc/units/grom_hellscream/annoyed/1.wav",
	"orc/units/grom_hellscream/annoyed/2.wav",
	"orc/units/grom_hellscream/annoyed/3.wav"})
MakeSound("korgath bladefist annoyed",
	{"orc/units/korgath_bladefist/annoyed/1.wav",
	"orc/units/korgath_bladefist/annoyed/2.wav",
	"orc/units/korgath_bladefist/annoyed/3.wav"})
MakeSound("teron gorefiend annoyed",
	{"orc/units/teron_gorefiend/annoyed/1.wav",
	"orc/units/teron_gorefiend/annoyed/2.wav",
	"orc/units/teron_gorefiend/annoyed/3.wav"})
    --
    --	Other sounds ---------------------------------------------------------
    --
MakeSound("explosion", "misc/explosion.wav")
MakeSound("building destroyed",
	{"misc/building_explosion/1.wav",
	"misc/building_explosion/2.wav",
	"misc/building_explosion/3.wav"})
MakeSound("sword attack",
	{"missiles/sword_attack/1.wav",
	"missiles/sword_attack/2.wav",
	"missiles/sword_attack/3.wav"})
MakeSound("tree chopping",
	{"misc/tree_chopping/1.wav",
	"misc/tree_chopping/2.wav",
	"misc/tree_chopping/3.wav",
	"misc/tree_chopping/4.wav"})

------------------------------------------------------------------------------
--	Define selection sound groups.
MakeSoundGroup("footman-selected",
	"basic human voices selected", "basic human voices annoyed")
MakeSoundGroup("grunt-selected",
	"basic orc voices selected", "basic orc voices annoyed")
MakeSoundGroup("peasant-selected",
	"peasant selected", "peasant annoyed")
MakeSoundGroup("knight-selected",
	"knight selected", "knight annoyed")
MakeSoundGroup("ogre-selected",
	"ogre selected", "ogre annoyed")
MakeSoundGroup("archer-selected",
	"elven archer-ranger selected", "elven archer-ranger annoyed")
MakeSoundGroup("axethrower-selected",
	"troll axethrower-berserker selected",
	"troll axethrower-berserker annoyed")
MakeSoundGroup("mage-selected",
	"mage selected", "mage annoyed")
MakeSoundGroup("death-knight-selected",
	"death knight selected", "death knight annoyed")
MakeSoundGroup("paladin-selected",
	"paladin selected", "paladin annoyed")
MakeSoundGroup("ogre-mage-selected",
	"ogre-mage selected", "ogre-mage annoyed")
MakeSoundGroup("dwarves-selected",
	"dwarven demolition squad selected", "dwarven demolition squad annoyed")
MakeSoundGroup("goblin-sappers-selected",
	"goblin sappers selected", "goblin sappers annoyed")
MakeSoundGroup("alleria-selected",
	"alleria selected", "alleria annoyed")
MakeSoundGroup("teron-gorefiend-selected",
	"teron gorefiend selected",
	"teron gorefiend annoyed")
MakeSoundGroup("kurdan-and-sky-ree-selected",
	"kurdan selected", "kurdan annoyed")
MakeSoundGroup("dentarg-selected",
	"dentarg selected", "dentarg annoyed")
MakeSoundGroup("khadgar-selected",
	"khadgar selected", "khadgar annoyed")
MakeSoundGroup("grom-hellscream-selected",
	"grom hellscream selected", "grom hellscream annoyed")
MakeSoundGroup("human-oil-tanker-selected",
	"ships human selected", "ships human annoyed")
MakeSoundGroup("orc-oil-tanker-selected",
	"ships orc selected", "ships orc annoyed")
MakeSoundGroup("deathwing-selected",
	"deathwing selected", "deathwing annoyed")
MakeSoundGroup("gnomish-submarine-selected",
	"ships human selected", "ships submarine annoyed")
MakeSoundGroup("gnomish-flying-machine-selected",
	"click", "gnomish flying machine annoyed")
MakeSoundGroup("goblin-zeppelin-selected",
	"click", "goblin zeppelin annoyed")
MakeSoundGroup("turalyon-selected",
	"turalyon selected", "turalyon annoyed")
MakeSoundGroup("danath-selected",
	"danath selected", "danath annoyed")
MakeSoundGroup("korgath-bladefist-selected",
	"korgath bladefist selected", "korgath bladefist annoyed")

------------------------------------------------------------------------------
--	Define sound remapping. (FIXME: somebody must clean the order.)
--
    --	acknowledge sounds
MapSound("footman-acknowledge", "basic human voices acknowledge")
MapSound("grunt-acknowledge", "basic orc voices acknowledge")
MapSound("peon-acknowledge", "basic orc voices acknowledge")
MapSound("ballista-acknowledge", "catapult-ballista movement")
MapSound("catapult-acknowledge", "catapult-ballista movement")
MapSound("archer-acknowledge", "elven archer-ranger acknowledge")
MapSound("axethrower-acknowledge", "troll axethrower-berserker acknowledge")
MapSound("ranger-acknowledge", "elven archer-ranger acknowledge")
MapSound("berserker-acknowledge", "troll axethrower-berserker acknowledge")
MapSound("human-oil-tanker-acknowledge", "tanker acknowledge")
MapSound("orc-oil-tanker-acknowledge", "tanker acknowledge")
MapSound("human-transport-acknowledge", "ships human acknowledge")
MapSound("orc-transport-acknowledge", "ships orc acknowledge")
MapSound("elven-destroyer-acknowledge", "ships human acknowledge")
MapSound("troll-destroyer-acknowledge", "ships orc acknowledge")
MapSound("battleship-acknowledge", "ships human acknowledge")
MapSound("ogre-juggernaught-acknowledge", "ships orc acknowledge")
MapSound("gnomish-submarine-acknowledge", "ships human acknowledge")
MapSound("giant-turtle-acknowledge", "ships orc acknowledge")
MapSound("cho-gall-acknowledge", "ogre-mage-acknowledge")
MapSound("lothar-acknowledge", "knight-acknowledge")
MapSound("gul-dan-acknowledge", "death-knight-acknowledge")
MapSound("uther-lightbringer-acknowledge", "paladin-acknowledge")
MapSound("zuljin-acknowledge", "troll axethrower-berserker acknowledge")
    --	 ready sounds
MapSound("footman-ready", "basic human voices ready")
MapSound("grunt-ready", "basic orc voices ready")
MapSound("ballista-ready", "basic human voices ready")
MapSound("catapult-ready", "basic orc voices ready")
MapSound("archer-ready", "elven archer-ranger ready")
MapSound("axethrower-ready", "troll axethrower-berserker ready")
MapSound("ranger-ready", "elven archer-ranger ready")
MapSound("berserker-ready", "troll axethrower-berserker ready")
MapSound("human-oil-tanker-ready", "ships human ready")
MapSound("orc-oil-tanker-ready", "ships orc ready")
MapSound("human-transport-ready", "ships human ready")
MapSound("orc-transport-ready", "ships orc ready")
MapSound("elven-destroyer-ready", "ships human ready")
MapSound("troll-destroyer-ready", "ships orc ready")
MapSound("battleship-ready", "ships human ready")
MapSound("ogre-juggernaught-ready", "ships orc ready")
MapSound("gnomish-submarine-ready", "ships human ready")
MapSound("giant-turtle-ready", "ships orc ready")
    --	 selection sounds
MapSound("peon-selected", "grunt-selected")
MapSound("ballista-selected", "click")
MapSound("catapult-selected", "click")
MapSound("ranger-selected", "elven archer-ranger selected")
MapSound("berserker-selected", "troll axethrower-berserker selected")
MapSound("human-transport-selected", "human-oil-tanker-selected")
MapSound("orc-transport-selected", "orc-oil-tanker-selected")
MapSound("elven-destroyer-selected", "human-oil-tanker-selected")
MapSound("troll-destroyer-selected", "orc-oil-tanker-selected")
MapSound("battleship-selected", "human-oil-tanker-selected")
MapSound("ogre-juggernaught-selected", "orc-oil-tanker-selected")
MapSound("giant-turtle-selected", "orc-oil-tanker-selected")
MapSound("eye-of-kilrogg-selected", "click")
MapSound("cho-gall-selected", "ogre-mage-selected")
MapSound("lothar-selected", "knight-selected")
MapSound("gul-dan-selected", "death-knight-selected")
MapSound("uther-lightbringer-selected", "paladin-selected")
MapSound("zuljin-selected", "troll axethrower-berserker selected")
MapSound("skeleton-selected", "click")
MapSound("daemon-selected", "click")
MapSound("human-barracks-selected", "click")
MapSound("orc-barracks-selected", "click")
MapSound("human-watch-tower-selected", "click")
MapSound("orc-watch-tower-selected", "click")
MapSound("human-shipyard-selected", "shipyard")
MapSound("orc-shipyard-selected", "shipyard")
MapSound("town-hall-selected", "click")
MapSound("great-hall-selected", "click")
MapSound("elven-lumber-mill-selected", "lumbermill")
MapSound("troll-lumber-mill-selected", "lumbermill")
MapSound("human-foundry-selected", "foundry")
MapSound("orc-foundry-selected", "foundry")
MapSound("human-blacksmith-selected", "blacksmith")
MapSound("orc-blacksmith-selected", "blacksmith")
MapSound("human-refinery-selected", "oil refinery")
MapSound("orc-refinery-selected", "oil refinery")
MapSound("human-oil-platform-selected", "oil platform")
MapSound("orc-oil-platform-selected", "oil platform")
MapSound("keep-selected", "click")
MapSound("stronghold-selected", "click")
MapSound("castle-selected", "click")
MapSound("fortress-selected", "click")
MapSound("oil-patch-selected", "click")
MapSound("human-guard-tower-selected", "click")
MapSound("orc-guard-tower-selected", "click")
MapSound("human-cannon-tower-selected", "click")
MapSound("orc-cannon-tower-selected", "click")
    --	attack sounds
MapSound("footman-attack", "sword attack")
MapSound("grunt-attack", "sword attack")
MapSound("peasant-attack", "peasant attack")
MapSound("peon-attack", "peasant attack")
MapSound("ballista-attack", "catapult-ballista attack")
MapSound("catapult-attack", "catapult-ballista attack")
MapSound("knight-attack", "sword attack")
MapSound("ogre-attack", "punch")
MapSound("archer-attack", "bow throw")
MapSound("axethrower-attack", "axe throw")
MapSound("mage-attack", "lightning")
MapSound("death-knight-attack", "touch of darkness")
MapSound("paladin-attack", "sword attack")
MapSound("ogre-mage-attack", "punch")
MapSound("dwarves-attack", "sword attack")
MapSound("goblin-sappers-attack", "sword attack")
MapSound("ranger-attack", "bow throw")
MapSound("berserker-attack", "axe throw")
MapSound("alleria-attack", "bow throw")
MapSound("teron-gorefiend-attack", "touch of darkness")
MapSound("kurdan-and-sky-ree-attack", "lightning")
MapSound("dentarg-attack", "punch")
MapSound("khadgar-attack", "lightning")
MapSound("grom-hellscream-attack", "sword attack")
    --	FIXME: what sound for ships?
MapSound("elven-destroyer-attack", "fireball throw")
MapSound("troll-destroyer-attack", "fireball throw")
MapSound("battleship-attack", "fireball throw")
MapSound("ogre-juggernaught-attack", "fireball throw")
MapSound("gnomish-submarine-attack", "fireball throw")
MapSound("giant-turtle-attack", "fireball throw")
MapSound("deathwing-attack", "fireball throw")
MapSound("gryphon-rider-attack", "lightning")
MapSound("dragon-attack", "fireball throw")
--	FIXME: what sound for those heroes?
--	MapSound("turalyon-attack")
--	MapSound("danath-attack")
--	MapSound("korgath-bladefist-attack")
--	MapSound("cho-gall-attack")
--	MapSound("lothar-attack")
--	MapSound("gul-dan-attack")
--	MapSound("uther-lightbringer-attack")
--	MapSound("zuljin-attack")
MapSound("skeleton-attack", "fist")
--	MapSound("daemon-attack")
--	FIXME: what attack sounds for towers?
--	MapSound("human-guard-tower-attack")
--	MapSound("orc-guard-tower-attack")
--	MapSound("human-cannon-tower-attack")
--	MapSound("orc-cannon-tower-attack")

MapSound("critter-help", "basic orc voices help 1")
MapSound("critter-dead", "explosion")


--	Define sounds used by game
--
DefineGameSounds(

  "placement-error", MakeSound("placement error", "ui/placement_error.wav"),
  "placement-success", MakeSound("placement success", "ui/placement_success.wav"),
  "click", sound_click,

-- FIXME: Not ready
--  "transport-docking",
--  "building-construction",

  "work-complete", {"human", MakeSound("basic human voices work complete", "human/basic_voices/work_complete.wav")},
  "work-complete", {"orc", MakeSound("basic orc voices work complete", "orc/basic_voices/work_complete.wav")},

  "rescue", {"human", MakeSound("human rescue", "human/rescue.wav")},
  "rescue", {"orc", MakeSound("orc rescue", "orc/rescue.wav")} )

MakeSound("highclick", "ui/highclick.wav")
MakeSound("statsthump", "ui/statsthump.wav")
