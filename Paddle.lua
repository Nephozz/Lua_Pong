--[[
    Test Pong
    23/01/2022

    "test du language lua et de LöVE2D"

    -- Paddle Class --

    Auteur: Thomas Bocandé
]]

Paddle = Class{}

--[[ Initialisation de la raquette ]]

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

--[[ Mise à jour de la raquette ]]

function Paddle:update(dt)
    -- mouvement de la raquette
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y +self.dy * dt)
    end
end

--[[ Affichage de la raquette ]]

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end