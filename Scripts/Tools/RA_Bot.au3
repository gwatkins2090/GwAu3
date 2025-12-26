#cs ----------------------------------------------------------------------------
    RA Bot - Random Arenas Bot
    Migrated from test.au3 to use the new GwAu3 API
    FIXED VERSION - Based on working Froggy bot patterns
    Now with GUI for visibility
#ce ----------------------------------------------------------------------------

#RequireAdmin
#include "../../API/_GwAu3.au3"

; GUI Options
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)

#Region Configuration
; Character name to connect to (empty string = first found GW process)
Global $g_s_CharName = ""

; Map constants
Global Const $MAP_RA_OUTPOST = $GC_I_MAP_ID_RANDOM_ARENAS_OUTPOST ; 188

; Combat ranges
Global Const $RANGE_ADJACENT = 166
Global Const $RANGE_NEARBY = 252
Global Const $RANGE_EARSHOT = 1012
Global Const $RANGE_SPIRIT = 2500
Global Const $RANGE_CAST = 1320
Global Const $RANGE_LONGBOW = 1250

; HP thresholds for healing priorities
Global Const $HP_CRITICAL = 0.40
Global Const $HP_LOW = 0.60
Global Const $HP_MEDIUM = 0.80

; Kiting settings
Global Const $KITE_HP_THRESHOLD = 0.50
Global Const $KITE_DISTANCE = 300

; Skill configuration - [Slot, TargetType (0=self, 1=other), HPThreshold, Priority]
Global $g_a_HealSkills[4][4]
$g_a_HealSkills[0][0] = 1
$g_a_HealSkills[0][1] = 1
$g_a_HealSkills[0][2] = 0.70
$g_a_HealSkills[0][3] = 1
$g_a_HealSkills[1][0] = 2
$g_a_HealSkills[1][1] = 1
$g_a_HealSkills[1][2] = 0.50
$g_a_HealSkills[1][3] = 2
$g_a_HealSkills[2][0] = 3
$g_a_HealSkills[2][1] = 0
$g_a_HealSkills[2][2] = 0.60
$g_a_HealSkills[2][3] = 1
$g_a_HealSkills[3][0] = 4
$g_a_HealSkills[3][1] = 1
$g_a_HealSkills[3][2] = 0.80
$g_a_HealSkills[3][3] = 0

Global $g_a_DamageSkills[4] = [5, 6, 7, 8]

; Timing
Global Const $LOOP_DELAY = 50
Global Const $CAST_DELAY = 250
#EndRegion Configuration

#Region Global Variables
Global $g_b_Running = False
Global $g_b_Initialized = False
Global $g_i_RoundCount = 0
Global $g_a_Allies[1]
Global $g_a_Enemies[1]
Global $g_i_MyID = 0
Global $g_i_MyTeam = 0
Global $g_f_MyX = 0
Global $g_f_MyY = 0
Global $g_f_MyHP = 1.0
Global $g_i_LastSkillTime = 0
Global Const $SKILL_AFTERCAST = 500
#EndRegion Global Variables

#Region GUI
; Create main window
Global $g_h_MainGui = GUICreate("RA Bot", 400, 350)

; Status label
Global $g_h_StatusLabel = GUICtrlCreateLabel("Status: Not Connected", 10, 10, 380, 20)
GUICtrlSetFont(-1, 10, 800)

; Character selection
GUICtrlCreateLabel("Character:", 10, 40, 70, 20)
Global $g_h_CharCombo = GUICtrlCreateCombo("", 80, 38, 200, 25)
GUICtrlSetData($g_h_CharCombo, Scanner_GetLoggedCharNames())

; Buttons
Global $g_h_ConnectBtn = GUICtrlCreateButton("Connect", 290, 36, 100, 25)
GUICtrlSetOnEvent($g_h_ConnectBtn, "OnConnectClick")

Global $g_h_StartBtn = GUICtrlCreateButton("Start Bot", 10, 70, 100, 30)
GUICtrlSetOnEvent($g_h_StartBtn, "OnStartClick")
GUICtrlSetState($g_h_StartBtn, $GUI_DISABLE)

Global $g_h_StopBtn = GUICtrlCreateButton("Stop Bot", 120, 70, 100, 30)
GUICtrlSetOnEvent($g_h_StopBtn, "OnStopClick")
GUICtrlSetState($g_h_StopBtn, $GUI_DISABLE)

