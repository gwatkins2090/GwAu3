#cs
    Froggy Farm Bot
    =====================
    Automatisation du farm Bogroot (Froggy)
    Auteur : Sky
#ce

#RequireAdmin
#include "YOURPATH\GwAu3\API\_GwAu3.au3"
#include "YOURPATH\GwAu3\Scripts\AddOns\GwAu3_AddOns_Froggy.au3"

; === Options ===
Global Const $doLoadLoggedChars = True
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
Opt("ExpandVarStrings", 1)

; === Globals ===
Global $charName = ""
Global $ProcessID = ""
Global $timer = TimerInit()
Global $EnableChestFarm = False
Global $BotRunning = False
Global $Bot_Core_Initialized = False
Global $g_bAutoStart = False

; ===========================================
#Region === Initialization & GUI ===
; ===========================================

; Parse command line args
For $i = 1 To $CmdLine[0]
    If $CmdLine[$i] = "-character" And $i < $CmdLine[0] Then
        $charName = $CmdLine[$i + 1]
        $g_bAutoStart = True
        ExitLoop
    EndIf
Next

; ------------- GUI --------------
#include "YOURPATH\GwAu3\Scripts\GUI\Gui_Froggy.au3"

; Auto-start logic if character name was provided via command line
If $g_bAutoStart And $charName <> "" Then
    Out("Auto-starting bot for character: " & $charName)

    If Core_Initialize($charName, True) = 0 Then
        MsgBox(0, "Error", "Could not Find a Guild Wars client with a Character named '" & $charName & "'")
        _Exit()
    EndIf

    Local $hGWWindow = Core_GetGuildWarsWindow()
    If $hGWWindow <> 0 Then
        ControlSend($hGWWindow, '', '', '{Enter}')
        Out("Sent Enter key to load character")
        Sleep(3000)
    Else
        Out("Warning: Could not get Guild Wars window handle")
    EndIf

    $Bot_Core_Initialized = True
    $BotRunning = True

    GUICtrlSetData($Button, "Pause")
    GUICtrlSetFont(-1, 10, 400, 0, "Times New Roman")
    WinSetTitle($mainGui, "", Player_GetCharname() & " - Sky Froggy Bot Farmer")

    GUICtrlSetState($Builds, $GUI_CHECKED)
    GUICtrlSetState($RenderingBox, $GUI_ENABLE)
    GUICtrlSetState($Input, $GUI_DISABLE)
    GUICtrlSetState($HardmodeCheckbox, $GUI_DISABLE)
    GUICtrlSetState($Builds, $GUI_DISABLE)

    UpdateStatistics()
EndIf

While Not $BotRunning
    Sleep(100)
WEnd

While True
    If $BotRunning Then
	Friend_SetOfflineStatus()	
	Out("OFFLINE MODE")
        MainFarm()
    Else
        Sleep(1000)
    EndIf
WEnd


; ===========================================
#Region === Core Farming Loop ===
; ===========================================
Func MainFarm()
    Setup()
    GoToDungeon()
    TakeQuest()
    EnterFirstRun()
    CombatLoop()
EndFunc ;==> MainFarm

