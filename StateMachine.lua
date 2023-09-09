StateMachine = Class{}

function StateMachine:init(states) --the state machine will containnt this function will be null for now
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }
    self.states = states or {} -- if the state machines containtes a state then we will use that or make at empty
    self.current = self.empty -- at the start of the program we are making it as empty state
end

function StateMachine:change(stateName, enterParams) -- this shows how the state machine changes
    assert(self.states[stateName])
    self.current:exit() -- when we call to change the state then we will exit the current state eg.title state (part 1)
    self.current = self.states[stateName]() -- then we will change the current state to whichever we want eg.play state (part 2)
    self.current:enter(enterParams) -- then we will enter in that state with the information which that state will containt (part 3)
end

function StateMachine:update(dt) -- this shows how the state machine updates
    self.current:update(dt) -- when we call to update then the current state will update with dt
end

function StateMachine:render() -- this shows how the state machine renders
    self.current:render() -- when we call to render then the current state will render 
end