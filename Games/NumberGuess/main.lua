math.randomseed(os.time())

HighscoreTime = 999
GoldScoreTarget = 10

function Restart()
    local title = "Guess my Number"
    love.window.setTitle(title)

    TargetNumber = math.random(1, 1000)

    PlayerGuess = ""
    Message = ""

    GameOver = false

    Time = 0

    CurrentTimeScore = 999
end

Restart()

function love.update(dt)
    Time = Time + dt
    CurrentTimeScore = Time
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
    music:setLooping(true)
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
        if CurrentTimeScore < HighscoreTime then
            HighscoreTime = (math.floor(CurrentTimeScore * 100)) / 100
        end
    end

    if HighscoreTime <= GoldScoreTarget then
        love.graphics.setColor(255, 215, 0, 1)
        love.graphics.print("Your Highscore: " .. HighscoreTime .. " seconds... Amazing!", 16, 16)
        love.graphics.setColor(255, 255, 255, 255)
    elseif HighscoreTime >= 999 then
        love.graphics.print("Your Highscore: NA", 16, 16)
    else
        love.graphics.print("Your Highscore: " .. HighscoreTime .. " seconds", 16, 16)
    end

end
