-- CityNearbyMapDatas
-- Author: LeeS
-- DateCreated: 8/02/2016
--[[
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Notes to users:


1)	This file should be added to your mod and set as ImportIntoVFS=true
2)	This file should never be used in the ModBuddy Content Tab as an "InGameUIAddin"
3)	This file should be included into your main lua-file via statement:

		include("CityNearbyMapDatasV4.lua")

	a)	See how this is done in the example Main Lua file called "Lua Script1.lua"
	b)	Note that file "Lua Script1.lua" IS set-up in modbuddy as an "InGameUIAddin"


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Notes to self:


1)	Finish un-done notes on how to use some of the functions, where needed.
	Some functions are not user-called. They are called by the user-called functions. Some documentation wil be helpful to self for later debug if required.



xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

			MAKE NO CHANGES BELOW THIS LINE !!!

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
]]--





--the following is for debug purposes
--it and all printing statements would be removed from a final version
------------------------------------

local bPrintDebug = true	--this is here in case I need to make copious debugs.
function PrintMessagingToLog(sMessage)
	if bPrintDebug then
		print(sMessage)
	end
end


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<-- toolkit information to make the rest of the code run more efficiently -->xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

local tArtifactResourcesCityNearbyMapDatas = {[GameInfoTypes.RESOURCE_ARTIFACTS] = "artifact", [GameInfoTypes.RESOURCE_HIDDEN_ARTIFACTS] = "hidden artifact"}
local tResouceValidImprovementsCityNearbyMapDatas = {}
local tImprovementValidResoucesCityNearbyMapDatas = {}
local tPillageableImprovements = {}
local tRelevantImprovements = {}
local tAllDomains = {}
local iAllDomainsCount = 0
for row in GameInfo.Improvement_ResourceTypes() do
	if not tResouceValidImprovementsCityNearbyMapDatas[GameInfoTypes[row.ResourceType]] then
		tResouceValidImprovementsCityNearbyMapDatas[GameInfoTypes[row.ResourceType]] = {[GameInfoTypes[row.ImprovementType]] = true}
	else
		tResouceValidImprovementsCityNearbyMapDatas[GameInfoTypes[row.ResourceType]][GameInfoTypes[row.ImprovementType]] = true
	end
	if not tImprovementValidResoucesCityNearbyMapDatas[GameInfoTypes[row.ImprovementType]] then
		tImprovementValidResoucesCityNearbyMapDatas[GameInfoTypes[row.ImprovementType]] = {[GameInfoTypes[row.ResourceType]] = true}
	else
		tImprovementValidResoucesCityNearbyMapDatas[GameInfoTypes[row.ImprovementType]][GameInfoTypes[row.ResourceType]] = true
	end
end
for row in GameInfo.Domains() do
	iAllDomainsCount = iAllDomainsCount + 1
	tAllDomains[row.ID] = true
end
for Improvement in DB.Query("SELECT ID, Description, Type FROM Improvements WHERE DestroyedWhenPillaged = 0 AND PillageGold > 0") do
	tPillageableImprovements[Improvement.ID] = { Type=Improvement.Type, Description=Locale.ConvertTextKey(Improvement.Description)}
end
--for Improvement in DB.Query("SELECT ID, Description, Type FROM Improvements WHERE BarbarianCamp = 0 AND Goody = 0 AND PromptWhenComplete = 0 AND Type != 'IMPROVEMENT_CITADEL' AND Type != 'IMPROVEMENT_CITY_RUINS' AND Type != 'IMPROVEMENT_FORT'") do
for Improvement in DB.Query("SELECT ID, Description, Type FROM Improvements WHERE BarbarianCamp = 0 AND Goody = 0 AND PromptWhenComplete = 0 AND Type != 'IMPROVEMENT_CITY_RUINS'") do
	tRelevantImprovements[Improvement.ID] = { Type=Improvement.Type, Description=Locale.ConvertTextKey(Improvement.Description)}
end





if bPrintDebug  then
	print("Data for table tPillageableImprovements is:")
	for iImprovement,DataTable in pairs(tPillageableImprovements) do
		print("Improvement ID# " .. iImprovement .. " (" .. DataTable.Type .. ": " .. DataTable.Description .. ") can be pillaged")
	end
	print("Data for table tRelevantImprovements is:")
	for iImprovement,DataTable in pairs(tRelevantImprovements) do
		print("Improvement ID# " .. iImprovement .. " (" .. DataTable.Type .. ": " .. DataTable.Description .. ") gives yields")
	end
end



--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<-- toolkit functions to make the rest of the code run more efficiently -->xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--------------------------------------------------------------
-- ItemIsInTable
-- Author: LeeS
-- returns true/false as to whether 'DataItem' is a "value" in 'tTable'
-- this function is only useful when the k,v pairs are in an array format of k=integer,v=data
--------------------------------------------------------------
function ItemIsInTable(tTable,DataItem)
	for iTableItem,TableDataValue in pairs(tTable) do
		if TableDataValue == DataItem then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------------

function SortForValidSettings(tAllowed, tPassed)
	local bIsAnySettingValid, tSettings = false, {}
	for k,Setting in pairs(tPassed) do
		if (Setting ~= nil) and tAllowed[Setting] then
			bIsAnySettingValid = true
			tSettings[Setting]=tAllowed[Setting]
		end
	end
	if not bIsAnySettingValid then
		tSettings = tAllowed
	end
	return bIsAnySettingValid, tSettings
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--[[

	UnitCountTypes



	--following lines are here for my easier reference
	tCityNearbyDatas.Units = { PlayerUnits = {}, PlayerUnitCount = 0, BarbarianCount = 0, BarbarianUnits = {}, EnemyCount = 0, EnemyUnits = {},
					AdversaryCount = 0, AdversaryUnits = {}, BarbarianInvisibleCount = 0, BarbarianInvisibleUnits = {},
					EnemyInvisibleCount = 0, EnemyInvisibleUnits = {}, AdversaryInvisibleCount = 0, AdversaryInvisibleUnits = {} }

]]--
-----------------------------------------------------------------------------------------------------------------------------------------------

function UnitCountTypes(tTable, sReturnType, sUnitCountKey, sUnitTableKey, tAllowedSettings, tPassedSettings)
	local iCountOfUnits = 0
	local tValidUnitObjects = {}
	-------------------------------------------------------------------------------------------------
	--decide what to count
	-------------------------------------------------------------------------------------------------
	local bValidCollectionSettings, tDataCollections = SortForValidSettings(tAllowedSettings, tPassedSettings)
	local bCountCombat = ((tDataCollections["Combat"] ~= nil) and true or false)
	local bCountCivilian = ((tDataCollections["Civilian"] ~= nil) and true or false)
	local bCountBoth = ((bCountCombat and bCountCivilian) and true or false)
	local bCountNiether = ((not bCountCombat and not bCountCivilian) and true or false)
	local iNumberDomains = 0
	local tRequiredDomains = {}
	for sKey,sValue in pairs(tDataCollections) do
		if sKey == "Land" then
			iNumberDomains = iNumberDomains + 1
			tRequiredDomains[GameInfoTypes[sValue]]=true
		elseif sKey == "Sea" then
			iNumberDomains = iNumberDomains + 1
			tRequiredDomains[GameInfoTypes[sValue]]=true
		elseif sKey == "Air" then
			iNumberDomains = iNumberDomains + 1
			tRequiredDomains[GameInfoTypes[sValue]]=true
		elseif sKey == "Hover" then
			iNumberDomains = iNumberDomains + 1
			tRequiredDomains[GameInfoTypes[sValue]]=true
		elseif sKey == "Immobile" then
			iNumberDomains = iNumberDomains + 1
			tRequiredDomains[GameInfoTypes[sValue]]=true
		end
	end
	if iNumberDomains == 0 then
		tRequiredDomains = tAllDomains
	end
	if bCountBoth and (iNumberDomains == iAllDomainsCount) then
		if sReturnType == "Counts" then
			return tTable.Units[sUnitCountKey]
		else
			return tTable.Units[sUnitTableKey]
		end
	end
	for KeyNum, pUnit in pairs(tTable.Units[sUnitTableKey]) do
		if tRequiredDomains[pUnit:GetDomainType()] then
			if bCountCombat and pUnit:IsCombatUnit() then
				iCountOfUnits = iCountOfUnits + 1
				table.insert(tValidUnitObjects, pUnit)
			elseif bCountCivilian and not pUnit:IsCombatUnit() then
				iCountOfUnits = iCountOfUnits + 1
				table.insert(tValidUnitObjects, pUnit)
			elseif bCountNiether then
				iCountOfUnits = iCountOfUnits + 1
				table.insert(tValidUnitObjects, pUnit)
			end
		end
	end
	if sReturnType == "Counts" then
		return iCountOfUnits
	else
		return tValidUnitObjects
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------

