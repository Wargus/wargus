function RunSaveMenu()
  local menu = WarGameMenu(panel(3))
  menu:resize(384, 256)

  menu:addLabel("Save Game", 384 / 2, 11)

  local t = menu:addTextInputField("game.sav",
    (384 - 300 - 18) / 2, 11 + 36, 318)

  local browser = menu:addBrowser("~save", ".sav.gz$",
    (384 - 300 - 18) / 2, 11 + 36 + 22, 318, 126)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (384 / 3) - 106 - 10, 256 - 16 - 27,
    -- FIXME: use a confirm menu if the file exists already
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- strip .gz
      if (string.find(name, ".gz$") ~= nil) then
        name = string.sub(name, 1, string.len(name) - 3)
      end
      -- append .sav
      if (string.find(name, ".sav$") == nil) then
        name = name .. ".sav"
      end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      SaveGame(name)
      UI.StatusLine:Set("Saved game to: " .. name)
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (384 / 3) - 106 - 10, 256 - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

