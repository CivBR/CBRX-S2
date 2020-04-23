--=======================================================================================================================
print("NorthYuan Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MOD CHECKS
-------------------------------------------------------------------------------------------------------------------------
function JFD_IsEDActive()
	local iEDID = "1f941088-b185-4159-865c-472df81247b2"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == iEDID) then
			return true
		end
	end
	return false
end
local bIsEDActive = JFD_IsEDActive()
-------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
-------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
local civilizationID  = GameInfoTypes.CIVILIZATION_THP_NORTHYUAN
local mathCeil = math.ceil

-------------------------------------------------------------------------------------------------------------------------
-- NorthYuan: Impose Symbolic Laws
-------------------------------------------------------------------------------------------------------------------------
local eraMed = GameInfoTypes.ERA_MEDIEVAL

local Decisions_THP_NorthYuan_OiratLaw = {}
	Decisions_THP_NorthYuan_OiratLaw.Name = "TXT_KEY_DECISIONS_THP_NORTHYUAN_OIRATLAW"
	Decisions_THP_NorthYuan_OiratLaw.Desc = "TXT_KEY_DECISIONS_THP_NORTHYUAN_OIRATLAW_DESC"
	HookDecisionCivilizationIcon(Decisions_THP_NorthYuan_OiratLaw, "CIVILIZATION_THP_NORTHYUAN")
	Decisions_THP_NorthYuan_OiratLaw.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_THP_NorthYuan_OiratLaw") then
			Decisions_THP_NorthYuan_OiratLaw.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NORTHYUAN_OIRATLAW_ENACTED_DESC")
			return false, false, true
		end
		local goldCost = mathCeil(300*iMod)
		Decisions_THP_NorthYuan_OiratLaw.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NORTHYUAN_OIRATLAW_DESC", goldCost)
		if player:GetCurrentEra() < eraMed then return true, false end
		if player:GetGold() < goldCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)

	Decisions_THP_NorthYuan_OiratLaw.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(300*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeGold(-goldCost)
		save(player, "Decisions_THP_NorthYuan_OiratLaw", true)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_THP_NORTHYUAN_OIRATLAW", player:GetName(), player:GetCivilizationShortDescription(), player:GetCivilizationAdjective()))
	end
	)

	Decisions_THP_NorthYuan_OiratLaw.Monitors = {}
	Decisions_THP_NorthYuan_OiratLaw.Monitors[GameEvents.CityConstructed] = (
	function(playerID, cityID)
		local pPlayer = Players[playerID]
		if load(pPlayer, "Decisions_THP_NorthYuan_OiratLaw") then
			local cCity = pPlayer:GetCityByID(cityID)
			if cCity:IsPuppet() then
				local iCultureUpdate = 3 * cCity:GetPopulation()
				pPlayer:ChangeJONSCulture(iCultureUpdate)
				if pPlayer:IsHuman() then
					Events.GameplayAlertMessage("The puppeted " .. cCity:GetName() .. " has completed a building, yielding " .. iCultureUpdate .. " [ICON_CULTURE] Culture!")
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_THP_NorthYuan_OiratLaw", Decisions_THP_NorthYuan_OiratLaw)

-------------------------------------------------------------------------------------------------------------------------
-- NorthYuan: Develop the NewFaith
-------------------------------------------------------------------------------------------------------------------------
local bPagoda = GameInfoTypes.BUILDING_PAGODA
local eraRen = GameInfoTypes.ERA_RENAISSANCE

function IsTradingWithHolyCity(pPlayer)
	local tTrades = pPlayer:GetTradeRoutes()
	for k, vTrade in pairs(tTrades) do
		if vTrade.FromID ~= vTrade.ToID then
			if vTrade.ToCity:IsHolyCityAnyReligion() then
				return true
			end
		end
	end
	return false
end

local Decisions_THP_NorthYuan_NewFaith = {}
	Decisions_THP_NorthYuan_NewFaith.Name = "TXT_KEY_DECISIONS_THP_NORTHYUAN_NEWFAITH"
	Decisions_THP_NorthYuan_NewFaith.Desc = "TXT_KEY_DECISIONS_THP_NORTHYUAN_NEWFAITH_DESC"
	HookDecisionCivilizationIcon(Decisions_THP_NorthYuan_NewFaith, "CIVILIZATION_THP_NORTHYUAN")
	Decisions_THP_NorthYuan_NewFaith.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_THP_NorthYuan_NewFaith") then
			Decisions_THP_NorthYuan_NewFaith.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NORTHYUAN_NEWFAITH_ENACTED_DESC")
			return false, false, true
		end
		local goldCost = mathCeil(400*iMod)
		Decisions_THP_NorthYuan_NewFaith.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NORTHYUAN_NEWFAITH_DESC", goldCost)
		if player:GetCurrentEra() < eraRen then return true, false end
		if not IsTradingWithHolyCity(player) then return true, false end
		if player:GetGold() < goldCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)

	Decisions_THP_NorthYuan_NewFaith.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(400*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:ChangeGold(-goldCost)
		for k, vTrade in pairs(player:GetTradeRoutes()) do
			vTrade.FromCity:SetNumRealBuilding(bPagoda, 1)
		end
		save(player, "Decisions_THP_NorthYuan_NewFaith", true)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_THP_NORTHYUAN_NEWFAITH", player:GetName(), player:GetCivilizationShortDescription(), player:GetCivilizationAdjective()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_THP_NorthYuan_NewFaith", Decisions_THP_NorthYuan_NewFaith)

--
--
