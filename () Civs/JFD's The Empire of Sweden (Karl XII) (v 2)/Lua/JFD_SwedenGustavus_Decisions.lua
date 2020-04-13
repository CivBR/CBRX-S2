-- JFD_SwedenGustavus_Decisions
-- Author: JFD
-- DateCreated: 6/14/2015 12:40:54 AM
--=======================================================================================================================
print("JFD's Sweden (Gustavus Adolphus) Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
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
-- Civ Specific Decisions
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilizationSwedenGustavusID  = GameInfoTypes["CIVILIZATION_JFD_SWEDEN_GUSTAV"]
local mathCeil						= math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Sweden (Gustavus): Indelningsverket
--------------------------------------------------------------------------------------------------------------------------
local policySwedenGustavusOrdinanceOfAlsnoID = GameInfoTypes["POLICY_DECISIONS_JFD_SWEDEN_ORDINANCE_ALSNO"]
local techMetallurgyID	 = GameInfoTypes["TECH_METALLURGY"]
local unitGreatGeneralID = GameInfoTypes["UNIT_GREAT_GENERAL"]
tDecisions.Decisions_SwedenIndelningsverket = nil
local Decisions_SwedenIndelningsverket = {}
	Decisions_SwedenIndelningsverket.Name = "TXT_KEY_DECISIONS_SWEDENINDELNINGSVERKET"
	Decisions_SwedenIndelningsverket.Desc = "TXT_KEY_DECISIONS_SWEDENINDELNINGSVERKET_DESC"
	HookDecisionCivilizationIcon(Decisions_SwedenIndelningsverket, "CIVILIZATION_JFD_SWEDEN_GUSTAV")
	Decisions_SwedenIndelningsverket.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationSwedenGustavusID then return false, false end
		if load(player, "Decisions_SwedenIndelningsverket") == true then
			Decisions_SwedenIndelningsverket.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SWEDENINDELNINGSVERKET_ENACTED_DESC")
			return false, false, true
		end
		Decisions_SwedenIndelningsverket.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SWEDENINDELNINGSVERKET_DESC")
		if (player:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (Teams[player:GetTeam()]:IsHasTech(techMetallurgyID)) and (player:GetCapitalCity() ~= nil) then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_SwedenIndelningsverket.DoFunc = (
	function(player)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policySwedenGustavusOrdinanceOfAlsnoID, true)
		InitUnitFromCity(player:GetCapitalCity(), unitGreatGeneralID, 1)
		save(player, "Decisions_SwedenIndelningsverket", true)		
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationSwedenGustavusID, "Decisions_SwedenIndelningsverket", Decisions_SwedenIndelningsverket)
-------------------------------------------------------------------------------------------------------------------------
-- Sweden (Gustavus): Kung och Riksdag
-------------------------------------------------------------------------------------------------------------------------
tDecisions.Decisions_SwedishRiksdag = nil
local Decisions_SwedishRiksdag = {}
	Decisions_SwedishRiksdag.Name = "TXT_KEY_DECISIONS_SWEDISHRIKSDAG"
	Decisions_SwedishRiksdag.Desc = "TXT_KEY_DECISIONS_SWEDISHRIKSDAG_DESC"
	HookDecisionCivilizationIcon(Decisions_SwedishRiksdag, "CIVILIZATION_JFD_SWEDEN_GUSTAV")
	Decisions_SwedishRiksdag.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationSwedenGustavusID then return false, false end
		if load(player, "Decisions_SwedishRiksdag") == true then
			Decisions_SwedishRiksdag.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SWEDISHRIKSDAG_ENACTED_DESC")
			return false, false, true
		end
		
		local cultureCost = math.ceil(450 * iMod)
		Decisions_SwedishRiksdag.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SWEDISHRIKSDAG_DESC", cultureCost)
		
		local iEra = player:GetCurrentEra()
		if not(iEra == GameInfoTypes.ERA_RENAISSANCE or iEra == GameInfoTypes.ERA_INDUSTRIAL) then
			return true, false
		end
		
		if (player:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (player:GetCapitalCity() == nil) then return true, false end		
		if player:GetJONSCulture() < cultureCost then return true, false end
		if player:IsGoldenAge() then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_SwedishRiksdag.DoFunc = (
	function(player)
		local cultureCost = mathCeil(450 * iMod)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:ChangeJONSCulture(-cultureCost)
		
		local tGreatPeople = {}
		local tInclude = {["UNITCLASS_SCIENTIST"] = 1, ["UNITCLASS_ENGINEER"] = 1, ["UNITCLASS_MERCHANT"] = 1, ["UNITCLASS_GREAT_GENERAL"] = 1, ["UNITCLASS_WRITER"] = 1}
		for Unit in GameInfo.Units() do
			if Unit.Special == "SPECIALUNIT_PEOPLE" and tInclude[Unit.Class] == 1 then
				table.insert(tGreatPeople, Unit.ID)
			end
		end	
		local pPlot = player:GetCapitalCity():Plot()
		player:InitUnit(tGreatPeople[GetRandom(1, #tGreatPeople)], pPlot:GetX(), pPlot:GetY())
		player:InitUnit(tGreatPeople[GetRandom(1, #tGreatPeople)], pPlot:GetX(), pPlot:GetY())
		
		save(player, "Decisions_SwedishRiksdag", true)				
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationSwedenGustavusID, "Decisions_SwedishRiksdag", Decisions_SwedishRiksdag)
--=======================================================================================================================
--=======================================================================================================================