; =============================
; Function: Setup
; =============================
Func Setup()

	
    ; Load builds on first run
    If GUICtrlRead($Builds) = $GUI_CHECKED And $RunCount = 0 And $Buildsloaded = 0 Then
        Out("Travelling to Great Temple of Balthazar")
		Sleep(5000)
        RndTravel($Town_ID_Great_Temple_of_Balthazar)
        Sleep(2000)

        ; Reset heroes
        Party_KickAllHeroes()
        Sleep(250)

        Out("Player skillbar loaded")

        ; === Add Heroes & Load Skillbars ===
        Out("Add Heroes")

        ; Livia
        Party_AddHero($HERO_ID_Olias)
        Sleep(500)
        Out("Load Livia's Skillbar")
        Attribute_LoadSkillTemplate("OAhjYYHbIPP1qqdwSUGmcSTrKA", 1)
        Sleep(500)
        Party_SetHeroAggression(1, 0)
        Sleep(500)
        Out("Livia ready!")

        ; Norgu
        Party_AddHero($HERO_ID_Norgu)
        Sleep(500)
        Out("Load Norgu's Skillbar")
        Attribute_LoadSkillTemplate("OQhkAgBsgGK0LAJQeWOgpDCYRwFD", 2)
        Sleep(500)
        Party_SetHeroAggression(2, 0)
        Sleep(500)
        Out("Norgu ready!")

        ; Olias
        Party_AddHero($HERO_ID_Livia)
        Sleep(500)
        Out("Load Olias's Skillbar")
        Attribute_LoadSkillTemplate("OANEUshd9JJHUFQFoAWVFQY0sFC", 3)
        Sleep(500)
        Party_SetHeroAggression(3, 0)
        Sleep(500)
        Out("Olias ready!")

        ; Razah
        Party_AddHero($HERO_ID_Razah)
        Sleep(500)
        Out("Load Razah's Skillbar")
        Attribute_LoadSkillTemplate("OQhkAsC8gFKDNY6lDMd40hQG4iB", 4)
        Sleep(500)
        Party_SetHeroAggression(4, 0)
        Sleep(500)
        Out("Razah ready!")

        ; Xandra
        Party_AddHero($HERO_ID_Xandra)
        Sleep(500)
        Out("Load Xandra's Skillbar")
        Attribute_LoadSkillTemplate("OAOj8YgM5OYTrX48xBNRuOzACA", 5)
        Sleep(500)
        Party_SetHeroAggression(5, 1)
        Sleep(500)
        Out("Xandra ready!")

        ; Master of Whispers
        Party_AddHero($HERO_ID_Master)
        Sleep(500)
        Out("Load Master of Whisper's Skillbar")
        Attribute_LoadSkillTemplate("OAhjQkGZIT3BVVCPSTTODTjTciA", 6)
        Sleep(500)
        Party_SetHeroAggression(6, 1)
        Sleep(500)
        Out("Master of Whisper ready!")

        ; Gwen
        Party_AddHero($HERO_ID_Gwen)
        Sleep(500)
        Out("Load Gwen's Skillbar")
        Attribute_LoadSkillTemplate("OQhkAsC8gFKzJY6lDMd40hQG4iB", 7)
        Sleep(500)
        Party_SetHeroAggression(7, 1)
        Sleep(500)
        Out("Gwen ready!")

        $Buildsloaded = 1
    EndIf

    ; Travel to Gadd’s Encampment
    If Map_GetMapID() <> $iGaddsEncampmentMapID Then


        If $Stucktimer = 0 Then
            If $mapindicator = 1 Then
                Sleep(200)
                $mapindicator = 0
				        Out("Travelling to Gadd's Camp")
                RndTravel($iGaddsEncampmentMapID)
            Else
                Sleep(200)
                $mapindicator = 1
				        Out("Travelling to Gadd's Camp")
                RndTravel2($iGaddsEncampmentMapID)
            EndIf
        Else
            $mapindicator = 0
			        Out("Travelling to Gadd's Camp")
            RndTravel($iGaddsEncampmentMapID)
        EndIf

        Sleep(2000)
    EndIf
	        If CountSlots() < 5 Then
            Out("Inventaire plein, arrêt du farm")
            Inventory()
        EndIf
    ; HardMode
    If GUICtrlRead($HardmodeCheckbox) = $GUI_CHECKED Then
        Game_SwitchMode($DIFFICULTY_HARD)
    Else
        Game_SwitchMode($DIFFICULTY_NORMAL)
    EndIf
	
	    ; === Clear Quest ===
;    Quest_AbandonQuest(0x339)
;    Out("Quest Cleared")


EndFunc ;==> Setup


; =============================
; Function: GoToDungeon
; =============================
Func GoToDungeon()
    Local $Stucktimer = TimerInit()

    ; === Exit to Map ===
    MoveTo(-9451, -19766)
    Out("Going Out")
    Do
        Sleep(1000)
    Until Map_GetMapID() == $iSplarkflyMapID
    Sleep(1000)

    ; === Get Asura Blessing ===
    Out("Moving to Asura beacon")
DoStep(1,-8950.00, -19843)
    Out("Getting Asura Blessing")
    Sleep(250)
    Agent_GoNPC(GetNearestNPCToAgent(-2))
    Sleep(2000)
    Ui_Dialog(0x84)
    Sleep(1000)

