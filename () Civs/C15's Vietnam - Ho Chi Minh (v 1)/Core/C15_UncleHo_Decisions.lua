-- C15_UncleHo_Decisions
-- Author: Chrisy15
-- DateCreated: 2/24/2018 10:06:00 AM
--------------------------------------------------------------

function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end

local civilizationID = GameInfoTypes["CIVILIZATION_C15_NVIET"]
local iGGClass = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]
local pHappinessDummy = GameInfo.Buildings["BUILDING_C15_HO_DECISION_TET_DUMMY"]
local iHappinessDummyClass = GameInfoTypes[pHappinessDummy.BuildingClass]

local piety = GameInfo.Yields["YIELD_JFD_PIETY"]
local bPiety = JFD_GetUserSetting("JFD_RTP_PIETY_CORE") == 1
local captain = GameInfo.Resources["RESOURCE_JFD_CAPTAIN"]
local magistrate = GameInfo.Resources[iMagistrate]

local tValidFeatures = {}
tValidFeatures[GameInfoTypes["FEATURE_FOREST"]] = true
tValidFeatures[GameInfoTypes["FEATURE_JUNGLE"]] = true

local sMaj = Locale.ConvertTextKey("TXT_KEY_C15_NVIET_MAJREL")
local sSta = Locale.ConvertTextKey("TXT_KEY_C15_NVIET_STAREL")

--[[
Launch the Tet Offensive 
Must have a Religion 
Must be at War with a Major Civilization
Costs Culture (and Piety) 
Enemy Cities take damage and receive Happiness Penalties from Vietnamese Units in their tiles
]]

function C15_GetTetOffenders()
	local t = {}
	for k, v in pairs(Players) do
		if v:GetCivilizationType() == civilizationID and load(v, "Decisions_C15_UncleHo_TetOffensive") == true then
			t[k] = v:GetTeam()
		end
	end
	return t
end

function C15_GetNumTetOffendersAtWarWith(pTeam, tTetOffenders)
	local iCount = 0
	for k, v in pairs(tTetOffenders) do
		if pTeam:IsAtWar(v) then
			iCount = iCount + 1
		end
	end
	return iCount
end

function C15_BoilDownReligion(pPlayer)
	if bPiety then
		if pPlayer:HasStateReligion() then
			return pPlayer:GetStateReligion()
		end
	end
	local iReligion = -1
	if Player.GetOriginalReligionCreatedByPlayer then
		-- Thanks a ton G
		iReligion = pPlayer:GetOriginalReligionCreatedByPlayer()
	else
		iReligion = pPlayer:GetReligionCreatedByPlayer()
	end
	if iReligion == -1 then
		return GetPlayerMajorityReligion(pPlayer) or -1
	else
		return iReligion
	end
end
	
