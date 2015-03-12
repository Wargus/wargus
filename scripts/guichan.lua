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
--      guichan.lua - Define the main guichan menu.
--
--      (c) Copyright 2006-2015 by Jimmy Salmon, Pali Rohár and cybermind
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

SetDefaultRaceView()
SetGrabMouse(wc2.preferences.GrabMouse)

-- Global useful objects for menus  ----------
dark = Color(38, 38, 78)
clear = Color(200, 200, 120)
black = Color(0, 0, 0)

bckground = CGraphic:New("ui/Menu_background_with_title.png")
bckground:Load()
bckground:Resize(Video.Width, Video.Height)
backgroundWidget = ImageWidget(bckground)

g_hbln = CGraphic:New("ui/human/widgets/button-large-normal.png")
g_hbln:Load()
g_hblp = CGraphic:New("ui/human/widgets/button-large-pressed.png")
g_hblp:Load()
g_hblg = CGraphic:New("ui/human/widgets/button-large-grayed.png")
g_hblg:Load()

g_hbsn = CGraphic:New("ui/human/widgets/button-small-normal.png")
g_hbsn:Load()
g_hbsp = CGraphic:New("ui/human/widgets/button-small-pressed.png")
g_hbsp:Load()
g_hbsg = CGraphic:New("ui/human/widgets/button-small-grayed.png")
g_hbsg:Load()

g_obln = CGraphic:New("ui/orc/widgets/button-large-normal.png")
g_obln:Load()
g_oblp = CGraphic:New("ui/orc/widgets/button-large-pressed.png")
g_oblp:Load()
g_oblg = CGraphic:New("ui/orc/widgets/button-large-grayed.png")
g_oblg:Load()

g_obsn = CGraphic:New("ui/orc/widgets/button-small-normal.png")
g_obsn:Load()
g_obsp = CGraphic:New("ui/orc/widgets/button-small-pressed.png")
g_obsp:Load()
g_obsg = CGraphic:New("ui/orc/widgets/button-small-grayed.png")
g_obsg:Load()

g_hcheckbox_off = CGraphic:New("ui/human/widgets/checkbox-normal-unselected.png")
g_hcheckbox_off:Load()
g_hcheckbox_off2 = CGraphic:New("ui/human/widgets/checkbox-pressed-unselected.png")
g_hcheckbox_off2:Load()
g_hcheckbox_on = CGraphic:New("ui/human/widgets/checkbox-normal-selected.png")
g_hcheckbox_on:Load()
g_hcheckbox_on2 = CGraphic:New("ui/human/widgets/checkbox-pressed-selected.png")
g_hcheckbox_on2:Load()

g_ocheckbox_off = CGraphic:New("ui/orc/widgets/checkbox-normal-unselected.png")
g_ocheckbox_off:Load()
g_ocheckbox_off2 = CGraphic:New("ui/orc/widgets/checkbox-pressed-unselected.png")
g_ocheckbox_off2:Load()
g_ocheckbox_on = CGraphic:New("ui/orc/widgets/checkbox-normal-selected.png")
g_ocheckbox_on:Load()
g_ocheckbox_on2 = CGraphic:New("ui/orc/widgets/checkbox-pressed-selected.png")
g_ocheckbox_on2:Load()

g_oradio_off = CGraphic:New("ui/orc/widgets/radio-normal-unselected.png")
g_oradio_off:Load()
g_oradio_off2 = CGraphic:New("ui/orc/widgets/radio-pressed-unselected.png")
g_oradio_off2:Load()
g_oradio_on = CGraphic:New("ui/orc/widgets/radio-normal-selected.png")
g_oradio_on:Load()
g_oradio_on2 = CGraphic:New("ui/orc/widgets/radio-pressed-selected.png")
g_oradio_on2:Load()

g_hradio_off = CGraphic:New("ui/human/widgets/radio-normal-unselected.png")
g_hradio_off:Load()
g_hradio_off2 = CGraphic:New("ui/human/widgets/radio-pressed-unselected.png")
g_hradio_off2:Load()
g_hradio_on = CGraphic:New("ui/human/widgets/radio-normal-selected.png")
g_hradio_on:Load()
g_hradio_on2 = CGraphic:New("ui/human/widgets/radio-pressed-selected.png")
g_hradio_on2:Load()

-- original continue button for the campaign, chapter and victory/defeat screens
g_continue_n = CGraphic:New("ui/human/widgets/button-grayscale-normal.png")
g_continue_n:Load()
g_continue_p = CGraphic:New("ui/human/widgets/button-grayscale-pressed.png")
g_continue_p:Load()

-- right slider arrows for human
g_hrslider_n = CGraphic:New("ui/human/widgets/right-arrow-normal.png")
g_hrslider_n:Load()
g_hrslider_p = CGraphic:New("ui/human/widgets/right-arrow-pressed.png")
g_hrslider_p:Load()
g_hrslider_d = CGraphic:New("ui/human/widgets/right-arrow-grayed.png")
g_hrslider_d:Load()

-- left slider arrows for human
g_hlslider_n = CGraphic:New("ui/human/widgets/left-arrow-normal.png")
g_hlslider_n:Load()
g_hlslider_p = CGraphic:New("ui/human/widgets/left-arrow-pressed.png")
g_hlslider_p:Load()
g_hlslider_d = CGraphic:New("ui/human/widgets/left-arrow-grayed.png")
g_hlslider_d:Load()

-- up slider arrows for human
g_huslider_n = CGraphic:New("ui/human/widgets/up-arrow-normal.png")
g_huslider_n:Load()
g_huslider_p = CGraphic:New("ui/human/widgets/up-arrow-pressed.png")
g_huslider_p:Load()
g_huslider_d = CGraphic:New("ui/human/widgets/up-arrow-grayed.png")
g_huslider_d:Load()

-- down slider arrows for human
g_hdslider_n = CGraphic:New("ui/human/widgets/down-arrow-normal.png")
g_hdslider_n:Load()
g_hdslider_p = CGraphic:New("ui/human/widgets/down-arrow-pressed.png")
g_hdslider_p:Load()
g_hdslider_d = CGraphic:New("ui/human/widgets/down-arrow-grayed.png")
g_hdslider_d:Load()

-- right slider arrows for orc
g_orslider_n = CGraphic:New("ui/orc/widgets/right-arrow-normal.png")
g_orslider_n:Load()
g_orslider_p = CGraphic:New("ui/orc/widgets/right-arrow-pressed.png")
g_orslider_p:Load()
g_orslider_d = CGraphic:New("ui/orc/widgets/right-arrow-grayed.png")
g_orslider_d:Load()

-- left slider arrows for orc
g_olslider_n = CGraphic:New("ui/orc/widgets/left-arrow-normal.png")
g_olslider_n:Load()
g_olslider_p = CGraphic:New("ui/orc/widgets/left-arrow-pressed.png")
g_olslider_p:Load()
g_olslider_d = CGraphic:New("ui/orc/widgets/left-arrow-grayed.png")
g_olslider_d:Load()