function GetUnitIDSThatMatch(sUnitType)
	local sDesignationMethod = "NONE"
	local tUnitsToConsider = {}
	if sUnitType ~= nil then
		for row in GameInfo.UnitClasses("Type='" .. sUnitType .. "'") do
			sDesignationMethod = "Class"
		end
		if sDesignationMethod == "NONE" then
			for row in GameInfo.Units("Type='" .. sUnitType .. "'") do
				tUnitsToConsider[row.ID] = Locale.ConvertTextKey(row.Description)
				sDesignationMethod = "Unit"
			end
		elseif sDesignationMethod == "Class" then
			for row in GameInfo.Units("Class='" .. sUnitType .. "'") do
				tUnitsToConsider[row.ID] = Locale.ConvertTextKey(row.Description)
			end
		end
	end
	if sDesignationMethod == "NONE" then
		local sLongMessage = "AreEnemyUnitsOfTypeNearby: No matching Unit or Unit-Class Was found anywhere within the game's Database to: [COLOR_NEGATIVE_TEXT] " .. sUnitType .. " [ENDCOLOR]"
		local sShortMessage = "[COLOR_NEGATIVE_TEXT]Invalid Data for AreEnemyUnitsOfTypeNearby[ENDCOLOR]"
		Players[0]:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], sShortMessage .. "[NEWLINE][NEWLINE]" .. sLongMessage, sShortMessage)
		print(sLongMessage)
		print(" ")
		print(" ")
	end
	return tUnitsToConsider
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx< Handler Routines to Simplify Data Extraction >xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function FilterTableContents(tCurrentTable, tAccumulatedTable)
	local tNewTable = {}
	for k,v in pairs(tCurrentTable) do
		if not ItemIsInTable(tAccumulatedTable,v) then
			table.insert(tNewTable, v)
			table.insert(tAccumulatedTable, v)
		end
	end
	return tNewTable, tAccumulatedTable
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function IsResourceRevealed(iPlayer, iResourceID)
	local iRequiredTech = GameInfoTypes[GameInfo.Resources[iResourceID].TechReveal]
	if (iRequiredTech ~= nil) and (iRequiredTech ~= -1) then
		local pPlayer = Players[iPlayer]
		local iTeam = pPlayer:GetTeam()
		local pTeam = Teams[iTeam]
		return pTeam:IsHasTech(iRequiredTech)
	end
	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetCityImprovementPlots(tTable, iImprovementID, sDataType)
	local tReturnTable = {}
	if tTable.Improvements[iImprovementID] then
		if (tTable.Improvements[iImprovementID][sDataType] ~= nil) then
			return tTable.Improvements[iImprovementID][sDataType]
		end
	end
	return tReturnTable
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetNumCityWorkingImprovementPlots(tTable, iImprovementID)
	if tTable.Improvements[iImprovementID] then
		return tTable.Improvements[iImprovementID].NumPlotsWorkedByCity
	end
	return 0
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function DoesImprovementExistNearCity(tTable, iImprovementID)
	if tTable.Improvements[iImprovementID] then
		return true
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function DoUnpillagedImprovementsExistNearCity(tTable, iImprovementID)
	if tTable.Improvements[iImprovementID] then
		return (tTable.Improvements[iImprovementID].NumPlotsCounted > tTable.Improvements[iImprovementID].NumPillagedPlots)
	end
	return false
end

-- Compatibility with V1 typo
function DoUnpillagedImprovmeentsExistNearCity(tTable, iImprovementID)
	return DoUnpillagedImprovmentsExistNearCity(tTable, iImprovementID)
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function CalculateCityImprovementPlotsWithResource(tTable, iImprovementID, iResourceID, sReturnType, tAllowedSettings, tSettings)
	local iDefaultCount, iNumCalculatedPlots, tTableToReturn = 0, 0, {}
	local bValidCollectionSettings, tDataCollections = SortForValidSettings(tAllowedSettings, tSettings)
	local bCountOnlyOwned = ((tDataCollections["Owned"] ~= nil) and true or false)
	local bCountOnlyNonPillaged = ((tDataCollections["Unpillaged"] ~= nil) and true or false)
	local bCountOnlyIfResourceRevealed = ((tDataCollections["ResourceIsRevealed"] ~= nil) and true or false)
	local bCountOnlyWorked = ((tDataCollections["Worked"] ~= nil) and true or false)
	local iPlayer = tTable.OurCity:GetOwner()
	local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	if bCountOnlyIfResourceRevealed then
		if not IsResourceRevealed(iPlayer, iResourceID) then
			if sReturnType == "Counts" then
				return iDefaultCount
			else
				return tTableToReturn
			end
		end
	end
	if tTable.Improvements[iImprovementID] then
		local tCountingTable = {}
		if bCountOnlyWorked then
			if bCountOnlyNonPillaged then
				tCountingTable = tTable.Improvements[iImprovementID].WorkedPlotsThatAreNotPillaged
			else
				tCountingTable = tTable.Improvements[iImprovementID].WorkedPlots
			end
		else
			for k,pPlot in pairs(tTable.Improvements[iImprovementID].Plots) do
				if bCountOnlyOwned then
					if (pPlot:GetOwner() == iPlayer) then
						if bCountOnlyNonPillaged then
							if not pPlot:IsImprovementPillaged() then
								table.insert(tCountingTable, pPlot)
							end
						else
							table.insert(tCountingTable, pPlot)
						end
					end
				else
					if bCountOnlyNonPillaged then
						if not pPlot:IsImprovementPillaged() then
							table.insert(tCountingTable, pPlot)
						end
					else
						table.insert(tCountingTable, pPlot)
					end
				end
			end
		end
		for k,pPlot in pairs(tCountingTable) do
			if pPlot:GetResourceType() == iResourceID then
				iNumCalculatedPlots = iNumCalculatedPlots + 1
				table.insert(tTableToReturn, pPlot)
			end
		end
		if sReturnType == "Counts" then
			return iNumCalculatedPlots
		else
			return tTableToReturn
		end
	end
	--data was not collected, return 0 or {}
	if sReturnType == "Counts" then
		return iDefaultCount
	else
		return tTableToReturn
	end
end
function GetCityImprovementPlotswithResource(tTable, iImprovementID, iResourceID, ...)
	local tAllowedSettings = { ["Owned"] = "Owned", ["Unpillaged"] = "Unpillaged", ["ResourceIsRevealed"] = "ResourceIsRevealed", ["Worked"] = "Worked" }
	return CalculateCityImprovementPlotsWithResource(tTable, iImprovementID, iResourceID, "Table", tAllowedSettings, {...})
