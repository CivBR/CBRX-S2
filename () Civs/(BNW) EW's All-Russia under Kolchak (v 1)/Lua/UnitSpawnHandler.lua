-- UnitSpawnHandler
-- Author: LeeS
-- DateCreated: 5/11/2015 7:44:08 AM
-- Special Thanks to whoward69 (W.Howard) for some suggestions on code streamlining

--------------------------------------------------------------
-------------------------------------------------------------------------
--Unit Spawn Handler
--this started as whoward's function of the same name but has grown into
--		a bit of a monster
-------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


-- CHANGE NOTHING IN THIS FILE

--'include' this file in the main lua file by the statement: include("UnitSpawnHandler.lua")
--set this file in ModBuddy as Import Into VFS=true

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx











---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--debug printing control
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

local bDebugPrint = false
local function dprint(...)
  if (bDebugPrint) then
    print(string.format(...))
  end
end

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--global constants used by this handler
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

local gCityAirStandardCapacity = GameDefines.BASE_CITY_AIR_STACKING

local gDomainAir = GameInfoTypes.DOMAIN_AIR
local gDomainLand = GameInfoTypes.DOMAIN_LAND
local gDomainSea = GameInfoTypes.DOMAIN_SEA

CarrierUnits = {}
for row in DB.Query("SELECT ID FROM Units WHERE DomainCargo = 'DOMAIN_AIR' AND SpecialCargo = 'SPECIALUNIT_FIGHTER' AND Domain = 'DOMAIN_SEA'") do
        CarrierUnits[row.ID] = true
end
gAirports = {}
for row in DB.Query("SELECT ID, AirModifier FROM Buildings WHERE AirModifier != 0") do
    gAirports[row.ID] = row.AirModifier
end
dprint("gCityAirStandardCapacity is calculated as " .. gCityAirStandardCapacity)

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--- functions used by this handler
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

------------------------------------------------------------------------------------------------------
--SpawnAtPlot is the main function for spawning a unit via lua
-----------------------------------------------------------------------------------------------------

function SpawnAtPlot(pPlayer, iUnitType, PlotX, PlotY, iExperience, iDamage, sUnitName, sPromotionTableName)
	if bDebugPrint then
		print("Running Function SpawnAtPlot with the following passed values:")
		print("iUnitType was passed as : " .. iUnitType .. " (" .. GameInfo.Units[iUnitType].Type .. ")")
	end
	local pUnit = "NONE"
	local pPlot = Map.GetPlot(PlotX, PlotY)
	local iUnitDomain = GameInfoTypes[GameInfo.Units[iUnitType].Domain]
	local bCanLandOnCarrier = (GameInfo.Units[iUnitType].Domain == "DOMAIN_AIR") and (GameInfo.Units[iUnitType].Special == "SPECIALUNIT_FIGHTER")
	local bCheckForJumpResult, bCivilianMode = CheckForJump(pPlayer, pPlot, iUnitDomain, iUnitType, bCanLandOnCarrier)
	if bCheckForJumpResult == "NONE" then return end
	if bCheckForJumpResult then
		if iUnitDomain == gDomainLand then
			local pValidLandUnitWaterPlot = "NONE"
			if pPlot:IsLake() or pPlot:IsWater() then
				pValidLandUnitWaterPlot = GetValidLandUnitWaterJumpPlot(pPlayer, pPlot)
			end
			if pValidLandUnitWaterPlot == "NONE" then
				local pNewUnit = pPlayer:InitUnit(iUnitType, PlotX, PlotY)
				pNewUnit:JumpToNearestValidPlot()
				pUnit = pNewUnit
			else pUnit = pPlayer:InitUnit(iUnitType, pValidLandUnitWaterPlot:GetX(), pValidLandUnitWaterPlot:GetY())
			end
		elseif iUnitDomain == gDomainSea then
			local pNewUnit = pPlayer:InitUnit(iUnitType, PlotX, PlotY)
			pNewUnit:JumpToNearestValidPlot()
			pUnit = pNewUnit
		elseif iUnitDomain == gDomainAir then
			pAirJumpPlot = GetValidAirJumpPlot(pPlayer, pPlot, bCanLandOnCarrier)
			if pAirJumpPlot then
				pUnit = pPlayer:InitUnit(iUnitType, pAirJumpPlot:GetX(), pAirJumpPlot:GetY())
			else
				dprint("there was no valid plot for the Air Unit to jump to, unit has been removed from play")
				return
			end
		end
	else
		pUnit = pPlayer:InitUnit(iUnitType, PlotX, PlotY)
	end
	pUnit:SetExperience(iExperience)
	pUnit:SetDamage(iDamage)
	if sUnitName and sUnitName ~= "NONE" and sUnitName ~= nil and sUnitName ~= "NO_NAME" then
		pUnit:SetName(sUnitName)
	end
	if iUnitDomain == gDomainLand then
		pCurrentUnitPlot = pUnit:GetPlot()
		if pCurrentUnitPlot:IsLake() or pCurrentUnitPlot:IsWater() then
			pUnit:SetEmbarked(true)
			pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_ALLWATER_EMBARKATION"], true)
		end
	end
	if sPromotionTableName ~= nil and sPromotionTableName ~= "NO_PROMOTION" and sPromotionTableName ~= "NONE" then
	        if type(sPromotionTableName) == "string" then
	            sPromotionTableName = {sPromotionTableName}
		end
	        -- Now we always have a table of strings
	        if #sPromotionTableName > 0 then
			for k,v in pairs(sPromotionTableName) do
				if CheckPromotionValidity(iUnitType, v, bCivilianMode) then
					pUnit:SetHasPromotion(GameInfoTypes[v], true)
					dprint("The unit was given the promotion " .. v)
				else dprint("The unit could not be given the promotion " .. v)
				end
			end
	        end
	end
