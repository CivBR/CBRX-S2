--===================================================================================================================================================
-- Leugi Trait Free Policies
--===================================================================================================================================================
-- To use, just include("Leugi_Trait_FreePolicies.lua") in your lua file and set this file VFS = True :D , also remember to add the table through SQL please D:
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Important Functions added: 
--		IsCP()										Returns true or false
--		Leugi_SetPolicy(player, policy, bool)		Gives or removes a policy from player in a CP safe way (or not if CP isn't there)
-----------------------------------------------------------------------------------------------------------------------------------------------------
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================




function IsCP()
    local CPModID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if (mod.ID == CPModID) then
            return true
        end
    end
    return false
end


function Leugi_SetPolicy(player, policy, bool)
	if bool == true then
		if player:HasPolicy(policy) == false then
			if IsCP() then
				player:GrantPolicy (policy, bool)
			else
				player:SetNumFreePolicies (1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy (policy, bool)
			end
		end
	end
	if bool == false then
		if player:HasPolicy(policy) == true then
			if IsCP() then
				player:GrantPolicy (policy, bool)
			else
				player:SetNumFreePolicies (1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy (policy, bool)
			end
		end
	end
end

function TraitGivePolicy(pPlayer, iPolicy)
	print("Policy: " .. iPolicy .. "")
	if pPlayer:HasPolicy(iPolicy) == false then
		print("GIVIN MAH POLICIES")
		Leugi_SetPolicy(pPlayer, iPolicy, true)
	end
end

function TraitPolicyCheck (iPlayer)
	----print("Check 1")
	local pPlayer = Players[iPlayer];
	DummyPolicies = {}
	if pPlayer == nil or not pPlayer:IsAlive() or 
			pPlayer:IsBarbarian() or pPlayer:IsMinorCiv() then
		return nil;
	end
	--local iTrait = GetMajorTrait(pPlayer);
	------print("Check 3")
	------print(iTrait)
	local leader = GameInfo.Leaders[pPlayer:GetLeaderType()];
	local leaderTrait = GameInfo.Leader_Traits("LeaderType ='" .. leader.Type .. "'")();
	local iTrait = leaderTrait.TraitType;
	----print(iTrait)
	local t = {}
	for row in DB.Query("SELECT PolicyType FROM Leugi_Trait_FreePolicies WHERE Type = '" .. iTrait .. "'") do
		print("STUFF")
		print(row.PolicyType)
		table.insert(t, row.PolicyType)
	end

	for loop, policy in ipairs(t) do
		----print ("CHECK N")
		print (policy);
		iPolicy = GameInfoTypes["" .. policy .. ""]
		----print (iPolicy)
		local Prereqs = {}
		for row in DB.Query("SELECT PrereqTech FROM Leugi_Trait_FreePolicies WHERE PolicyType = '" .. policy .. "'") do
			----print ("wahht")
			local TechP = GameInfoTypes[row.PrereqTech]
			if TechP == nil then
				----print("Check 8")
				TraitGivePolicy(pPlayer, iPolicy)
			else
				----print("CHECK NN")
				local teamID = pPlayer:GetTeam();
				local pTeam = Teams[teamID];
				if pTeam:IsHasTech(TechP) then
					TraitGivePolicy(pPlayer, iPolicy)
					----print("Check 9")
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(TraitPolicyCheck);

function GetMajorTrait(pPlayer)
	----print("Check 2")
	local leader = GameInfo.Leaders[pPlayer:GetLeaderType()];
	local leaderTrait = GameInfo.Leader_Traits("LeaderType ='" .. leader.Type .. "'")();
	return GameInfo.Traits[leaderTrait.TraitType];
end