print ("Mississippi Scripts")

--Stuff
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function DecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function CompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end

local RegionPlots = {}
local TempRegionPlots = {}
local TempRegionPlotsTwo = {}
local TempRegionPlotsMinCont = {}
local TempRegionPlotsMaxSize = {}

local MaxSize = 0;
local MaxX = 0;
local MaxY = 0;
local America = 0;
local Asia = 0;
local Africa = 0;
local Europe = 0;

local Tiny = 2016
local Huge = 10240

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	MaxSize = MaxSize + 1;
	if pPlot:GetY() > MaxY then
		MaxY = pPlot:GetY();
	end
	if pPlot:GetX() > MaxX then
		MaxX = pPlot:GetX();
	end
	if (pPlot:GetContinentArtType() == 1) then
		America = 1;
	end
	if (pPlot:GetContinentArtType() == 2) then
		Asia = 1;
	end
	if (pPlot:GetContinentArtType() == 3) then
		Africa = 1;
	end
	if (pPlot:GetContinentArtType() == 4) then
		Europe = 1;
	end
end

local MapHeight = (MaxY + 1)
local MapCenter = math.floor(MapHeight / 2);
local MapDivision = math.floor(MapHeight / 9);
local EquatAdjust = math.floor(MapDivision / 2);
local EqTop = (MapCenter + EquatAdjust);
local EqBottom = (MapCenter - EquatAdjust);
local Lat1 = (EqBottom - MapDivision);
local Lat2 = (Lat1 - MapDivision);
local Lat3 = (Lat2 - MapDivision);
local Lat1a = (EqTop + MapDivision);
local Lat2a = (Lat1a + MapDivision);
local Lat3a = (Lat2a + MapDivision);

local NumContinents = America + Asia + Africa + Europe;

local RegionDistance = 16;
if (MaxSize > Tiny) and (MaxSize < Huge) then
	RegionDistance = 15;
end
if MaxSize <= Tiny then
	RegionDistance = 14;
end

local iPlatformMound = GameInfoTypes.IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD;

local bTemple = GameInfoTypes.BUILDING_TEMPLE;
local bMoundTemple = GameInfoTypes.BUILDING_MISSISSIPPI_MOD_TOMATEKH;
local bMound40 = GameInfoTypes.BUILDING_MISSISSIPPI_MOD_4_0;
local bMound31 = GameInfoTypes.BUILDING_MISSISSIPPI_MOD_3_1;
local bMound22 = GameInfoTypes.BUILDING_MISSISSIPPI_MOD_2_2;
local bMound13 = GameInfoTypes.BUILDING_MISSISSIPPI_MOD_1_3;
local bMound04 = GameInfoTypes.BUILDING_MISSISSIPPI_MOD_0_4;

local LatBuildings = {
	GameInfoTypes.BUILDING_MISSISSIPPI_MOD_4_0,
	GameInfoTypes.BUILDING_MISSISSIPPI_MOD_3_1,
	GameInfoTypes.BUILDING_MISSISSIPPI_MOD_2_2,
	GameInfoTypes.BUILDING_MISSISSIPPI_MOD_1_3,
	GameInfoTypes.BUILDING_MISSISSIPPI_MOD_0_4,
	}

local bFoodDummy = GameInfoTypes.BUILDING_MISSISSIPPI_FOOD_DUMMY;
local bMaintCount = GameInfoTypes.BUILDING_MISSISSIPPI_MAINT_DUMMY;
local bUUProd = GameInfoTypes.BUILDING_MISSISSIPPI_PROD_DUMMY;

local pChunkeyGame = GameInfoTypes.POLICY_CHUNKEY_GAME_MOD;
local pRiverPolities = GameInfoTypes.POLICY_RIVER_POLITIES_MOD;

local FalconID = GameInfo.Units["UNIT_MISSISSIPPI_MOD_TOMATEKH"].ID;

