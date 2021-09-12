_W = display.contentWidth
_H = display.contentHeight

local physics = require("physics")
--physics.setDrawMode("debug")
--physics.setDrawMode("hybrid")

physics.start()
physics.setGravity( 0, 0 )

local grupo = display.newGroup();

local direita = display.newRect(grupo, 0, _H / 2, 5, _H - _H / 3)
local esquerda = display.newRect(grupo, _W, _H / 2, 5, _H - _H / 3)
local piso = display.newRect(grupo, _W / 2, _H - _H / 3, _W, 5)

local optionsArvore =
{
    width = 237,
    height = 490,
    numFrames = 1,

    sheetContentWidth = 237, 
    sheetContentHeight = 490 
}

local options =
{
    width = 800,
    height = 337,
    numFrames = 1,
    sheetContentWidth = 802, 
    sheetContentHeight = 339 
}

local optionsArvoreCortada =
{
    width = 412,
    height = 201,
    numFrames = 1,

    sheetContentWidth = 412, 
    sheetContentHeight = 201 
}

local optionsMudinha =
{
    width = 540,
    height = 430,
    numFrames = 1,
    sheetContentWidth = 540, 
    sheetContentHeight = 430 
}

local imageSheetM = graphics.newImageSheet( "assets/muda.png", optionsMudinha )
local imageSheetA = graphics.newImageSheet( "assets/arvoreinteira.png", optionsArvore )
local imageSheetB = graphics.newImageSheet( "assets/arvorecortada.png", optionsArvore )
local imageSheet = graphics.newImageSheet( "assets/serra.png", options )

local arvore1 = display.newImageRect(grupo, imageSheetA ,1,200, 400)
arvore1.x = _W /2

physics.addBody(arvore1, "static", { friction = 0.1 })
physics.addBody(direita, "static", { friction = 0.1 })
physics.addBody(esquerda, "static", { friction = 0.1 })
physics.addBody(piso, "static", { friction = 0.1 })

local serra = display.newImageRect(grupo, imageSheet, 1, 800*0.3, 337*0.3)
serra.x = _W - 200;
serra.y = _H * 0.6;

local mudinha = display.newImageRect(grupo, imageSheetM, 1, 80, 100)
mudinha.x = _W / 5;
mudinha.y = _H * 0.6;

physics.addBody(serra, "dynamic")
physics.addBody(mudinha, "dynamic")

mudinha.isFixedRotation = true 
serra.isFixedRotation = true 

local bgMusic2 = audio.loadStream("assets/somserra.mp3")

function arrastar(e)
  local body = e.target
  local phase = e.phase
  local stage = display.getCurrentStage()

  if (phase == "began") then
    stage:setFocus(body, e.id)
    body.tempJoint = physics.newJoint("touch", body, e.x, e.y)
    
    audio.reserveChannels(2)
    audio.setVolume( 0.5, { channel=2 } )
    audio.play( bgMusic2, { channel=2, loops=0 } )

  elseif (phase == "moved") then
    body.tempJoint:setTarget(e.x, e.y)

  elseif (phase == "ended") then
    stage:setFocus(body, nil)
    body.tempJoint:removeSelf()
    
  end

  return true
end

function arrastarPlanta(e)
  local body = e.target
  local phase = e.phase
  local stage = display.getCurrentStage()

  if (phase == "began") then
    stage:setFocus(body, e.id)
    body.tempJoint = physics.newJoint("touch", body, e.x, e.y)


  elseif (phase == "moved") then
    body.tempJoint:setTarget(e.x, e.y)

  elseif (phase == "ended") then
    stage:setFocus(body, nil)
    body.tempJoint:removeSelf()
    local arvore3 = display.newImageRect(grupo, imageSheetM ,1,50, 50)
    arvore3.x = e.x
    arvore3.y = e.y
    physics.addBody(arvore3, "static", { friction = 0.1 })
    physics.addBody(arvore3)
  end

  return true
end

local function onGlobalCollision( event )
  local arvore2 = display.newImageRect(grupo, imageSheetB ,1,411, 201)
  arvore2.x = _W - 200
  arvore2.y = 100
  arvore1.alpha = 0
  physics.addBody(arvore2, "static", { friction = 0.1 })
  physics.addBody(arvore2)
end

serra:addEventListener( "collision", onGlobalCollision )
serra:addEventListener("touch", arrastar)
mudinha:addEventListener("touch", arrastarPlanta)

return grupo