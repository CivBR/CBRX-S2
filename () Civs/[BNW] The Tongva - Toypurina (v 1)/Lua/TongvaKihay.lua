--==========================================
-- Tongva UB
--==========================================
local iKihay = GameInfoTypes["BUILDING_SAS_KIHAY"]
local iScienceDummy = GameInfoTypes["BUILDING_SAS_TONGVA_SCIENCE"]

function JWW_PolicyBranch2Yield(iPlayer)
	local iGoldChange = 0
	local iFaithChange = 0
	local iScienceChange = 0
	local iCultureChange = 0
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		for pCity in pPlayer:Cities() do
			local iFoodChange = 0
			local iProductionChange = 0
			if pCity:IsHasBuilding(iKihay) then
				if pPlayer:GetNumPolicyBranchesUnlocked() > 0 then
					if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_TRADITION) then
						iFoodChange = iFoodChange + 1
						if pCity:GetWeLoveTheKingDayCounter() > 0 then
							iFoodChange = iFoodChange + 1
						end
					end
					if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_LIBERTY) then
						iProductionChange = iProductionChange + 1
						if pCity:GetWeLoveTheKingDayCounter() > 0 then
							iProductionChange = iProductionChange + 1
						end
					end
					if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_HONOR) then
						iGoldChange = iGoldChange + 1
						if pCity:GetWeLoveTheKingDayCounter() > 0 then
							iGoldChange = iGoldChange + 1
						end
					end
					if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_PIETY) then
						iFaithChange = iFaithChange + 1
						if pCity:GetWeLoveTheKingDayCounter() > 0 then
							iFaithChange = iFaithChange + 1
						end
					end
					pCity:SetNumRealBuilding(iScienceDummy, 0)
					if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_PATRONAGE) then
						iScienceChange = iScienceChange + 1
						if pCity:GetWeLoveTheKingDayCounter() > 0 then
							iScienceChange = iScienceChange + 1
						end
						pCity:SetNumRealBuilding(iScienceDummy, iScienceChange)
					end
					if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_AESTHETICS) then
						iCultureChange = iCultureChange + 1
						if pCity:GetWeLoveTheKingDayCounter() > 0 then
							iCultureChange = iCultureChange + 1
						end
					end
				end
			end
			pCity:ChangeFood(iFoodChange)
			pCity:ChangeProduction(iProductionChange)
		end
		pPlayer:ChangeGold(iGoldChange)
		pPlayer:ChangeFaith(iFaithChange)
		pPlayer:ChangeJONSCulture(iCultureChange)
	end
end

GameEvents.PlayerDoTurn.Add(JWW_PolicyBranch2Yield)