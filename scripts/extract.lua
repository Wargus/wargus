-- TODO: This is unfinished!
-- This file is meant to allow GUI driven extraction of the game data within the Guichan GUI.
-- This will give each game the flexibility to drive extraction however it pleases.
-- Important questions are how to expose the system-level Lua->C functions only during extraction.

local ARGS=...

local width = 640
local height = 480

SetVideoResolution(width, height)

local i
local yellow = CFontColor:New("yellow")
for i=0,6,1 do
    yellow.Colors[i] = CColor(224, 244, 32)
end
local white = CFontColor:New("white")
for i=0,6,1 do
    white.Colors[i] = CColor(255, 255, 255)
end
UI.NormalFontColor = "yellow"
UI.ReverseFontColor = "white"
SetDefaultTextColors(UI.NormalFontColor, UI.ReverseFontColor)
SetGameSpeed(75)

DefineCursor({
    Name = "cursor-point",
    Race = "any",
    File = "contrib/cross.png",
    HotSpot = {15, 15},
    Size = {32, 32}
})

local font = CFont:New("small", CGraphic:New("contrib/6x12_espruino.png", 6, 12))
font = CFont:New("game", CGraphic:New("contrib/6x12_espruino.png", 6, 12))

local dark = Color(38, 38, 78)
local black = Color(0, 0, 0)
local clear = Color(99, 99, 99)

function RunExtraction()
    local function MakeLabel(txt)
        local label = Label(txt)
        label:setFont(font)
        label:adjustSize()
        return label    
    end
    
    local function MakeButton(txt, hotkey, callback)
        local btn = ButtonWidget(txt)
        btn:setFont(font)
        btn:setHotKey(hotkey)
        btn:setActionCallback(callback)
        btn:setSize(200, 24)
        btn:setBackgroundColor(dark)
        btn:setBaseColor(dark)
        btn:setBorderSize(0)
        return btn
    end
    
    local function MakeFileBrowser(menu, filter)
        -- Create a list of all dirs and files in a directory
        local function listfiles(path)
            local dirlist = {}
            local i
            local f

            for i,f in ipairs(ListFilesystem(path)) do
                dirlist[#dirlist + 1] = f
            end
            
            return dirlist
        end

        local bq = ListBoxWidget(width * 0.9, height * 0.6)
        bq.itemslist = {}
        bq:setList(bq.itemslist)
        bq:setBaseColor(black)
        bq:setForegroundColor(clear)
        bq:setBackgroundColor(dark)
        bq:setFont(font)
        menu:add(bq, width * 0.1 / 2, height * 0.4 / 2)

        local fbLabel = MakeLabel("Current path: ")
        menu:add(fbLabel, width * 0.1, height * 0.4 / 2 - fbLabel:getHeight() * 2)

        local filterNames = "Filter: "
        for i,f in ipairs(filter) do
            filterNames = filterNames .. " " .. f
        end
        local filterLabel = MakeLabel(filterNames)
        menu:add(filterLabel, width * 0.1, height * 0.4 / 2 - filterLabel:getHeight())

        -- The directory changed, update the list
        local function updatelist()
            fbLabel:setCaption("Current path: " .. bq.path)
            fbLabel:adjustSize()

            local entries = listfiles(bq.path)
            bq.itemslist = {}

            for i,entry in ipairs(entries) do
                if entry:sub(#entry) == "/" then
                    bq.itemslist[#bq.itemslist + 1] = entry
                end
                for j,pattern in ipairs(filter) do
                    if entry:find(pattern) ~= nil then
                        bq.itemslist[#bq.itemslist + 1] = entry
                    end
                end
            end

            if bq.path ~= "/" then
                table.insert(bq.itemslist, 1, "../")
            end

            local displaylist = {}
            for i,path in ipairs(bq.itemslist) do
                displaylist[i] = bq.itemslist[i]:gsub(bq.path, "", 1)
            end
            bq:setList(displaylist)
        end

        local function parentPath(p)
            local i
            if #p == 3 and p:sub(2,2) == ":" and p:sub(3,3) == "/" then
                -- windows drive letter
                return "/"
            end

            for i=string.len(p)-1,1,-1 do
                if (string.sub(p, i, i) == "/") then
                    return string.sub(p, 1, i)
                end
            end

            return p
        end
        
        -- Change to the default directory and select the default file
        bq.path = parentPath(__file__)
        updatelist()

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
                bq.path = parentPath(bq.path)
                updatelist()
            elseif (string.sub(f, string.len(f)) == '/') then
                bq.path = f
                updatelist()
            else
                print("Selected " .. f)
            end
        end
        bq:setActionCallback(cb)

        return bq
    end
    
    local menu = MenuScreen()
    menu:setBaseColor(black)
    menu:setOpaque(true)

    local label = MakeLabel("Wargus data is not extracted, yet.")
    menu:add(label, (width - label:getWidth()) / 2, label:getHeight())
    
    local gog, bnet, dos, quit
    
    gog = MakeButton("Extract from ~!GOG Installer", "g", function()
        menu:remove(gog)
        menu:remove(bnet)
        menu:remove(dos)
        menu:remove(quit)

        local browser = MakeFileBrowser(menu, {"setup.+%.exe"})
        local ok = MakeButton("~!OK", "o", function()
            print("Selected " .. browser:getSelectedItem())
            menu:stop()
        end)
        menu:add(ok, (width - ok:getWidth()) / 2, height - ok:getHeight() * 2)
    end)
    menu:add(gog, (width - gog:getWidth()) / 2, height - gog:getHeight() * 8)
    
    bnet = MakeButton("Extract from ~!Battle.NET Edition CD", "b", function()
        menu:remove(gog)
        menu:remove(bnet)
        menu:remove(dos)
        menu:remove(quit)

        local browser = MakeFileBrowser(menu, {"setup.+%.exe", "install%.mpq", "Install%.mpq", "INSTALL%.MPQ", "install%.exe", "Install%.exe", "INSTALL%.EXE"})
        local ok = MakeButton("~!OK", "o", function()
            print("Selected " .. browser:getSelectedItem())
            menu:stop()
        end)
        menu:add(ok, (width - ok:getWidth()) / 2, height - ok:getHeight() * 2)
    end)
    menu:add(bnet, (width - bnet:getWidth()) / 2, height - bnet:getHeight() * 6)
    
    dos = MakeButton("Extract from ~!DOS CD", "d", function()
        menu:remove(gog)
        menu:remove(bnet)
        menu:remove(dos)
        menu:remove(quit)

        local browser = MakeFileBrowser(menu, {"setup.+%.exe", "REZDAT%.WAR", "rezdat%.war"})
        local ok = MakeButton("~!OK", "o", function()
            print("Selected " .. browser:getSelectedItem())
            menu:stop()
        end)
        menu:add(ok, (width - ok:getWidth()) / 2, height - ok:getHeight() * 2)
    end)
    menu:add(dos, (width - dos:getWidth()) / 2, height - dos:getHeight() * 4)
    
    quit = MakeButton("QUIT", "q", function()
        menu:stop()
    end)
    menu:add(quit, (width - quit:getWidth()) / 2, height - quit:getHeight() * 2)
    
    menu:run()
end
