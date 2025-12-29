#include-once
#Region Constants
; ==== Constants ====
Global $ChestFarmActive = False
Global Enum $DIFFICULTY_NORMAL, $DIFFICULTY_HARD
Global Enum $INSTANCETYPE_OUTPOST, $INSTANCETYPE_EXPLORABLE, $INSTANCETYPE_LOADING
Global Enum $RANGE_ADJACENT=156, $RANGE_NEARBY=240, $RANGE_AREA=312, $RANGE_EARSHOT=1000, $RANGE_SPELLCAST = 1085, $RANGE_SPIRIT = 2500, $RANGE_COMPASS = 5000
Global Enum $RANGE_ADJACENT_2=156^2, $RANGE_NEARBY_2=240^2, $RANGE_AREA_2=312^2, $RANGE_EARSHOT_2=1000^2, $RANGE_SPELLCAST_2=1085^2, $RANGE_SPIRIT_2=2500^2, $RANGE_COMPASS_2=5000^2
Global Enum $PROF_NONE, $PROF_WARRIOR, $PROF_RANGER, $PROF_MONK, $PROF_NECROMANCER, $PROF_MESMER, $PROF_ELEMENTALIST, $PROF_ASSASSIN, $PROF_RITUALIST, $PROF_PARAGON, $PROF_DERVISH


Global Const $RARITY_Gold = 2624
Global Const $RARITY_Purple = 2626
Global Const $RARITY_Blue = 2623
Global Const $RARITY_White = 2621

;~ All Weapon mods
Global $Weapon_Mod_Array[25] = [893, 894, 895, 896, 897, 905, 906, 907, 908, 909, 6323, 6331, 15540, 15541, 15542, 15543, 15544, 15551, 15552, 15553, 15554, 15555, 17059, 19122, 19123]

;~ General Items
Global $General_Items_Array[6] = [2989, 2991, 2992, 5899, 5900, 22751]
Global Const $ITEM_ID_Lockpicks = 22751
Global Const $ITEM_ID_SSC = 27052
Global Const $ITEM_ID_Diessa = 24353
Global Const $ITEM_ID_RinRelic = 24354

;~ Dyes
Global Const $ITEM_ID_Dyes = 146
Global Const $ITEM_ExtraID_BlackDye = 10
Global Const $ITEM_ExtraID_WhiteDye = 12

;~ Alcohol
Global $Alcohol_Array[19] = [910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682]
Global $OnePoint_Alcohol_Array[11] = [910, 5585, 6049, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 28435]
Global $ThreePoint_Alcohol_Array[7] = [2513, 6366, 24593, 30855, 31145, 31146, 35124]
Global $FiftyPoint_Alcohol_Array[1] = [36682]

;~ Party
Global $Spam_Party_Array[5] = [6376, 21809, 21810, 21813, 36683]

;~ Sweets
Global $Spam_Sweet_Array[6] = [21492, 21812, 22269, 22644, 22752, 28436]

;~ Tonics
Global $Tonic_Party_Array[4] = [15837, 21490, 30648, 31020]

;~ Special Drops
Global $Special_Drops[7] = [5656, 18345, 21491, 37765, 21833, 28433, 28434]

;~ Stupid Drops that I am not using, but in here in case you want these to add these to the CanPickUp and collect in your chest
Global $Map_Piece_Array[4] = [24629, 24630, 24631, 24632]

;~ Stackable Trophies
Global $Stackable_Trophies_Array[1] = [27047]
Global Const $ITEM_ID_Glacial_Stones = 27047

;~ Materials
Global $All_Materials_Array[36] = [921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533]
Global $Common_Materials_Array[11] = [921, 925, 929, 933, 934, 940, 946, 948, 953, 954, 955]
Global $Rare_Materials_Array[25] = [922, 923, 926, 927, 928, 930, 931, 932, 935, 936, 937, 938, 939, 941, 942, 943, 944, 945, 949, 950, 951, 952, 956, 6532, 6533]

;~ Tomes
Global $All_Tomes_Array[20] = [21796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 21805, 21786, 21787, 21788, 21789, 21790, 21791, 21792, 21793, 21794, 21795]
Global Const $ITEM_ID_Mesmer_Tome = 21797

;~ Arrays for the title spamming (Not inside this version of the bot, but at least the arrays are made for you)
Global $ModelsAlcohol[100] = [910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682]
Global $ModelSweetOutpost[100] = [15528, 15479, 19170, 21492, 21812, 22644, 31150, 35125, 36681]
Global $ModelsSweetPve[100] = [22269, 22644, 28431, 28432, 28436]
Global $ModelsParty[100] = [6368, 6369, 6376, 21809, 21810, 21813]

Global $Array_pscon[39]=[910, 5585, 6366, 6375, 22190, 24593, 28435, 30855, 31145, 35124, 36682, 6376, 21809, 21810, 21813, 36683, 21492, 21812, 22269, 22644, 22752, 28436,15837, 21490, 30648, 31020, 6370, 21488, 21489, 22191, 26784, 28433, 5656, 18345, 21491, 37765, 21833, 28433, 28434]

Global $PIC_MATS[26][2] = [["Fur Square", 941],["Bolt of Linen", 926],["Bolt of Damask", 927],["Bolt of Silk", 928],["Glob of Ectoplasm", 930],["Steel of Ignot", 949],["Deldrimor Steel Ingot", 950],["Monstrous Claws", 923],["Monstrous Eye", 931],["Monstrous Fangs", 932],["Rubies", 937],["Sapphires", 938],["Diamonds", 935],["Onyx Gemstones", 936],["Lumps of Charcoal", 922],["Obsidian Shard", 945],["Tempered Glass Vial", 939],["Leather Squares", 942],["Elonian Leather Square", 943],["Vial of Ink", 944],["Rolls of Parchment", 951],["Rolls of Vellum", 952],["Spiritwood Planks", 956],["Amber Chunk", 6532],["Jadeite Shard", 6533]]


Global $Array_Store_ModelIDs460[147] = [474, 476, 486, 522, 525, 811, 819, 822, 835, 610, 2994, 19185, 22751, 4629, 24630, 4631, 24632, 27033, 27035, 27044, 27046, 27047, 7052, 5123 _
		, 1796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 1805, 910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682 _
		, 6376 , 6368 , 6369 , 21809 , 21810, 21813, 29436, 29543, 36683, 4730, 15837, 21490, 22192, 30626, 30630, 30638, 30642, 30646, 30648, 31020, 31141, 31142, 31144, 1172, 15528 _
		, 15479, 19170, 21492, 21812, 22269, 22644, 22752, 28431, 28432, 28436, 1150, 35125, 36681, 3256, 3746, 5594, 5595, 5611, 5853, 5975, 5976, 21233, 22279, 22280, 6370, 21488 _
		, 21489, 22191, 35127, 26784, 28433, 18345, 21491, 28434, 35121, 921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943 _
		, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533]

;~ Prophecies
Global $GH_ID_Warriors_Isle = 4
Global $GH_ID_Hunters_Isle = 5
Global $GH_ID_Wizards_Isle = 6
Global $GH_ID_Burning_Isle = 52
Global $GH_ID_Frozen_Isle = 176
Global $GH_ID_Nomads_Isle = 177
Global $GH_ID_Druids_Isle = 178
Global $GH_ID_Isle_Of_The_Dead = 179
;~ Factions
Global $GH_ID_Isle_Of_Weeping_Stone = 275
Global $GH_ID_Isle_Of_Jade = 276
Global $GH_ID_Imperial_Isle = 359
Global $GH_ID_Isle_Of_Meditation = 360
;~ Nightfall
Global $GH_ID_Uncharted_Isle = 529
Global $GH_ID_Isle_Of_Wurms = 530
Global $GH_ID_Corrupted_Isle = 537
Global $GH_ID_Isle_Of_Solitude = 538

Global $WarriorsIsle = False
Global $HuntersIsle = False
Global $WizardsIsle = False
Global $BurningIsle = False
Global $FrozenIsle = False
Global $NomadsIsle = False
Global $DruidsIsle = False
Global $IsleOfTheDead = False
Global $IsleOfWeepingStone = False
Global $IsleOfJade = False
Global $ImperialIsle = False
Global $IsleOfMeditation = False
Global $UnchartedIsle = False
Global $IsleOfWurms = False
Global $CorruptedIsle = False
Global $IsleOfSolitude = False

Global $xChestOld = 0
Global $yChestOld = 0
Global $xChestOldAr[1]
Global $yChestOldAr[1]
$xChestOldAr[0] = 0
$yChestOldAr[0] = 0


; ================ END CONFIGURATION ================

; ==== Bot global variables ====
Global $RenderingEnabled = True
Global $RunCount = 0
Global $runfirst = true
Global $FailCount = 0
Global $SuccesCount = 0
Global $ChatStuckTimer = TimerInit()
Global $Deadlocked = False

Global $BAG_SLOTS[18] = [0, 20, 5, 10, 10, 20, 41, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 9]

;~ Any pcons you want to use during a run
Global $pconsCupcake_slot[2]
Global $useCupcake = False ; set it on true and he use it

;~ Hero IDs
Global Enum $HERO_ID_Norgu = 1, $HERO_ID_Goren, $HERO_ID_Tahlkora, $HERO_ID_Master, $HERO_ID_Jin = 5, $HERO_ID_Koss, $HERO_ID_Dunkoro, $HERO_ID_Sousuke, $HERO_ID_Melonni, $HERO_ID_Zhed = 10, $HERO_ID_Morgahn, $HERO_ID_Margrid, $HERO_ID_Zenmai, $HERO_ID_Olias, $HERO_ID_Razah = 15, $HERO_ID_Mox, $HERO_ID_Keiran, $HERO_ID_Jora, $HERO_ID_Brandor, $HERO_ID_Anton = 20, $HERO_ID_Livia, $HERO_ID_Hayda, $HERO_ID_Kahmu, $HERO_ID_Gwen, $HERO_ID_Xandra = 25, $HERO_ID_Vekk, $HERO_ID_Ogden, $HERO_ID_MERCENARY_1, $HERO_ID_MERCENARY_2, $HERO_ID_MERCENARY_3 = 30, $HERO_ID_MERCENARY_4, $HERO_ID_MERCENARY_5, $HERO_ID_MERCENARY_6, $HERO_ID_MERCENARY_7, $HERO_ID_MERCENARY_8 = 35, $HERO_ID_Miku , $HERO_ID_Zei_Ri

; Identification and Salvaging Stuff
Global Const $SupIDKit = 5899
Global Const $ExpertSalvKit = 2991
Global Const $Ectoplasm_ID = 930

; ==== Build ====
;Global Const $SkillBarTemplate = "OgGlQtVoKtmsHhT2XwTsDmL29xeJeBs"
Global Const $SkillBarTemplate = "OgGlQpVpatmsHhT2XwTsDmL29JeRgB"
; declare skill numbers to make the code WAY more readable (UseSkill($sf) is better than UseSkill(2))
Global Const $fnp = 1
Global Const $hb = 2
Global Const $ttl = 3
Global Const $whirl = 4
Global Const $ebsoh = 5
Global Const $ga = 6
Global Const $vital = 7
Global Const $conv = 8
; Store skills energy cost
Global $skillCost[9]
$skillCost[$fnp] = 5
$skillCost[$hb] = 5
$skillCost[$ttl] = 5
$skillCost[$whirl] = 0
$skillCost[$ebsoh] = 10
$skillCost[$ga] = 10
$skillCost[$vital] = 5
$skillCost[$conv] = 5

Global $Buildsloaded = 0

;~ Timer
Global $indicator = 1

;~ ModelID for Enemies and NPCs
Global Const $Hexreaper = 6618
Global Const $Flameshielder = 6623
Global Const $BloodsongID = 4227
Global Const $FazeMagekiller = 6543
Global Const $MinistryClericID = 8413
Global Const $BoneFiendID = 2231
Global Const $BoneHorrorID = 2230
Global Const $BoneMinionID = 2232
Global Const $ShamblingHorrorID = 5713
Global Const $JaggedHorrorID = 5714
Global Const $VampiricHorrorID = 4210
Global Const $FleshGolemID = 4209
Global $MikuAgentID
Global $MakeHasteCheck = False
Global $MakeHasteAlive
Global $MakeHasteRange
Global $AmIDrunk = 0

; ==== Build ====
; declare skill numbers to make the code WAY more readable (UseSkill($sf) is better than UseSkill(2))


; Enemy ID Constants from A Chance Encounter (based on death log analysis)
Global Const $PurityID = 8408           ; Purger Soul Bind - High priority
Global Const $BladesmanDaggerID = 8415  ; Bladesman Palm - High priority
Global Const $BladesmanLyssaID = 8416   ; Bladesman Lyssa
Global Const $RangerBarrageID = 8395    ; Ranger Barrage - High priority
Global Const $RangerTrapperID = 8397    ; Ranger Trapper
Global Const $IlluInvokeID = 8405       ; Illu Extend Conditions - High priority
Global Const $IlluID = 8403             ; Illu Keystone Signet
Global Const $PurgerID = 8407           ; Purger Icy Veins
Global Const $MageGlowstoneID = 8401    ; Mage Sandstorm - High priority
Global Const $MageRitID = 8400          ; Mage Invoke - High priority
Global Const $ClericID = 8413           ; Cleric - High priority
Global Const $EnforcerID = 8393         ; Enforcer - High priority
Global Const $CaptainID = 8423          ; Captain - High priority


; Global variables for target persistence
Global $g_CurrentTarget = 0
Global $g_CurrentTargetTimer = 0

;~ Outpost - Map
Global Const $iGaddsEncampmentMapID = 638
Global Const $iSplarkflyMapID = 558
Global Const $iBogrootGrowthsLevel1MapID = 615
Global Const $iBogrootGrowthsLevel2MapID = 616
Global Const $Town_ID_Great_Temple_of_Balthazar = 248
Global Const $Town_ID_EyeOfTheNorth = 642
Global $inventorytrigger = 0
Global $mapindicator = 1
Global $Town_ID_Farm = $iGaddsEncampmentMapID

;~ Koordinates
Global $coords[2]
Global $X
Global $Y

;~ Timer -> For when killing takes too long or stucked enemies
Global $runcounter = 1
Global $Stucktimer = 0
Global $RunningTimer = 0
Global $mystictimer1 = 0
Global $mystictimer2 = 0
Global $indicator = 1
Global Const $blinded = 479


Global $Rendering = True
#EndRegion


Global $heroNumberWithRez[0]


;#Region DP Removal
Global Const $ID_Peppermint_CC              = 6370
Global Const $ID_Refined_Jelly              = 19039
Global Const $ID_Elixir_of_Valor            = 21227
Global Const $ID_Wintergreen_CC             = 21488
Global Const $ID_Rainbow_CC                 = 21489
Global Const $ID_Four_Leaf_Clover           = 22191
Global Const $ID_Honeycomb                  = 26784
Global Const $ID_Pumpkin_Cookie             = 28433
Global Const $ID_Oath_of_Purity             = 30206
Global Const $ID_Seal_of_the_Dragon_Empire  = 30211
Global Const $ID_Shining_Blade_Ration       = 35127

Global Const $DPRemoval_Sweets[] = [ _
    $ID_Peppermint_CC, $ID_Refined_Jelly, $ID_Elixir_of_Valor, _
    $ID_Wintergreen_CC, $ID_Rainbow_CC, $ID_Four_Leaf_Clover, _
    $ID_Honeycomb, $ID_Pumpkin_Cookie, $ID_Oath_of_Purity, _
    $ID_Seal_of_the_Dragon_Empire, $ID_Shining_Blade_Ration _
]
;#EndRegion DP Removal


;~ Rez Skills
Global $RezSkillIDs[15]
$RezSkillIDs[0] = 2 ; Resurrection Signet
$RezSkillIDs[1] = 268 ; Unyielding Aura
$RezSkillIDs[2] = 304 ; Light of Dwayna
$RezSkillIDs[3] = 305 ; Resurrect
$RezSkillIDs[4] = 306 ; Rebirth
$RezSkillIDs[5] = 314 ; Restore Life
$RezSkillIDs[6] = 315 ; Vengeance
$RezSkillIDs[7] = 791 ; Flesh of my Flesh
$RezSkillIDs[8] = 963 ; Restoration
$RezSkillIDs[9] = 1128 ; Resurrection Chant
$RezSkillIDs[10] = 1222 ; Lively Was Naomei
$RezSkillIDs[11] = 1263 ; Renew Life
$RezSkillIDs[12] = 1481 ; Death Pact Signet
$RezSkillIDs[13] = 1592 ; "We Shall Return"
$RezSkillIDs[14] = 1778 ; Signet of Return

;~ Summoning Stones
Global $SummoningStone[19]
$SummoningStone[0] = 37810	; LegionLegionnaire 
$SummoningStone[1] = 30209	; Tengu
$SummoningStone[2] = 30210	; Imperial Guard
$SummoningStone[3] = 35126	; Shining Blade
$SummoningStone[4] = 31156	; Zaishen 
$SummoningStone[5] = 32557	; Ghastly
$SummoningStone[6] = 31155	; Mysterious
$SummoningStone[7] = 30960	; Mystical
$SummoningStone[8] = 30963	; Demonic
$SummoningStone[9] = 34176	; Celestial
$SummoningStone[10] = 30961	; Amber
$SummoningStone[11] = 30966	; Jadeite
$SummoningStone[12] = 30846	; Automaton
$SummoningStone[13] = 30965	; Fossilized
$SummoningStone[14] = 30959	; Chitinous
$SummoningStone[15] = 30964	; Gelatinous
$SummoningStone[16] = 30962	; Arctic
$SummoningStone[17] = 31022	; Mischievous
$SummoningStone[18] = 31023	; Frosty

;~ Conset
Global $Conset[3]
$Conset[0] = 24859	; Essence of Celerity
$Conset[1] = 24860	; Armor of Salvation
$Conset[2] = 24861	; Grail fo Might

Global Const $EffectEssence = 2522
Global Const $EffectArmor = 2520
Global Const $EffectGrail = 2521

;~ Pcons
Global $Pcon[19]
$Pcon[0] = 17060	; Drake Kabob
$Pcon[1] = 17061	; Skalefin Soup
$Pcon[2] = 17062	; Pahnai Salad
$Pcon[3] = 22269	; Birthday Cupcake
$Pcon[4] = 22752	; Golden Egg
$Pcon[5] = 28431	; Candy Apple
$Pcon[6] = 28432	; Candy Corn
$Pcon[7] = 28436	; Slice of Pumpkin Pie
$Pcon[8] = 29425	; Lunar Fortune 2008
$Pcon[9] = 29426	; Lunar Fortune 2009
$Pcon[10] = 29427	; Lunar Fortune 2010
$Pcon[11] = 29428	; Lunar Fortune 2011
$Pcon[12] = 29429	; Lunar Fortune 2012
$Pcon[13] = 29430	; Lunar Fortune 2013
$Pcon[14] = 29431	; Lunar Fortune 2014
$Pcon[15] = 31151	; Blue Rock Candy
$Pcon[16] = 31152	; Green Rock Candy
$Pcon[17] = 31153	; Red Rock Candy
$Pcon[18] = 35121	; War Supplies

; Global variables for optimized targeting system
Global $g_CurrentTarget = 0
Global $g_CurrentTargetTimer = 0


;~ Description: Returns the distance between two agents.
Func GetDistance($aAgent1 = -1, $aAgent2 = -2)
	If IsDllStruct($aAgent1) = 0 Then $aAgent1 = Agent_GetAgentPtr($aAgent1)
	If IsDllStruct($aAgent2) = 0 Then $aAgent2 = Agent_GetAgentPtr($aAgent2)
	Return Sqrt((Agent_GetAgentInfo($aAgent1, "X") - Agent_GetAgentInfo($aAgent2, "X")) ^ 2 + (Agent_GetAgentInfo($aAgent1, "Y") - Agent_GetAgentInfo($aAgent2, "Y")) ^ 2)
EndFunc   ;==>GetDistance

Func GetPartyDefeated()
	; Party is defeated, when you die, while Malus is at 60%
	Return Party_GetPartyContextInfo("IsDefeated")
EndFunc ;==> GetPartyDefeated


Func GetNearestSignpostToAgent($aAgentID = -2, $aRange = 1320, $aReturnMode = 1, $aCustomFilter = "")
    Return GetAgents($aAgentID, $aRange, $GC_I_AGENT_TYPE_GADGET, $aReturnMode, $aCustomFilter)
EndFunc ;==>GetNearestSignpostToAgent

; ==========================
; Check if bot is in a "safe" state to continue
; ==========================
Func CheckSafeState()
    ; Dead -> stop directly
    If Agent_GetAgentInfo(-2, "IsDead") Then
        Out("CheckSafeState: Player is dead, abort function")
        Return False
    EndIf

    ; Not moving AND no enemies -> no point continuing
    If Not Agent_GetAgentInfo(-2, "IsMoving") And _
       GetNumberOfFoesInRangeOfAgent(-2, 1500, $GC_I_AGENT_TYPE_LIVING, 1, "EnemyFilter") = 0 Then
        Out("CheckSafeState: No movement and no enemies")
        Return False
    EndIf

    ; All good -> can continue
    Return True
EndFunc


Func HasDeathPenalty()
    Return Party_GetMoraleInfo(-2, "IsMoralePenalty")
EndFunc

Func MoralUp()
    ; Tant qu’il y a un malus de morale
    While Party_GetMoraleInfo(-2, "IsMoralePenalty")
        If Not UseFirstDPRemoval() Then
            Out("Aucun DP Removal trouvé")
            ExitLoop
        EndIf
        Out("DP Removal utilisé")
        Sleep(500)
    WEnd

    If Not Party_GetMoraleInfo(-2, "IsMoralePenalty") Then
        Out("Death Penalty supprimé")
    EndIf
