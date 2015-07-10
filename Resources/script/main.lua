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
	math.randomseed(os.time())
		--设置环境变量
	local strRootDir =CCFileUtils:sharedFileUtils():fullPathForFilename("script")
	local strTmpPkgPath = package.path;
	local strSubDirs =
	{
		"scenes",
		"config",
		"dataPool",
		"util",
		"view"
	};
	for key, value in ipairs(strSubDirs) do
		local strOld = strTmpPkgPath;
		if(1 == key) then
			strTmpPkgPath = string.format("%s/%s/?.lua%s", strRootDir, value, strOld);
		else
			strTmpPkgPath = string.format("%s/%s/?.lua;%s", strRootDir, value, strOld);
		end
		strOld = nil;
	end
	package.path = string.format("%s/?.lua;%s", strRootDir, strTmpPkgPath);
	strTmpPkgPath = nil
	--require("scenes.loginScene")
	--loginScene.init();
	require("scenes.RoomScene")
	RoomScene.init()
	RoomScene.ready()


end
xpcall(main, __G__TRACKBACK__)

