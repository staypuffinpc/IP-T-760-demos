-----------------------------------------------------------------------------------------
--
-- PURPOSE OF THIS FILE is to create several different scenes that a user can use to go back and forth between different places in the app
-- basic setup is a tab bar at the bottom with different scenes that a person clicks between
---- scene 1 "start up page"
---- scene 2: options page
---- scene 3: someting with a tabular scroller
---- scene 4: something with a draggable object that is larger than the viewing area
-----------------------------------------------------------------------------------------
_H = display.contentHeight
_W = display.contentWidth
local storyboard = require "storyboard"
local widget = require "widget"

local btnW = 50
local btnH = 50

--------------------------------------------------------------------------
-- Handlers
--------------------------------------------------------------------------
local onBtnPress = function(evt)
	storyboard.gotoScene(evt.target.id)
end




-- load scenetemplate.lua
storyboard.gotoScene( "scenetemplate" )


-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):

--------------------------------------------------------------------------
-- listeners
--------------------------------------------------------------------------

local tabBtns = {
	{
		id="first",
		up = "images/green_leaf_icon.png",
		width = btnW, height = btnH,
		onPress = onBtnPress,
	},
	{
		id = "second",
		up = "images/Abstract_Tree_Vector_Art.png",
		width = btnW, height = btnH,
		onPress = onBtnPress
	},
	{
		id = "third",
		up = "images/Tree_002.png",
		width = btnW, height = btnH,
		onPress = onBtnPress
	},
	{
		id = "fourth",
		up = "images/Tree_003.png",
		width = btnW, height = btnH,
		onPress = onBtnPress
	}
} 

local tabBar = widget.newTabBar{	
	buttons = tabBtns,
	top = _H - 80,
	bottomFill = { 255, 255, 245}
}