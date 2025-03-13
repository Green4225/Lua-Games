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

end

function love.draw()

    love.graphics.draw(Sprites.background, 0, 0)

    love.graphics.draw(Sprites.player, Player.x, Player.y, PlayerMouseANgle(), nil, nil, Sprites.player:getWidth() / 2,
        Sprites.player:getWidth() / 2)

        for i,z in ipairs(Zombies) do
        
        end
end

function PlayerMouseANgle()
    return math.atan2(Player.y - love.mouse.getY(), Player.x - love.mouse.getX()) + math.pi
end

function SpawnZombie()
    local zombie = {}
    zombie.x = 300
    zombie.y = 500
    zombie.idealSpeed = 1
    zombie.baseSpeed = zombie.idealSpeed * 60

    table.insert(Zombies, zombie)
end
