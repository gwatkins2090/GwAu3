Global Const $GWA_CONST_GREATTEMPLEOFBALTHAZAR = 248
Global Const $GWA_CONST_RANDOMARENAS = 188
Global Const $GWA_CONST_DISHONORABLE = 2546
Global Const $GWA_CONST_SIGNET = 7
Global Const $GWA_CONST_SKILL = 10
Global Const $GWA_CONST_STANCE = 3
Global Const $GWA_CONST_GLYPH = 12
Global Const $GWA_CONST_SHOUT = 15
Global Const $GWA_CONST_SKILL2 = 16
Global Const $GWA_CONST_PREPARATION = 19
Global Const $GWA_CONST_PETATTACK = 20
Global Const $GWA_CONST_TRAP = 21
Global Const $GWA_CONST_RITUAL = 22
Global Const $GWA_CONST_FORM = 26
Global Const $GWA_CONST_CHANT = 27
Global Const $GWA_CONST_ATTACK = 14
Global Const $GWA_CONST_HEX = 4
Global Const $GWA_CONST_SPELL = 5
Global Const $GWA_CONST_ENCHANTMENT = 6
Global Const $GWA_CONST_WELL = 9
Global Const $GWA_CONST_WARD = 11
Global Const $GWA_CONST_AXE = 2
Global Const $GWA_CONST_SWORD = 7
Global Const $GWA_CONST_HAMMER = 3
Global Const $GWA_CONST_SCYTHE = 5
Global Const $GWA_CONST_DAGGERS = 4
Global Const $GWA_CONST_DAZED = 485
Global Const $GWA_CONST_BLIND = 479
Global Const $GWA_CONST_DIVERSION = 30
Global Const $GWA_CONST_WAILOFDOOM = 764
Global Const $GWA_CONST_SHAME = 51
Global Const $GWA_CONST_MARKOFSUBVERSION = 127
Global Const $GWA_CONST_GUILT = 46
Global Const $GWA_CONST_MISTRUST = 979
Global Const $GWA_CONST_MISTRUSTPVP = 3191
Global Const $GWA_CONST_VISIONSOFREGRET = 878
Global Const $GWA_CONST_VISIONSOFREGRETPVP = 3234
Global Const $GWA_CONST_BACKFIRE = 28
Global Const $GWA_CONST_SOULLEECH = 128
Global Const $GWA_CONST_INEPTITUDE = 47
Global Const $GWA_CONST_CLUMSINESS = 43
Global Const $GWA_CONST_WANDERINGEYE = 2056
Global Const $GWA_CONST_WANDERINGEYEPVP = 3195
Global Const $GWA_CONST_INSIDIOUSPARASITE = 123
Global Const $GWA_CONST_EMPATHY = 26
Global Const $GWA_CONST_EMPATHYPVP = 3151
Global Const $GWA_CONST_SPITEFULSPIRIT = 121
Global Const $GWA_CONST_PRICEOFFAILURE = 103
Global Const $GWA_CONST_SPIRITSHACKLES = 66
Global Const $GWA_CONST_BONETTISDEFENSE = 380
Global Const $GWA_CONST_PROTECTORSDEFENSE = 810
Global Const $GWA_CONST_BULLSSTRIKE = 332
Global Const $GWA_CONST_ENRAGEDSMASH = 993
Global Const $GWA_CONST_WATERTRIDENT = 237
Global Const $GWA_CONST_SLIPPERYGROUND = 2191
Global Const $GWA_CONST_QUIVERINGBLADE = 892
Global Const $GWA_CONST_FOULFEAST = 2057
Global Const $GWA_CONST_DRAWCONDITIONS = 311
;~ Random Arenas Bot framework created by TheArkanaProject for GWA² 3.4
;~ Don't forget to use the GWA² switcher.
;~ Specify a max run time and the bot will automatically stop and close GW after finishing it's streak.
;~ Use Ctrl+Alt+E to stop the bot at any time.
;~ Like any bot using the event system, gw.exe should be run as an admin.
;~ If you want to minimize guild wars, it's highly recommended that you disable rendering first.
;~ The Cast() function must be written.
;~ It's HIGHLY recommended you rewrite the Kite() function
;~ If you want to wand/attack, write it into the Fight() function
;~ For efficiency's sake, try to alter the Update() func instead of utilizing large, slow AgentID loops.
;~ I've found a few of the dialogs for ZQuests, but not all of them yet.
;MsgBox(48, "Attention!", "THIS IS NOT AN RA BOT. It is the underlying framework for one. The code must be edited for this script to do actually do anything (other than maybe getting you banned for leeching).")
;Exit
#include "GWA².au3"

