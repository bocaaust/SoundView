-- SoundView
--displayMode(FULLSCREEN)

-- Use this function to perform your initial setup
function setup()
    screen = 0
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
    touching=false
end

-- This function gets called once every frame
function draw()
    if screen == 1 then
        sprite(img,0,0)
    elseif screen == 0 then
        font("Futura-Medium")   --prettier font
        background(174, 174, 190, 255)
        textMode(CENTER)
        fill(0)
        fontSize(80)
        text("Synesthetics",WIDTH/2,HEIGHT/2)
        fontSize(45)
        --draw buttons
        fill(30,30,30,160)  --dark gray buttons
        rectMode(CENTER)
        rect(WIDTH/4, HEIGHT/3.5, WIDTH/2.5, HEIGHT/7)
        rect(3*WIDTH/4, HEIGHT/3.5, WIDTH/2.5, HEIGHT/7)
        fill(255,255,255,255)   --white text
        text("Begin", WIDTH/4, HEIGHT/3.5)
        text("Select Image", 3*WIDTH/4, HEIGHT/3.5)
        rectMode(CORNER)    --reset rectMode

        --check touch
        if CurrentTouch.state == BEGAN and touching then
            touching=false

            --Check if user touched within the bounds of the buttons

            --First check y boundaries
            if CurrentTouch.y >= ((HEIGHT/3.5)-(HEIGHT/7)) and CurrentTouch.y <= ((HEIGHT/3.5)+(HEIGHT/7)) then
                --Check x boundaries on first button
                if CurrentTouch.x >= ((WIDTH/4)-(WIDTH/2.5)) and CurrentTouch.x <= ((WIDTH/4)+(WIDTH/2.5)) then
                    --User is touching left button, so go to "Begin" screen
                    screen = 1
                end

                --Check x boundaries on second button
                if CurrentTouch.x >= ((3*WIDTH/4)-(WIDTH/2.5)) and CurrentTouch.x <= ((3*WIDTH/4)+(WIDTH/2.5)) then
                    --User is touching right button, so go to "select image" screen
                    screen = 2
                end
            end
        end

        --Make sure user only taps once
        if CurrentTouch.state == ENDED then
            touching = true
        end

    elseif screen==2 then
        font("Futura-Medium")   --prettier font
        background(174, 174, 190, 255)
    end
    
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

