include("MC_JerusalemKnightlyOrders.lua")

--[[local tKnightlyOrders = {}

for row in GameInfo.KnightlyOrders() do
	table.insert(tKnightlyOrders, {
	["ID"] = row.Type,
	["Dummy"] = GameInfoTypes[row.Dummy],
	["Building"] = GameInfoTypes[row.Building],
	["Unit"] = GameInfoTypes[row.Unit],
	["Promotion"] = GameInfoTypes[row.Promotion],
	["Policy"] = GameInfoTypes[row.Policy]})
end]]

--======================================================================================
-- Function: Dummy tech to block order units at game start
-- By: LeeS
--======================================================================================
local iDummyFreeTech = GameInfoTypes.TECH_MC_JERUSALEM_ORDERS
local iTriggertech = GameInfoTypes.TECH_CHIVALRY
local iCivilization = GameInfoTypes.CIVILIZATION_MC_JERUSALEM

function GiveTechWithoutPopup(pPlayer, iTech)
    local pTeam = Teams[pPlayer:GetTeam()]
    if pTeam:IsHasTech(iTech) then return end
    local bIsActivePlayer = (pPlayer:GetID() == Game:GetActivePlayer())

    --Temporarily disable reward popups if they are on.
    local bNoRewardPopups = OptionsManager.IsNoRewardPopups_Cached()
    if bIsActivePlayer and not bNoRewardPopups then
        OptionsManager.SetNoRewardPopups_Cached(true)
        OptionsManager.CommitGameOptions();
    end

    pTeam:SetHasTech(iTech, true)

    if bIsActivePlayer and not bNoRewardPopups then
        OptionsManager.SetNoRewardPopups_Cached(false)
        OptionsManager.CommitGameOptions();
    end
end
function OnNotificationAdded( Id, nType, toolTip, strSummary, iGameValue, iExtraGameData, ePlayer )
    if nType == NotificationTypes.NOTIFICATION_TECH_AWARD and (iExtraGameData == iDummyFreeTech) then
        UI.RemoveNotification( Id )
    end
end
Events.NotificationAdded.Add(OnNotificationAdded)
function TeamResearchedATech(iTeam, iTech, iChange)
    if iTech == iTriggertech then
        for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
            local pPlayer = Players[iPlayer]
            if (pPlayer ~= nil) then
                if (pPlayer:GetTeam() == iTeam) and pPlayer:IsAlive() and (pPlayer:GetCivilizationType() == iCivilization) then
                    GiveTechWithoutPopup(pPlayer, iDummyFreeTech)
                end
            end
        end
    end
end
GameEvents.TeamTechResearched.Add(TeamResearchedATech)


------------------------------------------------------------------------------------------------------------------
-- Restrict Units
------------------------------------------------------------------------------------------------------------------
local iDummyCrusader = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER
local tBannedUnits = {}
for iKey, tTable in ipairs(tKnightlyOrders) do
    tBannedUnits[tTable.Unit] = tTable.Dummy
end


function JerusalemUnitRestrictions(iPlayer, iCity, iUnit)

    if iDummyCrusader == iUnit then return false end
    if not(tBannedUnits[iUnit]) then return true end

    local pPlayer = Players[iPlayer]
    local pCity = pPlayer:GetCityByID(iCity)

    if pCity:IsHasBuilding(tBannedUnits[iUnit]) then return true end

    return false
end

GameEvents.CityCanTrain.Add(JerusalemUnitRestrictions)

------------------------------------------------------------------------------------------------------------------
-- Restrict Buildings
------------------------------------------------------------------------------------------------------------------
local tBannedBuildings = {}
local iDummyChapter = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE

for iKey, tTable in ipairs(tKnightlyOrders) do
    tBannedBuildings[tTable.Building] = tTable.Dummy
end

function JerusalemBuildingRestrictions(iPlayer, iCity, iBuilding)

    if iDummyChapter == iBuilding then return false end
    if not(tBannedBuildings[iBuilding]) then return true end

    local pPlayer = Players[iPlayer]
    local pCity = pPlayer:GetCityByID(iCity)

    if pCity:IsHasBuilding(tBannedBuildings[iBuilding]) then return true end


    return false
end

GameEvents.CityCanConstruct.Add(JerusalemBuildingRestrictions)

--============================================================================================
-- Utils
----------------------------------------------------------------------------------------------

function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end

include("PlotIterators.lua")

--============================================================================================

