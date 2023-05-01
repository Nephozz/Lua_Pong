--[[
    Test Pong version 1
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
]]

push = require 'push'                             -- importation de la librarie 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[ Initialisation du jeu ]]

function love.load()
    -- mêmes paramètres avec une fenêtre de même taille mais de résolution différente
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[ Commandes ]]

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()                               -- quitte l'application si la touche 'échap' est pressée
    end
end

--[[ Affichage du texte 'Hello World!'' ]]

function love.draw()

    push:apply('start')                                 -- début du rendu à basse résolution
    
    love.graphics.printf(
        'Hello World!',                                 -- texte à afficher
        0,                                              -- X initial
        VIRTUAL_HEIGHT / 2 - 6,                          -- Y initial
        VIRTUAL_WIDTH,                                   -- nombre de pixels à centrer
        'center'
    )

    push:apply('end')                                   -- fin du rendu à basse résolution
end
