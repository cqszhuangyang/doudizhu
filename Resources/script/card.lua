



function card(num)
   -- body
   local cardSprite = CCSprite:create()
   local txt,bg
   local function init()
   	-- body
		cardSprite.num = num
		cardSprite:setContentSize(CCSize(80,80))
		cardSprite:setAnchorPoint(CCPoint(0,0))
      txt =CCLabelTTF:create(num,"Courier",50)

		--txt:setPosition(cardSprite:getContentSize().width/2,cardSprite:getContentSize()/2);
		cardSprite:addChild(txt)
      bg = CCSprite:create()
      bg:setTextureRect(CCRect(0,0,80,80))
      bg:setColor(ccc3(255,255,255))
      bg:setAnchorPoint(CCPoint(0,0))
      cardSprite:addChild(bg)
   end

   init()
   return cardSprite
end
