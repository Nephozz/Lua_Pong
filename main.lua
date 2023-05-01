--[[
    Test Pong version 2
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

]]

push = require 'push'                             -- importation de la librarie 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[ Initialisation du jeu ]]

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- police type rétro
    smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    -- mêmes paramètres avec une fenêtre de même taille mais de résolution différente
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[ Commandes ]]

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
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- dessine la raquette de gauche
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- dessine la raquette de droite
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- dessine la balle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- fin du rendu à basse résolution
    push:apply('end')
end
