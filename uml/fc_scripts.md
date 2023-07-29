# Flowchart

In the following flowchart it is indicated the order of the script that are loaded when the game is started.

```mermaid
flowchart TB;
Start([Game Start]) --> stratagus[stratagus.lua];

subgraph stratagusScript["stratagus lua script"]
  stratagus:::luascript --> cond1{"Exists the file\nwc2-config.lua?"} -- No --> extraction[extraction.lua]:::luascript -- Return --> stratagus;
  cond1 -- Yes --> wc2config["wc2-config.lua\nContains the definition of some variables"]:::luascript;
  wc2config --> initFunc[Define Init Functions]; 
  initFunc --> fov["fov.lua\n(Field of View)"]:::luascript;
  fov --> preferences[preferences.lua];
  preferences --> wc2[wc2.lua]:::luascript;
  wc2 --> ai[ai.lua]:::luascript;
  ai --> database[database.lua]:::luascript;
  database --> translate[translate.lua]:::luascript;
  translate --> icons[icons.lua]:::luascript;
  icons --> sound[sound.lua]:::luascript;
  sound --> missiles[missiles.lua]:::luascript;
  missiles --> constructions[constructions.lua]:::luascript;
  constructions --> spells[spells.lua]:::luascript;
  spells --> units[units.lua]:::luascript;
  units --> upgrade[upgrade.lua]:::luascript;
  upgrade --> fonts[fonts.lua]:::luascript;
  fonts --> buttons[buttons.lua]:::luascript;
  buttons --> ui[ui.lua]:::luascript;
  ui --> commands[commands.lua]:::luascript;
  commands --> cheats[cheats.lua]:::luascript;
end

extraction --> extractionScript

subgraph extractionScript[Extraction lua script]
  setVideoResolution[Set Video Resolution] --> setDefaultTextColors[Set Default Text Colors];
  setDefaultTextColors --> setGameSpeed[Set Game Speed];
  setGameSpeed --> runExtraction[Define Run Extraction Function];
  runExtraction -- Asks the user the file to extract the data --> extraction;
end

subgraph FolderAI["Folder scripts/ai/"]
  passive.lua:::luascript
  land_attack.lua:::luascript
  air_attack.lua:::luascript
  sea_attack.lua:::luascript
  names.lua:::luascript
end

stratagusScript -- Load at the end of the script --> FolderAI;

click stratagus "https://github.com/Wargus/wargus/blob/c5cbf8a15cc43961927f25d48d5e10ff57a4c660/scripts/stratagus.lua"
classDef luascript stroke:#00f
```