end

------------------------------------------------------------------------------------------------------
--UpdateEmbarkedUnitGraphics is used to update all embarked land unit graphics
--	use once at the end of placing a series of land units onto water tiles
-----------------------------------------------------------------------------------------------------

function UpdateEmbarkedUnitGraphics(pPlayer)
	Teams[pPlayer:GetTeam()]:UpdateEmbarkGraphics()
end

-----------------------------------------------------------------------------------------------------------------
--CheckPromotionValidity determines whether the specified promotion is valid for the type of unit being spawned
--	it looks only at whether the promotion is valid EVER for that unit
--	it ignores issues of prereq promotions or technologies
--	returns true if the promotion is EVER valid for that type of unit
-----------------------------------------------------------------------------------------------------------------

function CheckPromotionValidity(iUnitTypeID, sPromoString, bCivilianMode)
	if bDebugPrint then
		print("Running Function CheckPromotionValidity with the following passed values:")
		print("iUnitTypeID was passed as : " .. iUnitTypeID .. " (" .. GameInfo.Units[iUnitTypeID].Type .. ")")
		print("sPromoString was passed as : " .. sPromoString)
		print("bCivilianMode was passed as : " .. tostring(bCivilianMode))
	end
	local sUnitCombatType = GameInfo.Units[iUnitTypeID].CombatClass
	if sUnitCombatType == "NULL" or sUnitCombatType == nil or sUnitCombatType == 0 then
		sUnitCombatType = "NONE"
	end
	dprint("sUnitCombatType for the unit was calculated as " .. sUnitCombatType)
	local bWasAPromoMatch = false
	for row in GameInfo.UnitPromotions_UnitCombats() do
		if tostring(row.PromotionType) == sPromoString then
			dprint("There WAS a MATCH for " .. sPromoString .. " within a <Row> in Game-Table UnitPromotions_UnitCombats")
			bWasAPromoMatch = true
			if bCivilianMode == false and sUnitCombatType ~= "NONE" then
				dprint("bCivilianMode == false and sUnitCombatType ~= NONE (ie, the unit has a valid UnitCombatType and is not a civilian unit)")
				if tostring(row.UnitCombatType) == sUnitCombatType then
					dprint("There WAS a MATCH for " .. sUnitCombatType .. " within THE SAME <Row> in Game-Table UnitPromotions_UnitCombats, returning TRUE from CheckPromotionValidity")
					return true
				end
			end
		end
	end
	if bWasAPromoMatch then
		if bCivilianMode then
			if bDebugPrint then
				print("There WAS a MATCH for " .. sPromoString .. " within a <Row> in Game-Table UnitPromotions_UnitCombats, but the unit is a civilian unit, therefore the promotion is invalid")
				print("Returning FALSE")
			end
			return false
		else
			if bDebugPrint then
				print("There WAS a MATCH for " .. sPromoString .. " within a <Row> in Game-Table UnitPromotions_UnitCombats, but it did not match-up with the units CombatClass, therefore the promotion is invalid")
				print("Returning FALSE")
			end
			return false
		end
	else
		if bDebugPrint then
			print("There was NO MATCH for " .. sPromoString .. " within a <Row> in Game-Table UnitPromotions_UnitCombats, so all units should be valid for the promotion")
			print("Returning TRUE")
		end
		return true
	end
	if bDebugPrint then
		print("Somehow we got to the FailSafe line, which shouldn't ought to happen if the logic is correct, but since we are here there is something rotten going on")
		print("DEFAULTING TO and Returning FALSE")
	end
	return false
