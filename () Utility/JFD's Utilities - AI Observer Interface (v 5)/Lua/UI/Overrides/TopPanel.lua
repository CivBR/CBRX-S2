
-------------------------------
-- JFD Observer Stuff
-------------------------------
include("IconSupport");
include("InstanceManager");
include("JFD_AI_Observer_Utils.lua");

local isUsingCulDiv = Game_IsCulDivActive()

local gridX = 635
local gridY = 235

local civTitleGridX = 615
local civTitleGridY = 55

local diploGridX = 150
local diploGridY = 210

local rankingsTable = {}
	rankingsTable[1] = "1st"
	rankingsTable[2] = "2nd"
	rankingsTable[3] = "3rd"
	rankingsTable[21] = "21st"
	rankingsTable[22] = "22nd"
	rankingsTable[23] = "23rd"
	rankingsTable[31] = "31st"
	rankingsTable[32] = "32nd"
	rankingsTable[33] = "33rd"
	rankingsTable[41] = "41st"
	rankingsTable[42] = "42nd"
	rankingsTable[43] = "43rd"
	rankingsTable[51] = "51st"
	rankingsTable[52] = "52nd"
	rankingsTable[53] = "53rd"

-- local g_AlliesCivManager = InstanceManager:new("AlliesCivInstance", "AlliesCivBase", Controls.AlliesCivStack)
-- local g_EnemiesCivManager = InstanceManager:new("EnemiesCivInstance", "EnemiesCivBase", Controls.EnemiesCivStack)
-- local g_FriendsCivManager = InstanceManager:new("FriendsCivInstance", "FriendsCivBase", Controls.FriendsCivStack)
-- local g_WarCivManager = InstanceManager:new("WarCivInstance", "WarCivBase", Controls.WarCivStack)
local g_RelationsCivManager  = InstanceManager:new("RelationsCivInstance", "RelationsCivBase", Controls.RelationsCivStack)
local g_RelationsCiv2Manager = InstanceManager:new("RelationsCivInstance", "RelationsCivBase", Controls.RelationsCivStack2)
local g_RelationsCiv3Manager = InstanceManager:new("RelationsCivInstance", "RelationsCivBase", Controls.RelationsCivStack3)
local g_RelationsCiv4Manager = InstanceManager:new("RelationsCivInstance", "RelationsCivBase", Controls.RelationsCivStack4)

function RefreshAdditionalInformationEntries()

	local function Popup(popupType, data1, data2)
		Events.SerialEventGameMessagePopup{ 
			Type = popupType,
			Data1 = data1,
			Data2 = data2
		};
	end

	local additionalEntries = {
		{ text = Locale.Lookup("TXT_KEY_ADVISOR_COUNSEL"),					call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_ADVISOR_COUNSEL); end};
		{ text = Locale.Lookup("TXT_KEY_ADVISOR_SCREEN_TECH_TREE_DISPLAY"), call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_TECH_TREE, nil, -1); end };
		{ text = Locale.Lookup("TXT_KEY_DIPLOMACY_OVERVIEW"),				call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_DIPLOMATIC_OVERVIEW); end };
		{ text = Locale.Lookup("TXT_KEY_MILITARY_OVERVIEW"),				call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_MILITARY_OVERVIEW); end };
		{ text = Locale.Lookup("TXT_KEY_ECONOMIC_OVERVIEW"),				call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_ECONOMIC_OVERVIEW); end };
		{ text = Locale.Lookup("TXT_KEY_VP_TT"),							call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_VICTORY_INFO); end };
		{ text = Locale.Lookup("TXT_KEY_DEMOGRAPHICS"),						call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_DEMOGRAPHICS); end };
		{ text = Locale.Lookup("TXT_KEY_POP_NOTIFICATION_LOG"),				call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_NOTIFICATION_LOG,Game.GetActivePlayer()); end };
		{ text = Locale.Lookup("TXT_KEY_TRADE_ROUTE_OVERVIEW"),				call=function() Popup(ButtonPopupTypes.BUTTONPOPUP_TRADE_ROUTE_OVERVIEW); end };
	};

	-- Obtain any modder/dlc entries.
	LuaEvents.AdditionalInformationDropdownGatherEntries(additionalEntries);
	
	-- Now that we have all entries, call methods to sort them
	LuaEvents.AdditionalInformationDropdownSortEntries(additionalEntries);

	 Controls.MultiPull:ClearEntries();

	Controls.MultiPull:RegisterSelectionCallback(function(id)
		local entry = additionalEntries[id];
		if(entry and entry.call ~= nil) then
			entry.call();
		end
	end);
		 
	for i,v in ipairs(additionalEntries) do
		local controlTable = {};
		Controls.MultiPull:BuildEntry( "InstanceOne", controlTable );

		controlTable.Button:SetText( v.text );
		controlTable.Button:LocalizeAndSetToolTip( v.tip );
		controlTable.Button:SetVoid1(i);
		
	end

	-- STYLE HACK
	-- The grid has a nice little footer that will overlap entries if it is not resized to be larger than everything else.
	Controls.MultiPull:CalculateInternals();
	local dropDown = Controls.MultiPull;
	local width, height = dropDown:GetGrid():GetSizeVal();
	dropDown:GetGrid():SetSizeVal(width, height+100);

end
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries.Add(RefreshAdditionalInformationEntries);

function SortAdditionalInformationDropdownEntries(entries)
	table.sort(entries, function(a,b)
		return (Locale.Compare(a.text, b.text) == -1);
	end);
end
LuaEvents.AdditionalInformationDropdownSortEntries.Add(SortAdditionalInformationDropdownEntries);

