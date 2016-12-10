local awful = require("awful")


brightness = {}

brightness._increase = function(percentage)
    local command = string.format("xbacklight + %d%%", percentage)
    awful.util.spawn(command)
end
brightness.increase = function()
    brightness._increase(5)
end


brightness._decrease = function(percentage)
    local command = string.format("xbacklight - %d%%", percentage)
    awful.util.spawn(command)
end
brightness.decrease = function()
    brightness._decrease(5)
end


return brightness
