-- JFD_RTP_Utils
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:10 AM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
include("PlotIterators.lua");
--=======================================================================================================================
-- MOD UTILITIES
--=======================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
if Game then
	--Game_IsModActive
	function Game_IsModActive(modID)
		for _, mod in pairs(Modding.GetActivatedMods()) do
			if mod.ID == modID then
				return true
			end
		end
		return false
	end
	
	--Game.IsCBOActive
	function Game.IsCBOActive()
		return Game_IsModActive("8411a7a8-dad3-4622-a18e-fcc18324c799")
	end

	--Game.IsCIVDiploActive
	function Game.IsCIVDiploActive()
		return (Game_IsModActive("c7bf7064-d1b1-4708-9e93-7a1560868582") or Game_IsModActive("781d81cf-49e1-4acb-ae5f-b9e3713f98d3"))
	end
	
	--Game.IsCPActive
	function Game.IsCPActive()
		return (Game_IsModActive("d1b6328c-ff44-4b0d-aad7-c657f83610cd") and Player.HasStateReligion)
	end

	--Game.IsCyclesOfPowerActive
	function Game.IsCyclesOfPowerActive()
		return Game_IsModActive("fcff0553-e017-4d54-ac55-2082f016b8a7")
	end
	
	--Game.IsCBRTesterActive
	function Game.IsCBRTesterActive()
		return Game_IsModActive("2a742231-30bd-4aa3-a513-39cc1e029940")
	end

	--Game.IsEventsAndDecisionsActive
	function Game.IsEventsAndDecisionsActive()
		return Game_IsModActive("1f941088-b185-4159-865c-472df81247b2")
	end

	--Game_IsFlagsPlusActive
	function Game.IsFlagsPlusActive()
		return Game_IsModActive("e1ccf71a-f248-498c-8f30-5ca6d851079d")
	end

	--Game.IsGreatPhilosophersActive
	function Game.IsGreatPhilosophersActive()
		return Game_IsModActive("0d8117aa-bc83-4530-930e-98a685fde2c9")
	end

	--Game.IsGreatWorksManagerActive
	function Game.IsGreatWorksManagerActive()
		return Game_IsModActive("230546ae-ac6b-4a16-bd25-98c3b402849b")
	end

	--Game.IsInfoAddictActive
	function Game.IsInfoAddictActive()
		return Game_IsModActive("aec5d10d-f00f-4fc7-b330-c3a1e86c91c3")
	end

	--Game.IsMercenariesActive
	function Game.IsMercenariesActive()
		return false
	end

	--Game.IsNationalismActive
	function Game.IsNationalismActive()
		return Game_IsModActive("c3b6e30c-3548-4fbc-9d7f-cf3025be8261")
	end

	--Game.IsRealReligionsActive()
	function Game.IsRealReligionsActive()
		return Game_IsModActive("da1e59f2-7922-4d10-a668-eba6fa96a934")
	end

	--Game.IsRTPTopPanelActive
	function Game.IsRTPTopPanelActive()
		return Game_IsModActive("a8ac71dc-dcd9-4f87-af61-8ae7951ade57")
	end

	--Game.IsSovereigntyActive
	function Game.IsSovereigntyActive()
		return Game_IsModActive("d769cac9-5608-4826-9f7f-2d308b287ea6")
	end

	--Game.IsVMCActive()
	function Game.IsVMCActive()
		return Game_IsModActive("d1b6328c-ff44-4b0d-aad7-c657f83610cd")
	end

	--Game.IsWorkForcesActive()
	function Game.IsWorkForcesActive()
		return Game_IsModActive("f16460a3-aa5d-4384-9b10-ef34ba57ab8a")
	end
end

