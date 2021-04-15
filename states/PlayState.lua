PlayState=Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70
BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
--initializing one bird, an array of pipes (which initialize pipes inside the method), a timer, a score 
--and a number to keep track of the height of inmediatly previous pipe pairs
self.bird = Bird()
self.pipePairs = {}
self.timer = 0
self.lastY = -PIPE_HEIGHT + math.random(80)+30
--lastY will be linked to the y of the pipe pairs. This lastY is passed to PipePair as the y for the top pipe.
--PipePair passes this y to Pipe, and Pipe understands. Being a top pipe, Pipe adds to this y the pipe height and then invert the image.
--So, actually, lastY refers to the y component of the top left corner of a top pipe. I supose 20 is approximately 
--the height of the pipe opening?, and then we add a random additional height between 0 and 80. 
--This way, it will always be posible to see at least the opening of the pipe.
self.score=0
end

function PlayState:update(dt)
--our bird and pipes should only move if we're not in pause
if paused==false then
self.timer = self.timer + dt
--modifying the timer so the pipes have a range between 2 and 30 to appear
if self.timer > math.random(2,30) then
--modifying height between pipe pairs. They should be no higher than 10 from top
--and no larger than 90 pixels
--I've found that 30 is the ideal height for the pipe openings to always be visible 
		local y = math.max(-PIPE_HEIGHT +30, math.min(self.lastY + math.random(-30,30),
		-90))
		--90 is supposed to be the height of the gap between pipes(in the initial version)
		--the second factor on math.min is initially VIRTUAL_HEIGHT-90-PIPE_HEIGHT, which can be shorten as -90
		--since VIRTUAL_HEIGHT=PIPE_HEIGHT=288, so, I'll change it. I'll change the first factor of math.min too
		--so the difference between gaps can be now up to 30. The free way now won't be so smooth, but not imposible either
		self.lastY = y
		table.insert(self.pipePairs, PipePair(y))
		self.timer = 0
	end

	self.bird:update(dt)

	for k, pair in pairs(self.pipePairs) do
	pair:update(dt)

		for l, pipe in pairs(pair.pipes) do
			if self.bird:collides(pipe) then
			sounds['explosion']:play()
			sounds['hurt']:play()
			gStateMachine:change('score', {score = self.score})
			end
		end
		
		if not pair.scored then
			if pair.x + PIPE_WIDTH < self.bird.x then
			self.score = self.score + 1
			pair.scored=true
			sounds['score']:play()
			end
		end
	end
	if self.bird.y > VIRTUAL_HEIGHT - 15 then
	sounds['explosion']:play()
	sounds['hurt']:play()
	gStateMachine:change('score', {score = self.score})
	end

	for k, pair in pairs(self.pipePairs) do
	if pair.remove then
	table.remove(self.pipePairs, k)
	end
	end
	
	
end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
	
	love.graphics.setFont(flappyFont)
	love.graphics.print('Score: ' .. tostring(self.score), 8,8)

    self.bird:render()
	if paused==true then
	love.graphics.setFont(hugeFont)
	love.graphics.printf('Pause', 0, VIRTUAL_HEIGHT/2 - 60, VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(mediumFont)
	love.graphics.printf('Press p to continue', 0, VIRTUAL_HEIGHT/2 +40, VIRTUAL_WIDTH, 'center')
	end
end
