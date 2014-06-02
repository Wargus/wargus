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

  b = menu:addLabel("Sound Options", 128, 11, Fonts["game"])

  b = Label("Effects Volume")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:add(b, offx + 16, offy + 36 * 1)

  local soundslider = {}
		-- slider button to decrease slider value
		soundslider = menu:addImageLeftSliderButton("", nil, 21, offy + 36 * 1.5, function() soundslider:setValue(soundslider:getValue() - 25.5); SetEffectsVolume(soundslider:getValue()) end)
		
		-- slider button to increase slider value
		soundslider = menu:addImageRightSliderButton("", nil, 213, offy + 36 * 1.5, function() soundslider:setValue(soundslider:getValue() + 25.5); SetEffectsVolume(soundslider:getValue()) end)
		
		-- slider itself
		soundslider = menu:addImageSlider(0, 255, 172, 18, offx + 41, offy + 36 * 1.5, g_marker, g_slider, function() SetEffectsVolume(soundslider:getValue()) end)
		
		-- set the value so the game saves it
		soundslider:setValue(GetEffectsVolume())

  b = Label("min")
  b:setFont(CFont:Get("small"))
  b:adjustSize();
  menu:addCentered(b, offx + 32, offy + 36 * 2 + 2)

  b = Label("max")
  b:setFont(CFont:Get("small"))
  b:adjustSize();
  menu:addCentered(b, offx + 224, offy + 36 * 2 + 2)

  menu:addLabel("Sound:", 12, 176, Fonts["game"], false)
  menu:addLabel("On", 60, 202, Fonts["game"], false)
  menu:addLabel("Off", 60, 224, Fonts["game"], false)  
  
  local effectscheckbox = {}
		effectscheckbox = menu:addImageRadioButton("", "effectscheckbox", 37, 200, offi, offi2, oni, oni2, function() SetEffectsEnabled(true) end)
		effectscheckbox:setMarked(IsEffectsEnabled())
		
		effectscheckbox = menu:addImageRadioButton("", "effectscheckbox", 37, 222, offi, offi2, oni, oni2, function() SetEffectsEnabled(false) end)
		if (IsEffectsEnabled() == true) then
			effectscheckbox:setMarked(false)
		else
			effectscheckbox:setMarked(true)
		end

  b = Label("Music Volume")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:add(b, offx + 16, offy + 36 * 2.75)
  
  local musicslider = {}
		-- slider button to decrease slider value
		musicslider = menu:addImageLeftSliderButton("", nil, 21, offy + 36 * 3.25, function() musicslider:setValue(musicslider:getValue() - 25.5); SetMusicVolume(musicslider:getValue()) end)
		
		-- slider button to decrease slider value
		musicslider = menu:addImageRightSliderButton("", nil, 213, offy + 36 * 3.25, function() musicslider:setValue(musicslider:getValue() + 25.5); SetMusicVolume(musicslider:getValue()) end)
		
		-- slider itself
		musicslider = menu:addImageSlider(0, 255, 172, 18, offx + 41, offy + 36 * 3.25, g_marker, g_slider, function() SetMusicVolume(musicslider:getValue()) end)
		
		-- set the value so the game saves it
		musicslider:setValue(GetMusicVolume())

  b = Label("min")
  b:setFont(CFont:Get("small"))
  b:adjustSize();
  menu:addCentered(b, offx + 32, 137)

  b = Label("max")
  b:setFont(CFont:Get("small"))
  b:adjustSize();
  menu:addCentered(b, offx + 224, 137)

  menu:addLabel("Music:", 112, 176, Fonts["game"], false)
  menu:addLabel("On", 160, 202, Fonts["game"], false)
  menu:addLabel("Off", 160, 224, Fonts["game"], false)  
  
  local musiccheckbox = {}
		musiccheckbox = menu:addImageRadioButton("", "musiccheckbox", 138, 200, offi, offi2, oni, oni2, function() SetMusicEnabled(true) end)
		musiccheckbox:setMarked(IsMusicEnabled())
		
		musiccheckbox = menu:addImageRadioButton("", "musiccheckbox", 138, 222, offi, offi2, oni, oni2, function() SetMusicEnabled(false) end)
		if (IsMusicEnabled() == true) then
			musiccheckbox:setMarked(false)
		else
			musiccheckbox:setMarked(true)
		end
  
  b = menu:addHalfButton("~!OK", "o", 16 + 12 + 106, 288 - 40,
    function()
		wc2.preferences.EffectsVolume = GetEffectsVolume()
		wc2.preferences.EffectsEnabled = IsEffectsEnabled()
		wc2.preferences.MusicVolume = GetMusicVolume()
		wc2.preferences.MusicEnabled = IsMusicEnabled()
		SavePreferences()
		menu:stop()
    end)

  b = menu:addHalfButton("~!Cancel", "c", 16, 288 - 40,
    function() 
	  menu:stop() 
	end)
