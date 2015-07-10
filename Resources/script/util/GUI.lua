

module("GUI",package.seeall)

-- 创建UI
function createButton(defaultImgUrl,selectedImgUrl,lable,fontName,fontSize)

	local psc9Selected = CCScale9Sprite:create(selectedImgUrl)
    local label =nil
    if lable~=nil then 
    	label = CCLabelTTF:create(lable, fontName, fontSize);  
    end
    local psc9ButtonBG = CCScale9Sprite:create(defaultImgUrl)
    local button = CCControlButton:create(label, psc9ButtonBG);  
    button:setAnchorPoint(CCPoint(0.5,0.5))
    button:setBackgroundSpriteForState(psc9Selected, CCControlStateSelected);  
    return button;
end