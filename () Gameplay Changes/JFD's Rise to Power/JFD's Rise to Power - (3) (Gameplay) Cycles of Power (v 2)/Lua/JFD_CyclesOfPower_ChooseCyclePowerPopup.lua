--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
include("JFD_CyclesOfPower_Utils.lua")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
-- Pedia Callback: Adapted from EUI
-------------------------------------------------

CivilopediaControl = "/FrontEnd/MainMenu/Other/Civilopedia"

local getPedia

local function getPediaB(...)
	Events.SearchForPediaEntry(...)
end

local function getPediaA(...)
	UIManager:QueuePopup(LookUpControl(CivilopediaControl), PopupPriority.eUtmost)
	getPedia = getPediaB
	getPedia(...)
end

getPedia = CivilopediaControl and getPediaA
-------------------------------------------------
-- Choose Power Popup
-------------------------------------------------

include( "IconSupport" );
include( "InstanceManager" );
include( "CommonBehaviors" );

-- Used for Piano Keys
local ltBlue = {19/255,32/255,46/255,120/255};
local dkBlue = {12/255,22/255,30/255,120/255};

local g_ItemManager = InstanceManager:new( "ItemInstance", "Button", Controls.ItemStack );

local bHidden = true;

local screenSizeX, screenSizeY = UIManager:GetScreenSizeVal()
local spWidth, spHeight = Controls.ItemScrollPanel:GetSizeVal();

-- Original UI designed at 1050px 
local heightOffset = screenSizeY - 1020;

spHeight = spHeight + heightOffset;
Controls.ItemScrollPanel:SetSizeVal(spWidth, spHeight); 
Controls.ItemScrollPanel:CalculateInternalSize();
Controls.ItemScrollPanel:ReprocessAnchoring();

local bpWidth, bpHeight = Controls.BottomPanel:GetSizeVal();
--bpHeight = bpHeight * heightRatio;
bpHeight = bpHeight + heightOffset 

Controls.BottomPanel:SetSizeVal(bpWidth, bpHeight);
Controls.BottomPanel:ReprocessAnchoring();

local g_PopupInfo = nil;

ButtonPopupTypes.BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT_POWER = "BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT_POWER"
g_PopupInfo = {["Type"] = ButtonPopupTypes.BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT_POWER}

g_IsChangingGovtPower = false
-------------------------------------------------
-------------------------------------------------
function OnPopupMessage(popupInfo)
	  
	local popupType = popupInfo.Type;
	
	g_iUnitIndex = popupInfo.Data2;
	
	if popupType ~= ButtonPopupTypes.BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT_POWER then
		return;
	end	
	
	g_PopupInfo = popupInfo;
	
   	UIManager:QueuePopup( ContextPtr, PopupPriority.SocialPolicy );
end
Events.SerialEventGameMessagePopup.Add( OnPopupMessage );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    ----------------------------------------------------------------        
    -- Key Down Processing
    ----------------------------------------------------------------        
    if uiMsg == KeyEvents.KeyDown then
        if (wParam == Keys.VK_ESCAPE) then
			-- if(not Controls.ViewTenetsPopup:IsHidden()) then
				-- Controls.ViewTenetsPopup:SetHide(true);
			-- elseif(not Controls.ChooseConfirm:IsHidden()) then
				-- Controls.ChooseConfirm:SetHide(true);
			-- else
				OnClose();
			-- end
        	return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--ShowChooseCycleOfPowerPopup
function ShowChooseCycleOfPowerPopup(isChanging)
	g_IsChangingGovtPower = isChanging
	UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
