-- JFD_Sovereignty_Functions
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:33 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("JFD_Sovereignty_Utils.lua")
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
--=======================================================================================================================
-- CACHED TABLES
--=======================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Governments_Table
local g_JFD_Governments_Table = {}
local g_JFD_Governments_Count = 1
for row in DB.Query("SELECT * FROM JFD_Governments;") do 	
	g_JFD_Governments_Table[g_JFD_Governments_Count] = row
	g_JFD_Governments_Count = g_JFD_Governments_Count + 1
end

--g_JFD_Councillor_GreatPeople_Table
local g_JFD_Councillor_GreatPeople_Table = {}
local g_JFD_Councillor_GreatPeople_Count = 1
for row in DB.Query("SELECT * FROM JFD_Councillor_GreatPeople;") do 	
	g_JFD_Councillor_GreatPeople_Table[g_JFD_Councillor_GreatPeople_Count] = row
	g_JFD_Councillor_GreatPeople_Count = g_JFD_Councillor_GreatPeople_Count + 1
end

--g_JFD_Reform_DummyBuildings_Table
local g_JFD_Reform_DummyBuildings_Table = {}
local g_JFD_Reform_DummyBuildings_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reform_DummyBuildings;") do 	
	g_JFD_Reform_DummyBuildings_Table[g_JFD_Reform_DummyBuildings_Count] = row
	g_JFD_Reform_DummyBuildings_Count = g_JFD_Reform_DummyBuildings_Count + 1
end

--g_JFD_Reform_FreePromotions_Table
local g_JFD_Reform_FreePromotions_Table = {}
local g_JFD_Reform_FreePromotions_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reform_FreePromotions WHERE AddOnPass = 1 OR RemoveOnRevoke = 1;") do 	
	g_JFD_Reform_FreePromotions_Table[g_JFD_Reform_FreePromotions_Count] = row
	g_JFD_Reform_FreePromotions_Count = g_JFD_Reform_FreePromotions_Count + 1
end

--g_JFD_ReformSubBranches_Table
local g_JFD_ReformSubBranches_Table = {}
local g_JFD_ReformSubBranches_Count = 1
for row in DB.Query("SELECT Type FROM JFD_ReformSubBranches;") do 	
	g_JFD_ReformSubBranches_Table[g_JFD_ReformSubBranches_Count] = row
	g_JFD_ReformSubBranches_Count = g_JFD_ReformSubBranches_Count + 1
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
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]

local unitClassInquisitorID = GameInfoTypes["UNITCLASS_INQUISITOR"]
local unitClassMissionaryID = GameInfoTypes["UNITCLASS_MISSIONARY"]

