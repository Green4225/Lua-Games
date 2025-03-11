function Restart()
    local title = "Guess my Number"
    love.window.setTitle(title)

    math.randomseed(os.time())
    TargetNumber = math.random(1, 1000)

    PlayerGuess = ""
    Message = ""

    GameOver = false

    Time = 0
end

Restart()

function love.update(dt)
    Time = Time + dt
end

function love.textinput(input)
    if tonumber(input) then
        PlayerGuess = PlayerGuess .. input
    end
end

function love.keypressed(keyInput)
    if keyInput == "return" and not GameOver then
        CheckGuess()
    elseif keyInput == "backspace" then
        PlayerGuess = PlayerGuess:sub(1, -2)
    elseif keyInput == "return" and GameOver == true then
        Restart()
    end
end

function CheckGuess()
    local playerGuessAsNumber = tonumber(PlayerGuess)
    if playerGuessAsNumber then
        if playerGuessAsNumber < TargetNumber then
            Message = "Too low, try again!"
        elseif playerGuessAsNumber > TargetNumber then
            Message = "Too high, try again!"
        else
            Message = "You guessed it. You win!"
            GameOver = true
        end
    end
    if not GameOver then
        PlayerGuess = ""
    end
end

function love.load()
    Back = love.graphics.newImage("assets/pic.png")

    local gameFont = love.graphics.newFont("assets/SuperShape-PV9qE.ttf", 24)
    love.graphics.setFont(gameFont)

    local music = love.audio.newSource("assets/space-music.ogg", "stream")
    music:play()
end

function love.draw()
    love.graphics.draw(Back, 0, 0, 0, love.graphics.getWidth() / 1920, love.graphics.getHeight() / 1080)

    TextBob = math.sin(Time * 2) * 5

    love.graphics.printf("Guess my Number!", 0, 150 + TextBob, love.graphics.getWidth(), "center")
    love.graphics.printf("Your Guess: " .. PlayerGuess, 0, 192 + TextBob, love.graphics.getWidth(), "center")
    love.graphics.printf(Message, 0, 234 + TextBob, love.graphics.getWidth(), "center")

    if GameOver then
        love.graphics.printf("Press enter to play again!", 0, 276 + TextBob, love.graphics.getWidth(), "center")
    end

end