; Stats
GUICtrlCreateGroup("Statistics", 10, 110, 380, 50)
Global $g_h_RoundsLabel = GUICtrlCreateLabel("Rounds: 0", 20, 130, 100, 20)
Global $g_h_WinsLabel = GUICtrlCreateLabel("State: Idle", 150, 130, 230, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)

; Log box
GUICtrlCreateGroup("Log", 10, 165, 380, 175)
Global $g_h_LogBox = GUICtrlCreateEdit("", 20, 185, 360, 145, BitOR($ES_READONLY, $ES_MULTILINE, $ES_AUTOVSCROLL, $WS_VSCROLL))
GUICtrlSetFont($g_h_LogBox, 9, 400, 0, "Consolas")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; Window close event
GUISetOnEvent($GUI_EVENT_CLOSE, "OnGuiClose")

; Show window
GUISetState(@SW_SHOW)
#EndRegion GUI

#Region Logging
Func Out($a_s_Message)
    Local $l_s_Time = "[" & @HOUR & ":" & @MIN & ":" & @SEC & "] "
    Local $l_s_Current = GUICtrlRead($g_h_LogBox)

    ; Keep log from getting too long (last 50 lines)
    Local $l_a_Lines = StringSplit($l_s_Current, @CRLF, 1)
    If $l_a_Lines[0] > 50 Then
        Local $l_s_New = ""
        For $i = $l_a_Lines[0] - 49 To $l_a_Lines[0]
            If $l_a_Lines[$i] <> "" Then $l_s_New &= $l_a_Lines[$i] & @CRLF
        Next
        $l_s_Current = $l_s_New
    EndIf

    GUICtrlSetData($g_h_LogBox, $l_s_Current & $l_s_Time & $a_s_Message & @CRLF)

    ; Scroll to bottom
    Local $h_Edit = GUICtrlGetHandle($g_h_LogBox)
    _GUICtrlEdit_Scroll($h_Edit, $SB_SCROLLCARET)

    ; Also write to console for debugging
    ConsoleWrite($l_s_Time & $a_s_Message & @CRLF)
EndFunc
#EndRegion Logging

#Region GUI Event Handlers
Func OnGuiClose()
    $g_b_Running = False
    Exit
EndFunc

Func OnConnectClick()
    Out("Connecting to Guild Wars...")

    Local $l_s_CharName = GUICtrlRead($g_h_CharCombo)
    Local $l_h_Window

    If $l_s_CharName = "" Then
        ; Use first found GW process
        Local $l_i_ProcessID = ProcessExists("gw.exe")
        If $l_i_ProcessID = 0 Then
            Out("ERROR: Guild Wars is not running!")
            MsgBox(16, "Error", "Guild Wars is not running!")
            Return
        EndIf
        Out("Found GW process: " & $l_i_ProcessID)
        $l_h_Window = Core_Initialize($l_i_ProcessID, True)
    Else
        Out("Connecting to character: " & $l_s_CharName)
        $l_h_Window = Core_Initialize($l_s_CharName, True)
    EndIf

    If $l_h_Window = 0 Then
        Out("ERROR: Failed to connect to Guild Wars!")
        MsgBox(16, "Error", "Failed to connect to Guild Wars!")
        Return
    EndIf

    $g_b_Initialized = True
    Local $l_s_CharName = Player_GetCharname()
    Out("Connected to: " & $l_s_CharName)

    GUICtrlSetData($g_h_StatusLabel, "Status: Connected - " & $l_s_CharName)
    GUICtrlSetState($g_h_StartBtn, $GUI_ENABLE)
    GUICtrlSetState($g_h_ConnectBtn, $GUI_DISABLE)
    GUICtrlSetState($g_h_CharCombo, $GUI_DISABLE)

    ; Show current location
    Local $l_i_MapID = Map_GetMapID()
    Out("Current Map ID: " & $l_i_MapID)
EndFunc

Func OnStartClick()
    If Not $g_b_Initialized Then
        Out("ERROR: Not connected to Guild Wars!")
        Return
    EndIf

    $g_b_Running = True
    GUICtrlSetState($g_h_StartBtn, $GUI_DISABLE)
    GUICtrlSetState($g_h_StopBtn, $GUI_ENABLE)
    GUICtrlSetData($g_h_WinsLabel, "State: Running")
    Out("Bot started!")
EndFunc

