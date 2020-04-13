
print("Jerusalem Decisions: Loaded")

include("MC_JerusalemKnightlyOrders.lua")

local civilizationID = GameInfoTypes["CIVILIZATION_MC_JERUSALEM"]
local iCruciformPolicy = GameInfoTypes["POLICY_MC_CRUCIFORM_SWORD"]
local iCruciformDummy = GameInfoTypes["BUILDING_MC_JERUSALEM_CRUCIFORM"]
local iFaithDummy = GameInfoTypes["BUILDING_MC_JERUSALEM_CRUCIFORM_FAITH"]
local iRenaissance = GameInfoTypes["ERA_RENAISSANCE"]
--print("Policy: " ..iCruciformPolicy.. "Dummy: " ..iCruciformDummy)

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end

local bClerics = JFD_GetUserSetting("SUK_DECISIONS_RTP_PIETY_RESOURCE_ADDITIONS_CLERICS") == 1
local bCaptains = JFD_GetUserSetting("SUK_DECISIONS_RTP_SUPPLY_RESOURCE_ADDITIONS_CAPTAINS") == 1

local resourceCaptainsID 	= GameInfoTypes["RESOURCE_JFD_CAPTAINS"]
local resourceClericsID 	= GameInfoTypes["RESOURCE_JFD_CLERICS"]

local tWonders = {}
for BuildingClass in DB.Query("SELECT ID, Type, DefaultBuilding FROM BuildingClasses WHERE MaxGlobalInstances = '1'") do
    local iBuildingClass = BuildingClass.ID
    local sBuildingClassType = BuildingClass.Type
    for Building in GameInfo.Buildings("BuildingClass='" .. sBuildingClassType .. "'") do
		table.insert(tWonders, Building.ID)
	end
end

--------------------------
-- Cruciform
--------------------------
--[[local tCruciform = {}
tCruciform.ID = "Cruciform"
tCruciform.IconIndex = 3
tCruciform.Banner = "HospitallerBanner.dds"
tCruciform.Head = string.upper(Locale.ConvertTextKey("Brotherhood of the Cruciform Sword"))
tCruciform.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_CRUCIFORM")
tCruciform.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_CRUCIFORM
tCruciform.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_CRUCIFORM
tCruciform.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_CRUCIFORM
tCruciform.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_CRUCIFORM]]

local iGunpowder = GameInfoTypes["TECH_GUNPOWDER"]

local Decisions_C15_Cruciform = {}
	Decisions_C15_Cruciform.Name = "TXT_KEY_DECISIONS_C15_JERUSALEM_CRUCIFORM"
	Decisions_C15_Cruciform.Desc = "TXT_KEY_DECISIONS_C15_JERUSALEM_CRUCIFORM_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Cruciform, "CIVILIZATION_MC_JERUSALEM")
	Decisions_C15_Cruciform.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if pPlayer:HasPolicy(iCruciformPolicy) then
			if bCaptains then
				Decisions_C15_Cruciform.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_CRUCIFORM_DESC_ENACTED_JFDDLC")
			else
				Decisions_C15_Cruciform.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_CRUCIFORM_DESC_ENACTED")
			end
			return false, false, true
		end

		local iGold = 800 * iMod
		local iFaith = 400 * iMod
		
		if bCaptains then
			Decisions_C15_Cruciform.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_CRUCIFORM_DESC_JFDDLC", iGold, iFaith)
		else
			Decisions_C15_Cruciform.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_CRUCIFORM_DESC", iGold, iFaith)
		end

		if pPlayer:GetGold() < iGold then return true, false end
		if pPlayer:GetFaith() < iFaith then return true, false end
		if bCaptains then
			if pPlayer:GetNumResourceAvailable(resourceCaptainsID, false) < 2 then return true, false end
		else
			if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		end
		if (not Teams[pPlayer:GetTeam()]:IsHasTech(iGunpowder)) then return true, false end
	
		return true, true
	end
	)
	
	Decisions_C15_Cruciform.DoFunc = (
	function(pPlayer)
		local iGold = 800 * iMod
		local iFaith = 400 * iMod
		if bCaptains then
			pPlayer:ChangeNumResourceTotal(resourceCaptainsID, -2)
		else
			pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		end
		pPlayer:ChangeGold(-iGold)
		pPlayer:ChangeFaith(-iFaith)
		
		for pCity in pPlayer:Cities() do
			print("Switching")
			if JFD_GetRandom(0, 10) >= 60 then -- 40% chance
				print("Taking the chance")
				--[[for k, datatable in ipairs(tKnightlyOrders) do
					if pCity:IsHasBuilding(datatable.Dummy) then
						pCity:SetNumRealBuilding(datatable.Dummy, 0)
						pCity:SetNumRealBuilding(iCruciformDummy, 1)
					end
				end]]
				--[[for k, v in ipairs(tKnightlyOrders)
					local i = 0
					if row.Type == "Cruciform" then
						i = 1
					end
					pCity:SetNumRealBuilding(v.Dummy, i)
					--print("IsHas " .. row.Type .. "?", pCity:GetNumRealBuilding(GameInfoTypes[row.Dummy]))
				end]]
				C15_ChangeOrder(pCity, iCruciformDummy)
			end
		end
	
		if GrantPolicy then
			pPlayer:GrantPolicy(iCruciformPolicy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iCruciformPolicy, true)
		end
		LuaEvents.MC_Jerusalem_OrderRefresh(pPlayer)
	end
	)
	Decisions_C15_Cruciform.Monitors = {}
	Decisions_C15_Cruciform.Monitors[GameEvents.PlayerDoTurn] = (
	function(playerID)
		local pPlayer = Players[playerID]
		if pPlayer:HasPolicy(iCruciformPolicy) then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iCruciformDummy) then
					local iCount = 0
					for k, v in ipairs(tWonders) do
						if pCity:IsHasBuilding(v) then
							iCount = iCount + 1
						end
					end
					iCount = iCount + pCity:GetNumGreatWorks()
					pCity:SetNumRealBuilding(iFaithDummy, iCount)
				end
			end
		end
	end
	)


Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_Cruciform", Decisions_C15_Cruciform)