function UpdateNewData(playerID, szTag)
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner"):SetHide(true)
	Events.OpenInfoCorner(nil)
	if (not playerID) then playerID = Game.GetActivePlayer() end
	if(PreGame.IsMultiplayerGame()) then
		-- Turn Queue UI (see ActionInfoPanel.lua) replaces the turn processing UI in multiplayer.  
		return;
	end
	
	local player = Players[playerID]
	if (player == nil) then
		return;	
	end
	
	if (not player:IsTurnActive()) then
		return;
	end

	local civDescription;
	local bIsBarbarian = player:IsBarbarian();
	if (bIsBarbarian) then
		-- Even if there are no barbarians, we will get this call, just skip out if they are turned off
		return;
	end

	--Update date
	local date;
	local traditionalDate = Game.GetTurnString();
	if (player:IsUsingMayaCalendar()) then
		date = player:GetMayaCalendarString();
		local toolTipString = Locale.ConvertTextKey("TXT_KEY_MAYA_DATE_TOOLTIP", player:GetMayaCalendarLongString(), traditionalDate);
	else
		date = traditionalDate;
	end
	Controls.CurrentDate:SetText(date);
	
	--Update era
	local eraDesc = GameInfo.Eras[player:GetCurrentEra()].Description
	Controls.CurrentEra:LocalizeAndSetText(eraDesc)
	
	--Update turn counter
	local turn = Locale.ConvertTextKey("TXT_KEY_TP_TURN_COUNTER", Game.GetGameTurn());
	Controls.CurrentTern:SetText(Locale.ConvertTextKey(date) .. " (" .. Locale.ConvertTextKey("{1_Num}", turn) .. ")");
	
	local bIsMinor = player:IsMinorCiv() 
	if (not bIsMinor) and player:IsAlive() then
		local iPlayerLoop = playerID
		local pPlayer = Players[iPlayerLoop];
		local iTeam = pPlayer:GetTeam();
		local pTeam = Teams[iTeam];
			
		local civDesc = Locale.ToUpper(pPlayer:GetCivilizationDescription())
		local leaderDesc = pPlayer:GetName()
		
		-- Use the Civilization_Leaders table to cross reference from this civ to the Leaders table
		local leader = GameInfo.Leaders[pPlayer:GetLeaderType()];
		local leaderDescription = leader.Description;
			
		local strName
		local srCivName = pPlayer:GetCivilizationDescription()
		local strLeaderName = leaderDesc
		local srGovtName
		local strGovtStatsName = ""
		local strEcoStatsName = ""
		
		-- if (pPlayer:GetID() == Game.GetActivePlayer()) then
			-- strName = civDesc .. " (" .. Locale.ToUpper( "TXT_KEY_POP_VOTE_RESULTS_YOU" ) .. ")"
		-- else
			strName = "[" .. GameInfo.PlayerColors[player:GetPlayerColor()].PrimaryColor .. "]" .. civDesc .. "[ENDCOLOR]"
		-- end	
		
		local civilization = GameInfo.Civilizations[player:GetCivilizationType()]
		local leader = GameInfo.Leaders[player:GetLeaderType()]
		IconHookup( civilization.PortraitIndex, 64, civilization.IconAtlas, Controls.CivIcon )
		IconHookup( leader.PortraitIndex, 128, leader.IconAtlas, Controls.LeaderIcon )
		
		local strGovernment = ""
		
		--CYCLES OF POWER
		local cyclePowerID = -1
		if Player.GetCyclePower then
			cyclePowerID = pPlayer:GetCyclePower() or -1
		end				
		if cyclePowerID ~= -1 then
			local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
			Controls.CyclePower:SetHide(false)		
			Controls.CyclePowerNameText:SetText("[ICON_JFD_CYCLE_OF_POWER] " .. Locale.ToUpper(cyclePower.Description) .. "[ENDCOLOR]")
		else
			Controls.CyclePower:SetHide(true)
		end
		
		--SOVEREIGNTY
		local governmentID = -1
		local strFaction = ""
		if Player.GetCurrentGovernment then		
			governmentID = pPlayer:GetCurrentGovernment()
			srGovtName = pPlayer:GetGovernmentName(governmentID)	
			strGovernment = strGovernment .. "[NEWLINE][ICON_JFD_GOVERNMENT] " .. Locale.ConvertTextKey(GameInfo.JFD_Governments[governmentID].Description) 
			-- strGovtStatsName = strGovtStatsName .. " (" .. srGovtName .. ")" 
			-- Controls.PlayerLeaderNameText:SetText(srGovtName)
				
			local factionID = pPlayer:GetDominantFaction()
			if factionID ~= -1 then
				-- strGovtStatsName = strGovtStatsName .. "[COLOR_JFD_SOVEREIGNTY][ICON_BULLET]" .. GameInfo.JFD_Factions[factionID].IconString .. " " .. Locale.ConvertTextKey(GameInfo.JFD_Factions[factionID].Adjective) .. "[ENDCOLOR]" 
				-- strFaction = GameInfo.JFD_Factions[factionID].IconString .. " " .. Locale.ConvertTextKey(GameInfo.JFD_Factions[factionID].Description)
				Controls.PlayerFactionNameText:SetText("" .. GameInfo.JFD_Factions[factionID].IconString .. " " .. Locale.ConvertTextKey(GameInfo.JFD_Factions[factionID].Description))
				Controls.PlayerFactionNameText:SetHide(false)
				-- Controls.RightInfoStack:ReprocessAnchoring()
				-- strGovtStatsName = strGovtStatsName .. " (" .. pPlayer:GetFactionName(factionID) .. ")" 
			else
				Controls.PlayerFactionNameText:SetHide(true)
				-- Controls.RightInfoStack:ReprocessAnchoring()
			end
		end
		
		--IDEOLOGY
		local ideologyID = pPlayer:GetIdeology()
		local ideologyFont = nil
		local ideologyDesc = nil
		if ideologyID == -1 then
			ideologyID = pPlayer:GetDominantPolicyBranchForTitle()
			ideologyFont = "[ICON_CULTURE]"
			ideologyDesc = "None"
		else
			ideologyFont = GameInfo.PolicyBranchTypes[ideologyID].IconString
			ideologyDesc = GameInfo.PolicyBranchTypes[ideologyID].Description
		end
		if ideologyID ~= -1 then
			Controls.IdeologyIcon:SetText(ideologyFont)
			Controls.IdeologyIcon:LocalizeAndSetToolTip(ideologyDesc)
			Controls.IdButton:SetHide(false)
			-- Controls.PlayerIdeologyNameText:SetText(ideologyFont .. Locale.ConvertTextKey(ideologyDesc))
		else
			Controls.IdButton:SetHide(true)
		end
		
		--RELIGION
		local religionID = pPlayer:GetMainReligion()
		local religionFont = nil
		local religionDesc = nil
		if religionID >= 0 and pPlayer:HasCreatedPantheon() then
			religionFont = GameInfo.Religions[religionID].IconString
			religionDesc = GameInfo.Religions[religionID].Description
			Controls.ReliIcon:SetText(religionFont)
			Controls.ReliIcon:LocalizeAndSetToolTip(religionDesc)
			Controls.ReligionButton:SetHide(false)
		else
			Controls.ReligionButton:SetHide(true)
		end
		
		--STABILITY
		--Update status
		Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_1] [COLOR_HAPPINESS]STABLE[ENDCOLOR]")
		Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_1] [COLOR_HAPPINESS]STABLE[ENDCOLOR]")
		if pPlayer:IsEmpireSuperUnhappy() then
			Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]CIVIL WAR![ENDCOLOR]")
			Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]CIVIL WAR![ENDCOLOR]")
		end
		if pPlayer:IsEmpireVeryUnhappy() then
			Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]REBELLION![ENDCOLOR]")
			Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]REBELLION![ENDCOLOR]")
		end
		if pPlayer:IsEmpireUnhappy() then
			Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_3] [COLOR_UNHAPPINESS]DISCONTENT![ENDCOLOR]")
			Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_3] [COLOR_UNHAPPINESS]DISCONTENT![ENDCOLOR]")
		end
		if pPlayer:IsGoldenAge() then
			Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_GOLDEN_AGE] [COLOR_GOLDEN_AGE]GOLDEN AGE![ENDCOLOR]")
			Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_GOLDEN_AGE] [COLOR_GOLDEN_AGE]GOLDEN AGE![ENDCOLOR]")
		end
		if Player.IsDarkAge and pPlayer:IsDarkAge() then
			Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_DARK_AGE] [COLOR_DARK_AGE]DARK AGE![ENDCOLOR]")
			Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_DARK_AGE] [COLOR_DARK_AGE]DARK AGE![ENDCOLOR]")
		end
		if pPlayer:IsAnarchy() then
			Controls.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_RESISTANCE] [COLOR_RED]ANARCHY![ENDCOLOR]")
			Controls.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_RESISTANCE] [COLOR_RED]ANARCHY![ENDCOLOR]")
		end
		
		local primaryColor, secondaryColor = pPlayer:GetPlayerColors();
		local otherColor = GameInfo.Colors["COLOR_DARK_GREY"]
		local backgroundColor = {x = otherColor.Red, y = otherColor.Green, z = otherColor.Blue, w = 1};
		local headerColor = {x = secondaryColor.x, y = secondaryColor.y, z = secondaryColor.z, w = 1};
		-- Controls.BannerTurns:SetColor(backgroundColor)
		Controls.BannerBody:SetColor(backgroundColor)
		Controls.BannerHeader:SetColor(headerColor)
			
		--GREAT POWER STATUS
		if Player.GetGreatPowerStatus then
			local greatPowerStatusID = pPlayer:GetGreatPowerStatus()
			if greatPowerStatusID ~= -1 then
				local greatPowerStatus = GameInfo.JFD_GreatPowers[greatPowerStatusID]
				strName = greatPowerStatus.IconString .. strName
				
				-- local secondaryColor = GameInfo.Colors[greatPowerStatus.ColorString]
				-- local backgroundColor = {x = secondaryColor.Red, y = secondaryColor.Green, z = secondaryColor.Blue, w = 0.3};
				-- Controls.PlayerEntryAnimGrid:SetColor(backgroundColor)
			end
		end
		
		--EPITHET
		if Player.GetEpithetTitle then
			local strEpithet = pPlayer:GetEpithetTitle()
			if strEpithet then
				strLeaderName = strLeaderName .. " " .. Locale.ConvertTextKey(strEpithet)
			end
		end
		
		--LAND PERCENT
		local numPlotPercent = Game.GetRound(((pPlayer:GetNumPlots()/Map.GetNumPlots())*100),2)
		if strEcoStatsName ~= "" then
			strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		end
		strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		strEcoStatsName = strEcoStatsName .. "Land: " .. numPlotPercent .. "%" 
			
		--POPULATION PERCENT
		local numPopPercent = Game.GetRound(((pPlayer:GetTotalPopulation()/Game.GetTotalPopulation())*100),2)
		strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		strEcoStatsName = strEcoStatsName .. "Pop: " .. numPopPercent .. "%" 
		
		--MILITARY PERCENT
		local numMilitary = pPlayer:GetMilitaryMight()
		local numGlobalMilitary = 0
		for otherPlayerID = 0, GameDefines["MAX_MINOR_CIVS"], 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() and otherPlayerID ~= playerID then
				numGlobalMilitary = numGlobalMilitary + otherPlayer:GetMilitaryMight()
			end
		end
		local numMilitaryPercent = Game.GetRound(((numMilitary/numGlobalMilitary)*100),2)
		strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		strEcoStatsName = strEcoStatsName .. "Mil: " .. numMilitaryPercent .. "%" 
			
		Controls.PlayerGovtStatsText:LocalizeAndSetText(strGovtStatsName)
		Controls.PlayerEcoStatsText:LocalizeAndSetText(strEcoStatsName)
		Controls.PlayerEcoStatsText:LocalizeAndSetToolTip("TXT_KEY_JFD_WORLD_CIVILIZATIONS_ECO_STATS", numPlotPercent, numPopPercent, numMilitaryPercent)
		Controls.PlayerNameText:SetText(strName);
		-- if strFaction ~= "" then
			-- srCivName = "[ICON_JFD_GOVERNMENT]" .. strGovernment .. "[NEWLINE]" .. strFaction .. "[NEWLINE]" .. strIdeology .. "[NEWLINE]" .. strReligion
			-- srCivName = "[ICON_JFD_GOVERNMENT]" .. "[ICON_JFD_FACTION_CONSERVATIVE]" .. "[ICON_IDEOLOGY_AUTOCRACY]" .. "[ICON_RELIGION_BUDDHISM]" 
		-- end
		Controls.PlayerGovtNameText:SetText(strGovernment);
		Controls.PlayerCivNameText:SetText(strLeaderName);
		Controls.RightInfoStack:ReprocessAnchoring()
		
		--Update Relationships
		g_RelationsCivManager:ResetInstances()
		-- g_RelationsCiv2Manager:ResetInstances()
		-- g_RelationsCiv3Manager:ResetInstances()
		-- g_RelationsCiv4Manager:ResetInstances()
		-- local civsWarCount = 0
		-- local civsEnemiesCount = 0
		-- local civsAlliesCount = 0
		-- local civsFriendsCount = 0
		local civRelationsCount = 0
		-- local diploSizeY = 150
		local playerTeam = Teams[pPlayer:GetTeam()]
		for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do	
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() and (not otherPlayer:IsMinorCiv()) and otherPlayerID ~= playerID and playerTeam:IsHasMet(otherPlayer:GetTeam()) then
				if playerTeam:IsAtWar(otherPlayer:GetTeam()) then
					civRelationsCount = civRelationsCount + 1
					
					if civRelationsCount <= 11 then
						local instance = g_RelationsCivManager:GetInstance()
						
						CivIconHookup(otherPlayerID, 32, instance.RelationsCivIcon, instance.RelationsCivIconBG, instance.RelationsCivIconShadow, false, true, instance.RelationsCivIconHighlight)
						instance.RelationsCivIconBox:LocalizeAndSetToolTip(otherPlayer:GetCivilizationDescription())
						
						if playerTeam:IsAtWar(otherPlayer:GetTeam()) then
							instance.RelationsIcon:SetText("[ICON_WAR]")
							instance.RelationsIcon:SetToolTipString("War")
						end
						instance.RelationsIconPlus:SetHide(true)
					elseif civRelationsCount == 12 then
						local numWars = playerTeam:GetAtWarCount(true)-11
						local instance = g_RelationsCivManager:GetInstance()
						instance.RelationsCivIconBox:SetHide(true)
						instance.RelationsIconPlus:SetHide(false)
						instance.RelationsIconPlus:LocalizeAndSetText("+{1_Num}", numWars)
					end
				end
			end
			
			-- Controls.DiploGrid:SetSizeY(diploSizeY)
		end
	end
	
	Controls.LeftInfoStack:ReprocessAnchoring()
	Controls.RightInfoStack:ReprocessAnchoring()
end
GameEvents.PlayerDoTurn.Add(UpdateNewData)
Events.LoadScreenClose.Add(UpdateNewData);
-- Events.AIProcessingStartedForPlayer.Add(UpdateNewData)
Events.SerialEventGameDataDirty.Add(UpdateNewData);
Events.SerialEventTurnTimerDirty.Add(UpdateNewData);
Events.SerialEventCityInfoDirty.Add(UpdateNewData);
Events.SequenceGameInitComplete.Add(UpdateNewData);

