
module("Debugger", package.seeall)


function Debugger:debug( ... )
 	-- body
        print("["..os.date().."]DEBUG:"..string.format(...))
 end

function error( ... )
 	-- body
        print("["..os.date().."]ERROR:"..string.format(...))
end