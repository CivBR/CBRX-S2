-- JFD_Sovereignty_Utils
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:10 AM
--==========================================================================================================================
-- CACHING
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
MapModData.JFD_RTP_Sovereignty = MapModData.JFD_RTP_Sovereignty or {}
JFD_RTP_Sovereignty = MapModData.JFD_RTP_Sovereignty

include("TableSaverLoader016.lua");

tableRoot = JFD_RTP_Sovereignty
tableName = "JFD_RTP_Sovereignty_SaveData"

include("JFD_RTP_Sovereignty_TSLSerializerV3.lua");
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("JFD_RTP_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_GetRandom		= Game.GetRandom
local g_GetRound		= Game.GetRound
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams

local gameSpeedID		= Game.GetGameSpeedType()
local gameSpeed			= GameInfo.GameSpeeds[gameSpeedID]
local gameSpeedMod		= (gameSpeed.BuildPercent/100) 

local handicapID		= Game.GetHandicapType()
local handicap			= GameInfo.HandicapInfos[handicapID]
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--g_JFD_Governments_Table
local g_JFD_Governments_Table = {}
local g_JFD_Governments_Count = 1
for row in DB.Query("SELECT * FROM JFD_Governments WHERE IsHidden = 0;") do 	
	g_JFD_Governments_Table[g_JFD_Governments_Count] = row
	g_JFD_Governments_Count = g_JFD_Governments_Count + 1
end

--g_JFD_Government_LeaderTitles_ReformType_Table
local g_JFD_Government_LeaderTitles_ReformType_Table = {}
local g_JFD_Government_LeaderTitles_ReformType_Count = 1
for row in DB.Query("SELECT * FROM JFD_Government_Titles WHERE ReformType IS NOT NULL AND TitleLeader IS NOT NULL;") do 	
	g_JFD_Government_LeaderTitles_ReformType_Table[g_JFD_Government_LeaderTitles_ReformType_Count] = row
	g_JFD_Government_LeaderTitles_ReformType_Count = g_JFD_Government_LeaderTitles_ReformType_Count + 1
end

--g_JFD_Government_StateTitles_ReformType_Table
local g_JFD_Government_StateTitles_ReformType_Table = {}
local g_JFD_Government_StateTitles_ReformType_Count = 1
for row in DB.Query("SELECT * FROM JFD_Government_Titles WHERE ReformType IS NOT NULL AND TitleState IS NOT NULL;") do 	
	g_JFD_Government_StateTitles_ReformType_Table[g_JFD_Government_StateTitles_ReformType_Count] = row
	g_JFD_Government_StateTitles_ReformType_Count = g_JFD_Government_StateTitles_ReformType_Count + 1
end

--g_JFD_Factions_Table
local g_JFD_Factions_Table = {}
local g_JFD_Factions_Count = 1
for row in DB.Query("SELECT * FROM JFD_Factions;") do 	
	g_JFD_Factions_Table[g_JFD_Factions_Count] = row
	g_JFD_Factions_Count = g_JFD_Factions_Count + 1
end

--g_JFD_Reforms_Table
local g_JFD_Reforms_Table = {}
local g_JFD_Reforms_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reforms WHERE ShowInGovernment = 1;") do 	
	g_JFD_Reforms_Table[g_JFD_Reforms_Count] = row
	g_JFD_Reforms_Count = g_JFD_Reforms_Count + 1
end

--g_JFD_ReformsLeftRight_Table
local g_JFD_ReformsLeftRight_Table = {}
local g_JFD_ReformsLeftRight_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reforms WHERE ShowInGovernment = 1 AND Alignment != 'REFORM_CENTRE';") do 	
	g_JFD_ReformsLeftRight_Table[g_JFD_ReformsLeftRight_Count] = row
	g_JFD_ReformsLeftRight_Count = g_JFD_ReformsLeftRight_Count + 1
end

--g_JFD_ReformSubBranch_Flavours_Table
local g_JFD_ReformSubBranch_Flavours_Table = {}
local g_JFD_ReformSubBranch_Flavours_Count = 1
for row in DB.Query("SELECT * FROM JFD_ReformSubBranch_Flavours;") do 	
	g_JFD_ReformSubBranch_Flavours_Table[g_JFD_ReformSubBranch_Flavours_Count] = row
	g_JFD_ReformSubBranch_Flavours_Count = g_JFD_ReformSubBranch_Flavours_Count + 1
end

--g_ReformsSovereigntyWhenBuildingClass_Table
local g_ReformsSovereigntyWhenBuildingClass_Table = {}
local g_ReformsSovereigntyWhenBuildingClass_Count = 1
for row in DB.Query("SELECT ID, SovereigntyWhenBuildingClass, SovereigntyWhenBuildingClassType FROM JFD_Reforms WHERE SovereigntyWhenBuildingClass <> 0;") do 	
	g_ReformsSovereigntyWhenBuildingClass_Table[g_ReformsSovereigntyWhenBuildingClass_Count] = row
	g_ReformsSovereigntyWhenBuildingClass_Count = g_ReformsSovereigntyWhenBuildingClass_Count + 1
end

--g_JFD_Councillors_GreatPeople_Table
local g_JFD_Councillors_GreatPeople_Table = {}
local g_JFD_Councillors_GreatPeople_Count = 1
for row in DB.Query("SELECT * FROM JFD_Councillor_GreatPeople;") do 	
	g_JFD_Councillors_GreatPeople_Table[g_JFD_Councillors_GreatPeople_Count] = row
	g_JFD_Councillors_GreatPeople_Count = g_JFD_Councillors_GreatPeople_Count + 1
end

--g_Civilization_JFD_Governments_Table
local g_Civilization_JFD_Governments_Table = {}
local g_Civilization_JFD_Governments_Count = 1
for row in DB.Query("SELECT * FROM Civilization_JFD_Governments;") do 	
	g_Civilization_JFD_Governments_Table[g_Civilization_JFD_Governments_Count] = row
	g_Civilization_JFD_Governments_Count = g_Civilization_JFD_Governments_Count + 1
end

--g_Building_JFD_SovereigntyMods_Table
local g_Building_JFD_SovereigntyMods_Table = {}
local g_Building_JFD_SovereigntyMods_Count = 1
for row in DB.Query("SELECT * FROM Building_JFD_SovereigntyMods;") do 	
	g_Building_JFD_SovereigntyMods_Table[g_Building_JFD_SovereigntyMods_Count] = row
	g_Building_JFD_SovereigntyMods_Count = g_Building_JFD_SovereigntyMods_Count + 1
end

--g_Buildings_SovereigntyChange_Table
local g_Buildings_SovereigntyChange_Table = {}
local g_Buildings_SovereigntyChange_Count = 1
for row in DB.Query("SELECT ID, SovereigntyChange FROM Buildings WHERE SovereigntyChange <> 0;") do 	
	g_Buildings_SovereigntyChange_Table[g_Buildings_SovereigntyChange_Count] = row
	g_Buildings_SovereigntyChange_Count = g_Buildings_SovereigntyChange_Count + 1
end

--g_Buildings_SovereigntyChangeAllCities_Table
local g_Buildings_SovereigntyChangeAllCities_Table = {}
local g_Buildings_SovereigntyChangeAllCities_Count = 1
for row in DB.Query("SELECT ID, BuildingClass, SovereigntyChangeAllCities FROM Buildings WHERE SovereigntyChangeAllCities <> 0;") do 	
	g_Buildings_SovereigntyChangeAllCities_Table[g_Buildings_SovereigntyChangeAllCities_Count] = row
	g_Buildings_SovereigntyChangeAllCities_Count = g_Buildings_SovereigntyChangeAllCities_Count + 1
end

--g_Buildings_SovereigntyBonusPerTradeRoute_Table
local g_Buildings_SovereigntyBonusPerTradeRoute_Table = {}
local g_Buildings_SovereigntyBonusPerTradeRoute_Count = 1
for row in DB.Query("SELECT ID, SovereigntyBonusPerTradeRoute FROM Buildings WHERE SovereigntyBonusPerTradeRoute <> 0;") do 	
	g_Buildings_SovereigntyBonusPerTradeRoute_Table[g_Buildings_SovereigntyBonusPerTradeRoute_Count] = row
	g_Buildings_SovereigntyBonusPerTradeRoute_Count = g_Buildings_SovereigntyBonusPerTradeRoute_Count + 1
end

--g_Policy_JFD_SovereigntyMods_Table
local g_Policy_JFD_SovereigntyMods_Table = {}
local g_Policy_JFD_SovereigntyMods_Count = 1
for row in DB.Query("SELECT * FROM Policy_JFD_SovereigntyMods;") do 	
	g_Policy_JFD_SovereigntyMods_Table[g_Policy_JFD_SovereigntyMods_Count] = row
	g_Policy_JFD_SovereigntyMods_Count = g_Policy_JFD_SovereigntyMods_Count + 1
end

--g_Trait_JFD_SovereigntyMods_Table
local g_Trait_JFD_SovereigntyMods_Table = {}
local g_Trait_JFD_SovereigntyMods_Count = 1
for row in DB.Query("SELECT * FROM Trait_JFD_SovereigntyMods;") do 	
	g_Trait_JFD_SovereigntyMods_Table[g_Trait_JFD_SovereigntyMods_Count] = row
	g_Trait_JFD_SovereigntyMods_Count = g_Trait_JFD_SovereigntyMods_Count + 1
end
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive = Game.IsCPActive()
local g_IsVMCActive = Game.IsVMCActive()
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxCivPlayers = GameDefines["MAX_CIV_PLAYERS"]
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

local eraIndustrialID = GameInfoTypes["ERA_INDUSTRIAL"]
local eraMedievalID = GameInfoTypes["ERA_MEDIEVAL"]
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]

local factionRevolutionariesID = GameInfoTypes["FACTION_JFD_REVOLUTIONARIES"]

local governmentAnarchyID = GameInfoTypes["GOVERNMENT_JFD_ANARCHY"]
local governmentPolisID = GameInfoTypes["GOVERNMENT_JFD_POLIS"]
local governmentTribeID = GameInfoTypes["GOVERNMENT_JFD_TRIBE"]
local governmentMonarchyID = GameInfoTypes["GOVERNMENT_JFD_MONARCHY"]
local governmentPrincipalityID = GameInfoTypes["GOVERNMENT_JFD_PRINCIPALITY"]
local governmentRepublicID = GameInfoTypes["GOVERNMENT_JFD_REPUBLIC"]
local governmentTheocracyID = GameInfoTypes["GOVERNMENT_JFD_THEOCRACY"]
local governmentTotalitarianID = GameInfoTypes["GOVERNMENT_JFD_TOTALITARIAN"]
local governmentHREID = GameInfoTypes["GOVERNMENT_JFD_HOLY_ROMAN"]
local governmentPapacyID = GameInfoTypes["GOVERNMENT_JFD_PAPACY"]

local reformAdministrationCommonwealthID = GameInfoTypes["REFORM_JFD_ADMINISTRATION_COMMONWEALTH"]
local reformAdministrationPoliceStateID = GameInfoTypes["REFORM_JFD_ADMINISTRATION_POLICE_STATE"]
local reformConstitutionCodifiedID = GameInfoTypes["REFORM_JFD_CONSTITUTION_CODIFIED"]
local reformConstitutionUncodifiedID = GameInfoTypes["REFORM_JFD_CONSTITUTION_UNCODIFIED"]
local reformExecutiveAbsoluteID = GameInfoTypes["REFORM_JFD_EXECUTIVE_ABSOLUTE"]
local reformExecutiveDespoticID = GameInfoTypes["REFORM_JFD_EXECUTIVE_DESPOTIC"]
local reformExecutiveConstitutionalID = GameInfoTypes["REFORM_JFD_EXECUTIVE_CONSTITUTIONAL"]
local reformFactionsInterestsID = GameInfoTypes["REFORM_JFD_FACTIONS_INTERESTS"]
local reformFactionsMultiPartyID = GameInfoTypes["REFORM_JFD_FACTIONS_MULTI_PARTY"]
local reformFactionsTwoPartyID = GameInfoTypes["REFORM_JFD_FACTIONS_TWO_PARTY"]
local reformPowerCommonwealthID = GameInfoTypes["REFORM_JFD_POWER_COMMONWEALTH"]
local reformPowerPoliceStateID = GameInfoTypes["REFORM_JFD_POWER_POLICE_STATE"]
local reformRelationsManorialID = GameInfoTypes["REFORM_JFD_RELATIONS_MANORIAL"]
local reformRelationsPersonalID = GameInfoTypes["REFORM_JFD_RELATIONS_PERSONAL"]
local reformRelationsMunicipalID = GameInfoTypes["REFORM_JFD_RELATIONS_MUNICIPAL"]
local reformTerritoryCityStateID = GameInfoTypes["REFORM_JFD_TERRITORY_CITYSTATE"]
local reformTerritoryCityState = GameInfo.JFD_Reforms["REFORM_JFD_TERRITORY_CITYSTATE"]
local reformTerritoryCityStateLessSov = reformTerritoryCityState.SovereigntyWhenNumCitiesOrLess
local reformTerritoryCityStateLessReq = reformTerritoryCityState.SovereigntyWhenNumCitiesOrLessReq
local reformTerritoryCityStateMoreReq = reformTerritoryCityState.SovereigntyWhenNumCitiesOrMoreReq
local reformTerritoryCityStateMoreSov = reformTerritoryCityState.SovereigntyWhenNumCitiesOrMore
local reformTerritoryEmpireID = GameInfoTypes["REFORM_JFD_TERRITORY_EMPIRE"]
local reformTerritoryEmpire = GameInfo.JFD_Reforms["REFORM_JFD_TERRITORY_EMPIRE"]
local reformTerritoryEmpireLessSov = reformTerritoryEmpire.SovereigntyWhenNumCitiesOrLess
local reformTerritoryEmpireLessReq = reformTerritoryEmpire.SovereigntyWhenNumCitiesOrLessReq
local reformTerritoryEmpireMoreReq = reformTerritoryEmpire.SovereigntyWhenNumCitiesOrMoreReq
local reformTerritoryEmpireMoreSov = reformTerritoryEmpire.SovereigntyWhenNumCitiesOrMore
local reformStructureFederationID = GameInfoTypes["REFORM_JFD_STRUCTURE_FEDERATION"]
local reformStructureUnitaryID = GameInfoTypes["REFORM_JFD_STRUCTURE_UNITARY"]

local defineDefaultGovernmentCooldownCap = (GameDefines["JFD_SOVEREIGNTY_DEFAULT_GOVERNMENT_COOLDOWN_CAP"]*gameSpeedMod)
local defineDefaultGovernmentCooldownTurns = (GameDefines["JFD_SOVEREIGNTY_DEFAULT_GOVERNMENT_COOLDOWN"]*gameSpeedMod)
local defineDefaultReformCooldown = GameDefines["JFD_SOVEREIGNTY_DEFAULT_REFORM_COOLDOWN"]
local defineDefaultReformRevSentiment = GameDefines["JFD_SOVEREIGNTY_DEFAULT_REFORM_REVOLUTIONARY_SENTIMENT"]
--==========================================================================================================================
-- SOVEREIGNTY UTILS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- SOVEREIGNTY UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetMaxSovereignty
function Player.GetMaxSovereignty(player)
	local numSovMax = 0
	
	local currentGovernmentID = player:GetCurrentGovernment()
	local currentGovernment = GameInfo.JFD_Governments[currentGovernmentID]
	
	local numSovMaxMod = Player_GetMaxSovereigntyModifier(player)
	if numSovMaxMod ~= 0 then
		numSovMax = numSovMax + numSovMaxMod
	end
	
	return numSovMax
end
----------------------------------------------------------------------------------------------------------------------------
--g_Policy_GoldenAgeYieldMod_Table
local g_Policy_GoldenAgeYieldMod_Table = {}
local g_Policy_GoldenAgeYieldMod_Count = 1
if g_IsVMCActive then
	for row in DB.Query("SELECT * FROM Policy_GoldenAgeYieldMod WHERE YieldType = 'YIELD_JFD_SOVEREIGNTY' AND Yield <> 0;") do 	
		g_Policy_GoldenAgeYieldMod_Table[g_Policy_GoldenAgeYieldMod_Count] = row
		g_Policy_GoldenAgeYieldMod_Count = g_Policy_GoldenAgeYieldMod_Count + 1
	end
end

--Player:CalculateSovereignty
local yieldSovereigntyID = GameInfoTypes["YIELD_JFD_SOVEREIGNTY"]
function Player.CalculateSovereignty(player, onlyUpdateReformCapacity, returnsTT)	
	local playerID = player:GetID()
	local numCities = player:GetNumCities()
	local numSov = 0
	local numSovMax = player:GetMaxSovereignty()
	local strSovereigntyTT = ""

	if (not onlyUpdateReformCapacity) then
	
		if yieldSovereigntyID then
			--PLAYER YIELDS
			local numSovFromYieldRateMods = player:GetYieldRateModifier(yieldSovereigntyID)
			numSov = numSov + numSovFromYieldRateMods
			
			if (numSovFromYieldRateMods ~= 0 and returnsTT) then
				if numSovFromYieldRateMods > 0 then
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_FROM_POLICIES_AND_REFORMS", numSovFromYieldRateMods)
				else
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_FROM_POLICIES_AND_REFORMS", numSovFromYieldRateMods)
				end
			end
	
			local numSovFromGoldenAge = 0
			--g_Policy_GoldenAgeYieldMod_Table
			local policiesTable = g_Policy_GoldenAgeYieldMod_Table
			local numPolicies = #policiesTable
			for index = 1, numPolicies do
				local row = policiesTable[index]
				local policyID = GameInfoTypes[row.PolicyType]
				if player:HasPolicy(policyID) then
					numSovFromGoldenAge = numSovFromGoldenAge + row.Yield
				end
			end
			numSov = numSov + numSovFromGoldenAge
	
			if (numSovFromGoldenAge ~= 0 and returnsTT) then
				if numSovFromGoldenAge > 0 then 
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_FROM_GOLDEN_AGE", numSovFromGoldenAge)
				else
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_FROM_GOLDEN_AGE", numSovFromGoldenAge)
				end
			end
		end
	
		--BUILDINGS
		local numSovFromBuildings = 0
		--g_Buildings_SovereigntyChange_Table
		local buildingsTable = g_Buildings_SovereigntyChange_Table
		local numBuildings = #buildingsTable
		for index = 1, numBuildings do
			local row = buildingsTable[index]
			local buildingID = row.ID
			if player:CountNumBuildings(buildingID) > 0 then
				numSovFromBuildings = numSovFromBuildings + (player:CountNumBuildings(buildingID)*row.SovereigntyChange)
			end
		end
		for city in player:Cities() do
			if yieldSovereigntyID then
				numSovFromBuildings = numSovFromBuildings + city:GetYieldRateModifier(yieldSovereigntyID)
			end
		end
		numSov = numSov + numSovFromBuildings
		if (numSovFromBuildings ~= 0 and returnsTT) then
			strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_FROM_BUILDINGS", numSovFromBuildings)
		end
		
		--g_Buildings_SovereigntyChangeAllCities_Table
		local buildingsTable = g_Buildings_SovereigntyChangeAllCities_Table
		local numBuildings = #buildingsTable
		for index = 1, numBuildings do
			local row = buildingsTable[index]
			local buildingID = row.ID
			local numSovFromBuildings = row.SovereigntyChangeAllCities
			if player:CountNumBuildings(buildingID) == numCities then
				numSov = numSov + numSovFromBuildings
				strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_BUILDING_CLASS", "[COLOR_POSITIVE_TEXT]", numSovFromBuildings, GameInfo.BuildingClasses[row.BuildingClass].Description)
			elseif player:CountNumBuildings(buildingID) > 0 then
				strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_BUILDING_CLASS", "", numSovFromBuildings, GameInfo.BuildingClasses[row.BuildingClass].Description)
			end
		end
	
		--===============================
		--JFD's Top Panel Addins BEGIN
		--===============================
		--This is for any extra Sovereignty addins
		--for row in GameInfo.JFD_TopPanelAdditions("YieldType = 'YIELD_JFD_SOVEREIGNTY'") do
		--	local yieldSourceFunction = row.YieldSourceFunction
		--	if yieldSourceFunction then
		--		local numSovereignty = loadstring("return " .. yieldSourceFunction .. "(Game.GetActivePlayer())")()
		--		if numSovereignty > 0 then
		--			local prereqCivilization = row.CivilizationType 
		--			if prereqCivilization then
		--				local prereqCivilizationID = GameInfoTypes[prereqCivilization]
		--				if activePlayer:GetCivilizationType() == prereqCivilizationID then
		--					local yieldToolTip = row.YieldSourceToolTip
		--					if yieldToolTip then
		--						local yieldToolTipText = g_ConvertTextKey(yieldToolTip, numSovereignty)
		--						sovereignty = sovereignty + numSovereignty
		--						sovereigntyTT = sovereigntyTT .. "[NEWLINE][ICON_BULLET]" .. yieldToolTipText
		--					end
		--				end
		--			end
		--			if (not prereqCivilization) then
		--				local yieldToolTip = row.YieldSourceToolTip
		--				if yieldToolTip then
		--					local yieldToolTipText = g_ConvertTextKey(yieldToolTip, numSovereignty)
		--					sovereignty = sovereignty + numSovereignty
		--					sovereigntyTT = sovereigntyTT .. "[NEWLINE][ICON_BULLET]" .. yieldToolTipText
		--				end
		--			end	
		--		end
		--	end
		--end
		--===============================
		--JFD's Top Panel Addins END
		--===============================
	
		--CITY-STATE TERRITORY
		if player:HasReform(reformTerritoryCityStateID) then
			if numCities <= reformTerritoryCityStateLessReq then
				numSov = numSov + reformTerritoryCityStateLessSov
				if returnsTT then
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_NUM_CITIES_OR_LESS", "[COLOR_POSITIVE_TEXT]", reformTerritoryCityStateLessSov, reformTerritoryCityStateLessReq)
				end
			elseif numCities >= reformTerritoryCityStateMoreReq then
				numSov = numSov + reformTerritoryCityStateMoreSov
				if returnsTT then
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_NUM_CITIES_OR_MORE", "[COLOR_NEGATIVE_TEXT]", reformTerritoryCityStateMoreSov, reformTerritoryCityStateMoreReq)
				end
			end
		end
		
		--EMPIRE TERRITORY
		if player:HasReform(reformTerritoryEmpireID) then
			if numCities >= reformTerritoryEmpireMoreReq then
				numSov = numSov + reformTerritoryEmpireMoreSov
				if returnsTT then
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_NUM_CITIES_OR_MORE", "[COLOR_POSITIVE_TEXT]", reformTerritoryEmpireMoreSov, reformTerritoryEmpireMoreReq)
				end
			elseif numCities <= reformTerritoryEmpireLessReq then
				numSov = numSov + reformTerritoryEmpireLessSov
				if returnsTT then
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_NUM_CITIES_OR_LESS", "[COLOR_NEGATIVE_TEXT]", reformTerritoryEmpireLessSov, reformTerritoryEmpireLessReq)
				end
			end
		end
		
		--LEGITIMACIES
		local numSovFromLegitimaciesMod = Player_GetLegitimacySovModifier(player)
		--g_ReformsSovereigntyWhenBuildingClass_Table
		local reformsTable = g_ReformsSovereigntyWhenBuildingClass_Table
		local numReforms = #reformsTable
		for index = 1, numReforms do
			local row = reformsTable[index]
			local reformID = row.ID
			if player:HasReform(reformID) then
				local buildingClassID = GameInfoTypes[row.SovereigntyWhenBuildingClassType]
				local numBuildingClass = player:GetBuildingClassCount(buildingClassID)
				local numSovWhenBuildingClass = row.SovereigntyWhenBuildingClass
				if numSovFromLegitimaciesMod ~= 0 then 
					numSovWhenBuildingClass = numSovWhenBuildingClass + g_GetRound((numSovWhenBuildingClass*numSovFromLegitimaciesMod)/100) 
				end
				if numBuildingClass == numCities then
					numSov = numSov + numSovWhenBuildingClass
					if returnsTT then
						strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_BUILDING_CLASS", "[COLOR_POSITIVE_TEXT]", numSovWhenBuildingClass, GameInfo.BuildingClasses[buildingClassID].Description)
					end
				elseif numBuildingClass == 0 then
					numSovWhenBuildingClass = (numSovWhenBuildingClass*-1)
					numSov = numSov + numSovWhenBuildingClass
					if returnsTT then
						strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_NO_BUILDING_CLASS", numSovWhenBuildingClass, GameInfo.BuildingClasses[buildingClassID].Description)
					end
				else
					numSov = numSov + numSovWhenBuildingClass
					if returnsTT then
						strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_WHEN_BUILDING_CLASS", "", numSovWhenBuildingClass, GameInfo.BuildingClasses[buildingClassID].Description)
					end
				end
			end
		end
		
		--TRADE ROUTES	
		local numSovFromGoldenAge = 0
		--g_Policy_GoldenAgeYieldMod_Table
		local policiesTable = g_Policy_GoldenAgeYieldMod_Table
		local numPolicies = #policiesTable
		for index = 1, numPolicies do
			local row = policiesTable[index]
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numSovFromGoldenAge = numSovFromGoldenAge + row.Yield
			end
		end
			
		local numSovFromTradeRoutes = 0
		--g_Buildings_SovereigntyBonusPerTradeRoute_Table
		local buildingsTable = g_Buildings_SovereigntyBonusPerTradeRoute_Table
		local numBuildings = #g_Buildings_SovereigntyBonusPerTradeRoute_Table
		for index = 1, numBuildings do
			local row = buildingsTable[index]
			local buildingID = row.ID
			if player:CountNumBuildings(buildingID) > 0 then
				numSovFromTradeRoutes = numSovFromTradeRoutes + (#player:GetTradeRoutes()*row.SovereigntyBonusPerTradeRoute)
			end
		end
		if numSovFromTradeRoutes ~= 0 then 
			numSov = numSov + numSovFromTradeRoutes
			if returnsTT then
				strSovereigntyTT = strSovereigntyTT .. "[NEWLINE]  [ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_FROM_TRADE_ROUTES", numSovFromTradeRoutes)
			end
		end	
	
		--MANDATE OF HEAVEN
		if player:IsGoldenAge() then
			local governmentID = player:GetCurrentGovernment()
			local numGASovBonus = GameInfo.JFD_Governments[governmentID].GoldenAgeSovereigntyBonus
			if numGASovBonus > 0 then
				numSov = numSov + g_GetRound((numSov*numGASovBonus)/100)
				if returnsTT then
					strSovereigntyTT = strSovereigntyTT .. "[NEWLINE][ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_MOD_FROM_MANDATE", numGASovBonus)
				end
			end
		end
		
		--CYCLES OF POWER
		if Player.GetCyclePower then
			local playerCapital = player:GetCapitalCity()
			local cycleOfPowerID = player:GetCyclePower()
			if cycleOfPowerID > -1 then
				local cycleOfPower = GameInfo.JFD_CyclePowers[cycleOfPowerID]
				local numModFromCycleOfPower = 0
				
				local numModPerCapitalPop = cycleOfPower.SovModifierPerCapitalPopulation
				if numModPerCapitalPop > 0 then
					numModFromCycleOfPower = (playerCapital:GetPopulation()*numModPerCapitalPop)
				end
				
				local numModPerCity = cycleOfPower.SovModifierPerCity
				if numModPerCity > 0 then
					numModFromCycleOfPower = (player:GetNumCities()*numModPerCity)
				end
				
				local numModPerPop = cycleOfPower.SovModifierPerPopulation
				if numModPerPop > 0 then
					numModFromCycleOfPower = (player:GetTotalPopulation()*numModPerPop)
				end
				
				local numModPerCityFollowing = cycleOfPower.SovModifierPerCityFollowing
				if numModPerCityFollowing > 0 then
					local religionID = player:GetReligionCreatedByPlayer()
					if religionID > 0 then
						numModFromCycleOfPower = (Game.GetNumCitiesFollowing(religionID)*numModPerCityFollowing)
					end
				end
				
				if numModFromCycleOfPower > 0 then
					numSov = numSov + g_GetRound((numSov*numModFromCycleOfPower)/100)
				
					if returnsTT then
						strSovereigntyTT = strSovereigntyTT .. "[NEWLINE][ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_MOD_FROM_CYCLE_OF_POWER", numModFromCycleOfPower, "[ICON_JFD_CYCLE_POWER]", cycleOfPower.Description)
					end
				end
			end
		end
	
		--REFORM CAPACITY
		local numReforms = player:GetNumReforms(true, true)
		local numReformCapacity = player:CalculateReformCapacity()
		local numReformCapacitySovMod = player:GetReformCapacitySovModifier(numReforms, numReformCapacity)
		if numReformCapacitySovMod < 0 then
			numSov = numSov + g_GetRound((numSov*numReformCapacitySovMod)/100)
			-- numSov = numSov + numReformCapacitySovMod
			if returnsTT then
				strSovereigntyTT = strSovereigntyTT .. "[NEWLINE][ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_MOD_FROM_REFORM_CAPACITY", numReformCapacitySovMod)
			end
		end
	else
		numSov = player:GetCurrentSovereignty()
		
		--REFORM CAPACITY
		local numReforms = player:GetNumReforms(true, true)
		local numReformCapacity = player:CalculateReformCapacity()
		local numReformCapacitySovMod = player:GetReformCapacitySovModifier(numReforms, numReformCapacity)
		if numReformCapacitySovMod < 0 then
			numSov = numSov + g_GetRound((numSov*-10)/100)
			-- numSov = numSov + numReformCapacitySovMod
			if returnsTT then
				strSovereigntyTT = strSovereigntyTT .. "[NEWLINE][ICON_BULLET]" .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_MOD_FROM_REFORM_CAPACITY", numReformCapacitySovMod)
			end
		end
	end
	
	if numSov >= numSovMax then
		numSov = numSovMax
	elseif numSov < 0 then
		numSov = 0
	end
	
	return numSov, strSovereigntyTT
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetCurrentSovereignty
function Player.GetCurrentSovereignty(player)	
	local playerID = player:GetID()
	
	if Player.GetSovereignty then
		return player:GetSovereignty()
	else
		return JFD_RTP_Sovereignty[playerID .. "_SOVEREIGNTY_BALANCE"] or 0
	end
