local Decisions_TCM_Ptolemies_Army = {}
	Decisions_TCM_Ptolemies_Army.Name = "TXT_KEY_DECISIONS_TCM_PTOLEMIES_ARMY"
	Decisions_TCM_Ptolemies_Army.Desc = "TXT_KEY_DECISIONS_TCM_PTOLEMIES_ARMY_DESC"
	HookDecisionCivilizationIcon(Decisions_TCM_Ptolemies_Army, "CIVILIZATION_TCM_PTOLEMIES")
	Decisions_TCM_Ptolemies_Army.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_TCM_PTOLEMIES"]) then return false, false end
		if load(pPlayer, "Decisions_TCM_Ptolemies_Army") == true then
			Decisions_TCM_Ptolemies_Army.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_PTOLEMIES_ARMY_ENACTED_DESC")
			return false, false, true
		end
		Decisions_TCM_Ptolemies_Army.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_PTOLEMIES_ARMY_DESC")

		return true, true
	end
	)
       
	Decisions_TCM_Ptolemies_Army.DoFunc = (
	function(pPlayer)
		for city in pPlayer:Cities() do
			local unit = city:GetGarrisonedUnit()
			if unit then
				city:ChangePopulation(1)
				unit:SetDamage(999999)
			end
		end
		save(pPlayer, "Decisions_TCM_Ptolemies_Army", true)
	end
	)
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_TCM_PTOLEMIES"], "Decisions_TCM_Ptolemies_Army", Decisions_TCM_Ptolemies_Army)

local Decisions_TCM_Ptolemies_Serapis = {}
	Decisions_TCM_Ptolemies_Serapis.Name = "TXT_KEY_DECISIONS_TCM_PTOLEMIES_SERAPIS"
	Decisions_TCM_Ptolemies_Serapis.Desc = "TXT_KEY_DECISIONS_TCM_PTOLEMIES_SERAPIS_DESC"
	HookDecisionCivilizationIcon(Decisions_TCM_Ptolemies_Serapis, "CIVILIZATION_TCM_PTOLEMIES")
	Decisions_TCM_Ptolemies_Serapis.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_TCM_PTOLEMIES"]) then return false, false end
		if load(pPlayer, "Decisions_TCM_Ptolemies_Serapis") == true then
			Decisions_TCM_Ptolemies_Serapis.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_PTOLEMIES_SERAPIS_ENACTED_DESC")
			return false, false, true
		end
		local faith = math.ceil(200 * iMod)
		Decisions_TCM_Ptolemies_Serapis.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TCM_PTOLEMIES_SERAPIS_DESC", faith)
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetFaith() < faith) then return true, false end
		return true, true
	end
	)
       
	Decisions_TCM_Ptolemies_Serapis.DoFunc = (
	function(pPlayer)
		local faith = math.ceil(200 * iMod)
		pPlayer:ChangeFaith(-faith)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
        pPlayer:SetNumFreePolicies(0)
        pPlayer:SetHasPolicy(GameInfoTypes["POLICY_TCM_SERAPIS_POLICY"], true)
		save(pPlayer, "Decisions_TCM_Ptolemies_Serapis", true)
	end
	)
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_TCM_PTOLEMIES"], "Decisions_TCM_Ptolemies_Serapis", Decisions_TCM_Ptolemies_Serapis)