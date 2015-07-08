---getpath
--package.path = 
--[[print(CCFileUtils:getWritablePath())
require("card")
function main( ... )
	local scenceGame = CCScene:create()
	scenceGame:addChild(card(10))
end]]--
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end
function  main(...)
	-- body
	local scence = 1
end
xpcall(main, __G__TRACKBACK__)