end

------------------------------------------------------------------------------------------------------
--CheckForJump determines whether the specified plot is valid for the type of unit being spawned
--	if the plot is occupied, or is a city not belonging to the player
--	or has a Carrier Unit that is already at capacity
--	or is a city that is at capacity for air units
--	the function returns "true"
-----------------------------------------------------------------------------------------------------

function CheckForJump(pPlayer, pPlot, iDomainType, iUnitType, bCanLandOnCarrier)
	dprint("running function CheckForJump")
	local result = false
	local bCivilianMode = "NONE"
	local bCarrierAtPlot = false
	local bCarrierIsFull = true
	local iCityAirCapacity = 0
	local bCityAtPlot = pPlot:IsCity()
	local bPlotIsWaterOrLake = pPlot:IsLake() or pPlot:IsWater()
	local sCivilianAttackPriority = GameInfo.Units[iUnitType].CivilianAttackPriority
	--dprint(sCivilianAttackPriority)
	local sCombatClass = GameInfo.Units[iUnitType].CombatClass
	--dprint(sCombatClass)
	if iDomainType ~= gDomainAir then
		dprint("Unit was determined not to be an AIR unit for purposes of civilian unit determination")
		if sCivilianAttackPriority == "NULL" or sCivilianAttackPriority == "NONE" or sCivilianAttackPriority == "NIL" or sCivilianAttackPriority == nil then
			if sCombatClass ~= "NULL" and sCombatClass ~= "NONE" and sCombatClass ~= "NIL" and sCombatClass ~= nil then
				bCivilianMode = false
			end
		else
			if sCombatClass == "NULL" or sCombatClass == "NONE" or sCombatClass == "NIL" or sCombatClass == nil then
				bCivilianMode = true
			end
		end
	else bCivilianMode = false
	end
	if bCivilianMode == "NONE" then
		if bDebugPrint then
			print("Irreconcilable settings of Combat Class " .. tostring(sCombatClass) .. " and Civilian Attack Priority " .. tostring(sCivilianAttackPriority) .. " in determining if the unit is a Civilian Unit")
			print("ENDING THE FUNCTION WITHOUT A UNIT SPAWN")
		end
		return bCivilianMode, bCivilianMode
	end
	if bCityAtPlot then
		dprint("the targetted plot is a city")
		local pJumpCheckCity = pPlot:GetPlotCity()
		if (Players[pPlot:GetOwner()] ~= pPlayer) or (Players[pJumpCheckCity:GetOwner()] ~= pPlayer) then
			dprint("Because the City Owner is different from the Current Player the result for whether the unit should jump was true")
			return true, bCivilianMode
		end
	end
	if iDomainType == gDomainAir then
		dprint("the unit is an AIR unit while checking for whether the targert plot is a city before calculating the city air capacity")
		if bCityAtPlot then
			iCityAirCapacity = CalculateCityAirCapacity(pPlot:GetPlotCity())
		end
	end
	local iNumCombatUnits = 0
	for i = 0, pPlot:GetNumUnits() do
		local pPlotUnit = pPlot:GetUnit(i)
		if pPlotUnit then
			if Players[pPlotUnit:GetOwner()] ~= pPlayer then
				dprint("The target plot was occupied by a unit belonging to another player so the result for whether the unit should jump was true")
				return true, bCivilianMode
			end
			if pPlotUnit:IsCombatUnit() or pPlotUnit:GetDomainType() == gDomainAir then
				dprint("running a check for a unit that is " .. pPlotUnit:GetUnitType() .. " (" .. GameInfo.Units[pPlotUnit:GetUnitType()].Type .. ")")
				--check whether the unit is a carrier and get its capacity status
				if CheckForCarrierUnit(pPlotUnit:GetUnitType()) then
					dprint("there is an Aircraft Carrier on the target plot")
					bCarrierAtPlot = true
					bCarrierIsFull = pPlotUnit:IsFull()
					dprint("the Aircraft Carrier is FULL = " .. tostring(bCarrierIsFull))
				end
				if pPlotUnit:GetDomainType() == iDomainType then
					if bPlotIsWaterOrLake and pPlotUnit:GetDomainType() == gDomainLand then
						return true, bCivilianMode
					end
					dprint("iNumCombatUnits is increased by 1")
					iNumCombatUnits = iNumCombatUnits + 1
				end
			else
				if bCivilianMode then
					dprint("the result for whether the unit should jump was true for a Civilian unit")
					return true, bCivilianMode
				end
			end
		end
	end
	if iDomainType == gDomainAir then
		dprint("While determining if the plot is full for aircraft, the unit is an air unit")
		if bCityAtPlot then
			dprint("The plot was determined to be a city with " .. iCityAirCapacity .. " Air unit capacity")
			if iNumCombatUnits >= iCityAirCapacity then
				result = true
				dprint("The city was determined to already be at its Air unit capacity")
			end
		elseif bCarrierAtPlot then
			if bCanLandOnCarrier then
				result = bCarrierIsFull
				if bDebugPrint then
					print("The plot was determined to have an aircraft carrier")
					print("The aircraft carrier AT FULL CAPACITY status was determined as " ..tostring(result))
				end
			else result = true
				if bDebugPrint then
					print("The unit cannot land on a Carrier, and there was no City at the plot the Air Unit could land on")
					print("The Air Unit was required to jump to another plot than the original target plot")
				end
			end
		else result = true
		end
	else
		if not bCivilianMode then
			if iNumCombatUnits > 0 then
				result = true
			end
		else result = false
		end
	end
	dprint("the result for whether the unit should jump was " .. tostring(result))
	return result, bCivilianMode
