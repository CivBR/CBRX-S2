include("Iska_WaW_Common.lua")
include("IconSupport")
include("InstanceManager")
local DecCivInstanceManager = InstanceManager:new("CivName", "Box", Controls.DecCivStack)
local DefCivInstanceManager = InstanceManager:new("CivName", "Box", Controls.DefCivStack)

local eEnlight = GameInfoTypes.ERA_ENLIGHTENMENT

local unitWarriorID = GameInfo.Units.UNIT_WARRIOR.ID
local unitSwordsmanID = GameInfo.Units.UNIT_SWORDSMAN.ID
local unitKnightID = GameInfo.Units.UNIT_KNIGHT.ID
local unitIskaWarrior = GameInfo.Units.UNIT_ISKA_HW_WARRIOR.ID
local unitIskaSwordsman = GameInfo.Units.UNIT_ISKA_HW_SWORDSMAN.ID
local unitIskaKnight = GameInfo.Units.UNIT_ISKA_HW_KNIGHT.ID

g_PlayerActiveHolyWar = {}
function Iska_LoadHWVars()
	-- if Iska_HW_Debug then print("Loading previous game holy war vars...") end
	for id, player in pairs(Players) do
		if player:IsAlive() and not player:IsMinorCiv() and id ~= 63
		and player:GetReligionCreatedByPlayer() ~= -1 then
			local AHW = Iska_WaW_GetValue(id .. "ActiveHolyWar")
			if AHW ~= nil then
				g_PlayerActiveHolyWar[id] = true
			end
			for id2, player2 in pairs(Players) do
				if player2:IsAlive() and not player2:IsMinorCiv() and id2 ~= 63
				and player2:GetReligionCreatedByPlayer() ~= -1 then
					local AHW = Iska_WaW_GetValue(player:GetReligionCreatedByPlayer() .. "ActiveHolyWarWith" .. player2:GetReligionCreatedByPlayer())
					if AHW ~= nil then
						g_PlayerActiveHolyWar[player2:GetReligionCreatedByPlayer() .. "ActiveHolyWarWith" .. player:GetReligionCreatedByPlayer()] = true
						g_PlayerActiveHolyWar[player:GetReligionCreatedByPlayer() .. "ActiveHolyWarWith" .. player2:GetReligionCreatedByPlayer()] = true
					end
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(Iska_LoadHWVars)

