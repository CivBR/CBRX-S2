print ("Olmec Popup")

include("IconSupport");
include("InstanceManager");
include("InfoTooltipInclude");

--SaveUtils
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "Olmec 2";

-------------------------------------------------
local m_PopupInfo = nil;

local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
local numOlmecPersons = 2

local g_PopupInfo = nil;

ButtonPopupTypes.BUTTONPOPUP_TOMATEKH_CHOOSE_OLMEC_PERSON = "BUTTONPOPUP_TOMATEKH_CHOOSE_OLMEC_PERSON"
g_PopupInfo = {["Type"] = ButtonPopupTypes.BUTTONPOPUP_TOMATEKH_CHOOSE_OLMEC_PERSON}
 
local g_ItemManager = InstanceManager:new( "ItemInstance", "Button", Controls.ItemStack );
local g_SelectedPerson = nil
function DisplayPopup()
	g_ItemManager:ResetInstances();
	for num = 1, numOlmecPersons do
		local controlTable = g_ItemManager:GetInstance();
		local portraitAtlas = "OLMEC_CHOOSE_ATLAS"
		IconHookup( num, 64, portraitAtlas, controlTable.Icon64 );
		controlTable.Name:LocalizeAndSetText("TXT_KEY_OLMEC_BONUS_TITLE_" .. num);
		controlTable.Button:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_OLMEC_BONUS_BODY_" .. num));
		local pPlayer = activePlayer;
		--
		if (load(pPlayer, "OLMEC_EVER_BONUS_" .. num) == true) then
			controlTable.Name:LocalizeAndSetText("[COLOR_NEGATIVE_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_OLMEC_BONUS_TITLE_" .. num) .. "[ENDCOLOR]");
			controlTable.Button:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_OLMEC_BONUS_BODY_" .. num) .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_OLMEC_BONUS_CURRENT"));
			controlTable.Button:SetDisabled(true)
		else
			controlTable.Button:SetDisabled(false)
		end
		--
		local selectionAnim = controlTable.SelectionAnim;
		controlTable.Button:SetVoid1(num)
		controlTable.Button:RegisterCallback(Mouse.eLClick, function()  
			g_SelectedPerson = num
			DisplayPopup()
		end);
		if g_SelectedPerson then
			if g_SelectedPerson == num then
				controlTable.SelectionAnim:SetHide(false)
			else
				controlTable.SelectionAnim:SetHide(true)
			end
		else
			controlTable.SelectionAnim:SetHide(true)
		end
	end
	Controls.ItemStack:CalculateSize();
	Controls.ItemStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
	Controls.ConfirmButton:SetDisabled(true);
	ContextPtr:SetHide(false); 
	if g_SelectedPerson then
		Controls.ConfirmButton:SetDisabled(false);
	end	
end
----------------------------------------------------------------
function OnConfirm()
    ContextPtr:SetHide(true); 

	local pPlayer = activePlayer;
	local RepeatCheck = 0

	local uMerchant = GameInfo.Units.UNIT_MERCHANT.ID;
	local uArtist = GameInfo.Units.UNIT_OLMEC_UNIQUE_ART.ID;
	local uGeneral = GameInfo.Units.UNIT_GREAT_GENERAL.ID;
	local pcCity = pPlayer:GetCapitalCity();
	local title = "Great Person born";
	local descr = "A Great Person has been born in your civilization!";

	if g_SelectedPerson == 1 then
		if (load(pPlayer, "Olmec Merchant") ~= true) then

			pUnit = pPlayer:InitUnit(uMerchant, pcCity:GetX(), pcCity:GetY(), UNITAI_MERCHANT);
			pUnit:JumpToNearestValidPlot()
			pUnit:SetName("Kele");

			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, descr, title, pcCity:GetX(), pcCity:GetY(), uMerchant, -1);

		elseif (load(pPlayer, "Olmec Merchant") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedPerson == 2 then
		if (load(pPlayer, "Olmec Artist") ~= true) then

			pUnit = pPlayer:InitUnit(uArtist, pcCity:GetX(), pcCity:GetY(), UNITAI_ARTIST);
			pUnit:JumpToNearestValidPlot()

			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, descr, title, pcCity:GetX(), pcCity:GetY(), uArtist, -1);

		elseif (load(pPlayer, "Olmec Artist") == true) then
			RepeatCheck = 1;
		end
	end

	if RepeatCheck >= 1 then
		DisplayPopup()
	end

end
Controls.ConfirmButton:RegisterCallback( Mouse.eLClick, OnConfirm );
----------------------------------------------------------------
function ShowOlmecPersonsPopup()
	DisplayPopup()
end 
LuaEvents.Tomatekh_ShowOlmecPersonsPopup.Add(ShowOlmecPersonsPopup)
----------------------------------------------------------------
function OnActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	if (not ContextPtr:IsHidden()) then
		ContextPtr:SetHide(true);
	end
end
Events.GameplaySetActivePlayer.Add(OnActivePlayerChanged);

UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
UIManager:DequeuePopup(ContextPtr)
----------------------------------------------------------------