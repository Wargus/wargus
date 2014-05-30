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
--      options.lua - Define the menu for options.
--
--      (c) Copyright 2006-2011 by Jimmy Salmon, Pali Rohár and Kyran Jackson.
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

function AddSoundOptions(menu, offx, offy, centerx, bottom)
  local b

  b = menu:addLabel("Sound Options", 176, 11)

  b = Label("Effects Volume")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:add(b, offx + 16, offy + 36 * 1)

  -- FIXME: disable if effects turned off
  local soundslider = Slider(0, 255)
  soundslider:setValue(GetEffectsVolume())
  soundslider:setActionCallback(function() SetEffectsVolume(soundslider:getValue()) end)
  soundslider:setWidth(198)
  soundslider:setHeight(18)
  soundslider:setBaseColor(dark)
  soundslider:setForegroundColor(clear)
  soundslider:setBackgroundColor(clear)
  menu:add(soundslider, offx + 32, offy + 36 * 1.5)

  b = Label("min")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 44, offy + 36 * 2 + 6)

  b = Label("max")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 218, offy + 36 * 2 + 6)

  local effectscheckbox = {}
  effectscheckbox = menu:addCheckBox("Enabled", offx + 240, offy + 36 * 1.5,
    function() SetEffectsEnabled(effectscheckbox:isMarked()) end)
  effectscheckbox:setMarked(IsEffectsEnabled())
  effectscheckbox:adjustSize()

  b = Label("Music Volume")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:add(b, offx + 16, offy + 36 * 3)

  -- FIXME: disable if music turned off
  local musicslider = Slider(0, 255)
  musicslider:setValue(GetMusicVolume())
  musicslider:setActionCallback(function() SetMusicVolume(musicslider:getValue()) end)
  musicslider:setWidth(198)
  musicslider:setHeight(18)
  musicslider:setBaseColor(dark)
  musicslider:setForegroundColor(clear)
  musicslider:setBackgroundColor(clear)
  menu:add(musicslider, offx + 32, offy + 36 * 3.5)

  b = Label("min")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 44, offy + 36 * 4 + 6)

  b = Label("max")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 218, offy + 36 * 4 + 6)

  local musiccheckbox = {}
  musiccheckbox = menu:addCheckBox("Enabled", offx + 240, offy + 36 * 3.5,
    function() SetMusicEnabled(musiccheckbox:isMarked()); MusicStopped() end)
  musiccheckbox:setMarked(IsMusicEnabled())
  musiccheckbox:adjustSize();

  b = menu:addFullButton("~!OK", "o", centerx, bottom - 11 - 27,
    function()
      wc2.preferences.EffectsVolume = GetEffectsVolume()
      wc2.preferences.EffectsEnabled = IsEffectsEnabled()
      wc2.preferences.MusicVolume = GetMusicVolume()
      wc2.preferences.MusicEnabled = IsMusicEnabled()
      SavePreferences()
      menu:stop()
    end)
end

function RunGameSoundOptionsMenu()
  local menu = WarGameMenu(panel(5))
  menu:resize(352, 352)

  AddSoundOptions(menu, 0, 0, 352/2 - 224/2, 352)

  menu:run(false)
end

function RunPreferencesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Preferences", 128, 11)

  local fog = {}
  fog = menu:addCheckBox("Fog of War", 16, 40 + 36 * 0,
    function() SetFogOfWar(fog:isMarked()) end)
  fog:setMarked(GetFogOfWar())
  if (IsReplayGame() or IsNetworkGame()) then
    fog:setEnabled(false)
  end

  local ckey = {}
  ckey = menu:addCheckBox("Show command key", 16, 40 + 36 * 1,
    function() UI.ButtonPanel.ShowCommandKey = ckey:isMarked() end)
  ckey:setMarked(UI.ButtonPanel.ShowCommandKey)

  menu:addLabel("Game Speed", 16, 40 + 36 * 2, Fonts["game"], false)

  local gamespeed = {}
  gamespeed = menu:addSlider(15, 90, 198, 18, 32, 40 + 36 * 2.5,
    function() SetGameSpeed(gamespeed:getValue()) end)
  gamespeed:setValue(GetGameSpeed())

  menu:addLabel("slow", 34, 40 + (36 * 3) + 6, Fonts["small"], false)
  local l = Label("fast")
  l:setFont(Fonts["small"])
  l:adjustSize()
  menu:add(l, 230 - l:getWidth(), 40 + (36 * 3) + 6)

  menu:addFullButton("~!OK", "o", 128 - (224 / 2), 288 - 40,
    function()
      wc2.preferences.FogOfWar = GetFogOfWar()
      wc2.preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
      wc2.preferences.GameSpeed = GetGameSpeed()
      SavePreferences()
      menu:stop()
    end)

  menu:run(false)
