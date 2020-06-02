--===========================================================================
-- GLOBALS
--===========================================================================
local iRioGrande = GameInfoTypes["CIVILIZATION_JWW_RIO_GRANDE"]
local iFortaleza = GameInfoTypes["BUILDING_JWW_FORTALEZA_COLONIAL"]
local iRiverDummy = GameInfoTypes["BUILDING_JWW_RG_FC_RIVER_DUMMY"]
local iVaquero = GameInfoTypes["UNIT_JWW_VAQUERO"]
local iUADummy = GameInfoTypes["BUILDING_JWW_RG_UA_DUMMY"]
local iUUDummy = GameInfoTypes["PROMOTION_JWW_VAQUERO"]
--===========================================================================
-- UA
--===========================================================================

function JWW_RGRiverDamagesEnemyUnits(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsHuman() then
		if pPlayer:GetCivilizationType() == iRioGrande then
			for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pOtherPlayer = Players[iPlayer]
				if pOtherPlayer ~= pPlayer then
					for pUnit in pOtherPlayer:Units() do
						local pPlot = pUnit:GetPlot()
						if pPlot:IsVisibleEnemyUnit(pPlayer) then
							local pOwner = Players[pPlot:GetOwner()]
							if pOwner:GetCivilizationType() == iRioGrande then
								if pPlot:IsRiver() then
									local pAffectedUnit = pPlot:GetUnit(0)
									local iMaxHealth = pAffectedUnit:GetMaxHitPoints()
									local iHealthGone = math.ceil(iMaxHealth / 12)
									local iCurrentHealth = pAffectedUnit:GetCurrHitPoints()
									local iNewHealth = iCurrentHealth - iHealthGone
									--print("RG River damage to Unit", "CurrentHealth", iCurrentHealth, "MaxHealth", iMaxHealth, "HealthGone", iHealthGone, "NewHealth", iNewHealth)
									if iNewHealth > 0 then
									pUnit:ChangeDamage(iHealthGone)
									else
										pUnit:Kill(true)
										--print("RG River damage killed unit", "CurrentHealth", iCurrentHealth, "MaxHealth", iMaxHealth, "HealthGone", iHealthGone, "NewHealth", iNewHealth)
									end
								end
							end
						end
					end
				end
			end
		end
	else -- for some reason the first function only works if the player who is rio grande is human, thanks firaxis
		if pPlayer:GetCivilizationType() == iRioGrande then --this function might work for humans too but I'm too lazy to check so w/e
			local pTeam = Teams[pPlayer:GetTeam()]
			for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pOtherPlayer = Players[iPlayer]
				if pOtherPlayer ~= pPlayer then
					local pOtherTeam = pOtherPlayer:GetTeam()
					if pTeam:IsAtWar(pOtherTeam) then
						for pUnit in pOtherPlayer:Units() do
							local pPlot = pUnit:GetPlot()
							if pPlot:IsOwned() then
								if not pPlot:IsFriendlyTerritory(pPlayer) then
									local pOwner = Players[pPlot:GetOwner()]
									if pOwner:GetCivilizationType() == iRioGrande then
										if pPlot:IsRiver() then
											local pAffectedUnit = pPlot:GetUnit(0)
											local iMaxHealth = pAffectedUnit:GetMaxHitPoints()
											local iHealthGone = math.ceil(iMaxHealth / 12)
											local iCurrentHealth = pAffectedUnit:GetCurrHitPoints()
											local iNewHealth = iCurrentHealth - iHealthGone
											--print("RG River damage to Unit", "CurrentHealth", iCurrentHealth, "MaxHealth", iMaxHealth, "HealthGone", iHealthGone, "NewHealth", iNewHealth)
											if iNewHealth > 0 then
											pUnit:ChangeDamage(iHealthGone)
											else
												pUnit:Kill(true)
												--print("RG River damage killed unit", "CurrentHealth", iCurrentHealth, "MaxHealth", iMaxHealth, "HealthGone", iHealthGone, "NewHealth", iNewHealth)
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
end

--kudos to PorkBean
local resHorse = GameInfoTypes["RESOURCE_HORSE"];
local iHorseCount = 0;

function PB_RioGrandeXPFromHorses(iPlayer)
    local pPlayer = Players[iPlayer];    
    if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iRioGrande then
        for pCity in pPlayer:Cities() do
            iHorseCount = 0
            for i = 0, pCity:GetNumCityPlots()-1, 1 do --iterate the plots in a city (credit whoward69)
                local pPlot = pCity:GetCityIndexPlot(i)
                if (pPlot) then
                    if pPlot:GetResourceType(-1) == resHorse then
						local iHorsesPerPlot = 0
						local iHorsesPerPlot = pPlot:GetNumResource()
                        iHorseCount = iHorseCount + iHorsesPerPlot
                    end
                end
            end
        pCity:SetNumRealBuilding(iUADummy, iHorseCount);
        end
    end
end

GameEvents.PlayerDoTurn.Add(PB_RioGrandeXPFromHorses)
GameEvents.PlayerDoTurn.Add(JWW_RGRiverDamagesEnemyUnits)
--===========================================================================
-- UU
--===========================================================================

function JWW_VaqueroCombatBonusAcrossRivers(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			if pPlot:IsRiver() then
                if not pUnit:IsHasPromotion(iUUDummy) then
					pUnit:SetHasPromotion(iUUDummy, true)
				end
			else
				if pUnit:IsHasPromotion(iUUDummy) then
					pUnit:SetHasPromotion(iUUDummy, false)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JWW_VaqueroCombatBonusAcrossRivers)


-- This code is based on Tomatekh's template for button Lua.

include("FLuaVector.lua")
include("IconSupport.lua")
IconHookup(29, 45, "UNIT_ACTION_ATLAS", Controls.TomButtonImage)
Controls.TomButtonBackground:SetHide(true)
local pSelUnit

local iHorse = GameInfoTypes.RESOURCE_HORSE
local iPasture = GameInfoTypes.IMPROVEMENT_PASTURE

local iForest = GameInfoTypes.FEATURE_FOREST
local iJungle = GameInfoTypes.FEATURE_JUNGLE
local iMarsh = GameInfoTypes.FEATURE_MARSH
local iFlood = GameInfoTypes.FEATURE_FLOOD_PLAINS
local iCoast = GameInfoTypes.TERRAIN_COAST
local iOcean = GameInfoTypes.TERRAIN_OCEAN

--Generate a random number between the values indicated by 'lower' and 'upper'
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function CanBuildPastures(unit) -- checks if a unit is on a valid plot
	local pBool = false;
	local pPlot = unit:GetPlot();
	--print("checking if units have moves left", unit)
	if unit:MovesLeft() <= 1 then return pBool end
	--print("checking if plot owner", unit:GetOwner(), pPlot:GetOwner())
	if unit:GetOwner() ~= pPlot:GetOwner() then return pBool end
	if pPlot ~= nil then
		if (not pPlot:IsCity()) then
			if pPlot:GetResourceType() == -1 then
				if pPlot:GetImprovementType() == -1 then
					if (pPlot:GetFeatureType() == -1 or pPlot:GetFeatureType() == iForest or pPlot:GetFeatureType() == iJungle or pPlot:GetFeatureType() == iMarsh or pPlot:GetFeatureType() == iFlood) then
						if pPlot:GetTerrainType() == iCoast or pPlot:GetTerrainType() == iOcean then return pBool end
						--print("can build pasture + horses", unit)
						pBool = true;
					end
				end
			end
		end
	end
	return pBool
end

-- Most of this function is taken from the Tlingit lua that Neirai wrote
function PlaceThatHorse(playerID, unitID)
	local hPlayer = Players[playerID]
	local hUnit = pSelUnit;
	local hUnitPlot = hUnit:GetPlot();
	if CanBuildPastures(hUnit) then
		hUnitPlot:SetResourceType(iHorse,JFD_GetRandom(1, 5));
		hUnitPlot:SetImprovementType(iPasture);
		if hUnitPlot:GetFeatureType() ~= iFlood then
			hUnitPlot:SetFeatureType(-1);
		end
		hUnit:Kill()
	else
		local iX = hUnit:GetX()
		local iY = hUnit:GetY()
		Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), "[COLOR_WARNING_TEXT]Must be in friendly & empty land with remaining moves![ENDCOLOR]", 0)
	end
