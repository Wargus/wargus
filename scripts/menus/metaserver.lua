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
--      (c) Copyright 2013 by cybermind
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

function RunMetaServerMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local nick

  menu:addLabel(_("~<Metaserver~>"), offx + 640/2 + 12, offy + 192)
  local msgs = ""
  local numplayers_text = MultiLineLabel(msgs)
  numplayers_text:setFont(Fonts["game"])
  numplayers_text:setAlignment(MultiLineLabel.LEFT)
  numplayers_text:setVerticalAlignment(MultiLineLabel.TOP)
  numplayers_text:setLineWidth(270)
  numplayers_text:setWidth(270)
  numplayers_text:setHeight(41)
  numplayers_text:setBackgroundColor(dark)
  menu:add(numplayers_text, 9, 38)
  nick = menu:addTextInputField("", offx + 298, 260 + offy)
  
  menu:addFullButton(_("~!Send"), "s", 208 + offx, 320 + (36 * 1) + offy,
    function()
		MetaClient:Send(tostring(nick:getText()))
		local reply
		local n = MetaClient:Recv()
		print(n)
		if (n ~= -1) then
			reply = MetaClient:GetLastMessage()
			msgs = msgs .. reply.entry
			numplayers_text:setCaption(msgs)
			numplayers_text:adjustSize()
		end
	end)
  local function UpdateMessages()
	
  end

  menu:addFullButton(_("~!Clear"), "m", 208 + offx, 320 + (36 * 2) + offy,
    function() msgs = ""; numplayers_text:setCaption(msgs)  end)
  menu:addFullButton(_("~!Main Menu"), "m", 208 + offx, 320 + (36 * 3) + offy,
    function()  menu:stopAll() end)
--[[
  local listener = LuaActionListener(
	function(s)
		updateStartButton(UpdateMessages())
	end)
	menu:addLogicCallback(listener)]]
  menu:run()
  MetaClient:Close()

end

function RunJoiningMetaServerMenuDirect()
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel(_("Enter meta server address:"), 144, 11)
  local server = menu:addTextInputField(wc2.preferences.MetaServer..":"..tostring(wc2.preferences.MetaPort), 40, 38, 212)
  local conn_label = menu:addLabel(_("Connecting..."), 40, 60, Fonts["game"], false)
  conn_label:setVisible(false)

  local ok_button = menu:addHalfButton("~!OK", "o", 24, 80, function(s) end)
  local cancel_button = menu:addHalfButton(_("Cancel (~<Esc~>)"), "escape", 154, 80, function() menu:stop() end)
  ok_button:setActionCallback(
  function(s)
		print(tostring(string.len(server:getText())))
		if string.len(server:getText()) > 0 then
			conn_label:setVisible(true)
			conn_label:setCaption(_("Connecting..."))
			conn_label:adjustSize()
			local ip = string.find(server:getText(), ":")
			if ip ~= nil then
				wc2.preferences.MetaServer = string.sub(server:getText(), 1, ip - 1)
				wc2.preferences.MetaPort = tonumber(string.sub(server:getText(), ip + 1))
				if (wc2.preferences.MetaPort == 0) then wc2.preferences.MetaPort = 7775 end
				print(wc2.preferences.MetaServer.." "..tostring(wc2.preferences.MetaPort))
			else
				wc2.preferences.MetaServer = string.sub(server:getText(), 1)
				wc2.preferences.MetaPort = 7775
			end
			ok_button:setEnabled(false)
			cancel_button:setEnabled(false)
			MetaClient:SetMetaServer(wc2.preferences.MetaServer, wc2.preferences.MetaPort)
			if (MetaClient:Init() == -1) then
				conn_label:setCaption(_("Unable to connect"))
				conn_label:adjustSize()
				ok_button:setEnabled(true)
				cancel_button:setEnabled(true)
			else
				-- connected
				RunMetaServerMenu()
				menu:stop(0)
			end
			
		end	  
    end
	)

  menu:run()
end

