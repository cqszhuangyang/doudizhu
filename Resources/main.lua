require("lua/card")

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

function init (  )
	c = card(10)
	local scenceGame = CCScene:create()
	c:setPosition(0,0)
	scenceGame:addChild(c)
	return 	scenceGame
end
function main( )
	-- body
	 scenceGame = init()
	-- CCDirector:sharedDirector():runWithScene(scenceGame)
	 CCTransitionRotoZoom:create(0.5,scenceGame)
	 CCDirector:sharedDirector():replaceScene(scenceGame)
end
xpcall(main, __G__TRACKBACK__)