--Cleanup
GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
			--
			----
			--
			for sKey, tTable in pairs(RegionPlots) do
				RegionPlots[sKey] = nil
			end	
			for sKey, tTable in pairs(TempRegionPlots) do
				TempRegionPlots[sKey] = nil
			end	
			for sKey, tTable in pairs(TempRegionPlotsTwo) do
				TempRegionPlotsTwo[sKey] = nil
			end	
			for sKey, tTable in pairs(TempRegionPlotsMinCont) do
				TempRegionPlotsMinCont[sKey] = nil
			end	
			for sKey, tTable in pairs(TempRegionPlotsMaxSize) do
				TempRegionPlotsMaxSize[sKey] = nil
			end	
			--
			----
			--
			for pCity in pPlayer:Cities() do
				local pPlot = pCity:Plot();
				if (pPlot:GetImprovementType() ~= -1) then
					pPlot:SetImprovementType(-1)
				end
				if (pCity:IsHasBuilding(bFoodDummy)) then
					pCity:SetNumRealBuilding(bFoodDummy, 0);
				end
				if (pCity:IsHasBuilding(bMaintCount)) then
					pCity:SetNumRealBuilding(bMaintCount, 0);
				end
				if (pCity:IsHasBuilding(bUUProd)) then
					pCity:SetNumRealBuilding(bUUProd, 0);
				end
			end
			--
			----
			--
		end
	end
end)

--Find Regional Centers
cityMax = 1;

function largerThan(cCity, pCity)
	return cCity:GetPopulation() > pCity:GetPopulation();
end

function GetHighestPop(pPlayer, ContType)
	local cities = {};
	local last = 0;
	local bCity = 0;
	for cCity in pPlayer:Cities() do
		local cPlot = cCity:Plot();
		if (cPlot:GetContinentArtType() == ContType) then
			local larger = true;
			local i = last;
			while i > 0 and larger do
				larger = largerThan(cCity, cities[i]);
				if i ~= cityMax then
					if larger then
						cities[i+1] = cities[i];
					else
						cities[i+1] = cCity;
					end
				end
				i = i - 1;
			end
			if i == 0 and larger then
				cities[1] = cCity;
			end
			if last < cityMax then
				last = last + 1;
			end
		end
	end
	for i,cCity in ipairs(cities) do
		bCity = cCity;
		break
	end
	return bCity
end

function GetHighestPopTwo(pPlayer, tempTable)
	local cities = {};
	local last = 0;
	local exCity = 0;
	for sKey, tTable in pairs(tempTable) do
		local pPlot = DecompilePlotID(sKey)	
		if pPlot:IsCity() then
			local cCity = pPlot:GetPlotCity();
			local larger = true;
			local i = last;
			while i > 0 and larger do
				larger = largerThan(cCity, cities[i]);
				if i ~= cityMax then
					if larger then
						cities[i+1] = cities[i];
					else
						cities[i+1] = cCity;
					end
				end
				i = i - 1;
			end
			if i == 0 and larger then
				cities[1] = cCity;
			end
			if last < cityMax then
				last = last + 1;
			end
		end
	end
	for i,cCity in ipairs(cities) do
		exCity = cCity;
		break
	end
	return exCity
