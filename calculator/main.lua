--create a calculator, with as little code as possible

--import the needed libraries
local widget = require "widget"

--initialize globals
_H = display.contentHeight
_W = display.contentWidth

--set up variables
local op1, op2, operation, x, y 
local resultText = display.newText("",0,0,native.systemFont, 24)
local opsTable = {"+","-","÷","x"}
local btn_X = {_W/2, _W/2-150, _W/2, _W/2+150, _W/2-150, _W/2, _W/2+150, _W/2-150, _W/2, _W/2+150}
local btn_Y = {450, 0, 0, 0, 150, 150, 150, 300, 300, 300}
local errMsg = display.newText("Please enter a number",60,150, native.systemFont,48)
local enteredNum = display.newText("",0,0,native.SystemFont,76)
enteredNum:setReferencePoint(display.TopRightReferencePoint)
enteredNum.align = "right"
enteredNum.x = _W - 90
enteredNum.y = 80
--------------------------------------------------------------
-- create listener fcns
--------------------------------------------------------------
--figure out which operation to execute
local runOp = function(op1,op2,operation)
	local result
	if operation == "+" then --addition
		result = op1 + op2
	elseif operation == "-" then --subtraction
		result = op1 - op2
	elseif operation == "÷" then --division
		result = op1/op2
	else --must be multiplication
		result = op1*op2
	end
	return result
end

--execute the equal btn
local equalsHandler = function(event)
	--make sure there is something in op1 and op2
	if op1 == "" then --no nums yet
		errMsg.text = "Choose a number, sheesh!"
		errMsg.alpha = 1
	elseif operation == "" or operation == nil then -- no operation
		errMsg.text = "Choose an operation"
		errMsg.alpha = 1
	else 
		--everything checks out so execute the fcn
		--if there is no second number, just multiply the first number by 1
		if op2 == "" or nil then op2 = 1 end
		op2 = tonumber(enteredNum.text)
		enteredNum:setReferencePoint(display.TopRightReferencePoint)
		enteredNum.text = runOp(op1,op2,operation)
	end
end

--execute the keypad btns
local btnPress = function(event)
	--get rid of the error message
	errMsg.alpha = 0
	--[[check to see if there is anything in the text field]]
	if enteredNum.text == "" or nil then
		--it's not empty, so this must be the first operator
		enteredNum.text = event.target.id
	else 
		enteredNum.text = enteredNum.text .. event.target.id
	end
	enteredNum:setReferencePoint(display.TopRightReferencePoint)
	enteredNum.x = _W - 90
	print("width: "..enteredNum.width, "x: "..enteredNum.x)
end

--operator fcn
local opHandler = function(event)
	--check that there is actually a number to execute
	if enteredNum.text == ""  or nil then
		errMsg.text = "Please! enter a number"
		errMsg.alpha = 1
	else 
		--hide of the error message
		errMsg.alpha = 0
		--store the current text as a number
		op1 = tonumber(enteredNum.text)
		print (op1)
		enteredNum.text = ""
		--log which operation is going to occur
		operation = event.target.id
		print ("looks like you want to "..operation)
	end	
end
---------------------------------------------------------------
--create buttons
---------------------------------------------------------------

--fcn to create all the # buttons in one group 
----first, set up the group 
local num_group = display.newGroup()
x = 92
y = 200
for i = 0,9 do 
    local btn = widget.newButton{
    	id = i,
    	label = i,
    	left = btn_X[i+1],
    	top = btn_Y[i+1],
    	width = 140,
    	height = 140,
    	emboss = true,
    	fontSize = 76,
    	onRelease = btnPress,
 		cornerRadius = 75   	
    	}
    num_group:insert(btn)
    print("this is "..i,btn_X[i],btn_Y[i])
end
num_group:setReferencePoint(display.CenterReferencePoint)
num_group.y = _H/2+40
num_group.x = _W/2

--create the operation buttons individually  
----(HINT: use the operations table to dynamically generate these buttons)
x = 92;
local operations_group = display.newGroup()
for i = 1,#opsTable do
    local btn = widget.newButton{
    	id = opsTable[i],
    	label = opsTable[i],
    	left = x * (i-1),
    	width = 82,
    	height = 82,
    	emboss = true,
    	fontSize = 46,
    	onRelease = opHandler
    	}
    operations_group:insert(btn)
end
operations_group:setReferencePoint(display.CenterReferncePoilnt)
operations_group.x = operations_group.width/4
operations_group.y = _H*.9

--create equals btn
local equals_btn = widget.newButton{
	id = "equals",
	left = _W-120,
	top = .9*_H,
	label = "=",
	emboss = true,
	fontSize = 46,
	offset = -10,
	width = 100,
	height = 82,
	labelColor = {0},
	defaultColor = { default = {0}, over = {133,133,133}},
	onRelease = equalsHandler
}
---------------------------
