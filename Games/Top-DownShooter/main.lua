function love.load()

    local title = "Top-Down Shooter"
    love.window.setTitle(title)

    Sprites = {}
    Sprites.background = love.graphics.newImage("assets/background.png")
    Sprites.bullet = love.graphics.newImage("assets/bullet.png")
    Sprites.player = love.graphics.newImage("assets/player.png")
    Sprites.zombie = love.graphics.newImage("assets/zombie.png")

end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(Sprites.background, 0 , 0)

end