end

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetNumCities() >= 1) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
				local tempTable;
				--
				----
				--
				if pPlayer:HasPolicy(pRiverPolities) then
					RegionDistance = RegionDistance + 2;
				end
				--
				----
				--
				for pCity in pPlayer:Cities() do
					local pPlot = pCity:Plot();
					if (pPlot:GetContinentArtType() == 1) then
						local ContType = 1;
						local bCity = GetHighestPop(pPlayer, ContType);
						if pCity == bCity then
							local sKey = CompilePlotID(pPlot)
							RegionPlots[sKey] = -1
						end
					end
					if (pPlot:GetContinentArtType() == 2) then
						local ContType = 2;
						local bCity = GetHighestPop(pPlayer, ContType);
						if pCity == bCity then
							local sKey = CompilePlotID(pPlot)
							RegionPlots[sKey] = -1
						end
					end
					if (pPlot:GetContinentArtType() == 3) then
						local ContType = 3;
						local bCity = GetHighestPop(pPlayer, ContType);
						if pCity == bCity then
							local sKey = CompilePlotID(pPlot)
							RegionPlots[sKey] = -1
						end
					end
					if (pPlot:GetContinentArtType() == 4) then
						local ContType = 4;
						local bCity = GetHighestPop(pPlayer, ContType);
						if pCity == bCity then
							local sKey = CompilePlotID(pPlot)
							RegionPlots[sKey] = -1
						end
					end
				end
				--
				----
				--
				for pCity in pPlayer:Cities() do
					local pPlot = pCity:Plot();
					local DistanceReq = 0;
					for sKey, tTable in pairs(RegionPlots) do
						local rPlot = DecompilePlotID(sKey)		
						if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY()) < RegionDistance then
							DistanceReq = 1;
						end
					end
					if DistanceReq == 0 then
						local sKey = CompilePlotID(pPlot)
						TempRegionPlots[sKey] = -1	
					end
				end
				tempTable = TempRegionPlots;
				local exCity = GetHighestPopTwo(pPlayer, tempTable);
				if exCity ~= 0 then					
					local pPlot = exCity:Plot();
					local sKey = CompilePlotID(pPlot)
					RegionPlots[sKey] = -1
				end
				--
				----
				--	
				for pCity in pPlayer:Cities() do
					local pPlot = pCity:Plot();
					local DistanceReq = 0;
					for sKey, tTable in pairs(RegionPlots) do
						local rPlot = DecompilePlotID(sKey)		
						if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY()) < RegionDistance then
							DistanceReq = 1;
						end
					end
					if DistanceReq == 0 then
						local sKey = CompilePlotID(pPlot)
						TempRegionPlotsTwo[sKey] = -1	
					end
				end
				tempTable = TempRegionPlotsTwo;
				local exCity = GetHighestPopTwo(pPlayer, tempTable);
				if exCity ~= 0 then					
					local pPlot = exCity:Plot();
					local sKey = CompilePlotID(pPlot)
					RegionPlots[sKey] = -1
				end
				--
				----
				--				
				if NumContinents <= 2 then
					for pCity in pPlayer:Cities() do
						local pPlot = pCity:Plot();
						local DistanceReq = 0;
						for sKey, tTable in pairs(RegionPlots) do
							local rPlot = DecompilePlotID(sKey)		
							if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY()) < RegionDistance then
								DistanceReq = 1;
							end
						end
						if DistanceReq == 0 then
							local sKey = CompilePlotID(pPlot)
							TempRegionPlotsMinCont[sKey] = -1	
						end
					end
					tempTable = TempRegionPlotsMinCont;
					local exCity = GetHighestPopTwo(pPlayer, tempTable);
					if exCity ~= 0 then					
						local pPlot = exCity:Plot();
						local sKey = CompilePlotID(pPlot)
						RegionPlots[sKey] = -1
					end		
				end
				--
				----
				--	
				if MaxSize >= Huge then
					for pCity in pPlayer:Cities() do
						local pPlot = pCity:Plot();
						local DistanceReq = 0;
						for sKey, tTable in pairs(RegionPlots) do
							local rPlot = DecompilePlotID(sKey)		
							if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY()) < RegionDistance then
								DistanceReq = 1;
							end
						end
						if DistanceReq == 0 then
							local sKey = CompilePlotID(pPlot)
							TempRegionPlotsMaxSize[sKey] = -1	
						end
					end
					tempTable = TempRegionPlotsMaxSize;
					local exCity = GetHighestPopTwo(pPlayer, tempTable);
					if exCity ~= 0 then					
						local pPlot = exCity:Plot();
						local sKey = CompilePlotID(pPlot)
						RegionPlots[sKey] = -1
					end		
				end
				--
				----
				--
			end
		end
	end
end)

--Award
local NearbyCity1 = 4
local NearbyCity2 = 5
local NearbyCity3 = 6

