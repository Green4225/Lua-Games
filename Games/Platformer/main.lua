function love.load()

    Breezefield = require "libraries/breezefield"
    World = Breezefield.newWorld(0, 90.81)

    Player = Breezefield.Collider.new(World, "Rectangle", 360, 100, 80, 80)
    Platform = Breezefield.Collider.new(World, "Rectangle", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2,
    300, 100)
    Platform:setType("static")

end

function love.update(dt)

    World:update(dt)

end

function love.draw()

    World:draw()

end