end
-------------------------------------------------------------------------------------------------------------------------
--Player:UpdateCurrentSovereignty
function Player.UpdateCurrentSovereignty(player, numSov, onlyUpdateReformCapacity)	
	local playerID = player:GetID()
	
	-- print("UpdateCurrentSovereignty", debug.traceback())
	
	if (not numSov) then
		numSov = player:CalculateSovereignty(onlyUpdateReformCapacity)
	end
	
	if Player.SetSovereignty then
		player:SetSovereignty(numSov)
	else
		JFD_RTP_Sovereignty[playerID .. "_SOVEREIGNTY_BALANCE"] = numSov
	end
	
	if player:IsHuman() and player:IsTurnActive() then
		LuaEvents.JFD_UpdateTopPanel()
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- SOVEREIGNTY MODIFIER UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player_GetMaxSovereigntyModifier
local factionHolySeeOtherID = GameInfoTypes["FACTION_JFD_HOLY_SEE_OTHER"]
function Player_GetMaxSovereigntyModifier(player)
	local numSovMaxMod = 0
	
	local governmentID = player:GetCurrentGovernment()
	local numMaxSovPerHolySeeFaction = GameInfo.JFD_Governments[governmentID].MaxSovPerHolySeeFaction
	if numMaxSovPerHolySeeFaction > 0 then
		for playerID = 0, defineMaxMajorCivs - 1 do
			local player = Players[playerID]
			if player:IsAlive() then
				if player:GetDominantFaction() == factionHolySeeOtherID then
					numSovMaxMod = numSovMaxMod + numMaxSovPerHolySeeFaction
				end
			end
		end
	end

	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisMaxSovChange = row.MaxSovChange
		if numThisMaxSovChange ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numSovMaxMod = numSovMaxMod + numThisMaxSovChange
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisMaxSovChange = row.MaxSovChange
		if numThisMaxSovChange ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numSovMaxMod = numSovMaxMod + numThisMaxSovChange
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisMaxSovChange = row.MaxSovChange
		if numThisMaxSovChange ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numSovMaxMod = numSovMaxMod + numThisMaxSovChange
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisMaxSovChange = row.MaxSovChange
			if numThisMaxSovChange ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numSovMaxMod = numSovMaxMod + numThisMaxSovChange
				end
			end
		end
	end
	
	return numSovMaxMod
end
----------------------------------------------------------------------------------------------------------------------------
--Player_GetLegitimacySovModifier
function Player_GetLegitimacySovModifier(player)
	local numLegitimacySovMod = 0

	local governmentID = player:GetCurrentGovernment()
	local numLegitimacySovModGovernment = GameInfo.JFD_Governments[governmentID].LegitimacySovMod
	if numLegitimacySovModGovernment ~= 0 then
		numLegitimacySovMod = numLegitimacySovMod + numLegitimacySovModGovernment
	end
			
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisLegitimacySovMod = row.LegitimacySovMod
		if numThisLegitimacySovMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numLegitimacySovMod = numLegitimacySovMod + numThisLegitimacySovMod
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisLegitimacySovMod = row.LegitimacySovMod
		local reqReformID = GameInfoTypes[row.LegitimacySovModReformType]
		if (not reqReformID) or (reqReformID and reqReformID == reformID) then
			if numThisLegitimacySovMod ~= 0 then
				local buildingID = GameInfoTypes[row.BuildingType]
				local buildingCount = player:CountNumBuildings(buildingID)
				if buildingCount > 0 then
					numLegitimacySovMod = numLegitimacySovMod + (numThisLegitimacySovMod*buildingCount)
				end
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisLegitimacySovMod = row.LegitimacySovMod
		local reqReformID = GameInfoTypes[row.LegitimacySovModReformType]
		if (not reqReformID) or (reqReformID and reqReformID == reformID) then
			if numThisLegitimacySovMod ~= 0 then
				local policyID = GameInfoTypes[row.PolicyType]
				if player:HasPolicy(policyID) then
					numLegitimacySovMod = numLegitimacySovMod + numThisLegitimacySovMod
				end
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisLegitimacySovMod = row.LegitimacySovMod
			local reqReformID = GameInfoTypes[row.LegitimacySovModReformType]
			if (not reqReformID) or (reqReformID and reqReformID == reformID) then
				if numThisLegitimacySovMod ~= 0 then
					local traitID = GameInfoTypes[row.TraitType]
					if player:HasTrait(traitID) then
						numLegitimacySovMod = numLegitimacySovMod + numThisLegitimacySovMod
					end
				end
			end
		end
	end
	
	return numLegitimacySovMod
end
----------------------------------------------------------------------------------------------------------------------------
-- SOVEREIGNTY TEXT UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetSovereigntyToolTip
function Player.GetSovereigntyToolTip(player)
	local governmentID = player:GetCurrentGovernment()
	local government = GameInfo.JFD_Governments[governmentID]
	
	local strSovTopPanelTT = g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_TOP_PANEL_TT_YOUR_GOVERNMENT", government.Description)
	strSovTopPanelTT = strSovTopPanelTT .. " "
	-- strSovTopPanelTT = strSovTopPanelTT .. "[NEWLINE]"
	strSovTopPanelTT = strSovTopPanelTT .. g_ConvertTextKey(government.Help)
	strSovTopPanelTT = strSovTopPanelTT .. "[NEWLINE][NEWLINE]"
	
	--SOVEREIGNTY
	local numRealSov = player:GetCurrentSovereignty()
	local numProjSov, strSovTT = player:CalculateSovereignty(false, true)
	local numSovMax = player:GetMaxSovereignty()
	local HL1 = "[COLOR_JFD_SOVEREIGNTY_FADING]"
	if numRealSov >= numSovMax then
		HL1 = "[COLOR_JFD_SOVEREIGNTY]"
	end
	local HL2 = "[COLOR_JFD_SOVEREIGNTY_FADING]"
	if numProjSov >= numSovMax then
		HL2 = "[COLOR_JFD_SOVEREIGNTY]"
	end
	strSovTopPanelTT = strSovTopPanelTT .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_TOP_PANEL_TT_YOUR_SOVEREIGNTY", numRealSov, numSovMax, numProjSov, HL1, HL2)
	strSovTopPanelTT = strSovTopPanelTT .. strSovTT
	
	--REFORM CAPACITY
	local strHL = ""
	local numReforms = player:GetNumReforms(true, true)
	local numReformCapacity = player:CalculateReformCapacity()
	if numReforms > numReformCapacity then
		strHL = "[COLOR_WARNING_TEXT]"
	elseif numReforms < numReformCapacity then
		strHL = "[COLOR_POSITIVE_TEXT]"
	end
	strSovTopPanelTT = strSovTopPanelTT .. "[NEWLINE][NEWLINE]"
	strSovTopPanelTT = strSovTopPanelTT .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_TOP_PANEL_TT_REFORM_CAPACITY", numReforms, numReformCapacity, strHL)	
	
	--LEGISLATURE COOLDOWN
	local numGovernmentCooldown = player:GetCurrentGovernmentCooldown()
	if numGovernmentCooldown > 0 then
		strSovTopPanelTT = strSovTopPanelTT .. g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_TOP_PANEL_TT_GOVERNMENT_COOLDOWN", numGovernmentCooldown)	
	end
	
	if player:IsAnarchy() then
		strSovTopPanelTT = g_ConvertTextKey("TXT_KEY_JFD_SOVEREIGNTY_TOP_PANEL_TT_ANARCHY", player:GetAnarchyNumTurns()) .. "[NEWLINE][NEWLINE]" .. strSovTopPanelTT
	end
	
	return strSovTopPanelTT
