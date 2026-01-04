
; ============================================
; Sky Froggy Farmer - Modern UI
; Dark theme inspired by Tailwind CSS
; ============================================

#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>

; === Enable GUI Event Mode ===
Opt("GUIOnEventMode", 1)

; === Color Palette (Tailwind-inspired) ===
Global Const $COLOR_BG_DARK = 0x0f172a        ; slate-900
Global Const $COLOR_BG_CARD = 0x1e293b        ; slate-800
Global Const $COLOR_BG_INPUT = 0x334155       ; slate-700
Global Const $COLOR_BORDER = 0x475569         ; slate-600
Global Const $COLOR_TEXT_PRIMARY = 0xf1f5f9   ; slate-100
Global Const $COLOR_TEXT_SECONDARY = 0x94a3b8 ; slate-400
Global Const $COLOR_TEXT_MUTED = 0x64748b     ; slate-500
Global Const $COLOR_ACCENT_BLUE = 0x3b82f6    ; blue-500
Global Const $COLOR_ACCENT_GREEN = 0x22c55e   ; green-500
Global Const $COLOR_ACCENT_RED = 0xef4444     ; red-500
Global Const $COLOR_ACCENT_YELLOW = 0xeab308  ; yellow-500
Global Const $COLOR_ACCENT_PURPLE = 0xa855f7  ; purple-500
Global Const $COLOR_ACCENT_CYAN = 0x06b6d4    ; cyan-500

; === Stats Variables ===
Global $RunCount = 0
Global $SuccessCount = 0
Global $FailCount = 0
Global $LockpicksGained = 0
Global $GoldItemsGained = 0
Global $LuxonTitle = 0
Global $FroggyGained = 0
Global $SalvageArmorGained = 0
Global $TrophiesGained = 0
Global $RunTimer
Global $RunTime
Global $RunTimeCalc
Global $RunTimeMinutes
Global $RunTimeSeconds
Global $RunTimeFastest
Global $AvgRunTimeMinutes
Global $AvgRunTimeSeconds
Global $AvgTime[0]

; === Create Main Window ===
Global Const $mainGui = GUICreate("Sky Froggy Farmer", 420, 680, -1, -1)
GUISetBkColor($COLOR_BG_DARK)
GUISetFont(9, 400, 0, "Segoe UI")