; === Waypoints ===
DoStep(2, -8881, -18176, "move")
DoStep(3, -9557, -17429, "aggro")
DoStep(4, -10212, -16670, "aggro")
DoStep(5, -10625, -15755, "aggro")
DoStep(6, -10910, -14792, "aggro")
DoStep(7, -11164, -13824, "aggro")
DoStep(8, -11293, -12829, "aggro")
DoStep(9, -11268, -11828, "aggro")
DoStep(10, -11046, -10847, "aggro")
DoStep(11, -10371, -10103, "aggro")
DoStep(12, -9976, -9180, "aggro")
DoStep(13, -9667, -8221, "aggro")
DoStep(14, -9371, -7257, "aggro")
DoStep(15, -8808, -6429, "aggro")
DoStep(16, -8025, -5803, "aggro")
DoStep(17, -7228, -5197, "aggro")
DoStep(18, -6483, -4516, "aggro")
DoStep(19, -5803, -3775, "aggro")
DoStep(20, -5119, -3033, "aggro")
DoStep(21, -4271, -2488, "aggro")
DoStep(22, -3291, -2251, "aggro")
DoStep(23, -2497, -1638, "aggro")
DoStep(24, -1775, -943, "aggro")
DoStep(25, -1028, -270, "aggro")
DoStep(26, -283, 401, "aggro")
DoStep(27, 450, 1089, "aggro")
DoStep(28, 766, 2046, "aggro")
DoStep(29, 1130, 2979, "aggro")
DoStep(30, 1783, 3742, "aggro")
DoStep(31, 2490, 4457, "aggro")
DoStep(32, 3286, 5065, "aggro")
DoStep(33, 3954, 5820, "aggro")
DoStep(34, 4548, 6627, "aggro")
DoStep(35, 5048, 7493, "aggro")
DoStep(36, 5706, 8256, "aggro")
DoStep(37, 6506, 8859, "aggro")
DoStep(38, 7064, 9691, "aggro")
DoStep(39, 7469, 10606, "aggro")
DoStep(40, 7919, 11508, "aggro")
DoStep(41, 8454, 12357, "aggro")
DoStep(42, 9316, 12867, "aggro")
DoStep(43, 10286, 13137, "aggro")
DoStep(44, 11249, 13414, "aggro")
DoStep(45, 12022, 14050, "aggro")
DoStep(46, 12750, 14748, "aggro")
DoStep(47, 12900, 15740, "aggro")
DoStep(48, 13191, 16700, "aggro")
DoStep(49, 13376, 17688, "aggro")
DoStep(50, 13535, 18679, "aggro")
DoStep(51, 13558, 19682, "aggro")
DoStep(52, 13442, 20682, "aggro")
DoStep(53, 12592, 21216, "aggro")
DoStep(54, 12396, 22407, "aggro")

EndFunc ;==> GoToDungeon


; =============================
; Function: TakeQuest
; =============================
Func TakeQuest()
    Local $questID = 0x339
    Sleep(250)


    ; --- Cas 1 : Quête peut être récompensée ---
    If Quest_GetQuestInfo($questID, "IsCompleted") Then
        Out("Quest can be rewarded at Tekks, completing it ✅")
        Agent_GoNPC(GetNearestNPCToAgent(-2))
        Sleep(500)
        HandleTekks("reward", $questID)
        ReloadQuest()
        TakeQuestNewRun()
        Re_Enter()

    ; --- Cas 2 : Quête active mais incomplète ---
    ElseIf Quest_GetQuestInfo($questID, "QuestID") Then
        Out("Quest in progress at Tekks 📜")
		    ; Déplacement vers Tekks
    MoveTo(12509.11, 22640.00)
        Agent_GoNPC(GetNearestNPCToAgent(-2))
        Sleep(500)
        Ui_Dialog(0x833905) ; Juste pour interagir/dialoguer

    ; --- Cas 3 : Quête pas dans le journal ---
    Else
        Out("Quest not yet accepted at Tekks, taking it now 📜")
        Agent_GoNPC(GetNearestNPCToAgent(-2))
        Sleep(500)
        HandleTekks("take", $questID)
    EndIf

    Sleep(500)
EndFunc ;==> TakeQuest



