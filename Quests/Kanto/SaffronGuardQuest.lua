-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Saffron Guard'
local description = 'Route 11 to Viridian City'
local level = 55

local SaffronGuardQuest = Quest:new()

function SaffronGuardQuest:new()
	local o = Quest.new(SaffronGuardQuest, name, description, level)
	o.BUY_BIKE = true
	return o
end

function SaffronGuardQuest:isDoable()
	if self:hasMap() and not hasItem("Marsh Badge") then
		return true
	end
	return false
end

function SaffronGuardQuest:isDone()
	if getMapName() == "Viridian City" or getMapName() == "Pokecenter Fuchsia" or getMapName() == "Route 6" then --Fix Blackout
		return true
	end
	return false
end

function SaffronGuardQuest:Route15()
	if isNpcOnCell(32,14) then --Item: Pecha Berry
		return talkToNpcOnCell(32,14)
	elseif isNpcOnCell(33,14) then --Item: Leppa Berry
		return talkToNpcOnCell(33,14)
	else
		return moveToMap("Route 14")
	end
end

function SaffronGuardQuest:Route14()
	if isNpcOnCell(21,38) then --Item: Lum Berry
		return talkToNpcOnCell(21,38)
	elseif isNpcOnCell(22,38) then --Item: Lum Berry
		return talkToNpcOnCell(22,38)
	else
		return moveToMap("Route 13")
	end
end

function SaffronGuardQuest:DiglettsCaveEntrance1()
	return moveToMap("Route 2")
end

function SaffronGuardQuest:DiglettsCave()
	return moveToMap("Digletts Cave Entrance 1")
end

function SaffronGuardQuest:DiglettsCaveEntrance2()
	return moveToMap("Digletts Cave")
end

function SaffronGuardQuest:Route11()
	if isNpcOnCell(10,13) then
		return talkToNpcOnCell(10,13)
	else
		return moveToMap("Digletts Cave Entrance 2")
	end
end

function SaffronGuardQuest:VermilionPokemart()
	self:pokemart("Vermilion City")
end

function SaffronGuardQuest:VermilionCity()
	if hasItem("Bike Voucher") then 
		return moveToMap("Route 6")
	else
		return moveToMap("Route 11")
	end
end

function SaffronGuardQuest:Route2()
	return moveToMap("Viridian City") or moveToMap("Route 2 Stop3")
end

function SaffronGuardQuest:Route2Stop3()
	return moveToCell(3,12)
end

function SaffronGuardQuest:Route6()
	if isNpcOnCell(31, 5) then -- Berry 1
		return talkToNpcOnCell(31, 5)
	elseif isNpcOnCell(32, 5) then -- Berry 2
		return talkToNpcOnCell(32, 5)
	elseif isNpcOnCell(37, 5) then -- Berry 3
		return talkToNpcOnCell(37, 5)
	elseif isNpcOnCell(38, 5) then -- Berry 4
		return talkToNpcOnCell(38, 5)
	else
		return moveToMap("Route 6 Stop House")
	end
end

function SaffronGuardQuest:Route6StopHouse()
	return moveToMap("Saffron City")
end

return SaffronGuardQuest