local civilisationID 				= GameInfoTypes["CIVILIZATION_MC_JERUSALEM"]
local activePlayerID 				= Game.GetActivePlayer()
local activePlayer 					= Players[activePlayerID]
local activePlayerTeam 				= Teams[Game.GetActiveTeam()]
local isJerusalemCivActive 			= JFD_IsCivilisationActive(civilisationID)
local isJerusalemActivePlayer 		= activePlayer:GetCivilizationType() == civilisationID

local iLazarusFreshWater			= GameInfoTypes["FEATURE_MC_JERUSALEM_LAZARUS_WATER"] -- Copy stuff from Tom's Garamantes - it's weird
local iHSCombatBonus				= GameInfoTypes["PROMOTION_SEPULCHRE_COMBAT_BONUS"] -- Just a combat bonus
local iHospitallierScienceBonus		= 2 -- Whatever you want the science bonus to be; I'd add level scaling in too
local iTemplarFaithGold				= GameInfoTypes["BUILDING_MC_JERUSALEM_TEMPLAR_FAITHGOLD"] -- Yields faith and gold
local iLazarusFaithDummy			= GameInfoTypes["BUILDING_MC_JERUSALEM_LAZARUS_FAITH"] -- Yields Faith
local iLazarusFaithYield			= 1 -- Whatever you want the faith yield to be; level scaling is cool
local iUACombatBonus				= GameInfoTypes["PROMOTION_UA_COMBAT_BONUS"]
local iHospitallerCombatBonus		= GameInfoTypes["PROMOTION_MC_JERUSALEM_HOSPITALLER_RELIGIOUS"]
local iCooldownCounter 				= GameInfoTypes["BUILDING_MC_JERUSALEM_COOLDOWN_COUNTER"]
local iDummyPolicy 					= GameInfoTypes["POLICY_MC_JERUSALEM_CRUSADER"] -- DUMMY POLICY
local iCrusaderTech					= GameInfoTypes[GameInfo.Units["UNIT_MC_JERUSALEM_CRUSADER"].PrereqTech]

local iLazarusOrderDummy = 0
local iHospitallierPromotion = 0
local iTemplarOrderDummy = 0
local iHSPromotion = 0
local iLazarusPromotion = 0

for k, v in ipairs(tKnightlyOrders) do
	if v.ID == "Lazarus" then
		iLazarusOrderDummy = v.Dummy
		iLazarusPromotion = v.Promotion
	elseif v.ID == "Hospitaller" then
		iHospitallierPromotion = v.Promotion
	elseif v.ID == "Sepulchre" then
		iHSPromotion = v.Promotion
	elseif v.ID == "Templar" then
		iTemplarOrderDummy = v.Dummy
	end
end

--============================================================================================
-- Functions
----------------------------------------------------------------------------------------------

function GetPlayerMajorityReligion(pPlayer) -- Sukri
	local iMajorityReligion = nil
	for row in GameInfo.Religions() do
		local iReligion = row.ID
		if pPlayer:HasReligionInMostCities(iReligion) then
			iMajorityReligion = iReligion
			break
		end
	end
	return iMajorityReligion
end

function C15_GetPlayerReligion(pPlayer)
	if HasStateReligion then
		if pPlayer:HasStateReligion() then
			return pPlayer:GetStateReligion()
		end
	end
	if pPlayer:HasCreatedReligion() then
		return pPlayer:GetReligionCreatedByPlayer()
	else
		return GetPlayerMajorityReligion(pPlayer)
	end
end

function C15_Jersualem_DecrementCounter(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iCooldownCounter) then
				pCity:SetNumRealBuilding(iCooldownCounter, (pCity:GetNumRealBuilding(iCooldownCounter)) - 1)
			end
		end
	end
end

if isJerusalemCivActive then
	GameEvents.PlayerDoTurn.Add(C15_Jersualem_DecrementCounter)
	print("Counter Decrementer Added")
end

function C15_Jerusalem_GiveDummyPolicy(iTeam, iTech)
	if iTech == iCrusaderTech then
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local pPlayer = Players[i]
			if pPlayer then
				if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID and pPlayer:GetTeam() == iTeam then
					print("Give Policy")
					if GrantPolicy then
						pPlayer:GrantPolicy(iDummyPolicy, true)
					else
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
						pPlayer:SetHasPolicy(iDummyPolicy, true)
					end
				end
			end
		end
	end
end

