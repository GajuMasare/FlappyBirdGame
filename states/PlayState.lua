PlayState = Class{__includes = BaseState}

pipe_scroll_speed = 60
pipe_height = 288
pipe_width = 70

bird_width = 38
bird_height = 24

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0

    self.lastPipeY = -pipe_height + math.random(80) + 20
    -- thaking the hight of last pipe and adding some random number into it so our next pipe will be playable and its gap will not be at imposible position
end

function PlayState:update(dt)
    self.timer = self.timer + dt
    --timer for pipe spawning

    if self.timer > 2 then
        local y = math.max(-pipe_height +10, --the gap area will start after 10px from top of the scrren
            math.min(self.lastPipeY + math.random(-20, 20), virtual_height - 90 - pipe_height)) -- -90 means the gap area will start above 90px from bottom of the screen/ -20,20 means this can be the gap size
        self.lastPipeY = y 
        -- modify the last Y coordinate we placed so pipe gaps aren't too far apart
        -- no higher than 10 pixels below the top edge of the screen,
        -- and no lower than a gap length (90 pixels) from the bottom


        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
        -- after 2 second we are adding a pipe() into pipes table and setting the timer to 0
    end

    for k, pair in pairs(self.pipePairs) do -- for every pipe with k id in pipes table (part 1)
        if not pair.scored then
            if pair.x + pipe_width < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                sounds['score']:play()
            end
            --if the score is not given when the bird goes through specific pairpipe then give it a score and set that to true so it wont give it more points
        end

        pair:update(dt) -- update pipe every frame so we will get movement (part 2)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    
    for k, pair in pairs(self.pipePairs) do
        for l,pipe in pairs(pair.pipes) do
            if self.bird:colliedes(pipe) then
                sounds['explosion']:play()
                sounds['hurt']:play()

                gStateMachine:change('score', {score = self.score}) --changing the state and sending the score with the function
            end
        end
    end
    
    self.bird:update(dt)
    
    if self.bird.y > virtual_height - 15 then
        sounds['explosion']:play()
        sounds['hurt']:play()
        
        gStateMachine:change('score', {score = self.score})
    end
    -- if the bird touch the ground then change the state to score and send the score with the function
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' ..tostring(self.score), 8,8)
    --live score on the top left

    self.bird:render()
end