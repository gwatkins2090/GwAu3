# Froggy Farm Bot - Comprehensive Documentation

## Overview

The Froggy Farm Bot is an AutoIt3 automation script for Guild Wars 1 that farms the Bogroot Growths dungeon (commonly called "Froggy" due to the frog-like enemies). The bot automates the entire farming process including hero management, navigation, combat, loot collection, and quest handling.

---

## Project Structure

```
GwAu3/
├── API/                          # Core GwAu3 API (memory reading/writing)
│   └── _GwAu3.au3               # Main API include file
├── Scripts/
│   ├── Farm_Froggy.au3          # Main bot script (ACTIVE VERSION)
│   ├── GwAu3_AddOns_Froggy.au3  # Helper functions & constants
│   └── GUI/
│       └── Gui_Froggy.au3       # Modern dark-themed GUI
├── Farm_Froggy.au3              # Root version (legacy, has all features)
├── GwAu3_AddOns_Froggy.au3      # Root version (legacy, has all features)
└── Gui_Froggy.au3               # Root version (legacy, has all features)
```

**Note:** The Scripts/ folder contains the active development version. The root directory files are the original versions with all features already integrated.

---

## Key Files

### 1. Scripts/Farm_Froggy.au3 (Main Bot)

The main entry point that orchestrates the entire farming loop.

#### Include Dependencies
```autoit
#include "..\API\_GwAu3.au3"           # Core GW API
#include "GwAu3_AddOns_Froggy.au3"     # Helper functions
#include "GUI\Gui_Froggy.au3"          # GUI interface
```

#### Global Variables
- `$charName` - Character name for initialization
- `$BotRunning` - Boolean to control bot state (True = running)
- `$Bot_Core_Initialized` - Whether the API connection is established
- `$g_bAutoStart` - Auto-start via command line arguments

#### Main Functions

| Function | Description |
|----------|-------------|
| `MainFarm()` | Core loop - calls Setup, GoToDungeon, TakeQuest, EnterFirstRun, CombatLoop |
| `Setup()` | Loads hero builds, travels to Gadd's Encampment, checks inventory |
| `GoToDungeon()` | Navigates from Gadd's to Sparkfly Swamp, gets Asura blessing, walks to dungeon |
| `TakeQuest()` | Handles quest state (reward/take/in-progress) with Tekks NPC |
| `EnterFirstRun()` | Enters the dungeon portal |
| `CombatLoop()` | Main farming loop - manages runs, quest cycling, death handling |
| `FirstStage()` | Level 1 navigation and combat (steps 1-41) |
| `SecondStage()` | Level 2 navigation and combat (steps 42-87) |
| `LastStep()` | Boss area, chest opening, quest reward, exit (steps 88-99) |

#### Quest Functions
| Function | Description |
|----------|-------------|
| `TakeQuestNewRun()` | Takes quest from Tekks for a new run |
| `ReloadQuest()` | Re-enters dungeon and exits to reset quest state |
| `RetakeQuest()` | Handles quest retake when quest is missing |
| `Re_Enter()` | Re-enters dungeon via portal with timeout protection |
| `HandleTekks()` | Dialog handler for Tekks NPC (in AddOns file) |

---

### 2. Scripts/GwAu3_AddOns_Froggy.au3 (Helper Functions)

Contains all utility functions, constants, and helper logic.

#### Map ID Constants
```autoit
$iGaddsEncampmentMapID = 123    # Gadd's Encampment outpost
$iSplarkflyMapID = 456          # Sparkfly Swamp explorable
$iBogrootGrowthsLevel1MapID     # Dungeon Level 1
$iBogrootGrowthsLevel2MapID     # Dungeon Level 2
```

#### Rarity Constants
```autoit
$RARITY_Gold = 2624
$RARITY_Purple = 2626
$RARITY_Blue = 2623
$RARITY_White = 2621
```

#### Hero IDs
```autoit
$HERO_ID_Norgu, $HERO_ID_Goren, $HERO_ID_Tahlkora, $HERO_ID_Master,
$HERO_ID_Jin, $HERO_ID_Koss, $HERO_ID_Dunkoro, $HERO_ID_Sousuke,
$HERO_ID_Melonni, $HERO_ID_Zhed, $HERO_ID_Morgahn, $HERO_ID_Margrid,
$HERO_ID_Zenmai, $HERO_ID_Olias, $HERO_ID_Razah, $HERO_ID_Mox,
$HERO_ID_Livia, $HERO_ID_Gwen, $HERO_ID_Xandra, $HERO_ID_Vekk, etc.
```

---

## Timeout & Stuck Detection System

### Zone-Based Timeout (35 minutes per zone)
Prevents infinite loops by tracking time spent in each dungeon level.