function OnShowInterfaceButton()
	if Controls.BannerBody:IsHidden() then
		Controls.BannerBody:SetHide(false)
		Controls.PlayerEntryAnimGrid2:SetHide(false)
		Controls.PlayerFactionNameText:SetHide(false)
		Controls.RightInfoStack:SetHide(false)
		Controls.PlayerCivNameText:SetHide(false)
		Controls.PlayerGovtNameText:SetHide(false)
		Controls.PlayerFactionNameText:SetHide(false)
		Controls.CyclePowerNameText:SetHide(false)
		Controls.ShowInterfaceButton:SetTexture("mainopen.dds")
		Controls.ShowInterfaceMO:SetTexture("mainopen.dds")
		Controls.ShowInterfaceHL:SetTexture("mainopenhl.dds")
	else
		Controls.BannerBody:SetHide(true)
		Controls.PlayerEntryAnimGrid2:SetHide(true)
		Controls.RightInfoStack:SetHide(true)
		Controls.PlayerCivNameText:SetHide(true)
		Controls.PlayerGovtNameText:SetHide(true)
		Controls.PlayerFactionNameText:SetHide(true)
		Controls.CyclePowerNameText:SetHide(true)
		Controls.ShowInterfaceButton:SetTexture("mainclose.dds")
		Controls.ShowInterfaceMO:SetTexture("mainclose.dds")
		Controls.ShowInterfaceHL:SetTexture("mainclosehl.dds")
	end
end
Controls.ShowInterfaceButton:RegisterCallback( Mouse.eLClick, OnShowInterfaceButton );
Events.OpenInfoCorner( nil )

-------------------------------------------------
-------------------------------------------------
local g_PlayerListInstanceManager = InstanceManager:new( "PlayerEntryInstance", "PlayerEntryBox", Controls.PlayerListStack );
function OnWorldCivsListUpdated()
	Controls.WorldCivsList:SetHide(false)
	
	g_PlayerListInstanceManager:ResetInstances();
	
	local worldCivsTable = {}
	local worldCivsCount = 1
	
	for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		
		-- Player has to be alive to be in the list
		local pPlayer = Players[iPlayerLoop];
		if (pPlayer:IsAlive()) then
		
			local iTeam = pPlayer:GetTeam();
			local pTeam = Teams[iTeam];
		
			if pTeam:IsHasMet(Game.GetActiveTeam()) then
			
				local greatPowerRank = iPlayerLoop
				if Player.CalculateGreatPowerStats then
					greatPowerRank = pPlayer:CalculateGreatPowerStats()
				end
				
				worldCivsTable[worldCivsCount] = {PlayerID = iPlayerLoop, GreatPowerRank = greatPowerRank}
				worldCivsCount = worldCivsCount + 1
			end
		end
	end	
		
	table.sort(worldCivsTable, function(a,b) return a.GreatPowerRank > b.GreatPowerRank end)
	
	for _, worldCiv in pairs(worldCivsTable) do
		local iPlayerLoop = worldCiv.PlayerID
		local pPlayer = Players[iPlayerLoop];
		local iTeam = pPlayer:GetTeam();
		local pTeam = Teams[iTeam];
			
		local civDesc = Locale.ToUpper(pPlayer:GetCivilizationShortDescription())
		local leaderDesc = pPlayer:GetName()
		
		-- Use the Civilization_Leaders table to cross reference from this civ to the Leaders table
		local leader = GameInfo.Leaders[pPlayer:GetLeaderType()];
		local leaderDescription = leader.Description;
			
		local strName
		local srCivName = pPlayer:GetCivilizationDescription()
		local strLeaderName = leaderDesc
		local srGovtName
		local strGovtStatsName = ""
		local strEcoStatsName = ""
		
		local controlTable = g_PlayerListInstanceManager:GetInstance();
		
		if (pPlayer:GetID() == Game.GetActivePlayer()) then
			strName = civDesc .. " (" .. Locale.ToUpper( "TXT_KEY_POP_VOTE_RESULTS_YOU" ) .. ")"
		else
			strName = civDesc
		end	
		
		CivIconHookup( iPlayerLoop, 32, controlTable.Icon, controlTable.CivIconBG, controlTable.CivIconShadow, false, true);  
		IconHookup( leader.PortraitIndex, 64, leader.IconAtlas, controlTable.Portrait );
		
		--CYCLES OF POWER
		local cyclePowerID = -1
		if Player.GetCyclePower then
			cyclePowerID = pPlayer:GetCyclePower() or -1
		end				
		if cyclePowerID ~= -1 then
			local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
			controlTable.CyclePower:SetHide(false)		
			strGovtStatsName = "[COLOR_JFD_VIRTUE][ICON_BULLET][ICON_JFD_CYCLE_OF_POWER] " .. Locale.ToUpper(cyclePower.Description) .. "[ENDCOLOR]"
		else
			controlTable.CyclePower:SetHide(true)
		end
		
		--SOVEREIGNTY
		local governmentID = -1
		if Player.GetCurrentGovernment then		
			governmentID = pPlayer:GetCurrentGovernment()
			srGovtName = pPlayer:GetGovernmentName(governmentID)	
			strGovtStatsName = strGovtStatsName .. "[COLOR_JFD_SOVEREIGNTY][ICON_BULLET][ICON_JFD_GOVERNMENT] " .. Locale.ConvertTextKey(GameInfo.JFD_Governments[governmentID].Description) .. "[ENDCOLOR]" 
			-- strGovtStatsName = strGovtStatsName .. " (" .. srGovtName .. ")" 
			
			local factionID = pPlayer:GetDominantFaction()
			if factionID ~= -1 then
				strGovtStatsName = strGovtStatsName .. "[COLOR_JFD_SOVEREIGNTY][ICON_BULLET]" .. GameInfo.JFD_Factions[factionID].IconString .. " " .. Locale.ConvertTextKey(GameInfo.JFD_Factions[factionID].Adjective) .. "[ENDCOLOR]" 
				-- strGovtStatsName = strGovtStatsName .. " (" .. pPlayer:GetFactionName(factionID) .. ")" 
			end
		end
		
		--IDEOLOGY
		local ideologyID = pPlayer:GetIdeology()
		local ideologyFont = nil
		if ideologyID == -1 then
			ideologyID = pPlayer:GetDominantPolicyBranchForTitle()
			ideologyFont = "[ICON_CULTURE]"
		else
			ideologyFont = GameInfo.PolicyBranchTypes[ideologyID].IconString
		end
		if ideologyID ~= -1 then
			strGovtStatsName = strGovtStatsName .. "[COLOR_MAGENTA][ICON_BULLET]" .. ideologyFont .. " " .. Locale.ConvertTextKey(GameInfo.PolicyBranchTypes[ideologyID].Description) .. "[ENDCOLOR]	"
		end
		
		--RELIGION
		local religionID = pPlayer:GetMainReligion()
		local religionFont = nil
		if religionID >= 0 and pPlayer:HasCreatedPantheon() then
			religionFont = GameInfo.Religions[religionID].IconString
			strGovtStatsName = strGovtStatsName .. "[COLOR_WHITE][ICON_BULLET]" .. religionFont .. Locale.ConvertTextKey(GameInfo.Religions[religionID].Description) .. "[ENDCOLOR]"
		end
		
		--STABILITY
		--Update status
		controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_1] [COLOR_HAPPINESS]STABLE[ENDCOLOR]")
		controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_1] [COLOR_HAPPINESS]STABLE[ENDCOLOR]")
		if pPlayer:IsEmpireSuperUnhappy() then
			controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]CIVIL WAR![ENDCOLOR]")
			controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]CIVIL WAR![ENDCOLOR]")
		end
		if pPlayer:IsEmpireVeryUnhappy() then
			controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]CIVIL WAR![ENDCOLOR]")
			controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_4] [COLOR_NEGATIVE_TEXT]CIVIL WAR![ENDCOLOR]")
		end
		if pPlayer:IsEmpireUnhappy() then
			controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_HAPPINESS_3] [COLOR_UNHAPPINESS]REBELLION![ENDCOLOR]")
			controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_HAPPINESS_3] [COLOR_UNHAPPINESS]REBELLION![ENDCOLOR]")
		end
		if pPlayer:IsGoldenAge() then
			controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_GOLDEN_AGE] [COLOR_GOLDEN_AGE]GOLDEN AGE![ENDCOLOR]")
			controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_GOLDEN_AGE] [COLOR_GOLDEN_AGE]GOLDEN AGE![ENDCOLOR]")
		end
		if Player.IsDarkAge and pPlayer:IsDarkAge() then
			controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_DARK_AGE] [COLOR_DARK_AGE]DARK AGE![ENDCOLOR]")
			controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_DARK_AGE] [COLOR_DARK_AGE]DARK AGE![ENDCOLOR]")
		end
		if pPlayer:IsAnarchy() then
			controlTable.PlayerStabilityStatsText:LocalizeAndSetText("[ICON_RESISTANCE] [COLOR_RED]ANARCHY![ENDCOLOR]")
			controlTable.PlayerStabilityStatsText:LocalizeAndSetToolTip("[ICON_RESISTANCE] [COLOR_RED]ANARCHY![ENDCOLOR]")
		end
		
		--AGES
		-- if pPlayer:IsGoldenAge() then
			-- controlTable.AgeIcon:SetText("[ICON_GOLDEN_AGE]")
			-- controlTable.AgeIcon:SetHide(false)
			-- controlTable.PlayerEntryAnim:Play()
			-- controlTable.PlayerEntryAnimGridDA:SetHide(true)
			-- controlTable.PlayerEntryAnimGridNA:SetHide(true)
			-- controlTable.PlayerEntryAnimGridGA:SetHide(true)
		-- elseif Player.IsDarkAge and pPlayer:IsDarkAge() then
			-- controlTable.AgeIcon:SetText("[ICON_DARK_AGE]")
			-- controlTable.AgeIcon:SetHide(false)
			-- controlTable.PlayerEntryAnim:Play()
			-- controlTable.PlayerEntryAnimGridDA:SetHide(true)
			-- controlTable.PlayerEntryAnimGridNA:SetHide(true)
			-- controlTable.PlayerEntryAnimGridGA:SetHide(true)
		-- else
			controlTable.AgeIcon:SetHide(true)
			controlTable.PlayerEntryAnim:Stop()
			controlTable.PlayerEntryAnimGridDA:SetHide(true)
			controlTable.PlayerEntryAnimGridNA:SetHide(true)
			controlTable.PlayerEntryAnimGridGA:SetHide(true)
		-- end
		local primaryColor, secondaryColor = pPlayer:GetPlayerColors();
		local backgroundColor = {x = secondaryColor.x, y = secondaryColor.y, z = secondaryColor.z, w = 0.3};
		controlTable.PlayerEntryAnimGrid:SetColor(backgroundColor)
			
		--GREAT POWER STATUS
		if Player.GetGreatPowerStatus then
			local greatPowerStatusID = pPlayer:GetGreatPowerStatus()
			if greatPowerStatusID ~= -1 then
				local greatPowerStatus = GameInfo.JFD_GreatPowers[greatPowerStatusID]
				strName = greatPowerStatus.IconString .. "[" .. greatPowerStatus.ColorString .. "]" .. strName .. "[ENDCOLOR]"
				
				-- local secondaryColor = GameInfo.Colors[greatPowerStatus.ColorString]
				-- local backgroundColor = {x = secondaryColor.Red, y = secondaryColor.Green, z = secondaryColor.Blue, w = 0.3};
				-- controlTable.PlayerEntryAnimGrid:SetColor(backgroundColor)
			end
		end
		
		--EPITHET
		if Player.GetEpithetTitle then
			local strEpithet = pPlayer:GetEpithetTitle()
			if strEpithet then
				strLeaderName = strLeaderName .. " " .. Locale.ConvertTextKey(strEpithet)
			end
		end
		
		--LAND PERCENT
		local numPlotPercent = Game.GetRound(((pPlayer:GetNumPlots()/Map.GetNumPlots())*100),2)
		if strEcoStatsName ~= "" then
			strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		end
		strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		strEcoStatsName = strEcoStatsName .. "Land: " .. numPlotPercent .. "%" 
			
		--POPULATION PERCENT
		local numPopPercent = Game.GetRound(((pPlayer:GetTotalPopulation()/Game.GetTotalPopulation())*100),2)
		strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		strEcoStatsName = strEcoStatsName .. "Population: " .. numPopPercent .. "%" 
		
		--MILITARY PERCENT
		local numMilitary = pPlayer:GetMilitaryMight()
		local numGlobalMilitary = 0
		for otherPlayerID = 0, GameDefines["MAX_MINOR_CIVS"], 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() and otherPlayerID ~= playerID then
				numGlobalMilitary = numGlobalMilitary + otherPlayer:GetMilitaryMight()
			end
		end
		local numMilitaryPercent = Game.GetRound(((numMilitary/numGlobalMilitary)*100),2)
		strEcoStatsName = strEcoStatsName .. "[ICON_BULLET]"
		strEcoStatsName = strEcoStatsName .. "Military: " .. numMilitaryPercent .. "%" 
			
		controlTable.PlayerGovtStatsText:LocalizeAndSetText(strGovtStatsName)
		controlTable.PlayerEcoStatsText:LocalizeAndSetText(strEcoStatsName)
		controlTable.PlayerEcoStatsText:LocalizeAndSetToolTip("TXT_KEY_JFD_WORLD_CIVILIZATIONS_ECO_STATS", numPlotPercent, numPopPercent, numMilitaryPercent)
		controlTable.PlayerNameText:SetText(strName);
		controlTable.PlayerCivNameText:SetText("[ICON_BULLET]" .. srCivName);
		controlTable.PlayerLeaderNameText:SetText("[ICON_BULLET]" .. strLeaderName);
		controlTable.RightInfoStack:ReprocessAnchoring()
	end
	
	Controls.PlayerListStack:CalculateSize();
	Controls.PlayerListStack:ReprocessAnchoring();
	Controls.PlayerListScrollPanel:CalculateInternalSize();
