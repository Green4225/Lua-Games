function love.load()

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

    Music.main:setLooping(true)
    Music.battle:setLooping(true)

    Music.battle:play()

    Player = {}
    Player.x = love.graphics.getWidth() / 2
    Player.y = love.graphics.getHeight() / 2
    Player.idealSpeed = 3
    Player.baseSpeed = Player.idealSpeed * 60

    Zombies = {}

    Bullets = {}

end

function love.update(dt)

    if love.keyboard.isDown("d") then
        Player.x = Player.x + Player.baseSpeed * dt
    end
    if love.keyboard.isDown("a") then
        Player.x = Player.x - Player.baseSpeed * dt
    end
    if love.keyboard.isDown("w") then
        Player.y = Player.y - Player.baseSpeed * dt
    end
    if love.keyboard.isDown("s") then
        Player.y = Player.y + Player.baseSpeed * dt
    end

    for i, z in ipairs(Zombies) do
        z.x = z.x + math.cos(ZombiePlayerAngle(z)) * z.baseSpeed * dt
        z.y = z.y + math.sin(ZombiePlayerAngle(z)) * z.baseSpeed * dt

        if DistanceBetween(z.x, z.y, Player.x, Player.y) < Sprites.player:getWidth() / 2 then
            for i, z in ipairs(Zombies) do
                Zombies[i] = nil
            end
        end
    end
    for i,b in ipairs(Bullets) do
        b.x = b.x + math.cos(b.direction) * b.baseSpeed * dt
        b.y = b.y + math.sin(b.direction) * b.baseSpeed * dt
    end
end

function love.draw()

    love.graphics.draw(Sprites.background, 0, 0)

    love.graphics.draw(Sprites.player, Player.x, Player.y, PlayerMouseAngle(), nil, nil, Sprites.player:getWidth() / 2,
        Sprites.player:getHeight() / 2)

    for i, z in ipairs(Zombies) do
        love.graphics.draw(Sprites.zombie, z.x, z.y, ZombiePlayerAngle(z), nil, nil, Sprites.zombie:getWidth() / 2,
            Sprites.zombie:getHeight() / 2)
    end

    for i, b in ipairs(Bullets) do
        love.graphics.draw(Sprites.bullet, b.x, b.y)
    end
end

function love.keypressed(key)
    if key == "space" then
        SpawnZombie()
    end
end

function love.mousepressed(x, y , button)
    if button == 1 then
        SpawnBullet()
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
    zombie.x = math.random(16, love.graphics.getWidth() - 16)
    zombie.y = math.random(16, love.graphics.getHeight() - 16)
    zombie.idealSpeed = 1
    zombie.baseSpeed = zombie.idealSpeed * 60

    table.insert(Zombies, zombie)
end

function SpawnBullet()
    local bullet = {}
    bullet.x = Player.x
    bullet.y = Player.y
    bullet.idealSpeed = 8
    bullet.baseSpeed = bullet.idealSpeed * 60
    bullet.direction = PlayerMouseAngle()

    table.insert(Bullets, bullet)
end

function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