end
function GetNumCityImprovementPlotsWithResource(tTable, iImprovementID, iResourceID, ...)
	local tAllowedSettings = { ["Owned"] = "Owned", ["Unpillaged"] = "Unpillaged", ["ResourceIsRevealed"] = "ResourceIsRevealed", ["Worked"] = "Worked" }
	return CalculateCityImprovementPlotsWithResource(tTable, iImprovementID, iResourceID, "Counts", tAllowedSettings, {...})
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetImprovementPlotsWithResources(tTable, iImprovementID)
	local tReturnTable = {}
	if tTable.Improvements[iImprovementID] then
		tReturnTable = tTable.Improvements[iImprovementID].PlotsWithCorrectResources
		for k,pPlot in pairs(tTable.Improvements[iImprovementID].PlotsWithInCorrectResources) do
			table.insert(tReturnTable, pPlot)
		end
	end
	return tReturnTable
end


-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetCityResourcePlots(tTable, iResourceID, sDataType)
	local tReturnTable = {}
	if tTable.Resources[iResourceID] then
		if (tTable.Resources[iResourceID][sDataType] ~= nil) then
			return tTable.Resources[iResourceID][sDataType]
		end
	end
	return tReturnTable
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function DoesResourceExistNearCity(tTable, iResourceID)
	if tTable.Resources[iResourceID] then
		return true
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function CityIsWorkingResourcePlots(tTable, iResourceID)
	if tTable.Resources[iResourceID] then
		return (tTable.Resources[iResourceID].NumPlotsWorkedByCity > 0)
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetNumCityWorkingResourcePlots(tTable, iResourceID)
	if tTable.Resources[iResourceID] then
		return tTable.Resources[iResourceID].NumPlotsWorkedByCity
	end
	return 0
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetNumCityUnclaimedResourcePlots(tTable, iResourceID)
	if tTable.Resources[iResourceID] then
		return tTable.Resources[iResourceID].NumUnclaimedPlots
	end
	return 0
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function EnemyUnitsAreNearCity(tTable, sEnemyType, sMustBeVisible)
	local bMustBeVisible = ((sMustBeVisible ~= nil) and (sMustBeVisible == "MustBeVisible"))
	if sEnemyType == "Barbarians" then
		if bMustBeVisible then
			return (tTable.Units.BarbarianCount > 0)
		else
			return ((tTable.Units.BarbarianCount + tTable.Units.BarbarianInvisibleCount) > 0)
		end
	elseif (sEnemyType == "Players") then
		if bMustBeVisible then
			return (tTable.Units.EnemyCount > 0)
		else
			return ((tTable.Units.EnemyCount + tTable.Units.EnemyInvisibleCount) > 0)
		end
	elseif (sEnemyType == "Any") then
		if bMustBeVisible then
			return ((tTable.Units.BarbarianCount + tTable.Units.EnemyCount) > 0)
		else
			return ((tTable.Units.BarbarianCount + tTable.Units.BarbarianInvisibleCount + tTable.Units.EnemyCount + tTable.Units.EnemyInvisibleCount) > 0)
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function CountPlayerUnitsNearCity(tTable, ...)
	local tAllowedSettings = {["Combat"] = "Combat", ["Civilian"] = "Civilian", ["Land"] = "DOMAIN_LAND", ["Sea"] = "DOMAIN_SEA",
					["Air"] = "DOMAIN_AIR", ["Hover"] = "DOMAIN_HOVER", ["Immobile"] = "DOMAIN_IMMOBILE" }
	return UnitCountTypes(tTable, "Counts", "PlayerUnitCount", "PlayerUnits", tAllowedSettings, {...})
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetPlayerUnitsNearCity(tTable, ...)
	local tAllowedSettings = {["Combat"] = "Combat", ["Civilian"] = "Civilian", ["Land"] = "DOMAIN_LAND", ["Sea"] = "DOMAIN_SEA",
					["Air"] = "DOMAIN_AIR", ["Hover"] = "DOMAIN_HOVER", ["Immobile"] = "DOMAIN_IMMOBILE" }
	return UnitCountTypes(tTable, "Units", "PlayerUnitCount", "PlayerUnits", tAllowedSettings, {...})
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function MakeNearbyUnitNotification(pCity, pUnit, sUnitName)
	PrintMessagingToLog("function MakeNearbyUnitNotification fired")
	local iPlayer = pCity:GetOwner()
	local pPlayer = Players[iPlayer]
	local sUnitsPlayerName = Players[pUnit:GetOwner()]:GetName()
	if pPlayer:IsHuman() then
		PrintMessagingToLog("MakeNearbyUnitNotification: City Owner is Human so notification should be made")
		local sMessageFull = "An enemy " .. sUnitName .. " belonging to " .. sUnitsPlayerName .. " has been detected near the city of " .. pCity:GetName() .. "."
		pPlayer:AddNotification(NotificationTypes["NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"], sMessageFull, "EnemyInTerritory", pUnit:GetX(), pUnit:GetY(), pUnit:GetUnitType(), -1, false)
		PrintMessagingToLog("MakeNearbyUnitNotification: true should be returned")
		return true
	end
	PrintMessagingToLog("MakeNearbyUnitNotification: false should be returned")
	return false
end
function ProcessUnitsToTable(pCity, tTableName, tRequiredUnitTypes, tProcessingTable, bMakeNotification, bNotificationAlreadyMade, bNotifyOnce)
	local bUnitFound, bNotificationHasBeenMade = false, false
	for k,pUnit in pairs(tTableName) do
		if tRequiredUnitTypes[pUnit:GetUnitType()] then
			PrintMessagingToLog("ProcessUnitsToTable: A qualifying was added to the processing table")
			bUnitFound = true
			table.insert(tProcessingTable, pUnit)
			if bMakeNotification and not bNotificationAlreadyMade then
				PrintMessagingToLog("ProcessUnitsToTable: A notification should be made, which is being called in the next line of code")
				local bNotificationWasMade = MakeNearbyUnitNotification(pCity, pUnit, tRequiredUnitTypes[pUnit:GetUnitType()])
				PrintMessagingToLog("ProcessUnitsToTable: " .. tostring(bNotificationWasMade) .. " was recieved back from function MakeNearbyUnitNotification")
				if bNotifyOnce and not bNotificationHasBeenMade then
					bNotificationHasBeenMade = bNotificationWasMade
				elseif bNotificationWasMade then
					bNotificationHasBeenMade = true
				end
				PrintMessagingToLog("ProcessUnitsToTable: bNotificationHasBeenMade is now set to " .. tostring(bNotificationHasBeenMade))
			end
		end
	end
	PrintMessagingToLog("ProcessUnitsToTable: bNotificationHasBeenMade is now set to " .. tostring(bNotificationHasBeenMade) .. " and this value will be returned")
	PrintMessagingToLog("ProcessUnitsToTable: bUnitFound is now set to " .. tostring(bUnitFound) .. " and this value will be returned")
	return tProcessingTable, bUnitFound, bNotificationHasBeenMade
