-----------------------------------------------------------------------------------------
--PURPOSE: to create objects that can be dragged around the screen using physics (and to detect their collisions)
-----------------------------------------------------------------------------------------
--import physics,  gameUI, activate multitouch
local physics = require("physics")
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")
local gameUI = require("gameUI")
system.activate("multitouch")

--init globals
_H = display.contentHeight
_W = display.contentWidth
local onLocalCollision

--create a single cloud and numbershower and move it off screen
local cloud = display.newImageRect("cloud.png",256,256)
cloud.x = -200
cloud.y = -200 
local showValue = display.newRetinaText("Text",0,-200,"Arial",100)
showValue:setTextColor(255)

--handler for dragging
local function onDrag (event)
	gameUI.dragBody(event, {maxForce = 200000, frequency = 10, center = true})
	if event.phase == "moved" then
		display.getCurrentStage():insert(showValue)
		showValue.x = event.x 
		showValue.y = event.y
		return true
	end
	if event.phase == "ended" or event.phase == "cancelled" then
		showValue.x = -200
		showValue.y = -200
		return true
	end
end

--handler for making a new item appear
local function comboItem(x,y)
	local newItem = display.newImageRect("box.png",200,200)
	newItem.x = x 
	newItem.y = y
	physics.addBody(newItem)
	newItem.linearDamping = 9
	newItem.isFixedRotation = true
	newItem:addEventListener("touch",onDrag)
	newItem.collision = onLocalCollision
	newItem:addEventListener("collision",newItem)
end

--handler to make the cloud disappear
local function disappear (x,y,obj1, obj2)
	if (obj1 ~= nil) then
		obj1:removeSelf()
		obj1 = nil
	end
	if (obj2 ~= nil) then
		obj2:removeSelf()
		obj2 = nil
	end
	cloud.x = -200
	cloud.y = -200
	--closure for passing arguments in a fcn inside of a timer 
	local closure = function() return comboItem(x,y) end
	timer.performWithDelay(300,closure,1)
end

--handler for when boxes collide
local function boxHit (x,y, obj1, obj2)
	print ("cloud should appear")
	--make the cloud appear on top
	local thisStage = display.getCurrentStage():insert(cloud)
	cloud.x = x
	cloud.y = y
	--wrap the function I really want to run inside of a closure so that I can pass it an argument
	local closure = function() return disappear(x,y,obj1, obj2) end
	timer.performWithDelay(300, closure, 1)
end

onLocalCollision = function(self, event)
	local hitX = self.x 
	local hitY = self.y 
	local obj1 = self
	local obj2 = event.other
	if event.phase == "began" then
		print ("collision began")		
		local closure = function() return boxHit(hitX,hitY,obj1, obj2) end
		timer.performWithDelay(100, closure, 1)
		showValue.text = tostring(event.target.id)
		display.getCurrentStage():insert(showValue)
		showValue.x = hitX
		showValue.y = hitY
		return true;
	end
	
	
end


--generate boxes and add physics body to each box
for i=1,5 do 
	local box = display.newRoundedRect(math.random(_W/.9),math.random(_H/.9), 150, 50, 25)
	box.id = i
	box.strokeWidth = 2
	box:setFillColor(240, 40, 180)
	box:setStrokeColor(255)
	physics.addBody(box)
	box.isFixedRotation = true
	box.linearDamping = 9
	box:addEventListener("touch",onDrag)
	box.collision = onLocalCollision
	box:addEventListener("collision",box)
end
print("dragging test")