; === Header Section ===
GUICtrlCreateLabel("SKY FROGGY FARMER", 20, 15, 280, 28)
GUICtrlSetFont(-1, 16, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Bogroot Growths Bot v2.0", 20, 42, 200, 18)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Start Button (prominent)
Global Const $Button = GUICtrlCreateButton("START", 300, 18, 100, 40)
GUICtrlSetFont(-1, 11, 600, 0, "Segoe UI")
GUICtrlSetBkColor(-1, $COLOR_ACCENT_GREEN)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetOnEvent($Button, "GuiButtonHandler")

; === Character Selection Card ===
GUICtrlCreateLabel("", 15, 70, 390, 55)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel("CHARACTER", 25, 78, 100, 16)
GUICtrlSetFont(-1, 8, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global $Input
If $doLoadLoggedChars Then
    $Input = GUICtrlCreateCombo($charName, 25, 95, 370, 24)
    GUICtrlSetData(-1, Scanner_GetLoggedCharNames())
Else
    $Input = GUICtrlCreateCombo("Select character...", 25, 95, 370, 24, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
EndIf
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")

; === Options Card ===
GUICtrlCreateLabel("", 15, 135, 390, 115)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel("OPTIONS", 25, 143, 80, 16)
GUICtrlSetFont(-1, 8, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Left column options
Global Const $HardmodeCheckbox = GUICtrlCreateCheckbox(" Hard Mode", 25, 163, 110, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_CHECKED)

Global $chkChestFarm = GUICtrlCreateCheckbox(" Open Chests", 25, 187, 110, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetOnEvent($chkChestFarm, "ToggleChestFarm")

Global Const $Builds = GUICtrlCreateCheckbox(" Load Builds", 25, 211, 110, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)

; Middle column options
Global Const $PconsBox = GUICtrlCreateCheckbox(" Conset Stg 1", 145, 163, 110, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_CHECKED)

Global Const $PconsBox2 = GUICtrlCreateCheckbox(" Conset Stg 2", 145, 187, 110, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_CHECKED)

Global Const $RenderingBox = GUICtrlCreateCheckbox(" Rendering", 145, 211, 110, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetOnEvent(-1, "Ui_ToggleRendering")

; Right column options
Global Const $Summon1 = GUICtrlCreateCheckbox(" Summon Stg 1", 265, 163, 120, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_CHECKED)

Global Const $Summon2 = GUICtrlCreateCheckbox(" Summon Stg 2", 265, 187, 120, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_CHECKED)

; === Loot Pickup Card ===
GUICtrlCreateLabel("", 15, 260, 390, 55)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel("LOOT PICKUP", 25, 268, 100, 16)
GUICtrlSetFont(-1, 8, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global $g_bPickupSalvageArmor = False
Global $chkSalvageArmor = GUICtrlCreateCheckbox(" Salvage Armors", 25, 286, 130, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_BLUE)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetOnEvent($chkSalvageArmor, "ToggleSalvageArmor")

Global $g_bPickupTrophies = False
Global $chkTrophies = GUICtrlCreateCheckbox(" Trophies", 175, 286, 100, 22)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_PURPLE)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetOnEvent($chkTrophies, "ToggleTrophies")

; === Statistics Card ===
GUICtrlCreateLabel("", 15, 325, 390, 130)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel("STATISTICS", 25, 333, 100, 16)
GUICtrlSetFont(-1, 8, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Stats Row 1 - Run counts
GUICtrlCreateLabel("Runs", 25, 355, 60, 14)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $RunsLabel = GUICtrlCreateLabel("0", 25, 369, 60, 22)
GUICtrlSetFont(-1, 14, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Success", 105, 355, 60, 14)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $SuccessLabel = GUICtrlCreateLabel("0", 105, 369, 60, 22)
GUICtrlSetFont(-1, 14, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_GREEN)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Failed", 185, 355, 60, 14)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $FailsLabel = GUICtrlCreateLabel("0", 185, 369, 60, 22)
GUICtrlSetFont(-1, 14, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_RED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Froggy", 265, 355, 60, 14)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $FroggyLabel = GUICtrlCreateLabel("0", 265, 369, 60, 22)
GUICtrlSetFont(-1, 14, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_CYAN)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Stats Row 2 - Times
GUICtrlCreateLabel("Fastest", 25, 400, 80, 14)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $FastTimeLabel = GUICtrlCreateLabel("--:--", 25, 414, 100, 20)
GUICtrlSetFont(-1, 12, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_YELLOW)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Average", 145, 400, 80, 14)
GUICtrlSetFont(-1, 8, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $AvgTimeLabel = GUICtrlCreateLabel("--:--", 145, 414, 100, 20)
GUICtrlSetFont(-1, 12, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; === Drops Card ===
GUICtrlCreateLabel("", 15, 465, 390, 55)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel("DROPS", 25, 473, 60, 16)
GUICtrlSetFont(-1, 8, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Drops counters
GUICtrlCreateLabel("Lockpicks", 25, 491, 60, 12)
GUICtrlSetFont(-1, 7, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $LockpickLabel = GUICtrlCreateLabel("0", 25, 503, 50, 16)
GUICtrlSetFont(-1, 11, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_PRIMARY)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Golds", 105, 491, 50, 12)
GUICtrlSetFont(-1, 7, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $GoldItemsLabel = GUICtrlCreateLabel("0", 105, 503, 50, 16)
GUICtrlSetFont(-1, 11, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_YELLOW)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Salvage", 185, 491, 50, 12)
GUICtrlSetFont(-1, 7, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $SalvageLabel = GUICtrlCreateLabel("0", 185, 503, 50, 16)
GUICtrlSetFont(-1, 11, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_BLUE)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUICtrlCreateLabel("Trophies", 265, 491, 50, 12)
GUICtrlSetFont(-1, 7, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global Const $TrophiesLabel = GUICtrlCreateLabel("0", 265, 503, 50, 16)
GUICtrlSetFont(-1, 11, 700, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_ACCENT_PURPLE)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; === Console/Log Card ===
GUICtrlCreateLabel("", 15, 530, 390, 110)
GUICtrlSetBkColor(-1, $COLOR_BG_CARD)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel("CONSOLE", 25, 538, 80, 16)
GUICtrlSetFont(-1, 8, 600, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

Global $GLOGBOX = GUICtrlCreateEdit("", 25, 555, 370, 75, BitOR($ES_READONLY, $ES_MULTILINE, $ES_AUTOVSCROLL, $WS_VSCROLL))
GUICtrlSetFont(-1, 8, 400, 0, "Consolas")
GUICtrlSetColor(-1, $COLOR_TEXT_SECONDARY)
GUICtrlSetBkColor(-1, $COLOR_BG_INPUT)

; === Footer ===
GUICtrlCreateLabel("by Sky", 340, 650, 60, 18)
GUICtrlSetFont(-1, 9, 400, 2, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Status indicator
Global $StatusDot = GUICtrlCreateLabel("", 20, 653, 10, 10)
GUICtrlSetBkColor(-1, $COLOR_TEXT_MUTED)

Global $StatusLabel = GUICtrlCreateLabel("Ready", 35, 650, 100, 18)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, $COLOR_TEXT_MUTED)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Show GUI
GUISetState(@SW_SHOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "GuiButtonHandler")

; Fake label for stability
Global Const $Fakelabel = GUICtrlCreateLabel("", 0, 0, 1, 1)

; Legacy compatibility
Global Const $Group1 = 0
Global Const $Group2 = 0

; ============================================
; GUI Event Handlers
; ============================================

Func GuiButtonHandler()
    Switch @GUI_CtrlId
        Case $Button
            If $BotRunning Then
                GUICtrlSetData($Button, "STOPPING...")
                GUICtrlSetBkColor($Button, $COLOR_ACCENT_YELLOW)
                GUICtrlSetState($Button, $GUI_DISABLE)
                UpdateStatus("Stopping...", $COLOR_ACCENT_YELLOW)
                $BotRunning = False
            ElseIf $Bot_Core_Initialized Then
                GUICtrlSetData($Button, "PAUSE")
                GUICtrlSetBkColor($Button, $COLOR_ACCENT_YELLOW)
                UpdateStatus("Running", $COLOR_ACCENT_GREEN)
                $BotRunning = True
            Else
                Out("Initializing...")
                Local $CharName = GUICtrlRead($Input)
                If $CharName == "" Then
                    If Core_Initialize(ProcessExists("gw.exe"), True) = 0 Then
                        MsgBox(0, "Error", "Guild Wars is not running.")
                        _Exit()
                    EndIf
                ElseIf $ProcessID Then
                    $proc_id_int = Number($ProcessID, 2)
                    If Core_Initialize($proc_id_int, True) = 0 Then
                        MsgBox(0, "Error", "Could not find ProcessID: " & $proc_id_int)
                        _Exit()
                        If ProcessExists($proc_id_int) Then ProcessClose($proc_id_int)
                        Exit
                    EndIf
                Else
                    If Core_Initialize($CharName, True) = 0 Then
                        MsgBox(0, "Error", "Could not find character: " & $CharName)
                        _Exit()
                    EndIf
                EndIf

                ; Disable settings after start
                GUICtrlSetState($Input, $GUI_DISABLE)
                GUICtrlSetState($HardmodeCheckbox, $GUI_DISABLE)
                GUICtrlSetState($Builds, $GUI_DISABLE)

                GUICtrlSetData($Button, "PAUSE")
                GUICtrlSetBkColor($Button, $COLOR_ACCENT_YELLOW)
                WinSetTitle($mainGui, "", Player_GetCharname() & " - Sky Froggy Farmer")

                UpdateStatus("Running", $COLOR_ACCENT_GREEN)
                UpdateStatistics()

                $BotRunning = True
                $Bot_Core_Initialized = True
            EndIf

        Case $GUI_EVENT_CLOSE
            If Not $RenderingBox Then Ui_ToggleRendering()
            Exit
    EndSwitch
EndFunc

Func UpdateStatus($sText, $nColor)
    GUICtrlSetData($StatusLabel, $sText)
    GUICtrlSetColor($StatusLabel, $nColor)
    GUICtrlSetBkColor($StatusDot, $nColor)
EndFunc

Func UpdateStatistics()
    ; Update run counts
    GUICtrlSetData($RunsLabel, $RunCount)
    GUICtrlSetData($SuccessLabel, $SuccessCount)
    GUICtrlSetData($FailsLabel, $FailCount)
    GUICtrlSetData($FroggyLabel, $FroggyGained)

    ; Update times
    If $RunTimeMinutes <> "" Or $RunTimeSeconds <> "" Then
        GUICtrlSetData($FastTimeLabel, $RunTimeMinutes & ":" & StringFormat("%02d", $RunTimeSeconds))
    EndIf
    If $AvgRunTimeMinutes <> "" Or $AvgRunTimeSeconds <> "" Then
        GUICtrlSetData($AvgTimeLabel, $AvgRunTimeMinutes & ":" & StringFormat("%02d", $AvgRunTimeSeconds))
    EndIf

    ; Update drops
    GUICtrlSetData($LockpickLabel, $LockpicksGained)
    GUICtrlSetData($GoldItemsLabel, $GoldItemsGained)
    GUICtrlSetData($SalvageLabel, $SalvageArmorGained)
    GUICtrlSetData($TrophiesLabel, $TrophiesGained)
EndFunc