Decisions_C15_JerusLadder = {}
	Decisions_C15_JerusLadder.Name = "TXT_KEY_DECISIONS_C15_JERUSALEM_LADDER"
	Decisions_C15_JerusLadder.Desc = "TXT_KEY_DECISIONS_C15_JERUSALEM_LADDER_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_JerusLadder, "CIVILIZATION_MC_JERUSALEM")
	Decisions_C15_JerusLadder.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if load(pPlayer, "Decisions_C15_JerusLadder") == true then
			if bClerics then
				Decisions_C15_JerusLadder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_LADDER_DESC_ENACTED_JFDDLC")
			else
				Decisions_C15_JerusLadder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_LADDER_DESC_ENACTED")
			end
			return false, false, true
		end
		
		local tUniqueOrderCount = {}
		local iUniqueOrderCount = 0
		for k, v in ipairs(tKnightlyOrders) do
			table.insert(tUniqueOrderCount, {Dummy = v.Dummy, bHas = false})
		end
		
		for pCity in pPlayer:Cities() do
			for k, v in ipairs(tUniqueOrderCount) do
				if not v.bHas and pCity:IsHasBuilding(v.Dummy) then
					v.bHas = true
					iUniqueOrderCount = iUniqueOrderCount + 1
					break
				end
			end
		end
		
		local iFaith = iUniqueOrderCount * 50 * iMod
		local iCulture = math.floor(pPlayer:GetNextPolicyCost() / 2)
		
		if bClerics then
			Decisions_C15_JerusLadder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_LADDER_DESC_JFDDLC", iCulture, iFaith)
		else		
			Decisions_C15_JerusLadder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_JERUSALEM_LADDER_DESC", iCulture, iFaith)
		end
		
		if pPlayer:GetJONSCulture() < iCulture then return true, false end
		if pPlayer:GetCurrentEra() < iRenaissance then return true, false end
		if bClerics then
			if (pPlayer:GetNumResourceAvailable(resourceClericsID, false) < 1) then return true, false end
		else
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		end
		
		return true, true
	end
	)
	
	Decisions_C15_JerusLadder.DoFunc = (
	function(pPlayer)
		local tUniqueOrderCount = {}
		local iUniqueOrderCount = 0
		for k, v in ipairs(tKnightlyOrders) do
			table.insert(tUniqueOrderCount, {Dummy = v.Dummy, bHas = false})
		end
		
		for pCity in pPlayer:Cities() do
			for k, v in ipairs(tUniqueOrderCount) do
				if not v.bHas and pCity:IsHasBuilding(v.Dummy) then
					v.bHas = true
					iUniqueOrderCount = iUniqueOrderCount + 1
					break
				end
			end
		end
		
		local iFaith = iUniqueOrderCount * 50 * iMod
		local iCulture = math.floor(pPlayer:GetNextPolicyCost() / 2)
	
		pPlayer:ChangeFaith(iFaith)
		pPlayer:ChangeJONSCulture(-iCulture)
		if bClerics then
			pPlayer:ChangeNumResourceTotal(resourceClericsID, -1)
		else
			pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		end
		
		save(pPlayer, "Decisions_C15_JerusLadder", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_JerusLadder", Decisions_C15_JerusLadder)
