-- SoundView
displayMode(FULLSCREEN_NO_BUTTONS)
supportedOrientations(LANDSCAPE_LEFT)
-- Use this function to perform your initial setup
function setup()
    position = 0
    spriteMode(CORNER)
    img = image(WIDTH,HEIGHT)
    setContext(img)
    
    sprite("Project:spectrum",0,0,WIDTH,HEIGHT)
    setContext()
end

-- This function gets called once every frame
function draw()
  sprite(img,0,0)
    
end

function touched(touch)
    if touch.x > 0 and touch.y > 0 and touch.state ~= ENDED then
    r,g,b = img:get(math.floor(touch.x),math.floor(touch.y))
    sound("Game Sounds One:Menu Select",.33*r/255.,.20)
        sound("Game Sounds One:Menu Select",.33*b/255.,.5)
        sound("Game Sounds One:Menu Select",.33*g/255.,.8)
    end
end

