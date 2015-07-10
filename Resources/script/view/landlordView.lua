
require("util.GUI")

local  landlord ={ layer = nil}
 local visibleSize = CCDirector:sharedDirector():getVisibleSize()

function landlord:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
	    return o;
end

function landlord:create()
    layer=CCLayer:create()
    print("==============================================","create")
    local callBtn = GUI.creatButton("button/button_1011.png","button/button_1012.png")
    callBtn:setPosition(CCPoint(visibleSize.width/2-callBtn:getContentSize().width*1.5,visibleSize.height*0.45-callBtn:getContentSize().height))
    layer:addChild(callBtn)
    return layer
	-- if LandlordId ==tonumber(mPersonalInfo._userID) then
		-- landlordSprite=CCSprite:create("common/font_1002.png")
		-- landlordSprite:setAnchorPoint(CCPoint(0.5,0.5))
		-- landlordSprite:setPosition(CCPoint(pWinSize.width/2,pWinSize.height*0.55))
		-- layer:addChild(landlordSprite,0)

		-- local callBtn=ZyButton:new("button/button_1011.png","button/button_1012.png",nil)
		-- local path="button/panle_1046.png"
		-- if (not lastState or lastState ==0) and  ( not isRob or isRob==0)  then 
		-- 	path="button/button_1001.png"
		-- end
		-- callBtn:addImage(path)
		
		-- callBtn:addto(layer,0)
		-- callBtn:setPosition(CCPoint(pWinSize.width/2-callBtn:getContentSize().width*1.5,pWinSize.height*0.45-callBtn:getContentSize().height))
		-- callBtn:setTag(1)
		-- callBtn:registerScriptTapHandler(callLandLordAction)
		-- --
		-- local noCallBtn=ZyButton:new("button/button_1011.png","button/button_1012.png",nil)
		-- noCallPath="button/panle_1035.png"	
		-- if  (not lastState or lastState ==0) and  ( not isRob or isRob==0) then 
		-- 	 noCallPath="button/button_1002.png"
		-- end
		-- noCallBtn:addImage(noCallPath)
		-- noCallBtn:addto(layer,0)
		-- noCallBtn:setPosition(CCPoint(pWinSize.width/2+noCallBtn:getContentSize().width*0.5,callBtn:getPosition().y))
		-- noCallBtn:setTag(2)
		-- noCallBtn:registerScriptTapHandler(callLandLordAction)
	-- else
	--  	landlordSprite=CCLabelTTF:create(LandlordName or 0,FONT_NAME,FONT_BIG_SIZE)
	-- 	landlordSprite:setAnchorPoint(CCPoint(0.5,0.5))
	-- 	landlordSprite:setPosition(CCPoint(pWinSize.width/2,pWinSize.height*0.58))
	-- 	layer:addChild(landlordSprite,0)
	-- end
	
	-- local leftSprite=CCSprite:create(P("common/font_1001.png"))
	-- leftSprite:setAnchorPoint(CCPoint(1,0.5))
	-- leftSprite:setPosition(CCPoint(landlordSprite:getPosition().x-landlordSprite:getContentSize().width/2,landlordSprite:getPosition().y))
	-- layer:addChild(leftSprite,0)
	
	-- local rightImg=nil
	-- if   (not lastState or lastState ==0) and  ( not isRob or isRob==0) then
	-- 	rightImg="common/font_1003.png"
	-- else	
	-- 	rightImg="common/font_1008.png"
	-- end;
	
	
	-- local rightSprite=CCSprite:create(P(rightImg))
	-- rightSprite:setAnchorPoint(CCPoint(0,0.5))
	-- rightSprite:setPosition(CCPoint(landlordSprite:getPosition().x+landlordSprite:getContentSize().width/2,landlordSprite:getPosition().y))
	-- layer:addChild(rightSprite,0)
				
	-- local id=findPlayerByUserID(LandlordId)
	-- local info=mPalyerTable[id]	
	-- local posX=info.headSprite:getPosition().x+info.headSprite:getContentSize().width
	-- if posX>=pWinSize.width*0.8 then	
	-- 	    posX=info.headSprite:getPosition().x-mClockSprite:getContentSize().width
	-- end
	
	-- local clockPos=CCPoint(posX,info.headSprite:getPosition().y+mClockSprite:getContentSize().height*0.8)
								
	-- if mCurrentLandLord and lastState then	
	-- 	local info=mPalyerTable[mCurrentLandLord]
	-- 	local pathTable={[0]="font_1009",[1]="font_1008"}
	-- 	if  not isRob or  isRob==0   then
	-- 		pathTable={[0]="font_1007",[1]="font_1003"}
	-- 	else
	-- 		if lastState==1 then
	-- 			MainHelper.showAnimation("font_1002")
	-- 		end
	-- 	end
	-- 	local sprite=CCSprite:create(P(string.format("common/%s.png",pathTable[lastState])))
	-- 	sprite:setAnchorPoint(CCPoint(0,0))
	-- 	local posX=info.headSprite:getPosition().x+info.headSprite:getContentSize().width
	-- 	if posX>=pWinSize.width*0.8 then
	-- 		posX=info.headSprite:getPosition().x-sprite:getContentSize().width
	-- 	end
	-- 	sprite:setPosition(CCPoint(posX,info.headSprite:getPosition().y+info.headSprite:getContentSize().height*0.3))
	-- 	layer:addChild(sprite,0)
 --        if type then
 --             mClockSprite:setPosition(clockPos)
 --        else
 --            moveClock(clockPos)
 --        end
		
	-- else
	-- 	if mClockSprite then
	-- 	    mClockSprite:setPosition(clockPos)
	-- 	end
	-- end
	
	-- isFrstCallLandlord=false
	-- --找到斗地主
	-- mCurrentLandLord=findPlayerByUserID(LandlordId)
end

return landlord