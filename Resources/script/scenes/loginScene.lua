
module("loginScene", package.seeall)
 local visibleSize = CCDirector:sharedDirector():getVisibleSize()
 --初始化
function  init()
	local scene = CCScene:create()
	scene:setAnchorPoint(CCPoint(0,0))
	local uiLayer = CCLayer:create()
	scene:setAnchorPoint(CCPoint(0,0))
    local uiSprite = createUI()
    uiLayer:addChild(uiSprite)
	scene:addChild(uiLayer)
	CCDirector:sharedDirector():runWithScene(scene)
end
--创建UI
function createUI()
	local uiSprite = CCScene:create()
	--设置背景
	local bgSprite = CCSprite:create("imageupdate/default.jpg")
    bgSprite:setAnchorPoint(CCPoint(0.5,0.5))
    bgSprite:setPosition(CCPoint(visibleSize.width/2,visibleSize.height/2))
    uiSprite:addChild(bgSprite)
   
    --设置文本框
     local sacel9SprY = CCScale9Sprite:create("skin/input.png")
    local textUserInput = CCEditBox:create(CCSizeMake(300,100),sacel9SprY)
    textUserInput:setAnchorPoint(CCPoint(0.5,0.5))
    textUserInput:setFont("黑体",24)
    textUserInput:setPosition(CCPoint(visibleSize.width/2,visibleSize.height/2))
    textUserInput:setReturnType(kKeyboardReturnTypeGo)
    --CCBUtt
    for k=1,53 do
		local sprite=CCSprite:create("card/card_1055.png")
		sprite:setAnchorPoint(CCPoint(0.5,0.5))
		sprite:setPosition(CCPoint(visibleSize.width/2,visibleSize.height*0.57-(k-1)*(sprite:getContentSize().height/108)))
		uiSprite:addChild(sprite,0)
	end
   -- GUIReader:shareReader():widgetFromJsonFile("ui/login.json")
    --[[
//设置输入标志，可以有如下的几种
    //kEditBoxInputFlagPassword:        密码形式输入
 
    //kEditBoxInputFlagSensitive:        敏感数据输入、存储输入方案且预测自动完成
 
    //kEditBoxInputFlagInitialCapsWord:     每个单词首字母大写,并且伴有提示
 
    //kEditBoxInputFlagInitialCapsSentence:   第一句首字母大写,并且伴有提示
 
    //kEditBoxInputFlagInitialCapsAllCharacters:所有字符自动大写
   editBox->setInputFlag(kEditBoxInputFlagPassword);
 
    //设置键盘中return键显示的字符，这个移植android的时候没有看出来
 
   editBox->setReturnType(kKeyboardReturnTypeGo);
 
  //包括这些选项
 
  //kKeyboardReturnTypeDefault: 默认使用键盘return 类型
 
    //kKeyboardReturnTypeDone:   默认使用键盘return类型为“Done”字样
 
    //kKeyboardReturnTypeSend:   默认使用键盘return类型为“Send”字样
 
    //kKeyboardReturnTypeSearch:  默认使用键盘return类型为“Search”字样
 
    //kKeyboardReturnTypeGo:    默认使用键盘return类型为“Go”字样
 
    ]]--
    uiSprite:addChild(textUserInput)
	return uiSprite
end