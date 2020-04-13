-------------------------------------------------
-- TECH PANEL
-------------------------------------------------
include( "InstanceManager" );
include( "TechButtonInclude" );
include( "TechHelpInclude" );

local maxSmallButtons = 5;

local eRecentTech = -1;
local eCurrentTech= -1;

local techPortraitSize = Controls.TechIcon:GetSize().x;

local helpTT = Locale.ConvertTextKey( "TXT_KEY_NOTIFICATION_SUMMARY_NEW_RESEARCH" );

function OnTechnologyButtonClicked()
    if( Controls.TechPopup:IsHidden() == true ) then
    	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH,
                                              Data1 = Game.GetActivePlayer(),
                                              Data3 = -1 -- this is to tell it that a tech was not just finished
                                            } );
    else
        Controls.TechPopup:SetHide( true );
    end
end
Controls.TechButton:RegisterCallback( Mouse.eLClick, OnTechnologyButtonClicked );
Controls.BigTechButton:RegisterCallback( Mouse.eLClick, OnTechnologyButtonClicked );

function OnTechnologyButtonRClicked()

	local tech = eCurrentTech;
	if tech == -1 then
		tech = eRecentTech;
	end
	
	if tech ~= -1 then
		local pTechInfo = GameInfo.Technologies[tech];
		if pTechInfo then
		
			-- search by name
			local searchString = Locale.ConvertTextKey( pTechInfo.Description );
			Events.SearchForPediaEntry( searchString );			
		end
	end
	
end
Controls.BigTechButton:RegisterCallback( Mouse.eRClick, OnTechnologyButtonRClicked );