Func CombatLoop()
    Out("Starting Froggy Farm")

    While $BotRunning
        ; ===============================
        ; Vérification inventaire
        ; ===============================
        If CountSlots() < 5 Then
            Out("Inventaire plein, arrêt du farm")
            Inventory()
            ExitLoop
        EndIf

        ; ===============================
        ; Gestion intelligente de la quête
        ; ===============================
        Local $questID = 0x339

        If Quest_GetQuestInfo($questID, "IsCompleted") Then
            ; Quête terminée → rendre, recharger, reprendre
            HandleTekks("reward", $questID)
            ReloadQuest()
            TakeQuestNewRun()
            Re_Enter()

        ElseIf Not Quest_GetQuestInfo($questID, "QuestID") Then
            ; Quête absente du log → la reprendre
            HandleTekks("take", $questID)
            Re_Enter()
        EndIf

        ; ===============================
        ; Lancer un run complet
        ; ===============================
        ResetRun()
        FirstStage()
        SecondStage()
        LastStep()

        ; ===============================
        ; Comptabilisation du run
        ; ===============================
        If Agent_GetAgentInfo(-2, "IsDead") Then
            $FailCount += 1
            Out("Run échoué !")
        Else
            $SuccessCount += 1
        EndIf

        $RunCount += 1
        GUICtrlSetData($RunsLabel, "Runs: " & $RunCount)
        UpdateStatistics()
        Sleep(2000)
    WEnd
EndFunc




; ===========================================
#Region === Stages ===
; ===========================================
Func EnterFirstRun()
    Do
        MoveTo(11676.01, 22685)
        MoveTo(11562.77, 24059)
        MoveTo(13097, 26393)
    Until Map_GetMapID() = $iBogrootGrowthsLevel1MapID
Out("Enter !!")
    If Map_GetMapID() = $iBogrootGrowthsLevel1MapID Then
        Out("Mission Map loaded")
        Sleep(2000)
        Out("Dungeon Ready")
    Else
        Out("Mission Map not loaded")
    EndIf
EndFunc ;==> EnterFirstRun


Func FirstStage()
    $RunTimer = TimerInit() ; ✅ Start chrono
; === Vérifier si la quête est active ===
    Local $questID = 0x339 ; ID de la quête
    If Not Quest_GetQuestInfo($questID, "QuestID") Then
        ; Si la quête n'est pas active, on reprend la quête et réentre dans le donjon
        RetakeQuest()
        Return ; Sortir de la fonction pour éviter d'exécuter le reste avant de retourner dans le donjon
    EndIf

; Si la quête est active, on continue normalement
If Map_GetMapID() <> $iBogrootGrowthsLevel1MapID Then
    Do
        Sleep(500)
    Until Map_GetMapID() == $iBogrootGrowthsLevel1MapID
EndIf

	    Out("Aggro Frog Fight")
    DoStep(1, 18092, 4315, "aggro")
	Out("Moving to Beacon of Droknar")
    DoStep(2, 19045.95, 7877, "aggro")
    Out("Getting Dwarven Blessing")
    Agent_GoNPC(GetNearestNPCToAgent(-2))
    Sleep(1000)
    Ui_Dialog(0x84)
    Sleep(1000)
	Powerup()
	
    $ChestFarmActive = True
	
DoStep(4, 17666, 8087, "aggro")
DoStep(5, 16566, 8348, "aggro")
DoStep(6, 15272, 8352, "aggro")
DoStep(7, 13896, 7946, "aggro")
DoStep(8, 12482, 7082, "aggro")
DoStep(9, 11110, 6693, "aggro")
DoStep(10, 10439, 7643, "aggro")
DoStep(11, 9923, 8545, "aggro")
DoStep(12, 9715, 7454, "aggro")
DoStep(13, 8362, 6900, "aggro")
DoStep(14, 7847, 7881, "aggro")
DoStep(15, 7025, 6945, "aggro")
DoStep(16, 7662, 6016, "aggro")
DoStep(17, 6404, 5006, "aggro")
DoStep(18, 5750, 3860, "aggro")
DoStep(19, 5083, 2155, "aggro")
Out("Getting Dwarven Blessing")
Sleep(1000)
Agent_GoNPC(GetNearestNPCToAgent(-2))
DoStep(20, 4236, 1484, "aggro")
DoStep(21, 2698, 724, "aggro")
DoStep(22, 1243, -65, "aggro")
DoStep(23, 345, -1485, "aggro")
DoStep(24, -458, -3024, "aggro")
DoStep(25, -525, -4092, "aggro")
DoStep(26, -1104, -5308, "aggro")
DoStep(27, -641, -6726, "aggro")
DoStep(28, -586.44, -7221, "aggro")
DoStep(29, -99.85, -8510, "aggro")
DoStep(30, -1547, -8696, "aggro")
Out("Getting Dwarven Blessing")
Sleep(1000)
Agent_GoNPC(GetNearestNPCToAgent(-2))
DoStep(31, -99.85, -8510, "aggro")
DoStep(32, 922, -9647, "aggro")
DoStep(33, 1868, -10647, "aggro")
DoStep(34, 1645, -11810, "aggro")
DoStep(35, 1207, -13385, "aggro")
DoStep(36, 1238, -14841, "aggro")
DoStep(37, 2870, -15402, "aggro")
DoStep(38, 4398, -16213, "aggro")
DoStep(39, 6041, -16748, "aggro")
DoStep(40, 7017, -17023, "aggro")
DoStep(41, 7217, -17723, "aggro")
MoveTo(7865, -19350)


