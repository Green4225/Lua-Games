function love.load()

    math.randomseed(os.time())

    local title = "Top-Down Shooter"
    love.window.setTitle(title)

    Sprites = {}
    Sprites.background = love.graphics.newImage("assets/background.png")
    Sprites.bullet = love.graphics.newImage("assets/bullet.png")
    Sprites.player = love.graphics.newImage("assets/player.png")
    Sprites.zombie = love.graphics.newImage("assets/zombie.png")

    Music = {}
    Music.main = love.audio.newSource("assets/main.mp3", "stream")
    Music.battle = love.audio.newSource("assets/battle.mp3", "stream")

    Sound = {}
    Sound.shockwave = love.audio.newSource("assets/shockwave.mp3", "static")

    Music.main:setLooping(true)
    Music.battle:setLooping(true)

    Music.main:play()

    Player = {}
    Player.x = love.graphics.getWidth() / 2
    Player.y = love.graphics.getHeight() / 2
    Player.idealSpeed = 3
    Player.baseSpeed = Player.idealSpeed * 60
    Player.injured = false

    Zombies = {}

    Bullets = {}

    GameState = 1

    MaxTime = 2
    Timer = MaxTime

    Score = 0

    StartMessage = "Press Any Mouse Button to Start"
    GameFont = love.graphics.newFont(40)
    love.graphics.setFont(GameFont)

end

function love.update(dt)

    if GameState == 2 then
        if love.keyboard.isDown("d") and Player.x < love.graphics.getWidth() then
            Player.x = Player.x + Player.baseSpeed * dt
        end
        if love.keyboard.isDown("a") and Player.x > 0 then
            Player.x = Player.x - Player.baseSpeed * dt
        end
        if love.keyboard.isDown("w") and Player.y > 0 then
            Player.y = Player.y - Player.baseSpeed * dt
        end
        if love.keyboard.isDown("s") and Player.y < love.graphics.getHeight() then
            Player.y = Player.y + Player.baseSpeed * dt
        end
    end

    for i, z in ipairs(Zombies) do
        z.x = z.x + math.cos(ZombiePlayerAngle(z)) * z.baseSpeed * dt
        z.y = z.y + math.sin(ZombiePlayerAngle(z)) * z.baseSpeed * dt

        if DistanceBetween(z.x, z.y, Player.x, Player.y) < Sprites.player:getWidth() / 2 then

            for i, z in ipairs(Zombies) do
                Zombies[i] = nil
            end

            if Player.injured == true then
                GameState = 1
                Player.x = love.graphics.getWidth() / 2
                Player.y = love.graphics.getHeight() / 2
                Music.main:play()
                Music.battle:stop()
                MaxTime = 2
                Timer = MaxTime
                Player.idealSpeed = (Player.idealSpeed / 3) * 2
                Player.baseSpeed = Player.idealSpeed * 60
                Player.injured = false
                Sound.shockwave:play()
            end

            if GameState == 2 then
                Player.injured = true
                Player.idealSpeed = Player.idealSpeed * 1.33
                Player.baseSpeed = Player.idealSpeed * 60
                Sound.shockwave:play()
            end

        end
    end

    for i, b in ipairs(Bullets) do
        b.x = b.x + math.cos(b.direction) * b.baseSpeed * dt
        b.y = b.y + math.sin(b.direction) * b.baseSpeed * dt
    end

    for i = #Bullets, 1, -1 do
        local b = Bullets[i]
        if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getWidth() then
            table.remove(Bullets, i)
        end
    end

    for i, z in ipairs(Zombies) do
        for j, b in ipairs(Bullets) do
            if DistanceBetween(z.x, z.y, b.x, b.y) < Sprites.zombie:getWidth() / 2 then
                z.dead = true
                b.dead = true
                Score = Score + 1
            end
        end
    end

    for i = #Zombies, 1, -1 do
        local z = Zombies[i]
        if z.dead == true then
            table.remove(Zombies, i)
        end
    end

    for i = #Bullets, 1, -1 do
        local b = Bullets[i]
        if b.dead == true then
            table.remove(Bullets, i)
        end
    end

    if GameState == 2 then
        Timer = Timer - dt
        if Timer <= 0 then
            SpawnZombie()
            MaxTime = MaxTime * 0.98
            Timer = MaxTime
        end
    end

end

function love.draw()

    love.graphics.draw(Sprites.background, 0, 0)

    if Player.injured == true then
        love.graphics.setColor(1, 0, 0)
    end

    love.graphics.draw(Sprites.player, Player.x, Player.y, PlayerMouseAngle(), nil, nil, Sprites.player:getWidth() / 2,
        Sprites.player:getHeight() / 2)

        love.graphics.setColor(1, 1, 1)

    for i, z in ipairs(Zombies) do
        love.graphics.draw(Sprites.zombie, z.x, z.y, ZombiePlayerAngle(z), nil, nil, Sprites.zombie:getWidth() / 2,
            Sprites.zombie:getHeight() / 2)
    end

    for i, b in ipairs(Bullets) do
        love.graphics.draw(Sprites.bullet, b.x, b.y, nil, 0.3, nil, Sprites.bullet:getWidth() / 2,
            Sprites.bullet:getHeight() / 2)
    end

    if GameState == 1 then
        love.graphics.printf(StartMessage, 0, (love.graphics.getHeight() / 2) - (love.graphics.getHeight() / 8),
            love.graphics.getWidth(), "center")
    end

    love.graphics.printf("Score: " .. Score, 0, (love.graphics.getHeight() / 2) - (love.graphics.getHeight() / 2) + 4,
        love.graphics.getWidth(), "center")

end

function love.keypressed(key)

end

function love.mousepressed(x, y, button)
    if button == 1 and GameState == 2 then
        SpawnBullet()
    elseif button == 1 and GameState == 1 then
        GameState = 2
        Music.battle:play()
        Music.main:stop()
        Score = 0
    end
end

function PlayerMouseAngle()
    return math.atan2(Player.y - love.mouse.getY(), Player.x - love.mouse.getX()) + math.pi
end

function ZombiePlayerAngle(enemy)
    return math.atan2(Player.y - enemy.y, Player.x - enemy.x)
end

function SpawnZombie()
    local zombie = {}

    zombie.x = 0
    zombie.y = 0
    zombie.idealSpeed = 1
    zombie.baseSpeed = zombie.idealSpeed * 60
    zombie.dead = false

    local side = math.random(1, 4)
    if side == 1 then
        zombie.x = -30
        zombie.y = math.random(0, love.graphics.getHeight())

    elseif side == 2 then
        zombie.x = love.graphics.getWidth() + 30
        zombie.y = math.random(0, love.graphics.getHeight())

    elseif side == 3 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = -30

    elseif side == 4 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = love.graphics.getHeight() + 30
    end

    table.insert(Zombies, zombie)
end

function SpawnBullet()
    local bullet = {}
    bullet.x = Player.x
    bullet.y = Player.y
    bullet.idealSpeed = 8
    bullet.baseSpeed = bullet.idealSpeed * 60
    bullet.direction = PlayerMouseAngle()
    bullet.dead = false

    table.insert(Bullets, bullet)
end

function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