local Decisions_C15_UncleHo_TetOffensive = {}
	Decisions_C15_UncleHo_TetOffensive.Name = "TXT_KEY_DECISIONS_C15_NVIET_TET"
	Decisions_C15_UncleHo_TetOffensive.Desc = "TXT_KEY_DECISIONS_C15_NVIET_TET_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_UncleHo_TetOffensive, "CIVILIZATION_C15_NVIET")
	Decisions_C15_UncleHo_TetOffensive.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if load(pPlayer, "Decisions_C15_UncleHo_TetOffensive") == true then
			Decisions_C15_UncleHo_TetOffensive.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_NVIET_TET_DESC_ENACTED")
			return false, false, true
		end
		
		local iCulture = math.floor(pPlayer:GetNextPolicyCost() * 0.75)
		
		local sPiety = ""
		local sRel = sMaj
		if bPiety then
			sPiety = "[NEWLINE][ICON_BULLET]-10 " .. piety.IconString .. " " .. Locale.ConvertTextKey(piety.Description)
			sRel = sSta
		end
		
		Decisions_C15_UncleHo_TetOffensive.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_NVIET_TET_DESC", iCulture, sPiety, sRel)
		
		if C15_BoilDownReligion(pPlayer) <= 1 then return true, false end
		if pPlayer:GetJONSCulture() < iCulture then return true, false end
		if bPiety then
			if pPlayer:GetPiety() < 10 then return true, false end
		end
		if Teams[pPlayer:GetTeam()]:GetAtWarCount(true) == 0 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_UncleHo_TetOffensive.DoFunc = (
	function(pPlayer)
		local iCulture = math.floor(pPlayer:GetNextPolicyCost() * 0.75)
		pPlayer:ChangeJONSCulture(-iCulture)
		if bPiety then
			pPlayer:ChangePiety(-10)
		end
		JFD_SendWorldEvent(pPlayer:GetID(), Locale.ConvertTextKey("TXT_KEY_C15_NVIET_TET_WORLDEVENT"))
		save(pPlayer, "Decisions_C15_UncleHo_TetOffensive", true)
	end
	)
	
	Decisions_C15_UncleHo_TetOffensive.Monitors = {}
	Decisions_C15_UncleHo_TetOffensive.Monitors[GameEvents.PlayerDoTurn] = (
	function(playerID)
		local pPlayer = Players[playerID]
		local pTeam = Teams[pPlayer:GetTeam()]
		local tTetOffenders = C15_GetTetOffenders()
		local iTetAtWar = C15_GetNumTetOffendersAtWarWith(pTeam, tTetOffenders)
		if iTetAtWar > 0 or (iTetAtWar == 0 and pPlayer:GetBuildingClassCount(iHappinessDummyClass) > 0) then
			for pCity in pPlayer:Cities() do
				local iCount = 0
				for i = 0, pCity:GetNumCityPlots() - 1 do
					local pPlot = pCity:GetCityIndexPlot(i)
					if pPlot and pCity:IsWorkingPlot() and pPlot:IsUnit() then
						for j = 0, pPlot:GetNumUnits() - 1 do
							local pUnit = pPlot:GetUnit(j)
							if tTetOffenders[pUnit:GetOwner()] then
								iCount = iCount + 1
							end
						end
					end
				end
				pCity:SetNumRealBuilding(pHappinessDummy.ID, iCount)
				pCity:ChangeDamage(iCount * 10)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_UncleHo_TetOffensive", Decisions_C15_UncleHo_TetOffensive)

--[[
Establish the Viet Cong 
Must be at War with a Major Civilization
Costs a Great General 
Costs 1 Mag/Cap
Chance for Vietnamese Units to spawn in enemy Forest and Jungle when either you or they capture a City
]]

local Decisions_C15_UncleHo_VietCong = {}
	Decisions_C15_UncleHo_VietCong.Name = "TXT_KEY_DECISIONS_C15_NVIET_CONG"
	Decisions_C15_UncleHo_VietCong.Desc = "TXT_KEY_DECISIONS_C15_NVIET_CONG_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_UncleHo_VietCong, "CIVILIZATION_C15_NVIET")
	Decisions_C15_UncleHo_VietCong.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if load(pPlayer, "Decisions_C15_UncleHo_VietCong") == true then
			Decisions_C15_UncleHo_VietCong.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_NVIET_CONG_DESC_ENACTED")
			return false, false, true
		end
		
		local pRes
		if captain then
			pRes = captain
		else
			pRes = magistrate
		end
		
		Decisions_C15_UncleHo_VietCong.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_NVIET_CONG_DESC", pRes.IconString, pRes.Description)
		
		if pPlayer:GetUnitClassCount(iGGClass) == 0 then return true, false end
		if Teams[pPlayer:GetTeam()]:GetAtWarCount(true) == 0 then return true, false end
		if (pPlayer:GetNumResourceAvailable(pRes.ID, false) < 1) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_UncleHo_VietCong.DoFunc = (
	function(pPlayer)
		local pRes
		if captain then
			pRes = captain
		else
			pRes = magistrate
		end
		
		pPlayer:ChangeNumResourceTotal(pRes.ID, -1)

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == iGGClass then
				pUnit:Kill(true, -1)
				break
			end
		end
		JFD_SendWorldEvent(pPlayer:GetID(), Locale.ConvertTextKey("TXT_KEY_C15_NVIET_VC_WORLDEVENT"))
		save(pPlayer, "Decisions_C15_UncleHo_VietCong", true)
	end
	)
	
	Decisions_C15_UncleHo_VietCong.Monitors = {}
	Decisions_C15_UncleHo_VietCong.Monitors[GameEvents.CityCaptureComplete] = (
	function(oldID, bCap, iX, iY, newID, iOldPop, bConquest)
		if bConquest then
			local pOld, pNew = Players[oldID], Players[newID]
			local pPlot = Map.GetPlot(iX, iY)
			if not pPlot then return end
			local pCity = pPlot:GetPlotCity()
			if not pCity then return end
			local tPlayers = {}
			if load(pOld, "Decisions_C15_UncleHo_VietCong") == true then
				table.insert(tPlayers, {pOld, GetStrongestMilitaryUnit(pOld, false)})
			end
			if load(pNew, "Decisions_C15_UncleHo_VietCong") == true then
				table.insert(tPlayers, {pNew, GetStrongestMilitaryUnit(pNew, false)})
			end
			if #tPlayers > 0 then
				for i = 0, pCity:GetNumCityPlots() - 1 do
					local pIterPlot = pCity:GetCityIndexPlot(i)
					if pIterPlot and tValidFeatures[pIterPlot:GetFeatureType()] and pIterPlot:GetWorkingCity() == pCity then
						for k, v in pairs(tPlayers) do
							if GetRandom(1, 10) >= 6 then
								local pUnit = v[1]:InitUnit(v[2], pIterPlot:GetX(), pIterPlot:GetY())
								pUnit:SetName("TXT_KEY_C15_NVIET_VC")
							end
						end
					end
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_UncleHo_VietCong", Decisions_C15_UncleHo_VietCong)

				
		