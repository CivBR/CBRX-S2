-- Lua Script1
-- Author: pedro
-- DateCreated: 09/17/16 9:15:35 AM
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "TeutonFunctions";
include("IconSupport")
include("FLuaVector.lua")

local teutonID = GameInfoTypes.CIVILIZATION_UC_TEUTONS

--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

local isTeutonCivActive	= JFD_IsCivilisationActive(teutonID)

-- JFD_IsUsingPiety
function JFD_IsUsingPiety()
	local pietyModID = "eea66053-7579-481a-bb8d-2f3959b59974"
	local isUsingPiety = false
	for _, mod in pairs(Modding.GetActivatedMods()) do
	  if (mod.ID == pietyModID) then
	    isUsingPiety = true
	    break
	  end
	end
	return isUsingPiety
end
local isUsingPietyPrestige = JFD_IsUsingPiety()

if isUsingPietyPrestige then
   include("JFD_PietyUtils.lua")
end

function TeutonPolicyStart(player)
	for iPlayer=0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer]
		if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_UC_TEUTONS"] and player:IsAlive() then
			if not player:HasPolicy(GameInfoTypes["POLICY_UC_TEUTON"]) then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(GameInfoTypes["POLICY_UC_TEUTON"], true)	
			end
			if isUsingPietyPrestige then
			player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_OFF, true)
			end
		end
	end
end
Events.SequenceGameInitComplete.Add(TeutonPolicyStart)

function TeutonPolicies(playerID, policyID)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == teutonID) then
		if policyID == GameInfoTypes.POLICY_THEOCRACY then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(GameInfoTypes.POLICY_UC_TEUTON_THEOCRACY, true)
	else
		if policyID == GameInfoTypes.POLICY_REFORMATION then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(GameInfoTypes.POLICY_UC_TEUTON_FINISH, true)
	else
		if policyID == GameInfoTypes.POLICY_NEW_DEAL then
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(GameInfoTypes.POLICY_UC_TEUTON_NEW_DEAL, true)
				end
			end
        end
    end
end
if isTeutonCivActive then
GameEvents.PlayerAdoptPolicy.Add(TeutonPolicies)
end

local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)

function OrdensburgBuilt(playerID, cityID, buildingID, isGold, isFaith)
local player = Players[playerID]
local city = player:GetCityByID(cityID)
if player:IsAlive() and player:GetCivilizationType() == teutonID then 
	if buildingID == GameInfoTypes.BUILDING_UC_ORDENSBURG or buildingID == GameInfoTypes.BUILDING_ALHAMBRA or buildingID == GameInfoTypes.BUILDING_HIMEJI_CASTLE then
		local religionID = player:GetReligionCreatedByPlayer() or player:GetCapitalCity():GetReligiousMajority()
		if isUsingPietyPrestige then religionID = JFD_GetStateReligion(playerID) end
			if city:GetReligiousMajority() == religionID then
				city:SetNumRealBuilding(GameInfoTypes.BUILDING_UC_ORDER_MIL, 1)
			else
			local numHeathens = 0
				for row in GameInfo.Religions("ID > '0' AND ID <> '" .. religionID .. "'") do
				if city:GetNumFollowers(row.ID) > 0 then
				numHeathens = numHeathens + city:GetNumFollowers(row.ID)
				player:ChangeFaith(numHeathens * 10)
				city:AdoptReligionFully(religionID)
			if player:IsHuman() then
				local converts = numHeathens * 10
				local alertmessage = Locale.ConvertTextKey("TXT_KEY_UC_TEUTON_CONVERT", converts, city:GetName())
				Events.GameplayAlertMessage(alertmessage)
						end
					end
				end
			end	
		end
		if isFaith then
		local cost = city:GetBuildingFaithPurchaseCost(buildingID)
		local engineerBoost = math.ceil(cost * .15 * iMod)
			local previousHonor = load(player, "TeutonHonor")
			if previousHonor == nil then
				previousHonor = 0
			end
		honor = (engineerBoost) + previousHonor
		save(player, "TeutonHonor", honor)
		TeutonHonorCheck(player)
		print("You got " .. honor .. ".")
		end
	end
