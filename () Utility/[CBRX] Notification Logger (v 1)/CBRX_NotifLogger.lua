local bVictory = (Game.GetWinner() ~= -1);
local IsWonder = {}
local techAvailable = {}
local cLog;

for row in GameInfo.Technologies() do
	local bOn = true;
	for i, v in pairs(Players) do
		if v:IsEverAlive() and (not v:IsBarbarian()) and (not v:IsMinorCiv()) then
			if Teams[v:GetTeam()]:IsHasTech(row.ID) then
				bOn = false;
				break;
			end
		end
	end
	if bOn then
		techAvailable[row.ID] = true;
	end
end

for row in GameInfo.BuildingClasses() do
	if row.MaxGlobalInstances == 1 then
		--print(row.Type)
		local buildingID = GameInfo.Buildings[row.DefaultBuilding].ID;
		if buildingID then
			IsWonder[buildingID] = true;
		end
	end
end

GameEvents.PlayerCityFounded.Add(function(player, cityX, cityY)
--	if Game.GetElapsedGameTurns() > 1 then
	if not Players[player]:IsMinorCiv() then
		DoLogAI(1, player, Map.GetPlot(cityX, cityY):GetPlotCity():GetName(), cityX, cityY)
	end
--	end
end)

function DoLogAI(type, val1, val2, val3, val4, val5, val6, val7, val8)
	--LuaEvents.JustAILogDoLog(type, val1, val2, val3, val4, val5, val6, val7)
	--table.insert(aiLog, 1, {type, Game.GetGameTurn(), val1, val2, val3, val4, val5, val6, val7})
	if type == 1 then
		print(Game.GetGameTurn() .. "T: <<" .. val2 .. ">> Founded by " .. Players[val1]:GetName() .. " (" .. val3 .. "," .. val4 .. ")")
	elseif type == 2 then
		if val6 then
			print(Game.GetGameTurn() .. "T: <<" .. val3 .. ">> (" .. Players[val1]:GetName() .. ") captured by " .. Players[val2]:GetName() .. " (" .. val4 .. "," .. val5 .. ")" .. " oldPop: " .. val7 .. " newPop: " .. val8)
		else
			print(Game.GetGameTurn() .. "T: <<" .. val3 .. ">> (" .. Players[val1]:GetName() .. ") claimed by " .. Players[val2]:GetName() .. " in peace treaty (" .. val4 .. "," .. val5 .. ")")
		end
	elseif type == 3 then
		print(Game.GetGameTurn() .. "T: Religion " .. Locale.Lookup(GameInfo.Religions[val2].Description) .. " founded in " .. val3 .. " by " .. Players[val1]:GetName() .. " with " .. (val4 or "noBelief1") .. " and " ..  (val5 or "noBelief2") .. " and " ..  (val6 or "noBelief3"))
	elseif type == 4 then
		print(Game.GetGameTurn() .. "T: Wonder " .. val2 .. " constructed in " .. val3 .. " by " .. Players[val1]:GetName())
	elseif type == 5 then
		print(Game.GetGameTurn() .. "T: Victory claimed by " .. Players[val1]:GetName() .. " (" .. val2 .. ")")
	elseif type == 6 then
		print(Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " ended game with " .. val2 .. " points.")
	elseif type == 7 then
		print(Game.GetGameTurn() .. "T: Technology " .. Locale.Lookup(GameInfo.Technologies[val2].Description) .. " was discovered by " .. GetProperTeamName(val1))
	elseif type == 8 then
		print(Game.GetGameTurn() .. "T: " .. GetProperTeamName(val1) .. " declared war on " .. GetProperTeamName(val2))
	elseif type == 9 then
		print(Game.GetGameTurn() .. "T: " .. GetProperTeamName(val1) .. " made peace with " .. GetProperTeamName(val2))
	elseif type == 10 then
		if not val3 then
			print(Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " adopted " .. Locale.Lookup(GameInfo.PolicyBranchTypes[val2].Description))
		else
			print(Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " adopted " .. Locale.Lookup(GameInfo.PolicyBranchTypes[val2].Description) .. " (revolution)")
		end
	elseif type == 11 then
		print(Game.GetGameTurn() .. "T: " .. GetProperTeamName(val1) .. " created Citadel. (" .. val2 .. ", " .. val3 .. ")")
	elseif type == 12 then
		local iPlot = Map.GetPlot(val2, val3);
		local iTarget = iPlot:GetOwner();
		local text = "";
		if val4 then
			if iTarget ~= -1 then
				text = Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " declared war by casually dropping Nuclear Weapon on " .. Players[iTarget]:GetName() .. "'s territory."
			else
				text = Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " used a Nuclear Weapon.";
			end
		else
			if iTarget ~= -1 then
				text = Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " dropped Nuclear Weapon at " .. Players[iTarget]:GetName() .. "'s territory."
			else
				text = Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " used a Nuclear Weapon."
			end
		end
		if val5 then
			text = text .. " (bystander was hit)"
		end
		print(text)
	elseif type == 13 then
		print(Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " Enhanced " .. Locale.Lookup(GameInfo.Religions[val2].Description) .. " with " .. Locale.Lookup(GameInfo.Beliefs[val3].Description) .. " and " ..  Locale.Lookup(GameInfo.Beliefs[val4].Description) .. ".")
	elseif type == 14 then
		print(Game.GetGameTurn() .. "T: " .. Players[val1]:GetName() .. " adopted the " .. Locale.Lookup(GameInfo.Policies[val2].Description) .. " policy.")
	end