EndFunc


Func UseFirstDPRemoval()
    Local $lItemPtr, $lItemID

    For $i = 1 To 4 ; Parcourt les 4 sacs
        For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), "Slots")
            $lItemPtr = Item_GetItemBySlot($i, $j)
            If $lItemPtr = 0 Then ContinueLoop ; Slot vide

            $lItemID = Item_GetItemInfoByPtr($lItemPtr, "ModelID")

            For $ii = 0 To UBound($DPRemoval_Sweets) - 1
                If $lItemID = $DPRemoval_Sweets[$ii] Then
                    Item_UseItem($lItemPtr)
                    Sleep(250)
                    Return True ; Stop après avoir utilisé un item
                EndIf
            Next
        Next
    Next

    Return False ; Aucun DP removal trouvé
EndFunc


; Calcul distance entre 2 points
Func ComputeDistance($x1, $y1, $x2, $y2)
    Return Sqrt(($x2 - $x1)^2 + ($y2 - $y1)^2)
EndFunc

; === Steps system ===
Global Const $MAX_STEPS = 300
Global $aSteps[$MAX_STEPS][4] ; tableau des waypoints : Step, X, Y, Mode
Global $iStepsCount = 0       ; Nombre de steps enregistrés
Global $iCurrentStep = 0      ; Step actuel

Func RegisterStep($step, $x, $y, $mode = "aggro")
    If $iStepsCount < $MAX_STEPS Then
        $aSteps[$iStepsCount][0] = $step   ; numéro du step
        $aSteps[$iStepsCount][1] = $x      ; coordonnée X
        $aSteps[$iStepsCount][2] = $y      ; coordonnée Y
        $aSteps[$iStepsCount][3] = $mode   ; mode ("move" ou "aggro")
        $iStepsCount += 1
    Else
        Out("⚠️ Error: too many steps (>" & $MAX_STEPS & ")")
    EndIf
EndFunc


; Tolerance for identifying a shrine (max distance)
Global Const $SANCTUAIRE_TOLERANCE = 600

; [MapID, Step, X, Y]
Global $aSanctuaires[7][4]

; === Etage 1 ===
$aSanctuaires[0][0] = $iBogrootGrowthsLevel1MapID
$aSanctuaires[0][1] = 2
$aSanctuaires[0][2] = 19045.95
$aSanctuaires[0][3] = 7877

$aSanctuaires[1][0] = $iBogrootGrowthsLevel1MapID
$aSanctuaires[1][1] = 19
$aSanctuaires[1][2] = 5083
$aSanctuaires[1][3] = 2155

$aSanctuaires[2][0] = $iBogrootGrowthsLevel1MapID
$aSanctuaires[2][1] = 30
$aSanctuaires[2][2] = -1547
$aSanctuaires[2][3] = -8696

; === Etage 2 ===
$aSanctuaires[3][0] = $iBogrootGrowthsLevel2MapID
$aSanctuaires[3][1] = 42
$aSanctuaires[3][2] = -11055
$aSanctuaires[3][3] = -5533

$aSanctuaires[4][0] = $iBogrootGrowthsLevel2MapID
$aSanctuaires[4][1] = 63
$aSanctuaires[4][2] = -955
$aSanctuaires[4][3] = 10984

$aSanctuaires[5][0] = $iBogrootGrowthsLevel2MapID
$aSanctuaires[5][1] = 75
$aSanctuaires[5][2] = 8591
$aSanctuaires[5][3] = 4285

; === LastStep (toujours étage 2) ===
$aSanctuaires[6][0] = $iBogrootGrowthsLevel2MapID
$aSanctuaires[6][1] = 94
$aSanctuaires[6][2] = 19619
$aSanctuaires[6][3] = -11498



Func GetNearestSanctStep()
    Local $px = Agent_GetAgentInfo(-2, "X")
    Local $py = Agent_GetAgentInfo(-2, "Y")
    Local $curMap = Map_GetMapID()

    Local $bestStep = -1, $bestDist = 999999

    For $i = 0 To UBound($aSanctuaires) - 1
        If $aSanctuaires[$i][0] = $curMap Then ; bonne carte
            Local $sx = $aSanctuaires[$i][2]
            Local $sy = $aSanctuaires[$i][3]
            Local $dist = ComputeDistance($px, $py, $sx, $sy)
            If $dist < $bestDist And $dist <= $SANCTUAIRE_TOLERANCE Then
                $bestDist = $dist
                $bestStep = $aSanctuaires[$i][1]
            EndIf
        EndIf
    Next

    Return $bestStep ; -1 if no shrine detected
EndFunc

Func HandleResurrection($lastStep)
    Out("Death detected, waiting for resurrection...")
    Do
        Sleep(1000)
    Until Not Agent_GetAgentInfo(-2, "IsDead")

    ; Coordinates after rez
    Local $px = Agent_GetAgentInfo(-2, "X")
    Local $py = Agent_GetAgentInfo(-2, "Y")

    ; Check if we are near a known shrine
    Local $sanctStep = GetNearestSanctStep()
    If $sanctStep <> -1 Then
        Out("Resurrection at shrine -> resuming from step " & $sanctStep)
		MoralUp()

        ; Replay up to last step reached before death
        For $i = $sanctStep + 1 To $lastStep - 1
            Local $sx = $aSteps[$i][1], $sy = $aSteps[$i][2], $smode = $aSteps[$i][3]
            Out("Replaying step " & $i & " (" & $smode & ")")
            If $smode = "aggro" Then
                AggroMoveToEx($sx, $sy)
            Else
                MoveTo($sx, $sy)
            EndIf
        Next
        $iCurrentStep = $lastStep - 1
    Else
        Out("Rez outside shrine detected (rez in place) -> not moving")
		MoralUp()
    EndIf
EndFunc


; ----------------------
; DoStep: main function to use in your script
; - handles resurrection / recovery of missed steps
; - uses _DoStepInternal for movements and detours
; ----------------------
; === Death management ===
Func DoStep($step, $x, $y, $mode = "aggro")
    RegisterStep($step, $x, $y, $mode)

    ; Safety timer
    Local $stepTimer = TimerInit()
    Local $customtimer = 20000 ; Adjustable timer

    ; Immediate death handling
    If Agent_GetAgentInfo(-2, "IsDead") Then
        HandleDeath($step)
    EndIf

    ; Movement
    If $mode = "aggro" Then
        AggroMoveToEx($x, $y)
    Else
        MoveTo($x, $y)
    EndIf

    While True
        Sleep(10)

        ; Death en route
        If Agent_GetAgentInfo(-2, "IsDead") Then
            Out("Death detected -> waiting for resurrection...")
            HandleDeath($step) ; wait for rez properly
            Out("Resuming step " & $step & " after resurrection")
            Return DoStep($step, $x, $y, $mode)
        EndIf

        Local $curX = Agent_GetAgentInfo(-2, "X")
        Local $curY = Agent_GetAgentInfo(-2, "Y")
        Local $distToDest = ComputeDistance($curX, $curY, $x, $y)

        ; Step reached
        If $distToDest < 100 Then
            Out("Step " & $step & " reached (" & $x & "," & $y & ")")
            $iCurrentStep = $step
            Return True ; Step success
        EndIf

        ; In combat -> reset timer
        If GetNumberOfFoesInRangeOfAgent(-2, 1000, $GC_I_AGENT_TYPE_LIVING, 1, "EnemyFilter") > 0 Then
            $stepTimer = TimerInit()
        Else
            ; Timeout only if character is IMMOBILE and out of combat
            If TimerDiff($stepTimer) > $customtimer Then
                If Agent_GetAgentInfo(-2, "MoveX") = 0 And Agent_GetAgentInfo(-2, "MoveY") = 0 Then
                    Out("Timeout at step " & $step & " -> attempting smart recovery")
                    Return False ; Step failed
                Else
                    ; still moving -> reset timer
                    $stepTimer = TimerInit()
                EndIf
            EndIf
        EndIf
    WEnd

    ; === Optional loot
    If $EnableChestFarm And $ChestFarmActive Then OpenNearbyChestsFiltered()

    Return False ; If we exit the loop without success
EndFunc



Func TryRecoverStep($failedStep)
    Local $curX = Agent_GetAgentInfo(-2, "X")
    Local $curY = Agent_GetAgentInfo(-2, "Y")

    ; Search neighboring step (-3 to +3)
    For $offset = -3 To 3
        If $offset = 0 Then ContinueLoop
        Local $testStep = $failedStep + $offset
        If $testStep < 1 Or $testStep > UBound($aSteps) - 1 Then ContinueLoop

        Local $sx = $aSteps[$testStep][1]
        Local $sy = $aSteps[$testStep][2]
        Local $dist = ComputeDistance($curX, $curY, $sx, $sy)

        If $dist < 150 Then
            Out("Resuming from neighboring step " & $testStep)
            $iCurrentStep = $testStep
            Return
        EndIf
    Next

    ; If no neighboring step -> resume from shrine
    Local $sanctStep = GetNearestSanctStep()
    If $sanctStep <> -1 Then
        Out("Resuming from shrine -> step " & $sanctStep)
        $iCurrentStep = $sanctStep
    Else
        Out("No neighboring step or shrine found -> returning to previous step")
        $iCurrentStep = $failedStep - 1
        If $iCurrentStep < 1 Then $iCurrentStep = 1
    EndIf
EndFunc



; ===========================
; Death management
; ===========================
Func HandleDeath($lastStep)
    Out("Death detected, waiting for resurrection...")
    Do
        Sleep(1000)
    Until Not Agent_GetAgentInfo(-2, "IsDead")

    ; Check if rez at a shrine
    Local $rezStep = GetNearestSanctStep()
    If $rezStep <> -1 Then
        Out("Resurrection at shrine (step " & $rezStep & ")")
        $iCurrentStep = $rezStep
    Else
        ; Otherwise resume at closest step
        Local $px = Agent_GetAgentInfo(-2, "X")
        Local $py = Agent_GetAgentInfo(-2, "Y")
        Local $bestStep = 0, $bestDist = 999999

        For $i = 0 To $iStepsCount - 1
            Local $dx = $aSteps[$i][1], $dy = $aSteps[$i][2]
            Local $dist = ComputeDistance($px, $py, $dx, $dy)
            If $dist < $bestDist Then
                $bestDist = $dist
                $bestStep = $aSteps[$i][0]
            EndIf
        Next

        Out("💀 Résurrection → reprise depuis step " & $bestStep & " (dist=" & $bestDist & ")")
        $iCurrentStep = $bestStep
    EndIf

    ; MoralUp pour virer le malus
    MoralUp()

    ; Rejouer les étapes manquantes jusqu'au step avant la mort
    For $i = $iCurrentStep + 1 To $lastStep - 1
        Local $sx = $aSteps[$i][1], $sy = $aSteps[$i][2], $smode = $aSteps[$i][3]
        Out("↪️ Rejoue step " & $i & " (" & $smode & ")")
        If $smode = "aggro" Then
            AggroMoveToEx($sx, $sy)
        Else
            MoveTo($sx, $sy)
        EndIf
    Next
EndFunc


Func Powerup()
    ; Vérifie si conset activé
    If GUICtrlRead($PconsBox) = $GUI_CHECKED Then
        Out("Activate Cons")
        If GetPartyDefeated() Then Return
        If FindConset() Then UseConset()

    ; Vérifie si pierre d'invocation activée
    ElseIf GUICtrlRead($Summon1) = $GUI_CHECKED Then
        Local $stonePtr = FindSummoningStone()
        If $stonePtr <> 0 Then
            UseSummoningStone()
        Else
            Out("❌ No summoning stone found")
        EndIf
    EndIf
EndFunc


Func Powerup2()
    ; Vérifie si conset activé
    If GUICtrlRead($PconsBox2) = $GUI_CHECKED Then
        Out("Activate Cons")
        If GetPartyDefeated() Then Return
        If FindConset() Then UseConset()

    ; Vérifie si pierre d'invocation activée
    ElseIf GUICtrlRead($Summon2) = $GUI_CHECKED Then
        Local $stonePtr = FindSummoningStone()
        If $stonePtr <> 0 Then
            UseSummoningStone()
        Else
            Out("❌ No summoning stone found")
        EndIf
    EndIf
EndFunc


Func FindConset()
	Local $lItemPtr
	Local $litemID
	Local $consetItemCounter = 0
	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			$lItemID = Item_GetItemInfoByPtr($lItemPtr, 'ModelID')
			For $ii = 0 to UBound($Conset) - 1
				If $litemID = $Conset[$ii] Then
					$consetItemCounter += 1
				EndIf
			Next
		Next
	Next

	If $consetItemCounter = 3 Then Return True
	Return False
EndFunc   ;==>FindConset

Func UseConset()
	Local $lItemPtr
	Local $lItemID

	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			$lItemID = Item_GetItemInfoByPtr($lItemPtr, 'ModelID')
			For $ii = 0 to UBound($Conset) - 1
				If $lItemID = $Conset[$ii] Then
					If $ii = 0 and GetEffectTimeRemainingEx(-2, $EffectEssence) = 0 then
						Item_UseItem($lItemPtr)
						Sleep(250)
					ElseIf $ii = 1 and GetEffectTimeRemainingEx(-2, $EffectArmor) = 0 then
						Item_UseItem($lItemPtr)
						Sleep(250)
					ElseIf $ii = 2 and GetEffectTimeRemainingEx(-2, $EffectGrail) = 0 then
						Item_UseItem($lItemPtr)
						Sleep(250)
					Else
						ContinueLoop
					EndIf
				EndIf
			Next
		Next
	Next
	Return
EndFunc	   ;==>UseConset

Func GetNearestChestToAgent($aAgentID = -2, $aRange = $RANGE_COMPASS, $aType = $GC_I_AGENT_TYPE_GADGET, $aReturnMode = 1, $aCustomFilter = "ChestFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)	
EndFunc	;==>GetNearestChestToAgent

Func GetNumberOfFoesInRangeOfAgent($aAgentID = -2, $aRange = 1200, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 0, $aCustomFilter = "EnemyFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNumberOfFoesInRangeOfAgent


; Cherche la première pierre dans l'inventaire et renvoie son pointeur
Func FindSummoningStone()
    Local $lItemPtr, $lItemID
    For $i = 1 To 4 ; 4 sacs
        For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), "Slots")
            $lItemPtr = Item_GetItemBySlot($i, $j)
            If $lItemPtr = 0 Then ContinueLoop ; case vide

            $lItemID = Item_GetItemInfoByPtr($lItemPtr, "ModelID")
            
            ; Compare avec toutes les pierres disponibles
            For $ii = 0 To UBound($SummoningStone) - 1
                If $lItemID = $SummoningStone[$ii] Then
                    Return $lItemPtr ; ✅ on renvoie directement le pointeur de la 1ère trouvée
                EndIf
            Next
        Next
    Next
    Return 0 ; aucune pierre trouvée
EndFunc   ;==>FindSummoningStone