function OnTechPanelUpdated()
	
	local pPlayer = Players[Game.GetActivePlayer()];
	local pTeam = Teams[pPlayer:GetTeam()];
	local pTeamTechs = pTeam:GetTeamTechs();
	
	eCurrentTech = pPlayer:GetCurrentResearch();
	eRecentTech = pTeamTechs:GetLastTechAcquired();
	local iButtonAlpha = 0.2
	
	local fResearchProgressPercent = 0;
	local fResearchProgressPlusThisTurnPercent = 0;
	
	local researchStatus = "";
	local szText = "";
	
	techPediaSearchStrings = {};
	
	-- Are we researching something right now?
	local customHelpString = GetHelpTextForTech(eRecentTech);
	if (eCurrentTech ~= -1) then
		customHelpString = GetHelpTextForTech(eCurrentTech);	
		local iResearchTurnsLeft = pPlayer:GetResearchTurnsLeft(eCurrentTech, true);
		local iCurrentResearchProgress = pPlayer:GetResearchProgress(eCurrentTech);
		local iResearchNeeded = pPlayer:GetResearchCost(eCurrentTech);
		local iResearchPerTurn = pPlayer:GetScience();
		local iCurrentResearchPlusThisTurn = iCurrentResearchProgress + iResearchPerTurn;
		
		fResearchProgressPercent = iCurrentResearchProgress / iResearchNeeded;
		fResearchProgressPlusThisTurnPercent = iCurrentResearchPlusThisTurn / iResearchNeeded;
		
		if (fResearchProgressPlusThisTurnPercent > 1) then fResearchProgressPlusThisTurnPercent = 1 end
		if fResearchProgressPercent > 0 then iButtonAlpha = fResearchProgressPercent end	
		local pTechInfo = GameInfo.Technologies[eCurrentTech];
		if pTechInfo then
			szText = Locale.ConvertTextKey( pTechInfo.Description );
			if iResearchPerTurn > 0 then
				szText = szText .. " (" .. tostring(iResearchTurnsLeft) .. ")";
			end		
			local customHelpString = GetHelpTextForTech(eCurrentTech);
			Controls.ActiveStyle:SetToolTipString( customHelpString );
			Controls.TechButton:SetToolTipString( customHelpString );
			Controls.BigTechButton:SetToolTipString( customHelpString );
			-- if we have one, update the tech picture
			if IconHookup( pTechInfo.PortraitIndex, techPortraitSize, pTechInfo.IconAtlas, Controls.TechIcon ) then
				Controls.TechIcon:SetHide( false );
			else
				Controls.TechIcon:SetHide( true );
			end

			-- Update the little icons
			local numButtonsAdded = AddSmallButtonsToTechButton( Controls, pTechInfo, maxSmallButtons, 64, 1);
			numButtonsAdded = math.max( 0, numButtonsAdded );
	
			AddCallbackToSmallButtons( Controls, maxSmallButtons, -1, -1, Mouse.eLClick, OnTechnologyButtonClicked );
			
			if numButtonsAdded > 0 then
				if OptionsManager.GetSmallUIAssets() then		
					Controls.ActiveStyle:SetSizeVal( numButtonsAdded*56 + 76, 126 );
				else
					Controls.ActiveStyle:SetSizeVal( numButtonsAdded*56 + 130, 126 );
				end
				Controls.ActiveStyle:SetHide( false );
			else
				Controls.ActiveStyle:SetHide( true );
			end
			
		end
		--Controls.ResearchLabel:SetText( "" );-- Locale.ConvertTextKey( "TXT_KEY_RESEARCH_ONGOING" ));
		--Controls.TechText:SetHide( false );
		--Controls.FinishedTechText:SetHide( true );
	elseif (eRecentTech ~= -1) then -- maybe we just finished something
				
		local pTechInfo = GameInfo.Technologies[eRecentTech];
		if pTechInfo then
			szText = Locale.ConvertTextKey( pTechInfo.Description );
			-- if we have one, update the tech picture
			if IconHookup( pTechInfo.PortraitIndex, techPortraitSize, pTechInfo.IconAtlas, Controls.TechIcon ) then
				Controls.TechIcon:SetHide( false );
			else
				Controls.TechIcon:SetHide( true );
			end

			-- Update the little icons
			local numButtonsAdded = AddSmallButtonsToTechButton( Controls, pTechInfo, maxSmallButtons, 64, 1 );
			numButtonsAdded = math.max( 0, numButtonsAdded );
			
			AddCallbackToSmallButtons( Controls, maxSmallButtons, -1, -1, Mouse.eLClick, OnTechnologyButtonClicked );
			
			if numButtonsAdded > 0 then
				Controls.ActiveStyle:SetSizeVal( numButtonsAdded*56 + 130, 126 );
				Controls.ActiveStyle:SetHide( false );
			else
				Controls.ActiveStyle:SetHide( true );
			end
			
		end
		researchStatus = Locale.ConvertTextKey("TXT_KEY_RESEARCH_FINISHED");
		--Controls.ResearchLabel:SetText( Locale.ConvertTextKey( "TXT_KEY_RESEARCH_FINISHED" ) );
		Controls.ActiveStyle:SetToolTipString( helpTT );
		Controls.TechButton:SetToolTipString( helpTT );
		Controls.BigTechButton:SetToolTipString( helpTT );
		--Controls.TechText:SetHide( true );
		--Controls.FinishedTechText:SetHide( false );
	else
		researchStatus = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_SUMMARY_NEW_RESEARCH");
		
		Controls.ActiveStyle:SetHide( true );
		--Controls.ResearchLabel:SetText( Locale.ConvertTextKey( "TXT_KEY_NOTIFICATION_SUMMARY_NEW_RESEARCH" )  );
		Controls.ActiveStyle:SetToolTipString( helpTT );
		Controls.TechButton:SetToolTipString( helpTT );
		Controls.BigTechButton:SetToolTipString( helpTT );
		--Controls.TechText:SetHide( false );
		--Controls.FinishedTechText:SetHide( true );
	end
	
	-- Research Meter
	local research = pPlayer:GetCurrentResearch();
  	if( research ~= -1 ) then
		iButtonAlpha = 1
		Controls.TechIcon:SetAlpha( iButtonAlpha );
		Controls.ResearchMeter:SetPercents( fResearchProgressPercent, fResearchProgressPlusThisTurnPercent );
	else
    	Controls.TechIcon:SetAlpha( 1 );
    	Controls.ResearchMeter:SetPercents( 1, 0 );
	end
	
	--if userSettingCIDInnovationsCore then
	--	local pTechInfo = nil
	--	if eRecentTech ~= -1 then
	--		pTechInfo = GameInfo.Technologies[eRecentTech];
	--	elseif eCurrentTech ~= -1 then
	--		pTechInfo = GameInfo.Technologies[eCurrentTech];
	--	end
	--	--if pTechInfo then
	--	--	local numInnovations, maxInnovations = pPlayer:GetNumInnovations(pTeamTechs, pTechInfo.ID)
	--	--	if pTechInfo.Innovations > 0 then
	--	--		Controls.InnovationMeter:SetPercent( numInnovations/maxInnovations );
	--	--		Controls.InnovationMeter:SetHide( false );
	--	--		Controls.ResearchMeter:SetHide(true)
	--	--	else
	--	--		Controls.InnovationMeter:SetHide( true );
	--	--		Controls.ResearchMeter:SetHide( false );
	--	--	end
	--	--end
	--end
	
	-- Tech Text
	Controls.TechText:SetText(researchStatus .. " " .. szText);
	Controls.FinishedTechText:SetText(researchStatus .. " " .. szText);
	
end
Events.SerialEventGameDataDirty.Add(OnTechPanelUpdated);
	
	
-------------------------------------------------
-------------------------------------------------
function OnOpenInfoCorner( iInfoType )
    -- show if it's our id and we're not already visible
    if( iInfoType == InfoCornerID.Tech ) then
        ContextPtr:SetHide( false );
    else
        ContextPtr:SetHide( true );
    end
end
Events.OpenInfoCorner.Add( OnOpenInfoCorner );


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnPopup( popupInfo )	
    if( (popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH or popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSE_TECH_TO_STEAL) and
        ContextPtr:IsHidden() == true ) then
        Events.OpenInfoCorner( InfoCornerID.Tech );
    end
end
Events.SerialEventGameMessagePopup.Add( OnPopup );

----------------------------------------------------------------
----------------------------------------------------------------
function UpdatePlayerData()
	local playerID = Game.GetActivePlayer();	
	local player = Players[playerID];
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type;
	GatherInfoAboutUniqueStuff( civType );
end

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnTechPanelActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	UpdatePlayerData();    
	OnTechPanelUpdated();
end
Events.GameplaySetActivePlayer.Add(OnTechPanelActivePlayerChanged);

UpdatePlayerData();    
OnTechPanelUpdated();
