--[[
    Test Pong version 1
    23/01/2022

    "test du language lua et de LöVE2D"

    -- Main Program --
    
    Auteur: Thomas Bocandé
    
    #Changelog:

        --version 0 (23/01/2022):
            Affichage du texte 'Hello World!'
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[ Initialisation du jeu ]]

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,                             -- pas de plein écran
        resizable = false,                              -- fenêtre de taille fixe 
        vsync = true                                    -- Vsync on
    })
end

--[[ Affichage du texte 'Hello World!'' ]]

function love.draw()
    love.graphics.printf(
        'Hello World!',                                 -- texte à afficher
        0,                                              -- X initial
        WINDOW_HEIGHT / 2 - 6,                          -- Y initial
        WINDOW_WIDTH,                                   -- nombre de pixels à centrer
        'center'
    )
end
