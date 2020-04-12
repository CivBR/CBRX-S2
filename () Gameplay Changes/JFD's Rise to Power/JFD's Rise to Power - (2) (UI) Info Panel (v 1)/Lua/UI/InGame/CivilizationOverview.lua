-------------------------------------------------
-- TECH PANEL
-------------------------------------------------
include( "InstanceManager" );
include( "IconSupport" );
include( "JFD_RTP_Utils.lua" );

function OnCivButtonClicked()
	 LuaEvents.UI_UpdateCivilizationOverview()
end
Controls.CivButton:RegisterCallback( Mouse.eLClick, OnCivButtonClicked );

g_CyclePower_ToolTip_TipControls = {}
TTManager:GetTypeControlTable("CyclePower_ToolTip", g_CyclePower_ToolTip_TipControls)

local gridX = 470
local gridY = 45
function OnCivPanelUpdated()
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	local civilization = GameInfo.Civilizations[activePlayer:GetCivilizationType()]
	if civilization then
		--Update civ and leader icon
		local civilization = GameInfo.Civilizations[activePlayer:GetCivilizationType()]
		local leader = GameInfo.Leaders[activePlayer:GetLeaderType()]
		IconHookup( civilization.PortraitIndex, 45, civilization.IconAtlas, Controls.CivIcon )
		IconHookup( leader.PortraitIndex, 128, leader.IconAtlas, Controls.LeaderIcon )
		
		--Update civ description
		local civDesc = activePlayer:GetCivilizationDescription()
		local leaderDesc = activePlayer:GetName()
		Controls.CivText:SetText(civDesc);
		Controls.CivText:LocalizeAndSetToolTip(civDesc);
		Controls.CivText:SetHide(false);
		Controls.LeaderText:SetText(leaderDesc);
		Controls.LeaderText:LocalizeAndSetToolTip(leaderDesc);
		Controls.LeaderText:SetHide(false);
		
		if JFD_RTP then
			--CYCLES OF POWER
			if Player.GetCyclePower then
				local cyclePowerID = activePlayer:GetCyclePower() or -1
				if cyclePowerID ~= -1 then
					local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
					if activePlayer:IsAnarchy() then
						local strCyclePowerTT = activePlayer:GetCyclePowerToolTip(cyclePowerID)
						Controls.Virtue:SetHide(false)
						Controls.CyclePower:SetHide(false)
						Controls.CyclePower:LocalizeAndSetText("[ICON_RESISTANCE][COLOR_NEGATIVE_TEXT] " .. Locale.ToUpper("TXT_KEY_CYCLE_POWER_JFD_ANARCHY_DESC") .. "[ENDCOLOR]")
						-- Controls.CyclePower:LocalizeAndSetToolTip(strCyclePowerTT)
						local tipControls = g_CyclePower_ToolTip_TipControls
						tipControls.CyclePowerInfo:LocalizeAndSetText(strCyclePowerTT)
						tipControls.CyclePowerInfo:SetWrapWidth(400)
						tipControls.Box:DoAutoSize()
						Controls.Virtue:SetHide(true)
					else
						local cyclePowerID = activePlayer:GetCyclePower() or -1
						if cyclePowerID ~= -1 then
							local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
							local strCyclePowerTT = activePlayer:GetCyclePowerToolTip(cyclePowerID)
							local numVirtueMax = activePlayer:GetMaxVirtue()
							local numVirtue = activePlayer:GetVirtue()
							local numVirtueRate = activePlayer:GetVirtueRate(cyclePowerID)
							local strVirtueTT = activePlayer:GetVirtueToolTip(cyclePowerID)
							Controls.CyclePower:SetHide(false)
							Controls.CyclePower:LocalizeAndSetText("[ICON_JFD_CYCLE_POWER] " .. Locale.ConvertTextKey(cyclePower.Description))
							-- Controls.CyclePower:LocalizeAndSetToolTip(strCyclePowerTT)
							local tipControls = g_CyclePower_ToolTip_TipControls
							tipControls.CyclePowerInfo:LocalizeAndSetText(strCyclePowerTT)
							tipControls.CyclePowerInfo:SetWrapWidth(1000)
							tipControls.Box:DoAutoSize()

							if (numVirtue*numVirtueMax/100) <= 10 then
								Controls.Virtue:LocalizeAndSetText("TXT_KEY_INFO_PANEL_JFD_VIRTUE", "[COLOR_NEGATIVE_TEXT]", numVirtue, numVirtueRate)
							else
								Controls.Virtue:LocalizeAndSetText("TXT_KEY_INFO_PANEL_JFD_VIRTUE", "[COLOR_JFD_VIRTUE]", numVirtue, numVirtueRate)
							end
							Controls.Virtue:SetHide(false)
							if strVirtueTT then
								Controls.Virtue:LocalizeAndSetToolTip(strVirtueTT)
							end
						else
							Controls.CyclePower:SetHide(true)
							Controls.Virtue:SetHide(true)
						end
					end
				else
					Controls.CyclePower:SetHide(true)
					Controls.Virtue:SetHide(true)
				end
			else
				Controls.CyclePower:SetHide(true)
				Controls.Virtue:SetHide(true)
			end
			
			--GOVERNMENT
			if Player.IsHasGovernment then
				local currentGovernmentID = activePlayer:GetCurrentGovernment()
				local strGovernment = Locale.ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_INFO_GOVERNMENT", "None")
				local strSovereignty = Locale.ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_INFO_SOVEREIGNTY", "0")
				if currentGovernmentID > -1 then
					local government = GameInfo.JFD_Governments[currentGovernmentID]
					strGovernment = Locale.ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_INFO_GOVERNMENT", government.Description)
					strSovereignty = Locale.ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_INFO_SOVEREIGNTY", activePlayer:GetCurrentSovereignty())
					Controls.Sovereignty:SetHide(true)
				else
					Controls.Sovereignty:SetHide(false)
				end
				Controls.Government:SetText(strGovernment)
				Controls.Government:SetToolTipString(strGovernment)
				Controls.Sovereignty:SetText(strSovereignty)
				Controls.Sovereignty:SetToolTipString(strSovereignty)
				
				Controls.Government:SetHide(false)
			else
				Controls.Government:SetHide(true)
				Controls.Sovereignty:SetHide(true)
			end
			
			--LAST POLICY/REFORM
			if Player.GetLastReformPassed then
				local strLastReform = Locale.ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_INFO_LAST_REFORM", activePlayer:GetLastReformPassed())
				Controls.LastReform:SetText(strLastReform)
				Controls.LastReform:SetToolTipString(strLastReform)
				Controls.LastReform:SetHide(false)
				
				local strLastPolicy = Locale.ConvertTextKey("TXT_KEY_JFD_CIVILIZATION_INFO_LAST_POLICY", activePlayer:GetLastPolicyAdopted())
				Controls.LastPolicy:SetText(strLastPolicy)
				Controls.LastPolicy:SetToolTipString(strLastPolicy)
				Controls.LastPolicy:SetHide(false)
			else
				Controls.LastReform:SetHide(true)
				Controls.LastPolicy:SetHide(true)
			end
		end
	end
		
	Controls.RightInfoStack:ReprocessAnchoring()
	Controls.LeftInfoStack:ReprocessAnchoring()
