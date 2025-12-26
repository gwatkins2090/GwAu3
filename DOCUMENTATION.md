# GwAu3 Comprehensive Documentation

## Table of Contents
- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Inventory Management](#inventory-management)
- [Model IDs](#model-ids)
- [Core Modules](#core-modules)
- [Common Operations](#common-operations)
- [Naming Conventions](#naming-conventions)
- [Advanced Features](#advanced-features)

---

## Introduction

GwAu3 is a comprehensive AutoIt3 API for automating and controlling Guild Wars. It provides a complete programming interface to interact with the game, allowing you to create bots, assistance tools, and automation applications.

### Key Features
- Memory reading and writing
- Packet sending for game commands
- Complete inventory management
- Agent (entity) manipulation
- Skill usage and management
- Map travel and movement
- Trading and merchant interactions
- Party and guild management
- SmartCast AI system for automated skill usage
- Pathfinding system

---

## Project Structure

The GwAu3 project is organized into several main directories:

```
GwAu3/
├── API/
│   ├── Constants/          # All constant definitions (IDs, enums, etc.)
│   ├── Core/              # Core functionality (memory, scanner, updater)
│   ├── Modules/           # Main API modules
│   │   ├── Cmd/          # Command functions (actions you can perform)
│   │   └── Data/         # Data retrieval functions (get information)
│   ├── Pathfinding/       # Pathfinding system
│   ├── SmartCast/         # AI-based skill casting system
│   ├── GwAu3_Core.au3    # Core initialization and main functions
│   └── _GwAu3.au3        # Main include file
├── Scripts/               # Example scripts and tools
└── Utilities/            # Utility libraries (GUI, ImGui, etc.)
```

### File Organization

- **Constants/** - Contains all constant definitions organized by category:
  - `GwAu3_Const_Item.au3` - Item types, model IDs, rarity levels
  - `GwAu3_Const_Map.au3` - Map IDs and coordinates
  - `GwAu3_Const_Skill.au3` - Skill IDs and attributes
  - `GwAu3_Const_Agents.au3` - Agent types and model IDs
  - And many more...

- **Core/** - Low-level functionality:
  - `GwAu3_Core_Memory.au3` - Memory reading/writing functions
  - `GwAu3_Core_Scanner.au3` - Pattern scanning in memory
  - `GwAu3_Core_Structure.au3` - Data structure definitions
  - `GwAu3_Core_Updater.au3` - Automatic update system

- **Modules/Cmd/** - Command functions (perform actions):
  - `GwAu3_Cmd_Item.au3` - Item manipulation commands
  - `GwAu3_Cmd_Agent.au3` - Agent targeting and interaction
  - `GwAu3_Cmd_Map.au3` - Movement and travel
  - `GwAu3_Cmd_Skill.au3` - Skill usage
  - And more...

- **Modules/Data/** - Data retrieval functions (get information):
  - `GwAu3_Data_Item.au3` - Get item information
  - `GwAu3_Data_Agent.au3` - Get agent information
  - `GwAu3_Data_Map.au3` - Get map information
  - And more...

---

## Getting Started

### Installation

1. **Prerequisites**
   - AutoIt3 v3.3.16.1 or higher (32-bit)
   - Guild Wars installed
   - Windows 7/8/10/11

2. **Setup**
   ```autoit
   #include "API/_GwAu3.au3"
   ```

### Basic Initialization

```autoit
#include "API/_GwAu3.au3"

; Method 1: Initialize with character name
Core_Initialize("Character Name")

; Method 2: Initialize with process PID
; Core_Initialize($ProcessID)

; Check if initialized successfully
If Not Core_IsConnected() Then
    MsgBox(0, "Error", "Failed to connect to Guild Wars")
    Exit
EndIf

; Your code here...
```

### Simple Example

```autoit
#include "API/_GwAu3.au3"

Core_Initialize("My Character")

; Get basic information
Local $l_i_MyID = Agent_GetMyID()
Local $l_s_CharName = Player_GetCharname()
Local $l_i_MapID = Map_GetCharacterInfo("MapID")

ConsoleWrite("Character: " & $l_s_CharName & @CRLF)
ConsoleWrite("Agent ID: " & $l_i_MyID & @CRLF)
ConsoleWrite("Map ID: " & $l_i_MapID & @CRLF)

; Move to a position
Map_Move(1000, -500)
Sleep(500)

; Use skill in slot 1
Skill_UseSkill(1)
```

---

## Inventory Management

The inventory system in GwAu3 is comprehensive and allows you to query, move, use, and manipulate items.

### Inventory Structure

Guild Wars has multiple storage locations:

```autoit
; Inventory bags (constants from GwAu3_Const_Item.au3)
$GC_I_INVENTORY_BACKPACK        ; Bag 1 (20 slots)
$GC_I_INVENTORY_BELT_POUCH      ; Bag 2 (10 slots)
$GC_I_INVENTORY_BAG1            ; Bag 3 (up to 15 slots)
$GC_I_INVENTORY_BAG2            ; Bag 4 (up to 15 slots)
$GC_I_INVENTORY_EQUIPMENT_PACK  ; Equipped items
$GC_I_INVENTORY_MATERIAL_STORAGE ; Material storage
$GC_I_INVENTORY_UNCLAIMED_ITEMS  ; Unclaimed rewards
$GC_I_INVENTORY_STORAGE1 to $GC_I_INVENTORY_STORAGE14 ; Storage tabs
```

### Getting Inventory Information

#### Get All Items in Inventory

```autoit
; Get inventory array (includes bags 1-4 by default)
Local $l_av2_Inventory = Item_GetInventoryArray()

; Loop through all items
For $i = 0 To UBound($l_av2_Inventory) - 1
    Local $l_i_ItemID = $l_av2_Inventory[$i][$GC_I_INVENTORY_ITEMID]
    Local $l_i_ModelID = $l_av2_Inventory[$i][$GC_I_INVENTORY_MODELID]
    Local $l_i_Quantity = $l_av2_Inventory[$i][$GC_I_INVENTORY_QUANTITY]
    Local $l_i_Bag = $l_av2_Inventory[$i][$GC_I_INVENTORY_BAG]
    Local $l_i_Slot = $l_av2_Inventory[$i][$GC_I_INVENTORY_SLOT]

    ConsoleWrite("Item: " & $l_i_ItemID & ", ModelID: " & $l_i_ModelID & _
                 ", Qty: " & $l_i_Quantity & ", Bag: " & $l_i_Bag & _
                 ", Slot: " & $l_i_Slot & @CRLF)
Next
```

#### Inventory Array Structure

The inventory array returned by `Item_GetInventoryArray()` has the following columns:

```autoit
$GC_I_INVENTORY_PTR               ; Pointer to item structure in memory
$GC_I_INVENTORY_ITEMID            ; Unique item ID
$GC_I_INVENTORY_BAG               ; Bag number (1-4)
$GC_I_INVENTORY_ITEMTYPE          ; Item type (weapon, armor, material, etc.)
$GC_I_INVENTORY_EXTRAID           ; Extra ID (used for dyes, etc.)
$GC_I_INVENTORY_VALUE             ; Item value
$GC_I_INVENTORY_ISIDENTIFIED      ; True if identified
$GC_I_INVENTORY_ISSTACKABLE       ; True if stackable
$GC_I_INVENTORY_ISINSCRIBABLE     ; True if inscribable
$GC_I_INVENTORY_MODELID           ; Model ID (identifies item type)
$GC_I_INVENTORY_RARITY            ; Rarity (white, blue, purple, gold, green)
$GC_I_INVENTORY_ISMATERIALSALVAGEABLE ; True if can salvage materials
$GC_I_INVENTORY_QUANTITY          ; Quantity (for stackable items)
$GC_I_INVENTORY_SLOT              ; Slot number in bag
```

#### Get Specific Bag Information

```autoit
; Get information about a specific bag
Local $l_i_BagSlots = Item_GetBagInfo($GC_I_INVENTORY_BACKPACK, "Slots")
Local $l_i_ItemCount = Item_GetBagInfo($GC_I_INVENTORY_BACKPACK, "ItemCount")
Local $l_i_EmptySlots = Item_GetBagInfo($GC_I_INVENTORY_BACKPACK, "EmptySlots")

ConsoleWrite("Backpack has " & $l_i_ItemCount & " items in " & _
             $l_i_BagSlots & " slots (" & $l_i_EmptySlots & " empty)" & @CRLF)
```

#### Get Storage Information

```autoit
; Get all items in storage (includes all 14 storage tabs)
Local $l_av2_Storage = Item_GetStorageArray()

; Include material storage
Local $l_av2_StorageWithMats = Item_GetStorageArray(True)
```

### Finding Items

#### Find Item by Model ID

```autoit
; Find an identification kit in bags
Local $l_i_ItemID = Item_GetBagsItembyModelID($GC_I_MODELID_IDENTIFICATION_KIT)

If $l_i_ItemID <> 0 Then
    ConsoleWrite("Found ID kit: " & $l_i_ItemID & @CRLF)
Else
    ConsoleWrite("ID kit not found" & @CRLF)
EndIf
```

#### Get Item by Slot

```autoit
; Get item pointer in backpack slot 5
Local $l_p_Item = Item_GetItemBySlot($GC_I_INVENTORY_BACKPACK, 5)

If $l_p_Item <> 0 Then
    Local $l_i_ModelID = Item_GetItemInfoByPtr($l_p_Item, "ModelID")
    ConsoleWrite("Item in slot 5 has ModelID: " & $l_i_ModelID & @CRLF)
EndIf
```

### Item Operations

#### Using Items

```autoit
; Use an item (double-click)
Item_UseItem($l_i_ItemID)

; Equip an item
Item_EquipItem($l_i_ItemID)
```

#### Moving Items

```autoit
; Move item to bag 2, slot 3
Item_MoveItem($l_i_ItemID, $GC_I_INVENTORY_BELT_POUCH, 3)

; Move item and split stack (move 5 items to bag 2, slot 3)
Item_MoveItem_($l_i_ItemID, $GC_I_INVENTORY_BELT_POUCH, 3, 5)
```

#### Dropping Items

```autoit
; Drop entire stack
Item_DropItem($l_i_ItemID)

; Drop specific amount (10 items)
Item_DropItem($l_i_ItemID, 10)
```

#### Picking Up Items

```autoit
; Pick up an item (requires agent ID of item on ground)
Item_PickUpItem($l_i_AgentID)
```

#### Salvaging and Identifying

```autoit
; Identify an item (uses superior kit if available)
Item_IdentifyItem($l_i_ItemID)

; Salvage materials from item
Item_SalvageItem($l_i_ItemID, "Expert", "Materials")

; Salvage upgrade (prefix, suffix, or inscription)
Item_SalvageItem($l_i_ItemID, "Expert", "Prefix")
Item_SalvageItem($l_i_ItemID, "Expert", "Suffix")
Item_SalvageItem($l_i_ItemID, "Expert", "Inscription")
```

### Gold Management

```autoit
; Get character gold
Local $l_i_CharGold = Item_GetInventoryInfo("GoldCharacter")
ConsoleWrite("Character has " & $l_i_CharGold & " gold" & @CRLF)

; Get storage gold
Local $l_i_StorageGold = Item_GetInventoryInfo("GoldStorage")
ConsoleWrite("Storage has " & $l_i_StorageGold & " gold" & @CRLF)

; Deposit all gold to storage
Item_DepositGold()

; Deposit specific amount (50000 gold)
Item_DepositGold(50000)

; Withdraw all gold from storage
Item_WithdrawGold()

; Withdraw specific amount (10000 gold)
Item_WithdrawGold(10000)

; Drop gold on ground
Item_DropGold(1000)
```

### Weapon Sets

```autoit
; Get active weapon set (0-3)
Local $l_i_ActiveSet = Item_GetInventoryInfo("ActiveWeaponSet")

; Get weapon set 1 weapon ModelID
Local $l_i_WeaponModelID = Item_GetInventoryInfo("WeaponSet1WeaponModelID")

; Switch to weapon set 2
Item_SwitchWeaponSet(2)
```

---

## Model IDs

Model IDs are unique identifiers for each type of item, agent, skill, or other game entity. They are essential for identifying specific items or entities in the game.

### What are Model IDs?

A **Model ID** is a numeric identifier that represents a specific type of game object:
- **Item Model IDs**: Identify item types (e.g., 2989 = Identification Kit)
- **Agent Model IDs**: Identify NPC/enemy types
- **Skill IDs**: Identify skills
- **Map IDs**: Identify zones/maps

### Where are Model IDs Stored?

Model IDs are defined as constants in the `API/Constants/` directory:

#### Item Model IDs

File: `API/Constants/GwAu3_Const_Item.au3`

```autoit
; Common kits
Global Const $GC_I_MODELID_IDENTIFICATION_KIT = 2989
Global Const $GC_I_MODELID_SUPERIOR_IDENTIFICATION_KIT = 5899
Global Const $GC_I_MODELID_SALVAGE_KIT = 2991
Global Const $GC_I_MODELID_EXPERT_SALVAGE_KIT = 2992
Global Const $GC_I_MODELID_SUPERIOR_SALVAGE_KIT = 5900

; Dyes
Global Const $GC_I_MODELID_DYE = 146

; Gold
Global Const $GC_I_MODELID_GOLD_COIN = 2511

; Materials (common)
Global Const $GC_AI_COMMON_MATERIALS[11] = [10, 921, 940, 941, 942, 946, 948, 953, 954, 955, 956]

; Materials (rare)
Global Const $GC_AI_RARE_MATERIALS[6] = [5, 944, 945, 949, 950, 951]
```

#### Map IDs

File: `API/Constants/GwAu3_Const_Map.au3`

```autoit
Global Const $GC_I_MAP_ID_GREAT_TEMPLE_OF_BALTHAZAR = 248
Global Const $GC_I_MAP_ID_KAMADAN = 449
Global Const $GC_I_MAP_ID_LIONS_ARCH = 52
; ... hundreds more map IDs
```

#### Skill IDs

File: `API/Constants/GwAu3_Const_Skill.au3`

Contains skill IDs for all skills in the game.

### How to Get Model IDs

#### For Items in Your Inventory

```autoit
; Method 1: From inventory array
Local $l_av2_Inventory = Item_GetInventoryArray()
For $i = 0 To UBound($l_av2_Inventory) - 1
    Local $l_i_ModelID = $l_av2_Inventory[$i][$GC_I_INVENTORY_MODELID]
    ConsoleWrite("Item ModelID: " & $l_i_ModelID & @CRLF)
Next

; Method 2: From item pointer
Local $l_p_Item = Item_GetItemBySlot($GC_I_INVENTORY_BACKPACK, 1)
Local $l_i_ModelID = Item_GetItemInfoByPtr($l_p_Item, "ModelID")

; Method 3: From item ID
Local $l_i_ModelID = Item_GetItemInfoByItemID($l_i_ItemID, "ModelID")
```

#### For Agents (NPCs, Enemies, Players)

```autoit
; Get agent information
Local $l_i_AgentID = Agent_GetMyID()
Local $l_i_ModelID = Agent_GetAgentInfo($l_i_AgentID, "PlayerNumber")
```

### Finding Unknown Model IDs

If you need to find a Model ID for an item you don't know:

```autoit
; 1. Get the item in your inventory
; 2. Use this script to display all items with their ModelIDs

Local $l_av2_Inventory = Item_GetInventoryArray()
For $i = 0 To UBound($l_av2_Inventory) - 1
    Local $l_i_ItemID = $l_av2_Inventory[$i][$GC_I_INVENTORY_ITEMID]
    Local $l_i_ModelID = $l_av2_Inventory[$i][$GC_I_INVENTORY_MODELID]
    Local $l_i_Bag = $l_av2_Inventory[$i][$GC_I_INVENTORY_BAG]
    Local $l_i_Slot = $l_av2_Inventory[$i][$GC_I_INVENTORY_SLOT]

    ConsoleWrite("Bag " & $l_i_Bag & ", Slot " & $l_i_Slot & ": ModelID = " & $l_i_ModelID & @CRLF)
Next
```

### Using Model IDs in Practice

```autoit
; Example: Find all Obsidian Shards in inventory
Local Const $OBSIDIAN_SHARD_MODELID = 945

Local $l_av2_Inventory = Item_GetInventoryArray()
Local $l_i_TotalShards = 0

For $i = 0 To UBound($l_av2_Inventory) - 1
    If $l_av2_Inventory[$i][$GC_I_INVENTORY_MODELID] = $OBSIDIAN_SHARD_MODELID Then
        $l_i_TotalShards += $l_av2_Inventory[$i][$GC_I_INVENTORY_QUANTITY]
    EndIf
Next

ConsoleWrite("Total Obsidian Shards: " & $l_i_TotalShards & @CRLF)
```

---

## Core Modules

### Agent Module

Agents are entities in the game (players, NPCs, enemies, items on the ground, etc.).

```autoit
; Get your agent ID
Local $l_i_MyID = Agent_GetMyID()

; Get target's agent ID
Local $l_i_TargetID = Agent_GetTargetID()

; Change target
Agent_ChangeTarget($l_i_AgentID)

; Get agent information
Local $l_f_HP = Agent_GetAgentInfo($l_i_AgentID, "HP")
Local $l_f_Energy = Agent_GetAgentInfo($l_i_AgentID, "Energy")
Local $l_i_Level = Agent_GetAgentInfo($l_i_AgentID, "Level")
Local $l_i_Allegiance = Agent_GetAgentInfo($l_i_AgentID, "Allegiance")

; Get agent position
Local $l_f_X = Agent_GetAgentInfo($l_i_AgentID, "X")
Local $l_f_Y = Agent_GetAgentInfo($l_i_AgentID, "Y")

; Get all agents in range
Local $l_ap_AgentArray = Agent_GetAgentArray()
For $i = 1 To $l_ap_AgentArray[0]
    Local $l_i_AgentID = Memory_Read($l_ap_AgentArray[$i], "dword")
    ; Process each agent...
Next
```

### Map Module

```autoit
; Get current map ID
Local $l_i_MapID = Map_GetCharacterInfo("MapID")

; Get current position
Local $l_f_X = Map_GetCharacterInfo("X")
Local $l_f_Y = Map_GetCharacterInfo("Y")

; Move to coordinates
Map_Move(1000, -500)

; Travel to a map
Map_TravelTo($GC_I_MAP_ID_KAMADAN)

; Enter mission/challenge
Map_EnterMission()

; Leave mission
Map_ReturnToOutpost()
```

### Skill Module

```autoit
; Use skill in slot 1
Skill_UseSkill(1)

; Use skill on target
Skill_UseSkill(3, $l_i_TargetID)

; Use skill at position
Skill_UseSkillEx(1, 0, $l_f_X, $l_f_Y)

; Get skill information
Local $l_i_SkillID = Skill_GetSkillInfo(1, "SkillID")
Local $l_i_Recharge = Skill_GetSkillInfo(1, "Recharge")
Local $l_i_Adrenaline = Skill_GetSkillInfo(1, "Adrenaline")

; Load skill bar
Local $l_ai_Skills[8] = [123, 456, 789, 101, 102, 103, 104, 105]
Skill_LoadSkillBar($l_ai_Skills)
```

### Chat Module

```autoit
; Send message to all chat
Chat_SendMessage("Hello!")

; Send whisper
Chat_SendWhisper("PlayerName", "Hi there!")

; Send to guild chat
Chat_SendGuild("Looking for DoA group")

; Send to alliance chat
Chat_SendAlliance("Any runners?")

; Send to party chat
Chat_SendParty("Ready to go!")
```

### Party Module

```autoit
; Get party information
Local $l_i_PartySize = Party_GetPartySize()
Local $l_i_HenchCount = Party_GetHenchCount()

; Invite player
Party_InvitePlayer($l_i_AgentID)

; Kick player
Party_KickPlayer($l_i_AgentID)

; Leave party
Party_LeaveParty()

; Add hero
Party_AddHero(1) ; Hero number 1

; Kick hero
Party_KickHero($l_i_AgentID)

; Get hero information
Local $l_i_HeroID = Party_GetHeroInfo(1, "AgentID")
```

### Merchant/Trade Module

```autoit
; Buy from merchant
Merchant_BuyItem($l_i_ModelID, $l_i_Quantity)

; Sell to merchant
Merchant_SellItem($l_i_ItemID, $l_i_Quantity)

; Request quote
Merchant_RequestQuote($GC_I_QUOTETYPE_SELL)

; Trade with player
Trade_OfferItem($l_i_ItemID)
Trade_OfferGold($l_i_Amount)
Trade_AcceptTrade()
Trade_CancelTrade()
```

---

## Common Operations

### Check if Character is Dead

```autoit
Func IsCharacterDead()
    Local $l_i_MyID = Agent_GetMyID()
    Local $l_f_HP = Agent_GetAgentInfo($l_i_MyID, "HP")
    Return $l_f_HP <= 0
EndFunc
```

### Wait Until Reached Position

```autoit
Func WaitUntilReached($a_f_X, $a_f_Y, $a_f_Distance = 100)
    Local $l_i_Timeout = TimerInit()
    While TimerDiff($l_i_Timeout) < 10000 ; 10 second timeout
        Local $l_f_CurrentX = Map_GetCharacterInfo("X")
        Local $l_f_CurrentY = Map_GetCharacterInfo("Y")

        Local $l_f_Dist = Sqrt(($a_f_X - $l_f_CurrentX)^2 + ($a_f_Y - $l_f_CurrentY)^2)
        If $l_f_Dist < $a_f_Distance Then Return True

        Sleep(100)
    WEnd
    Return False ; Timeout
EndFunc
```

### Find Nearest Enemy

```autoit
Func FindNearestEnemy()
    Local $l_i_MyID = Agent_GetMyID()
    Local $l_f_MyX = Agent_GetAgentInfo($l_i_MyID, "X")
    Local $l_f_MyY = Agent_GetAgentInfo($l_i_MyID, "Y")

    Local $l_ap_AgentArray = Agent_GetAgentArray()
    Local $l_i_NearestID = 0
    Local $l_f_NearestDist = 999999

    For $i = 1 To $l_ap_AgentArray[0]
        Local $l_p_Agent = $l_ap_AgentArray[$i]
        Local $l_i_AgentID = Memory_Read($l_p_Agent, "dword")

        ; Check if enemy and alive
        If Agent_GetAgentInfo($l_i_AgentID, "Allegiance") = 3 And _
           Agent_GetAgentInfo($l_i_AgentID, "HP") > 0 Then

            Local $l_f_X = Agent_GetAgentInfo($l_i_AgentID, "X")
            Local $l_f_Y = Agent_GetAgentInfo($l_i_AgentID, "Y")
            Local $l_f_Dist = Sqrt(($l_f_X - $l_f_MyX)^2 + ($l_f_Y - $l_f_MyY)^2)

            If $l_f_Dist < $l_f_NearestDist Then
                $l_f_NearestDist = $l_f_Dist
                $l_i_NearestID = $l_i_AgentID
            EndIf
        EndIf
    Next

    Return $l_i_NearestID
EndFunc
```

### Auto-Salvage Materials

```autoit
Func AutoSalvageMaterials()
    Local $l_av2_Inventory = Item_GetInventoryArray()

    For $i = 0 To UBound($l_av2_Inventory) - 1
        ; Check if item is salvageable for materials and not identified
        If $l_av2_Inventory[$i][$GC_I_INVENTORY_ISMATERIALSALVAGEABLE] And _
           Not $l_av2_Inventory[$i][$GC_I_INVENTORY_ISIDENTIFIED] Then

            Local $l_i_ItemID = $l_av2_Inventory[$i][$GC_I_INVENTORY_ITEMID]

            ; Salvage with expert kit
            If Item_SalvageItem($l_i_ItemID, "Expert", "Materials") Then
                Sleep(500) ; Wait for salvage to complete
            EndIf
        EndIf
    Next
EndFunc
```

---

## Naming Conventions

GwAu3 follows a strict Hungarian notation naming convention. Understanding this is crucial for reading and writing code.

### Variable Naming Format

```
$<scope><attribute>_<datatype>_<VariableName>
```

### Scope Prefixes

- `g` - Global variable
- `l` - Local variable
- `s` - Static variable
- `a` - Function argument/parameter

### Data Type Prefixes

#### Basic Types
- `i` - Integer
- `f` - Float/Double
- `s` - String
- `b` - Boolean
- `v` - Variant (any type)
- `p` - Pointer
- `h` - Handle

#### Array Types
- `ai` - Array of Integers
- `af` - Array of Floats
- `as` - Array of Strings
- `ap` - Array of Pointers
- `av` - Array of Variants
- `av2` - 2D Array of Variants

### Constants

Constants use `UPPERCASE_WITH_UNDERSCORES` and prefix `GC_`:

```autoit
Global Const $GC_I_MAX_VALUE = 100
Global Const $GC_S_APP_NAME = "GwAu3"
```

### Examples

```autoit
Local $l_i_Counter = 0              ; Local integer
Local $l_s_CharName = "MyChar"      ; Local string
Local $l_b_IsReady = True           ; Local boolean
Local $l_p_ItemPtr = 0x12345678     ; Local pointer
Local $l_ai_Skills[8]               ; Local array of integers
Local $l_av2_Inventory[][14]        ; Local 2D array

Global $g_i_TotalRuns = 0           ; Global integer
Static $s_i_CallCount = 0           ; Static integer (persists)

Func MyFunction($a_i_Value, $a_s_Name)  ; Arguments
    ; $a_i_Value is an integer argument
    ; $a_s_Name is a string argument
EndFunc
```

For complete naming convention documentation, see [API/Constants/README.md](API/Constants/README.md).

---

## Advanced Features

### SmartCast System

SmartCast is an AI-based skill casting system that automatically uses skills based on the situation.

Location: `API/SmartCast/`

Features:
- Automatic target selection
- Skill priority management
- Condition checking (energy, recharge, range, etc.)
- Customizable skill behaviors
- Caching for performance

See [API/SmartCast/SMARTCAST_DOCUMENTATION.md](API/SmartCast/SMARTCAST_DOCUMENTATION.md) for details.

### Pathfinding System

The pathfinding system allows automated navigation through maps.

Location: `API/Pathfinding/`

Features:
- A* pathfinding algorithm
- Obstacle avoidance
- Path optimization
- Movement control

See [API/Pathfinding/README.md](API/Pathfinding/README.md) for details.

### Automatic Updates

GwAu3 includes an automatic update system that can fetch the latest version from GitHub.

Configuration file: `API/Core/config.ini`

```ini
[Update]
Enabled=1      ; 0 = Disable automatic updates
Verbose=1      ; 0 = Silent updates (no prompts)
Owner=JAG-GW
Repo=GwAu3
Branch=main
```

### Memory Scanner

The memory scanner allows you to find patterns in the game's memory.

```autoit
; Scan for a pattern
Local $l_p_Address = Scanner_ScanPattern($g_h_GWProcess, $l_s_Pattern, $l_i_StartAddress, $l_i_EndAddress)
```

---

## Tips and Best Practices

### Performance

1. **Cache frequently accessed data**: Don't call `Agent_GetAgentInfo()` repeatedly in a loop
2. **Use inventory arrays**: Get the full inventory once with `Item_GetInventoryArray()` instead of multiple individual queries
3. **Sleep appropriately**: Use `Sleep()` or `Other_PingSleep()` to avoid spamming the game

### Safety

1. **Check return values**: Many functions return 0 on failure
2. **Validate agent IDs**: Check if agents exist before using them
3. **Handle timeouts**: Don't create infinite loops without timeout conditions
4. **Test in safe areas**: Test your scripts in safe maps first

### Code Organization

1. **Use constants**: Define Model IDs and other magic numbers as constants
2. **Create helper functions**: Encapsulate common operations
3. **Comment your code**: Explain complex logic
4. **Follow naming conventions**: Use the GwAu3 naming style

### Example: Well-Structured Script

```autoit
#include "API/_GwAu3.au3"

; ========================================
; Configuration
; ========================================
Global Const $CONFIG_CHARACTER_NAME = "My Character"
Global Const $CONFIG_TARGET_MAP = $GC_I_MAP_ID_KAMADAN

; ========================================
; Main Script
; ========================================
Main()

Func Main()
    ; Initialize
    If Not Initialize() Then
        MsgBox(0, "Error", "Failed to initialize")
        Exit
    EndIf

    ; Run main loop
    While True
        DoMainTask()
        Sleep(100)
    WEnd
EndFunc

Func Initialize()
    Core_Initialize($CONFIG_CHARACTER_NAME)

    If Not Core_IsConnected() Then Return False

    ConsoleWrite("Initialized successfully!" & @CRLF)
    Return True
EndFunc

Func DoMainTask()
    ; Your main logic here
EndFunc
```

---

## Troubleshooting

### Common Issues

**Script doesn't connect to Guild Wars**
- Ensure Guild Wars is running
- Make sure you're using 32-bit AutoIt
- Try initializing with PID instead of character name

**Items not found**
- Check that you're using the correct Model ID
- Verify the item is in the bags you're searching
- Make sure the item exists in inventory

**Functions return 0**
- Check if character is in the right state (in outpost, in mission, etc.)
- Verify parameters are correct
- Check return values of prerequisite functions

**Memory errors**
- Restart Guild Wars
- Update GwAu3 to the latest version
- Check if game was patched (may need GwAu3 update)

---

## Additional Resources

- **Main README**: [README.md](README.md)
- **Naming Conventions**: [API/Constants/README.md](API/Constants/README.md)
- **SmartCast Documentation**: [API/SmartCast/SMARTCAST_DOCUMENTATION.md](API/SmartCast/SMARTCAST_DOCUMENTATION.md)
- **Pathfinding**: [API/Pathfinding/README.md](API/Pathfinding/README.md)
- **Example Scripts**: Check the `Scripts/` directory

---

## Contributing

Contributions are welcome! If you find bugs or want to add features:
1. Report issues on GitHub
2. Submit pull requests
3. Improve documentation
4. Share example scripts

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Disclaimer

Use at your own risk. Using bots and automation tools may violate the Guild Wars Terms of Service and could result in account bans. This tool is provided for educational purposes only.

---

**Last Updated**: December 26, 2025
**Version**: 1.0
