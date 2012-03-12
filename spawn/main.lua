-----------------------------------------------------------------------------------------
-- PURPOSE: to create numerous new items on the screen
-----------------------------------------------------------------------------------------

--enable multitouch
system.activate( "multitouch" )

----------------- VARIABLES --------------------------
_H = display.contentHeight
_W = display.contentWidth
local moveRate = 2 -- how fast the cookie moves across the screen
local createRate = 1500 --how often a new cookie is spawned (in milliseconds)
local level = 3

--create an object for each cookie
local oreo = {name = "oreo", value = 1}
local gingerbread = {name = "gingerbread", value = 10}
local chocolate_chip = {name = "chocolate_chip", value = 100}

--list which cookies are available on each level
local cookieList = {
	{oreo},
	{oreo, gingerbread},
	{oreo, gingerbread, chocolate_chip},
}
print ("level: "..level)
local thisLevel = cookieList[level]
for i,v in ipairs(thisLevel) do 
	print (thisLevel[i].name)
end

-------------------------- simple DISPLAY OBJECTS ----------------------
local showLevel = display.newRetinaText("Level: "..tostring(level), 100, _H*.9, "Arial", 42)
local showMoveRate = display.newRetinaText("Speed: "..tostring(moveRate), 300, _H*.9, "Arial", 42)
local showCreateRate = display.newRetinaText("Interval: "..tostring(createRate), 500, _H*.9, "Arial", 42)

--couldn't seem to get external classes to work, so I'm going to use Rafael Hernandez's method of spawning objects as seen in the Bubble Ball exercise
local function spawnCookie(kind, value)
	image = ("images/cookie_"..kind..".png") or ("images/cookie_oreo.png")
	local cookie = display.newImageRect(image, 72,72)
	cookie.kind = kind or "oreo"
	cookie.value = value or 1
	cookie.x = _W-50
	cookie.y = _H/2

	function cookie:touch(event)
		if event.phase == "began" then
			
			--show the value of the cookie on top of the cookie
			number = display.newRetinaText("",0,0,"Arial",76)
			number:setTextColor(0,200,200)
			number.text = tostring(cookie.value)
			number.x = cookie.x 
			number.y = cookie.y 
			return true
		elseif event.phase == "moved" then
			--set a variable to know that the cookie has been moved and should no longer move across the screen
			cookie.moved = "yes"
			--move the cookie around the screen
			cookie.x = event.x 
			cookie.y = event.y
			number.x = event.x 
			number.y = event.y 
			return true
		elseif event.phase =="cancelled" then
			print "cancelled"
			number.x = -50
			number.y = -50
			number:removeSelf()
			number = nil
			return true
		elseif (event.phase == "ended") then
			number:removeSelf()
			number = nil
			return true
		end
		
	end
	
	--make the cookie move across the screen
	function cookie:enterFrame()
		if (cookie.moved ~= "yes") then
			cookie.x = cookie.x - moveRate
		end
		if cookie.x < -50 then 
			Runtime:removeEventListener("enterFrame",cookie)
			cookie:removeSelf()
			cookie = nil
		end
	end
	--attach listeners
	cookie:addEventListener("touch",cookie)
	Runtime:addEventListener("enterFrame", cookie)
end

--set up a timer to generate cookies (NOTE: allow users to increase the speed of the cookies across the screen and the rate at which cookies are generated)
local generator = function ()
	local newCookie = math.random(#thisLevel)
	print (thisLevel[newCookie].name)
	spawnCookie(thisLevel[newCookie].name,thisLevel[newCookie].value)
end

timer.performWithDelay(createRate, generator,0)

--track how much memory is being used
local garbage = display.newRetinaText("Garbage collected:  "..collectgarbage("count"),0, 50, "Arial", 36)
garbage:setReferencePoint(display.CenterReferencePoint)
garbage.x = _W/2
local texture = display.newRetinaText("Texture memory:  "..system.getInfo("textureMemoryUsed"),0, 100, "Arial", 36)
texture:setReferencePoint(display.CenterReferencePoint)
texture.x = _W/2

function updateGarbage() 
	garbage.text = "Garbage collected:  "..collectgarbage("count")
	texture.text = "Texture memory: "..system.getInfo("textureMemoryUsed")
end

Runtime:addEventListener("enterFrame",updateGarbage)

