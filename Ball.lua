--[[
    Test Pong
    23/01/2022

    "test du language lua et de LöVE2D"

    -- Ball Class --

    Auteur: Thomas Bocandé
]]

Ball = Class{}

--[[ Initialisation de la balle ]]

function Ball:init(x, y, witdh, height)
    self.x = x
    self.y = y
    self.witdh = witdh
    self.height = height

    -- variables de la vitesse
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

--[[ Colision de la balle ]]

function Ball:collides(paddle)
    -- vérifie si le coté gauche de l'un est plus à droite que la droite de l'autre
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.witdh then
        return false
    end

    -- vérifie si le bas de l'un est plus haut que le dessus de l'autre
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    -- Si aucune des deux condition n'est vérifiée alros il y a colision
    return true
end

--[[ Réinitialisation de la balle ]]

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

--[[ Mise à jour des attributs de la balle ]]

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

--[[ Affichage de la balle ]]

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.witdh, self.height)
end