function Iska_WaW_HW_WarStateChange(team1, team2, war)
	local hplayer = Players[Game.GetActivePlayer()]
	local decplayer = Players[Teams[team1]:GetLeaderID()]
	local decrel = decplayer:GetReligionCreatedByPlayer()
	local defplayer = Players[Teams[team2]:GetLeaderID()]
	local defrel = defplayer:GetReligionCreatedByPlayer()
	
	if decplayer:GetCurrentEra() > eEnlight and defplayer:GetCurrentEra() > eEnlight then return end
	
	local deccontrolhs, defcontrolhs, playerscontrolhcs
	for city in decplayer:Cities() do
		if city:IsHolyCityForReligion(decrel) then deccontrolhs = true end
	end
	for city in defplayer:Cities() do
		if city:IsHolyCityForReligion(defrel) then defcontrolhs = true end
	end
	if deccontrolhs and defcontrolhs then playerscontrolhcs = true end
	if decplayer:IsMinorCiv() or defplayer:IsMinorCiv() or defrel < 1 or decrel < 1 or not playerscontrolhcs then return end
	if Iska_WaW_GetMajorityReligion(decplayer) <= 0 or Iska_WaW_GetMajorityReligion(defplayer) <= 0 then return end
	--if Iska_HW_Debug then print("Starting code Iska_WaW_HW_WarStateChange: religions: " ..  Locale.Lookup(GameInfo.Religions[decrel].Description) .. " " .. Locale.Lookup(GameInfo.Religions[defrel].Description)) end

	if war and playerscontrolhcs then
		if Iska_WaW_GetValue(decrel .. "ActiveHolyWarWith" .. defrel) == nil and Iska_WaW_GetValue(defrel .. "ActiveHolyWarWith" .. decrel) == nil then
			--if Iska_HW_Debug then print("The religious authorities of " .. GameInfo.Religions[decrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[decrel].Description) .. " have declared a Holy War upon " .. GameInfo.Religions[defrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[defrel].Description) .. "!") end
			local sTitle = Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_TITLE")
			local sText = Locale.ConvertTextKey("TXT_KEY_ISKA_HOLY_WAR_DESC", GameInfo.Religions[decrel].IconString, Locale.Lookup(GameInfo.Religions[decrel].Description), GameInfo.Religions[defrel].IconString, Locale.Lookup(GameInfo.Religions[defrel].Description))
			hplayer:AddNotification(NotificationTypes.NOTIFICATION_RELIGION_FOUNDED, sText, sTitle)
			Iska_WaW_SetValue(decplayer:GetID() .. "ActiveHolyWar", true)
			Iska_WaW_SetValue(defplayer:GetID() .. "ActiveHolyWar", true)
			g_PlayerActiveHolyWar[decplayer:GetID()] = true
			g_PlayerActiveHolyWar[defplayer:GetID()] = true
			Iska_WaW_SetValue(defrel .. "ActiveHolyWarWith" .. decrel, true)
			Iska_WaW_SetValue(decrel .. "ActiveHolyWarWith" .. defrel, true)
			g_PlayerActiveHolyWar[decrel .. "ActiveHolyWarWith" .. defrel] = true
			g_PlayerActiveHolyWar[defrel .. "ActiveHolyWarWith" .. decrel] = true
			Iska_WaW_HW_GrantHolyWarriors(decplayer)
			Iska_WaW_HW_GrantHolyWarriors(defplayer)
		end
	end
	
	if not war and playerscontrolhcs then
		if Iska_WaW_GetValue(defrel .. "ActiveHolyWarWith" .. decrel) ~= nil and Iska_WaW_GetValue(decrel .. "ActiveHolyWarWith" .. defrel) ~= nil then
			--if Iska_HW_Debug then print("The Holy War between the faiths of " .. Locale.Lookup(GameInfo.Religions[defrel].Description) .. " and " .. Locale.Lookup(GameInfo.Religions[decrel].Description) .. " has ended.") end
			Iska_WaW_SetValue(defrel .. "ActiveHolyWarWith" .. decrel, nil)
			Iska_WaW_SetValue(decrel .. "ActiveHolyWarWith" .. defrel, nil)
			g_PlayerActiveHolyWar[defrel .. "ActiveHolyWarWith" .. defrel] = nil
			g_PlayerActiveHolyWar[defrel .. "ActiveHolyWarWith" .. decrel] = nil
			Iska_WaW_SetValue(decplayer:GetID() .. "ActiveHolyWar", nil)
			Iska_WaW_SetValue(defplayer:GetID() .. "ActiveHolyWar", nil)
			g_PlayerActiveHolyWar[decplayer:GetID()] = nil
			g_PlayerActiveHolyWar[defplayer:GetID()] = nil
			local sTitle = Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_ENDED_TITLE")
			local sText = Locale.ConvertTextKey("TXT_KEY_ISKA_HOLY_WAR_ENDED_DESC", GameInfo.Religions[decrel].IconString, Locale.Lookup(GameInfo.Religions[decrel].Description), GameInfo.Religions[defrel].IconString, Locale.Lookup(GameInfo.Religions[defrel].Description))
			hplayer:AddNotification(NotificationTypes.NOTIFICATION_RELIGION_FOUNDED, sText, sTitle)
		end
	end
	--if Iska_HW_Debug then print("End Iska_WaW_HW_WarStateChange.") end
end
Events.WarStateChanged.Add(Iska_WaW_HW_WarStateChange)

