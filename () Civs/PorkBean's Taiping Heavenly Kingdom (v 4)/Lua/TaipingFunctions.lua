--=======================================================================================================================
-- PorkBean's Taiping Heavenly Kingdom
--=======================================================================================================================

include("FLuaVector.lua")

local iTaipingCiv = GameInfoTypes.CIVILIZATION_PB_TAIPING;
local buildingPressureDummy = GameInfoTypes.BUILDING_PB_TAIPING_FAITH_DUMMY;

local gameSpeedID				= Game.GetGameSpeedType()
local gameSpeed					= GameInfo.GameSpeeds[gameSpeedID]
local gameSpeedMod				= (gameSpeed.GoldPercent/100)

------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
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

local isTaipingCivActive = JFD_IsCivilisationActive(iTaipingCiv);

------------------------------------------------------------------------------------------------------------------------
-- Check for EE and FW
------------------------------------------------------------------------------------------------------------------------
local bEnlightenmentEraIsActive = false
local bFutureWorldsIsActive = false
for _,v in ipairs(Modding.GetActivatedMods()) do
	if (v.ID == "ce8aa614-7ef7-4a45-a179-5329869e8d6d") then
		bEnlightenmentEraIsActive = true
	elseif (v.ID == "d9ece224-6cd8-4519-a27a-c417b59cdf35") then
		bFutureWorldsIsActive = true
	end
end

--=======================================================================================================================
-- UA: Brother of Christ
--=======================================================================================================================

-----------------------------------------------------------------------------
-- PressureFromPuppet
-----------------------------------------------------------------------------
function PressureFromPuppet(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iTaipingCiv then
		local pReligion = pPlayer:GetReligionCreatedByPlayer();
		if not pReligion then return end
		for pCity in pPlayer:Cities() do
			if pCity:IsPuppet() then
				if pCity:GetReligiousMajority() == pReligion then
					local pCityPop = pCity:GetPopulation();
					pCity:SetNumRealBuilding(buildingPressureDummy, 1);
				else
					pCity:SetNumRealBuilding(buildingPressureDummy, 0);
				end
			else
			pCity:SetNumRealBuilding(buildingPressureDummy, 0);
			end
		end
	end
end

-----------------------------------------------------------------------------
-- CaptureHealAndFaith
-----------------------------------------------------------------------------
function CaptureHealAndFaith(iPlayer, bCapital, iX, iY, iNewPlayer)
	local faithReturn = 50*gameSpeedMod
	local pNewPlayer = Players[iNewPlayer];
	local pCity = Map.GetPlot(iX, iY):GetPlotCity();
	if pNewPlayer:IsAlive() and pNewPlayer:GetCivilizationType() == iTaipingCiv then
		local numReward = 0;
		for i = 0, pCity:GetNumCityPlots()-1, 1 do --iterate the plots in a city (credit whoward69)
			local pPlot = pCity:GetCityIndexPlot(i)
			if (pPlot) then
				if pPlot:IsImprovementPillaged() then
					if pNewPlayer:IsHuman() then
						local hex = HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY())))
						Events.AddPopupTextEvent(hex, Locale.ConvertTextKey("+{1_Num}[ICON_PEACE]", faithReturn))
					end
					numReward = numReward+1;
				end
			end
		end
		pNewPlayer:ChangeFaith(faithReturn*numReward);
		local hpToHeal = (pCity:GetMaxHitPoints()/10)*numReward;
		pCity:ChangeDamage(-hpToHeal);
		local hex = HexToWorld(ToHexFromGrid(Vector2(iX, iY)))
		Events.AddPopupTextEvent(hex, Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR]", hpToHeal))
	end
end

if isTaipingCivActive then
	GameEvents.PlayerDoTurn.Add(PressureFromPuppet);
	GameEvents.CityCaptureComplete.Add(CaptureHealAndFaith);
end

--=======================================================================================================================
-- UU: Changmao
--=======================================================================================================================

local iChangmao = GameInfoTypes.UNIT_PB_CHANG_MAO;
local iChangmaoPromotion = GameInfoTypes.PROMOTION_PB_CHM_CITY_COMBAT;
local iChangmaoPromotion2 = GameInfoTypes.PROMOTION_PB_CHM_CITY_CAPTURE;

local buildingDef1 = GameInfoTypes.BUILDING_WALLS;
local techDef1 = GameInfoTypes.TECH_MASONRY;
local buildingDef2 = GameInfoTypes.BUILDING_CASTLE;
local techDef2 = GameInfoTypes.TECH_CHIVALRY;
local buildingDef3 = GameInfoTypes.BUILDING_ARSENAL;
local techDef3 = GameInfoTypes.TECH_METALLURGY;
local buildingDef4 = GameInfoTypes.BUILDING_MILITARY_BASE;
local techDef4 = GameInfoTypes.TECH_REPLACEABLE_PARTS;