end
Events.SerialEventGameDataDirty.Add(OnCivPanelUpdated);
LuaEvents.UI_UpdateCivilizationOverview.Add(OnCivPanelUpdated);
-------------------------------------------------
-------------------------------------------------
local g_PlayerListInstanceManager = InstanceManager:new( "PlayerEntryInstance", "PlayerEntryBox", Controls.PlayerListStack );
function OnWorldCivsListUpdated()
	Controls.WorldCivsList:SetHide(false)
	
	g_PlayerListInstanceManager:ResetInstances();
	
	for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		
		-- Player has to be alive to be in the list
		local pPlayer = Players[iPlayerLoop];
		if (pPlayer:IsAlive()) then
			local iTeam = pPlayer:GetTeam();
			local pTeam = Teams[iTeam];
		
			local civDesc = pPlayer:GetCivilizationShortDescription()
			local leaderDesc = pPlayer:GetName()
			if Player.GetLeaderTitle then
				_, leaderDesc = pPlayer:GetLeaderTitle(nil, true, true)
			end
			
			local controlTable = g_PlayerListInstanceManager:GetInstance();
		
			-- Use the Civilization_Leaders table to cross reference from this civ to the Leaders table
			local leader = GameInfo.Leaders[pPlayer:GetLeaderType()];
			local leaderDescription = leader.Description;
				
			local strName
			
			local cyclePowerID = -1
			--CYCLES OF POWER
			if Player.GetCyclePower then
				cyclePowerID = pPlayer:GetCyclePower() or -1
			end
									
			-- Active player
			if (pPlayer:GetID() == Game.GetActivePlayer()) then
				strName = civDesc .. " (" .. Locale.ConvertTextKey( "TXT_KEY_POP_VOTE_RESULTS_YOU" ) .. ")"
				strLeaderName = leaderDesc
				CivIconHookup( iPlayerLoop, 32, controlTable.Icon, controlTable.CivIconBG, controlTable.CivIconShadow, false, true);  
				IconHookup( leader.PortraitIndex, 64, leader.IconAtlas, controlTable.Portrait );
				
				if cyclePowerID ~= -1 then
					local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
					controlTable.CyclePower:SetHide(false)
					controlTable.CyclePower:LocalizeAndSetText(Locale.ToUpper(cyclePower.Description) .. " [ICON_JFD_CYCLE_POWER]")
				else
					controlTable.CyclePower:SetHide(true)
				end
				
			-- Haven't yet met this player
			elseif (not pTeam:IsHasMet(Game.GetActiveTeam())) then
				strName = Locale.ConvertTextKey( "TXT_KEY_POP_VOTE_RESULTS_UNMET_PLAYER" );
				strLeaderName = Locale.ConvertTextKey( "TXT_KEY_POP_VOTE_RESULTS_UNMET_PLAYER" );
				CivIconHookup( -1, 32, controlTable.Icon, controlTable.CivIconBG, controlTable.CivIconShadow, false, true);
				IconHookup( 22, 64, "LEADER_ATLAS", controlTable.Portrait );
				
				controlTable.CyclePower:SetHide(true)
			-- Met players
			else
				strName = civDesc
				strLeaderName = leaderDesc
				CivIconHookup( iPlayerLoop, 32, controlTable.Icon, controlTable.CivIconBG, controlTable.CivIconShadow, false, true);  
				IconHookup( leader.PortraitIndex, 64, leader.IconAtlas, controlTable.Portrait );
				
				if cyclePowerID ~= -1 then
					local cyclePower = GameInfo.JFD_CyclePowers[cyclePowerID]
					controlTable.CyclePower:SetHide(false)
					controlTable.CyclePower:LocalizeAndSetText(Locale.ToUpper(cyclePower.Description) .. " [ICON_JFD_GOVERNMENT_POWER]")
				else
					controlTable.CyclePower:SetHide(true)
				end
			end    
			
			controlTable.PlayerNameText:SetText(strName);
			controlTable.PlayerLeaderNameText:SetText(strLeaderName);
		end
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


