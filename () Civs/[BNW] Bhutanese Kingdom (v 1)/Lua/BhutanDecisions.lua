local Decisions_BhutanThongdrels = {}
	Decisions_BhutanThongdrels.Name = "TXT_KEY_DECISIONS_BHUTAN_THONGDREL"
	Decisions_BhutanThongdrels.Desc = "TXT_KEY_DECISIONS_BHUTAN_THONGDREL_DESC"
	HookDecisionCivilizationIcon(Decisions_BhutanThongdrels, "CIVILIZATION_BHUTAN")
	Decisions_BhutanThongdrels.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_BHUTAN"]) then return false, false end
		if load(pPlayer, "Decisions_BhutanThongdrels") == true then
			Decisions_BhutanThongdrels.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BHUTAN_THONGDREL_ENACTED_DESC")
			return false, false, true
		end
		local gold = math.ceil(500 * iMod)
		local faith = math.ceil(100 * iMod)
		local culture = math.ceil(50 * iMod)
		Decisions_BhutanThongdrels.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BHUTAN_THONGDREL_DESC", gold, faith, culture)
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetGold() < gold) then return true, false end
		if (pPlayer:CountNumBuildings(GameInfoTypes["BUILDING_ARTISTS_GUILD"])) < 1 then return true, false end

		return true, true
	end
	)
       
	Decisions_BhutanThongdrels.DoFunc = (
	function(pPlayer)
		local gold = math.ceil(500 * iMod)
		local faith = math.ceil(100 * iMod)
		local culture = math.ceil(50 * iMod)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
        pPlayer:ChangeJONSCulture(-culture)
        pPlayer:ChangeGold(-gold)
        pPlayer:ChangeFaith(-faith)
        for city in pPlayer:Cities() do
        	 if city:IsHasBuilding(GameInfoTypes["BUILDING_ARTISTS_GUILD"]) then
                city:SetNumRealBuilding(GameInfoTypes["BUILDING_THONGDREL_RELIGION"], 1)
                break
             end
        end

		save(pPlayer, "Decisions_BhutanThongdrels", true)
	end
	)
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_BHUTAN"], "Decisions_BhutanThongdrels", Decisions_BhutanThongdrels)
------------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_BhutanGNH = {}
	Decisions_BhutanGNH.Name = "TXT_KEY_DECISIONS_BHUTAN_GNH"
	Decisions_BhutanGNH.Desc = "TXT_KEY_DECISIONS_BHUTAN_GNH_DESC"
	HookDecisionCivilizationIcon(Decisions_BhutanGNH, "CIVILIZATION_BHUTAN")
	Decisions_BhutanGNH.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_BHUTAN"]) then return false, false end
		if load(pPlayer, "Decisions_BhutanGNH") == true then
			Decisions_BhutanGNH.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BHUTAN_GNH_ENACTED_DESC")
			return false, false, true
		end
		local gold = math.ceil(1000 * iMod)
		Decisions_BhutanGNH.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_BHUTAN_GNH_DESC", gold)
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetGold() < gold) then return true, false end
		if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_MODERN then return true, false end

		return true, true
	end
	)
       
	Decisions_BhutanGNH.DoFunc = (
	function(pPlayer)
		local gold = math.ceil(1000 * iMod)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
        pPlayer:ChangeGold(-gold)
        pPlayer:SetNumFreePolicies(1)
        pPlayer:SetNumFreePolicies(0)
        pPlayer:SetHasPolicy(GameInfoTypes["POLICY_BHUTAN_GNH"], true)
		save(pPlayer, "Decisions_BhutanGNH", true)
	end
	)
       
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_BHUTAN"], "Decisions_BhutanGNH", Decisions_BhutanGNH)