function Iska_WaW_HW_GrantHolyWarriors(player)
	if player ~= nil then
		--if Iska_HW_Debug then print("Start code Iska_WaW_HW_GrantHolyWarriors: player: " ..  player:GetName()) end
		for unit in player:Units() do
			if unit ~= nil then
				if unit:GetDamage() < 100 then
					local type = unit:GetUnitType()
					if type == unitWarriorID then
						local placex = unit:GetX() local placey = unit:GetY() --unit:Kill(false, -1)
						local newUnit = player:InitUnit(unitIskaWarrior, placex, placey, UNITAI_OFFENSE)
						newUnit:Convert(unit)
					end
					if type == unitSwordsmanID then
						local placex = unit:GetX() local placey = unit:GetY() --unit:Kill(false, -1)
						local newUnit = player:InitUnit(unitIskaSwordsman, placex, placey, UNITAI_OFFENSE)
						newUnit:Convert(unit)
					end
					if type == unitKnightID then
						local placex = unit:GetX() local placey = unit:GetY() --unit:Kill(false, -1)
						local newUnit = player:InitUnit(unitIskaKnight, placex, placey, UNITAI_OFFENSE)
						newUnit:Convert(unit)
					end
				end
			end
		end
		--if Iska_HW_Debug then print("End Iska_WaW_HW_GrantHolyWarriors.") end
	end
 end

function Iska_WaW_LimitHW(iPlayer, unitTypeID)
	if unitTypeID == GameInfo.Units["UNIT_ISKA_HW_WARRIOR"].ID
	or unitTypeID == GameInfo.Units["UNIT_ISKA_HW_SWORDSMAN"].ID
	or unitTypeID == GameInfo.Units["UNIT_ISKA_HW_KNIGHT"].ID
	then
		return false
	end
	return true
end
GameEvents.PlayerCanTrain.Add(Iska_WaW_LimitHW)

function Iska_WaW_HW_AIDecideEntrance(playerID)
	local player = Players[playerID]
	if player:GetCurrentEra() > eEnlight then return end
	if not player:IsMinorCiv() and Iska_WaW_GetMajorityReligion(player) > 0 then
		for id, oplayer in pairs(Players) do
			if g_PlayerActiveHolyWar[id] and player:HasReligionInMostCities(oplayer:GetReligionCreatedByPlayer()) and player ~= oplayer then
				for id, nplayer in pairs(Players) do
					if g_PlayerActiveHolyWar[oplayer:GetReligionCreatedByPlayer() .. "ActiveHolyWarWith" .. nplayer:GetReligionCreatedByPlayer()] 
					and nplayer ~= oplayer and nplayer ~= player and Iska_WaW_GetMajorityReligion(nplayer) > 0 and not Teams[player:GetTeam()]:IsAtWar(nplayer:GetTeam()) then
						Teams[player:GetTeam()]:DeclareWar(nplayer:GetTeam())
						Iska_WaW_HW_GrantHolyWarriors(player)
						if Iska_HW_Debug then print(player:GetName() .. " declared war on " .. nplayer:GetName() .. " due to holy war!") end

						for id, mplayer in pairs(Players) do
							if mplayer:HasReligionInMostCities(nplayer:GetReligionCreatedByPlayer()) and not Teams[player:GetTeam()]:IsAtWar(mplayer:GetTeam()) then
								Teams[player:GetTeam()]:DeclareWar(mplayer:GetTeam())
								if Iska_HW_Debug then print(player:GetName() .. " also declared war on " .. mplayer:GetName() .. " due to holy war!") end
							end
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(Iska_WaW_HW_AIDecideEntrance)