end

GameEvents.WinnerChanged.Add(function(winner, victory)
	if not bVictory then
		if winner ~= -1 then
			DoLogAI(5, Game.GetWinner(), Locale.Lookup(GameInfo.Victories[Game.GetVictory()].Description))
			for i, v in pairs(Players) do
				if v:IsAlive() and (not v:IsBarbarian()) and (not v:IsMinorCiv()) then
					DoLogAI(6, i, v:GetScore())
				end
			end
			bVictory = true;
		end
	end
end)

GameEvents.CityCaptureComplete.Add(function(player, capital, x, y, newPlayer, iOldPopulation, bConquest)
	DoLogAI(2, player, newPlayer, Map.GetPlot(x, y):GetPlotCity():GetName(), x, y, bConquest, iOldPopulation, Map.GetPlot(x, y):GetPlotCity():GetPopulation())
end)

GameEvents.ReligionFounded.Add(function(ePlayer, holyCityId, eReligion, eBelief1, eBelief2, eBelief3, eBelief4, eBelief5)
	DoLogAI(3, ePlayer, eReligion, Players[ePlayer]:GetCityByID(holyCityId):GetName(), eBelief1, eBelief2, eBelief3)
end)

GameEvents.ReligionEnhanced.Add(function(ePlayer, eReligion, eBelief1, eBelief2)
	DoLogAI(13, ePlayer, eReligion, eBelief1, eBelief2)
end)

GameEvents.CityConstructed.Add(function(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if IsWonder[buildingType] then
		DoLogAI(4, ownerId, Locale.Lookup(GameInfo.Buildings[buildingType].Description), Players[ownerId]:GetCityByID(cityId):GetName(), Players[ownerId]:GetCityByID(cityId):Plot():GetPlotIndex())
	end
end)

GameEvents.TeamSetHasTech.Add(function(team, tech, bAdopted)
	if bAdopted then
		if techAvailable[tech] then
			if not Teams[team]:IsMinorCiv() then
				techAvailable[tech] = nil
				DoLogAI(7, team, tech)
			end
		end
	end
end)

GameEvents.DeclareWar.Add(function(team, teamB)
	if (not Teams[team]:IsMinorCiv()) and (not Teams[teamB]:IsMinorCiv()) then
		if (not Teams[team]:IsBarbarian()) and (not Teams[teamB]:IsBarbarian()) then
			DoLogAI(8, team, teamB)
		end
	end
end)

GameEvents.MakePeace.Add(function(team, teamB)
	if (not Teams[team]:IsMinorCiv()) and (not Teams[teamB]:IsMinorCiv()) then
		if (not Teams[team]:IsBarbarian()) and (not Teams[teamB]:IsBarbarian()) then
			DoLogAI(9, team, teamB)
		end
	end
end)

function GetProperTeamName(teamId)
	if (Teams[teamId]:GetName() or "") == "" then
		return Players[teamId]:GetName() .. " (" .. teamId .. ")";
	end
	return Teams[teamId]:GetName();
end

GameEvents.SetPolicyBranchUnlocked.Add(function(iPlayer, branch, bUnlocked, bRev)
	if bUnlocked then
		if GameInfo.PolicyBranchTypes[branch].PurchaseByLevel then
			DoLogAI(10, iPlayer, branch, bRev)
		else
			--? is there sense to log other openings?
		end
	end
end)

GameEvents.BuildFinished.Add(function(iPlayer, x, y, improID)
	local thLog = (iPlayer .. "x" .. x .. "y" .. "i" .. improID)
	if thLog == cLog then
		return; -- prevents duplicates
	end
	cLog = thLog;
	if improID == GameInfoTypes.IMPROVEMENT_CITADEL then
		DoLogAI(11, iPlayer, x, y)
	end
end)

GameEvents.NuclearDetonation.Add(function(AttackerPlayerId, PlotX, PlotY, bDeclareWar, bBystander)
	DoLogAI(12, AttackerPlayerId, PlotX, PlotY, bDeclareWar, bBystander)
end)

GameEvents.PlayerAdoptPolicy.Add(function(playerID, policyID)
	DoLogAI(14, playerID, policyID)
end)
