function love.load()

    local title = "Shooting Gallery"
    love.window.setTitle(title)

    TargetTable = {}
    TargetTable.x = 300
    TargetTable.y = 300
    TargetTable.radius = 50

    Refous = {}
    Refous.r = 168/255
    Refous.g = 28/255
    Refous.b = 7/255

    Score = 0

    Timer = 0

    GameFont = love.graphics.newFont(40)

end

function love.update(dt)

end

function love.draw()

    love.graphics.setColor(Refous.r, Refous.g, Refous.b)
    love.graphics.circle("fill", TargetTable.x, TargetTable.y, TargetTable.radius)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(GameFont)
    love.graphics.print(Score)

end