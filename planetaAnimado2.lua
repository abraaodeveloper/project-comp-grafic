display.setStatusBar( display.HiddenStatusBar )

local mainGroup = display.newGroup()

local sheetOptions = {
	width = 700,
	height = 600,
	numFrames = 1,
	sheetContentWidth = 700,
	sheetContentHeight = 600
}
local imageSheet = graphics.newImageSheet( "assets/planeta2.png", sheetOptions )
local character = display.newSprite( mainGroup, imageSheet, { name="swim", start=1, count=1, time=100 } )
character.x, character.y = display.contentWidth/2, display.contentHeight/2  - display.contentWidth/5
character:play()

local currentTransition = 1
local scale = 1
local rotation = 1

local function doNextTransition()
	-- Set up transition parameters
	local transData = {  rotation=rotation, xScale=scale, yScale=scale  }
	transData["time"] = tonumber(3000)
	transData["transition"] =  easing.linear
	transData["onComplete"] = doNextTransition

	-- Initiate the transition
	transition.to( character, transData )

    if (scale >= 1.1) then
        rotation = -10
    else
        rotation = rotation+10
    end
end

return {animation=doNextTransition, character=character}