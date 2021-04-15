TitleScreenState = Class{__includes = BaseState}
--inheriting from BaseState

function TitleScreenState:update(dt)
if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
gStateMachine:change('countdown')
end
end

function TitleScreenState:render()
love.graphics.setFont(flappyFont)
love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')
love.graphics.setFont(mediumFont)
love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
love.graphics.printf('Press p to pause', 0, 150, VIRTUAL_WIDTH, 'center')
end