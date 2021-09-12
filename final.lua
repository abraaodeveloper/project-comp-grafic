local composer = require("composer")
local scene = composer.newScene()

local anterior

local function abrirPage2(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("page6", "slideRight", 800)
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
        text = "Abraão Barbosa \n\n setembro \nde 2021",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.05),
        width = 600,
        font = native.systemFont,
        fontSize = 40,
        align = "center"
    }

    local options2 = {
        text = "Prof: Ewerton Mendonça",
        x = display.contentWidth * 0.5,
        y = display.contentHeight - (display.contentHeight * 0.42),
        width = 600,
        font = native.systemFont,
        fontSize = 60,
        align = "center"
    }

    local myText1 = display.newText(options1)
    local myText2 = display.newText(options2)

    local upelogo = display.newImageRect(sceneGroup, "assets/upe1.png", 400, 270)
    upelogo.x = display.contentWidth * 0.5
    upelogo.y = display.contentHeight * 0.2

    anterior = display.newImageRect(sceneGroup, "assets/seta.png", 130, 100)
    anterior.x = display.contentWidth * 0.1
    anterior.y = display.contentHeight + 100

    transition.to( anterior, { rotation=180 } )

    sceneGroup:insert(background)
    sceneGroup:insert(myText1)
    sceneGroup:insert(myText2)
    sceneGroup:insert(anterior)
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
        anterior.touch = abrirPage2
        anterior:addEventListener("touch", anterior)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        anterior:removeEventListener("touch", anterior)

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
