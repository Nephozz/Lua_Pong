--[[
    Test Pong version 10
    23/01/2022

    "test du language lua et de LöVE2D"

    -- Main Program --

    Auteur: Thomas Bocandé

    #Changelog:

        --version 10 (23/01/2022):
            Changement de certains textes
            Ajout d'une condition de victoire et un écran de victoire

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

    -- titre de la fenêtre
    love.window.setTitle('Pong')

    -- "seed" la RNG grâce à l'horloge de la machine
    math.randomseed(os.time())

    -- police type rétro
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- police pour le score
    scoreFont = love.graphics.newFont('font.ttf', 48)

    -- police pour le GO
    largeFont = love.graphics.newFont('font.ttf', 16)

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
    if gameState == 'serve' then
        -- avant de changer le serveur on réinitialise la vitesse de la balle
        -- selon le joueur qui a marqué
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    -- mouvement de la balle lors de la phase de jeu
    elseif gameState == 'play' then
        ball:update(dt)
        -- collision avec le joueur, renvoie la balle vers le x opposé,
        -- et garde la direction du y avec une vitesse aléatroire
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        -- collision avec le haut
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = - ball.dy
        end

        --collision avec le bas
        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end

        -- Détection des point et attribution du service
        if ball.x < 0 then
            servingPlayer = 1
            player2score = player2score + 1
            if player2score == 10 then
            winningPlayer = 2
            gameState = 'done'
            else
                ball:reset()
                gameState = 'serve'
            end
        end
        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1score = player1score + 1
            if player1score == 10 then
                winningPlayer = 1
                gameState = 'done'
            else
                ball:reset()
                gameState = 'serve'
            end
        end
    end

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
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'serve'

            ball:reset()

            player1score = 0
            player2score = 0

            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

--[[ Affichage ]]

function love.draw()

    -- début du rendu à basse résolution
    push:apply('start')

    -- nettoye l'écran avec une couleur proche de celle de l'arrière plan du Pong
    love.graphics.clear(love.math.colorFromBytes(40, 45, 52, 255))

    -- affiche l'état du jeu en haut de l'écran
    if gameState == 'start' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Hello press Enter to start!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. '\'s serve!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to serve!', 0, 30, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        -- pas de message
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to retart!', 0, 30, VIRTUAL_WIDTH, 'center')
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

    displayFPS()

    -- fin du rendu à basse résolution
    push:apply('end')
end

--[[ Affichage des FPS ]]

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(love.math.colorFromBytes(0, 255, 0, 255))
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end