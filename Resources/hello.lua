require "AudioEngine" 

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
    -- avoid memory leak 这是脚本回收参数，避免内存泄漏
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    local cclog = function(...)
        print(string.format(...))
    end

    -- 类似c++的include，引入文件，会检查是否重复引入  
    require "hello2"
    cclog("result is " .. myadd(3, 5))

    ---------------
    -- 获取可视区域  
    local visibleSize = CCDirector:sharedDirector():getVisibleSize()
    -- 可视原点坐标 OpenGL坐标系，左下角为原点  
    local origin = CCDirector:sharedDirector():getVisibleOrigin()

     -- add the moving dog 添加移动的小松鼠 
    local function creatDog()
        --每一帧尺寸设置，local表示局部变量  
        local frameWidth = 105
        local frameHeight = 95

        -- create dog animate 加载动画资源并创建精灵帧  
        -- 加载精灵动画所在纹理 
        local textureDog = CCTextureCache:sharedTextureCache():addImage("dog.png")
        -- 设置第一帧帧区域 
        local rect = CCRectMake(0, 0, frameWidth, frameHeight)
           -- 创建第一帧精灵Frame
        local frame0 = CCSpriteFrame:createWithTexture(textureDog, rect)
        -- 设置第二帧帧区域
        rect = CCRectMake(frameWidth, 0, frameWidth, frameHeight)
        -- c创建第二帧精灵Frame  
        local frame1 = CCSpriteFrame:createWithTexture(textureDog, rect)
        -- 基于使用第一帧Frame创建Sprite对象
        local spriteDog = CCSprite:createWithSpriteFrame(frame0)
        spriteDog.isPaused = false
        spriteDog:setPosition(origin.x, origin.y + visibleSize.height / 4 * 3)
        local animFrames = CCArray:create()
        animFrames:addObject(frame0)
        animFrames:addObject(frame1)

    -- 根据帧序列数组创建一个动画animation。帧间隔时间delay等于0.5秒  
        local animation = CCAnimation:createWithSpriteFrames(animFrames, 0.5)
          -- 根据动画animation创建动作实例
        local animate = CCAnimate:create(animation);
        -- 松鼠精灵执行该动作 
        spriteDog:runAction(CCRepeatForever:create(animate))

         -- moving dog at every frame 用来更新松鼠的位置，后面会调用该函数
        local function tick()
            if spriteDog.isPaused then return end
            local x, y = spriteDog:getPosition()
            if x > origin.x + visibleSize.width then
                x = origin.x
            else
                x = x + 1
            end

            spriteDog:setPositionX(x)
        end
       -- 生成一个scheule,每帧执行tick函数  
        CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(tick, 0, false)

        return spriteDog
    end

    -- create farm 创建地面的农场  
    local function createLayerFarm()
        local layerFarm = CCLayer:create()

        -- add in farm background 添加农场管理  
        local bg = CCSprite:create("farm.jpg")
        bg:setPosition(origin.x + visibleSize.width / 2 + 80, origin.y + visibleSize.height / 2)
        layerFarm:addChild(bg)

        -- add land sprite 添加地面砖块  

        for i = 0, 3 do
            for j = 0, 1 do
                local spriteLand = CCSprite:create("land.png")
                spriteLand:setPosition(200 + j * 180 - i % 2 * 90, 10 + i * 95 / 2)
                layerFarm:addChild(spriteLand)
            end
        end

        -- add crop 添加庄稼，注意crop.png是多张图的合成贴图，所以只取了里面的部分贴图
        local frameCrop = CCSpriteFrame:create("crop.png", CCRectMake(0, 0, 105, 95))
        for i = 0, 3 do
            for j = 0, 1 do
                local spriteCrop = CCSprite:createWithSpriteFrame(frameCrop);
                spriteCrop:setPosition(10 + 200 + j * 180 - i % 2 * 90, 30 + 10 + i * 95 / 2)
                layerFarm:addChild(spriteCrop)
            end
        end

        -- add moving dog 调用上面的createDog()方面，创建一个移动的松鼠 
        local spriteDog = creatDog()
        layerFarm:addChild(spriteDog)

        -- handing touch events 手指触摸事件处理  
        local touchBeginPoint = nil

        local function onTouchBegan(x, y)
            cclog("onTouchBegan: %0.2f, %0.2f", x, y)
            touchBeginPoint = {x = x, y = y}
            spriteDog.isPaused = true
            -- CCTOUCHBEGAN event must return true
            return true
        end

        local function onTouchMoved(x, y)
            cclog("onTouchMoved: %0.2f, %0.2f", x, y)
            if touchBeginPoint then
                local cx, cy = layerFarm:getPosition()
                layerFarm:setPosition(cx + x - touchBeginPoint.x,
                                      cy + y - touchBeginPoint.y)
                touchBeginPoint = {x = x, y = y}
            end
        end

        local function onTouchEnded(x, y)
            cclog("onTouchEnded: %0.2f, %0.2f", x, y)
            touchBeginPoint = nil
            spriteDog.isPaused = false
        end

        local function onTouch(eventType, x, y)
            if eventType == "began" then   
                return onTouchBegan(x, y)
            elseif eventType == "moved" then
                return onTouchMoved(x, y)
            else
                return onTouchEnded(x, y)
            end
        end

        layerFarm:registerScriptTouchHandler(onTouch)
        layerFarm:setTouchEnabled(true)

        return layerFarm
    end


   -- create menu 创建界面菜单  
    local function createLayerMenu()
         -- 创建一个新的Layer管理所有菜单  

        local layerMenu = CCLayer:create()

        local menuPopup, menuTools, effectID
    -- 点击菜单回调函数  
        local function menuCallbackClosePopup()
            -- stop test sound effect
            AudioEngine.stopEffect(effectID)
            menuPopup:setVisible(false)
        end

        local function menuCallbackOpenPopup()
            -- loop test sound effect
            local effectPath = CCFileUtils:sharedFileUtils():fullPathForFilename("effect1.wav")
            effectID = AudioEngine.playEffect(effectPath)
            menuPopup:setVisible(true)
        end

        -- add a popup menu 创建弹出的菜单面板  

        local menuPopupItem = CCMenuItemImage:create("menu2.png", "menu2.png")
        menuPopupItem:setPosition(0, 0)
        menuPopupItem:registerScriptTapHandler(menuCallbackClosePopup)
        menuPopup = CCMenu:createWithItem(menuPopupItem)
        menuPopup:setPosition(origin.x + visibleSize.width / 2, origin.y + visibleSize.height / 2)
        menuPopup:setVisible(false)
        layerMenu:addChild(menuPopup)

        -- add the left-bottom "tools" menu to invoke menuPopup
        local menuToolsItem = CCMenuItemImage:create("menu1.png", "menu1.png")
        menuToolsItem:setPosition(0, 0)
        -- 注册点击回调地址  
        menuToolsItem:registerScriptTapHandler(menuCallbackOpenPopup)
        menuTools = CCMenu:createWithItem(menuToolsItem)
        local itemWidth = menuToolsItem:getContentSize().width
        local itemHeight = menuToolsItem:getContentSize().height
        menuTools:setPosition(origin.x + itemWidth/2, origin.y + itemHeight/2)
        layerMenu:addChild(menuTools)

        return layerMenu
    end

    -- play background music, preload effect

    -- uncomment below for the BlackBerry version
    -- local bgMusicPath = CCFileUtils:sharedFileUtils():fullPathForFilename("background.ogg")
    local bgMusicPath = CCFileUtils:sharedFileUtils():fullPathForFilename("background.mp3")
    AudioEngine.playMusic(bgMusicPath, true)
    local effectPath = CCFileUtils:sharedFileUtils():fullPathForFilename("effect1.wav")
    AudioEngine.preloadEffect(effectPath)

    -- run
    local sceneGame = CCScene:create()-- 创建场景  

    sceneGame:addChild(createLayerFarm())-- 将农场层加入场景  

    sceneGame:addChild(createLayerMenu()) -- 将菜单界面层加入场景  

    CCDirector:sharedDirector():runWithScene(sceneGame)
end
--[[  
xpcall( 调用函数, 错误捕获函数 );  
lua提供了xpcall来捕获异常  
xpcall接受两个参数:调用函数、错误处理函数。  
当错误发生时,Lua会在栈释放以前调用错误处理函数,因此可以使用debug库收集错误相关信息。  
两个常用的debug处理函数:debug.debug和debug.traceback  
前者给出Lua的提示符,你可以自己动手察看错误发生时的情况;  
后者通过traceback创建更多的错误信息,也是控制台解释器用来构建错误信息的函数。  
--]]  
xpcall(main, __G__TRACKBACK__)
