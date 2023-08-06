# Flowchart

In the following flowchart it is indicated the order of the script that are loaded when the game is started.

```mermaid
flowchart TB;
Start([Start]) --> stratagus[stratagus.lua];

subgraph stratagusScript["stratagus lua script"]
  stratagus:::luascript --> cond1{"Exists the file\nwc2-config.lua?"} -- No --> extraction[extraction.lua]:::luascript -- Return --> stratagus;
  cond1 -- Yes --> wc2config["wc2-config.lua\n(Contains the definition of some variables)"]:::luascript;
  wc2config --> initFunc[Define Init Functions]; 
  initFunc --> fov["fov.lua\n(Field of View)"]:::luascript;
  fov --> preferences["preferences.lua\n(File is created once game is started at least once)"]:::luascript;
  preferences --> wc2[wc2.lua]:::luascript;
  wc2 --> ai[ai.lua]:::luascript;
  ai --> database[database.lua]:::luascript;
  database --> translate["translate.lua\n(Load all the .po files in the translate folder)"]:::luascript;
  translate --> icons[icons.lua]:::luascript;
  icons --> sound["sound.lua\n(Define all game sound effects)"]:::luascript;
  sound --> missiles["missiles.lua\n(Define all missile/projectiles)"]:::luascript;
  missiles --> constructions[constructions.lua]:::luascript;
  constructions --> spells["spells.lua\n(Define all game spells)"]:::luascript;
  spells --> units[units.lua]:::luascript;
  units --> upgrade["upgrade.lua\n(Define all upgrades)"]:::luascript;
  upgrade --> fonts["fonts.lua\n(Load font data)"]:::luascript;
  fonts --> buttons["buttons.lua\n(Define all buttons)"]:::luascript;
  buttons --> ui[ui.lua]:::luascript;
  ui --> commands[commands.lua]:::luascript;
  commands --> cheats[cheats.lua]:::luascript;
end

extraction -.-> extractionScript
wc2 -.-> wc2Script
ai -.-> aiScript
icons -.-> iconsScript
units -.-> unitsScript
ui -.-> uiScript

subgraph extractionScript[Extraction lua script]
  direction LR;
  extSetVideoResolution[Set Video Resolution] --> extSetDefaultTextColors[Set Default Text Colors];
  extSetDefaultTextColors --> extSetGameSpeed[Set Game Speed];
  extSetGameSpeed --> runExtraction[Define Run Extraction Function];
  runExtraction -- Asks the user the file to extract the data -..-> extraction;
end

subgraph wc2Script[wc2 lua script]
  direction TB;
  defineRaces[Define Race Names] --> defineTableUnits[Define table of unit names];
  defineTableUnits --> defineWC2Functions["Define functions"];
  defineWC2Functions -.-> wc2;
end

subgraph aiScript[ai lua script]
  direction TB;
  defineAIUnitNames[Define functions for referecing unit names] --> defineAIFunctions[Define functions to use in the AI Scripts];
  defineAIFunctions -.- ai;
end

subgraph iconsScript[icons lua script]
  direction TB;
  defineIconTable[Define table with unit names and indexes] --> applyIcons["Assign to each index the proper icon\n(This is repeated for each tileset)"];
  applyIcons -.-> icons
end

subgraph unitsScript[units lua script]
  direction TB;
  defineNeutral["Define neutral units and buildings"] --> defineHuman["Define human units and buildings"];
  defineHuman --> defineOrc["Define orc units and buildings"];
  defineOrc -.-> units;
end

subgraph uiScript[ui lua script]
  direction TB;
  widgets[widgets.lua]:::luascript --> defineSD[Define sprites and decorations];
  defineSD --> definePanel[Define contents for the panels];
  definePanel --> uiHumOrc[Load the UI for both Human and Orc];
  uiHumOrc --> defineCursor[Define the cursor];
  defineCursor --> ui_cond_1{Popups on the buttons are enabled?} -- No -.-> ui;
  ui_cond_1 -- Yes --> definePopups["Define Popups"];
  definePopups -.-> ui;
end

click stratagus "https://github.com/Wargus/wargus/blob/master/scripts/stratagus.lua"
click extraction "https://github.com/Wargus/wargus/blob/master/scripts/extract.lua"
click fov "https://github.com/Wargus/wargus/blob/master/scripts/fov.lua"
click wc2 "https://github.com/Wargus/wargus/blob/master/scripts/wc2.lua"
click ai "https://github.com/Wargus/wargus/blob/master/scripts/ai.lua"
click database "https://github.com/Wargus/wargus/blob/master/scripts/database.lua"
click icons "https://github.com/Wargus/wargus/blob/master/scripts/icons.lua"
click sound "https://github.com/Wargus/wargus/blob/master/scripts/sound.lua"
click missiles "https://github.com/Wargus/wargus/blob/master/scripts/missiles.lua"
click constructions "https://github.com/Wargus/wargus/blob/master/scripts/constructions.lua"
click spells "https://github.com/Wargus/wargus/blob/master/scripts/spells.lua"
click units "https://github.com/Wargus/wargus/blob/master/scripts/units.lua"
click upgrade "https://github.com/Wargus/wargus/blob/master/scripts/upgrade.lua"
click fonts "https://github.com/Wargus/wargus/blob/master/scripts/fonts.lua"
click buttons "https://github.com/Wargus/wargus/blob/master/scripts/buttons.lua"
click ui "https://github.com/Wargus/wargus/blob/master/scripts/ui.lua"
click commands "https://github.com/Wargus/wargus/blob/master/scripts/commands.lua"
click cheats "https://github.com/Wargus/wargus/blob/master/scripts/cheats.lua"

classDef luascript stroke:#00f
```
