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

-----------------------------------------------------------------------------------------
-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
-----------------------------------------------------------------------------------------
--function that the buttons run
local changeScene = function (event)
	storyboard.gotoScene(tabBarBtns[event.target.id].scene, "crossFade", 1000)
end

--buttons for the tab bar
tabBarBtns = {
	{
		label="First",
        up="images/up.png",
        down="images/over.png",
        width=64, height=64,
        onPress=changeScene,
        size = 20,
        selected=true,
        scene = "menu"
	},
	{
		label="Second",
        up="images/up.png",
        down="images/over.png",
        width=48, height=48,
        size = 20,
        onPress=changeScene,
        scene = "game"
	},
	{
		label="Third",
        up="images/up.png",
        down="images/over.png",
        width=32, height=32,
        size = 20,
        onPress=changeScene,
        scene = "theend"
	}
}

-- create a tabBar
local tabBar = widget.newTabBar{
	height = 100,
	top = _H - 100,
	bottomFill = {130,240,138},
	buttons = tabBarBtns
}