if bEnlightenmentEraIsActive == true then
	local buildingDefEE1 = GameInfoTypes.BUILDING_EE_BASTION;
	local techDefEE1 = GameInfoTypes.TECH_EE_FORTIFICATION;
	local techDefEE2 = GameInfoTypes.TECH_DYNAMITE;
end
if bFutureWorldsIsActive == true then
	local buildingDefFW1 = GameInfoTypes.BUILDING_FW_DEFENSE_FIELD;
	local techDefFW1 = GameInfoTypes.TECH_ARTIFICIAL_ENVIRONMENTS;
	local buildingDefFW2 = GameInfoTypes.BUILDING_FW_UTILITY_FOG;
	local techDefFW2 = GameInfoTypes.TECH_SMART_MATERIALS;
end

-----------------------------------------------------------------------------
-- ChangmaoVsCities
-----------------------------------------------------------------------------
function ChangmaoVsCities(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsAlive() then
		local unit = player:GetUnitByID(unitID);
		if unit:GetUnitType() == iChangmao then
			local unitPlot = Map.GetPlot(unitX, unitY);
			if unitPlot then
				if unitPlot:IsImprovementPillaged() then
					unit:SetHasPromotion(iChangmaoPromotion,true)
				else
					unit:SetHasPromotion(iChangmaoPromotion,false)
				end
			end
		end
	end
end

function ChangmaoVsCitiesDoTurn(playerID)
	local player = Players[playerID]
	if player:IsAlive() then
		for unit in player:Units() do
			if unit:GetUnitType() == iChangmao then
				local unitPlot = Map.GetPlot(unit:GetX(), unit:GetY());
				if unitPlot then
					if unitPlot:IsImprovementPillaged() then
						unit:SetHasPromotion(iChangmaoPromotion,true)
					else
						unit:SetHasPromotion(iChangmaoPromotion,false)
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(ChangmaoVsCitiesDoTurn);
GameEvents.UnitSetXY.Add(ChangmaoVsCities);

-----------------------------------------------------------------------------
-- GrantDefensiveBuildings
-----------------------------------------------------------------------------
function GrantDefensiveBuildings(pPlayer, pCity)
	local pPlayerTeam = Teams[pPlayer:GetTeam()];
	if pPlayerTeam:IsHasTech(techDef1) then
		pCity:SetNumRealBuilding(buildingDef1, 1)
	end
	if pPlayerTeam:IsHasTech(techDef2) then
		pCity:SetNumRealBuilding(buildingDef2, 1)
	end
	if bEnlightenmentEraIsActive == false then
		if pPlayerTeam:IsHasTech(techDef3) then
			pCity:SetNumRealBuilding(buildingDef3, 1)
		end
	else
		if pPlayerTeam:IsHasTech(techDefEE2) then
			pCity:SetNumRealBuilding(buildingDef3, 1)
		end
		if pPlayerTeam:IsHasTech(techDefEE1) then
			pCity:SetNumRealBuilding(BuildingDefEE1, 1)
		end
	end
	if pPlayerTeam:IsHasTech(techDef4) then
		pCity:SetNumRealBuilding(buildingDef4, 1)
	end
	if bFutureWorldsIsActive == true then
		if pPlayerTeam:IsHasTech(techDefFW1) then
			pCity:SetNumRealBuilding(buildingDefFW1, 1)
		end
		if pPlayerTeam:IsHasTech(techDefFW2) then
			pCity:SetNumRealBuilding(buildingDefFW2, 1)
		end
	end
end

-----------------------------------------------------------------------------
-- ChangmaoCaptureCities
-----------------------------------------------------------------------------
function ChangmaoCaptureCities(iPlayer, bCapital, iX, iY, iNewPlayer)
	local pNewPlayer = Players[iNewPlayer];
	local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity();
	for i = 0, pPlot:GetNumUnits() - 1, 1 do
		local otherUnit = pPlot:GetUnit(i)
		if otherUnit and otherUnit:IsHasPromotion(iChangmaoPromotion2) then
			GrantDefensiveBuildings(pNewPlayer, pCity);
		end
	end
end

GameEvents.UnitSetXY.Add(ChangmaoVsCities);
GameEvents.CityCaptureComplete.Add(ChangmaoCaptureCities);

--=======================================================================================================================
-- UB: Heavenly Hall
--=======================================================================================================================
local buildingHeavenlyHall = GameInfoTypes.BUILDING_PB_HEAVENLY_HALL;
local buildingPromotionDummy = GameInfoTypes.BUILDING_PB_TAIPING_PROM_DUMMY;

function HeavenlyHallPromotions(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iTaipingCiv then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(buildingHeavenlyHall) then
				if pCity:GetWeLoveTheKingDayCounter() > 0 then
					pCity:SetNumRealBuilding(buildingPromotionDummy, 1);
				else
					pCity:SetNumRealBuilding(buildingPromotionDummy, 0);
				end
			else
				pCity:SetNumRealBuilding(buildingPromotionDummy, 0);
			end
		end
	end
end

if isTaipingCivActive then
	GameEvents.PlayerDoTurn.Add(HeavenlyHallPromotions);
end