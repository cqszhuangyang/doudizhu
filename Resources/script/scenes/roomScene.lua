 
module("RoomScene", package.seeall)
require("config.RoomConfig")
 local scene = nil
 local uiLayer = nil;  -- UI层
 local sendLayer = nil; -- 发牌层
 local deskLayer = nil; -- 桌子
 local visibleSize = CCDirector:sharedDirector():getVisibleSize()
 local playerNum = 3
 local sendTable={}
 local roomConfig = nil
 local playerSet,lastCardSet = nil
 --初始化场景
 function  init()
	scene = CCScene:create()
	scene:setAnchorPoint(CCPoint(0,0))
	scene:setAnchorPoint(CCPoint(0,0))
    createUI()
	CCDirector:sharedDirector():runWithScene(scene)
	roomConfig = RoomConfig.getConfigByMode(RoomConfig.MODE1)
end
--创建UI
function createUI()
	bgLayer = CCLayer:create()
	--设置房间背景
	local bgSprite = CCSprite:create("room/beijing.jpg")
    bgSprite:setAnchorPoint(CCPoint(0.5,0.5))
    bgSprite:setPosition(CCPoint(visibleSize.width/2,visibleSize.height/2))
    bgLayer:addChild(bgSprite)
    --发牌层
    sendLayer = CCLayer:create()
    --桌子层
    deskLayer = CCLayer:create()
	scene:addChild(bgLayer)
	scene:addChild(sendLayer)
	scene:addChild(deskLayer)
end

--开始游戏
function ready()
    require("dataPool.AiData")
    require("config.CardConfig")
    playerSet,lastCardSet = AiData.shuffleCardMode1(roomConfig.playerNum,roomConfig.lastCardNum)
    local packCard = CardConfig.getAllPackCard()
    for k=1,#packCard do
		local sprite=CCSprite:create("card/card_1055.png")
		sprite:setAnchorPoint(CCPoint(0.5,0.5))
		sprite:setPosition(CCPoint(visibleSize.width/2,visibleSize.height*0.57-(k-1)*(sprite:getContentSize().height/108)))
	    sendLayer:addChild(sprite,0)
	end
	sendTable.sendIndex = 1
	sendTable.player = 1


    --发牌之前对自己的牌进行排序
    local cardSet = playerSet[1]
    table.sort( cardSet, CardConfig.cardSort)
    cardSet = playerSet[2]
    table.sort( cardSet, CardConfig.cardSort)
     cardSet = playerSet[3]
    table.sort( cardSet, CardConfig.cardSort)
	--开始发牌
    runSendAction()
end