; Transition vers étage suivant
Out("FirstStage : Check")
Out("Travelling to Bogroot Growths - Level 2")
$ChestFarmActive = False	

EndFunc ;==> FirstStage


Func SecondStage()
	Map_WaitMapLoading($iBogrootGrowthsLevel2MapID)
; 🔑 Sécurité : si on a déjà changé de map, on sort direct
; Si la quête est active, on continue normalement
If Map_GetMapID() <> $iBogrootGrowthsLevel2MapID Then
    Do
        Sleep(2000)
    Until Map_GetMapID() == $iBogrootGrowthsLevel2MapID
EndIf
Out("✅ Bogroot Growths - Level 2 : Uploaded !")
    $ChestFarmActive = True
	Out("Moving to Beacon of Droknar")
DoStep(42, -11055, -5551, "move")
	Sleep(1000)
    Out("Getting Dwarven Blessing")
    Agent_GoNPC(GetNearestNPCToAgent(-2))
    Sleep(1000)
    Ui_Dialog(0x84)
    Sleep(1000)
    Powerup2()
    
     ; === Level 2 ===   
 Out("Cleaning First Room")    
DoStep(43, -11522, -3486, "aggro")
DoStep(44, -10639, -4076, "aggro")
DoStep(45, -11321, -5033, "aggro")
DoStep(46, -11268, -3922, "aggro")
DoStep(47, -11187, -2190, "aggro")
DoStep(48, -10706, -1272, "aggro")
DoStep(49, -10535, -191, "aggro")
DoStep(50, -10262, -1167, "aggro")
DoStep(51, -9390, -393, "aggro")
DoStep(52, -8427, 1043, "aggro")
DoStep(53, -7297, 2371, "aggro")
DoStep(54, -6460, 2964, "aggro")
DoStep(55, -5173, 3621, "aggro")
DoStep(56, -4225, 4452, "aggro")
DoStep(57, -3405, 5274, "aggro")
DoStep(58, -2778, 6814, "aggro")
DoStep(59, -3725, 7823, "aggro")
DoStep(60, -3627, 8933, "aggro")
DoStep(61, -3014, 10554, "aggro")
DoStep(62, -1604, 11789, "aggro")
    DoStep(63, -955, 10984, "aggro")
	Out("Getting Dwarven Blessing")
	Sleep(1000)
    Agent_GoNPC(GetNearestNPCToAgent(-2))
DoStep(64, 216, 11534, "aggro")
DoStep(65, 1485, 12022, "aggro")
DoStep(66, 2690, 12615, "aggro")
DoStep(67, 3343, 13721, "aggro")
DoStep(68, 4693, 13577, "aggro")
DoStep(69, 5693, 12927, "aggro")
DoStep(70, 5942, 11067, "aggro")
DoStep(71, 6878, 9657, "aggro")
DoStep(72, 6890, 7938, "aggro")
DoStep(73, 7485, 6406, "aggro")
DoStep(74, 9234.03, 6843, "aggro")
	Out("Kill Patriarch")
    DoStep(75, 8591, 4285, "aggro")
		Out("Getting Dwarven Blessing")
	Sleep(1000)
    Agent_GoNPC(GetNearestNPCToAgent(-2))
DoStep(76, 8372, 3448, "aggro")
DoStep(77, 8714, 2151, "aggro")
DoStep(78, 9268, 1261, "aggro")
DoStep(79, 10207, -201, "aggro")
DoStep(80, 10999, -1356, "aggro")
DoStep(81, 10593, -2846, "aggro")
DoStep(82, 10280, -4144, "aggro")
DoStep(83, 11016, -5384, "aggro")
DoStep(84, 12943, -6511, "aggro")
DoStep(85, 15127, -6231, "aggro")
	Out("Kill Patriarch")
DoStep(86, 16461, -6041, "aggro")
DoStep(87, 17565, -6227, "aggro")
ClearEnemiesInCompass()
    Sleep(2000)
    PickupLoot()
    Sleep(500)
    Out("SecondStage : Check")