;~ Config
Global $fLog = FileOpen("RABotLog.txt", 1) ;Log file
Global Const $GuildWars = "Guild Wars" ;Guild Wars window name
Global Const $BalthPercent = .5 ;Trade for Zkeys once you have this much faction
Global Const $Zaishen = False ;quest ID of zaishen (there's 4 or so, use the correct one, and un/comment the corresponding dialog IDs)
Global Const $MaxRunTime = 60 ;Minutes to run
Global $mDisableRendering = False ;Ctrl+Alt+R to turn on/off
;~ Global Const $Range = 1500 ;Controls Ranged Arrays
;~ End of Config

If Not Initialize(WinGetProcess($GuildWars), False, False) Then
	Out("Initialization Failed!")
	Exit
EndIf
SetEvent('SkillActivate', 'SkillCancel', 'SkillComplete')
If $mDisableRendering Then DisableRendering()

Global Const $Pi = 4 * ATan(1)
Global Const $RunTimer = TimerInit()

Global $mOldBalthazarFaction = GetBalthazarFaction()
Global $mOldGladPoints = GetGladiatorTitle()
Global $mWins, $mStreak, $mEnters, $mZWins = 0, $mBalthazarFaction = 0, $mGladPoints = 0, $mStrongBoxes = 0, $mZKeys = 0

Global $mX, $mY
Global $mMovementTimer = TimerInit()
Global $mMovementDelay = 400
Global $mKiting = 0

Global $mTeam ;Array of living members
Global $mTeamOthers ;Array of living members other than self
Global $mTeamDead ;Array of dead teammates
Global $mETeam ;Array of living enemy team
;~ Global $mTeamRange ;Array of living members in range
;~ Global $mTeamOthersRange ;Array of living members other than self in range
;~ Global $mTeamDeadRange ;Array of dead teammates
;~ Global $mETeamRange ;Array of living enemy team in range

Global $mSelf
Global $mSelfID

Global $mLowestAlly
Global $mLowestAllyHP
Global $mLowestOtherAlly
Global $mLowestOtherAllyHP
Global $mLowestEnemy
Global $mLowestEnemyHP

Global $mEffects
Global $mSkillbar
Global $mEnergy
Global $mDeaths = False
Global $mEnemies = False

Global $mDazed = False
Global $mBlind = False
Global $mSkillHardCounter = False
Global $mSkillSoftCounter = 0
Global $mAttackHardCounter = False
Global $mAttackSoftCounter = 0
Global $mAllySpellHardCounter = False
Global $mEnemySpellHardCounter = False
Global $mSpellSoftCounter = 0
Global $mBlocking = False

Global $mSkillTimer = TimerInit()
Global $mCastTime = -1
Global $mAllyDraw = False

OnAutoItExitRegister("BotShutdown")
Func BotShutdown()
	Out("Entered " & $mEnters & " times and won " & $mWins & " games.")
	Out("Gained " & $mBalthazarFaction & " faction, " & $mZkeys & " Zaishen Keys, " & $mStrongBoxes & " strongboxes, and " & $mGladPoints & " gladiator points.")
	Out("Ran for " & Floor(TimerDiff($RunTimer) / 60000) & " minutes.")
	If $mDisableRendering Then EnableRendering()
EndFunc

HotKeySet("^!e", "Abort")
Func Abort()
	Exit
EndFunc

HotKeySet("^!r", "Rendering")
Func Rendering()
	If $mDisableRendering Then
		EnableRendering()
	Else
		DisableRendering()
	EndIf
	$mDisableRendering = Not $mDisableRendering
EndFunc

Func Fight()
	$mAllyDraw = False
	$mDeaths = False
	While GetMapLoading() == 1
		Sleep(20)
		If Not Update() Then ContinueLoop
		If $mTeamOthers[0] = 0 Then ContinueLoop ;Entire team dead (or not loaded), do nothing
		If GetIsDead($mSelf) Then ContinueLoop ;I'm dead, do nothing
		
		;Add code to attack/wand here
		
		If CastEngine() Then ContinueLoop
		
		Kite()
	WEnd
EndFunc

#Region Non-Combat
Func Setup()
	If GetMapLoading() == 1 Then Return Out("Already in match!")
	Local $lMe
	
;~ 	Grab Zaishen quest/reward
	If $Zaishen Then
		If DllStructGetData(GetQuestByID($Zaishen), 'ID') == 0 Or ($mZWins >= 3 And DllStructGetData(GetQuestByID($Zaishen), 'ID') == $Zaishen) Then
			If GetMapID() <> $GWA_CONST_GREATTEMPLEOFBALTHAZAR Then
				If Not TravelTo($GWA_CONST_GREATTEMPLEOFBALTHAZAR) Then Exit
				Sleep(Random(750, 1250, 1))
			EndIf
			
			MoveTo(-5900, -5560, 125)
			
			If DllStructGetData(GetQuestByID($Zaishen), 'ID') == 0 Then
				Local $lBounty = GetNearestNPCToCoords(-5053, -5391)
			Else
				Local $lBounty = GetNearestNPCToCoords(-5019, -5496)
			EndIf
			
			$i = 0
			Do
				$lMe = GetAgentByID(-2)
				Local $mX = (DllStructGetData($lBounty, 'X') + DllStructGetData($lMe, 'X'))/2
				Local $mY = (DllStructGetData($lBounty, 'Y') + DllStructGetData($lMe, 'Y'))/2
				MoveTo($mX, $mY, 150)
				$i += Random(1, 3, 1)
				Sleep(Random(400, 600, 1))
			Until $i > 2 Or GetDistance($lMe, $lBounty) < 1500
			GoNPC($lBounty)
			
			Do
				Sleep(Random(50, 200, 1))
				$lMe = GetAgentByID(-2)
			Until GetDistance($lMe, $lBounty) < 400
			Sleep(Random(4500, 5500, 1))
			
			If DllStructGetData(GetQuestByID($Zaishen), 'ID') == 0 Then
;~ 				Dialog(0x00844F03);1103
				Dialog(0x00845703);1111
				Sleep(Random(450, 650, 1))
;~ 				Dialog(0x00844F01);1103
				Dialog(0x00845701);1111
				Sleep(Random(4500, 5500, 1))
			ElseIf $mZWins >= 3 Then
				$mZWins = 0
;~ 				Dialog(0x00844F06);1103
				Dialog(0x00845706);1111
				Sleep(Random(450, 650, 1))
;~ 				Dialog(0x00844F07);1103
				Dialog(0x00845707);1111
				Sleep(Random(4500, 5500, 1))
				TravelTo($GWA_CONST_RANDOMARENAS)
				Sleep(Random(4500, 5500, 1))
				Setup()
				Return
			EndIf
		EndIf
	EndIf
	
	If GetMapID() <> $GWA_CONST_RANDOMARENAS Then
		If Not TravelTo($GWA_CONST_RANDOMARENAS) Then Exit
		Sleep(Random(750, 1250, 1))
	EndIf
	
	Local $lTolkano = GetNearestNPCToCoords(4433, 3914)
	
;~ 	Buy Zkeys
	If GetBalthazarFaction() > $BalthPercent * GetMaxBalthazarFaction() And GetBalthazarFaction() > 5000 Then
		$i = 0
		Do
			$lMe = GetAgentByID(-2)
			Local $mX = (DllStructGetData($lTolkano, 'X') + DllStructGetData($lMe, 'X'))/2
			Local $mY = (DllStructGetData($lTolkano, 'Y') + DllStructGetData($lMe, 'Y'))/2
			MoveTo($mX, $mY, 150)
			$i += Random(1, 3, 1)
			Sleep(Random(400, 600, 1))
		Until $i > 2 Or GetDistance($lMe, $lTolkano) < 1500
		GoNPC($lTolkano)
		
		Do
			Sleep(Random(50, 200, 1))
			$lMe = GetAgentByID(-2)
		Until GetDistance($lMe, $lTolkano) < 400
		
		Do 
			Dialog(134)
			Sleep(Random(450, 650, 1))
			Dialog(135)
			Sleep(Random(450, 650, 1))
			GoNPC($lTolkano)
			Sleep(Random(450, 650, 1))
			$mZkeys += 1
		Until GetBalthazarFaction() < 5000
		$mOldBalthazarFaction = GetBalthazarFaction()
	EndIf
	
	If TimerDiff($RunTimer) / 60000 > $MaxRunTime Then
		WinClose($GuildWars)
		Exit
	EndIf
	
	While DllStructGetData(GetEffect($GWA_CONST_DISHONORABLE), 'SkillID') == $GWA_CONST_DISHONORABLE
		Sleep(Random(15000, 30000, 1))
	WEnd
	
	$mEnters += 1
	Out("Entering new match. Enter count: " & $mEnters)
	EnterChallenge()
	Do
		Sleep(Random(750, 1250, 1))
	Until GetMapLoading() == 1 And GetAgentExists(-2)
	Sleep(Random(8000, 9000))
EndFunc

Func NewRound()
	Out("New Round!")
	Do
		Sleep(Random(750, 1250, 1))
	Until GetMapLoading() <> 2 And GetAgentExists(-2)
	Sleep(Random(4500, 5500, 1))
	If GetBalthazarFaction() - $mOldBalthazarFaction > 0 Then ;In Event of Crash
		$mBalthazarFaction += GetBalthazarFaction() - $mOldBalthazarFaction
		$mOldBalthazarFaction = GetBalthazarFaction()
	EndIf
	If GetGladiatorTitle() - $mOldGladPoints > 0 Then ;In Event of Crash
		$mGladPoints += GetGladiatorTitle() - $mOldGladPoints
		$mOldGladPoints = GetGladiatorTitle()
	EndIf
	If GetMapLoading() == 1 Then
		$mWins += 1
		$mStreak += 1
		If IsInt($mStreak / 5) Then $mStrongBoxes += 1
		$mZWins += 1
		If Not $mDeaths Then Out("Flawless!")
		Out("Match Won! Total Wins: " & $mWins & " Streak: " & $mStreak)
		Return True
	Else
		If $mStreak == 24 Then
			$mWins += 1
			$mStrongBoxes += 1
			$mZWins += 1
			If Not $mDeaths Then Out("Flawless!")
			Out("25 wins reached!")
		Else
			Out("Awww... I lost.")
		EndIf
		$mStreak = 0
		Return False
	EndIf
	Sleep(Random(8000, 9000))
EndFunc
#EndRegion Non-Combat


#Region CastEngine
Func CastEngine()
	If Not $mEnemies Then Return False
	
	If TimerDiff($mSkillTimer) < $mCastTime Then Return False
	$mCastTime = -1
	Local $lDeadLock = TimerInit()
	If Cast() Then
		Do
			Sleep(3)
		Until $mCastTime > -1 Or TimerDiff($lDeadLock) > 750
		Return True
	EndIf
	Return False
EndFunc

;~ Checks if it's safe to use a skill and if you have enough energy.
;~ Won't use skills through hard counters like diversion or shame if applicable.
;~ Will only cast through soft counters (like backfire) if flag is high enough.
;~ If flag is set to 1, then it will cast through a single soft-counter. So it will cast through backfire or soul leech alone, but do nothing if under the effects of both.
Func CanUseSkill($aSkillSlot, $aEnergy = 0, $aSoftCounter = 0)
	If $mSkillHardCounter Then Return False
	If $mSkillSoftCounter > $aSoftCounter Then Return False
	If $mEnergy < $aEnergy Then Return False
	If DllStructGetData($mSkillbar, 'Recharge' & $aSkillSlot) == 0 Then
		Local $lSkill = GetSkillByID(DllStructGetData($mSkillbar, 'Id' & $aSkillSlot))
		If DllStructGetData($mSkillbar, 'AdrenalineA' & $aSkillSlot) < DllStructGetData($lSkill, 'Adrenaline') Then Return False
		Switch DllStructGetData($lSkill, 'Type')
			Case $GWA_CONST_SIGNET, $GWA_CONST_SKILL, $GWA_CONST_STANCE, $GWA_CONST_GLYPH, $GWA_CONST_SHOUT, $GWA_CONST_SKILL2, $GWA_CONST_PREPARATION, $GWA_CONST_PETATTACK, $GWA_CONST_TRAP, $GWA_CONST_RITUAL, $GWA_CONST_FORM, $GWA_CONST_CHANT
				
			Case $GWA_CONST_ATTACK
				If $mBlind Then Return False
				If $mAttackHardCounter Then Return False
				If $mAttackSoftCounter > $aSoftCounter Then Return False
			Case $GWA_CONST_HEX, $GWA_CONST_SPELL, $GWA_CONST_ENCHANTMENT, $GWA_CONST_WELL, $GWA_CONST_WARD
				If $mSpellSoftCounter > $aSoftCounter Then Return False
				If $mDazed Then
					If DllStructGetData($lSkill, 'Activation') > .25 Then Return False
				EndIf
				Switch DllStructGetData($lSkill, 'Target')
					Case 3, 4
						If $mAllySpellHardCounter Then Return False
					Case 5, 16
						If $mEnemySpellHardCounter Then Return False
					Case Else
				EndSwitch
		EndSwitch
		Return True
	EndIf
	Return False
EndFunc

;~ Edit this section to suit your build. Return true if you use a skill!
;Func Cast()
	;If GetIsKnocked($mSelf) Then Return False
	
;~ 	Word of Healing
;~ 	If $mLowestAllyHP < .5 Then
;~ 		If CanUseSkill(1, 5, 1) Then
;~ 			UseSkill(1, $mLowestAlly)
;~ 			Return True
;~ 		EndIf
;~ 	EndIf

Func Cast()
	If GetIsKnocked($mSelf) Then Return False
		
		If $mLowestAllyHP < .5 Then
 		If CanUseSkill(2, 5) Then
 			UseSkill(2, $mLowestAlly)
 			Return True
		EndIf
		Endif
		
		If $mLowestAllyHP < .8 Then
			If CanUseSkill(1, 5) Then
 			UseSkill(1, $mLowestAlly)
 			Return True
			EndIf
		EndIf
		
		If $mLowestAllyHP < .8 Then
 		If CanUseSkill(3, 0) Then
 			UseSkill(3, $mLowestAlly)
 			Return True
		EndIf
		Endif
		
	
 		If CanUseSkill(5, 5) Then
			If GetHasDeepWound($mSelf) Then
                    	UseSkill(5, $mSelf)
                        ; or     If GetHasHex($mLowestOtherAlly) Then
		                   UseSkill(5, $mLowestOtherAlly)
 			Return True
		EndIf
		Endif
			
		If CanUseSkill(4, 5) Then
		If GetHasHex($mLowestAlly) Then
			UseSkill(4, $mLowestAlly)
			Return True
		EndIf
	EndIf
	
		If CanUseSkill(6, 5) Then
		If GetHasCondition($mLowestOtherAlly) Then
		UseSkill(6, $mLowestOtherAlly)
		Return True
		EndIf
		EndIf
	
	
	If CanUseSkill(7, 0) Then	
	UseSkill(7, $mSelf)
 			Return True
		EndIf
	
	
	If CanUseSkill(8, 0) Then	
	UseSkill(8, $mSelf)
 			Return True
		EndIf

	Return False
EndFunc




	
	;Return False
;EndFunc
#EndRegion CastEngine

#Region HelperFunctions
Func GetIsMeleed($aAgentID)
	For $i = 1 to $mETeam[0]
		If GetIsAttacking($mETeam[$i]) Then
			Local $lWeapon = DllStructGetData($mETeam[$i], 'WeaponType')
			Switch $lWeapon
				Case $GWA_CONST_AXE, $GWA_CONST_SWORD, $GWA_CONST_HAMMER, $GWA_CONST_SCYTHE, $GWA_CONST_DAGGERS
					If GetTarget($mETeam[$i]) == $aAgentID Then
						Return True
					EndIf
			EndSwitch
		EndIf
	Next
	Return False
EndFunc

Func NearestEnemy($aArray = 0) ;Find nearest enemy to you or an array of coordinates
	Local $lNearest = 0
	Local $lDistance = 5000
	Local $lNewDistance
	For $i = 1 To $mETeam[0]
		If Not IsArray($aArray) Then
			$lNewDistance = GetDistance($mSelf, $mETeam[$i])
		Else
			$lNewDistance = ComputeDistance(DllStructGetData($mETeam[$i], 'X'), DllStructGetData($mETeam[$i], 'Y'), $aArray[0], $aArray[1])
		EndIf
		If $lNewDistance < $lDistance Then
			$lNearest = $mETeam[$i]
			$lDistance = $lNewDistance
		EndIf
	Next
	SetExtended($lDistance)
	Return $lNearest
EndFunc

Func NearestAlly($aArray = 0) ;Find nearest ally to you or an array of coordinates
	Local $lNearest = 0
	Local $lDistance = 5000
	Local $lNewDistance
	For $i = 1 To $mTeamOthers[0]
		If Not IsArray($aArray) Then
			$lNewDistance = GetDistance($mSelf, $mTeamOthers[$i])
		Else
			$lNewDistance = ComputeDistance(DllStructGetData($mTeamOthers[$i], 'X'), DllStructGetData($mTeamOthers[$i], 'Y'), $aArray[0], $aArray[1])
		EndIf
		If $lNewDistance < $lDistance Then
			$lNearest = $mTeamOthers[$i]
			$lDistance = $lNewDistance
		EndIf
	Next
	SetExtended($lDistance)
	Return $lNearest
EndFunc

Func Out($aString)
	FileWriteLine($fLog, @HOUR & ":" & @MIN & " - " & $aString)
	ConsoleWrite(@HOUR & ":" & @MIN & " - " & $aString & @CRLF)
EndFunc

;~ Updates all the information you need for combat.
;~ Better to get all the information you can from a single loop here than repeatedly loop through agents for each spell.
;~ Edit as necessary.
Func Update()
	If GetMapLoading() <> 1 Then Return False
	$mSelfID = GetMyID()
	$mSelf = GetAgentByID($mSelfID)
	$mEnergy = GetEnergy($mSelf)
	$mSkillbar = GetSkillbar()
	$mEffects = GetEffect()
	If Not IsArray($mEffects) Then Dim $mEffects[1] = [0]
	
	$mDazed = False
	$mBlind = False
	$mSkillHardCounter = False
	$mSkillSoftCounter = 0
	$mAttackHardCounter = False
	$mAttackSoftCounter = 0
	$mAllySpellHardCounter = False
	$mEnemySpellHardCounter = False
	$mSpellSoftCounter = 0
	$mBlocking = False
	
	For $i = 1 To $mEffects[0]
		Switch DllStructGetData($mEffects[$i], 'SkillID')
			Case $GWA_CONST_DAZED
				$mDazed = True
			Case $GWA_CONST_BLIND
				$mBlind = True
			Case $GWA_CONST_DIVERSION, $GWA_CONST_WAILOFDOOM
				$mSkillHardCounter = True
			Case $GWA_CONST_SHAME, $GWA_CONST_MARKOFSUBVERSION
				$mAllySpellHardCounter = True
			Case $GWA_CONST_GUILT, $GWA_CONST_MISTRUST, $GWA_CONST_MISTRUSTPVP
				$mEnemySpellHardCounter = True
			Case $GWA_CONST_VISIONSOFREGRET, $GWA_CONST_VISIONSOFREGRETPVP
				$mSkillSoftCounter += 1
				$mSpellSoftCounter += 1
				$mAttackSoftCounter += 1
			Case $GWA_CONST_BACKFIRE, $GWA_CONST_SOULLEECH
				$mSpellSoftCounter += 1
			Case $GWA_CONST_INEPTITUDE, $GWA_CONST_CLUMSINESS, $GWA_CONST_WANDERINGEYE, $GWA_CONST_WANDERINGEYEPVP
				$mAttackHardCounter = True
			Case $GWA_CONST_INSIDIOUSPARASITE, $GWA_CONST_EMPATHY, $GWA_CONST_EMPATHYPVP, $GWA_CONST_SPITEFULSPIRIT, $GWA_CONST_PRICEOFFAILURE, $GWA_CONST_SPIRITSHACKLES
				$mAttackSoftCounter += 1
			Case $GWA_CONST_BONETTISDEFENSE, $GWA_CONST_PROTECTORSDEFENSE ;Not fully developed
				$mBlocking = True
		EndSwitch
	Next
	
	Local $lAgent
	Local $lHP
	Local $lTeam = DllStructGetData($mSelf, 'Team')
	
	$mEnemies = False
	Dim $mTeam[1] = [0]
	Dim $mTeamOthers[1] = [0]
	Dim $mTeamDead[1] = [0]
	Dim $mETeam[1] = [0]
;~ 	Dim $mTeamRange[1] = [0]
;~ 	Dim $mTeamOthersRange[1] = [0]
;~ 	Dim $mTeamDeadRange[1] = [0]
;~ 	Dim $mETeamRange[1] = [0]

	$mLowestAlly = $mSelf
	$mLowestAllyHP = 1
	$mLowestOtherAlly = 0
	$mLowestOtherAllyHP = 2
	$mLowestEnemy = 0
	$mLowestEnemyHP = 2
	
	
	For $i = 1 To GetMaxAgents()
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'LoginNumber') > 0 And DllStructGetData($lAgent, 'Primary') > 0 Then
			$lHP = DllStructGetData($lAgent, 'HP')
			If DllStructGetData($lAgent, 'Team') == $lTeam Then
				If Not GetIsDead($lAgent) And $lHP > 0 Then
					$mTeam[0] += 1
					Redim $mTeam[$mTeam[0] + 1]
					$mTeam[$mTeam[0]] = $lAgent
