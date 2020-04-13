-- Decisions
-- Author: DJSHenninger
-- DateCreated: 16/3/2015 3:15:39 PM
--------------------------------------------------------------------------------------------------------------------------
-- Invest in the Nigerian Film Industry
--------------------------------------------------------------------------------------------------------------------------
local Decisions_CLNigerianFilmIndustry = {}
	Decisions_CLNigerianFilmIndustry.Name = "TXT_KEY_DECISIONS_CL_NIGERIAN_FILM_INDUSTRY"
	Decisions_CLNigerianFilmIndustry.Desc = "TXT_KEY_DECISIONS_CL_NIGERIAN_FILM_INDUSTRY_DESC"
	HookDecisionCivilizationIcon(Decisions_CLNigerianFilmIndustry, "CIVILIZATION_CL_NIGERIA")
	Decisions_CLNigerianFilmIndustry.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_CL_NIGERIA"] then 
		return false, false 
		end
		if load(player, "Decisions_CLNigerianFilmIndustry") == true then
			Decisions_CLNigerianFilmIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_NIGERIAN_FILM_INDUSTRY_ENACTED_DESC")
			return false, false, true 
		end

		local goldCost = math.ceil(850 * iMod)
		local cultureCost = math.ceil(500 * iMod)
		Decisions_CLNigerianFilmIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_NIGERIAN_FILM_INDUSTRY_DESC", goldCost, cultureCost)

		if player:GetNumResourceAvailable(iMagistrate, false) < 2 	then return true, false end
		if player:GetCurrentEra() < GameInfoTypes["ERA_MODERN"]	then return true, false end

		local bBroadcast = false
		if player:GetCapitalCity():GetNumRealBuilding(GameInfoTypes["BUILDING_BROADCAST_TOWER"]) > 0 then
			bBroadcast = true
		end
		
		if bBroadcast and (player:GetJONSCulture() >= cultureCost) and (player:GetGold() >= goldCost) then
			return true, true
		else 
			return true, false
		end
	end
	)

Decisions_CLNigerianFilmIndustry.DoFunc = (
	function(player)
		local goldCost = math.ceil(850 * iMod)
		local cultureCost = math.ceil(850 * iMod)
		player:ChangeGold(-goldCost)
		player:ChangeJONSCulture(-cultureCost)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes["POLICY_CL_NIGERIAN_FILM_INDUSTRY"], true)
		save(player, "Decisions_CLNigerianFilmIndustry", true)
	end
	)

	Decisions_CLNigerianFilmIndustry.Monitors = {}
	Decisions_CLNigerianFilmIndustry.Monitors[GameEvents.PlayerDoTurn] =  (
	function(playerID)
		local player = Players[playerID]
		if (player:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CL_NIGERIA) then return end
		if load(player, "Decisions_CLNigerianFilmIndustry") == true then
			for city in player:Cities() do
				local cultureBoost = math.floor(city:GetNumGreatWorks())
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_CL_CULTURE_NIGERIAN_FILM_INDUSTRY"], cultureBoost)
				if (city:GetNumRealBuilding(GameInfoTypes["BUILDING_BROADCAST_TOWER"]) > 0) then
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_CL_GREAT_PEOPLE_NIGERIAN_FILM_INDUSTRY"], 1)
				else
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_CL_GREAT_PEOPLE_NIGERIAN_FILM_INDUSTRY"], 0)
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_CL_NIGERIA"], "Decisions_CLNigerianFilmIndustry", Decisions_CLNigerianFilmIndustry)
--------------------------------------------------------------------------------------------------------------------------
-- Implement the Four Imperatives
--------------------------------------------------------------------------------------------------------------------------
local Decisions_CLFourImperatives = {}
	Decisions_CLFourImperatives.Name = "TXT_KEY_DECISIONS_CL_FOUR_IMPERATIVES"
	Decisions_CLFourImperatives.Desc = "TXT_KEY_DECISIONS_CL_FOUR_IMPERATIVES_DESC"
	HookDecisionCivilizationIcon(Decisions_CLFourImperatives, "CIVILIZATION_CL_NIGERIA")
	Decisions_CLFourImperatives.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_CL_NIGERIA"] then 
		return false, false 
		end
		if load(player, "Decisions_CLFourImperatives") == true then
			Decisions_CLFourImperatives.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_FOUR_IMPERATIVES_ENACTED_DESC")
			return false, false, true 
		end

		local cultureCost = math.ceil(250 * iMod)
		Decisions_CLFourImperatives.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CL_FOUR_IMPERATIVES_DESC", cultureCost)

		if player:GetNumResourceAvailable(iMagistrate, false) < 1 	then return true, false end

		local bNumCities = 0
		for city in player:Cities() do
			if (city:GetPopulation() >= 10) then
				bNumCities = bNumCities + 1
			end
		end

		local bUnhappiness = false
		if player:GetUnhappiness() > player:GetHappiness() then
			bUnhappiness = true
		end

		if (bNumCities >= 3) and bUnhappiness and (player:GetJONSCulture() >= cultureCost) then
			return true, true
		else 
			return true, false
		end
	end
	)

Decisions_CLFourImperatives.DoFunc = (
	function(player)
		local cultureCost = math.ceil(250 * iMod)
		player:ChangeJONSCulture(-cultureCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(GameInfoTypes["POLICY_CL_FOUR_IMPERATIVES"], true)
		save(player, "Decisions_CLFourImperatives", true)
	end
	)

	Decisions_CLFourImperatives.Monitors = {}
	Decisions_CLFourImperatives.Monitors[GameEvents.PlayerDoTurn] =  (
	function(playerID)
		local player = Players[playerID]
		if (player:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CL_NIGERIA) then return end
		if load(player, "Decisions_CLFourImperatives") == true then
			for city in player:Cities() do
				if (city:GetPopulation() >= 10) then
					local happBoost = math.floor(city:GetPopulation() / 2)
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_CL_FOUR_IMPERATIVES"], happBoost)
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_CL_NIGERIA"], "Decisions_CLFourImperatives", Decisions_CLFourImperatives)