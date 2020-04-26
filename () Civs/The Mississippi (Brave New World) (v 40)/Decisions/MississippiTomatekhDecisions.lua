print("Mississippi Decisions")

--Chunkey
local pChunkeyGame = GameInfoTypes.POLICY_CHUNKEY_GAME_MOD;
local tWheel = GameInfoTypes.TECH_METALLURGY;

local Decisions_MississippianInventChunkey = {}
	Decisions_MississippianInventChunkey.Name = "TXT_KEY_DECISIONS_CHUNKEY_FIELD"
	Decisions_MississippianInventChunkey.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHUNKEY_FIELD_DESC")
	HookDecisionCivilizationIcon(Decisions_MississippianInventChunkey, "CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH")
	Decisions_MississippianInventChunkey.Weight = nil
	Decisions_MississippianInventChunkey.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH"]) then return false, false end
		if load(pPlayer, "Decisions_MississippianInventChunkey") == true then
			Decisions_MississippianInventChunkey.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHUNKEY_FIELD_ENACTED_DESC")
			return false, false, true
		end		

		local iCost = math.ceil(50 * iMod)
		Decisions_MississippianInventChunkey.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHUNKEY_FIELD_DESC", iCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if (pPlayer:GetJONSCulture() < iCost) then return true, false end

		local bStadium = GameInfoTypes.BUILDINGCLASS_COLOSSEUM;
		local iSCount = pPlayer:GetBuildingClassCount(bStadium)
		if iSCount < 3 then return true, false end

		local pTeam = pPlayer:GetTeam();
		if (Teams[pTeam]:IsHasTech(tWheel)) then return true, false end

		return true, true
	end
	)
	
	Decisions_MississippianInventChunkey.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(50 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		if not pPlayer:HasPolicy(pChunkeyGame) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pChunkeyGame, true);
		end

		save(pPlayer, "Decisions_MississippianInventChunkey", true)

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH"], "Decisions_MississippianInventChunkey", Decisions_MississippianInventChunkey)

--River
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

local RiverPlots = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if pPlot:IsRiver() then
		local sKey = CompilePlotID(pPlot)
		RiverPlots[sKey] = -1
    end
end

local pRiverPolities = GameInfoTypes.POLICY_RIVER_POLITIES_MOD;
local tCivilService = GameInfoTypes.TECH_CIVIL_SERVICE;

local Decisions_MississippianBigRiver = {}
	Decisions_MississippianBigRiver.Name = "TXT_KEY_DECISIONS_RIVER_POLITIES"
	Decisions_MississippianBigRiver.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIVER_POLITIES_DESC")
	HookDecisionCivilizationIcon(Decisions_MississippianBigRiver, "CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH")
	Decisions_MississippianBigRiver.Weight = nil
	Decisions_MississippianBigRiver.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH"]) then return false, false end
		if load(pPlayer, "Decisions_MississippianBigRiver") == true then
			Decisions_MississippianBigRiver.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIVER_POLITIES_ENACTED_DESC")
			return false, false, true
		end		

		local MapSize = Map.GetNumPlots();
		local Tiny = 2016
		local Huge = 10240
		local iRiverTiles = 20;
		if (MapSize > Tiny) and (MapSize < Huge) then
			iRiverTiles = 15;
		end
		if MapSize <= Tiny then
			iRiverTiles = 10;
		end

		Decisions_MississippianBigRiver.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIVER_POLITIES_DESC", iRiverTiles)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 3) then return true, false end

		local RiverCheck = 0;
		for pCity in pPlayer:Cities() do
			local pPlot = pCity:Plot();
			if pPlot:IsRiver() then
				RiverCheck = RiverCheck + 1;
			end
		end
		if (RiverCheck < 2) then return true, false end	

		local RiverCount = 0;
		local pID = pPlayer:GetID();
		for sKey, tTable in pairs(RiverPlots) do
			local pPlot = DecompilePlotID(sKey)
			if pPlot:GetOwner() ~= -1 then			
				if pPlot:GetOwner() == pID then 
					RiverCount = RiverCount + 1;
				end
			end
		end
		if (RiverCount < iRiverTiles) then return true, false end	

		local pTeam = pPlayer:GetTeam();
		if not (Teams[pTeam]:IsHasTech(tCivilService)) then return true, false end

		return true, true
	end
	)
	
	Decisions_MississippianBigRiver.DoFunc = (
	function(pPlayer)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -3)

		if not pPlayer:HasPolicy(pRiverPolities) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pRiverPolities, true);
		end

		save(pPlayer, "Decisions_MississippianBigRiver", true)

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH"], "Decisions_MississippianBigRiver", Decisions_MississippianBigRiver)