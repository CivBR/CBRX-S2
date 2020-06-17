--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("JFD_Sovereignty_Utils.lua")
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

local g_CurrentManager = InstanceManager:new( "ItemInstance", "Button", Controls.CurrentStack );
local g_ChooseableManager = InstanceManager:new( "ItemInstance", "Button", Controls.ChooseableStack );
local g_LockedManager = InstanceManager:new( "ItemInstance", "Button", Controls.LockedStack );

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

ButtonPopupTypes.BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT = "BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT"
g_PopupInfo = {["Type"] = ButtonPopupTypes.BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT}

local g_IsChangingGovt = false
local g_IsChangingGovtAnarchyFree = false
local g_IsRestrictedGovernment = false
local g_IsChangingGovtFree = false
local g_IsViewingGovt = false
-------------------------------------------------
-------------------------------------------------
function OnPopupMessage(popupInfo)
	  
	local popupType = popupInfo.Type;
	
	g_iUnitIndex = popupInfo.Data2;
	
	if popupType ~= ButtonPopupTypes.BUTTONPOPUP_CHOOSE_JFD_GOVERNMENT then
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
--UI_ShowChooseGovernmentPopup
function UI_ShowChooseGovernmentPopup(isLooking)
	local activePlayerID = Game.GetActivePlayer()
	local activePlayer = Players[activePlayerID]
	local isChanging = activePlayer:IsHasGovernment()
	g_IsChangingGovt = isChanging
	_, g_IsRestrictedGovernment, g_IsChangingGovtFree = activePlayer:IsCanChangeGovernment()
	g_IsViewingGovt = isLooking
	RefreshList()
	UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
