-- MHA_ChooseSociety
-- Author: JFD
-- Modified by Sukritact
-- DateCreated: 5/28/2014 5:24:04 AM
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
-- Globals
------------------------------------------------------------------------------------------------------------------------
local activePlayer = Players[Game.GetActivePlayer()]

local tMHA_Societies = {}
for iKey, sVal in ipairs({
	'POLICY_DECISIONS_MHA_GOOSE_SOCIETY',
	'POLICY_DECISIONS_MHA_BULL_SOCIETY',
	'POLICY_DECISIONS_MHA_STONE_HAMMER_SOCIETY',
	'POLICY_DECISIONS_MHA_SKUNK_SOCIETY',
	'POLICY_DECISIONS_MHA_WHITE_BUFFALO_COW_SOCIETY',
	'POLICY_DECISIONS_MHA_BLACK_MOUTH_SOCIETY',
}) do
	
	local tPolicy = GameInfo.Policies[sVal]
	if tPolicy then
		local sDescription = Locale.ConvertTextKey(tPolicy.Description)
		local iColon = string.find(sDescription, ":")
		local sName = string.sub(sDescription, 0, iColon - 1)
		local sEffect = string.sub(sDescription, iColon + 2)
		table.insert(tMHA_Societies, {ID = tPolicy.ID, Type = tPolicy.Type, Description = sName, Effect = sEffect})
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_OnSelectButton
------------------------------------------------------------------------------------------------------------------------
function JFD_OnSelectButton()
	Controls.MainUIBG:SetHide(true)
	Controls.MainUI:SetHide(true)	

	activePlayer:SetNumFreePolicies(1)
	activePlayer:SetNumFreePolicies(0)
	activePlayer:SetHasPolicy(SocietySelectedID, true)	
end
Controls.SelectButton:RegisterCallback(Mouse.eLClick, JFD_OnSelectButton)
------------------------------------------------------------------------------------------------------------------------
-- JFD_OnStateReligionChosen
------------------------------------------------------------------------------------------------------------------------
function JFD_OnSocietyChosen(iKey)
	local player = Players[Game.GetActivePlayer()]
	local tPolicy = tMHA_Societies[iKey]
	local SocietyDesc = tPolicy.Description
	Controls.SocietyInstanceMenu:GetButton():LocalizeAndSetText(SocietyDesc)
	SocietySelectedID = tPolicy.ID

	Controls.SelectButton:SetDisabled(false)
	Controls.SelectButton:LocalizeAndSetToolTip("TXT_KEY_MHA_CHOOSE_SOCIETY_BUTTON", SocietyDesc)
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_ShowPopup
------------------------------------------------------------------------------------------------------------------------
function JFD_ShowPopup()
	Controls.MainUIBG:SetHide(false)
	Controls.MainUI:SetHide(false)
	JFD_UpdateSocietyList()
end
LuaEvents.MHA_ShowChooseSocietyPopup.Add(function() JFD_ShowPopup() end)
------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdateSocietyList
------------------------------------------------------------------------------------------------------------------------
function JFD_UpdateSocietyList()
	Controls.SocietyInstanceMenu:ClearEntries()
	local activePlayerID = Game.GetActivePlayer()
	
	for iKey, tPolicy in ipairs(tMHA_Societies) do
		if not(activePlayer:HasPolicy(tPolicy.ID)) then
			local entry = {}
			Controls.SocietyInstanceMenu:BuildEntry("InstanceOne", entry)
			entry.Button:SetVoid1(iKey)
			entry.Button:LocalizeAndSetText(tPolicy.Description)
			entry.Button:SetToolTipString(tPolicy.Effect)
		end
	end
	
	Controls.SelectButton:SetDisabled(true)
	Controls.SocietyInstanceMenu:GetButton():LocalizeAndSetText("TXT_KEY_DECISIONS_MHA_SOCIETIES")
	Controls.SocietyInstanceMenu:CalculateInternals()
	Controls.SocietyInstanceMenu:RegisterSelectionCallback(JFD_OnSocietyChosen)
end
--==========================================================================================================================
--==========================================================================================================================