local BaseReduction = 10;

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
			--
			----
			--
			if pPlayer:HasPolicy(pRiverPolities) then
				NearbyCity3 = NearbyCity3 + 1;
				BaseReduction = BaseReduction--[[ + 1--]];
			end
			--
			----
			--
			for sKey, tTable in pairs(RegionPlots) do
				local pPlot = DecompilePlotID(sKey)
				if pPlot:IsCity() then
					if (pPlot:GetImprovementType() == -1) then
						pPlot:SetImprovementType(iPlatformMound)
					end
				end
			end
			--
			----
			--
			local MaintCity1 = 0;
			local MaintCity2 = 0;
			local MaintCity3 = 0;
			for pCity in pPlayer:Cities() do
				local pPlot = pCity:Plot();
				if (pPlot:GetImprovementType() ~= iPlatformMound) then
					local MinDistance = 999;
					local rcPlot = pPlot;
					for sKey, tTable in pairs(RegionPlots) do
						local rPlot = DecompilePlotID(sKey)
						local prDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY());
						if prDistance < MinDistance then
							MinDistance = prDistance;
							rcPlot = rPlot;
						end
					end
					local CapPop = 15;
					if rcPlot:IsCity() then
						local rcCity = rcPlot:GetPlotCity();
						CapPop = rcCity:GetPopulation();
					end
					if MinDistance <= NearbyCity1 then
						if CapPop >= 15 then
							CapPop = 15;
						end
						pCity:SetNumRealBuilding(bFoodDummy, CapPop);
						MaintCity1 = (MaintCity1 + pCity:GetTotalBaseBuildingMaintenance());
					elseif (MinDistance >= NearbyCity2) and (MinDistance < NearbyCity3) then
						if CapPop >= 10 then
							CapPop = 10;
						end
						pCity:SetNumRealBuilding(bFoodDummy, CapPop);
						MaintCity2 = (MaintCity2 + pCity:GetTotalBaseBuildingMaintenance());
					elseif MinDistance == NearbyCity3 then
						if CapPop >= 5 then
							CapPop = 5;
						end
						pCity:SetNumRealBuilding(bFoodDummy, CapPop);
						MaintCity3 = (MaintCity3 + pCity:GetTotalBaseBuildingMaintenance());
					end
				elseif (pPlot:GetImprovementType() == iPlatformMound) then	
					local MinDistance = 999;			
					for rCity in pPlayer:Cities() do
						local rPlot = rCity:Plot();
						if (rPlot:GetImprovementType() ~= iPlatformMound) then
							local prDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY());
							if prDistance < MinDistance then
								MinDistance = prDistance;
							end
						end
					end
					local CapPop = pCity:GetPopulation();
					if MinDistance <= NearbyCity1 then
						if CapPop >= 15 then
							CapPop = 15;
						end
						pCity:SetNumRealBuilding(bFoodDummy, CapPop);
						MaintCity1 = (MaintCity1 + pCity:GetTotalBaseBuildingMaintenance());
					elseif (MinDistance >= NearbyCity2) and (MinDistance < NearbyCity3) then
						if CapPop >= 10 then
							CapPop = 10;
						end
						pCity:SetNumRealBuilding(bFoodDummy, CapPop);
						MaintCity2 = (MaintCity2 + pCity:GetTotalBaseBuildingMaintenance());
					elseif MinDistance == NearbyCity3 then
						if CapPop >= 5 then
							CapPop = 5;
						end
						pCity:SetNumRealBuilding(bFoodDummy, CapPop);
						MaintCity3 = (MaintCity3 + pCity:GetTotalBaseBuildingMaintenance());
					end
					--
					----
					--
					if not pPlayer:IsHuman() then
						if pCity:GetProductionUnit() ~= -1 then
							local Unit = pCity:GetProductionUnit();
							if Unit == FalconID then
								local BonusProduction = ((pCity:GetCurrentProductionDifferenceTimes100(false, false) / 100) / 2);
								pCity:ChangeUnitProduction(FalconID, BonusProduction);
							end					
						end
					end
					--
					----
					--
				end
			end
			--
			----
			--
			if (pPlayer:GetNumCities() >= 1) then
				local Maint2Edit = (MaintCity2 * 0.75);
				local Maint3Edit = (MaintCity3 * 0.5);
				local TotalMaint = (MaintCity1 + Maint2Edit + Maint3Edit);
				local Discount = math.floor(TotalMaint / BaseReduction);
				pPlayer:ChangeGold(Discount);
				local pcCity = pPlayer:GetCapitalCity();
				pcCity:SetNumRealBuilding(bMaintCount, Discount);
			end
			--
			----
			--
		end
	end
end)

--Falcon Dancer
function OnHumanPlayerTurnEnd()
	local pPlayer = Players[Game.GetActivePlayer()];
	if pPlayer:IsAlive() then
		if pPlayer:IsHuman() then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
				for pCity in pPlayer:Cities() do
					local pPlot = pCity:Plot();
					if (pPlot:GetImprovementType() == iPlatformMound) then	
						if pCity:GetProductionUnit() ~= -1 then
							local Unit = pCity:GetProductionUnit();
							if Unit == FalconID then
								if not (pCity:IsHasBuilding(bUUProd)) then
									pCity:SetNumRealBuilding(bUUProd, 1);
								end
							end
						end
					end
				end
			end
		end
	end