local showAll = true
  --[[
    1 发牌结束等待 叫地主
    2 发牌叫地主结束开始游戏
  ]]--
 function sendEnd()
    local viewClass = require("view.landlordView")
    view = viewClass:new()
    layer = view:create()
    scene:addChild(layer)
 -- print(movePos.x,movePos.y,speed)
  --spriteMoveAction(sprite,movePos,speed,showover
  
end;

--[[
    地主牌动画
]]--
local playLandLoardCardIndex = -1
function playLandLordCard()
  if playLandLoardCardIndex > 1 then
  	 --print("playLandLordCard over")
  	 sendEnd()
  	 return
  end
  -- body
  local pChildren = sendLayer:getChildren();
  local sprite =  pChildren:objectAtIndex(pChildren:count()-1);
 local x, y = sprite:getPosition()
  cardWidth = sprite:getContentSize().width;
  cardHeight = sprite:getContentSize().height;
  local movePos=CCPoint(visibleSize.width/2,visibleSize.height/2)
  movePos.x = movePos.x + playLandLoardCardIndex*(cardWidth+ cardWidth*0.2);
  local speedLenth= cardWidth*5
   local speed=math.abs(movePos.x-visibleSize.width/2)/speedLenth
  if playLandLoardCardIndex==0 then
  	speedLenth= cardHeight*3
  	speed = math.abs(movePos.y-y)/speedLenth
  end
  spriteMoveAction(sprite,movePos,speed,playLandlordCardEnd)
end


function playLandlordCardEnd(node)
  playLandLoardCardIndex =playLandLoardCardIndex +1
  sendTable.sendIndex = sendTable.sendIndex + 1;
  sendLayer:removeChild(node,false)
  deskLayer:addChild(node,0)

  playLandLordCard()

end
--[[
    地主牌动画 ending===========================
]]--


function sequence(actions)
	if #actions<1 then return end
	if #actions<2 then return actions[1] end
	local prev = actions[1]
	for i=2 ,#actions do
		prev = CCSequence:createWithTwoActions(prev,actions[i])
	end
	return prev
end

--[[
    发牌动画
]]--
--开始发牌
function runSendAction()

    if sendTable.sendIndex > #playerSet[sendTable.player] then
      sendTable.player = sendTable.player + 1
      sendTable.sendIndex = 1
    end  
    if sendTable.player > roomConfig.playerNum then 
        --发牌结束
        --播放地主牌动画
    	playLandLordCard()
    	return 
    end
    sprite =  sendLayer:getChildren():objectAtIndex(sendLayer:getChildren():count()-1);
	local x, y = sprite:getPosition()
	local movePos=CCPoint(visibleSize.width*0.9,visibleSize.height*0.1)
	local speedLenth= visibleSize.width*5
	local speed=math.abs(movePos.y-y)/speedLenth
	cardWidth = sprite:getContentSize().width;
  	cardHeight = sprite:getContentSize().height;
	movePos.x=(visibleSize.width*0.9-sendTable.sendIndex*(cardWidth/3))
	if sendTable.player==2 then
		movePos=CCPoint(visibleSize.width*0.9,visibleSize.height*0.5)
	    if showAll then
			movePos.y=(visibleSize.height*0.9 - sendTable.sendIndex*(cardHeight/5))
	    end 
		speed=math.abs(movePos.x-x)/speedLenth
	elseif sendTable.player==3 then
		movePos=CCPoint(visibleSize.width*0.1,visibleSize.height*0.5)
		if showAll then
			movePos.y=(visibleSize.height*0.9 - sendTable.sendIndex*(cardHeight/5))
	    end 
		speed=math.abs(movePos.x-x)/speedLenth
	end
	spriteMoveAction(sprite,movePos,speed,sendOnceEnd)
end;

---播放发牌动画
function  spriteMoveAction(sprite,movePos,speed,fun)
	local moveAct = CCMoveTo:create(speed,movePos);
	moveAct=CCSequence:createWithTwoActions(moveAct, CCCallFuncN:create(fun))
	sprite:runAction(moveAct)
end;
--一次发牌结束
function sendOnceEnd(node)
  local x,y =node:getPosition()
  sendLayer:removeChild(node,false)
  if sendTable.player == 1 or showAll then
    local cardSet = playerSet[sendTable.player]
    local cardIndex = cardSet[sendTable.sendIndex]

    local cardInfo = CardConfig.getCardInfoByIndex(cardIndex)
    local sprite =  createSigleCard(cardInfo)
    sprite:setPosition(x,y)
    if sendTable.player == 1 then 
         deskLayer:addChild(sprite,#playerSet[sendTable.player]-sendTable.sendIndex) 
    else 
    	 deskLayer:addChild(sprite,0) 
   end
  else
  	deskLayer:addChild(node,0)
  end
  sendTable.sendIndex = sendTable.sendIndex + 1;
  runSendAction()
end
--[[
    发牌动画 ending
]]--

function createSigleCard(cardInfo)
	if cardInfo then
		local imgPath=string.format("card/%s.png",cardInfo.HeadIcon)
		local sprite=CCSprite:create(imgPath)
		sprite:setAnchorPoint(CCPoint(0.5,0.5))
		return sprite
    end
end