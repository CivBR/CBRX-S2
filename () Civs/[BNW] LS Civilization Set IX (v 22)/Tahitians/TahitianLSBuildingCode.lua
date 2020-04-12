print ("Blue Sky - Tahitian Building code")

local ValidPlayerTable = {}
local htT = {}
local dummy = GameInfoTypes.BUILDING_DUMMY_LS_TAHITI;
local MCT = {}
local speed = Game.GetGameSpeedType() + 1;
local hSpeedT = {0.75, 0.9, 1, 1.25}
local bTahiti = GameInfoTypes.BUILDING_LS_MARAE

for i, v in pairs(Players) do
	if not v:IsBarbarian() then
		if not v:IsMinorCiv() then
			if v:IsEverAlive() then
				MCT[v:GetTeam()] = 1;
			end
		end
	end
end

function GiveTableOfValidBuildingPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
		for iCity in Players[player]:Cities() do
			if iCity:IsHasBuilding(bTahiti) then
				htT[iCity:Plot():GetPlotIndex()] = iCity:GetPopulation();
			end
		end
	end
end

function CanHaveBonus(iCity)
	local index = iCity:Plot():GetPlotIndex();
	if not htT[index] then
		htT[index] = iCity:GetPopulation();
		return true;
	end
	if iCity:GetPopulation() ~= htT[index] then
		if iCity:GetPopulation() < htT[index] then
			htT[index] = iCity:GetPopulation();
			return true
		else
			iCity:SetNumRealBuilding(dummy, 0)
			htT[index] = iCity:GetPopulation();
			return false
		end
	end
	return true;
end

function GetTahModifier(iPlot, iTeam)
	for hTeam, sth in pairs(MCT) do
		if hTeam ~= iTeam then
			if iPlot:IsRevealed(hTeam) then
				return 1;
			end
		end
	end
	return 3;
end

function GetTahCityPopModifier(iPop)
	return math.max(1, (15 - iPop) / 7)
end

function GetBonusIncrease(iCity, iPlayer)
	local base = (hSpeedT[speed] or 0.75) * GetTahModifier(iCity:Plot(), Players[iPlayer]:GetTeam()) * GetTahCityPopModifier(iCity:GetPopulation());
	local gTurn = Game.GetGameTurn();
	local bBonus = math.floor(gTurn * base) - math.floor((gTurn - 1) * base);
	return bBonus;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		for iCity in Players[iPlayer]:Cities() do
			if iCity:IsHasBuilding(bTahiti) and CanHaveBonus(iCity) then
				iCity:SetNumRealBuilding(dummy, math.min(33, iCity:GetNumRealBuilding(dummy) + GetBonusIncrease(iCity, iPlayer)))
			else
				iCity:SetNumRealBuilding(dummy, 0)
			end
		end
	end
end)