-- Lua Script1
-- Author: Vanadius
-- DateCreated: 8/18/2019 1:23:54 PM
--------------------------------------------------------------

print('G E K O L O N I S E E R D')

-- Intended Effect: After the construction of the building on up to three either freshwater forests or forts a Fur resource will spawn

include("PlotIterators")

local civilizationID = GameInfoTypes.CIVILIZATION_VANA_NEWNETHERLAND
local resourceFurID = GameInfoTypes.RESOURCE_FUR
local fortID = GameInfoTypes.IMPROVEMENT_FORT;
local forestID = GameInfoTypes.FEATURE_FOREST;



function VanaBeaverSpawn(playerID, cityID, buildingID)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
        if buildingID == GameInfoTypes.BUILDING_VANA_BEAVER_FACTORIJ then
            local numDams = 0
            local city = player:GetCityByID(cityID)
            local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
            for adjacentPlot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
                if (adjacentPlot:GetFeatureType() == forestID and adjacentPlot:GetResourceType() == -1 and adjacentPlot:IsFreshWater()) or (adjacentPlot:GetImprovementType() == fortID and adjacentPlot:IsFreshWater()) then
                    print('found dams')
                    numDams = numDams + 1
                    adjacentPlot:SetResourceType(resourceFurID, 1)
                    if numDams >= 3 then break end
                end
            end
        end     
    end     
end    
GameEvents.CityConstructed.Add(VanaBeaverSpawn) 


----------------------------------------------------------------------------------------------------------------------------
-- +5% Great Person generation for each Religion and Outgoing TradeRoute present in the city
----------------------------------------------------------------------------------------------------------------------------

local buildingGPGenID = GameInfoTypes["BUILDING_VANA_GPP"]
local mathMin  = math.min

-- JFD_GetNumOutgoingTradeRoutes
function JFD_GetNumOutgoingTradeRoutes(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	local numOutgoingTRs = 0
	for _, tradeRoute in ipairs(tradeRoutes) do
		if tradeRoute.FromCity == city then
			numOutgoingTRs = numOutgoingTRs + 1
		end
	end
	return numOutgoingTRs
end


local tReligion = {}
for Religion in GameInfo.Religions() do
	tReligion[Religion.Type] = Religion.ID
	if Religion.ID == GameInfoTypes.RELIGION_PANTHEON then
		tReligion[Religion.Type] = nil
	end
end


function Vlad_NewNethers_GPGenPerReligion(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilizationID then
		for city in player:Cities() do
			local numReligions = 0  
			for s, v in pairs(tReligion) do
				if city:GetNumFollowers(v) >= 1 then
					numReligions = numReligions + 1
				end
			end
				city:SetNumRealBuilding(buildingGPGenID, numReligions + mathMin(JFD_GetNumOutgoingTradeRoutes(playerID, city)))
				print("Number of dummy buildings placed:", numReligions)
		end
	end
end

GameEvents.PlayerDoTurn.Add(Vlad_NewNethers_GPGenPerReligion)




----------------------------------------------------------------------------------------------------------------------------
-- FORTS CLAIM FRESHWATER
----------------------------------------------------------------------------------------------------------------------------

--VanaFortsClaim
local improvementFortID = GameInfoTypes["IMPROVEMENT_FORT"]
local function VanaFortsClaim(playerID, plotX, plotY, improvementID)
    local player = Players[playerID]
    local playerTeamID = player:GetTeam()
    local playerTeam = Teams[playerTeamID]
    if (not player:IsAlive()) then return end
    if (player:IsBarbarian()) then return end
    if (player:IsMinorCiv()) then return end

     if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
        if improvementID == improvementFortID then
            local plot = Map.GetPlot(plotX, plotY)
            local plotRadius = 1
            for adjacentPlot in PlotAreaSweepIterator(plot, plotRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
                if adjacentPlot:GetOwner() == -1 and adjacentPlot:IsFreshWater() then
                    local cityID = adjacentPlot:GetWorkingCity()
                    adjacentPlot:SetOwner(playerID, cityID, true, true)
                    adjacentPlot:SetRevealed(playerTeamID, true)
                end
            end
        end
    end
end
GameEvents.BuildFinished.Add(VanaFortsClaim)

----------------------------------------------------------------------------------------------------------------------------
-- CULTURE FROM WORKED FORTS & CAMPS + FORTS EXTEND RANGE
----------------------------------------------------------------------------------------------------------------------------

local buildingBeaverID		    = GameInfoTypes["BUILDING_VANA_BEAVER_FACTORIJ"]
local buildingBeaverCultureID   = GameInfoTypes["BUILDING_VANA_BEAVER_CULTURE"]
local buildingFortTradeRangeID  = GameInfoTypes["BUILDING_VANA_FORTS_RANGE"]
local buildingFurID				= GameInfoTypes["BUILDING_VANA_BUILDING_VANA_FUR"]
local improvementFortID			= GameInfoTypes["IMPROVEMENT_FORT"]
local improvementCampID			= GameInfoTypes["IMPROVEMENT_CAMP"]
local resourceFurID				= GameInfoTypes["RESOURCE_FUR"]


function Vana_NN_Beaver_DoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	for city in player:Cities() do
		if city:IsHasBuilding(buildingBeaverID) then
			local numCamps	= 0 
			local numForts	= 0
			local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
			for loopPlot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if (loopPlot:GetImprovementType() == improvementCampID and city:IsWorkingPlot(loopPlot)) then
					numCamps = numCamps + 1
				elseif (loopPlot:GetImprovementType() == improvementFortID and city:IsWorkingPlot(loopPlot)) then
					numCamps = numCamps + 1
					numForts = numForts + 1
				end
			end
			city:SetNumRealBuilding(buildingBeaverCultureID, numCamps)
			city:SetNumRealBuilding(buildingFortTradeRangeID, numForts)
		else
			city:SetNumRealBuilding(buildingBeaverCultureID, 0)
			city:SetNumRealBuilding(buildingFortTradeRangeID, 0)
		end
	end
end

GameEvents.PlayerDoTurn.Add(Vana_NN_Beaver_DoTurn)

function Vana_NN_BeaverFort_DoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	for city in player:Cities() do
			local numFurs  = 0 
			local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
			for loopPlot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if (loopPlot:GetImprovementType() == improvementFortID and loopPlot:GetResourceType() == resourceFurID) then 
					numFurs = numFurs + 1
				end
			city:SetNumRealBuilding(buildingFurID, numFurs)
		end
	end
end

GameEvents.PlayerDoTurn.Add(Vana_NN_BeaverFort_DoTurn)