function Iska_WaW_HW_CityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local plot = Map.GetPlot(iX, iY)
	local city = plot:GetPlotCity()
	local newPlayerID = iNewOwner
	--if Iska_HW_Debug then print("Pre-start 0 code Iska_WaW_HW_CityCaptured: city: " ..  city:GetName()) end
	if city:IsHolyCityAnyReligion() then
		--if Iska_HW_Debug then print("Pre-start 1 code Iska_WaW_HW_CityCaptured: city: " ..  city:GetName()) end
		local defrel
		for row in GameInfo.Religions() do
			if city:IsHolyCityForReligion(row.ID) then
				defrel = row.ID
				break
			end
		end
		--if Iska_HW_Debug then print("Pre-start 2 code Iska_WaW_HW_CityCaptured: city: " ..  city:GetName()) end
		for row in GameInfo.Religions() do
			--if row.ID ~= nil then
				--if Game.GetFounder(row.ID, -1) ~= nil then
					if g_PlayerActiveHolyWar[defrel .. "ActiveHolyWarWith" .. row.ID] or g_PlayerActiveHolyWar[row.ID .. "ActiveHolyWarWith" .. defrel] then
						--if Iska_HW_Debug then print("Start code Iska_WaW_HW_CityCaptured: city: " ..  city:GetName()) end
						
						Iska_WaW_SetValue(defrel .. "ActiveHolyWarWith" .. row.ID, nil)
						Iska_WaW_SetValue(row.ID .. "ActiveHolyWarWith" .. defrel, nil)
						g_PlayerActiveHolyWar[defrel .. "ActiveHolyWarWith" .. row.ID] = nil
						g_PlayerActiveHolyWar[row.ID .. "ActiveHolyWarWith" .. defrel] = nil
						Iska_WaW_SetValue(Game.GetFounder(defrel, -1) .. "ActiveHolyWar", nil)
						Iska_WaW_SetValue(Game.GetFounder(row.ID, -1) .. "ActiveHolyWar", nil)
						g_PlayerActiveHolyWar[Game.GetFounder(defrel, -1)] = nil
						g_PlayerActiveHolyWar[Game.GetFounder(row.ID, -1)] = nil

						local hplayer = Players[Game.GetActivePlayer()]
						local player = Players[newPlayerID]
						local oplayer = Players[iOldOwner]

						if Players[newPlayerID]:GetReligionCreatedByPlayer() == row.ID then
							local decrel = row.ID
							if decrel == defrel then return end
							if Iska_HW_Debug then print("The Holy Armies of " .. GameInfo.Religions[decrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[decrel].Description) .. " have captured " .. city:GetName() .. ", the Holy City of  " .. GameInfo.Religions[defrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[defrel].Description) .. "! The Holy War of " .. GameInfo.Religions[decrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[decrel].Description) .. " has ended.") end
							local sTitle = Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_ENDED_TITLE")
							local sText = Locale.ConvertTextKey("TXT_KEY_ISKA_HOLY_WAR_ENDED_CAPTURE_OTHER_DESC", city:GetName(), GameInfo.Religions[decrel].IconString, Locale.Lookup(GameInfo.Religions[decrel].Description), GameInfo.Religions[defrel].IconString, Locale.Lookup(GameInfo.Religions[defrel].Description))
							hplayer:AddNotification(NotificationTypes.NOTIFICATION_RELIGION_FOUNDED, sText, sTitle)
							Players[newPlayerID]:ChangeFaith(1000)
							Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(Players[newPlayerID]:GetCapitalCity():GetX(),Players[newPlayerID]:GetCapitalCity():GetY()))), Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_ENDED_CELEBRATIONS") .. 1000 .. " [ICON_PEACE] Faith", 0)
						else
							if row.ID == defrel then return end
							if Iska_HW_Debug then print("The Holy City of " .. Locale.Lookup(GameInfo.Religions[defrel].Description) .. " has fallen! The Holy War of " .. Locale.Lookup(GameInfo.Religions[row.ID].Description) .. " has ended.") end
							local sTitle = Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_ENDED_TITLE")
							local sText = Locale.ConvertTextKey("TXT_KEY_ISKA_HOLY_WAR_ENDED_CAPTURE_PLAYER_DESC", city:GetName(), GameInfo.Religions[defrel].IconString, Locale.Lookup(GameInfo.Religions[defrel].Description), GameInfo.Religions[row.ID].IconString, Locale.Lookup(GameInfo.Religions[row.ID].Description))
							hplayer:AddNotification(NotificationTypes.NOTIFICATION_RELIGION_FOUNDED, sText, sTitle)
							if Players[newPlayerID]:GetCapitalCity():GetReligiousMajority() == row.ID then
								Players[newPlayerID]:ChangeFaith(750)
								Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(Players[newPlayerID]:GetCapitalCity():GetX(),Players[newPlayerID]:GetCapitalCity():GetY()))), Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_ENDED_CELEBRATIONS") .. 750 .. " [ICON_PEACE] Faith", 0)
							end
						end
					end
					--if Iska_HW_Debug then print("End Iska_WaW_HW_CityCaptured.") end
				end
			--end
		--end
	end