Func OnStopClick()
    $g_b_Running = False
    GUICtrlSetState($g_h_StartBtn, $GUI_ENABLE)
    GUICtrlSetState($g_h_StopBtn, $GUI_DISABLE)
    GUICtrlSetData($g_h_WinsLabel, "State: Stopped")
    Out("Bot stopped!")
EndFunc
#EndRegion GUI Event Handlers

#Region Main Loop
; Main loop
While True
    If $g_b_Running Then
        BotLoop()
    EndIf
    Sleep(50)
WEnd

Func BotLoop()
    ; Check if still running
    If Not $g_b_Running Then Return

    ; Wait for map to finish loading
    If Map_GetInstanceInfo("IsLoading") Then
        GUICtrlSetData($g_h_WinsLabel, "State: Loading...")
        While Map_GetInstanceInfo("IsLoading") And $g_b_Running
            Sleep(100)
        WEnd
        If Not $g_b_Running Then Return
        Out("Map loaded!")
        Sleep(1000)
    EndIf

    ; Check current state
    Local $l_i_MapID = Map_GetMapID()
    Local $l_b_IsOutpost = Map_GetInstanceInfo("IsOutpost")
    Local $l_b_IsExplorable = Map_GetInstanceInfo("IsExplorable")

    If $l_b_IsOutpost Then
        GUICtrlSetData($g_h_WinsLabel, "State: In Outpost (Map " & $l_i_MapID & ")")
        Setup()
    ElseIf $l_b_IsExplorable Then
        GUICtrlSetData($g_h_WinsLabel, "State: In Match!")
        Fight()
    Else
        GUICtrlSetData($g_h_WinsLabel, "State: Unknown")
        Sleep(500)
    EndIf
EndFunc
#EndRegion Main Loop

#Region Setup Functions
Func Setup()
    If Not $g_b_Running Then Return

    Local $l_i_MapID = Map_GetMapID()

    ; Check if we need to travel to RA outpost
    If $l_i_MapID <> $MAP_RA_OUTPOST Then
        Out("Traveling to Random Arenas...")
        Map_TravelTo($MAP_RA_OUTPOST)

        ; Wait for travel to complete
        Sleep(2000)
        Local $l_i_Timeout = 0
        While (Map_GetInstanceInfo("IsLoading") Or Map_GetMapID() <> $MAP_RA_OUTPOST) And $g_b_Running
            Sleep(500)
            $l_i_Timeout += 500
            If $l_i_Timeout > 30000 Then
                Out("ERROR: Travel timeout!")
                Return
            EndIf
        WEnd

        If Not $g_b_Running Then Return
        Out("Arrived at Random Arenas!")
        Sleep(1000)
        Return
    EndIf

    ; We're at RA outpost, enter a match
    $g_i_RoundCount += 1
    GUICtrlSetData($g_h_RoundsLabel, "Rounds: " & $g_i_RoundCount)
    Out("Entering match #" & $g_i_RoundCount & "...")

    ; Enter the challenge
    Ui_EnterChallenge(False, True)

    ; Wait for map to change (match to start)
    Local $l_i_Timeout = 0
    Local $l_i_InitialMap = Map_GetMapID()
    While Map_GetMapID() = $l_i_InitialMap And Not Map_GetInstanceInfo("IsLoading") And $g_b_Running
        Sleep(500)
        $l_i_Timeout += 500
        If $l_i_Timeout > 30000 Then
            Out("No match found, retrying in 5s...")
            Sleep(5000)
            Return
        EndIf
    WEnd

    If $g_b_Running Then Out("Match starting!")
EndFunc
#EndRegion Setup Functions

#Region Combat Functions
Func Fight()
    If Not $g_b_Running Then Return

    ; Update agent info
    Update()

    ; Check if dead
    If Agent_GetAgentInfo(-2, "IsDead") Then
        Sleep(500)
        Return
    EndIf

    ; Check if match ended (back in outpost)
    If Map_GetInstanceInfo("IsOutpost") Then
        Out("Match ended!")
        Return
    EndIf

    ; Kite if low HP and enemies nearby
    If $g_f_MyHP < $KITE_HP_THRESHOLD And HasNearbyEnemies($RANGE_ADJACENT) Then
        Kite()
    EndIf

    ; Use skills
    CastEngine()
EndFunc

