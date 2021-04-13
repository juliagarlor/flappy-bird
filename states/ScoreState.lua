ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
self.score=params.score
end

function ScoreState:update()
if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
gStateMachine:change('play')
end
end

function ScoreState:render()
if self.score >= topb then
	if self.score >= tops then
		if self.score >= topg then
		topg = self.score
		love.graphics.draw(gold, VIRTUAL_WIDTH/2 - (42*3/2), 30, 0, 3, 3)
		else
		tops = self.score
		love.graphics.draw(silver, VIRTUAL_WIDTH/2 - (42*3/2), 30, 0, 3, 3)
		end
	else
	topb = self.score
	love.graphics.draw(bronze, VIRTUAL_WIDTH/2 - (42*3/2), 30, 0, 3, 3)
	end
love.graphics.setFont(hugeFont)
love.graphics.printf('New record: ' .. tostring(self.score)..'!', 0, VIRTUAL_HEIGHT/2,VIRTUAL_WIDTH, 'center')

else
love.graphics.setFont(flappyFont)
love.graphics.printf('Oooh! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

love.graphics.setFont(mediumFont)
love.graphics.printf('Score: ' .. tostring(self.score),0, 100, VIRTUAL_WIDTH, 'center')
love.graphics.printf('Press Enter to play again!', 0, 160, VIRTUAL_WIDTH, 'center')

love.graphics.draw(bronze, VIRTUAL_WIDTH/3 - 20, 190, 0, 1, 1)
love.graphics.draw(silver, VIRTUAL_WIDTH/2 -20, 190, 0, 1, 1)
love.graphics.draw(gold, 2*VIRTUAL_WIDTH/3-20, 190, 0, 1, 1)
love.graphics.printf(tostring(topb),VIRTUAL_WIDTH/3 - 5, 250, VIRTUAL_WIDTH/3, 'left')
love.graphics.printf(tostring(tops),VIRTUAL_WIDTH/2-5, 250, VIRTUAL_WIDTH/3, 'left')
love.graphics.printf(tostring(topg),2*VIRTUAL_WIDTH/3-5, 250, VIRTUAL_WIDTH/3, 'left')
end
end