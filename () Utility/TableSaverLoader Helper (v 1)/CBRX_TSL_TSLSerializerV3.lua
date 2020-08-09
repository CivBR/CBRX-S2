-- TSLSerializerV3
-- TSL Serializer Client File
iClientVersion = 3
-- Author: DarkScythe
-- DateCreated: 1/14/2015 3:47:04 PM
--------------------------------------------------------------
--print("Loading TSL Serializer Client...")
--print("TSL Serializer Client Version: " .. tostring(iClientVersion))
--------------------------------------------------------------
-- IMPORTANT:
-- THIS FILE MUST BE RENAMED.
-- Step-by-step instructions at the bottom of this text block.
--------------------------------------------------------------
--[[
WHAT THIS IS:

This script is a work-around for the game's inherent limitation of the input handler system interfering with TableSaverLoader across multiple mods / contexts.

Mods which use TableSaverLoader's Lua-only savegame interception system require the use of an input handler hooked up to its current context to catch game saves.

Unfortunately, only the last mod / context to load this input handler will be able to do so, and manual saves will only save that particular mod's data, leaving all other mods' data unsaved until the next autosave.
--------------------------------------------------------------
WHAT THIS DOES:

This script remedies the input handler limitation by invoking the use of LuaEvents to trigger all associated mods to execute a TableSave() from their own context.
--------------------------------------------------------------
HOW IT WORKS:

This is the "client" file, which communicates with the "Master" defined in the TSLSerializerCore Lua file. It hooks up with TableSaverLoader, and provides a way to receive the LuaEvent from the Master in order to conduct a TableSave() even when this context is not the active one.

It is important that this file be renamed into something unique for each mod or context it will be used in, as the client itself must be within the same context as the parent.
--------------------------------------------------------------
USAGE NOTES:

This file MUST be renamed to something unique.
It must then be included into your main Lua script following two conditions:
	1. It must come AFTER TableSaverLoader has been loaded, AND have had its global tables defined.
	2. It must come BEFORE the first Events.LoadScreenClose event.

For example:
	...
	include("TableSaverLoader016.lua")
	gMyGlobalTable = {}
	include("ModTSLSerializer.lua")
	...
--------------------------------------------------------------
'tableRoot' and 'tableName' MUST be defined here, or before this file is included.

'tableRoot' will be the base global table your mod uses.

For example, if you use the global MapModData table:
	MapModData.gMyModTable
	MapModData.gT.gMyModData

Simple global Lua tables are also valid:
	gMyModDataTable = {}

If you have assigned to something to reference that table instead, you may also use it.
	MapModData.gMyModTable
	gMyModTable = MapModData.gMyModTable
	gTable = gMyModDataTable

For these examples, these are valid tables to define tableRoot as:
	tableRoot = MapModData.gMyModTable
	tableRoot = MapModData.gT.gMyModData
	tableRoot = gMyModTable
	tableRoot = gTable

The only requirement is that it points to your base/root table which contains all the data, and all the sub-tables you wish to save. This is no different from what you normally define into TableSave().

AVOID USING 'MapModData' or 'MapModData.gT'!

These are default tables (the latter being a TSL-specific example) and may contain a whole lot of unrelated data which may cause weird issues if saved all into your table. As the client registers the defined table with the Master, the Master will warn you if you try to do this.
--------------------------------------------------------------
'tableName' must be a string, and will be the unique name for the table when written into the savegame database. Avoid duplicates! The Master will warn you if a duplicate tableName is submitted.
--------------------------------------------------------------
This script introduces a new LuaEvent which effectively replaces the default TableSave():
	LuaEvents.TSLTableSave()

It sends a notice to the Master to trigger all contexts to conduct a TableSave() immediately.

The biggest usage for this is with TSL's savegame intercept functions, which have already been included. Placement of this LuaEvent hook should not be necessary for full function of this component. Everything is already set up.

All manual saves done by your script, as well as autosave need not be modified, although there is no harm in using the above LuaEvents replacement.
--------------------------------------------------------------
USAGE INSTRUCTIONS / HOW TO USE:

1. Rename this file to something unique.
2. Import this file, and TSLSerializerCore into VFS.
3. include() this file into your main Lua script.
	- Make sure it comes AFTER TableSaverLoader
	- Make sure the global tables have already been defined.
4. Define 'tableRoot' and 'tableName' below.
	- Refer to above section for specifics about what they need to be

IF INSTALLING THIS COMPONENT AND TABLESAVERLOADER FOR THE FIRST TIME
5a. Create an OnModLoaded() function, or equivalent.
	- This function's only purpose is to call TableLoad() somewhere after your basic table structure has been defined, so that it can load the data properly from a savegame.
	- This must come before the first TableSave() event.
	- Please see Pazyryk's instructions for TableSaverLoader, or the forum thread for this component for details.

IF INSTALLING THIS COMPONENT WITH AN EXISTING TABLESAVERLOADER SETUP
5b. Delete any existing TSL hook-up code, EXCEPT for OnModLoaded() or its equivalent
	- At the minimum, SaveGameIntercept() and QuickSaveIntercept() need to be removed, or commented out. Modified versions of those functions are included in this script.
	- Every other TSL hook-up function has also been included, so it may duplicate autosaves if not removed.
	- The only function not duplicated/included is the OnModLoaded() (or equivalent) function, as different mods have different ways of defining this.
--------------------------------------------------------------
VERSION HISTORY:

v3 (Mar 28, 2015)
	- Fixed an issue causing the save game hotkeys to not work properly
	- Added version checking to the Serializer
	- Removed the need to delete tableRoot and tableName if they were already defined
	- Hooked up the debug mode so it actually does something
	- Switched standard save operation method with the previously-experimental debug method for speed; Old method is activated by toggling MapModData.TSLMaster.debugMode to true
v2 (Jan 14, 2015)
	- Separated the code into 'Core' and 'Client' files
v1 (Jan 13, 2015)
	- Initial private beta testing release

--------------------------------------------------------------
REMINDER:

'tableRoot' and 'tableName' MUST be defined!

To define them in this file, change the values to the RIGHT side of the equal sign (=) such as:
	
	tableRoot = myGlobalTable
	tableName = "MyUniqueTableName"

If they have already been defined as GLOBALS prior to including this file, NO CHANGES ARE NECESSARY.
For more examples, please see the previous sections.

--]]
--------------------------------------------------------------
-- MODIFY ONLY THESE TWO LINES
-- LEAVE ALONE IF THESE TWO VARIABLES ARE ALREADY DEFINED
--------------------------------------------------------------

