ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed ('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown') 
    end
    -- when the score state starts its mean we have lost and if we press inter then we will go back to play state
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, virtual_width, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' ..tostring(self.score), 0, 100, virtual_width, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, virtual_width, 'center')
end