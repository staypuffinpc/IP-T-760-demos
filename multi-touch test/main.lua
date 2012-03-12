-----------------------------------------------------------------------------------------
--PURPOSE: To test the different types of touch available when using multi-touch
--
--show a circle when user touches the screen at the location of the touch
--remove circle when user releases from screen
--log each touch and its coordinates
--if a touch is already occurring, check the distance from the other touch
--on move, check if the touch is getting bigger or smaller. If bigger, it's expanding, if smaller, it's pinching
--check for a double touch (w/i 300 milliseconds)
-----------------------------------------------------------------------------------------

_H = display.contentHeight
_W = display.contentWidth
display.setStatusBar( display.HiddenStatusBar )

--enable multitouch
system.activate( "multitouch" )

----------------- VARIABLES --------------------------
--create an output area to show which event is occurring
local touchTeller = display.newRetinaText("Phase:_____", 10, _H-50, system.defaultFont, 26)
local instructions = display.newRetinaText("Touch the screen with two fingers to see what happens", _W/2, 50, system.defaultFont, 26)
instructions:setReferencePoint(display.CenterReferencePoint)
instructions.x = _W/2

----------------- LISTENERS --------------------------



----------------- FUNCTIONS --------------------------