; Utilise la première pierre trouvée
Func UseSummoningStone()
    ; Vérifie si Summoning Sickness actif (empêche d'utiliser une autre pierre)
    If GetEffectTimeRemainingEx(-2, 2886) <> 0 Then Return False

    Local $stonePtr = FindSummoningStone()
    If $stonePtr = 0 Then
        Out("❌ No summoning stone found in inventory")
        Return False
    EndIf

    ; Utilisation de la pierre
    Item_UseItem($stonePtr)
    Sleep(250)

    Out("✨ Summoning Stone used!")
    Return True
EndFunc   ;==>UseSummoningStone


Func CheckAreaRange($aX, $aY, $range)
	$ret = False
	$pX = Agent_GetAgentInfo(-2, "X")
	$pY = Agent_GetAgentInfo(-2, "Y")

	If ($pX < $aX + $range) And ($pX > $aX - $range) And ($pY < $aY + $range) And ($pY > $aY - $range) Then
		$ret = True
	EndIf
	Return $ret
EndFunc   ;==>CheckAreaRange
#EndRegion Calculations

#Region Travel
Func RndTravel($aMapID)
	Local $UseDistricts = 7 ; 7=eu, 8=eu+int, 11=all(incl. asia)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, int, asia-ko, asia-ch, asia-ja
	Local $Region[11]   = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
;~ 	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	Map_MoveMap($aMapID, $Region[$Random], 0, $Language[5])
	Map_WaitMapLoading($aMapID, 0)
	Sleep(1000)
EndFunc   ;==>RndTravel

Func RndTravel2($aMapID)
	Local $UseDistricts = 7 ; 7=eu, 8=eu+int, 11=all(incl. asia)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, int, asia-ko, asia-ch, asia-ja
	Local $Region[11]   = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
;~ 	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	Map_MoveMap($aMapID, $Region[$Random], 0, $Language[2])
	Map_WaitMapLoading($aMapID, 0)
	Sleep(1000)
EndFunc   ;==>RndTravel
#EndRegion Travel

#Region Other
;~ Description: Resign.
Func Resign()
	Chat_SendChat('resign', '/')
EndFunc   ;==>Resign

Func GetisDead($aAgent = -2)
	Return Agent_GetAgentInfo($aAgent, "IsDead")
EndFunc	;==>GetisDead

Func GetEnergy($aAgent = -2)
	Return Agent_GetAgentInfo($aAgent, "CurrentEnergy")
EndFunc	;==>GetEnergy
#EndRegion


#Region Movement
Func MoveTo($aX, $aY, $aRandom = 100)
    If GetIsDead(-2) Then Return

    Local $lBlocked = 0
    Local $lMapStart = Map_GetMapID()
    Local $lDestX = $aX + Random(-$aRandom, $aRandom)
    Local $lDestY = $aY + Random(-$aRandom, $aRandom)
    Local $lStuckTimer = TimerInit()

    ; Premier mouvement
    Map_Move($lDestX, $lDestY, 0)

    Do
        Sleep(100)

        ; Mort → stop
        If GetIsDead(-2) Then ExitLoop

        ; 🚪 Détection changement de map
        If Map_GetMapID() <> $lMapStart Then ExitLoop

        ; Vérifie si le perso bouge
        If Agent_GetAgentInfo(-2, "IsMoving") Then
			Map_Move($lDestX, $lDestY, 0)
            ; reset du timer si le perso avance
            $lStuckTimer = TimerInit()
        Else
            ; si pas de mouvement depuis trop longtemps → blocage
            If TimerDiff($lStuckTimer) > 5000 Then ; 8s immobile
                $lBlocked += 1
                Out("⚠️ Blocage détecté (" & $lBlocked & ") → nouvelle tentative")

                ; recalcul d’une nouvelle destination
                $lDestX = $aX + Random(-$aRandom, $aRandom)
                $lDestY = $aY + Random(-$aRandom, $aRandom)

                Map_Move($lDestX, $lDestY, $aRandom)
                $lStuckTimer = TimerInit()
            EndIf
        EndIf

    Until ComputeDistance(Agent_GetAgentInfo(-2, "X"), Agent_GetAgentInfo(-2, "Y"), $lDestX, $lDestY) < 50 _
       Or $lBlocked > 3 _
       Or GetIsDead(-2)

EndFunc   ;==>MoveTo
#EndRegion


Func AggroMoveToEx($x, $y, $s = "", $z = 1500)

	If GetPartyDead() Then Return
	$TimerToKill = TimerInit()
	Local $random = 50
	Local $iBlocked = 0
	Local $enemy
	Local $distance

	Map_Move($x, $y, $random)
	$coords[0] = Agent_GetAgentInfo(-2, 'X')
	$coords[1] = Agent_GetAgentInfo(-2, 'Y')
	Do
		If GetPartyDead() Then ExitLoop
		Other_RndSleep(250)
		$oldCoords = $coords
		If GetNumberOfFoesInRangeOfAgent(-2,1500,$GC_I_AGENT_TYPE_LIVING,1,"EnemyFilter") > 0 Then
			If GetPartyDead() Then ExitLoop
			$enemy = GetNearestEnemyToAgent(-2,1500,$GC_I_AGENT_TYPE_LIVING,1,"EnemyFilter")
			If GetPartyDead() Then ExitLoop
			$distance = ComputeDistance(Agent_GetAgentInfo($enemy, 'X'), Agent_GetAgentInfo($enemy, 'Y'), Agent_GetAgentInfo(-2, 'X'), Agent_GetAgentInfo(-2, 'Y'))
			If $distance < $z And $enemy <> 0 and GetPartyDead() = false Then
				Fight($z, $s)
			EndIf
		EndIf

		Other_RndSleep(250)

		If GetPartyDead() Then ExitLoop
		$coords[0] = Agent_GetAgentInfo(-2, 'X')
		$coords[1] = Agent_GetAgentInfo(-2, 'Y')
		If $oldCoords[0] = $coords[0] And $oldCoords[1] = $coords[1] and GetPartyDead() = false Then
			$iBlocked += 1
			MoveTo($coords[0], $coords[1], 300)
			Other_RndSleep(350)
			If GetPartyDead() Then ExitLoop
			Map_Move($x, $y)
		EndIf

	Until ComputeDistance($coords[0], $coords[1], $x, $y) < 250 Or $iBlocked > 20 or GetPartyDead() or TimerDiff($TimerToKill) > 180000
EndFunc   ;==>AggroMoveToEx


; More precise movement function for exact positioning
Func MoveToExact($aX, $aY, $aTolerance = 10)
	If GetisDead(-2) Then Return
	Local $lBlocked = 0
	Local $lMapLoading = Map_GetInstanceInfo("Type"), $lMapLoadingOld
	Local $lDestX = $aX
	Local $lDestY = $aY
	Local $lAttempts = 0
	Local $lStuckTimer = TimerInit()

	Out("Moving to exact position: (" & $aX & ", " & $aY & ") with tolerance " & $aTolerance)

	Map_Move($lDestX, $lDestY, 0)

	Do
		Sleep(100)

		If GetisDead(-2) Then ExitLoop

		$lMapLoadingOld = $lMapLoading
		$lMapLoading = Map_GetInstanceInfo("Type")
		If $lMapLoading <> $lMapLoadingOld Then ExitLoop

		Local $currentDistance = ComputeDistance(Agent_GetAgentInfo(-2, "X"), Agent_GetAgentInfo(-2, "Y"), $lDestX, $lDestY)

		; If we're close enough, we're done
		If $currentDistance <= $aTolerance Then
			Out("Reached exact position. Final distance: " & Round($currentDistance, 2))
			ExitLoop
		EndIf

		; Check if character is stuck (not moving)
		If Agent_GetAgentInfo(-2, "MoveX") == 0 And Agent_GetAgentInfo(-2, "MoveY") == 0 Then
			If TimerDiff($lStuckTimer) > 2000 Then ; Stuck for more than 2 seconds
				$lBlocked += 1
				Out("Character stuck, attempt " & $lBlocked & ". Distance remaining: " & Round($currentDistance, 2))

				; Try slight variations in destination to avoid obstacles
				Local $offsetX = Random(-20, 20)
				Local $offsetY = Random(-20, 20)
				Map_Move($lDestX + $offsetX, $lDestY + $offsetY, 0)
				Sleep(500)

				; Then try to move to exact position again
				Map_Move($lDestX, $lDestY, 0)
				$lStuckTimer = TimerInit()
				EndIf
		Else
			$lStuckTimer = TimerInit() ; Reset stuck timer if moving
		EndIf

		$lAttempts += 1

		; Periodically re-issue move command to ensure we're heading to exact coordinates
		If Mod($lAttempts, 20) == 0 Then
			Map_Move($lDestX, $lDestY, 0)
		EndIf

	Until $lBlocked > 10 or GetisDead(-2) or $lAttempts > 300 ; Max 30 seconds of attempts

	Local $finalDistance = ComputeDistance(Agent_GetAgentInfo(-2, "X"), Agent_GetAgentInfo(-2, "Y"), $lDestX, $lDestY)
	If $finalDistance > $aTolerance Then
		Out("Warning: Could not reach exact position. Final distance: " & Round($finalDistance, 2))
	EndIf
EndFunc   ;==>MoveToExact

Func MoveAggroing($lDestX, $lDestY, $lRandom = 150)
	If GetIsDead(-2) Then Return
	Local $Me
	Local $distance
	Local $lAngle = 0
	Local $block = 0

	Map_Move($lDestX, $lDestY, $lRandom)

	Do
		Other_RndSleep(100)
		If GetIsDead(-2) Then ExitLoop
		StayAlive()
		$distance = ComputeDistance(Agent_GetAgentInfo(-2, "X"), Agent_GetAgentInfo(-2, "Y"), $lDestX, $lDestY)

		If Agent_GetAgentInfo(-2, "MoveX") == 0 And Agent_GetAgentInfo(-2, "MoveY") == 0 And $distance > $lRandom * 1.5 Then
			$block += 1
			$lAngle += 40
			Map_Move(Agent_GetAgentInfo(-2, "X") + 300 * Sin($lAngle), Agent_GetAgentInfo(-2, "Y") + 300 * Cos($lAngle))
		EndIf
		Map_Move($lDestX, $lDestY, $lRandom)
	Until $distance < $lRandom * 1.5 Or $block > 10

EndFunc   ;==>MoveAggroing
#EndRegion

Func ResetRun()
    $iCurrentStep = 0
    $iStepsCount = 0
EndFunc ; ==>ResetSteps()

Func HandleTekks($action, $questID = 0x339)
    ; $action = "take" ou "reward"
    Global $TekksAgentID = 0  ; Initialize to prevent null pointer access

    ; === Trouver Tekks ===
    Local $Tekks = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter") ; Recherche Tekks
    If $Tekks > 0 Then
        ; Récupérer l'ID de Tekks
        $TekksAgentID = Agent_GetAgentInfo($Tekks, "ID")
        Out("Tekks NPC found with Agent ID: " & $TekksAgentID)
    Else
        $TekksAgentID = 0
        Out("Warning: Could not find Tekks NPC")
        Return ; Sortie si Tekks n'est pas trouvé
    EndIf

    ; === Position Tekks avec léger offset ===
    Local $offset = 20 ; distance de décalage
    Local $npcX = Agent_GetAgentInfo($Tekks, "X") - $offset
    Local $npcY = Agent_GetAgentInfo($Tekks, "Y") - $offset

    ; === Choix de l'action ===
    If $action = "take" Then
        Out(">>> Going to Tekks to take quest")
        MoveTo($npcX, $npcY)
        Sleep(250)
        
        Agent_GoNPC($Tekks) ; Utilisation de l'ID de Tekks
        Sleep(2000)
        Quest_AcceptQuest($questID)
        Sleep(2000)

        If Quest_GetQuestInfo($questID, "QuestID") Then
            Out("Quest accepted at Tekks ✅")
        EndIf
    ElseIf $action = "reward" Then
        Out(">>> Going to Tekks to validate quest")
        MoveTo($npcX, $npcY)
        Sleep(250)

        Agent_GoNPC($Tekks) ; Utilisation de l'ID de Tekks
        Sleep(2000)
        Quest_QuestReward($questID)
        Sleep(2000)

        If Not Quest_GetQuestInfo($questID, "QuestID") Then
            Out("Quest validated at Tekks 🎉")
        EndIf
    EndIf ; <-- Fermeture du bloc If
EndFunc ;==> HandleTekks




; ----------------------------------------------------------------
; QuestManager_AfterReload($questID)
;  - Doit être appelé **après** le reload (Map_GetMapID() == $iSplarkflyMapID)
;  - Retour : entière (codes)
;      1  -> la quête n'est plus dans le log (déjà validée en donjon) => on a pris la nouvelle quête (take)
;      2  -> la quête est présente et peut être validée => on a fait reward (caller doit ensuite faire ReloadQuest->TakeQuestNewRun->Re_Enter)
;      0  -> état non géré / incomplete / rien fait (sécurité)
;     -1  -> pas sur Sparkfly (appel invalide)
;     -2  -> échec de la prise de quête après reward-in-dungeon
; ----------------------------------------------------------------
Func QuestManager_AfterReload($questID = 0x339)
    ; Vérifie qu'on est bien à Sparkfly (obligatoire)
    If Map_GetMapID() <> $iSplarkflyMapID Then
        Out("QuestManager_AfterReload: appel annulé — pas sur Sparkfly (MapID=" & Map_GetMapID() & ")")
        Return -1
    EndIf

    ; Lecture de la présence de la quête dans le log
    Local $qid = Quest_GetQuestInfo($questID, "QuestID")

    ; --- CAS A : la quête n'est plus dans le log -> elle a été validée en donjon
    If Not $qid Then
        Out("QuestManager_AfterReload: quête absente du log -> probablement validée en donjon. On prend la nouvelle quête...")
        HandleTekks("take", $questID)
        Sleep(500)

        ; Vérif post-take
        If Quest_GetQuestInfo($questID, "IsIncomplete") Then
            Out("QuestManager_AfterReload: prise de quête confirmée.")
            Return 1
        Else
            Out("QuestManager_AfterReload: échec lors de la tentative de prise de quête (après reward-in-dungeon).")
            Return -2
        EndIf
    EndIf

    ; --- CAS B : la quête est présente dans le log
    If Quest_GetQuestInfo($questID, "IsCompleted") Then
        Out("QuestManager_AfterReload: quête présente et rewardable -> on valide la récompense (reward).")
        HandleTekks("reward", $questID)
        Sleep(500)

        ; Après reward on **ne prend pas** la quête ici (règle: prendre se fait via le flow normal ReloadQuest->TakeQuestNewRun->Re_Enter)
        Return 2
    EndIf

    ; --- Cas improbable : quête présente mais ni rewardable ni incomplete -> log/état inattendu
    If Quest_GetQuestInfo($questID, "IsIncomplete") Then
        Out("QuestManager_AfterReload: la quête est encore marquée INCOMPLETE (cas inattendu). Aucune action effectuée.")
        Return 0
    EndIf

    Out("QuestManager_AfterReload: état non pris en charge. Rien fait.")
    Return 0
EndFunc ;==> QuestManager_AfterReload

#Region Fighting
Global $TimerToKill = 0

Func Fight($x, $s = "enemies")
	If GetPartyDead() Then Return
	Local $target
	Local $distance
	Local $useSkill
	Local $energy
	Local $lastId = 99999, $coordinate[2], $timer
		Do
			If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
			If TimerDiff($TimerToKill) > 180000 then Exitloop
			if GetPartyDead() Then ExitLoop
			$target = GetNearestEnemyToAgent(-2,1500,$GC_I_AGENT_TYPE_LIVING,1,"EnemyFilter")
			If GetPartyDead() Then ExitLoop
			$distance = ComputeDistance(Agent_GetAgentInfo($target, 'X'),Agent_GetAgentInfo($target, 'Y'),Agent_GetAgentInfo(-2, 'X'),Agent_GetAgentInfo(-2, 'Y'))
			If $target <> 0 AND $distance < $x and GetPartyDead() = false Then
				If TimerDiff($TimerToKill) > 180000 then Exitloop
				If Agent_GetAgentInfo($target, 'ID') <> $lastId Then
					if GetPartyDead() Then ExitLoop
					Agent_ChangeTarget($target)
					Other_RndSleep(150)
					Agent_CallTarget($target)
					Other_RndSleep(150)
					If GetPartyDead() Then ExitLoop
					Agent_Attack($target)
					$lastId = Agent_GetAgentInfo($target, 'ID')
					$coordinate[0] = Agent_GetAgentInfo($target, 'X')
					$coordinate[1] = Agent_GetAgentInfo($target, 'Y')
					$timer = TimerInit()
					$distance = ComputeDistance($coordinate[0],$coordinate[1],Agent_GetAgentInfo(-2, 'X'),Agent_GetAgentInfo(-2, 'Y'))
					If GetPartyDead() Then ExitLoop
					If $distance > 1100 Then
						Do
							If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
							If TimerDiff($TimerToKill) > 180000 then Exitloop
							if GetPartyDead() Then ExitLoop
							Map_Move($coordinate[0],$coordinate[1])
							Other_RndSleep(50)
							If GetPartyDead() Then ExitLoop
							$distance = ComputeDistance($coordinate[0],$coordinate[1],Agent_GetAgentInfo(-2, 'X'),Agent_GetAgentInfo(-2, 'Y'))
						Until $distance < 1100 or TimerDiff($timer) > 10000 or GetPartyDead() or TimerDiff($TimerToKill) > 180000
					EndIf
				EndIf
				If TimerDiff($TimerToKill) > 180000 then Exitloop
				Other_RndSleep(150)
				$timer = TimerInit()
				if GetPartyDead() Then ExitLoop
					Do
						If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
						If TimerDiff($TimerToKill) > 180000 then Exitloop
						if GetPartyDead() Then ExitLoop
						$target = GetNearestEnemyToAgent(-2,1500,$GC_I_AGENT_TYPE_LIVING,1,"EnemyFilter")
						If GetPartyDead() Then ExitLoop
						$distance = GetDistance($target, -2)
						If $distance < 1250 and GetPartyDead() = false Then
							If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
							If TimerDiff($TimerToKill) > 180000 then Exitloop
							For $i = 0 To 7
								If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
								If TimerDiff($TimerToKill) > 180000 then Exitloop
								if GetPartyDead() Then ExitLoop
								If Agent_GetAgentInfo($target,'IsDead') then ExitLoop

								$distance = GetDistance($target, -2)
								If $distance > $x then ExitLoop

								$energy = GetEnergy(-2)

								If IsRecharged($i+1) And $energy >= $skillCost[$i] and GetPartyDead() = false Then
									If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
									If TimerDiff($TimerToKill) > 180000 then Exitloop
									$useSkill = $i + 1
									UseSkillEx($useSkill, $target)
									Other_RndSleep(150)
									If GetPartyDead() Then ExitLoop
									Agent_Attack($target)
									Other_RndSleep(150)
								EndIf
								If TimerDiff($TimerToKill) > 180000 then Exitloop
								If $i = 7 then $i = -1 ; change -1
								if GetPartyDead() Then ExitLoop
							Next
						EndIf
						If TimerDiff($TimerToKill) > 180000 then Exitloop
						if GetPartyDead() Then ExitLoop
						Agent_Attack($target)
						$distance = GetDistance($target, -2)
					Until Agent_GetAgentInfo($target, 'HP') < 0.005 Or $distance > $x Or TimerDiff($timer) > 20000 Or GetPartyDead() or TimerDiff($TimerToKill) > 180000
			EndIf
			If GetNumberOfFoesInRangeOfAgent(-2, 1500) = 0 Then Exitloop
			If TimerDiff($TimerToKill) > 180000 then Exitloop
			if GetPartyDead() Then ExitLoop
			$target = GetNearestEnemyToAgent(-2,1500,$GC_I_AGENT_TYPE_LIVING,1,"EnemyFilter")
			If GetPartyDead() Then ExitLoop
			$distance = GetDistance($target, -2)
		Until Agent_GetAgentInfo($target, 'ID') = 0 OR $distance > $x Or GetPartyDead() or TimerDiff($TimerToKill) > 180000

;Uncomment the lines below, if you want to pick up items
		If CountSlots() <> 0 and GetPartyDead() = false then
			If TimerDiff($TimerToKill) > 180000 then Return
			PickupLoot()
		EndIf
EndFunc   ;==>Fight


Func ClearEnemiesInCompass($range = 1700)
	        Local $enemy = GetNearestEnemyToAgent(-2, $range, $GC_I_AGENT_TYPE_LIVING, 1, "EnemyFilter")
    Out("Clearing enemies in compass range: " & $enemy)

    Local $clearCount = 0

    While True
        If Agent_GetAgentInfo(-2, "IsDead") Then
            Out("⚰️ Player is dead → abort clearing (will retry after rez)")
            Return False ; on ne valide pas le clean
        EndIf

        Local $enemy = GetNearestEnemyToAgent(-2, $range, $GC_I_AGENT_TYPE_LIVING, 1, "EnemyFilter")

        If $enemy = 0 Then
            ; Aucun ennemi détecté → on incrémente la validation
            $clearCount += 1
            If $clearCount >= 3 Then
                Out("✅ All Enemy Dead")
                Return True
            EndIf
        Else
            ; On a trouvé un ennemi → reset du compteur
            $clearCount = 0

            ; Si c’est un boss → on l’annonce
            If Agent_GetAgentInfo($enemy, "HasBossGlow") Then
                Out("🎯 Boss detected : Fight !")
            EndIf

            ; On engage le combat
            Fight($range)
        EndIf

        Sleep(500)
    WEnd
EndFunc



; Cherche Tekks dans la map courante
Func GetTekksID()
    Local $aAgents = Agent_GetAgentArray()
    If Not IsArray($aAgents) Or $aAgents[0] = 0 Then Return 0

    For $i = 1 To $aAgents[0]
        Local $modelID = Agent_GetAgentInfo($aAgents[$i], "ModelID")

        ; Vérifie si l'agent a le ModelID 6744 (Tekks)
        If $modelID = 6744 Then
            Return Agent_GetAgentInfo($aAgents[$i], "ID") ; Retourne l'ID de Tekks
        EndIf
    Next

    Return 0 ; Tekks non trouvé
EndFunc




Func DumpAgents()
    Local $aAgents = Agent_GetAgentArray()

    ; Vérification
    If Not IsArray($aAgents) Then
        Out("DumpAgents: Agent_GetAgentArray() n'a pas renvoyé de tableau.")
        Return
    EndIf

    If $aAgents[0] = 0 Then
        Out("DumpAgents: aucun agent trouvé.")
        Return
    EndIf

    ; Boucle sur tous les agents
    For $i = 1 To $aAgents[0]
        Local $id = Agent_GetAgentInfo($aAgents[$i], "ID")
        Local $name = Agent_GetAgentInfo($aAgents[$i], "Name")
        Local $type = Agent_GetAgentInfo($aAgents[$i], "Type")
        Out("Agent[" & $i & "] ID=" & $id & " | Name=" & $name & " | Type=" & $type)
    Next
EndFunc



Func ChestFilter($aAgentPtr)
	If Agent_GetAgentInfo($aAgentPtr, 'Type') <> 512 Then Return False
	Local $lgadgetID = Agent_GetAgentInfo($aAgentPtr, 'GadgetID')
		If $lgadgetID = 8141 Then Return True
	Return False
EndFunc	;==>ChestFilter

Func OpenNearbyChestsFiltered($range = 1000)
	If GetIsDead(-2) Then Return
	Local $chest
	Local $xchest
	Local $ychest
	Local $aItemPtr
	Local $canpickup
	Local $chestdistance
	Local $minchestdistance = 10000000
	Local $IsThereAChest

	$IsThereAChest = GetNumberOfChestsInRangeOfAgent(-2, $RANGE_COMPASS, $GC_I_AGENT_TYPE_GADGET, 0, "ChestFilter")
	Out("How many Chests are nearby?: " & $IsThereAChest)
	Sleep(16)
    If $IsThereAChest <> 0 Then
		If GetIsDead(-2) Then Return
		$chest = GetNearestChestToAgent(-2, $RANGE_COMPASS, $GC_I_AGENT_TYPE_GADGET, 1, "ChestFilter")
		$xchest = Agent_GetAgentInfo($chest, "X")
		$ychest = Agent_GetAgentInfo($chest, "Y")
		; Don't open chests that are already opened - otherwise statistics are wrong
		For $i = 0 To UBound($xChestOldAr)-1
			If GetIsDead(-2) Then ExitLoop
			$chestdistance = ComputeDistance($xchest, $ychest, $xChestOldAr[$i], $yChestOldAr[$i])
			If $chestdistance < $minchestdistance Then
				If GetIsDead(-2) Then ExitLoop
				$minchestdistance = $chestdistance				
			EndIf
		Next
		If GetIsDead(-2) Then Return
If $minchestdistance < 100 Then
    If GetIsDead(-2) Then Return
    Out("You already had that chest ... , skip it!!!")
    Return True ; on sort proprement sans bloquer le reste
EndIf

; if it is a new chest, we need those coordinates added to the arrays
ReDim $xChestOldAr[UBound($xChestOldAr)+1]
ReDim $yChestOldAr[UBound($yChestOldAr)+1]
$xChestOldAr[UBound($xChestOldAr)-1] = $xchest
$yChestOldAr[UBound($yChestOldAr)-1] = $ychest


		If GetIsDead(-2) Then Return
		; Go open the chest
		Agent_GoSignpost($chest)
		Sleep(250)
		If GetIsDead(-2) Then Return
		Item_OpenChest()
		Sleep(250)
		; Now what Items was dropped? -> If an item was dropped and is not allowed to pick up, it should still show up in statistics
		$aItemPtr = GetNearestItemToAgent(-2, $range)
		Sleep(16)
		; Pick up the item, if it is allowed
		$canpickup = CanPickUp($aItemPtr)
		Sleep(100)
		If GetIsDead(-2) Then Return
		If $canpickup Then
			If GetIsDead(-2) Then Return
			MoveTo($xchest, $ychest, 20)
			If GetIsDead(-2) Then Return
			PickUpLoot()
			Sleep(250)
			If GetIsDead(-2) Then Return
		EndIf
		; Get the updated Statistics on the GUI
		UpdateStatistics()
		If GetIsDead(-2) Then Return
	EndIf
	return True
EndFunc


Func ToggleChestFarm()
    If BitAND(GUICtrlRead($chkChestFarm), $GUI_CHECKED) = $GUI_CHECKED Then
        $EnableChestFarm = True
        Out("Use Lockpicks")
    Else
        $EnableChestFarm = False
        Out("Don't Use Lockpicks")
    EndIf
EndFunc

Func ToggleSalvageArmor()
    If BitAND(GUICtrlRead($chkSalvageArmor), $GUI_CHECKED) = $GUI_CHECKED Then
        $g_bPickupSalvageArmor = True
        Out("Pickup Salvage Armors enabled")
    Else
        $g_bPickupSalvageArmor = False
        Out("Pickup Salvage Armors disabled")
    EndIf
EndFunc

Func ToggleTrophies()
    If BitAND(GUICtrlRead($chkTrophies), $GUI_CHECKED) = $GUI_CHECKED Then
        $g_bPickupTrophies = True
        Out("Pickup Trophies enabled")
    Else
        $g_bPickupTrophies = False
        Out("Pickup Trophies disabled")
    EndIf
EndFunc


Func GetPartyDead()
	; Party is dead, if player is dead and no more heroes have a rez skill or all heroes with rez skills are also dead
	Local $heroID

	; Check, if all of those heroes are dead - if at least 1 is still alive not, return false
	for $ii = 1 To UBound($heroNumberWithRez)
		$heroID = Party_GetMyPartyHeroInfo($heroNumberWithRez[$ii-1], "AgentID")
		If Not Agent_GetAgentInfo($heroID, "IsDead") Then Return False
	Next

	; If those heroes are all dead, check if you as player are also dead
	If Not GetisDead(-2) then Return False

	; If all area dead, return True
	Return True
EndFunc ;==> GetPartyDead


Func GetEffectTimeRemainingEx($aAgent = -2, $aSkillID = 0, $aInfo = "TimeRemaining")
    Return Agent_GetAgentEffectInfo($aAgent, $aSkillID, $aInfo)
EndFunc   ;==>GetEffectTimeRemainingEx

; Safe wrapper for Agent_GetAgentInfo to prevent crashes
Func SafeGetAgentInfo($agentID, $property)
    If $agentID <= 0 Then Return 0
    
    Local $result = Agent_GetAgentInfo($agentID, $property)
    If @error Then
        Out("Warning: Agent_GetAgentInfo failed for agent " & $agentID & " property " & $property)
        Return 0
    EndIf
    Return $result
EndFunc

; Safe wrapper for UseSkillEx to prevent crashes
Func SafeUseSkillEx($skillSlot, $target = -1, $agentID = -2)
    If $skillSlot < 1 Or $skillSlot > 8 Then
        Out("Warning: Invalid skill slot " & $skillSlot)
        Return False
    EndIf
    
    If $target > 0 And SafeGetAgentInfo($target, "IsDead") Then
        Out("Warning: Target is dead, skipping skill use")
        Return False
    EndIf
    
    UseSkillEx($skillSlot, $target, $agentID)
    If @error Then
        Out("Warning: UseSkillEx failed for slot " & $skillSlot)
        Return False
    EndIf
    Return True
EndFunc



#EndRegion

#Region AgentFilters
Func EnemyFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 3 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False

    Return True
EndFunc	;==>EnemyFilter

Func MinionFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 3 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False
	Local $agentID = Agent_GetAgentInfo($aAgentPtr, 'PlayerNumber')
		Switch $agentID
			Case $BoneFiendID, $BoneHorrorID, $BoneMinionID, $ShamblingHorrorID, $JaggedHorrorID, $VampiricHorrorID, $FleshGolemID
				Return True
			Case Else
				Return False
		EndSwitch

    Return True
EndFunc	;==>MinionFilter

Func HexreaperFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 3 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'PlayerNumber') <> $Hexreaper Then Return False

    Return True
