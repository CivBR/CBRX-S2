-------------------------------------------------
-- Natural Wonder Popup
-------------------------------------------------
include( "IconSupport" );

local m_PopupInfo = nil;

-------------------------------------------------
-------------------------------------------------
function ShowCyclePowerPowerPopup( playerID, cyclePowerID, isInit, isAnarchy, isTopPanel )
	playerID = playerID or Game.GetActivePlayer()
	local player = Players[playerID]
	local playerCiv = GameInfo.Civilizations[player:GetCivilizationType()]
	IconHookup(playerCiv.PortraitIndex, 64, playerCiv.IconAtlas, Controls.CivIcon)
	
	local thisPower = GameInfo.JFD_CyclePowers[cyclePowerID]
	if (not isTopPanel) then
		Events.AudioPlay2DSound(thisPower.CyclePowerAudio);	
	end

    if( thisPower.Description ~= nil ) then
    	Controls.Title:SetText( Locale.ToUpper( thisPower.Description ) );
    	Controls.Title:SetHide( false );
    else
    	Controls.Title:SetHide( true );
    	Controls.LowerTitle:SetHide( true );
	end
    if( thisPower.Quote ~= nil ) then
        Controls.Quote:SetText( Locale.ConvertTextKey( thisPower.Quote ) );
    	Controls.Quote:SetHide( false );
    else
    	Controls.Quote:SetHide( true );
    end

	-- Game Info
	local strGameInfo = Locale.ConvertTextKey("TXT_KEY_JFD_CYCLE_OF_POWER_SUMMARY", thisPower.Description, thisPower.Strategy)
	--if thisPower.IsTheocracy then
	--	strGameInfo = Locale.ConvertTextKey("TXT_KEY_JFD_CYCLE_OF_POWER_SUMMARY_THEOCRACY", thisPower.Description, thisPower.Strategy)
	if isAnarchy then
		strGameInfo = Locale.ConvertTextKey("TXT_KEY_JFD_CYCLE_OF_POWER_SUMMARY_ANARCHY", thisPower.Description, thisPower.Strategy)
	elseif isInit then
		strGameInfo = Locale.ConvertTextKey("TXT_KEY_JFD_CYCLE_OF_POWER_SUMMARY_INITIAL", thisPower.Description, thisPower.Strategy)
	end

    if( strGameInfo ~= nil ) then
        Controls.Stats:SetText( strGameInfo );
    	Controls.Stats:SetHide( false );
    else
    	Controls.Stats:SetHide( true );
    end

	UIManager:QueuePopup( ContextPtr, PopupPriority.WonderPopup );
	
end
LuaEvents.UI_ShowCyclePowerPopup.Add(ShowCyclePowerPowerPopup)

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------        
-- Input processing
----------------------------------------------------------------        

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnCloseButtonClicked ()
    UIManager:DequeuePopup( ContextPtr );
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnCloseButtonClicked );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function InputHandler( uiMsg, wParam, lParam )
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
            OnCloseButtonClicked();
            return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );

--------------------------------------------------------------------
function ShowHideHandler(bIsHide, bInitState)
	if (not bInitState and not bIsHide) then
		--ShowCyclePowerPowerPopup()
	end
end
ContextPtr:SetShowHideHandler(ShowHideHandler)
ContextPtr:SetHide(true)

----------------------------------------------------------------


UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
UIManager:DequeuePopup(ContextPtr)

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
Events.GameplaySetActivePlayer.Add(OnClose);
