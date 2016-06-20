local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

battery_widget = wibox.widget.textbox()
battery_widget:set_align("right")

local color_red = "#CC9393"
local color_green = "#7F9F7F"
local color_yellow = "#F0DFAF"
local color_fg = "#DCDCCC"


function update_battery(widget)
    local fd = io.popen("acpi -b | sed 's/^.*: //' | sed 's/[a-zA-Z ]*$//' | sed 's/, /,/g'")
    local stats = fd:read("*all")
    fd:close()

    local status = string.match(stats, "^(%a+)")
    local percentage = string.match(stats, ",(%d+)%%")
    local time = string.match(stats, ",(%d+:%d%d:%d%d)\n$") or "Unknown"

    color = color_fg
    template = " <span color='%s'>%s</span> "
    if status:match("Charging") then
        message = "⚇ CHR " .. percentage .. "% " .. time
    elseif status:match("Discharging") then
        message = "⚡ BAT " .. percentage .. "% " .. time
        if tonumber(percentage) < 20 then
            color = color_yellow
        end
        if tonumber(percentage) < 15 then
            color = color_red
            naughty.notify({
                title="Low battery charge",
                text="Battery charge is low. "..percentage.."% left. Connect your A/C adapter.",
                timeout=1,
                position="top_right",
                fg=beautiful.fg_focus,
                bg=beautiful.bg_focus
            })
        end
    elseif status:match("Full") then
        color = color_green
        message = "⚉ FULL " .. percentage .. "%"
    else
        -- assume we are on A/C
        color = color_yellow
        message = "⚉ A/C " .. percentage .. "%"
    end
    battery = template:format(color, message)
    widget:set_markup(battery)
end

update_battery(battery_widget)

battery_timer = timer({ timeout = 1 })
battery_timer:connect_signal("timeout", function () update_battery(battery_widget) end)
battery_timer:start()
