   require("script.datapool.aiData")
function myadd(x, y)
    return x + y
end
playerSet,lastCardSet = shuffleCardMode2（4)
print(#playerSet,#lastCardSet)
for i,v in ipairs(lastCardSet) do
	print(i,v)
end
for i,v in ipairs(playerSet) do
	print("============"..i.."=============")
	for ki,kv in ipairs(v) do
		print(ki,kv)
	end
end