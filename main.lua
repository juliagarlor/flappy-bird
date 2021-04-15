push= require 'push'
Class=require 'Class'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/CountdownState'
require 'states/TitleScreenState'
--require 'Medal'

WINDOW_WIDTH=1280
WINDOW_HEIGHT= 720

VIRTUAL_WIDTH=512
VIRTUAL_HEIGHT=288

--in flappy birds there are two different background that pass at different speed:
local background = love.graphics.newImage('background.png')
local backgroundScroll = 0
local ground= love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED=30
local GROUND_SCROLL_SPEED=60

local BACKGROUND_LOOPING_POINT=413


function love.load()
love.graphics.setDefaultFilter('nearest','nearest')

love.window.setTitle('Flappy Bird')

smallFont = love.graphics.newFont('font.ttf',8)
mediumFont = love.graphics.newFont('flappy.ttf',14)
flappyFont = love.graphics.newFont('flappy.ttf',28)
hugeFont = love.graphics.newFont('flappy.ttf',56)
love.graphics.setFont(flappyFont)

push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
vsync=true,
fullscreen=false,
resizable=true
})

gold = love.graphics.newImage('goldenBird.png')
silver = love.graphics.newImage('silverBird.png')
bronze = love.graphics.newImage('bronzeBird.png')
topg = 40
tops = 20
topb = 10

sounds ={
['jump']=love.audio.newSource('sounds/Jump.wav', 'static'),
['explosion']=love.audio.newSource('sounds/Explosion3.wav', 'static'),
['hurt']=love.audio.newSource('sounds/Blip_Select.wav', 'static'),
['score']=love.audio.newSource('sounds/Powerup4.wav', 'static'),
['music']=love.audio.newSource('sounds/marios_way.mp3', 'static')
}

gStateMachine = StateMachine{
['title'] = function () return TitleScreenState() end,
['countdown'] = function() return CountdownState() end,
['play'] = function() return PlayState() end,
['score'] = function() return ScoreState() end
}
sounds['music']:setLooping(true)
sounds['music']:play()
gStateMachine:change('title')

--lets create a boolean value for tracking whether we're in pause or not
paused = false

love.keyboard.keysPressed={}

end

function love.resize(w,h)
push:resize(w,h)
end

function love.keypressed(key)
if key== 'escape' then
love.event.quit()
end
--press p to pause
if key== 'p' then
	if paused==false then
	paused = true
	else
	paused = false
	end
end
love.keyboard.keysPressed[key]=true
end

function love.keyboard.wasPressed(key)
if love.keyboard.keysPressed[key] then
return true
else
return false
end
end

function love.update(dt)
gStateMachine:update(dt)

love.keyboard.keysPressed={}

if paused==false then
backgroundScroll= (backgroundScroll + BACKGROUND_SCROLL_SPEED*dt)
		% BACKGROUND_LOOPING_POINT
	
groundScroll= (groundScroll + GROUND_SCROLL_SPEED*dt)
		%VIRTUAL_WIDTH
end
end

function love.draw()
push:start()
love.graphics.draw(background,-backgroundScroll ,0)
gStateMachine:render()
love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)
--observe that the background and ground get ordered in different layers

push:finish()
end