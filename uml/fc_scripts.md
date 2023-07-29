# Flowchart

In the following flowchart it is indicated the order of the script that are loaded when the game is started.

```mermaid
flowchart TB;
Start([Game Start]) --> stratagus[stratagus.lua];

subgraph stratagusScript["stratagus lua script"]
  stratagus --> cond1{"Exists the file\nwc2-config.lua?"} -- No --> extraction[extraction.lua] -- Return --> stratagus;
  cond1 -- Yes --> wc2config["wc2-config.lua"]; 
  wc2config --> fov["fov.lua\n(Field of View)"];
  fov --> preferences[preferences.lua];
  preferences --> wc2[wc2.lua];
  wc2 --> ai[ai.lua];
  ai --> database[database.lua];
  database --> translate[translate.lua];
  translate --> icons[icons.lua];
  icons --> sound[sound.lua];
  sound --> missiles[missiles.lua];
  missiles --> constructions[constructions.lua];
  constructions --> spells[spells.lua];
  spells --> units[units.lua];
  units --> upgrade[upgrade.lua];
  upgrade --> fonts[fonts.lua];
  fonts --> buttons[buttons.lua];
  buttons --> ui[ui.lua];
  ui --> commands[commands.lua];
  commands --> cheats[cheats.lua];
end

extraction --> extractionScript

subgraph extractionScript[Extraction lua script]
  setVideoResolution[Set Video Resolution] --> setDefaultTextColors[Set Default Text Colors];
  setDefaultTextColors --> setGameSpeed[Set Game Speed];
  setGameSpeed --> runExtraction[Define Run Extraction Function];
  runExtraction -- Asks the user the file to extract the data --> extraction;
end

subgraph FolderAI["Folder scripts/ai/"]
  passive.lua
  land_attack.lua
  air_attack.lua
  sea_attack.lua
  names.lua
end

stratagusScript -- Load at the end of the script --> FolderAI;

click stratagus "https://github.com/Wargus/wargus/blob/c5cbf8a15cc43961927f25d48d5e10ff57a4c660/scripts/stratagus.lua"
```
