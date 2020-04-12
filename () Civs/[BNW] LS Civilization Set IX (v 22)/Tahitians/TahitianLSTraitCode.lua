print ("Blue Sky - Tahitian Trait code")

--Code by Androrc the Orc
g_SaveData = Modding.OpenSaveData();
local g_Properties = {};
local h_Properties = {};
-------------------------------------------------------------- 
-- Access the modding database entries through a locally cached table
function load(name)
	if not g_Properties[name] then
		g_Properties[name] = g_SaveData.GetValue(name);
	end
	return g_Properties[name];
end
--------------------------------------------------------------
-- Access the modding database entries through a locally cached table
function save(name, value)
	if (g_Properties[name] ~= value) then
		g_SaveData.SetValue(name, value);
		g_Properties[name] = value;
	end
end

local ValidPlayerTable = {}
local techAstr = GameInfoTypes.TECH_ASTRONOMY;
local promEnterOcean = GameInfoTypes.PROMOTION_LS_TAHITI_SET;
local classSettler = GameInfoTypes.UNITCLASS_SETTLER
local TerrOceanID = GameInfoTypes.TERRAIN_OCEAN;

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

Events.SequenceGameInitComplete.Add(function()
	for player, sth in pairs(ValidPlayerTable) do
		AddPromToSettlers(player)
	end
end)

function AddPromToSettlers(player)
	for iUnit in Players[player]:Units() do
		if iUnit:GetUnitClassType() == classSettler then
			iUnit:SetHasPromotion(promEnterOcean, true)
		end
	end
end

local iDistanceToCity = 2; -- may increase to 2 for better results!
function GetCityWithinOneRange(iPlayer, iUnit)
	for iCity in Players[iPlayer]:Cities() do
		if Map.PlotDistance(iCity:GetX(), iCity:GetY(), iUnit:GetX(), iUnit:GetY()) <= iDistanceToCity then
			return iCity;
		end
	end
	return nil;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then	
		if not Teams[Players[iPlayer]:GetTeam()]:IsHasTech(techAstr) then
			for iUnit in Players[iPlayer]:Units() do
				if iUnit:GetUnitClassType() == classSettler then
					local iPlot = iUnit:GetPlot();
					if iPlot:GetTerrainType() == TerrOceanID then
						TahitiBB(iUnit)
					elseif Players[iPlayer]:GetNumCities() > 0 then
						local iToMove = load("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "aimI" .. iUnit:GetGameTurnCreated());
						if iToMove then
							iUnit:PushMission(MissionTypes.MISSION_MOVE_TO, Map.GetPlotByIndex(iToMove):GetX(), Map.GetPlotByIndex(iToMove):GetY())
							iUnit:FinishMoves()
						else
							local tCity = GetCityWithinOneRange(iPlayer, iUnit)
							if tCity then
								local tPlotIndex = tCity:Plot():GetPlotIndex();
								if tPlotIndex == load("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "cityC" .. iUnit:GetGameTurnCreated()) then
									local turns = load("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "turnC" .. iUnit:GetGameTurnCreated()) + 1;
									if turns >= 2 then
										local epicTargetPlot = GetBestOceanTargetForUnitAI(iUnit);
										if epicTargetPlot then
											save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "aimI" .. iUnit:GetGameTurnCreated(), epicTargetPlot:GetPlotIndex())
											iUnit:PushMission(MissionTypes.MISSION_MOVE_TO, epicTargetPlot:GetX(), epicTargetPlot:GetY())
										end
									else
										save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "turnC" .. iUnit:GetGameTurnCreated(), turns)
									end
								else
									save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "cityC" .. iUnit:GetGameTurnCreated(), tPlotIndex)
									save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "turnC" .. iUnit:GetGameTurnCreated(), 0)
								end
							else
								save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "cityC" .. iUnit:GetGameTurnCreated(), nil)
								save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "cityC" .. iUnit:GetGameTurnCreated(), 0)
								--anti stacking stuff
								if iUnit:GetPlot():GetPlotIndex() == load("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "stackI" .. iUnit:GetGameTurnCreated()) then
									local turns = load("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "turnS" .. iUnit:GetGameTurnCreated()) + 1;
									if turns >= 3 then
										local epicTargetPlot = GetBestOceanTargetForUnitAI(iUnit);
										if epicTargetPlot then
											save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "aimI" .. iUnit:GetGameTurnCreated(), epicTargetPlot:GetPlotIndex())
											iUnit:PushMission(MissionTypes.MISSION_MOVE_TO, epicTargetPlot:GetX(), epicTargetPlot:GetY())
										end
									else
										save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "turnS" .. iUnit:GetGameTurnCreated(), turns)
									end
								else
									save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "turnS" .. iUnit:GetGameTurnCreated(), 0)
									save("LS" .. iPlayer .. "tahiti" .. iUnit:GetID() .. "stackI" .. iUnit:GetGameTurnCreated(), iUnit:GetPlot():GetPlotIndex())
								end
							end
						end	
					end
				end
			end
		end
		AddPromToSettlers(iPlayer)
	end
end)

GameEvents.PlayerAdoptPolicy.Add(function(iPlayer, policyID)
	if ValidPlayerTable[iPlayer] then	
		AddPromToSettlers(iPlayer)
	end
end)