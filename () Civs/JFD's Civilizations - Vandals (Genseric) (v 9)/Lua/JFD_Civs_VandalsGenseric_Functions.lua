-- JFD_Civs_VandalsGenseric_Functions
-- Author: JFD
-- DateCreated: 2/15/2014 6:33:36 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("PlotIterators.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- CORE UTILITIES
----------------------------------------------------------------------------------------------------------------------------
--HasTrait
function HasTrait(player, traitID)
	if Player.HasTrait then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end
--==========================================================================================================================
-- MOD USE
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilizationVandalsID  = GameInfoTypes["CIVILIZATION_JFD_VANDALS_GENSERIC"]
local traitVandalsGensericID = GameInfoTypes["TRAIT_JFD_VANDALS_GENSERIC"]
local unitTrihemioliaID      = GameInfoTypes["UNIT_JFD_TRIHEMIOLIA"]
----------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------
--JFD_Vandals_PlayerDoTurn
--local cityRuins = {}
--local improvementCityRuinsID 		 = GameInfoTypes["IMPROVEMENT_CITY_RUINS"]
local promotionVandalsID			 = GameInfoTypes["PROMOTION_JFD_VANDALS_GENSERIC"]
local promotionTrihemioliaActiveID   = GameInfoTypes["PROMOTION_JFD_TRIHEMIOLIA_ACTIVE"]
local promotionTrihemioliaInactiveID = GameInfoTypes["PROMOTION_JFD_TRIHEMIOLIA_INACTIVE"]
local terrainCoastID				 = GameInfoTypes["TERRAIN_COAST"]
local function JFD_Vandals_PlayerDoTurn(playerID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	
	--if player:IsEverAlive() then
	--	for city in player:Cities() do
	--		local plot = g_MapGetPlot(city:GetX(), city:GetY())
	--		if (not cityRuins[plot]) then
	--			cityRuins[plot] = true
	--		end	
	--	end
	--end
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
		
	local hasTrait = HasTrait(player, traitVandalsGensericID)
	for unit in player:Units() do
		--GREAT MIGRATION
		if hasTrait then
			local plot = g_MapGetPlot(unit:GetX(), unit:GetY())

			local isInOrAdjacentCoast = (plot:IsCoastalLand() or plot:GetTerrainType() == terrainCoastID)
			--if  then
			--	isInOrAdjacentCoast = true
			--else
			--	if (not Player.HasTrait) then
			--		for loopPlot in PlotAreaSpiralIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
			--			if loopPlot:IsCoast() then
			--				isInOrAdjacentCoast = loopPlot:IsCoast()
			--				break
			--			end
			--		end
			--	else
			--		isInOrAdjacentCoast = unit:IsAdjacentToTerrain(terrainCoastID)
			--	end
			--end

			unit:SetHasPromotion(promotionVandalsID, isInOrAdjacentCoast)
			if isInOrAdjacentCoast then
				unit:ChangeMoves(60)
			end
		end
		
		--TRIHEMIOLIA
		if unit:IsHasPromotion(promotionTrihemioliaActiveID) or unit:IsHasPromotion(promotionTrihemioliaInactiveID) then
			unit:SetHasPromotion(promotionTrihemioliaActiveID, false)
			unit:SetHasPromotion(promotionTrihemioliaInactiveID, true)
			
			local plotX, plotY = unit:GetX(), unit:GetY()
			local unitPlot = g_MapGetPlot(plotX, plotY)
			
			local city = unitPlot:GetPlotCity()
			if city then
				unit:SetHasPromotion(promotionTrihemioliaActiveID, true)
				unit:SetHasPromotion(promotionTrihemioliaInactiveID, false)

				if city:IsRazing() then
					city:ChangeRazingTurns(-1)	
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Vandals_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Vandals_UnitSetXY
local terrainCoastID = GameInfoTypes["TERRAIN_COAST"]
local function JFD_Vandals_UnitSetXY(playerID, unitID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	if (not player:IsAlive()) then return end
	if (player:IsBarbarian()) then return end
	if (player:IsMinorCiv()) then return end

	--GREAT MIGRATION
	if HasTrait(player, traitVandalsGensericID) then
		local unit = player:GetUnitByID(unitID)
		local plot = g_MapGetPlot(unit:GetX(), unit:GetY())

		local isInOrAdjacentCoast = false
		if plot:IsCoast() then
			isInOrAdjacentCoast = true
		else
			if (not Player.HasTrait) then
				for loopPlot in PlotAreaSpiralIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if loopPlot:IsCoast() then
						isInOrAdjacentCoast = true
					end
				end
			else
				isInOrAdjacentCoast = unit:IsAdjacentToTerrain(terrainCoastID)
			end
		end

		unit:SetHasPromotion(promotionVandalsID, isInOrAdjacentCoast)
	end
end
--GameEvents.UnitSetXY.Add(JFD_Vandals_UnitSetXY)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Vandals_SequenceGameInitComplete
--local function JFD_Vandals_SequenceGameInitComplete()
--	for playerID = 0, defineMaxMajorCivs - 1 do
--		local player = Players[playerID]
--		if player:IsEverAlive() then
--			for city in player:Cities() do
--				local plot = g_MapGetPlot(city:GetX(), city:GetY())
--				if (not cityRuins[plot]) then
--					cityRuins[plot] = true
--				end	
--			end
--		end
--	end
--end
--Events.SequenceGameInitComplete.Add(JFD_Vandals_SequenceGameInitComplete)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Vandals_PlayerCanTrain
local techUnitAlaniHorsemanSettlerID = GameInfoTypes[GameInfo.Units["UNIT_JFD_ALANI_HORSEMAN"].PrereqTech]
local unitAlaniHorsemanSettlerID 	 = GameInfoTypes["UNIT_JFD_ALANI_HORSEMAN_SETTLER"]
local function JFD_Vandals_PlayerCanTrain(playerID, unitID)
	local player = Players[playerID]
    if unitID == unitAlaniHorsemanSettlerID then
		local playerTeam = Teams[player:GetTeam()]
		return (playerTeam:GetTeamTechs():HasTech(techUnitAlaniHorsemanSettlerID) and HasTrait(player, traitVandalsGensericID))
	end
	return true
end
GameEvents.PlayerCanTrain.Add(JFD_Vandals_PlayerCanTrain)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Vandals_PlayerCityFounded
local buildingMonumentID = GameInfoTypes["BUILDING_MONUMENT"]
local function JFD_Vandals_PlayerCityFounded(playerID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	
	--GREAT MIGRATION
	if HasTrait(player, traitVandalsGensericID) then
		local playerCapital = player:GetCapitalCity()
		if (not playerCapital) then return end
		
		local plot = g_MapGetPlot(plotX, plotY)
		local capitalPlot = g_MapGetPlot(playerCapital:GetX(), playerCapital:GetY())
		if plot:GetArea() ~= capitalPlot:GetArea() then
		--if cityRuins[plot] then
		--	cityRuins[plot] = nil
			local city = plot:GetPlotCity()
			city:ChangePopulation(2, true)
			--city:SetNumRealBuilding(buildingMonumentID, 1)
			for loopPlot in PlotAreaSpiralIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				loopPlot:SetOwner(playerID, city:GetID())
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_Vandals_PlayerCityFounded)
--==========================================================================================================================
--==========================================================================================================================