-- up slider arrows for orc
g_ouslider_n = CGraphic:New("ui/orc/widgets/up-arrow-normal.png")
g_ouslider_n:Load()
g_ouslider_p = CGraphic:New("ui/orc/widgets/up-arrow-pressed.png")
g_ouslider_p:Load()
g_ouslider_d = CGraphic:New("ui/orc/widgets/up-arrow-grayed.png")
g_ouslider_d:Load()

-- down slider arrows for orc
g_odslider_n = CGraphic:New("ui/orc/widgets/down-arrow-normal.png")
g_odslider_n:Load()
g_odslider_p = CGraphic:New("ui/orc/widgets/down-arrow-pressed.png")
g_odslider_p:Load()
g_odslider_d = CGraphic:New("ui/orc/widgets/down-arrow-grayed.png")
g_odslider_d:Load()

-- slider marker - so we know the value of the option we're trying to change
g_hmarker = CGraphic:New("ui/human/widgets/slider-knob.png")
g_hmarker:Load()

-- slider background image
g_hslider = CGraphic:New("ui/human/widgets/hslider-bar-normal.png")
g_hslider:Load()
g_hslider_d = CGraphic:New("ui/human/widgets/hslider-bar-grayed.png")
g_hslider_d:Load()

-- vertical slider background image
g_hvslider = CGraphic:New("ui/human/widgets/vslider-bar-normal.png")
g_hvslider:Load()
g_hvslider_d = CGraphic:New("ui/human/widgets/vslider-bar-grayed.png")
g_hvslider_d:Load()

-- same, but for orc this time.
g_omarker = CGraphic:New("ui/orc/widgets/slider-knob.png")
g_omarker:Load()

-- slider image for the orcs
g_oslider = CGraphic:New("ui/orc/widgets/hslider-bar-normal.png")
g_oslider:Load()
g_oslider_d = CGraphic:New("ui/orc/widgets/hslider-bar-grayed.png")
g_oslider_d:Load()

-- vertical slider image for the orcs
g_ovslider = CGraphic:New("ui/orc/widgets/vslider-bar-normal.png")
g_ovslider:Load()
g_ovslider_d = CGraphic:New("ui/orc/widgets/vslider-bar-grayed.png")
g_ovslider_d:Load()

-- human list box item bar
g_hibar = CGraphic:New("ui/human/widgets/pulldown-bar-normal.png")
g_hibar:Load()

-- orc list box item bar
g_oibar = CGraphic:New("ui/orc/widgets/pulldown-bar-normal.png")
g_oibar:Load()

local hpanels = {
  "ui/human/panel_1.png",
  "ui/human/panel_2.png",
  "ui/human/panel_3.png",
  "ui/human/panel_4.png",
  "ui/human/panel_5.png"
}

local opanels = {
  "ui/orc/panel_1.png",
  "ui/orc/panel_2.png",
  "ui/orc/panel_3.png",
  "ui/orc/panel_4.png",
  "ui/orc/panel_5.png"
}

local wc1_hpanels = {
  "ui/human_war1/panel_1.png",
  "ui/human_war1/panel_2.png",
  "ui/human_war1/panel_3.png",
  "ui/human_war1/panel_4.png",
  "ui/human_war1/panel_5.png"
}

local wc1_opanels = {
  "ui/orc_war1/panel_1.png",
  "ui/orc_war1/panel_2.png",
  "ui/orc_war1/panel_3.png",
  "ui/orc_war1/panel_4.png",
  "ui/orc_war1/panel_5.png"
}

function panel(n)
  if (currentExp == "wc1") then
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
      return wc1_hpanels[n]
    else
      return wc1_opanels[n]
    end
  else
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
      return hpanels[n]
    else
      return opanels[n]
    end
  end
end



