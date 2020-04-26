-- Re-written by Tomatekh

----print("Gran Colombia E&D")

--Congress
local iBuildingCourtHouse = GameInfoTypes.BUILDING_COURTHOUSE;
local iBuildingCourtHouse2 = GameInfoTypes.BUILDING_GC_PATCH_ED_DUMMY;

local Decisions_GCPatchCongress = {}
	Decisions_GCPatchCongress.Name = "TXT_KEY_DECISIONS_GC_PATCH_CONGRESS"
	Decisions_GCPatchCongress.Desc = "TXT_KEY_DECISIONS_GC_PATCH_CONGRESS_DESC"
	HookDecisionCivilizationIcon(Decisions_GCPatchCongress, "CIVILIZATION_PG_GRANCOLOMBIA")
	Decisions_GCPatchCongress.Weight = nil
	Decisions_GCPatchCongress.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_PG_GRANCOLOMBIA"]) then return false, false end
		if load(pPlayer, "Decisions_GCPatchCongress") == true then
			Decisions_GCPatchCongress.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GC_PATCH_CONGRESS_ENACTED_DESC")
			return false, false, true
		end		
	
		Decisions_GCPatchCongress.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GC_PATCH_CONGRESS_DESC")

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		if load(pPlayer, "Liberate Check") ~= true then return true, false end

		local pTeam = pPlayer:GetTeam();
		if Teams[pTeam]:GetAtWarCount(true) >= 1 then return true, false end

		return true, true
	end
	)
	
	Decisions_GCPatchCongress.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		for pCity in pPlayer:Cities() do
			if pCity:IsResistance() then
				local tResistance = (pCity:GetResistanceTurns());
				pCity:ChangeResistanceTurns(-tResistance);
			end
			if pCity:IsHasBuilding(iBuildingCourtHouse) then	
				if not pCity:IsHasBuilding(iBuildingCourtHouse2) then	
					pCity:SetNumRealBuilding(iBuildingCourtHouse2, 1)
				end
			end
			if pCity:IsHasBuilding(iBuildingCourtHouse2) then		
				if not pCity:IsHasBuilding(iBuildingCourtHouse) then	
					pCity:SetNumRealBuilding(iBuildingCourtHouse2, 0)
				end
			end
		end

		save(pPlayer, "Decisions_GCPatchCongress", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_PG_GRANCOLOMBIA"], "Decisions_GCPatchCongress", Decisions_GCPatchCongress)

GameEvents.CityCaptureComplete.Add(
function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pPlot = Map.GetPlot(iX, iY);	
	local cCity = pPlot:GetPlotCity();
	local iNewOwner = cCity:GetOwner();
	local iOldOwner = cCity:GetOriginalOwner();
	local iPreviousOwner = cCity:GetPreviousOwner();
	local pPlayer = Players[iNewOwner];
	local oPlayer = Players[iOldOwner];
	local lPlayer = Players[iPreviousOwner];
	if cCity then
		if cCity:IsOriginalCapital() then
			if pPlayer == oPlayer then
				if (lPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PG_GRANCOLOMBIA) then
					for iPlotUnit = 0, pPlot:GetNumUnits()-1, 1 do
						local pPlotUnit = pPlot:GetUnit(iPlotUnit)
						if (pPlotUnit:GetOwner() == iPreviousOwner and pPlotUnit:IsCombatUnit()) then
							if oPlayer:IsMinorCiv() then
								pPlayer = lPlayer
								if load(pPlayer, "Liberate Check") ~= true then
									save(pPlayer, "Liberate Check", true)
								end
							end
						end
					end
				end
			end
		end
	end
end)

GameEvents.CityCaptureComplete.Add(
function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local plot = Map.GetPlot(iX, iY);	
	local cCity = plot:GetPlotCity();
	local iNewOwner = cCity:GetOwner();
	local pPlayer = Players[iNewOwner];
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PG_GRANCOLOMBIA) then
		if load(pPlayer, "Decisions_GCPatchCongress") == true then
			if cCity:IsResistance() then
				local tResistance = (cCity:GetResistanceTurns());
				cCity:ChangeResistanceTurns(-tResistance);
			end
		end
	end
end)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PG_GRANCOLOMBIA) then
			if load(pPlayer, "Decisions_GCPatchCongress") == true then
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(iBuildingCourtHouse) then		
						if not pCity:IsHasBuilding(iBuildingCourtHouse2) then	
							pCity:SetNumRealBuilding(iBuildingCourtHouse2, 1)
						end
					end
					if pCity:IsHasBuilding(iBuildingCourtHouse2) then		
						if not pCity:IsHasBuilding(iBuildingCourtHouse) then	
							pCity:SetNumRealBuilding(iBuildingCourtHouse2, 0)
						end
					end
				end
			end
		end
	end