EndFunc	;==>HexreaperFilter

Func FlameshielderFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 3 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'PlayerNumber') <> $Flameshielder Then Return False

    Return True
EndFunc	;==>FlameshielderFilter

Func ClericFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 3 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'PlayerNumber') <> $MinistryClericID Then Return False

    Return True
EndFunc	;==>ClericFilter

Func FazeMageKillerFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 3 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'PlayerNumber') <> $FazeMagekiller Then Return False

    Return True
EndFunc	;==>FazeMageKillerFilter

Func NPCFilter($aAgentPtr)

	If Agent_GetAgentInfo($aAgentPtr, 'Allegiance') <> 6 Then Return False
    If Agent_GetAgentInfo($aAgentPtr, 'HP') <= 0 Then Return False
	If Agent_GetAgentInfo($aAgentPtr, 'IsDead') > 0 Then Return False

    Return True
EndFunc	;==>NPCFilter
#EndRegion

#Region Agents
Func GetNearestEnemyToAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 1, $aCustomFilter = "EnemyFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNearestEnemyToAgent

Func GetNearestHexreaperToAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 1, $aCustomFilter = "HexreaperFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNearestHexreaperToAgent

Func GetNearestFlameshielderToAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 1, $aCustomFilter = "FlameshielderFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNearestFlameshielderToAgent

Func GetNearestClericToAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 1, $aCustomFilter = "ClericFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNearestClericToAgent

Func GetNumberOfMinionsInRangeOfAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 0, $aCustomFilter = "MinionFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNumberOfMinionsInRangeOfAgent

Func GetNumberOfHexreapersInRangeOfAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 0, $aCustomFilter = "HexreaperFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNumberOfHexreapersInRangeOfAgent

Func GetNumberOfFlameshieldersInRangeOfAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 0, $aCustomFilter = "FlameshielderFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNumberOfFlameshieldersInRangeOfAgent

Func GetNumberOfClericsInRangeOfAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 0, $aCustomFilter = "ClericFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNumberOfClericsInRangeOfAgent

Func GetNearestNPCToAgent($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 1, $aCustomFilter = "NPCFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>GetNearestNPCToAgent

Func IsFazeAlive($aAgentID = -2, $aRange = 1320, $aType = $GC_I_AGENT_TYPE_LIVING, $aReturnMode = 0, $aCustomFilter = "FazeMageKillerFilter")
	Return GetAgents($aAgentID, $aRange, $aType, $aReturnMode, $aCustomFilter)
EndFunc	;==>IsFazeAlive

; Priority targeting function with target persistence
Func GetPriorityTarget($aAgent = -2, $aRange = 1250)
    Local $lAgent, $lDistance, $lModelID
    Local $lHighestPriority = 0
    Local $lBestTarget = 0
    Local $lCurrentPriority
    Local $lCurrentTargetPriority = 0
    Local $lKeepCurrentTarget = False

    If Not IsDllStruct($aAgent) Then $aAgent = Agent_GetAgentPtr($aAgent)

    ; Check if current target is still valid and alive
    If $g_CurrentTarget <> 0 Then
        If Agent_GetAgentInfo($g_CurrentTarget, "HP") > 0 And GetDistance($g_CurrentTarget, $aAgent) <= $aRange Then
            ; Get current target's priority
            $lModelID = Agent_GetAgentInfo($g_CurrentTarget, "PlayerNumber")
            Switch $lModelID
                Case $ClericID
                    $lCurrentTargetPriority = 10
                Case $CaptainID
                    $lCurrentTargetPriority = 9
                Case $EnforcerID
                    $lCurrentTargetPriority = 8
                Case $MageRitID, $MageGlowstoneID
                    $lCurrentTargetPriority = 7
                Case $RangerBarrageID, $IlluInvokeID
                    $lCurrentTargetPriority = 6
                Case $BladesmanDaggerID, $PurityID
                    $lCurrentTargetPriority = 5
                Case $PurgerID
                    $lCurrentTargetPriority = 4
                Case $BladesmanLyssaID, $RangerTrapperID
                    $lCurrentTargetPriority = 3
                Case $IlluID
                    $lCurrentTargetPriority = 2
                Case Else
                    $lCurrentTargetPriority = 1
            EndSwitch
            $lKeepCurrentTarget = True
        Else
            ; Current target is dead or out of range, reset
            $g_CurrentTarget = 0
        EndIf
    EndIf

    For $i = 1 To Agent_GetMaxAgents()
        $lAgent = Agent_GetAgentPtr($i)
        If Not IsDllStruct($lAgent) Then ContinueLoop
        If Agent_GetAgentInfo($lAgent, "Type") <> $GC_I_AGENT_TYPE_LIVING Then ContinueLoop
        If Agent_GetAgentInfo($lAgent, "Allegiance") <> $GC_I_ALLEGIANCE_ENEMY Then ContinueLoop
        If Agent_GetAgentInfo($lAgent, "HP") <= 0 Then ContinueLoop
        If BitAND(Agent_GetAgentInfo($lAgent, "Effects"), 0x0010) > 0 Then ContinueLoop ; Skip hexed enemies

        $lDistance = GetDistance($lAgent, $aAgent)
        If $lDistance > $aRange Then ContinueLoop

        $lModelID = Agent_GetAgentInfo($lAgent, "PlayerNumber")
        $lCurrentPriority = 0

        ; Priority based on death log frequency (highest threat enemies first)
        Switch $lModelID
            Case $ClericID
                $lCurrentPriority = 10 ; Highest priority - healing enemies
            Case $CaptainID
                $lCurrentPriority = 9  ; Very high priority - leadership
            Case $EnforcerID
                $lCurrentPriority = 8  ; High priority - damage dealers
            Case $MageRitID
                $lCurrentPriority = 7  ; High priority - Mage Invoke
            Case $MageGlowstoneID
                $lCurrentPriority = 7  ; High priority - Mage Sandstorm
            Case $RangerBarrageID
                $lCurrentPriority = 6  ; Medium-high priority - Ranger Barrage
            Case $IlluInvokeID
                $lCurrentPriority = 6  ; Medium-high priority - Illu Extend Conditions
            Case $BladesmanDaggerID
                $lCurrentPriority = 5  ; Medium priority - Bladesman Palm
            Case $PurityID
                $lCurrentPriority = 5  ; Medium priority - Purger Soul Bind
            Case $PurgerID
                $lCurrentPriority = 4  ; Lower priority - Purger Icy Veins
            Case $BladesmanLyssaID
                $lCurrentPriority = 3  ; Lower priority - Bladesman Lyssa
            Case $RangerTrapperID
                $lCurrentPriority = 3  ; Lower priority - Ranger Trapper
            Case $IlluID
                $lCurrentPriority = 2  ; Lowest priority - Illu Keystone Signet
            Case Else
                $lCurrentPriority = 1  ; Default priority for unknown enemies
        EndSwitch

        ; Adjust priority based on distance (closer enemies get slight priority boost)
        $lCurrentPriority += (1000 - $lDistance) / 1000

        If $lCurrentPriority > $lHighestPriority Then
            $lHighestPriority = $lCurrentPriority
            $lBestTarget = $lAgent
        EndIf
    Next

    ; Target persistence logic: only switch if new target has significantly higher priority
    If $lKeepCurrentTarget Then
        ; Add minimum time before allowing target switch (reduces CPU churn)
        If TimerDiff($g_CurrentTargetTimer) < 1000 Then
            Return $g_CurrentTarget  ; Keep current target for at least 1 second
        EndIf

        ; Only switch if new target has at least 2 priority levels higher (prevents constant switching)
        If $lHighestPriority > ($lCurrentTargetPriority + 2) Then
            $g_CurrentTarget = $lBestTarget
            $g_CurrentTargetTimer = TimerInit()
            Return $lBestTarget
        Else
            ; Keep current target to avoid frequent switching
            Return $g_CurrentTarget
        EndIf
    Else
        ; No current target, select the best available
        $g_CurrentTarget = $lBestTarget
        $g_CurrentTargetTimer = TimerInit()
        Return $lBestTarget
    EndIf
EndFunc
#EndRegion

#Region Skills
Func IsRecharged($aSkill)
	Return Skill_GetSkillbarInfo($aSkill, "IsRecharged")
EndFunc   ;==>IsRecharged

Func GetSkillbarSkillAdrenaline($aSkillSlot = 0, $aInfo = "Adrenaline", $aHeroNumber = 0)
    Return Skill_GetSkillbarInfo($aSkillSlot, $aInfo, $aHeroNumber)
EndFunc   ;==>GetSkillbarSkillAdrenaline

Func UseSkillEx($aSkill, $aTgt = -2, $aTimeout = 3000)
	If GetIsDead(-2) Then Return
	If Not IsRecharged($aSkill) Then Return
	Local $aSkillID = Skill_GetSkillbarInfo($aSkill, "SkillID")
	Local $aEnergyCost = Skill_GetSkillInfo($aSkillID, "EnergyCost")
	If GetEnergy(-2) < $aEnergyCost Then Return
	Local $aAftercast = Skill_GetSkillInfo($aSkillID, "Aftercast")
	Local $lDeadlock = TimerInit()
	Skill_UseSkill($aSkill, $aTgt)
	Do
		Sleep(50)
		If GetIsDead(-2) = 1 Then Return
	Until (Not IsRecharged($aSkill)) Or (TimerDiff($lDeadlock) > $aTimeout)
	Sleep($aAftercast * 1000)
EndFunc   ;==>UseSkillEx
#EndRegion

#Region Inventory
Func GetNicholasItemCount()
    Local $AAMOUNTNicholasItem = 0
    Local $lItemArray = Item_GetItemArray()

    For $i = 1 To $lItemArray[0]
        Local $lItemPtr = $lItemArray[$i]
        If Item_GetItemInfoByPtr($lItemPtr, "ModelID") = $NicholasItemID Then
            $AAMOUNTNicholasItem += Item_GetItemInfoByPtr($lItemPtr, "Quantity")
        EndIf
    Next

    Return $AAMOUNTNicholasItem
EndFunc	;==>GetNicholasItemCount

Func GetNicholasCollectorItemCount()
	Local $AAMOUNTNicholasItem = 0
    Local $lItemArray = Item_GetItemArray()

    For $i = 1 To $lItemArray[0]
        Local $lItemPtr = $lItemArray[$i]
        If Item_GetItemInfoByPtr($lItemPtr, "ModelID") = $CollectorItemID Then
            $AAMOUNTNicholasItem += Item_GetItemInfoByPtr($lItemPtr, "Quantity")
        EndIf
    Next

    Return $AAMOUNTNicholasItem
EndFunc   ; Counts Nicholas Items in your Inventory

Func CountSlots()
	Local $bag
	Local $temp = 0
	For $i = 1 To 4
		$bag = Item_GetBagPtr($i)
		$temp += Item_GetBagInfo($bag,"EmptySlots")
	Next
	Return $temp
EndFunc ; Counts open slots in your Inventory

Func PickUpLoot()
    Local $lAgentArray = Item_GetItemArray()
    Local $maxitems = $lAgentArray[0]

    For $i = 1 To $maxitems
        Local $aItemPtr = $lAgentArray[$i]
        Local $aItemAgentID = Item_GetItemInfoByPtr($aItemPtr, "AgentID")

        If GetIsDead(-2) Then Return
        If $aItemAgentID = 0 Then ContinueLoop ; If Item is not on the ground

        If CanPickUp($aItemPtr) Then
            Item_PickUpItem($aItemAgentID)
            Local $lDeadlock = TimerInit()
            While GetItemAgentExists($aItemAgentID)
                Sleep(100)
                If GetIsDead(-2) Then Return
                If TimerDiff($lDeadlock) > 10000 Then ExitLoop
            WEnd
        EndIf
    Next
EndFunc   ;==>PickUpLoot


;~ Description: Test if an Item agent exists.
Func GetItemAgentExists($aItemAgentID)
	Return (Agent_GetAgentPtr($aItemAgentID) > 0 And $aItemAgentID < Item_GetMaxItems())
EndFunc   ;==>GetItemAgentExists

Func CanPickUp($aItemPtr)
	Local $lModelID = Item_GetItemInfoByPtr($aItemPtr, "ModelID")
	Local $aExtraID = Item_GetItemInfoByPtr($aItemPtr, "ExtraID")
	Local $lRarity  = Item_GetItemInfoByPtr($aItemPtr, "Rarity")

	; Pièces d'or
	If (($lModelID == 2511) And (GetGoldCharacter() < 99000)) Then
		Return True

	; Teintures : uniquement Noir & Blanc
	ElseIf ($lModelID == $ITEM_ID_Dyes) Then
		If (($aExtraID == $ITEM_ExtraID_BlackDye) Or ($aExtraID == $ITEM_ExtraID_WhiteDye)) Then
			Return True
		EndIf

	; Objets or
ElseIf $lRarity == $RARITY_Gold Then
    $GoldItemsGained += 1
    GUICtrlSetData($GoldItemsLabel, "Gold Items: " & $GoldItemsGained)
Return True
		

; Froggies (1953 → 1975)
ElseIf $lModelID >= 1953 And $lModelID <= 1975 Then
    $FroggyGained += 1
    Out("Un Froggy !! GG")
GUICtrlSetData($FroggyLabel, "Gold Items: " & $FroggyGained)	
Return True

; Purple items -> ignored
ElseIf $lRarity == $RARITY_Purple Then
    Return False

; Lockpicks
ElseIf $lModelID == $ITEM_ID_Lockpicks Then
    $LockpicksGained += 1
    Return True

; Boss key
ElseIf $lModelID == 25416 Then
    Out("Boss key picked up!")
    Return True


	; Cupcakes
	ElseIf $lModelID == 22269 Then
		Return True

	; Candy Cane Shard
	ElseIf $lModelID == $GC_I_MODELID_CC_SHARDS Then
		Return True

	; Trophies (when checkbox enabled) - Sentient Vine, Amphibian Tongue, Beetle Egg
	ElseIf $g_bPickupTrophies And ($lModelID == $GC_I_MODELID_SENTIENT_VINE Or $lModelID == $GC_I_MODELID_AMPHIBIAN_TONGUE Or $lModelID == 27066) Then
		$TrophiesGained += 1
		GUICtrlSetData($TrophiesLabel, "Trophies: " & $TrophiesGained)
		Return True

	; Pcons (event items, misc consumables)
	ElseIf IsPcon($aItemPtr) Then
		Return False

	; Rare materials
	ElseIf IsRareMaterial($aItemPtr) Then
		Return True

	; Blue/Purple Salvage Armors (when checkbox enabled)
	ElseIf $g_bPickupSalvageArmor And ($lRarity == $RARITY_Blue Or $lRarity == $RARITY_Purple) Then
		Local $lItemType = Item_GetItemInfoByPtr($aItemPtr, "ItemType")
		If $lItemType == $GC_I_TYPE_SALVAGE Then
			$SalvageArmorGained += 1
			GUICtrlSetData($SalvageLabel, "Salvage: " & $SalvageArmorGained)
			Return True
		EndIf

	EndIf

	; Everything else -> ignored
	Return False
EndFunc   ;==> CanPickUp


;~ Description: Returns a weapon or shield's minimum required attribute.
Func GetItemReq($aItemPtr)
	Local $lMod = GetModByIdentifier($aItemPtr, "9827")
	Return $lMod[0]
EndFunc   ;==>GetItemReq

;~ Description: Returns a weapon or shield's required attribute.
Func GetItemAttribute($aItem)
	Local $lMod = GetModByIdentifier($aItem, "9827")
	Return $lMod[1]
EndFunc   ;==>GetItemAttribute

;~ Description: Returns an array of a the requested mod.
Func GetModByIdentifier($aItemPtr, $aIdentifier)
	If Not IsPtr($aItemPtr) Then $aItemPtr = Item_GetItemPtr($aItemPtr)
	Local $lReturn[2]
	Local $lString = StringTrimLeft(Item_GetModStruct($aItemPtr), 2)
	For $i = 0 To StringLen($lString) / 8 - 2
		If StringMid($lString, 8 * $i + 5, 4) == $aIdentifier Then
			$lReturn[0] = Int("0x" & StringMid($lString, 8 * $i + 1, 2))
			$lReturn[1] = Int("0x" & StringMid($lString, 8 * $i + 3, 2))
			ExitLoop
		EndIf
	Next
	Return $lReturn
EndFunc   ;==>GetModByIdentifier


Func GetItemMaxDmg($aItem)
	If Not IsPtr($aItem) Then $aItem = Item_GetItemPtr($aItem)
	Local $lModString = Item_GetModStruct($aItem)
	Local $lPos = StringInStr($lModString, "A8A7") ; Weapon Damage
	If $lPos = 0 Then $lPos = StringInStr($lModString, "C867") ; Energy (focus)
	If $lPos = 0 Then $lPos = StringInStr($lModString, "B8A7") ; Armor (shield)
	If $lPos = 0 Then Return 0
	Return Int("0x" & StringMid($lModString, $lPos - 2, 2))
 EndFunc	;==> GetItemMaxDmg

Func GetGoldCharacter()
	Return Item_GetInventoryInfo("GoldCharacter")
EndFunc   ;==>GetGoldCharacter

Func GetGoldStorage()
	Return Item_GetInventoryInfo("GoldStorage")
EndFunc   ;==>GetGoldStorage

Func CheckArrayPscon($lModelID)
	For $p = 0 To (UBound($Array_pscon) -1)
		If ($lModelID == $Array_pscon[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayPscon

Func Inventory()
	
	Out("Travelling to Eye of the North")
	RndTravel($Town_ID_EyeOfTheNorth)

	$inventorytrigger = 1

	sleep(1000)

	Out("Move to Merchant")
	MerchantEotN()
	sleep(2000)

	Out("Identifying")
	For $i = 1 To 4
		Ident($i)
	Next

	Out("Selling")
	For $i = 1 To 4
		Sell($i)
	Next

	If GetGoldCharacter() > 90000 Then
		Out("Depositing Gold")
		Item_DepositGold()
	EndIf

	If FindRareRuneOrInsignia() <> 0 Then
		Out("Salvage all Runes")
		For $i = 1 To 4
			Salvage($i)
		Next
		Out("Second Round of Salvage")
		For $i = 1 To 4
			Salvage($i)
		Next

		Out("Sell leftover items")
		For $i = 1 To 4
			Sell($i)
		Next
	EndIf

	; Add safety counter to prevent infinite loops
	Local $loopCounter = 0
	Local $maxLoops = 10
	
	While FindRareRuneOrInsignia() <> 0 And $loopCounter < $maxLoops
		$loopCounter += 1
		Out("Move to Rune Trader (Attempt " & $loopCounter & "/" & $maxLoops & ")")
		RuneTraderEotN()
		Sleep(2000)

		Out("Sell Runes")
		For $i = 1 To 4
			SellRunes($i)
		Next
		Sleep(2000)

		If GetGoldCharacter() > 20000 Then
			Out("Buying Rare Materials")
			RareMaterialTraderEotN()
		EndIf
		
		; Additional safety check - if we've tried multiple times, force exit
		If $loopCounter >= $maxLoops Then
			Out("WARNING: Maximum rune selling attempts reached. Exiting loop to prevent infinite loop.")
			ExitLoop
		EndIf
	WEnd

	If GetGoldCharacter() > 20000 and GetGoldStorage() > 900000 Then
		Out("Buying Rare Materials")
		RareMaterialTraderEotN()
	EndIf

	sleep(3000)
	RndTravel($Town_ID_Farm)
EndFunc ;==> Inventory

Func Merchant()
	;~ Array with Coordinates for Merchants (you better check those for your own Guildhall)
	Dim $Waypoints_by_Merchant[29][3] = [ _
			[$BurningIsle, -4439, -2088], _
			[$BurningIsle, -4772, -362], _
			[$BurningIsle, -3637, 1088], _
			[$BurningIsle, -2506, 988], _
			[$DruidsIsle, -2037, 2964], _
			[$FrozenIsle, 99, 2660], _
			[$FrozenIsle, 71, 834], _
			[$FrozenIsle, -299, 79], _
			[$HuntersIsle, 5156, 7789], _
			[$HuntersIsle, 4416, 5656], _
			[$IsleOfTheDead, -4066, -1203], _
			[$NomadsIsle, 5129, 4748], _
			[$WarriorsIsle, 4159, 8540], _
			[$WarriorsIsle, 5575, 9054], _
			[$WizardsIsle, 4288, 8263], _
			[$WizardsIsle, 3583, 9040], _
			[$ImperialIsle, 1415, 12448], _
			[$ImperialIsle, 1746, 11516], _
			[$IsleOfJade, 8825, 3384], _
			[$IsleOfJade, 10142, 3116], _
			[$IsleOfMeditation, -331, 8084], _
			[$IsleOfMeditation, -1745, 8681], _
			[$IsleOfMeditation, -2197, 8076], _
			[$IsleOfWeepingStone, -3095, 8535], _
			[$IsleOfWeepingStone, -3988, 7588], _
			[$CorruptedIsle, -4670, 5630], _
			[$IsleOfSolitude, 2970, 1532], _
			[$IsleOfWurms, 8284, 3578], _
			[$UnchartedIsle, 1503, -2830]]
	For $i = 0 To (UBound($Waypoints_by_Merchant) - 1)
		If ($Waypoints_by_Merchant[$i][0] == True) Then
			MoveTo($Waypoints_by_Merchant[$i][1], $Waypoints_by_Merchant[$i][2])
		EndIf
	Next

	Out("Talk to Merchant")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)
EndFunc ;==> Merchant

Func MerchantEotN()
	; Run to Merchant in EotN
	Out("Run to Merchant in EotN")
	MoveTo(-2713.30, 1084)

	Out("Talk to Merchant")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)
EndFunc ;==> MerchantEotN

Func MerchantGadd()
	; Run to Merchant in Gadd's Camp
	Out("Run to Merchant in Gadd's Camp")
	MoveTo(-8339.00, -22433)

	Out("Talk to Merchant")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)