;~ 					If ComputeDistance($mX, $mY, DllStructGetData($lAgent, 'X'), DllStructGetData($lAgent, 'Y')) <= $Range Then ;Range from where you should be
;~ 					If GetDistance($mSelf, $lAgent) <= $Range Then ;Range from self
						If $lHP < $mLowestAllyHP Then
							$mLowestAlly = $lAgent
							$mLowestAllyHP = $lHP
						ElseIf $lHP = $mLowestAllyHP Then
							If GetDistance($lAgent, $mSelf) < GetDistance($mLowestAlly, $mSelf) Then
								$mLowestAlly = $lAgent
								$mLowestAllyHP = $lHP
							EndIf
						EndIf
;~ 						$mTeamRange[0] += 1
;~ 						Redim $mTeamRange[$mTeamRange[0] + 1]
;~ 						$mTeamRange[$mTeamRange[0]] = $lAgent
;~ 					EndIf
					
					If $i <> $mSelfID Then
						$mTeamOthers[0] += 1
						Redim $mTeamOthers[$mTeamOthers[0] + 1]
						$mTeamOthers[$mTeamOthers[0]] = $lAgent
;~ 						If ComputeDistance($mX, $mY, DllStructGetData($lAgent, 'X'), DllStructGetData($lAgent, 'Y')) <= $Range Then
;~ 						If GetDistance($mSelf, $lAgent) <= $Range Then
							If $lHP < $mLowestOtherAllyHP Then
								$mLowestOtherAlly = $lAgent
								$mLowestOtherAllyHP = $lHP
							ElseIf $lHP = $mLowestOtherAllyHP Then
								If GetDistance($lAgent, $mSelf) < GetDistance($mLowestOtherAlly, $mSelf) Then
									$mLowestOtherAlly = $lAgent
									$mLowestOtherAllyHP = $lHP
								EndIf
							EndIf