#### Global Variables
```autoit
Global Const $g_iMaxZoneTime = 2100000   ; 35 minutes in milliseconds
Global $g_bRunTimedOut = False
Global $g_iZoneStartTimer = 0
Global $g_sCurrentZone = ""              ; "Level 1", "Level 2", "Outpost"
```

#### Functions
| Function | Description |
|----------|-------------|
| `CheckRunTimeout()` | Returns True if zone time exceeded 35 min |
| `OnZoneEntered($sZoneName)` | Resets zone timer when entering new area |
| `ResetRunTimeout()` | Resets all timers at start of new run |
| `GetZoneTimeFormatted()` | Returns current zone time as "MM:SS" |

### Step Progression Timeout (10 minutes per step)
Detects if bot is stuck on a single waypoint too long.

#### Global Variables
```autoit
Global $g_iLastStepNumber = 0
Global $g_iLastStepTime = 0
Global Const $g_iMaxStepTime = 600000    ; 10 minutes
```

#### Functions
| Function | Description |
|----------|-------------|
| `CheckStepTimeout()` | Returns True if stuck on same step > 10 min |
| `OnStepReached($iStepNumber)` | Updates step tracking when reaching waypoint |

### Position-Based Stuck Detection
Monitors actual character movement to detect physical stucks.

#### Global Variables
```autoit
Global $g_fLastPosX = 0, $g_fLastPosY = 0
Global $g_iStuckCheckTimer = 0
Global $g_iStuckCount = 0
Global Const $g_iStuckCheckInterval = 3000   ; Check every 3 seconds
Global Const $g_fMinMoveDistance = 75        ; Must move 75+ units
Global Const $g_iMaxStuckCount = 5           ; 5 checks = stuck (15 sec)
Global $g_iRecoveryAttempts = 0
```

#### Functions
| Function | Description |
|----------|-------------|
| `CheckPositionStuck()` | Returns: 0=OK, 1=recovered, 2=abort run |
| `ResetPositionStuck()` | Resets all position tracking variables |
| `AttemptStuckRecovery()` | 3-level escalating recovery (small move -> large move -> abort) |

---

## Loot Pickup System

### GUI Checkboxes
- **Salvage Armors** (`$chkSalvageArmor`) - Pick up blue/purple salvage items
- **Trophies** (`$chkTrophies`) - Pick up Sentient Vine, Amphibian Tongue, Beetle Egg

### Global Variables
```autoit
Global $g_bPickupSalvageArmor = False
Global $g_bPickupTrophies = False
Global $SalvageArmorGained = 0
Global $TrophiesGained = 0
```

### Toggle Functions
```autoit
Func ToggleSalvageArmor()    ; Called when checkbox toggled
Func ToggleTrophies()        ; Called when checkbox toggled
```

### CanPickUp() Function Logic
The `CanPickUp($aItemPtr)` function determines what items to pick up:

| Item Type | Condition | Picked Up? |
|-----------|-----------|------------|
| Gold coins | Character gold < 99000 | Yes |
| Black/White dyes | Always | Yes |
| Gold rarity items | Always | Yes |
| Froggies (model IDs: 1197, 1556, 1569, 1439, 1563) | Always | Yes |
| Lockpicks | Always | Yes |
| Boss keys (25416) | Always | Yes |
| Cupcakes (22269) | Always | Yes |
| Candy Cane Shards | Always | Yes |
| Trophies (Sentient Vine, Amphibian Tongue, Beetle Egg) | If checkbox enabled | Conditional |
| Blue/Purple salvage items | If checkbox enabled | Conditional |
| Rare materials | Always | Yes |
| Pcons | Never | No |
| Everything else | Never | No |

---

## GUI System (Gui_Froggy.au3)

### Visual Theme
Modern dark theme inspired by Tailwind CSS with slate color palette.

### Color Constants
```autoit
$COLOR_BG_DARK = 0x0f172a        ; Main background (slate-900)
$COLOR_BG_CARD = 0x1e293b        ; Card background (slate-800)
$COLOR_BG_INPUT = 0x334155       ; Input background (slate-700)
$COLOR_TEXT_PRIMARY = 0xf1f5f9   ; Primary text (slate-100)
$COLOR_TEXT_SECONDARY = 0x94a3b8 ; Secondary text (slate-400)
$COLOR_ACCENT_GREEN = 0x22c55e   ; Success/Start button
$COLOR_ACCENT_RED = 0xef4444     ; Fail count
$COLOR_ACCENT_YELLOW = 0xeab308  ; Fastest time
```

### GUI Controls

#### Character Selection
- `$Input` - Combo box for character selection

