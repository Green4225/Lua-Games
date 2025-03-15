function love.load()

    Breezefield = require "libraries/breezefield"
    World = Breezefield.newWorld(0, 0)

    Player = Breezefield.Collider.new(World, "Rectangle", 360, 100, 80, 80)

end

function love.update(dt)

end

function love.draw()

end