end
GameEvents.CityCaptureComplete.Add(Iska_WaW_HW_CityCaptured)

function Iska_WaW_HW_UnitKilled(krplayerID, keplayerID)
	local krplayer = Players[krplayerID]
	local keplayer = Players[keplayerID]
	local deccity = krplayer:GetCapitalCity()
	local defcity = keplayer:GetCapitalCity()
	if deccity and defcity then
		if deccity:GetReligiousMajority() and defcity:GetReligiousMajority()
		and defcity:GetReligiousMajority() ~= -1 and deccity:GetReligiousMajority() ~= -1 then
			--if Iska_HW_Debug then print("pre-Start code Iska_WaW_HW_UnitKilled.") end
			local decrel = Locale.Lookup(GameInfo.Religions[deccity:GetReligiousMajority()].Description)
			local defrel = Locale.Lookup(GameInfo.Religions[defcity:GetReligiousMajority()].Description)
			--if g_PlayerActiveHolyWar[Game.GetFounder(deccity:GetReligiousMajority(), -1)] and g_PlayerActiveHolyWar[Game.GetFounder(defcity:GetReligiousMajority(), -1)] then
				if Iska_WaW_JFDLC then
					if decplayer:GetStateReligion() > 0  and defplayer:GetStateReligion() > 0 then
						decrel = krplayer:GetStateReligion()
						defrel = keplayer:GetStateReligion()
					else return end
				end
				--if Iska_HW_Debug then print("Start code Iska_WaW_HW_UnitKilled.") end

				if g_PlayerActiveHolyWar[defrel .. "ActiveHolyWarWith" .. decrel] or g_PlayerActiveHolyWar[decrel .. "ActiveHolyWarWith" .. defrel] then
					local faith = krplayer:GetTotalFaithPerTurn()
					if GameInfo["Units"][UnitType]["Combat"] ~= nil then
						if faith > GameInfo["Units"][UnitType]["Combat"] then faith = GameInfo["Units"][UnitType]["Combat"] end
					end
					krplayer:ChangeFaith(faith)
					Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(krplayer:GetCapitalCity():GetX(),krplayer:GetCapitalCity():GetY()))), Locale.Lookup("TXT_KEY_ISKA_HOLY_WAR_UNIT_KILLED") .. faith .. " [ICON_PEACE] Faith", 0)
					--if Iska_RoT_JFDLC then krplayer:ChangePiety(1) end
				end

				--if Iska_HW_Debug then print("End Iska_WaW_HW_UnitKilled.") end
			--end
		end 
	end
end
GameEvents.UnitKilledInCombat.Add(Iska_WaW_HW_UnitKilled)