if isJerusalemCivActive then
	GameEvents.TeamTechResearched.Add(C15_Jerusalem_GiveDummyPolicy)
	print("Dummy Policy Giver Added")
end

-- Order-specific
---------------------------------------

-- LazarusWater
function C15_Jerusalem_LazarusWater(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() then
		for pCity in pPlayer:Cities() do
			local pPlot = pCity:Plot()
			if pPlayer:GetCivilizationType() ~= civilisationID or not pCity:IsHasBuilding(iLazarusOrderDummy) then
				if pPlot:GetFeatureType() == iLazarusFreshWater then
					pPlot:SetFeatureType(-1)
				end
			elseif pPlayer:GetCivilizationType() == civilisationID and pCity:IsHasBuilding(iLazarusOrderDummy) then
				if pPlot:GetFeatureType() ~= iLazarusFreshWater then
					pPlot:SetFeatureType(iLazarusFreshWater)
				end
			end
		end
	end
end

if isJerusalemCivActive then
	GameEvents.PlayerDoTurn.Add(C15_Jerusalem_LazarusWater)
	print("Lazarus Water Added")
end

-- HospitallierUnitScience
function C15_Jerusalem_HospitallierUnitScience(playerID)
	local pPlayer = Players[playerID]
	local pTeam = Teams[pPlayer:GetTeam()]
	if pPlayer:IsAlive() then
		local iScience = 0
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iHospitallierPromotion) then
				local pPlot = pUnit:GetPlot()
				if pTeam:IsAtWar(pPlot:GetOwner():GetTeam()) then
					iScience = iScience + iHospitallierScienceBonus
				end
			end
		end
		if iScience > 0 then
			pTeam:GetTeamTechs():ChangeResearchProgress(pPlayer:GetCurrentResearch(), iScience, playerID)
			if pPlayer:IsHuman() then
				local sGoldenAgeMessage = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_HOSPITALLIER_SCIENCE", iScience)
				Events.GameplayAlertMessage(sGoldenAgeMessage)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_Jerusalem_HospitallierUnitScience)

-- TemplarTradeRouteBonuses
function C15_Jerusalem_TemplarTradeRouteBonuses(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID then
		local tToAdd = {}
		for k, datatable in pairs(pPlayer:GetTradeRoutesToYou()) do
			if datatable.FromID ~= playerID and datatable.ToCity:IsHasBuilding(iTemplarOrderDummy) then
				if tToAdd[datatable.ToCity] then
					tToAdd[datatable.ToCity] = (tToAdd[datatable.ToCity] + 1)
				else
					tToAdd[datatable.ToCity] = 1
				end
			end
		end
		for k, v in pairs(tToAdd) do
			k:SetNumRealBuilding(iTemplarFaithGold, v)
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_Jerusalem_TemplarTradeRouteBonuses)

-- SepulchreFriendlyCityBonus (and the UA too)

function C15_Jerusalem_IsWithinRangeOfCity(playerID, pPlot, iReligion)
	local bHS, bReligion = false, false
	--print("playerID = ", playerID, "pPlot = ", pPlot)
    for pAdjPlot in PlotAreaSpiralIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		--print("Iterating")
		if pAdjPlot:IsCity() then
			--print("IsCity")
			if pAdjPlot:GetPlotCity():GetOwner() == playerID then
				--print("bHS should be true")
				bHS = true
				if pAdjPlot:GetPlotCity():GetReligiousMajority() == iReligion then
					--print("bReligion should be true")
					bReligion = true
				end
			end
		end
	end
	--print(bHS, bReligion)
	return bHS, bReligion
end

