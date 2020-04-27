--[[
INSERT INTO Policies
		(Type,					Description)
VALUES	('POLICY_TAR_YUAN_GHS',	'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI'),
		('POLICY_TAR_CHAO',		'TXT_KEY_DECISIONS_TAR_CHAO');
		
INSERT INTO Policy_HurryModifiers
		(PolicyType,			HurryType,		HurryCostModifier)
VALUES	('POLICY_TAR_CHAO',		'HURRY_GOLD',	-25);

INSERT INTO BuildingClasses
		(Type,										DefaultBuilding,						Description)
VALUES	('BUILDINGCLASS_TAR_YUAN_GHS_SPECIALISTS',	'BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI'),
		('BUILDINGCLASS_TAR_YUAN_GHS_HOSPITAL',		'BUILDING_TAR_YUAN_GHS_HOSPITAL',		'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI'),
		('BUILDINGCLASS_TAR_YUAN_CHAO_MINT_NEG',	'BUILDING_TAR_YUAN_CHAO_MINT_NEG',		'TXT_KEY_DECISIONS_TAR_CHAO');
		
INSERT INTO Buildings
		(Type,									BuildingClass,								Description,							Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	IconAtlas,		PortraitIndex,	NeverCapture,	NukeImmune)
VALUES	('BUILDING_TAR_YUAN_GHS_HOSPITAL',		'BUILDINGCLASS_TAR_YUAN_GHS_HOSPITAL',		'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI',	-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1),
		('BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'BUILDINGCLASS_TAR_YUAN_GHS_SPECIALISTS',	'TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI',	-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1), -- Hm I suppose a query would've been better wouldn't it
		('BUILDING_TAR_YUAN_CHAO_MINT_NEG',		'BUILDINGCLASS_TAR_YUAN_CHAO_MINT_NEG',		'TXT_KEY_DECISIONS_TAR_CHAO',			-1,		-1,			-1,				NULL,		'BW_ATLAS_1',	13,				1,				1);
		
UPDATE Buildings
SET FreeBuildingThisCity = 'BUILDINGCLASS_HOSPITAL'
WHERE Type = 'BUILDING_TAR_YUAN_GHS_HOSPITAL';

INSERT INTO Building_SpecialistYieldChanges
		(BuildingType,							SpecialistType,			YieldType,		Yield)
VALUES	('BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'SPECIALIST_SCIENTIST',	'YIELD_FOOD',	1);

INSERT INTO Building_SpecialistYieldChanges
		(BuildingType,							SpecialistType,				YieldType,		Yield)
SELECT	'BUILDING_TAR_YUAN_GHS_SPECIALISTS',	'SPECIALIST_JFD_DOCTOR',	'YIELD_FOOD',	1
WHERE EXISTS (SELECT Type FROM Specialists WHERE Type = 'SPECIALIST_JFD_DOCTOR');

UPDATE Building_SpecialistYieldChanges
SET YieldType = 'YIELD_JFD_HEALTH'
WHERE BuildingType = 'BUILDING_TAR_YUAN_GHS_SPECIALISTS'
AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_JFD_HEALTH');

INSERT INTO Building_ResourceYieldChanges
		(BuildingType,							ResourceType,				YieldType,		Yield)
SELECT	'BUILDING_TAR_YUAN_CHAO_MINT_NEG',		ResourceType,				YieldType,		Yield * -1
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_MINT';

CREATE TRIGGER Tar_Yuan_JFD_Specialist_Added
AFTER INSERT ON Specialists
WHEN NEW.Type = 'SPECIALIST_JFD_DOCTOR'
BEGIN
	INSERT INTO Building_SpecialistYieldChanges
			(BuildingType,							SpecialistType,	YieldType,																														Yield)
	VALUES	('BUILDING_TAR_YUAN_GHS_SPECIALISTS',	NEW.Type,		(CASE WHERE EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_JFD_HEALTH') THEN 'YIELD_JFD_HEALTH' ELSE 'YIELD_FOOD' END),	1);
END;


CREATE TRIGGER Tar_Yuan_JFD_Yield_Added
AFTER INSERT ON Yields
WHEN NEW.Type = 'YIELD_JFD_HEALTH'
BEGIN
	UPDATE Building_SpecialistYieldChanges
	SET YieldType = NEW.Type
	WHERE BuildingType = 'BUILDING_TAR_YUAN_GHS_SPECIALISTS';
END;

-- Fukin rip Policy_SpecialistExtraYields tbh

CREATE TRIGGER Tar_Yuan_Mint_Resource_Added
AFTER INSERT ON Building_ResourceYieldChanges
WHEN NEW.BuildingType = 'BUILDING_MINT'
BEGIN
	INSERT INTO Building_ResourceYieldChanges
			(BuildingType,							ResourceType,				YieldType,		Yield)
	VALUES	('BUILDING_TAR_YUAN_CHAO_MINT_NEG',		NEW.ResourceType,			NEW.YieldType,	NEW.Yield * -1);
END;

--===========================================================================================

<GameDefines>
	<Language_en_US>
		<Row Tag="TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI">
			<Text>Establish the Guang Hui Si</Text>
		</Row>
		<Row Tag="TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI_DESC">
			<Text>
				Those Muslads are good at doctoring and shit, what if we put a whole bunch of them in a big building with a bunch of sick people?[NEWLINE]
				[NEWLINE]Requirement/Restrictions:
				[NEWLINE][ICON_BULLET]Player must be Yuan
				[NEWLINE][ICON_BULLET]Player must have discovered the Education technology
				[NEWLINE][ICON_BULLET]May only be enacted once per game
				[NEWLINE][ICON_BULLET]Must have a {3_Religion} Religion
				[NEWLINE]Costs:
				[NEWLINE][ICON_BULLET]{1_Gold} [ICON_GOLD] Gold
				[NEWLINE][ICON_BULLET]{2_Faith} [ICON_PEACE] FaithCost
				[NEWLINE][ICON_BULLET]2 [ICON_MAGISTRATES] Magistrates
				[NEWLINE]Rewards:
				[NEWLINE][ICON_BULLET]{5_Specialists} Specialists yield +1 {4_Yield} in all Cities
				[NEWLINE][ICON_BULLET]Receive a free Hospital in all Cities that don't follow your {3_Religion} Religion
			</Text>
		</Row>
		<Row Tag="TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI_DESC_ENACTED">
			<Text>
				Those Muslads are good at doctoring and shit, what if we put a whole bunch of them in a big building with a bunch of sick people?[NEWLINE]
				[NEWLINE]Rewards:
				[NEWLINE][ICON_BULLET]{3_Specialists} Specialists yield +1 {2_Yield} in all Cities
				[NEWLINE][ICON_BULLET]Receive a free Hospital in all Cities that don't follow your {1_Religion} Religion
			</Text>
		</Row>
		<Row Tag="TXT_KEY_DECISIONS_TAR_CHAO">
			<Text>Establish the Chao Currency</Text>
		</Row>
		<Row Tag="TXT_KEY_DECISIONS_TAR_CHAO_DESC">
			<Text>
				Let's replace actual valuable metal money with paper. Idk how this works but apparently it does...
				[NEWLINE]Requirement/Restrictions:
				[NEWLINE][ICON_BULLET]Player must be Yuan
				[NEWLINE][ICON_BULLET]Player must have discovered the Banking technology
				[NEWLINE][ICON_BULLET]May only be enacted once per game
				[NEWLINE][ICON_BULLET]Must have at least one Mint
				[NEWLINE]Costs:
				[NEWLINE][ICON_BULLET]{1_Culture} [ICON_CULTURE] Culture
				[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrate
				[NEWLINE]Rewards:
				[NEWLINE][ICON_BULLET]Yield Bonuses on Resources from Mints removed
				[NEWLINE][ICON_BULLET]Cost of [ICON_GOLD] Gold Purchasing in all Cities reduced by 25%
			</Text>
		</Row>
		<Row Tag="TXT_KEY_DECISIONS_TAR_CHAO_DESC_ENACTED">
			<Text>
				Let's replace actual valuable metal money with paper. Idk how this works but apparently it does...
				[NEWLINE]Rewards:
				[NEWLINE][ICON_BULLET]Yield Bonuses on Resources from Mints removed
				[NEWLINE][ICON_BULLET]Cost of [ICON_GOLD] Gold Purchasing in all Cities reduced by 25%
			</Text>
		</Row>
	</Language_en_US>
</GameDefines>
]]
--===========================================================================================

local civilizationID = GameInfoTypes["CIVILIZATION_TAR_YUAN"]
local iHospitalGiver = GameInfoTypes["BUILDING_TAR_YUAN_GHS_HOSPITAL"]
local iHospital = GameInfoTypes["BUILDING_HOSPITAL"]
local iSpecialistPolicy = GameInfoTypes["POLICY_TAR_YUAN_GHS"]
local iEdu = GameInfoTypes["TECH_EDUCATION"]
local iSpecialistDummy = GameInfoTypes["BUILDING_TAR_YUAN_GHS_SPECIALISTS"]

local iMint = GameInfoTypes["BUILDING_MINT"]
local iMintClass = GameInfoTypes["BUILDINGCLASS_MINT"]
local iMintDummy = GameInfoTypes["BUILDING_TAR_YUAN_CHAO_MINT_NEG"]
local iChaoPolicy = GameInfoTypes["POLICY_TAR_CHAO"]
local iBanking = GameInfoTypes["TECH_BANKING"]

function Game.GetUserSetting(type)
    for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
        return row.Value
    end
end
local userSettingRTPPietyCore = (Game.GetUserSetting("JFD_RTP_PIETY_CORE") == 1)
local bHealth = (Game.GetUserSetting("JFD_CID_HEALTH_CORE") == 1)

local Decisions_Tar_GuangHuiSi = {}
	Decisions_Tar_GuangHuiSi.Name = "TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI"
	Decisions_Tar_GuangHuiSi.Desc = "TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI_DESC"
	HookDecisionCivilizationIcon(Decisions_Tar_GuangHuiSi, "CIVILIZATION_TAR_YUAN")
	Decisions_Tar_GuangHuiSi.CanFunc = (
	function(pPlayer)
		local sReligion = "Majority"
		if userSettingRTPPietyCore then
			sReligion = "State"
		end
		local sYield = "[ICON_FOOD] Food"
		local sSpecialists = "Scientist"
		if bHealth then
			sYield = "[ICON_JFD_HEALTH] Health"
			sSpecialists = "Scientist and Doctor"
		end
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if pPlayer:HasPolicy(iSpecialistPolicy) then
			Decisions_Tar_GuangHuiSi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI_DESC_ENACTED", sReligion, sYield, sSpecialists)
			return false, false, true
		end
		local iReligion = GetPlayerMajorityReligion(pPlayer) or -1
		if userSettingRTPPietyCore then
			iReligion = pPlayer:GetStateReligion()
		end
		local iNumCities = 0
		for pCity in pPlayer:Cities() do
			if pCity:GetReligiousMajority() ~= iReligion then
				iNumCities = iNumCities + 1
			end
		end
		local iGold = 800 * iMod
		local iFaith = 200 * iMod * iNumCities
		Decisions_Tar_GuangHuiSi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAR_GUANG_HUI_SI_DESC", iGold, iFaith, sReligion, sYield, sSpecialists)
        if (not Teams[pPlayer:GetTeam()]:IsHasTech(iEdu)) then return true, false end
        if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if iNumCities == 0 then return true, false end
		if iReligion <= 0 then return true, false end
		if pPlayer:GetGold() < iGold then return true, false end
		if pPlayer:GetFaith() < iFaith then return true, false end
		
		return true, true
	end
	)
	
	Decisions_Tar_GuangHuiSi.DoFunc = (
	function(pPlayer)
		local iReligion = GetPlayerMajorityReligion(pPlayer)
		if userSettingRTPPietyCore then
			iReligion = pPlayer:GetStateReligion()
		end
		local tCities = {}
		for pCity in pPlayer:Cities() do
			if pCity:GetReligiousMajority() ~= iReligion then
				table.insert(tCities, pCity)
			end
		end
		local iGold = 800 * iMod
		local iFaith = 200 * iMod * #tCities
        pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
        pPlayer:ChangeGold(-iGold)
        pPlayer:ChangeFaith(-iFaith)
		if Player.GrantPolicy then
			pPlayer:GrantPolicy(iSpecialistPolicy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iSpecialistPolicy, true)
		end
		pPlayer:GetCapitalCity():SetNumRealBuilding(iSpecialistDummy, 1)
		for k, v in ipairs(tCities) do
			v:SetNumRealBuilding(iHospitalGiver, 1)
		end
	end
	)
	
	Decisions_Tar_GuangHuiSi.Monitors = {}
	Decisions_Tar_GuangHuiSi.Monitors[GameEvents.PlayerDoTurn] = (
	function(playerID)
		local pPlayer = Players[playerID]
		if pPlayer:HasPolicy(iSpecialistPolicy) and pPlayer:IsAlive() then
			local iReligion = GetPlayerMajorityReligion(pPlayer)
			if userSettingRTPPietyCore then
				iReligion = pPlayer:GetStateReligion()
			end
			for pCity in pPlayer:Cities() do
				if pCity:IsCapital() then
					pCity:SetNumRealBuilding(iSpecialistDummy, 1)
				else
					pCity:SetNumRealBuilding(iSpecialistDummy, 0)
				end
				if pCity:GetReligiousMajority() == iReligion then
					pCity:SetNumRealBuilding(iHospitalGiver, 0)
					pCity:SetNumRealBuilding(iHospital, 0)
				else
					pCity:SetNumRealBuilding(iHospitalGiver, 1)
				end
			end
		end
	end
	)
	Decisions_Tar_GuangHuiSi.Monitors[GameEvents.CityCaptureComplete] = (
	function(oldPlayerID, bCap)
		local pPlayer = Players[playerID]
		if pPlayer:HasPolicy(iSpecialistPolicy) and bCap and pPlayer:IsAlive() then
			local pCap = pPlayer:GetCapitalCity()
			if pCap then
				pCap:SetNumRealBuilding(iSpecialistDummy, 1)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_Tar_GuangHuiSi", Decisions_Tar_GuangHuiSi)

local Decisions_Tar_Chao = {}
	Decisions_Tar_Chao.Name = "TXT_KEY_DECISIONS_TAR_CHAO"
	Decisions_Tar_Chao.Desc = "TXT_KEY_DECISIONS_TAR_CHAO_DESC"
	HookDecisionCivilizationIcon(Decisions_Tar_Chao, "CIVILIZATION_TAR_YUAN")
	Decisions_Tar_Chao.CanFunc = (
	function(pPlayer)
		local iMintCount = pPlayer:GetBuildingClassCount(iMintClass)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if pPlayer:HasPolicy(iChaoPolicy) then
			Decisions_Tar_Chao.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAR_CHAO_DESC_ENACTED")
			return false, false, true
		end
		local iCultureCost = pPlayer:GetGold()
		local iCultureStored = pPlayer:GetJONSCulture()
		--[[if iCultureCost > iCultureStored then -- wtf am I even doing here...
			iCultureCost = math.floor(iCultureCost - (iCultureCost - iCultureStored) / 2)
		end]]
		
		Decisions_Tar_Chao.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAR_CHAO_DESC", iCultureCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if iCultureCost > iCultureStored then return true, false end
		if not Teams[pPlayer:GetTeam()]:IsHasTech(iBanking) then return true, false end
		if iMintCount <= 0 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_Tar_Chao.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeJONSCulture(-pPlayer:GetGold())	
		if Player.GrantPolicy then
			pPlayer:GrantPolicy(iChaoPolicy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iChaoPolicy, true)
		end
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iMint) then
				pCity:SetNumRealBuilding(iMintDummy, 1)
			else
				pCity:SetNumRealBuilding(iMintDummy, 0)
			end
		end
	end
	)
	
	Decisions_Tar_Chao.Monitors = {}
	Decisions_Tar_Chao.Monitors[GameEvents.PlayerDoTurn] = (
	function(playerID)
		local pPlayer = Players[playerID]
		if pPlayer:IsAlive() and pPlayer:HasPolicy(iChaoPolicy) then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iMintDummy) then
					pCity:SetNumRealBuilding(iMintDummy, 1)
				else
					pCity:SetNumRealBuilding(iMintDummy, 0)
				end
			end
		end
	end
	)
	
	--[[Decisions_Tar_Chao.Monitors[GameEvents.CityCaptureComplete] = ( -- I'd play around with this stuff but since I crbf to test I won't risk it :p
	function(oldPlayerID, bCap, iX, iY, iNewPlayerID)
		Decisions_Tar_Chao.Monitors[GameEvents.PlayerDoTurn](iNewPlayerID)
	end
	)
	
	Decisions_Tar_Chao.Monitors[GameEvents.CityConstructed] = (
	function(playerID, cityID, iBuilding)
		if iBuilding == iMint then
			Decisions_Tar_Chao.Monitors[GameEvents.PlayerDoTurn](playerID)
		end
	end
	)
	
	Decisions_Tar_Chao.Monitors[GameEvents.CitySoldBuilding] = Decisions_Tar_Chao.Monitors[GameEvents.CityConstructed]
	]]

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_Tar_Chao", Decisions_Tar_Chao)

	
	
