-- SoundView
--displayMode(FULLSCREEN)

-- Use this function to perform your initial setup
function setup()
    position = 0
    selector = 1
    parameter.integer( "BackgroundImage", 1, 5, 1, redrawBG )
    sounds = {"Menu Select","violin1","violin2","violin3"}
    imges = {"spectrum","monalisa","trumptrain","test1","test2"}
    spriteMode(CORNER)
    img = image(WIDTH,HEIGHT)
    setContext(img)
    
    sprite("Project:"..imges[1],0,0,WIDTH,HEIGHT)
    setContext()
end

-- This function gets called once every frame
function draw()
  sprite(img,0,0)
    
end

function redrawBG()
    img = image(WIDTH,HEIGHT)
    setContext(img)

    if imges ~= nil and selector ~= nil then
        sprite("Project:"..imges[selector],0,0,WIDTH,HEIGHT)
    else
        sprite("Project:spectrum",0,0,WIDTH,HEIGHT)
    end
    setContext()
end

function redrawBG(input)
    selector = input
    img = image(WIDTH,HEIGHT)
    setContext(img)

    if imges ~= nil and selector ~= nil then
        sprite("Project:"..imges[selector],0,0,WIDTH,HEIGHT)
    else
        sprite("Project:spectrum",0,0,WIDTH,HEIGHT)
    end
    setContext()
end

function orientationChanged(newOrientation)
    redrawBG()
end

function touched(touch)
    if touch.x > 0 and touch.y > 0 and touch.state ~= ENDED then
    r,g,b = img:get(math.floor(touch.x),math.floor(touch.y))
        sound("Game Sounds One:"..sounds[2],.33*r/255.,.20)
        sound("Game Sounds One:"..sounds[3],.33*b/255.,.5)
        sound("Game Sounds One:"..sounds[4],.23*g/255.,.8)
    end
end

