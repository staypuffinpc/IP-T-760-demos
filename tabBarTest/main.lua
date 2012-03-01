-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
_H = display.contentHeight
_W = display.contentWidth

local widget = require "widget"

local btnHandler = function (event)
	print(event.target.id)
	print(event.targetParent)
end

local tabBarBtns = {
	{
		label = "First",
        up="images/up.png",
        down="images/over.png",
        width=32, height=32,
        onPress=btnHandler,
        selected=true,
        scene = "this",
        cornerRadius = 0
	},
	{
		label = "Second",
        up="images/up.png",
        down="images/over.png",
        width=32, height=32,
        onPress=btnHandler,
        scene = "that"
	},
	{
		label = "Third",
        up="images/up.png",
        down="images/over.png",
        width=32, height=32,
        onPress=btnHandler,
        scene = "other"
	},
	{
		label = "Fourth",
        up="images/up.png",
        down="images/over.png",
        width=32, height=32,
        onPress=btnHandler,
        scene = "iffy"
	},
	{
		label = "Fifth",
        up="images/up.png",
        down="images/over.png",
        width=32, height=32,
        onPress=btnHandler,
        scene = "sniffy"
	}
}

local tabBar = widget.newTabBar{
	top= _H - 30,
	buttons = tabBarBtns,
	bottomFill = {136,173,189, 150}
}