end
Controls.WorldCivsButton:RegisterCallback( Mouse.eLClick, OnWorldCivsListUpdated );
-------------------------------------------------
-------------------------------------------------
function OnWorldCivsListClose()
	Controls.WorldCivsList:SetHide(true)
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnWorldCivsListClose );
-------------------------------
-- TopPanel.lua
-------------------------------

function UpdateData()

	local iPlayerID = Game.GetActivePlayer();

	if( iPlayerID >= 0 ) then
		local pPlayer = Players[iPlayerID];
		local pTeam = Teams[pPlayer:GetTeam()];
		local pCity = UI.GetHeadSelectedCity();
		
		if (pPlayer:GetNumCities() > 0) then
			
			-- Controls.TopPanelInfoStack:SetHide(false);
			
			if (pCity ~= nil and UI.IsCityScreenUp()) then		
				Controls.MenuButton:SetText(Locale.ToUpper(Locale.ConvertTextKey("TXT_KEY_RETURN")));
				Controls.MenuButton:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_CITY_SCREEN_EXIT_TOOLTIP"));
			else
				Controls.MenuButton:SetText(Locale.ToUpper(Locale.ConvertTextKey("TXT_KEY_MENU")));
				Controls.MenuButton:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_MENU_TOOLTIP"));
			end
			-----------------------------
			-- Update science stats
			-----------------------------
			local strScienceText;
			
			if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_SCIENCE)) then
				strScienceText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_SCIENCE_OFF");
			else
			
				local sciencePerTurn = pPlayer:GetScience();
			
				-- No Science
				if (sciencePerTurn <= 0) then
					strScienceText = string.format("[COLOR:255:60:60:255]" .. Locale.ConvertTextKey("TXT_KEY_NO_SCIENCE") .. "[/COLOR]");
				-- We have science
				else
					strScienceText = string.format("+%i", sciencePerTurn);

					local iGoldPerTurn = pPlayer:CalculateGoldRate();
					
					-- Gold being deducted from our Science
					if (pPlayer:GetGold() + iGoldPerTurn < 0) then
						strScienceText = "[COLOR:255:60:0:255]" .. strScienceText .. "[/COLOR]";
					-- Normal Science state
					else
						strScienceText = "[COLOR:33:190:247:255]" .. strScienceText .. "[/COLOR]";
					end
				end
			
				strScienceText = "[ICON_RESEARCH]" .. strScienceText;
			end
			
			Controls.SciencePerTurn:SetText(strScienceText);
			
			-----------------------------
			-- Update gold stats
			-----------------------------
			local iTotalGold = pPlayer:GetGold();
			local iGoldPerTurn = pPlayer:CalculateGoldRate();
			
			-- Accounting for positive or negative GPT - there's obviously a better way to do this.  If you see this comment and know how, it's up to you ;)
			-- Text is White when you can buy a Plot
			--if (iTotalGold >= pPlayer:GetBuyPlotCost(-1,-1)) then
				--if (iGoldPerTurn >= 0) then
					--strGoldStr = string.format("[COLOR:255:255:255:255]%i (+%i)[/COLOR]", iTotalGold, iGoldPerTurn)
				--else
					--strGoldStr = string.format("[COLOR:255:255:255:255]%i (%i)[/COLOR]", iTotalGold, iGoldPerTurn)
				--end
			---- Text is Yellow or Red when you can't buy a Plot
			--else
			local strGoldStr = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_GOLD", iTotalGold, iGoldPerTurn);
			--end
			
			Controls.GoldPerTurn:SetText(strGoldStr);

			-----------------------------
			-- Update international trade routes
			-----------------------------
			local iUsedTradeRoutes = pPlayer:GetNumInternationalTradeRoutesUsed();
			local iAvailableTradeRoutes = pPlayer:GetNumInternationalTradeRoutesAvailable();
			local strInternationalTradeRoutes = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_INTERNATIONAL_TRADE_ROUTES", iUsedTradeRoutes, iAvailableTradeRoutes);
			Controls.InternationalTradeRoutes:SetText(strInternationalTradeRoutes);
			
			-----------------------------
			-- Update Happiness
			-----------------------------
			local strHappiness;
			
			if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)) then
				strHappiness = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_HAPPINESS_OFF");
			else
				local iHappiness = pPlayer:GetExcessHappiness();
				local tHappinessTextColor;

				-- Empire is Happiness
				if (not pPlayer:IsEmpireUnhappy()) then
					strHappiness = string.format("[ICON_HAPPINESS_1][COLOR:60:255:60:255]%i[/COLOR]", iHappiness);
				
				-- Empire Really Unhappy
				elseif (pPlayer:IsEmpireVeryUnhappy()) then
					strHappiness = string.format("[ICON_HAPPINESS_4][COLOR:255:60:60:255]%i[/COLOR]", -iHappiness);
				
				-- Empire Unhappy
				else
					strHappiness = string.format("[ICON_HAPPINESS_3][COLOR:255:60:60:255]%i[/COLOR]", -iHappiness);
				end
			end
			
			Controls.HappinessString:SetText(strHappiness);
			
			-----------------------------
			-- Update Golden Age Info
			-----------------------------
			local strGoldenAgeStr;

			if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)) then
				strGoldenAgeStr = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_GOLDEN_AGES_OFF");
			else
				if (pPlayer:GetGoldenAgeTurns() > 0) then
				    if (pPlayer:GetGoldenAgeTourismModifier() > 0) then
						strGoldenAgeStr = string.format(Locale.ToUpper(Locale.ConvertTextKey("TXT_KEY_UNIQUE_GOLDEN_AGE_ANNOUNCE")) .. " (%i)", pPlayer:GetGoldenAgeTurns());
					else
						strGoldenAgeStr = string.format(Locale.ToUpper(Locale.ConvertTextKey("TXT_KEY_GOLDEN_AGE_ANNOUNCE")) .. " (%i)", pPlayer:GetGoldenAgeTurns());
					end
				else
					strGoldenAgeStr = string.format("%i/%i", pPlayer:GetGoldenAgeProgressMeter(), pPlayer:GetGoldenAgeProgressThreshold());
				end
			
				strGoldenAgeStr = "[ICON_GOLDEN_AGE][COLOR:255:255:255:255]" .. strGoldenAgeStr .. "[/COLOR]";
			end
			
			Controls.GoldenAgeString:SetText(strGoldenAgeStr);
			
			-----------------------------
			-- Update Culture
			-----------------------------

			local strCultureStr;
			
			if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_POLICIES)) then
				strCultureStr = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_POLICIES_OFF");
			else
			
				if (pPlayer:GetNextPolicyCost() > 0) then
					strCultureStr = string.format("%i/%i (+%i)", pPlayer:GetJONSCulture(), pPlayer:GetNextPolicyCost(), pPlayer:GetTotalJONSCulturePerTurn());
				else
					strCultureStr = string.format("%i (+%i)", pPlayer:GetJONSCulture(), pPlayer:GetTotalJONSCulturePerTurn());
				end
			
				strCultureStr = "[ICON_CULTURE][COLOR:255:0:255:255]" .. strCultureStr .. "[/COLOR]";
			end
			
			Controls.CultureString:SetText(strCultureStr);
			
			-----------------------------
			-- Update Tourism
			-----------------------------
			local strTourism;
			strTourism = string.format("[ICON_TOURISM] +%i", pPlayer:GetTourism());
			Controls.TourismString:SetText(strTourism);
			
			-----------------------------
			-- Update Faith
			-----------------------------
			local strFaithStr;
			if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_RELIGION)) then
				strFaithStr = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_RELIGION_OFF");
			else
				strFaithStr = string.format("%i (+%i)", pPlayer:GetFaith(), pPlayer:GetTotalFaithPerTurn());
				strFaithStr = "[ICON_PEACE]" .. strFaithStr;
			end
			Controls.FaithString:SetText(strFaithStr);
	
			-----------------------------
			-- Update Resources
			-----------------------------
			local pResource;
			local bShowResource;
			local iNumAvailable;
			local iNumUsed;
			local iNumTotal;
			
			local strResourceText = "";
			local strTempText = "";
			
			for pResource in GameInfo.Resources() do
				local iResourceLoop = pResource.ID;
				
				if (Game.GetResourceUsageType(iResourceLoop) == ResourceUsageTypes.RESOURCEUSAGE_STRATEGIC) then
					
					bShowResource = false;
					
					if (pTeam:GetTeamTechs():HasTech(GameInfoTypes[pResource.TechReveal])) then
						if (pTeam:GetTeamTechs():HasTech(GameInfoTypes[pResource.TechCityTrade])) then
							bShowResource = true;
						end
					end
					
					iNumAvailable = pPlayer:GetNumResourceAvailable(iResourceLoop, true);
					iNumUsed = pPlayer:GetNumResourceUsed(iResourceLoop);
					iNumTotal = pPlayer:GetNumResourceTotal(iResourceLoop, true);
					
					if (iNumUsed > 0) then
						bShowResource = true;
					end
							
					if (bShowResource) then
						local text = Locale.ConvertTextKey(pResource.IconString);
						strTempText = string.format("%i %s   ", iNumAvailable, text);
						
						-- Colorize for amount available
						if (iNumAvailable > 0) then
							strTempText = "[COLOR_POSITIVE_TEXT]" .. strTempText .. "[ENDCOLOR]";
						elseif (iNumAvailable < 0) then
							strTempText = "[COLOR_WARNING_TEXT]" .. strTempText .. "[ENDCOLOR]";
						end
						
						strResourceText = strResourceText .. strTempText;
					end
				end
			end
			
			Controls.ResourceString:SetText(strResourceText);
			
		-- No Cities, so hide science
		else
			
			Controls.TopPanelInfoStack:SetHide(true);
			
		end
		
		-- Update turn counter
		local turn = Locale.ConvertTextKey("TXT_KEY_TP_TURN_COUNTER", Game.GetGameTurn());
		Controls.CurrentTurn:SetText(turn);
		
		-- Update Unit Supply
		local iUnitSupplyMod = pPlayer:GetUnitProductionMaintenanceMod();
		if (iUnitSupplyMod ~= 0) then
			local iUnitsSupplied = pPlayer:GetNumUnitsSupplied();
			local iUnitsOver = pPlayer:GetNumUnitsOutOfSupply();
			local strUnitSupplyToolTip = Locale.ConvertTextKey("TXT_KEY_UNIT_SUPPLY_REACHED_TOOLTIP", iUnitsSupplied, iUnitsOver, -iUnitSupplyMod);
			
			Controls.UnitSupplyString:SetToolTipString(strUnitSupplyToolTip);
			Controls.UnitSupplyString:SetHide(false);
		else
			Controls.UnitSupplyString:SetHide(true);
		end
		
		-- Update date
		local date;
		local traditionalDate = Game.GetTurnString();
		
		if (pPlayer:IsUsingMayaCalendar()) then
			date = pPlayer:GetMayaCalendarString();
			local toolTipString = Locale.ConvertTextKey("TXT_KEY_MAYA_DATE_TOOLTIP", pPlayer:GetMayaCalendarLongString(), traditionalDate);
			Controls.CurrentDate:SetToolTipString(toolTipString);
		else
			date = traditionalDate;
		end
		
		Controls.CurrentDate:SetText(date);
	end