local governmentTotalitarianID = GameInfoTypes["GOVERNMENT_JFD_TOTALITARIAN"]
local governmentPolisID = GameInfoTypes["GOVERNMENT_JFD_POLIS"] 
local governmentTribeID = GameInfoTypes["GOVERNMENT_JFD_TRIBE"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_SequenceGameInitComplete
 function JFD_Sovereignty_SequenceGameInitComplete()
	for playerID = 0, defineMaxMajorCivs - 1 do
		local player = Players[playerID]
		if player:IsAlive() and (not player:IsFoundedFirstCity()) then
			local civ = GameInfo.Civilizations[player:GetCivilizationType()]
			local civDesc = civ.Description
			local civAdj = player:GetCivilizationAdjective(playerID)
			local newText = g_ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_DESC", civAdj)
			Game.ChangeBaseGameText(civDesc, newText)
			player:UpdateLeaderName(governmentTribeID)
			player:UpdateCivilizationStateDescription(governmentTribeID)
			JFD_RTP_Sovereignty[playerID .. "_CHANGE_CHANGE_GOVT"] = {}
		end
	end
end
Events.SequenceGameInitComplete.Add(JFD_Sovereignty_SequenceGameInitComplete)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_NotificationAdded
local notificationGovernmentChoiceType = NotificationTypes["NOTIFICATION_JFD_GOVERNMENT_CHOICE"]
 function JFD_Sovereignty_NotificationAdded(notification, notificationType)
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	if notificationType == notificationGovernmentChoiceType then
		if (not activePlayer:IsCanChangeGovernment()) then
			LuaEvents.UI_ClearNotification("GovernmentChoice")
		end
	end
end
Events.NotificationAdded.Add(JFD_Sovereignty_NotificationAdded)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_LoadScreenClose
 function JFD_Sovereignty_LoadScreenClose()
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	if activePlayer:IsCanChangeGovernment() then 
		LuaEvents.JFD_Sovereignty_UI_BlockEndTurnButton(true, activePlayerID)
	end
	LuaEvents.UI_DoUpdateOverviewButtons()
	Events.OpenInfoCorner( InfoCornerID.Civilization );
end
Events.LoadScreenClose.Add(JFD_Sovereignty_LoadScreenClose)
----------------------------------------------------------------------------------------------------------------------------
--UpdateCivilizationStateDescription
local function JFD_Sovereignty_GovernmentEstablished(playerID, governmentID, oldGovernmentID)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	if (not player:IsAlive()) then return end
	
	player:UpdateLeaderName(governmentID)
	player:UpdateCivilizationStateDescription(governmentID)
end
LuaEvents.JFD_GovernmentEstablished.Add(JFD_Sovereignty_GovernmentEstablished)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_PlayerCityFounded
local function JFD_Sovereignty_PlayerCityFounded(playerID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	
	local city = g_MapGetPlot(plotX, plotY):GetPlotCity()
	if (not city:IsCapital()) then return end
	
	if player:IsMinorCiv() then 
		player:SetHasGovernment(governmentPolisID, true)
	else
		player:SetHasGovernment(governmentTribeID, true)
	end
end
GameEvents.PlayerCityFounded.Add(JFD_Sovereignty_PlayerCityFounded)
----------------------------------------------------------------------------------------------------------------------------
--g_Policies_BonusUnitHPPerTurn_Table
local g_Policies_BonusUnitHPPerTurn_Table = {}
local g_Policies_BonusUnitHPPerTurn_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE BonusUnitHPPerTurn <> 0;") do 	
	g_Policies_BonusUnitHPPerTurn_Table[g_Policies_BonusUnitHPPerTurn_Count] = row
	g_Policies_BonusUnitHPPerTurn_Count = g_Policies_BonusUnitHPPerTurn_Count + 1
end

--g_Policies_BonusInquisitorMoves_Table
local g_Policies_BonusInquisitorMoves_Table = {}
local g_Policies_BonusInquisitorMoves_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE BonusInquisitorMoves <> 0;") do 	
	g_Policies_BonusInquisitorMoves_Table[g_Policies_BonusInquisitorMoves_Count] = row
	g_Policies_BonusInquisitorMoves_Count = g_Policies_BonusInquisitorMoves_Count + 1
end

--g_Policies_BonusMissMoves_Table
local g_Policies_BonusMissMoves_Table = {}
local g_Policies_BonusMissMoves_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE BonusMissForeignMoves <> 0 OR BonusMissDomesticMoves <> 0;") do 	
	g_Policies_BonusMissMoves_Table[g_Policies_BonusMissMoves_Count] = row
	g_Policies_BonusMissMoves_Count = g_Policies_BonusMissMoves_Count + 1
end

--g_Policies_RouteMovementBonus_Table
local g_Policies_RouteMovementBonus_Table = {}
local g_Policies_RouteMovementBonus_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE RouteMovementBonus <> 0;") do 	
	g_Policies_RouteMovementBonus_Table[g_Policies_RouteMovementBonus_Count] = row
	g_Policies_RouteMovementBonus_Count = g_Policies_RouteMovementBonus_Count + 1
end

--JFD_Sovereignty_PlayerDoTurn
local factionMandateID = GameInfoTypes["FACTION_JFD_IMPERIAL_MANDATE"]
local notificationPolicy = NotificationTypes["NOTIFICATION_POLICY"]
function JFD_Sovereignty_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	if (not player:IsAlive()) then return end

	local playerCapital = player:GetCapitalCity()
	if (not playerCapital) then return end

	--GOVERNMENT
	if player:IsHasGovernment() then
		local governmentID = player:GetCurrentGovernment()
		--GOVERNMENT COOLDOWN
		if (not Player.HasGovernment) then
			player:ChangeCurrentGovernmentCooldown(-1)
		end	

		--CHANGING GOVERNMENT
		if player:IsInRevolution() and (not player:IsHuman()) then
			player:InitiateGovernmentChangeConsideration(governmentID)
		end
		
		--REVOLUTIONARIES
		if (not player:IsAnarchy()) then
			if player:IsInRevolution() then
				player:DoEndRevolution()
			end
		end
	end

	--REFORMS
	--g_JFD_Reform_DummyBuildings_Table
	local reformsTable = g_JFD_Reform_DummyBuildings_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = GameInfoTypes[row.ReformType]
		if player:HasReform(reformID) then
			if row.IsOnlyCapital then
				local buildingID = GameInfoTypes[row.BuildingType]
				if (not playerCapital:IsHasBuilding(buildingID)) then
					playerCapital:SetNumRealBuilding(buildingID, 1, true)
				end
			else
				for city in player:Cities() do
					local buildingID = GameInfoTypes[row.BuildingType]
					if (not city:IsHasBuilding(buildingID)) then
						city:SetNumRealBuilding(buildingID, 1, true)
					end
				end
			end
		end
	end

	--POLICIES
	--g_Policies_BonusUnitHPPerTurn_Table
	local policiesTable = g_Policies_BonusUnitHPPerTurn_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			for unit in player:Units() do	
				unit:ChangeDamage(-row.BonusUnitHPPerTurn)
			end
		end
	end

	--g_Policies_BonusInquisitorMoves_Table
	local policiesTable = g_Policies_BonusInquisitorMoves_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			for unit in player:Units() do	
				if unit:GetUnitClassType() == unitClassInquisitorID then
					unit:ChangeMoves(row.BonusInquisitorMoves*60)
				end
			end
		end
	end

	--g_Policies_BonusMissMoves_Table
	local policiesTable = g_Policies_BonusMissMoves_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			for unit in player:Units() do	
				if unit:GetUnitClassType() == unitClassMissionaryID then
					local plot = unit:GetPlot()
					if plot and plot:GetOwner() == playerID then
						unit:ChangeMoves(row.BonusMissDomesticMoves*60)
					else
						unit:ChangeMoves(row.BonusMissForeignMoves*60)
					end
				end
			end
		end
	end

	--g_Policies_RouteMovementBonus_Table
	local policiesTable = g_Policies_RouteMovementBonus_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			for unit in player:Units() do	
				local plot = unit:GetPlot()
				if (plot and plot:GetOwner() == playerID) and (not plot:IsCity()) then
					if (plot:IsRoute() and (not plot:IsRoutePillaged())) then
						unit:ChangeMoves(row.RouteMovementBonus*60)
					end
				end
			end
		end
	end

	--SOVEREIGNTY
	if (not player:IsHuman()) then return end
	if (not player:IsTurnActive()) then return end
	player:UpdateCurrentSovereignty()

	--REFORM SUB BRANCH COOLDOWN
	--g_JFD_ReformSubBranches_Table
	local reformSubBranchesTable = g_JFD_ReformSubBranches_Table
	local numReformSubBranches = #reformSubBranchesTable
	for index = 1, numReformSubBranches do
		local row = reformSubBranchesTable[index]
		local reformSubBranchType = row.Type
		if player:GetCurrentReformCooldown(reformSubBranchType) > 0 then
			player:ChangeCurrentReformCooldown(reformSubBranchType, -1)
		end
	end

	--POLICY FIX
	if (not Player.GrantPolicy) then
		if player:GetJONSCulture() >= player:GetNextPolicyCost() then
			player:AddNotification(notificationPolicy, g_ConvertTextKey("TXT_KEY_CHOOSE_POLICY"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_SUMMARY_ENOUGH_CULTURE_FOR_POLICY"), -1, -1)
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Sovereignty_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
--g_Technologies_InternationalTradeRoutesChange_Table
local g_Technologies_InternationalTradeRoutesChange_Table = {}
for row in DB.Query("SELECT ID FROM Technologies WHERE InternationalTradeRoutesChange == 1;") do 	
	g_Technologies_InternationalTradeRoutesChange_Table[row.ID] = true
end

--g_Technologies_JFD_MiscEffects_Table
local g_Technologies_JFD_MiscEffects_Table = {}
for row in DB.Query("SELECT TechType FROM Technologies_JFD_MiscEffects WHERE UnlockQuery == 'AllowGovernments';") do 	
	g_Technologies_JFD_MiscEffects_Table[GameInfoTypes[row.TechType]] = true
end

--JFD_Sovereignty_TechResearched
function JFD_Sovereignty_TechResearched(teamID, techID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	
	if g_Technologies_InternationalTradeRoutesChange_Table[techID] then
		if GameInfo.JFD_Governments[player:GetCurrentGovernment()].BonusReformCapacityPerTradeTech then
			player:ChangeFreeReformCapacity(1)
		end
	end
	
	if player:IsHasGovernment() then return end
	if g_Technologies_JFD_MiscEffects_Table[techID] then
		player:InitiateGovernmentChoice(nil, true)
	end
end
GameEvents.TeamTechResearched.Add(JFD_Sovereignty_TechResearched)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_TeamSetEra
function JFD_Sovereignty_TeamSetEra(teamID, eraID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	player:ChangeFreeReformCapacity((eraID+1)+2)
	
	--SHOGUNATE
	local governmentID = player:GetCurrentGovernment()
	if GameInfo.JFD_Governments[governmentID].IsLegislatureOnlyEraReset then
		player:ResetLegislature(governmentID)
	end
end
GameEvents.TeamSetEra.Add(JFD_Sovereignty_TeamSetEra)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_ReformCapacityExpanded
function JFD_Sovereignty_ReformCapacityExpanded(playerID, newReformCapacity)
	local player = Players[playerID]
	if newReformCapacity < 0 then return end
	if (not player:IsAlive()) then return end
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end
	if (not player:IsHasGovernment()) then return end
	if player:IsHuman() then 
		Events.AudioPlay2DSound("AS2D_SOUND_JFD_REFORM_PASSABLE")
		player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_REFORM", g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_REFORM_CAPACITY_EXPANDS_TEXT"), g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_REFORM_CAPACITY_EXPANDS_SHORT_TEXT"), false, -1, -1)
	else
		local isUnder, numReformSlots = player:IsUnderReformCapacity()
		for index = 1, numReformSlots do
			local reformID = Player_GetReformToPass(playerID)
			if reformID then
				print(Game.GetGameTurn() .. " " .. player:GetName() .. " passed a reform: " .. g_ConvertTextKey(GameInfo.JFD_Reforms[reformID].ShortDescription) .. " (" .. g_ConvertTextKey(GameInfo.JFD_Reforms[reformID].ReformSubBranchDescription) .. ")")
				player:SetHasReform(reformID, false, true)
			end
		end
		player:UpdateCurrentSovereignty()
	end
end
LuaEvents.JFD_ReformCapacityExpanded.Add(JFD_Sovereignty_ReformCapacityExpanded)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_IdeologyAdopted
function JFD_Sovereignty_IdeologyAdopted(playerID, newIdeologyID)
	local player = Players[playerID]
	if (not player:IsHuman()) then 
		if player:IsHasGovernment() then
			--CHANGING GOVERNMENT
			local governmentID = player:GetCurrentGovernment()
			local government = GameInfo.JFD_Governments[governmentID]
			if (not government.IsUnique) then
				player:InitiateGovernmentChangeConsideration(governmentID, false, true)
			end
		end
	end
end
GameEvents.IdeologyAdopted.Add(JFD_Sovereignty_IdeologyAdopted)
GameEvents.IdeologySwitched.Add(JFD_Sovereignty_IdeologySwitched)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_ReligionFounded
function JFD_Sovereignty_ReligionFounded(playerID, newIdeologyID)
	local player = Players[playerID]
	if (not player:IsHuman()) then 
		if player:IsHasGovernment() then
			--CHANGING GOVERNMENT
			local governmentID = player:GetCurrentGovernment()
			local government = GameInfo.JFD_Governments[governmentID]
			if (not government.IsUnique) then
				player:InitiateGovernmentChangeConsideration(governmentID, true)
			end
		end
	end
end
GameEvents.ReligionFounded.Add(JFD_Sovereignty_ReligionFounded)
----------------------------------------------------------------------------------------------------------------------------
--g_Buildings_FoundsGovernment_Table
local g_Buildings_FoundsGovernment_Table = {}
for row in DB.Query("SELECT ID FROM Buildings WHERE FoundsGovernment IS NOT NULL;") do 	
	g_Buildings_FoundsGovernment_Table[row.ID] = true
end

--g_Buildings_NumBonusReformCapacity_Table
local g_Buildings_NumBonusReformCapacity_Table = {}
for row in DB.Query("SELECT ID FROM Buildings WHERE NumBonusReformCapacity > 0;") do 	
	g_Buildings_NumBonusReformCapacity_Table[row.ID] = true
end

--g_Buildings_UnlocksGovernment_Table
local g_Buildings_UnlocksGovernment_Table = {}
for row in DB.Query("SELECT ID FROM Buildings WHERE UnlocksGovernment = 1;") do 	
	g_Buildings_UnlocksGovernment_Table[row.ID] = true
end

--JFD_Sovereignty_CityConstructed
local function JFD_Sovereignty_CityConstructed(playerID, cityID, buildingID)
	local player = Players[playerID]
	local building = GameInfo.Buildings[buildingID]
	
	--BONUS REFORM CAPACITY
	if g_Buildings_NumBonusReformCapacity_Table[buildingID] then
		player:ChangeFreeReformCapacity(building.NumBonusReformCapacity)
	end
	
	--FOUNDS GOVERNMENT
	if (not player:IsHuman()) then
		if g_Buildings_FoundsGovernment_Table[buildingID] then
			local governmentID = GameInfoTypes[building.FoundsGovernment]
			player:InitiateGovernmentChoice(governmentID, true)
		end
	end
	
	--UNLOCKS GOVERNMENT
	if g_Buildings_UnlocksGovernment_Table[buildingID] then
		player:InitiateGovernmentChoice(nil, true)
	end

end
GameEvents.CityConstructed.Add(JFD_Sovereignty_CityConstructed)
----------------------------------------------------------------------------------------------------------------------------
--g_Buildings_GovernmentType_Table
local g_Buildings_GovernmentType_Table = {}
for row in DB.Query("SELECT ID, GovernmentType FROM Buildings WHERE GovernmentType IS NOT NULL;") do 
	g_Buildings_GovernmentType_Table[row.ID] = row.GovernmentType
end

--JFD_Sovereignty_PlayerCanConstruct
local function JFD_Sovereignty_PlayerCanConstruct(playerID, buildingID)
	local player = Players[playerID]
	
	--REQUIRES GOVERNMENT
	local reqGovernment = g_Buildings_GovernmentType_Table[buildingID]
	if reqGovernment then
		return (player:GetCurrentGovernment() == GameInfoTypes[reqGovernment])
	end

	return true
end
GameEvents.PlayerCanConstruct.Add(JFD_Sovereignty_PlayerCanConstruct)
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Table
local g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Table = {}
local g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reform_FreePromotions WHERE AddOnFaithPurchase = 1;") do 	
	g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Table[g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Count] = row
	g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Count = g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Count + 1
end

--g_JFD_Reform_FreePromotions_AddOnUnitTrain_Table
local g_JFD_Reform_FreePromotions_AddOnUnitTrain_Table = {}
local g_JFD_Reform_FreePromotions_AddOnUnitTrain_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reform_FreePromotions WHERE AddOnUnitTrain = 1;") do 	
	g_JFD_Reform_FreePromotions_AddOnUnitTrain_Table[g_JFD_Reform_FreePromotions_AddOnUnitTrain_Count] = row
	g_JFD_Reform_FreePromotions_AddOnUnitTrain_Count = g_JFD_Reform_FreePromotions_AddOnUnitTrain_Count + 1
end

--g_Policies_BonusUnitTrainedMoves_Table
local g_Policies_BonusUnitTrainedMoves_Table = {}
local g_Policies_BonusUnitTrainedMoves_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE BonusUnitTrainedMoves <> 0;") do 	
	g_Policies_BonusUnitTrainedMoves_Table[g_Policies_BonusUnitTrainedMoves_Count] = row
	g_Policies_BonusUnitTrainedMoves_Count = g_Policies_BonusUnitTrainedMoves_Count + 1
end

--JFD_Sovereignty_CityTrained
local function JFD_Sovereignty_CityTrained(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	
	if unit:IsCombatUnit() then
		--g_Policies_BonusUnitTrainedMoves_Table
		local policiesTable = g_Policies_BonusUnitTrainedMoves_Table
		local numPolicies = #policiesTable
		for index = 1, numPolicies do
			local row = policiesTable[index]
			local policyID = row.ID
			if player:HasPolicy(policyID) then
				unit:ChangeMoves(row.BonusUnitTrainedMoves*60)
			end
		end
	end
	
	--g_JFD_Reform_FreePromotions_AddOnUnitTrain_Table
	local reformsTable = g_JFD_Reform_FreePromotions_AddOnUnitTrain_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = GameInfoTypes[row.ReformType]
		if player:HasReform(reformID) then
			local thisUnitClassID = GameInfoTypes[row.UnitClassType]
			if unitClassID and unit:GetUnitClassType() == unitClassID then
				local promotionID = GameInfoTypes[row.PromotionType]
				if (not unit:IsHasPromotion(promotionID)) then
					unit:SetHasPromotion(promotionID, true)
				end
			end
			if (not unitClassID) and unit:IsCombatUnit() then
				local promotionID = GameInfoTypes[row.PromotionType]
				if (not unit:IsHasPromotion(promotionID)) then
					unit:SetHasPromotion(promotionID, true)
				end
			end
		end
	end

	if isFaith then
		--g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Table
		local reformsTable = g_JFD_Reform_FreePromotions_AddOnFaithPurchase_Table
		local numReforms = #reformsTable
		for index = 1, numReforms do
			local row = reformsTable[index]
			local reformID = GameInfoTypes[row.ReformType]
			if player:HasReform(reformID) then
				local thisUnitClassID = GameInfoTypes[row.UnitClassType]
				if unitClassID and unit:GetUnitClassType() == unitClassID then
					local promotionID = GameInfoTypes[row.PromotionType]
					if (not unit:IsHasPromotion(promotionID)) then
						unit:SetHasPromotion(promotionID, true)
					end
				end
				if (not unitClassID) and unit:IsCombatUnit() then
					local promotionID = GameInfoTypes[row.PromotionType]
					if (not unit:IsHasPromotion(promotionID)) then
						unit:SetHasPromotion(promotionID, true)
					end
				end
			end
		end
	end

end
GameEvents.CityTrained.Add(JFD_Sovereignty_CityTrained)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_ReformCooldownChanges
-- function JFD_Sovereignty_ReformCooldownChanges(playerID, cooldown)
	-- local player = Players[playerID]
	-- if player:IsMinorCiv() then return end
	-- if player:IsBarbarian() then return end
	-- if (not player:IsAlive()) then return end
	-- if (not player:IsHasGovernment()) then return end

	-- if cooldown ~= 0 then return end

	-- if player:IsHuman() then 
		-- Events.AudioPlay2DSound("AS2D_SOUND_JFD_REFORM_PASSABLE")
		-- player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_REFORM", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REFORM_COOLDOWN_ENDS_TEXT"), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_REFORM_COOLDOWN_ENDS_SHORT_TEXT"), false, -1, -1)
	-- else
		-- local numFreeReforms = (player:GetNumFreeReforms()+1)
		-- for index = 1, numFreeReforms do
			-- local reformID = Player_GetReformToPass(playerID)
			-- if reformID then
				-- print(Game.GetGameTurn() .. " " .. player:GetName() .. " passed a reform: " .. g_ConvertTextKey(GameInfo.JFD_Reforms[reformID].ShortDescription) .. " (" .. g_ConvertTextKey(GameInfo.JFD_Reforms[reformID].ReformSubBranchDescription) .. ")")
				-- player:SetHasReform(reformID, (numFreeReforms > 1), true)
			-- end
		-- end
	-- end
	-- player:UpdateCurrentSovereignty()
-- end
-- if Player.HasGovernment then
	-- GameEvents.ReformCooldownChanges.Add(JFD_Sovereignty_ReformCooldownChanges)
-- else
	-- LuaEvents.JFD_ReformCooldownChanges.Add(JFD_Sovereignty_ReformCooldownChanges)
-- end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_GovernmentCooldownChanges
function JFD_Sovereignty_GovernmentCooldownChanges(playerID, cooldown)
	local player = Players[playerID]
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end
	if (not player:IsAlive()) then return end
	
	if cooldown == 5 then
		if player:IsHuman() and player:IsTurnActive() then
			Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_NEUTRAL");
			player:SendNotification("NOTIFICATION_JFD_GOVERNMENT_LEGISLATURE", g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_GOVERNMENT_COOLDOWN_ENDS_IMMINENT_TEXT", cooldown), g_ConvertTextKey("TXT_KEY_JFD_NOTIFICATION_GOVERNMENT_COOLDOWN_ENDS_IMMINENT_SHORT_TEXT"), false, -1, -1)
		end
	elseif cooldown == 0 then
		player:UpdateCurrentSovereignty()
		player:ResetLegislature(player:GetCurrentGovernment())
	end
end
if Player.HasGovernment then
	GameEvents.GovernmentCooldownChanges.Add(JFD_Sovereignty_GovernmentCooldownChanges)
else
	LuaEvents.JFD_GovernmentCooldownChanges.Add(JFD_Sovereignty_GovernmentCooldownChanges)
end
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Government_StateTitles_ReformType_Table
local g_JFD_Government_StateTitles_ReformType_Table = {}
for row in DB.Query("SELECT ReformType FROM JFD_Government_Titles WHERE ReformType IS NOT NULL AND TitleState IS NOT NULL ORDER BY Priority;") do 	
	g_JFD_Government_StateTitles_ReformType_Table[GameInfoTypes[row.ReformType]] = true
end

--JFD_Sovereignty_ReformPassed
function JFD_Sovereignty_ReformPassed(playerID, reformID)
	local player = Players[playerID]
	local playerCapital = player:GetCapitalCity()

	--g_JFD_Reform_DummyBuildings_Table
	local reformsTable = g_JFD_Reform_DummyBuildings_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local thisReformID = GameInfoTypes[row.ReformType]
		if thisReformID == reformID then
			if row.IsOnlyCapital then
				local buildingID = GameInfoTypes[row.BuildingType]
				if (not playerCapital:IsHasBuilding(buildingID)) then
					playerCapital:SetNumRealBuilding(buildingID, 1, true)
				end
			else
				for city in player:Cities() do
					local buildingID = GameInfoTypes[row.BuildingType]
					if (not city:IsHasBuilding(buildingID)) then
						city:SetNumRealBuilding(buildingID, 1, true)
					end
				end
			end
		end
	end
	
	--g_JFD_Reform_FreePromotions_Table
	local reformsTable = g_JFD_Reform_FreePromotions_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		if row.AddOnPass then
			local thisReformID = GameInfoTypes[row.ReformType]
			if thisReformID == reformID then
				local unitClassID = GameInfoTypes[row.UnitClassType]
				for unit in player:Units() do
					if unitClassID and unit:GetUnitClassType() == unitClassID then
						local promotionID = GameInfoTypes[row.PromotionType]
						if (not unit:IsHasPromotion(promotionID)) then
							unit:SetHasPromotion(promotionID, true)
						end
					end
					if (not unitClassID) and unit:IsCombatUnit() then
						local promotionID = GameInfoTypes[row.PromotionType]
						if (not unit:IsHasPromotion(promotionID)) then
							unit:SetHasPromotion(promotionID, true)
						end
					end
				end
			end
		end
	end

	Player_SetLastReformPassed(playerID, reformID)

end
LuaEvents.JFD_ReformPassed.Add(JFD_Sovereignty_ReformPassed)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_ReformRevoked
function JFD_Sovereignty_ReformRevoked(playerID, reformID)
	local player = Players[playerID]
	
	--g_JFD_Reform_DummyBuildings_Table
	local reformsTable = g_JFD_Reform_DummyBuildings_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local thisReformID = GameInfoTypes[row.ReformType]
		if thisReformID == reformID then
			for city in player:Cities() do
				local buildingID = GameInfoTypes[row.BuildingType]
				if city:IsHasBuilding(buildingID) then
					city:SetNumRealBuilding(buildingID, 0, true)
				end
			end
		end
	end
	
	--g_JFD_Reform_FreePromotions_Table
	local reformsTable = g_JFD_Reform_FreePromotions_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		if row.RemoveOnRevoke then
			local thisReformID = GameInfoTypes[row.ReformType]
			if thisReformID == reformID then
				for unit in player:Units() do
					local promotionID = GameInfoTypes[row.PromotionType]
					if unit:IsHasPromotion(promotionID) then
						unit:SetHasPromotion(promotionID, false)
					end
				end
			end
		end
	end

end
LuaEvents.JFD_ReformRevoked.Add(JFD_Sovereignty_ReformRevoked)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_PlayerAdoptPolicy
function JFD_Sovereignty_PlayerAdoptPolicy(playerID, policyID)
	Player_SetLastPolicyAdopted(playerID, policyID)
end
GameEvents.PlayerAdoptPolicy.Add(JFD_Sovereignty_PlayerAdoptPolicy)
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table
local g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table = {}
local g_JFD_Reform_FreePromotions_AddOnUnitCreate_Count = 1
for row in DB.Query("SELECT * FROM JFD_Reform_FreePromotions WHERE AddOnUnitCreate = 1;") do 	
	g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table[g_JFD_Reform_FreePromotions_AddOnUnitCreate_Count] = row
	g_JFD_Reform_FreePromotions_AddOnUnitCreate_Count = g_JFD_Reform_FreePromotions_AddOnUnitCreate_Count + 1
end

--JFD_Sovereignty_UnitCreated
local function JFD_Sovereignty_UnitCreated(playerID, unitID, unitType, plotX, plotY)
	local player = Players[playerID]
	if player:IsHuman() then return end
	if (not player:IsHasGovernment()) then return end
	
	local unit = player:GetUnitByID(unitID)
	local unitClassID = unit:GetUnitClassType()
	if (not unitClassID) then return end
	local unitClassType = GameInfo.UnitClasses[unitClassID].Type
			
	--g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table
	local reformsTable = g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = GameInfoTypes[row.ReformType]
		if player:HasReform(reformID) then
			local thisUnitClassID = GameInfoTypes[row.UnitClassType]
			if unitClassID and unit:GetUnitClassType() == unitClassID then
				local promotionID = GameInfoTypes[row.PromotionType]
				if (not unit:IsHasPromotion(promotionID)) then
					unit:SetHasPromotion(promotionID, true)
				end
			end
			if (not unitClassID) and unit:IsCombatUnit() then
				local promotionID = GameInfoTypes[row.PromotionType]
				if (not unit:IsHasPromotion(promotionID)) then
					unit:SetHasPromotion(promotionID, true)
				end
			end
		end
	end
	
	if unit:IsGreatPerson() then
		--g_JFD_Councillor_GreatPeople_Table
		local councillorsTable = g_JFD_Councillor_GreatPeople_Table
		local numCouncillors = #councillorsTable
		for index = 1, numCouncillors do
			local row = councillorsTable[index]
			local councillorID = GameInfoTypes[row.CouncillorType]
			if (not player:IsHasCouncillor(councillorID)) then
				if row.UnitClassType == unitClassType then
					local flavourType = row.FlavourType
					local flavourVal = player:GetFlavorValue(flavourType)
					if (flavourVal > 5 and flavourVal >= g_GetRandom(1,10)) then
						player:SetHasCouncillor(unit, unitType, councillorID, unit:GetName(), true)
						break
					end					
				end
			end
		end
	end
end
if g_IsVMCActive then
	GameEvents.UnitCreated.Add(JFD_Sovereignty_UnitCreated)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_SerialEventUnitCreated
local promotionGreatPersonCreatedID = GameInfoTypes["PROMOTION_JFD_GREAT_PERSON_CREATED"]
local function JFD_Sovereignty_SerialEventUnitCreated(playerID, unitID)
    local player = Players[playerID]
	if player:IsHuman() then return end
	if (not player:IsHasGovernment()) then return end
	
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	local unitTypeID = unit:GetUnitType()
	local unitClassID = unit:GetUnitClassType()
	if (not unitClassID) then return end
	local unitClassType = GameInfo.UnitClasses[unitClassID].Type
			
	--g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table
	local reformsTable = g_JFD_Reform_FreePromotions_AddOnUnitCreate_Table
	local numReforms = #reformsTable
	for index = 1, numReforms do
		local row = reformsTable[index]
		local reformID = GameInfoTypes[row.ReformType]
		if player:HasReform(reformID) then
			local thisUnitClassID = GameInfoTypes[row.UnitClassType]
			if unitClassID and unit:GetUnitClassType() == unitClassID then
				local promotionID = GameInfoTypes[row.PromotionType]
				if (not unit:IsHasPromotion(promotionID)) then
					unit:SetHasPromotion(promotionID, true)
				end
			end
			if (not unitClassID) and unit:IsCombatUnit() then
				local promotionID = GameInfoTypes[row.PromotionType]
				if (not unit:IsHasPromotion(promotionID)) then
					unit:SetHasPromotion(promotionID, true)
				end
			end
		end
	end
	
	if unit:IsGreatPerson() and (not unit:IsHasPromotion(promotionGreatPersonCreatedID)) then
		--g_JFD_Councillor_GreatPeople_Table
		local councillorsTable = g_JFD_Councillor_GreatPeople_Table
		local numCouncillors = #councillorsTable
		for index = 1, numCouncillors do
			local row = councillorsTable[index]
			local councillorID = GameInfoTypes[row.CouncillorType]
			if (not player:IsHasCouncillor(councillorID)) then
				if row.UnitClassType == unitClassType then
					local flavourType = row.FlavourType
					local flavourVal = player:GetFlavorValue(flavourType)
					if (flavourVal > 5 and flavourVal >= g_GetRandom(1,10)) then
						player:SetHasCouncillor(unit, unitTypeID, councillorID, unit:GetName(), true)
						break
					end					
				end
			end
		end

		unit:SetHasPromotion(promotionGreatPersonCreatedID, true)
	end
end
if (not g_IsVMCActive) then
	Events.SerialEventUnitCreated.Add(JFD_Sovereignty_SerialEventUnitCreated)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_PlayerAnarchy
local function JFD_Sovereignty_PlayerAnarchy(playerID, isStart, numTurns)
	local player = Players[playerID]
	if isStart then 
		if (not player:IsHuman()) then
			player:InitiateGovernmentChangeConsideration(governmentID)
		end
	else
		if player:IsInRevolution() then
			player:DoEndRevolution()
		end
	end
end
GameEvents.PlayerAnarchy.Add(JFD_Sovereignty_PlayerAnarchy)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_GetScenarioDiploModifier1
local reformPrecedencePowerID = GameInfoTypes["REFORM_JFD_PRECEDENCE_POWER"]
local reformPrecedenceRankID = GameInfoTypes["REFORM_JFD_PRECEDENCE_RANK"]
local function JFD_Sovereignty_GetScenarioDiploModifier1(playerID, otherPlayerID)
	local player = Players[playerID]
	local otherPlayer = Players[otherPlayerID]
	local numDiploMod = 0
	
	if otherPlayer:HasReform(reformPrecedenceRankID) then
		if otherPlayer:GetCurrentGovernment() == player:GetCurrentGovernment() then
			numDiploMod = -20
		else
			numDiploMod = 20
		end
	elseif otherPlayer:HasReform(reformPrecedencePowerID) then
		if otherPlayer:GetNumCities() > player:GetNumCities() then
			numDiploMod = -20
		else
			numDiploMod = 20
		end
	end

	return numDiploMod
end
if (not g_IsVMCActive) then
	GameEvents.GetScenarioDiploModifier1.Add(JFD_Sovereignty_GetScenarioDiploModifier1)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_GetDiploModifier
local diploModBasicBonusID = GameInfoTypes["DIPLOMODIFIER_JFD_PRECEDENCE_BASIC_BONUS"]
local diploModBasicPenaltyID = GameInfoTypes["DIPLOMODIFIER_JFD_PRECEDENCE_BASIC_PENALTY"]
local diploModPowerBonusID = GameInfoTypes["DIPLOMODIFIER_JFD_PRECEDENCE_POWER_BONUS"]
local diploModPowerPenaltyID = GameInfoTypes["DIPLOMODIFIER_JFD_PRECEDENCE_POWER_PENALTY"]
local diploModRankBonusID = GameInfoTypes["DIPLOMODIFIER_JFD_PRECEDENCE_RANK_BONUS"]
local diploModRankPenaltyID = GameInfoTypes["DIPLOMODIFIER_JFD_PRECEDENCE_RANK_PENALTY"]
local function JFD_Sovereignty_GetDiploModifier(diploModifierID, playerID, otherPlayerID)
	local player = Players[playerID]
	local otherPlayer = Players[otherPlayerID]
	local numDiploMod = 0

	if diploModifierID == diploModRankBonusID then
		if otherPlayer:HasReform(reformPrecedenceRankID) then
			if player:GetCurrentGovernment() == otherPlayer:GetCurrentGovernment() then
				numDiploMod = -20
			end
		end
	elseif diploModifierID == diploModRankPenaltyID then
		if otherPlayer:HasReform(reformPrecedenceRankID) then
			if player:GetCurrentGovernment() ~= otherPlayer:GetCurrentGovernment() then
				numDiploMod = 20
			end
		end
	elseif diploModifierID == diploModPowerBonusID then
		if otherPlayer:HasReform(reformPrecedencePowerID) then
			if otherPlayer:GetNumCities() > player:GetNumCities() then
				numDiploMod = -20
			end
		end
	elseif diploModifierID == diploModPowerPenaltyID then
		if otherPlayer:HasReform(reformPrecedencePowerID) then
			if otherPlayer:GetNumCities() < player:GetNumCities() then
				numDiploMod = 20
			end
		end
	end

	return numDiploMod
end
GameEvents.GetDiploModifier.Add(JFD_Sovereignty_GetDiploModifier)
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
--==========================================================================================================================