end
if isTeutonCivActive then
GameEvents.CityConstructed.Add(OrdensburgBuilt)
end

function RitterbruderPromotion(playerID)
local player = Players[playerID]
	if (player:IsAlive() and (not player:IsBarbarian())) then	
		for unit in player:Units() do
			if unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_1) then
				local plot = unit:GetPlot()
					if plot then
					local ownerID = plot:GetOwner()
					local owner = Players[ownerID]
					if ownerID > - 1 then
					local religionID = player:GetReligionCreatedByPlayer() or player:GetCapitalCity():GetReligiousMajority()
					if isUsingPietyPrestige then religionID = JFD_GetStateReligion(playerID) end
					local otherID = owner:GetReligionCreatedByPlayer() or owner:GetCapitalCity():GetReligiousMajority()
					if isUsingPietyPrestige then otherID = JFD_GetStateReligion(ownerID) end
						if ownerID ~= playerID and otherID ~= religionID then
							if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2) then
							unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2, true)
								end
							else
							if unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2) then
							unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2, false)
							end
						end
					else
					if unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2) then
							unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2, false)
					end
				end
				else
				if unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2) then
							unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_2, false)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(RitterbruderPromotion)


function RitterbruderListenSEUSD(playerId, unitId, newDamage, oldDamage)
	if not isUsingPietyPrestige then return end
    if newDamage > oldDamage then
        local pPlayer = Players[playerId]
        for pUnit in pPlayer:Units() do
            if pUnit:GetID() == unitId then --if the unit is null, it died. WHich is what we want.
                --we only want this to trigger on not-dead enemies
                --to find and reset UC_TEUTON_PIETY_ATTACK to UC_TEUTON_PIETY so that RitterbruderListenPT never triggers.
                if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY_ATTACK) then -- this is a possible target
                    local pPlot = pUnit:GetPlot()
                    for i = 0, 5 do
                        local pAdj = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                        if pAdj ~= nil then
                            if pAdj:GetNumUnits() > 0 then
                                for i = 0, pAdj:GetNumUnits() - 1 do
                                    local pSH = pAdj:GetUnit(i)
									local strength = math.max(pUnit:GetBaseRangedCombatStrength(), pUnit:GetBaseCombatStrength())
									local pSHOwner = pSH:GetOwner()
									local guy = Players[pSHOwner]
                                    if pSH:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY_ATTACK) then
                                        pSH:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY_ATTACK, false)
                                        pSH:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY, true)
											end
										end
                                    end
                                end
                            end
                        end
                    end
                end
            end
    return --this event expects a return, so it perfoms better if you give it one
end
Events.SerialEventUnitSetDamage.Add(RitterbruderListenSEUSD)

function RitterbruderListenPT(playerId) -- all else has failed, we'll do this on the next turn
if not isUsingPietyPrestige then return end
    local pPlayer = Players[playerId]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_UC_TEUTONS then
        for pUnit in pPlayer:Units() do
            if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY_ATTACK) then -- unit killed someone
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY_ATTACK, false)
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_TEUTON_PIETY, true)
                if pPlayer:HasStateReligion() then
										local pietyReward = 5
									if pietyReward > 0 then
										pPlayer:ChangePiety(pietyReward)
									if pPlayer:IsHuman() then
										local plotX = pUnit:GetX()
										local plotY = pUnit:GetY()
										local hex = ToHexFromGrid(Vector2(plotX, plotY))
										Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_JFD_PIETY]+{1_Num}[ENDCOLOR] [ICON_JFD_PIETY]", pietyReward), true)
						end
					end
                end
            end
        end
    end
    return --this event expects a return, so it perfoms better if you give it one
end
GameEvents.PlayerDoTurn.Add(RitterbruderListenPT)

