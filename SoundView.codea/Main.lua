-- SoundView
--displayMode(FULLSCREEN)

-- Use this function to perform your initial setup
function setup()
    screen = 0
    position = 0
    selector = 1
    parameter.integer( "BackgroundImage", 1, 6, 1, redrawBG )
    sounds = {"Menu Select","violin1","violin2","violin3"}
    imges = {"spectrum","monalisa","sagradafamilia","test1","test2","sundayafternoon"}
    spriteMode(CORNER)
    img = image(WIDTH,HEIGHT)
    setContext(img)
    sprite("Project:"..imges[1],0,0,WIDTH,HEIGHT)
    setContext()
    touching=true
    parameter.action("Play",playSound)
    playing = false
end

function playSound()
    position = 1
    playing = true
end

function playSound2()
    if position == nil then
        position = 1
    end
    red = 0
    green = 0
    blue = 0
    counter = 0
    xpos = position
    ypos = 1
    repeat
    counter = counter + 1
    r,g,b = img:get(math.floor(xpos),math.floor(ypos))
    red = red + r
    green = green + g
    blue = blue + b
    xpos = xpos - 1
    if ypos < HEIGHT-1 then
        ypos = ypos + 1
    end
    until xpos <= 0
    sound("Game Sounds One:"..sounds[2],.33*red/counter/255.,.20)
    sound("Game Sounds One:"..sounds[3],.33*blue/counter/255.,.5)
    sound("Game Sounds One:"..sounds[4],.23*green/counter/255.,.8)
    position = position + 1
end

-- This function gets called once every frame
function draw()
    if screen == 1 then
        if touching == false then
            touching = true
            selector = BackgroundImage
            redrawBG()
        end
        
        sprite(img,0,0)
        if playing then
            position = playSound2()
            if position ~= nil then
                if position >= WIDTH then
                    playing = false
                end
            end
        end
    elseif screen == 0 then
        font("Futura-Medium")   --prettier font
        background(174, 174, 190, 255)
        textMode(CENTER)
        fill(0)
        fontSize(80*WIDTH/1024)
        text("Synesthetics",WIDTH/2,HEIGHT/2)
        fontSize(45*WIDTH/1024)
        text("tap to begin",WIDTH/2,HEIGHT/2.4)
        
        
        --check touch
        if CurrentTouch.state == BEGAN and touching then
            touching=false
            screen = 1
        end
    end
    
end

function redrawBG()
    --if BackgroundImage ~= nil then
    --     selector = BackgroundImage
    -- end
    spriteMode(CORNER)
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
    spriteMode(CORNER)
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
    if screen == 1 then
        redrawBG()
    end
end

function touched(touch)
    if screen == 1 then
        if touch.x > 0 and touch.y > 0 and touch.state ~= ENDED then
            r,g,b = img:get(math.floor(touch.x),math.floor(touch.y))
            sound("Game Sounds One:"..sounds[2],.33*r/255.,.20)
            sound("Game Sounds One:"..sounds[3],.33*b/255.,.5)
            sound("Game Sounds One:"..sounds[4],.23*g/255.,.8)
        end
    end
end
