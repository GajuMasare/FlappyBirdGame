-- this file is used so we can console log if we are using any print() statement

function love.conf(t)
    t.console = false
    t.modules.joystick = false
    t.externalstorage = true

    t.window.width = 960
    t.window.height = 720
end