#### Options Checkboxes
- `$HardmodeCheckbox` - Hard Mode toggle
- `$chkChestFarm` - Open Chests toggle
- `$Builds` - Load Builds toggle
- `$PconsBox` / `$PconsBox2` - Conset Stage 1/2
- `$RenderingBox` - Rendering toggle
- `$Summon1` / `$Summon2` - Summon Stage 1/2

#### Loot Pickup Checkboxes
- `$chkSalvageArmor` - Salvage Armors toggle
- `$chkTrophies` - Trophies toggle

#### Statistics Labels
- `$RunsLabel` - Total runs count
- `$SuccessLabel` - Successful runs (green)
- `$FailsLabel` - Failed runs (red)
- `$FroggyLabel` - Froggy items found (cyan)
- `$FastTimeLabel` - Fastest run time (yellow)
- `$AvgTimeLabel` - Average run time

#### Drop Counters
- `$LockpickLabel` - Lockpicks gained
- `$GoldItemsLabel` - Gold items gained
- `$SalvageLabel` - Salvage armors gained
- `$TrophiesLabel` - Trophies gained

#### Console
- `$GLOGBOX` - Log output edit control

### Key GUI Functions
```autoit
Func GuiButtonHandler()      ; Handles Start/Pause button and close event
Func UpdateStatus($sText, $nColor)  ; Updates status indicator
Func UpdateStatistics()      ; Refreshes all stat labels
Func Out($sMessage)          ; Outputs to console log (in AddOns)
```

---

## Navigation System

### DoStep() Function
Primary navigation function that moves to waypoints with combat awareness.

```autoit
DoStep($stepNumber, $x, $y, $mode)
; $mode = "move" (just move) or "aggro" (move + fight enemies)
```

### Waypoint Structure
The dungeon is divided into numbered steps:
- **Sparkfly Swamp (Pre-dungeon):** Steps 1-54
- **Level 1:** Steps 1-41 (resets numbering)
- **Level 2:** Steps 42-87
- **Boss Area:** Steps 88-99

### Movement Functions
```autoit
MoveTo($x, $y)               ; Basic movement to coordinates
RndTravel($mapID)            ; Travel to outpost (method 1)
RndTravel2($mapID)           ; Travel to outpost (method 2)
```

---

## Combat System

### Hero Builds
The bot loads specific skill templates for 7 heroes:
1. **Livia** - Support build
2. **Norgu** - Mesmer build
3. **Olias** - Necro build
4. **Razah** - Caster build
5. **Xandra** - Ritualist build
6. **Master of Whispers** - Necro build
7. **Gwen** - Mesmer build

### Combat Functions
```autoit
ClearEnemiesInCompass()      ; Fight all enemies in compass range
Powerup()                    ; Use consumables for Stage 1
Powerup2()                   ; Use consumables for Stage 2
```

### Blessing Shrines
The bot collects blessings at strategic points:
- **Asura Blessing** - At start of Sparkfly Swamp
- **Dwarven Blessing** - Multiple beacons throughout dungeon

---

## Quest System

### Quest ID
```autoit
$questID = 0x339             ; Bogroot Growths quest
```

### Quest States
1. **Completed** - Can be rewarded at Tekks
2. **In Progress** - Quest active but not complete
3. **Not Accepted** - Quest needs to be taken

### HandleTekks() Function
```autoit
HandleTekks($action, $questID)
; $action = "take" or "reward"
```

---

## Inventory Management

### Functions
```autoit
CountSlots()                 ; Returns number of empty inventory slots
Inventory()                  ; Travels to EotN, identifies, sells, salvages
PickupLoot()                 ; Picks up items based on CanPickUp() rules
```

### Inventory Full Handling
When `CountSlots() < 5`, the bot:
1. Travels to Eye of the North
2. Identifies items
3. Sells to merchant
4. Deposits gold if > 90000
5. Salvages runes

---

## Command Line Arguments

The bot supports auto-start via command line:
```
Farm_Froggy.au3 -character "CharacterName"
```

This will:
1. Initialize with the specified character
2. Auto-press Enter to load character
3. Start farming automatically

---

## Statistics Tracking

### Run Statistics
- `$RunCount` - Total runs completed
- `$SuccessCount` - Successful runs
- `$FailCount` - Failed runs (deaths)

### Time Statistics
- `$RunTimer` - Timer for current run
- `$RunTime` / `$RunTimeCalc` - Run duration
- `$AvgTime[]` - Array of all run times
- `$RunTimeMinutes` / `$RunTimeSeconds` - Fastest time
- `$AvgRunTimeMinutes` / `$AvgRunTimeSeconds` - Average time

### Loot Statistics
- `$LockpicksGained`
- `$GoldItemsGained`
- `$FroggyGained`
- `$SalvageArmorGained`
- `$TrophiesGained`

### Stat Functions
```autoit
CalculateFastestTime()       ; Updates fastest run time
CalculateAverageTime()       ; Calculates average from $AvgTime array
UpdateStatistics()           ; Refreshes all GUI labels
```