;~ 							$mTeamOthersRange[0] += 1
;~ 							Redim $mTeamOthersRange[$mTeamOthersRange[0] + 1]
;~ 							$mTeamOthersRange[$mTeamOthersRange[0]] = $lAgent
;~ 						EndIf
					EndIf
					
				Else
					$mDeaths = True
					
					If $i == $mAllyDraw Then $mAllyDraw = False
					$mTeamDead[0] += 1
					Redim $mTeamDead[$mTeamDead[0] + 1]
					$mTeamDead[$mTeamDead[0]] = $lAgent
;~ 					If ComputeDistance($mX, $mY, DllStructGetData($lAgent, 'X'), DllStructGetData($lAgent, 'Y')) <= $Range Then
;~ 					If GetDistance($mSelf, $lAgent) <= $Range Then
;~ 						$mTeamDeadRange[0] += 1
;~ 						Redim $mTeamDeadRange[$mTeamDeadRange[0] + 1]
;~ 						$mTeamDeadRange[$mTeamDeadRange[0]] = $lAgent
;~ 					EndIf
				EndIf
			Else
				$mEnemies = True
				If Not GetIsDead($lAgent) And $lHP > 0 Then
					$mETeam[0] += 1
					Redim $mETeam[$mETeam[0] + 1]
					$mETeam[$mETeam[0]] = $lAgent