local g_IsVMCActive = Game.IsVMCActive()
------------------------------------------------------------------------------------------------------------------------
--MATH UTILS
------------------------------------------------------------------------------------------------------------------------
--Game.GetRandom
function Game.GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
local g_GetRandom = Game.GetRandom
------------------------------------------------------------------------------------------------------------------------
--Game.GetRound
function Game.GetRound(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end
local g_GetRound = Game.GetRound
------------------------------------------------------------------------------------------------------------------------
--Game.GetEraAdjustedValue
function Game.GetEraAdjustedValue(playerID, num)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	local eraMod = GameInfo.Eras[currentEraID].ResearchAgreementCost
	return g_GetRound(num * eraMod/100)
end 
------------------------------------------------------------------------------------------------------------------------
--NOTIFICATION UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:SendWorldEvent
local notificationWorldEventID = NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"]
function Player.SendWorldEvent(player, description)
	print("Sending World Event: ", description)
	local activePlayer = Players[Game.GetActivePlayer()]
	local playerTeam = Teams[player:GetTeam()]
	if (not playerTeam:IsHasMet(Game.GetActiveTeam())) then return end
	activePlayer:AddNotification(notificationWorldEventID, description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
end 
-------------------------------------------------------------------------------------------------------------------------
--Player:SendNotification
function Player.SendNotification(player, notificationType, description, descriptionShort, global, data1, data2, unitID, data3, metOnly, includesSerialMessage)
	local notificationID = NotificationTypes[notificationType]
	local teamID = player:GetTeam()
	local data1 = data1 or -1
	local data2 = data2 or -1
	local unitID = unitID or -1
	local data3 = data3 or -1
	if global then
		if (metOnly and Teams[Game.GetActiveTeam()]:IsHasMet(teamID) or (not metOnly)) then
			Players[Game.GetActivePlayer()]:AddNotification(notificationID, description, descriptionShort, data1, data2, unitID, data3)
			if (includesSerialMessage and description) then Events.GameplayAlertMessage(description) end
		end
	else
		if (not player:IsHuman()) then return end
		if (metOnly and Teams[Game.GetActiveTeam()]:IsHasMet(teamID) or (not metOnly)) then
			player:AddNotification(notificationID, description, descriptionShort, data1, data2, unitID, data3)
			if (includesSerialMessage and description) then Events.GameplayAlertMessage(description) end
		end
	end
end  
------------------------------------------------------------------------------------------------------------------------
--CITY UTILS
------------------------------------------------------------------------------------------------------------------------
local defineUnhappinessPerCity = GameDefines["UNHAPPINESS_PER_CITY"]
local defineUnhappinessPerCapturedCity = GameDefines["UNHAPPINESS_PER_CAPTURED_CITY"]
local defineUnhappinessPerPop = GameDefines["UNHAPPINESS_PER_POPULATION"]
local defineUnhappinessPerOccupiedPop = GameDefines["UNHAPPINESS_PER_OCCUPIED_POPULATION"]
--Player:GetCityUnhappiness
function Player.GetCityUnhappiness(player, city)
	local numPop = city:GetPopulation()
	local numUnhappiness = 0

	local numUnhappinessFromCity = defineUnhappinessPerCity
	if city:IsOccupied() then
		numUnhappinessFromCity = defineUnhappinessPerCapturedCity
	end
	if city:IsCapital() then
		local numCapitalUnhappinessMod = player:GetCapitalUnhappinessMod()
		if numCapitalUnhappinessMod ~= 0 then
			numUnhappinessFromCity = numUnhappinessFromCity + ((numUnhappinessFromCity*numCapitalUnhappinessMod)/100)
		end
	end
	local numCityUnhappinessMod = player:GetCityCountUnhappinessMod()
	if numCityUnhappinessMod ~= 0 then
		numUnhappinessFromCity = numUnhappinessFromCity + ((numUnhappinessFromCity*numCityUnhappinessMod)/100)
	end

	local numUnhappinessFromPop = (defineUnhappinessPerPop*numPop)
	if city:IsOccupied() then
		numUnhappinessFromPop = defineUnhappinessPerOccupiedPop
	end
	local numUnhappinessMod = player:GetUnhappinessMod()
	if numUnhappinessMod ~= 0 then
		numUnhappinessFromPop = numUnhappinessFromPop + ((numUnhappinessFromPop*numUnhappinessMod)/100)
	end
	
	numUnhappiness = numUnhappinessFromCity + numUnhappinessFromPop

	return numUnhappiness, numUnhappinessFromCity, numUnhappinessFromPop
end
------------------------------------------------------------------------------------------------------------------------
--LEADER UTILS
------------------------------------------------------------------------------------------------------------------------
--g_Leader_Flavors_Table
local g_Leader_Flavors_Table = {}
local g_Leader_Flavors_Count = 1
for row in DB.Query("SELECT * FROM Leader_Flavors;") do 	
	g_Leader_Flavors_Table[g_Leader_Flavors_Count] = row
	g_Leader_Flavors_Count = g_Leader_Flavors_Count + 1
end

local g_LeaderFlavours_Table = {}
for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
	local otherPlayer = Players[otherPlayerID]
	if otherPlayer:IsAlive() then
		local leaderID = otherPlayer:GetLeaderType()
		local leader = GameInfo.Leaders[leaderID]
		local leaderType = leader.Type
		g_LeaderFlavours_Table[otherPlayerID] = {}
		--g_Leader_Flavors_Table
		local flavorsTable = g_Leader_Flavors_Table
		local numFlavors = #flavorsTable
		for index = 1, numFlavors do
			local row = flavorsTable[index]
			if row.LeaderType == leaderType then
				g_LeaderFlavours_Table[otherPlayerID][row.FlavorType] = row.Flavor
			end
		end
	end
end

--Player:GetFlavorValue
function Player.GetFlavorValue(player, flavorType)
	return g_LeaderFlavours_Table[player:GetID()][flavorType] or 5
end	
------------------------------------------------------------------------------------------------------------------------
--MAP UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetNumTilesDiscovered
function Player.GetNumTilesDiscovered(player, isAll, isOcean)
	local teamID = player:GetTeam()
	local numTiles = 0
	for plotID = 0, Map.GetNumPlots()-1, 1 do
		local plot = Map.GetPlotByIndex(plotID)
		if (plot and plot:IsVisible(teamID)) then
			if isAll then
				numTiles = numTiles + 1
			end
			if (isOcean and plot:IsPlotOcean()) then
				numTiles = numTiles + 1
			end
		end
	end
	return numTiles
end
------------------------------------------------------------------------------------------------------------------------
--PLAYER UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetNumCityStatePartners
function Player.GetNumCityStatePartners(player) 
	local numFriends = 0
	local numAllies = 0

	for otherPlayerID = 0, GameDefines.MAX_MINOR_CIVS - 1 do
		local otherPlayer = Players[otherPlayerID]
		if (otherPlayer:IsAlive() and otherPlayer:IsMinorCiv() and otherPlayer:GetCapitalCity()) then
			if otherPlayer:IsFriends(playerID) then
				numFriends = numFriends + 1
			end
			if otherPlayer:IsAllies(playerID) then
				numFriends = numFriends + 1
			end
		end
	end

	return numFriends, numAllies
end
------------------------------------------------------------------------------------------------------------------------
--Player:GetNumConqueredCities
function Player.GetNumConqueredCities(player, isOnlyOccupied)
	local numCities = 0
	for city in player:Cities() do
		if isOnlyOccupied then
			if city:IsOccupied() then
				numCities = numCities + 1
			end
		else
			if city:GetOriginalOwner() ~= playerID then
				numCities = numCities + 1
			end
		end
	end
	return numCities
end	
------------------------------------------------------------------------------------------------------------------------
--POLICY UTILS
------------------------------------------------------------------------------------------------------------------------
--g_DummyPolicies_Table
local g_DummyPolicies_Table = {}
local g_DummyPolicies_Count = 1
for row in DB.Query("SELECT ID FROM Policies WHERE PolicyBranchType IS NULL AND Type NOT IN (SELECT FreePolicy FROM PolicyBranchTypes WHERE FreePolicy IS NOT NULL) AND Type NOT IN  (SELECT FreePolicy FROM PolicyBranchTypes WHERE FreeFinishingPolicy IS NOT NULL);") do 	
	g_DummyPolicies_Table[g_DummyPolicies_Count] = row
	g_DummyPolicies_Count = g_DummyPolicies_Count + 1
end

--Player:GetNumDummyPolicies
function Player.GetNumDummyPolicies(player) 
	local numDummyPolicies = 0

	--g_DummyPolicies_Table
	local policiesTable = g_DummyPolicies_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			numDummyPolicies = numDummyPolicies + 1
		end
	end

	return numDummyPolicies
end
------------------------------------------------------------------------------------------------------------------------
--Player:GetRealScoreFromPolicies
function Player.GetRealScoreFromPolicies(player) 
	local numDummiesScore = (player:GetNumDummyPolicies()*4)
	local numPoliciesScore = player:GetScoreFromPolicies()
	local numDummyPoliciesScore = (player:GetScoreFromPolicies()-numDummiesScore)
	return numDummyPoliciesScore, numPoliciesScore
end	
------------------------------------------------------------------------------------------------------------------------
--g_Policies_Table
local g_Policies_Table = {}
local g_Policies_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE PolicyBranchType IS NOT NULL;") do 	
	g_Policies_Table[g_Policies_Count] = row
	g_Policies_Count = g_Policies_Count + 1
end

--Player:GetNumPoliciesUnlockedInBranch
function Player.GetNumPoliciesUnlockedInBranch(player, policyBranchType) 
	if (not GameInfoTypes[policyBranchType]) then
		return 0
	end

	local numPoliciesUnlocked = 0
	local policyBranchID = GameInfoTypes[policyBranchType]

	if player:IsPolicyBranchFinished(policyBranchID) then
		numPoliciesUnlocked = numPoliciesUnlocked + 1
	end
	if player:IsPolicyBranchUnlocked(policyBranchID) then
		numPoliciesUnlocked = numPoliciesUnlocked + 1
	end

	--g_Policies_Table
	local policiesTable = g_Policies_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		if (row.PolicyBranchType == policyBranchType) then
			local policyID = row.ID
			if player:HasPolicy(policyID) then
				numPoliciesUnlocked = numPoliciesUnlocked + 1
			end
		end
	end

	return numPoliciesUnlocked
end
------------------------------------------------------------------------------------------------------------------------
--g_Tenets_Table
local g_Tenets_Table = {}
local g_Tenets_Count = 1
for row in DB.Query("SELECT * FROM Policies WHERE PolicyBranchType IS NOT NULL AND Level > 0;") do 	
	g_Tenets_Table[g_Tenets_Count] = row
	g_Tenets_Count = g_Tenets_Count + 1
end

--Player:GetNumIdeologicalTenets
function Player.GetNumIdeologicalTenets(player)
	local numTenets = 0
	
	--g_Tenets_Table
	local policiesTable = g_Tenets_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			numTenets = numTenets + 1
		end
	end
 
	return numTenets
end
------------------------------------------------------------------------------------------------------------------------
--Player:GetIdeology
local ideologySpiritID = GameInfoTypes["POLICY_BRANCH_JFD_SPIRIT"]
function Player.GetIdeology(player, notSpirit)
	local ideologyID = player:GetLateGamePolicyTree()
	if (notSpirit) then
		return ideologyID
	else
		if ideologySpiritID and player:IsPolicyBranchUnlocked(ideologySpiritID) then
			return ideologySpiritID
		else
			return ideologyID
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
--RELIGION UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetMainReligion
function Player.GetMainReligion(player, ignorePantheon)
	local mainReligionID = player:GetReligionCreatedByPlayer()
	if Player.GetCurrentStateReligion then
		mainReligionID = player:GetCurrentStateReligion()
	else
		if mainReligionID == -1 then
			local playerCapital = player:GetCapitalCity()
			if playerCapital then
				mainReligionID = playerCapital:GetReligiousMajority()
			end
		end
	end
	if mainReligionID == -1 and (not ignorePantheon) then
		mainReligionID = 0
	end
	return mainReligionID
end
------------------------------------------------------------------------------------------------------------------------
--g_Religions_Table
local g_Religions_Table = {}
local g_Religions_Count = 1
for row in DB.Query("SELECT ID FROM Religions WHERE ID > 0;") do 	
	g_Religions_Table[g_Religions_Count] = row.ID
	g_Religions_Count = g_Religions_Count + 1
end

--Player:GetNumTotalFollowers
function Player.GetNumTotalFollowers(player, religionID)
	local numFollowers = 0
	local numNotFollowers = 0
	local numNoneFollowers = 0
	if player:IsAlive() then
		for city in player:Cities() do
			local numPopulation = city:GetPopulation()
			numNoneFollowers = numPopulation
			
			local numThisFollowers = city:GetNumFollowers(religionID)
			numFollowers = numFollowers + numThisFollowers
			numNoneFollowers = numNoneFollowers - numThisFollowers

			--g_Religions_Table
			local religionsTable = g_Religions_Table
			local numReligions = #religionsTable
			for index = 1, numReligions do
				local ID = religionsTable[index]
				if ID ~= religionID then
					local numThatFollowers = city:GetNumFollowers(ID)
					numNotFollowers = numNotFollowers + numThatFollowers
					numNoneFollowers = numNoneFollowers - numThatFollowers
				end
			end
			
			if numNoneFollowers < 0 then numNoneFollowers = 0 end
		end
	end	
	return numFollowers, numNotFollowers, numNoneFollowers
end
------------------------------------------------------------------------------------------------------------------------
--SPECIALIST UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetCityHasAnySpecialist
function Player.GetCityHasAnySpecialist(player, city)
	return (player:GetTotalSpecialistCount(nil, city) > 0)
end
------------------------------------------------------------------------------------------------------------------------
--g_Specialists_Table
local g_Specialists_Table = {}
local g_Specialists_Count = 1
for row in DB.Query("SELECT ID FROM Specialists WHERE ID > 0;") do 	
	g_Specialists_Table[g_Specialists_Count] = row.ID
	g_Specialists_Count = g_Specialists_Count + 1
end

--Player:GetTotalSpecialistCount
function Player.GetTotalSpecialistCount(player, specialistID, city)
	local numSpecialist = 0
	if specialistID then
		if city then
			numSpecialist = numSpecialist + city:GetSpecialistCount(specialistID)
		else
			for city in player:Cities() do
				numSpecialist = numSpecialist + city:GetSpecialistCount(specialistID)
			end	
		end	
	else
		if city then
			--g_Specialists_Table
			local specialistsTable = g_Specialists_Table
			local numSpecialists = #specialistsTable
			for index = 1, numSpecialists do
				local ID = specialistsTable[index]
				numSpecialist = numSpecialist + city:GetSpecialistCount(ID)
			end
		else
			for city in player:Cities() do
				--g_Specialists_Table
				local specialistsTable = g_Specialists_Table
				local numSpecialists = #specialistsTable
				for index = 1, numSpecialists do
					local ID = specialistsTable[index]
					numSpecialist = numSpecialist + city:GetSpecialistCount(ID)
				end
			end	
		end	
	end	
	return numSpecialist
end
------------------------------------------------------------------------------------------------------------------------
--TECH UTILS
------------------------------------------------------------------------------------------------------------------------
--g_Technologies_MiscEffects_Table
local g_Technologies_MiscEffects_Table = {}
local g_Technologies_MiscEffects_Count = 1
for row in DB.Query("SELECT * FROM Technologies_JFD_MiscEffects;") do 	
	g_Technologies_MiscEffects_Table[g_Technologies_MiscEffects_Count] = row
	g_Technologies_MiscEffects_Count = g_Technologies_MiscEffects_Count + 1
end

--Player:HasTechnologyRequiredForUnlock
function Player.HasTechnologyRequiredForUnlock(player, unlockQuery)
	local playerTeam = Teams[player:GetTeam()]
	
	--g_Technologies_MiscEffects_Table
	local techsTable = g_Technologies_MiscEffects_Table
	local numTechs = #techsTable
	for index = 1, numTechs do
		local row = techsTable[index]
		if row.UnlockQuery == unlockQuery then
			local techID = GameInfoTypes[row.TechType]
			if g_IsVMCActive then
				return player:HasTech(techID)
			else
				return playerTeam:GetTeamTechs():HasTech(techID)
			end
		end
	end

	return false
end
------------------------------------------------------------------------------------------------------------------------
--TEXT UTILS
------------------------------------------------------------------------------------------------------------------------
local g_DefaultLeaderNames_Table = {}
for otherPlayerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
	local otherPlayer = Players[otherPlayerID]
	if otherPlayer:IsAlive() then
		local leaderID = otherPlayer:GetLeaderType()
		local leader = GameInfo.Leaders[leaderID]
		local leaderDesc = leader.Description
		g_DefaultLeaderNames_Table[otherPlayerID] = leaderDesc
	end
end

--Player:GetDefaultName
function Player.GetDefaultName(player)
	local strDefaultName = g_DefaultLeaderNames_Table[player:GetID()]
	if (not strDefaultName) then
		strDefaultName = GameInfo.Leaders[player:GetLeaderType()].Description
	end
	return strDefaultName
end
------------------------------------------------------------------------------------------------------------------------
--g_Language_en_US_Feminine_Table
local g_Language_en_US_Plurality_Table = {}
for row in DB.Query("SELECT Tag, Plurality FROM Language_en_US WHERE Plurality = '2'") do 	
	g_Language_en_US_Plurality_Table[row.Tag] = true
end

--Player:IsCivilizationPlural
function Player.IsCivilizationPlural(player)
	local civID = player:GetCivilizationType()
	local civDesc = GameInfo.Civilizations[civID].Description
	return g_Language_en_US_Plurality_Table[civDesc]
end
------------------------------------------------------------------------------------------------------------------------
--g_Language_en_US_Feminine_Table
local g_Language_en_US_Feminine_Table = {}
for row in DB.Query("SELECT Tag, Gender FROM Language_en_US WHERE Gender = 'feminine'") do 	
	g_Language_en_US_Feminine_Table[row.Tag] = true
end

--Player:IsLeaderFeminine
function Player.IsLeaderFeminine(player)
	local leaderID = player:GetLeaderType()
	local leaderDesc = GameInfo.Leaders[leaderID].Description
	return g_Language_en_US_Feminine_Table[leaderDesc] or false
end
------------------------------------------------------------------------------------------------------------------------
--g_Language_en_US_HistoricalPrimeMinisters_Table
local g_Language_en_US_HistoricalPrimeMinisters_Table = {}
local g_Language_en_US_HistoricalPrimeMinisters_Count = 1
for row in DB.Query("SELECT Tag, Text FROM Language_en_US WHERE Tag LIKE '%TITLES%' AND Text LIKE '%Chancellor%'") do 	
	g_Language_en_US_HistoricalPrimeMinisters_Table[g_Language_en_US_HistoricalPrimeMinisters_Count] = row
	g_Language_en_US_HistoricalPrimeMinisters_Count = g_Language_en_US_HistoricalPrimeMinisters_Count + 1
end
for row in DB.Query("SELECT Tag, Text FROM Language_en_US WHERE Tag LIKE '%TITLES%' AND Text LIKE '%Prime Minister%'") do 	
	g_Language_en_US_HistoricalPrimeMinisters_Table[g_Language_en_US_HistoricalPrimeMinisters_Count] = row
	g_Language_en_US_HistoricalPrimeMinisters_Count = g_Language_en_US_HistoricalPrimeMinisters_Count + 1
end

--Player:IsHistoricalPrimeMinister
function Player.IsHistoricalPrimeMinister(player)
	local leaderID = player:GetLeaderType()
	local leaderTag = GameInfo.Leaders[leaderID].CivilopediaTag
	local leaderTitle = leaderTag .. "_TITLES"
	--g_Language_en_US_HistoricalPrimeMinisters_Table
	local textsTable = g_Language_en_US_HistoricalPrimeMinisters_Table
	local numTexts = #textsTable
	for index = 1, numTexts do
		local row = textsTable[index]
		if row.Tag == (leaderTitle .. "_" .. tostring(1)) 
		or row.Tag == (leaderTitle .. "_" .. tostring(2))
		or row.Tag == (leaderTitle .. "_" .. tostring(3)) then
			return true
		end
	end	
	return false
end
------------------------------------------------------------------------------------------------------------------------
--g_Language_en_US_HistoricalRegents_Table
local g_Language_en_US_HistoricalRegents_Table = {}
local g_Language_en_US_HistoricalRegents_Count = 1
for row in DB.Query("SELECT Tag, Text FROM Language_en_US WHERE Tag LIKE '%TITLES%' AND Text LIKE '%Regent%'") do 	
	g_Language_en_US_HistoricalRegents_Table[g_Language_en_US_HistoricalRegents_Count] = row
	g_Language_en_US_HistoricalRegents_Count = g_Language_en_US_HistoricalRegents_Count + 1
end

--Player:IsHistoricalRegent
function Player.IsHistoricalRegent(player)
	local leaderID = player:GetLeaderType()
	local leaderTag = GameInfo.Leaders[leaderID].CivilopediaTag
	local leaderTitle = leaderTag .. "_TITLES"
	--g_Language_en_US_HistoricalRegents_Table
	local textsTable = g_Language_en_US_HistoricalRegents_Table
	local numTexts = #textsTable
	for index = 1, numTexts do
		local row = textsTable[index]
		if row.Tag == (leaderTitle .. "_" .. tostring(1)) 
		or row.Tag == (leaderTitle .. "_" .. tostring(2))
		or row.Tag == (leaderTitle .. "_" .. tostring(3)) then
			return true
		end
	end	
	return false
end
------------------------------------------------------------------------------------------------------------------------
--Game:ChangeBaseGameText
function Game.ChangeBaseGameText(tagQuery, newText)
	local tquery = {"UPDATE Language_en_US SET Text = '".. newText .."' WHERE Tag = '" .. tagQuery .. "'"}
	for i, iQuery in pairs(tquery) do
		for result in DB.Query(iQuery) do
		end
	end
	Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
end
------------------------------------------------------------------------------------------------------------------------
--UNIQUES UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetUniqueBuilding
function Player.GetUniqueBuilding(player, buildingClass)
	local buildingType = nil
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
 
	for uniqueBuilding in GameInfo.Civilization_BuildingClassOverrides{CivilizationType = civType, BuildingClassType = buildingClass} do
		buildingType = uniqueBuilding.BuildingType
		break
	end
 
	if (not buildingType) then
		buildingType = GameInfo.BuildingClasses[buildingClass].DefaultBuilding
	end
 
	return buildingType
end
--------------------------------------------------------------------------------------------------------------------------
--Player:GetUniqueUnit
function Player.GetUniqueUnit(player, unitClass)
	local unitType = nil
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
 
	for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
		unitType = uniqueUnit.UnitType
		break
	end
 
	if (not unitType) then
		unitType = GameInfo.UnitClasses[unitClass].DefaultUnit
	end
 
	return unitType
end
------------------------------------------------------------------------------------------------------------------------
--UNIT UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetNumUnitCombatType
function Player.GetNumUnitCombatType(player, unitCombatID)
	local numUnits = 0
	for unit in player:Units() do
		if (unit:IsCombatUnit() and unit:GetUnitCombatType() == unitCombatID) then
			numUnits = numUnits + 1
		end
	end
	return numUnits
end
------------------------------------------------------------------------------------------------------------------------
--Player:GetNumUnitDomainType
function Player.GetNumUnitDomainType(player, domainID)
	local numUnits = 0
	for unit in player:Units() do
		if (unit:IsCombatUnit() and unit:GetDomainType() == domainID) then
			numUnits = numUnits + 1
		end
	end
	return numUnits
end
------------------------------------------------------------------------------------------------------------------------
-- YIELD UTILS
------------------------------------------------------------------------------------------------------------------------
--Player:GetCityLowestYield
function Player.GetCityLowestYield(player, city, yieldsTable)
	local lowestYieldID = nil
	local numLowestYield = 0
	
	local numYields = #yieldsTable
	for index = 1, numYields do
		local yieldID = yieldsTable[index]
		local numYield = city:GetYieldRate(yieldID)
		if numYield > numLowestYield then
			lowestYieldID = yieldID
			numLowestYield = numYield 
		end
	end

	return lowestYieldID
end
--------------------------------------------------------------------------------------------------------------------------
--Player:GetHighestYield
function Player.GetHighestYield(player, city)
	local highestYieldID = 0
	local highestYield = 0
	for row in GameInfo.Yields("IsFake = 0") do
		local yieldID = row.ID
		if city then
			if city:GetYieldRate(row.ID) > highestYield then
				highestYieldID = yieldID
				highestYield = city:GetYieldRate(yieldID)
			end
		elseif player:CalculateTotalYield(yieldID) > highestYield then
			highestYieldID = yieldID
			highestYield = player:CalculateTotalYield(yieldID)
		end
	end
	return highestYieldID, highestYield
end
--------------------------------------------------------------------------------------------------------------------------
--Player:GetStoredYield
local yieldCultureID  = GameInfoTypes["YIELD_CULTURE"]
local yieldFaithID	  = GameInfoTypes["YIELD_FAITH"]
local yieldGoldID	  = GameInfoTypes["YIELD_GOLD"]
local yieldGoldenAgeProgressID = GameInfoTypes["YIELD_GOLDEN_AGE_POINTS"]
function Player.GetStoredYield(player, yieldID)
	local yield = 0
	if yieldID == yieldCultureID then
		yield = player:GetJONSCulture()
	elseif yieldID == yieldFaithID then
		yield = player:GetFaith()
	elseif yieldID == yieldGoldID then
		yield = player:GetGold()
	elseif yieldGoldenAgeProgressID and yieldID == yieldGoldenAgeProgressID then
		yield = player:GetGoldenAgeProgressMeter()
	end
	return yield
end
--------------------------------------------------------------------------------------------------------------------------
--Player:GetTotalYieldRate
function Player.GetTotalYieldRate(player, yieldID)
	local totalYield = 0
	for city in player:Cities() do
		totalYield = totalYield + city:GetYieldRate(yieldID)
	end	
	return totalYield
end
--==========================================================================================================================
--==========================================================================================================================