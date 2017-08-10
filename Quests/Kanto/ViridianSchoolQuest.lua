-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Viridian School'
local description = 'from Route 1 to Route 2'

local dialogs = {
	jacksonDefeated = Dialog:new({
		"You will not take my spot!",
		"Sorry, the young boy there doesn't want to give his spot, I'm truly sorry..."
	})
}

local ViridianSchoolQuest = Quest:new()
function ViridianSchoolQuest:new()
	return Quest.new(ViridianSchoolQuest, name, description, 80, dialogs)
end

function ViridianSchoolQuest:isDoable()
	if  self:hasMap() then
		return true
	end
	return false
end

function ViridianSchoolQuest:isDone()
	return getMapName() == "Route 2" or getMapName() == "Route 22"
end

-- necessary, in case of black out we come back to the bedroom
function ViridianSchoolQuest:PlayerBedroomPallet()
	return moveToMap("Player House Pallet")
end

function ViridianSchoolQuest:PlayerHousePallet()
	return moveToMap("Link")
end

function ViridianSchoolQuest:PalletTown()
	return moveToMap("Route 1")
end

function ViridianSchoolQuest:Route1()
	return moveToMap("Route 1 Stop House")
end

function ViridianSchoolQuest:Route1StopHouse()
	return moveToMap("Viridian City")
end


function ViridianSchoolQuest:ViridianCity()
	if not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Viridian" then
		return moveToMap("Pokecenter Viridian")
	elseif  isNpcOnCell(57,61) then --Item: rare candy
		return talkToNpcOnCell(57,61)
	elseif hasItem("Marsh Badge") then
		return moveToMap("Route 22")
	else
		return moveToMap("Route 2")
	end
end


function ViridianSchoolQuest:PokecenterViridian()
	if game.minTeamLevel() >= 90 and getTeamSize() == 6 and not game.hasPokemonWithMove("Surf") then
		if isPCOpen() then
						if isCurrentPCBoxRefreshed() then
							if getCurrentPCBoxSize() ~= 0 then
								for pokemon=1, getCurrentPCBoxSize() do
									if getPokemonMoveNameFromPC(getCurrentPCBoxId(),pokemon,1) == "surf" or getPokemonMoveNameFromPC(getCurrentPCBoxId(),pokemon,2) == "surf" or getPokemonMoveNameFromPC(getCurrentPCBoxId(),pokemon,3) == "surf" or getPokemonMoveNameFromPC(getCurrentPCBoxId(),pokemon,4) == "surf" then
										log("Pokemon with surf found in pc")
										return swapPokemonFromPC(getCurrentPCBoxId(),pokemon,5)
									end
								end
							end
						else
							return
						end
		else
				return usePC()
		end
	end
	return self:pokecenter("Viridian City")
end

function ViridianSchoolQuest:ViridianPokemart()
	return self:pokemart("Viridian City")
end

return ViridianSchoolQuest