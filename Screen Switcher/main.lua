-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
_H = display.contentHeight
_W = display.contentWidth

local storyboard = require "storyboard"
local widget = require "widget"

-- load scenetemplate.lua
storyboard.gotoScene( "scenetemplate" )

------------------------------------------------------------------------------------------------------
-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
------------------------------------------------------------------------------------------------------
local tabBtnHandler = function(event) 
	print(storyboard.getScene("scene1"))
	storyboard.gotoScene(tabBtns[event.target.id].scene, "flip", 500)
end


-- Table w/ buttons --
tabBtns = {
	{
		up = "images/btn_up.png",
		down = "images/btn_down.png",
		label = "first",
		width = "30",
		height = "30",
		scene = "scene1",
		onPress = tabBtnHandler
	},
	{
		up = "images/btn_up.png",
		down = "images/btn_down.png",
		label = "second",
		width = "30",
		height = "30",
		scene = "scene2",
		onPress = tabBtnHandler
	},
	{
		up = "images/btn_up.png",
		down = "images/btn_down.png",
		label = "third",
		width = "30",
		height = "30",
		scene = "scene3",
		onPress = tabBtnHandler
	}
}

-- TabBar --
local tabBar = widget.newTabBar {
	top = _H - 60,
	buttons = tabBtns,
	width = _W*1.28
}
tabBar:setReferencePoint(display.TopLeftReferencePoint)
tabBar.x = -140