end 
LuaEvents.UI_ShowChooseCycleOfPowerPopup.Add(ShowChooseCycleOfPowerPopup)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnClose()
    UIManager:DequeuePopup(ContextPtr);
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function RefreshList()
	g_ItemManager:ResetInstances();
		
	local pPlayer = Players[Game.GetActivePlayer()];
	CivIconHookup( pPlayer:GetID(), 64, Controls.CivIcon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
	   
	local activePlayerTeam = Teams[pPlayer:GetTeam()];
			
	local tick = true;
	for cyclePower in GameInfo.JFD_CyclePowers("ShowInCyclePowerChoice = 1") do
		local cyclePowerType = cyclePower.Type;
		local cyclePowerID = cyclePower.ID;
		local cyclePowerStrat = cyclePower.Strategy
		local itemInstance = g_ItemManager:GetInstance();
		itemInstance.Name:LocalizeAndSetText(cyclePower.Description);
		itemInstance.Help:LocalizeAndSetText(cyclePowerStrat);
		
		if cyclePower.IsTheocracy then
			itemInstance.Name:SetAlpha(0.5)
			itemInstance.Help:SetAlpha(0.5)
		end
		
		itemInstance.Button:RegisterCallback(Mouse.eLClick, function() SelectGovtPowerChoice(cyclePowerID); end);
		local pediaEntry = CivilopediaControl and (cyclePower.Civilopedia)
		if (pediaEntry and (not setDisabled)) then
			itemInstance.Button:RegisterCallback(Mouse.eRClick, function() getPedia(pediaEntry) end)
		end
		
		local color = tick and ltBlue or dkBlue;
		tick = not tick;
		
		itemInstance.Box:SetColorVal(unpack(color));
		
		itemInstance.Button:SetAlpha(1)
		if cyclePower.IsTheocracy then
			itemInstance.Button:SetDisabled(true)
		else
			itemInstance.Button:SetDisabled(false)
		end
		local buttonWidth, buttonHeight = itemInstance.GovtPowerStack:GetSizeVal();
		local newHeight = buttonHeight;	
		
		itemInstance.Button:SetSizeVal(buttonWidth, newHeight);
		itemInstance.BounceAnim:SetSizeVal(buttonWidth, newHeight);
		itemInstance.Box:SetSizeVal(buttonWidth, newHeight);
		
		itemInstance.BounceAnim:SetSizeVal(buttonWidth, newHeight + 5);
		itemInstance.BounceGrid:SetSizeVal(buttonWidth, newHeight + 5);
	end

	Controls.ChooseCyclesOptions:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_CYCLE_OF_POWER_SUMMARY", GameDefines["JFD_CYCLES_OF_POWER_ANARCHY_TURNS"])
	
	Controls.ItemStack:CalculateSize();
	Controls.ItemStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
end
-------------------------------------------------------------------------------
function SelectGovtPowerChoice(iChoice) 
	g_iChoice = iChoice;
	
	local cyclePower = GameInfo.JFD_CyclePowers[iChoice];
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_CYCLE_OF_POWER_CONFIRM", cyclePower.Description); 
	Controls.ChooseConfirm:SetHide(false);
end
-------------------------------------------------------------------------------
function OnConfirmYes( )
	Controls.ChooseConfirm:SetHide(true);
	local player = Players[Game.GetActivePlayer()]
	player:BeginCycleOfPower(g_iChoice)
	Events.AudioPlay2DSound("AS2D_SOUND_JFD_GENERIC_CHOICE");	
	OnClose();
	Events.SerialEventEndTurnDirty()
end
Controls.ConfirmYes:RegisterCallback( Mouse.eLClick, OnConfirmYes );
-------------------------------------------------------------------------------
function OnConfirmNo( )
	Controls.ChooseConfirm:SetHide(true);
end
Controls.ConfirmNo:RegisterCallback( Mouse.eLClick, OnConfirmNo );


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

	bHidden = bIsHide;
    if( not bInitState ) then
        if( not bIsHide ) then
        	UI.incTurnTimerSemaphore();
        	Events.SerialEventGameMessagePopupShown(g_PopupInfo);
        	
        	RefreshList();
        
			local unitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/UnitPanel/Base" );
			if( unitPanel ~= nil ) then
				unitPanel:SetHide( true );
			end
			
			local infoCorner = ContextPtr:LookUpControl( "/InGame/WorldView/InfoCorner" );
			if( infoCorner ~= nil ) then
				infoCorner:SetHide( true );
			end
               	
        else
      
			local unitPanel = ContextPtr:LookUpControl( "/InGame/WorldView/UnitPanel/Base" );
			if( unitPanel ~= nil ) then
				unitPanel:SetHide(false);
			end
			
			local infoCorner = ContextPtr:LookUpControl( "/InGame/WorldView/InfoCorner" );
			if( infoCorner ~= nil ) then
				infoCorner:SetHide(false);
			end
			
			if(g_PopupInfo ~= nil) then
				Events.SerialEventGameMessagePopupProcessed.CallImmediate(g_PopupInfo.Type, 0);
			end
            UI.decTurnTimerSemaphore();
        end
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );
-------------------------------------------------------------------------------
function OnDirty()
	-- If the user performed any action that changes selection states, just close this UI.
	if not bHidden then
		OnClose();
	end
end
Events.UnitSelectionChanged.Add( OnDirty );

UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
UIManager:DequeuePopup(ContextPtr)