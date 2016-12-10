local awful = require("awful")


volume = {}

volume._increase = function(percentage)
    local command = string.format("amixer sset Master,0 %d%%+", percentage)
    awful.util.spawn(command)
end
volume.increase = function()
    volume._increase(5)
end

volume._decrease = function(percentage)
    local command = string.format("amixer sset Master,0 %d%%-", percentage)
    awful.util.spawn(command)
end
volume.decrease = function()
    volume._decrease(5)
end

volume.toggle = function()
    local command = "amixer sset Master,0 toggle"
    awful.util.spawn(command)
end


return volume
