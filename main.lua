--[[
    Test Pong version 5
    23/01/2022

    "test du language lua et de LöVE2D"

    -- Main Program --

    Auteur: Thomas Bocandé

    #Changelog:

        --version 5 (23/01/2022):
            Refonte du programme et ajout des classes Ball.lua et Paddle.lua

]]

-- importation des librarie push.lua et class.lua
push = require 'push'
Class = require 'class'

require 'Paddle'

require 'Ball'

-- taille de la fenêtre
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- taille de la fenêtre virtuelle
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- vitesse de la raquette
PADDLE_SPEED = 200

--[[ Initialisation du jeu ]]

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- "seed" la RNG grâce à l'horloge de la machine
    math.randomseed(os.time())

    -- police type rétro
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- police pour le score
    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    -- mêmes paramètres avec une fenêtre de même taille mais de résolution différente
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    --scores des joueurs
    player1score = 0
    player2score = 0

    -- positions initiales des raquettes
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- position initiale de la balle
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- état du jeu
    gameState = 'start'
end

--[[ Update du jeu ]]

function love.update(dt)
    -- mouvement du joueur 1
    if love.keyboard.isDown('z') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    --mouvement du joueur 2
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    -- mouvement de la balle lors de la phase de jeu
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

--[[ Commandes supplémentaires ]]

function love.keypressed(key)
    -- quitte l'application si la touche 'échap' est pressée
    if key == 'escape' then
        love.event.quit()
    -- changement de l'état du jeu
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- réinitialise la position de la balle
            ball:reset()
        end
    end
end

--[[ Affichage ]]

function love.draw()

    -- début du rendu à basse résolution
    push:apply('start')

    -- nettoye l'écran avec une couleur proche de celle de l'arrière plan du Pong
    love.graphics.clear(40, 45, 52, 0.2)

    -- affiche l'état du jeu en haut de l'écran
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    --affiche les scores
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- dessine la raquette de gauche et de droite
    player1:render()
    player2:render()

    -- dessine la balle
    ball:render()

    -- fin du rendu à basse résolution
    push:apply('end')
end