end

function RunGameSoundOptionsMenu()
  local menu = WarGameMenu(panel(1))
  menu:resize(256, 288)

  AddSoundOptions(menu, 0, 0, 256/2 - 192/2, 256)

  menu:run(false)
end

function RunPreferencesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Preferences", 128, 11)

-- To fog of war? Or not to fog of war?
  menu:addLabel("Show Hotkeys:", 16, 40, Fonts["large"], false)
  menu:addLabel("On", 79, 65, Fonts["large"], false)
  menu:addLabel("Off", 79, 87, Fonts["large"], false)
  
  local ckey = {}
        ckey = menu:addImageRadioButton("", "ckey", 56, 63, offi, offi2, oni, oni2, function() UI.ButtonPanel.ShowCommandKey = true end)
        ckey:setMarked(UI.ButtonPanel.ShowCommandKey)
  
        ckey = menu:addImageRadioButton("", "ckey", 56, 85, offi, offi2, oni, oni2, function() UI.ButtonPanel.ShowCommandKey = false end)
        if (UI.ButtonPanel.ShowCommandKey == true) then
          ckey:setMarked(false)
        else
          ckey:setMarked(true)
        end
  
  -- To fog of war? Or not to fog of war?
  menu:addLabel("Fog of War:", 16, 108, Fonts["large"], false)
  menu:addLabel("On", 79, 132, Fonts["large"], false)
  menu:addLabel("Off", 79, 154, Fonts["large"], false)
  
  local fog = {}
        fog = menu:addImageRadioButton("", "fog", 56, 130, offi, offi2, oni, oni2, function() SetFogOfWar(true) end)
        fog:setMarked(GetFogOfWar())
  
        fog = menu:addImageRadioButton("", "fog", 56, 152, offi, offi2, oni, oni2, function() SetFogOfWar(false) end)
        if (GetFogOfWar() == true) then
          fog:setMarked(false)
        else
          fog:setMarked(true)
        end
		
  if (IsReplayGame() or IsNetworkGame()) then
		fog:setEnabled(false)
  end  
  
  -- Grab the mouse, so it doesn't go outside the window in "windowed" mode (Has no effect in fullscreen mode though)
  menu:addLabel("Grab Mouse:", 12, 176, Fonts["large"], false)
  menu:addLabel("On", 79, 202, Fonts["large"], false)
  menu:addLabel("Off", 79, 224, Fonts["large"], false)
  
  local gmouse = {}
	    gmouse = menu:addImageRadioButton("", "gmouse", 56, 200, offi, offi2, oni, oni2, function() SetGrabMouse(true) end)
		gmouse:setMarked(GetGrabMouse())
  	
		gmouse = menu:addImageRadioButton("", "gmouse", 56, 222, offi, offi2, oni, oni2, function() SetGrabMouse(false) end)
        if (GetGrabMouse() == true) then
          gmouse:setMarked(false)
        else
          gmouse:setMarked(true)
        end
	
  menu:addHalfButton("~!OK", "o", 16 + 12 + 106, 288 - 40,
    function()
	  wc2.preferences.GrabMouse = GetGrabMouse()
      wc2.preferences.FogOfWar = GetFogOfWar()
      wc2.preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
      SavePreferences()
      menu:stop(1)
    end)

  menu:addHalfButton("~!Cancel", "c", 16, 288 - 40,
    function() 
	  menu:stop()
	end)
	
	menu:run(false)