EndFunc ;==> MerchantEotN

Func RareMaterialTrader()
	;~ Array with Coordinates for Merchants (you better check those for your own Guildhall)
	Dim $Waypoints_by_RareMatTrader[36][3] = [ _
			[$BurningIsle, -3793, 1069], _
			[$BurningIsle, -2798, -74], _
			[$DruidsIsle, -989, 4493], _
			[$FrozenIsle, 71, 834], _
			[$FrozenIsle, 99, 2660], _
			[$FrozenIsle, -385, 3254], _
			[$FrozenIsle, -983, 3195], _
			[$HuntersIsle, 3267, 6557], _
			[$IsleOfTheDead, -3415, -1658], _
			[$NomadsIsle, 1930, 4129], _
			[$NomadsIsle, 462, 4094], _
			[$WarriorsIsle, 4108, 8404], _
			[$WarriorsIsle, 3403, 6583], _
			[$WarriorsIsle, 3415, 5617], _
			[$WizardsIsle, 3610, 9619], _
			[$ImperialIsle, 244, 11719], _
			[$IsleOfJade, 8919, 3459], _
			[$IsleOfJade, 6789, 2781], _
			[$IsleOfJade, 6566, 2248], _
			[$IsleOfMeditation, -2197, 8076], _
			[$IsleOfMeditation, -1745, 8681], _
			[$IsleOfMeditation, -331, 8084], _
			[$IsleOfMeditation, 422, 8769], _
			[$IsleOfMeditation, 549, 9531], _
			[$IsleOfWeepingStone, -3988, 7588], _
			[$IsleOfWeepingStone, -3095, 8535], _
			[$IsleOfWeepingStone, -2431, 7946], _
			[$IsleOfWeepingStone, -1618, 8797], _
			[$CorruptedIsle, -4424, 5645], _
			[$CorruptedIsle, -4443, 4679], _
			[$IsleOfSolitude, 3172, 3728], _
			[$IsleOfSolitude, 3221, 4789], _
			[$IsleOfSolitude, 3745, 4542], _
			[$IsleOfWurms, 8353, 2995], _
			[$IsleOfWurms, 6708, 3093], _
			[$UnchartedIsle, 2530, -2403]]
	For $i = 0 To (UBound($Waypoints_by_RareMatTrader) - 1)
		If ($Waypoints_by_RareMatTrader[$i][0] == True) Then
			MoveTo($Waypoints_by_RareMatTrader[$i][1], $Waypoints_by_RareMatTrader[$i][2])
		EndIf
	Next
	Out("Talk to Rare Material Trader")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)
	;~This section does the buying
	While GetGoldStorage() > 900*1000 Or GetGoldCharacter() > 10*1000
		If GetGoldCharacter() > 10*1000 Then
			Merchant_RequestQuote(930)
			Sleep(500)
			Merchant_TraderBuy()
			Sleep(500)
		Elseif GetGoldStorage() > 900*1000 Then
			Item_WithdrawGold()
			Sleep(1000)
		EndIf
	WEnd
EndFunc	;==>Rare Material trader

Func RareMaterialTraderEotN()
	Out("Run to Rare Material Trader in EotN")
	MoveTo(-2216.90, 1083.70)

	Out("Talk to Rare Material Trader")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)

	;~This section does the buying
	While GetGoldStorage() > 900*1000 Or GetGoldCharacter() > 10*1000
		If GetGoldCharacter() > 10*1000 Then
			Merchant_BuyItem($Ectoplasm_ID, 1, True)
			;Merchant_RequestQuote(930)
			;Sleep(500)
			;Merchant_TraderBuy()
			;Sleep(500)
		Elseif GetGoldStorage() > 900*1000 Then
			Item_WithdrawGold()
			Sleep(1000)
		EndIf
	WEnd
EndFunc	;==> RareMaterialTraderEotN

Func RuneTrader()
	MoveTo(1297.07,11389.97)
	MoveTo(905.74,11655.34)
	Out("Talk to Rune Trader")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)
EndFunc	;==> Rune Trader

Func RuneTraderEotN()
	Out("Run to Rune Trader in EotN")
	MoveTo(-3250.18, 2011.88)

	Out("Talk to Rune Trader")
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	MoveTo(Agent_GetAgentInfo($guy, "X")-20,Agent_GetAgentInfo($guy, "Y")-20)
    Agent_GoNPC($guy)
    Sleep(1000)
EndFunc	;==> RuneTraderEotN

Func Ident($BagIndex)
	Local $BagPtr
	Local $aItemPtr
	Local $guy = GetNearestNPCToAgent(-2, 1320, $GC_I_AGENT_TYPE_LIVING, 1, "NPCFilter")
	Local $merchantID = Agent_GetAgentInfo($guy, "ID")
	$BagPtr = Item_GetBagPtr($BagIndex)
	For $ii = 1 To Item_GetBagInfo($BagPtr, "Slots")
		If FindIdentificationKit() = 0 Then
			If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
				Item_WithdrawGold(500)
				Sleep(1000)
			EndIf
			Local $j = 0
			Do
				Merchant_BuyItem($SupIDKit, 1)
				Sleep(1000)
				$j = $j + 1
			Until FindIdentificationKit() <> 0 Or $j = 3
			If $j = 3 Then ExitLoop
			Sleep(1000)
		EndIf
		$aItemPtr = Item_GetItemBySlot($BagIndex, $ii)
		If Item_GetItemInfoByPtr($aItemPtr, "ItemID") = 0 Then ContinueLoop
		If Item_GetItemInfoByPtr($aItemPtr, "IsIdentified") Then ContinueLoop
		Item_IdentifyItem($aItemPtr, "Superior")
		;IdentifyItem2($aItemPtr, FindIdentificationKit())
		Sleep(250)
	Next
EndFunc ;==>Ident

Func Salvage($BagIndex)
	Local $BagPtr
	Local $aItemPtr
	Local $aItemID
	Local $aSalvageKitID
	$BagPtr = Item_GetBagPtr($BagIndex)
	For $ii = 1 To Item_GetBagInfo($BagPtr, "Slots")
		If FindExpertSalvageKit() = 0 Then
			If GetGoldCharacter() < 400 And GetGoldStorage() > 399 Then
				Item_WithdrawGold(400)
				Sleep(1000)
			EndIf
			Local $j = 0
			Do
				Merchant_BuyItem($ExpertSalvKit, 1)
				Sleep(1000)
				$j = $j + 1
			Until FindExpertSalvageKit() <> 0 Or $j = 3
			If $j = 3 Then ExitLoop
			Sleep(1000)
		EndIf
		$aItemPtr = Item_GetItemBySlot($BagIndex, $ii)
		If Item_GetItemInfoByPtr($aItemPtr, "ItemID") = 0 Then ContinueLoop
		If IsRareRune($aItemPtr) = 0 and IsRareInsignia($aItemPtr) = 0 then
			Continueloop
		Else
			If IsAlreadySalvaged($aItemPtr) Then ContinueLoop
			If IsRareRune($aItemPtr) Then
				;StartSalvage2($aItemPtr, FindExpertSalvageKit())
				;Sleep(500)
				;Item_SalvageMod(1)
				;Sleep(500)
				Item_SalvageItem($aItemPtr, "Expert", "Suffix")
			ElseIf IsRareInsignia($aItemPtr) Then
				;StartSalvage2($aItemPtr, FindExpertSalvageKit())
				;Sleep(500)
				;Item_SalvageMod(0)
				;Sleep(500)
				Item_SalvageItem($aItemPtr, "Expert", "Prefix")
			Else
				Continueloop
			EndIf
		EndIf
	Next
EndFunc ;==>Salvage

Func IsAlreadySalvaged($aItemPtr)
	Local $modelID
	If Not IsPtr($aItemPtr) Then $aItemPtr = Item_GetItemPtr($aItemPtr)

	$modelID = Item_GetItemInfoByPtr($aItemPtr, "ModelID")
	Switch $modelID
		Case 5551	;~ Sup Vigor
			Return True
		Case 903	;~ minor Strength, minor Tactics
			Return True
		Case 904	;~ minor Expertise, minor Marksman
			Return True
		Case 902	;~ minor Healing, minor Prot, minor Divine
			Return True
		Case 900	;~ minor Soul
			Return True
		Case 899	;~ minor Fastcast, minor Insp
			Return True
		Case 901	;~ minor Energy
			Return True
		Case 6327	;~ minor Spawn
			Return True
		Case 15545	;~ minor Scythe, minor Mystic
			Return True
		Case 898	;~ minor Vigor, minor Vitae
			Return True
		Case 3612	;~ major Fastcast
			Return True
		Case 5550	;~ major Vigor
			Return True
		Case 5557	;~ superior Smite
			Return True
		Case 5553	;~ superior Death
			Return True
		Case 5549	;~ superior Dom
			Return True
		Case 5555	;~ superior Air
			Return True
		Case 6329	;~ superior Channel, superior Commu
			Return True
		Case 5551	;~ superior Vigor
			Return True
		Case 19156	;~ Sentinel insignia
			Return True
		Case 19139	;~ Tormentor insignia
			Return True
		Case 19163	;~ Winwalker insignia
			Return True
		Case 19129	;~ Prodigy insignia
			Return True
		Case 19165	;~ Shamans insignia
			Return True
		Case 19127	;~ Nightstalker insignia
			Return True
		Case 19168	;~ Centurions insignia
			Return True
		Case 19135	;~ Blessed insignia
			Return True
	EndSwitch

	Return False
EndFunc	;==> IsAlreadySalvaged

;~ Description: Starts a salvaging session of an item.
Func StartSalvage2($aItem, $aSalvageKit = 0)
    Local $lOffset[4] = [0, 0x18, 0x2C, 0x690]
    Local $lSalvageSessionID = Memory_ReadPtr($g_p_BasePointer, $lOffset)
    Local $lSalvageKit = 0

    If Not IsPtr($aSalvageKit) Then
        $lSalvageKit = Item_GetItemPtr($aSalvageKit)
    Else
        $lSalvageKit = $aSalvageKit
    EndIf
    Sleep(250)
    If $lSalvageKit = 0 Then Return 0

    DllStructSetData($g_d_Salvage, 2, Item_ItemID($aItem))
    DllStructSetData($g_d_Salvage, 3, Item_ItemID($lSalvageKit))
    DllStructSetData($g_d_Salvage, 4, $lSalvageSessionID[1])
    Core_Enqueue($g_p_Salvage, 16)
    Return 1
EndFunc

;~ Description: Identifies an item.
Func IdentifyItem2($aItem, $aIdentKit = 0)
	Local $lItemID = Item_ItemID($aItem)
	Local $lIdentKit = 0

	If Not IsPtr($aIdentKit) Then
		$lIdentKit = Item_GetItemPtr($aIdentKit)
	Else
		$lIdentKit = $aIdentKit
	EndIf
	Sleep(250)

    If Item_GetItemInfoByPtr($aItem, "IsIdentified") Then Return True
    If $lIdentKit = 0 Then Return False

    Core_SendPacket(0xC, $GC_I_HEADER_ITEM_IDENTIFY, Item_ItemID($lIdentKit), $lItemID)

    Local $lDeadlock = TimerInit()
    Do
        Sleep(100)
    Until Item_GetItemInfoByPtr($aItem, "IsIdentified") Or TimerDiff($lDeadlock) > 2500

	If TimerDiff($lDeadlock) > 2500 Then Return False

    Return True
EndFunc   ;==>IdentifyItem

Func FindIdentificationKit()
	Local $lItemPtr
	Local $lKit = 0
	Local $lKitPtr = 0
	Local $lUses = 101
	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			Switch Item_GetItemInfoByPtr($lItemPtr, 'ModelID')
				Case 2989
					If Item_GetItemInfoByPtr($lItemPtr, 'Value') / 2 < $lUses Then
						$lKit = Item_GetItemInfoByPtr($lItemPtr, 'ItemID')
						$lUses = Item_GetItemInfoByPtr($lItemPtr, 'Value') / 2
						$lKitPtr = $lItemPtr
					EndIf
				Case 5899
					If Item_GetItemInfoByPtr($lItemPtr, 'Value') / 2.5 < $lUses Then
						$lKit = Item_GetItemInfoByPtr($lItemPtr, 'ItemID')
						$lUses = Item_GetItemInfoByPtr($lItemPtr, 'Value') / 2.5
						$lKitPtr = $lItemPtr
					EndIf
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $lKitPtr
EndFunc   ;==>FindIdentificationKit

Func FindExpertSalvageKit()
	Local $lItemPtr
	Local $lKitPtr = 0
	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			Switch Item_GetItemInfoByPtr($lItemPtr, 'ModelID')
				Case 2991
					$lKitPtr = $lItemPtr
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $lKitPtr
EndFunc   ;==>FindExpertSalvageKit

Func FindRareRuneOrInsignia()
	Local $lItemPtr
	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			If IsRareRune($lItemPtr) Or IsRareInsignia($lItemPtr) Then Return True
		Next
	Next
	Return False
EndFunc	   ;==>FindSellableRune

Func FindAlcohol()
	Local $lItemPtr
	Local $litemID
	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			$lItemID = Item_GetItemInfoByPtr($lItemPtr, 'ModelID')
			For $ii = 0 to UBound($Alcohol_Array) - 1
				If $litemID = $Alcohol_Array[$ii] Then Return True
			Next
		Next
	Next
	Return False
EndFunc   ;==>FindAlcohol

Func UseAlcohol()
	Local $lItemPtr
	Local $litemID
	For $i = 1 To 4
		For $j = 1 To Item_GetBagInfo(Item_GetBagPtr($i), 'Slots')
			$lItemPtr = Item_GetItemBySlot($i, $j)
			$lItemID = Item_GetItemInfoByPtr($lItemPtr, 'ModelID')
			For $ii = 0 to UBound($Alcohol_Array) - 1
				If $litemID = $Alcohol_Array[$ii] Then
					Item_UseItem($lItemPtr)
					Sleep(250)
					Return True
				EndIf
			Next
		Next
	Next
	Return False
EndFunc	   ;==>UseAlcohol

Func ScanDyes($dyeID)
	Local $aItemPtr
	Local $BagIndex
	Local $BagPtr
	Local $dyeNumber = 0
	Local $ModelID
	Local $ExtraID

	For $BagIndex = 1 To 4
		$BagPtr = Item_GetBagPtr($BagIndex)
		For $ii = 1 To Item_GetBagInfo($BagPtr, "Slots")
			$aItemPtr = Item_GetItemBySlot($BagIndex, $ii)
			If Item_GetItemInfoByPtr($aItemPtr, "ItemID") = 0 Then ContinueLoop
			$ModelID = Item_GetItemInfoByPtr($aItemPtr, "ModelID")
			$ExtraID = Item_GetItemInfoByPtr($aItemPtr, "ExtraID")
			If $ModelID == 146 and $ExtraID == $dyeID Then
				$dyeNumber += Item_GetItemInfoByPtr($aItemPtr, "Quantity")
			Else
				ContinueLoop
			EndIf
		Next
	Next
	Return $dyeNumber
EndFunc ;==> ScanDyes


Func SellRunes($BagIndex)
	Local $aItemPtr
	Local $BagPtr = Item_GetBagPtr($BagIndex)
	For $ii = 1 To Item_GetBagInfo($BagPtr, "Slots")
		$aItemPtr = Item_GetItemBySlot($BagIndex, $ii)
		If Item_GetItemInfoByPtr($aItemPtr, "ItemID") = 0 Then ContinueLoop
		Local $sellable = IsSellableInsignia($aItemPtr) + IsSellableRune($aItemPtr)
		Sleep(250)
		If $sellable > 0 Then
			; Handle gold management before selling
			if GetGoldCharacter() > 65000 and GetGoldStorage() <= 935000 Then
				Item_DepositGold(65000)
				Sleep(500)
			ElseIf GetGoldCharacter() > 65000 and GetGoldStorage() > 935000 Then
				; Storage is full, but still sell the item to prevent infinite loop
				Out("Storage full, selling item anyway to prevent loop")
			EndIf

			; Handle Superior Vigor special case
			If IsSupVigor($aItemPtr) Then
				If GetGoldCharacter() > 20000 Then Item_DepositGold()
				Sleep(500)
				; Don't skip selling even if gold is still high - sell anyway to prevent loop
				If GetGoldCharacter() > 20000 Then
					Out("High gold amount, selling Superior Vigor anyway to prevent loop")
				EndIf
			EndIf
			
			; Always sell the item if it's sellable to prevent infinite loops
			Merchant_SellItem($aItemPtr, 1, True)
		EndIf
		Sleep(500)
	Next
EndFunc ;==> SellRunes

Func Sell($BagIndex)
    Local $aItemPtr
    Local $BagPtr = Item_GetBagPtr($BagIndex)
    For $ii = 1 To Item_GetBagInfo($BagPtr, "Slots")
        $aItemPtr = Item_GetItemBySlot($BagIndex, $ii)
        If Item_GetItemInfoByPtr($aItemPtr, "ItemID") = 0 Then ContinueLoop
        
        ; Vérifie si l'item peut être vendu
        Local $sellable = CanSell($aItemPtr)
        
        ; Si l'item est vendable, vendre l'objet
        If $sellable Then
            Merchant_SellItem($aItemPtr)
        EndIf
        
        Sleep(250)
    Next
EndFunc ;==> Sell


Func CanSell($aItem)
    Local $RareSkin = IsRareSkin($aItem)
    Local $IsDaggerCollect = IsDaggerForCollection($aItem)
    Local $IsAxeCollect = IsAxeForCollection($aItem)
    Local $IsSwordCollect = IsSwordForCollection($aItem)
    Local $Pcon = IsPcon($aItem)
    Local $Material = IsRareMaterial($aItem)
    Local $IsSpecial = IsSpecialItem($aItem)
    Local $IsCaster = IsPerfectCaster($aItem)
    Local $IsStaff = IsPerfectStaff($aItem)
    Local $IsShield = IsPerfectShield($aItem)
    Local $IsRune = IsRareRune($aItem)
    Local $IsInsignia = IsRareInsignia($aItem)
    Local $IsReq8 = IsReq8Max($aItem)
    Local $IsReq7 = IsReq7Max($aItem)
    Local $IsTome = IsRegularTome($aItem)
    Local $IsEliteTome = IsEliteTome($aItem)
    Local $IsFiveE = IsFiveE($aItem)
    Local $IsMaxAxe = IsMaxAxe($aItem)
    Local $IsMaxDagger = IsMaxDagger($aItem)
    Local $IsTyriaAnniSkin = IsTyriaAnniSkin($aItem)
    Local $IsCanthaAnniSkin = IsCanthaAnniSkin($aItem)
    Local $IsElonaAnniSkin = IsElonaAnniSkin($aItem)
    Local $IsEotnAnniSkin = IsEotnAnniSkin($aItem)
    Local $IsAnyCampAnniSkin = IsAnyCampAnniSkin($aItem)

    ; Si c'est un skin rare, on ne permet pas la vente
    If $RareSkin Then
        Return False
    EndIf

    ; Si c'est un objet destiné à une collection, on ne le vend pas
    Switch True
        Case $IsAxeCollect, $IsDaggerCollect, $IsSwordCollect
            Return False
    EndSwitch

    ; Si c'est un objet spécial ou une potion, on ne le vend pas
    Switch True
        Case $IsSpecial, $Pcon, $Material, $IsRune, $IsInsignia, $IsTome, $IsEliteTome
            Return False
    EndSwitch

    ; Ne pas vendre des objets parfaits
    Switch True
        Case $IsCaster, $IsStaff, $IsShield
            Return False
    EndSwitch

    ; Ne pas vendre les items rares de type axe, dague, etc.
    Switch True
        Case $IsMaxAxe, $IsMaxDagger
            Return False
    EndSwitch

    ; Si c'est un skin anniversaire, ne pas vendre
    Switch True
        Case $IsTyriaAnniSkin, $IsCanthaAnniSkin, $IsElonaAnniSkin, $IsEotnAnniSkin, $IsAnyCampAnniSkin
            Return False
    EndSwitch

    ; Si aucun des cas ci-dessus, autoriser la vente
    Return True