end

function OnTopPanelDirty()
	UpdateData();
end

-------------------------------------------------
-------------------------------------------------
function OnCivilopedia()	
	-- In City View, return to main game
	--if (UI.GetHeadSelectedCity() ~= nil) then
		--Events.SerialEventExitCityScreen();
	--end
	--
	-- opens the Civilopedia without changing its current state
	Events.SearchForPediaEntry("");
end
Controls.CivilopediaButton:RegisterCallback( Mouse.eLClick, OnCivilopedia );


-------------------------------------------------
-------------------------------------------------
function OnMenu()
	
	-- In City View, return to main game
	if (UI.GetHeadSelectedCity() ~= nil) then
		Events.SerialEventExitCityScreen();
		--UI.SetInterfaceMode(InterfaceModeTypes.INTERFACEMODE_SELECTION);
	-- In Main View, open Menu Popup
	else
	    UIManager:QueuePopup( LookUpControl( "/InGame/GameMenu" ), PopupPriority.InGameMenu );
	end
end
Controls.MenuButton:RegisterCallback( Mouse.eLClick, OnMenu );


-------------------------------------------------
-------------------------------------------------
function OnCultureClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_CHOOSEPOLICY } );

end
Controls.CultureString:RegisterCallback( Mouse.eLClick, OnCultureClicked );


-------------------------------------------------
-------------------------------------------------
function OnTechClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_TECH_TREE, Data2 = -1} );

end
Controls.SciencePerTurn:RegisterCallback( Mouse.eLClick, OnTechClicked );

-------------------------------------------------
-------------------------------------------------
function OnTourismClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_CULTURE_OVERVIEW, Data2 = 4 } );

end
Controls.TourismString:RegisterCallback( Mouse.eLClick, OnTourismClicked );


-------------------------------------------------
-------------------------------------------------
function OnFaithClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_RELIGION_OVERVIEW } );

end
Controls.FaithString:RegisterCallback( Mouse.eLClick, OnFaithClicked );
-------------------------------------------------
-------------------------------------------------
function OnGoldClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_ECONOMIC_OVERVIEW } );

end
Controls.GoldPerTurn:RegisterCallback( Mouse.eLClick, OnGoldClicked );
-------------------------------------------------
-------------------------------------------------
function OnTradeRouteClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_TRADE_ROUTE_OVERVIEW } );

end
Controls.InternationalTradeRoutes:RegisterCallback( Mouse.eLClick, OnTradeRouteClicked );
-------------------------------------------------
-------------------------------------------------
function OnScoreClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_DEMOGRAPHICS } );

end
-------------------------------------------------
-------------------------------------------------
function OnMilitaryClicked()
	
	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_MILITARY_OVERVIEW } );

end
-------------------------------------------------
-------------------------------------------------
function OnGovernmentClicked()
	
	LuaEvents.UI_ShowGovernmentOverview()

end

-------------------------------------------------
-------------------------------------------------

Controls.Score:RegisterCallback( Mouse.eLClick, OnScoreClicked );
Controls.DominantPolicy:RegisterCallback( Mouse.eLClick, OnCultureClicked );
Controls.CurrentResearch:RegisterCallback( Mouse.eLClick, OnTechClicked );
Controls.DominantReligion:RegisterCallback( Mouse.eLClick, OnFaithClicked );
Controls.CurrentGovernment:RegisterCallback( Mouse.eLClick, OnGovernmentClicked );
Controls.DominantFaction:RegisterCallback( Mouse.eLClick, OnGovernmentClicked );
Controls.CurrentPopulation:RegisterCallback( Mouse.eLClick, OnGoldClicked );
Controls.CurrentManpower:RegisterCallback( Mouse.eLClick, OnMilitaryClicked );
Controls.CurrentUnitSupplyProportion:RegisterCallback( Mouse.eLClick, OnMilitaryClicked );
Controls.CurrentProduction:RegisterCallback( Mouse.eLClick, OnGoldClicked );
Controls.StatusText:RegisterCallback( Mouse.eLClick, OnGoldClicked );
Controls.CurrentLandmass:RegisterCallback( Mouse.eLClick, OnGoldClicked );


-------------------------------------------------
-- TOOLTIPS
-------------------------------------------------


-- Tooltip init
function DoInitTooltips()
	Controls.SciencePerTurn:SetToolTipCallback( ScienceTipHandler );
	Controls.GoldPerTurn:SetToolTipCallback( GoldTipHandler );
	Controls.HappinessString:SetToolTipCallback( HappinessTipHandler );
	Controls.GoldenAgeString:SetToolTipCallback( GoldenAgeTipHandler );
	Controls.CultureString:SetToolTipCallback( CultureTipHandler );
	Controls.TourismString:SetToolTipCallback( TourismTipHandler );
	Controls.FaithString:SetToolTipCallback( FaithTipHandler );
	Controls.ResourceString:SetToolTipCallback( ResourcesTipHandler );
	Controls.InternationalTradeRoutes:SetToolTipCallback( InternationalTradeRoutesTipHandler );
end