end

function RunSpeedsMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Speed Settings", 128, 8, Fonts["game"])
  menu:addLabel("Game Speed", 12, 44, Fonts["game"], false)

  local gamespeed = {}
		-- slider button to decrease slider value
		gamespeed = menu:addImageLeftSliderButton("", nil, 21, 60, function() gamespeed:setValue(gamespeed:getValue() - 5); SetGameSpeed(gamespeed:getValue()) end)
		
	    -- slider button to decrease slider value
		gamespeed = menu:addImageRightSliderButton("", nil, 213, 60, function() gamespeed:setValue(gamespeed:getValue() + 5); SetGameSpeed(gamespeed:getValue()) end)
		
		-- slider itself
		gamespeed = menu:addImageSlider(15, 75, 172, 18, 41, 60, g_marker, g_slider, function() SetGameSpeed(gamespeed:getValue()) end)
		
		-- set the value so the game saves it
		gamespeed:setValue(GetGameSpeed())

  menu:addLabel("slow", 22, 80, Fonts["small"], false)
  local l = Label("fast")
  l:setFont(Fonts["small"])
  l:adjustSize()
  menu:add(l, 234 - l:getWidth(), 80)

  menu:addLabel("Mouse Scroll Speed", 12, 112, Fonts["game"], false)

  local mousescrollspeed = {}
  		-- slider button to decrease slider value
		mousescrollspeed = menu:addImageLeftSliderButton("", nil, 21, 128, function() mousescrollspeed:setValue(mousescrollspeed:getValue() - .5); SetMouseScrollSpeed(mousescrollspeed:getValue()) end)
		
	    -- slider button to decrease slider value		
		mousescrollspeed = menu:addImageRightSliderButton("", nil, 213, 128, function() mousescrollspeed:setValue(mousescrollspeed:getValue() + .5); SetMouseScrollSpeed(mousescrollspeed:getValue()) end)
		
		-- slider itself
		mousescrollspeed = menu:addImageSlider(1, 10, 172, 18, 41, 128, g_marker, g_slider, function() SetMouseScrollSpeed(mousescrollspeed:getValue()) end)
		
		-- set the value so the game saves it
		mousescrollspeed:setValue(GetMouseScrollSpeed())

  menu:addLabel("slow", 22, 148, Fonts["small"], false)
  local l = Label("fast")
  l:setFont(Fonts["small"])
  l:adjustSize()
  menu:add(l, 228 - l:getWidth() + 6, 148)
  
  menu:addHalfButton("~!OK", "o", 16 + 12 + 106, 288 - 40,
  function()
	  wc2.preferences.GameSpeed = GetGameSpeed()
      wc2.preferences.MouseScrollSpeed = GetMouseScrollSpeed()
      SavePreferences()
      menu:stop(1)
  end)

  menu:addHalfButton("~!Cancel", "c", 16, 288 - 40,
    function() 
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
  menu:addFullButton("Speeds (~<F6~>)", "f6", 16, 40 + 36*0,
    function() RunSpeedsMenu() end)
  menu:addFullButton("Sound (~<F7~>)", "f7", 16, 40 + 36*1,
    function() RunGameSoundOptionsMenu() end) 
	menu:addFullButton("Preferences (~<F8~>)", "f8", 16, 40 + 36*2,
    function() RunPreferencesMenu() end)
  menu:addFullButton("Diplomacy (~<F9~>)", "f9", 16, 40 + 36*3,
    function() RunDiplomacyMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 128 - (224 / 2), 288 - 40,
    function() menu:stop() end)

  menu:run(false)
end