function AddMenuHelpers(menu)
  function menu:addCentered(widget, x, y)
    self:add(widget, x - widget:getWidth() / 2, y)
  end

  function menu:addLabel(text, x, y, font, center)
    local label = Label(text)
    if (font == nil) then font = Fonts["large"] end
    label:setFont(font)
    label:adjustSize()
    if (center == nil or center == true) then -- center text by default
      x = x - label:getWidth() / 2
    end
    self:add(label, x, y)

    return label
  end

  function menu:writeText(text, x, y)
    return self:addLabel(text, x, y, Fonts["game"], false)
  end

  function menu:writeLargeText(text, x, y)
    return self:addLabel(text, x, y, Fonts["large"], false)
  end

  function menu:addButton(caption, hotkey, x, y, callback, size)
    local b = ButtonWidget(caption)
	b:setHotKey(hotkey)
    b:setActionCallback(callback)
    if (size == nil) then size = {200, 24} end
    b:setSize(size[1], size[2])
    b:setBackgroundColor(dark)
    b:setBaseColor(dark)
    self:add(b, x, y)
	b:setBorderSize(0)
    return b
  end

  function menu:addImageButton(caption, hotkey, x, y, callback)
    local b = ImageButton(caption)
	b:setHotKey(hotkey)
    b:setActionCallback(callback)
    self:add(b, x, y)
	b:setBorderSize(0)
    return b
  end

  function menu:addFullButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
	  b:setNormalImage(g_hbln)
      b:setPressedImage(g_hblp)
      b:setDisabledImage(g_hblg)
    else
      b:setNormalImage(g_obln)
      b:setPressedImage(g_oblp)
      b:setDisabledImage(g_oblg)
    end
    b:setSize(224, 28)
	b:setBorderSize(0)
    return b
  end
  
  function menu:addContinueButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    b:setNormalImage(g_continue_n)
    b:setPressedImage(g_continue_p)
    b:setSize(106, 28)
	b:setBorderSize(0)
    return b
  end

  function menu:addHalfButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
	if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
      b:setNormalImage(g_hbsn)
      b:setPressedImage(g_hbsp)
      b:setDisabledImage(g_hbsg)
	else
      b:setNormalImage(g_obsn)
      b:setPressedImage(g_obsp)
      b:setDisabledImage(g_obsg)
    end
    b:setSize(106, 28)
	b:setBorderSize(0)
    return b
  end

  function menu:addImageLeftSliderButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
	  b:setNormalImage(g_hlslider_n)
	  b:setPressedImage(g_hlslider_p)
	  b:setDisabledImage(g_hlslider_d)
	else
	  b:setNormalImage(g_olslider_n)
	  b:setPressedImage(g_olslider_p)
	  b:setDisabledImage(g_olslider_d)
    end
	b:setSize(20, 19)
	b:setBorderSize(0)
    return b
  end
  
  function menu:addImageSlider(min, max, w, h, x, y, mi, bi, callback)
    local b = ImageSlider(min, max)
	-- New Slider Functions
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
		b:setMarkerImage(g_hmarker)
		b:setBackgroundImage(g_hslider)
		b:setDisabledBackgroundImage(g_hslider_d)
    else
		b:setMarkerImage(g_omarker)
		b:setBackgroundImage(g_oslider)
		b:setDisabledBackgroundImage(g_oslider_d)
    end
    b:setSize(w, h)
    b:setActionCallback(function(s) callback(b, s) end)
    self:add(b, x, y)
	b:setBorderSize(0)
    return b
  end
  
  function menu:addImageRightSliderButton(caption, hotkey, x, y, callback)
    local b = self:addImageButton(caption, hotkey, x, y, callback)
    if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
	  b:setNormalImage(g_hrslider_n)
	  b:setPressedImage(g_hrslider_p)
	  b:setDisabledImage(g_hrslider_d)
	else
	  b:setNormalImage(g_orslider_n)
	  b:setPressedImage(g_orslider_p)
	  b:setDisabledImage(g_orslider_d)
    end	  
    b:setSize(20, 19)
	b:setBorderSize(0)
    return b
  end

  function menu:addListBox(x, y, w, h, list)
    local bq = ListBoxWidget(w, h)
    bq:setList(list)
    bq:setBaseColor(black)
    bq:setForegroundColor(clear)
    bq:setBackgroundColor(dark)
    bq:setFont(Fonts["game"])
    self:add(bq, x, y)
    bq.itemslist = list
    return bq
  end
  
  function menu:addImageListBox(x, y, w, h, list)
    local bq = ImageListBoxWidget(w, h)
    bq:setList(list)
    bq:setBaseColor(black)
    bq:setForegroundColor(clear)
    bq:setBackgroundColor(dark)
    bq:setFont(Fonts["game"])
	if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
		bq:setItemImage(g_hibar)
		bq:setUpButtonImage(g_huslider_n)
		bq:setDownButtonImage(g_hdslider_n)
		bq:setLeftButtonImage(g_hlslider_n)
		bq:setRightButtonImage(g_hrslider_n)
		bq:setMarkerImage(g_hmarker)
		bq:setHBarImage(g_hslider)
		bq:setVBarImage(g_hvslider)
	else
		bq:setItemImage(g_oibar)
		bq:setUpButtonImage(g_ouslider_n)
		bq:setDownButtonImage(g_odslider_n)
		bq:setLeftButtonImage(g_olslider_n)
		bq:setRightButtonImage(g_orslider_n)
		bq:setMarkerImage(g_omarker)
		bq:setHBarImage(g_oslider)
		bq:setVBarImage(g_ovslider)
	end

	
	
	
    self:add(bq, x, y)
    bq.itemslist = list
    return bq
  end

  function menu:addBrowser(path, filter, x, y, w, h, default)
    -- Create a list of all dirs and files in a directory
    local function listfiles(path)
      local dirlist = {}
      local i
      local f
      local u = 1

      local dirs = ListDirsInDirectory(path)
      for i,f in ipairs(dirs) do
        dirlist[u] = f .. "/"
        u = u + 1
      end

      local fileslist = ListFilesInDirectory(path)
      for i,f in ipairs(fileslist) do
        if (string.find(f, filter)) then
          dirlist[u] = f
          u = u + 1
        end
      end

      return dirlist
    end

    local bq = self:addImageListBox(x, y, w, h, {})

    if (string.sub(path, string.len(path)) ~= "/") then
      path = path .. "/"
    end
    bq.origpath = path
    bq.actioncb = nil

    -- The directory changed, update the list
    local function updatelist()
      bq.itemslist = listfiles(bq.path)
      if (bq.path ~= bq.origpath) then
        table.insert(bq.itemslist, 1, "../")
      end
      bq:setList(bq.itemslist)
    end

    -- Change to the default directory and select the default file
    if (default == nil) then
      bq.path = path
      updatelist()
    else
      local i
      for i=string.len(default)-1,1,-1 do
        if (string.sub(default, i, i) == "/") then
          bq.path = string.sub(default, 1, i)
          updatelist()

          local f = string.sub(default, i + 1)
          for i=1,table.getn(bq.itemslist) do
            if (bq.itemslist[i] == f) then
              bq:setSelected(i - 1)
            end
          end
          break
        end
      end
    end

    function bq:exists(name)
     for i,v in ipairs(self.itemslist) do
       if(v == name) then
         return true
       end
     end
     return false
    end


    function bq:getSelectedItem()
      if (self:getSelected() < 0) then
        return self.itemslist[1]
      end
      return self.itemslist[self:getSelected() + 1]
    end

    -- If a directory was clicked change dirs
    -- Otherwise call the user's callback
    local function cb(s)
      local f = bq:getSelectedItem()
      if (f == "../") then
        local i
        for i=string.len(bq.path)-1,1,-1 do
          if (string.sub(bq.path, i, i) == "/") then
            bq.path = string.sub(bq.path, 1, i)
            updatelist()
            break
          end
        end
      elseif (string.sub(f, string.len(f)) == '/') then
        bq.path = bq.path .. f
        updatelist()
      else
        if (bq.actioncb ~= nil) then
          bq:actioncb(s)
        end
      end
    end
    bq:setActionCallback(cb)

    bq.oldSetActionCallback = bq.setActionCallback
    function bq:setActionCallback(cb)
      bq.actioncb = cb
    end

    return bq
  end

  function menu:addCheckBox(caption, x, y, callback) --my new function
	local b = ImageCheckBox(caption)
    b:setBaseColor(clear)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
	if (callback ~= nil) then b:setActionCallback(function(s) callback(b, s) end) end
    b:setFont(Fonts["game"])
    self:add(b, x, y)
    return b
  end
  
  function menu:addImageCheckBox(caption, x, y, offi, offi2, oni, oni2, callback) --my new function
	local b = ImageCheckBox(caption)
    b:setBaseColor(clear)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
	-- new functions to display checkbox graphics
	if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
        b:setUncheckedNormalImage(g_hcheckbox_off)
		b:setUncheckedPressedImage(g_hcheckbox_off2)
		b:setCheckedNormalImage(g_hcheckbox_on)
		b:setCheckedPressedImage(g_hcheckbox_on2)
    else
		b:setUncheckedNormalImage(g_ocheckbox_off)
		b:setUncheckedPressedImage(g_ocheckbox_off2)
		b:setCheckedNormalImage(g_ocheckbox_on)
		b:setCheckedPressedImage(g_ocheckbox_on2)
    end
	if (callback ~= nil) then b:setActionCallback(function(s) callback(b, s) end) end
    b:setFont(Fonts["game"])
    self:add(b, x, y)
    return b
  end
  
 function menu:addRadioButton(caption, group, x, y, callback)
    local b = RadioButton(caption, group)
    b:setBaseColor(dark)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
    b:setActionCallback(callback)
    self:add(b, x, y)
    return b
  end
 
 function menu:addImageRadioButton(caption, group, x, y, offi, offi2, oni, oni2, callback)
    local b = ImageRadioButton(caption, group)
    b:setBaseColor(dark)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
	if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
		b:setUncheckedNormalImage(g_hradio_off)
		b:setUncheckedPressedImage(g_hradio_off2)
		b:setCheckedNormalImage(g_hradio_on)
		b:setCheckedPressedImage(g_hradio_on2)
    else
		b:setUncheckedNormalImage(g_oradio_off)
		b:setUncheckedPressedImage(g_oradio_off2)
		b:setCheckedNormalImage(g_oradio_on)
		b:setCheckedPressedImage(g_oradio_on2)
    end
	b:setFont(Fonts["game"])
    b:setActionCallback(callback)
    self:add(b, x, y)
    return b
  end

  function menu:addDropDown(list, x, y, callback)
    local dd = DropDownWidget()
    dd:setFont(Fonts["game"])
    dd:setList(list)
    dd:setActionCallback(function(s) callback(dd, s) end)
    dd:setBaseColor(dark)
    dd:setForegroundColor(clear)
    dd:setBackgroundColor(dark)
    self:add(dd, x, y)
    return dd
  end

  function menu:addTextInputField(text, x, y, w)
    local b = ImageTextField(text)
	if (GetPlayerData(GetThisPlayer(), "RaceName") == "human") then
		b:setItemImage(g_hibar)
	else
		b:setItemImage(g_oibar)
	end
    b:setActionCallback(function() end) --FIXME: remove this?
    b:setFont(Fonts["game"])
    b:setBaseColor(clear)
    b:setForegroundColor(clear)
    b:setBackgroundColor(dark)
    if (w == nil) then w = 100 end
    b:setSize(w, 18)
    self:add(b, x, y)
    return b
  end