Func Update()
    $g_i_MyID = Agent_GetMyID()
    $g_i_MyTeam = Agent_GetAgentInfo(-2, "Team")
    $g_f_MyX = Agent_GetAgentInfo(-2, "X")
    $g_f_MyY = Agent_GetAgentInfo(-2, "Y")
    $g_f_MyHP = Agent_GetAgentInfo(-2, "HP")

    ; Get all agents
    Local $l_a_AllAgents = Agent_GetAgentArray(0xDB)
    If Not IsArray($l_a_AllAgents) Then
        ReDim $g_a_Allies[1]
        ReDim $g_a_Enemies[1]
        $g_a_Allies[0] = 0
        $g_a_Enemies[0] = 0
        Return
    EndIf

    If $l_a_AllAgents[0] = 0 Then
        ReDim $g_a_Allies[1]
        ReDim $g_a_Enemies[1]
        $g_a_Allies[0] = 0
        $g_a_Enemies[0] = 0
        Return
    EndIf

    Local $l_a_TempAllies[UBound($l_a_AllAgents)]
    Local $l_a_TempEnemies[UBound($l_a_AllAgents)]
    Local $l_i_AllyCount = 0
    Local $l_i_EnemyCount = 0

    For $i = 1 To $l_a_AllAgents[0]
        Local $l_p_Agent = $l_a_AllAgents[$i]
        If Agent_GetAgentInfo($l_p_Agent, "IsDead") Then ContinueLoop
        Local $l_i_Team = Agent_GetAgentInfo($l_p_Agent, "Team")
        Local $l_i_ID = Agent_GetAgentInfo($l_p_Agent, "ID")

        If $l_i_Team = $g_i_MyTeam Then
            $l_i_AllyCount += 1
            $l_a_TempAllies[$l_i_AllyCount] = $l_i_ID
        Else
            $l_i_EnemyCount += 1
            $l_a_TempEnemies[$l_i_EnemyCount] = $l_i_ID
        EndIf
    Next

    ReDim $g_a_Allies[$l_i_AllyCount + 1]
    $g_a_Allies[0] = $l_i_AllyCount
    For $i = 1 To $l_i_AllyCount
        $g_a_Allies[$i] = $l_a_TempAllies[$i]
    Next

    ReDim $g_a_Enemies[$l_i_EnemyCount + 1]
    $g_a_Enemies[0] = $l_i_EnemyCount
    For $i = 1 To $l_i_EnemyCount
        $g_a_Enemies[$i] = $l_a_TempEnemies[$i]
    Next
EndFunc

Func CastEngine()
    If TimerDiff($g_i_LastSkillTime) < $SKILL_AFTERCAST Then Return
    If TryHealCritical() Then Return
    If TryHealLow() Then Return
    If TryDamage() Then Return
    If TryHealMaintenance() Then Return
EndFunc

Func TryHealCritical()
    If $g_f_MyHP < $HP_CRITICAL Then
        If CastHealOn(-2, 2) Then Return True
    EndIf
    For $i = 1 To $g_a_Allies[0]
        Local $l_i_AllyID = $g_a_Allies[$i]
        If $l_i_AllyID = $g_i_MyID Then ContinueLoop
        Local $l_f_HP = Agent_GetAgentInfo($l_i_AllyID, "HP")
        If $l_f_HP < $HP_CRITICAL And $l_f_HP > 0 Then
            If CastHealOn($l_i_AllyID, 2) Then Return True
        EndIf
    Next
    Return False
EndFunc

Func TryHealLow()
    If $g_f_MyHP < $HP_LOW Then
        If CastHealOn(-2, 1) Then Return True
    EndIf
    For $i = 1 To $g_a_Allies[0]
        Local $l_i_AllyID = $g_a_Allies[$i]
        If $l_i_AllyID = $g_i_MyID Then ContinueLoop
        Local $l_f_HP = Agent_GetAgentInfo($l_i_AllyID, "HP")
        If $l_f_HP < $HP_LOW And $l_f_HP > 0 Then
            If CastHealOn($l_i_AllyID, 1) Then Return True
        EndIf
    Next
    Return False
EndFunc

Func TryHealMaintenance()
    For $i = 1 To $g_a_Allies[0]
        Local $l_i_AllyID = $g_a_Allies[$i]
        Local $l_f_HP = Agent_GetAgentInfo($l_i_AllyID, "HP")
        If $l_f_HP < $HP_MEDIUM And $l_f_HP > 0 Then
            If CastHealOn($l_i_AllyID, 0) Then Return True
        EndIf
    Next
    Return False