tableRoot = tableRoot
tableName = tableName

--------------------------------------------------------------
-- NO FURTHER CHANGES ARE NECESSARY
--------------------------------------------------------------

assert(tableRoot and type(tableRoot) == "table", "Error! tableRoot is not defined properly, or is not a table! Received: [" .. type(tableRoot) .. "] Aborting...")
assert(tableName and type(tableName) == "string", "Error! tableName is not defined properly, or is not a string! Received: [" .. type(tableName) .. "] Aborting...")

MapModData.TSLMaster = MapModData.TSLMaster or {}
TSLMaster = MapModData.TSLMaster
iTSLIndex = TSLMaster.tableIndex or 1

-- Load Core TSL Serializer Components
include("TSLSerializerCoreV3.lua")

-- Initiating client code
if TSLMaster.isActive then
	--print("TSL Master is active, retrieving ID...")
	LuaEvents.GetTSLIndex()
	iTSLIndex = TSLMaster.tableIndex
	--print("Received ID of " .. tostring(iTSLIndex) .. " from TSL Master.")
end

local function TSLSaveTable()
	local iCurrentMasterVersion = TSLMaster.verNum
	local bDebug = TSLMaster.debugMode or false
	if iCurrentMasterVersion >= iClientVersion then
		if bDebug == true and TSLMaster.processTableID == iTSLIndex or bDebug == false then
			if iCurrentMasterVersion > iClientVersion then
				print("WARNING: TSL Serializer component for '" .. tostring(tableName) .. "' is out of date! Updating is recommended!")
			end
			--print("Table save #" .. tostring(iTSLIndex) .. " for '" .. tostring(tableName) .. "' initiated from TSL Master.")
			TableSave(tableRoot, tableName)
		end
	end
end

-- Add new LuaEvent listener to execute TableSave() when triggered by the TSL Master
LuaEvents.TriggerTSLTableSave.Add(TSLSaveTable)

-- Register the global table with the TSL Master
LuaEvents.RegisterTSLTable(tableRoot, tableName)

--------------------------------------------------------------
-- TableSaverLoader Hookup Code
--------------------------------------------------------------

-- Modified SaveGameIntercept to use the new LuaEvent
function SaveGameIntercept()
	LuaEvents.TSLTableSave()
	UIManager:QueuePopup(ContextPtr:LookUpControl("/InGame/GameMenu/SaveMenu"), PopupPriority.SaveMenu)
end

-- Modified QuickSaveIntercept to use the new LuaEvent
function QuickSaveIntercept()
	LuaEvents.TSLTableSave()
	UI.QuickSave()
end

-- TableSaverLoader Autosave Interception Hookup

local function OnAIProcessingEndedForPlayer(iPlayer)
	if iPlayer == 63 then
		if Game.GetGameTurn() % autoSaveFreq == 0 then
			TableSave(tableRoot, tableName)
		end
	end
end

Events.AIProcessingEndedForPlayer.Add(OnAIProcessingEndedForPlayer)

--------------------------------------------------------------
-- All functions loaded.
--------------------------------------------------------------
print("TSL Serializer version " .. tostring(iClientVersion) .. " loaded successfully.")