end
--==========================================================================================================================
-- GOVERNMENT UTILS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- GOVERNMENT UTILS
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
--Game.AnyoneHasGovernment
function Game.AnyoneHasGovernment(governmentID)
	for otherPlayerID = 0, defineMaxMajorCivs - 1 do
		local otherPlayer = Players[otherPlayerID]
		if otherPlayer:IsAlive() then
			if otherPlayer:IsHasGovernment(governmentID) then
				return true
			end
		end
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Player:CanHaveGovernment
local resourceHorseID = GameInfoTypes["RESOURCE_HORSE"]
local unitClassGreatGeneralID = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]
function Player.CanHaveGovernment(player, governmentID)
	local playerID = player:GetID()
	local playerTeam = Teams[player:GetTeam()]
	if governmentID == 0 then
		return false
	end
	
	local currentGovernmentID = player:GetCurrentGovernment()
	local currentGovernment = GameInfo.JFD_Governments[currentGovernmentID]
	local government = GameInfo.JFD_Governments[governmentID]
	local canHaveGovernment = true
	local canSeeGovernment = true
	local strCanHaveGovernment = ""
	
	if governmentID == currentGovernmentID then
		canHaveGovernment = false
		canSeeGovernment = true
		strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_CURRENT")
		return canHaveGovernment, canSeeGovernment, strCanHaveGovernment
	end
	
	local reqBuildingOR = government.RequiresBuildingOR
	if reqBuildingOR then
		local buildingORID = GameInfoTypes[reqBuildingOR]
		if player:CountNumBuildings(buildingORID) > 0 then
			canHaveGovernment = true
			canSeeGovernment = true
			return canHaveGovernment, canSeeGovernment, strCanHaveGovernment
		end
	end
	
	local reqPopulation = government.RequiresPopulation
	if reqPopulation > 0 then
		local numTotalPop = player:GetTotalPopulation()
		if numTotalPop < reqPopulation then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_POPULATION", reqPopulation, numTotalPop)
		end
	end

	local reqBuilding = government.RequiresBuilding
	if reqBuilding then
		local buildingID = GameInfoTypes[reqBuilding]
		local building = GameInfo.Buildings[buildingID]
		if player:CountNumBuildings(buildingID) <= 0 then
			canHaveGovernment = false
			canSeeGovernment = false
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_BUILDING", building.Description)
			return canHaveGovernment, canSeeGovernment, strCanHaveGovernment
		end
	end

	local reqOtherReligion = government.RequiresOtherReligion
	if reqOtherReligion then
		local hasOtherReligion = false
		for otherPlayerID = 0, defineMaxMajorCivs - 1 do
			if player:HasOthersReligionInMostCities(otherPlayerID) then
				hasOtherReligion = true
				break
			end
		end
		if (not hasOtherReligion) then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_OTHER_RELIGION")
		end
	end

	local reqBuildingAllCities = government.RequiresBuildingAllCities
	if reqBuildingAllCities then
		local buildingClassID = GameInfoTypes[reqBuildingAllCities]
		local buildingClass = GameInfo.BuildingClasses[buildingClassID]
		if player:GetNumCities() > player:GetBuildingClassCount(buildingClassID) then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_BUILDING_ALL_CITIES", buildingClass.Description)
		end
	end

	local reqGovernment = government.RequiresGovernment
	if reqGovernment then
		local reqGovernmentID = GameInfoTypes[reqGovernment]
		local reqGovernment = GameInfo.JFD_Governments[reqGovernmentID]
		if currentGovernmentID ~= reqGovernmentID then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_GOVERNMENT", reqGovernment.Description)
		end
	end

	local reqHorses = government.RequiresHorses
	if reqHorses then
		if player:GetNumResourceTotal(resourceHorseID, false) < reqHorses then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_HORSES")
		end
	end

	local reqGreatGenerals = government.RequiresGreatGenerals
	if reqGreatGenerals then
		if player:GetUnitClassCount(unitClassGreatGeneralID) < reqGreatGenerals then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_GREAT_GENERALS")
		end
	end

	local reqTech = government.RequiresTech
	if reqTech then
		local reqTechID = GameInfoTypes[reqTech]
		local reqTech = GameInfo.Technologies[reqTechID]
		if (not playerTeam:IsHasTech(reqTechID)) then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_TECH", reqTech.Description)
		end
	end

	local reqIdeology = government.RequiresIdeology
	if reqIdeology then
		if player:GetIdeology() < 0 then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_IDEOLOGY")
		end
	end

	local reqNOTAnarchy = government.RequiresNOTAnarchy
	if reqNOTAnarchy then
		if player:IsAnarchy() then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_NOT_ANARCHY")
		end
	end

	local reqAnarchy = government.RequiresAnarchy
	if reqAnarchy then
		if (not player:IsAnarchy()) then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_ANARCHY")
		end
	end

	local reqWar = government.RequiresActiveWar
	if reqWar then
		if playerTeam:GetAtWarCount(true) == 0 then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_ACTIVE_WAR")
		end
	end

	local reqCityStateAllies = government.RequiresCityStateAllies
	if reqCityStateAllies > 0 then
		local numFriends, numAllies = player:GetNumCityStatePartners()
		if numAllies < reqCityStateAllies then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_CITY_STATE_ALLIES", reqCityStateAllies)
		end
	end

	local reqTradeRoutes = government.RequiresTradeRoutes
	if reqTradeRoutes > 0 then
		local numTradeRoutes = #player:GetTradeRoutes()
		if numTradeRoutes < reqTradeRoutes then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_TRADE_ROUTES", reqTradeRoutes)
		end
	end

	local reqConqueredCapital = government.RequiresConqueredCapital
	if reqConqueredCapital then
		local numConqueredCapitals = 0
		for city in player:Cities() do
			if city:GetOriginalOwner() ~= playerID and city:IsOriginalCapital() then
				numConqueredCapitals = numConqueredCapitals + 1
			end
		end
		if numConqueredCapitals == 0 then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_CONQUERED_CAPITAL")
		end
	end

	local reqConnectedCities = government.RequiresConnectedCities
	if reqConnectedCities then
		if player:GetNumCities() < 2 then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_ALL_CITIES_CONNECTED")
		else
			for city in player:Cities() do
				if (not player:IsCapitalConnectedToCity(city)) then
					canHaveGovernment = false
					canSeeGovernment = true
					strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_ALL_CITIES_CONNECTED")
					break
				end
			end
		end
	end

	local reqGarrisonCities = government.RequiresGarrisonCities
	if reqGarrisonCities then
		for city in player:Cities() do
			if (not city:GetGarrisonedUnit()) then
				canHaveGovernment = false
				canSeeGovernment = true
				strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_ALL_CITIES_GARRISONED")
				break
			end
		end
	end

	local reqGoldenAge = government.RequiresGoldenAge
	if reqGoldenAge then
		if (not player:IsGoldenAge()) then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_GOLDEN_AGE")
		end
	end

	local reqReligion = government.RequiresReligion
	if reqReligion then
		if player:GetReligionCreatedByPlayer() <= 0 then 
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_RELIGION")
		end
	end

	local reqReligionAllControl = government.RequiresReligionAllControl
	if reqReligionAllControl then
		local religionID = player:GetMainReligion()
		if (religionID <= 0 or (religionID > 0 and Game.GetNumCitiesFollowing(religionID) <= player:GetNumCities())) then 
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_RELIGION_ALL_CONTROL")
		end
	end

	local reqReligionNotAllControl = government.RequiresReligionNotAllControl
	if reqReligionNotAllControl then
		local religionID = player:GetMainReligion()
		if (religionID <= 0 or (religionID > 0 and Game.GetNumCitiesFollowing(religionID) > player:GetNumCities())) then 
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_RELIGION_NOT_ALL_CONTROL")
		end
	end
	
	local reqEra = government.RequiresMinEra
	if reqEra then
		if player:GetCurrentEra() < GameInfoTypes[reqEra] then
			canHaveGovernment = false
			canSeeGovernment = true
			strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_ERA", GameInfo.Eras[reqEra].Description)
		end
	end

	if government.IsUnique then
		for otherPlayerID = 0, defineMaxMajorCivs - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() then
				if otherPlayer:GetCurrentGovernment() == governmentID then
					canHaveGovernment = false
					canSeeGovernment = true
					if otherPlayerID == player:GetID() then
						strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_UNIQUE_YOU")
					else
						strCanHaveGovernment = strCanHaveGovernment .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_REQUIRES_UNIQUE", otherPlayer:GetName())
					end
					break
				end
			end
		end
	end

	return canHaveGovernment, canSeeGovernment, strCanHaveGovernment
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetHasGovernment
function Player.SetHasGovernment(player, governmentID, isInit, isChanging, isChangingFree, isAnarchyFree)
	local playerID = player:GetID()
	local oldGovernmentID = player:GetCurrentGovernment()
	local government = GameInfo.JFD_Governments[governmentID]
		
	if Player.SetGovernment then
		player:SetGovernment(governmentID)
	else
		JFD_RTP_Sovereignty[playerID .. "_GOVERNMENT"] = governmentID
	end
	player:SetCanChangeGovernment(false)
	
	if player:IsMinorCiv() then return end
	
	if isInit then
		player:SetHasAllDefaultReforms(governmentID, true, false, false, true)
	end
	
	if (not isAnarchyFree) and (not player:IsAnarchy()) then
		local numAnarchyTurns = government.NumAnarchyTurnsFromChange
		if isChanging and numAnarchyTurns > 0 then
			player:ChangeAnarchyNumTurns(numAnarchyTurns)
			if player:IsHuman() and player:IsTurnActive() then
				Events.AudioPlay2DSound("AS2D_SOUND_JFD_ANARCHY");
			end
		end
	end
	if player:IsInRevolution() then
		player:DoEndRevolution(true)
	elseif player:IsAnarchy() then
		player:SetAnarchyNumTurns(0)
	end
	player:UpdateCurrentSovereignty()
	
	if player:IsHuman() and player:IsTurnActive() then
		local notificationDesc = government.NotificationDescription
		local notificationShortDesc = government.NotificationShortDescription
		if notificationDesc then
			if isChanging then
				notificationDesc = notificationDesc .. "_CHANGE"
				notificationShortDesc = notificationShortDesc .. "_CHANGE"
				local oldGovernment = GameInfo.JFD_Governments[oldGovernmentID]
				player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_ACTIVE_PLAYER", g_ConvertTextKey(notificationDesc, government.Description, oldGovernment.Description), g_ConvertTextKey(notificationShortDesc), false, nil, nil, governmentID)
			else
				player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_ACTIVE_PLAYER", g_ConvertTextKey(notificationDesc, government.Description), g_ConvertTextKey(notificationShortDesc), false, nil, nil, governmentID)
			end
			
			local governmentSound = government.AudioEffect
			if governmentID == governmentTotalitarianID then
				Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_BAD");
			elseif isChanging then
				Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_BAD");
			else
				Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_GOOD");
			end
			if governmentSound then
				Events.AudioPlay2DSound(governmentSound);
			end
		end

		Events.OpenInfoCorner( InfoCornerID.Civilization );
		LuaEvents.UI_UpdateCivilizationOverview()
	else
		local notificationWorldEvent = government.NotificationWorldEvent
		if notificationWorldEvent then
			if isChanging then
				notificationWorldEvent = notificationWorldEvent .. "_CHANGE"
				local oldGovernment = GameInfo.JFD_Governments[oldGovernmentID]
				player:SendWorldEvent(g_ConvertTextKey(notificationWorldEvent, player:GetCivilizationShortDescriptionKey(), government.Description, oldGovernment.Description))	
			else
				player:SendWorldEvent(g_ConvertTextKey(notificationWorldEvent, player:GetCivilizationShortDescriptionKey(), government.Description))
			end
		end
	end	

	LuaEvents.JFD_GovernmentEstablished(playerID, governmentID, oldGovernmentID)
	
	if government.IsLegislated then
		player:ResetLegislature(governmentID)
	end
	
	if (not isInit) then
		player:UpdateLeaderName(governmentID)
		player:UpdateCivilizationStateDescription(governmentID)
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetCurrentGovernment
function Player.GetCurrentGovernment(player)
	local playerID = player:GetID()
	if Player and Player.GetGovernment then
		return player:GetGovernment()
	elseif JFD_RTP_Sovereignty then
		local currentGovernmentID = JFD_RTP_Sovereignty[playerID .. "_GOVERNMENT"] or 0
		if currentGovernmentID == 0 then
			if player:IsMinorCiv() then
				currentGovernmentID = governmentPolisID
			else
				currentGovernmentID = governmentTribeID
			end
		end
		return currentGovernmentID 
	else
		return 0 
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsHasGovernment
function Player.IsHasGovernment(player, governmentID)
	if governmentID then
		return (player:GetCurrentGovernment() == governmentID)
	else
		return (player:GetCurrentGovernment() > governmentTribeID)
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--Player_GetGovernmentPreference
function Player_GetGovernmentPreference(player, isRandom)

	if (not isRandom) then
		local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
		--g_Civilization_JFD_Governments_Table
		local governmentsTable = g_Civilization_JFD_Governments_Table
		local numGovernments = #governmentsTable
		for index = 1, numGovernments do
			local row = governmentsTable[index]
			if row.CivilizationType == civType then
				local governmentType = row.GovernmentType
				local government = GameInfo.JFD_Governments[governmentType]
				local governmentPrefID = GameInfoTypes[governmentType]
				if governmentPrefID and player:CanHaveGovernment(governmentPrefID) then
					local flavour1 = player:GetFlavorValue(government.FlavorType1)
					local flavour2 = player:GetFlavorValue(government.FlavorType2)
					local weight = flavour1 + flavour2 + row.Weight
					return governmentPrefID, weight
				end
			end
		end
		
		local govtPreferenceID = nil
		local govtPreferenceWeight = 0
		--g_JFD_Governments_Table
		local governmentsTable = g_JFD_Governments_Table
		local numGovernments = #governmentsTable
		for index = 1, numGovernments do
			local row = governmentsTable[index]
			local governmentPrefID = row.ID
			local government = GameInfo.JFD_Governments[governmentPrefID]
			if government and player:CanHaveGovernment(governmentPrefID) then
				local flavour1 = player:GetFlavorValue(government.FlavorType1)
				local flavour2 = player:GetFlavorValue(government.FlavorType2)
				local weight = flavour1 + flavour2 
				if weight > govtPreferenceWeight then
					govtPreferenceID = governmentPrefID
					govtPreferenceWeight = weight
				end
			end
		end
		if govtPreferenceID then
			return govtPreferenceID, govtPreferenceWeight
		end
	else
		local validGovts = {}
		local numValidGovts = 1
		--g_JFD_Governments_Table
		local governmentsTable = g_JFD_Governments_Table
		local numGovernments = #governmentsTable
		for index = 1, numGovernments do
			local row = governmentsTable[index]
			local governmentID = row.ID
			local government = GameInfo.JFD_Governments[governmentID]
			if governmentID and (not government.IsHidden) and player:CanHaveGovernment(governmentID) then
				validGovts[numValidGovts] = governmentID
				numValidGovts = numValidGovts + 1
			end
		end
		return validGovts[g_GetRandom(1,#validGovts)]
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:DoInitiateGovernmentChoice
function Player.InitiateGovernmentChoice(player, governmentID, isFree, isFixedChoice)
	local playerID = player:GetID()
	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	if playerIsHuman then
		player:SetCanChangeGovernment(true, governmentID, isFree)
	else
		local currentGovernmentID = player:GetCurrentGovernment()
		if (not governmentID) or (governmentID and currentGovernmentID ~= governmentID) then
			local isInit = (currentGovernmentID == governmentTribeID)
			local isChanging = player:IsHasGovernment()
			if governmentID and isFixedChoice then
				player:SetHasGovernment(governmentID, isInit, isChanging, isFree)
			else
				local governmentPrefID, governmentPrefVal = Player_GetGovernmentPreference(player)
				if (governmentPrefID and governmentPrefID == governmentID) or (not governmentID) then
					if player:CanHaveGovernment(governmentPrefID) then
						if governmentPrefVal >= g_GetRandom(1,100) then
							player:SetHasGovernment(governmentPrefID, isInit, isChanging, isFree)
						else
							local newGovernmentPrefID = Player_GetGovernmentPreference(player, true)
							if newGovernmentPrefID then
								player:SetHasGovernment(newGovernmentPrefID, isInit, isChanging, isFree)
							end
						end
					end
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:InitiateGovernmentChangeConsideration
function Player.InitiateGovernmentChangeConsideration(player, currentGovernmentID, isReligious, isIdeological)
	if (not player:IsHuman()) then
		print(Game.GetGameTurn() .. " " .. player:GetName() .. " is considering changing Government!")
		local prefGovernmentID = Player_GetGovernmentPreference(player)
		if isReligious and prefGovernmentID ~= governmentTheocracyID then return end
		if isIdeological and prefGovernmentID ~= governmentTotalitarianID then return end
		if prefGovernmentID and prefGovernmentID ~= currentGovernmentID then
			player:SetHasGovernment(prefGovernmentID, false, true)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsCanChangeGovernment
function Player.IsCanChangeGovernment(player)
	local playerID = player:GetID()
	return JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"].IsCanChange, JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"].GovernmentID, JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"].IsFree
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetCanChangeGovernment
function Player.SetCanChangeGovernment(player, canChange, governmentID, isFree)
	local playerID = player:GetID()
	JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"] = {}
	if canChange then
		if player:IsHuman() and player:IsTurnActive() then
			Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_GOOD");	
			player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_CHOICE", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_GOVERNMENT_CHOICE_DESC"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_GOVERNMENT_CHOICE_SHORT_DESC"), false, nil, nil, -1)
			LuaEvents.JFD_Sovereignty_UI_BlockEndTurnButton(true, playerID)
		end
		
		JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"].IsCanChange = canChange
		if governmentID then
			JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"].GovernmentID = governmentID
		end
		if isFree then
			JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"].IsFree = true
		end
	else
		LuaEvents.JFD_Sovereignty_UI_BlockEndTurnButton(false, playerID)
		LuaEvents.UI_ClearNotification("GovernmentChoice")
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- GOVERNMENT TITLES UTILS
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Government_LeaderTitles_Table
local g_JFD_Government_LeaderTitles_Table = {}
local g_JFD_Government_LeaderTitles_Count = 1
for row in DB.Query("SELECT * FROM JFD_Government_Titles WHERE TitleLeader IS NOT NULL ORDER BY Priority;") do 	
	g_JFD_Government_LeaderTitles_Table[g_JFD_Government_LeaderTitles_Count] = row
	g_JFD_Government_LeaderTitles_Count = g_JFD_Government_LeaderTitles_Count + 1
end

--g_JFD_Government_StateTitles_Table
local g_JFD_Government_StateTitles_Table = {}
local g_JFD_Government_StateTitles_Count = 1
for row in DB.Query("SELECT * FROM JFD_Government_Titles WHERE TitleState IS NOT NULL ORDER BY Priority;") do 	
	g_JFD_Government_StateTitles_Table[g_JFD_Government_StateTitles_Count] = row
	g_JFD_Government_StateTitles_Count = g_JFD_Government_StateTitles_Count + 1
end

--g_JFD_Government_StyleTitles_Table
local g_JFD_Government_StyleTitles_Table = {}
local g_JFD_Government_StyleTitles_Count = 1
for row in DB.Query("SELECT * FROM JFD_Government_Titles WHERE TitleStyle IS NOT NULL ORDER BY Priority;") do 	
	g_JFD_Government_StyleTitles_Table[g_JFD_Government_StyleTitles_Count] = row
	g_JFD_Government_StyleTitles_Count = g_JFD_Government_StyleTitles_Count + 1
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetLeaderTitle
function Player.GetLeaderTitle(player, governmentID, includeEpithet, includeFullTitle, includeFullTitleWithStyle, otherPlayer)
	local isFeminine = player:IsLeaderFeminine()
	
	if otherPlayer then
		player = otherPlayer
	end
	
	if (not governmentID) then
		governmentID = player:GetCurrentGovernment()
		if governmentID == -1 then
			governmentID = governmentTribeID
		end
	end
	
	-- print("Getting Leader Title", debug.traceback())
	
	local playerID = player:GetID()
	local playerTeam = Teams[player:GetTeam()]
	local playerCapital = player:GetCapitalCity()
	local leaderName = g_ConvertTextKey(player:GetDefaultName())
	local government = GameInfo.JFD_Governments[governmentID]
	
	if player:IsMinorCiv() then
		--LEADER TITLE
		local minorCivID = player:GetMinorCivType()
		if minorCivID == -1 then
			minorCivID = otherPlayer:GetMinorCivType()
		end
		local strLeaderTitle = "TXT_KEY_JFD_TITLE_LEADER_" .. GameInfo.MinorCivilizations[minorCivID].Type
		
		--FEMALE
		if isFeminine then
			strLeaderTitle = strLeaderTitle .. "_FEMALE"
		end
		strLeaderTitle = g_ConvertTextKey(strLeaderTitle)

		return strLeaderTitle
		
	else
		--LEADER TITLE
		local strLeaderTitle
		local strLeaderTitleText 
		local strLeaderTitleStyleText 
		local isStateTitleDoNotUseCiv = false
		local isLeaderTitleAfterName = false
	
		--FEMALE
		--SPECIAL TITLES
		--g_JFD_Government_LeaderTitles_Table
		local titlesTable = g_JFD_Government_LeaderTitles_Table
		local numTitles = #titlesTable
		for index = 1, numTitles do
			local row = titlesTable[index]
			local strSpecialLeaderTitle = row.TitleLeader
			local isTitleMet = true
			
			--FEMALE
			if isFeminine then
				strSpecialLeaderTitle = strSpecialLeaderTitle .. "_FEMALE"
			end
			
			--Governments
			local thisGovernmentID = GameInfoTypes[row.GovernmentType]
			if (thisGovernmentID and governmentID == thisGovernmentID) or (not thisGovernmentID) then
				
				local thisGovernmentNOTID = GameInfoTypes[row.GovernmentTypeNOT]
				if (thisGovernmentNOTID and governmentID == thisGovernmentNOTID) then
					isTitleMet = false
				end
		
				--Cycle of Power
				local cyclePowerID = GameInfoTypes[row.CyclePowerType]
				if cyclePowerID and Player.GetCyclePower then
					if player:GetCyclePower() ~= cyclePowerID then
						isTitleMet = false
					end
				end
						
				--Era
				local eraID = GameInfoTypes[row.EraType]
				if eraID and player:GetCurrentEra() <= eraID then
					isTitleMet = false
				end
		
				--Beliefs
				local belief = row.BeliefType
				local beliefID = GameInfoTypes[belief]
				if beliefID then
					if Player.HasBelief then
						if (not player:HasBelief(beliefID)) then
							isTitleMet = false
						end
					else
						local hasBelief = false
						if player:GetBeliefInPantheon() == beliefID then 
							hasBelief = true
						end
						if (not hasBelief) then
							local religionID = player:GetMainReligion()
							if religionID > 0 then
								for i,v in ipairs(Game.GetBeliefsInReligion(religionID)) do
									local thisBelief = GameInfo.Beliefs[v]
									if beliefID == thisBelief.ID then
										hasBelief = true
										break
									end
								end
							end
						end
						if (not hasBelief) then
							isTitleMet = false
						end
					end
				elseif belief then
					isTitleMet = false
				end
				
				--Buildings
				local building = row.BuildingType
				local buildingID = GameInfoTypes[building]
				if buildingID then
					if player:CountNumBuildings(buildingID) == 0 then
						isTitleMet = false
					end
				elseif building then
					isTitleMet = false
				end
					
				--Ideologies
				local ideology = row.IdeologyType
				local ideologyID = GameInfoTypes[ideology]
				if ideologyID then
					if (not player:IsPolicyBranchUnlocked(ideologyID)) then
						isTitleMet = false
					end
				elseif ideology then
					isTitleMet = false
				end
					
				--Policy Branches
				local policyBranch = row.PolicyBranchType
				local policyBranchID = GameInfoTypes[policyBranch]
				if policyBranchID then
					if player:GetDominantPolicyBranchForTitle() ~= policyBranchID then
						isTitleMet = false
					end
				elseif policyBranch then
					isTitleMet = false
				end
					
				--Policies
				local policy = row.PolicyType
				local policyID = GameInfoTypes[policy]
				if policyID then
					if (not player:HasPolicy(policyID)) then
						isTitleMet = false
					end
				elseif policy then
					isTitleMet = false
				end
				local policyAND = row.PolicyTypeAND
				local policyANDID = GameInfoTypes[policyAND]
				if policyANDID then
					if (not player:HasPolicy(policyANDID)) then
						isTitleMet = false
					end
				elseif policyAND then
					isTitleMet = false
				end
					
				--Reforms
				local reform = row.ReformType
				local reformID = GameInfoTypes[reform]
				if reformID then
					if (not player:HasReform(reformID)) then
						isTitleMet = false
					end
				elseif reform then
					isTitleMet = false
				end
				local reformAND = row.ReformTypeAND
				local reformANDID = GameInfoTypes[reformAND]
				if reformANDID then
					if (not player:HasReform(reformANDID)) then
						isTitleMet = false
					end
				elseif reformAND then
					isTitleMet = false
				end
				local reformAND2 = row.ReformTypeAND2
				local reformAND2ID = GameInfoTypes[reformAND2]
				if reformAND2ID then
					if (not player:HasReform(reformAND2ID)) then
						isTitleMet = false
					end
				elseif reformAND2 then
					isTitleMet = false
				end
				local reformAND3 = row.ReformTypeAND3
				local reformAND3ID = GameInfoTypes[reformAND3]
				if reformAND3ID then
					if (not player:HasReform(reformAND3ID)) then
						isTitleMet = false
					end
				elseif reformAND3 then
					isTitleMet = false
				end
				local reformNOT = row.ReformTypeNOT
				local reformNOTID = GameInfoTypes[reformNOT]
				if reformNOTID then
					if player:HasReform(reformNOTID) then
						isTitleMet = false
					end
				elseif reformNOT then
					isTitleMet = false
				end
				
				--Anti-Pope
				if row.IsAntiPope then
					if (not Game.AnyoneHasGovernment(governmentPapacyID)) then
						isTitleMet = false
					end
				end
	
				--Religion Founded
				local religion = row.ReligionFoundedType
				local religionID = GameInfoTypes[religion]
				if religionID then
					if Game.GetFounderBenefitsReligion(playerID) ~= religionID then
						isTitleMet = false
					end
				elseif religion then
					isTitleMet = false
				end
		
				--State Religion
				local religion = row.StateReligionType
				local religionID = GameInfoTypes[religion]
				if religionID then
					local stateReligionID = player:GetMainReligion()
					if religionID and religionID ~= stateReligionID then
						isTitleMet = false
					end
				elseif religion then
					isTitleMet = false
				end
		
				--Vassals
				if row.IsVassalOfSomeone then
					if playerTeam.IsVassalOfSomeone then
						if (not playerTeam:IsVassalOfSomeone()) then
							isTitleMet = false
						end
						if row.IsVassalHRE then
							local playerMasterID = playerTeam:GetMaster()
							if playerMasterID ~= -1 then
								local playerMaster = Players[playerMasterID]
								if playerMaster:GetCurrentGovernment() ~= governmentHREID then
									isTitleMet = false
								end
							end
						end
					else
						isTitleMet = false
					end
				end
				
				--Historical Prime Ministers/Chancellors
				if row.IsLeaderPrimeMinister then
					if (not player:IsHistoricalPrimeMinister()) then
						isTitleMet = false
					end
				end	
				
				--Historical Regents
				if row.IsLeaderRegent then
					if (not player:IsHistoricalRegent()) then
						isTitleMet = false
					end
				end	
				
				if isTitleMet then
					strLeaderTitle = g_ConvertTextKey(strSpecialLeaderTitle)
					isStateTitleDoNotUseCiv = row.IsStateTitleDoNotUseCiv
					isLeaderTitleAfterName = row.IsLeaderTitleAfterName
				end
			else
				isTitleMet = false
			end
		end
	
		--LEADER FULL TITLE
		if includeFullTitle and strLeaderTitle then
			--EPITHET
			if includeEpithet then
				if Player.GetEpithetTitle then
					local strEpithet = player:GetEpithetTitle()
					if strEpithet then
						leaderName = leaderName .. " " .. g_ConvertTextKey(strEpithet)
					end
				end
			end
			if isLeaderTitleAfterName then
				strLeaderTitleText = g_ConvertTextKey("TXT_KEY_JFD_BLANK_LEADER_TITLE", leaderName, strLeaderTitle)
			else
				strLeaderTitleText = g_ConvertTextKey("TXT_KEY_JFD_BLANK_LEADER_TITLE", strLeaderTitle, leaderName)
			end
			
			--LEADER FULL TITLE WITH STYLE
			if includeFullTitleWithStyle then
				strLeaderTitleStyleText = leaderName
				
				local strStateTitle, strStateTitleText = player:GetStateTitle(governmentID, true)
				
				local isTitleStyleReqAndIsFirst = true
				--SPECIAL STYLES
				--g_JFD_Government_StyleTitles_Table
				local titlesTable = g_JFD_Government_StyleTitles_Table
				local numTitles = #titlesTable
				for index = 1, numTitles do
					local row = titlesTable[index]
					local strStyleTitle = row.TitleStyle
					if isFeminine then
						strStyleTitle = strStyleTitle .. "_FEMALE"
					end
					local isTitleStyleReqAnd = row.IsStyleRequiresAnd
					local isTitleMet = true
					
					--Beliefs
					local belief = row.BeliefType
					local beliefID = GameInfoTypes[belief]
					if beliefID then
						if Player.HasBelief then
							if (not player:HasBelief(beliefID)) then
								isTitleMet = false
							end
						else
							local hasBelief = false
							if player:GetBeliefInPantheon() == beliefID then 
								hasBelief = true
							end
							if (not hasBelief) then
								local religionID = player:GetMainReligion()
								if religionID > 0 then
									for i,v in ipairs(Game.GetBeliefsInReligion(religionID)) do
										local belief = GameInfo.Beliefs[v]
										if beliefID == belief.ID then
											hasBelief = true
											break
										end
									end
								end
							end
							if (not hasBelief) then
								isTitleMet = false
							end
						end
					elseif belief then
						isTitleMet = false
					end
	
					--Buildings
					local building = row.BuildingType
					local buildingID = GameInfoTypes[building]
					if buildingID then
						if player:CountNumBuildings(buildingID) == 0 then
							isTitleMet = false
						end
					elseif building then
						isTitleMet = false
					end
						
					--Ideologies
					local ideology = row.IdeologyType
					local ideologyID = GameInfoTypes[ideology]
					if ideologyID then
						if (not player:IsPolicyBranchUnlocked(ideologyID)) then
							isTitleMet = false
						end
					elseif ideology then
						isTitleMet = false
					end
						
					--Policies
					local policy = row.PolicyType
					local policyID = GameInfoTypes[policy]
					if policyID then
						if (not player:HasPolicy(policyID)) then
							isTitleMet = false
						end
					elseif policy then
						isTitleMet = false
					end
					local policyAND = row.PolicyTypeAND
					local policyANDID = GameInfoTypes[policyAND]
					if policyANDID then
						if (not player:HasPolicy(policyANDID)) then
							isTitleMet = false
						end
					elseif policyAND then
						isTitleMet = false
					end
			
					--Governments
					local reqGovernmentID = GameInfoTypes[row.GovernmentType]
					if (reqGovernmentID and governmentID ~= reqGovernmentID) then
						isTitleMet = false
					end
					local thisGovernmentNOTID = GameInfoTypes[row.GovernmentTypeNOT]
					if (thisGovernmentNOTID and governmentID == thisGovernmentNOTID) then
						isTitleMet = false
					end
						
					--Reforms
					local reform = row.ReformType
					local reformID = GameInfoTypes[reform]
					if reformID then
						if (not player:HasReform(reformID)) then
							isTitleMet = false
						end
					elseif reform then
						isTitleMet = false
					end
					local reformAND = row.ReformTypeAND
					local reformANDID = GameInfoTypes[reformAND]
					if reformANDID then
						if (not player:HasReform(reformANDID)) then
							isTitleMet = false
						end
					elseif reformAND then
						isTitleMet = false
					end
					local reformAND2 = row.ReformTypeAND2
					local reformAND2ID = GameInfoTypes[reformAND2]
					if reformAND2ID then
						if (not player:HasReform(reformAND2ID)) then
							isTitleMet = false
						end
					elseif reformAND2 then
						isTitleMet = false
					end
					local reformAND3 = row.ReformTypeAND3
					local reformAND3ID = GameInfoTypes[reformAND3]
					if reformAND3ID then
						if (not player:HasReform(reformAND3ID)) then
							isTitleMet = false
						end
					elseif reformAND3 then
						isTitleMet = false
					end
					local reformNOT = row.ReformTypeNOT
					local reformNOTID = GameInfoTypes[reformNOT]
					if reformNOTID then
						if player:HasReform(reformNOTID) then
							isTitleMet = false
						end
					elseif reformNOT then
						isTitleMet = false
					end
	
					--Religion Founded
					local religion = row.ReligionFoundedType
					local religionID = GameInfoTypes[religion]
					if religionID then
						if Game.GetFounderBenefitsReligion(playerID) ~= religionID then
							isTitleMet = false
						end
					elseif religion then
						isTitleMet = false
					end
			
					--State Religion
					local religion = row.StateReligionType
					local religionID = GameInfoTypes[religion]
					if religionID then
						local stateReligionID = player:GetMainReligion()
						if religionID and religionID ~= stateReligionID then
							isTitleMet = false
						end
					elseif religion then
						isTitleMet = false
					end
					
					if isTitleMet then
						if row.UseAdjectiveInLocalization then
							local civAdj = player:GetCivilizationAdjective()
							strStyleTitle = g_ConvertTextKey(strStyleTitle, civAdj)
						end
						if row.UseGovernmentDescriptionInLocalization then
							local govtDesc = government.Description
							strStyleTitle = g_ConvertTextKey(strStyleTitle, govtDesc)
						end
						if row.UseDescriptionInLocalization then
							local civDesc = player:GetCivilizationShortDescription()
							strStyleTitle = g_ConvertTextKey(strStyleTitle, civDesc)
						end
						if row.UseReligionInLocalization then
							local mainReligionID = player:GetMainReligion()
							if mainReligionID > -1 then
								local religionAdj = GameInfo.Religions[mainReligionID].Adjective
								if religionAdj then
									strStyleTitle = g_ConvertTextKey(strStyleTitle, religionAdj)
								end
							end
						end
						if row.UseCapitalInLocalization and playerCapital then
							strStyleTitle = g_ConvertTextKey(strStyleTitle, playerCapital:GetName())
						end
						
						if isTitleStyleReqAnd then
							if isTitleStyleReqAndIsFirst then
								strLeaderTitleStyleText = strLeaderTitleStyleText .. ", " .. g_ConvertTextKey(strStyleTitle)
								isTitleStyleReqAndIsFirst = false
							else
								strLeaderTitleStyleText = strLeaderTitleStyleText .. ", " .. g_ConvertTextKey("TXT_KEY_JFD_TITLE_AND") .. " " .. g_ConvertTextKey(strStyleTitle)
							end
						else
							strLeaderTitleStyleText = strLeaderTitleStyleText .. ", " .. g_ConvertTextKey(strStyleTitle)
						end
					end
				end
				
				if (not isStateTitleDoNotUseCiv) then
					strLeaderTitleStyleText = strLeaderTitleStyleText .. ", " .. g_ConvertTextKey(strLeaderTitle) .. " " .. g_ConvertTextKey("TXT_KEY_JFD_TITLE_OF") .. " " .. player:GetCivilizationShortDescription()
				else
					strLeaderTitleStyleText = strLeaderTitleStyleText .. ", " .. g_ConvertTextKey(strLeaderTitle)
				end
				
				--CONQUESTS
				if player:HasReform(reformTerritoryEmpireID) then
					for city in player:Cities() do
						if (city:IsOriginalCapital() and city:GetOriginalOwner() ~= playerID) then	
							local originalOwnerID = city:GetOriginalOwner()
							local originalOwner = Players[originalOwnerID]
							local originalOwnerCivDesc = originalOwner:GetCivilizationShortDescription()
							local originalGovernmentID = originalOwner:GetCurrentGovernment()
							local originalGovernment = GameInfo.JFD_Governments[originalGovernmentID]
							local strConqueredTitle
							if (not originalGovernment.IsSpecial) then
								strConqueredTitle = player:GetLeaderTitle(originalGovernmentID, false, false, false, originalOwner)
							else
								strConqueredTitle = player:GetLeaderTitle(governmentID, false, false, false, originalOwner)
							end
							strLeaderTitleStyleText = strLeaderTitleStyleText .. ", " .. g_ConvertTextKey(strConqueredTitle) .. " " .. g_ConvertTextKey("TXT_KEY_JFD_TITLE_OF") .. " " .. originalOwnerCivDesc
						end
					end
				end
			end
		end

		return strLeaderTitle, strLeaderTitleText, strLeaderTitleStyleText
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetStateTitle
function Player.GetStateTitle(player, governmentID, includeFullTitle)
	if (not governmentID) then
		governmentID = player:GetCurrentGovernment()
		if governmentID == -1 then
			governmentID = governmentTribeID
		end
	end
	
	local playerID = player:GetID()
	local playerTeam = Teams[player:GetTeam()]
	local playerCapital = player:GetCapitalCity()
	local civName = player:GetCivilizationShortDescription()
	local civAdj = player:GetCivilizationAdjective()
	local government = GameInfo.JFD_Governments[governmentID]
	local isNotCivNameInUse = false
	local isUseAdjective = false
	local isStateTitleOmitOf = false
	
	if player:IsMinorCiv() then
		--STATE TITLE
		local strStateTitle = "TXT_KEY_JFD_TITLE_STATE_" .. GameInfo.MinorCivilizations[player:GetMinorCivType()].Type
		strStateTitle = g_ConvertTextKey("TXT_KEY_JFD_BLANK_STATE_TITLE", strStateTitle, player:GetCivilizationShortDescription())
		
		return strStateTitle
	else
	
		--STATE TITLE
		local strStateTitle
		local strStateTitleText
		
		--SPECIAL TITLES
		--g_JFD_Government_StateTitles_Table
		local titlesTable = g_JFD_Government_StateTitles_Table
		local numTitles = #titlesTable
		for index = 1, numTitles do
			local row = titlesTable[index]
			local strSpecialStateTitle = row.TitleState
			local isTitleMet = true
			
			--Governments
			local thisGovernmentID = GameInfoTypes[row.GovernmentType]
			if (thisGovernmentID and governmentID == thisGovernmentID) or (not thisGovernmentID) then
				
				local thisGovernmentNOTID = GameInfoTypes[row.GovernmentTypeNOT]
				if (thisGovernmentNOTID and governmentID == thisGovernmentNOTID) then
					isTitleMet = false
				end
		
				--Cycle of Power
				local cyclePowerID = GameInfoTypes[row.CyclePowerType]
				if cyclePowerID and Player.GetCyclePower then
					if player:GetCyclePower() ~= cyclePowerID then
						isTitleMet = false
					end
				end
				
				--Faction
				local factionID = GameInfoTypes[row.FactionType]
				if factionID and player:GetDominantFaction() ~= factionID then
					isTitleMet = false
				end
				
				--Anti-Pope
				if row.IsAntiPope then
					if (not Game.AnyoneHasGovernment(governmentPapacyID)) then
						isTitleMet = false
					end
				end
						
				--Era
				local eraID = GameInfoTypes[row.EraType]
				if eraID and player:GetCurrentEra() <= eraID then
					isTitleMet = false
				end
		
				--Beliefs
				local belief = row.BeliefType
				local beliefID = GameInfoTypes[belief]
				if beliefID then
					if Player.HasBelief then
						if (not player:HasBelief(beliefID)) then
							isTitleMet = false
						end
					else
						local hasBelief = false
						if player:GetBeliefInPantheon() == beliefID then 
							hasBelief = true
						end
						if (not hasBelief) then
							local religionID = player:GetMainReligion()
							if religionID > 0 then
								for i,v in ipairs(Game.GetBeliefsInReligion(religionID)) do
									local belief = GameInfo.Beliefs[v]
									if beliefID == belief.ID then
										hasBelief = true
										break
									end
								end
							end
						end
						if (not hasBelief) then
							isTitleMet = false
						end
					end
				elseif belief then
					isTitleMet = false
				end
		
				--Buildings
				local building = row.BuildingType
				local buildingID = GameInfoTypes[building]
				if buildingID then
					if player:CountNumBuildings(buildingID) == 0 then
						isTitleMet = false
					end
				elseif building then
					isTitleMet = false
				end
					
				--Ideologies
				local ideology = row.IdeologyType
				local ideologyID = GameInfoTypes[ideology]
				if ideologyID then
					if (not player:IsPolicyBranchUnlocked(ideologyID)) then
						isTitleMet = false
					end
				elseif ideology then
					isTitleMet = false
				end
					
				--Policies
				local policy = row.PolicyType
				local policyID = GameInfoTypes[policy]
				if policyID then
					if (not player:HasPolicy(policyID)) then
						isTitleMet = false
					end
				elseif policy then
					isTitleMet = false
				end
				local policyAND = row.PolicyTypeAND
				local policyANDID = GameInfoTypes[policyAND]
				if policyANDID then
					if (not player:HasPolicy(policyANDID)) then
						isTitleMet = false
					end
				elseif policyAND then
					isTitleMet = false
				end
					
				--Reforms
				local reform = row.ReformType
				local reformID = GameInfoTypes[reform]
				if reformID then
					if (not player:HasReform(reformID)) then
						isTitleMet = false
					end
				elseif reform then
					isTitleMet = false
				end
				local reformAND = row.ReformTypeAND
				local reformANDID = GameInfoTypes[reformAND]
				if reformANDID then
					if (not player:HasReform(reformANDID)) then
						isTitleMet = false
					end
				elseif reformAND then
					isTitleMet = false
				end
				local reformAND2 = row.ReformTypeAND2
				local reformAND2ID = GameInfoTypes[reformAND2]
				if reformAND2ID then
					if (not player:HasReform(reformAND2ID)) then
						isTitleMet = false
					end
				elseif reformAND2 then
					isTitleMet = false
				end
				local reformAND3 = row.ReformTypeAND3
				local reformAND3ID = GameInfoTypes[reformAND3]
				if reformAND3ID then
					if (not player:HasReform(reformAND3ID)) then
						isTitleMet = false
					end
				elseif reformAND3 then
					isTitleMet = false
				end
				local reformNOT = row.ReformTypeNOT
				local reformNOTID = GameInfoTypes[reformNOT]
				if reformNOTID then
					if player:HasReform(reformNOTID) then
						isTitleMet = false
					end
				elseif reformNOT then
					isTitleMet = false
				end
		
				--Religion Founded
				local religion = row.ReligionFoundedType
				local religionID = GameInfoTypes[religion]
				if religionID then
					if Game.GetFounderBenefitsReligion(playerID) ~= religionID then
						isTitleMet = false
					end
				elseif religion then
					isTitleMet = false
				end
		
				--State Religion
				local religion = row.StateReligionType
				local religionID = GameInfoTypes[religion]
				if religionID then
					local stateReligionID = player:GetMainReligion()
					if religionID and religionID ~= stateReligionID then
						isTitleMet = false
					end
				elseif religion then
					isTitleMet = false
				end
		
				--Vassals
				if row.IsVassalOfSomeone then
					if playerTeam.IsVassalOfSomeone then
						if (not playerTeam:IsVassalOfSomeone()) then
							isTitleMet = false
						end
						if row.IsVassalHRE then
							local playerMasterID = playerTeam:GetMaster()
							if playerMasterID ~= -1 then
								local playerMaster = Players[playerMasterID]
								if playerMaster:GetCurrentGovernment() ~= governmentHREID then
									isTitleMet = false
								end
							end
						end
					else
						isTitleMet = false
					end
				end
				
				--City-State Allies
				if row.MinNumCityStateAllies then
					if player:GetNumCityStatePartners() < row.MinNumCityStateAllies then
						isTitleMet = false
					end
				end
				
				if row.UseReligionAsAdjective then
					local mainReligionID = player:GetMainReligion()
					if mainReligionID > -1 then
						local religionAdj = GameInfo.Religions[mainReligionID].Adjective
						if religionAdj then
							strSpecialStateTitle = g_ConvertTextKey(strSpecialStateTitle, religionAdj)
						else
							isTitleMet = false
						end
					else
						isTitleMet = false
					end
				end
				
				if isTitleMet then
					isNotCivNameInUse = row.IsStateTitleDoNotUseCiv
					isStateTitleReverse = row.IsStateTitleReverse
					isUseAdjective = row.UseAdjective
					isStateTitleOmitOf = row.IsStateTitleOmitOf
					
					if row.UseCapital then
						civName = playerCapital:GetName()
					end
					
					if row.UseAdjectiveInLocalization then
						local civAdj = player:GetCivilizationAdjective()
						strStateTitle = g_ConvertTextKey(strSpecialStateTitle, civAdj)
					elseif row.UseCapitalInLocalization then
						strStateTitle = g_ConvertTextKey(strSpecialStateTitle, playerCapital:GetName())
					else
						strStateTitle = g_ConvertTextKey(strSpecialStateTitle)
					end
				end
			else
				isTitleMet = false
			end
		end
	
		--STATE FULL TITLE
		if includeFullTitle then
			if isNotCivNameInUse then
				strStateTitleText = strStateTitle
			else
				if strStateTitle then
					if isStateTitleOmitOf then
						strStateTitleText = g_ConvertTextKey("TXT_KEY_JFD_BLANK_STATE_TITLE_NO_OF", strStateTitle, civName)
					else
						strStateTitleText = g_ConvertTextKey("TXT_KEY_JFD_BLANK_STATE_TITLE", strStateTitle, civName)
					end
				end
	
				--PLURAL
				if (player:IsCivilizationPlural() or isStateTitleReverse or isUseAdjective) and strStateTitle then
					strStateTitleText = g_ConvertTextKey("TXT_KEY_JFD_BLANK_STATE_TITLE_REVERSE", strStateTitle, civAdj)
				end
			end
		end
		
		return strStateTitle, strStateTitleText
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:UpdateLeaderName
function Player.UpdateLeaderName(player, governmentID)
	local playerID = player:GetID()
	local _, strLeaderTitleText = player:GetLeaderTitle(governmentID, false, true)
	local strCurrentDesc = player:GetName()
	if strLeaderTitleText and strLeaderTitleText ~= strCurrentDesc then
		PreGame.SetLeaderName(playerID, strLeaderTitleText)
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:UpdateCivilizationStateDescription
function Player.UpdateCivilizationStateDescription(player, governmentID)
	local playerID = player:GetID()
	local strStateTitle, strStateTitleText = player:GetStateTitle(governmentID, true)
	local strCurrentDesc = player:GetCivilizationDescription()
	if strStateTitleText and strStateTitleText ~= strCurrentDesc then
		PreGame.SetCivilizationDescription(playerID, strStateTitleText)
	end
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Government_Names_Table
local g_JFD_Government_Names_Table = {}
local g_JFD_Government_Names_Count = 1
for row in DB.Query("SELECT * FROM JFD_Government_Names;") do 
	g_JFD_Government_Names_Table[g_JFD_Government_Names_Count] = row
	g_JFD_Government_Names_Count = g_JFD_Government_Names_Count + 1
end

--Player:GetGovernmentName
function Player.GetGovernmentName(player, governmentID)
	local government = GameInfo.JFD_Governments[governmentID]
	local governmentType = government.Type
	local currentEraID = player:GetCurrentEra()
	local strGovernmentName = ""
	
	if government.IsUnique then
		return g_ConvertTextKey(government.Description)
	end
	 
	--g_JFD_Government_Names_Table
	local governmentsTable = g_JFD_Government_Names_Table
	local numGovernments = #governmentsTable
	for index = 1, numGovernments do
		local row = governmentsTable[index]
		local isNameValid = true
		
		local reqGovernment = row.GovernmentType
		local reqGovernmentID = GameInfoTypes[reqGovernment]
		if ((reqGovernment and governmentID == reqGovernmentID) or (not reqGovernment)) then
		
			if row.IsAnarchy and (not player:IsAnarchy()) then
				isNameValid = false
			end
			
			local reqEra = row.EraType
			if reqEra then
				local reqEraID = GameInfoTypes[reqGovernment]
				if reqEraID then
					if currentEraID ~= reqEraID then
						isNameValid = false
					end
				else
					isNameValid = false
				end
			end
			
			local reqReform = row.ReformType
			if reqReform then
				local reqReformID = GameInfoTypes[reqReform]
				if (not player:HasReform(reqReformID)) then
					isNameValid = false
				end
			end
			local reqReformAND = row.ReformTypeAND
			if reqReformAND then
				local reqReformANDID = GameInfoTypes[reqReformAND]
				if (not player:HasReform(reqReformANDID)) then
					isNameValid = false
				end
			end
			local reqReformNOT = row.ReformTypeNOT
			if reqReformNOT then
				local reqReformNOTID = GameInfoTypes[reqReformNOT]
				if player:HasReform(reqReformNOTID) then
					isNameValid = false
				end
			end
				
			local reqIdeology = row.IdeologyType
			if reqIdeology then
				local reqIdeologyID = GameInfoTypes[reqIdeology]
				if reqIdeologyID then
					if player:GetIdeology() ~= reqIdeologyID then
						isNameValid = false
					end
				else
					isNameValid = false
				end
			end
			
			local reqReligion = row.ReligionType
			if reqReligion then
				local reqReligionID = GameInfoTypes[reqReligion]
				if reqReligionID then
					if player:GetMainReligion() ~= reqReligionID then
						isNameValid = false
					end
				else
					isNameValid = false
				end
			end
			
			local reqFaction = row.FactionType
			if reqFaction then
				local reqFactionID = GameInfoTypes[reqFaction]
				if reqFactionID then
					if player:GetDominantFaction() ~= reqFactionID then
						isNameValid = false
					end
				else
					isNameValid = false
				end
			end
				
			local reqPolicy = row.PolicyType
			if reqPolicy then
				local reqPolicyID = GameInfoTypes[reqPolicy]
				if (not player:HasPolicy(reqPolicyID)) then
					isNameValid = false
				end
			end
			
			local reqBuilding = row.BuildingType
			if reqBuilding then
				local reqBuildingID = GameInfoTypes[reqBuilding]
				if player:CountNumBuildings(reqBuildingID) == 0 then
					isNameValid = false
				end
			end
			
			if row.IsNoCities then
				if player:GetNumCities() > 0 then
					isNameValid = false
				end
			end
		else
			isNameValid = false
		end
		
		if isNameValid then
			strGovernmentName = g_ConvertTextKey(row.Name)
			if row.UseReligionAdj then
				local mainReligionID = player:GetMainReligion()
				if mainReligionID > -1 then
					local religionAdj = GameInfo.Religions[mainReligionID].Adjective
					if religionAdj then
						strGovernmentName = g_ConvertTextKey(row.Name, religionAdj) .. " " .. strGovernmentName
					end
				end
			end
			
			if (not row.IsFullGovName) then
				if row.IsAfterGovName then  
					strGovernmentName = g_ConvertTextKey(government.Description)  .. " " .. g_ConvertTextKey(row.Name)
				else
					strGovernmentName = g_ConvertTextKey(row.Name)  .. " " .. g_ConvertTextKey(government.Description)
				end
			end	
		end	
	end
	
	return strGovernmentName
end
--==========================================================================================================================
-- LEGISLATURE UTILS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Faction_FavouredReforms_Table
local g_JFD_Faction_FavouredReforms_Table = {}
local g_JFD_Faction_FavouredReforms_Count = 1
for row in DB.Query("SELECT * FROM JFD_Faction_FavouredReforms;") do 	
	g_JFD_Faction_FavouredReforms_Table[g_JFD_Faction_FavouredReforms_Count] = row
	g_JFD_Faction_FavouredReforms_Count = g_JFD_Faction_FavouredReforms_Count + 1
end

--g_JFD_Faction_FavouredReforms_ReformTypes_Table
local g_JFD_Faction_FavouredReforms_ReformTypes_Table = {}
local g_JFD_Faction_FavouredReforms_ReformTypes_Count = 1
for row in DB.Query("SELECT * FROM JFD_Faction_FavouredReforms WHERE ReformType IS NOT NULL;") do 	
	g_JFD_Faction_FavouredReforms_ReformTypes_Table[g_JFD_Faction_FavouredReforms_ReformTypes_Count] = row
	g_JFD_Faction_FavouredReforms_ReformTypes_Count = g_JFD_Faction_FavouredReforms_ReformTypes_Count + 1
end

--g_JFD_Reforms_FactionSupportSovMod_Table
local g_JFD_Reforms_FactionSupportSovMod_Table = {}
local g_JFD_Reforms_FactionSupportSovMod_Count = 1
for row in DB.Query("SELECT ID, FactionSupportSovMod FROM JFD_Reforms WHERE ShowInGovernment = 1 AND FactionSupportSovMod <> 0;") do 	
	g_JFD_Reforms_FactionSupportSovMod_Table[g_JFD_Reforms_FactionSupportSovMod_Count] = row
	g_JFD_Reforms_FactionSupportSovMod_Count = g_JFD_Reforms_FactionSupportSovMod_Count + 1
end

--g_JFD_Faction_OpposedReforms_Table
local g_JFD_Faction_OpposedReforms_Table = {}
local g_JFD_Faction_OpposedReforms_Count = 1
for row in DB.Query("SELECT * FROM JFD_Faction_OpposedReforms;") do 	
	g_JFD_Faction_OpposedReforms_Table[g_JFD_Faction_OpposedReforms_Count] = row
	g_JFD_Faction_OpposedReforms_Count = g_JFD_Faction_OpposedReforms_Count + 1
end

--g_JFD_Faction_OpposedReforms_ReformTypes_Table
local g_JFD_Faction_OpposedReforms_ReformTypes_Table = {}
local g_JFD_Faction_OpposedReforms_ReformTypes_Count = 1
for row in DB.Query("SELECT * FROM JFD_Faction_OpposedReforms WHERE ReformType IS NOT NULL;") do 	
	g_JFD_Faction_OpposedReforms_ReformTypes_Table[g_JFD_Faction_OpposedReforms_ReformTypes_Count] = row
	g_JFD_Faction_OpposedReforms_ReformTypes_Count = g_JFD_Faction_OpposedReforms_ReformTypes_Count + 1
end

--g_JFD_Reforms_FactionOppositionSovMod_Table
local g_JFD_Reforms_FactionOppositionSovMod_Table = {}
local g_JFD_Reforms_FactionOppositionSovMod_Count = 1
for row in DB.Query("SELECT ID, FactionOppositionSovMod FROM JFD_Reforms WHERE ShowInGovernment = 1 AND FactionOppositionSovMod <> 0;") do 	
	g_JFD_Reforms_FactionOppositionSovMod_Table[g_JFD_Reforms_FactionOppositionSovMod_Count] = row
	g_JFD_Reforms_FactionOppositionSovMod_Count = g_JFD_Reforms_FactionOppositionSovMod_Count + 1
end
----------------------------------------------------------------------------------------------------------------------------
-- FACTION UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetDominantFaction
function Player.GetDominantFaction(player, returnsTT)
	local factionID = -1
	local factionPower = -1

	--g_JFD_Factions_Table
	local factionsTable = g_JFD_Factions_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local thisFactionID = row.ID
		if player:IsFactionValid(thisFactionID) then	
			local thisFactionPower = player:GetFactionPower(thisFactionID)
			if thisFactionPower > factionPower then
				factionID = thisFactionID
				factionPower = thisFactionPower
			end
		end	
	end
	
	local strDominantFactionTT
	if returnsTT then
		if factionID > -1 then
			strDominantFactionTT = g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_DOMINANT_FACTION_TT", player:GetFactionName(factionID))
			local numFactionSovMod, strFactionSovMod = Player_GetFactionSovModifier(player, true)
			if strFactionSovMod then
				strDominantFactionTT = strDominantFactionTT .. strFactionSovMod
			end
		else
			strDominantFactionTT = g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_DOMINANT_FACTION_NONE_TT")
		end
	end

	return factionID, factionPower, strDominantFactionTT
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetFactionPower
function Player.GetFactionPower(player, factionID)
	if Player.GetPoliticPercent then
		return player:GetPoliticPercent(factionID)
	else
		local playerID = player:GetID()
		return JFD_RTP_Sovereignty[playerID .. "_" .. factionID .. "_POWER"] or -1
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetFactionPower
function Player.SetFactionPower(player, factionID, setVal)
	if Player.SetPoliticPercent then
		return player:SetPoliticPercent(factionID, setVal)
	else
		local playerID = player:GetID()
		JFD_RTP_Sovereignty[playerID .. "_" .. factionID .. "_POWER"] = setVal
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Faction_Names_Table
local g_JFD_Faction_Names_Table = {}
local g_JFD_Faction_Names_Count = 1
for row in DB.Query("SELECT * FROM JFD_Faction_Names;") do 	
	g_JFD_Faction_Names_Table[g_JFD_Faction_Names_Count] = row
	g_JFD_Faction_Names_Count = g_JFD_Faction_Names_Count + 1
end

--Player:GetIntendedFactionName
function Player.GetIntendedFactionName(player, factionID, governmentID, otherPlayerID)
	local playerCapital = player:GetCapitalCity()
	local civAdj = player:GetCivilizationAdjective()
	local civShortDesc = player:GetCivilizationShortDescription()
	
	local dominantFactionID = player:GetDominantFaction() 
	if dominantFactionID == factionID then	
		if g_GetRandom(1,100) <= 75 then
			local factionName = player:GetFactionName(dominantFactionID)
			return factionName 
		end
	end
	
	local religionAdj = ""
	local religionID = player:GetMainReligion()
	if religionID ~= -1 then
		religionAdj = GameInfo.Religions[religionID].Adjective
	end
	
	local faction = GameInfo.JFD_Factions[factionID]
	local factionType = faction.Type
	local strName = g_ConvertTextKey(faction.Description)
	
	local currentEraID = player:GetCurrentEra()
	
	local factionPartyTable = {}
	local factionPartyCount = 1
	
	--g_JFD_Faction_Names_Table
	local factionsTable = g_JFD_Faction_Names_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		if row.FactionType == factionType then		
			local strNameIntended = g_ConvertTextKey(row.Name)
			local isNameValid = true
			
			if row.IsReligious then
				if religionID ~= -1 then
					local reqReligionID = GameInfoTypes[row.ReligionType]
					if reqReligionID then
						if religionID ~= reqReligionID then
							isNameValid = false
						end
					end
				else
					isNameValid = false
				end
			end
			
			local reqGovernment = row.GovernmentType
			if reqGovernment then
				local reqGovernmentID = GameInfoTypes[reqGovernment]
				if governmentID ~= reqGovernmentID then
					isNameValid = false
				end
			end
			
			local reqPolicyBranch = row.PolicyBranchType
			if reqPolicyBranch then
				local reqPolicyBranchID = GameInfoTypes[reqPolicyBranch]
				if reqPolicyBranchID and (not player:IsPolicyBranchUnlocked(reqPolicyBranchID)) then
					isNameValid = false
				elseif (not reqPolicyBranchID) then
					isNameValid = false
				end
			end
			
			local reqPolicy = row.PolicyType
			if reqPolicy then
				local reqPolicyID = GameInfoTypes[reqPolicy]
				if reqPolicyID and (not player:HasPolicy(reqPolicyID)) then
					isNameValid = false
				elseif (not reqPolicyID) then
					isNameValid = false
				end
			end
			
			local reqReform = row.ReformType
			if reqReform then
				local reqReformID = GameInfoTypes[reqReform]
				if (not player:HasReform(reqReformID)) then
					isNameValid = false
				end
			end
			
			local reqReformNOT = row.ReformTypeNOT
			if reqReformNOT then
				local reqReformNOTID = GameInfoTypes[reqReformNOT]
				if player:HasReform(reqReformNOTID) then
					isNameValid = false
				end
			end
			
			local reqAnyIdeology = row.ReqIdeology
			if reqAnyIdeology then
				if player:GetIdeology() == -1 then
					isNameValid = false
				end
			end
			
			local reqIdeology = row.IdeologyType
			if reqIdeology then
				local reqIdeologyID = GameInfoTypes[reqIdeology]
				if reqIdeologyID then
					if player:GetIdeology() ~= reqIdeologyID then
						isNameValid = false
					end
				else
					isNameValid = false
				end
			end
			
			if row.ReqNoIdeology then
				if player:GetIdeology() ~= -1 then
					isNameValid = false
				end
			end
			
			local minEra = row.MinEra
			if minEra then
				local minEraID = GameInfoTypes[minEra]
				if currentEraID < minEraID then
					isNameValid = false
				end
			end
			
			if isNameValid then
				if row.IsReligious then
					if religionAdj then
						strName = g_ConvertTextKey(row.Name, religionAdj)
					else
						strName = g_ConvertTextKey(row.Name, "TXT_KEY_JFD_FACTION_JFD_RELIGIOUS_NAME_1")
					end
				else
					strName = strNameIntended
				end
				
				if row.UsePlayerAdj then
					strName = g_ConvertTextKey("TXT_KEY_JFD_FACTION_PREFIX_CIV", player:GetCivilizationAdjective()) .. " " .. g_ConvertTextKey(strName)
				end
				
				if row.UsePlayerDesc then
					strName = g_ConvertTextKey(strName) .. " " .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SUFFIX_OF_CIV", player:GetCivilizationShortDescription())
				end
				
				if row.UseCustomPlayerAdj and otherPlayerID then
					local otherPlayer = Players[otherPlayerID]
					strName = g_ConvertTextKey("TXT_KEY_JFD_FACTION_PREFIX_CIV", otherPlayer:GetCivilizationAdjective()) .. " " .. g_ConvertTextKey(strName)
				end
			
				if row.UseCustomPlayerDesc and otherPlayerID then
					local otherPlayer = Players[otherPlayerID]
					strName = g_ConvertTextKey(strName) .. " " .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SUFFIX_OF_CIV", otherPlayer:GetCivilizationShortDescription())
				end
			
				if row.IsRandom then
					local prefixCiv = g_ConvertTextKey("TXT_KEY_JFD_FACTION_PREFIX_CIV", civAdj)
					
					if (not row.NoPrefixOrSuffix) then
						local suffixChance = g_GetRandom(1,100)
						if suffixChance <= 10 then
							local suffixDesc = "TXT_KEY_JFD_FACTION_SUFFIX_" .. g_GetRandom(1,26)
							strName = strName .. " " .. g_ConvertTextKey(suffixDesc)
						end
					end
					
					if (not row.NoGroup) then
						local groupDesc = "TXT_KEY_JFD_FACTION_GROUP_" .. g_GetRandom(1,35)
						strName = strName .. " " .. g_ConvertTextKey(groupDesc)
					end
					
					if row.AlwaysUseCivDesc then
						local prefixCiv = g_ConvertTextKey("TXT_KEY_JFD_FACTION_PREFIX_CIV", civShortDesc)
						strName = prefixCiv .. " " .. strName
					else
						local suffixChance = g_GetRandom(1,100)
						if suffixChance <= 25 then
							local suffixOfCiv = g_ConvertTextKey("TXT_KEY_JFD_FACTION_SUFFIX_OF_CIV", civShortDesc)
							strName = strName .. " " .. suffixOfCiv
						else
							local prefixChance = g_GetRandom(1,100)
							if prefixChance <= 25 then
								local prefixCiv = g_ConvertTextKey("TXT_KEY_JFD_FACTION_PREFIX_CIV", civAdj)
								strName = prefixCiv .. " " .. strName
							end
							
							if (not row.NoPrefixOrSuffix) then
								local prefixChance = g_GetRandom(1,100)
								if prefixChance <= 20 then
									local prefixDesc = "TXT_KEY_JFD_FACTION_PREFIX_" .. g_GetRandom(1,18)
									strName = g_ConvertTextKey(prefixDesc) .. " " .. strName
								end
							end
						end
					end
				end
				
				factionPartyTable[factionPartyCount] = strName
				factionPartyCount = factionPartyCount + 1
			end
		end
	end
	
	if #factionPartyTable > 0 then
		return factionPartyTable[g_GetRandom(1,#factionPartyTable)]
	end
	
	return strName
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetFactionName
function Player.GetFactionName(player, factionID)
	local playerID = player:GetID()
	local faction = GameInfo.JFD_Factions[factionID]
	local factionType = faction.Type
	return JFD_RTP_Sovereignty[playerID .. "_" .. factionType .. "_NAME"] or g_ConvertTextKey(faction.Description)
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetFactionName
function Player.SetFactionName(player, factionID, strName)
	local playerID = player:GetID()
	local factionType = GameInfo.JFD_Factions[factionID].Type
	JFD_RTP_Sovereignty[playerID .. "_" .. factionType .. "_NAME"] = strName
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetFactionCivType
function Player.GetFactionCivType(player, factionID)
	local playerID = player:GetID()
	local faction = GameInfo.JFD_Factions[factionID]
	local factionType = faction.Type
	return JFD_RTP_Sovereignty[playerID .. "_" .. factionType .. "_CIV_TYPE"] or -1
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetFactionCivType
function Player.SetFactionCivType(player, factionID, civID)
	local playerID = player:GetID()
	local factionType = GameInfo.JFD_Factions[factionID].Type
	JFD_RTP_Sovereignty[playerID .. "_" .. factionType .. "_CIV_TYPE"] = civID
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetFactionHelp
function Player.GetFactionHelp(player, factionID, factionName, factionPower)
	local faction = GameInfo.JFD_Factions[factionID]
	local factionType = faction.Type
	local strFactionHelp = g_ConvertTextKey(faction.Help, factionName, factionPower)	
	return strFactionHelp
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsFactionValid
function Player.IsFactionValid(player, factionID, governmentID, isViewing)	
	local playerTeam = Teams[player:GetTeam()]
	local governmentID = governmentID or player:GetCurrentGovernment()
	local government = GameInfo.JFD_Governments[governmentID]
	local governmentType = government.Type
	
	local isFactionValid = true
	
	--g_JFD_Factions_Table
	local factionsTable = g_JFD_Factions_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local thisFactionID = row.ID
		if thisFactionID == factionID then
			local prereqGovernment = row.PrereqGovernment
			local prereqGovernmentOR = row.PrereqGovernmentOR
			local prereqGovernmentNOT = row.PrereqGovernmentNOT
			local prereqReform = row.PrereqReform
			local prereqReformOR = row.PrereqReformOR
			local prereqReformID = GameInfoTypes[prereqReform]
			local prereqReformORID = GameInfoTypes[prereqReformOR]
			local prereqIdeology = row.PrereqIdeology
			local prereqIdeologyID = GameInfoTypes[prereqIdeology]
			
			if (prereqGovernment and prereqGovernment ~= governmentType) then
				isFactionValid = false
			end
			
			if row.IsValidNotSpecial then
				if government.IsSpecial then
					return false
				end
			end
			
			if row.IsPapalFollower then
				isFactionValid = false
				if (governmentID ~= governmentPapacyID and player:GetReligionCreatedByPlayer() <= 0) then
					local playerPopeID, playerPopeReligionID = Game_GetPapacyFounder()
					if playerPopeID > -1 and playerPopeReligionID > -1 then
						local playerPope = Players[playerPopeID]
						local teamPopeID = playerPope:GetTeam()
						local teamPope = Teams[teamPopeID]
						if (playerTeam:IsHasMet(teamPopeID) and (not playerTeam:IsAtWar(teamPopeID))) then
							local religionID = player:GetMainReligion()
							if religionID == playerPopeReligionID then
								isFactionValid = true
							end
						end
					end	
				end
			end
			
			if (prereqGovernmentOR and prereqGovernmentOR ~= governmentType) then
				isFactionValid = false
			end
			
			if (prereqGovernmentNOT and prereqGovernmentNOT == governmentType) then
				isFactionValid = false
			end
			
			if isViewing then
				if (prereqReform and prereqReform ~= "REFORM_JFD_FACTIONS_INTERESTS") then
					isFactionValid = false
				end
			
				if prereqIdeology and (not prereqIdeologyID) then
					isFactionValid = false
				end
			else
				if (prereqReform and (not player:HasReform(prereqReformID))) then
					if (prereqReformOR and (not player:HasReform(prereqReformORID))) or (not prereqReformOR) then
						isFactionValid = false
					end
				end
			
				local ideologyID = player:GetIdeology()
				if prereqIdeology and ideologyID ~= prereqIdeologyID then
					isFactionValid = false
				elseif prereqIdeology and (not prereqIdeologyID) then
					isFactionValid = false
				end
			end
		end
	end
		
	return isFactionValid
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Faction_Criteria_Table
local g_JFD_Faction_Criteria_Table = {}
local g_JFD_Faction_Criteria_Count = 1
for row in DB.Query("SELECT * FROM JFD_Faction_Criteria;") do 	
	g_JFD_Faction_Criteria_Table[g_JFD_Faction_Criteria_Count] = row
	g_JFD_Faction_Criteria_Count = g_JFD_Faction_Criteria_Count + 1
end

--Player:ComposeNewLegislature
local yieldFaithID = GameInfoTypes["YIELD_FAITH"]
function Player.ComposeNewLegislature(player, governmentID)
	if (not player:IsAlive()) then return end
	local playerID = player:GetID()
	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	local playerTeam = Teams[player:GetTeam()]
	local playerCapital = player:GetCapitalCity()
	local playerIsGoldenAge = player:IsGoldenAge()
	
	-- print("Compose new Legislature", debug.traceback())
	
	local numFactionSovMod = Player_GetFactionSovModifier(player)
	local numCities = player:GetNumCities()
	local numTotalPopulation = player:GetTotalPopulation()
	local numMilitaryUnits = player:GetNumMilitaryUnits()
	local numCapitalPopulation = playerCapital:GetPopulation()
	local numTotal = 0
	local numCityTotal = 0
	
	local newFactionTable = {}
	
	--g_JFD_Factions_Table
	local factionsTable = g_JFD_Factions_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local thisFactionID = row.ID
		player:SetFactionPower(thisFactionID, 0)
		newFactionTable[thisFactionID] = {FactionID = thisFactionID, Power = 0}
	end
	
	--FACTIONS
	local cityCount = 1
	--g_JFD_Factions_Table
	local factionsTable = g_JFD_Factions_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local thisFactionID = row.ID
		
		if player:IsFactionValid(thisFactionID) then
		
			--g_JFD_Faction_Criteria_Table
			local factionsCriteriaTable = g_JFD_Faction_Criteria_Table
			local numFactionsCriteria = #factionsCriteriaTable
			for index = 1, numFactionsCriteria do
				local row2 = factionsCriteriaTable[index]
				local factionType = row2.FactionType
				local factionID = GameInfoTypes[factionType]
				if factionID == thisFactionID then
					
					if row2.IsTotalControlActiveWar then
						if playerTeam:GetAtWarCount(true) > 0 then
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + 1
							numTotal = numTotal + 1
						else
							local numPower = g_GetRandom(1,100)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPower
							numTotal = numTotal + numPower
						end
					end
					
					if row2.IsTotalControlIdeologyType then
						local ideologyID = GameInfoTypes[row2.IsTotalControlIdeologyType]
						if ideologyID == player:GetIdeology() then
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + 100
							newFactionTable[thisFactionID].PowerIsTotal = (newFactionTable[thisFactionID].Power or -1) + 1
							numTotal = numTotal + 1
						else
							local numPower = g_GetRandom(1,100)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPower
							numTotal = numTotal + numPower
						end
					end
					
					if row2.IsTotalControlMajorityReligion then
						local religionID = player:GetMainReligion()
						if player:HasReligionInMostCities(religionID) then
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + 1
							numTotal = numTotal + 1
						else
							local numPower = g_GetRandom(1,100)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPower
							numTotal = numTotal + numPower
						end
					end
					
					if row2.IsNumCities then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numCities = (player:GetNumCities()*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numCities
						numTotal = numTotal + numCities
					end
					
					if row2.IsNumConnectedCities then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numCities = 0
						for city in player:Cities() do
							if player:IsCapitalConnectedToCity(city) then
								numCities = numCities + 1
							end
						end
						numCities = (numCities*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numCities
						numTotal = numTotal + numCities
					end
					
					if row2.IsNumSpecialists then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numSpecialists = (player:GetTotalSpecialistCount()*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numSpecialists
						numTotal = numTotal + numSpecialists
					end
					
					if row2.IsNumReligiousBuildings then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numReligiousBuildings = 0 
						for building in GameInfo.Buildings("FaithCost > 0 AND Cost == -1 AND UnlockedByBelief = 1") do
							numReligiousBuildings = numReligiousBuildings + player:CountNumBuildings(building.ID)
						end
						numReligiousBuildings = (numReligiousBuildings*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numReligiousBuildings
						numTotal = numTotal + numReligiousBuildings
					end
					
					if row2.IsNumStarvingUnemployed then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numStarvingUnemployed = 0
						for city in player:Cities() do
							if city:FoodDifference() < 0 then
								numStarvingUnemployed = numStarvingUnemployed + city:GetPopulation()
							end
							numStarvingUnemployed = numStarvingUnemployed + city:GetSpecialistCount(0)
						end
						numStarvingUnemployed = (numStarvingUnemployed*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numStarvingUnemployed
						numTotal = numTotal + numStarvingUnemployed
					end
					
					if row2.IsNumBuildings then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numBuildings = 0
						for city in player:Cities() do
							numBuildings = numBuildings + city:GetNumBuildings()
						end
						numBuildings = (numBuildings*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numBuildings
						numTotal = numTotal + numBuildings
					end
					
					if row2.IsNumImprovements then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numImprovements = 0
						for row in GameInfo.Improvements() do
							numImprovements = numImprovements + player:GetImprovementCount(row.ID)
						end
						numImprovements = (numImprovements*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numImprovements
						numTotal = numTotal + numImprovements
					end
					
					if row2.IsNumTiles then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numTiles = 1
						for city in player:Cities() do
							for i = 0, city:GetNumCityPlots() - 1, 1 do
								local plot = city:GetCityIndexPlot( i );
								if (plot ~= nil) then	
									if plot:GetOwner() == playerID then
										if (not city:IsWorkingPlot(plot)) then
											numTiles = numTiles + 1
										end
									end
								end
							end
						end
						numTiles = (numTiles*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numTiles
						numTotal = numTotal + numTiles
					end
					
					if row2.IsNumCapitalPopulation then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numCapPopulation = (numCapitalPopulation*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numCapPopulation
						numTotal = numTotal + numCapPopulation
					end
					
					if row2.IsNumCapitalPopulationDoubled then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numCapPopulation = ((numCapitalPopulation*2)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numCapPopulation
						numTotal = numTotal + numCapPopulation
					end
					
					if row2.IsNumOtherCityPopulation then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numOtherPopulation = (((player:GetTotalPopulation()-numCapitalPopulation)+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numOtherPopulation
						numTotal = numTotal + numOtherPopulation
					end
					
					if row2.IsNumPolicyBranchType  then
						local policyBranchType = row2.IsNumPolicyBranchType 
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numPolicyBranchType = ((player:GetNumPoliciesUnlockedInBranch(policyBranchType)+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPolicyBranchType
						numTotal = numTotal + numPolicyBranchType
					end
					
					if row2.IsNumBuildingClass then
						local buildingClassType = row2.IsNumBuildingClass
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local buildingClassID = GameInfoTypes[buildingClassType]
						local numBuilding = ((player:GetBuildingClassCountPlusMaking(buildingClassID)+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numBuilding
						numTotal = numTotal + numBuilding
					end
					
					if row2.IsNumUnitClass then
						local unitClassType = row2.IsNumUnitClass
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local unitClassID = GameInfoTypes[unitClassType]
						local numUnit = ((player:GetUnitClassCount(unitClassID)+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numUnit
						numTotal = numTotal + numUnit
					end
					
					if row2.IsNumUnitCombatType then
						local unitCombatType = row2.IsNumUnitCombatType
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numUnitCombat = ((player:GetNumUnitCombatType(GameInfoTypes[unitCombatType])+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numUnitCombat
						numTotal = numTotal + numUnitCombat
					end
					
					local numImprovementType = row2.IsNumImprovementType
					if numImprovementType then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numImprovements = ((player:GetImprovementCount(GameInfoTypes[numImprovementType])+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numImprovements
						numTotal = numTotal + numImprovements
					end
					
					local numResourceType = row2.IsNumResourceType
					if numResourceType then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numImprovements = ((player:GetNumResourceTotal(GameInfoTypes[numResourceType],false)+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numImprovements
						numTotal = numTotal + numImprovements
					end
					
					if row2.IsNumFaithFromTerrain then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numFaith = 1
						for city in player:Cities() do
							numFaith = numFaith + city:GetBaseYieldRateFromTerrain(yieldFaithID)
						end
						numFaith = (numFaith*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numFaith
						numTotal = numTotal + numFaith
					end
					
					if row2.IsNumPopulationPuppet then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numPuppets = 1
						for city in player:Cities() do
							if city:IsPuppet() then
								numPuppets = numPuppets + city:GetPopulation()
							end
						end
						numPuppets = (numPuppets*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPuppets
						numTotal = numTotal + numPuppets
					end
					
					if row2.IsNumPopulationNonPuppet then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numPuppets = 1
						for city in player:Cities() do
							if (not city:IsPuppet()) then
								numPuppets = numPuppets + city:GetPopulation()
							end
						end
						numPuppets = (numPuppets*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPuppets
						numTotal = numTotal + numPuppets
					end
					
					if row2.IsNumPuppetCities then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numPuppets = 1
						if Player.GetNumPuppetCities then
							numPuppets = player:GetNumPuppetCities()
						else
							for city in player:Cities() do
								if city:IsPuppet() then
									numPuppets = numPuppets + 1
								end
							end
						end
						numPuppets = (numPuppets*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPuppets
						numTotal = numTotal + numPuppets
					end
					
					if row2.IsNumNonPuppetCities then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numPuppets = 1
						if Player.GetNumPuppetCities then
							numPuppets = player:GetNumPuppetCities()
						else
							for city in player:Cities() do
								if city:IsPuppet() then
									numPuppets = numPuppets + 1
								end
							end
						end
						local numNonPuppets = (player:GetNumCities()-numPuppets)
						numNonPuppets = (numNonPuppets*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numNonPuppets
						numTotal = numTotal + numNonPuppets
					end
					
					if row2.IsNumConqueredCities then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numConquered = 1
						for city in player:Cities() do
							if city:GetOriginalOwner() ~= playerID then
								numConquered = numConquered + 1
							end
						end
						numConquered = (numConquered*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numConquered
						numTotal = numTotal + numConquered
					end
					
					if row2.IsNumSettledCities then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numSettled = 1
						for city in player:Cities() do
							if city:GetOriginalOwner() == playerID then
								numSettled = numSettled + 1
							end
						end
						numSettled = (numSettled*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numSettled
						numTotal = numTotal + numSettled
					end
					
					if row2.IsNumCitiesGarrisoned then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numGarrisoned = 1
						for city in player:Cities() do
							if city:GetGarrisonedUnit() then
								numGarrisoned = numGarrisoned + 1
							end
						end
						numGarrisoned = (numGarrisoned*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numGarrisoned
						numTotal = numTotal + numGarrisoned
					end
					
					if row2.IsNumCitiesNotGarrisoned then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numNotGarrisoned = 1
						for city in player:Cities() do
							if (not city:GetGarrisonedUnit()) then
								numNotGarrisoned = numNotGarrisoned + 1
							end
						end
						numNotGarrisoned = (numNotGarrisoned*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numNotGarrisoned
						numTotal = numTotal + numNotGarrisoned
					end
					
					if row2.IsNumCapitalStrength then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numCapitalStrength = ((g_MathFloor(playerCapital:GetStrengthValue()/100))*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numCapitalStrength
						numTotal = numTotal + numCapitalStrength
					end
					
					if row2.IsNumOtherCityStrength then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numOtherCityStrength = 1
						for city in player:Cities() do
							if (not city:IsCapital()) then
								numOtherCityStrength = numOtherCityStrength + g_MathFloor(city:GetStrengthValue()/100)
							end
						end
						numOtherCityStrength = (numOtherCityStrength*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numOtherCityStrength
						numTotal = numTotal + numOtherCityStrength
					end
					
					if row2.IsNumPapalFaith then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numPapalFaith = ((player:GetTotalFaithPerTurn()+1)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPapalFaith
						numTotal = numTotal + numPapalFaith
					end
					
					if row2.IsNumPapalHighestFollowerFaith then
						local playerPopeID, playerPopeReligionID = Game_GetPapacyFounder()
						local playerFollowerID = -1
						local playerNumYield = 0
						local playerYieldType = row2.IsNumPapalHighestFollowerFaith
						for otherPlayerID = 0, defineMaxMajorCivs - 1 do
							local otherPlayer = Players[otherPlayerID]
							if otherPlayer:IsAlive() and playerTeam:IsHasMet(otherPlayer:GetTeam()) then
								local religionID = otherPlayer:GetMainReligion()
								if religionID == playerPopeReligionID then
									local highestYieldID = GameInfoTypes[playerYieldType]
									local thisPlayerNumYield = otherPlayer:CalculateTotalYield(highestYieldID)
									if thisPlayerNumYield > playerNumYield then
										playerFollowerID = otherPlayerID
										playerNumYield = thisPlayerNumYield
									end
								end
							end
						end
						if playerFollowerID > -1 then
							local numRandomWeight = row2.RandomWeight
							local numRandomResult = g_GetRandom(1,numRandomWeight)
							local playerFollower = Players[playerFollowerID]
							local numFaith = (playerFollower:GetTotalFaithPerTurn()*numRandomResult)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numFaith
							newFactionTable[thisFactionID].PlayerID = playerFollowerID
							numTotal = numTotal + numFaith
						end
					end
					
					if row2.IsOtherFactionPower then
						local otherFactionType = row2.IsOtherFactionPower
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local playerPopeID = Game_GetPapacyFounder()
						local otherFactionID = GameInfoTypes[otherFactionType]
						local numFactionPower = (Players[playerPopeID]:GetFactionPower(otherFactionID)*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numFactionPower
						numTotal = numTotal + numFactionPower
					end
					
					if row2.IsNumCivilianUnits then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numCivilianUnits = 1
						for unit in player:Units() do
							if ((not unit:IsCombatUnit()) and (not unit:IsTrade()) and unit:GetReligion() <= 0) then
								numCivilianUnits = numCivilianUnits + 1
							end
						end
						numCivilianUnits = (numCivilianUnits*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numCivilianUnits
						numTotal = numTotal + numCivilianUnits
					end
					
					if row2.IsNumReligiousUnits then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numReligiousUnits = 1
						for unit in player:Units() do
							if unit:GetReligion() > 0 then
								numReligiousUnits = numReligiousUnits + 1
							end
						end
						numReligiousUnits = (numReligiousUnits*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numReligiousUnits
						numTotal = numTotal + numReligiousUnits
					end
					
					if row2.IsNumTradeUnits then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numTradeUnits = 1
						for unit in player:Units() do
							if unit:IsTrade() then
								numTradeUnits = numTradeUnits + 1
							end
						end
						numTradeUnits = (numTradeUnits*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numTradeUnits
						numTotal = numTotal + numTradeUnits
					end
					
					if row2.IsNumNonCityStateTradeRoute then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numTradeRoutes = 1
						for _,tradeRoute in ipairs(player:GetTradeRoutes()) do
							local toPlayer = Players[tradeRoute.ToID]
							if (not toPlayer:IsMinorCiv()) then
								numTradeRoutes = numTradeRoutes + 1
							end
						end
						numTradeRoutes = (numTradeRoutes*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numTradeRoutes
						numTotal = numTotal + numTradeRoutes
					end
					
					if row2.IsNumCityStateTradeRoute then
						local minorCivTraitType = row2.IsNumCityStateTradeRoute
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numTradeRoutes = 1
						for _,tradeRoute in ipairs(player:GetTradeRoutes()) do
							local toPlayer = Players[tradeRoute.ToID]
							if toPlayer:IsMinorCiv() then
								local minorTraitID = toPlayer:GetMinorCivTrait()
								local minorTraitType = GameInfo.MinorCivTraits[minorTraitID].Type
								if minorTraitType == minorCivTraitType then
									numTradeRoutes = numTradeRoutes + 1
								end
							end
						end
						numTradeRoutes = (numTradeRoutes*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numTradeRoutes
						numTotal = numTotal + numTradeRoutes
					end
					
					if row2.IsNumLargestAllyPopulation then
						local minorCivTraitType = row2.IsNumLargestAllyPopulation
						local largestMinors = {}
						for otherPlayerID = 0, defineMaxCivPlayers - 1 do	
							local otherPlayer = Players[otherPlayerID]
							if otherPlayer:IsAlive() and otherPlayer:IsMinorCiv() and playerTeam:IsHasMet(otherPlayer:GetTeam()) and otherPlayer:IsAllies(playerID) and otherPlayer:GetCapitalCity() then
								local minorTraitID = otherPlayer:GetMinorCivTrait()
								local minorTraitType = GameInfo.MinorCivTraits[minorTraitID].Type
								largestMinors[minorTraitID] = {MinorID = -1, NumPop = 0}
								if minorCivTraitType == minorTraitType then
									local numPop = otherPlayer:GetTotalPopulation()
									if numPop > largestMinors[minorTraitID].NumPop then
										largestMinors[minorTraitID].MinorID = otherPlayerID
										largestMinors[minorTraitID].NumPop = numPop
									end
								end
							end
						end	
						for _, thisMinor in pairs(largestMinors) do
							if thisMinor.MinorID ~= -1 then
								local numRandomWeight = row2.RandomWeight
								local numRandomResult = g_GetRandom(1,numRandomWeight)
								local numPopulation = (thisMinor.NumPop*numRandomResult)
								newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPopulation
								newFactionTable[thisFactionID].PlayerID = thisMinor.MinorID
								numTotal = numTotal + numPopulation
							end
						end
					end
					
					if row2.IsNumReligiousFollowers then
						local religionID = player:GetMainReligion()
						local numFollowers, numNotFollowers, numNoneFollowers = player:GetNumTotalFollowers(religionID)
					
						if row2.IsNumOwnReligiousFollowers then
							local numRandomWeight = row2.RandomWeight
							local numRandomResult = g_GetRandom(1,numRandomWeight)
							numFollowers = ((numFollowers+1)*numRandomResult)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numFollowers
							numTotal = numTotal + numFollowers
						end
					
						if row2.IsNumOtherReligiousFollowers then
							local numRandomWeight = row2.RandomWeight
							local numRandomResult = g_GetRandom(1,numRandomWeight)
							numNotFollowers = ((numNotFollowers+1)*numRandomResult)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numNotFollowers
							numTotal = numTotal + numNotFollowers
						end
						
						if row2.IsNumNonReligiousFollowers then
							local numRandomWeight = row2.RandomWeight
							local numRandomResult = g_GetRandom(1,numRandomWeight)
							numNoneFollowers = ((numNoneFollowers+1)*numRandomResult)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numNoneFollowers
							numTotal = numTotal + numNoneFollowers
						end
					end
					
					if row2.IsGoldenAge then
						if playerIsGoldenAge then
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + 1
							numTotal = numTotal + 1
						else
							local numPower = g_GetRandom(1,100)
							newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numPower
							numTotal = numTotal + numPower
						end
					end
					
					if row2.IsNotGoldenAgeTotalUnhappiness and (not playerIsGoldenAge) then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numUnhappiness = (player:GetUnhappiness()*numRandomResult)
						newFactionTable[thisFactionID].Power = numUnhappiness
						numTotal = numTotal + numUnhappiness
					end
					
					if row2.IsNotGoldenAgeTotalHappiness and (not playerIsGoldenAge) then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numHappiness = (player:GetHappiness()*numRandomResult)
						newFactionTable[thisFactionID].Power = numHappiness
						numTotal = numTotal + numHappiness
					end
					
					if row2.IsNumYieldType then
						local yieldType = row2.IsNumYieldType
						local yieldID = GameInfoTypes[yieldType]
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numYield = 1
						if yieldType == "YIELD_FOOD_SURPLUS" then
							for city in player:Cities() do
								local numFoodDiff = city:FoodDifference()
								if numFoodDiff > 0 then
									numYield = numYield + numFoodDiff
								end
							end
						elseif yieldType == "YIELD_FOOD_DEFICIT" then
							for city in player:Cities() do
								local numFoodDiff = city:FoodDifference()
								if numFoodDiff < 0 then
									numYield = numYield + (numFoodDiff*-1)
								end
							end
						elseif yieldType == "YIELD_FOOD_CON" then
							for city in player:Cities() do
								numYield = numYield + city:FoodConsumption()
							end
						elseif yieldType == "YIELD_PRODUCTION" then
							for city in player:Cities() do
								numYield = numYield + city:GetCurrentProductionDifference()
							end
						elseif yieldType == "YIELD_GOLD_DEFICIT" then
							local numGold = player:CalculateGoldRate()
							if numGold < 0 then
								numYield = numYield + (numGold*-1)
							end
						elseif yieldType == "YIELD_GOLD_SURPLUS" then
							local numGold = player:CalculateGoldRate()
							if numGold > 0 then
								numYield = numYield + numGold
							end
						elseif yieldType == "YIELD_SCIENCE" then
							numYield = numYield + g_GetRound(player:GetScience()/2)
						elseif yieldType == "YIELD_FAITH" then
							numYield = numYield + player:GetTotalFaithPerTurn()
						elseif yieldType == "YIELD_CULTURE" then
							numYield = numYield + player:GetTotalJONSCulturePerTurn()
						elseif yieldType == "YIELD_TOURISM" then
							numYield = numYield + player:GetTourism()
						elseif yieldType == "YIELD_HAPPINESS" then
							numYield = numYield + player:GetHappiness()
						elseif yieldType == "YIELD_UNHAPPINESS" then
							numYield = numYield + player:GetUnhappiness()
						else
							numYield = player:CalculateTotalYield(yieldID)
						end
						numYield = (numYield*numRandomResult)
						newFactionTable[thisFactionID].Power = (newFactionTable[thisFactionID].Power or -1) + numYield
						numTotal = numTotal + numYield
					end
					
					if row2.IsNumHappiness then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numHappiness = (player:GetHappiness()*numRandomResult)
						newFactionTable[thisFactionID].Power = numHappiness
						numTotal = numTotal + numHappiness
					end
					
					if row2.IsNumUnhappiness then
						local numRandomWeight = row2.RandomWeight
						local numRandomResult = g_GetRandom(1,numRandomWeight)
						local numUnhappiness = (player:GetUnhappiness()*numRandomResult)
						newFactionTable[thisFactionID].Power = numUnhappiness
						numTotal = numTotal + numUnhappiness
					end
				end
			end
		end
	end
	
	table.sort(newFactionTable, function(a,b) return a.Power > b.Power end)
	
	local numDominantFactions = 0
	for _, thisFaction in pairs(newFactionTable) do
		local factionID = thisFaction.FactionID
		local faction = GameInfo.JFD_Factions[factionID]
		local factionType = faction.Type
		local factionPower = thisFaction.Power
		local factionPowerDivided = faction.PowerDividedByX
		local factionPowerIsTotal = thisFaction.PowerIsTotal
		local factionPlayerID = thisFaction.PlayerID
		
		if (factionPower > 0 or thisFaction.PlayerID) then
			if (not factionPowerIsTotal) then
				if numDominantFactions == 0 then
					if numFactionSovMod ~= 0 then
						local factionPowerBonus = g_GetRound((factionPower*numFactionSovMod)/100)
						factionPower = factionPower + factionPowerBonus
						numTotal = numTotal+factionPowerBonus
					end
					numDominantFactions = 1
				end
			end
			if factionPowerDivided > 0 then
				factionPower = g_GetRound(factionPower/factionPowerDivided)
			end	
			local numPercent = factionPower
			if (not factionPowerIsTotal) then
				numPercent = g_GetRound((factionPower/numTotal)*100)	
			end
			player:SetFactionPower(factionID, numPercent)
			local strFactionName = player:GetIntendedFactionName(factionID, governmentID, factionPlayerID)
			player:SetFactionName(factionID, strFactionName)
			if factionPlayerID then
				player:SetFactionCivType(factionID, factionPlayerID)
			end
		end
	end
	
	--DOMINANT FACTION
	local factionDominantID = player:GetDominantFaction()
	if factionDominantID > -1 then
		local factionDominant = GameInfo.JFD_Factions[factionDominantID]
		local factionName = player:GetFactionName(factionDominantID)
		local factionDesc = factionDominant.ShortDescription
		if playerIsHuman then
			LuaEvents.UI_ShowNewLegislaturePopup(playerID, governmentID)
			player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_LEGISLATURE", g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_NEW_LEGISLATURE_TEXT", factionDominant.ShortDescription), g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_NEW_LEGISLATURE_SHORT_TEXT", factionDesc), false, -1, -1)
		end
	end
	
	LuaEvents.JFD_LegislatureComposed(playerID, governmentID)
end
----------------------------------------------------------------------------------------------------------------------------
--Game_GetPapacyFounder
function Game_GetPapacyFounder()
	for playerID = 0, defineMaxMajorCivs - 1 do
		local player = Players[playerID]
		if player:IsAlive() then
			if player:GetCurrentGovernment() == governmentPapacyID then
				return playerID, player:GetReligionCreatedByPlayer()
			end
		end
	end
	return -1, -1
end
----------------------------------------------------------------------------------------------------------------------------
-- FACTION MODIFIER UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player_GetFactionSovModifier
function Player_GetFactionSovModifier(player, returnsTT)
	local numFactionSovMod = 0
	local strFactionSovMod = ""

	local governmentID = player:GetCurrentGovernment()
	local numFactionSovModGovernment = GameInfo.JFD_Governments[governmentID].FactionSovMod
	if numFactionSovModGovernment ~= 0 then
		numFactionSovMod = numFactionSovMod + numFactionSovModGovernment
		if returnsTT then
			if numFactionSovModGovernment > 0 then 
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_GOVERNMENT", numFactionSovModGovernment, "+")
			else
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_GOVERNMENT", numFactionSovModGovernment, "")
			end
		end
	end
			
	local numFactionSovModReforms = 0
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisFactionSovMod = row.FactionSovMod
		if numThisFactionSovMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numFactionSovModReforms = numFactionSovModReforms + numThisFactionSovMod
			end
		end
	end
	if numFactionSovModReforms ~= 0 then
		numFactionSovMod = numFactionSovMod + numFactionSovModReforms				
		if returnsTT then
			if numFactionSovModReforms > 0 then 
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_REFORMS", numFactionSovModReforms, "+")
			else
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_REFORMS", numFactionSovModReforms, "")
			end
		end
	end
	
	local numFactionSovModBuildings = 0
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisFactionSovMod = row.FactionSovMod
		if numThisFactionSovMod ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numFactionSovModBuildings = numFactionSovModBuildings + (numThisFactionSovMod*buildingCount)
			end
		end
	end
	if numFactionSovModBuildings ~= 0 then
		numFactionSovMod = numFactionSovMod + numFactionSovModBuildings				
		if returnsTT then
			if numFactionSovModBuildings > 0 then 
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_BUILDINGS", numFactionSovModBuildings, "+")
			else
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_BUILDINGS", numFactionSovModBuildings, "")
			end
		end
	end
				
	local numFactionSovModPolicies = 0
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisFactionSovMod = row.FactionSovMod
		if numThisFactionSovMod ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numFactionSovModPolicies = numFactionSovModPolicies + numThisFactionSovMod
			end
		end
	end
	if numFactionSovModPolicies ~= 0 then
		numFactionSovMod = numFactionSovMod + numFactionSovModPolicies				
		if returnsTT then
			if numFactionSovModPolicies > 0 then 
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_POLICIES", numFactionSovModPolicies, "+")
			else
				strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_POLICIES", numFactionSovModPolicies, "")
			end
		end
	end
				
	if Player.HasTrait then
		local numFactionSovModTraits = 0
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisFactionSovMod = row.FactionSovMod
			if numThisFactionSovMod ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numFactionSovModTraits = numFactionSovModTraits + numThisFactionSovMod
				end
			end
		end
		if numFactionSovModTraits ~= 0 then
			numFactionSovMod = numFactionSovMod + numFactionSovModTraits				
			if returnsTT then
				if numFactionSovModTraits > 0 then 
					strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_TRAITS", numFactionSovModTraits, "+")
				else
					strFactionSovMod = strFactionSovMod .. g_ConvertTextKey("TXT_KEY_JFD_FACTION_SOV_MODIFIER_FROM_TRAITS", numFactionSovModTraits, "")
				end
			end
		end
	end
	
	return numFactionSovMod, strFactionSovMod
end
----------------------------------------------------------------------------------------------------------------------------
-- LEGISLATURE UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:ResetLegislature
function Player.ResetLegislature(player, governmentID, isInit)
	if player:IsHuman() and player:IsTurnActive() then
		if (not isInit) then
			player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_LEGISLATURE", g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_GOVERNMENT_COOLDOWN_ENDS_TEXT"), g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_GOVERNMENT_COOLDOWN_ENDS_SHORT_TEXT"), false, -1, -1)
		end
		Events.AudioPlay2DSound("AS2D_SOUND_JFD_LEGISLATURE_RESET");
	end
	player:ComposeNewLegislature(governmentID)
	local numGovernmentCooldown = player:CalculateGovernmentCooldown()
	if numGovernmentCooldown > 0 then
		player:SetCurrentGovernmentCooldown(numGovernmentCooldown) 
		if Player.SetGovernmentCooldownRate then
			player:SetGovernmentCooldownRate(1) 
		end
	else
		if Player.SetGovernmentCooldownRate then
			player:SetGovernmentCooldownRate(0) 
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetCurrentGovernmentCooldown
function Player.GetCurrentGovernmentCooldown(player)
	if Player.GetGovernmentCooldown then
		return player:GetGovernmentCooldown()
	else
		local playerID = player:GetID()
		return JFD_RTP_Sovereignty[playerID .. "_GOVERNMENT_COOLDOWN_TURNS"] or 0
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeCurrentGovernmentCooldown
function Player.ChangeCurrentGovernmentCooldown(player, changeVal)
	if Player.ChangeGovernmentCooldown then
		player:ChangeGovernmentCooldown(changeVal)
	else
		local currentVal = player:GetCurrentGovernmentCooldown()
		local newVal = g_GetRound(currentVal+changeVal)
		player:SetCurrentGovernmentCooldown(newVal)
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetCurrentGovernmentCooldown
function Player.SetCurrentGovernmentCooldown(player, setVal)
	if setVal <= 0 then setVal = 0 end
	if Player.SetGovernmentCooldown then
		player:SetGovernmentCooldown(setVal)
	else
		local playerID = player:GetID()
		JFD_RTP_Sovereignty[playerID .. "_GOVERNMENT_COOLDOWN_TURNS"] = setVal
		LuaEvents.JFD_GovernmentCooldownChanges(player:GetID(), setVal)
	end	
end
----------------------------------------------------------------------------------------------------------------------------
--Player:CalculateGovernmentCooldown
function Player.CalculateGovernmentCooldown(player, returnsTT)
	
	local governmentID = player:GetCurrentGovernment() 
	if GameInfo.JFD_Governments[governmentID].IsLegislatureOnlyEraReset then
		return -1, -1, g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_GOVERNMENT_COOLDOWN_TT_SHOGUNATE")
	end

	local numCurrentGovernmentCooldown = player:GetCurrentGovernmentCooldown()
	local numGovernmentCooldown = defineDefaultGovernmentCooldownTurns
	local strGovernmentCooldownTT
	local strGovernmentCooldownModTT
	local numGovernmentCooldownMod, strNumGovernmentCooldownModTT = Player_GetGovernmentCooldownModifier(player, returnsTT)
	
	local currentGovernmentID = player:GetCurrentGovernment()
	local numGovtGovernmentCooldownMod = GameInfo.JFD_Governments[currentGovernmentID].GovernmentCooldownCityMod
	if numGovtGovernmentCooldownMod ~= 0 then
		numGovernmentCooldownModPerCityMod = numGovernmentCooldownModPerCityMod + numGovtGovernmentCooldownMod
	end
		
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisGovernmentCooldownMod = row.GovernmentCooldownCityMod
		if numThisGovernmentCooldownMod ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numThisGovernmentCooldownMod = (numThisGovernmentCooldownMod*buildingCount)
				numGovernmentCooldownModPerCityMod = numGovernmentCooldownModPerCityMod + numThisGovernmentCooldownMod
			end
		end
	end
	if numGovernmentCooldownMod ~= 0 then
		numGovernmentCooldown = numGovernmentCooldown + ((numGovernmentCooldown*numGovernmentCooldownMod)/100)
	end
	numGovernmentCooldown = g_GetRound(numGovernmentCooldown)
	
	if returnsTT then
		strGovernmentCooldownTT = g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_GOVERNMENT_COOLDOWN_TT", numCurrentGovernmentCooldown, numGovernmentCooldown)
		if strNumGovernmentCooldownModTT then
			strGovernmentCooldownTT = strGovernmentCooldownTT .. strNumGovernmentCooldownModTT
		end
	end
	
	if numGovernmentCooldown < defineDefaultGovernmentCooldownCap then 
		numGovernmentCooldown = defineDefaultGovernmentCooldownCap 
	end

	return numGovernmentCooldown, numCurrentGovernmentCooldown, strGovernmentCooldownTT
end
----------------------------------------------------------------------------------------------------------------------------
-- LEGISLATURE MODIFIER UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player_GetGovernmentCooldownModifier
function Player_GetGovernmentCooldownModifier(player, returnsTT)
	local numGovernmentCooldownMod = 0
	local strNumGovernmentCooldownModTT = ""	

	local governmentID = player:GetCurrentGovernment()
	local numGovernmentCooldownGovernment = GameInfo.JFD_Governments[governmentID].GovernmentCooldownMod
	if numGovernmentCooldownGovernment ~= 0 then
		numGovernmentCooldownMod = numGovernmentCooldownMod + numGovernmentCooldownGovernment
		if returnsTT then
			if numGovernmentCooldownGovernment > 0 then
				strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_GOVERNMENT", "+" .. numGovernmentCooldownGovernment .. "%")
			else
				strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_GOVERNMENT", numGovernmentCooldownGovernment .. "%")
			end
		end
	end
			
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisGovernmentCooldownMod = row.GovernmentCooldownMod
		if numThisGovernmentCooldownMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numGovernmentCooldownMod = numGovernmentCooldownMod + numThisGovernmentCooldownMod
				if returnsTT then
					if numThisGovernmentCooldownMod > 0 then
						strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_REFORMS", "+" .. numThisGovernmentCooldownMod .. "%")
					else
						strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_REFORMS", numThisGovernmentCooldownMod .. "%")
					end
				end
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisGovernmentCooldownMod = row.GovernmentCooldownMod
		if numThisGovernmentCooldownMod ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numThisGovernmentCooldownMod = (numThisGovernmentCooldownMod*buildingCount)
				numGovernmentCooldownMod = numGovernmentCooldownMod + numThisGovernmentCooldownMod
				if returnsTT then
					if numThisGovernmentCooldownMod > 0 then
						strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_BUILDINGS", "+" .. numThisGovernmentCooldownMod .. "%")
					else
						strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_BUILDINGS", numThisGovernmentCooldownMod .. "%")
					end
				end
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisGovernmentCooldownMod = row.GovernmentCooldownMod
		if numThisGovernmentCooldownMod ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numGovernmentCooldownMod = numGovernmentCooldownMod + numThisGovernmentCooldownMod
				if returnsTT then
					if numThisGovernmentCooldownMod > 0 then
						strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_POLICIES", "+" .. numThisGovernmentCooldownMod .. "%")
					else
						strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_POLICIES", numThisGovernmentCooldownMod .. "%")
					end
				end
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisGovernmentCooldownMod = row.GovernmentCooldownMod
			if numThisGovernmentCooldownMod ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numGovernmentCooldownMod = numGovernmentCooldownMod + numThisGovernmentCooldownMod
					if returnsTT then
						if numThisGovernmentCooldownMod > 0 then
							strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_TRAITS", "+" .. numThisGovernmentCooldownMod .. "%")
						else
							strNumGovernmentCooldownModTT = strNumGovernmentCooldownModTT .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_COOLDOWN_TT_FROM_TRAITS", numThisGovernmentCooldownMod .. "%")
						end
					end
				end
			end
		end
	end

	return numGovernmentCooldownMod, strNumGovernmentCooldownModTT
end
--==========================================================================================================================
-- REFORM UTILS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- REFORM UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:HasReform
function Player.HasReform(player, reformID)
	if (not reformID) then print("reformID is nil!", debug.traceback()) return end
	if reformID ~= -1 then
		local reform = GameInfo.JFD_Reforms[reformID]
		local policyID = GameInfoTypes[reform.PolicyType]
		return player:HasPolicy(policyID)
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetNumReforms
function Player.GetNumReforms(player, isAligned, isForCapacity)
	local numPassedReforms = 0
	
	local reformsTable = g_JFD_Reforms_Table
	if isAligned then
		--g_JFD_Reforms_Table
		reformsTable = g_JFD_ReformsLeftRight_Table
	end
	
	local governmentID = player:GetCurrentGovernment()
	local isReligiousReformNoCapacity = GameInfo.JFD_Governments[governmentID].ReligiousReformIsNoCapacity
	
	--g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = row.ID
		if player:HasReform(reformID) then
			numPassedReforms = numPassedReforms + 1
			if isForCapacity and isReligiousReformNoCapacity then
				if row.ReformBranchType == "REFORM_BRANCH_JFD_RELIGION" then
					numPassedReforms = numPassedReforms - 1
				end
			end
		end
	end
	
	if isForCapacity then
		
	end

	return numPassedReforms
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Reform_Negates_Table
local g_JFD_Reform_Negates_Table = {}
local g_JFD_Reform_Negates_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reform_Negates;") do 	
	g_JFD_Reform_Negates_Table[g_JFD_Reform_Negates_Count] = row
	g_JFD_Reform_Negates_Count = g_JFD_Reform_Negates_Count + 1
end

--Player:SetHasReform
function Player.SetHasReform(player, reformID, isReformFree, setHasReform, isInit)
	local playerID = player:GetID()
	local playerIsHuman = (player:IsHuman() and player:IsTurnActive())
	local isTriggersAnarchy = false
	
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local reformSubBranchType = reform.ReformSubBranchType
	local policyID = GameInfoTypes[reform.PolicyType]
	if setHasReform and (not player:HasReform(reformID)) then
		
		--REVOLUTIONARIES
		local numRevolutionarySentiment = g_MathFloor(player:GetTotalRevolutionarySentiment())
		if numRevolutionarySentiment > 0 then
			if player:IsReformOpposed(reformID) then
				if (not player:IsHuman()) then
					if numRevolutionarySentiment > 60 then
						local numRandomChance = g_GetRandom(1,100)
						if numRandomChance <= g_MathMax((numRevolutionarySentiment-60),0) then
							player:DoStartRevolution()
							return
						end
					end
				else
					local numRandomChance = g_GetRandom(1,100)
					if numRandomChance <= numRevolutionarySentiment then
						player:DoStartRevolution()
						return
					end
				end
			end
		end
	
		if (not isInit) then
			
			--REFORM COOLDOWN
			if playerIsHuman then
				local numReformCooldown = player:CalculateReformCooldown(reformSubBranchType)
				if numReformCooldown ~= 0 then
					player:SetCurrentReformCooldown(reformSubBranchType, numReformCooldown)
				end
			end
	
			LuaEvents.JFD_ReformPassed(playerID, reformID, isReformFree)
	
			if playerIsHuman then
				local reformBranch = GameInfo.JFD_ReformBranches[reform.ReformBranchType]
				local reformBranchDesc = reformBranch.ShortDescription
				local reformHeaderDesc = reform.ReformSubBranchDescription
				local reformDesc = reform.ShortDescription
				local reformPedia = reform.Pedia
				local reformHelpBonus = reform.HelpBonus
				local reformHelpPenalty = reform.HelpPenalty
				player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_REFORM", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REFORM_PASSED_TEXT", reformBranchDesc, reformDesc, reformHeaderDesc, reformPedia, reformHelpBonus, reformHelpPenalty), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REFORM_PASSED_SHORT_TEXT", reformBranchDesc), false, -1, -1)
			end
		end
	
		if Player.GrantPolicy then
			player:GrantPolicy(policyID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyID, true)
		end
		
		--UPDATE REFORM CAPCACITY
		player:UpdateCurrentSovereignty(nil, true)
	
		--g_JFD_Reform_Negates_Table
		local reformsTable = g_JFD_Reform_Negates_Table
		local numReforms = #reformsTable
		for index = 1, numReforms do
			local row = reformsTable[index]
			if row.ReformType == reformType then
				local reformNegateType = row.ReformNegateType
				local reformNegateID = GameInfoTypes[reformNegateType]
				local policyID = GameInfoTypes["POLICY_" .. reformNegateType]
				if Player.RevokePolicy then
					player:RevokePolicy(policyID)
				else
					player:SetHasPolicy(policyID, false)
				end
				LuaEvents.JFD_ReformRevoked(playerID, reformNegateID)
			end
		end
	elseif (not setHasReform) then
		if Player.RevokePolicy then
			player:RevokePolicy(policyID)
		else
			player:SetHasPolicy(policyID, false)
		end
		LuaEvents.JFD_ReformRevoked(playerID, reformID)
	end

	--LEGISLATURE
	if (not isInit) then
		if reform.ResetsLegislature then
			local governmentID = player:GetCurrentGovernment()
			player:ResetLegislature(governmentID)
		end
	end
	
	--TITLE
	if (not isInit) then
		--g_JFD_Government_LeaderTitles_ReformType_Table
		if g_JFD_Government_LeaderTitles_ReformType_Table[reformID] then
			player:UpdateLeaderName(governmentID)
		end
		--g_JFD_Government_StateTitles_ReformType_Table
		if g_JFD_Government_StateTitles_ReformType_Table[reformID] then
			player:UpdateCivilizationStateDescription(governmentID)
		end
	end

	if playerIsHuman then
		LuaEvents.JFD_UpdateTopPanel()
		if (not isTriggersAnarchy) and (not isInit) then
			Events.AudioPlay2DSound("AS2D_SOUND_JFD_REFORM_PASSED")
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetHasAllDefaultReforms
function Player.SetHasAllDefaultReforms(player, governmentID, isInit)
	if governmentID == governmentTribeID then 
		return 
	end
	local government = GameInfo.JFD_Governments[governmentID]
	local governmentType = government.Type

	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = row.ID
		if row.DefaultActive then
			player:SetHasReform(reformID, false, true, isInit)
			if (not g_IsVMCActive) and isInit then
				player:ChangeScoreFromScenario4(-4)
			end
		end
	end
	
	player:UpdateLeaderName(governmentID)
	player:UpdateCivilizationStateDescription(governmentID)
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Reforms_ReformCostModPerCity_Table
local g_JFD_Reforms_ReformCostModPerCity_Table = {}
local g_JFD_Reforms_ReformCostModPerCity_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reforms WHERE ReformCostModPerCity <> 0;") do 	
	g_JFD_Reforms_ReformCostModPerCity_Table[g_JFD_Reforms_ReformCostModPerCity_Count] = row
	g_JFD_Reforms_ReformCostModPerCity_Count = g_JFD_Reforms_ReformCostModPerCity_Count + 1
end

--g_JFD_Reforms_ReformCostModPerPop_Table
local g_JFD_Reforms_ReformCostModPerPop_Table = {}
local g_JFD_Reforms_ReformCostModPerPop_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reforms WHERE ReformCostModPerPop <> 0;") do 	
	g_JFD_Reforms_ReformCostModPerPop_Table[g_JFD_Reforms_ReformCostModPerPop_Count] = row
	g_JFD_Reforms_ReformCostModPerPop_Count = g_JFD_Reforms_ReformCostModPerPop_Count + 1
end

--Player:GetReformCost
function Player.GetReformCost(player, reformID)
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformBranchType = reform.ReformBranchType
	local numReformCost = reform.Cost
	if (not player:IsHuman()) then
		numReformCost = 0
	end
	
	local numReformCostMod = Player_GetReformCostModifier(player, reformID)
	if numReformCostMod ~= 0 then
		numReformCost = numReformCost + ((numReformCost*numReformCostMod)/100)
	end
	
	--REFORMS
	--g_JFD_Reforms_ReformCostModPerCity_Table
	local reformsTable = g_JFD_Reforms_ReformCostModPerCity_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = row.ID
		if player:HasReform(reformID) then
			local numCities = player:GetNumCities()
			local numReformCostModPerCity = 0
			local numReformCostModPerCityReformCategoryType = row.ReformCostModPerCityReformCategoryType
			if numReformCostModPerCityReformCategoryType then	
				if reformBranchType == numReformCostModPerCityReformCategoryType then 
					numReformCostModPerCity = row.ReformCostModPerCity
				end
			end
			
			local numReformCostMod = g_MathMin(numReformCostModPerCity*numCities, 30)
			numReformCostMod = g_MathMax(numReformCostMod, -30)
			numReformCost = numReformCost + ((numReformCost*numReformCostMod)/100)
		end
	end
		
	--g_JFD_Reforms_ReformCostModPerPop_Table
	local reformsTable = g_JFD_Reforms_ReformCostModPerPop_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = row.ID
		if player:HasReform(reformID) then
			local numPopulation = player:GetTotalPopulation()
			local numReformCostModPerPop = 0
			local numReformCostModPerCityReformCategoryType = row.ReformCostModPerPopReformCategoryType
			if numReformCostModPerCityReformCategoryType then	
				if reformBranchType == numReformCostModPerCityReformCategoryType then 
					numReformCostModPerPop = row.ReformCostModPerPop
				end
			end
			
			local numReformCostMod = g_MathMin(numReformCostModPerPop*numPopulation, 30)
			numReformCostMod = g_MathMax(numReformCostMod, -30)
			numReformCost = numReformCost + ((numReformCost*numReformCostMod)/100)
		end
	end
	
	--LEGISLATURE
	numReformCost = numReformCost + player:GetReformOpinionOpposed(reformID)
	numReformCost = numReformCost - player:GetReformOpinionFavoured(reformID)
	
	if numReformCost < 0 then 
		numReformCost = 0 
	end
	
	return g_GetRound(numReformCost)
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsReformFavoured
function Player.IsReformFavoured(player, reformID)
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local reformAlignment = reform.Alignment
	local reformBranchType = reform.ReformBranchType
	
	--g_JFD_Faction_FavouredReforms_Table
	local factionsTable = g_JFD_Faction_FavouredReforms_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local factionID = GameInfoTypes[row.FactionType]
		local factionPower = player:GetFactionPower(factionID)
		if factionPower > 0 then
				
			local thisReformBranchType = row.ReformBranchType
			local thisReformType = row.ReformType
			if (thisReformBranchType and thisReformBranchType == reformBranchType) and ((reformAlignment == row.ReformAlignment) or (not row.ReformAlignment)) then
				return true
			elseif (thisReformType and reformType == thisReformType) then
				return true
			end
		end
	end
	
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetReformOpinionFavoured
function Player.GetReformOpinionFavoured(player, reformID)
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local reformAlignment = reform.Alignment
	local reformBranchType = reform.ReformBranchType
	local numReformOpinionFavoured = 0
	
	--g_JFD_Faction_FavouredReforms_Table
	local factionsTable = g_JFD_Faction_FavouredReforms_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local factionID = GameInfoTypes[row.FactionType]
		local factionPower = player:GetFactionPower(factionID)
		if factionPower > 0 then
				
			--g_JFD_Reforms_FactionSupportSovMod_Table
			local reformsTable = g_JFD_Reforms_FactionSupportSovMod_Table
			local numReforms = #reformsTable
			for index = 1, numReforms do
				local row = reformsTable[index]
				local reformID = row.ID
				if player:HasReform(reformID) then
					factionPower = factionPower + g_GetRound((factionPower*row.FactionSupportSovMod)/100)
				end
			end
			
			local thisReformBranchType = row.ReformBranchType
			local thisReformType = row.ReformType
			if (thisReformBranchType and thisReformBranchType == reformBranchType) and ((reformAlignment == row.ReformAlignment) or (not row.ReformAlignment)) then
				numReformOpinionFavoured = numReformOpinionFavoured + factionPower
			elseif (thisReformType and reformType == thisReformType) then
				numReformOpinionFavoured = numReformOpinionFavoured + factionPower
			end
		end
	end
	
	return numReformOpinionFavoured
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsReformOpposed
function Player.IsReformOpposed(player, reformID)
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local reformAlignment = reform.Alignment
	local reformBranchType = reform.ReformBranchType
	
	--g_JFD_Faction_OpposedReforms_Table
	local factionsTable = g_JFD_Faction_OpposedReforms_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local factionID = GameInfoTypes[row.FactionType]
		local factionPower = player:GetFactionPower(factionID)
			
		if factionPower > 0 then
			local thisReformBranchType = row.ReformBranchType
			local thisReformType = row.ReformType
			if (thisReformBranchType and thisReformBranchType == reformBranchType) and ((reformAlignment == row.ReformAlignment) or (not row.ReformAlignment)) then
				return true
			elseif (thisReformType and reformType == thisReformType) then
				return true
			end
		end
	end
	
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetReformOpinionOpposed
function Player.GetReformOpinionOpposed(player, reformID)
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local reformAlignment = reform.Alignment
	local reformBranchType = reform.ReformBranchType
	local numReformOpinionOpposed = 0
	
	--g_JFD_Faction_OpposedReforms_Table
	local factionsTable = g_JFD_Faction_OpposedReforms_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local factionID = GameInfoTypes[row.FactionType]
		local factionPower = player:GetFactionPower(factionID)
		
		--g_JFD_Reforms_FactionOppositionSovMod_Table
		local reformsTable = g_JFD_Reforms_FactionOppositionSovMod_Table
		local numReforms = #reformsTable
		for index = 1, numReforms do
			local row = reformsTable[index]
			local reformID = row.ID
			if player:HasReform(reformID) then
				factionPower = factionPower + g_GetRound((factionPower*row.FactionOppositionSovMod)/100)
			end
		end
			
		if factionPower > 0 then
			local thisReformBranchType = row.ReformBranchType
			local thisReformType = row.ReformType
			if (thisReformBranchType and thisReformBranchType == reformBranchType) and ((reformAlignment == row.ReformAlignment) or (not row.ReformAlignment)) then
				numReformOpinionOpposed = numReformOpinionOpposed + factionPower
			elseif (thisReformType and reformType == thisReformType) then
				numReformOpinionOpposed = numReformOpinionOpposed + factionPower
			end
		end
	end
	
	return numReformOpinionOpposed
end
----------------------------------------------------------------------------------------------------------------------------
--Player:CanHaveReform
function Player.CanHaveReform(player, reformID, ignoreCost, reformCost)
	local playerTeam = Teams[player:GetTeam()]
	local currentGovernmentID = player:GetCurrentGovernment()
	local currentGovernment = GameInfo.JFD_Governments[currentGovernmentID]
	local reform = GameInfo.JFD_Reforms[reformID]
	local canHaveReform = true
	local isReformCooldownDisable = false
	local strReformDisableIcon = ""
	local strReformDisabledTT = ""
	
	if (not reform.ShowInGovernment) then 
		return false, false, "", ""
	end

	if player:HasReform(reformID) then 
		canHaveReform = false
		isReformCooldownDisable = false
		strReformDisableIcon = ""
		strReformDisabledTT = strReformDisabledTT .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_PASSED")
	end

	if player:IsAnarchy() then
		canHaveReform = false
		isReformCooldownDisable = false
		strReformDisableIcon = "[ICON_RESISTANCE]"
		-- strReformDisabledTT = strReformDisabledTT .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_ANARCHY")
	end

	if (not ignoreCost) then
		local numSov = player:GetCurrentSovereignty()
		local numReformCost = reformCost
		if (not numReformCost) then			
			numReformCost = player:GetReformCost(reformID)
		end
		if numSov < numReformCost then 
			canHaveReform = false
			isReformCooldownDisable = false
			strReformDisableIcon = "[ICON_JFD_SOVEREIGNTY]"
			-- strReformDisabledTT = strReformDisabledTT .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_SOVEREIGNTY_REQ", numReformCost) 
		end
	end

	local prereqGovernmentID = GameInfoTypes[reform.PrereqGovernment]
	if prereqGovernmentID then
		if currentGovernmentID ~= prereqGovernmentID then 
			canHaveReform = false
			isReformCooldownDisable = false
			strReformDisableIcon = "[ICON_LOCKED]"
			strReformDisabledTT = strReformDisabledTT .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_PREREQ_GOVERNMENT", GameInfo.JFD_Governments[prereqGovernmentID].Description) 
		end
	end

	local prereqEraID = GameInfoTypes[reform.PrereqEra]
	if prereqEraID then
		local currentEraID = player:GetCurrentEra()
		if currentEraID < prereqEraID then 
			canHaveReform = false
			isReformCooldownDisable = false
			strReformDisableIcon = "[ICON_LOCKED]"
			strReformDisabledTT = strReformDisabledTT .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_PREREQ_ERA", GameInfo.Eras[prereqEraID].Description)
		end
	end

	local numReformCooldown = player:GetCurrentReformCooldown(reform.ReformSubBranchType)
	if numReformCooldown > 0 then 
		canHaveReform = false
		isReformCooldownDisable = true
		strReformDisableIcon = "[ICON_JFD_REFORM_COOLDOWN]"
		-- strReformDisabledTT = strReformDisabledTT .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_COOLDOWN", numReformCooldown)
	end

	return canHaveReform, isReformCooldownDisable, strReformDisableIcon, strReformDisabledTT
end
----------------------------------------------------------------------------------------------------------------------------
--Player_GetReformSubBranchAlignmentPreference
function Player_GetReformSubBranchAlignmentPreference(player, reformSubBranchID)
	local prefAlignment = "REFORM_CENTRE"
	local reformSubBranch = GameInfo.JFD_ReformSubBranches[reformSubBranchID]
	local reformSubBranchType = reformSubBranch.Type
	local reformBranchType = reformSubBranch.ReformBranchType
	local reformBranchFlavourType = reformBranchType.FlavourType
	local baseFlavour = player:GetFlavorValue(reformBranchFlavourType)
	if baseFlavour == 0 then
		local reformBranchAltFlavourType = reformBranchType.AltFlavourType
		baseFlavour = player:GetFlavorValue(reformBranchAltFlavourType)
	end

	local leftFlavourVal = 0
	if baseFlavour <= 4 then
		leftFlavourVal = baseFlavour
	end
	local rightFlavourVal = 0
	if baseFlavour >= 7 then
		rightFlavourVal = (baseFlavour-6)
	end
	local centreFlavourVal = 0
	if (baseFlavour == 5 or baseFlavour == 6) then
		centreFlavourVal = (baseFlavour-4)
	end

	--g_JFD_ReformSubBranch_Flavours_Table
	local reformSubBranchesTable = g_JFD_ReformSubBranch_Flavours_Table
	local numSubBranches = #reformSubBranchesTable
	for index = 1, numSubBranches do
		local row = reformSubBranchesTable[index]	
		if row.ReformSubBranchType == reformSubBranchType then
			local leftFlavourType = row.LeftFlavourType
			leftFlavourVal = leftFlavourVal + player:GetFlavorValue(leftFlavourType) + g_GetRandom(1,3)
			local rightFlavourType = row.RightFlavourType
			rightFlavourVal = rightFlavourVal + player:GetFlavorValue(rightFlavourType) + g_GetRandom(1,3)
			local centreFlavourType = row.CentreFlavourType
			centreFlavourVal = centreFlavourVal + 0
			if centreFlavourType then
				centreFlavourVal = centreFlavourVal + player:GetFlavorValue(centreFlavourType) + g_GetRandom(1,3)
			end
		end
	end
	
	if (rightFlavourVal > centreFlavourVal and leftFlavourVal > centreFlavourVal) then
		if rightFlavourVal > leftFlavourVal then
			prefAlignment = "REFORM_RIGHT"
		else
			prefAlignment = "REFORM_LEFT"
		end
	end
	
	return prefAlignment
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_ReformsToPass_Table
local g_JFD_ReformsToPass_Table = {}
local g_JFD_ReformsToPass_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reforms WHERE ShowInGovernment = 1 ORDER BY ID DESC;") do 	
	g_JFD_ReformsToPass_Table[g_JFD_ReformsToPass_Count] = row
	g_JFD_ReformsToPass_Count = g_JFD_ReformsToPass_Count + 1
end

--Player_GetReformToPass
function Player_GetReformToPass(playerID)
	local player = Players[playerID]
	-- if player:IsHuman() then return end
	if (not player:IsHasGovernment()) then return end
	
	local numCities = player:GetNumCities()
	local numPop = player:GetTotalPopulation()
		
	local governmentID = player:GetCurrentGovernment()
	local government = GameInfo.JFD_Governments[governmentID]
	local governmentType = government.Type
	local governmentIsSpecial = government.IsSpecial
	local governmentIsUnique = government.IsUnique
	local validReformsTable = {}
	local validReformsTableCount = 1
	
	local currentEraID = player:GetCurrentEra()
	if currentEraID >= eraIndustrialID then
		if player:HasReform(reformFactionsInterestsID) then
			if ((not governmentIsSpecial) and (not governmentIsUnique)) or (governmentIsSpecial and g_GetRandom(1,100) < 5) then
				local reformSubBranchAlignmentPref = Player_GetReformSubBranchAlignmentPreference(player, "REFORM_SUBBRANCH_JFD_FACTIONS")
				if reformSubBranchAlignmentPref == "REFORM_LEFT" then
					if player:CanHaveReform(reformFactionsMultiPartyID, true) then
						return reformFactionsMultiPartyID
					end
				elseif reformSubBranchAlignmentPref == "REFORM_RIGHT" then
					if player:CanHaveReform(reformFactionsTwoPartyID, true) then	
						return reformFactionsTwoPartyID
					end
				end
			end
		end
	end

	--g_JFD_ReformSubBranch_Flavours_Table
	local reformSubBranchesTable = g_JFD_ReformSubBranch_Flavours_Table
	local numSubBranches = #reformSubBranchesTable
	for index = 1, numSubBranches do
		local row = reformSubBranchesTable[index]	
		local reformSubBranchType = row.ReformSubBranchType
		local reformSubBranchAlignmentPref = Player_GetReformSubBranchAlignmentPreference(player, reformSubBranchType)
		
		--g_JFD_ReformsToPass_Table
		local reformsTable = g_JFD_ReformsToPass_Table
		local numReforms = #reformsTable
		for index = 1, numReforms do
			local row2 = reformsTable[index]	
			local reformID = row2.ID
			if row2.ShowInGovernment then
				if (row2.ReformSubBranchType == reformSubBranchType and row2.Alignment == reformSubBranchAlignmentPref) then
					if player:CanHaveReform(reformID, true) then
						local numSovWhenNumCitiesOrLess = row2.SovereigntyWhenNumCitiesOrLess
						local numSovWhenNumCitiesOrMore = row2.SovereigntyWhenNumCitiesOrMore
						if (numSovWhenNumCitiesOrLess > 0 and numCities <= numSovWhenNumCitiesOrLess) 
						or (numSovWhenNumCitiesOrMore > 0 and numCities >= numSovWhenNumCitiesOrMore) 
						or (numSovWhenNumCitiesOrLess == 0 and numSovWhenNumCitiesOrLess == 0) then
							validReformsTable[validReformsTableCount] = reformID
							validReformsTableCount = validReformsTableCount + 1
						end
					end
				end
			end
		end
	end
	
	if #validReformsTable > 0 then
		for _, reformID in pairs(validReformsTable) do
			local reformBranch = GameInfo.JFD_Reforms[reformID].ReformBranchType
			local reformBranchFlavour1 = GameInfo.JFD_ReformBranches[reformBranch].FlavourType
			local reformBranchFlavour2 = GameInfo.JFD_ReformBranches[reformBranch].AltFlavourType
			local playerFlavour1 = player:GetFlavorValue(reformBranchFlavour1) + g_GetRandom(1,4)
			local playerFlavour2 = player:GetFlavorValue(reformBranchFlavour2) + g_GetRandom(1,4)
			local playerFlavour = (playerFlavour1 + playerFlavour2)
			local randomChance = g_GetRandom(1,100)
			if playerFlavour > randomChance then
				return validReformsTable[reformID]
			end
		end
		return validReformsTable[g_GetRandom(1,#validReformsTable)]
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- REFORM CAPACITY UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:CalculateReformCapacity
function Player.CalculateReformCapacity(player)
	local playerID = player:GetID()
	local numReformCapacity = 0
	
	local numFreeReformCapacity = player:GetFreeReformCapacity()
	numReformCapacity = numReformCapacity + numFreeReformCapacity
	
	local governmentID = player:GetCurrentGovernment()
	local government = GameInfo.JFD_Governments[governmentID]
	
	local numReformCapacityMod = Player_GetReformCapacityModifier(player)
	if numReformCapacityMod ~= 0 then
		numReformCapacity = numReformCapacity + ((numReformCapacity*numReformCapacityMod)/100)
	end
	
	return g_GetRound(numReformCapacity), numFreeReformCapacity
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetFreeReformCapacity
function Player.GetFreeReformCapacity(player)
	local playerID = player:GetID()
	return JFD_RTP_Sovereignty[playerID .. "_REFORM_CAPACITY"] or 0
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeFreeReformCapacity
function Player.ChangeFreeReformCapacity(player, changeVal)
	local currentVal = player:GetFreeReformCapacity()
	local newVal = g_GetRound(currentVal+changeVal)
	player:SetFreeReformCapacity(newVal)
	LuaEvents.JFD_ReformCapacityExpanded(player:GetID(), changeVal)
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetFreeReformCapacity
function Player.SetFreeReformCapacity(player, setVal)
	local playerID = player:GetID()
	JFD_RTP_Sovereignty[playerID .. "_REFORM_CAPACITY"] = setVal
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsAtReformCapacity
function Player.IsAtReformCapacity(player)
	local numReformCapacity = player:CalculateReformCapacity()
	local numReforms = player:GetNumReforms(true, true)
	if numReforms == numReformCapacity then
		return true
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsOverReformCapacity
function Player.IsOverReformCapacity(player)
	local numReformCapacity = player:CalculateReformCapacity()
	local numReforms = player:GetNumReforms(true, true)
	if numReforms > numReformCapacity then
		return true
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsUnderReformCapacity
function Player.IsUnderReformCapacity(player)
	local numReformCapacity = player:CalculateReformCapacity()
	local numReforms = player:GetNumReforms(true, true)
	if numReforms < numReformCapacity then
		return true, (numReformCapacity-numReforms)
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetReformCapacitySovModifier
function Player.GetReformCapacitySovModifier(player, numReforms, numReformCapacity)
	local numOverReform = g_MathMax(numReforms-numReformCapacity,0)
	local numSovMod = (numOverReform*10)
	
	local numSovModMod = 0
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisReformCapacitySovMod = row.ReformCapacitySovMod
		if numThisReformCapacitySovMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numSovModMod = numSovModMod + numThisReformCapacitySovMod
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisReformCapacitySovMod = row.ReformCapacitySovMod
		if numThisReformCapacitySovMod ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numThisReformCapacitySovMod = (numThisReformCapacitySovMod*buildingCount)
				numSovModMod = numSovModMod + numThisReformCapacitySovMod
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisReformCapacitySovMod = row.ReformCapacitySovMod
		if numThisReformCapacitySovMod ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numSovModMod = numSovModMod + numThisReformCapacitySovMod
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisReformCapacitySovMod = row.ReformCapacitySovMod
			if numThisReformCapacitySovMod ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numSovModMod = numSovModMod + numThisReformCapacitySovMod
				end
			end
		end
	end
	if numSovModMod ~= 0 then
		numSovMod = numSovMod + ((numSovMod*numSovModMod)/100)
	end
	
	return numSovMod
end
----------------------------------------------------------------------------------------------------------------------------
-- REFORM COOLDOWN UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetCurrentReformCooldown
function Player.GetCurrentReformCooldown(player, reformSubBranchType)
	return JFD_RTP_Sovereignty[reformSubBranchType .. "_COOLDOWN_TURNS"] or 0
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeCurrentReformCooldown
function Player.ChangeCurrentReformCooldown(player, reformSubBranchType, changeVal)
	local currentVal = player:GetCurrentReformCooldown(reformSubBranchType)
	local newVal = g_GetRound(currentVal+changeVal)
	player:SetCurrentReformCooldown(reformSubBranchType, newVal)
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetCurrentReformCooldown
function Player.SetCurrentReformCooldown(player, reformSubBranchType, setVal)
	if setVal <= 0 then setVal = 0 end

	JFD_RTP_Sovereignty[reformSubBranchType .. "_COOLDOWN_TURNS"] = setVal
	LuaEvents.JFD_ReformCooldownChanges(player:GetID(), reformSubBranchType, setVal)
end
----------------------------------------------------------------------------------------------------------------------------
--Player:CalculateReformCooldown
function Player.CalculateReformCooldown(player, reformSubBranchType)
	local numReformCooldown = defineDefaultReformCooldown
	
	local numReformCooldownMod = Player_GetReformCooldownModifier(player, reformSubBranchType)
	if numReformCooldownMod ~= 0 then
		numReformCooldown = numReformCooldown + ((numReformCooldown*numReformCooldownMod)/100)
		numReformCooldown = g_GetRound(numReformCooldown)
	end

	return numReformCooldown, numCurrentReformCooldown
end
----------------------------------------------------------------------------------------------------------------------------
-- REVOLUTIONARIES UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:DoStartRevolution
function Player.DoStartRevolution(player)
	print("Revolution started for ", player:GetName())
	
	--g_JFD_Factions_Table
	local factionsTable = g_JFD_Factions_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local thisFactionID = row.ID
		player:SetFactionPower(thisFactionID, 0)
	end
	player:SetFactionPower(factionRevolutionariesID, 100)
	player:SetAnarchyNumTurns(1)
	
	if player:IsHuman() and player:IsTurnActive() then
		local factionDesc = player:GetFactionName(factionRevolutionariesID)
		Events.AudioPlay2DSound("AS2D_SOUND_JFD_ANARCHY");
		player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_ACTIVE_PLAYER", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REVOLUTION_BEGINS_DESC", factionDesc, 1), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REVOLUTION_BEGINS_SHORT_DESC", factionDesc), false, nil, nil, governmentAnarchyID)
		LuaEvents.UI_ShowNewLegislaturePopup(playerID, governmentID, true)
	else
		local factionDesc = player:GetFactionName(factionRevolutionariesID)
		player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_NEW_LEGISLATURE_DESC_REVOLUTIONARIES", factionDesc, player:GetCivilizationAdjective()))
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsInRevolution
function Player.IsInRevolution(player)
	return (player:GetDominantFaction() == factionRevolutionariesID)
end
----------------------------------------------------------------------------------------------------------------------------
--Player:DoEndRevolution
function Player.DoEndRevolution(player, isFromGovChange)
	player:SetFactionPower(factionRevolutionariesID, 0)
	player:SetAnarchyNumTurns(0)
	if player:IsHuman() and player:IsTurnActive() then
		local faction = GameInfo.JFD_Factions[factionRevolutionariesID]
		local factionDesc = player:GetFactionName(factionRevolutionariesID)
		Events.AudioPlay2DSound("AS2D_SOUND_JFD_ANARCHY_ENDS");
		player:SendNotification("NOTIFICATION_JFD_GOVERNMENT", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REVOLUTION_ENDS_DESC", factionDesc), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REVOLUTION_ENDS_SHORT_DESC", factionDesc), false, -1, -1)
	end
	if (not isFromGovChange) then
		local governmentID = player:GetCurrentGovernment()
		player:ResetLegislature(governmentID)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- REVOLUTIONARY SENTIMENT UTILS
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Reforms_RevolutionarySentimentPerReform_Table
local g_JFD_Reforms_RevolutionarySentimentPerReform_Table = {}
local g_JFD_Reforms_RevolutionarySentimentPerReform_Count = 1
for row in DB.Query("SELECT ID, RevolutionarySentimentPerReform FROM JFD_Reforms WHERE ShowInGovernment = 1 AND RevolutionarySentimentPerReform <> 0;") do 	
	g_JFD_Reforms_RevolutionarySentimentPerReform_Table[g_JFD_Reforms_RevolutionarySentimentPerReform_Count] = row
	g_JFD_Reforms_RevolutionarySentimentPerReform_Count = g_JFD_Reforms_RevolutionarySentimentPerReform_Count + 1
end

--Player:GetTotalRevolutionarySentiment
function Player.GetTotalRevolutionarySentiment(player, returnsTT)
	local currentGovernmentID = player:GetCurrentGovernment()
	local currentGovernment = GameInfo.JFD_Governments[currentGovernmentID]
	
	if currentGovernment.IsNoRevSentiment then
		return 0, g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REVOLUTIONARY_SENTIMENT_TT_DISABLED")
	end	
	
	local numRevolutionarySentiment = 0
	local strRevolutionarySentimentTT = ""
	
	--OPPOSITION	
	local numRevolutionarySentimentPerReform = 1
	local numRevolutionarySentimentOpposition = 0
	--g_JFD_Reforms_RevolutionarySentimentPerReform_Table
	local reformsTable = g_JFD_Reforms_RevolutionarySentimentPerReform_Table
	local numGovts = #reformsTable
	for index = 1, numGovts do
		local row = reformsTable[index]
		local reformID = row.ID
		if player:HasReform(reformID) then
			numRevolutionarySentimentPerReform = numRevolutionarySentimentPerReform + ((numRevolutionarySentimentPerReform*row.RevolutionarySentimentPerReform)/100)
		end
	end
	
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = row.ID
		if player:HasReform(reformID) then
			local reformAlignment = row.Alignment
			local reformBranch = row.ReformBranchType
			
			--g_JFD_Faction_OpposedReforms_Table
			local factionsTable = g_JFD_Faction_OpposedReforms_Table
			local numFactions = #factionsTable
			for index = 1, numFactions do
				local row = factionsTable[index]
				if ((row.ReformBranchType == reformBranch) and (row.ReformAlignment == reformAlignment)) then
					local factionID = GameInfoTypes[row.FactionType]
					local factionPower = player:GetFactionPower(factionID)
					if factionPower > 0 then
						numRevolutionarySentimentOpposition = numRevolutionarySentimentOpposition + ((numRevolutionarySentimentPerReform*factionPower)/100)
					end
				end
			end
		end
	end
	numRevolutionarySentiment = numRevolutionarySentimentOpposition
	if returnsTT then
		strRevolutionarySentimentTT = g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_OPPOSITION", "[COLOR_WARNING_TEXT]+" .. numRevolutionarySentimentOpposition .. "[ENDCOLOR]")
	end
	
	local numRevolutionarySentimentMod, strRevolutionarySentimentModTT = Player_GetRevolutionarySentimentModifier(player, returnsTT)
	if numRevolutionarySentimentMod ~= 0 then
		numRevolutionarySentiment = numRevolutionarySentiment + ((numRevolutionarySentiment*numRevolutionarySentimentMod)/100)
	end	
	numRevolutionarySentiment = g_GetRound(numRevolutionarySentiment)
	numRevolutionarySentiment = g_MathMax(numRevolutionarySentiment,0)
	if returnsTT then
		strRevolutionarySentimentTT = g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REVOLUTIONARY_SENTIMENT_TT", numRevolutionarySentiment) .. strRevolutionarySentimentTT
		if strRevolutionarySentimentModTT ~= "" then
			strRevolutionarySentimentTT = strRevolutionarySentimentTT .. strRevolutionarySentimentModTT
		end
	end

	return numRevolutionarySentiment, strRevolutionarySentimentTT
end
----------------------------------------------------------------------------------------------------------------------------
-- REVOLUTIONARY SENTIMENT MODIFIER UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player_GetRevolutionarySentimentModifier
function Player_GetRevolutionarySentimentModifier(player, returnsTT)
	local numCities = player:GetNumCities()
	local numPopulation = player:GetTotalPopulation()

	local numRevolutionarySentimentMod = 0
	local strRevolutionarySentimentModTT = ""
			
	local numRevolutionarySentimentModReforms = 0
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisRevolutionarySentimentModReforms = row.RevolutionarySentimentMod
		if numThisRevolutionarySentimentModReforms ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numRevolutionarySentimentModReforms = numRevolutionarySentimentModReforms + numThisRevolutionarySentimentModReforms
			end
		end
	end
	if numRevolutionarySentimentModReforms ~= 0 then
		numRevolutionarySentimentMod = numRevolutionarySentimentMod + numRevolutionarySentimentModReforms
		if returnsTT then
			if numRevolutionarySentimentModReforms > 0 then
				strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_REFORMS", "[COLOR_WARNING_TEXT]+" .. numRevolutionarySentimentModReforms .. "%[ENDCOLOR]")
			else
				strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_REFORMS", "[COLOR_POSITIVE_TEXT]" .. numRevolutionarySentimentModReforms .. "%[ENDCOLOR]")
			end
		end
	end
				
	local numRevolutionarySentimentModBuildings = 0
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisRevolutionarySentimentModRBuildings = row.RevolutionarySentimentMod
		if numThisRevolutionarySentimentModRBuildings ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numRevolutionarySentimentModBuildings = numRevolutionarySentimentModBuildings + (numThisRevolutionarySentimentModRBuildings*buildingCount)
			end
		end
	end
	if numRevolutionarySentimentModBuildings ~= 0 then
		numRevolutionarySentimentMod = numRevolutionarySentimentMod + numRevolutionarySentimentModBuildings
		if returnsTT then
			if numRevolutionarySentimentModBuildings > 0 then
				strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_BUILDINGS", "[COLOR_WARNING_TEXT]+" .. numRevolutionarySentimentModBuildings .. "%[ENDCOLOR]")
			else
				strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_BUILDINGS", "[COLOR_POSITIVE_TEXT]" .. numRevolutionarySentimentModBuildings .. "%[ENDCOLOR]")
			end
		end
	end
			
	local numRevolutionarySentimentModPolicies = 0
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisRevolutionarySentimentModPolicies = row.RevolutionarySentimentMod
		if numThisRevolutionarySentimentModPolicies ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numRevolutionarySentimentModPolicies = numRevolutionarySentimentModPolicies + numThisRevolutionarySentimentModPolicies
			end
		end
	end
	if numRevolutionarySentimentModPolicies ~= 0 then
		numRevolutionarySentimentMod = numRevolutionarySentimentMod + numRevolutionarySentimentModPolicies
		if returnsTT then
			if numRevolutionarySentimentModPolicies > 0 then
				strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_POLICIES", "[COLOR_WARNING_TEXT]+" .. numRevolutionarySentimentModPolicies .. "%[ENDCOLOR]")
			else
				strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_POLICIES", "[COLOR_POSITIVE_TEXT]" .. numRevolutionarySentimentModPolicies .. "%[ENDCOLOR]")
			end
		end
	end
			
	if Player.HasTrait then
		local numRevolutionarySentimentModTraits = 0
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisRevolutionarySentimentModTraits = row.RevolutionarySentimentMod
			if numThisRevolutionarySentimentModTraits ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numRevolutionarySentimentModTraits = numRevolutionarySentimentModTraits + numThisRevolutionarySentimentModTraits
				end
			end
		end
		if numRevolutionarySentimentModTraits ~= 0 then
			numRevolutionarySentimentMod = numRevolutionarySentimentMod + numRevolutionarySentimentModTraits
			if returnsTT then
				if numRevolutionarySentimentModTraits > 0 then
					strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_TRAITS", "[COLOR_WARNING_TEXT]+" .. numRevolutionarySentimentModTraits .. "%[ENDCOLOR]")
				else
					strRevolutionarySentimentModTT = strRevolutionarySentimentModTT .. g_ConvertTextKey("TXT_KEY_JFD_REVOLUTIONARY_SENTIMENT_TT_FROM_TRAITS", "[COLOR_POSITIVE_TEXT]" .. numRevolutionarySentimentModTraits .. "%[ENDCOLOR]")
				end
			end
		end
	end
	
	return numRevolutionarySentimentMod, strRevolutionarySentimentModTT
end
----------------------------------------------------------------------------------------------------------------------------
-- REFORM MODIFIER UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player_GetReformCapacityModifier
function Player_GetReformCapacityModifier(player, returnsTT)
	local numReformCapacityMod = 0
	local strNumReformCapacityMod = ""
	
	local governmentID = player:GetCurrentGovernment()
	local numReformCapacityModAtWar = GameInfo.JFD_Governments[governmentID].ReformCapacityModAtWar
	if numReformCapacityModAtWar > 0 then
		local playerTeam = Teams[player:GetTeam()]
		if playerTeam:GetAtWarCount(true) > 0 then
			numReformCapacityMod = numReformCapacityMod + numReformCapacityModAtWar
		end
	end

	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisReformCapacityMod = row.ReformCapacityMod
		if numThisReformCapacityMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numReformCapacityMod = numReformCapacityMod + numThisReformCapacityMod
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisReformCapacityMod = row.ReformCapacityMod
		if numThisReformCapacityMod ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numThisReformCapacityMod = (numThisReformCapacityMod*buildingCount)
				numReformCapacityMod = numReformCapacityMod + numThisReformCapacityMod
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisReformCapacityMod = row.ReformCapacityMod
		if numThisReformCapacityMod ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numReformCapacityMod = numReformCapacityMod + numThisReformCapacityMod
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisReformCapacityMod = row.ReformCapacityMod
			if numThisReformCapacityMod ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numReformCapacityMod = numReformCapacityMod + numThisReformCapacityMod
				end
			end
		end
	end
	
	return numReformCapacityMod, strNumReformCapacityMod
end
----------------------------------------------------------------------------------------------------------------------------
--Player_GetReformCooldownModifier
function Player_GetReformCooldownModifier(player, reformSubBranchType)
	local numReformCooldownMod = 0

	if GameInfo.JFD_ReformSubBranches[reformSubBranchType].ReformBranchType == "REFORM_BRANCH_JFD_RELIGION" then
		local governmentID = player:GetCurrentGovernment()
		local numReformCooldownModReligious = GameInfo.JFD_Governments[governmentID].ReligiousReformCooldownMod
		if numReformCooldownModReligious ~= 0 then
			numReformCooldownMod = numReformCooldownMod + numReformCooldownModReligious
		end
	end
			
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisReformCooldownMod = row.ReformCooldownMod
		if numThisReformCooldownMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numReformCooldownMod = numReformCooldownMod + numThisReformCooldownMod
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisReformCooldownMod = row.ReformCooldownMod
		if numThisReformCooldownMod ~= 0 then
			local buildingID = GameInfoTypes[row.BuildingType]
			local buildingCount = player:CountNumBuildings(buildingID)
			if buildingCount > 0 then
				numThisReformCooldownMod = (numThisReformCooldownMod*buildingCount)
				numReformCooldownMod = numReformCooldownMod + numThisReformCooldownMod
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisReformCooldownMod = row.ReformCooldownMod
		if numThisReformCooldownMod ~= 0 then
			local policyID = GameInfoTypes[row.PolicyType]
			if player:HasPolicy(policyID) then
				numReformCooldownMod = numReformCooldownMod + numThisReformCooldownMod
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisReformCooldownMod = row.ReformCooldownMod
			if numThisReformCooldownMod ~= 0 then
				local traitID = GameInfoTypes[row.TraitType]
				if player:HasTrait(traitID) then
					numReformCooldownMod = numReformCooldownMod + numThisReformCooldownMod
				end
			end
		end
	end
	
	return numReformCooldownMod
end
----------------------------------------------------------------------------------------------------------------------------
--Player_GetReformCostModifier
function Player_GetReformCostModifier(player, reformID)
	local governmentID = player:GetCurrentGovernment()
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local numReformCostMod = 0
	
	local governmentID = player:GetCurrentGovernment()
	local government = GameInfo.JFD_Governments[governmentID]
	local numReformCostModGovernment = government.ReformCostMod
	local numReformCostModGovernmentReliMil = government.ReliMilReformCostMod
	local numReformCostCouncillorBonus = government.CouncillorReformCostMod
	if numReformCostModGovernment ~= 0 then
		numReformCostMod = numReformCostMod + numReformCostModGovernment
	end
	
	if numReformCostModGovernmentReliMil ~= 0 then
		if reform.ReformBranchType == "REFORM_BRANCH_JFD_RELIGION" or reform.ReformBranchType == "REFORM_BRANCH_JFD_MILITARY" then
			numReformCostMod = numReformCostMod + numReformCostModGovernmentReliMil
		end
	end
			
	--g_JFD_Reforms_Table
	local reformsTable = g_JFD_Reforms_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local numThisReformCostMod = row.ReformCostMod
		if numThisReformCostMod ~= 0 then
			local reformID = row.ID
			if player:HasReform(reformID) then
				numReformCostMod = numReformCostMod + numThisReformCostMod
			end
		end
	end
	
	--g_Building_JFD_SovereigntyMods_Table
	local buildingsTable = g_Building_JFD_SovereigntyMods_Table
	local numBuildings = #buildingsTable
	for index = 1, numBuildings do
		local row = buildingsTable[index]
		local numThisReformCostMod = row.ReformCostMod
		local reqReformID = GameInfoTypes[row.ReformCostModReformType]
		if (not reqReformID) or (reqReformID and reqReformID == reformID) then
			if numThisReformCostMod ~= 0 then
				local buildingID = GameInfoTypes[row.BuildingType]
				local buildingCount = player:CountNumBuildings(buildingID)
				if buildingCount > 0 then
					numReformCostMod = numReformCostMod + (numThisReformCostMod*buildingCount)
				end
			end
		end
	end
			
	--g_Policy_JFD_SovereigntyMods_Table
	local policiesTable = g_Policy_JFD_SovereigntyMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local numThisReformCostMod = row.ReformCostMod
		if row.IsCouncillorBonus then
			if numReformCostCouncillorBonus > 0 then
				numThisReformCostMod = numReformCostCouncillorBonus
			end
		end
		local reqReformID = GameInfoTypes[row.ReformCostModReformType]
		local reqReformBranch = row.ReformBranchType
		if ((not reqReformID) and (not reqReformBranch)) or (reqReformID and reqReformID == reformID) or (reqReformBranch and reform.ReformBranchType == reqReformBranch) then
			if numThisReformCostMod ~= 0 then
				local policyID = GameInfoTypes[row.PolicyType]
				if player:HasPolicy(policyID) then
					numReformCostMod = numReformCostMod + numThisReformCostMod
				end
			end
		end
	end
			
	if Player.HasTrait then
		--g_Trait_JFD_SovereigntyMods_Table
		local traitsTable = g_Trait_JFD_SovereigntyMods_Table
		local numTraits = #traitsTable
		for index = 1, numTraits do
			local row = traitsTable[index]
			local numThisReformCostMod = row.ReformCostMod
			local reqReformID = GameInfoTypes[row.ReformCostModReformType]
			if (not reqReformID) or (reqReformID and reqReformID == reformID) then
				if numThisReformCostMod ~= 0 then
					local traitID = GameInfoTypes[row.TraitType]
					if player:HasTrait(traitID) then
						numReformCostMod = numReformCostMod + numThisReformCostMod
					end
				end
			end
		end
	end
	
	return numReformCostMod
end
----------------------------------------------------------------------------------------------------------------------------
-- REFORM TEXT UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetReformInfoTT
function Player.GetReformInfoTT(player, reformID, reformCost)
	local playerTeam = Teams[player:GetTeam()]
	local strReformHelp = ""
	
	local reform = GameInfo.JFD_Reforms[reformID]
	local reformType = reform.Type
	local reformAlignment = reform.Alignment
	local hasReform = player:HasReform(reformID)
	local canHaveReform, reformCooldownIsDisable, strReformDisabledIcon, strReformDisabledTT = player:CanHaveReform(reformID, reformCost)
	local reformBranchType = reform.ReformBranchType
	local reformHelp
	
	--LEGISLATURE	
	local strReformOpinions = ""
	local isSupported = false
	
	--g_JFD_Faction_FavouredReforms_Table
	local factionsTable = g_JFD_Faction_FavouredReforms_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local factionID = GameInfoTypes[row.FactionType]
		local factionPower = player:GetFactionPower(factionID)
		if factionPower > 0 then
		
			--g_JFD_Reforms_FactionSupportSovMod_Table
			local reformsTable = g_JFD_Reforms_FactionSupportSovMod_Table
			local numReforms = #reformsTable
			for index = 1, numReforms do
				local row = reformsTable[index]
				local reformID = row.ID
				if player:HasReform(reformID) then
					factionPower = factionPower + g_GetRound((factionPower*row.FactionSupportSovMod)/100)
				end
			end
		
			isSupported = true
			local thisReformAlignment = row.ReformAlignment
			local thisReformBranch = row.ReformBranchType
			local thisReformType = row.ReformType
			if thisReformBranch and thisReformBranch == reformBranchType and reformAlignment == thisReformAlignment then
				local faction = GameInfo.JFD_Factions[factionID]
				local factionIcon = faction.IconString
				strReformOpinions = strReformOpinions .. "[NEWLINE]   [ICON_BULLET][ICON_JFD_REFORM_SUPPORT] "
				strReformOpinions = strReformOpinions .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORM_SUPPORTED", factionIcon, factionPower) 
			elseif (thisReformType and reformType == thisReformType) then
				local faction = GameInfo.JFD_Factions[factionID]
				local factionIcon = faction.IconString
				strReformOpinions = strReformOpinions .. "[NEWLINE]   [ICON_BULLET][ICON_JFD_REFORM_SUPPORT] "
				strReformOpinions = strReformOpinions .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORM_SUPPORTED", factionIcon, factionPower) 
			end
		end
	end
	
	--g_JFD_Faction_OpposedReforms_Table
	local factionsTable = g_JFD_Faction_OpposedReforms_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local factionID = GameInfoTypes[row.FactionType]
		local factionPower = player:GetFactionPower(factionID)
		if factionPower > 0 then
		
			--g_JFD_Reforms_FactionOppositionSovMod_Table
			local reformsTable = g_JFD_Reforms_FactionOppositionSovMod_Table
			local numReforms = #reformsTable
			for index = 1, numReforms do
				local row = reformsTable[index]
				local reformID = row.ID
				if player:HasReform(reformID) then
					factionPower = factionPower + g_GetRound((factionPower*row.FactionOppositionSovMod)/100)
				end
			end
			
			local thisReformAlignment = row.ReformAlignment
			local thisReformBranch = row.ReformBranchType
			local thisReformType = row.ReformType
			if thisReformBranch and thisReformBranch == reformBranchType and reformAlignment == thisReformAlignment then
				local faction = GameInfo.JFD_Factions[factionID]
				local factionIcon = faction.IconString
				if (not isSupported) then
					strReformOpinions = strReformOpinions .. "[NEWLINE]"
				end
				strReformOpinions = strReformOpinions .. "[NEWLINE]   [ICON_BULLET][ICON_JFD_REFORM_OPPOSE] "
				strReformOpinions = strReformOpinions .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORM_OPPOSED", factionIcon, factionPower) 
			elseif (thisReformType and reformType == thisReformType) then
				local faction = GameInfo.JFD_Factions[factionID]
				local factionIcon = faction.IconString
				strReformOpinions = strReformOpinions .. "[NEWLINE]   [ICON_BULLET][ICON_JFD_REFORM_OPPOSE] "
				strReformOpinions = strReformOpinions .. g_ConvertTextKey("TXT_KEY_JFD_GOVERNMENT_OVERVIEW_REFORM_OPPOSED", factionIcon, factionPower) 
			end
		end
	end
	
	strReformOpinions = strReformOpinions .. "[NEWLINE]" 
	strReformHelp = g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP", reform.ShortDescription, reform.Pedia, reform.HelpBonus, reform.HelpPenalty, strReformOpinions)
	
	--Active
	if hasReform then
		strReformHelp = strReformHelp .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_PASSED")
	else
			
		--ANARCHY
		if player:IsAnarchy() then
			strReformHelp = strReformHelp .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_ANARCHY")
		end
		
		--COST
		local numSov = player:GetCurrentSovereignty()
		local numReformCost = reformCost
		if (not numReformCost) then			
			numReformCost = player:GetReformCost(reformID)
		end
		if numSov < numReformCost then 
			strReformHelp = strReformHelp .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_SOVEREIGNTY_REQ", numReformCost) 
		end
		
		--COOLDOWN
		local reformSubBranchType = reform.ReformSubBranchType
		local numReformCooldown = player:GetCurrentReformCooldown(reformSubBranchType)
		if numReformCooldown > 0 then 
			strReformHelp = strReformHelp .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_COOLDOWN", numReformCooldown)
		end
		
		--PREREQS	
		if strReformDisabledTT ~= "" then
			strReformHelp = strReformHelp .. "[NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_REFORM_HELP_PREREQS") 
			strReformHelp = strReformHelp .. strReformDisabledTT
		end	
	end
	
	return strReformHelp
end
----------------------------------------------------------------------------------------------------------------------------
-- COUNCILLOR UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetUnitClassCouncillorType
function Player.GetUnitClassCouncillorType(player, unitClassType)
	--g_JFD_Councillors_GreatPeople_Table
	local councillorsTable = g_JFD_Councillors_GreatPeople_Table
	local numCouncillors = #councillorsTable
	for index = 1, numCouncillors do
		local row = councillorsTable[index]
		if row.UnitClassType == unitClassType then
			return row.CouncillorType
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:IsHasCouncillor
function Player.IsHasCouncillor(player, councillorID)
	return (player:GetCouncillorUnitClassType(councillorID))
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetHasCouncillor
function Player.SetHasCouncillor(player, unit, unitID, councillorID, councillorName, setHasCouncillor)
	if setHasCouncillor then
		local unitInfo = GameInfo.Units[unitID]
		local unitClassID = GameInfoTypes[unitInfo.Class]
		
		if councillorName then
			local lengthUnitDesc = (Locale.Length(councillorName) - Locale.Length(" (" .. Locale.ConvertTextKey(unitInfo.Description) .. ")"))
			councillorName = Locale.Substring(councillorName, 0, lengthUnitDesc)
		end
	
		--g_JFD_Councillors_GreatPeople_Table
		local councillorsTable = g_JFD_Councillors_GreatPeople_Table
		local numCouncillors = #councillorsTable
		for index = 1, numCouncillors do
			local row = councillorsTable[index]
			local thisCouncillorID = GameInfoTypes[row.CouncillorType]
			if thisCouncillorID == councillorID then
				if player:IsHasCouncillor(councillorID) then
					player:SetHasCouncillor(unit, unitID, councillorID, nil, false)
				end
			end
		end

		--g_JFD_Councillors_GreatPeople_Table
		local councillorsTable = g_JFD_Councillors_GreatPeople_Table
		local numCouncillors = #councillorsTable
		for index = 1, numCouncillors do
			local row = councillorsTable[index]
			local thisCouncillorID = GameInfoTypes[row.CouncillorType]
			if thisCouncillorID == councillorID then
				local thisUnitClassID = GameInfoTypes[row.UnitClassType]
				if thisUnitClassID == unitClassID then
					local policyID = GameInfoTypes[row.PolicyType]
					if Player.GrantPolicy then
						player:GrantPolicy(policyID, true)
					else
						player:SetNumFreePolicies(1)
						player:SetNumFreePolicies(0)
						player:SetHasPolicy(policyID, true)
					end
					player:SetCouncillorName(councillorID, councillorName)
				end
			end
		end

		if g_IsCPActive then
			unit:greatperson()
		else
			unit:Kill(-1)
		end

		if player:IsHuman() and player:IsTurnActive() then
			local councillor = GameInfo.JFD_Councillors[councillorID]
			local councillorDesc = councillor.Description
			local unitDesc = unitInfo.Description
			player:SendNotification("NOTIFICATION_JFD_GOVERNMENT", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_COUNCILLOR_APPOINTED_TEXT", unit:GetName(), unitDesc, councillorDesc), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_COUNCILLOR_APPOINTED_SHORT_TEXT"), false, nil, nil)
			Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_GOOD");
		end
		LuaEvents.JFD_CouncillorAppointed(player:GetID(), councillorID, councillorName)
	else
		local unitInfo = GameInfo.Units[unitID]
		local unitClassID = GameInfoTypes[unitInfo.Class]
		
		--g_JFD_Councillors_GreatPeople_Table
		local councillorsTable = g_JFD_Councillors_GreatPeople_Table
		local numCouncillors = #councillorsTable
		for index = 1, numCouncillors do
			local row = councillorsTable[index]
			local thisCouncillorID = GameInfoTypes[row.CouncillorType]
			if thisCouncillorID == councillorID then
				local thisUnitClassID = GameInfoTypes[row.UnitClassType]
				if thisUnitClassID ~= unitClassID then
					local policyID = GameInfoTypes[row.PolicyType]
					if Player.RevokePolicy then
						player:RevokePolicy(policyID)
					else
						player:SetHasPolicy(policyID, false)
					end
					player:SetCouncillorName(councillorID, councillorName)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetCouncillorUnitClassType
function Player.GetCouncillorUnitClassType(player, councillorID)
	local councillor = GameInfo.JFD_Councillors[councillorID]
	local councillorType = councillor.Type

	--g_JFD_Councillors_GreatPeople_Table
	local councillorsTable = g_JFD_Councillors_GreatPeople_Table
	local numCouncillors = #councillorsTable
	for index = 1, numCouncillors do
		local row = councillorsTable[index]
		local policyID = GameInfoTypes[row.PolicyType]
		if row.CouncillorType == councillorType then
			if player:HasPolicy(policyID) then
				return row.UnitClassType
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetCouncillorName
function Player.GetCouncillorName(player, councillorID)
	local playerID = player:GetID()
	local councillor = GameInfo.JFD_Councillors[councillorID]
	return JFD_RTP_Sovereignty[playerID .. "_" .. councillor.Type .. "_NAME"]
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetCouncillorName
function Player.SetCouncillorName(player, councillorID, strName)
	local playerID = player:GetID()
	local councillor = GameInfo.JFD_Councillors[councillorID]
	JFD_RTP_Sovereignty[playerID .. "_" .. councillor.Type .. "_NAME"] = strName
end
----------------------------------------------------------------------------------------------------------------------------
-- MISC UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetLastReformPassed
function Player.GetLastReformPassed(player)
	local playerID = player:GetID()
	local lastReformID = JFD_RTP_Sovereignty[playerID .. "_LAST_REFORM"]
	local strLastReform = "None"
	if lastReformID then
		local reform = GameInfo.JFD_Reforms[lastReformID]
		local reformDesc = reform.ShortDescription
		local reformSubBranch = reform.ReformSubBranchType
		local reformSubBranchDesc = GameInfo.JFD_ReformSubBranches[reformSubBranch].Description
		strLastReform = g_ConvertTextKey(reformDesc) .. " (" .. g_ConvertTextKey(reformSubBranchDesc) .. ")"
	end
	return strLastReform
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetLastReformPassed
function Player_SetLastReformPassed(playerID, reformID)
	JFD_RTP_Sovereignty[playerID .. "_LAST_REFORM"] = reformID
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetLastPolicyAdopted
function Player.GetLastPolicyAdopted(player)
	local playerID = player:GetID()
	local lastPolicyID = JFD_RTP_Sovereignty[playerID .. "_LAST_POLICY"]
	local strLastPolicy = "None"
	if lastPolicyID then
		local policy = GameInfo.Policies[lastPolicyID]
		local policyDesc = policy.Description
		local policyBranch = policy.PolicyBranchType
		local policyBranchDesc = GameInfo.PolicyBranchTypes[policyBranch].Description
		strLastPolicy = g_ConvertTextKey(policyDesc) .. " (" .. g_ConvertTextKey(policyBranchDesc) .. ")"
	end
	return strLastPolicy
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetLastPolicyAdopted
function Player_SetLastPolicyAdopted(playerID, policyID)
	JFD_RTP_Sovereignty[playerID .. "_LAST_POLICY"] = policyID
end
--=======================================================================================================================
-- CACHING
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--OnModLoaded
function OnModLoaded() 
	local bNewGame = not TableLoad(tableRoot, tableName)

	if bNewGame then
		print("New Game")
	else 
		print("Sovereignty Loaded from Saved Game")
	end

	TableSave(tableRoot, tableName)
end
OnModLoaded()
--==========================================================================================================================
--==========================================================================================================================