EndFunc

Func TryDamage()
    Local $l_i_Target = NearestEnemy($RANGE_CAST)
    If $l_i_Target = 0 Then Return False
    For $i = 0 To 3
        If Cast($g_a_DamageSkills[$i], $l_i_Target) Then Return True
    Next
    Return False
EndFunc

Func CastHealOn($a_i_TargetID, $a_i_MinPriority = 0)
    Local $l_b_IsSelf = ($a_i_TargetID = -2 Or $a_i_TargetID = $g_i_MyID)
    Local $l_f_TargetHP = Agent_GetAgentInfo($a_i_TargetID, "HP")
    If Not $l_b_IsSelf Then
        If Agent_GetDistance($a_i_TargetID) > $RANGE_CAST Then Return False
    EndIf
    For $i = 0 To 3
        Local $l_i_Slot = $g_a_HealSkills[$i][0]
        Local $l_i_TargetType = $g_a_HealSkills[$i][1]
        Local $l_f_HPThreshold = $g_a_HealSkills[$i][2]
        Local $l_i_Priority = $g_a_HealSkills[$i][3]
        If $l_i_Priority < $a_i_MinPriority Then ContinueLoop
        If $l_i_TargetType = 0 And Not $l_b_IsSelf Then ContinueLoop
        If $l_i_TargetType = 1 And $l_b_IsSelf Then ContinueLoop
        If $l_f_TargetHP > $l_f_HPThreshold Then ContinueLoop
        If Cast($l_i_Slot, $a_i_TargetID) Then Return True
    Next
    Return False
EndFunc

Func Cast($a_i_Slot, $a_i_TargetID = -2)
    If Not Skill_GetSkillbarInfo($a_i_Slot, "IsRecharged") Then Return False
    If Not Skill_GetSkillbarInfo($a_i_Slot, "HasSkill") Then Return False
    Local $l_i_SkillID = Skill_GetSkillbarInfo($a_i_Slot, "SkillID")
    Local $l_i_EnergyCost = Skill_GetSkillInfo($l_i_SkillID, "EnergyCost")
    If Agent_GetAgentInfo(-2, "CurrentEnergy") < $l_i_EnergyCost Then Return False
    Skill_UseSkill($a_i_Slot, $a_i_TargetID)
    $g_i_LastSkillTime = TimerInit()
    Sleep($CAST_DELAY)
    Return True
EndFunc
#EndRegion Combat Functions

#Region Helper Functions
Func NearestEnemy($a_i_Range = $RANGE_CAST)
    Local $l_i_NearestID = 0, $l_f_NearestDist = $a_i_Range + 1
    For $i = 1 To $g_a_Enemies[0]
        Local $l_f_Dist = Agent_GetDistance($g_a_Enemies[$i])
        If $l_f_Dist < $l_f_NearestDist Then
            $l_f_NearestDist = $l_f_Dist
            $l_i_NearestID = $g_a_Enemies[$i]
        EndIf
    Next
    Return $l_i_NearestID
EndFunc

Func HasNearbyEnemies($a_i_Range = $RANGE_ADJACENT)
    For $i = 1 To $g_a_Enemies[0]
        If Agent_GetDistance($g_a_Enemies[$i]) <= $a_i_Range Then Return True
    Next
    Return False
EndFunc
#EndRegion Helper Functions

#Region Movement Functions
Func Kite()
    Local $l_i_NearestEnemy = NearestEnemy($RANGE_EARSHOT)
    If $l_i_NearestEnemy = 0 Then Return
    Local $l_f_EnemyX = Agent_GetAgentInfo($l_i_NearestEnemy, "X")
    Local $l_f_EnemyY = Agent_GetAgentInfo($l_i_NearestEnemy, "Y")
    Local $l_f_DX = $g_f_MyX - $l_f_EnemyX
    Local $l_f_DY = $g_f_MyY - $l_f_EnemyY
    Local $l_f_Length = Sqrt($l_f_DX * $l_f_DX + $l_f_DY * $l_f_DY)
    If $l_f_Length = 0 Then Return
    $l_f_DX = ($l_f_DX / $l_f_Length) * $KITE_DISTANCE
    $l_f_DY = ($l_f_DY / $l_f_Length) * $KITE_DISTANCE
    Map_Move($g_f_MyX + $l_f_DX, $g_f_MyY + $l_f_DY, 0)
EndFunc
#EndRegion Movement Functions
