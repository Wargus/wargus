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
--	stratagus.ccl	-	The craft configuration language.
--
--	(c) Copyright 1998-2003 by Lutz Sammer
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

-- For documentation see stratagus/doc/ccl/ccl.html
--[[
(cond ((equal? *scheme* 'guile)
       (load "guile.ccl"))
      ((equal? *scheme* 'siod)
       (load "ccl/siod.ccl" #f #t)))
]]
print("Stratagus default config file loading ...\n")

-- Config file version
--(define media-version (list 'wc2 'class 'wc2 'version '(1 18 0)))

-------------------------------------------------------------------------------
--	Config-Part
-------------------------------------------------------------------------------

--	Edit the next sections to get your look and feel.
--	Note, some of those values are overridden by user preferences,
--	see ~/.stratagus/preferences1.ccl
--	and ~/.stratagus/gamename/preferences2.ccl


--	Set the game contrast,brightness,saturation.
SetContrast(100) SetBrightness(0) SetSaturation(100)
--SetContrast(110) SetBrightness(15) SetSaturation(100)

--	Enter your default title screen.
SetTitleScreens(
	{"graphics/ui/stratagus.png", "music/default.mod"}
--	{"graphics/logo_stratagus.avi"}
)

--	Enter your default menu background.
SetMenuBackground("graphics/ui/Menu_background_without_title.png")

--	Enter your default menu background with title.
SetMenuBackgroundWithTitle(
	"graphics/ui/Menu_background_with_title.png")

--	Enter your menu music.
SetMenuMusic("music/default.mod")

--	If color-cycle-all is off (#f) only the tileset and global palette are
--	color cycled.  Otherwise (#t) all palettes are color cycled.
SetColorCycleAll(true)
--SetColorCycleAll(false)

--	Set the game name. It's used so we can mantain different savegames
--	and setting. Might also be used for multiplayer.
SetGameName("wc2")
--	set the default map file.
SetDefaultMap("puds/default.pud")

-------------------------------------------------------------------------------
--	Music play list -	Insert your titles here

--
--	Create a list from the directory content
--
--[[
(define (dir->list s . prepend)
  (define (aux d rl p)
    (let ((q (readdir d)))
      (cond ((eof-object? q)
             (closedir d)
             rl)
            (else
             (if (or (equal? q ".") (equal? q ".."))
                 (aux d rl p)
                 (aux d (cons (string-append p q) rl) p))))))

  (aux (opendir s) '() (if (string? (car prepend))
                           (car prepend) 
                           "")))

;; hack to detect WC2 directory without data extracted
(if (< (length (dir->list (library-path) nil)) 6)
  (begin
    (writes nil "You are trying to run the WC2 but your data seems incomplete.\n")
    (writes nil "Use tools/wartool or specify another game with '-d /path/to/gamedir'!\n")))

;; Uncomment to play automatic all music
;; FIXME: Comments are wrong, system dependend stuff didn't belong into the
;;	  config files.
(if (eq? (os-classification) (intern "win32"))
  (define play-list
    (dir->list (string-append (library-path) "/music/*") "music/"))
  (define play-list
    (dir->list (string-append (library-path) "/music") "music/")))

;; Comment this, if you use above
;(define play-list (list "music/default.mod"))
]]
SetSelectionStyle("corners")
SetShowSightRange(false)
SetShowAttackRange(false)
SetShowReactionRange(false)

SetShowOrders(2)

--	Enable/disable the short display of the orders after command.
--	FIXME: planned
--(set-order-feedback! #t)
--(set-order-feedback! #f)

--	Define the mana/energy decoration.
--	FIXME: Planned?
--
--	(set-mana-style!
--		'sprite (...)
--		'horizontal
--		'vertical
--		'no-full
--		'on-top
--		'only-selected
--		'background-long
--	  )

--	Define the health decoration.
--	FIXME: Planned?
--
--	(set-health-style!
--		'sprite (...)
--		'horizontal
--		'vertical
--		'no-full
--		'on-top
--		'only-selected
--		'background-long
--	  )

--              file                             hotx hoty width height
--ManaSprite("graphics/ui/mana.png", -7, -7, 7, 7)
ManaSprite("graphics/ui/mana2.png", 0, -1, 31, 4)
--HealthSprite("graphics/ui/health.png", 1, -7, 7, 7)
HealthSprite("graphics/ui/health2.png", 0, -4, 31, 4)

--ShowHealthBar()
--ShowHealthVertical()
--ShowHealthHorizontal()
ShowHealthDot()

--ShowManaBar()
--ShowManaVertical()
--ShowManaHorizontal()
ShowManaDot()

ShowNoFull()
--ShowFull()


--	Uncomment next, to show energy bars and dots only for selected units
--(show-energy-selected-only)

--	Uncomment next, to show bars and dots always on top.
--	FIXME: planned feature
DecorationOnTop()

--	Define shadow-sprite.
--
--	(shadow-sprite file hotx hoty width height)
--
ShadowSprite("graphics/missiles/unit_shadow.png", 3, 42, 32, 32)
SpellSprite("graphics/ui/bloodlust,haste,slow,invisible,shield.png",
	1, 1, 16, 16)

--	Uncomment next, to enable fancy building (random mirroring buildings)
SetFancyBuildings(true)
--SetFancyBuildings(false)

--	Edit this to enable/disable show tips at the start of a level
SetShowTips(true)

-------------------------------------------------------------------------------
--	Game modification

--	Edit this to enable/disable XP to add more damage to attacks
--SetXPDamage(true)
SetXPDamage(false)

--	Edit this to enable/disable extended features.
--		Currently enables some additional buttons.
extensions = true
--extensions = false

--	Edit this to enable/disable the training queues.
SetTrainingQueue(true)
--SetTrainingQueue(false)

--	Edit this to enable/disable building capture.
--SetBuildingCapture(true)
SetBuildingCapture(false)

--	Set forest regeneration speed. (n* seconds, 0 = disabled)
--	(Auf allgemeinen Wunsch eines einzelnen Herrn :)
SetForestRegeneration(0)
--SetForestRegeneration(5)

--	Edit this to enable/disable the reveal of the attacker.
--SetRevealAttacker(true)
SetRevealAttacker(false)

-------------------------------------------------------------------------------

--	If you prefer fighters are attacking by right clicking empty space
--	uncomment this (you must comment the next).
--	FIXME: this option will be renamed
--RightButtonAttacks()

--	If you prefer fighters are moving by right clicking empty space
--	uncomment this.
--	FIXME: this option will be renamed
RightButtonMoves()

--	Set the name of the missile to use when clicking
SetClickMissile("missile-green-cross")

--	Set the name of the missile to use when displaying damage
SetDamageMissile("missile-hit")

--	Edit this to enable/disable grabbing the mouse.
SetGrabMouse(false)

--	Edit this to enable/disable stopping scrolling on mouse leave.
SetLeaveStops(true)

--	Edit this to enable/disable mouse scrolling.
SetMouseScroll(true)
--SetMouseScroll(false)

--	Edit this to enable/disable keyboard scrolling.
SetKeyScroll(true)
--SetKeyScroll(false)

--	Set keyboard scroll speed in frames (1=each frame,2 each second,...)
SetKeyScrollSpeed(1)

--	Set mouse scroll speed in frames (1=each frame,2 each second,...)
--	This is when the mouse cursor hits the border.
SetMouseScrollSpeed(1)

--	While middle-mouse is pressed:
--	Pixels to move per scrolled mouse pixel, negative = reversed
SetMouseScrollSpeedDefault(4)

--	Same if Control is pressed
SetMouseScrollSpeedDefault(15)

--	Change next, for the wanted double-click delay (in ms).
SetDoubleClickDelay(300)

--	Change next, for the wanted hold-click delay (in ms).
SetHoldClickDelay(1000)

--	Edit this to enable/disable the display of the command keys in buttons.
SetShowCommandKey(true)
--SetShowCommandKey(false)

--	Uncomment next, to reveal the complete map.
--RevealMap()

--	Choose your default fog of war state (enabled #t/disabled #f).
--		disabled is a C&C like fog of war.
SetFogOfWar(true)
--SetFogOfWar(false)

--	Choose your default for minimap with/without terrain.
SetMinimapTerrain(true)
--SetMinimapTerrain(false)

--	Choose your default for the fog of war style.
-- Planned	(set-fog-of-war-style! 'original)
-- 		(set-fog-of-war-style! 'alpha-gray)
--OriginalFogOfWar()
AlphaFogOfWar()

--	If you use gray style fog of war set the contrast,brightness,saturation
SetFogOfWarContrast(30)
SetFogOfWarBrightness(10)
SetFogOfWarSaturation(100)

-------------------------------------------------------------------------------

--	Define default resources

-- FIXME: Must be removed: Use and write (define-resource)
--
--	(define-resource 'gold 'name "Gold"
--	  'start-resource-default 2000
--	  'start-resource-low 2000
--	  'start-resource-medium 5000
--	  'start-resource-high 10000
--	  'income 100)
--	  FIXME: Must describe how geting resources work.
--

DefineDefaultResources(
	0, 2000, 1000, 1000, 1000, 1000, 1000)

DefineDefaultResourcesLow(
	0, 2000, 1000, 1000, 1000, 1000, 1000)

DefineDefaultResourcesMedium(
	0, 5000, 2000, 2000, 2000, 2000, 2000)

DefineDefaultResourcesHigh(
	0, 10000, 5000, 5000, 5000, 5000, 5000)

DefineDefaultIncomes(
	0, 100, 100, 100, 100, 100)

DefineDefaultActions(
	"stop", "mine", "chop", "drill", "mine", "mine", "mine")

DefineDefaultResourceNames(
	"time", "gold", "wood", "oil", "ore", "stone", "coal")

DefineDefaultResourceAmounts(
	"gold", 100000,
	"oil", 50000)

-------------------------------------------------------------------------------

--	Edit next to increase the speed, for debugging.

--	Decrease the mining time by this factor.
--SetSpeedResourcesHarvest("gold", 10)
--	Decrease the time in a gold deposit by this factor.
--SetSpeedResourcesReturn("gold", 10)
--	Decrease the time for chopping a tree by this factor.
--SetSpeedResourcesHarvest("wood", 10)
--	Decrease the time in a wood deposit by this factor.
--SetSpeedResourcesReturn("wood", 10)
--	Decrease the time for haul oil by this factor.
--SetSpeedResourcesHarvest("oil", 10)
--	Decrease the time in an oil deposit by this factor.
--SetSpeedResourcesReturn("oil", 10)
--	Decrease the time to build a unit by this factor.
--SetSpeedBuild(10)
--	Decrease the time to train a unit by this factor.
--SetSpeedTrain(10)
--	Decrease the time to upgrade a unit by this factor.
--SetSpeedUpgrade(10)
--	Decrease the time to research by this factor.
--SetSpeedResearch(10)

--	You can do all the above with this
SetSpeeds(1)

-------------------------------------------------------------------------------

AStar("fixed-unit-cost", 1000, "moving-unit-cost", 20, "know-unseen-terrain", "unseen-terrain-cost", 2)

-------------------------------------------------------------------------------

--	Maximum number of selectable units
SetMaxSelectable(18)

--	All player food unit limit
SetAllPlayersUnitLimit(200)
--	All player building limit
SetAllPlayersBuildingLimit(200)
--	All player total unit limit
SetAllPlayersTotalUnitLimit(400)

-------------------------------------------------------------------------------
--	Default triggers for single player
--		(FIXME: must be combined with game types)

function SinglePlayerTriggers()
  AddTrigger(
    function() return IfUnit("this", "==", 0, "all") end,
    function() return ActionDefeat() end)

  AddTrigger(
    function() return IfOpponents("this", "==", 0) end,
    function() return ActionVictory() end)
end

-------------------------------------------------------------------------------
--	Tables-Part
-------------------------------------------------------------------------------

--- Uses Stratagus Library path!
Load("ccl/wc2.lua")

Load("ccl/tilesets.lua")
Load("ccl/icons.lua")
if (WithSound()) then
	Load("ccl/sound.lua")
end
Load("ccl/missiles.lua")
Load("ccl/constructions.lua")
Load("ccl/spells.lua")
Load("ccl/units.lua")
Load("ccl/upgrade.lua")
Load("ccl/fonts.lua")
Load("ccl/buttons.lua")
Load("ccl/ui.lua")
Load("ccl/ai.lua")
Load("ccl/campaigns.lua")
Load("ccl/credits.lua")
Load("ccl/tips.lua")
Load("ccl/ranks.lua")
Load("ccl/menus.lua")

-------------------------------------------------------------------------------

-- Test code to create male orc names.
--(define orc-first (list "B" "Er" "G" "Gr" "H" "P" "Pr" "R" "V" "Vr"))
--(define orc-middle (list "a" "i" "o" "u"))
--(define orc-last (list "dash" "dish" "dush" "gar" "gor" "gdush" "lo" "gdish"
--    "k" "lg" "nak" "rag" "rbag" "rg" "rk" "ng" "nk" "rt" "ol" "urk" "shnak"))

--(define (orc-name)
--  (string-append (nth (rand (length orc-first)) orc-first)
--    (nth (rand (length orc-middle)) orc-middle)
--    (nth (rand (length orc-last)) orc-last)))

-- Test code to create male human names.
--(define human-first (list "Au" "Gar" "Bo" "Natha" "Gwë" "Ann" "Ma"
--    "Ygd" "Ni" "Lau" "Fra" "O'" "Sul"))
--(define human-middle (list "ba" "ga" "ro" "na" "ji" "ria" "da" "li" "re" "va"))
--(define human-last (list "nel" "mel" "mir" "ël" "len" "ll" "ril" "van"
--    "lin" "lien"))

--(define (human-name)
--  (string-append (nth (rand (length human-first)) human-first)
--    (nth (rand (length human-middle)) human-middle)
--    (nth (rand (length human-last)) human-last)))

--(define (gen-unit-name ut)
--  (orc-name))

-------------------------------------------------------------------------------

print("... ready!\n")