end

function WarMenu(title, background, resize)
  local menu
  local exitButton
  local bg
  local bgg

  menu = MenuScreen()

  if background == nil then
    bg = backgroundWidget
  else
    bgg = CGraphic:New(background)
    bgg:Load()
    if (resize == nil or resize == true) then
      bgg:Resize(Video.Width, Video.Height)
    end
    bg = ImageWidget(bgg)
  end
  menu:add(bg, 0, 0)

  AddMenuHelpers(menu)

  if title then
    menu:addLabel(title, Video.Width / 2, Video.Height / 20, Fonts["large"])
  end

  return menu
end

-- Default configurations -------
Widget:setGlobalFont(Fonts["large"])


DefaultObjectives = {_("-Destroy the enemy")}
Objectives = DefaultObjectives


-- Define the different menus ----------

function InitGameSettings()
	local resources = { "gold", "wood", "oil" }
	for i=0, PlayerMax-1 do
		for j = 1,table.getn(resources) do
			SetSpeedResourcesHarvest(i, resources[j], 100)
			SetSpeedResourcesReturn(i, resources[j], 100)
		end
		SetSpeedBuild(i, 100)
		SetSpeedTrain(i, 100)
		SetSpeedUpgrade(i, 100)
		SetSpeedResearch(i, 100)
	end
	GameSettings.NetGameType = 1
	for i=0, PlayerMax-1 do
		GameSettings.Presets[i].PlayerColor = i
		GameSettings.Presets[i].AIScript = _("Map Default")
		GameSettings.Presets[i].Race = -1
		GameSettings.Presets[i].Team = -1
		GameSettings.Presets[i].Type = -1
	end
	GameSettings.Difficulty = -1
	GameSettings.Resources = -1
	GameSettings.NumUnits = -1
	GameSettings.Opponents = -1
	GameSettings.Terrain = -1
	GameSettings.GameType = -1
	GameSettings.NoFogOfWar = false
	GameSettings.RevealMap = 0
	GameSettings.Tileset = nil
	IsSkirmishClassic = false
end
InitGameSettings()

function RunMap(map, objective, fow, revealmap)
  if objective == nil then
    Objectives = DefaultObjectives
  else
    Objectives = objective
  end
  local loop = true
  while (loop) do
    InitGameVariables()
    if fow ~= nil then
      SetFogOfWar(fow)
    end
    if revealmap == true then
       RevealMap()
    end
	if GameSettings.RevealMap == 2 then
      SetFogOfWar(false)
	  RevealMap()
    end
    if GameSettings.RevealMap == 1 then
       RevealMap()
    end
    StartMap(map)
    if GameResult ~= GameRestart then
      loop = false
    else
		StartCustomGame_Lua()
	end
  end
  RunResultsMenu(s)
  InitGameSettings()
  SetDefaultRaceView()
end

function SetDefaultPlayerNames()
-- Add player names according to player color
	for i=0,7 do
		if (GetPlayerData(i, "RaceName") == "human") then
			if (i == 0) then
				SetPlayerData(i, "Name", _("Nation of Stromgarde"))
			elseif (i == 1) then
				SetPlayerData(i, "Name", _("Nation of Azeroth"))
			elseif (i == 2) then
				SetPlayerData(i, "Name", _("Nation of Kul Tiras"))
			elseif (i == 3) then
				SetPlayerData(i, "Name", _("Nation of Dalaran"))
			elseif (i == 4) then
				SetPlayerData(i, "Name", _("Nation of Alterac"))
			elseif (i == 5) then
				SetPlayerData(i, "Name", _("Nation of Gilneas"))
			elseif (i == 6) then
				SetPlayerData(i, "Name", _("Nation of Lordaeron"))
			elseif (i == 7) then
				SetPlayerData(i, "Name", _("Alliance Traitors"))
			end
		elseif  (GetPlayerData(i, "RaceName") == "orc") then
			if (i == 0) then
				SetPlayerData(i, "Name", _("Blackrock Clan"))
			elseif (i == 1) then
				SetPlayerData(i, "Name", _("Stormreaver Clan"))
			elseif (i == 2) then
				SetPlayerData(i, "Name", _("Bleeding Hollow Clan"))
			elseif (i == 3) then
				SetPlayerData(i, "Name", _("Twilight's Hammer Clan"))
			elseif (i == 4) then
				SetPlayerData(i, "Name", _("Burning Blade Clan"))
			elseif (i == 5) then
				SetPlayerData(i, "Name", _("Black Tooth Grin Clan"))
			elseif (i == 6) then
				SetPlayerData(i, "Name", _("Dragonmaw Clan"))
			elseif (i == 7) then
				SetPlayerData(i, "Name", _("Laughing Skull Clan"))
			end
		end
	end
end

mapname = "maps/skirmish/(2)timeless-isle.smp.gz"
local buttonStatut = 0 -- 0:not initialised, 1: Ok, 2: Cancel
mapinfo = {
  playertypes = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil},
  playerais = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil},
  playerrace = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil},
  description = "",
  nplayers = 1,
  w = 32,
  h = 32,
  id = 0
}