end

function VaqueroSelection(playerID, unitID, x, y, a5, bool)
	if bool then
		local pPlayer = Players[playerID]
		local pUnit = pPlayer:GetUnitByID(unitID);
		if pUnit:GetUnitType() == iVaquero then
			ContextPtr:SetHide(false)
			Controls.TomButtonBackground:SetHide(false)
			pSelUnit = pUnit;
			Controls.TomButton:SetDisabled(false)
			Controls.TomButton:RegisterCallback(Mouse.eLClick, PlaceThatHorse)

			local sTT = Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]Create Improved Horses[ENDCOLOR][NEWLINE][NEWLINE]Expend this unit to create an improved source of Horses on this tile.[NEWLINE][NEWLINE]Unit must be in friendly territory without an existing resource or improvement, and have moves remaining.")
			Controls.TomButton:LocalizeAndSetToolTip("" .. sTT .. "")
		end
	else
		Controls.TomButtonBackground:SetHide(true)
		pSelUnit = nil;
	end
end
--Events.UnitSelectionChanged.Add(VaqueroSelection)


function AIBuildsPasturesRioGrande(playerID)
	local aPlayer = Players[playerID]
	local aTeam = Teams[aPlayer:GetTeam()]
	if aPlayer:IsHuman() then return end
	if aPlayer:GetCivilizationType() == iRioGrande then
		for aUnit in aPlayer:Units() do
			if aUnit:GetUnitType() == iVaquero then
				if CanBuildPastures(aUnit) then
					if aTeam:IsAtWar() == false then
						if JFD_GetRandom(1, 10) > 7 then
							local aUnitPlot = aUnit:GetPlot();
							aUnitPlot:SetResourceType(iHorse,JFD_GetRandom(1, 5));
							aUnitPlot:SetImprovementType(iPasture);
							if aUnitPlot:GetFeatureType() ~= iFlood then
								aUnitPlot:SetFeatureType(-1);
							end
							aUnit:Kill()
						end						
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(AIBuildsPasturesRioGrande)

