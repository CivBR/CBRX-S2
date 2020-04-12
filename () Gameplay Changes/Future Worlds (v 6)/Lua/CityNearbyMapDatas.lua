-- CityNearbyMapDatas
-- Author: LeeS
-- DateCreated: 8/02/2016
--[[
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Notes to users:


1)	This file should be added to your mod and set as ImportIntoVFS=true
2)	This file should never be used in the ModBuddy Content Tab as an "InGameUIAddin"
3)	This file should be included into your main lua-file via statement:

		include("CityNearbyMapDatas.lua")

	a)	See how this is done in the example Main Lua file called "Lua Script1.lua"
	b)	Note that file "Lua Script1.lua" IS set-up in modbuddy as an "InGameUIAddin"


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Notes to self:


1)	Need to clean up all the IsResourceRevealed methods to use the routine rather than the repetative use of the same code-lines over and over and over.
	Does not affect how the code works one way or the other but does make for a small amount of code-bloat
2)	Move all the descriptions into a readme so that what is getting parsed into the game is not a bloated file that is 70% comments and 30% executables
3)	Finish un-done notes on how to use some of the functions, where needed.
	Some functions are not user-called. They are called by the user-called functions. Some documentation wil be helpful to self for later debug if required.



xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

			MAKE NO CHANGES BELOW THIS LINE !!!

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
]]--





--the following is for debug purposes
--it and all printing statements would be removed from a final version
------------------------------------

local bPrintDebug = false	--this is here in case I need to make copious debugs.
function PrintMessagingToLog(sMessage)
	if bPrintDebug then
		print(sMessage)
	end
end


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--[[


		GET ALL MAP DATAS NEAR CITY	(RSOURCES, IMPROVEMENTS, UNITS, OTHER CITIES)

	Function Name:			GetCityMapDatas(pCity)
	Required Parameter:		City Object in place of variable "pCity"
					No other parameters are required
	Example 'Call' Statements:	local tNearbyDatas = GetCityMapDatas(pCity)


	Optional Parameters:		Up to x text-string parameters can be included AFTER the city-object parameter, in any order.
					a)	Each of these tells the code which type of data to collect.
					b)	when no additional parameters are added, all data is collected
					c)	the additional text-string parameters allowed are:
						1)	"Units"
						2)	"Resources"
						3)	"Improvements"
						4)	"Cities"
						5)	
					d)	as mentioned, these can be stated in any order following the
						city object.
					e)	if any valid optional parameter is used, then ONLY data that
						corresponds to those listed optional parameters will be collected.
					f)	if oddball text-string data is included, such as "Lettuce",
						the code will ignore such, and the parameter where such an
						oddball designation appears will be treated as if it did not
						exist.
					g)	note that when "Resources" is selected by default or by adding it
						as an active parameter-selection, the plot of the city passed to the
						function will always get data collected for it as outlined in # 5 if
						the city it located on a plot with a map resource.

	Example 'Call' Statements:	Using Additional Parameters

	I)	Gathering only data about units near the city:

				local tNearbyDatas = GetCityMapDatas(pCity, "Units")

	II)	Gathering only data about resources near the city:

				local tNearbyDatas = GetCityMapDatas(pCity, "Resources")

	III)	Gathering only data about resources and units near the city:

				local tNearbyDatas = GetCityMapDatas(pCity, "Resources", "Units")

		or

				local tNearbyDatas = GetCityMapDatas(pCity, "Units", "Resources")

	IV)	Gathering only data about units near the city because "Resources" is mispelled:

				local tNearbyDatas = GetCityMapDatas(pCity, "Rehorses", "Units")

		or

				local tNearbyDatas = GetCityMapDatas(pCity, "Units", "Rehorses")

	V)	Gathering data about all data-types near the city because "Cheeseburgers" is not recognized as valid:

				local tNearbyDatas = GetCityMapDatas(pCity, "Cheeseburgers")

		In this case the code reverts to collecting all data because no valid limiting parameter was stated.

....................................................................................................................................

1)	All data about map-plot resources within the 3-tile range of the specified city are thrown into one lua-table

....................................................................................................................................

2)	This lua table containing all the information about nearby city resources is returned by the function

....................................................................................................................................