function GetMapInfo(mapname)
  local OldDefinePlayerTypes = DefinePlayerTypes
  local OldPresentMap = PresentMap
  local OldSetAiType = SetAiType
  local OldSetStartView = SetStartView
  local OldSetPlayerData = SetPlayerData
  local OldLoadTileModels = LoadTileModels
  local OldSetTile = SetTile
  local OldCreateUnit = CreateUnit
  local OldSetResourcesHeld = SetResourcesHeld

  mapinfo.playerais = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
  mapinfo.playerrace = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
  function DefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
    mapinfo.playertypes[1] = p1
    mapinfo.playertypes[2] = p2
    mapinfo.playertypes[3] = p3
    mapinfo.playertypes[4] = p4
    mapinfo.playertypes[5] = p5
    mapinfo.playertypes[6] = p6
    mapinfo.playertypes[7] = p7
    mapinfo.playertypes[8] = p8
    mapinfo.playertypes[9] = p9
    mapinfo.playertypes[10] = p10
    mapinfo.playertypes[11] = p11
    mapinfo.playertypes[12] = p12
    mapinfo.playertypes[13] = p13
    mapinfo.playertypes[14] = p14
    mapinfo.playertypes[15] = p15
    mapinfo.nplayers = 0
    for i=0,15 do
      local t = mapinfo.playertypes[i]
	  if (t~= nil) then
		  if (t == "person" or t == "computer") then
			mapinfo.nplayers = mapinfo.nplayers + 1
		  end
	  end
    end
  end

  function PresentMap(description, nplayers, w, h, id)
    mapinfo.description = description
    -- nplayers includes rescue-passive and rescue-active
    -- calculate the real nplayers in DefinePlayerTypes
    --mapinfo.nplayers = nplayers
    mapinfo.w = w
    mapinfo.h = h
    mapinfo.id = id
  end

  Load(mapname)

  DefinePlayerTypes = OldDefinePlayerTypes
  PresentMap = OldPresentMap
end

function RunSelectScenarioMenu()
  buttonStatut = 0
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel(_("Select scenario"), 176, 8)

  local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$",
    24, 140, 300, 108, mapname)

  local l = menu:addLabel(browser:getSelectedItem(), 24, 260, Fonts["game"], false)

  local function cb(s)
    l:setCaption(browser:getSelectedItem())
    l:adjustSize()
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!OK", "o", 48, 318,
    function()
      local cap = l:getCaption()

      if (browser:getSelected() < 0) then
        return
      end
      buttonStatut = 1
      mapname = browser.path .. cap
      menu:stop()
    end)
  menu:addHalfButton(_("~!Cancel"), "c", 198, 318,
    function() buttonStatut = 2; menu:stop() end)

  menu:run()
end

function RunSinglePlayerTypeMenu()

  wargus.playlist = { "music/Main Menu" .. wargus.music_extension }
  SetDefaultRaceView()

  if not (IsMusicPlaying()) then
    PlayMusic("music/Main Menu" .. wargus.music_extension)
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  if (wargus.tales == false) then
    menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"])
  end
  menu:addLabel(_("~<Single Player~>"), offx + 320, offy + 212 - 25)
  local buttonNewMap =
  menu:addFullButton(_("~!Standard Game"), "s", offx + 208, offy + 104 + 36*3,
    function() RunSinglePlayerGameModeMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Campaign Game"), "c", offx + 208, offy + 104 + 36*4,
    function() RunModCampaignGameMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Load Game"), "l", offx + 208, offy + 104 + 36*5,
    function() RunLoadGameMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Previous Menu"), "p", offx + 208, offy + 104 + 36*6,
    function() menu:stop() end)
  return menu:run()
end

function RunSinglePlayerGameModeMenu()

  buttonStatut = 0
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel(_("Standard Game"), 176, 8)

  local browser = menu:addBrowser("maps/list/", "", 24, (24+8+8), (300+5), (318-24-8-8-24))

  menu:addHalfButton("~!OK", "o", 48, 318,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      Load(browser.path .. browser:getSelectedItem())
      menu:stop()
    end)
  menu:addHalfButton(_("~!Cancel"), "c", 198, 318,
    function() buttonStatut = 2; menu:stop(1); RunSinglePlayerTypeMenu() end)

  menu:run()

end

function RunSinglePlayerGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local d
  local race
  local resources
  local opponents
  local numunits
  local gametype
  local mapl
  local descriptionl
  local tilesetdd
  
  -- Setup variables
  local nameslist = {"1:","2:","3:","4:","5:","6:","7:","8:","9:","10:","11:","12:","13:","14:","15:"}
  local colorlist = {_("~red~Red"),_("~blue~Blue"),_("~green~Green"),_("~violet~Violet"),_("~orange~Orange"),_("~black~Black"),
	_("~white~White"),_("~yellow~Yellow")}
  local sidelist = {_("Map Default"), _("Human"),_("Orc"),_("Random")}
  local teamlist = {"-","1","2","3","4"}
  local playerlist = {_("Player"),_("Computer"),_("Rescue-passive"),_("Rescue-active"),_("None")}
  local reveal_list = {_("Default"),_("Explored"),_("Revealed")}
  local game_types = {_("Use map settings"), _("Melee"), _("Free for all"), _("Top vs bottom"), _("Left vs right"), _("Man vs Machine")}
  local tileset_names = {_("Map Default"), _("Summer"), _("Swamp"), _("Wasteland"), _("Winter")}
  local numunit_types = {_("Map Default"), _("One Peasant Only")}
  local difficulty_types = {_("Easy"), _("Normal"), _("Hard"),_("Nightmare"),_("Hell")}
  local resource_types = {_("Map Default"), _("High"), _("Medium"), _("Low"),_("Quick Start")}
  local nms = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
  local pcolor = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
  local ptype = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
  local paitype = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
  local pside = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
  local teams = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
  local rescount = nil
  local game_type = nil
  local difficulty = nil
  local max_score = nil
  local reveal_type = nil

  -- Logo
  menu:addLabel(_("~<Single Player Game Setup~>"), offx + 640/2 + 12, offy + 35)
  -- Copyright information.
  if (wargus.tales == false) then
    menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"])
  end
  
  -- Error handling function
  function ErrorMessage(errmsg)
	  local menu = WarMenu(nil, panel(4), false)
	  menu:setSize(288, 128)
	  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
	  menu:setDrawMenusUnder(true)

	  menu:addLabel(_("Error:"), 144, 11)

	  local l = MultiLineLabel(errmsg)
	  l:setFont(Fonts["large"])
	  l:setAlignment(MultiLineLabel.CENTER)
	  l:setVerticalAlignment(MultiLineLabel.CENTER)
	  l:setLineWidth(270)
	  l:setWidth(270)
	  l:setHeight(41)
	  l:setBackgroundColor(dark)
	  menu:add(l, 9, 38)

	  menu:addHalfButton("~!OK", "o", 92, 80, function() menu:stop() end)

	  menu:run()
  end 
  
  -- Check for correct data before start
  function CheckCorrect()
	local firstTeam=0
	local firstTeam2=0
	--Team Check
	for i=0,15 do
		if teams[i+1]~=nil then
			if teams[i+1]:isVisible() and teams[i+1]:getSelected()~=0 then
				firstTeam = teams[i+1]:getSelected()
				break
			elseif teams[i+1]:getSelected()==0 then
				firstTeam = -1
				firstTeam2 = i
				break
			end
		end
	end
	if firstTeam > -1 then
		for j=firstTeam2+1,15 do
			if teams[j+1]~=nil then
				if teams[j+1]:isVisible() and teams[j+1]:getSelected()~=firstTeam then
					break
				elseif j==15 then
					return 1 -- only 1 team
				end
			end
		end
	end
	--PlayerCheck
	local personcount = 0
	local compcount = 0
	for i=0,15 do
		if ptype[i+1]~=nil then
			if ptype[i+1]:isVisible() and ptype[i+1]:getSelected()==0 then
				personcount = personcount + 1
			elseif ptype[i+1]:isVisible() and ptype[i+1]:getSelected()==1 then
				compcount = compcount + 1
			end
		end
	end
	if compcount == 0 and personcount == 0 then
		return 2 -- no players or computers
	elseif compcount>0 and personcount == 0 then
		return 3 -- only computers and no player
	elseif compcount+personcount < 2 then
		return 4 -- only one player
	end
	--Success 
	return 0
  end
  
  if mapname == nil then
	mapname = "maps/skirmish/(2)timeless-isle.sms.gz"
  end
  
  menu:addLabel(_("Scenario:"), offx + 16, offy + 360, Fonts["game"], false)
  mapl = menu:addLabel(string.sub(mapname, 6), offx + 16, offy + 360 + 24, Fonts["game"], false)
  descriptionl = menu:addLabel("descriptionl", offx + 16 + 70, offy + 360, Fonts["game"], false)

  
  menu:addFullButton(_("S~!elect Scenario"), "e", offx + 640 - 224 - 16, offy + 360 + 36*0,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)
  menu:addFullButton(_("~!Start Game"), "s", offx + 640 - 224 - 16, offy + 360 + 36*1,
    function()
      local tilesetFilename = {nil, "summer.lua", "swamp.lua", "wasteland.lua", "winter.lua"}
	  InitGameSettings()
		local errorlevel = CheckCorrect()
		if errorlevel==1 then
			ErrorMessage(_("Need more than 1 team"))
		elseif errorlevel==2 then
			ErrorMessage(_("No players selected"))
		elseif errorlevel==3 then
			ErrorMessage(_("Need at least 1 person player"))
		elseif errorlevel==4 then
			ErrorMessage(_("Need at least 2 players"))
		else
			local wefoundperson = false
			for i=0,14 do
				if pside[i+1]==nil then
					GameSettings.Presets[i].Race = 0
				elseif (pside[i+1]:getSelected() == 3) then
					GameSettings.Presets[i].Race = math.random(0, 1)
				else
					GameSettings.Presets[i].Race = pside[i+1]:getSelected()
				end
				if teams[i+1]==nil then
					GameSettings.Presets[i].Team = -1
				else
					GameSettings.Presets[i].Team = teams[i+1]:getSelected()
				end
				if ptype[i+1]==nil then
					GameSettings.Presets[i].Type = -1
				elseif ptype[i+1]:getSelected()==0 then
					if wefoundperson == false then
						wefoundperson = true
						GameSettings.Presets[i].Type = PlayerPerson
					else
						GameSettings.Presets[i].Type = PlayerComputer
					end
				elseif ptype[i+1]:getSelected()==1 then
					GameSettings.Presets[i].Type = PlayerComputer
				elseif ptype[i+1]:getSelected()==2 then
					GameSettings.Presets[i].Type = PlayerRescuePassive
				elseif ptype[i+1]:getSelected()==3 then
					GameSettings.Presets[i].Type = PlayerRescueActive
				elseif ptype[i+1]:getSelected()==4 then
					GameSettings.Presets[i].Type = -1
				end
				if pcolor[i+1]==nil then
					GameSettings.Presets[i].PlayerColor = i
				else
					GameSettings.Presets[i].PlayerColor = pcolor[i+1]:getSelected()
				end
				if paitype[i+1] ~= nil and paitype[i+1]:getSelected() > 0 then
					GameSettings.Presets[i].AIScript = AIStrategyTypes[paitype[i+1]:getSelected() + 1]
				end
			end
			GameSettings.Difficulty = difficulty:getSelected() + 1
			GameSettings.GameType = game_type:getSelected()
			GameSettings.Resources = rescount:getSelected()
			GameSettings.RevealMap = reveal_type:getSelected()
			GameSettings.NumUnits = numunits:getSelected()
			GameSettings.Tileset = tilesetFilename[tilesetdd:getSelected() + 1]
			GameSettings.NetGameType = 1
			Load(mapname)
			RunMap(mapname)
			menu:stop()
		end
    end)
	
  -- Player redrawing function
  function PlayersRedraw()
	local offset=0
	  for i=0,15 do
		if nms[i+1]~=nil then
			nms[i+1]:setVisible(false)
		end
		if ptype[i+1]~=nil then
			ptype[i+1]:setVisible(false)
		end
		if pside[i+1]~=nil then
			pside[i+1]:setVisible(false)
		end
		if pcolor[i+1]~=nil then
			pcolor[i+1]:setVisible(false)
		end
		if teams[i+1]~=nil then
			teams[i+1]:setVisible(false)
		end
		if paitype[i+1]~=nil then
			paitype[i+1]:setVisible(false)
		end
	  end
	  for i=0,15 do
	    if mapinfo.playertypes[i+1] ~= "nobody" and mapinfo.playertypes[i+1] ~= nil then
		  nms[i+1] = menu:addLabel(nameslist[i+1], offx + 2 , offy + 80+offset+15,Fonts["game"], false)
		  offset=offset+25
	    end
	  end
	  offset=0
	  menu:addLabel(_("~<Color:~>"), offx+25, offy +10+60,Fonts["game"], false)
	  for i=0,15 do
	    if mapinfo.playertypes[i+1] ~= "nobody" and mapinfo.playertypes[i+1] ~= nil then
		  pcolor[i+1] = menu:addDropDown(colorlist, offx + 20, offy + 10 + 80+ offset, function(dd) end)
		  if (i > 7) then
		    pcolor[i+1]:setSelected(i-8)
		  else
		    pcolor[i+1]:setSelected(i)
		  end
		  pcolor[i+1]:setSize(60, 20)
		  pcolor[i+1]:setActionCallback(
		  function()
		  	sk_pcolor[i+1] = pcolor[i+1]:getSelected()
		  end)
		  if sk_pcolor[i+1]~=-1 then
			pcolor[i+1]:setSelected(sk_pcolor[i+1])
		  end
		  offset=offset+25
	    end
	  end
	  offset=0
	  menu:addLabel(_("~<Type:~>"), offx+100, offy +10+60,Fonts["game"], false)
	  for i=0,15 do
		if mapinfo.playertypes[i+1] ~= "nobody" and mapinfo.playertypes[i+1] ~= nil  then
			ptype[i+1] = menu:addDropDown(playerlist, offx + 85, offy + 10 + 80+ offset, function(dd) end)
			if mapinfo.playertypes[i+1] == "computer" then
				ptype[i+1]:setSelected(1)
			elseif mapinfo.playertypes[i+1] == "rescue-passive" then
				ptype[i+1]:setSelected(2)
			elseif mapinfo.playertypes[i+1] == "rescue-active" then
				ptype[i+1]:setSelected(3)
			end
			ptype[i+1]:setSize(80, 20)
			ptype[i+1]:setActionCallback(
			function()
				sk_ptype[i+1] = ptype[i+1]:getSelected()
			end)
			if sk_ptype[i+1]~=-1 then
				ptype[i+1]:setSelected(sk_ptype[i+1])
			end
			offset=offset+25
		end
	  end
	  offset=0
	  menu:addLabel(_("~<Race:~>"), offx+170, offy +10+60,Fonts["game"], false)
	  for i=0,15 do
		if mapinfo.playertypes[i+1] ~= "nobody" and mapinfo.playertypes[i+1] ~= nil  then
		pside[i+1] = menu:addDropDown(sidelist, offx + 170, offy + 10 + 80+ offset, function(dd) end)
		if mapinfo.playerrace[i+1] == "human" then
			pside[i+1]:setSelected(1)
		elseif mapinfo.playerrace[i+1] == "orc" then
			pside[i+1]:setSelected(2)
		end
		pside[i+1]:setSize(70, 20)
		pside[i+1]:setActionCallback(
		function()
			sk_pside[i+1] = pside[i+1]:getSelected()
		end)
		if sk_pside[i+1]~=-1 then
			pside[i+1]:setSelected(sk_pside[i+1])
		end
		offset=offset+25
		end
	  end
	  offset=0
	  menu:addLabel(_("~<Teams:~>"), offx+238, offy +10+60,Fonts["game"], false)
	  for i=0,15 do
		if mapinfo.playertypes[i+1] ~= "nobody" and mapinfo.playertypes[i+1] ~= nil  then
		teams[i+1] = menu:addDropDown(teamlist, offx + 245, offy + 10 + 80 +offset, function(dd) end)
		teams[i+1]:setSize(40, 20)
		teams[i+1]:setActionCallback(
		function()
			sk_teams[i+1] = teams[i+1]:getSelected()
		end)
		if sk_teams[i+1]~=-1 then
			teams[i+1]:setSelected(sk_teams[i+1])
		end
		offset=offset+25
		end
	  end
	  offset=0
	  menu:addLabel(_("~<AI Script:~>"), offx+320, offy +10+60,Fonts["game"], false)
	  for i=0,15 do
		if mapinfo.playertypes[i+1] ~= "nobody" and mapinfo.playertypes[i+1] ~= nil  then
		paitype[i+1] = menu:addDropDown(AIStrategyTypes, offx + 290, offy + 10 + 80 +offset, function(dd) end)
		for cc = 1, table.getn(AIStrategyTypes) do
			if mapinfo.playerais[i+1] == AIStrategyTypes[cc] then
				
				paitype[i+1]:setSelected(cc-1)
				break
			end
		end
		paitype[i+1]:setSize(130, 20)
		paitype[i+1]:setActionCallback(
		function()
			sk_paitype[i+1] = paitype[i+1]:getSelected()
		end)
		if sk_paitype[i+1]~=-1 then
			paitype[i+1]:setSelected(sk_paitype[i+1])
		end
		offset=offset+25
		end
	  end
	  
	  for i=0,15 do
		if mapinfo.playertypes[i+1] == "nobody" or mapinfo.playertypes[i+1] == nil then
			if nms[i+1] ~= nil then
				nms[i+1]:setVisible(false) 
			end
			if pcolor[i+1] ~= nil then
				pcolor[i+1]:setVisible(false) 
			end
			if ptype[i+1] ~= nil then
				ptype[i+1]:setVisible(false) 
				ptype[i+1]:setSelected(2)
			end
			if pside[i+1] ~= nil then
				pside[i+1]:setVisible(false) 
			end
			if teams[i+1] ~= nil then
				teams[i+1]:setVisible(false) 
			end
			if paitype[i+1] ~= nil then
				paitype[i+1]:setVisible(false) 
			end
		end
	  end
  end
  
  menu:addFullButton(_("~!Cancel Game"), "c", offx + 640 - 224 - 16, offy + 360 + 36*2, function()  menu:stop(1); RunSinglePlayerTypeMenu() end)

  menu:addLabel(_("~<Fog of War:~>"), offx + 450, offy + 74, Fonts["game"], false)
  reveal_type = menu:addDropDown(reveal_list, offx + 450, offy + 90,
    function(dd) end)
  reveal_type:setSize(170, 20)
  reveal_type:setActionCallback(
	function()
		sk_reveal_type = reveal_type:getSelected()
	end)
	if sk_reveal_type~=-1 then
		reveal_type:setSelected(sk_reveal_type)
	end

  menu:addLabel(_("~<Game Type:~>"), offx + 450, offy + 114, Fonts["game"], false)
  game_type = menu:addDropDown(game_types, offx + 450, offy + 130,
   function(dd) TimerRedraw() end)
  game_type:setSize(170, 20)
  game_type:setActionCallback(
	function()
		sk_game_type = game_type:getSelected()
	end)
	if sk_game_type~=-1 then
		game_type:setSelected(sk_game_type)
	end

  menu:addLabel(_("~<Resources:~>"), offx + 450, offy + 154, Fonts["game"], false)
  rescount = menu:addDropDown(resource_types, offx + 450, offy + 170,
    function(dd) end)
  rescount:setSize(170, 20)
  rescount:setActionCallback(
	function()
		sk_rescount = rescount:getSelected()
	end)
	if sk_rescount~=-1 then
		rescount:setSelected(sk_rescount)
	end

  menu:addLabel(_("~<AI Difficulty:~>"), offx + 450, offy + 194, Fonts["game"], false)
  difficulty = menu:addDropDown(difficulty_types, offx + 450, offy + 210,
    function(dd) end)
  difficulty:setSize(170, 20)
  difficulty:setSelected(2)
  difficulty:setActionCallback(
	function()
		sk_difficulty = difficulty:getSelected()
	end)
	if sk_difficulty~=-1 then
		difficulty:setSelected(sk_difficulty)
	end

  menu:addLabel(_("~<Tileset:~>"), offx + 450, offy + 234, Fonts["game"], false)
  tilesetdd = menu:addDropDown(tileset_names, offx + 450, offy + 250,
    function(dd) end)
  tilesetdd:setSize(170, 20)
  tilesetdd:setActionCallback(
	function()
		sk_tileset = tilesetdd:getSelected()
	end)
	if sk_tileset~=-1 then
		tilesetdd:setSelected(sk_tileset)
	end
  menu:addLabel(_("~<Units:~>"), offx + 450, offy + 274, Fonts["game"], false)
  numunits = menu:addDropDown(numunit_types, offx + 450, offy + 290,
    function(dd) end)
  numunits:setSize(170, 20)
  numunits:setActionCallback(
	function()
		sk_numunits = numunits:getSelected()
	end)
	if sk_numunits~=-1 then
		numunits:setSelected(sk_numunits)
	end

  function MapChanged()
    mapl:setCaption(string.sub(mapname, 6))
    mapl:adjustSize()

    descriptionl:setCaption(mapinfo.description ..
      " (" .. mapinfo.w .. " x " .. mapinfo.h .. ")")
    descriptionl:adjustSize()

    PlayersRedraw()
  end

  GetMapInfo(mapname)
  MapChanged()

  menu:run()
