local title = "Guess my Number"
love.window.setTitle(title)

math.randomseed(os.time())
local targetNumber = math.random(1, 1000)

function love.load()
    Back = love.graphics.newImage("assets/pic.png")
end

function love.draw()
    love.graphics.draw(Back, 0, 0, 0, love.graphics.getWidth() / 1920, love.graphics.getHeight() / 1080)

    love.graphics.printf("Guess my Number!", 0, 150, love.graphics.getWidth(), "center")
    love.graphics.printf("Your Guess:", 0, 171, love.graphics.getWidth(), "center")

end