end

------------------------------------------------------------------------------------------------------
--GetValidAirJumpPlot looks for a good plot to place an Air Unit when the Air Unit cannot
--	be placed at the original specified tile.
--	If the original required plot was a city, it will look for a City to which the Air Unit can be placed 1st
--	If the original required plot was not a city, it will look for a Carrier Unit to which the Air Unit can be placed 1st
--	It will look for a City or a Carrier to which the Air Unit can be placed 2nd when the 1st search fails
--	the function returns the plot that is good
--	the function returns "nil" when no plot can be found
--	the function does NOT pay attention to the normal rebasing range restrictions
-----------------------------------------------------------------------------------------------------

function GetValidAirJumpPlot(pPlayer, pPlot, bCanLandOnCarrier)
	local pJumpToPlot = "NONE"
	if pPlot:IsCity() then
		pJumpToPlot = LookForAValidAirUnitCity(pPlayer, pPlot)
		if pJumpToPlot == "NONE" then
			if bCanLandOnCarrier then
				pJumpToPlot = LookForValidCarrier(pPlayer, pPlot)
			end
		end
	else
		if bCanLandOnCarrier then
			pJumpToPlot = LookForValidCarrier(pPlayer, pPlot)
		end
		if pJumpToPlot == "NONE" then
			pJumpToPlot = LookForAValidAirUnitCity(pPlayer, pPlot)
		end
	end
	if pJumpToPlot ~= "NONE" then
		return pJumpToPlot
	else
		return nil
	end
end

------------------------------------------------------------------------------------------------------
--GetValidLandUnitWaterJumpPlot looks for a good plot to place a Land Unit when the Land Unit cannot
--	be placed at the original specified tile.
--	the function looks at the adjacent tiles only
--	the function only looks for water plots, and only runs when the orignal target plot was a water tile
--		ie, it is only called to run when the original target tile was lake or other water
--	the function returns the plot that is good
--	the function returns "NONE" when no plot can be found
-----------------------------------------------------------------------------------------------------

function GetValidLandUnitWaterJumpPlot(pPlayer, pPlot)
	local pJumpToPlot = "NONE"
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local pAdjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
		local bPlotCanBeUsed = true
		if pAdjacentPlot then
			if pAdjacentPlot:IsLake() or pAdjacentPlot:IsWater() then
				if pAdjacentPlot:IsUnit() then
					for i = 0, pAdjacentPlot:GetNumUnits() do
						local pPlotUnit = pAdjacentPlot:GetUnit(i)
						if pPlotUnit and pPlotUnit:GetDomainType() == gDomainLand then
							bPlotCanBeUsed = false
						end
					end
					if bPlotCanBeUsed then
						return pAdjacentPlot
					end
				else return pAdjacentPlot
				end
			end
		end
	end
	return pJumpToPlot
