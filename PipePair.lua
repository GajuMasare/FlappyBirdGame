PipePair = Class{}

local gap_height = 120
--the gap between top and bottom pipe

function PipePair:init(y)
    self.x = virtual_width + 32
    -- the starting x location of the pipe
    
    self.y = y 
    --y is location of top pipe

    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + pipe_height + gap_height)
    }

    self.remove = false -- this is check if the pipe is ready to be removed we are using this logic so it wont cause glithces
    self.scored = false -- this is to chack if the score is really made or not
end 

function PipePair:update(dt)
    if self.x > - pipe_width then
        self.x = self.x - pipe_scroll_speed * dt
        self.pipes['lower'].x = self.x 
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end