end
Events.ActivePlayerTurnEnd.Add(OnHumanPlayerTurnEnd);

function FalconDance(playerID, cityID, unitID)
	local pPlayer = Players[playerID];
	local pCity = pPlayer:GetCityByID(cityID);
	local pPlot = pCity:Plot();
	local pUnit = pPlayer:GetUnitByID(unitID)
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
		if pUnit:GetUnitType() == FalconID then
			if (pPlot:GetImprovementType() == iPlatformMound) then	
				local pPop = pCity:GetPopulation();			
				if pPlayer:HasPolicy(pChunkeyGame) then 
					pPop = (pPop * 1.5);
				end
				local BaseXP = pUnit:GetExperience();
				local BonusXP = (BaseXP + pPop);
				pUnit:SetExperience(BonusXP);
			end
		end
	end
end
GameEvents.CityTrained.Add(FalconDance);

--AI Handle
local iTechSteel = GameInfo.Technologies["TECH_STEEL"].ID
local iTechGunpowder = GameInfo.Technologies["TECH_GUNPOWDER"].ID
local iTechMetallurgy = GameInfo.Technologies["TECH_METALLURGY"].ID

function AIFalcon(gPlayer)
	local pcCity = gPlayer:GetCapitalCity();
	local pPop = pcCity:GetPopulation();
	if gPlayer:HasPolicy(pChunkeyGame) then 
		pPop = (pPop * 1.5);
	end
	pUnit = gPlayer:InitUnit(FalconID, pcCity:GetX(), pcCity:GetY(), UNITAI_ATTACK);
	pUnit:JumpToNearestValidPlot();
	local BaseXP = pUnit:GetExperience();
	local BonusXP = (BaseXP + pPop);
	pUnit:SetExperience(BonusXP);
end

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	if (iTech == iTechSteel) or (iTech == iTechGunpowder) or (iTech == iTechMetallurgy) then
		local gPlayer = 0;
		local pTeam = 999;
		for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local pPlayer = Players[iPlayer]
			if (pPlayer:IsAlive()) then
				if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
					gPlayer = pPlayer;
					pTeam = pPlayer:GetTeam();
				end
			end
		end
		if gPlayer ~= 0 then
			if not gPlayer:IsHuman() then
				if pTeam == iTeam then
					AIFalcon(gPlayer);
					if (iTech == iTechGunpowder) then
						AIFalcon(gPlayer);
					end
				end
			end
		end
	end
end)

--Mound Temple
function AwardLatitude(pCity)
	local pPlot = pCity:Plot();
	local pCityY = pPlot:GetY();
	local LatCheck = 0;
	for _, iBuilding in pairs(LatBuildings) do
		if (pCity:IsHasBuilding(iBuilding)) then
			LatCheck = 1;
			break
		end
	end
	if LatCheck == 0 then
		if (pCityY > Lat3a) then
			pCity:SetNumRealBuilding(bMound04, 1);
		end
		if (pCityY > Lat2a) and (pCityY <= Lat3a) then
			pCity:SetNumRealBuilding(bMound13, 1);
		end
		if (pCityY > Lat1a) and (pCityY <= Lat2a) then
			pCity:SetNumRealBuilding(bMound22, 1);
		end
		if (pCityY > EqTop) and (pCityY <= Lat1a) then
			pCity:SetNumRealBuilding(bMound31, 1);
		end
		if (pCityY <= EqTop) and (pCityY >= EqBottom) then
			pCity:SetNumRealBuilding(bMound40, 1);
		end
		if (pCityY < EqBottom) and (pCityY >= Lat1) then
			pCity:SetNumRealBuilding(bMound31, 1);
		end
		if (pCityY < Lat1) and (pCityY >= Lat2) then
			pCity:SetNumRealBuilding(bMound22, 1);
		end
		if (pCityY < Lat2) and (pCityY >= Lat3) then
			pCity:SetNumRealBuilding(bMound13, 1);
		end
		if (pCityY < Lat3) then
			pCity:SetNumRealBuilding(bMound04, 1);
		end
	end
end

