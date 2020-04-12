-- Combat & Stacking Overhaul Main File
-- Author: Gedemon
-- DateCreated: 7/31/2013 10:29 PM
--------------------------------------------------------------

print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
print("+++++++++++++++++++++++++++++++++++++++++++++++++ Combat & Stacking Overhaul script started... +++++++++++++++++++++++++++++++++++++++++++++++")
print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
--------------------------------------------------------------

include ("CSO_Defines")
include ("CSO_Debug")
include ("PlotIterators") -- by whoward69
include ("CSO_Utils")
include ("CSO_Functions")

--------------------------------------------------------------

local bWaitBeforeInitialize = true
local bDebug = true

local endTurnTime = 0
local startTurnTime = 0

function NewTurnSummary()
	local year = Game.GetGameTurnYear()
	local turn = Game.GetGameTurn()
	startTurnTime = os.clock()
	print("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	print("---------------------------------------------------------------------------------------- NEW TURN -----------------------------------------------------------------------------------------------------")
	print("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	Dprint ("Game year = " .. year .. ", Game turn = " .. turn)
	if endTurnTime > 0 then
		print ("AI turn execution time = " .. startTurnTime - endTurnTime )	
	end
	print("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
end

function EndTurnsummary()
	endTurnTime = os.clock()
	print("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	print ("Your turn execution time = " .. endTurnTime - startTurnTime )
	print("-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
end


-----------------------------------------
-- Initializing functions
-----------------------------------------

-- functions to call at beginning of each turn
function OnNewTurn()
	Dprint("Calling OnNewTurn()...", bDebug)
	Dprint("-------------------------------------", bDebug)
	--NewTurnSummary()
end

-- functions to call at end of each turn
function OnEndTurn()
	Dprint("Calling OnEndTurn()...", bDebug)
	Dprint("-------------------------------------", bDebug)
	--EndTurnsummary()
end

-- functions to call once at end of 1st turn
function OnFirstTurnEnd()
	Dprint("End of First turn detected, calling OnFirstTurnEnd() ...", bDebug)
	Dprint("-------------------------------------", bDebug)
	--
	--
	Events.ActivePlayerTurnEnd.Remove(OnFirstTurnEnd)
end


-- functions to call after loading this file when game is launched for the first time
function OnFirstTurn()
	Dprint("Calling OnFirstTurn() ...", bDebug)
	Dprint("-------------------------------------", bDebug)
	--
	--NewTurnSummary()
end

-- functions to call ASAP after loading a game
function OnLoading()
	Dprint("Calling OnLoading() ...", bDebug)
	Dprint("-------------------------------------", bDebug)
	--
	ShareGlobalTables()
	InitializeCitiesStackingLimit()
	InitializePlayerUnits()
	--NewTurnSummary()
end

-- functions to call after game initialization (DoM screen button "Begin your journey" appears)
function OnGameInit ()
	if not UI:IsLoadedGame() then
		Dprint ("Game is initialized, calling OnGameInit() for new game ...", bDebug)
		Dprint("-------------------------------------", bDebug)
		--
	else
		Dprint ("Game is initialized, calling OnGameInit() for loaded game ...", bDebug)
		Dprint("-------------------------------------", bDebug)
		--
		--
	end
end

-- functions to call after entering game (DoM screen button pushed)
function OnEnterGame()
	Dprint ("Calling OnEnterGame() ...", bDebug)
	Dprint("-------------------------------------", bDebug)
	--
	--
end

-- Initialize when AH is loaded
if ( bWaitBeforeInitialize ) then
	bWaitBeforeInitialize = false
	if not UI:IsLoadedGame() then
		OnFirstTurn()
		Events.ActivePlayerTurnEnd.Add(OnFirstTurnEnd)
	else
		OnLoading()
	end
end

-- Add functions to corresponding events
Events.ActivePlayerTurnStart.Add( OnNewTurn )
Events.ActivePlayerTurnEnd.Add( OnEndTurn )
Events.SequenceGameInitComplete.Add( OnGameInit )
Events.LoadScreenClose.Add( OnEnterGame )
-- Add functions to corresponding Game Events
--GameEvents.PlayerDoTurn.Add(ShowPlayerInfo)
GameEvents.PlayerDoTurn.Add(SetPlayerCitiesStackingLimit)
GameEvents.PlayerDoTurn.Add( ReinitUnits )
GameEvents.PlayerCityFounded.Add(SetStackingLimitOnNewCity)
GameEvents.CombatResult.Add( CombatResult )
GameEvents.CombatEnded.Add( CombatEnded )
GameEvents.CombatResult.Add( NavalCounterAttack )
GameEvents.CombatResult.Add( CounterFire )
GameEvents.TacticalAILaunchUnitAttack.Add(TacticalAILaunchUnitAttack)
GameEvents.PushingMissionTo.Add(PushingMissionTo)

-----------------------------------------
-----------------------------------------

print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
print("+++++++++++++++++++++++++++++++++++++++++++++++++ Combat & Stacking Overhaul script loaded ! ++++++++++++++++++++++++++++++++++++++++++++++++")
print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

