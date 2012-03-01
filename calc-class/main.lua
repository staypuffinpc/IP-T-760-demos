--[[ PURPOSE: To create a calculator that performs simple arithmetic functions, based on an arabic base-10, roman alphabet system 
-- allow the user to enter numbers with a GUI keypad (so they don't have to enter a textField first)
]]
-- globals
_W = display.contentWidth
_H = display.contentHeight
--things I'm going to need (resources)
--import required libraries
local widget = require "widget"

-- variables to represent each operand (op1 and op2)
--variable to represent the chosen operator (operator)
-- result: the output of the operation (result)
-- variable for error message
local num1, num2, operation, result, msg
local btnX = {_W/2, _W/2-86, _W/2, _W/2+86, _W/2-86, _W/2, _W/2+86, _W/2-86, _W/2, _W/2+86 }
local btnY = {258, 0,0,0,86,86,86, 172, 172, 172}
local numGroup = display.newGroup()
local ops = {"+","-","x","÷"}
------------------------------------------------------------------------------------------------------
--DISPLAY OBJECTS
------------------------------------------------------------------------------------------------------
local numDisplay = display.newText("",_W*.9,80, native.systemFontBold, 76)
numDisplay:setReferencePoint(display.TopRightReferencePoint)
numDisplay.align = "right"

--msg display object 
local msgDisplay = display.newText("", 0, 0, native.systemFont, 48)
msgDisplay:setReferencePoint(display.CenterReferencePoint)
msgDisplay.width = _W
msgDisplay.x = _W/2; msgDisplay.y = 180;
msgDisplay.text = "Please enter a number"
------------------------------------------------------------------------------------------------------
-- Functions (Handlers)
------------------------------------------------------------------------------------------------------
local function reset()
	numDisplay:setReferencePoint(display.TopRightReferencePoint)
	numDisplay.x = _W*.9
end
--function to execute the operation
-- function that runs the operation and returns a result (equals function)
-- function to register which number was clicked
local numHandler = function (event)
	num1 = numDisplay.text..event.target.id
	numDisplay.text = num1
	reset()
	if (operation) then
		msgDisplay.text = num1
		print("your operation is " .. operation)
	end
	
end

-- function to register which operation was chosen
local opsHandler = function (event)
	-- 	register whichever operator was pushed
	operation = event.target.id
	msg = operation
	msgDisplay.text = msgDisplay.text .. " ".. msg .. " "
	-- clear the display
	numDisplay.text = ""
	print(operation)
end

local equalsHandler = function (event)
	print(event.target.id)
end

------------------------------------------------------------------------------------------------------- 
--BUTTONS
--------------------------------------------------------------------------------------------------------
-- buttons that have numbers on them
for n = 0,9 do 
	 local nBtn = widget.newButton{
		id = n,
		top = btnY[n+1],
		left = btnX[n+1],
		defaultColor = {255},
		width = 76,
		height = 76,
		cornerRadius = 38,
		label = n,
		fontSize = 60,
		offset =  -5,
		labelColor = { default={ 100,0,255 }, over={ 0 } },
		onRelease = numHandler
	}
	numGroup:insert(nBtn)
	if n%2 == 0 then
	   nBtn.defaultColor = {175,130,45}
	end
end
numGroup.y = 300


-- buttons that have operators on them
local opsGroup = display.newGroup()
for n = 1,#ops do 
	--create a button for each operation and place it into a common group
	local opsBtn = widget.newButton{
		id = ops[n],
		left = (n-1)*86,
		defaultColor = {135,146,56},
		width = 76,
		height = 76,
		cornerRadius = 18,
		label = ops[n],
		fontSize = 60,
		offset =  -5,
		labelColor = { default={255 }, over={ 0 } },
		onRelease = opsHandler
	}
	opsGroup:insert(opsBtn)
end
opsGroup.y = _H*.9
opsGroup.x = 40

--button for the equal button
local equals_btn = widget.newButton{
	id = "equals",
	top = _H*.9,
	left = _W*.8,
	defaultColor = {255},
	width = 76,
	height = 76,
	cornerRadius = 16,
	label = "=",
	fontSize = 60,
	offset =  -5,
	labelColor = { default={ 100,0,255 }, over={ 0 } },
	onRelease = equalsHandler
}