function C15_Jerusalem_SepulchreFriendlyCityBonus(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID then
		local iReligion = C15_GetPlayerReligion(pPlayer)
		--print("iReligion = ", iReligion)
		for pUnit in pPlayer:Units() do
			local bHS, bReligion = C15_Jerusalem_IsWithinRangeOfCity(playerID, pUnit:GetPlot(), iReligion)
			pUnit:SetHasPromotion(iUACombatBonus, bReligion)
			if pUnit:IsHasPromotion(iHSPromotion) then
				pUnit:SetHasPromotion(iHSCombatBonus, bHS)
			end
		end
	end
end

if isJerusalemCivActive then
	GameEvents.PlayerDoTurn.Add(C15_Jerusalem_SepulchreFriendlyCityBonus)
end

function C15_Jerusalem_SepulchreFriendlyCityBonusSetXY(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == civilisationID then
		C15_Jerusalem_SepulchreFriendlyCityBonus(playerID)
	end
end

if isJerusalemCivActive then
	GameEvents.UnitSetXY.Add(C15_Jerusalem_SepulchreFriendlyCityBonusSetXY)
end

function C15_Jerusalem_IsNearForeignReligion(pPlayer, pPlot, iReligion)
	for pAdjPlot in PlotAreaSpiralIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if pAdjPlot:IsCity() and Teams[Players[pAdjPlot:GetOwner()]:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
			local pCity = pAdjPlot:GetPlotCity()
			if pCity:GetReligiousMajority() ~= iReligion then
				return true
			end
		end
	end
	return false
end

function C15_Jerusalem_NearForeignReligionBonus(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == civilisationID then
		local pPlot, iReligion, pUnit = Map.GetPlot(iX, iY), C15_GetPlayerReligion(pPlayer), pPlayer:GetUnitByID(unitID)
		pUnit:SetHasPromotion(iUACombatBonus, C15_Jerusalem_IsNearForeignReligion(pPlayer, pPlot, iReligion)) -- This is meant to be an OR setup, right?
	end
end

if isJerusalemCivActive then
	GameEvents.UnitSetXY.Add(C15_Jerusalem_NearForeignReligionBonus)
end

-- LazarusCityGarrison
function C15_Jerusalem_LazarusCityGarrison(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID then
		for pCity in pPlayer:Cities() do
			if pCity:GetGarrisonedUnit() ~= nil then
				if pCity:GetGarrisonedUnit():IsHasPromotion(iLazarusPromotion) then
					pCity:SetNumRealBuilding(iLazarusFaithDummy, iLazarusFaithYield)
				else
					pCity:SetNumRealBuilding(iLazarusFaithDummy, 0)
				end
			else
				pCity:SetNumRealBuilding(iLazarusFaithDummy, 0)
			end
		end
	end
end

if isJerusalemCivActive then
	GameEvents.PlayerDoTurn.Add(C15_Jerusalem_LazarusCityGarrison)
	GameEvents.UnitPromoted.Add(C15_Jerusalem_LazarusCityGarrison)
end

function C15_Jerusalem_LazarusCityGarrisonSetXY(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID then
		local pUnit = pPlayer:GetUnitByID(unitID)
		if pUnit:IsCombatUnit() and pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
			if pUnit:IsHasPromotion(iLazarusPromotion) then
				if iX < 0 or iY < 0 then
					C15_Jerusalem_LazarusCityGarrison(playerID)
				else
					local pPlot = Map.GetPlot(iX, iY)
					if pPlot:IsCity() then
						local pCity = pPlot:GetPlotCity()
						if pCity:GetOwner() == playerID then
							pCity:SetNumRealBuilding(iLazarusFaithDummy, iLazarusFaithYield)
						end
					else
						for pAdjPlot in PlotRingIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE) do
							if pAdjPlot:IsCity() then
								if pAdjPlot:GetPlotCity():GetGarrisonedUnit() == nil or (not pAdjPlot:GetPlotCity():GetGarrisonedUnit():IsHasPromotion(iLazarusPromotion)) then
									pAdjPlot:GetPlotCity():SetNumRealBuilding(iLazarusFaithDummy, 0)
								end
							end
						end
					end
				end
			end
		end
	end
end

if isJerusalemCivActive then
	GameEvents.UnitSetXY.Add(C15_Jerusalem_LazarusCityGarrisonSetXY)
end

function C15_Jersualem_IsNearReligousUnit(playerID, pPlot)
    for pAdjPlot in PlotAreaSpiralIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		if pAdjPlot:IsUnit() then
			for i = 0, pAdjPlot:GetNumUnits() - 1 do
				local pUnit = pAdjPlot:GetUnit(i)
				if pUnit:GetOwner() == playerID and pUnit:GetConversionStrength() > -1 then
					return true
				end
			end
		end
	end
	return false
end

function C15_Jerusalem_Hospitaller_NearMissionaryBonus(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilisationID then
		local pUnit = pPlayer:GetUnitByID(unitID)
		if pUnit:IsHasPromotion(iHospitallierPromotion) then
			pUnit:SetHasPromotion(iHospitallerCombatBonus, C15_Jersualem_IsNearReligousUnit(playerID, pPlot))
		end
	end
end

if isJerusalemCivActive then
	GameEvents.UnitSetXY.Add(C15_Jerusalem_Hospitaller_NearMissionaryBonus)
end