end 
LuaEvents.UI_ShowChooseGovernmentPopup.Add(UI_ShowChooseGovernmentPopup)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnClose()
    UIManager:DequeuePopup(ContextPtr);
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function RefreshList()
	g_CurrentManager:ResetInstances();
	g_ChooseableManager:ResetInstances();
	g_LockedManager:ResetInstances();
		
	local pPlayer = Players[Game.GetActivePlayer()];

	CivIconHookup( pPlayer:GetID(), 64, Controls.CivIcon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
	   
	local activePlayerTeam = Teams[pPlayer:GetTeam()];
	local currentGovernmentID = pPlayer:GetCurrentGovernment()
	local currentGovernment = GameInfo.JFD_Governments[currentGovernmentID]
	local isAllowsGovtChangeNoAnarchy = currentGovernment.IsAllowsChangeGovernmentNoAnarchy
		
	Controls.ChooseGovtOptionsChoose:SetHide(false)
	Controls.ChooseGovtOptionsChoose:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_GOVERNMENT_OPTIONS_CHOOSE")
	if g_IsChangingGovt then
		Controls.ChooseGovtOptionsChoose:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_GOVERNMENT_OPTIONS_CHANGE")
	end
	
	if g_IsRestrictedGovernment then
	
		Controls.CurrentHeader:SetHide(true)
		Controls.ChooseableHeader:SetHide(false)
		Controls.LockedHeader:SetHide(true)

		local tick = true;
		for government in GameInfo.JFD_Governments("ID = '" .. g_IsRestrictedGovernment .. "' AND IsDisabled = 0 AND IsHidden = 0") do
			local govtType = government.Type;
			local govtID = government.ID;
			local govtDesc = government.Description
			local govtHelp = government.Help
			local strHelp = Locale.ConvertTextKey(govtHelp)
			local govtChoiceImage = government.GovernmentChoiceImage
			local itemInstance = g_ChooseableManager:GetInstance();
			itemInstance.Name:LocalizeAndSetText(govtDesc);
			itemInstance.ChoiceImage:SetTexture(govtChoiceImage)
			
			itemInstance.Button:RegisterCallback(Mouse.eLClick, function() SelectGovernmentChoice(govtID); end);
			local pediaEntry = CivilopediaControl and (government.Civilopedia)
			if pediaEntry then
				itemInstance.Button:RegisterCallback(Mouse.eRClick, function() getPedia(Locale.ConvertTextKey(govtDesc)) end)
			end
			
			local color = tick and ltBlue or dkBlue;
			tick = not tick;
			
			itemInstance.Box:SetColorVal(unpack(color));
			itemInstance.Button:SetAlpha(1)
			itemInstance.Button:SetDisabled(false)

			if g_IsChangingGovt then
				if government.NumAnarchyTurnsFromChange > 0 and (not isAllowsGovtChangeNoAnarchy) then
					strHelp = strHelp .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_JFD_CHOOSE_GOVERNMENT_WARNING_ANARCHY", government.NumAnarchyTurnsFromChange)
				end
			end
			itemInstance.Help:SetText(Locale.ConvertTextKey(strHelp))

			local buttonWidth, buttonHeight = itemInstance.GovernmentStack:GetSizeVal();
			local newHeight = buttonHeight;	
			itemInstance.Button:SetSizeVal(buttonWidth - 5, newHeight);
			itemInstance.BounceAnim:SetSizeVal(buttonWidth - 5, newHeight);
			itemInstance.Box:SetSizeVal(buttonWidth - 5, newHeight);
			
			itemInstance.BounceAnim:SetSizeVal(buttonWidth - 5, newHeight + 5);
			itemInstance.BounceGrid:SetSizeVal(buttonWidth - 5, newHeight + 5);
		end

	else
		
		Controls.CurrentHeader:SetHide(false)
		Controls.ChooseableHeader:SetHide(false)
		Controls.LockedHeader:SetHide(false)

		for government in GameInfo.JFD_Governments("IsDisabled = 0 AND IsHidden = 0") do
			local govtType = government.Type;
			local govtID = government.ID;
			local govtDesc = government.Description
			local govtHelp = government.Help
			local canHaveGovernment, canSeeGovernment, strCanHaveGovernment = pPlayer:CanHaveGovernment(govtID)
			local strHelp = Locale.ConvertTextKey(govtHelp)
			local govtChoiceImage = government.GovernmentChoiceImage
			local itemInstance
			
			if govtID == currentGovernmentID then
				itemInstance = g_CurrentManager:GetInstance();
			elseif canHaveGovernment and canSeeGovernment then
				itemInstance = g_ChooseableManager:GetInstance();
			elseif canSeeGovernment then
				itemInstance = g_LockedManager:GetInstance();
			end
			
			if itemInstance then
				itemInstance.Name:LocalizeAndSetText(govtDesc);
				itemInstance.Help:LocalizeAndSetText(govtHelp);
				itemInstance.ChoiceImage:SetTexture(govtChoiceImage)
				
				itemInstance.Button:RegisterCallback(Mouse.eLClick, function() SelectGovernmentChoice(govtID); end);
				itemInstance.ShowViewFactions:RegisterCallback( Mouse.eLClick, function() ShowViewFactions(govtID); end);
				local pediaEntry = CivilopediaControl and (government.Civilopedia)
				if pediaEntry then
					itemInstance.Button:RegisterCallback(Mouse.eRClick, function() getPedia(Locale.ConvertTextKey(govtDesc)) end)
				end
				
				local color = tick and ltBlue or dkBlue;
				tick = not tick;
				
				itemInstance.Box:SetColorVal(unpack(color));
				itemInstance.Button:SetAlpha(1)
				itemInstance.Button:SetDisabled(false)
	
				if (not canHaveGovernment) or g_IsViewingGovt then
					itemInstance.Button:SetDisabled(true)
					itemInstance.Button:SetAlpha(0.6)
				end
				if strCanHaveGovernment ~= "" then
					strHelp = strHelp .. strCanHaveGovernment
				end
				itemInstance.Help:SetText(Locale.ConvertTextKey(strHelp))
				itemInstance.Button:SetHide(not canSeeGovernment)
	
				local buttonWidth, buttonHeight = itemInstance.GovernmentStack:GetSizeVal();
				local newHeight = buttonHeight;	
				itemInstance.Button:SetSizeVal(buttonWidth - 5, newHeight);
				itemInstance.BounceAnim:SetSizeVal(buttonWidth - 5, newHeight);
				itemInstance.Box:SetSizeVal(buttonWidth - 5, newHeight);
				
				itemInstance.BounceAnim:SetSizeVal(buttonWidth - 5, newHeight + 5);
				itemInstance.BounceGrid:SetSizeVal(buttonWidth - 5, newHeight + 5);
			end
		end
	end
	
	Controls.CurrentStack:CalculateSize();
	Controls.CurrentStack:ReprocessAnchoring();
	Controls.ChooseableStack:CalculateSize();
	Controls.ChooseableStack:ReprocessAnchoring();
	Controls.LockedStack:CalculateSize();
	Controls.LockedStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
end

function SelectGovernmentChoice(iChoice) 
	g_iChoice = iChoice;
	
	local govt = GameInfo.JFD_Governments[iChoice];
	if g_IsChangingGovt and (not g_IsChangingGovtFree) then
		local player = Players[Game.GetActivePlayer()]
		if govt.NumAnarchyTurnsFromChange > 0 and (not player:IsAnarchy()) then
			Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_GOVERNMENT_CONFIRM_CHANGE_ANARCHY", govt.Description, govt.NumAnarchyTurnsFromChange); 
			Controls.ConfirmGrid:SetSizeVal(500,360)
		elseif player:IsAnarchy() then
			Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_GOVERNMENT_CONFIRM_CHANGE_ANARCHY_ENDS", govt.Description, govt.NumAnarchyTurnsFromChange); 
			Controls.ConfirmGrid:SetSizeVal(500,360)
		else
			Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_GOVERNMENT_CONFIRM_CHANGE", govt.Description); 
			Controls.ConfirmGrid:SetSizeVal(500,350)
		end
	else
		Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_CHOOSE_JFD_GOVERNMENT_CONFIRM", govt.Description); 
	end

	Controls.ChooseConfirm:SetHide(false);
end

local governmentTribeID = GameInfoTypes["GOVERNMENT_JFD_TRIBE"]
function OnConfirmYes( )
	Controls.ChooseConfirm:SetHide(true);
	local player = Players[Game.GetActivePlayer()]
	local currentGovernmentID = player:GetCurrentGovernment()
	player:SetHasGovernment(g_iChoice, (currentGovernmentID == governmentTribeID), g_IsChangingGovt, g_IsChangingGovtFree, g_IsChangingGovtAnarchyFree)
	Events.AudioPlay2DSound("AS2D_SOUND_JFD_GENERIC_CHOICE");	
	OnClose();
	Events.SerialEventEndTurnDirty()
	LuaEvents.UI_ShowGovernmentOverview()
end
Controls.ConfirmYes:RegisterCallback( Mouse.eLClick, OnConfirmYes );

function OnConfirmNo( )
	Controls.ChooseConfirm:SetHide(true);
end
Controls.ConfirmNo:RegisterCallback( Mouse.eLClick, OnConfirmNo );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function CloseViewFactions( )
	Controls.ViewFactionsPopup:SetHide(true);
end
Controls.CloseViewFactionsButton:RegisterCallback( Mouse.eLClick, CloseViewFactions );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--g_JFD_Factions_Table
local g_JFD_Factions_Table = {}
local g_JFD_Factions_Count = 1
for row in DB.Query("SELECT * FROM JFD_Factions WHERE Type != 'FACTION_JFD_REVOLUTIONARIES';") do 	
	g_JFD_Factions_Table[g_JFD_Factions_Count] = row
	g_JFD_Factions_Count = g_JFD_Factions_Count + 1
end

local reformFactionsMultiPartyID = GameInfoTypes["REFORM_JFD_FACTIONS_MULTI_PARTY"]
local reformFactionsTwoPartyID = GameInfoTypes["REFORM_JFD_FACTIONS_TWO_PARTY"]

local g_PoliticalFactionPopupManager = InstanceManager:new("FactionPopupInstance", "FactionBase",  Controls.FactionPopupStack)
function ShowViewFactions(governmentID)
	
	IconHookup(13, 64, "JFD_SOVEREIGNTY_NOTIFICATION_ATLAS", Controls.Icon)
	
	local player = Players[Game.GetActivePlayer()]
	
	local government = GameInfo.JFD_Governments[governmentID]
	if government.GovernmentNewLegislatureImage then
		Controls.BgImage:SetTexture(government.GovernmentNewLegislatureImage)
	end
	if player:HasReform(reformFactionsMultiPartyID) then
		Controls.BgImage:SetTexture("NewLegislatureMultiParty.dds")
	elseif player:HasReform(reformFactionsTwoPartyID) then
		Controls.BgImage:SetTexture("NewLegislatureTwoParty.dds")
	end
	
	Controls.Stats:LocalizeAndSetText("TXT_KEY_JFD_LEGISLATURE_POPUP_TEXT", government.Description)
			
	local strResultsTT 
	
	g_PoliticalFactionPopupManager:ResetInstances()
	
	local dominantFactionID = player:GetDominantFaction()
		
	local theseFactionsTable = {}
	
	--g_JFD_Factions_Table
	local factionsTable = g_JFD_Factions_Table
	local numFactions = #factionsTable
	for index = 1, numFactions do
		local row = factionsTable[index]
		local thisFactionID = row.ID
		if player:IsFactionValid(thisFactionID, governmentID, true) then	
			table.insert(theseFactionsTable, {FactionID = thisFactionID});
		end
	end
	
	for _, faction in ipairs(theseFactionsTable) do
		local instance = g_PoliticalFactionPopupManager:GetInstance()
		local factionID = faction.FactionID
		local factionInfo = GameInfo.JFD_Factions[factionID]
		local factionName = Locale.ConvertTextKey(factionInfo.Description)
		local factionHelp = player:GetFactionHelp(factionID, factionName, 0)
		instance.FactionName:LocalizeAndSetToolTip(factionHelp)
		instance.CivIconBox:SetHide(true)
		instance.FactionName:SetOffsetVal(12,0)
		instance.FactionName:SetText(factionInfo.IconString .. " " .. factionName)
	end
	
	Controls.FactionPopupStack:CalculateSize()
	Controls.FactionPopupStack:ReprocessAnchoring()
	Controls.FactionPopupScrollPanel:CalculateInternalSize()
	Controls.ViewFactionsPopup:SetHide(false)
end
-------------------------------------------------------------------------------
-- Collapse/Expand Behavior
-------------------------------------------------------------------------------
function OnCollapseExpand()
	Controls.CurrentStack:CalculateSize()
	Controls.CurrentStack:ReprocessAnchoring()
	Controls.ChooseableStack:CalculateSize()
	Controls.ChooseableStack:ReprocessAnchoring()
	Controls.LockedStack:CalculateSize()
	Controls.LockedStack:ReprocessAnchoring()
	Controls.ItemScrollPanel:CalculateInternalSize()
end

RegisterCollapseBehavior{	
	Header = Controls.CurrentHeader, 
	HeaderLabel = Controls.CurrentHeaderLabel, 
	HeaderExpandedLabel = Locale.Lookup("TXT_KEY_JFD_CHOOSE_GOVERNMENT_CURRENT_HEADER"),
	HeaderCollapsedLabel = Locale.Lookup("TXT_KEY_JFD_CHOOSE_GOVERNMENT_CURRENT_HEADER_COLLAPSED"),
	Panel = Controls.CurrentStack,
	Collapsed = false,
	OnCollapse = OnCollapseExpand,
	OnExpand = OnCollapseExpand,
};
							
RegisterCollapseBehavior{
	Header = Controls.ChooseableHeader,
	HeaderLabel = Controls.ChooseableHeaderLabel,
	HeaderExpandedLabel = Locale.Lookup("TXT_KEY_JFD_CHOOSE_GOVERNMENT_AVAILABLE_HEADER"),
	HeaderCollapsedLabel = Locale.Lookup("TXT_KEY_JFD_CHOOSE_GOVERNMENT_AVAILABLE_HEADER_COLLAPSED"),
	Panel = Controls.ChooseableStack,
	Collapsed = false,
	OnCollapse = OnCollapseExpand,
	OnExpand = OnCollapseExpand,
};

RegisterCollapseBehavior{
	Header = Controls.LockedHeader,
	HeaderLabel = Controls.LockedHeaderLabel,
	HeaderExpandedLabel = Locale.Lookup("TXT_KEY_JFD_CHOOSE_GOVERNMENT_LOCKED_HEADER"),
	HeaderCollapsedLabel = Locale.Lookup("TXT_KEY_JFD_CHOOSE_GOVERNMENT_LOCKED_HEADER_COLLAPSED"),
	Panel = Controls.LockedStack,
	Collapsed = false,
	OnCollapse = OnCollapseExpand,
	OnExpand = OnCollapseExpand,
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

	bHidden = bIsHide;
    if( not bInitState ) then
        if( not bIsHide ) then
        	UI.incTurnTimerSemaphore();
        	Events.SerialEventGameMessagePopupShown(g_PopupInfo);
        	
        	--RefreshList();
        
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

function OnDirty()
	-- If the user performed any action that changes selection states, just close this UI.
	if not bHidden then
		OnClose();
	end
end
Events.UnitSelectionChanged.Add( OnDirty );

UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
UIManager:DequeuePopup(ContextPtr)