Pipe = Class{}

local pipe_image = love.graphics.newImage('assets/pipe.png')
-- imported the image

pipe_scroll_speed = 60

pipe_height = 430
pipe_width = 70

function Pipe:init(orientation, y)
    self.x = virtual_width
    self.y = y 

    self.width = pipe_width
    self.height = pipe_height

    self.orientation = orientation
end

function Pipe:update(dt)

end

function Pipe:render()
    love.graphics.draw(pipe_image, self.x,
        (self.orientation == 'top' and self.y + pipe_height or self.y),
        0, -- roatation 
        1, -- x scale
        self.orientation == 'top' and -1 or 1) -- y scale
end