end

function BuildProgramStartMenu()
  wargus.playlist = { "music/Main Menu" .. wargus.music_extension }
  SetDefaultRaceView()

  if not (IsMusicPlaying()) then
    PlayMusic("music/Main Menu" .. wargus.music_extension)
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  
  --menu:addLabel(wargus.Name .. " V" .. wargus.Version .. "  " .. wargus.Homepage, offx + 320, offy + 390 + 18*0)
  --menu:addLabel("Stratagus V" .. GetStratagusVersion() .. "  " .. GetStratagusHomepage(), offx + 320, offy + 390 + 18*1)
  --menu:addLabel(wargus.Copyright, offx + 320, offy + 390 + 18*4)

  if (wargus.tales == false) then
    menu:addLabel(wargus.Name .. _(" V") .. wargus.Version .. ", " .. wargus.Copyright, offx + 320, (Video.Height - 90) + 18*4, Fonts["small"])
  end
  
  menu:addFullButton(_("~!Single Player Game"), "s", offx + 208, offy + 104 + 36*0,
    function() RunSinglePlayerTypeMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Multi Player Game"), "m", offx + 208, offy + 104 + 36*1,
    function() RunMultiPlayerGameMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Replay Game"), "r", offx + 208, offy + 104 + 36*2,
    function() RunReplayGameMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Options"), "o", offx + 208, offy + 104 + 36*3,
    function() RunGameOptionsMenu(); menu:stop(1) end)
  menu:addFullButton(_("~!Load Mod"), "l", offx + 208, offy + 104 + 36*4,
    function() RunLoadModMenu(); menu:stop(1) end)
  menu:addFullButton(_("Map ~!Editor"), "e", offx + 208, offy + 104 + 36*5,
    function() RunEditorMenu(); menu:stop(1) end)
  menu:addFullButton(_("S~!how Credits"), "h", offx + 208, offy + 104 + 36*6, RunShowCreditsMenu)

  menu:addFullButton(_("E~!xit Program"), "x", offx + 208, offy + 104 + 36*7,
    function() menu:stop() end)
	
  return menu:run()
