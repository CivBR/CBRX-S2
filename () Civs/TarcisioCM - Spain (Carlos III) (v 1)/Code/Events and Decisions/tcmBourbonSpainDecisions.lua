local Decisions_TCM_Bourbon_Spain_Intendancies = {}
	Decisions_TCM_Bourbon_Spain_Intendancies.Name = "TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_INTENDANCIES"
	Decisions_TCM_Bourbon_Spain_Intendancies.Desc = "TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_INTENDANCIES_DESC"
	HookDecisionCivilizationIcon(Decisions_TCM_Bourbon_Spain_Intendancies, "CIVILIZATION_TCM_BOURBON_SPAIN")
	Decisions_TCM_Bourbon_Spain_Intendancies.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"]) then return false, false end
		if load(pPlayer, "Decisions_TCM_Bourbon_Spain_Intendancies") == true then
			Decisions_TCM_Bourbon_Spain_Intendancies.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_INTENDANCIES_ENACTED_DESC")
			return false, false, true
		end

		local iCurrentEra = pPlayer:GetCurrentEra()
		local culture = math.ceil((pPlayer:GetNextPolicyCost() * 40) / 100) + 100
		
		Decisions_TCM_Bourbon_Spain_Intendancies.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_INTENDANCIES_DESC", culture)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetJONSCulture() < culture) then return true, false end
		local capital = pPlayer:GetCapitalCity()
		local captialPlot = capital:Plot()
		local capitalContinent = captialPlot:GetContinentArtType()
		local numCities = 0
		for city in pPlayer:Cities() do
			local plot = city:Plot()
			local continent = plot:GetContinentArtType()
			if continent ~= capitalContinent then
				numCities = numCities + 1
				if numCities >= 4 then
					break
				end
			end
		end
		if numCities < 4 then return true, false end

		return true, true
	end
	)
       
	Decisions_TCM_Bourbon_Spain_Intendancies.DoFunc = (
	function(pPlayer)
		local culture = math.ceil((pPlayer:GetNextPolicyCost() * 50) / 100) + 100
		pPlayer:ChangeJONSCulture(-culture)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_TCM_BOURBON_INTENDANCY"], true)

		save(pPlayer, "Decisions_TCM_Bourbon_Spain_Intendancies", true)
	end
	)
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"], "Decisions_TCM_Bourbon_Spain_Intendancies", Decisions_TCM_Bourbon_Spain_Intendancies)

local Decisions_TCM_Bourbon_Spain_Pacte = {}
	Decisions_TCM_Bourbon_Spain_Pacte.Name = "TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_PACT"
	Decisions_TCM_Bourbon_Spain_Pacte.Desc = "TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_PACT_DESC"
	HookDecisionCivilizationIcon(Decisions_TCM_Bourbon_Spain_Pacte, "CIVILIZATION_TCM_BOURBON_SPAIN")
	Decisions_TCM_Bourbon_Spain_Pacte.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"]) then return false, false end
		if load(pPlayer, "Decisions_TCM_Bourbon_Spain_Pacte") == true then
			Decisions_TCM_Bourbon_Spain_Pacte.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_PACT_ENACTED_DESC")
			return false, false, true
		end

		local gold = math.ceil(700 * iMod)
		
		Decisions_TCM_Bourbon_Spain_Pacte.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_BOURBON_SPAIN_PACT_DESC", gold)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetGold() < gold) then return true, false end
		local team = Teams[pPlayer:GetTeam()]
		if team:GetDefensivePactCount() < 1 then return true, false end
		
		return true, true
	end
	)
       
	Decisions_TCM_Bourbon_Spain_Pacte.DoFunc = (
	function(pPlayer)
		local gold = math.ceil(700 * iMod)
		pPlayer:ChangeGold(-gold)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes["POLICY_TCM_BOURBON_PACTE"], true)

		save(pPlayer, "Decisions_TCM_Bourbon_Spain_Pacte", true)
	end
	)
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_TCM_BOURBON_SPAIN"], "Decisions_TCM_Bourbon_Spain_Pacte", Decisions_TCM_Bourbon_Spain_Pacte)