EndFunc ;==> SecondStage

Func LastStep()
    ; === Boss Door Opening ===
    PickupLoot()
    Out("Open Boss Door")
MoveTo(17922.00, -6241)	

    Sleep(1000)
	Agent_GoSignpost(GetNearestSignpostToAgent(-2))
	Sleep(250)	
	Agent_GoSignpost(GetNearestSignpostToAgent(-2))
	Sleep(250)
	Agent_GoSignpost(GetNearestSignpostToAgent(-2))
	Sleep(500)
    Out("Door Opened")
    
    ; === Boss Waypoints ===    
DoStep(88, 17623.87, -6546, "move")	
DoStep(89, 18024, -9191, "aggro")
DoStep(90, 17110, -9842, "aggro")
DoStep(91, 15867, -10866, "aggro")
DoStep(92, 17555, -11963, "aggro")
DoStep(93, 18761, -12747, "aggro")
    DoStep(94, 19619, -11498, "aggro")
	Out("Getting Dwarven Blessing")
	Sleep(1000)
    Agent_GoNPC(GetNearestNPCToAgent(-2))
DoStep(95, 17582.52, -14231, "aggro")
DoStep(96, 14794.47, -14929, "aggro")
DoStep(97, 13609.12, -17286, "aggro")
DoStep(98, 14079.80, -17776, "aggro")
DoStep(99, 15116.40, -18733, "aggro")

    ; === Boss Fight Loop ===
    ClearEnemiesInCompass()

    ; === Chest & Loot ===
    Out("Bogroot Chest")
    MoveTo(14982.66, -19122)
    Sleep(1000)
    Agent_GoSignpost(GetNearestSignpostToAgent(-2))
    Sleep(2000)



    ; ✅ Calcul du temps du run
    $RunTime = TimerDiff($RunTimer)
    $RunTimeCalc = Round($RunTime / 1000)

    ; On stocke dans la liste des temps pour les stats
    ReDim $AvgTime[UBound($AvgTime) + 1]
    $AvgTime[UBound($AvgTime) - 1] = $RunTimeCalc

    ; Mise à jour des stats
    CalculateFastestTime()
    CalculateAverageTime()

    ; ✅ Affichage console + GUI
    Out("Run réussi en " & $RunTimeCalc & "s")
    GUICtrlSetData($FastTimeLabel, "Fastest Time: " & $RunTimeMinutes & " min  " & $RunTimeSeconds & " sec")
    GUICtrlSetData($AvgTimeLabel, "Average Time: " & $AvgRunTimeMinutes & " min  " & $AvgRunTimeSeconds & " sec")

    Out("Pick Up Drops")
    PickupLoot()

    Out("Wait for Reload")
    $ChestFarmActive = False
Local $questID = 0x339

    MoveTo(14497.64, -17438) ; position approximative Tekks
    HandleTekks("reward", $questID)  ; 		
	    Do
        Sleep(500)
    Until Map_GetMapID() == $iSplarkflyMapID
Sleep(2000)
EndFunc ;==> LastStep


#EndRegion Stages

; ===========================================
#Region === Quest section ===
; ===========================================

Func TakeQuestNewRun()
    Local $questID = 0x339
    Out("Starting next run")

    If Map_GetMapID() == $iSplarkflyMapID Then
        Out("Map Loaded : Go to Tekks")
    EndIf
    MoveTo(11676.01, 22685)
    MoveTo(12490.82, 22420)
	    
    HandleTekks("take", $questID)
    Sleep(500)
EndFunc

Func ReloadQuest()
    Out("Setup Next Run")
    Re_Enter()
    Sleep(2000)
    Out("Going Out")
    MoveTo(14718.64, 402.43)
EndFunc

Func RetakeQuest()
    Out("Another try")
	    Out("Going Out")
    MoveTo(14718.64, 402.43)
	    Sleep(2000)
	TakeQuestNewRun()	
    Re_Enter()
    Sleep(2000)
EndFunc

Func Re_Enter()
    Out("Re-entering dungeon via portal")
    MoveTo(11676.01, 22685)
    MoveTo(11562.77, 24059)
    MoveTo(13130.04, 26467.22)
Out("Enter !!")	
    Do
        Sleep(4000)
    Until Map_GetMapID() == $iBogrootGrowthsLevel1MapID
    Out("Map Completly Loaded")
EndFunc
#EndRegion Quest