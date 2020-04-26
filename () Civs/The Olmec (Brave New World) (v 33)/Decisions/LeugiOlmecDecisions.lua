print("Olmec Decisions")

local tCalendar = GameInfoTypes.TECH_CALENDAR;
local tIndustrialization = GameInfoTypes.TECH_INDUSTRIALIZATION;
local bChampionDummy = GameInfoTypes.BUILDING_LEUGI_OLMEC_DECISIONS_DUMMY;
local bRubberDummy = GameInfoTypes.BUILDING_LEUGI_OLMEC_RUBBER_DECISIONS_DUMMY;
local bColosseum = GameInfoTypes.BUILDING_COLOSSEUM;
local bcColosseum = GameInfoTypes.BUILDINGCLASS_COLOSSEUM;
local iPlantation = GameInfoTypes.IMPROVEMENT_PLANTATION;

--Invent Rubber

local Decisions_OlmecRubber = {}
	Decisions_OlmecRubber.Name = "TXT_KEY_DECISIONS_OLMEC_RUBBER"
	Decisions_OlmecRubber.Desc = "TXT_KEY_DECISIONS_OLMEC_RUBBER_DESC"
	HookDecisionCivilizationIcon(Decisions_OlmecRubber, "CIVILIZATION_LEUGI_OLMEC")
	Decisions_OlmecRubber.Weight = nil
	Decisions_OlmecRubber.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_OLMEC"]) then return false, false end
		if load(pPlayer, "Decisions_OlmecRubber") == true then
			Decisions_OlmecRubber.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OLMEC_RUBBER_ENACTED_DESC")
			return false, false, true
		end		

		local iTech = GameInfoTypes.TECH_AGRICULTURE
		--local iCost = math.ceil(pPlayer:GetResearchCost(iTech) * 2.5)
		local iCost = math.ceil(50 * iMod)
		Decisions_OlmecRubber.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OLMEC_RUBBER_DESC", iCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		local cPlantations = pPlayer:GetImprovementCount(iPlantation)
		if cPlantations < 4 then return true, false end
		if (Teams[pPlayer:GetTeam()]:IsHasTech(iTech)) and (pPlayer:GetResearchProgress(pPlayer:GetCurrentResearch()) >= iCost) then
			return true, true
		else
			return true, false
		end
		
		local bJungleCount = 0;
		local pID = pPlayer:GetID()
		local fJungle = GameInfoTypes.FEATURE_JUNGLE;

		for pCity in pPlayer:Cities() do
			local plotX = pCity:GetX();
			local plotY = pCity:GetY();
			for iDX = -2, 2 do
				for iDY = -2, 2 do
					local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, 2);
					if pTargetPlot then
						if (pTargetPlot:GetOwner() == pID) then
							if (pTargetPlot:GetFeatureType() == fJungle) then
								bJungleCount = bJungleCount + 1;
								break
							end
						end
					end
				end
			end
		end
		if bJungleCount <= 0 then return true, false end

		return true, true
	end
	)
	
	Decisions_OlmecRubber.DoFunc = (
	function(pPlayer)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		local iTech = GameInfoTypes.TECH_AGRICULTURE
		--local iCost = math.ceil(pPlayer:GetResearchCost(iTech) * 2.5)	
		local iCost = math.ceil(50 * iMod)
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -iCost, pPlayer:GetID())

		for pCity in pPlayer:Cities() do
			local pTeam = pPlayer:GetTeam();
			if (Teams[pTeam]:IsHasTech(tIndustrialization)) then
				if (pCity:GetNumBuilding(bRubberDummy) < 2) then
					pCity:SetNumRealBuilding(bRubberDummy, 2);
				end
			elseif not (Teams[pTeam]:IsHasTech(tIndustrialization)) then
				if not pCity:IsHasBuilding(bRubberDummy) then
					pCity:SetNumRealBuilding(bRubberDummy, 1);
				end
			end
		end

		save(pPlayer, "Decisions_OlmecRubber", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_OLMEC"], "Decisions_OlmecRubber", Decisions_OlmecRubber)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			if load(pPlayer, "Decisions_OlmecRubber") == true then
				for pCity in pPlayer:Cities() do
					local pTeam = pPlayer:GetTeam();
					if (Teams[pTeam]:IsHasTech(tIndustrialization)) then
						if (pCity:GetNumBuilding(bRubberDummy) < 2) then
							pCity:SetNumRealBuilding(bRubberDummy, 2);
						end
					elseif not (Teams[pTeam]:IsHasTech(tIndustrialization)) then
						if not pCity:IsHasBuilding(bRubberDummy) then
							pCity:SetNumRealBuilding(bRubberDummy, 1);
						end
					end
				end
			end
		end
	end
end)