end
function AreEnemyUnitsOfTypeNearby(tTable, sReturnMethod, sUnitType, sEnemyType, sMustBeVisible, sMakeNotification, sNotifyOnce)
	local tUnitsToConsider = GetUnitIDSThatMatch(sUnitType)
	local bMustBeVisible = ((sMustBeVisible ~= nil) and (sMustBeVisible == "MustBeVisible"))
	local bCountAll = ((sEnemyType ~= nil) and (sEnemyType == "Any"))
	local bCountOnlyEnemy = ((sEnemyType ~= nil) and (sEnemyType == "Enemy"))
	local bReturnBoolean = ((sReturnMethod ~= nil) and (sReturnMethod == "boolean"))
	local bMakeNotification = ((sMakeNotification ~= nil) and (sMakeNotification == "MakeNotification"))
	local bNotifyOnce = ((sNotifyOnce ~= nil) and (sNotifyOnce == "NotifyOnce"))
	local bNotificationAlreadyMade = false
	local tUnitsToProcess = {}
	local bExitWithBooleanTrue = false
	if bCountAll or bCountOnlyEnemy then
		tUnitsToProcess, bExitWithBooleanTrue, bNotificationAlreadyMade = ProcessUnitsToTable(tTable.OurCity, tTable.Units.EnemyUnits, tUnitsToConsider, tUnitsToProcess, bMakeNotification, bNotificationAlreadyMade, bNotifyOnce)
		if bReturnBoolean and bExitWithBooleanTrue then
			return true
		end
		if bCountAll then
			tUnitsToProcess, bExitWithBooleanTrue, bNotificationAlreadyMade = ProcessUnitsToTable(tTable.OurCity, tTable.Units.AdversaryUnits, tUnitsToConsider, tUnitsToProcess, bMakeNotification, bNotificationAlreadyMade, bNotifyOnce)
			if bReturnBoolean and bExitWithBooleanTrue then
				return true
			end
		end
		if not bMustBeVisible then
			tUnitsToProcess, bExitWithBooleanTrue, bNotificationAlreadyMade = ProcessUnitsToTable(tTable.OurCity, tTable.Units.EnemyInvisibleUnits, tUnitsToConsider, tUnitsToProcess, bMakeNotification, bNotificationAlreadyMade, bNotifyOnce)
			if bReturnBoolean and bExitWithBooleanTrue then
				return true
			end
			if bCountAll then
				tUnitsToProcess, bExitWithBooleanTrue, bNotificationAlreadyMade = ProcessUnitsToTable(tTable.OurCity, tTable.Units.AdversaryUnits, tUnitsToConsider, tUnitsToProcess, bMakeNotification, bNotificationAlreadyMade, bNotifyOnce)
				if bReturnBoolean and bExitWithBooleanTrue then
					return true
				end
			end
		end
	end
	if bReturnBoolean then
		return false
	else
		return tUnitsToProcess
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetBaseStrategicResourceQty(pCity, iResourceID, tResourceTable)
	local iStratResourceAmount = 0
	for Item,pPlot in pairs(tResourceTable) do
		if not pPlot:IsCity() then
			if not pPlot:IsImprovementPillaged() then
				local iImprovementID = pPlot:GetImprovementType()
				if (iImprovementID ~= -1) and tResouceValidImprovementsCityNearbyMapDatas[iResourceID][iImprovementID] then
					if pPlot:IsBeingWorked() then
						if pPlot:GetWorkingCity() == pCity then
							iStratResourceAmount = iStratResourceAmount + pPlot:GetNumResource()
						end
					else
						iStratResourceAmount = iStratResourceAmount + pPlot:GetNumResource()
					end
				end
			end
		end
	end
	return iStratResourceAmount
end
function GetCityStrategicResourceAmount(tTable, iResourceID, ...)
	local iStratResourceAmount = 0
	if tTable.Resources[iResourceID] then
		if tTable.Resources[iResourceID].ResourceIsStrategic == true then
			local iCityPlotAmount = ((tTable.Resources[iResourceID].CityResourceQty ~= nil) and tTable.Resources[iResourceID].CityResourceQty or 0)
			local tAllowedSettings = { ["DoNotCountCityPlot"] = "DoNotCountCityPlot", ["CountOnlyPillagedPlots"] = "CountOnlyPillagedPlots", ["CountOnlyUnclaimedPlots"] = "CountOnlyUnclaimedPlots", ["CountOnlyCorrectlyImproved"] = "CountOnlyCorrectlyImproved", ["CountOnlyUnpillagedPlots"] = "CountOnlyUnpillagedPlots", ["ResourceDoesNotHaveToBeRevealed"] = "ResourceDoesNotHaveToBeRevealed", ["CountOnlyPlotsWorkedByTheCity"] = "CountOnlyPlotsWorkedByTheCity" }
			local bValidCollectionSettings, tDataCollections = SortForValidSettings(tAllowedSettings, {...})
			local pCity = tTable.OurCity
			local iPlayer = pCity:GetOwner()
			local bCountOnlyCorrectlyImproved = ((tDataCollections["CountOnlyCorrectlyImproved"] ~= nil) and true or false)
			local bCountOnlyNonPillaged = ((tDataCollections["CountOnlyUnpillagedPlots"] ~= nil) and true or false)
			local bCountOnlyWorked = ((tDataCollections["CountOnlyPlotsWorkedByTheCity"] ~= nil) and true or false)
			local bCountOnlyUnclaimedPlots = ((tDataCollections["CountOnlyUnclaimedPlots"] ~= nil) and true or false)
			local bCountOnlyPillagedPlots = ((tDataCollections["CountOnlyPillagedPlots"] ~= nil) and true or false)
			local bDoNotCountCityPlot = ((tDataCollections["DoNotCountCityPlot"] ~= nil) and true or false)
			if not bValidCollectionSettings then
				--make overrides for no settings stated
				if not IsResourceRevealed(iPlayer, iResourceID) then
					return iStratResourceAmount
				end
				return (iCityPlotAmount + GetBaseStrategicResourceQty(pCity, iResourceID, tTable.Resources[iResourceID]["Plots"]))
			end
			if (tDataCollections["ResourceDoesNotHaveToBeRevealed"] == nil) and not IsResourceRevealed(iPlayer, iResourceID) then
				return iStratResourceAmount
			end

			local pPlayer = Players[iPlayer]
			local iTeam = pPlayer:GetTeam()
			local pTeam = Teams[iTeam]
			if bCountOnlyUnclaimedPlots then
				return tTable.Resources[iResourceID].UnClaimedResourceAmounts
			elseif bCountOnlyPillagedPlots then
				return tTable.Resources[iResourceID].PillagedResourceAmounts
			elseif bCountOnlyCorrectlyImproved then
				iStratResourceAmount = GetBaseStrategicResourceQty(pCity, iResourceID, tTable.Resources[iResourceID]["Plots"])
				if bDoNotCountCityPlot then
					return iStratResourceAmount
				end
				return (iStratResourceAmount + iCityPlotAmount)
			end
			-------------------------------------------------------------------------------------------------
			--figure all the variable possible remaining conditions and return correct strat resource qty
			-------------------------------------------------------------------------------------------------
			if bCountOnlyWorked then
				if bCountOnlyNonPillaged then
					iStratResourceAmount = tTable.Resources[iResourceID].CityResourceAmount
				else
					iStratResourceAmount = tTable.Resources[iResourceID].CityResourceAmount + tTable.Resources[iResourceID].PillagedWorkedResourceAmounts
				end
			else
				if bCountOnlyNonPillaged then
					iStratResourceAmount = tTable.Resources[iResourceID].CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount
				else
					iStratResourceAmount = tTable.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount
				end
			end
		end
	end
	if bDoNotCountCityPlot then
		return (iStratResourceAmount - iCityPlotAmount)
	else
		return iStratResourceAmount
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------
--			"Plots"					= table with all plots having the resource recorded as "Values",
--								  except those in unclaimed territory, and those belonging to a
--								  different player
-----------------------------------------------------------------------------------------------------------------------------------------------

function RequireCorrectImprovement(bRequireCorrectImprovement, bPlotIsCorrectlyImproved)
	if bRequireCorrectImprovement then
		if bPlotIsCorrectlyImproved then
			return true
		end
	else
		return true
	end
	return false