3)	So stating as follows:

		local tNearbyDatas = GetCityMapDatas(pCity)

	will place the information about resources near the city into the table called "tNearbyDatas"

	a)	You do not have to state your local table-name as "tNearbyDatas". You can call it whatever you want, such as
		"Cheeseburgers", so long as you then reference the data within the table using "Cheeseburgers" as the main table-name
		instead of how I will refer to it (ie, "tNearbyDatas"):

		Using "Cheeseburgers" as the table name where the city resource info gets placed:

			local Cheeseburgers = GetCityMapDatas(pCity)
			if Cheeseburgers.CityResource ~= nil then
				print(Cheeseburgers.CityResource)
			end

		Using "tNearbyDatas" as the table name where the city resource info gets placed:

			local tNearbyDatas = GetCityMapDatas(pCity)
			if tNearbyDatas.CityResource ~= nil then
				print(tNearbyDatas.CityResource)
			end

....................................................................................................................................

4)	For Map Plot Resources, Data is only collected about plots that adhere to the following rules:
	a)	only plots that have a map resource, or a terrain improvement, or a unit, or a city are included
	b)	are not being worked by some other city (whether of the same player or a different player)
	c)	are not owned by some other player (except that some limited data is gathered about cities)

....................................................................................................................................

5)	Information about a resource that may be on the same plot as the city passed to the function is given in special details
	of the lua table. If there is a resource on the same tile as the city, this information will be contained in the following
	keys (assuming you stored the info on the city's resources into a table called "tNearbyDatas"):

		tNearbyDatas.CityResource			The resource ID#
		tNearbyDatas.CityResourceIsRevealed		Boolean for whether the player can "see" the resource
		tNearbyDatas.CityResourceQty		The resource "Qty" on the city plot
								(for use with Strat. Resources: it is 0 otherwise)
		tNearbyDatas.CityResourceIsLuxury		Boolean for whether the resource is a Luxury Resource
		tNearbyDatas.CityResourceIsBonus		Boolean for whether the resource is a Bonus Resource
		tNearbyDatas.CityResourceIsStrategic	Boolean for whether the resource is a Strategic Resource

	Note that if there is no resource on the same plot as the city occupies, all of these would be "nil"

	All information for the plot the city is on is also rolled into the main counts for the Resource so that the data for the
	Resource on the same plot as the city occupies reflects not only the city plot itself but also all plots near the city that
	have the same map resource. See # 6.

....................................................................................................................................

6)	Data about all map resources near the city is collected into a subtable called "Resources", so if you stored the information
	gathered from the function for pCity into a local table called "tNearbyDatas", all the information about map resources
	near the city will be placed into a table accessed by "tNearbyDatas.Resources"
	a)	This table "tNearbyDatas.Resources" is organized so that all its "keys" are integer ID#s of resources actually near the city,
		and the "values" are themselves sub-tables holding the information about that individual type of resource.
	b)	The information for any resource that may be on the City plot is also rolled into the various counts and other
		data collected for this individual resource.
	c)	If a particular resource is not within range of the city, or cannot be counted because of the rules outlined in # 4,
		then that resource's ID # will not be present as a "key" within table "tNearbyDatas.Resources"
	d)	For each resource found near the city, the following "Sub-Keys" are created and data is collected within the proper
		"Sub-Keys" for that resource:

		Type					= text	The recource's "Type" info from table <Resources>
		Class					= text	The recource's "ResourceClassType" info from table <Resources>
		Description				= text	The recource's localized "Description" TXT_KEY tag as specified table <Resources>
		NumPlotsCounted		 		= int	default 0	number plots with the resource except those in unclaimed territory	
		NumPlotsWorkedByCity			= int	default 0	number plots with the resource that are being worked by the city
		NumPlotsWorkedByCityThatAreNotPillaged	= int	default 0	number plots with the resource that are being worked by the city and which are not pillaged
		NumPlotsWorkedByCityThatArePillaged	= int	default 0	number plots with the resource that are being worked by the city and which are pillaged
		NumPillagedPlots			= int	default 0	number plots with the resource that are pillaged
		NumUnclaimedPlots			= int	default 0	number plots with the resource that are in unowned territory
		NumPlotsWithIncorrectImprovement	= int	default 0	number plots with the resource that have an incorrect improvement for the resource
		NumPlotsWithNoImprovement		= int	default 0	number plots with the resource that have no improvmeent of any kind
		ResourceAmount				= int	default 0	total strategic resource amount for this resource
										from plots either being worked by the city or which are owned by the same player
		CityResourceAmount			= int	default 0	strategic resource amount for this resource from the city plot itself or from plots
										being worked by city and which have a correct improvement type.
		UnClaimedResourceAmounts		= int	default 0	total strategic resource amount for this resource near this city in unowned territory
		PillagedResourceAmounts			= int	default 0	total strategic resource amount for this resource that are on pillaged plots
		Plots					= {}*	an lua array-table with all plots having the resource recorded as "Values", except those in unclaimed territory
		WorkedPlots				= {}*	an lua array-table with all Worked plots having the resource recorded as "Values"
		WorkedPlotsThatAreNotPillaged		= {}*	an lua array-table with all Unpillaged Worked plots having the resource recorded as "Values"
		WorkedPlotsThatArePillaged		= {}*	an lua array-table with all Pillaged Worked plots having the resource recorded as "Values"
		WorkedPlotsWithIncorrectImprovement	= {}*	an lua array-table with all Worked plots having the resource but with an incorrect improvement for that resource recorded as "Values"
		WorkedPlotsWithNoImprovement		= {}*	an lua array-table with all Worked plots having the resource but no terrain improvemnent recorded as "Values"
		PillagedPlots				= {}*	an lua array-table with all Pillaged plots having the resource recorded as "Values"
		UnclaimedPlots				= {}*	an lua array-table with all Unowned plots having the resource recorded as "Values"
		ResourceIsRevealed			= bool	true/false as to whether the player has the tech that reveals the resource
		ResourceIsLuxury			= bool	true/false as to whether the resource is a luxury
		ResourceIsBonus				= bool	true/false as to whether the resource is a bonus
		ResourceIsStrategic			= bool	true/false as to whether the resource is a strategic
		ResourceIsArtifact			= bool	true/false as to whether the resource is either an Artifact or Hidden Artifact
		ResourceArtifactType			= text	"Not An Atrifact Or Hidden Artifact", "artifact", "hidden artifact"


		* in all these tables, 'pPlot' is recorded as the 'v' within the table so you can iterate through the table like as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			if tNearbyDatas.Resources[GameInfoTypes.RESOURCE_WHEAT] and (#NearbyResources.Resources[GameInfoTypes.RESOURCE_WHEAT].WorkedPlotsWithIncorrectImprovement > 0) then
				for k,v in pairs(tNearbyDatas.Resources[GameInfoTypes.RESOURCE_WHEAT].WorkedPlotsWithIncorrectImprovement) do
					if v:IsImprovementPillaged() then
						print("There is a pillaged wheat tile at " .. v:GetX() .. "," .. v:GetY() .. " that is being worked by the city and that has something else than a farm on it")
					end
				end
			end


....................................................................................................................................

7)	Description about Nearby Units data here


	a)

		---------------------------------------------------------------------------------------------------------------------
		PlayerUnitCount			= int	default 0
							number units near the city that belong to the city owner
		---------------------------------------------------------------------------------------------------------------------
		BarbarianCount			= int	default 0
							number units near the city that the city owner can see and that are barbarians
		---------------------------------------------------------------------------------------------------------------------
		EnemyCount			= int	default 0
							number units near the city that the city owner can see and that belong to enemy (at war) players
		---------------------------------------------------------------------------------------------------------------------
		AdversaryCount			= int	default 0
							number units near the city that the city owner can see and that belong to neutral players
		---------------------------------------------------------------------------------------------------------------------
		BarbarianInvisibleCount		= int	default 0
							number units near the city that the city owner cannot see and that are barbarians
		---------------------------------------------------------------------------------------------------------------------
		EnemyInvisibleCount		= int	default 0
							number units near the city that the city owner cannot see and that belong to enemy (at war) players
		---------------------------------------------------------------------------------------------------------------------
		AdversaryInvisibleCount		= int	default 0
							number units near the city that the city owner cannot see and that belong to neutral players
		---------------------------------------------------------------------------------------------------------------------
		PlayerUnits			= {}*	an lua array-table with units near the city belonging to the player recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------
		BarbarianUnits			= {}*	an lua array-table with units near the city that the city owner can see and that are
							barbarians recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------
		EnemyUnits			= {}*	an lua array-table with units near the city that the city owner can see and that belong
							to enemy (at war) players recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------
		AdversaryUnits			= {}*	an lua array-table with units near the city that the city owner can see and that belong to
							neutral players recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------
		BarbarianInvisibleUnits		= {}*	an lua array-table with units near the city that the city owner cannot see and that are
							barbarians recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------
		EnemyInvisibleUnits		= {}*	an lua array-table with units near the city that the city owner cannot see and that belong
							to enemy (at war) players recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------
		AdversaryInvisibleUnits		= {}*	an lua array-table with units near the city that the city owner cannot see and that belong
							to neutral players recorded as "Values"
		---------------------------------------------------------------------------------------------------------------------

		* in all these tables, 'pUnit' is recorded as the 'v' within the table so you can iterate through the table like as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			if tNearbyDatas.Units.BarbarianCount > 0 then
				for k,v in pairs(tNearbyDatas.Units.BarbarianUnits) do
					if v:GetPlot():GetOwner() == iPlayer then
						print("The Barb Unit at " .. v:GetX() .. "," .. v:GetY() .. " is in our territory!")
						v:ChangeDamage(10)
					end
				end
			end