;~ 					If ComputeDistance($mX, $mY, DllStructGetData($lAgent, 'X'), DllStructGetData($lAgent, 'Y')) <= $Range Then
;~ 					If GetDistance($mSelf, $lAgent) <= $Range Then
						If $lHP < $mLowestEnemyHP Then
							$mLowestEnemy = $lAgent
							$mLowestEnemyHP = $lHP
						ElseIf $lHP = $mLowestEnemyHP Then
							If GetDistance($lAgent, $mSelf) < GetDistance($mLowestEnemy, $mSelf) Then
								$mLowestEnemy = $lAgent
								$mLowestEnemyHP = $lHP
							EndIf
						EndIf
;~ 						$mETeamRange[0] += 1
;~ 						Redim $mETeamRange[$mETeamRange[0] + 1]
;~ 						$mETeamRange[$mETeamRange[0]] = $lAgent
;~ 					EndIf
				EndIf
			EndIf
		EndIf
	Next
	Return True
EndFunc
#EndRegion HelperFunctions

#Region Events
Func SkillActivate($aCaster, $aTarget, $aSkill, $aActivation)
	If DllStructGetData($aCaster, 'ID') == $mSelfID Then
		$mSkillTimer = TimerInit()
		$mCastTime = $aActivation * 1000 + DllStructGetData($aSkill, 'Aftercast') * 1000 + 25
	EndIf
	If DllStructGetData($aTarget, 'ID') == $mSelfID Then
		Switch DllStructGetData($aSkill, 'ID')
			Case $GWA_CONST_BULLSSTRIKE, $GWA_CONST_ENRAGEDSMASH, $GWA_CONST_WATERTRIDENT, $GWA_CONST_SLIPPERYGROUND, $GWA_CONST_QUIVERINGBLADE
				If GetIsMoving(-2) Then CancelAction()
				$mMovementTimer = TimerInit()
				$mMovementDelay = 1000 * $aActivation + 25
		EndSwitch
	EndIf