end
function PlotCountPillageStatus(iCount, bPlotIsPillaged, bRequireCorrectImprovement, bPlotIsCorrectlyImproved)
	local iNumberPlots = iCount
	if bPlotIsPillaged then
		if not bRequireNotPillaged then
			iNumberPlots = iNumberPlots + (RequireCorrectImprovement(bRequireCorrectImprovement, bPlotIsCorrectlyImproved) and 1 or 0)
		end 
	else
		if not bRequirePillaged then
			iNumberPlots = iNumberPlots + (RequireCorrectImprovement(bRequireCorrectImprovement, bPlotIsCorrectlyImproved) and 1 or 0)
		end
	end
	return iNumberPlots
end
function GetNumCityOwnedResourcePlots(tTable, iResourceID, ...)
	local iNumberPlots = 0
	local iPlayer = tTable.OurCity:GetOwner()
	local bValidCollectionSettings, tDataCollections = SortForValidSettings({ ["ResourceDoesNotHaveToBeRevealed"] = "ResourceDoesNotHaveToBeRevealed", ["Worked"] = "Worked", ["RequirePillaged"] = "RequirePillaged", ["RequireNotPillaged"] = "RequireNotPillaged", ["RequireCorrectImprovement"] = "RequireCorrectImprovement" }, {...})
	if not bValidCollectionSettings then
		--make overrides for no settings stated
		if not IsResourceRevealed(iPlayer, iResourceID) then
			return iNumberPlots
		end
	else
		if (tDataCollections["ResourceDoesNotHaveToBeRevealed"] == nil) and not IsResourceRevealed(iPlayer, iResourceID) then
			return iNumberPlots
		end
	end
	local bMustBeWorked = ((tDataCollections["Worked"] ~= nil) and true or false)
	local bRequirePillaged = ((tDataCollections["RequirePillaged"] ~= nil) and true or false)
	local bRequireNotPillaged = ((tDataCollections["RequireNotPillaged"] ~= nil) and true or false)
	local bRequireCorrectImprovement = ((tDataCollections["RequireCorrectImprovement"] ~= nil) and true or false)
	if not bValidCollectionSettings then
		bRequirePillaged, bRequireNotPillaged = false, true
		bRequireCorrectImprovement = false
	else
		if bRequireNotPillaged then
			bRequirePillaged = false
		end
	end
	local bCityHasResource = (tTable.CityResource ~= nil) and (tTable.CityResource == iResourceID)
	if not bRequirePillaged then
		iNumberPlots = iNumberPlots + (bCityHasResource and 1 or 0)
	end
	local tPlotsToCalculate = GetCityResourcePlots(tTable, iResourceID, "Plots")
	if #tPlotsToCalculate > 0 then
		for Item,pPlot in pairs(PlotsToCalculate) do
			local iPlotImprovement = pPlot:GetImprovementType()
			local bPlotIsCorrectlyImproved = false
			if tImprovementValidResoucesCityNearbyMapDatas[iPlotImprovement] then
				bPlotIsCorrectlyImproved = (tImprovementValidResoucesCityNearbyMapDatas[iPlotImprovement][iResourceID] ~= nil)
			end
			if bMustBeWorked then
				if pPlot:IsBeingWorked() then
					if pPlot:GetWorkingCity() == tTable.OurCity then
						iNumberPlots = PlotCountPillageStatus(iNumberPlots, pPlot:IsImprovementPillaged(), bRequireCorrectImprovement, bPlotIsCorrectlyImproved)
					end
				end
			else
				if pPlot:GetOwner() == iPlayer then
					if pPlot:IsBeingWorked() then
						if pPlot:GetWorkingCity() == tTable.OurCity then
							iNumberPlots = PlotCountPillageStatus(iNumberPlots, pPlot:IsImprovementPillaged(), bRequireCorrectImprovement, bPlotIsCorrectlyImproved)
						end
					else
						iNumberPlots = PlotCountPillageStatus(iNumberPlots, pPlot:IsImprovementPillaged(), bRequireCorrectImprovement, bPlotIsCorrectlyImproved)
					end
				elseif bCanBeUnclaimed and (pPlot:GetOwner() == -1) then
					table.insert(tPillagedPlots, pPlot)
				end
			end
		end
	end
	return iNumberPlots
end


