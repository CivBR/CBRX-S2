-- GajahMadaFunctions
-- Author: DuskJockey
-- DateCreated: 3/8/2019 12:16:10 PM
--------------------------------------------------------------
-- Globals
--------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationGajahMadaID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationGajahMadaID then
				return true
			end
		end
	end

	return false
end

function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPActive = Game_IsCPActive()

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

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

local civilisationGajahMadaID = GameInfoTypes["CIVILIZATION_INDONESIA"]
local isGajahMadaCivActive = JFD_IsCivilisationActive(civilisationGajahMadaID)
if isGajahMadaCivActive then
	print("Gajah Mada is in this game.")
end
--------------------------------------------------------------
-- Book of Kings
--------------------------------------------------------------
local traitGajahMadaID = GameInfoTypes["TRAIT_DJ_BOOK_OF_KINGS"]
local buildingCourthouseID = GameInfoTypes["BUILDING_COURTHOUSE"]
local techCourthousePrereqID = GameInfo.Technologies[GameInfo.Buildings[buildingCourthouseID].PrereqTech].ID
local buildingCourthouseID = GameInfoTypes["BUILDING_COURTHOUSE"]
local techCourthousePrereqID = GameInfo.Buildings[buildingCourthouseID].PrereqTech --at this point the type of the variable is a String (E.g. TECH_MATHEMATICS) or nil (when the PrereqTech is NULL)
if techCourthousePrereqID  == nil then
    print("Courthouse didn't have a PrereqTech, using "..tostring(GameInfo.Technologies[0].Type).." instead");
    techCourthousePrereqID  = 0
else
    print("Courthouse has a PrereqTech: "..tostring(techCourthousePrereqID).." ");
    techCourthousePrereqID  = GameInfo.Technologies[techCourthousePrereqID].ID
end
--------------------------------------------------------------
function DJ_CityCaptureBonuses(oldOwnerID, isCapital, cityX, cityY, newOwnerID, pop, isConquest)
	local player = Players[newOwnerID]
	local playerTeam = Teams[player:GetTeam()]
	local capturedPlayer = Players[oldOwnerID]
	if (HasTrait(player, traitGajahMadaID) and player:IsAlive()) then
		local city = Map.GetPlot(cityX, cityY):GetPlotCity()
		if player ~= capturedPlayer then
		print("City is owned by another player")
			local pillageLower = math.floor(city:GetBaseYieldRate(GameInfoTypes["YIELD_GOLD"]) * 0.5) + 50
			local pillageUpper = math.floor(city:GetBaseYieldRate(GameInfoTypes["YIELD_GOLD"]) * 0.5) + 100
			local goldPillaged = JFD_GetRandom(pillageLower, pillageUpper)
			player:ChangeGold(goldPillaged)
			print("Gold pillaged:", goldPillaged)
			if player:IsHuman() then
				local alertmessage = Locale.ConvertTextKey("TXT_KEY_DJ_INDONESIA_PILLAGE_CITY_ALERT", goldPillaged, city:GetName())
				Events.GameplayAlertMessage(alertmessage)
			end

			if city:IsCoastal() then
			print("Captured coastal city")
				if playerTeam:IsHasTech(techCourthousePrereqID) then
					city:SetNumRealBuilding(buildingCourthouseID, 1)
					print("Courthouse added")
				end
			end
		end 
	end
end

if isGajahMadaCivActive then
	GameEvents.CityCaptureComplete.Add(DJ_CityCaptureBonuses)
end
--------------------------------------------------------------
-- Detect Plunder
-- Globals
--------------------------------------------------------------
local tClasses = {}
tClasses[GameInfoTypes.UNITCLASS_CARGO_SHIP] = GameInfoTypes.UNITCLASS_CARGO_SHIP
--------------------------------------------------------------
-- Main Code
--------------------------------------------------------------
function DetectPlunder(iPlayer, iUnit)
    local pPlayer = Players[iPlayer]
    local pUnit = pPlayer:GetUnitByID(iUnit)
    local iUnitClass = pUnit:GetUnitClassType()
    
    if tClasses[iUnitClass] ~= nil then
        local pTeam = Teams[pPlayer:GetTeam()]
        local pPlot = pUnit:GetPlot()
        local iNumUnits = pPlot:GetNumUnits()
        for iVal = 0,(iNumUnits - 1) do
            local pLUnit = pPlot:GetUnit(iVal)
            if pLUnit:GetCombatLimit() > 0 and pTeam:IsAtWar(pLUnit:GetTeam()) then
                -- Being plundered, run function
				DJ_TradeRoutePillage(Players[pLUnit:GetOwner()])
                break
            end
        end
    end
    
    return false
end

GameEvents.CanSaveUnit.Add(DetectPlunder)
--------------------------------------------------------------
function DJ_TradeRoutePillage(player)
	local player = players[PlayerID]
	local pillageLower = math.floor(player:GetCapitalCity():GetBaseYieldRate(GameInfoTypes["YIELD_GOLD"]) * 0.5) + 50
	local pillageUpper = math.floor(player:GetCapitalCity():GetBaseYieldRate(GameInfoTypes["YIELD_GOLD"]) * 0.5) + 100
	local goldPillaged = JFD_GetRandom(pillageLower, pillageUpper)
	pPlayer:ChangeGold(goldPillaged)
	if pPlayer:IsHuman() then
		local alertmessage = Locale.ConvertTextKey("TXT_KEY_DJ_INDONESIA_PILLAGE_TRADE_ALERT", goldPillaged)
		Events.GameplayAlertMessage(alertmessage)
	end
end
--------------------------------------------------------------
-- Candi
--------------------------------------------------------------
local buildingCandiID = GameInfoTypes["BUILDING_CANDI"]
local buildingCandiXPID = GameInfoTypes["BUILDING_DJ_CANDY_XP"]

local tReligion = {}
for Religion in GameInfo.Religions() do
	tReligion[Religion.Type] = Religion.ID
	if Religion.ID == GameInfoTypes.RELIGION_PANTHEON then
		tReligion[Religion.Type] = nil
	end
end

function DJ_CandyFreeXP(playerID)
	local player = Players[playerID]
	for city in player:Cities() do
		if city:IsHasBuilding(buildingCandiID) then
			local numReligions = 0
			for s, v in pairs(tReligion) do
				if city:GetNumFollowers(v) >= 1 then
					numReligions = numReligions + 1
				end
			end
			if numReligions > 0 then
				city:SetNumRealBuilding(buildingCandiXPID, numReligions)
				print("Number of dummy buildings placed:", numReligions)
			end
		end
	end
end

if isGajahMadaCivActive then
	GameEvents.PlayerDoTurn.Add(DJ_CandyFreeXP)
end