EndFunc

#EndRegion

#Region Items
Func IsRareSkin($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
    Case 399
	   Return True ; Crystallines
    Case 344
	   Return True ; Magmas Shield
    Case 603
	   Return True ; Orrian Earth Staff
    Case 391
	   Return True ; Raven Staff
    Case 926
       Return True ; Cele Scepter All Attribs
    Case 942, 943
	   Return True ; Cele Shields (Str + Tact)
    Case 858, 776, 789
	   Return True ; Paper Fans (Divine, Soul, Energy)
    Case 905
	   Return True ; Divine Scroll (Canthan)
    Case 785
	   Return True ; Celestial Staff all attribs.
    Case 1022, 874, 875
	   Return True ; Jug - DF, SF, ES
    Case 952, 953
	   Return True ; Kappa Shields (Str + Tact)
    Case 736, 735, 778, 777, 871, 872, 741, 870, 873, 871, 872, 869, 744, 1101
	   Return True ; All rare skins from Cantha Mainland
    Case 945, 944, 940, 941, 950, 951, 1320, 1321, 789, 896, 875, 954, 955, 956, 958
	   Return True ; All rare skins from Dragon Moss
    Case 959, 960
	   Return True ; Plagueborn Shields
;~     Case 1026, 1027
;~ 	   Return True ; Plagueborn Focus (ES, DF)
    Case 341
	   Return True ; Stone Summit Shield
    Case 342
	   Return True ; Summit Warlord Shield
    Case 1985
	   Return True ; Eaglecrest Axe
    Case 2048
	   Return True ; Wingcrest Maul
    Case 2071
	   Return True ; Voltaic Spear
    Case 1953, 1954, 1955, 1956, 1957, 1958, 1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971, 1972, 1973
	   Return True ; Froggy Scepters
	Case 1197, 1556, 1569, 1439, 1563
	   Return True ; Elonian Swords (Colossal, Ornate, Tattooed, Dead, etc)
	Case 1589
		Return True ; Sea Purse Shield
	Case 1469, 1488, 1266
		Return True ; Diamong Aegis mot,com,tac
	Case 1497, 1498, 1268
		Return True ; Iridescent Aegis mot,com,tac
    Case 21439
	   Return True ; Polar Bear
    Case 1896
	   Return True ; Draconic Aegis - Str
    Case 36674
	   Return True ; Envoy Staff (Divine?)
    Case 1976
	   Return True ; Emerald Blade
    Case 1978
	   Return True ; Draconic Scythe
    Case 32823
	   Return True ; Dhuums Soul Reaper
    Case 208
	   Return True ; Ascalon War Hammer
    Case 1315
	   Return True ; Gloom Shield (Str)
    Case 1039
	   Return True ; Zodiac Shield (Str)
    Case 1037
	   Return True ; Exalted Aegis (Str)
    Case 1320
	   Return True ; Guardian Of The Hunt (Str)
    Case 956, 958
	   Return True ; Outcast Shield (Str) / (Tac)
    Case 336
	   Return True ; Shadow Shield (OS - Str)
    Case 120
	   Return True ; Sephis Axe (OS)
    Case 114
	   Return True ; Dwarven Axe (OS)
    Case 118
	   Return True ; Serpent Axe (OS)
    Case 1052
	   Return True ; Darkwing Defender (Str)
    Case 2236
	   Return True ; Enamaled Shield (Tact)
	Case 985
	   Return True ; Dragon Kamas
	Case 396
		Return True ; Brute Sword
	Case 397
		Return True ; Butterfly Sword
	Case 405
		Return True ; Falchion
	Case 400
		Return True ; Fellblade
	Case 402
		Return True ; Fiery Dragon Sword
	Case 406
		Return True ; Flamberge
	Case 407
		Return True ; Forked Sword
	Case 408
		Return True ; Gladius
	Case 412
		Return True ; Long Sword
	Case 416
		Return True ; Scimitar
	Case 417
		Return True ; Shadow Blade
	Case 418
		Return True ; Short Sword
	Case 419
		Return True ; Spatha
	Case 421
		Return True ; Wingblade
	Case 737
		Return True ; Broadsword
	Case 790
		Return True ; Celestial Sword
	Case 791
		Return True ; Crenellated Sword
	Case 739
		Return True ; Dadao Sword
	Case 740
		Return True ; Dusk Blade
	Case 795
		Return True ; Golden Phoenix Blade
	Case 793
		Return True ; Gothic Sword
	Case 1322
		Return True ; Jade Sword
	Case 741
		Return True ; Jitte
	Case 742
		Return True ; Katana
	Case 794
		Return True ; Oni Blade
	Case 796
		Return True ; Plagueborn Sword
	Case 743
		Return True ; Platinum Blade
	Case 744
		Return True ; Shinobi Blade
	Case 797
		Return True ; Sunqua Blade
	Case 792
		Return True ; Wicked Blade
	Case 1042
		Return True ; Vertebreaker
	Case 1043
		Return True ; Zodiac Sword
	EndSwitch
	Return False
EndFunc ;==> IsRareSkin

Func IsTyriaAnniSkin($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
	Case 2017, 2018, 2019, 2020
	   Return True ; Bone Idols
	Case 2444
		Return True ; Canthan Targe
	Case 2100, 2101
		Return True ; Censor Icon
	Case 2012, 2013, 2014, 2015, 2016
		Return True ; Chirmeric Prism
	Case 2011
		Return True ; Ithas Bow
	EndSwitch
	Return False
EndFunc ;==> IsTyriaAnniSkin

Func IsCanthaAnniSkin($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
	Case 2460
	   Return True ; Dragon Fangs
	Case 2464, 2465, 2466, 2467
		Return True ; Spirit Binder
	Case 2469, 2470
		Return True ; Japan 1st Anniversary Shield
	EndSwitch
	Return False
EndFunc ;==> IsCanthaAnniSkin

Func IsElonaAnniSkin($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
	Case 2471
	   Return True ; Sunspear
	EndSwitch
	Return False
EndFunc ;==> IsElonaAnniSkin

Func IsEotnAnniSkin($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
	Case 2472
	   Return True ; Darksteel Longbow
	Case 2473
		Return True ; Glacial Blade
	Case 2474
		Return True ; Glacial Blades
	Case 2475, 2476, 2477, 2478, 2479, 2480, 2481, 2482, 2483, 2484, 2485, 2486, 2487, 2488, 2489, 2490, 2491, 2492, 2493, 2494, 2495
		Return True ; Hourglass Staff
	Case 2102, 2134, 2103
		Return True ; Etched Sword
	Case 2105, 2106
		Return True ; Arced Blade
	Case 2116, 2117
		Return True ; Granite Edge
	Case 1955, 2125, 1956
		Return True ; Stoneblade
	EndSwitch
	Return False
EndFunc ;==> IsEotnAnniSkin

Func IsAnyCampAnniSkin($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
	Case 2239
	   Return True ; Bears Sloth
	Case 2070, 2081, 2082, 2084
		Return True ; Foxs Greed
	Case 2440, 2439, 2438
		Return True ; Hogs Gluttony
	Case 2020, 2026, 2027, 2028, 2029, 2030, 2492
		Return True ; Lions Pride
	Case 2009, 2008
		Return True ; Scorpions Lust, Scorpions Bow
	Case 2451, 2452, 2453, 2454
		Return True ; Snakes Envy
	Case 2246, 2424, 2427, 2428, 2429, 2430
		Return True ; Unicorns Wrath
	Case 2010
		Return True ; Black Hawks Lust
	Case 2456, 2457, 2458, 2459
		Return True ; Dragons Envy
	Case 2431, 2432, 2433, 2434
		Return True ; Peacocks Wrath
	Case 2240
		Return True ; Rhinos Sloth
	Case 2442, 2443, 2441
		Return True ; Spiders Gluttony
	Case 2031, 2045, 2047, 2054, 2055
		Return True ; Tigers Pride
	Case 2087, 2088, 2090, 2091, 2092, 2094, 2095
		Return True ; Wolfs Greed
	Case 2133
		Return True ; Furious Bonecrusher
	Case 2435, 2436, 2437
		Return True ; Bronze Guardian
	Case 2447, 2450, 2448
		Return True ; Deaths Head
	Case 2056, 2057, 2066, 2067
		Return True ; Heavens Arch
	Case 2242, 2243, 2244, 2445
		Return True ; Quicksilver
	Case 2021, 2022, 2023, 2024, 2025
		Return True ; Storm Ember
	Case 2461
		Return True ; Omnious Aegis
	EndSwitch
	Return False
EndFunc ;==> IsAnyCampAnniSkin

Func IsPcon($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
    Case 910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682
	   Return True ; Alcohol
    Case 6376, 21809, 21810, 21813, 36683
	   Return True ; Party
    Case 21492, 21812, 22269, 22644, 22752, 28436
	   Return True ; Sweets
    Case 6370, 21488, 21489, 22191, 26784, 28433
	   Return True ; DP Removal
    Case 15837, 21490, 30648, 31020
	   Return True ; Tonic
    EndSwitch
	Return False
EndFunc ;==> IsPcon

Func IsRareMaterial($aItem)
	Local $M = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $M
	Case 937, 938, 935, 931, 932, 936, 930, 945, 923
	   Return True ; Rare Mats
	EndSwitch
	Return False
EndFunc ;==> IsRareMaterial

Func IsSpecialItem($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")
	Local $ExtraID = Item_GetItemInfoByPtr($aItem, "ExtraID")

	Switch $ModelID
    Case 5656, 18345, 21491, 37765, 21833, 28433, 28434
	   Return True ; Special - ToT etc
    Case 22751
	   Return True ; Lockpicks
    Case 146
	   If $ExtraID = 10 Or $ExtraID = 12 Then
		  Return True ; Black & White Dye
	   Else
		  Return False
	   EndIf
    Case 24353, 24354
	   Return True ; Chalice & Rin Relics
    Case 522
	   Return True ; Dark Remains
    Case 3746, 22280
	   Return True ; Underworld & FOW Scroll
    Case 35121
	   Return True ; War supplies
    Case 36985
	   Return True ; Commendations
	Case 19186, 19187, 19188, 19189
		Return True ; Djinn Essences
    EndSwitch
	Return False
EndFunc	;==> IsSpecialItem

Func IsPerfectCaster($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $A = GetItemAttribute($aItem)
    ; Universal mods
    Local $PlusFive = StringInStr($ModStruct, "5320823", 0, 1) ; Mod struct for +5^50
	Local $PlusFiveEnch = StringInStr($ModStruct, "500F822", 0, 1) ; Mod struct for +5wench
	Local $is10Cast = StringInStr($ModStruct, "A0822", 0, 1) ; Mod struct for 10% cast
	Local $is10Recharge = StringInStr($ModStruct, "AA823", 0, 1) ; Mod struct for 10% recharge
	; Ele mods
	Local $Fire20Casting = StringInStr($ModStruct, "0A141822", 0, 1) ; Mod struct for 20% fire
	Local $Fire20Recharge = StringInStr($ModStruct, "0A149823", 0, 1)
	Local $Water20Casting = StringInStr($ModStruct, "0B141822", 0, 1) ; Mod struct for 20% water
	Local $Water20Recharge = StringInStr($ModStruct, "0B149823", 0, 1)
	Local $Air20Casting = StringInStr($ModStruct, "08141822", 0, 1) ; Mod struct for 20% air
	Local $Air20Recharge = StringInStr($ModStruct, "08149823", 0, 1)
	Local $Earth20Casting = StringInStr($ModStruct, "09141822", 0, 1)
	Local $Earth20Recharge = StringInStr($ModStruct, "09149823", 0, 1)
	Local $Energy20Casting = StringInStr($ModStruct, "0C141822", 0, 1)
	Local $Energy20Recharge = StringInStr($ModStruct, "0C149823", 0, 1)
	; Monk mods
	Local $Smiting20Casting = StringInStr($ModStruct, "0E141822", 0, 1) ; Mod struct for 20% smite
	Local $Smiting20Recharge = StringInStr($ModStruct, "0E149823", 0, 1)
	Local $Divine20Casting = StringInStr($ModStruct, "10141822", 0, 1) ; Mod struct for 20% divine
	Local $Divine20Recharge = StringInStr($ModStruct, "10149823", 0, 1)
	Local $Healing20Casting = StringInStr($ModStruct, "0D141822", 0, 1) ; Mod struct for 20% healing
	Local $Healing20Recharge = StringInStr($ModStruct, "0D149823", 0, 1)
	Local $Protection20Casting = StringInStr($ModStruct, "0F141822", 0, 1) ; Mod struct for 20% protection
	Local $Protection20Recharge = StringInStr($ModStruct, "0F149823", 0, 1)
	; Rit mods
	Local $Channeling20Casting = StringInStr($ModStruct, "22141822", 0, 1) ; Mod struct for 20% channeling
	Local $Channeling20Recharge = StringInStr($ModStruct, "22149823", 0, 1)
	Local $Restoration20Casting = StringInStr($ModStruct, "21141822", 0, 1)
	Local $Restoration20Recharge = StringInStr($ModStruct, "21149823", 0, 1)
    Local $Communing20Casting = StringInStr($ModStruct, "20141822", 0, 1)
	Local $Communing20Recharge = StringInStr($ModStruct, "20149823", 0, 1)
    Local $Spawning20Casting = StringInStr($ModStruct, "24141822", 0, 1) ; Spawning - Unconfirmed
	Local $Spawning20Recharge = StringInStr($ModStruct, "24149823", 0, 1) ; Spawning - Unconfirmed
	; Mes mods
    Local $Illusion20Recharge = StringInStr($ModStruct, "01149823", 0, 1)
	Local $Illusion20Casting = StringInStr($ModStruct, "01141822", 0, 1)
	Local $Domination20Casting = StringInStr($ModStruct, "02141822", 0, 1) ; Mod struct for 20% domination
    Local $Domination20Recharge = StringInStr($ModStruct, "02149823", 0, 1) ; Mod struct for 20% domination recharge
    Local $Inspiration20Recharge = StringInStr($ModStruct, "03149823", 0, 1)
	Local $Inspiration20Casting = StringInStr($ModStruct, "03141822", 0, 1)
	; Necro mods
    Local $Death20Casting = StringInStr($ModStruct, "05141822", 0, 1) ; Mod struct for 20% death
	Local $Death20Recharge = StringInStr($ModStruct, "05149823", 0, 1)
    Local $Blood20Recharge = StringInStr($ModStruct, "04149823", 0, 1)
	Local $Blood20Casting = StringInStr($ModStruct, "04141822", 0, 1)
    Local $SoulReap20Recharge = StringInStr($ModStruct, "06149823", 0, 1)
	Local $SoulReap20Casting = StringInStr($ModStruct, "06141822", 0, 1)
    Local $Curses20Recharge = StringInStr($ModStruct, "07149823", 0, 1)
	Local $Curses20Casting = StringInStr($ModStruct, "07141822", 0, 1)

	Switch $A
    Case 1 ; Illusion
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Illusion20Casting > 0 Or $Illusion20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Illusion20Recharge > 0 Or $Illusion20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Illusion20Recharge > 0 Then
		  If $Illusion20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 2 ; Domination
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Domination20Casting > 0 Or $Domination20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Domination20Recharge > 0 Or $Domination20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Domination20Recharge > 0 Then
		  If $Domination20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 3 ; Inspiration
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Inspiration20Casting > 0 Or $Inspiration20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Inspiration20Recharge > 0 Or $Inspiration20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Inspiration20Recharge > 0 Then
		  If $Inspiration20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 4 ; Blood
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Blood20Casting > 0 Or $Blood20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Blood20Recharge > 0 Or $Blood20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Blood20Recharge > 0 Then
		  If $Blood20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 5 ; Death
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Death20Casting > 0 Or $Death20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Death20Recharge > 0 Or $Death20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Death20Recharge > 0 Then
		  If $Death20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 6 ; SoulReap - Doesnt drop?
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $SoulReap20Casting > 0 Or $SoulReap20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $SoulReap20Recharge > 0 Or $SoulReap20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $SoulReap20Recharge > 0 Then
		  If $SoulReap20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 7 ; Curses
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Curses20Casting > 0 Or $Curses20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Curses20Recharge > 0 Or $Curses20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Curses20Recharge > 0 Then
		  If $Curses20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 8 ; Air
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Air20Casting > 0 Or $Air20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Air20Recharge > 0 Or $Air20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Air20Recharge > 0 Then
		  If $Air20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 9 ; Earth
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Earth20Casting > 0 Or $Earth20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Earth20Recharge > 0 Or $Earth20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Earth20Recharge > 0 Then
		  If $Earth20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
       Return False
    Case 10 ; Fire
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Fire20Casting > 0 Or $Fire20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Fire20Recharge > 0 Or $Fire20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Fire20Recharge > 0 Then
		  If $Fire20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
       Return False
    Case 11 ; Water
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Water20Casting > 0 Or $Water20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Water20Recharge > 0 Or $Water20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Water20Recharge > 0 Then
		  If $Water20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 12 ; Energy Storage
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Energy20Casting > 0 Or $Energy20Recharge > 0 Or $Water20Casting > 0 Or $Water20Recharge > 0 Or $Fire20Casting > 0 Or $Fire20Recharge > 0 Or $Earth20Casting > 0 Or $Earth20Recharge > 0 Or $Air20Casting > 0 Or $Air20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Energy20Recharge > 0 Or $Energy20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Or $Water20Casting > 0 Or $Water20Recharge > 0 Or $Fire20Casting > 0 Or $Fire20Recharge > 0 Or $Earth20Casting > 0 Or $Earth20Recharge > 0 Or $Air20Casting > 0 Or $Air20Recharge > 0 Then
		     Return True
		  EndIf
       EndIf
	   If $Energy20Recharge > 0 Then
		  If $Energy20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $is10Cast > 0 Or $is10Recharge > 0 Then
		  If $Water20Casting > 0 Or $Water20Recharge > 0 Or $Fire20Casting > 0 Or $Fire20Recharge > 0 Or $Earth20Casting > 0 Or $Earth20Recharge > 0 Or $Air20Casting > 0 Or $Air20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 13 ; Healing
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Healing20Casting > 0 Or $Healing20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Healing20Recharge > 0 Or $Healing20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Healing20Recharge > 0 Then
		  If $Healing20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 14 ; Smiting
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Smiting20Recharge > 0 Or $Smiting20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Smiting20Recharge > 0 Then
		  If $Smiting20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 15 ; Protection
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Protection20Recharge > 0 Or $Protection20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Protection20Recharge > 0 Then
		  If $Protection20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 16 ; Divine
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Divine20Casting > 0 Or $Divine20Recharge > 0 Or $Healing20Casting > 0 Or $Healing20Recharge > 0 Or $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Or $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Divine20Recharge > 0 Or $Divine20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Or $Healing20Casting > 0 Or $Healing20Recharge > 0 Or $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Or $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Divine20Recharge > 0 Then
		  If $Divine20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $is10Cast > 0 Or $is10Recharge > 0 Then
		  If $Healing20Casting > 0 Or $Healing20Recharge > 0 Or $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Or $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 32 ; Communing
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Communing20Casting > 0 Or $Communing20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Communing20Recharge > 0 Or $Communing20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Communing20Recharge > 0 Then
		  If $Communing20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
	Case 33 ; Restoration
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Restoration20Casting > 0 Or $Restoration20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Restoration20Recharge > 0 Or $Restoration20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Restoration20Recharge > 0 Then
		  If $Restoration20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 34 ; Channeling
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Channeling20Casting > 0 Or $Channeling20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Channeling20Recharge > 0 Or $Channeling20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Channeling20Recharge > 0 Then
		  If $Channeling20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    Case 36 ; Spawning - Unconfirmed
	   If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
		  If $Spawning20Casting > 0 Or $Spawning20Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Spawning20Recharge > 0 Or $Spawning20Casting > 0 Then
		  If $is10Cast > 0 Or $is10Recharge > 0 Then
		     Return True
		  EndIf
	   EndIf
	   If $Spawning20Recharge > 0 Then
		  If $Spawning20Casting > 0 Then
		     Return True
		  EndIf
	   EndIf
	   Return False
    EndSwitch
    Return False
EndFunc ;==> IsPerfectCaster

Func IsPerfectStaff($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $A = GetItemAttribute($aItem)
	; Ele mods
	Local $Fire20Casting = StringInStr($ModStruct, "0A141822", 0, 1) ; Mod struct for 20% fire
	Local $Water20Casting = StringInStr($ModStruct, "0B141822", 0, 1) ; Mod struct for 20% water
	Local $Air20Casting = StringInStr($ModStruct, "08141822", 0, 1) ; Mod struct for 20% air
	Local $Earth20Casting = StringInStr($ModStruct, "09141822", 0, 1) ; Mod Struct for 20% Earth
	Local $Energy20Casting = StringInStr($ModStruct, "0C141822", 0, 1) ; Mod Struct for 20% Energy Storage (Doesnt drop)
	; Monk mods
	Local $Smite20Casting = StringInStr($ModStruct, "0E141822", 0, 1) ; Mod struct for 20% smite
	Local $Divine20Casting = StringInStr($ModStruct, "10141822", 0, 1) ; Mod struct for 20% divine
	Local $Healing20Casting = StringInStr($ModStruct, "0D141822", 0, 1) ; Mod struct for 20% healing
	Local $Protection20Casting = StringInStr($ModStruct, "0F141822", 0, 1) ; Mod struct for 20% protection
	; Rit mods
	Local $Channeling20Casting = StringInStr($ModStruct, "22141822", 0, 1) ; Mod struct for 20% channeling
	Local $Restoration20Casting = StringInStr($ModStruct, "21141822", 0, 1) ; Mod Struct for 20% Restoration
	Local $Communing20Casting = StringInStr($ModStruct, "20141822", 0, 1) ; Mod Struct for 20% Communing
	Local $Spawning20Casting = StringInStr($ModStruct, "24141822", 0, 1) ; Mod Struct for 20% Spawning (Unconfirmed)
	; Mes mods
	Local $Illusion20Casting = StringInStr($ModStruct, "01141822", 0, 1) ; Mod struct for 20% Illusion
	Local $Domination20Casting = StringInStr($ModStruct, "02141822", 0, 1) ; Mod struct for 20% domination
	Local $Inspiration20Casting = StringInStr($ModStruct, "03141822", 0, 1) ; Mod struct for 20% Inspiration
	; Necro mods
	Local $Death20Casting = StringInStr($ModStruct, "05141822", 0, 1) ; Mod struct for 20% death
	Local $Blood20Casting = StringInStr($ModStruct, "04141822", 0, 1) ; Mod Struct for 20% Blood
    Local $SoulReap20Casting = StringInStr($ModStruct, "06141822", 0, 1) ; Mod Struct for 20% Soul Reap (Doesnt drop)
	Local $Curses20Casting = StringInStr($ModStruct, "07141822", 0, 1) ; Mod Struct for 20% Curses

	Switch $A
    Case 1 ; Illusion
	   If $Illusion20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 2 ; Domination
	   If $Domination20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 3 ; Inspiration - Doesnt Drop
	   If $Inspiration20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 4 ; Blood
	   If $Blood20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 5 ; Death
	   If $Death20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 6 ; SoulReap - Doesnt Drop
	   If $SoulReap20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 7 ; Curses
	   If $Curses20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 8 ; Air
	   If $Air20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 9 ; Earth
	   If $Earth20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 10 ; Fire
	   If $Fire20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 11 ; Water
	   If $Water20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 12 ; Energy Storage
	   If $Air20Casting > 0 Or $Earth20Casting > 0 Or $Fire20Casting > 0 Or $Water20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 13 ; Healing
	   If $Healing20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 14 ; Smiting
	   If $Smite20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 15 ; Protection
	   If $Protection20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 16 ; Divine
	   If $Healing20Casting > 0 Or $Protection20Casting > 0 Or $Divine20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 32 ; Communing
	   If $Communing20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 33 ; Restoration
	   If $Restoration20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 34 ; Channeling
	   If $Channeling20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 36 ; Spawning - Unconfirmed
	   If $Spawning20Casting > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
	EndSwitch
	Return False
EndFunc ;==> IsPerfectStaff

Func IsPerfectShield($aItem)
    Local $ModStruct = Item_GetModStruct($aItem)
	; Universal mods
    Local $Plus30 = StringInStr($ModStruct, "1E4823", 0, 1) ; Mod struct for +30 (shield only?)
	Local $Minus3Hex = StringInStr($ModStruct, "3009820", 0, 1) ; Mod struct for -3wHex (shield only?)
	Local $Minus2Stance = StringInStr($ModStruct, "200A820", 0, 1) ; Mod Struct for -2Stance
	Local $Minus2Ench = StringInStr($ModStruct, "2008820", 0, 1) ; Mod struct for -2Ench
	Local $Plus45Stance = StringInStr($ModStruct, "02D8823", 0, 1) ; For +45Stance
	Local $Plus45Ench = StringInStr($ModStruct, "02D6823", 0, 1) ; Mod struct for +45ench
	Local $Plus44Ench = StringInStr($ModStruct, "02C6823", 0, 1) ; For +44/+10Demons
	Local $Minus520 = StringInStr($ModStruct, "5147820", 0, 1) ; For -5(20%)
	; +1 20% Mods ~ Updated 08/10/2018 - FINISHED
	Local $PlusIllusion = StringInStr($ModStruct, "0118240", 0, 1) ; +1 Illu 20%
	Local $PlusDomination = StringInStr($ModStruct, "0218240", 0, 1) ; +1 Dom 20%
	Local $PlusInspiration = StringInStr($ModStruct, "0318240", 0, 1) ; +1 Insp 20%
	Local $PlusBlood = StringInStr($ModStruct, "0418240", 0, 1) ; +1 Blood 20%
	Local $PlusDeath = StringInStr($ModStruct, "0518240", 0, 1) ; +1 Death 20%
	Local $PlusSoulReap = StringInStr($ModStruct, "0618240", 0, 1) ; +1 SoulR 20%
	Local $PlusCurses = StringInStr($ModStruct, "0718240", 0, 1) ; +1 Curses 20%
	Local $PlusAir = StringInStr($ModStruct, "0818240", 0, 1) ; +1 Air 20%
	Local $PlusEarth = StringInStr($ModStruct, "0918240", 0, 1) ; +1 Earth 20%
    Local $PlusFire = StringInStr($ModStruct, "0A18240", 0, 1) ; +1 Fire 20%
	Local $PlusWater = StringInStr($ModStruct, "0B18240", 0, 1) ; +1 Water 20%
	Local $PlusHealing = StringInStr($ModStruct, "0D18240", 0, 1) ; +1 Heal 20%
	Local $PlusSmite = StringInStr($ModStruct, "0E18240", 0, 1) ; +1 Smite 20%
	Local $PlusProt = StringInStr($ModStruct, "0F18240", 0, 1) ; +1 Prot 20%
	Local $PlusDivine = StringInStr($ModStruct, "1018240", 0, 1) ; +1 Divine 20%
	; +10vsMonster Mods
	Local $PlusDemons = StringInStr($ModStruct, "A0848210", 0, 1) ; +10vs Demons
	Local $PlusDragons = StringInStr($ModStruct, "A0948210", 0, 1) ; +10vs Dragons
	Local $PlusPlants = StringInStr($ModStruct, "A0348210", 0, 1) ; +10vs Plants
	Local $PlusUndead = StringInStr($ModStruct, "A0048210", 0, 1) ; +10vs Undead
	Local $PlusTengu = StringInStr($ModStruct, "A0748210", 0, 1) ; +10vs Tengu
    ; New +10vsMonster Mods 07/10/2018 - Thanks to Savsuds
    Local $PlusCharr = StringInStr($ModStruct, "0A014821", 0 ,1) ; +10vs Charr
    Local $PlusTrolls = StringInStr($ModStruct, "0A024821", 0 ,1) ; +10vs Trolls
    Local $PlusSkeletons = StringInStr($ModStruct, "0A044821", 0 ,1) ; +10vs Skeletons
    Local $PlusGiants = StringInStr($ModStruct, "0A054821", 0 ,1) ; +10vs Giants
    Local $PlusDwarves = StringInStr($ModStruct, "0A064821", 0 ,1) ; +10vs Dwarves
    Local $PlusDragons = StringInStr($ModStruct, "0A094821", 0 ,1) ; +10vs Dragons
    Local $PlusOgres = StringInStr($ModStruct, "0A0A4821", 0 ,1) ; +10vs Ogres
	; +10vs Dmg
	Local $PlusPiercing = StringInStr($ModStruct, "A0118210", 0, 1) ; +10vs Piercing
	Local $PlusLightning = StringInStr($ModStruct, "A0418210", 0, 1) ; +10vs Lightning
	Local $PlusVsEarth = StringInStr($ModStruct, "A0B18210", 0, 1) ; +10vs Earth
	Local $PlusCold = StringInStr($ModStruct, "A0318210", 0, 1) ; +10 vs Cold
	Local $PlusSlashing = StringInStr($ModStruct, "A0218210", 0, 1) ; +10vs Slashing
	Local $PlusVsFire = StringInStr($ModStruct, "A0518210", 0, 1) ; +10vs Fire
	; New +10vs Dmg 08/10/2018
	Local $PlusBlunt = StringInStr($ModStruct, "A0018210", 0, 1) ; +10vs Blunt

    If $Plus30 > 0 Then
	   If $PlusDemons > 0 Or $PlusPiercing > 0 Or $PlusDragons > 0 Or $PlusLightning > 0 Or $PlusVsEarth > 0 Or $PlusPlants > 0 Or $PlusCold > 0 Or $PlusUndead > 0 Or $PlusSlashing > 0 Or $PlusTengu > 0 Or $PlusVsFire > 0 Then
	      Return True
	   ElseIf $PlusCharr > 0 Or $PlusTrolls > 0 Or $PlusSkeletons > 0 Or $PlusGiants > 0 Or $PlusDwarves > 0 Or $PlusDragons > 0 Or $PlusOgres > 0 Or $PlusBlunt > 0 Then
		  Return True
	   ElseIf $PlusDomination > 0 Or $PlusDivine > 0 Or $PlusSmite > 0 Or $PlusHealing > 0 Or $PlusProt > 0 Or $PlusFire > 0 Or $PlusWater > 0 Or $PlusAir > 0 Or $PlusEarth > 0 Or $PlusDeath > 0 Or $PlusBlood > 0 Or $PlusIllusion > 0 Or $PlusInspiration > 0 Or $PlusSoulReap > 0 Or $PlusCurses > 0 Then
		  Return True
	   ElseIf $Minus2Stance > 0 Or $Minus2Ench > 0 Or $Minus520 > 0 Or $Minus3Hex > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
	EndIf
    If $Plus45Ench > 0 Then
	   If $PlusDemons > 0 Or $PlusPiercing > 0 Or $PlusDragons > 0 Or $PlusLightning > 0 Or $PlusVsEarth > 0 Or $PlusPlants > 0 Or $PlusCold > 0 Or $PlusUndead > 0 Or $PlusSlashing > 0 Or $PlusTengu > 0 Or $PlusVsFire > 0 Then
	      Return True
	   ElseIf $PlusCharr > 0 Or $PlusTrolls > 0 Or $PlusSkeletons > 0 Or $PlusGiants > 0 Or $PlusDwarves > 0 Or $PlusDragons > 0 Or $PlusOgres > 0 Or $PlusBlunt > 0 Then
		  Return True
	   ElseIf $Minus2Ench > 0 Then
		  Return True
	   ElseIf $PlusDomination > 0 Or $PlusDivine > 0 Or $PlusSmite > 0 Or $PlusHealing > 0 Or $PlusProt > 0 Or $PlusFire > 0 Or $PlusWater > 0 Or $PlusAir > 0 Or $PlusEarth > 0 Or $PlusDeath > 0 Or $PlusBlood > 0 Or $PlusIllusion > 0 Or $PlusInspiration > 0 Or $PlusSoulReap > 0 Or $PlusCurses > 0 Then
		  Return True
	   Else
		  Return False
	   EndIf
	EndIf
	If $Minus2Ench > 0 Then
	   If $PlusDemons > 0 Or $PlusPiercing > 0 Or $PlusDragons > 0 Or $PlusLightning > 0 Or $PlusVsEarth > 0 Or $PlusPlants > 0 Or $PlusCold > 0 Or $PlusUndead > 0 Or $PlusSlashing > 0 Or $PlusTengu > 0 Or $PlusVsFire > 0 Then
		  Return True
	   ElseIf $PlusCharr > 0 Or $PlusTrolls > 0 Or $PlusSkeletons > 0 Or $PlusGiants > 0 Or $PlusDwarves > 0 Or $PlusDragons > 0 Or $PlusOgres > 0 Or $PlusBlunt > 0 Then
		  Return True
	   EndIf
	EndIf
    If $Plus44Ench > 0 Then
	   If $PlusDemons > 0 Then
	      Return True
	   EndIf
	EndIf
    If $Plus45Stance > 0 Then
	   If $Minus2Stance > 0 Then
	      Return True
	   EndIf
	EndIf
	Return False
EndFunc ;==> IsPerfectShield

Func IsDaggerForCollection($aItem)

	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Req = GetItemReq($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $isfiveE = StringInStr($ModStruct, "0500D822", 0, 1) ; Mod struct for +5 Energy mod
	Local $is15_50 = StringInStr($ModStruct, "0F327822", 0, 1) ; Mod struct for 15^50 Damage mod
	Local $is15_Stance = StringInStr($ModStruct, "0F00A822", 0, 1) ; Mod struct for 15^Stance Damage mod
	Local $is15_Ench = StringInStr($ModStruct, "0F006822", 0, 1) ; Mod struct for 15^Ench Damage mod
	Local $is15_Hex = StringInStr($ModStruct, "0F005822", 0, 1) ; Mod struct for 15^Hex Damage mod
	Local $is15minus5 = StringInStr($ModStruct, "0F0038220500B8", 0, 1) ; Mod struct for 15^-5 Damage mod
	Local $is15minus10 = StringInStr($ModStruct, "0F0038220A0018", 0, 1) ; Mod struct for 15^-10 Damage mod
	Local $is20below50 = StringInStr($ModStruct, "143288220711A8A", 0, 1) ; Mod struct for 20below50 Damage mod
	Local $is20whexed = StringInStr($ModStruct, "140098220711A8A", 0, 1) ; Mod struct for 20whexed Damage mod
	Local $isclean = StringInStr($ModStruct, "8240711A8A7", 0, 1) ; Mod struct for clean mod

	Switch $Req
		; I'm only collecting q9 Daggers
		Case 9
			; Only missing ModelIDs getting browsed with the missing Modstructs
			Switch $ModelID
				Case 760 ; Aureate Daggers
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 713 ; Butterfly Knives
					If $is15_Stance or $is15_Hex or $is15minus5 or $is20whexed or $isclean Then
						Return True
					Else
						Return False
					EndIf

				Case 761 ; Celestial Daggers
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf

				Case 980 ; Chromium Shards
					If $is15_Hex Then
						Return True
					Else
						Return False
					EndIf

				Case 715 ; Dirks
					If $is15minus5 or $is15minus10 or $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 716 ; Gilded Daggers
					If $is15minus5 or $is15minus10 Then
						Return True
					Else
						Return False
					EndIf

				Case 768 ; Golden Talons
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 986 ; Hooked Daggers
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 762 ; Jade Daggers
					If $is15_Hex Then
						Return True
					Else
						Return False
					EndIf

				Case 763 ; Kamas
					If $isfiveE or $is15_Ench or $is15_Hex or $is15minus5 or $is15minus10 or $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 717 ; Korambits
					If $is20below50 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 767 ; Plagueborn Daggers
					If $is15_Hex or $is15minus5 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 718 ; Platinum Sickles
					If $is15_Stance or $is15minus5 or $is15minus10 or $is20below50 or $is20whexed or $isclean Then
						Return True
					Else
						Return False
					EndIf

				Case 719 ; Sai
					If $is15minus10 or $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 1318 ; Salient Daggers
					If $is15minus5 or $is15minus10 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 714 ; Split Chakrams
					If $is15_Hex or $is15minus10 or $is20below50 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 720 ; Stilletos
					If $is15minus5 Then
						Return True
					Else
						Return False
					EndIf

				Case 1003 ; Ceremonial Daggers
					If $is15minus10 or $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 969 ; Zodiacus Daggers
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf

				Case 2460 ; Dragon Fangs
					If $isfiveE or $is15_50 or $is15_Stance or $is15_Ench or $is15_Hex or $is15minus5 or $is15minus10 or $is20below50 or $is20whexed or $isclean Then
						Return True
					Else
						Return False
					EndIf

				Case Else
					Return False
			EndSwitch

		Case Else
			Return False
	EndSwitch
EndFunc ;==> IsDaggerForCollection

Func IsAxeForCollection($aItem)

	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Req = GetItemReq($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $isfiveE = StringInStr($ModStruct, "0500D822", 0, 1) ; Mod struct for +5 Energy mod
	Local $is15_50 = StringInStr($ModStruct, "0F327822", 0, 1) ; Mod struct for 15^50 Damage mod
	Local $is15_Stance = StringInStr($ModStruct, "0F00A822", 0, 1) ; Mod struct for 15^Stance Damage mod
	Local $is15_Ench = StringInStr($ModStruct, "0F006822", 0, 1) ; Mod struct for 15^Ench Damage mod
	Local $is15_Hex = StringInStr($ModStruct, "0F005822", 0, 1) ; Mod struct for 15^Hex Damage mod
	Local $is15minus5 = StringInStr($ModStruct, "0F0038220500B8", 0, 1) ; Mod struct for 15^-5 Damage mod
	Local $is15minus10 = StringInStr($ModStruct, "0F0038220A0018", 0, 1) ; Mod struct for 15^-10 Damage mod
	Local $is20below50 = StringInStr($ModStruct, "143288220711A8A", 0, 1) ; Mod struct for 20below50 Damage mod
	Local $is20whexed = StringInStr($ModStruct, "140098220711A8A", 0, 1) ; Mod struct for 20whexed Damage mod
	Local $isclean = StringInStr($ModStruct, "8240711A8A7", 0, 1) ; Mod struct for clean mod
	Local $isDV = StringInStr($ModStruct, "0F0038220100E", 0, 1) ; Mod struct for Dual Vamp mod
	Local $isDZ = StringInStr($ModStruct, "0F0038220100C", 0, 1) ; Mod struct for Dual Zeal mod

	; For Dual Vamp and Dual Zeal, keep all req9 ones
	If $Req = 9 and $Type = 2 Then
		If $isDV or $IsDZ Then
			Return True
		EndIf
	EndIf

	Switch $Req
		; I'm only collecting q9 Daggers
		Case 9
			; Only missing ModelIDs getting browsed with the missing Modstructs
			Switch $ModelID
				Case 115 ; Great Axe
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 120 ; Sephis Axe
					If $is15_Hex or $is20below50 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 119 ; White Reaver
					If $is20below50 or $isclean Then
						Return True
					Else
						Return False
					EndIf

				Case 746 ; Archaic Axe
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 747 ; Celestial Axe
					If $is15_Ench Then
						Return True
					Else
						Return False
					EndIf

				Case 699 ; Cleaver
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf

				Case 700 ; Crude Axe
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf

				Case 749 ; Gothic Dual Axe
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 924 ; Grinning Dragon Axe
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 702 ; Halo Axe
					If $is15minus5 Then
						Return True
					Else
						Return False
					EndIf

				Case 1317 ; Hand Axe (Canthan)
					If $is20whexed or $isclean Then
						Return True
					Else
						Return False
					EndIf

				Case 923 ; Kaineng Axe
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 705 ; Mammoth Axe
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf

				Case 706 ; Serpent Axe (Canthan)
					If $is15minus5 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf

				Case 964 ; Zodiac Axe
					If $is15minus5 Then
						Return True
					Else
						Return False
					EndIf

				Case Else
					Return False
			EndSwitch

		Case Else
			Return False
	EndSwitch
EndFunc ;==> IsAxeForCollection

Func IsSwordForCollection($aItem)

	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Req = GetItemReq($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $isfiveE = StringInStr($ModStruct, "0500D822", 0, 1) ; Mod struct for +5 Energy mod
	Local $is15_50 = StringInStr($ModStruct, "0F327822", 0, 1) ; Mod struct for 15^50 Damage mod
	Local $is15_Stance = StringInStr($ModStruct, "0F00A822", 0, 1) ; Mod struct for 15^Stance Damage mod
	Local $is15_Ench = StringInStr($ModStruct, "0F006822", 0, 1) ; Mod struct for 15^Ench Damage mod
	Local $is15_Hex = StringInStr($ModStruct, "0F005822", 0, 1) ; Mod struct for 15^Hex Damage mod
	Local $is15minus5 = StringInStr($ModStruct, "0F0038220500B8", 0, 1) ; Mod struct for 15^-5 Damage mod
	Local $is15minus10 = StringInStr($ModStruct, "0F0038220A0018", 0, 1) ; Mod struct for 15^-10 Damage mod
	Local $is20below50 = StringInStr($ModStruct, "143288220711A8A", 0, 1) ; Mod struct for 20below50 Damage mod
	Local $is20whexed = StringInStr($ModStruct, "140098220711A8A", 0, 1) ; Mod struct for 20whexed Damage mod
	Local $isclean = StringInStr($ModStruct, "8240711A8A7", 0, 1) ; Mod struct for clean mod
	Local $isDV = StringInStr($ModStruct, "0F0038220100E", 0, 1) ; Mod struct for Dual Vamp mod
	Local $isDZ = StringInStr($ModStruct, "0F0038220100C", 0, 1) ; Mod struct for Dual Zeal mod

	; For Dual Vamp and Dual Zeal, keep all req9 ones
	If $Req = 9 and $Type = 27 Then
		If $isDV or $IsDZ Then
			Return True
		EndIf
	EndIf

	; Switch for the Model ID
	Switch $ModelID
		Case 400 ; Fellblade
			Switch $Req
				Case 12
					If $is15_Hex or $is15minus10 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 406 ; Flamberge
			Switch $Req
				Case 13
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 408 ; Gladius
			Switch $Req
				Case 10
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 417 ; Shadowblade
			Switch $Req
				Case 10
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 418 ; Short Sword
			Switch $Req
				Case 13
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 419 ; Spatha
			Switch $Req
				Case 12
					If $is15minus10 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 791 ; Crennelated Sword
			Switch $Req
				Case 10
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 740 ; Dusk Blade
			Switch $Req
				Case 13
					If $is15_Ench or $is15minus10 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 795 ; Golden Phoenix Blade
			Switch $Req
				Case 12
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case 13
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 741 ; Jitte
			Switch $Req
				Case 10
					If $is15minus5 or $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 11
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 12
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 13
					If $is15_Ench or $is15minus5 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 794 ; Oni Blade
			Switch $Req
				Case 12
					If $is15minus5 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 796 ; Plagueborn Sword
			Switch $Req
				Case 11
					If $is15minus10 or $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 13
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 743 ; Platinum Blade
			Switch $Req
				Case 9
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 10
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case 11
					If $is15_Stance or $is15minus5 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 744 ; Shinobi Blade
			Switch $Req
				Case 9
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 10
					If $is15minus10 or $is20below50 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case 11
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 12
					If $is15minus10 or $is20below50 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case 13
					If $is15_Stance or $is15_Hex or $is20below50 or $isclean Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 797 ; Sunqua Blade
			Switch $Req
				Case 12
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case 13
					If $is20below50 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 792 ; Wicked Blade
			Switch $Req
				Case 10
					If $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 1042 ; Vertebreaker
			Switch $Req
				Case 11
					If $is15minus10 or $is20whexed Then
						Return True
					Else
						Return False
					EndIf
				Case 12
					If $is15minus5 Then
						Return True
					Else
						Return False
					EndIf
				Case 13
					If $is20below50 Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case 1043 ; Zodiacus Sword
			Switch $Req
				Case 11
					If $is20below50 or $isclean Then
						Return True
					Else
						Return False
					EndIf
				Case 12
					If $is15_Stance Then
						Return True
					Else
						Return False
					EndIf
				Case Else
					Return False
			EndSwitch

		Case Else
			Return False
	EndSwitch
EndFunc ;==> IsSwordForCollection

Func IsRareRune($aItem)
    Local $ModStruct = Item_GetModStruct($aItem)
	Local $SupVigor = StringInStr($ModStruct, "C202EA27", 0, 1) ; Mod struct for Sup vigor rune
	Local $minorStrength = StringInStr($ModStruct, "0111E821", 0, 1) ; minor Strength
	Local $minorTactics = StringInStr($ModStruct, "0115E821", 0, 1) ; minor Tactics
	Local $minorExpertise = StringInStr($ModStruct, "0117E821", 0, 1) ; minor Expertise
	Local $minorMarksman = StringInStr($ModStruct, "0119E821", 0, 1) ; minor Marksman
	Local $minorHealing = StringInStr($ModStruct, "010DE821", 0, 1) ; minor Healing
	Local $minorProt = StringInStr($ModStruct, "010FE821", 0, 1) ; minor Prot
	Local $minorDivine = StringInStr($ModStruct, "0110E821", 0, 1) ; minor Divine
	Local $minorSoul = StringInStr($ModStruct, "0106E821", 0, 1) ; minor Soul
	Local $minorFastcast = StringInStr($ModStruct, "0100E821", 0, 1) ; minor Fastcast
	Local $minorInsp = StringInStr($ModStruct, "0103E821", 0, 1) ; minor Insp
	Local $minorEnergy = StringInStr($ModStruct, "010CE821", 0, 1) ; minor Energy
	Local $minorSpawn = StringInStr($ModStruct, "0124E821", 0, 1) ; minor Spawn
	Local $minorScythe = StringInStr($ModStruct, "0129E821", 0, 1) ; minor Scythe
	Local $minorMystic = StringInStr($ModStruct, "012CE821", 0, 1) ; minor Mystic
	Local $minorVigor = StringInStr($ModStruct, "C202E827", 0, 1) ; minor Vigor
	Local $minorVitae = StringInStr($ModStruct, "12020824", 0, 1) ; minor Vitae

	Local $majorFast = StringInStr($ModStruct, "0200E821", 0, 1) ; major Fastcast
	Local $majorVigor = StringInStr($ModStruct, "C202E927", 0, 1) ; major Vigor

	Local $supSmite = StringInStr($ModStruct, "030EE821", 0, 1) ; superior Smite
	Local $supDeath = StringInStr($ModStruct, "0305E821", 0, 1) ; superior Death
	Local $supDom = StringInStr($ModStruct, "0302E821", 0, 1) ; superior Dom
	Local $supAir = StringInStr($ModStruct, "0308E821", 0, 1) ; superior Air
	Local $supChannel = StringInStr($ModStruct, "0322E821", 0, 1) ; superior Channel
	Local $supCommu = StringInStr($ModStruct, "0320E821", 0, 1) ; superior Commu

	If $minorStrength > 0 Or $minorTactics > 0 Or $minorExpertise > 0 Or $minorMarksman > 0 Or $minorHealing > 0 Or $minorProt > 0 Or $minorDivine > 0 Then
	   	Return True
	ElseIf $minorSoul > 0 Or $minorFastcast > 0 Or $minorInsp > 0 Or $minorEnergy > 0 Or $minorSpawn > 0 Or $minorScythe > 0 Or $minorMystic > 0 Then
		Return True
	ElseIf $minorVigor > 0 Or $minorVitae > 0 Or $majorFast > 0 Or $majorVigor > 0 Or $supSmite > 0 Or $supDeath > 0 Or $supDom > 0 Then
		Return True
	ElseIf $supAir > 0 Or $supChannel > 0 Or $supCommu > 0 Or $SupVigor > 0 Then
		Return True
	Else
	   Return False
	EndIf
EndFunc ;==> IsRareRune

Func IsSellableRune($aItem)
    Local $ModStruct = Item_GetModStruct($aItem)
	Local $SupVigor = StringInStr($ModStruct, "C202EA27", 0, 1) ; Mod struct for Sup vigor rune
	Local $minorStrength = StringInStr($ModStruct, "0111E821", 0, 1) ; minor Strength
	Local $minorTactics = StringInStr($ModStruct, "0115E821", 0, 1) ; minor Tactics
	Local $minorExpertise = StringInStr($ModStruct, "0117E821", 0, 1) ; minor Expertise
	Local $minorMarksman = StringInStr($ModStruct, "0119E821", 0, 1) ; minor Marksman
	Local $minorHealing = StringInStr($ModStruct, "010DE821", 0, 1) ; minor Healing
	Local $minorProt = StringInStr($ModStruct, "010FE821", 0, 1) ; minor Prot
	Local $minorDivine = StringInStr($ModStruct, "0110E821", 0, 1) ; minor Divine
	Local $minorSoul = StringInStr($ModStruct, "0106E821", 0, 1) ; minor Soul
	Local $minorFastcast = StringInStr($ModStruct, "0100E821", 0, 1) ; minor Fastcast
	Local $minorInsp = StringInStr($ModStruct, "0103E821", 0, 1) ; minor Insp
	Local $minorEnergy = StringInStr($ModStruct, "010CE821", 0, 1) ; minor Energy
	Local $minorSpawn = StringInStr($ModStruct, "0124E821", 0, 1) ; minor Spawn
	Local $minorScythe = StringInStr($ModStruct, "0129E821", 0, 1) ; minor Scythe
	Local $minorMystic = StringInStr($ModStruct, "012CE821", 0, 1) ; minor Mystic
	Local $minorVigor = StringInStr($ModStruct, "C202E827", 0, 1) ; minor Vigor
	Local $minorVitae = StringInStr($ModStruct, "12020824", 0, 1) ; minor Vitae

	Local $majorFast = StringInStr($ModStruct, "0200E821", 0, 1) ; major Fastcast
	Local $majorVigor = StringInStr($ModStruct, "C202E927", 0, 1) ; major Vigor

	Local $supSmite = StringInStr($ModStruct, "030EE821", 0, 1) ; superior Smite
	Local $supDeath = StringInStr($ModStruct, "0305E821", 0, 1) ; superior Death
	Local $supDom = StringInStr($ModStruct, "0302E821", 0, 1) ; superior Dom
	Local $supAir = StringInStr($ModStruct, "0308E821", 0, 1) ; superior Air
	Local $supChannel = StringInStr($ModStruct, "0322E821", 0, 1) ; superior Channel
	Local $supCommu = StringInStr($ModStruct, "0320E821", 0, 1) ; superior Commu

	If $minorStrength > 0 Or $minorTactics > 0 Or $minorExpertise > 0 Or $minorMarksman > 0 Or $minorHealing > 0 Or $minorProt > 0 Or $minorDivine > 0 Then
		Return True
 	ElseIf $minorSoul > 0 Or $minorFastcast > 0 Or $minorInsp > 0 Or $minorEnergy > 0 Or $minorSpawn > 0 Or $minorScythe > 0 Or $minorMystic > 0 Then
	 	Return True
 	ElseIf $minorVigor > 0 Or $minorVitae > 0 Or $majorFast > 0 Or $majorVigor > 0 Or $supSmite > 0 Or $supDeath > 0 Or $supDom > 0 Then
	 	Return True
	ElseIf $supAir > 0 Or $supChannel > 0 Or $supCommu > 0 Or $SupVigor > 0 Then
		Return True
	Else
	   Return False
	EndIf
EndFunc ;==> IsSellableRune

Func IsSupVigor($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $SupVigor = StringInStr($ModStruct, "C202EA27", 0, 1) ; Mod struct for Sup vigor rune

	If $SupVigor > 0 Then
	   Return True
	Else
	   Return False
	EndIf
EndFunc ;==> IsSupVigor


Func IsRareInsignia($aItem)
    Local $ModStruct = Item_GetModStruct($aItem)
	Local $Sentinel = StringInStr($ModStruct, "FB010824", 0, 1) ; Sentinel insig
	Local $Tormentor = StringInStr($ModStruct, "EC010824", 0, 1) ; Tormentor insig
	Local $WindWalker = StringInStr($ModStruct, "02020824", 0, 1) ; Windwalker insig
	Local $Prodigy = StringInStr($ModStruct, "E3010824", 0, 1) ; Prodigy insig
	Local $Shamans = StringInStr($ModStruct, "04020824", 0, 1) ; Shamans insig
	Local $Nightstalker = StringInStr($ModStruct, "E1010824", 0, 1) ; Nightstalker insig
	Local $Centurions = StringInStr($ModStruct, "07020824", 0, 1) ; Centurions insig
	Local $Blessed = StringInStr($ModStruct, "E9010824", 0, 1) ; Blessed insig

	If $Sentinel > 0 Or $Tormentor > 0 Or $WindWalker > 0 Or $Prodigy > 0 Or $Shamans > 0 Or $Nightstalker > 0 Or $Centurions > 0 Or $Blessed > 0 Then
	   Return True
	Else
	   Return False
	EndIf
EndFunc ;==> IsRareInsignia

Func IsSellableInsignia($aItem)
    Local $ModStruct = Item_GetModStruct($aItem)
	Local $Sentinel = StringInStr($ModStruct, "FB010824", 0, 1) ; Sentinel insig
	Local $Tormentor = StringInStr($ModStruct, "EC010824", 0, 1) ; Tormentor insig
	Local $WindWalker = StringInStr($ModStruct, "02020824", 0, 1) ; Windwalker insig
	Local $Prodigy = StringInStr($ModStruct, "E3010824", 0, 1) ; Prodigy insig
	Local $Shamans = StringInStr($ModStruct, "04020824", 0, 1) ; Shamans insig
	Local $Nightstalker = StringInStr($ModStruct, "E1010824", 0, 1) ; Nightstalker insig
	Local $Centurions = StringInStr($ModStruct, "07020824", 0, 1) ; Centurions insig
	Local $Blessed = StringInStr($ModStruct, "E9010824", 0, 1) ; Blessed insig

	If $Sentinel > 0 Or $Tormentor > 0 Or $WindWalker > 0 Or $Prodigy > 0 Or $Shamans > 0 Or $Nightstalker > 0 Or $Centurions > 0 Or $Blessed > 0 Then
	   Return True
	Else
	   Return False
	EndIf
EndFunc ;==> IsSellableInsignia

Func IsReq8Max($aItem)
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Rarity = Item_GetItemInfoByPtr($aItem, "Rarity")
	Local $MaxDmgOffHand = GetItemMaxReq8($aItem)
	Local $MaxDmgShield = GetItemMaxReq8($aItem)
	Local $MaxDmgSword = GetItemMaxReq8($aItem)

	Switch $Rarity
    Case 2624 ;~ Gold
       Switch $Type
	   Case 12 ;~ Offhand
		  If $MaxDmgOffHand = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 24 ;~ Shield
		  If $MaxDmgShield = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 27 ;~ Sword
		  If $MaxDmgSword = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   EndSwitch
    Case 2623 ;~ Purple?
	   Switch $Type
	   Case 12 ;~ Offhand
		  If $MaxDmgOffHand = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 24 ;~ Shield
		  If $MaxDmgShield = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 27 ;~ Sword
		  If $MaxDmgSword = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   EndSwitch
    Case 2626 ;~ Blue?
	   Switch $Type
	   Case 12 ;~ Offhand
		  If $MaxDmgOffHand = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 24 ;~ Shield
		  If $MaxDmgShield = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 27 ;~ Sword
		  If $MaxDmgSword = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   EndSwitch
	EndSwitch
	Return False
EndFunc ;==> IsReq8Max

Func IsReq7Max($aItem)
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Rarity = Item_GetItemInfoByPtr($aItem, "Rarity")
	Local $MaxDmgOffHand = GetItemMaxReq7($aItem)
	Local $MaxDmgShield = GetItemMaxReq7($aItem)
	Local $MaxDmgSword = GetItemMaxReq7($aItem)

	Switch $Rarity
    Case 2624 ;~ Gold
       Switch $Type
	   Case 12 ;~ Offhand
		  If $MaxDmgOffHand = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 24 ;~ Shield
		  If $MaxDmgShield = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 27 ;~ Sword
		  If $MaxDmgSword = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   EndSwitch
    Case 2623 ;~ Purple?
	   Switch $Type
	   Case 12 ;~ Offhand
		  If $MaxDmgOffHand = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 24 ;~ Shield
		  If $MaxDmgShield = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 27 ;~ Sword
		  If $MaxDmgSword = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   EndSwitch
    Case 2626 ;~ Blue?
	   Switch $Type
	   Case 12 ;~ Offhand
		  If $MaxDmgOffHand = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 24 ;~ Shield
		  If $MaxDmgShield = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   Case 27 ;~ Sword
		  If $MaxDmgSword = True Then
			 Return True
		  Else
			 Return False
		  EndIf
	   EndSwitch
	EndSwitch
	Return False
EndFunc ;==> IsReq7Max

Func GetItemMaxReq8($aItem)
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Dmg = GetItemMaxDmg($aItem)
	Local $Req = GetItemReq($aItem)

	Switch $Type
    Case 12 ;~ Offhand
	   If $Dmg == 12 And $Req == 8 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 24 ;~ Shield
	   If $Dmg == 16 And $Req == 8 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 27 ;~ Sword
	   If $Dmg == 22 And $Req == 8 Then
		  Return True
	   Else
		  Return False
	   EndIf
	EndSwitch
EndFunc ;==> GetItemMaxReq8

Func GetItemMaxReq7($aItem)
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Dmg = GetItemMaxDmg($aItem)
	Local $Req = GetItemReq($aItem)

	Switch $Type
    Case 12 ;~ Offhand
	   If $Dmg == 11 And $Req == 7 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 24 ;~ Shield
	   If $Dmg == 15 And $Req == 7 Then
		  Return True
	   Else
		  Return False
	   EndIf
    Case 27 ;~ Sword
	   If $Dmg == 21 And $Req == 7 Then
		  Return True
	   Else
		  Return False
	   EndIf
	EndSwitch
EndFunc ;==> GetItemMaxReq7

Func IsRegularTome($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
    Case 21796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 21805
	   Return True
	EndSwitch
	Return False
EndFunc ;==> IsRegularTome

Func IsEliteTome($aItem)
	Local $ModelID = Item_GetItemInfoByPtr($aItem, "ModelID")

	Switch $ModelID
    Case 21786, 21787, 21788, 21789, 21790, 21791, 21792, 21793, 21794, 21795
	   Return True ; All Elite Tomes
	EndSwitch
	Return False
EndFunc ;==> IsEliteTome

Func IsFiveE($aItem)
	Local $ModStruct = Item_GetModStruct($aItem)
	Local $t = Item_GetItemInfoByPtr($aItem, "ItemType")
	If (IsIHaveThePower($ModStruct) and $t = 2) Then Return True	; (Nur für Äxte)
EndFunc	;==> IsFiveE

Func IsIHaveThePower($ModStruct)
	Local $EnergyAlways5 = StringInStr($ModStruct, "0500D822", 0 ,1) ; Energy +5
	If $EnergyAlways5 > 0 Then Return True
EndFunc ;==> IsIHaveThePower

Func IsMaxAxe($aItem)
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Dmg = GetItemMaxDmg($aItem)
	Local $Req = GetItemReq($aItem)

	If $Type == 2 and $Dmg == 28 and $Req == 9 Then
		Return True
	Else
		Return False
	EndIf
EndFunc ;==> IsMaxAxe

Func IsMaxDagger($aItem)
	Local $Type = Item_GetItemInfoByPtr($aItem, "ItemType")
	Local $Dmg = GetItemMaxDmg($aItem)
	Local $Req = GetItemReq($aItem)

	If $Type == 32 and $Dmg == 17 and $Req == 9 Then
		Return True
	Else
		Return False
	EndIf
EndFunc ;==> IsMaxDagger

#EndRegion

#Region Checking Guild Hall
;~ Checks to see which Guild Hall you are in and the spawn point
Func CheckGuildHall()
	If Map_GetMapID() == $GH_ID_Warriors_Isle Then
		$WarriorsIsle = True
		Out("Warrior's Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Hunters_Isle Then
		$HuntersIsle = True
		Out("Hunter's Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Wizards_Isle Then
		$WizardsIsle = True
		Out("Wizard's Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Burning_Isle Then
		$BurningIsle = True
		Out("Burning Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Frozen_Isle Then
		$FrozenIsle = True
		Out("Frozen Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Nomads_Isle Then
		$NomadsIsle = True
		Out("Nomad's Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Druids_Isle Then
		$DruidsIsle = True
		Out("Druid's Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Isle_Of_The_Dead Then
		$IsleOfTheDead = True
		Out("Isle of the Dead")
	EndIf
	If Map_GetMapID() == $GH_ID_Isle_Of_Weeping_Stone Then
		$IsleOfWeepingStone = True
		Out("Isle of Weeping Stone")
	EndIf
	If Map_GetMapID() == $GH_ID_Isle_Of_Jade Then
		$IsleOfJade = True
		Out("Isle of Jade")
	EndIf
	If Map_GetMapID() == $GH_ID_Imperial_Isle Then
		$ImperialIsle = True
		Out("Imperial Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Isle_Of_Meditation Then
		$IsleOfMeditation = True
		Out("Isle of Meditation")
	EndIf
	If Map_GetMapID() == $GH_ID_Uncharted_Isle Then
		$UnchartedIsle = True
		Out("Uncharted Isle")
	EndIf
	If Map_GetMapID() == $GH_ID_Isle_Of_Wurms Then
		$IsleOfWurms = True
		Out("Isle of Wurms")
		If $IsleOfWurms = True Then
			CheckIsleOfWurms()
		EndIf
	EndIf
	If Map_GetMapID() == $GH_ID_Corrupted_Isle Then
		$CorruptedIsle = True
		Out("Corrupted Isle")
		If $CorruptedIsle = True Then
			CheckCorruptedIsle()
		EndIf
	EndIf
	If Map_GetMapID() == $GH_ID_Isle_Of_Solitude Then
		$IsleOfSolitude = True
		Out("Isle of Solitude")
	EndIf
EndFunc ;~ Check Guild halls

Func CalculateAverageTime()
	Local $averagetime
	Local $timesum = 0

	for $i = 1 To UBound($AvgTime)
		$timesum += $AvgTime[$i-1]
	Next

	$averagetime = $timesum/UBound($AvgTime)
	$averagetime = Round($averagetime)
	$AvgRunTimeMinutes = Int($averagetime / 60)
	$AvgRunTimeSeconds = Mod($averagetime , 60)
EndFunc ;==> CalculateAverageTime

Func CalculateFastestTime()
	Local $fastesttime
	Local $currtime

	for $i = 1 To UBound($AvgTime)
		$currtime = $AvgTime[$i-1]
		If $i = 1 Then
			$fastesttime = $currtime
		Else
			If $currtime < $fastesttime Then
				$fastesttime = $currtime
			EndIf
		EndIf
	Next

	$RunTimeMinutes = Int($fastesttime / 60)
    $RunTimeSeconds = Mod($fastesttime , 60)
EndFunc ;==> CalculateFastestTime
#EndRegion Calculations


#Region Gui
;~ Description: Print to console with timestamp
Func Out($TEXT)
    GUICtrlSetData($GLOGBOX, GUICtrlRead($GLOGBOX) & @HOUR & ":" & @MIN & " - " & $TEXT & @CRLF)
	GUICtrlSetFont(-1, 12, 400, 0, "Times New Roman")
    _GUICtrlEdit_Scroll($GLOGBOX, $SB_SCROLLCARET)
    _GUICtrlEdit_Scroll($GLOGBOX, $SB_LINEUP)
    ;UpdateLock()
EndFunc   ;==>OUT
#EndRegion