end)

local uGCGG1 = GameInfoTypes.UNITPG_GRANCOLOMBIA_INDEPENDIST;
local uGCGG2 = GameInfoTypes.UNITPG_GRANCOLOMBIA_INDEPENDIST_2;

local Decisions_GCPatchConference = {}
	Decisions_GCPatchConference.Name = "TXT_KEY_DECISIONS_GC_PATCH_CONFERENCE"
	Decisions_GCPatchConference.Desc = "TXT_KEY_DECISIONS_GC_PATCH_CONFERENCE_DESC"
	HookDecisionCivilizationIcon(Decisions_GCPatchConference, "CIVILIZATION_PG_GRANCOLOMBIA")
	Decisions_GCPatchConference.Weight = nil
	Decisions_GCPatchConference.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_PG_GRANCOLOMBIA"]) then return false, false end
		if load(pPlayer, "Decisions_GCPatchConference") == true then
			Decisions_GCPatchConference.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GC_PATCH_CONFERENCE_ENACTED_DESC")
			return false, false, true
		end		
	
		Decisions_GCPatchConference.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GC_PATCH_CONFERENCE_DESC")

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local pID = pPlayer:GetID();
		local pTeam = pPlayer:GetTeam();

		local isFriend = 0;
		for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
			local cPlayer = Players[i];	
			if (cPlayer:GetMinorCivFriendshipLevelWithMajor(pID) >= 2) then
				isFriend = 1;
				break
			end
		end
		if isFriend <= 0 then return true, false end

		local lCount = 0;
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == uGCGG1) or (pUnit:GetUnitType() == uGCGG2) then
				lCount = lCount + 1;
			end
		end
		if lCount <= 0 then return true, false end		

		return true, true
	end
	)
	
	Decisions_GCPatchConference.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == uGCGG1) or (pUnit:GetUnitType() == uGCGG2) then
				local title = "Guayaquil Conference";
				local descr = "A Libertador has left your cause!";									
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, pUnit:GetX(), pUnit:GetY());					
				pUnit:Kill();
				break
			end
		end

		local pID = pPlayer:GetID();
		local pTeam = pPlayer:GetTeam();

		cityMax = 1;

		function largerThan(pCity, cCity)
			return pCity:GetPopulation() > cCity:GetPopulation();
		end

		local cities = {};
		local last = 0;
		local bCity = 0;
		for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
			local pCity = 0
			local tPlayer = Players[i];					
			local tTeam = tPlayer:GetTeam();
			if (tPlayer:GetMinorCivFriendshipLevelWithMajor(pID) >= 2) then
				pCity = tPlayer:GetCapitalCity();
			end
			if pCity ~= 0 then
				local larger = true;
				local i = last;
				while i > 0 and larger do
					larger = largerThan(pCity, cities[i]);
					if i ~= cityMax then
						if larger then
							cities[i+1] = cities[i];
						else
							cities[i+1] = pCity;
						end
					end
					i = i - 1;
				end
				if i == 0 and larger then
					cities[1] = pCity;
				end
				if last < cityMax then
					last = last + 1;
				end
			end
		end
		for i,pCity in ipairs(cities) do
			bCity = pCity;
			break
		end
			
		local uVenice = GameInfoTypes["UNIT_VENETIAN_MERCHANT"]
		local unitMissionBuyCSID = GameInfoTypes["MISSION_BUY_CITY_STATE"]
		dUnit = pPlayer:InitUnit(uVenice, bCity:GetX(), bCity:GetY(), UNITAI_MERCHANT);
		dUnit:PushMission(unitMissionBuyCSID)

		for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
			local tPlayer = Players[i];					
			local tTeam = tPlayer:GetTeam();
			if pTeam ~= tTeam then
				if Teams[pTeam]:IsHasMet(tTeam) then
					tPlayer:ChangeMinorCivFriendshipWithMajor(pID, 15);
				end
			end
		end

		save(pPlayer, "Decisions_GCPatchConference", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_PG_GRANCOLOMBIA"], "Decisions_GCPatchConference", Decisions_GCPatchConference)