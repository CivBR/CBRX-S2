-- JFD_Intrigue_Functions
-- Author: JFD
-- DateCreated: 1/25/2020 9:23:03 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_GetRandom		= Game.GetRandom
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
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
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
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

local buildingCabinetNoirOccupationID = GameInfoTypes["BUILDING_JFD_CABINET_NOIR_OCCUPATION"]
local buildingDiplomaticCabalsDelegateID = GameInfoTypes["BUILDING_JFD_DIPLOMATIC_CABALS_DELEGATE"]
local buildingIntrigueFinisherSpyID = GameInfoTypes["BUILDING_JFD_INTRIGUE_FINISHER_SPY"]
local policyBranchIntrigueID = GameInfoTypes["POLICY_BRANCH_JFD_INTRIGUE"]
local policyCabinetNoirID = GameInfoTypes["POLICY_JFD_CABINET_NOIR"]
local policyDiplomaticCabalsID = GameInfoTypes["POLICY_JFD_DIPLOMATIC_CABALS"]
local policyIntelligenceNetworkID = GameInfoTypes["POLICY_JFD_INTELLIGENCE_NETWORK"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--JFD_Intrigue_PlayerDoTurn
local function JFD_Intrigue_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	local playerCapital = player:GetCapitalCity()
	if (not playerCapital) then return end
	
	if player:HasPolicy(policyCabinetNoirID) then 
		local buildingConstabularyID = GameInfoTypes[player:GetUniqueBuilding("BUILDINGCLASS_CONSTABLE")]
		for city in player:Cities() do
			if city:IsOccupied() then
				if city:IsHasBuilding(buildingConstabularyID) then
					if (not city:IsHasBuilding(buildingCabinetNoirOccupationID)) then
						city:SetNumRealBuilding(buildingCabinetNoirOccupationID, 1)
					end
				else
					if city:IsHasBuilding(buildingCabinetNoirOccupationID) then
						city:SetNumRealBuilding(buildingCabinetNoirOccupationID, 0)
					end
				end
			end
		end
	end

	if player:HasPolicy(policyDiplomaticCabalsID) then 
		local numSpies = 0
		local spies = player:GetEspionageSpies()
		for i,v in ipairs(spies) do
			if (not v.IsDiplomat) then
				local cityX = v.CityX
				local cityY = v.CityY
				if cityX and cityY then
					local plot = g_MapGetPlot(cityX, cityY)
					if plot then
						local city = plot:GetPlotCity()
						if city and city:IsOriginalCapital() and city:GetOwner() ~= playerID then
							numSpies = numSpies + 1
						end
					end
				end
			end
		end
		playerCapital:SetNumRealBuilding(buildingDiplomaticCabalsDelegateID, numSpies, true)
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Intrigue_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Intrigue_PlayerAdoptPolicyBranch
local function JFD_Intrigue_PlayerAdoptPolicyBranch(playerID, policyBranchID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	if policyBranchID ~= policyBranchIntrigueID then return end

	local playerCapital = player:GetCapitalCity()
	if (not playerCapital) then return end

	if (not g_IsCPActive) then
		local buildingJailID = GameInfoTypes[player:GetUniqueBuilding("BUILDINGCLASS_JFD_JAIL")]
		local numCities = 0 
		for city in player:Cities() do
			if (not city:IsHasBuilding(buildingJailID)) then
				city:SetNumRealBuilding(buildingJailID, 1, true)
				numCities = numCities + 1
				if numCities >= 4 then
					break
				end
			end
		end
	end
end
GameEvents.PlayerAdoptPolicyBranch.Add(JFD_Intrigue_PlayerAdoptPolicyBranch)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Intrigue_PlayerAdoptPolicy
local function JFD_Intrigue_PlayerAdoptPolicy(playerID, policyID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	if policyID == policyCabinetNoirID or policyID == policyDiplomaticCabalsID then
		JFD_Intrigue_PlayerDoTurn(playerID)
	end

	if (not g_IsCPActive) then
		local playerCapital = player:GetCapitalCity()
		if (not playerCapital) then return end

		local policyBranch = GameInfo.Policies[policyID].PolicyBranchType
		if policyBranch == "POLICY_BRANCH_JFD_INTRIGUE" then
			if (policyID == policyCabinetNoirID and player:HasPolicy(policyDiplomaticCabalsID) and player:HasPolicy(policyIntelligenceNetworkID)) 
			or (policyID == policyDiplomaticCabalsID and player:HasPolicy(policyCabinetNoirID) and player:HasPolicy(policyIntelligenceNetworkID)) 
			or (policyID == policyIntelligenceNetworkID and player:HasPolicy(policyCabinetNoirID) and player:HasPolicy(policyDiplomaticCabalsID)) then
				if (not playerCapital:IsHasBuilding(buildingIntrigueFinisherSpyID)) then
					playerCapital:SetNumRealBuilding(buildingIntrigueFinisherSpyID, 1, true)
				end
			end
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(JFD_Intrigue_PlayerAdoptPolicy)
----------------------------------------------------------------------------------------------------------------------------
--g_Specialists_Table
local g_Specialists_Table = {}
local g_Specialists_Count = 1
for row in DB.Query("SELECT * FROM Specialists WHERE GreatPeopleUnitClass IS NOT NULL;") do 	
	g_Specialists_Table[g_Specialists_Count] = row
	g_Specialists_Count = g_Specialists_Count + 1
end

--JFD_Intrigue_UnitCreated
local function JFD_Intrigue_UnitCreated(playerID, unitID, unitType, plotX, plotY)
	local player = Players[playerID]
	if player:IsHuman() then return end

	local unit = player:GetUnitByID(unitID)
	if (not unit:IsGreatPerson()) then return end
	
	local unitX = unit:GetX()
	local unitY = unit:GetY()
	local city = g_MapGetPlot(unitX, unitY):GetPlotCity()
	if (not city) then return end
	
	local unitTypeID = unit:GetUnitType()
	local unitInfo = GameInfo.Units[unitTypeID]
	local unitClassType = unitInfo.Class
	
	if unitClassType == "UNITCLASS_GREAT_ADMIRAL" or unitClassType == "UNITCLASS_GREAT_GENERAL" then
		for otherPlayerID = 0, defineMaxMajorCivs - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() and otherPlayer:HasPolicy(policyIntelligenceNetworkID) then
				local otherSpies = otherPlayer:GetEspionageSpies() 
				for i,v in ipairs(otherSpies) do
					local cityX = v.CityX
					local cityY = v.CityY
					if cityX and cityY then
						if cityX == unitX and cityY == unitY then
							local otherPlayerCapital = otherPlayer:GetCapitalCity()
							if otherPlayerCapital then
								local eraID = otherPlayer:GetCurrentEra()+1
								local numPoints = ((5*eraID)*gameSpeedMod)
								if unitClassType == "UNITCLASS_GREAT_GENERAL" then
									otherPlayer:ChangeCombatExperience(numPoints)
								elseif unitClassType == "UNITCLASS_GREAT_ADMIRAL" then
									otherPlayer:ChangeNavalCombatExperience(numPoints)
								end
								if otherPlayer:IsHuman() then
									otherPlayer:SendNotification("NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_DESC", player:GetCivilizationAdjective(), city:GetName(), unitInfo.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_SHORT_DESC"), false, otherPlayerCapital:GetX(), otherPlayerCapital:GetY(), -1)
								end
							end
						end
					end
				end
			end
		end	
	else
		--g_Specialists_Table
		local specialistsTable = g_Specialists_Table
		local numSpecialists = #specialistsTable
		for index = 1, numSpecialists do
			local row = specialistsTable[index]
			if row.GreatPeopleUnitClass == unitClassType then
				local specialistID = GameInfoTypes[row.Type]
				for otherPlayerID = 0, defineMaxMajorCivs - 1 do
					local otherPlayer = Players[otherPlayerID]
					if otherPlayer:IsAlive() and otherPlayer:HasPolicy(policyIntelligenceNetworkID) then
						local otherSpies = otherPlayer:GetEspionageSpies() 
						for i,v in ipairs(otherSpies) do
							local cityX = v.CityX
							local cityY = v.CityY
							if cityX and cityY then
								if cityX == unitX and cityY == unitY then
									local otherPlayerCapital = otherPlayer:GetCapitalCity()
									if otherPlayerCapital then
										local eraID = otherPlayer:GetCurrentEra()+1
										local numPoints = ((5*eraID)*gameSpeedMod)*100
										otherPlayerCapital:ChangeSpecialistGreatPersonProgressTimes100(specialistID, numPoints)
										if otherPlayer:IsHuman() then
											otherPlayer:SendNotification("NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_DESC", player:GetCivilizationAdjective(), city:GetName(), unitInfo.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_SHORT_DESC"), false, otherPlayerCapital:GetX(), otherPlayerCapital:GetY(), -1)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
if g_IsVMCActive then
	GameEvents.UnitCreated.Add(JFD_Intrigue_UnitCreated)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Intrigue_SerialEventUnitCreated
local promotionGreatPersonCreatedID = GameInfoTypes["PROMOTION_JFD_GREAT_PERSON_CREATED"]
local function JFD_Intrigue_SerialEventUnitCreated(playerID, unitID)
    local player = Players[playerID]
	
	if player:IsHuman() then return end
	
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	if (not unit:IsGreatPerson()) then return end
	if unit:IsHasPromotion(promotionGreatPersonCreatedID) then return end
	
	local unitX = unit:GetX()
	local unitY = unit:GetY()
	local city = g_MapGetPlot(unitX, unitY):GetPlotCity()
	if (not city) then return end
	
	local unitTypeID = unit:GetUnitType()
	local unitInfo = GameInfo.Units[unitTypeID]
	local unitClassType = unitInfo.Class
	
	if unitClassType == "UNITCLASS_GREAT_ADMIRAL" or unitClassType == "UNITCLASS_GREAT_GENERAL" then
		for otherPlayerID = 0, defineMaxMajorCivs - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() and otherPlayer:HasPolicy(policyIntelligenceNetworkID) then
				local otherSpies = otherPlayer:GetEspionageSpies() 
				for i,v in ipairs(otherSpies) do
					local cityX = v.CityX
					local cityY = v.CityY
					if cityX and cityY then
						if cityX == unitX and cityY == unitY then
							local otherPlayerCapital = otherPlayer:GetCapitalCity()
							if otherPlayerCapital then
								local eraID = otherPlayer:GetCurrentEra()+1
								local numPoints = ((5*eraID)*gameSpeedMod)
								if unitClassType == "UNITCLASS_GREAT_GENERAL" then
									otherPlayer:ChangeCombatExperience(numPoints)
								elseif unitClassType == "UNITCLASS_GREAT_ADMIRAL" then
									otherPlayer:ChangeNavalCombatExperience(numPoints)
								end
								if otherPlayer:IsHuman() then
									otherPlayer:SendNotification("NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_DESC", player:GetCivilizationAdjective(), city:GetName(), unitInfo.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_SHORT_DESC"), false, otherPlayerCapital:GetX(), otherPlayerCapital:GetY(), -1)
								end
							end
						end
					end
				end
			end
		end	
	else
		--g_Specialists_Table
		local specialistsTable = g_Specialists_Table
		local numSpecialists = #specialistsTable
		for index = 1, numSpecialists do
			local row = specialistsTable[index]
			if row.GreatPeopleUnitClass == unitClassType then
				local specialistID = GameInfoTypes[row.Type]
				for otherPlayerID = 0, defineMaxMajorCivs - 1 do
					local otherPlayer = Players[otherPlayerID]
					if otherPlayer:IsAlive() and otherPlayer:HasPolicy(policyIntelligenceNetworkID) then
						local otherSpies = otherPlayer:GetEspionageSpies() 
						for i,v in ipairs(otherSpies) do
							local cityX = v.CityX
							local cityY = v.CityY
							if cityX and cityY then
								if cityX == unitX and cityY == unitY then
									local otherPlayerCapital = otherPlayer:GetCapitalCity()
									if otherPlayerCapital then
										local eraID = otherPlayer:GetCurrentEra()+1
										local numPoints = ((5*eraID)*gameSpeedMod)*100
										otherPlayerCapital:ChangeSpecialistGreatPersonProgressTimes100(specialistID, numPoints)
										if player:IsHuman() then
											player:SendNotification("NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_DESC", player:GetCivilizationAdjective(), city:GetName(), unitInfo.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_INTELLIGENCE_NETWORKS_SHORT_DESC"), false, otherPlayerCapital:GetX(), otherPlayerCapital:GetY(), -1)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	unit:SetHasPromotion(promotionGreatPersonCreatedID, true)
end
if (not g_IsVMCActive) then
	Events.SerialEventUnitCreated.Add(JFD_Intrigue_SerialEventUnitCreated)
end
--==========================================================================================================================
--==========================================================================================================================