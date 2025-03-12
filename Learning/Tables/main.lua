local message = 0

local testScores = {}
local testScores2 = {94, 86, 97}
local testScores3 = {91,45}
local testScores4 = {}

testScores[1] = 95
testScores[2] = 87
testScores[3] = 98

table.insert(testScores3, 65)

testScores4[0] = 50
table.insert(testScores4, 42)

testScores.subject = "science"

for i,s in ipairs(testScores) do
message = message + s
end

--local message = testScores[2]
local message2 = testScores2[3]
local message3 = testScores3[3]
local message4 = testScores4[0]
local message5 = testScores4[1]
local message6 = testScores.subject


function love.draw()
    love.graphics.print(message, 16, 16)
    love.graphics.print(message2, 16, 32)
    love.graphics.print(message3, 16, 48)
    love.graphics.print(message4, 16, 64)
    love.graphics.print(message5, 16, 80)
    love.graphics.print(message6, 16, 96)
end
