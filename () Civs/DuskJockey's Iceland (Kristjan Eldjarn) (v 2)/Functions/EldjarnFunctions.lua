-- EldjarnFunctions
-- Author: DuskJockey
-- DateCreated: 9/1/2019 9:26:18 PM
--------------------------------------------------------------
-- Globals
--------------------------------------------------------------
include("AdditionalAchievementsUtility.lua")
include("FLuaVector.lua")
include("C15_IteratorPack_v1.lua")
--------------------------------------------------------------
function JFD_IsCivilizationActive(civilizationID)
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
--------------------------------------------------------------
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPActive = Game_IsCPActive()
--------------------------------------------------------------
function Game_IsAAActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "432bc547-eb05-4189-9e46-232dbde8f09f" then
			return true
		end
	end
	return false
end
local isAAActive = Game_IsAAActive()
--------------------------------------------------------------
function HasTrait(player, traitID)
	if isCPActive then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
end

local civilizationID  = GameInfoTypes["CIVILIZATION_DJ_ICELAND"]
local isCivActive	  = JFD_IsCivilizationActive(civilizationID)
if isCivActive then
	print("President Kristjan Eldjarn is in this game.")
end
--------------------------------------------------------------
-- THE COD WARS
--------------------------------------------------------------
local traitEldjarnID = GameInfoTypes["TRAIT_DJ_COD_WARS"]
local unitWorkboatID = GameInfoTypes["UNIT_WORKBOAT"]
local unitIcyWorkboatID = GameInfoTypes["UNIT_DJ_ICELAND_WORKBOAT"]
local buildIcyFishingBoatID = GameInfoTypes["IMPROVEMENT_DJ_ICELAND_FISHING_BOATS"]
local buildFishingBoatID = GameInfoTypes["IMPROVEMENT_FISHING_BOATS"]
local buildIcyPlatformID = GameInfoTypes["IMPROVEMENT_DJ_ICELAND_OFFSHORE_PLATFORM"]
local buildPlatformID = GameInfoTypes["IMPROVEMENT_OFFSHORE_PLATFORM"]
--------------------------------------------------------------
function DJ_IcelandBlockWorkboats(playerID, unitID)
	local player = Players[playerID]
    if unitID == unitIcyWorkboatID then return false end
	return true
end
GameEvents.PlayerCanTrain.Add(DJ_IcelandBlockWorkboats)
--------------------------------------------------------------
function DJ_IcelandConvertWorkboats(playerID, unitID)
    local player = Players[playerID]
    if (player:IsAlive() and HasTrait(player, traitEldjarnID)) then
		local unit = player:GetUnitByID(unitID)
       	if (unit and unit:GetUnitType() == unitWorkboatID) then
			local unit = player:GetUnitByID(unitID)
			local newUnit = player:InitUnit(unitIcyWorkboatID, unit:GetX(), unit:GetY())
			newUnit:Convert(unit)
        end
    end
end
if isCivActive then
	Events.SerialEventUnitCreated.Add(DJ_IcelandConvertWorkboats)
end
--------------------------------------------------------------
function DJ_IcelandCoastBuilds(playerID, plotX, plotY, improvementID)
	local player = Players[playerID]
    if (player:IsAlive() and HasTrait(player, traitEldjarnID)) then 
		if improvementID == buildIcyFishingBoatID or improvementID == buildIcyPlatformID then
			local plot = Map.GetPlot(plotX, plotY)
			if (plot and plot:GetOwner() ~= playerID) then
				plot:SetOwner(playerID)
				plot:SetRevealed(player:GetTeam(), true)
				--print("Plot claimed for Iceland")
			end
		end
	end
end
if isCivActive then
	GameEvents.BuildFinished.Add(DJ_IcelandCoastBuilds)