---

## Error Handling & Recovery

### Timeout Checks
Every major operation checks for timeouts:
```autoit
If CheckRunTimeout() Then
    Out("Timeout - aborting")
    Return
EndIf
```

### Map Load Timeouts
All map transitions have 60-second safety timeouts:
```autoit
Local $iWaitTimer = TimerInit()
Do
    Sleep(500)
    If TimerDiff($iWaitTimer) > 60000 Then
        Out("Map load timeout (60s) - aborting")
        Return
    EndIf
Until Map_GetMapID() == $targetMapID
```

### Stuck Recovery Levels
1. **Level 1:** Small random movement (200 units)
2. **Level 2:** Large random movement (500 units)
3. **Level 3:** Abort run and restart

---

## Development Notes

### Include Path Structure
The Scripts folder uses relative paths:
```autoit
#include "..\API\_GwAu3.au3"           ; Parent folder API
#include "GwAu3_AddOns_Froggy.au3"     ; Same folder
#include "GUI\Gui_Froggy.au3"          ; Subfolder GUI
```

### .gitignore Configuration
The Scripts folder is normally ignored, with exceptions:
```
/Scripts/*
!/Scripts/Exemples/
!/Scripts/Tools/
!/Scripts/Multi-Launcher/
!/Scripts/Farm_Froggy.au3
!/Scripts/GwAu3_AddOns_Froggy.au3
!/Scripts/GUI/
```

### French to English Translations Done
All French comments and output have been translated:
- "Inventaire plein" -> "Inventory full"
- "Run echoue" -> "Run failed"
- "Quete terminee" -> "Quest completed"
- All emojis removed from output

---

## API Functions Reference (from GwAu3)

### Agent Functions
```autoit
Agent_GetAgentInfo($agentID, $property)  ; Get agent data
Agent_GoNPC($npcID)                      ; Interact with NPC
Agent_GoSignpost($signpostID)            ; Interact with signpost
GetNearestNPCToAgent($agentID)           ; Find nearest NPC
GetNearestSignpostToAgent($agentID)      ; Find nearest signpost
```

### Map Functions
```autoit
Map_GetMapID()                           ; Current map ID
Map_WaitMapLoading($mapID)               ; Wait for map load
Map_GetInstanceInfo($property)           ; Get instance data
```

### Party Functions
```autoit
Party_AddHero($heroID)                   ; Add hero to party
Party_KickAllHeroes()                    ; Remove all heroes
Party_SetHeroAggression($slot, $mode)    ; Set hero behavior
```

### Quest Functions
```autoit
Quest_GetQuestInfo($questID, $property)  ; Get quest data
Quest_AbandonQuest($questID)             ; Abandon quest
```

### Item Functions
```autoit
Item_GetItemArray()                      ; Get all items
Item_GetItemInfoByPtr($ptr, $property)   ; Get item data
Item_PickUpItem($agentID)                ; Pick up item
Item_DepositGold()                       ; Deposit gold to storage
```

### Skill Functions
```autoit
Attribute_LoadSkillTemplate($template, $heroSlot)  ; Load skill bar
UseSkillEx($slot, $target, $caster)      ; Use skill
```

### Travel Functions
```autoit
RndTravel($mapID)                        ; Travel to outpost
Game_SwitchMode($difficulty)             ; Switch Normal/Hard mode
```

### UI Functions
```autoit
Ui_Dialog($dialogID)                     ; Click dialog button
Ui_ToggleRendering()                     ; Toggle game rendering
```

---

## Typical Run Flow

1. **Setup:** Load builds at Great Temple, add heroes, travel to Gadd's
2. **GoToDungeon:** Exit to Sparkfly, get Asura blessing, navigate to dungeon entrance
3. **TakeQuest:** Handle Tekks NPC based on quest state
4. **EnterFirstRun:** Enter dungeon portal
5. **CombatLoop:** Repeat runs until stopped or inventory full
   - FirstStage: Clear Level 1 (steps 1-41)
   - SecondStage: Clear Level 2 (steps 42-87)
   - LastStep: Kill boss, open chest, reward quest, exit
6. **Restart:** Return to step 5 for next run

---

## Known Issues & Limitations

1. Bot requires Guild Wars to be running with character at login screen or in-game
2. Hero unlocks and skill templates must be available on account
3. Inventory management requires items to be identifiable/sellable
4. Stuck detection may not catch all edge cases
5. Network lag can cause timeout false positives

---

## Version History

- **Initial:** Basic farming loop
- **v2.0:** Added modern GUI with Tailwind-inspired theme
- **Recent:** Added timeout protection, stuck detection, trophy/salvage armor pickup options, translated French to English
