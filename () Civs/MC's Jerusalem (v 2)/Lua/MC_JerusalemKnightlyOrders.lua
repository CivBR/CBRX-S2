tKnightlyOrders = {}
local sPlaceholder = "I shouldn't be here, report me as a bug."
print("loaded")
--------------------------
-- Hospitaller
--------------------------
local tHospitaller = {}
tHospitaller.ID = "Hospitaller"
tHospitaller.IconIndex = 3
tHospitaller.Banner = "HospitallerBanner.dds"
tHospitaller.Head = string.upper(Locale.ConvertTextKey("Knights Hospitaller"))
tHospitaller.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_ST_JOHN")
tHospitaller.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_ST_JOHN
tHospitaller.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_ST_JOHN
tHospitaller.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_ST_JOHN
tHospitaller.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_ST_JOHN
table.insert(tKnightlyOrders, tHospitaller)

--------------------------
-- St Lazarus
--------------------------
local tLazarus = {}
tLazarus.ID = "Lazarus"
tLazarus.IconIndex = 2
tLazarus.Banner = "LazarusBanner.dds"
tLazarus.Head = string.upper(Locale.ConvertTextKey("Order of Saint Lazarus"))
tLazarus.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_LAZARUS")
tLazarus.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_LAZARUS
tLazarus.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_LAZARUS
tLazarus.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_LAZARUS
tLazarus.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_LAZARUS
table.insert(tKnightlyOrders, tLazarus)

--------------------------
-- Holy Sepulchre
--------------------------
local tSepulchre = {}
tSepulchre.ID = "Sepulchre"
tSepulchre.IconIndex = 0
tSepulchre.Banner = "SepulchreBanner.dds"
tSepulchre.Head = string.upper(Locale.ConvertTextKey("Order of the"))
tSepulchre.Head2 = string.upper(Locale.ConvertTextKey("Holy Sepulchre"))
tSepulchre.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_SEPULCHRE")
tSepulchre.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_SEPULCHRE
tSepulchre.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_SEPULCHRE
tSepulchre.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_SEPULCHRE
tSepulchre.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_SEPULCHRE
table.insert(tKnightlyOrders, tSepulchre)

--------------------------
-- Teutonic Knights
--------------------------
local tTeutonic = {}
tTeutonic.ID = "Teutonic"
tTeutonic.IconIndex = 1
tTeutonic.Banner = "TeutonicBanner.dds"
tTeutonic.Head = string.upper(Locale.ConvertTextKey("Teutonic Order"))
tTeutonic.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_TEUTONIC")
tTeutonic.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_TEUTONIC
tTeutonic.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_TEUTONIC
tTeutonic.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_TEUTONIC
tTeutonic.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_TEUTONIC
table.insert(tKnightlyOrders, tTeutonic)

--------------------------
-- Knights Templar
--------------------------
local tTemplar = {}
tTemplar.ID = "Templar"
tTemplar.IconIndex = 4
tTemplar.Banner = "TemplarBanner.dds"
tTemplar.Head = string.upper(Locale.ConvertTextKey("Knights Templar"))
tTemplar.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_TEMPLARS")
tTemplar.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_TEMPLARS
tTemplar.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_TEMPLARS
tTemplar.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_TEMPLARS
tTemplar.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_TEMPLARS
table.insert(tKnightlyOrders, tTemplar)

local iPolicy = GameInfoTypes["POLICY_MC_CRUCIFORM_SWORD"]
--[[
function C15_CruciformListener(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasPolicy(iPolicy) then
		if tCruciform ~= nil then return end
		local tCruciform = {}
		tCruciform.ID = "Cruciform"
		tCruciform.IconIndex = 3
		tCruciform.Banner = "HospitallerBanner.dds"
		tCruciform.Head = string.upper(Locale.ConvertTextKey("Brotherhood of the Cruciform Sword"))
		tCruciform.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_CRUCIFORM")
		tCruciform.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_TEMPLARS
		tCruciform.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_TEMPLARS
		tCruciform.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_TEMPLARS
		tCruciform.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_TEMPLARS
		table.insert(tKnightlyOrders, tCruciform)
	end
end

GameEvents.PlayerDoTurn.Add(C15_CruciformListener)
]]
---------------------------
-- Cruciform Sword
---------------------------
local tCruciform = {}
tCruciform.ID = "Cruciform"
tCruciform.IconIndex = 5
tCruciform.Banner = "CruciformBanner.dds"
tCruciform.Head = string.upper(Locale.ConvertTextKey("Brotherhood of"))
tCruciform.Head2 = string.upper(Locale.ConvertTextKey("the Cruciform Sword"))
tCruciform.Body = Locale.ConvertTextKey("TXT_KEY_JERUSALEM_CRUCIFORM")
tCruciform.Dummy = GameInfoTypes.BUILDING_MC_JERUSALEM_CRUCIFORM
tCruciform.Building = GameInfoTypes.BUILDING_MC_JERUSALEM_CHAPTER_HOUSE_CRUCIFORM
tCruciform.Unit = GameInfoTypes.UNIT_MC_JERUSALEM_CRUSADER_CRUCIFORM
tCruciform.Promotion = GameInfoTypes.PROMOTION_MC_JERUSALEM_CRUCIFORM
tCruciform.Policy = iPolicy
table.insert(tKnightlyOrders, tCruciform)
--=======================================================================================================================
--=======================================================================================================================

local iCooldownCounter = GameInfoTypes["BUILDING_MC_JERUSALEM_COOLDOWN_COUNTER"]

function C15_ChangeOrder(pCity, iDummy)

    local bResetCounter = not pCity:IsHasBuilding(iDummy)
    local bIsHasChapterHouse = false

    for k, v in ipairs(tKnightlyOrders) do
        local i = 0
        if v.Dummy == iDummy then
            i = 1
        end
        pCity:SetNumRealBuilding(v.Dummy, i)
        if pCity:IsHasBuilding(v.Building) then bIsHasChapterHouse = true end
    end

    if bIsHasChapterHouse then
        for k, v in ipairs(tKnightlyOrders) do
            local i = 0
            if v.Dummy == iDummy then
                i = 1
            end
            pCity:SetNumRealBuilding(v.Building, i)
        end
    end

    if bResetCounter then
        pCity:SetNumRealBuilding(iCooldownCounter, 10)
    end
end
