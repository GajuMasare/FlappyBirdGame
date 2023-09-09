Bird = Class{}

local gravity = 4

function Bird:init()
    self.image = love.graphics.newImage('assets/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getWidth()
    -- loaded image and sets its height and width to its acctual size

    self.x = virtual_width / 2 - (self.width / 2)
    self.y = virtual_height / 2 - (self.height / 2)
    --postion of bird is set to center

    self.dy = 0
    -- y velocity; gravity
end
 
function Bird:colliedes(pipe)
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + pipe_width then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + pipe_height then
            return true
        end
    end
    return false
end

function Bird:update(dt)
    self.dy = self.dy + gravity * dt
    --appling gravity velocity

    self.y = self.y + self.dy
    --appling the velocity to y postion so it will move the image

    if love.keyboard.wasPressed('space') then
        self.dy = -0.5
        sounds['jump']:play()
    end 

    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end