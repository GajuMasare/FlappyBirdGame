push = require 'push'
-- we need this to handle virtual display

Class = require 'class'

require 'Bird'
-- importing the bird file

require 'Pipe'
-- importing pipe file

require 'PipePair'
-- importing pipepair file

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/CountDownState'
require 'states/ScoreState'

window_width = 1280
window_height = 720
--physical display

virtual_width = 512
virtual_height = 288
--virtual display

local background = love.graphics.newImage('assets/background.png') --local means we can not accese this line outside this file
local backgroundScroll = 0 -- setting its background scroll at 0 x axis

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0 --setting its ground scroll at 0 x axis

local background_scroll_speed = 30
local ground_scroll_speed = 60
--setting the speed of scorll scaled by dt

local background_looping_point = 413
--this is the point where the images will go to 0 at x axis

local scrolling = true 
-- this is to pause the game

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') --this will not make the everything blur since love makes everything blur by defaultt
    love.window.setTitle('Flappy bird') --title of the game

    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('fonts/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('fonts/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()
    --setting the backgound music on loop and playing it

    push:setupScreen(virtual_width, virtual_height, window_width, window_height, {
        vsync = true,
        fullscreen = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountDownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    -- making a table to know which key is pressed. at start it will be empty(part 1)
end

function love.resize(w, h)
    push:resize(w, h)
end
-- this will make our screen risponsive

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    -- once a key is pressed then set that key to true and that key is added to the table(part 2)

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then -- if keysPressed table has a key in it which is presed then return true. this data can be accesed by anyone, bird.lua is acceceing this function (part 3)
        return true
    else
        return false
    end
end

function love.update(dt) -- the update function gets called every frame (60 times in a second)
    backgroundScroll = (backgroundScroll + background_scroll_speed * dt)
        % background_looping_point
    -- scroll backgroung with present speed by dt (30 * dt) after that looping it back to 0 after looping point (if backgrounscroll > 413 then backgroundscrool = 0)

    groundScroll = (groundScroll + ground_scroll_speed * dt)
        % virtual_width
    --groundscroll = gscroll + GSspeed * dt (0 + 60 * 1,2,3(time) and will set it to 0 after Vwidth (512))

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {} -- when we go to next frame this will delete the table (part 4)
end

function love.draw() --this is used to render stuff
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, virtual_height - 16)
    push:finish()
end