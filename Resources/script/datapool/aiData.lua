
module("AiData", package.seeall)
require("config.CardConfig")
local allPackCards = CardConfig.getAllPackCard();--包含大小王
local packCards = CardConfig.getPackCard();--不包含大小王

--[[
  洗牌模式1
  地主模式
  @playerNum:玩家数量
  @lastNum:需要保留牌数量
  return playerSet[1]={牌索引......},playerSet[1]={牌索引......}
  return lastCardsSet={牌索引......}
]]--
function shuffleCardMode1(playerNum,lastNum)
	function random()
		local index  = math.random(1, #allPackCards);

		if  randomSet[index]==index then
			return random();
		else
		   	randomSet[index]=index;
		   	return index
		end 
	end 
	--生成对应玩家牌信息
	local playerSet = {}
	--随机出来的所有牌 为了保证不重复
	randomSet = {}
	local count = #allPackCards - lastNum;
	local randomCount  = math.floor(count/playerNum);--随机次数
	--随机需要留下来的牌
	local lastCardsSet = {}
	for i=1,lastNum do
		   index = random()
           lastCardsSet[i] = index;
    end

    ---随机玩家的牌
	for i=1,playerNum do
		playerSet[i] = {}
        for m=1,randomCount do
           playerSet[i][m] = random();
        end
	end
	return playerSet,lastCardsSet
end
--[[
  洗牌模式2
  梁平模式 
  @playerNum:玩家数量
  @cardVal:如果不为nil 配牌模式 为nil 正常模式
  return playerSet[1]={牌索引......},playerSet[1]={牌索引......}
]]--
function shuffleCardMode2(playerNum)
	--生成对应玩家牌信息
	local playerSet = {}
	--随机出来的所有牌 为了保证不重复
	randomSet = {}
	count = #packCards;
	function random()
		local index  = math.random(1, count);
		if  randomSet[index] == index then
			return random();
		end 
		randomSet[index]=index;
		return index
	end 

	local randomCount  = math.floor(count/playerNum);--随机次数
    ---随机玩家的牌
	for i=1,playerNum do
		playerSet[i] = {}
        for m=1,randomCount do
           playerSet[i][m] = random();
        end
	end
	return playerSet

end