....................................................................................................................................

8)	Description about Terrain Improvements data here




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



....................................................................................................................................

9)	Description about Other Cities data here

....................................................................................................................................




]]--
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxx<-- toolkit information to make the rest of the code run more efficiently -->xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

local tArtifactResourcesCityNearbyMapDatas = {[GameInfoTypes.RESOURCE_ARTIFACTS] = "artifact", [GameInfoTypes.RESOURCE_HIDDEN_ARTIFACTS] = "hidden artifact"}
local tResouceValidImprovementsCityNearbyMapDatas = {}
local tImprovementValidResoucesCityNearbyMapDatas = {}
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

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxx<-- toolkit functions to make the rest of the code run more efficiently -->xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

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

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx< Handler Routines to Simplify Data Extraction >xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------
--[[

	FilterTableContents(tCurrentTable, tAccumulatedTable)

	1)	Filters the contents of a table against those already within another table
	2)	The table that will have its contents filtered is expressed as the "tCurrentTable" argument
	3)	the table that will be filtered against is expressed as the "tAccumulatedTable" argument
	4)	the function returns two arguments in the following order: tNewTable, tAccumulatedTable
		a)	tNewTable
			This will be the original "tCurrentTable" with any 'v' items that were also present in the
			original "tAccumulatedTable" removed from "tCurrentTable"
		b)	tAccumulatedTable
			i)	This will be the original "tAccumulatedTable" with any new items from "tCurrentTable" added to
				it.
			ii)	"tAccumulatedTable" is used as a comprehensive list of all items that have been accounted for
				since "tAccumulatedTable" was created or last completely emptied.
	5)	Use as:

			local tMyWheatPlotsThisTurn = {}
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local iResourceID = GameInfoTypes.RESOURCE_WHEAT
			for pCity in pPlayer:Cities() do
				local tNearbyDatas = GetCityMapDatas(pCity)
				local tCityWheatPlots = GetCityImprovementPlotswithResource(tNearbyDatas, iImprovementID, iResourceID, "Owned")
				tCityWheatPlots, tMyWheatPlotsThisTurn = FilterTableContents(tCityWheatPlots, tMyWheatPlotsThisTurn)
				for Item,pPlot in pairs(tCityWheatPlots) do
					print("We have a Farm plot with Wheat on it near the city of " .. pCity:GetName() .. "! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
					print(" ")
				end
			end

		a)	Note that as in this example you should NOT localize the result of "FilterTableContents(tCityWheatPlots, tMyWheatPlotsThisTurn)"
			within a loop through a player's cities because this would create a 2nd version of "tMyWheatPlotsThisTurn" that would only be
			valid for each individual city in turn as that city is being processed by the loop through the player's cities.

			The word "local" does NOT appear on this line within the loop through the player's cities:

				tCityWheatPlots, tMyWheatPlotsThisTurn = FilterTableContents(tCityWheatPlots, tMyWheatPlotsThisTurn)

			This is the desired and correct method for using function FilterTableContents

	6)	Advanced Usage:

		If you do not clear the contents of table "tMyWheatPlotsThisTurn" after the termination of the loop through a player's cities,
		then "tMyWheatPlotsThisTurn" will be an lua table holding all of the player's owned wheat plots with farms on them. So, you could
		do as (note the new part AFTER the loop through the player's cities):

			local tMyWheatPlotsThisTurn = {}
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local iResourceID = GameInfoTypes.RESOURCE_WHEAT
			for pCity in pPlayer:Cities() do
				local tNearbyDatas = GetCityMapDatas(pCity)
				local tCityWheatPlots = GetCityImprovementPlotswithResource(tNearbyDatas, iImprovementID, iResourceID, "Owned")
				tCityWheatPlots, tMyWheatPlotsThisTurn = FilterTableContents(tCityWheatPlots, tMyWheatPlotsThisTurn)
				for Item,pPlot in pairs(tCityWheatPlots) do
					print("We have a Farm plot with Wheat on it near the city of " .. pCity:GetName() .. "! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
					print(" ")
				end
			end
			if #tMyWheatPlotsThisTurn > 0 then
				local iNumFarmedWheat = #tMyWheatPlotsThisTurn
				pPlayer:ChangeGold(iNumFarmedWheat)
				print(iNumFarmedWheat .. " Gold added to the player's treasury")
			end

]]--
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
--[[

	IsResourceRevealed

	1)	returns boolean true/false for whether the player has the required tech to reveal a map resource
	2)	Send the two arguments in order as (iPlayer, iResourceID)
		a)	iPlayer		the player's player ID# from the active in-game list of players
		b)	iResourceID	the ID # of the map resource
	3)	lua does not pay attention to whether the player has the correct tech for the resource when Plot:GetResourceType()
		is invoked unless the eTeam argument to Plot:GetResourceType() is used. But when a plot object is not available, or
		when a "do not proceed with code" filter is needed BEFORE the plot objects are available, a routine like this is needed.

]]--
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
--[[

	GetCityImprovementPlots

	1)	Returns a list of plots for the specified improvement. If the improvement is not present near the city
		the returned table will be an empty table
	2)	State parameters in the order of (tTable, iImprovementID, sDataType)
		a)	tTable		=	the tablename of city data previously collected from GetCityMapDatas()
		b)	iImprovementID	=	the ID# of the terrain improvement
		c)	sDataType	=	text string of the desired list of plots
	3)	Allowed designations for "sDataType" are:
			"Plots"
				table with all plots having the improvmeent recorded as "Values", except those in unclaimed territory
			"WorkedPlots"
				table with all Worked plots having the improvmeent recorded as "Values"
			"WorkedPlotsThatAreNotPillaged"
				table with all Unpillaged Worked plots having the improvmeent recorded as "Values"
			"WorkedPlotsThatArePillaged"
				table with all Pillaged Worked plots having the improvmeent recorded as "Values"
			"WorkedPlotsWithIncorrectImprovementForResource"
				table with all Worked plots having the improvmeent and where the improvement is incorrect
				for the plot's resource recorded as "Values"
			"UnWorkedPlotsWithIncorrectImprovementForResource"
				table with all Unworked plots having the improvmeent and where the improvement is incorrect
				for the plot's resource recorded as "Values"
			"PillagedPlots"
				table with all Pillaged plots having the improvmeent recorded as "Values"
			"UnclaimedPlots"
				table with all Unowned plots having the improvmeent recorded as "Values"
			"PlotsWithCorrectResources"
				table with all plots having both the improvement and a resource that is correct for the improvement recorded as "Values"
			"PlotsWithInCorrectResources"
				table with all plots having both the improvement and an incorrect resource for the improvement recorded as "Values"
	4)	Use as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local tFarmedPlots = GetCityImprovementPlots(tNearbyDatas, iImprovementID, "WorkedPlots")
			for Item,pPlot in pairs(tFarmedPlots) do
				print("We Have a plot with a Farm on it! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
			end


]]--
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
--[[

	GetNumCityWorkingImprovementPlots

	1)	returns the integer number of plots with the specified improvement that the city is working


]]--
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
--[[

	DoesImprovementExistNearCity

	1)	returns true/false for whether a the specified improvement exists on the map near the city


]]--
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
--[[

	DoUnpillagedImprovmeentsExistNearCity

	1)	returns true/false for whether any unpillaged plots with the specified improvement exists on the map near the city
	2)	Plots that are Worked by the city, Owned by the city owner, or which are unowned will be considered for the end result


]]--
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
--[[

	GetNumCityImprovementPlotsWithResource
	GetCityImprovementPlotswithResource

	1)	The callig methods and required parameters are the same between the two functions. The difference is in the
		type of data returned
		a)	GetNumCityImprovementPlotsWithResource
				returns the integer number of plots with the specified improvement that also have the specified resource
		b)	GetCityImprovementPlotswithResource
				returns a table of plots with the specified improvement that also have the specified resource

	2)	State parameters in the order of (tTable, iImprovementID, iResourceID, sData1, sData2, sData3, sData4)
		a)	tTable		=	the tablename of city data previously collected from GetCityMapDatas()
		b)	iImprovementID	=	the ID# of the terrain improvement
		c)	iResourceID	=	the ID# of the terrain resource

	3)	sData1, sData2, sData3, sData4
		a)	As many of these as desired can be stated, but they must follow the three parameters as listed in #2
		b)	They are all stated as text strings and designate additional limitations on the counts made
		c)	The order in which a particular limitation method is stated does not matter
		d)	Allowed limitations are
			I)	"Owned"			the player must own the plot
			II)	"Unpillaged"		the plot must not be pillaged
			III)	"ResourceIsRevealed"	the player has to have the tech that reveals the resource
			IV)	"Worked"		the city has to be working the plot
		e)	trailing parameters for these extra designations can be omitted

	4)	Use GetNumCityImprovementPlotsWithResource as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local iResourceID = GameInfoTypes.RESOURCE_WHEAT
			local iNumFarmedWheat = GetNumCityImprovementPlotsWithResource(tNearbyDatas, iImprovementID, iResourceID, "Worked", "Unpillaged")
			if iNumFarmedWheat > 0 then
				print("We have " .. iNumFarmedWheat .. " near the city of " .. pCity:GetName() .. " that we are actually working")
				print("HURRAH!!! We can make bread. That is, if we have figured out how to make ovens.")
			end 

		or as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iNumFarmedWheat = GetNumCityImprovementPlotsWithResource(tNearbyDatas, GameInfoTypes.IMPROVEMENT_FARM, GameInfoTypes.RESOURCE_WHEAT, "Unpillaged", "Worked" )
			if iNumFarmedWheat > 0 then
				print("We have " .. iNumFarmedWheat .. " near the city of " .. pCity:GetName() .. " that we are actually working")
				print("HURRAH!!! We can make bread. That is, if we have figured out how to make ovens.")
			end 

	5)	Use GetCityImprovementPlotswithResource as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local iResourceID = GameInfoTypes.RESOURCE_WHEAT
			local tFarmedWheat = GetCityImprovementPlotswithResource(tNearbyDatas, iImprovementID, iResourceID, "Worked", "Unpillaged")
			for k,pPlot in pairs(tFarmedWheat) do
				print("We have a farmed Wheat tile near the city of " .. pCity:GetName() .. " that we are actually working located at X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
				print("HURRAH!!! We can make bread. That is, if we have figured out how to make ovens.")
			end 

		or as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local tFarmedWheat = GetCityImprovementPlotswithResource(tNearbyDatas, GameInfoTypes.IMPROVEMENT_FARM, GameInfoTypes.RESOURCE_WHEAT, "Unpillaged", "Worked" )
			for k,pPlot in pairs(tFarmedWheat) do
				print("We have a farmed Wheat tile near the city of " .. pCity:GetName() .. " that we are actually working located at X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
				print("HURRAH!!! We can make bread. That is, if we have figured out how to make ovens.")
			end 



]]--
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
--[[

	GetImprovementPlotsWithResources

	1)	Returns a list of plots for the specified improvement. If the improvement is not present near the city
		the returned table will be an empty table. The routine only collects all plots with the specified improvement
		that also have a resource. It does not sort out whether the resource is correct for the improvement
	2)	State parameters in the order of (tTable, iImprovementID, sDataType)
		a)	tTable		=	the tablename of city data previously collected from GetCityMapDatas()
		b)	iImprovementID	=	the ID# of the terrain improvement
	3)	When using this function, you will have to write additional code to scan through the list of plots returned
		and sort out such issues as whether the plot belongs to the city-owner, whether the plot is being worked by the
		city, etc.
	4)	Use as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local tFarmedPlots = GetImprovementPlotsWithResources(tNearbyDatas, iImprovementID)
			for Item,pPlot in pairs(tFarmedPlots) do
				print("We Have a plot with a Farm on it! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
				print("The plot has a resource but it might not be a correct resource for a farm")
			end

	5)	To get a list of plots with the same improvement and which have a correct map resource for that improvement,
		instead of this function, use function GetCityImprovementPlots as so:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local tFarmedPlots = GetCityImprovementPlots(tNearbyDatas, iImprovementID, "PlotsWithCorrectResources")
			for Item,pPlot in pairs(tFarmedPlots) do
				print("We Have a plot with a Farm on it! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
			end

		In this particular example only farm plots with wheat on them would be returned

	6)	To get a list of plots with the same improvement and which have an incorrect map resource for that improvement,
		instead of this function, use function GetCityImprovementPlots as so:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iImprovementID = GameInfoTypes.IMPROVEMENT_FARM
			local tFarmedPlots = GetCityImprovementPlots(tNearbyDatas, iImprovementID, "PlotsWithInCorrectResources")
			for Item,pPlot in pairs(tFarmedPlots) do
				print("We Have a plot with a Farm on it! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
			end

		For example, plots near the city that have the iron resource and a farm on them would be returned to you. Plots with other
		similar "Farms + Bad Resources for Farms" conditions would also be included.

]]--
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
--[[

	GetCityResourcePlots

	1)	Returns a list of plots for the specified resource. If the resource is not present near the city
		the returned table will be an empty table
	2)	State parameters in the order of (tTable, iResourceID, sDataType)
		a)	tTable		=	the tablename of city data previously collected from GetCityMapDatas()
		b)	iResourceID	=	the ID# of the map resource
		c)	sDataType	=	text string of the desired list of plots
	3)	Allowed designations for "sDataType" are:
			"Plots"					= table with all plots having the resource recorded as "Values",
								  except those in unclaimed territory
			"WorkedPlots"				= table with all Worked plots having the resource recorded as "Values"
			"WorkedPlotsThatAreNotPillaged"		= table with all Unpillaged Worked plots having the resource recorded as "Values"
			"WorkedPlotsThatArePillaged"		= table with all Pillaged Worked plots having the resource recorded as "Values"
			"WorkedPlotsWithIncorrectImprovement"	= table with all Worked plots having the resource but with an incorrect improvement
								  for that resource recorded as "Values"
			"WorkedPlotsWithNoImprovement"		= table with all Worked plots having the resource but no terrain improvemnent
								  recorded as "Values"
			"PillagedPlots"				= table with all Pillaged plots having the resource recorded as "Values"
			"UnclaimedPlots"			= table with all Unowned plots having the resource recorded as "Values"
	4)	Use as:

			local tNearbyDatas = GetCityMapDatas(pCity)
			local iResourceID = GameInfoTypes.RESOURCE_WHEAT
			local tResourcePlots = GetCityResourcePlots(tNearbyDatas, iResourceID, "WorkedPlots")
			for Item,pPlot in pairs(tResourcePlots) do
				print("We Have a plot with Wheat on it! The plot's location is X" .. pPlot:GetX() .. ", Y" ..  pPlot:GetY())
			end


]]--
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
--[[

	DoesResourceExistNearCity

	1)	returns true/false for whether a the specified resource exists on the map near the city


]]--
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
--[[

	CityIsWorkingResourcePlots


	1)	returns true/false for whether a city is working a plot with the specified resource

]]--
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
--[[

	GetNumCityWorkingResourcePlots

	1)	returns the integer number of plots with the specified resource that the city is working


]]--
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
--[[

	 GetNumCityUnclaimedResourcePlots

	1)	returns the integer number of unclaimed (unowned) plots with the specified resource that are within the city's working range


]]--
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
--[[

	EnemyUnitsAreNearCity

	1)	returns true/false for whether Enemy, Adversary, or Barbarian units are near the city
	2)	Allows setting of parameters "tTable", "sEnemyType", and "sMustBeVisible"
	3)	tTable must be the table of data gathered by function GetCityMapDatas()
	4)	sEnemyType is given as a text string and must be one of:
		a)	"Barbarians"	only looks for Barbarian units
		b)	"Players"	only looks for units of enemy non-barbarian players
					only players of units the city owner is at war with are considered
		c)	"Any"		looks for any enemy unit, "Barbarians" or "Players"
	5)	sMustBeVisible is given as a text string and must be either of:
		a)	"MustBeVisible"
		b)	otherwise omit the parameter entirely
	6)	State as in the following examples:

			local tNearbyDatas = GetCityMapDatas(pCity)
			if EnemyUnitsAreNearCity(tNearbyDatas, "Barbarians", "MustBeVisible") then
				print("Barbarians Detected Near the City of " .. pCity:GetName .. "!")
			end
		..................................................................................

			local tNearbyDatas = GetCityMapDatas(pCity)
			if EnemyUnitsAreNearCity(tNearbyDatas, "Players", "MustBeVisible") then
				print("The City of " .. pCity:GetName .. " is under attack!")
			end
	

]]--
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
--[[

	CountPlayerUnitsNearCity

	I haven't made the description yet but you can see examples of use in the Lua Script1.lua file
	It will return the number of units belonging to the city owner and that are within the 3-tile-range of the city
	You can designate whether to count only combat or only civilian units
	You can designate whether to count only units of certain domains

]]--
-----------------------------------------------------------------------------------------------------------------------------------------------

