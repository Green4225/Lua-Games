function love.load()
 Number = 0
end

function love.update(dt)
 Number = Number + 1
end

function love.draw()
love.graphics.print(Number)
end