end

function SetVideoSize(width, height)
  if (Video:ResizeScreen(width, height) == false) then
    return
  end
  bckground:Resize(Video.Width, Video.Height)
  backgroundWidget = ImageWidget(bckground)
  Load("scripts/ui.lua")
  wc2.preferences.VideoWidth = Video.Width
  wc2.preferences.VideoHeight = Video.Height
  SavePreferences()
end

function BuildOptionsMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 352) / 2
  local offy = (Video.Height - 352) / 2
  local checkTexture
  local b
  
  if (Video.Width < 640 or Video.Height < 400) then
    -- For ultra small resolutions.
    menu:addLabel("Global Options", Video.Width - Video.Width/4, Video.Height/6)
    -- menu:addLabel("Video Resolution", Video.Width/8 - 4, Video.Height/3, Fonts["game"], false)
  
    b = menu:addCheckBox("320 x 240", Video.Width/8 + 12, Video.Height/6.5 + 26*1.8,
      function() SetVideoSize(320, 240) menu:stop(1) end)
    if (Video.Width == 320 and Video.Height == 240) then b:setMarked(true) end
	
	b = menu:addCheckBox("640 x 480", Video.Width/8 + 12, Video.Height/6.5 + 26*2.6,
      function() SetVideoSize(640, 480) menu:stop(1) end)
	if (Video.Width == 640 and Video.Height == 480) then b:setMarked(true) end
  
  	b = menu:addCheckBox("720 x 480", Video.Width/8 + 12, Video.Height/6.5 + 26*3.4,
	  function() SetVideoSize(720, 480) menu:stop(1) end)
	if (Video.Width == 720 and Video.Height == 480) then b:setMarked(true) end
	
    b = menu:addCheckBox("720 x 576", Video.Width/8 + 12, Video.Height/6.5 + 26*4.2,
	  function() SetVideoSize(720, 576) menu:stop(1) end)
	if (Video.Width == 720 and Video.Height ==756) then b:setMarked(true) end
  
	b = menu:addCheckBox("800 x 480", Video.Width/8 + 12, Video.Height/6.5 + 26*5,
	  function() SetVideoSize(800, 480) menu:stop(1) end)
	if (Video.Width == 800 and Video.Height == 480) then b:setMarked(true) end
	
	b = menu:addCheckBox("1024 x 768", Video.Width/8 + 12, Video.Height/6.5 + 26*5.8,
      function() SetVideoSize(1024, 768) menu:stop(1) end)
    if (Video.Width == 1024 and Video.Height == 768) then b:setMarked(true) end
	
	b = menu:addCheckBox("Full Screen", Video.Width/2 + 16, Video.Height/6.5 + 26*1.8,
      function()
        ToggleFullScreen()
		wc2.preferences.VideoFullScreen = Video.FullScreen
        SavePreferences()
        menu:stop(1)
      end)
    b:setMarked(Video.FullScreen)

    checkOpenGL = menu:addCheckBox("OpenGL", Video.Width/2 + 16, Video.Height/6.5 + 26*2.6,
      function()
		wc2.preferences.UseOpenGL = checkOpenGL:isMarked()
		SavePreferences()
      end)
	checkOpenGL:setMarked(wc2.preferences.UseOpenGL)

    menu:addHalfButton("~!OK", "o", Video.Width/2 + 16, Video.Height/6.5 + 26*5.8, 
	  function() 
		wc2.preferences.EffectsVolume = GetEffectsVolume()
		wc2.preferences.EffectsEnabled = IsEffectsEnabled()
		wc2.preferences.MusicVolume = GetMusicVolume()
		wc2.preferences.MusicEnabled = IsMusicEnabled()
        SavePreferences()
	    menu:stop() 
	  end)

    effectscheckbox = menu:addCheckBox("Sound", Video.Width/2 + 16, Video.Height/6.5 + 26*3.4,
      function() 
	    SetEffectsEnabled(effectscheckbox:isMarked()) 
      end)
    effectscheckbox:setMarked(IsEffectsEnabled())

    musiccheckbox = menu:addCheckBox("Music", Video.Width/2 + 16, Video.Height/6.5 + 26*4.2,
      function() 
	    SetMusicEnabled(musiccheckbox:isMarked()); MusicStopped() 
	  end)
    musiccheckbox:setMarked(IsMusicEnabled())
	
  else
  
    menu:addLabel("Global Options", offx + 176, offy + 1 + 26*-2)
    menu:addLabel("Video Resolution", offx + 16, offy + 34 + 26*-2, Fonts["game"], false)
    -- Normal (4:3 and 5:4)
  
    b = menu:addCheckBox("320 x 240", offx + 16, offy + 55 + 26*-1, -- 320 x 240, for Caanoo, Wiz, and GP2X. - Kyran Jackson.
      function() SetVideoSize(320, 240) menu:stop(1) end)
    if (Video.Width == 320 and Video.Height == 240) then b:setMarked(true) end
    
    b = menu:addCheckBox("640 x 480", offx + 16, offy + 55 + 26*-0.2,
      function() SetVideoSize(640, 480) menu:stop(1) end)
    if (Video.Width == 640 and Video.Height == 480) then b:setMarked(true) end
  
    b = menu:addCheckBox("800 x 480", offx + 16, offy + 55 + 26*0.6,
      function() SetVideoSize(800, 480) menu:stop(1) end)
    if (Video.Width == 800 and Video.Height == 480) then b:setMarked(true) end
  
    b = menu:addCheckBox("720 x 576", offx + 16, offy + 55 + 26*1.4,
      function() SetVideoSize(720, 576) menu:stop(1) end)
    if (Video.Width == 720 and Video.Height == 576) then b:setMarked(true) end
  
    b = menu:addCheckBox("800 x 600", offx + 16, offy + 55 + 26*2.2,
      function() SetVideoSize(800, 600) menu:stop(1) end)
    if (Video.Width == 800 and Video.Height == 600) then b:setMarked(true) end
  
    b = menu:addCheckBox("1024 x 768", offx + 16, offy + 55 + 26*3,
      function() SetVideoSize(1024, 768) menu:stop(1) end)
    if (Video.Width == 1024 and Video.Height == 768) then b:setMarked(true) end
  
    b = menu:addCheckBox("1152 x 864", offx + 16, offy + 55 + 26*3.8,
      function() SetVideoSize(1152, 864) menu:stop(1) end)
    if (Video.Width == 1152 and Video.Height == 864) then b:setMarked(true) end
  
    b = menu:addCheckBox("1280 x 960", offx + 16, offy + 55 + 26*4.6,
      function() SetVideoSize(1280, 960) menu:stop(1) end)
    if (Video.Height == 960) then b:setMarked(true) end
  
    b = menu:addCheckBox("1280 x 1024", offx + 16, offy + 55 + 26*5.4,
      function() SetVideoSize(1280, 1024) menu:stop(1) end)
    if (Video.Height == 1024) then b:setMarked(true) end  
  
    b = menu:addCheckBox("1400 x 1050", offx + 16, offy + 55 + 26*6.2,
      function() SetVideoSize(1400, 1050) menu:stop(1) end)
    if (Video.Width == 1400) then b:setMarked(true) end

    b = menu:addCheckBox("1600 x 1200", offx + 16, offy + 55 + 26*7, 
      function() SetVideoSize(1600, 1200) menu:stop(1) end)
    if (Video.Width == 1600 and Video.Height == 1200) then b:setMarked(true) end
  
    b = menu:addCheckBox("1600 x 1280", offx + 16, offy + 55 + 26*7.8, 
      function() SetVideoSize(1600, 1280) menu:stop(1) end)
    if (Video.Width == 1600 and Video.Height == 1280) then b:setMarked(true) end
  
    b = menu:addCheckBox("1920 x 1440", offx + 16, offy + 55 + 26*8.6, 
      function() SetVideoSize(1920, 1440) menu:stop(1) end)
    if (Video.Width == 1920 and Video.Height == 1440) then b:setMarked(true) end
  
    -- Widescreen 10:6
  
    b = menu:addCheckBox("1024 x 600", offx + 16*15, offy + 55 + 26*-1, -- Adding netbook resolution in response to #685144. - Kyran Jackson.
      function() SetVideoSize(1024, 600) menu:stop(1) end)
    if (Video.Width == 1024 and Video.Height == 600) then b:setMarked(true) end
  
    -- Widescreen 16:9
  
    b = menu:addCheckBox("1280 x 720", offx + 16*15, offy + 55 + 26*-0.2,
      function() SetVideoSize(1280, 720) menu:stop(1) end)
    if (Video.Width == 1280 and Video.Height == 720) then b:setMarked(true) end
  
    b = menu:addCheckBox("1360 x 768", offx + 16*15, offy + 55 + 26*0.6,
      function() SetVideoSize(1360, 768) menu:stop(1) end)
    if (Video.Width == 1360 and Video.Height == 768) then b:setMarked(true) end
  
    b = menu:addCheckBox("1366 x 768", offx + 16*15, offy + 55 + 26*1.4,
      function() SetVideoSize(1366, 768) menu:stop(1) end)
    if (Video.Width == 1366 and Video.Height == 768) then b:setMarked(true) end
  
    b = menu:addCheckBox("1600 x 900", offx + 16*15, offy + 55 + 26*2.2,
      function() SetVideoSize(1600, 900) menu:stop(1) end)
    if (Video.Width == 1600 and Video.Height == 900) then b:setMarked(true) end
  
    b = menu:addCheckBox("1920 x 1080", offx + 16*15, offy + 55 + 26*3,
      function() SetVideoSize(1920, 1080) menu:stop(1) end)
    if (Video.Width == 1920 and Video.Height == 1080) then b:setMarked(true) end
  
    -- Widescreen 16:10
  
    b = menu:addCheckBox("720 x 480", offx + 16*15, offy + 55 + 26*3.8,
      function() SetVideoSize(720, 480) menu:stop(1) end)
    if (Video.Width == 720 and Video.Height == 480) then b:setMarked(true) end
  
    b = menu:addCheckBox("1280 x 768", offx + 16*15, offy + 55 + 26*4.6,
      function() SetVideoSize(1280, 768) menu:stop(1) end)
    if (Video.Width == 1280 and Video.Height == 768) then b:setMarked(true) end
  
    b = menu:addCheckBox("1280 x 800", offx + 16*15, offy + 55 + 26*5.4,
      function() SetVideoSize(1280, 800) menu:stop(1) end)
    if (Video.Width ==1280 and Video.Height == 800) then b:setMarked(true) end
  
    b = menu:addCheckBox("1440 x 900", offx + 16*15, offy + 55 + 26*6.2,
      function() SetVideoSize(1440, 900) menu:stop(1) end)
    if (Video.Width == 1440 and Video.Height == 900) then b:setMarked(true) end
  
    b = menu:addCheckBox("1680 x 1050", offx + 16*15, offy + 55 + 26*7,
      function() SetVideoSize(1680, 1050) menu:stop(1) end)
    if (Video.Width == 1680 and Video.Height == 1050) then b:setMarked(true) end
  
    b = menu:addCheckBox("1920 x 1200", offx + 16*15, offy + 55 + 26*7.8,
      function() SetVideoSize(1920, 1200) menu:stop(1) end)
    if (Video.Width == 1920 and Video.Height == 1200) then b:setMarked(true) end
  
    b = menu:addCheckBox("2560 x 1600", offx + 16*15, offy + 55 + 26*8.6,
      function() SetVideoSize(2560, 1600) menu:stop(1) end)
    if (Video.Width == 2560 and Video.Height == 1600) then b:setMarked(true) end

    b = menu:addCheckBox("Full Screen", offx + 17, offy + 55 + 26*10 + 14,
      function()
        ToggleFullScreen()
        wc2.preferences.VideoFullScreen = Video.FullScreen
        SavePreferences()
        menu:stop(1)
      end)
    b:setMarked(Video.FullScreen)

    checkTexture = menu:addCheckBox("Set Maximum OpenGL Texture to 256", offx + 127, offy + 55 + 26*10 + 14,
      function()
        if (checkTexture:isMarked()) then
          wc2.preferences.MaxOpenGLTexture = 256
        else
          wc2.preferences.MaxOpenGLTexture = 0
        end
        SetMaxOpenGLTexture(wc2.preferences.MaxOpenGLTexture)
        SavePreferences()
      end)
    if (wc2.preferences.MaxOpenGLTexture == 256) then checkTexture:setMarked(true) end

    checkOpenGL = menu:addCheckBox("Use OpenGL / OpenGL ES 1.1 (restart required)", offx + 17, offy + 55 + 26*11 + 14,
      function()
--TODO: Add function for immediately change state of OpenGL
        wc2.preferences.UseOpenGL = checkOpenGL:isMarked()
        SavePreferences()
--      menu:stop(1) --TODO: Enable if we have an OpenGL function
      end)
    checkOpenGL:setMarked(wc2.preferences.UseOpenGL)
--  checkOpenGL:setMarked(UseOpenGL) --TODO: Enable if we have an OpenGL function

    menu:addHalfButton("~!OK", "o", offx + 123, offy + 55 + 26*12 + 14, function() menu:stop() end)

    end
  return menu:run()
end


function RunOptionsMenu()
  local continue = 1
  while (continue == 1) do
    continue = BuildOptionsMenu()
  end
end

function RunGameOptionsMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Game Options", 128, 11)
  menu:addFullButton("Sound (~<F7~>)", "f7", 16, 40 + 36*0,
    function() RunGameSoundOptionsMenu() end)
  menu:addFullButton("Preferences (~<F8~>)", "f8", 16, 40 + 36*1,
    function() RunPreferencesMenu() end)
  menu:addFullButton("Diplomacy (~<F9~>)", "f9", 16, 40 + 36*2,
    function() RunDiplomacyMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 128 - (224 / 2), 288 - 40,
    function() menu:stop() end)

  menu:run(false)
end