end

LoadGameFile = nil

function RunProgramStartMenu()
  local continue = 1

  while continue == 1 do
    if (LoadGameFile ~= nil) then
      LoadGame(LoadGameFile)
    else
      continue = BuildProgramStartMenu(menu)
    end
  end
end

function RunLoadModMenu()
  buttonStatut = 0
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel(_("Load Mod"), 176, 8)
  
  local browser = menu:addBrowser("mods/list/", "", 24, (24+8+8), (300+5), (318-24-8-8-24))

  menu:addHalfButton("~!OK", "o", 48, 318,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      Load(browser.path .. browser:getSelectedItem())
      menu:stop()
    end)
  menu:addHalfButton(_("~!Cancel"), "c", 198, 318,
    function() buttonStatut = 2; menu:stop() end)

  menu:run()
end

function RunModCampaignGameMenu()
  buttonStatut = 0
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352, 352)
  menu:setPosition((Video.Width - 352) / 2, (Video.Height - 352) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel(_("Campaign Game"), 176, 8)

  local browser = menu:addBrowser("campaigns/list/", "", 24, (24+8+8), (300+5), (318-24-8-8-24))

  menu:addHalfButton(_("~!OK"), "o", 48, 318,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      Load(browser.path .. browser:getSelectedItem())
      menu:stop()
    end)
  menu:addHalfButton(_("~!Cancel"), "c", 198, 318,
    function() buttonStatut = 2; menu:stop(1); RunSinglePlayerTypeMenu() end)

  menu:run()
end

Load("scripts/menus/campaign.lua")
Load("scripts/menus/load.lua")
Load("scripts/menus/save.lua")
Load("scripts/menus/replay.lua")
Load("scripts/menus/options.lua")
Load("scripts/menus/editor.lua")
Load("scripts/menus/credits.lua")
Load("scripts/menus/game.lua")
Load("scripts/menus/help.lua")
Load("scripts/menus/objectives.lua")
Load("scripts/menus/endscenario.lua")
Load("scripts/menus/diplomacy.lua")
Load("scripts/menus/results.lua")
Load("scripts/menus/network.lua")
Load("scripts/menus/metaserver.lua")

function GameStarting()
  if (wc2.preferences.ShowTips and not IsReplayGame()) then
    SetGamePaused(true)
    RunTipsMenu()
  end
  if GameSettings.NetGameType == 1 then
		if GameSettings.GameType==0 or GameSettings.GameType==1 then
			for plrs=0,14 do
				for plrs2=0,14 do
					if plrs==plrs2 then
					else
						if GameSettings.Presets[plrs].Team == -1 then
						elseif GameSettings.Presets[plrs].Team == 0 then
							if GameSettings.Presets[plrs].Type == PlayerComputer and GameSettings.Presets[plrs2].Type == PlayerComputer then
								SetDiplomacy(plrs, "allied" , plrs2)
								SetSharedVision(plrs, true, plrs2)
							else
								SetDiplomacy(plrs, "enemy" , plrs2)
								SetSharedVision(plrs, false, plrs2)
							end
						else
							if GameSettings.Presets[plrs].Team == GameSettings.Presets[plrs2].Team then
								SetDiplomacy(plrs, "allied" , plrs2)
								SetSharedVision(plrs, true, plrs2)
							else
								SetDiplomacy(plrs, "enemy" , plrs2)
								SetSharedVision(plrs, false, plrs2)
							end
						end
					end
				end
			end
		end
	end
end

if (Editor.Running == EditorCommandLine) then
  if (CliMapName and CliMapName ~= "") then
    StartEditor(CliMapName)
  else
    RunEditorMenu()
  end
else
  if (CliMapName and CliMapName ~= "") then
    RunMap(CliMapName)
  else
    RunProgramStartMenu()
  end
end