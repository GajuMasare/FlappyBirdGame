CountDownState = Class{__includes = BaseState}

countdown_time = 0.75
--speed of count down 1 sec is a little long so we keep it 0.75

function CountDownState:init()
    self.count = 3
    self.timer = 0
end

function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > countdown_time then
        self.timer = self.timer % countdown_time
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountDownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 120, virtual_width, 'center')
end