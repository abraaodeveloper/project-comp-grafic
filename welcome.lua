local composer = require("composer")
local scene = composer.newScene()

local seguinte

local function abrirTela1(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page0", "slideLeft", 800)
        return true
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "assets/fundo.png", display.contentWidth, display.contentHeight * 2)
    background.anchorX = 0
    background.anchorY = 0
    background.x, background.y = 0, -150


    local options1 = {
        text = "Abraão Barbosa",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.1),
        width = 600,
        font = native.systemFont,
        fontSize = 40,
        align = "center"
    }

    local options2 = {
        text = "Educação Ambiental",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.3),
        width = 600,
        font = native.systemFont,
        fontSize = 60,
        align = "center"
    }

    local myText1 = display.newText(options1)
    local myText2 = display.newText(options2)

    local upelogo = display.newImageRect(sceneGroup, "assets/upe1.png", 400, 270)
    upelogo.x = display.contentWidth * 0.5
    upelogo.y = display.contentHeight * 0.3

    seguinte = display.newImageRect(sceneGroup, "assets/seta.png", 130, 100)
    seguinte.x = display.contentWidth * 0.9
    seguinte.y = display.contentHeight + 100

    sceneGroup:insert(background)
    sceneGroup:insert(myText1)
    sceneGroup:insert(myText2)
    sceneGroup:insert(seguinte)
    sceneGroup:insert(upelogo)

    local bgMusic = audio.loadStream("assets/vento.mp3")
    audio.reserveChannels(1)
    audio.setVolume( 0.5, { channel=1 } )
    audio.play( bgMusic, { channel=1, loops=-1 } )
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        seguinte.touch = abrirTela1
        seguinte:addEventListener("touch", seguinte)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        seguinte:removeEventListener("touch", seguinte)

    elseif phase == "did" then

    end
end

function scene:destroy(event)
    local sceneGroup = self.view

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