function CountPlayerUnitsNearCity(tTable, ...)
	local tAllowedSettings = {["Combat"] = "Combat", ["Civilian"] = "Civilian", ["Land"] = "DOMAIN_LAND", ["Sea"] = "DOMAIN_SEA",
					["Air"] = "DOMAIN_AIR", ["Hover"] = "DOMAIN_HOVER", ["Immobile"] = "DOMAIN_IMMOBILE" }
	return UnitCountTypes(tTable, "Counts", "PlayerUnitCount", "PlayerUnits", tAllowedSettings, {...})
end



-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------
--[[

	GetPlayerUnitsNearCity

	I haven't made the description yet
	It will return a table of unit objects for units belonging to the city owner and that are within the 3-tile-range of the city
	You can designate whether to gather only combat or only civilian units
	You can designate whether to gather only units of certain domains

]]--
-----------------------------------------------------------------------------------------------------------------------------------------------

function GetPlayerUnitsNearCity(tTable, ...)
	local tAllowedSettings = {["Combat"] = "Combat", ["Civilian"] = "Civilian", ["Land"] = "DOMAIN_LAND", ["Sea"] = "DOMAIN_SEA",
					["Air"] = "DOMAIN_AIR", ["Hover"] = "DOMAIN_HOVER", ["Immobile"] = "DOMAIN_IMMOBILE" }
	return UnitCountTypes(tTable, "Units", "PlayerUnitCount", "PlayerUnits", tAllowedSettings, {...})
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--					xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----------------------------------------------------------------------------------------------------------------------------------------------
--[[

	AreEnemyUnitsOfTypeNearby(tTable, sReturnMethod, sUnitType, sEnemyType, sMustBeVisible, sMakeNotification, sNotifyOnce)

	I haven't made the description yet
	It will return a table of unit objects for units belonging to the city owner and that are within the 3-tile-range of the city
	You can designate whether to gather only combat or only civilian units
	You can designate whether to gather only units of certain domains

]]--
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

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx<-- Main City-Plot Scanning Function -->xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

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
			local tPlotResourceData = GameInfo.Resources[iResourceID]
			local bPlotHasResourceAmount = (pPlot:GetNumResource() > 0)
			local iPlotOwner = pPlot:GetOwner()
			local bPlotIsOwnedByPlayer = (iPlotOwner == iPlayer)
			local bPlotIsNotOwned = (iPlotOwner == -1)
			local iImprovementID = pPlot:GetImprovementType()
			local bPlotHasImprovement = (iImprovementID ~= -1)
			local tPlotImprovementData = GameInfo.Improvements[iImprovementID]

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
						bImprovementIsCorrectForMapResource = (tImprovementValidResourcesCityNearbyMapDatas[iImprovementID][iResourceID] ~= nil)
						if bImprovementIsCorrectForMapResource then
							table.insert(tCityNearbyDatas.Improvements[iImprovementID].PlotsWithCorrectResources, pPlot)
						else
							tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWithIncorrectImprovementForResource = tCityNearbyDatas.Improvements[iImprovementID].NumPlotsWithIncorrectImprovementForResource + 1
							table.insert(tCityNearbyDatas.Improvements[iImprovementID].PlotsWithInCorrectResources, pPlot)
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
							ResourceAmount = 0, UnClaimedResourceAmounts = 0, PillagedResourceAmounts = 0, CityResourceAmount = 0,
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
							if bResourceIsStrategic and (bPlotHasResourceAmount) and not pPlot:IsImprovementPillaged() then
								tCityNearbyDatas.Resources[iResourceID].ResourceAmount = tCityNearbyDatas.Resources[iResourceID].ResourceAmount + pPlot:GetNumResource()
								if bResourceIsCorrectlyImproved then
									tCityNearbyDatas.Resources[iResourceID].CityResourceAmount = tCityNearbyDatas.Resources[iResourceID].CityResourceAmount + pPlot:GetNumResource()
								end
							end
							if pPlot:IsImprovementPillaged() then
								tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCityThatArePillaged = tCityNearbyDatas.Resources[iResourceID].NumPlotsWorkedByCityThatArePillaged + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].WorkedPlotsThatArePillaged, pPlot)
								tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots = tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].PillagedPlots, pPlot)
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
								end
								if not bResourceIsCorrectlyImproved and (bPlotHasImprovement) then
									tCityNearbyDatas.Resources[iResourceID].NumPlotsWithIncorrectImprovement = tCityNearbyDatas.Resources[iResourceID].NumPlotsWithIncorrectImprovement + 1
								end
							else
								tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots = tCityNearbyDatas.Resources[iResourceID].NumPillagedPlots + 1
								table.insert(tCityNearbyDatas.Resources[iResourceID].PillagedPlots, pPlot)
								if bResourceIsStrategic and (bPlotHasResourceAmount) then
									tCityNearbyDatas.Resources[iResourceID].PillagedResourceAmounts = tCityNearbyDatas.Resources[iResourceID].PillagedResourceAmounts + pPlot:GetNumResource()
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
						if bResourceIsStrategic and (bPlotHasResourceAmount) then
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


