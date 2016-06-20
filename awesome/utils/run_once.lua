local awful = require("awful")


function run_once(name, arg_string)
    if not arg_string then
        awful.util.spawn_with_shell("pgrep -u $USER '" .. name .. "' || (" .. name ..  ")")
    else
        awful.util.spawn_with_shell("pgrep -u $USER '" .. name .. "' || (" .. name .. " " .. arg_string .. ")")
    end
end
