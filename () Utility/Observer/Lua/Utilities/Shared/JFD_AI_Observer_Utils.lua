-- JFD_AI_Observer_Utils
-- Author: JFD
-- DateCreated: 12/29/2016 4:59:53 PM
--==========================================================================================================================
-- MODS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCulDivActive
function Game_IsCulDivActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "31a31d1c-b9d7-45e1-842c-23232d66cd47" then
			return true
		end
	end
	return false
end
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
-- SETTINGS
--------------------------------------------------------------------------------------------------------------------------
--JFD_GetUserSetting
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--=======================================================================================================================
-- GENERAL UTILITIES
--=======================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
local mathCeil  = math.ceil
local mathFloor = math.floor
--------------------------------------------------------------------------------------------------------------------------
--Player_GetMajorityReligion
function Player_GetMajorityReligion(player)
	local religionID = -1
	if player:HasCreatedReligion() then
		religionID = player:GetReligionCreatedByPlayer()
		if religionID > -1 then
			return religionID
		end
		for row in GameInfo.Religions() do
			if player:HasReligionInMostCities(row.ID) then
				religionID = row.ID
				break
			end
		end
		if religionID > -1 then
			return religionID
		end
	end
	return religionID
end
--=======================================================================================================================
--=======================================================================================================================
