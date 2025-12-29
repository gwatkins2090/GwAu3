
; Constants needed for Gui
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

Global Const $mainGui =             GUICreate("Sky Froggy Farmer", 388, 550, 191, 124)

; Buttons and Checkboxes and Characterselection
Global Const $Fighter =             GUICtrlCreateLabel("Choose your Fighter", 8, 8, 114, 19)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")

Global $Input
    If $doLoadLoggedChars Then
        $Input =                    GUICtrlCreateCombo($charName, 8, 40, 372, 25)
						            GUICtrlSetData(-1, Scanner_GetLoggedCharNames())
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
    Else
        $Input =                    GUICtrlCreateCombo("Choose your Fighter", 8, 32, 372, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
    EndIf


Global Const $HardmodeCheckbox =    GUICtrlCreateCheckbox("HM", 20, 64, 41, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState(-1, $gui_checked)

; Left column checkboxes
Global $chkChestFarm = GUICtrlCreateCheckbox("Open Chest with Lockpick", 20, 92, 180, 20)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState($chkChestFarm, $GUI_UNCHECKED)
									GUICtrlSetOnEvent($chkChestFarm, "ToggleChestFarm")

Global $g_bPickupSalvageArmor = False
Global $chkSalvageArmor = GUICtrlCreateCheckbox("Pickup Salvage Armors", 20, 112, 180, 20)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState($chkSalvageArmor, $GUI_UNCHECKED)
									GUICtrlSetOnEvent($chkSalvageArmor, "ToggleSalvageArmor")

Global $g_bPickupTrophies = False
Global $chkTrophies = GUICtrlCreateCheckbox("Pickup Trophies", 20, 132, 180, 20)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState($chkTrophies, $GUI_UNCHECKED)
									GUICtrlSetOnEvent($chkTrophies, "ToggleTrophies")

; Right column checkboxes
Global Const $PconsBox =            GUICtrlCreateCheckbox("Use conset Stage 1", 210, 64, 150, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState(-1, $gui_checked)
Global Const $PconsBox2 =           GUICtrlCreateCheckbox("Use conset Stage 2", 210, 92, 150, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState(-1, $gui_checked)


Global Const $Button =              GUICtrlCreateButton("Start", 230, 6, 150, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
                                    GUICtrlSetOnEvent($Button, "GuiButtonHandler")

; Summoning Group
Global Const $Group2 =              GUICtrlCreateGroup("Use Summoning Stone", 8, 155, 372, 50)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
Global Const $Summon1 =            GUICtrlCreateCheckbox("Stage 1", 20, 175, 200, 20)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState(-1, $gui_checked)
Global Const $Summon2 =            GUICtrlCreateCheckbox("Stage 2", 230, 175, 200, 20)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
									GUICtrlSetState(-1, $gui_checked)

; Statistics Group
Global Const $Group1 =              GUICtrlCreateGroup("Statistics", 8, 210, 372, 145)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")

Global Const $RunsLabel =           GUICtrlCreateLabel("Runs: " & $RunCount, 24, 232, 100, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
Global Const $SuccessLabel =        GUICtrlCreateLabel("Success: " & $SuccessCount, 148, 232, 100, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
                                    GUICtrlSetColor(-1, 0x006400)
Global Const $FailsLabel =          GUICtrlCreateLabel("Fails: " & $FailCount, 272, 232, 100, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
                                    GUICtrlSetColor(-1, 0x8B0000)

Global Const $FroggyLabel =     GUICtrlCreateLabel("Froggy: " & $FroggyGained, 148, 256, 200, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")

Global Const $FastTimeLabel =       GUICtrlCreateLabel("Fastest Time: " & "-", 24, 280, 150, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")

Global Const $AvgTimeLabel =        GUICtrlCreateLabel("Average Time: " & "-", 220, 280, 150, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")

Global Const $Label1 =              GUICtrlCreateLabel("_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _", 16, 296, 360, 19)
Global Const $Drops =               GUICtrlCreateLabel("Drops", 24, 316, 34, 18)
                                    GUICtrlSetFont(-1, 8, 800, 4, "Times New Roman")
Global Const $LockpickLabel =       GUICtrlCreateLabel("Lockpicks: " & $LockpicksGained, 100, 316, 80, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
Global Const $GoldItemsLabel =      GUICtrlCreateLabel("Golds: " & $GoldItemsGained, 180, 316, 60, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
                                    GUICtrlSetColor(-1, 0xDAA520)
Global Const $SalvageLabel =        GUICtrlCreateLabel("Salvage: " & $SalvageArmorGained, 245, 316, 60, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")
                                    GUICtrlSetColor(-1, 0x4169E1)
Global Const $TrophiesLabel =       GUICtrlCreateLabel("Trophies: " & $TrophiesGained, 310, 316, 65, 18)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")

                                    GUICtrlCreateGroup("", -99, -99, 1, 1)

; Output
Global $GLOGBOX =                   GUICtrlCreateEdit("", 8, 360, 372, 150)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
                                    GUICtrlSetState($GLOGBOX, $GUI_ONTOP)

; Rendering
Global Const $RenderingBox =        GUICtrlCreateCheckbox("Rendering?", 8, 515, 100, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
                                    GUICtrlSetState(-1, $gui_unchecked)
								    GUICtrlSetOnEvent(-1, "Ui_ToggleRendering")

; Build Section
Global Const $Builds =              GUICtrlCreateCheckbox("Sky's Builds?", 140, 520, 107, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")

; Copyright :)
Global Const $BubbleLabel =         GUICtrlCreateLabel("by Sky", 290, 520, 85, 25)
                                    GUICtrlSetFont(-1, 10, 400, 0, "Viner Hand ITC")

                                    GUISetState(@SW_SHOW)
                                    GUISetOnEvent($GUI_EVENT_CLOSE, "GuiButtonHandler")

; Fake Label, cause the last string is always strange
Global Const $Fakelabel =           GUICtrlCreateLabel("", 110, 520, 10, 10)
                                    GUICtrlSetFont(-1, 8, 800, 0, "Times New Roman")

                                    GUISetState(@SW_SHOW)
                                    GUISetOnEvent($GUI_EVENT_CLOSE, "GuiButtonHandler")


; Description: Handles the Button Press
Func GuiButtonHandler()
    Switch @GUI_CtrlId

        ; Startbutton Press
        Case $Button
            If $BotRunning Then
				GUICtrlSetData($Button, "Will pause after this run")
                GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
				GUICtrlSetState($Button, $GUI_DISABLE)
				$BotRunning = False
			ElseIf $Bot_Core_Initialized Then
				GUICtrlSetData($Button, "Pause")
                GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
				$BotRunning = True
			Else
				Out("Initializing")
				Local $CharName = GUICtrlRead($Input)
				If $CharName=="" Then
					If Core_Initialize(ProcessExists("gw.exe"), True) = 0 Then
						MsgBox(0, "Error", "Guild Wars is not running.")
						_Exit()
					EndIf
                ElseIf $ProcessID Then
					$proc_id_int = Number($ProcessID, 2)
					If Core_Initialize($proc_id_int, True) = 0 Then
						MsgBox(0, "Error", "Could not Find a ProcessID or somewhat '"&$proc_id_int&"'  "&VarGetType($proc_id_int)&"'")
						_Exit()
						If ProcessExists($proc_id_int) Then
							ProcessClose($proc_id_int)
						EndIf
						Exit
					EndIf
				Else
					If Core_Initialize($CharName, True) = 0 Then
						MsgBox(0, "Error", "Could not Find a Guild Wars client with a Character named '"&$CharName&"'")
						_Exit()
					EndIf
				EndIf

                ; When Start is first clicked this will happen
                ; Disable and Enable Certain Features and Buttons on the Gui
				GUICtrlSetState($RenderingBox, $GUI_ENABLE) ; can change the rendering checkbox
				GUICtrlSetState($Input, $GUI_DISABLE)   ; can't change the Character Name
                GUICtrlSetState($HardmodeCheckbox, $GUI_DISABLE)  ; can't change Hard- or Normalmode
                GUICtrlSetState($Builds, $GUI_DISABLE)  ; can't change the Option for using Bubbles Builds
                GUICtrlSetState($PconsBox, $GUI_ENABLE)  ; can't change Using Pcons or not

				GUICtrlSetData($Button, "Pause")
                GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
				WinSetTitle($mainGui, "", Player_GetCharname() & " - Sky Froggy Bot Farmer")

                ; Update the Numbers for Statistics on the first Page of the Gui
                UpdateStatistics()


				$BotRunning = True
				$Bot_Core_Initialized = True
			EndIf

        Case $GUI_EVENT_CLOSE
            If Not $RenderingBox Then Ui_ToggleRendering()
            Exit
    EndSwitch

EndFunc

Func UpdateStatistics()
    ; Update the Statistics on the first Page of the Gui
    GUICtrlSetData($RunsLabel, "Runs: " & $RunCount)
    GUICtrlSetData($SuccessLabel, "Success: " & $SuccessCount)
    GUICtrlSetData($FailsLabel, "Fails: " & $FailCount)
    GUICtrlSetData($FastTimeLabel, "Fastest Time: " & $RunTimeMinutes & " min  " & $RunTimeSeconds & " sec")
    GUICtrlSetData($AvgTimeLabel, "Average Time: " & $AvgRunTimeMinutes & " min  " & $AvgRunTimeSeconds & " sec")
    GUICtrlSetData($LockpickLabel, "Lockpicks: " & $LockpicksGained)
    GUICtrlSetData($GoldItemsLabel, "Golds: " & $GoldItemsGained)
    GUICtrlSetData($SalvageLabel, "Salvage: " & $SalvageArmorGained)
    GUICtrlSetData($TrophiesLabel, "Trophies: " & $TrophiesGained)
EndFunc
