--============================================================
-- GLOBALS
--============================================================
include("FLuaVector.lua")
include("IconSupport.lua")
include("InstanceManager.lua")

local iUzbekistan = GameInfoTypes["CIVILIZATION_JWW_UZBEKISTAN"]
local iKanali = GameInfoTypes["BUILDING_JWW_SUGORISH_KANALI"]
local iMaxsusKuchlar = GameInfoTypes["UNIT_JWW_MAXSUS_KUCHLAR"]
local iDesert = GameInfoTypes["TERRAIN_DESERT"]
local iCoast = GameInfoTypes["TERRAIN_COAST"]
local iUADummy = GameInfoTypes["BUILDING_JWW_UZBEK_UA_DUMMY"]
local iWorker = GameInfoTypes["UNIT_WORKER"]
local iUBProductionDummy = GameInfoTypes["BUILDING_JWW_KANALI_PROD_DUMMY"]
local iUBFoodCounter = GameInfoTypes["BUILDING_JWW_KANALI_FOOD_DUMMY"]

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function Neirai_GetNearestCity(pPlayer, pPlot)
    local distance = 9999
    local cNearestCity = nil
    for cCity in pPlayer:Cities() do
        local pCityPlot = cCity:Plot()
        local between = Map.PlotDistance(pCityPlot:GetX(), pCityPlot:GetY(), pPlot:GetX(), pPlot:GetY())
        if between < distance then
            distance = between
            cNearestCity = cCity
        end
    end
    return cNearestCity
end
--============================================================
-- UA
--============================================================

function JWW_RipCitizens(iPlotX, iPlotY, oldPop, newPop)
	if newPop > oldPop then
		local pPlot = Map.GetPlot(iPlotX, iPlotY)
		local pPlayer = Players[pPlot:GetOwner()]
		if pPlot:IsCity() and pPlayer:GetCivilizationType() == iUzbekistan then
			local pCity = pPlot:GetPlotCity()
			local iPop = pCity:GetPopulation()
			if iPop > 2 then
				if iPop <= 5 then
					if JFD_GetRandom(1, 8) == 1 then
						pCity:SetPopulation(iPop - 1, true)
						pCity:ChangeFood(pCity:GrowthThreshold() * -1)
						JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
					end
				elseif iPop <= 10 then
					if JFD_GetRandom(1, 7) == 1 then
						pCity:SetPopulation(iPop - 1, true)
						pCity:ChangeFood(pCity:GrowthThreshold() * -1)
						JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
					end
				elseif iPop <= 15 then
					if JFD_GetRandom(1, 5) == 1 then
						pCity:SetPopulation(iPop - 1, true)
						pCity:ChangeFood(pCity:GrowthThreshold() * -1)
						JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
					end
				elseif iPop <= 20 then
					if JFD_GetRandom(1, 4) == 1 then
						pCity:SetPopulation(iPop - 1, true)
						pCity:ChangeFood(pCity:GrowthThreshold() * -1)
						JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
					end
				elseif iPop <= 25 then
					if JFD_GetRandom(1, 3) == 1 then
						pCity:SetPopulation(iPop - 1, true)
						pCity:ChangeFood(pCity:GrowthThreshold() * -1)
						JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
					end
				elseif iPop > 25 then
					if JFD_GetRandom(1, 2) == 1 then
						pCity:SetPopulation(iPop - 1, true)
						pCity:ChangeFood(pCity:GrowthThreshold() * -1)
						JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
					end
				end
			end
		end
	end
end