local pietyLevelDevoutID = GameInfoTypes["PIETY_LEVEL_JFD_DEVOUT"]
local pietyLevelVirtuousID = GameInfoTypes["PIETY_LEVEL_JFD_VIRTUOUS"]
local pietyLevelNormalID = GameInfoTypes["PIETY_LEVEL_JFD_NORMAL"]
function TeutonPietyGenerals(playerID)
	if not isUsingPietyPrestige then return end
	local player = Players[playerID]
	if (player and player:GetCivilizationType() == teutonID) then
		if JFD_GetPietyLevelID(playerID) == pietyLevelDevoutID then
			if not player:HasPolicy(GameInfoTypes.POLICY_UC_TEUTON_DEVOUT) then
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_DEVOUT, true)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_VIRTUOUS, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_NORMAL, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_OFF, false)
				print("devout")
			end
		elseif JFD_GetPietyLevelID(playerID) == pietyLevelVirtuousID then
			if not player:HasPolicy(GameInfoTypes.POLICY_UC_TEUTON_VIRTUOUS) then
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_DEVOUT, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_VIRTUOUS, true)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_NORMAL, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_OFF, false)
				print("virtuous")
			end
		elseif JFD_GetPietyLevelID(playerID) == pietyLevelNormalID then
			if not player:HasPolicy(GameInfoTypes.POLICY_UC_TEUTON_NORMAL) then
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_DEVOUT, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_VIRTUOUS, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_NORMAL, true)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_OFF, false)
				print("normal")
			end
		elseif not player:HasPolicy(GameInfoTypes.POLICY_UC_TEUTON_OFF) then
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_DEVOUT, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_VIRTUOUS, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_NORMAL, false)
				player:GrantPolicy(GameInfoTypes.POLICY_UC_TEUTON_OFF, true)
		end
	end
end
if isTeutonCivActive then
	GameEvents.PlayerDoTurn.Add(TeutonPietyGenerals)
end