EndFunc

Func SkillCancel($aCaster, $aTarget, $aSkill)
	If DllStructGetData($aCaster, 'ID') == $mSelfID Then
		$mSkillTimer = TimerInit()
		$mCastTime = 775
	EndIf
EndFunc

Func SkillComplete($aCaster, $aTarget, $aSkill)
	Switch DllStructGetData($aSkill, 'ID')
		Case $GWA_CONST_FOULFEAST, $GWA_CONST_DRAWCONDITIONS
			If DllStructGetData($aCaster, 'Allegiance') == 0x1 And DllStructGetData($aCaster, 'ID') <> $mSelfID Then
				$mAllyDraw = DllStructGetData($aCaster, 'ID')
			EndIf
	EndSwitch
EndFunc
#EndRegion Events

#Region Movement
Func Kite() ;I HIGHLY recommend you edit this.
	If GetIsCasting($mSelf) Then Return False
	If $mBlocking Then Return False
	If TimerDiff($mMovementTimer) < $mMovementDelay Then Return False
	$mMovementDelay = 1500
	
	Local $lCenterArray[2]
	Local $lFollowing = Random(1, $mTeamOthers[0], 1)
	$lCenterArray[0] = DllStructGetData($mTeamOthers[$lFollowing], 'X')
	$lCenterArray[1] = DllStructGetData($mTeamOthers[$lFollowing], 'Y')
	Radial($lCenterArray, 500)
	
	$mX = $lCenterArray[0]
	$mY = $lCenterArray[1]
	
	$mKiting = 0
	If TimerDiff($mMovementTimer) < $mMovementDelay Then Return False ;Double-check in case of bulls
	$mMovementTimer = TimerInit()
	If GetMapLoading() <> 1 Then Return False
	Move($mX, $mY)
	Return True