GameEvents.CityConstructed.Add(
function(player, city, building)
	local pPlayer = Players[player];
	local pTeam = pPlayer:GetTeam();
	local pCity = pPlayer:GetCityByID(city);
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
		if (building == bMoundTemple) then
			--
			----
			--
			if (load(pPlayer, "First Mound Temple") ~= true) then
				save(pPlayer, "First Mound Temple", true)
				local Plot2 = Map.GetPlot(MaxX, MaxY)
				Plot2:SetRevealed(pTeam, true);
				Plot2:UpdateFog();	
				local Plot1 = Map.GetPlot(0, 0)
				Plot1:SetRevealed(pTeam, true);
				Teams[pTeam]:SetMapCentering(true)
				Plot1:UpdateFog();		
				Game.UpdateFOW(true);
				UI.RequestMinimapBroadcast();
			end
			--
			----
			--
			AwardLatitude(pCity)
			--
			----
			--
		end
	end
end)

--More Cleanup
GameEvents.CityCaptureComplete.Add(
function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pPlot = Map.GetPlot(iX, iY);
	local pCity = pPlot:GetPlotCity();
	local iNewOwner = pCity:GetOwner();
	local pPlayer = Players[iNewOwner];
	if (pPlot:GetImprovementType() ~= iPlatformMound) then
		pPlot:SetImprovementType(-1)
	end
	if (pCity:IsHasBuilding(bFoodDummy)) then
		pCity:SetNumRealBuilding(bFoodDummy, 0);
	end
	if (pCity:IsHasBuilding(bMaintCount)) then
		pCity:SetNumRealBuilding(bMaintCount, 0);
	end
	if (pCity:IsHasBuilding(bUUProd)) then
		pCity:SetNumRealBuilding(bUUProd, 0);
	end
	for _, iBuilding in pairs(LatBuildings) do
		if (pCity:IsHasBuilding(iBuilding)) then
			pCity:SetNumRealBuilding(iBuilding, 0);
		end
	end
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
		if (pCity:IsHasBuilding(bMoundTemple)) then
			pCity:SetNumRealBuilding(bMoundTemple, 0);
		end
		if (pCity:IsHasBuilding(bTemple)) then
			pCity:SetNumRealBuilding(bTemple, 0);
		end			
	end		
end)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
			for pCity in pPlayer:Cities() do
				if (pCity:IsHasBuilding(bMoundTemple)) then
					local LatCheck = 0;
					for _, iBuilding in pairs(LatBuildings) do
						if (pCity:IsHasBuilding(iBuilding)) then
							LatCheck = 1;
							break
						end
					end
					if LatCheck == 0 then
						AwardLatitude(pCity)
					end
				elseif not (pCity:IsHasBuilding(bMoundTemple)) then
					for _, iBuilding in pairs(LatBuildings) do
						if (pCity:IsHasBuilding(iBuilding)) then
							pCity:SetNumRealBuilding(iBuilding, 0);
						end
					end
				end
			end
		elseif (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
			for pCity in pPlayer:Cities() do
				local pPlot = pCity:Plot();
				if (pPlot:GetImprovementType() ~= iPlatformMound) then
					pPlot:SetImprovementType(-1)
				end
				if (pCity:IsHasBuilding(bFoodDummy)) then
					pCity:SetNumRealBuilding(bFoodDummy, 0);
				end
				if (pCity:IsHasBuilding(bMaintCount)) then
					pCity:SetNumRealBuilding(bMaintCount, 0);
				end
				if (pCity:IsHasBuilding(bUUProd)) then
					pCity:SetNumRealBuilding(bUUProd, 0);
				end
				for _, iBuilding in pairs(LatBuildings) do
					if (pCity:IsHasBuilding(iBuilding)) then
						pCity:SetNumRealBuilding(iBuilding, 0);
					end
				end
			end
		end
	end
end)

--Settle
GameEvents.PlayerCityFounded.Add(
function(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	local pPlot = Map.GetPlot(iCityX, iCityY);
	local pCity = pPlot:GetPlotCity();
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
			local NewCont = pPlot:GetContinentArtType();
			local NewContCount = 0;
			for nCity in pPlayer:Cities() do
				local nPlot = nCity:Plot();
				if nPlot:GetContinentArtType() == NewCont then
					NewContCount = NewContCount + 1;
				end
			end
			if NewContCount == 1 then
				if (pPlot:GetImprovementType() == -1) then
					pPlot:SetImprovementType(iPlatformMound)
				end
			end
		end
	end
end)


