local awful = require("awful")


apps = {}

apps.arandr = function() awful.util.spawn("aeandr --force-version") end
apps.chrome = function() awful.util.spawn("google-chrome") end
apps.pcmanfm = function() awful.util.spawn("pcmanfm") end
apps.terminator = function() awful.util.spawn("terminator") end

return apps