-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetPillagedPlots(tTable, ...)
	local tPillagedPlots = {}
	local iPlayer = tTable.OurCity:GetOwner()
	local bValidCollectionSettings, tDataCollections = SortForValidSettings({ ["Worked"] = "Worked", ["Owned"] = "Owned", ["CanBeUnclaimed"] = "CanBeUnclaimed", ["MustBeUnclaimed"] = "MustBeUnclaimed" }, {...})
	local bMustBeWorked = ((tDataCollections["Worked"] ~= nil) and true or false)
	local bMustBeWorkedOverride = (bMustBeWorked and bValidCollectionSettings)
	local bMustBeOwned = ((tDataCollections["Owned"] ~= nil) and true or false)
	local bCanBeUnclaimed = ((tDataCollections["CanBeUnclaimed"] ~= nil) and true or false)
	local bMustBeUnclaimed = ((tDataCollections["MustBeUnclaimed"] ~= nil) and true or false)
	if not bValidCollectionSettings then
		bMustBeWorked, bMustBeOwned, bCanBeUnclaimed, bMustBeUnclaimed = true, false, false, false
	elseif bMustBeWorkedOverride then
		bMustBeOwned, bCanBeUnclaimed, bMustBeUnclaimed = false, false, false
	elseif bMustBeOwned then
		bMustBeUnclaimed = false
	elseif bCanBeUnclaimed then
		bMustBeUnclaimed = false
	end
	for iImprovementID, DataTable in pairs(tTable.Improvements) do
		if tPillageableImprovements[iImprovementID] then
			if bMustBeWorked then
				for Item,pPlot in pairs(DataTable.WorkedPlotsThatArePillaged) do
					table.insert(tPillagedPlots, pPlot)
				end
			elseif bMustBeOwned then
				for Item,pPlot in pairs(DataTable.PillagedPlots) do
					if pPlot:GetOwner() == iPlayer then
						if pPlot:IsBeingWorked() then
							if pPlot:GetWorkingCity() == tTable.OurCity then
								table.insert(tPillagedPlots, pPlot)
							end
						else
							table.insert(tPillagedPlots, pPlot)
						end
					elseif bCanBeUnclaimed and (pPlot:GetOwner() == -1) then
						table.insert(tPillagedPlots, pPlot)
					end
				end
			elseif bCanBeUnclaimed then
				for Item,pPlot in pairs(DataTable.PillagedPlots) do
					if pPlot:IsBeingWorked() then
						if pPlot:GetWorkingCity() == tTable.OurCity then
							table.insert(tPillagedPlots, pPlot)
						end
					else
						table.insert(tPillagedPlots, pPlot)
					end
				end
			elseif bMustBeUnclaimed then
				for Item,pPlot in pairs(DataTable.PillagedPlots) do
					if (pPlot:GetOwner() == -1) then
						table.insert(tPillagedPlots, pPlot)
					end
				end
			else
				local sLongMessage = "In function GetPillagedPlots: We arrived somewhere we should not be able to be"
				local sShortMessage = "[COLOR_NEGATIVE_TEXT]GetPillagedPlots Error![ENDCOLOR]"
				Players[0]:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], sShortMessage .. "[NEWLINE][NEWLINE]" .. sLongMessage, sShortMessage)
				print(sLongMessage)
				print(" ")
				print(" ")
			end
		end
	end
	return tPillagedPlots
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetImprovedPlots(tTable, ...)
	local tImprovedPlots = {}
	local iPlayer = tTable.OurCity:GetOwner()
	local bValidCollectionSettings, tDataCollections = SortForValidSettings({ ["Worked"] = "Worked", ["Owned"] = "Owned", ["CanBeUnclaimed"] = "CanBeUnclaimed", ["MustBeUnclaimed"] = "MustBeUnclaimed" }, {...})
	local bMustBeWorked = ((tDataCollections["Worked"] ~= nil) and true or false)
	local bMustBeWorkedOverride = (bMustBeWorked and bValidCollectionSettings)
	local bMustBeOwned = ((tDataCollections["Owned"] ~= nil) and true or false)
	local bCanBeUnclaimed = ((tDataCollections["CanBeUnclaimed"] ~= nil) and true or false)
	local bMustBeUnclaimed = ((tDataCollections["MustBeUnclaimed"] ~= nil) and true or false)
	if not bValidCollectionSettings then
		bMustBeWorked, bMustBeOwned, bCanBeUnclaimed, bMustBeUnclaimed = true, false, false, false
	elseif bMustBeWorkedOverride then
		bMustBeOwned, bCanBeUnclaimed, bMustBeUnclaimed = false, false, false
	elseif bMustBeOwned then
		bMustBeUnclaimed = false
	elseif bCanBeUnclaimed then
		bMustBeUnclaimed = false
	end
	for iImprovementID, DataTable in pairs(tTable.Improvements) do
		if bMustBeWorked then
			for Item,pPlot in pairs(DataTable.WorkedPlotsThatAreNotPillaged) do
				table.insert(tImprovedPlots, pPlot)
			end
		elseif bMustBeOwned then
			for Item,pPlot in pairs(DataTable.Plots) do
				if not pPlot:IsImprovementPillaged() then
					if pPlot:GetOwner() == iPlayer then
						if pPlot:IsBeingWorked() then
							if (pPlot:GetWorkingCity() == tTable.OurCity) then
								table.insert(tImprovedPlots, pPlot)
							end
						else
							table.insert(tImprovedPlots, pPlot)
						end
					elseif bCanBeUnclaimed and (pPlot:GetOwner() == -1) then
						table.insert(tImprovedPlots, pPlot)
					end
				end
			end
		elseif bCanBeUnclaimed then
			for Item,pPlot in pairs(DataTable.Plots) do
				if not pPlot:IsImprovementPillaged() then
					if pPlot:IsBeingWorked() then
						if (pPlot:GetWorkingCity() == tTable.OurCity) then
							table.insert(tImprovedPlots, pPlot)
						end
					else
						table.insert(tImprovedPlots, pPlot)
					end
				end
			end
		elseif bMustBeUnclaimed then
			for Item,pPlot in pairs(DataTable.UnclaimedPlots) do
				if not pPlot:IsImprovementPillaged() then
					if (pPlot:GetOwner() == -1) then
						table.insert(tImprovedPlots, pPlot)
					end
				end
			end
		else
			local sLongMessage = "In function GetPillagedPlots: We arrived somewhere we should not be able to be"
			local sShortMessage = "[COLOR_NEGATIVE_TEXT]GetPillagedPlots Error![ENDCOLOR]"
			Players[0]:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], sShortMessage .. "[NEWLINE][NEWLINE]" .. sLongMessage, sShortMessage)
			print(sLongMessage)
			print(" ")
			print(" ")
		end
	end
	return tImprovedPlots
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<-- Main City-Plot Scanning Function -->xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function GetCityMapDatas(pCity, ...)
	-------------------------------------------------------------------------------------------------
	--decide what to count
	-------------------------------------------------------------------------------------------------
	local bValidCollectionSettings, tDataCollections = SortForValidSettings({ ["Units"] = "Units", ["Resources"] = "Resources", ["Improvements"] = "Improvements", ["Cities"] = "Cities" }, {...})
	local bCollectUnitData = ((tDataCollections["Units"] ~= nil) and true or false)
	local bCollectResourceData = ((tDataCollections["Resources"] ~= nil) and true or false)
	local bCollectImprovementData = ((tDataCollections["Improvements"] ~= nil) and true or false)
	local bCollectCityData = ((tDataCollections["Cities"] ~= nil) and true or false)
	-------------------------------------------------------------------------------------------------
	--count
	-------------------------------------------------------------------------------------------------
	local iPlayer = pCity:GetOwner()
	local pPlayer = Players[iPlayer]
	local tCityNearbyDatas = {}
	tCityNearbyDatas.Resources = {}
	tCityNearbyDatas.Units = { PlayerUnits = {}, PlayerUnitCount = 0, BarbarianCount = 0, BarbarianUnits = {}, EnemyCount = 0, EnemyUnits = {},
					AdversaryCount = 0, AdversaryUnits = {}, BarbarianInvisibleCount = 0, BarbarianInvisibleUnits = {},
					EnemyInvisibleCount = 0, EnemyInvisibleUnits = {}, AdversaryInvisibleCount = 0, AdversaryInvisibleUnits = {} }
	tCityNearbyDatas.Improvements = {}
	tCityNearbyDatas.OtherCities = { Cities = {}, CitiesWithResources = {} }
	tCityNearbyDatas.OurCity = pCity
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	local tCityUnits = {}
	local iNumUnitsNearCity = 0
	local iNumPlots = pCity:GetNumCityPlots()
	for i = 0, iNumPlots - 1 do
		local pPlot = pCity:GetCityIndexPlot(i)
		if pPlot then
			local iResourceID = pPlot:GetResourceType()
			local bPlotHasResource = (iResourceID ~= -1)
			local tPlotResourceData = -1
			if bPlotHasResource then
				tPlotResourceData = GameInfo.Resources[iResourceID]
			end
			local bPlotHasResourceAmount = (pPlot:GetNumResource() > 0)
			local iPlotOwner = pPlot:GetOwner()
			local bPlotIsOwnedByPlayer = (iPlotOwner == iPlayer)
			local bPlotIsNotOwned = (iPlotOwner == -1)
			local iImprovementID = pPlot:GetImprovementType()
			local bPlotHasImprovement = ((iImprovementID ~= -1) and (tRelevantImprovements[iImprovementID]))
			local tPlotImprovementData = -1
			if bPlotHasImprovement then
				tPlotImprovementData = GameInfo.Improvements[iImprovementID]
			end
			if bCollectImprovementData then
				if (bPlotIsOwnedByPlayer or bPlotIsNotOwned) and bPlotHasImprovement then
					if not tCityNearbyDatas.Improvements[iImprovementID] then
						tCityNearbyDatas.Improvements[iImprovementID] = { Type = tPlotImprovementData.Type,
							Description = Locale.ConvertTextKey(tPlotImprovementData.Description),
							NumPlotsCounted = 0,
							NumPlotsWorkedByCity = 0,
							NumPlotsWorkedByCityThatAreNotPillaged = 0,
							NumPlotsWorkedByCityThatArePillaged = 0,
							NumPillagedPlots = 0,
							NumUnclaimedPlots = 0,
							NumPlotsWithIncorrectImprovementForResource = 0,
							Plots = {},
							WorkedPlots = {},
							WorkedPlotsThatAreNotPillaged = {},
							WorkedPlotsThatArePillaged = {},
							WorkedPlotsWithIncorrectImprovementForResource = {},
							UnWorkedPlotsWithIncorrectImprovementForResource = {},
							PillagedPlots = {},
							UnclaimedPlots = {},
							PlotsWithCorrectResources = {},
							PlotsWithInCorrectResources = {},
							Placeholder = "Placeholder" }
					end
					tCityNearbyDatas.Improvements[iImprovementID].NumPlotsCounted = tCityNearbyDatas.Improvements[iImprovementID].NumPlotsCounted + 1
					table.insert(tCityNearbyDatas.Improvements[iImprovementID].Plots, pPlot)
					local bImprovementIsCorrectForMapResource = false
					if bPlotHasResource then
						if tImprovementValidResoucesCityNearbyMapDatas[iImprovementID] then
							bImprovementIsCorrectForMapResource = (tImprovementValidResoucesCityNearbyMapDatas[iImprovementID][iResourceID] ~= nil)
							if bImprovementIsCorrectForMapResource then
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].PlotsWithCorrectResources, pPlot)
							else
								tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWithIncorrectImprovementForResource = tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWithIncorrectImprovementForResource + 1
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].PlotsWithInCorrectResources, pPlot)
							end
						end
					end
					if pPlot:IsBeingWorked() then
						if pPlot:GetWorkingCity() == pCity then
							tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWorkedByCity = tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWorkedByCity + 1
							table.insert(tCityNearbyDatas.Improvements[iImprovementID].WorkedPlots, pPlot)
							if pPlot:IsImprovementPillaged() then
								tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWorkedByCityThatArePillaged = tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWorkedByCityThatArePillaged + 1
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].WorkedPlotsThatArePillaged, pPlot)
								tCityNearbyDatas.Improvements[iImprovementID].NumPillagedPlots = tCityNearbyDatas.Improvements[iImprovementID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].PillagedPlots, pPlot)
							else
								tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWorkedByCityThatAreNotPillaged = tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWorkedByCityThatAreNotPillaged + 1
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].WorkedPlotsThatAreNotPillaged, pPlot)
								if bPlotHasResource and not bImprovementIsCorrectForMapResource then
									table.insert(tCityNearbyDatas.Improvements[iImprovementID].WorkedPlotsWithIncorrectImprovementForResource, pPlot)
								end
							end
						end
					else
						if bPlotIsOwnedByPlayer then
							if not pPlot:IsImprovementPillaged() then
								if bPlotHasResource and not bImprovementIsCorrectForMapResource then
									table.insert(tCityNearbyDatas.Improvements[iImprovementID].UnWorkedPlotsWithIncorrectImprovementForResource, pPlot)
								end
							else
								tCityNearbyDatas.Improvements[iImprovementID].NumPillagedPlots = tCityNearbyDatas.Improvements[iImprovementID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].PillagedPlots, pPlot)
							end
						elseif bPlotIsNotOwned then
							tCityNearbyDatas.Improvements[iImprovementID].NumUnclaimedPlots = tCityNearbyDatas.Improvements[iImprovementID].NumUnclaimedPlots + 1
							table.insert(tCityNearbyDatas.Improvements[iImprovementID].UnclaimedPlots, pPlot)
							if pPlot:IsImprovementPillaged() then
								tCityNearbyDatas.Improvements[iImprovementID].NumPillagedPlots = tCityNearbyDatas.Improvements[iImprovementID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Improvements[iImprovementID].PillagedPlots, pPlot)
							end
						end
					end
				end
			end
			if bCollectCityData then
				if pPlot:IsCity() and (pPlot:GetPlotCity() ~= pCity) then
					local pOtherCity = pPlot:GetPlotCity()
					table.insert(tCityNearbyDatas.OtherCities.Cities, {CityObject=pOtherCity, CityName=pOtherCity:GetName()})
				end
			end
			if bCollectUnitData then
				if (bPlotIsOwnedByPlayer or bPlotIsNotOwned) and pPlot:IsUnit() then
					for i = 0, pPlot:GetNumUnits() - 1 do
						local pUnit = pPlot:GetUnit(i)
						if pUnit then
							iNumUnitsNearCity = iNumUnitsNearCity + 1
							tCityUnits[iNumUnitsNearCity] = pUnit
						end
					end
				end
			end
			if bCollectResourceData and bPlotHasResource then
				local bPlayerHasResourceRevealTech = true
				local iRequiredTech = GameInfoTypes[tPlotResourceData.TechReveal]
				local bResourceIsArtifact = (tArtifactResourcesCityNearbyMapDatas[iResourceID] ~= nil)
				local bResourceIsCorrectlyImproved = false
				if not bResourceIsArtifact then
					bResourceIsCorrectlyImproved = (tResouceValidImprovementsCityNearbyMapDatas[iResourceID][iImprovementID] ~= nil)
				end
				local bResourceIsStrategic = (((tPlotResourceData.ResourceClassType == "RESOURCECLASS_MODERN") or (tPlotResourceData.ResourceClassType == "RESOURCECLASS_RUSH")) and not bResourceIsArtifact)
				if (iRequiredTech ~= nil) and (iRequiredTech ~= -1) then
					bPlayerHasResourceRevealTech = pTeam:IsHasTech(iRequiredTech)
				end
				if pPlot:IsCity() and (pPlot:GetPlotCity() == pCity) then
					tCityNearbyDatas.CityResource = iResourceID
					tCityNearbyDatas.CityResourceIsRevealed = bPlayerHasResourceRevealTech
					tCityNearbyDatas.CityResourceQty = (bResourceIsStrategic and pPlot:GetNumResource() or 0)
					tCityNearbyDatas.CityResourceIsLuxury = (tPlotResourceData.ResourceClassType == "RESOURCECLASS_LUXURY")
					tCityNearbyDatas.CityResourceIsBonus = (tPlotResourceData.ResourceClassType == "RESOURCECLASS_BONUS")
					tCityNearbyDatas.CityResourceIsStrategic = bResourceIsStrategic
				elseif pPlot:IsCity() then
					if bCollectCityData then
						local pOtherCity = pPlot:GetPlotCity()
						table.insert(tCityNearbyDatas.OtherCities.CitiesWithResources, {CityObject=pOtherCity, CityName=pOtherCity:GetName(), CityResource=iResourceID, CityResourceIsStrategic=bResourceIsStrategic, CityResourceQty = (bResourceIsStrategic and pPlot:GetNumResource() or 0)})
					end
				else
					if not tCityNearbyDatas.Resources[iResourceID] then
						tCityNearbyDatas.Resources[iResourceID] = { Type = tPlotResourceData.Type,
							Class = tPlotResourceData.ResourceClassType, Description = Locale.ConvertTextKey(tPlotResourceData.Description),
							NumPlotsCounted = 0, NumPlotsWorkedByCity = 0, NumPlotsWorkedByCityThatAreNotPillaged = 0,
							NumPlotsWorkedByCityThatArePillaged = 0, NumPillagedPlots = 0, NumUnclaimedPlots = 0,
							NumPlotsWithIncorrectImprovement = 0, NumPlotsWithNoImprovement = 0,
							ResourceAmount = 0, UnClaimedResourceAmounts = 0, PillagedResourceAmounts = 0, PillagedWorkedResourceAmounts = 0,
							CityResourceAmount = 0, CorrectlyImprovedAllOwnedTilesResourceAmount = 0, CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount = 0,
							Plots = {}, WorkedPlots = {}, WorkedPlotsThatAreNotPillaged = {}, WorkedPlotsThatArePillaged = {},
							WorkedPlotsWithIncorrectImprovement = {}, WorkedPlotsWithNoImprovement = {},
							PillagedPlots = {}, UnclaimedPlots = {},
							ResourceIsRevealed = bPlayerHasResourceRevealTech,
							ResourceIsLuxury = (tPlotResourceData.ResourceClassType == "RESOURCECLASS_LUXURY"),
							ResourceIsBonus = (tPlotResourceData.ResourceClassType == "RESOURCECLASS_BONUS"),
							ResourceIsStrategic = bResourceIsStrategic, ResourceIsArtifact = bResourceIsArtifact,

							Placeholder = "Placeholder" }
						if (tCityNearbyDatas.CityResource ~= nil) and (tCityNearbyDatas.CityResource == iResourceID) and (tCityNearbyDatas.CityResourceIsStrategic == true) and (tCityNearbyDatas.CityResourceQty > 0) then
							tCityNearbyDatas.Resources[iResourceID].ResourceAmount = tCityNearbyDatas.CityResourceQty
							tCityNearbyDatas.Resources[iResourceID].CityResourceAmount = tCityNearbyDatas.CityResourceQty
							tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount = tCityNearbyDatas.CityResourceQty
							tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount = tCityNearbyDatas.CityResourceQty
						end
						if bResourceIsArtifact then
							tCityNearbyDatas.Resources[iResourceID].ResourceArtifactType = tArtifactResourcesCityNearbyMapDatas[iResourceID]
						else
							tCityNearbyDatas.Resources[iResourceID].ResourceArtifactType = "Not An Atrifact Or Hidden Artifact"
						end
					end
					if pPlot:IsBeingWorked() then
						if pPlot:GetWorkingCity() == pCity then
							tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCity = tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCity + 1
							tCityNearbyDatas.Resources[iResourceID].NumPlotsCounted = tCityNearbyDatas.Resources[iResourceID].NumPlotsCounted + 1
							table.insert(tCityNearbyDatas.Resources[iResourceID].WorkedPlots, pPlot)
							table.insert(tCityNearbyDatas.Resources[iResourceID].Plots, pPlot)
							if bResourceIsStrategic and bPlotHasResourceAmount and not pPlot:IsImprovementPillaged() then
								tCityNearbyDatas.Resources[iResourceID].ResourceAmount = tCityNearbyDatas.Resources[iResourceID].ResourceAmount + pPlot:GetNumResource()
								if bResourceIsCorrectlyImproved then
									tCityNearbyDatas.Resources[iResourceID].CityResourceAmount = tCityNearbyDatas.Resources[iResourceID].CityResourceAmount + pPlot:GetNumResource()
									tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount = tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount + pPlot:GetNumResource()
									tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount = tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount + pPlot:GetNumResource()
								end
							end
							if pPlot:IsImprovementPillaged() then
								tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCityThatArePillaged = tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCityThatArePillaged + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].WorkedPlotsThatArePillaged, pPlot)
								tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots = tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].PillagedPlots, pPlot)
								if bResourceIsStrategic and bResourceIsCorrectlyImproved and bPlotHasResourceAmount then
									tCityNearbyDatas.Resources[iResourceID].PillagedResourceAmounts = tCityNearbyDatas.Resources[iResourceID].PillagedResourceAmounts + pPlot:GetNumResource()
									tCityNearbyDatas.Resources[iResourceID].PillagedWorkedResourceAmounts = tCityNearbyDatas.Resources[iResourceID].PillagedWorkedResourceAmounts + pPlot:GetNumResource()
								end
							else
								tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCityThatAreNotPillaged = tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCityThatAreNotPillaged + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].WorkedPlotsThatAreNotPillaged, pPlot)
								if not bResourceIsCorrectlyImproved and bPlotHasImprovement then
									tCityNearbyDatas.Resources[iResourceID].NumPlotsWithIncorrectImprovement = tCityNearbyDatas.Resources[iResourceID].NumPlotsWithIncorrectImprovement + 1
									table.insert(tCityNearbyDatas.Resources[iResourceID].WorkedPlotsWithIncorrectImprovement, pPlot)
								end
							end
							if iImprovementID == -1 then
								tCityNearbyDatas.Resources[iResourceID].NumPlotsWithNoImprovement = tCityNearbyDatas.Resources[iResourceID].NumPlotsWithNoImprovement + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].WorkedPlotsWithNoImprovement, pPlot)
							end
						end
					else
						if bPlotIsOwnedByPlayer then
							tCityNearbyDatas.Resources[iResourceID].NumPlotsCounted = tCityNearbyDatas.Resources[iResourceID].NumPlotsCounted + 1
							table.insert(tCityNearbyDatas.Resources[iResourceID].Plots, pPlot)
							if not pPlot:IsImprovementPillaged() then
								if bResourceIsStrategic and (bPlotHasResourceAmount) then
									tCityNearbyDatas.Resources[iResourceID].ResourceAmount = tCityNearbyDatas.Resources[iResourceID].ResourceAmount + pPlot:GetNumResource()
									if bResourceIsCorrectlyImproved then
										tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount = tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount + pPlot:GetNumResource()
										tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount = tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedUnpillagedTilesResourceAmount + pPlot:GetNumResource()
									end
								end
								if not bResourceIsCorrectlyImproved and (bPlotHasImprovement) then
									tCityNearbyDatas.Resources[iResourceID].NumPlotsWithIncorrectImprovement = tCityNearbyDatas.Resources[iResourceID].NumPlotsWithIncorrectImprovement + 1
								end
							else
								tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots = tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].PillagedPlots, pPlot)
								if bResourceIsStrategic and bResourceIsCorrectlyImproved and bPlotHasResourceAmount then
									tCityNearbyDatas.Resources[iResourceID].PillagedResourceAmounts = tCityNearbyDatas.Resources[iResourceID].PillagedResourceAmounts + pPlot:GetNumResource()
									tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount = tCityNearbyDatas.Resources[iResourceID].CorrectlyImprovedAllOwnedTilesResourceAmount + pPlot:GetNumResource()
								end
							end
							if not bPlotHasImprovement then
								tCityNearbyDatas.Resources[iResourceID].NumPlotsWithNoImprovement = tCityNearbyDatas.Resources[iResourceID].NumPlotsWithNoImprovement + 1
							end
						end
					end
					if bPlotIsNotOwned then
						tCityNearbyDatas.Resources[iResourceID].NumUnclaimedPlots = tCityNearbyDatas.Resources[iResourceID].NumUnclaimedPlots + 1
						table.insert(tCityNearbyDatas.Resources[iResourceID].UnclaimedPlots, pPlot)
						if bResourceIsStrategic and bPlotHasResourceAmount then
							tCityNearbyDatas.Resources[iResourceID].UnClaimedResourceAmounts = tCityNearbyDatas.Resources[iResourceID].UnClaimedResourceAmounts + pPlot:GetNumResource()
						end
					end
				end
			end
		end
	end
	if bCollectUnitData and (iNumUnitsNearCity > 0) then
		for iNearbyUnitNumber,pUnit in pairs(tCityUnits) do
			local iUnitOwner = pUnit:GetOwner()
			local pUnitOwner = Players[iUnitOwner]
			local bPlotIsVisible = pUnit:GetPlot():IsVisible(iTeam, false)
			local iUnitTeam = pUnitOwner:GetTeam()
			local bWeAreAtWar = pTeam:IsAtWar(iUnitTeam)
			if iUnitOwner == iPlayer then
				tCityNearbyDatas.Units.PlayerUnitCount = tCityNearbyDatas.Units.PlayerUnitCount + 1
				table.insert(tCityNearbyDatas.Units.PlayerUnits,pUnit)
			else
				local sCounterKey, sTableKey = "BarbarianInvisibleCount", "BarbarianInvisibleUnits"
				if bPlotIsVisible then
					if pUnitOwner:IsBarbarian() then
						sCounterKey, sTableKey = "BarbarianCount", "BarbarianUnits"
					elseif bWeAreAtWar then
						sCounterKey, sTableKey = "EnemyCount", "EnemyUnits"
					else
						sCounterKey, sTableKey = "AdversaryCount", "AdversaryUnits"
					end
				else
					if bWeAreAtWar then
						sCounterKey, sTableKey = "EnemyInvisibleCount", "EnemyInvisibleUnits"
					else
						sCounterKey, sTableKey = "AdversaryInvisibleCount", "AdversaryInvisibleUnits"
					end
				end
				tCityNearbyDatas.Units[sCounterKey] = tCityNearbyDatas.Units[sCounterKey] + 1
				table.insert(tCityNearbyDatas.Units[sTableKey],pUnit)
			end
		end
	end
	return tCityNearbyDatas
end















print("CityNearbyMapDatas from the CityNearbyMapDatas Mod loaded to the end")


