--[[
    Test Pong version 3
    23/01/2022

    "test du language lua et de LöVE2D"

    -- Main Program --

    Auteur: Thomas Bocandé

    #Changelog:

        --version 0 (23/01/2022):
            Affichage du texte 'Hello World!'

        --version 1 (23/01/2022):
            Affichage basse résolution
            Ajout de la commande 'quitter l'application'

        --version 2 (23/01/2022):
            Police et couleur de l'écran plus proche du Pong originel
            Modification du texte 'Hello World!' en 'Hello Pong!' et déplacement en haut
            Ajout des deux raquettes et de la balle

        --version 3 (23/01/2022):
            Implémentation du mouvement des raquettes
            Ajout de l'affichage du score

]]

push = require 'push'                             -- importation de la librarie 'push'

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
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

--[[ Update du jeu ]]

function love.update(dt)
    -- mouvement du joueur 1
    if love.keyboard.isDown('z') then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end
    
    --mouvement du joueur 2
    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

--[[ Commandes supplémentaires ]]

function love.keypressed(key)

    -- quitte l'application si la touche 'échap' est pressée
    if key == 'escape' then
        love.event.quit()
    end
end

--[[ Affichage ]]

function love.draw()

    -- début du rendu à basse résolution
    push:apply('start')

    -- nettoye l'écran avec une couleur proche de celle de l'arrière plan du Pong
    love.graphics.clear(40, 45, 52, 0.2)

    -- affiche 'Hello Pong!' en haut de l'écran
    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    --affiche les scores
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- dessine la raquette de gauche
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- dessine la raquette de droite
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- dessine la balle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- fin du rendu à basse résolution
    push:apply('end')
end
