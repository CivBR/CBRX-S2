-- MainFunctions
-- Author: Limaeus
-- DateCreated: 5/30/2020 5:35:46 PM
--------------------------------------------------------------

local beliefGuardianSpirits = GameInfo.Beliefs["BELIEF_GUARDIAN_SPIRITS"]
local beliefCharity = GameInfo.Beliefs["BELIEF_CHARITY"]
local beliefAstralProtection = GameInfo.Beliefs["BELIEF_ASTRAL_PROTECTION"]
local beliefTutelaryDeities = GameInfo.Beliefs["BELIEF_TUTELARY_DEITIES"]


local buildingGuardianSpiritsDummy = GameInfoTypes["BUILDING_CBRX_FOUNDER_GUARDIAN_SPIRITS"]
local buildingCharityDummy = GameInfoTypes["BUILDING_CBRX_FOUNDER_CHARITY"]
local buildingAstralProjectionDummy = GameInfoTypes["BUILDING_CBRX_FOUNDER_ASTRAL_PROJECTION"]
local buildingTutelaryDeitiesDummy = GameInfoTypes["BUILDING_CBRX_FOUNDER_TUTELARY_DEITIES"]

local buildingShrine = GameInfoTypes["BUILDING_SHRINE"]

function foundersPlayerDoTurn(iPlayer)
	local player = Players[iPlayer]
	if (not player:IsAlive()) then return end
	if (not player:HasCreatedReligion()) then return end
	
	local religion = player:GetReligionCreatedByPlayer()

	for i,v in ipairs(Game.GetBeliefsInReligion(religion)) do
		local belief = GameInfo.Beliefs[v]
		if (belief == beliefGuardianSpirits) then
			local numCitiesFollowing = Game.GetNumCitiesFollowing(religion)
			for city in player:Cities() do
				city:SetNumRealBuilding(buildingGuardianSpiritsDummy, 0)
				city:SetNumRealBuilding(buildingGuardianSpiritsDummy, numCitiesFollowing)
			end
		elseif (belief == beliefCharity) then
			if player:CountNumBuildings(buildingCharityDummy) == 0 then
				Game.GetFounder():GetCapitalCity():SetNumRealBuilding(buildingCharityDummy, 1)
			end
		elseif (belief == beliefAstralProtection) then
			if player:CountNumBuildings(buildingAstralProjectionDummy) == 0 then
				Game.GetFounder():GetCapitalCity():SetNumRealBuilding(buildingAstralProjectionDummy, 1)
			end
		elseif (belief == beliefTutelaryDeities) then
			for city in player:Cities() do
				if city:GetReligiousMajority() == religion then
					if city:IsHasBuiling(buildingShrine) then
						city:SetNumRealBuilding(buildingTutelaryDeitiesDummy, 1)
					end
				else
					city:SetNumRealBuilding(buildingTutelaryDeitiesDummy, 0)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(foundersPlayerDoTurn)

function foundersReligionFounded(iPlayer, holyCityId, eReligion, eBelief1, eBelief2, eBelief3, eBelief4, eBelief5)
	local player = Players[iPlayer]
	if (not player:IsAlive()) then return end
	
	if eBelief1 == beliefCharity or eBelief2 == beliefCharity or eBelief3 == beliefCharity or eBelief4 == beliefCharity or eBelief5 == beliefCharity then
		player:GetCityByID(holyCityId):SetNumRealBuilding(buildingCharityDummy, 1)
	elseif eBelief1 == beliefAstralProtection or eBelief2 == beliefAstralProtection or eBelief3 == beliefAstralProtection or eBelief4 == beliefAstralProtection or eBelief5 == beliefAstralProtection then
		player:GetCityByID(holyCityId):SetNumRealBuilding(buildingAstralProjectionDummy, 1)
	elseif eBelief1 == beliefTutelaryDeities or eBelief2 == beliefTutelaryDeities or eBelief3 == beliefTutelaryDeities or eBelief4 == beliefTutelaryDeities or eBelief5 == beliefTutelaryDeities then
		local religion = GameInfo.Religions[eReligion]
		for city in player:Cities() do
			if city:GetReligiousMajority() == religion then
				if city:IsHasBuiling(buildingShrine) then
					city:SetNumRealBuilding(buildingTutelaryDeitiesDummy, 1)
				end
			end
		end
	end
end
GameEvents.ReligionFounded.Add(foundersReligionFounded)

print("Loaded Belief Main Functions")