EndFunc

Func Radial(ByRef $aArray, $aRange) ;Moves array so you're $aRange away from teammate
	Local $lAgent = NearestAlly($aArray)
	Local $lDistance = @extended
	If $lDistance == 0 Then
		If $mETeam[0] > 0 Then
			Local $lAgent = NearestEnemy($aArray)
			Local $lDistance = @extended
			If $lDistance == 0 Then $lDistance = 1
			$aArray[0] -= $aRange * (DllStructGetData($lAgent, 'X') - $aArray[0]) / $lDistance
			$aArray[1] -= $aRange * (DllStructGetData($lAgent, 'Y') - $aArray[1]) / $lDistance
			Return
		Else
			Local $lAngle = Random(0, 2 * $Pi)
			$aArray[0] += $aRange * Cos($lAngle)
			$aArray[1] += $aRange * Sin($lAngle)
			Return
		EndIf
	Else
		$aArray[0] -= $aRange * (DllStructGetData($lAgent, 'X') - $aArray[0]) / $lDistance
		$aArray[1] -= $aRange * (DllStructGetData($lAgent, 'Y') - $aArray[1]) / $lDistance
	EndIf
EndFunc
#EndRegion Movement

Out("Bot Starting...")
While 1
	Setup()
	Do
		Fight()
	Until Not NewRound()
	Out("Entering Setup")
WEnd