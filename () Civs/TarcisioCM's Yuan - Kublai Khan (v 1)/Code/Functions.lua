include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "Tar_Yuan";
--______________________________________________________________________________________________________
--Defines
local civilization = GameInfoTypes["CIVILIZATION_TAR_YUAN"]
local sao = GameInfoTypes["UNIT_TAR_SAO"]
local yuanUB = GameInfoTypes["BUILDING_TAR_SECRETARIAT"]
--______________________________________________________________________________________________________
--Yuan Trait

local tTechs = {}
for row in GameInfo.Technologies() do
	tTechs[row.ID] = Locale.ConvertTextKey(row.Description)
end

function YuanTrait(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilization then
		local team = Teams[player:GetTeam()]
		if team:GetAtWarCount(true) > 0 then
			local enemyList = {}
			local teamTechs = team:GetTeamTechs()
			local targetTech
			local scienceYield
			for enemyID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
				local enemy = Players[enemyID]	
				if enemy ~= nil and enemy ~= player and not(enemy:IsMinorCiv()) and not(enemy:IsBarbarian()) and Teams[enemy:GetTeam()]:IsAtWar(player:GetTeam()) then	
					local enemyTechs = Teams[enemy:GetTeam()]:GetTeamTechs()
					table.insert(enemyList, enemyID)
					local LastTechReminder = load(player, "Yuan_RememberTech")
					if LastTechReminder and not(teamTechs:HasTech(LastTechReminder)) and enemyTechs:HasTech(LastTechReminder) then
						targetTech = LastTechReminder
						print("reminded")
					else
						targetTech = enemy:GetCurrentResearch()
						print("not 1")
						if teamTechs:HasTech(targetTech) then
							 --[[for row in GameInfo.Technologies() do
						        if not(teamTechs:HasTech(row.ID)) and enemyTechs:HasTech(row.ID) then
									targetTech = row.ID
									print("not 2")
						        	break
						        end
						    end]]
							for k, v in pairs(tTechs) do
								if not (teamTechs:HasTech(k)) and enemyTechs:HasTech(k) then
									targetTech = k
									print("not 2")
									break
								end
							end
						end
					end
					if not(teamTechs:HasTech(targetTech)) then
						scienceYield = math.ceil((enemy:GetScience() * 0.10) + (player:GetScience() * 0.15))
						print("add")
						break
					end
				end
			end
			if not(teamTechs:HasTech(targetTech)) then
				save(player, "Yuan_RememberTech", targetTech)
				print("save")
				teamTechs:ChangeResearchProgress(targetTech, scienceYield, playerID)
				if player:IsHuman() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_TAR_YUAN_C15_UA_TEXT", tTechs[targetTech], scienceYield))
				end
			else
				for key,enemyID in pairs(enemyList) do 
					local enemy = Players[enemyID]
					for city in enemy:Cities() do
						local damage = city:GetMaxHitPoints() * 0.13
						print("damage")
						city:ChangeDamage(damage)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(YuanTrait)

--______________________________________________________________________________________________________
function createdCopies(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	local player = Players[ownerId]
	local unit = player:GetUnitByID(unitId)
	local city = player:GetCityByID(cityId)
	if city then
		local fleetNum 
		local name
		if unit:GetUnitType() == sao then
			print("unitIsSao")
			fleetNum = load(player,"numFleets")
			if fleetNum == nil then fleetNum = 0 end
			fleetNum = fleetNum + 1

			name = fleetNum .. "th " .. unit:GetName() .. " Fleet"
			if fleetNum == 1 then
				name = "1st " .. unit:GetName() .. " Fleet"
			elseif fleetNum == 2 then
				name = "2nd " .. unit:GetName() .. " Fleet"
			elseif fleetNum == 3 then
				name = "3rd " .. unit:GetName() .. " Fleet"
			end
			unit:SetName(name)

			save(unit,"belongsto",fleetNum)
			save(player,"numFleets",fleetNum)
		end
		if unit:GetUnitType() == sao or city:IsHasBuilding(yuanUB) then
			local runTimes = 0
			local activeUB = false
			if city:IsHasBuilding(yuanUB) then
				print("cityHasYuanUB")
				local enemyMilitary = 0
				local yourMilitary = player:GetNumMilitaryUnits()
				for enemyID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
					local enemy = Players[enemyID]	
					if enemy ~= nil and enemy ~= player and not(enemy:IsBarbarian()) and Teams[enemy:GetTeam()]:IsAtWar(player:GetTeam()) then	
						print("enemyFojnd")
						enemyMilitary = enemyMilitary + enemy:GetNumMilitaryUnits()
					end
				end
				if enemyMilitary > yourMilitary then 
					activeUB = true 
					print("activateUB")
				end
			end
			if activeUB == true then runTimes = 1 end
			if unit:GetUnitType() == sao then runTimes = 2 end
			if unit:GetUnitType() == sao and city:IsHasBuilding(yuanUB) and activeUB == true then runTimes = 5 end
			print("run times: " .. runTimes)
			if runTimes > 0 then
				print("greater than zero")
				for i = 0, runTimes - 1 do
					print("iterating")
					local newUnit = player:InitUnit(unit:GetUnitType(), city:GetX(), city:GetY())
					for row in GameInfo.UnitPromotions() do
						if unit:IsHasPromotion(row.ID) then
							newUnit:SetHasPromotion(row.ID, true)
						end
					end
					local xp = unit:GetExperience()
					newUnit:ChangeExperience(xp)
					if unit:GetUnitType() == sao then
						print("sao, saving")
						newUnit:SetName(name)
						save(newUnit,"belongsto",fleetNum)
					end
				end
			end
		end
	end
end
GameEvents.CityTrained.Add(createdCopies)

local ignoreThis
function destroyCopies(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	local player = Players[unitOwnerId]
	local unit = player:GetUnitByID(unitId)
	if unit:GetUnitType() == sao then
		local fleetNum = load(unit,"belongsto")
		if not(ignoreThis == fleetNum) and fleetNum then
			for otherUnit in player:Units() do
				if unit ~= otherUnit and load(otherUnit,"belongsto") == fleetNum and otherUnit:GetUnitType() == sao then
					ignoreThis = fleetNum
					save(otherUnit,"belongsto",0)
					otherUnit:Kill(true)
				end
			end
		end
	end
end
GameEvents.UnitPrekill.Add(destroyCopies)
