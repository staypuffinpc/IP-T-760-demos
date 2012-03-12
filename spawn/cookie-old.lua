--------------- PURPOSE: all properties and methods for an individual cookie are created herein --------------------

local cookie = {}
local cookie_mt = { __index = cookie }

_H = display.contentHeight
_W = display.contentWidth

-- return cookie
----------------- PROPERTIES --------------------------
-- number
-- image file 
-- cookie type 
-- size?


----------------- PUBLIC FUNCTIONS --------------------------
-- cookie constructor
function cookie.new (kind, value)
	local newCookie = { --properties go here
		kind = kind or "Mystery",
		value = value or 1
	}
	
	local image = "images/cookie_"..kind..".png"
	print(image)
	--now make the cookie show up on screen
	thisCookie = display.newImageRect(image, 72,72)
	thisCookie.x = _W/2
	thisCookie.y = _H/2
	
	setmetatable(newCookie, self)
	self.__metatable = self
	return newCookie
end

--function cookie:addEventListener("touch", cookie)

--------------------------------------------------------------------------------------
-- showNum: when cookie is touched, show its numerical value
function cookie:touch(event)
	if (event.phase == "began") then
		print ("x: "..self.x)
		--print ("I'm worth " .. self.value)
		--print("I am a "..self.kind.." cookie.")
			return true
	end

end
--------------------------------------------------------------------------------------

-- startCookie: moves cookie from right side of screen to left-side of screen (perhaps drop onto the screen, then move left)
-- removeCookie: once cookie is off the screen, check for a collision and then nix the cookie
-- moveCookie: when a user touches and holds down on a cookie, it will move with the finger to the "packaging" area
-- storeCookie: put the cookie into the stack representing the cookies for counting
-- break cookie: cookie breaks into 10 constituent pieces
-- mergeCookie: combine cookie with another (of like kind) to form a new cookie unit


----------------- LISTENERS --------------------------



return cookie