--Ballgame Champions

local Decisions_OlmecChampions = {}
	Decisions_OlmecChampions.Name = "TXT_KEY_DECISIONS_OLMEC_BALLGAME_CHAMPIONS"
	Decisions_OlmecChampions.Desc = "TXT_KEY_DECISIONS_OLMEC_BALLGAME_CHAMPIONS_DESC"
	HookDecisionCivilizationIcon(Decisions_OlmecChampions, "CIVILIZATION_LEUGI_OLMEC")
	Decisions_OlmecChampions.Weight = nil
	Decisions_OlmecChampions.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_OLMEC"]) then return false, false end
		if load(pPlayer, "Decisions_OlmecChampions") == true then
			Decisions_OlmecChampions.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OLMEC_BALLGAME_CHAMPIONS_ENACTED_DESC")
			return false, false, true
		end		

		local iCost = math.ceil(200 * iMod)
		Decisions_OlmecChampions.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OLMEC_BALLGAME_CHAMPIONS_DESC", iCost)

		if (pPlayer:GetGold() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		local iColosseum = pPlayer:GetBuildingClassCount(bcColosseum);
		if iColosseum < 3 then return true, false end
		--local pTeam = pPlayer:GetTeam();
		--if not (Teams[pTeam]:IsHasTech(tCalendar)) then return true, false end
		
		if load(pPlayer, "Decisions_OlmecRubber") ~= true then return true, false end

		return true, true
	end
	)
	
	Decisions_OlmecChampions.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iCost);
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(bColosseum) then
				if not (pCity:IsHasBuilding(bChampionDummy)) then
					pCity:SetNumRealBuilding(bChampionDummy, 1);
				end
			end
		end

		local pcCity = pPlayer:GetCapitalCity();
		if (pcCity:GetWeLoveTheKingDayCounter() >= 1) then
			pcCity:ChangeWeLoveTheKingDayCounter(20)
			pcCity:SetResourceDemanded(-1)
		elseif (pcCity:GetWeLoveTheKingDayCounter() <= 0) then
			pcCity:SetWeLoveTheKingDayCounter(20)
			pcCity:SetResourceDemanded(-1)
		end

		local pID = pPlayer:GetID()
		if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
			Events.GameplayAlertMessage("" .. Locale.ConvertTextKey(pcCity:GetName()) .. " loves its King!");
		end

		--pPlayer:ChangeNumFreeGreatPeople(1)
		LuaEvents.Tomatekh_ShowOlmecPersonsPopup()

		save(pPlayer, "Decisions_OlmecChampions", true)

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_OLMEC"], "Decisions_OlmecChampions", Decisions_OlmecChampions)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			if load(pPlayer, "Decisions_OlmecChampions") == true then
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(bColosseum) then
						if not (pCity:IsHasBuilding(bChampionDummy)) then
							pCity:SetNumRealBuilding(bChampionDummy, 1);
						end
					elseif not (pCity:IsHasBuilding(bColosseum)) then
						if pCity:IsHasBuilding(bChampionDummy) then
							pCity:SetNumRealBuilding(bChampionDummy, 0);
						end
					end
				end
			end
		end
	end
end)