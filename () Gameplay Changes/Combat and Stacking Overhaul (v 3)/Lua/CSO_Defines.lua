-- Combat & Stacking Overhaul Defines
-- Author: Gedemon
-- DateCreated: 7/31/2013 10:29 PM
--------------------------------------------------------------

print("Loading Combat & Stacking Overhaul Defines...")
print("-------------------------------------")

-------------------------------------------------------------------------------------------------------
-- DEBUG Output
-------------------------------------------------------------------------------------------------------
PRINT_DEBUG =			true	-- Dprint Lua output to firetuner ON/OFF
DEBUG_DB_UTILS =		false	-- Dprint Lua output for "get civ for player" functions
DEBUG_PERFORMANCE =		true	-- always show loading/save time of tables

-------------------------------------------------------------------------------------------------------
-- Initialize for SaveUtils
-------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false
include( "ShareData.lua" )
include( "SaveUtils" )
MY_MOD_NAME = "b42e2fd3-b0eb-46ce-a516-e72e1c635cf3"

DEFAULT_SAVE_KEY =			"2,0"	-- "0,0" used by HSD -- "1,1" used by Revolution -- "0,1" used by Cultural diffusion -- "1,0" used by Another History

----------------------------------------------------------------------------------------------------------------------------
-- Global Data Tables
----------------------------------------------------------------------------------------------------------------------------

-- Saved
g_CombatsLog = {}


--------------------------------------------------------------
-- player ID
--------------------------------------------------------------

LOCAL_PLAYER = Game.GetActivePlayer()
BARBARIAN_PLAYER = GameDefines.MAX_PLAYERS-1

----------------------------------------------------------------------------------------------------------------------------
-- Combat types Enum
----------------------------------------------------------------------------------------------------------------------------

MELEE =			0	-- normal combat
RANGED =		1	-- ranged attack
SUBATTACK =		2	-- submarines attacking
SUBHUNT =		3	-- submarines attacked
AIRBOMB =		4	-- Air bombing
INTERCEPT =		5	-- Air bombing with interception
DOGFIGHT =		6	-- Airsweep
CITYBOMB =		7	-- Ranged attack on city
CITYASSAULT =	8	-- Melee attack on city
NAVALCOUNTER =	9	-- Naval counter-attack
GRDINTERCEPT =	10	-- Interception by ground (sea, land) unit


----------------------------------------------------------------------------------------------------------------------------
-- Moves
----------------------------------------------------------------------------------------------------------------------------
MOVE_DENOMINATOR = GameDefines.MOVE_DENOMINATOR

----------------------------------------------------------------------------------------------------------------------------
-- Rules
----------------------------------------------------------------------------------------------------------------------------
MIN_HP_LEFT_BEFORE_ESCAPING_CITY	= 4 -- under that value of predicted HP left to a city after a combat that is starting, units will try to escape a city
MAX_PERCENT_HP_LOSS_ESCAPE			= 50 -- Maximum percentage of remaining HP loss when retreating from a plot.
MIN_PERCENT_HP_LOSS_ESCAPE			= 25 -- Minimum percentage of remaining HP loss when retreating from a plot.