function JWW_HereIsYourRewardDontSpendItAllInOnePlace(pPlayer, pCity)
	local iNum = JFD_GetRandom(1, 4)
	if iNum == 1 then
		local iMod = (pPlayer:GetCurrentEra() + 1)
		local iProd = (JFD_GetRandom(20, 50)) * iMod
		pCity:ChangeProduction(iProd)
		if pPlayer:IsHuman() then
			Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city [ICON_PRODUCTION] [COLOR_YIELD_FOOD]' .. iProd .. ' Production![ENDCOLOR]')
		end
	elseif iNum == 2 then
		if pPlayer:HasCreatedReligion() then
			local iNum2 = JFD_GetRandom(1, 5)
			if iNum2 == 1 then
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_SETTLER, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Settler![ENDCOLOR]')
				end
			elseif iNum2 == 2 then
				local pUnit = pPlayer:InitUnit(iWorker, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Worker![ENDCOLOR]')
				end
			elseif iNum2 == 3 then
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_GREAT_GENERAL, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Great General![ENDCOLOR]')
				end
			elseif iNum2 == 4 then
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_CARAVAN, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Caravan![ENDCOLOR]')
				end
			else
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_MISSIONARY, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Missionary![ENDCOLOR]')
				end
			end
		else
			local iNum2 = JFD_GetRandom(1, 4)
			if iNum2 == 1 then
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_SETTLER, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Settler![ENDCOLOR]')
				end
			elseif iNum2 == 2 then
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_WORKER, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Worker![ENDCOLOR]')
				end
			elseif iNum2 == 3 then
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_GREAT_GENERAL, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Great General![ENDCOLOR]')
				end
			else
				local pUnit = pPlayer:InitUnit(GameInfoTypes.UNIT_CARAVAN, pCity:GetX(), pCity:GetY())
				pUnit:JumpToNearestValidPlot()
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city a free [COLOR_CITY_GREEN]Caravan![ENDCOLOR]')
				end
			end
		end
	elseif iNum == 3 then
		if JFD_GetRandom(1, 2) == 1 then
			pCity:SetNumRealBuilding(iUADummy, pCity:GetNumBuilding(iUADummy) + 1)
			Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city +1 [ICON_HAPPINESS_1] [COLOR_FONT_GREEN]Happiness![ENDCOLOR]')
		else
			pCity:SetNumRealBuilding(iUADummy, pCity:GetNumBuilding(iUADummy) + 2)
			Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city +2 [ICON_HAPPINESS_1] [COLOR_FONT_GREEN]Happiness![ENDCOLOR]')
		end
	else
		local iMod = (pPlayer:GetCurrentEra() + 1)
		local iGold = (JFD_GetRandom(30, 60)) * iMod
		pPlayer:ChangeGold(iGold)
		if pPlayer:IsHuman() then
			Events.GameplayAlertMessage('When the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] grew, 1 Population was sacrificed, granting the city [ICON_GOLD] [COLOR_YIELD_GOLD]' .. iGold .. ' Gold![ENDCOLOR]')
		end
	end
end

function JWW_GibPopFromMakingStuff(iPlayer, iCity, iThing, bGold, bFaithOrCulture)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iUzbekistan then
		local pCity = pPlayer:GetCityByID(iCity)
		local iFoodGiven = (pCity:GrowthThreshold() / 2)
		pCity:ChangeFood(iFoodGiven)
	end
end

GameEvents.SetPopulation.Add(JWW_RipCitizens)
GameEvents.CityConstructed.Add(JWW_GibPopFromMakingStuff)
GameEvents.CityCreated.Add(JWW_GibPopFromMakingStuff)
GameEvents.CityTrained.Add(JWW_GibPopFromMakingStuff)
--============================================================
-- UU
--============================================================
function JWW_DesertEqualsZoom(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitType() == iMaxsusKuchlar then
			local pPlot = pUnit:GetPlot()
			if pPlot:GetTerrainType() == iDesert then
				pUnit:ChangeMoves(120)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JWW_DesertEqualsZoom)
--============================================================
-- UB
--============================================================
function JWW_DoYouWantProductionOrFood(iPlayer)
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iKanali) then
			if not pCity:IsHasBuilding(iUBFoodCounter) then
				if not pCity:IsHasBuilding(iUBProductionDummy) then
					pCity:SetNumRealBuilding(iUBFoodCounter, JFD_GetRandom(6, 11))
				end
			end
		end
	end
end

function JWW_TurnCounter(iPlayer)
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iKanali) then
			if pCity:GetNumBuilding(iUBFoodCounter) > 1 then
				pCity:SetNumRealBuilding(iUBFoodCounter, pCity:GetNumBuilding(iUBFoodCounter) - 1)
			else
				if pCity:GetNumBuilding(iUBFoodCounter) == 1 then
					pCity:SetNumRealBuilding(iUBFoodCounter, pCity:GetNumBuilding(iUBFoodCounter) - 1)
					pCity:SetNumRealBuilding(iUBProductionDummy, JFD_GetRandom(6, 11))
					if pPlayer:IsHuman() then
						Events.GameplayAlertMessage('The lakes and coasts in the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] are now making [ICON_PRODUCTION] [COLOR_YIELD_FOOD]Production[ENDCOLOR] instead of [ICON_FOOD] [COLOR_FONT_GREEN]food![ENDCOLOR]')
					end
				elseif pCity:GetNumBuilding(iUBProductionDummy) > 0 then
					pCity:SetNumRealBuilding(iUBProductionDummy, pCity:GetNumBuilding(iUBProductionDummy) - 1)
					local iFoodRevoked = 0
					for i = 0, pCity:GetNumCityPlots(), 1 do
						local pPlot = pCity:GetCityIndexPlot(i)
						if pPlot:GetTerrainType() == iCoast then
							if pPlot:GetWorkingCity(pCity) then
								local iYield = pPlot:GetYield(GameInfoTypes.YIELD_FOOD)
								iFoodRevoked = iFoodRevoked + iYield
							end
						end
					end
					pCity:ChangeFood(pCity:FoodDifference() * -1)
					pCity:ChangeProduction(iFoodRevoked)
					if pCity:GetNumBuilding(iUBProductionDummy) == 0 then
						pCity:SetNumRealBuilding(iUBFoodCounter, JFD_GetRandom(6, 11))
						if pPlayer:IsHuman() then
							Events.GameplayAlertMessage('The lakes and coasts in the city of [COLOR_POSITIVE_TEXT]' .. pCity:GetName() .. '[ENDCOLOR] have gone back to producing [ICON_FOOD] [COLOR_FONT_GREEN]food.[ENDCOLOR]')
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JWW_DoYouWantProductionOrFood)
GameEvents.PlayerDoTurn.Add(JWW_TurnCounter)