function Iska_WaW_HW_GetPanelInfo(decplayer, defplayer, hplayer, decrel, defrel)
	-- if Iska_HW_Debug then print("Starting code Iska_WaW_HW_GetPanelInfo: religions: " ..  decrel .. " " .. defrel) end
	DecCivInstanceManager:ResetInstances()
	DefCivInstanceManager:ResetInstances()
	decmight, defmight, decfaith, deffaith = 0, 0, 0, 0
	for id, player in pairs(Players) do
		if player:IsAlive() and id ~= 63 then
			if Iska_HW_Debug then print("civ: " .. player:GetCivilizationShortDescriptionKey() .. " founded religion: " .. player:GetReligionCreatedByPlayer() .. " religion in most cities: " .. Iska_WaW_GetMajorityReligion(player)) end
			if (player:HasReligionInMostCities(decrel) and player:GetReligionCreatedByPlayer() ~= defrel) or player:GetReligionCreatedByPlayer() == decrel then
				--if Iska_HW_Debug then print("Adding to dec civ list") end
				local DecCivInstance = DecCivInstanceManager:GetInstance()   
				DecCivInstance.Label:LocalizeAndSetText(player:GetCivilizationShortDescriptionKey())
				DecCivInstance.MightLabel:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_MIGHTLABEL", tostring(player:GetMilitaryMight())))
				DecCivInstance.FaithLabel:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_FAITHLABEL", tostring(player:GetTotalFaithPerTurn())))
				CivIconHookup(id, 32, DecCivInstance.CivIcon, DecCivInstance.CivIconBG, DecCivInstance.CivIconShadow, false, true);
				decmight = decmight + player:GetMilitaryMight()
				decfaith = decfaith + player:GetTotalFaithPerTurn()
			end
			if (player:HasReligionInMostCities(defrel) and player:GetReligionCreatedByPlayer() ~= decrel) or player:GetReligionCreatedByPlayer() == defrel then
				--if Iska_HW_Debug then print("Adding to def civ list") end
				local DefCivInstance = DefCivInstanceManager:GetInstance()   
				DefCivInstance.Label:LocalizeAndSetText(player:GetCivilizationShortDescriptionKey())
				DefCivInstance.MightLabel:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_MIGHTLABEL", tostring(player:GetMilitaryMight())))
				DefCivInstance.FaithLabel:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_FAITHLABEL", tostring(player:GetTotalFaithPerTurn())))
				CivIconHookup(id, 32, DefCivInstance.CivIcon, DefCivInstance.CivIconBG, DefCivInstance.CivIconShadow, false, true);
				defmight = defmight + player:GetMilitaryMight()
				deffaith = deffaith + player:GetTotalFaithPerTurn()
			end
		end
	end

	Controls.DecCivStack:CalculateSize();
	Controls.DecCivStack:ReprocessAnchoring();
	Controls.DecCivPanel:CalculateInternalSize()
	Controls.DecRel:LocalizeAndSetText(GameInfo.Religions[decrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[decrel].Description))
	Controls.DecMight:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_MIGHTLABEL", tostring(decmight)))
	Controls.DecFaith:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_FAITHLABEL", tostring(decfaith)))
	Controls.DefCivStack:CalculateSize();
	Controls.DefCivStack:ReprocessAnchoring();
	Controls.DefCivPanel:CalculateInternalSize()
	Controls.DefRel:LocalizeAndSetText(GameInfo.Religions[defrel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[defrel].Description))
	Controls.DefMight:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_MIGHTLABEL", tostring(defmight)))
	Controls.DefFaith:LocalizeAndSetText(Locale.ConvertTextKey("TXT_KEY_ISKA_INSTANCE_FAITHLABEL", tostring(deffaith)))

	return ""
end

function Iska_WaW_HW_ClosePanel()
	Controls.HolyWarPanelMain:SetHide(true)
	Controls.BGBlock:SetHide(true)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, Iska_WaW_HW_ClosePanel)

local function InputHandler(uiMsg, wParam, lParam)
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE then
			if not Controls.HolyWarPanelMain:IsHidden() then
				Iska_WaW_HW_ClosePanel()
				return true
			end
        end
		if wParam == Keys.VK_RETURN then
			if not Controls.HolyWarPanelMain:IsHidden() then
				Iska_WaW_HW_ClosePanel()
				return true
			end
        end
    end
end
ContextPtr:SetInputHandler(InputHandler);