--===========================================================================
-- UB
--===========================================================================

function JWW_RGDefensePerRiver(iPlayer)
	local pPlayer = Players[iPlayer]
	local iNumRiverTiles = 0
	if pPlayer:IsAlive() then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iFortaleza) then
				if pCity:IsHasBuilding(iRiverDummy) then
					pCity:SetNumRealBuilding(iRiverDummy, 0)
				end
				for i = 0, pCity:GetNumCityPlots(), 1 do
                    local pCheckedPlot = pCity:GetCityIndexPlot(i)
					if pCheckedPlot:GetWorkingCity(pCity) then
						if pCheckedPlot:IsRiver() then
							iNumRiverTiles = iNumRiverTiles + 1.5
						end
					end
				end
				pCity:SetNumRealBuilding(iRiverDummy, iNumRiverTiles)
			else
				if pCity:IsHasBuilding(iRiverDummy) then
					pCity:SetNumRealBuilding(iRiverDummy, 0)
				end
			end
		end
	end
end

function JWW_RGDuringWarBorderGrowthDoubled(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		local pTeam = Teams[pPlayer:GetTeam()]
		if pTeam:GetAtWarCount(false) ~= 0 then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iFortaleza) then
					local iCultureThreshold = pCity:GetJONSCultureThreshold()
					local iCultureStored = pCity:GetJONSCultureStored()
					local iCultureNeeded = iCultureThreshold - iCultureStored
					local iCultureAdded = math.ceil(iCultureNeeded / 2)
					if iCultureStored < iCultureAdded then
						pCity:ChangeJONSCultureStored(iCultureAdded)
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(JWW_RGDuringWarBorderGrowthDoubled)
GameEvents.PlayerDoTurn.Add(JWW_RGDefensePerRiver)

