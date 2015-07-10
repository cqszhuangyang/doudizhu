
module("RoomConfig", package.seeall)
local config = {}
config [1] = {playerNum=3,lastCardNum=3}

function getConfigByMode(mode)
	-- body
	if config[mode] then
		return config[mode]
	end 
end

MODE1 = 1--地主
