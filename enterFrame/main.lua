--PURPOSE: To demonstrate what is possible with an "enterFrame" event --

--init globals
_H = display.contentHeight
_W = display.contentWidth

local ball = display.newImage("images/8ball.gif")
ball.x = math.random(display.contentWidth)
ball.y = -ball.contentHeight

--listener function for enterFrame event 
local function onEveryFrame ( event )
	ball:translate (0,5) -- move ball 1 pt down on every frame
	
	--move ball above top of screen when it goes below the screen
	if ball.y > display.contentHeight then
		ball.y = -ball.contentHeight
	end
end

--assign the enterFrame event fcn as an "enterFrame" listener
Runtime:addEventListener ("enterFrame",onEveryFrame)