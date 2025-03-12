function love.load()

    math.randomseed(os.time())

    local title = "Shooting Gallery"
    love.window.setTitle(title)

    TargetTable = {}
    TargetTable.x = 300
    TargetTable.y = 300
    TargetTable.radius = 50

    Refous = {}
    Refous.r = 168 / 255
    Refous.g = 28 / 255
    Refous.b = 7 / 255

    Score = 0

    Timer = 0

    GameFont = love.graphics.newFont(40)

    TargetPadding = 32

    NewRandom()

end

function love.update(dt)

end

function love.draw()

    love.graphics.setColor(Refous.r, Refous.g, Refous.b)
    love.graphics.circle("fill", TargetTable.x, TargetTable.y, TargetTable.radius)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(GameFont)
    love.graphics.print(Score, 16, 16)

end

function love.mousepressed(x, y, button, istouch, presses)

    if button == 1 then
        local mouseToTarget = DistanceBetween(x, y, TargetTable.x, TargetTable.y)
        if mouseToTarget <= TargetTable.radius then
            Score = Score + 1
            NewRandom()
            TargetTable.x = TargetRandom
            NewRandom()
            TargetTable.y = TargetRandom
        end
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
    NewRandom()
    TargetTable.x = TargetRandom

    NewRandom()
    TargetTable.y = TargetRandom
end
