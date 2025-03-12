function love.load()

    math.randomseed(os.time())

    local title = "Shooting Gallery"
    love.window.setTitle(title)

    TargetTable = {}
    TargetTable.x = 0
    TargetTable.y = 0
    TargetTable.radius = 50

    SkyColour = {}
    SkyColour.r = 153 / 255
    SkyColour.g = 204 / 255
    SkyColour.b = 255 / 255

    CrosshairColour = {}
    CrosshairColour.r = 40 / 255
    CrosshairColour.g = 1 / 255
    CrosshairColour.b = 55 / 255

    Score = 0

    Timer = 0

    StartMessage = "Press Any Mouse Button to Start"

    GameState = 1

    GameFont = love.graphics.newFont(40)

    TargetPadding = 32

    Sprites = {}
    Sprites.clouds = love.graphics.newImage("assets/cloud.png")
    Sprites.target = love.graphics.newImage("assets/target.png")
    Sprites.crosshairs = love.graphics.newImage("assets/crosshair.png")

    Music = love.audio.newSource("assets/sky.mp3", "stream")
    Music:setLooping(true)
    Music:play()

    Sounds = {}
    Sounds.impact = love.audio.newSource("assets/impact.wav", "static")

    love.mouse.setVisible(false)

    NewRandom()

    NewTargetXY()

end

function love.update(dt)

    if Timer > 0 then
        Timer = Timer - dt
    end
    if Timer < 0 then
        Timer = 0
        GameState = 1
    end

end

function love.draw()

    love.graphics.setBackgroundColor(SkyColour.r, SkyColour.g, SkyColour.b)
    love.graphics.draw(Sprites.clouds, 0, 0, 0, love.graphics.getWidth() / 576, love.graphics.getHeight() / 324)

    love.graphics.setFont(GameFont)
    if GameState == 1 then
        love.graphics.printf(StartMessage, 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    end
    love.graphics.print("Score: " .. Score, 16, 16)
    love.graphics.print("Time Left: " .. math.ceil(Timer), 300, 16)

    if GameState == 2 then
        love.graphics.draw(Sprites.target, TargetTable.x - 50, TargetTable.y - 50)
    end

    love.graphics.setColor(CrosshairColour.r, CrosshairColour.g, CrosshairColour.b)
    love.graphics.draw(Sprites.crosshairs, love.mouse.getX() - 32, love.mouse.getY() - 32)
    love.graphics.setColor(1, 1, 1)

end

function love.mousepressed(x, y, button, istouch, presses)

    if button == 1 and GameState == 2 then
        local mouseToTarget = DistanceBetween(x, y, TargetTable.x, TargetTable.y)
        if mouseToTarget <= TargetTable.radius then
            Sounds.impact:play()
            Score = Score + 1
            NewTargetXY()
        else
            Score = Score - 1
            if Score <= 0 then
                Score = 0
            end
        end
    elseif GameState == 1 then
        GameState = 2
        Timer = 10
        Score = 0
    end

end

function DistanceBetween(x1, y1, x2, y2)

    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

end

function NewRandom()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local smallSide = 0

    local safeMn = TargetTable.radius + TargetPadding

    if w < h then
        smallSide = w
    else
        smallSide = h
    end

    local safeMx = smallSide - safeMn

    TargetRandom = math.random(safeMn, safeMx)
end

function NewTargetXY()
    local randomTooCloseCheckX = false
    local randomTooCloseCheckY = false

    NewRandom()

    while randomTooCloseCheckX == false do
        if math.abs(TargetRandom - TargetTable.x) <= TargetTable.radius then
            NewRandom()
        else
            TargetTable.x = TargetRandom
            randomTooCloseCheckX = true
        end

        NewRandom()

        while randomTooCloseCheckY == false do
            if math.abs(TargetRandom - TargetTable.y) <= TargetTable.radius then
                NewRandom()
            else
                TargetTable.y = TargetRandom
                randomTooCloseCheckY = true
            end
        end
    end
end
