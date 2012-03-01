--PURPOSE: To demonstrate how to create a scrolling table view using the tableView widget 

--init globals
_H = display.contentHeight
_W = display.contentWidth

--get required modules
local widget = require "widget"

local listOptions = {
	top = display.statusBarHeight,
	height = 410,
	maskFile = "images/scrollArea.jpg"
}

local list = widget.newTableView( listOptions )

--onEvent Listener for the tableview
local function onRowTouch (event) 
	local row = event.target
	local rowGroup = event.view
	
	if event.phase == "press" then
		if not row.isCategory then rowGroup.alpha = .5 end
	elseif event.phase == "swipeLeft" then
		print ("swiped left")
	elseif event.phase == "swipeRigth" then
		print ("swiped right")
	elseif event.phase == "release" then
		if not row.isCategory then
			row.render = true
			print ("You touched row "..event.index)
		end
	end
	
	return true
end

--onRender listener for tableview
local function onRowRender (event)
	local row = event.target
	local rowGroup = event.view
	
	local text = display.newRetinaText("Row #"..event.index, 12, 70, native.systemFont, 18)
	text:setReferencePoint(display.CenterLeftReferencePoint)
	text.y = row.height*.5
	if not row.isCategory then
		text.x = 15
		text:setTextColor(135,156,0)
	end
	--must insert everything into  event.view
	rowGroup:insert(text)
end

--Create 100 rows and two categories for the tableview
for i=1,100 do 
	local rowHeight, rowColor, lineColor, isCategory
	
	-- make the 25th item a category
	if i == 25 or i == 45 then
		isCategory = true
		rowHeight = 24
		rowColor = {70, 70, 130, 255}
		lineColor = {0,0,0, 255}
	end
	
	--fcn below creates the row
	list:insertRow{
		onEvent = onRowTouch,
		onRender = onRowRender,
		height = rowHeight,
		isCategory = isCategory,
		rowColor = rowColor,
		lineColor = lineColor
	}
	
end
