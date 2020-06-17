-------------------------------------------------
-- Great Person Popup
-------------------------------------------------

include( "IconSupport" );
local m_PopupInfo = nil;

-------------------------------------------------
-------------------------------------------------
local g_CouncillorID = -1
local g_CouncillorName = nil
local g_City = nil
local g_Unit = nil
local g_UnitID = -1

--g_JFD_Councillor_GreatPeople_Table
local g_JFD_Councillor_GreatPeople_Table = {}
local g_JFD_Councillor_GreatPeople_Count = 1
for row in DB.Query("SELECT * FROM JFD_Councillor_GreatPeople;") do 	
	g_JFD_Councillor_GreatPeople_Table[g_JFD_Councillor_GreatPeople_Count] = row
	g_JFD_Councillor_GreatPeople_Count = g_JFD_Councillor_GreatPeople_Count + 1
end

function UpdateCouncillorInfo(playerID, city, unitID, greatPerson)
	local player = Players[playerID]
	
	local councillorType = player:GetUnitClassCouncillorType(greatPerson.Class)
	local councillor = GameInfo.JFD_Councillors[councillorType]
	local councillorDesc = councillor.Description
	local strCouncillorTT = Locale.ConvertTextKey("TXT_KEY_JFD_COUNCILLOR_APPOINT_TT", councillorDesc)
	
	local unitClass = GameInfo.Units[unitID].Class
	local unitClassID = GameInfoTypes[unitClass]
	local plot = Map.GetPlot(city:GetX(), city:GetY())
	for numIndex = 0,(plot:GetNumUnits() - 1) do
		local unit = plot:GetUnit(numIndex)
		if unit:IsGreatPerson() then 
			if (unit:GetUnitClassType() == unitClassID and unit:GetGameTurnCreated() == Game.GetGameTurn()) then
				g_CouncillorName = unit:GetName()
				g_Unit = unit
			end	
		end
	end
	
	g_CouncillorID = councillor.ID
	g_City = city
	g_UnitID = unitID
	
	--g_JFD_Councillor_GreatPeople_Table
	local councillorsTable = g_JFD_Councillor_GreatPeople_Table
	local numCouncillors = #councillorsTable
	for index = 1, numCouncillors do
		local row = councillorsTable[index]
		strCouncillorTT = strCouncillorTT .. Locale.ConvertTextKey(row.Help)
	end
	
	if (not player:IsHasGovernment()) then
		strCouncillorTT = strCouncillorTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_JFD_COUNCILLOR_APPOINT_TT_DISABLED")
		Controls.CouncillorButton:SetDisabled(true)
	else
		if player:IsHasCouncillor(g_CouncillorID) then
			strCouncillorTT = strCouncillorTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_JFD_COUNCILLOR_APPOINT_TT_WARNING", councillorDesc)
		end
		Controls.CouncillorButton:SetDisabled(false)
	end
	Controls.CouncillorButton:SetToolTipString(strCouncillorTT)
end
-------------------------------------------------------------------------------
function OnAppointCouncillorButton()
	if g_UnitID == -1 then return end
	if g_CouncillorID == -1 then return end
   
    local player = Players[Game.GetActivePlayer()]
    if (not player) then return  end
	
	local councillor = GameInfo.JFD_Councillors[g_CouncillorID]
	local councillorDesc = councillor.Description
	local unit = GameInfo.Units[g_UnitID]
	local unitDesc = unit.Description
	Controls.CouncillorConfirm:SetHide(false)
	Controls.CouncillorConfirmLabel:LocalizeAndSetText("TXT_KEY_JFD_COUNCILLOR_APPOINT_CONFIRM", g_CouncillorName, councillorDesc)
	
	if player:IsHasCouncillor(g_CouncillorID) then
		local councillorName = player:GetCouncillorName(g_CouncillorID)
		local existingUnitClass = player:GetCouncillorUnitClassType(g_CouncillorID)
		local existingUnitClassDesc = GameInfo.UnitClasses[existingUnitClass].Description
		Controls.CouncillorConfirmLabel:LocalizeAndSetToolTip("TXT_KEY_JFD_COUNCILLOR_APPOINT_CONFIRM_WARNING", councillorName, existingUnitClassDesc, unitDesc, councillorDesc)
	end
end
Controls.CouncillorButton:RegisterCallback(Mouse.eLClick, OnAppointCouncillorButton)
-------------------------------------------------------------------------------
function OnConfirmYes()
	Players[Game.GetActivePlayer()]:SetHasCouncillor(g_Unit, g_UnitID, g_CouncillorID, g_CouncillorName, true)
	Controls.CouncillorConfirm:SetHide(true)
	OnCloseButtonClicked()
	LuaEvents.UI_ClearNotification("GreatPerson")
end
Controls.ConfirmYes:RegisterCallback(Mouse.eLClick, OnConfirmYes)
-------------------------------------------------------------------------------
function OnConfirmNo()
	Controls.CouncillorConfirm:SetHide(true)
end
Controls.ConfirmNo:RegisterCallback(Mouse.eLClick, OnConfirmNo)
-------------------------------------------------
-------------------------------------------------
function OnPopup( popupInfo )

	if( popupInfo.Type ~= ButtonPopupTypes.BUTTONPOPUP_GREAT_PERSON_REWARD ) then
		return;
	end

	m_PopupInfo = popupInfo;

    local iUnitType = popupInfo.Data1;
    local pGreatPersonInfo = GameInfo.Units[iUnitType];
    
    local iPlayer = Game.GetActivePlayer();
    local iCityID = popupInfo.Data2;
    local pCity = Players[iPlayer]:GetCityByID(iCityID);
	
	Controls.DescriptionLabel:SetText(Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_REWARD", pGreatPersonInfo.Description, pCity:GetNameKey()));
	
	local portraitOffset, portraitAtlas = UI.GetUnitPortraitIcon(iUnitType, iPlayer);
	if IconHookup( portraitOffset, 256, portraitAtlas, Controls.Portrait ) then
		Controls.Portrait:SetHide( false );
	else
		Controls.Portrait:SetHide( true );
	end

	UIManager:QueuePopup( ContextPtr, PopupPriority.GreatPersonReward );
	
	UpdateCouncillorInfo(iPlayer, pCity, iUnitType, pGreatPersonInfo)
end
Events.SerialEventGameMessagePopup.Add( OnPopup );

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function OnCloseButtonClicked ()
	Controls.Portrait:UnloadTexture();
    UIManager:DequeuePopup( ContextPtr );
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnCloseButtonClicked );


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- function InputHandler( uiMsg, wParam, lParam )
    -- if uiMsg == KeyEvents.KeyDown then
        -- if wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
            -- OnCloseButtonClicked();
            -- return true;
        -- end
    -- end
-- end
-- ContextPtr:SetInputHandler( InputHandler );


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

    if( not bInitState ) then
        if( not bIsHide ) then
        	UI.incTurnTimerSemaphore();
        	Events.SerialEventGameMessagePopupShown(m_PopupInfo);
        else
            UI.decTurnTimerSemaphore();
            Events.SerialEventGameMessagePopupProcessed.CallImmediate(ButtonPopupTypes.BUTTONPOPUP_GREAT_PERSON_REWARD, 0);
        end
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
Events.GameplaySetActivePlayer.Add(OnCloseButtonClicked);
