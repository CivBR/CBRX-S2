-- Tongva UA
-- Written by: TopHatPaladin
----------------------------

include("FLuaVector.lua")

local iCiv = GameInfoTypes["CIVILIZATION_SAS_TONGVA"]
local iNumDirections = DirectionTypes.NUM_DIRECTION_TYPES - 1

-- ============================ --
-- UA: CULTURE FROM COAST TILES --
-- ============================ --

local iCoast = GameInfoTypes["TERRAIN_COAST"]
local tSuppressedTiles = {}

function GetTongvaCultureGain(pPlayer)
	local iEra = pPlayer:GetCurrentEra()
	return ((iEra + 1) * 4)
end

function Tongva_CultureFromGainedTile(playerID, cityID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		local pPlot = Map.GetPlot(iX, iY)
		if tSuppressedTiles[pPlot] then return end
		if pPlot:GetTerrainType() == iCoast then
			local pCityArea = pPlayer:GetCityByID(cityID):Area()
			local pCapArea = pPlayer:GetCapitalCity():Area()
			local iGain = 0
			if pCityArea == pCapArea then
				iGain = GetTongvaCultureGain(pPlayer)
				pPlayer:ChangeJONSCulture(iGain)
			else
				iGain = GetTongvaCultureGain(pPlayer) * 2
				pPlayer:ChangeJONSCulture(iGain)
			end
			if pPlayer:IsHuman() then
				Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), "+" .. iGain .. " [ICON_CULTURE]", 1)
			end
		end
	end
end

function Tongva_SuppressCultureOnCityFounding(playerID, iX, iY)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		for iDirection = 0, iNumDirections, 1 do
			local pAdjPlot = Map.PlotDirection(iX, iY, iDirection)
			tSuppressedTiles[pAdjPlot] = true
		end
	end
end

function Tongva_ResetSuppressedTiles(playerID)
	if (#tSuppressedTiles < 1) then return end
	for k, v in pairs(tSuppressedTiles) do
		tSuppressedTiles[k] = nil
	end
end

GameEvents.CityBoughtPlot.Add(Tongva_CultureFromGainedTile)
GameEvents.PlayerCityFounded.Add(Tongva_SuppressCultureOnCityFounding)
GameEvents.PlayerDoTurn.Add(Tongva_ResetSuppressedTiles)

-- ===================================== --
-- UA: WLTKD WHEN FINISHING POLICY TREES --
-- ===================================== --

local tFinishers = {}
for row in DB.Query("SELECT ID, PolicyBranchType FROM Policies WHERE PolicyBranchType IS NOT NULL AND Level = 0") do
    if not tFinishers[row.PolicyBranchType] then
        tFinishers[row.PolicyBranchType] = {}
    end
    table.insert(tFinishers[row.PolicyBranchType], row.ID)
    tFinishers[row.ID] = row.PolicyBranchType
end
local iWLTKDTurns = GameDefines.CITY_RESOURCE_WLTKD_TURNS -- Surely there's gotta be a game speed mod on this too? Maybe it's shared with the growth mod?
function Tongva_PolicyWLTKD(playerID, policyID)
    print("Tongva Finishers")
    local pPlayer = Players[playerID]
    if pPlayer:GetCivilizationType() == iCiv then
        local sBranch = tFinishers[policyID]
        if sBranch then
            print("Tongva Finishers 2")
            for i = 1, #tFinishers[sBranch] do
                if not pPlayer:HasPolicy(tFinishers[sBranch][i]) then
                    print("Igottago")
                    return
                end
            end
            for pCity in pPlayer:Cities() do
                pCity:SetWeLoveTheKingDayCounter(iWLTKDTurns)
                print("Tongva start WLTKD")
            end
        end
    end
end

GameEvents.PlayerAdoptPolicy.Add(Tongva_PolicyWLTKD)