--===================================================================================================================================================
-- Leugi Colombia Utils
--===================================================================================================================================================
-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Important Functions and Variables added: 
--		IsCPActive()														Returns true or false
--		SetPolicy(player, policy, bool)										Gives or removes a policy from player in a CP safe way (or not if CP isn't there)
--		iModded(int)														Returns the integer multiplied by iMod (So the value changes with the game speed)
--		Leugi_Notification(player, description, title, UnitIcon, plot)		Shows a notification, either World Events (Like JFD's) or using the UnitIcon provided (if any)
--		tablerandom(tbl)													Returns a random number from a table.
--		IsLatino(player)													Returns true or false if player is Colonial Latin (using CulDiv)
--		HasTrait(player, traitID)											Returns true or false if it has the trait... the trait must be in "TRAIT_XXX" format.
--		Leugi_FloatingText(plot, text)										Adds a Floating text on the plot.
--		isWarWith(player, cplayer)											Returns true or false if the two players are at war
--		isPeC()																Returns true or false if Panem et Circenses is active
-----------------------------------------------------------------------------------------------------------------------------------------------------
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
--===================================================================================================================================================
-- isPeC()
--===================================================================================================================================================
function isPeC()
	if GameInfoTypes["UNIT_ENTERTAINER"] then
		return true
	else
		return false
	end
end
-- isWarWith(player, cplayer)
--===================================================================================================================================================
function isWarWith(player, cplayer)
	--print("Checking War")
	local team = player:GetTeam();
	local cteam = cplayer:GetTeam();
	--if cplayer:GetCivilizationType() == GameInfo.Civilizations.CIVILIZATION_BARBARIAN.ID then return true end
	if Teams[team]:IsAtWar(cteam) then
		--print("War True")
		return true
	end
	return false
end
--===================================================================================================================================================
-- Leugi_FloatingText(plot, text)
--===================================================================================================================================================
include("FLuaVector.lua");
function Leugi_FloatingText(plot, text)
	Events.AddPopupTextEvent(HexToWorld( ToHexFromGrid( Vector2( plot:GetX(), plot:GetY() ) ) ), text, 1)
end
--===================================================================================================================================================
-- HasTrait(player, traitID)
--===================================================================================================================================================
function HasTrait(player, traitID)
    local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
    local traitType  = GameInfo.Traits[traitID].Type
    for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
       return true
    end
    return false
end
--===================================================================================================================================================
-- tablerandom(tbl)
--===================================================================================================================================================
function tablerandom(tbl)
	local keys = {}
	for k in pairs(tbl) do
		table.insert(keys, k)
	end
	local randIndex = math.random(#keys)
	local randKey = keys[randIndex]
	return tbl[randKey]
end
--===================================================================================================================================================
-- Leugi_Notification(player, description, title, UnitIcon, plot)
--===================================================================================================================================================
function Leugi_Notification(player, description, title, UnitIcon, plot)
	if UnitIcon == nil or UnitIcon == -1 then
		if title == nil or title == -1 then title = "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]" end
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, title, -1, -1)
	else
		if player == Players[Game.GetActivePlayer()] then
			if plot == nil or plot == -1 then pX = -1; pY = -1; else pX = plot:GetX(); pY = plot:GetY() end
			player:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, description, title, pX, pY, UnitIcon, UnitIcon);
		end
	end
end
--===================================================================================================================================================
-- iModded(int)
--===================================================================================================================================================
iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)
function iModded(int)
	return math.ceil( int * iMod )
end
--===================================================================================================================================================
-- IsCPACtive()
--===================================================================================================================================================
function IsCPActive()
    local CPModID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if (mod.ID == CPModID) then
            return true
        end
    end
    return false
end
--===================================================================================================================================================
-- SetPolicy(player, policy, bool)
--===================================================================================================================================================
function SetPolicy(player, policy, bool)
	if bool == true then
		if player:HasPolicy(policy) == false then
			if IsCPActive() then
				player:GrantPolicy (policy, bool)
			else
				player:SetNumFreePolicies (1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy (policy, bool)
			end
		end
	end
	if bool == false then
		if player:HasPolicy(policy) == true then
			if IsCPActive() then
				player:GrantPolicy (policy, bool)
			else
				player:SetNumFreePolicies (1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy (policy, bool)
			end
		end
	end
end
--===================================================================================================================================================
-- Latino Event Stuff
--===================================================================================================================================================
--===================================================================================================================================================
-- IsLatino(player)
--===================================================================================================================================================
function IsLatino(player)
	local LatinoCivs = {}
	for row in DB.Query("SELECT CivilizationType FROM Civilization_JFD_CultureTypes WHERE SplashScreenTag = 'JFD_ColonialLatin'") do
		table.insert(LatinoCivs, row.CivilizationType)
	end
	for loop, iCiv in ipairs(LatinoCivs) do
		if player:GetCivilizationType() == GameInfoTypes["" .. iCiv .. ""] then
		 return true
		end
	end
	return false
end
--===================================================================================================================================================
function GetLibertador(player)
	CivType = GameInfo.Civilizations[player:GetCivilizationType()].Type
	iLibertadorID = GameInfoTypes["UNIT_PG_LIBERTADOR"]
	iUnits ={}
	for row in DB.Query("SELECT LibertadorType FROM Leugi_Independence WHERE CivilizationType = '" .. CivType .. "'") do
		--print("Checking Libertador for " .. CivType .. "")
		--print(row.LibertadorType)
		iLibertadorID = GameInfoTypes["" .. row.LibertadorType .. ""]
	end
	return iLibertadorID
end
--===================================================================================================================================================
function GetIndependenceUnits(player)
	CivType = GameInfo.Civilizations[player:GetCivilizationType()].Type
	iUUID = GameInfoTypes["UNIT_CAVALRY"]
	for row in DB.Query("SELECT SupportUnit FROM Leugi_Independence WHERE CivilizationType = '" .. CivType .. "'") do
		--print("Checking Units for " .. CivType .. "")
		--print(row.SupportUnit)
		iUUID = GameInfoTypes["" .. row.SupportUnit .. ""]
	end
	return iUUID
end
--===================================================================================================================================================

