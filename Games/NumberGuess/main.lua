local title = "Guess my Number"
love.window.setTitle(title)

math.randomseed(os.time())
local targetNumber = math.random(1, 1000)

local playerGuess = ""
local message = ""

local gameOver = false

function love.textinput(input)
    if tonumber(input) then
        playerGuess = playerGuess .. input
    end
end

function love.keypressed(keyInput)
    if keyInput == "return" and not gameOver then
        CheckGuess()
    elseif keyInput == "backspace" then
        playerGuess = playerGuess:sub(1, -2)
    elseif keyInput == "return" and gameOver == true then
        love.load()
    end
end

function CheckGuess()
    local playerGuessAsNumber = tonumber(playerGuess)
    if playerGuessAsNumber then
        if playerGuessAsNumber < targetNumber then
            message = "Too low, try again!"
        elseif playerGuessAsNumber > targetNumber then
            message = "Too high, try again!"
        else
            message = "You guessed it. You win!"
            gameOver = true
        end
    end
    if not gameOver then
        playerGuess = ""
    end
end

function love.load()
    Back = love.graphics.newImage("assets/pic.png")

    local music = love.audio.newSource("assets/space-music.ogg", "stream")
    music:play()

end

function love.draw()
    love.graphics.draw(Back, 0, 0, 0, love.graphics.getWidth() / 1920, love.graphics.getHeight() / 1080)

    love.graphics.printf("Guess my Number!", 0, 150, love.graphics.getWidth(), "center")
    love.graphics.printf("Your Guess: " .. playerGuess, 0, 171, love.graphics.getWidth(), "center")
    love.graphics.printf(message, 0, 192, love.graphics.getWidth(), "center")

    if gameOver then
        love.graphics.printf("Press enter to play again!", 0, 213, love.graphics.getWidth(), "center")
    end

end