-------------------------------------------------
-------------------------------------------------
function OnOpenInfoCorner( iInfoType )
    -- show if it's our id and we're not already visible
    if( iInfoType == InfoCornerID.Civilization ) then
        ContextPtr:SetHide( false );
    else
        ContextPtr:SetHide( true );
    end
end
Events.OpenInfoCorner.Add( OnOpenInfoCorner );

-------------------------------------------------
-------------------------------------------------
function OnChangeEvent()
	if( ContextPtr:IsHidden() == false ) then
		OnCivPanelUpdated();
	end
end
Events.SerialEventGameDataDirty.Add( OnChangeEvent );
Events.SerialEventCityInfoDirty.Add( OnChangeEvent );
Events.GameplaySetActivePlayer.Add( OnChangeEvent );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnPopup( popupInfo )	
    if( (popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH or popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSE_TECH_TO_STEAL) and
        ContextPtr:IsHidden() == true ) then
        Events.OpenInfoCorner( InfoCornerID.Civilization );
    end
end
--Events.SerialEventGameMessagePopup.Add( OnPopup );

----------------------------------------------------------------
----------------------------------------------------------------
--function UpdatePlayerData()
--	local playerID = Game.GetActivePlayer();	
--	local player = Players[playerID];
--	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type;
--	GatherInfoAboutUniqueStuff( civType );
--end

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnCivPanelActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	-- UpdatePlayerData();    
	OnCivPanelUpdated();
end
Events.GameplaySetActivePlayer.Add(OnCivPanelActivePlayerChanged);

-- UpdatePlayerData();    
OnCivPanelUpdated();