local tSeaResources = {}
for row in DB.Query("SELECT ID FROM Resources WHERE TechCityTrade = 'TECH_SAILING' OR TechCityTrade = 'TECH_BIOLOGY'") do
    tSeaResources[row.ID] = true
end

--adapted from PorkBean
function JWW_IsButtonPossible(uUnit)
	if uUnit:GetUnitType() == iWorker then
		local pPlot = uUnit:GetPlot()
		if pPlot then
			if uUnit:GetOwner() == pPlot:GetOwner() then
				local pPlayer = Players[pPlot:GetOwner()]
				local pCity = Neirai_GetNearestCity(pPlayer, pPlot)
				if pCity:IsHasBuilding(iKanali) then
					if tSeaResources[pPlot:GetResourceType(pPlayer:GetTeam())] then
						return true
					end
				end
			end
		end
	end
	return false
end

function JWW_RipFish(pPlayer, uUnit)
	local pPlot = uUnit:GetPlot()
	pPlot:SetResourceType(-1)
	for pCity in pPlayer:Cities() do
		if not pCity:IsProductionProject() then
			local iProd = pCity:GetProductionNeeded() / 2
			if iProd < 200 then
				pCity:ChangeProduction(200)
			else
				pCity:ChangeProduction(iProd)
			end
		else
			pCity:ChangeProduction(200)
		end
	end
end

function PB_UnitActionButton()
	local uUnit = UI.GetHeadSelectedUnit();
	local pActivePlayer = Players[Game.GetActivePlayer()]
	JWW_RipFish(pActivePlayer, uUnit)
end

function PB_SerialEventUnitInfoDirty()
	local uUnit = UI.GetHeadSelectedUnit();
	if (not uUnit) then return end
	if JWW_IsButtonPossible(uUnit) then
		Controls.UnitActionButton:SetHide(false)
	else
		Controls.UnitActionButton:SetHide(true)
	end
	
	local buildCityButtonActive = uUnit:IsFound();
				
	local primaryStack = ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStack")
	local primaryStretchy = ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy")
	primaryStack:CalculateSize();
	primaryStack:ReprocessAnchoring();

	local stackSize = primaryStack:GetSize();
	local stretchySize = primaryStretchy:GetSize();
	local buildCityButtonSize = 0
	if buildCityButtonActive then
		if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
			buildCityButtonSize = 36;
		else
			buildCityButtonSize = 60;
		end
	end
	primaryStretchy:SetSizeVal( stretchySize.x, stackSize.y + buildCityButtonSize + 348 );
end

local function PB_UpdateUnitInfoPanel()
	if (not OptionsManager.GetSmallUIAssets()) then
		Controls.UnitActionButton:SetSizeVal(50,50)
		Controls.UnitActionIcon:SetSizeVal(64,64)
		Controls.UnitActionIcon:SetTexture("UnitActions360.dds")
	else
		Controls.UnitActionButton:SetSizeVal(36,36)
		Controls.UnitActionIcon:SetSizeVal(45,45)
		Controls.UnitActionIcon:SetTexture("UnitActions360.dds")
	end
	Controls.UnitActionIcon:LocalizeAndSetToolTip("TXT_KEY_JWW_WORKER_CANAL_HELP")
	Controls.UnitActionButton:ChangeParent(ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStack"))
end

local function PB_Initialize()	
	Events.LoadScreenClose.Add(PB_UpdateUnitInfoPanel);
	Events.SerialEventUnitInfoDirty.Add(PB_SerialEventUnitInfoDirty);
end

function JWW_AIKillsFish(playerID)
	local pPlayer = Players[playerID]
	if not pPlayer:IsHuman() then
		if pPlayer:GetCurrentEra() > 3 then
			for uUnit in pPlayer:Units() do
				if JWW_IsButtonPossible(uUnit) then
					if JFD_GetRandom(1, 100) >= 90 then
						JWW_RipFish(pPlayer, uUnit)
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JWW_AIKillsFish)

Controls.UnitActionButton:RegisterCallback(Mouse.eLClick, PB_UnitActionButton);
IconHookup(35, 45, "UNIT_ACTION_ATLAS", Controls.UnitActionIcon)
PB_Initialize();