end
--------------------------------------------------------------
-- AEGIR-CLASS
--------------------------------------------------------------
local unitAegirClassID = GameInfoTypes["UNIT_DJ_AEGIR_CLASS"]
local promotionNetCuttersID = GameInfoTypes["PROMOTION_DJ_AEGIR_CLASS"]
--------------------------------------------------------------
function DJ_AegirClassBonuses(playerID, unitID, plotX, plotY)
    local player = Players[playerID]
    local unit = player:GetUnitByID(unitID)
    local plot = Map.GetPlot(plotX, plotY)
    if plot then
        if unit:GetUnitType() == unitAegirClassID then
			local ResourceNearby = false
			if plot:GetNumResource() > 0 then
				ResourceNearby = true
			else
				for iterPlot in C15_AdjacentPlotIterator(plot) do
					if iterPlot and iterPlot:IsWater() and iterPlot:GetNumResource() > 0 then
						ResourceNearby = true
						break
					end
				end
			end
			unit:SetHasPromotion(promotionNetCuttersID, ResourceNearby)
			print("An Aegir-class is near a resource")
			local myTeam = Teams[player:GetTeam()]
			local plotOwner = plot:GetOwner()
			if plotOwner ~= -1 then
				local plotOwnerTeam = Players[plotOwner]:GetTeam()
				if myTeam:IsAtWar(plotOwnerTeam) and plot:GetImprovementType() == buildFishingBoatID then
					plot:SetImprovementType(-1)
					local bonus = math.floor(player:GetTotalJONSCulturePerTurn() / 4)
					player:ChangeGold(bonus)
					--print("Enemy fishing boat krilled")
					if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GOLD]", bonus), true)
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(DJ_AegirClassBonuses)
--------------------------------------------------------------
-- TORFBAER
--------------------------------------------------------------
local buildTorfbaerID = GameInfoTypes["IMPROVEMENT_DJ_TORFBAER"]
local featureForestID = GameInfoTypes["FEATURE_FOREST"]
--------------------------------------------------------------
function DJ_TorfbaerFoodBoost(playerID)
	local player = Players[playerID]
	for city in player:Cities() do
		local iX, iY = city:GetX(), city:GetY()
		for i = 0, city:GetNumCityPlots() - 1, 1 do
			local plot = city:GetCityIndexPlot(i)
			if plot then
				if plot:GetImprovementType() == buildTorfbaerID then
					local forestAdjacency = false
					for iterPlot in C15_AdjacentPlotIterator(plot) do
						if iterPlot and iterPlot:GetFeatureType() == featureForestID then
							forestAdjacency = true
							break
						end
					end
					if forestAdjacency then
						city:ChangeFood(1)
						--print("Successfully added food from torbaer to " .. city:GetName() .. "")
					end
				end
			end
			
		end
	end
end

GameEvents.PlayerDoTurn.Add(DJ_TorfbaerFoodBoost)
--------------------------------------------------------------
-- ADDITIONAL ACHIEVEMENT
--------------------------------------------------------------
local resourceFishID = GameInfoTypes["RESOURCE_FISH"]
local unitSSStasisChamberID = GameInfoTypes["UNIT_SS_STASIS_CHAMBER"]
--------------------------------------------------------------
function DJ_AAIcelandSpecial(playerID, cityID, unitID, isGold, isFaithOrCulture)
	local player = Players[playerID]
	if isAAActive then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == unitSSStasisChamberID then
			local playerNumFish = player:GetNumResourceAvailable(resourceFishID, true)
			local mostFish = numFish
			local mostFishPlayerID = playerID
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local otherPlayer = Players[otherPlayerID]
				local otherPlayerNumFish = otherPlayer:GetNumResourceAvailable(resourceFishID, true)
				if (otherPlayer:IsAlive() and otherPlayerNumFish >= playerNumFish) then
					mostFish = otherPlayerCulturePerTurn
					mostFishPlayerID = otherPlayerID
				end
			end
		end
		if mostFishPlayerID == playerID then
			UnlockAA("AA_DJ_ICELAND_SPECIAL")
		end
	end
end

if not IsAAUnlocked("AA_DJ_ICELAND_SPECIAL") then
	GameEvents.CityTrained.Add(DJ_AAIcelandSpecial)
end
--------------------------------------------------------------
print("EldjarnFunctions.lua loaded successfully!")