-- Science Tooltip
local tipControlTable = {};
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable );
function ScienceTipHandler( control )

	local strText = "";
	
	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_SCIENCE)) then
		strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_SCIENCE_OFF_TOOLTIP");
	else
	
		local iPlayerID = Game.GetActivePlayer();
		local pPlayer = Players[iPlayerID];
		local pTeam = Teams[pPlayer:GetTeam()];
		local pCity = UI.GetHeadSelectedCity();
	
		local iSciencePerTurn = pPlayer:GetScience();
	
		if (pPlayer:IsAnarchy()) then
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_ANARCHY", pPlayer:GetAnarchyNumTurns());
			strText = strText .. "[NEWLINE][NEWLINE]";
		end
	
		-- Science
		if (not OptionsManager.IsNoBasicHelp()) then
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE", iSciencePerTurn);
		
			if (pPlayer:GetNumCities() > 0) then
				strText = strText .. "[NEWLINE][NEWLINE]";
			end
		end
	
		local bFirstEntry = true;
	
		-- Science LOSS from Budget Deficits
		local iScienceFromBudgetDeficit = pPlayer:GetScienceFromBudgetDeficitTimes100();
		if (iScienceFromBudgetDeficit ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strText = strText .. "[NEWLINE]";
			end

			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE_FROM_BUDGET_DEFICIT", iScienceFromBudgetDeficit / 100);
			strText = strText .. "[NEWLINE]";
		end
	
		-- Science from Cities
		local iScienceFromCities = pPlayer:GetScienceFromCitiesTimes100(true);
		if (iScienceFromCities ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strText = strText .. "[NEWLINE]";
			end

			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE_FROM_CITIES", iScienceFromCities / 100);
		end
	
		-- Science from Trade Routes
		local iScienceFromTrade = pPlayer:GetScienceFromCitiesTimes100(false) - iScienceFromCities;
		if (iScienceFromTrade ~= 0) then
			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strText = strText .. "[NEWLINE]";
			end
			
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE_FROM_ITR", iScienceFromTrade / 100);
		end
	
		-- Science from Other Players
		local iScienceFromOtherPlayers = pPlayer:GetScienceFromOtherPlayersTimes100();
		if (iScienceFromOtherPlayers ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strText = strText .. "[NEWLINE]";
			end

			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE_FROM_MINORS", iScienceFromOtherPlayers / 100);
		end
	
		-- Science from Happiness
		local iScienceFromHappiness = pPlayer:GetScienceFromHappinessTimes100();
		if (iScienceFromHappiness ~= 0) then
			
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strText = strText .. "[NEWLINE]";
			end
	
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE_FROM_HAPPINESS", iScienceFromHappiness / 100);
		end
	
		-- Science from Research Agreements
		local iScienceFromRAs = pPlayer:GetScienceFromResearchAgreementsTimes100();
		if (iScienceFromRAs ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				bFirstEntry = false;
			else
				strText = strText .. "[NEWLINE]";
			end
	
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_SCIENCE_FROM_RESEARCH_AGREEMENTS", iScienceFromRAs / 100);
		end
		
		-- Let people know that building more cities makes techs harder to get
		if (not OptionsManager.IsNoBasicHelp()) then
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_TECH_CITY_COST", Game.GetNumCitiesTechCostMod());
		end
	end
	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- Gold Tooltip
function GoldTipHandler( control )

	local strText = "";
	local iPlayerID = Game.GetActivePlayer();
	local pPlayer = Players[iPlayerID];
	local pTeam = Teams[pPlayer:GetTeam()];
	local pCity = UI.GetHeadSelectedCity();
	
	local iTotalGold = pPlayer:GetGold();

	local iGoldPerTurnFromOtherPlayers = pPlayer:GetGoldPerTurnFromDiplomacy();
	local iGoldPerTurnToOtherPlayers = 0;
	if (iGoldPerTurnFromOtherPlayers < 0) then
		iGoldPerTurnToOtherPlayers = -iGoldPerTurnFromOtherPlayers;
		iGoldPerTurnFromOtherPlayers = 0;
	end
	
	local iGoldPerTurnFromReligion = pPlayer:GetGoldPerTurnFromReligion();

	local fTradeRouteGold = (pPlayer:GetGoldFromCitiesTimes100() - pPlayer:GetGoldFromCitiesMinusTradeRoutesTimes100()) / 100;
	local fGoldPerTurnFromCities = pPlayer:GetGoldFromCitiesMinusTradeRoutesTimes100() / 100;
	local fCityConnectionGold = pPlayer:GetCityConnectionGoldTimes100() / 100;
	--local fInternationalTradeRouteGold = pPlayer:GetGoldPerTurnFromTradeRoutesTimes100() / 100;
	local fTraitGold = pPlayer:GetGoldPerTurnFromTraits();
	local fTotalIncome = fGoldPerTurnFromCities + iGoldPerTurnFromOtherPlayers + fCityConnectionGold + iGoldPerTurnFromReligion + fTradeRouteGold + fTraitGold;
	
	if (pPlayer:IsAnarchy()) then
		strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_ANARCHY", pPlayer:GetAnarchyNumTurns());
		strText = strText .. "[NEWLINE][NEWLINE]";
	end
	
	if (not OptionsManager.IsNoBasicHelp()) then
		strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_AVAILABLE_GOLD", iTotalGold);
		strText = strText .. "[NEWLINE][NEWLINE]";
	end
	
	strText = strText .. "[COLOR:150:255:150:255]";
	strText = strText .. "+" .. Locale.ConvertTextKey("TXT_KEY_TP_TOTAL_INCOME", math.floor(fTotalIncome));
	strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_CITY_OUTPUT", fGoldPerTurnFromCities);
	strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_FROM_CITY_CONNECTIONS", math.floor(fCityConnectionGold));
	strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_FROM_ITR", math.floor(fTradeRouteGold));
	if (math.floor(fTraitGold) > 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_FROM_TRAITS", math.floor(fTraitGold));
	end
	if (iGoldPerTurnFromOtherPlayers > 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_FROM_OTHERS", iGoldPerTurnFromOtherPlayers);
	end
	if (iGoldPerTurnFromReligion > 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_FROM_RELIGION", iGoldPerTurnFromReligion);
	end
	strText = strText .. "[/COLOR]";
	
	local iUnitCost = pPlayer:CalculateUnitCost();
	local iUnitSupply = pPlayer:CalculateUnitSupply();
	local iBuildingMaintenance = pPlayer:GetBuildingGoldMaintenance();
	local iImprovementMaintenance = pPlayer:GetImprovementGoldMaintenance();
	local iTotalExpenses = iUnitCost + iUnitSupply + iBuildingMaintenance + iImprovementMaintenance + iGoldPerTurnToOtherPlayers;
	
	strText = strText .. "[NEWLINE]";
	strText = strText .. "[COLOR:255:150:150:255]";
	strText = strText .. "[NEWLINE]-" .. Locale.ConvertTextKey("TXT_KEY_TP_TOTAL_EXPENSES", iTotalExpenses);
	if (iUnitCost ~= 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNIT_MAINT", iUnitCost);
	end
	if (iUnitSupply ~= 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_UNIT_SUPPLY", iUnitSupply);
	end
	if (iBuildingMaintenance ~= 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_BUILDING_MAINT", iBuildingMaintenance);
	end
	if (iImprovementMaintenance ~= 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_TILE_MAINT", iImprovementMaintenance);
	end
	if (iGoldPerTurnToOtherPlayers > 0) then
		strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLD_TO_OTHERS", iGoldPerTurnToOtherPlayers);
	end
	strText = strText .. "[/COLOR]";
	
	if (fTotalIncome + iTotalGold < 0) then
		strText = strText .. "[NEWLINE][COLOR:255:60:60:255]" .. Locale.ConvertTextKey("TXT_KEY_TP_LOSING_SCIENCE_FROM_DEFICIT") .. "[/COLOR]";
	end
	
	-- Basic explanation of Happiness
	if (not OptionsManager.IsNoBasicHelp()) then
		strText = strText .. "[NEWLINE][NEWLINE]";
		strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_GOLD_EXPLANATION");
	end
	
	--Controls.GoldPerTurn:SetToolTipString(strText);
	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- Happiness Tooltip
function HappinessTipHandler( control )

	local strText;
	
	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)) then
		strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_HAPPINESS_OFF_TOOLTIP");
	else
		local iPlayerID = Game.GetActivePlayer();
		local pPlayer = Players[iPlayerID];
		local pTeam = Teams[pPlayer:GetTeam()];
		local pCity = UI.GetHeadSelectedCity();
	
		local iHappiness = pPlayer:GetExcessHappiness();

		if (not pPlayer:IsEmpireUnhappy()) then
			strText = Locale.ConvertTextKey("TXT_KEY_TP_TOTAL_HAPPINESS", iHappiness);
		elseif (pPlayer:IsEmpireVeryUnhappy()) then
			strText = Locale.ConvertTextKey("TXT_KEY_TP_TOTAL_UNHAPPINESS", "[ICON_HAPPINESS_4]", -iHappiness);
		else
			strText = Locale.ConvertTextKey("TXT_KEY_TP_TOTAL_UNHAPPINESS", "[ICON_HAPPINESS_3]", -iHappiness);
		end
	
		local iPoliciesHappiness = pPlayer:GetHappinessFromPolicies();
		local iResourcesHappiness = pPlayer:GetHappinessFromResources();
		local iExtraLuxuryHappiness = pPlayer:GetExtraHappinessPerLuxury();
		local iCityHappiness = pPlayer:GetHappinessFromCities();
		local iBuildingHappiness = pPlayer:GetHappinessFromBuildings();
		local iTradeRouteHappiness = pPlayer:GetHappinessFromTradeRoutes();
		local iReligionHappiness = pPlayer:GetHappinessFromReligion();
		local iNaturalWonderHappiness = pPlayer:GetHappinessFromNaturalWonders();
		local iExtraHappinessPerCity = pPlayer:GetExtraHappinessPerCity() * pPlayer:GetNumCities();
		local iMinorCivHappiness = pPlayer:GetHappinessFromMinorCivs();
		local iLeagueHappiness = pPlayer:GetHappinessFromLeagues();
	
		local iHandicapHappiness = pPlayer:GetHappiness() - iPoliciesHappiness - iResourcesHappiness - iCityHappiness - iBuildingHappiness - iTradeRouteHappiness - iReligionHappiness - iNaturalWonderHappiness - iMinorCivHappiness - iExtraHappinessPerCity - iLeagueHappiness;
	
		if (pPlayer:IsEmpireVeryUnhappy()) then
		
			if (pPlayer:IsEmpireSuperUnhappy()) then
				strText = strText .. "[NEWLINE][NEWLINE]";
				strText = strText .. "[COLOR:255:60:60:255]" .. Locale.ConvertTextKey("TXT_KEY_TP_EMPIRE_SUPER_UNHAPPY") .. "[/COLOR]";
			end
		
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText .. "[COLOR:255:60:60:255]" .. Locale.ConvertTextKey("TXT_KEY_TP_EMPIRE_VERY_UNHAPPY") .. "[/COLOR]";
		elseif (pPlayer:IsEmpireUnhappy()) then
		
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText .. "[COLOR:255:60:60:255]" .. Locale.ConvertTextKey("TXT_KEY_TP_EMPIRE_UNHAPPY") .. "[/COLOR]";
		end
	
		local iTotalHappiness = iPoliciesHappiness + iResourcesHappiness + iCityHappiness + iBuildingHappiness + iMinorCivHappiness + iHandicapHappiness + iTradeRouteHappiness + iReligionHappiness + iNaturalWonderHappiness + iExtraHappinessPerCity + iLeagueHappiness;
	
		strText = strText .. "[NEWLINE][NEWLINE]";
		strText = strText .. "[COLOR:150:255:150:255]";
		strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_SOURCES", iTotalHappiness);
	
		strText = strText .. "[NEWLINE]";
		strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_FROM_RESOURCES", iResourcesHappiness);
	
		-- Individual Resource Info
	
		local iBaseHappinessFromResources = 0;
		local iNumHappinessResources = 0;

		for resource in GameInfo.Resources() do
			local resourceID = resource.ID;
			local iHappiness = pPlayer:GetHappinessFromLuxury(resourceID);
			if (iHappiness > 0) then
				strText = strText .. "[NEWLINE]";
				strText = strText .. "          +" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_EACH_RESOURCE", iHappiness, resource.IconString, resource.Description);
				iNumHappinessResources = iNumHappinessResources + 1;
				iBaseHappinessFromResources = iBaseHappinessFromResources + iHappiness;
			end
		end
	
		-- Happiness from Luxury Variety
		local iHappinessFromExtraResources = pPlayer:GetHappinessFromResourceVariety();
		if (iHappinessFromExtraResources > 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "          +" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_RESOURCE_VARIETY", iHappinessFromExtraResources);
		end
	
		-- Extra Happiness from each Luxury
		if (iExtraLuxuryHappiness >= 1) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "          +" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_EXTRA_PER_RESOURCE", iExtraLuxuryHappiness, iNumHappinessResources);
		end
	
		-- Misc Happiness from Resources
		local iMiscHappiness = iResourcesHappiness - iBaseHappinessFromResources - iHappinessFromExtraResources - (iExtraLuxuryHappiness * iNumHappinessResources);
		if (iMiscHappiness > 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "          +" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_OTHER_SOURCES", iMiscHappiness);
		end
	
		strText = strText .. "[NEWLINE]";
		strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_CITIES", iCityHappiness);
		if (iPoliciesHappiness >= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_POLICIES", iPoliciesHappiness);
		end
		strText = strText .. "[NEWLINE]";
		strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_BUILDINGS", iBuildingHappiness);
		if (iTradeRouteHappiness ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_CONNECTED_CITIES", iTradeRouteHappiness);
		end
		if (iReligionHappiness ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_STATE_RELIGION", iReligionHappiness);
		end
		if (iNaturalWonderHappiness ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_NATURAL_WONDERS", iNaturalWonderHappiness);
		end
		if (iExtraHappinessPerCity ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_CITY_COUNT", iExtraHappinessPerCity);
		end
		if (iMinorCivHappiness ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_CITY_STATE_FRIENDSHIP", iMinorCivHappiness);
		end
		if (iLeagueHappiness ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_LEAGUES", iLeagueHappiness);
		end
		strText = strText .. "[NEWLINE]";
		strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_DIFFICULTY_LEVEL", iHandicapHappiness);
		strText = strText .. "[/COLOR]";
	
		-- Unhappiness
		local iTotalUnhappiness = pPlayer:GetUnhappiness();
		local iUnhappinessFromUnits = Locale.ToNumber( pPlayer:GetUnhappinessFromUnits() / 100, "#.##" );
		local iUnhappinessFromCityCount = Locale.ToNumber( pPlayer:GetUnhappinessFromCityCount() / 100, "#.##" );
		local iUnhappinessFromCapturedCityCount = Locale.ToNumber( pPlayer:GetUnhappinessFromCapturedCityCount() / 100, "#.##" );
		
		local iUnhappinessFromPupetCities = pPlayer:GetUnhappinessFromPuppetCityPopulation();
		local unhappinessFromSpecialists = pPlayer:GetUnhappinessFromCitySpecialists();
		local unhappinessFromPop = pPlayer:GetUnhappinessFromCityPopulation() - unhappinessFromSpecialists - iUnhappinessFromPupetCities;
			
		local iUnhappinessFromPop = Locale.ToNumber( unhappinessFromPop / 100, "#.##" );
		local iUnhappinessFromOccupiedCities = Locale.ToNumber( pPlayer:GetUnhappinessFromOccupiedCities() / 100, "#.##" );
		local iUnhappinessPublicOpinion = pPlayer:GetUnhappinessFromPublicOpinion();
		
		strText = strText .. "[NEWLINE][NEWLINE]";
		strText = strText .. "[COLOR:255:150:150:255]";
		strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_TOTAL", iTotalUnhappiness);
		strText = strText .. "[NEWLINE]";
		strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_CITY_COUNT", iUnhappinessFromCityCount);
		if (iUnhappinessFromCapturedCityCount ~= "0") then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_CAPTURED_CITY_COUNT", iUnhappinessFromCapturedCityCount);
		end
		strText = strText .. "[NEWLINE]";
		strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_POPULATION", iUnhappinessFromPop);
		
		if(iUnhappinessFromPupetCities > 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_PUPPET_CITIES", iUnhappinessFromPupetCities / 100);
		end
		
		if(unhappinessFromSpecialists > 0) then
			strText = strText .. "[NEWLINE]  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_SPECIALISTS", unhappinessFromSpecialists / 100);
		end
		
		if (iUnhappinessFromOccupiedCities ~= "0") then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_OCCUPIED_POPULATION", iUnhappinessFromOccupiedCities);
		end
		if (iUnhappinessFromUnits ~= "0") then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_UNITS", iUnhappinessFromUnits);
		end
		if (iPoliciesHappiness < 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_POLICIES", iPoliciesHappiness);
		end		
		if (iUnhappinessPublicOpinion > 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. "  [ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_TP_UNHAPPINESS_PUBLIC_OPINION", iUnhappinessPublicOpinion);
		end		
		strText = strText .. "[/COLOR]";
	
		-- Basic explanation of Happiness
		if (not OptionsManager.IsNoBasicHelp()) then
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_HAPPINESS_EXPLANATION");
		end
	end
	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- Golden Age Tooltip
function GoldenAgeTipHandler( control )

	local strText;
	
	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)) then
		strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_HAPPINESS_OFF_TOOLTIP");
	else
		local iPlayerID = Game.GetActivePlayer();
		local pPlayer = Players[iPlayerID];
		local pTeam = Teams[pPlayer:GetTeam()];
		local pCity = UI.GetHeadSelectedCity();
	
		if (pPlayer:GetGoldenAgeTurns() > 0) then
			strText = Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_NOW", pPlayer:GetGoldenAgeTurns());
		else
			local iHappiness = pPlayer:GetExcessHappiness();

			strText = Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_PROGRESS", pPlayer:GetGoldenAgeProgressMeter(), pPlayer:GetGoldenAgeProgressThreshold());
			strText = strText .. "[NEWLINE]";
		
			if (iHappiness >= 0) then
				strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_ADDITION", iHappiness);
			else
				strText = strText .. "[COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_LOSS", -iHappiness) .. "[ENDCOLOR]";
			end
		end
	
		strText = strText .. "[NEWLINE][NEWLINE]";
		if (pPlayer:IsGoldenAgeCultureBonusDisabled()) then
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_EFFECT_NO_CULTURE");		
		else
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_EFFECT");		
		end
		
		if (pPlayer:GetGoldenAgeTurns() > 0 and pPlayer:GetGoldenAgeTourismModifier() > 0) then
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_CARNIVAL_EFFECT");			
		end
	end
	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- Culture Tooltip
function CultureTipHandler( control )

	local strText = "";
	
	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_POLICIES)) then
		strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_POLICIES_OFF_TOOLTIP");
	else
	
		local iPlayerID = Game.GetActivePlayer();
		local pPlayer = Players[iPlayerID];
    
	    local iTurns;
		local iCultureNeeded = pPlayer:GetNextPolicyCost() - pPlayer:GetJONSCulture();
	    if (iCultureNeeded <= 0) then
			iTurns = 0;
		else
			if (pPlayer:GetTotalJONSCulturePerTurn() == 0) then
				iTurns = "?";
			else
				iTurns = iCultureNeeded / pPlayer:GetTotalJONSCulturePerTurn();
				iTurns = math.ceil(iTurns);
			end
	    end
	    
	    if (pPlayer:IsAnarchy()) then
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_ANARCHY", pPlayer:GetAnarchyNumTurns());
		end
	    
		strText = strText .. Locale.ConvertTextKey("TXT_KEY_NEXT_POLICY_TURN_LABEL", iTurns);
	
		if (not OptionsManager.IsNoBasicHelp()) then
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_ACCUMULATED", pPlayer:GetJONSCulture());
			strText = strText .. "[NEWLINE]";
		
			if (pPlayer:GetNextPolicyCost() > 0) then
				strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_NEXT_POLICY", pPlayer:GetNextPolicyCost());
			end
		end

		if (pPlayer:IsAnarchy()) then
			tipControlTable.TooltipLabel:SetText( strText );
			tipControlTable.TopPanelMouseover:SetHide(false);
			tipControlTable.TopPanelMouseover:DoAutoSize();
			return;
		end

		local bFirstEntry = true;
		
		-- Culture for Free
		local iCultureForFree = pPlayer:GetJONSCulturePerTurnForFree();
		if (iCultureForFree ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FOR_FREE", iCultureForFree);
		end
	
		-- Culture from Cities
		local iCultureFromCities = pPlayer:GetJONSCulturePerTurnFromCities();
		if (iCultureFromCities ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_CITIES", iCultureFromCities);
		end
	
		-- Culture from Excess Happiness
		local iCultureFromHappiness = pPlayer:GetJONSCulturePerTurnFromExcessHappiness();
		if (iCultureFromHappiness ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_HAPPINESS", iCultureFromHappiness);
		end
	
		-- Culture from Traits
		local iCultureFromTraits = pPlayer:GetJONSCulturePerTurnFromTraits();
		if (iCultureFromTraits ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_TRAITS", iCultureFromTraits);
		end
	
		-- Culture from Minor Civs
		local iCultureFromMinors = pPlayer:GetCulturePerTurnFromMinorCivs();
		if (iCultureFromMinors ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_MINORS", iCultureFromMinors);
		end

		-- Culture from Religion
		local iCultureFromReligion = pPlayer:GetCulturePerTurnFromReligion();
		if (iCultureFromReligion ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_RELIGION", iCultureFromReligion);
		end
		
		-- Culture from a bonus turns (League Project)
		local iCultureFromBonusTurns = pPlayer:GetCulturePerTurnFromBonusTurns();
		if (iCultureFromBonusTurns ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			local iBonusTurns = pPlayer:GetCultureBonusTurns();
			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_BONUS_TURNS", iCultureFromBonusTurns, iBonusTurns);
		end
		
		-- Culture from Golden Age
		local iCultureFromGoldenAge = pPlayer:GetTotalJONSCulturePerTurn() - iCultureForFree - iCultureFromCities - iCultureFromHappiness - iCultureFromMinors - iCultureFromReligion - iCultureFromTraits - iCultureFromBonusTurns;
		if (iCultureFromGoldenAge ~= 0) then
		
			-- Add separator for non-initial entries
			if (bFirstEntry) then
				strText = strText .. "[NEWLINE]";
				bFirstEntry = false;
			end

			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_FROM_GOLDEN_AGE", iCultureFromGoldenAge);
		end

		-- Let people know that building more cities makes policies harder to get
		if (not OptionsManager.IsNoBasicHelp()) then
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_CULTURE_CITY_COST", Game.GetNumCitiesPolicyCostMod());
		end
	end
	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- Tourism Tooltip
function TourismTipHandler( control )

	local iPlayerID = Game.GetActivePlayer();
	local pPlayer = Players[iPlayerID];
	
	local iTotalGreatWorks = pPlayer:GetNumGreatWorks();
	local iTotalSlots = pPlayer:GetNumGreatWorkSlots();
	
	local strText1 = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_TOURISM_TOOLTIP_1", iTotalGreatWorks);
	local strText2 = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_TOURISM_TOOLTIP_2", (iTotalSlots - iTotalGreatWorks));
		
	local strText = strText1 .. "[NEWLINE]" .. strText2;
		
	local cultureVictory = GameInfo.Victories["VICTORY_CULTURAL"];
	if(cultureVictory ~= nil and PreGame.IsVictory(cultureVictory.ID)) then
	    local iNumInfluential = pPlayer:GetNumCivsInfluentialOn();
		local iNumToBeInfluential = pPlayer:GetNumCivsToBeInfluentialOn();
		local szText = Locale.ConvertTextKey("TXT_KEY_CO_VICTORY_INFLUENTIAL_OF", iNumInfluential, iNumToBeInfluential);

		local strText3 = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_TOURISM_TOOLTIP_3", szText);
		
		strText = strText .. "[NEWLINE][NEWLINE]" .. strText3;
	end	

	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- FaithTooltip
function FaithTipHandler( control )

	local strText = "";

	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_RELIGION)) then
		strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_RELIGION_OFF_TOOLTIP");
	else
	
		local iPlayerID = Game.GetActivePlayer();
		local pPlayer = Players[iPlayerID];

	    if (pPlayer:IsAnarchy()) then
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_ANARCHY", pPlayer:GetAnarchyNumTurns());
			strText = strText .. "[NEWLINE]";
			strText = strText .. "[NEWLINE]";
		end
	    
		strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_ACCUMULATED", pPlayer:GetFaith());
		strText = strText .. "[NEWLINE]";
	
		-- Faith from Cities
		local iFaithFromCities = pPlayer:GetFaithPerTurnFromCities();
		if (iFaithFromCities ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_FROM_CITIES", iFaithFromCities);
		end
	
		-- Faith from Minor Civs
		local iFaithFromMinorCivs = pPlayer:GetFaithPerTurnFromMinorCivs();
		if (iFaithFromMinorCivs ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_FROM_MINORS", iFaithFromMinorCivs);
		end

		-- Faith from Religion
		local iFaithFromReligion = pPlayer:GetFaithPerTurnFromReligion();
		if (iFaithFromReligion ~= 0) then
			strText = strText .. "[NEWLINE]";
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_FROM_RELIGION", iFaithFromReligion);
		end
		
		if (iFaithFromCities ~= 0 or iFaithFromMinorCivs ~= 0 or iFaithFromReligion ~= 0) then
			strText = strText .. "[NEWLINE]";
		end
	
		strText = strText .. "[NEWLINE]";

		if (pPlayer:HasCreatedPantheon()) then
			if (Game.GetNumReligionsStillToFound() > 0 or pPlayer:HasCreatedReligion()) then
				if (pPlayer:GetCurrentEra() < GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
					strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_NEXT_PROPHET", pPlayer:GetMinimumFaithNextGreatProphet());
					strText = strText .. "[NEWLINE]";
					strText = strText .. "[NEWLINE]";
				end
			end
		else
			if (pPlayer:CanCreatePantheon(false)) then
				strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_NEXT_PANTHEON", Game.GetMinimumFaithNextPantheon());
				strText = strText .. "[NEWLINE]";
			else
				strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_PANTHEONS_LOCKED");
				strText = strText .. "[NEWLINE]";
			end
			strText = strText .. "[NEWLINE]";
		end

		if (Game.GetNumReligionsStillToFound() < 0) then
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_RELIGIONS_LEFT", 0);
		else
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_RELIGIONS_LEFT", Game.GetNumReligionsStillToFound());
		end
		
		if (pPlayer:GetCurrentEra() >= GameInfo.Eras["ERA_INDUSTRIAL"].ID) then
		    local bAnyFound = false;
			strText = strText .. "[NEWLINE]";		
			strText = strText .. "[NEWLINE]";		
			strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_FAITH_NEXT_GREAT_PERSON", pPlayer:GetMinimumFaithNextGreatProphet());	
			
			local capital = pPlayer:GetCapitalCity();
			if(capital ~= nil) then	
				for info in GameInfo.Units{Special = "SPECIALUNIT_PEOPLE"} do
					local infoID = info.ID;
					local faithCost = capital:GetUnitFaithPurchaseCost(infoID, true);
					if(faithCost > 0 and pPlayer:IsCanPurchaseAnyCity(false, true, infoID, -1, YieldTypes.YIELD_FAITH)) then
						if (pPlayer:DoesUnitPassFaithPurchaseCheck(infoID)) then
							strText = strText .. "[NEWLINE]";
							strText = strText .. "[ICON_BULLET]" .. Locale.ConvertTextKey(info.Description);
							bAnyFound = true;
						end
					end
				end
			end
						
			if (not bAnyFound) then
				strText = strText .. "[NEWLINE]";
				strText = strText .. "[ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_RO_YR_NO_GREAT_PEOPLE");
			end
		end
	end

	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- Resources Tooltip
function ResourcesTipHandler( control )

	local strText;
	local iPlayerID = Game.GetActivePlayer();
	local pPlayer = Players[iPlayerID];
	local pTeam = Teams[pPlayer:GetTeam()];
	local pCity = UI.GetHeadSelectedCity();
	
	strText = "";
	
	local pResource;
	local bShowResource;
	local bThisIsFirstResourceShown = true;
	local iNumAvailable;
	local iNumUsed;
	local iNumTotal;
	
	for pResource in GameInfo.Resources() do
		local iResourceLoop = pResource.ID;
		
		if (Game.GetResourceUsageType(iResourceLoop) == ResourceUsageTypes.RESOURCEUSAGE_STRATEGIC) then
			
			bShowResource = false;
			
			if (pTeam:GetTeamTechs():HasTech(GameInfoTypes[pResource.TechReveal])) then
				if (pTeam:GetTeamTechs():HasTech(GameInfoTypes[pResource.TechCityTrade])) then
					bShowResource = true;
				end
			end
			
			if (bShowResource) then
				iNumAvailable = pPlayer:GetNumResourceAvailable(iResourceLoop, true);
				iNumUsed = pPlayer:GetNumResourceUsed(iResourceLoop);
				iNumTotal = pPlayer:GetNumResourceTotal(iResourceLoop, true);
				
				-- Add newline to the front of all entries that AREN'T the first
				if (bThisIsFirstResourceShown) then
					strText = "";
					bThisIsFirstResourceShown = false;
				else
					strText = strText .. "[NEWLINE][NEWLINE]";
				end
				
				strText = strText .. iNumAvailable .. " " .. pResource.IconString .. " " .. Locale.ConvertTextKey(pResource.Description);
				
				-- Details
				if (iNumUsed ~= 0 or iNumTotal ~= 0) then
					strText = strText .. ": ";
					strText = strText .. Locale.ConvertTextKey("TXT_KEY_TP_RESOURCE_INFO", iNumTotal, iNumUsed);
				end
			end
		end
	end
	
	print(strText);
	if(strText ~= "") then
		tipControlTable.TopPanelMouseover:SetHide(false);
		tipControlTable.TooltipLabel:SetText( strText );
	else
		tipControlTable.TopPanelMouseover:SetHide(true);
	end
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
	
end

-- International Trade Route Tooltip
function InternationalTradeRoutesTipHandler( control )

	local iPlayerID = Game.GetActivePlayer();
	local pPlayer = Players[iPlayerID];
	
	local strTT = "";
	
	local iNumLandTradeUnitsAvail = pPlayer:GetNumAvailableTradeUnits(DomainTypes.DOMAIN_LAND);
	if (iNumLandTradeUnitsAvail > 0) then
		local iTradeUnitType = pPlayer:GetTradeUnitType(DomainTypes.DOMAIN_LAND);
		local strUnusedTradeUnitWarning = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_INTERNATIONAL_TRADE_ROUTES_TT_UNASSIGNED", iNumLandTradeUnitsAvail, GameInfo.Units[iTradeUnitType].Description);
		strTT = strTT .. strUnusedTradeUnitWarning;
	end
	
	local iNumSeaTradeUnitsAvail = pPlayer:GetNumAvailableTradeUnits(DomainTypes.DOMAIN_SEA);
	if (iNumSeaTradeUnitsAvail > 0) then
		local iTradeUnitType = pPlayer:GetTradeUnitType(DomainTypes.DOMAIN_SEA);
		local strUnusedTradeUnitWarning = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_INTERNATIONAL_TRADE_ROUTES_TT_UNASSIGNED", iNumLandTradeUnitsAvail, GameInfo.Units[iTradeUnitType].Description);	
		strTT = strTT .. strUnusedTradeUnitWarning;
	end
	
	if (strTT ~= "") then
		strTT = strTT .. "[NEWLINE]";
	end
	
	local iUsedTradeRoutes = pPlayer:GetNumInternationalTradeRoutesUsed();
	local iAvailableTradeRoutes = pPlayer:GetNumInternationalTradeRoutesAvailable();
	
	local strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_INTERNATIONAL_TRADE_ROUTES_TT", iUsedTradeRoutes, iAvailableTradeRoutes);
	strTT = strTT .. strText;
	
	local strYourTradeRoutes = pPlayer:GetTradeYourRoutesTTString();
	if (strYourTradeRoutes ~= "") then
		strTT = strTT .. "[NEWLINE][NEWLINE]"
		strTT = strTT .. Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_ITR_ESTABLISHED_BY_PLAYER_TT");
		strTT = strTT .. "[NEWLINE]";
		strTT = strTT .. strYourTradeRoutes;
	end

	local strToYouTradeRoutes = pPlayer:GetTradeToYouRoutesTTString();
	if (strToYouTradeRoutes ~= "") then
		strTT = strTT .. "[NEWLINE][NEWLINE]"
		strTT = strTT .. Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_ITR_ESTABLISHED_BY_OTHER_TT");
		strTT = strTT .. "[NEWLINE]";
		strTT = strTT .. strToYouTradeRoutes;
	end
	
	--print(strText);
	if(strText ~= "") then
		tipControlTable.TopPanelMouseover:SetHide(false);
		tipControlTable.TooltipLabel:SetText( strTT );
	else
		tipControlTable.TopPanelMouseover:SetHide(true);
	end
    
    -- Autosize tooltip
    tipControlTable.TopPanelMouseover:DoAutoSize();
end

-------------------------------------------------
-- On Top Panel mouseover exited
-------------------------------------------------
--function HelpClose()
	---- Hide the help text box
	--Controls.HelpTextBox:SetHide( true );
--end


-- Register Events
Events.SerialEventGameDataDirty.Add(OnTopPanelDirty);
Events.SerialEventTurnTimerDirty.Add(OnTopPanelDirty);
Events.SerialEventCityInfoDirty.Add(OnTopPanelDirty);

-- Update data at initialization
UpdateData();
DoInitTooltips();
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()

Events.OpenInfoCorner(nil)
if ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner") then
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner"):SetHide(true)
end