-- Author: JFD
--------------------------------------------------------------

include("IconSupport")

local activePlayerID = Game.GetActivePlayer()
local activePlayer	 = Players[activePlayerID]

local iPlatformMound = GameInfoTypes.IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD;
local iCiv = GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH;

function JFD_ActivePlayerTurnStart()

	if (activePlayer:GetCivilizationType() ~= iCiv) then return end	
	if not (activePlayer:IsHuman()) then return end	

	IconHookup(4, 80, "MISSISSIPPI_MOD_TOMATEKH_ATLAS", Controls.IconImage) 
	Controls.IconFrame:SetHide(true)

	local UITitle = ""
	local UIList = ""
		
	if (activePlayer:GetNumCities() >= 1) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_3_CENTER")
		for pCity in activePlayer:Cities() do
			local pPlot = pCity:Plot();
			if (pPlot:GetImprovementType() == iPlatformMound) then
				UIList = UIList .. "[NEWLINE]" 
				UIList = UIList .. pCity:GetName() .. ""
			end
		end
	elseif (activePlayer:GetNumCities() < 1) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_3_CENTER")
		UIList = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_LIST_1_CENTER")
	end

	text = UITitle .. UIList .. "[ENDCOLOR]"

	Controls.IconImage:LocalizeAndSetToolTip(text, activePlayer:GetName(), activePlayer:GetCivilizationShortDescription())
	Controls.IconFrame:SetHide(false)

end
Events.ActivePlayerTurnStart.Add(JFD_ActivePlayerTurnStart)

--City Screen stuff
function JFD_OnEnterCityScreen()
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)

function JFD_OnExitCityScreen()
	JFD_ActivePlayerTurnStart()
end
Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)