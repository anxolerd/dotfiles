local awful = require("awful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local function brightness_widget()
  local request_command = "brightnessctl -m"

  local bar_color = "#eed202"
  local background_color = "#3a3a3a"

  local icons = {
    [0]  = "🔅",
    [50] = "🔆",
  }

  local brightness_icon = wibox.widget.textbox()
  local brightnessbar_widget = wibox.widget {
      max_value = 1,
      forced_width = 50,
      paddings = 0,
      border_width = 0.5,
      color = bar_color,
      background_color = background_color,
      shape = gears.shape.bar,
      clip = true,
      margins       = {
          top = 10,
          bottom = 10,
      },
      widget = wibox.widget.progressbar
  }

  local update_graphic = function(widget, stdout, _, _, _)
      local brightness_level = tonumber(string.match(stdout, '([0-9]+)%%'))

      widget.color = bar_color
      widget.value = brightness_level / 100;
      local icon = icons[0]
      for threshold, range_icon in pairs(icons) do
        if brightness_level > threshold then
          icon = range_icon
        end
      end
      brightness_icon:set_text(icon .. ' ')
  end

  brightnessbar_widget:connect_signal("button::press", function(_,_,_,button)
      if (button == 4)     then awful.spawn("brightnessctl s 5%+", false)
      elseif (button == 5) then awful.spawn("brightnessctl s  5%-", false)
      end

      awful.spawn.easy_async(request_command, function(stdout, stderr, exitreason, exitcode)
          update_graphic(brightnessbar_widget, stdout, stderr, exitreason, exitcode)
      end)
  end)

  watch(request_command, 1, update_graphic, brightnessbar_widget)

  return wibox.widget {
    brightness_icon,
    brightnessbar_widget,
    layout = wibox.layout.align.horizontal,
  }
end

return brightness_widget