end


------------------------------------------------------------------------------------------------------
--Look Through A Player's Cities for a Valid City for the Air Unit to land on
--	cities being razed can never be picked
-----------------------------------------------------------------------------------------------------

function LookForAValidAirUnitCity(pPlayer, pPlot)
	local pNearestCityPlot = "NONE"
	local iShortestDistance = Map.MaxPlotDistance()
	for city in pPlayer:Cities() do
		if not city:IsRazing() then
			local iCityAirCapacity = CalculateCityAirCapacity(city)
			pCityPlot = city:Plot()
			local iNumberAirUnits = CalculateNumberAirUnits(pCityPlot)
			if iNumberAirUnits < iCityAirCapacity then
				local iCityPlotDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCityPlot:GetX(), pCityPlot:GetY())
				if iCityPlotDistance < iShortestDistance then
					iShortestDistance = iCityPlotDistance
					pNearestCityPlot = pCityPlot
				end
			end
		end
	end
	return pNearestCityPlot
end

------------------------------------------------------------------------------------------------------
--Look Through A Player's Units for a Valid Carrier for the Air Unit to land on
--	looks through adjacent plots before looking elsewhere for a Carrier to land on
-----------------------------------------------------------------------------------------------------

function LookForValidCarrier(pPlayer, pPlot)
	local pNearestCarrierPlot = "NONE"
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local pAdjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
		if pAdjacentPlot and pAdjacentPlot:IsUnit() then
			for i = 0, pAdjacentPlot:GetNumUnits() do
				local pPlotUnit = pAdjacentPlot:GetUnit(i)
				if pPlotUnit then
					if CheckForCarrierUnit(pPlotUnit:GetUnitType()) then
						if not pPlotUnit:IsFull() then
							return pAdjacentPlot
						end
					end
				end
			end
		end
	end
	local iShortestDistance = Map.MaxPlotDistance()
	for Unit in pPlayer:Units() do
		if CheckForCarrierUnit(Unit:GetUnitType()) then
			if not Unit:IsFull() then
				pUnitPlot = Unit:GetPlot()
				local iCarrierPlotDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pUnitPlot:GetX(), pUnitPlot:GetY())
				if iCarrierPlotDistance < iShortestDistance then
					iShortestDistance = iCarrierPlotDistance
					pNearestCarrierPlot = pUnitPlot
				end
			end
		end
	end
	return pNearestCarrierPlot
end

------------------------------------------------------------------------------------------------------
--CalculateCityAirCapacity determines the total Air Unit capacity of the city
--	it returns that calculated value as an integer
-----------------------------------------------------------------------------------------------------

function CalculateCityAirCapacity(pCity)
    local iCityAirCapacity = gCityAirStandardCapacity
    dprint("the targetted plot is a city and the unit to be spawned is an AIR DOMAIN unit")
    
    for iBuilding, iAirModifier in pairs(gAirports) do
        if (pCity:IsHasBuilding(iBuilding)) then
            dprint("the city has airlift building " .. iBuilding .. " (" .. GameInfo.Buildings[iBuilding].Type .. ") adding " .. iAirModifier)
            -- This should really be iAirModifier * GetNumBuildings(iBuilding), but the core DLL is bugged in this respect and always multiplies by one
            iCityAirCapacity = iCityAirCapacity + iAirModifier
        end
    end

    dprint("The Citys total air capacity was calculated as " .. iCityAirCapacity .. " Air Units")
    return iCityAirCapacity
end

------------------------------------------------------------------------------------------------------
--CalculateNumberAirUnits calculates the number of Air Units already occupying a specified plot
--	it returns that calculated value as an integer
-----------------------------------------------------------------------------------------------------

function CalculateNumberAirUnits(pPlot)
	local iNumberAirUnits = 0
	for i = 0, pPlot:GetNumUnits() do
		local pPlotUnit = pPlot:GetUnit(i)
		if pPlotUnit then
			if pPlotUnit:GetDomainType() == gDomainAir then
				iNumberAirUnits = iNumberAirUnits + 1
			end
		end
	end
	return iNumberAirUnits
end

------------------------------------------------------------------------------------------------------
--CheckForCarrierUnit returns true/false for whether a unit is a valid aircraft-carrier type of unit
-----------------------------------------------------------------------------------------------------

function CheckForCarrierUnit(iUnitType)
    return CarrierUnits[iUnitType]
end

print("The Unit Spawn Handler loaded")




