-- JFD_IsUsingCPDLL
function JFD_IsUsingCPDLL()
	local cPDLLID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == cPDLLID) then
			return true
		end
	end
	return false
end
local isUsingCPDLL = JFD_IsUsingCPDLL()

-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

--===========================================================================
-- GLOBALS
--===========================================================================
local iRioGrande = GameInfoTypes["CIVILIZATION_JWW_RIO_GRANDE"]
local iMilitaryScience = GameInfoTypes["TECH_MILITARY_SCIENCE"]
local iNewspaperDummy = GameInfoTypes["BUILDING_JWW_RG_NEWSPAPER_DUMMY"]
local iAncient = GameInfoTypes["ERA_ANCIENT"]
local iClassical = GameInfoTypes["ERA_CLASSICAL"]
local iMedieval = GameInfoTypes["ERA_MEDIEVAL"]
--===========================================================================
-- Establish the "Correo del Rio Bravo del Norte"
--===========================================================================
local Decisions_RioGrande_Newspaper = {}
	Decisions_RioGrande_Newspaper.Name = "TXT_KEY_DECISIONS_RIOGRANDE_NEWSPAPER"
	Decisions_RioGrande_Newspaper.Desc = "TXT_KEY_DECISIONS_RIOGRANDE_NEWSPAPER_DESC"
	HookDecisionCivilizationIcon(Decisions_RioGrande_Newspaper, "CIVILIZATION_JWW_RIO_GRANDE")
	Decisions_RioGrande_Newspaper.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= iRioGrande then return false, false end
		if load(pPlayer, "Decisions_RioGrande_Newspaper") == true then
			Decisions_RioGrande_Newspaper.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIOGRANDE_NEWSPAPER_ENACTED_DESC")
			return false, false, true
		end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local iCost = math.ceil(300 * iMod)
		Decisions_RioGrande_Newspaper.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIOGRANDE_NEWSPAPER_DESC", iCost)
		if pPlayer:GetGold() < iCost then return true, false end
		if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		if not pTeam:IsHasTech(iMilitaryScience) then return true, false end
		if pTeam:GetAtWarCount(false) == 0 then return true, false end
		return true, true
	end
	)
	
	Decisions_RioGrande_Newspaper.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:ChangeGold(-iCost)
		for pUnit in pPlayer:Units() do
			pUnit:ChangeExperience(15)
		end
		local pCity = pPlayer:GetCapitalCity()
		pCity:SetNumRealBuilding(iNewspaperDummy, 1)
		save(pPlayer, "Decisions_RioGrande_Newspaper", true)
	end
	)
Decisions_AddCivilisationSpecific(iRioGrande, "Decisions_RioGrande_Newspaper", Decisions_RioGrande_Newspaper)

--===========================================================================
-- Gather Volunteers for the Rio Grande Army
--===========================================================================
function JWW_DoFCheck(pPlayer)
	local iNumDoFs = 0
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pWithPlayer = Players[iPlayer]
		if pPlayer ~= pWithPlayer then
			if pWithPlayer:IsDoF(pPlayer) then
				iNumDoFs = iNumDoFs + 1
				if iNumDoFs ~= 0 then
					return true
				else
					return false
				end
			end
		end
	end
end

local Decisions_RioGrande_Volunteers = {}
	Decisions_RioGrande_Volunteers.Name = "TXT_KEY_DECISIONS_RIOGRANDE_VOLUNTEERS"
	Decisions_RioGrande_Volunteers.Desc = "TXT_KEY_DECISIONS_RIOGRANDE_VOLUNTEERS_DESC"
	HookDecisionCivilizationIcon(Decisions_RioGrande_Volunteers, "CIVILIZATION_JWW_RIO_GRANDE")
	Decisions_RioGrande_Volunteers.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= iRioGrande then return false, false end
		if load(pPlayer, "Decisions_RioGrande_Volunteers") == true then
			Decisions_RioGrande_Volunteers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIOGRANDE_VOLUNTEERS_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(500 * iMod)
		Decisions_RioGrande_Volunteers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIOGRANDE_VOLUNTEERS_DESC", iCost)
		if pPlayer:GetJONSCulture() < iCost then return true, false end
		if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		if ((pPlayer:GetCurrentEra() == iAncient or pPlayer:GetCurrentEra() == iClassical) or pPlayer:GetCurrentEra() == iMedieval) then return true, false end
		if not JWW_DoFCheck(pPlayer) then return true, false end
		return true, true
	end
	)

	Decisions_RioGrande_Volunteers.DoFunc = (
	function(pPlayer)
		local iNumUnits = 0
		local iCost = math.ceil(500 * iMod)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:ChangeJONSCulture(-iCost)
		for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pWithPlayer = Players[iPlayer]
			if pPlayer ~= pWithPlayer then
				if pWithPlayer:IsDoF(pPlayer) then
					local iNumPlayerUnits = (pWithPlayer:GetNumMilitaryUnits() / 3)
					for pUnit in pWithPlayer:Units() do
						if JFD_GetRandom(1, 10) == 1 then
							if iNumUnits > iNumPlayerUnits then
								local iNumUnits = 0
								break
							else
								iNumUnits = iNumUnits + 1
								local pCap = pPlayer:GetCapitalCity()
								local pNewUnit = pPlayer:InitUnit(pUnit:GetUnitType(), pCap:GetX(), pCap:GetY(), pUnit:GetUnitAIType())
								pNewUnit:JumpToNearestValidPlot()
								pUnit:Kill(true)
								save(pPlayer, "Decisions_RioGrande_Volunteers", true)
							end
						end
					end
				end
			end
		end
	end
	)
Decisions_AddCivilisationSpecific(iRioGrande, "Decisions_RioGrande_Volunteers", Decisions_RioGrande_Volunteers)