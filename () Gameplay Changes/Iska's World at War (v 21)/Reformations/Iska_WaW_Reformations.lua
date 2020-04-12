function Iska_WaW_HW_Reformation(playerID)
	player = Players[playerID]
	if GameInfo.Policies["POLICY_REFORMATION"].ID ~= nil then
		if player:HasPolicy(GameInfo.Policies["POLICY_REFORMATION"].ID) and player:GetReligionCreatedByPlayer() < 1 then
			for city in player:Cities() do
				if city:IsHolyCityAnyReligion() and city:IsHolyCityForReligion(player:GetCapitalCity():GetReligiousMajority()) then
					if Iska_HW_Debug then print("Starting code Iska_WaW_HW_Reformation: religion: " ..  city:IsHolyCityForReligion(player:GetCapitalCity():GetReligiousMajority())) end
					local religion = player:GetCapitalCity():GetReligiousMajority()
					Game.SetFounder(religion, player:GetID())
					--Game.SetHolyCity(religion, player:GetCapitalCity()) Doesn't seem to work :|
					--print(Game.GetHolyCityForReligion(religion, -1):GetName())
					if Iska_HW_Debug then print("The religious authorities of " .. GameInfo.Religions[religion].IconString .. " " .. Locale.Lookup(GameInfo.Religions[religion].Description) .. " have fallen to ruin and obsolesence. " .. player:GetName() .. " has initiated a Reformation of " .. GameInfo.Religions[religion].IconString .. " " .. Locale.Lookup(GameInfo.Religions[religion].Description) .. ", and now " .. player:GetCivilizationShortDescription() .. " alone will benefit from the Founder Beliefs of " .. GameInfo.Religions[religion].IconString .. " " .. Locale.Lookup(GameInfo.Religions[religion].Description) .. ".") end
					local sTitle = Locale.Lookup("TXT_KEY_ISKA_REFORMATION_TITLE")
					local sText = Locale.ConvertTextKey("TXT_KEY_ISKA_REFORMATION_DESC", GameInfo.Religions[religion].IconString, Locale.Lookup(GameInfo.Religions[religion].Description), player:GetName())
					local hplayer = Players[Game.GetActivePlayer()]
					hplayer:AddNotification(NotificationTypes.NOTIFICATION_REFORMATION_BELIEF_ADDED, sText, sTitle)
					if Iska_HW_Debug then print("End Iska_WaW_HW_Reformation.") end
				end
			end
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(Iska_WaW_HW_Reformation)
GameEvents.PlayerDoTurn.Add(Iska_WaW_HW_Reformation)