function TeutonPurchaseUnit(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if player:IsAlive() and player:GetCivilizationType() == teutonID then 
	if isFaith then
	local unitThing = GameInfo.Units[unitID]
	local cost = unitThing.FaithCost
		local previousHonor = load(player, "TeutonHonor")
			if previousHonor == nil then
				previousHonor = 0
			end
		honor = (math.ceil(cost * .15 * iMod)) + previousHonor
		save(player, "TeutonHonor", honor)
		print("You got " .. honor .. ".")
		TeutonHonorCheck(player)		
		end
	end	
end
if isTeutonCivActive then
GameEvents.CityTrained.Add(TeutonPurchaseUnit)
end

function TeutonHonorCheck(player)
	local honor = load(player, "TeutonHonor")
	local capital = player:GetCapitalCity()
		if not capital:IsHasBuilding(GameInfoTypes.BUILDING_UC_ORDER) then
	capital:SetNumRealBuilding(GameInfoTypes.BUILDING_UC_ORDER, 1)
		end
	if honor >= 300 and not player:HasPolicy(GameInfoTypes.POLICY_PROFESSIONAL_ARMY) then
	player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes.POLICY_PROFESSIONAL_ARMY, true)
	elseif honor >= 250 and not player:HasPolicy(GameInfoTypes.POLICY_MILITARY_CASTE) then
	player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes.POLICY_MILITARY_CASTE, true)
	elseif honor >= 200 and not player:HasPolicy(GameInfoTypes.POLICY_MILITARY_TRADITION) then
	player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes.POLICY_MILITARY_TRADITION, true)
	elseif honor >= 150 and not player:HasPolicy(GameInfoTypes.POLICY_DISCIPLINE) then
	player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes.POLICY_DISCIPLINE, true)
	elseif honor >= 100 and not player:HasPolicy(GameInfoTypes.POLICY_WARRIOR_CODE) then
	player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes.POLICY_WARRIOR_CODE, true)
	elseif honor >= 50 and not(player:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"])) then
	player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
					player:SetPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"], 1)	
							end
						end
	
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID		= Game.GetActivePlayer()
local activePlayer			= Players[activePlayerID]
local activePlayerTeam		= Teams[Game.GetActiveTeam()]
local isTeutonActivePlayer = activePlayer:GetCivilizationType() == teutonID
----------------------------------------------------------------------------------------------------------------------------
-- PESILAT
----------------------------------------------------------------------------------------------------------------------------
local isCityViewOpen = false

local Armory = GameInfoTypes.BUILDING_ARMORY
local MilAcad = GameInfoTypes.BUILDING_MILITARY_ACADEMY
local Barracks = GameInfoTypes.BUILDING_BARRACKS
-- TeutonXPBuy
function TeutonXPBuy()
    Controls.UnitBackground:SetHide(true)
    Controls.UnitImage:SetHide(true)
    Controls.UnitButton:SetHide(true)
    Controls.UnitButton:LocalizeAndSetToolTip(nil)
    local pCity = UI.GetHeadSelectedCity()
    --print("pCity = ", pCity)
    if pCity and pCity:GetOwner() == activePlayerID then

        local bDisabled = true
		if pCity:IsHasBuilding(Armory) then building = MilAcad
		elseif pCity:IsHasBuilding(Barracks) then building = Armory
		else building = Barracks
			end
        local buildingThing = GameInfo.Buildings[building]
        local buildingDesc = buildingThing.Description
		if building == MilAcad then tech = GameInfoTypes.TECH_MILITARY_SCIENCE
		elseif building == Armory then tech = GameInfoTypes.TECH_STEEL
		else tech = GameInfoTypes.TECH_BRONZE_WORKING
			end
        local iFaith = math.ceil(buildingThing.Cost * .8 * iMod)
        local buttonText = Locale.ConvertTextKey("TXT_KEY_TEUTON_PURCHASE", buildingDesc, iFaith)
        local buttonToolTip = Locale.ConvertTextKey("TXT_KEY_TEUTON_PURCHASE_TT", buildingDesc, iFaith)
        if activePlayer:GetFaith() < iFaith or not activePlayerTeam:IsHasTech(tech) or pCity:IsHasBuilding(MilAcad) then
            buttonText = Locale.ConvertTextKey("TXT_KEY_TEUTON_PURCHASE_DISABLED", buildingDesc, iFaith)
            buttonToolTip = Locale.ConvertTextKey("TXT_KEY_TEUTON_PURCHASE_DISABLED_TT", buildingDesc, iFaith)
        else
            bDisabled = false
        end
        --print("bDisabled = ", bDisabled)
        --print("isCityViewOpen = ", isCityViewOpen)
        IconHookup(buildingThing.PortraitIndex, 64, buildingThing.IconAtlas, Controls.UnitImage)
        Controls.UnitBackground:SetHide(false)
        Controls.UnitImage:SetHide(false)
        Controls.UnitButton:SetHide(false)
        Controls.UnitButton:SetText(buttonText)
        Controls.UnitButton:SetToolTipString(buttonToolTip)
        Controls.UnitButton:SetDisabled(bDisabled)
		end
    end

-- TeutonXPBuyRecruit
function TeutonXPBuyRecruit()
	local city = UI.GetHeadSelectedCity();
	if city then
		if city:IsHasBuilding(Armory) then building = MilAcad
		elseif city:IsHasBuilding(Barracks) then building = Armory
		else building = Barracks
			end
		local buildingThing = GameInfo.Buildings[building]
		local faithCost = math.ceil(buildingThing.Cost * .75)
		city:SetNumRealBuilding(building, 1)
		activePlayer:ChangeFaith(-faithCost)
		local previousHonor = load(activePlayer, "TeutonHonor")
			if previousHonor == nil then
				previousHonor = 0
			end
		honor = (math.ceil(faithCost * .15)) + previousHonor
		save(activePlayer, "TeutonHonor", honor)
		TeutonHonorCheck(activePlayer)
		print("You got " .. honor .. ".")
	end
	TeutonXPBuy()
	Events.AudioPlay2DSound("AS2D_INTERFACE_POLICY")
end
Controls.UnitButton:RegisterCallback(Mouse.eLClick, TeutonXPBuyRecruit)	

-- TeutonXPBuyOnEnterCityScreen
function TeutonXPBuyOnEnterCityScreen()
	isCityViewOpen = true
	TeutonXPBuy()
end

-- TeutonXPBuyOnExitCityScreen
function TeutonXPBuyOnExitCityScreen()
	isCityViewOpen = false
	TeutonXPBuy()
end

-- TeutonXPBuyOnNextCityScren
function TeutonXPBuyOnNextCityScren()
	if isCityViewOpen then
		TeutonXPBuy()
	end
end
if (isTeutonActivePlayer) then
	Events.SerialEventEnterCityScreen.Add(TeutonXPBuyOnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(TeutonXPBuyOnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(TeutonXPBuyOnNextCityScren)
end

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "UC_Teuton_Honor_MCIS", ["SortOrder"] = 1})
end
if isTeutonActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "UC_Teuton_Honor_MCIS" then return end
	ProcessCityScreen(instance)
end
if isTeutonActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end

g_UC_Teuton_Honor_MCIS_TipControls = {}
TTManager:GetTypeControlTable("UC_Teuton_Honor_MCIS_Tooltip", g_UC_Teuton_Honor_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
	-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(instance)
	-- Ensure City Selected
	local city = UI.GetHeadSelectedCity()
	if (not city) then
		instance.IconFrame:SetHide(true)
		return
	end
	print("city == true")
	if not city:IsHasBuilding(GameInfoTypes.BUILDING_UC_ORDER) then
		instance.IconFrame:SetHide(true)
		return
	end
	if activePlayer:HasPolicy(GameInfoTypes.POLICY_WARRIOR_CODE) and activePlayer:HasPolicy(GameInfoTypes.POLICY_DISCIPLINE) and activePlayer:HasPolicy(GameInfoTypes.POLICY_MILITARY_TRADITION) and activePlayer:HasPolicy(GameInfoTypes.POLICY_MILITARY_CASTE) and not activePlayer:HasPolicy(GameInfoTypes.POLICY_PROFESSIONAL_ARMY) and activePlayer:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"]) then cost = 300
	elseif activePlayer:HasPolicy(GameInfoTypes.POLICY_WARRIOR_CODE) and activePlayer:HasPolicy(GameInfoTypes.POLICY_DISCIPLINE) and activePlayer:HasPolicy(GameInfoTypes.POLICY_MILITARY_TRADITION) and not activePlayer:HasPolicy(GameInfoTypes.POLICY_MILITARY_CASTE) and activePlayer:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"]) then cost = 250
	elseif activePlayer:HasPolicy(GameInfoTypes.POLICY_WARRIOR_CODE) and activePlayer:HasPolicy(GameInfoTypes.POLICY_DISCIPLINE) and not activePlayer:HasPolicy(GameInfoTypes.POLICY_MILITARY_TRADITION) and activePlayer:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"]) then cost = 200
	elseif activePlayer:HasPolicy(GameInfoTypes.POLICY_WARRIOR_CODE) and not activePlayer:HasPolicy(GameInfoTypes.POLICY_DISCIPLINE) and activePlayer:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"]) then cost = 150
	elseif activePlayer:IsPolicyBranchUnlocked(GameInfoTypes["POLICY_BRANCH_HONOR"]) then cost = 100
	else cost = 50
		end
	instance.IconFrame:SetToolTipType("UC_Teuton_Honor_MCIS_Tooltip")
	IconHookup(0, 64, "UC_TEUTON_ATLAS", instance.IconImage)
	if activePlayer:IsPolicyBranchFinished(GameInfoTypes["POLICY_BRANCH_HONOR"]) then
		instance.IconFrame:SetHide(true)
		return
	end
	local current = load(activePlayer, "TeutonHonor")
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_TEUTON_CITY_UI_DESC")) .. "[ENDCOLOR]" -- Header
	local textHelp = Locale.ConvertTextKey("TXT_KEY_TEUTON_CITY_UI_HELP", current, cost) -- Text
	g_UC_Teuton_Honor_MCIS_TipControls.Heading:SetText(textDescription)
	g_UC_Teuton_Honor_MCIS_TipControls.Body:SetText(textHelp)
	g_UC_Teuton_Honor_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end


