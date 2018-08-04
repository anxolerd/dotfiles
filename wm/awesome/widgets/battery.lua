-- {{{ Imports

-- Standart awesome library
local wibox = require("wibox")
local vicious = require("vicious")

-- Utilities for widget making
local utils = require("widgets/common");
-- }}}


local status_icons = {
    ["-"] = "🔋",  -- Discharging
    ["−"] = "🔋",  -- Discharging (old status)
    ["+"] = "🔌",  -- Charging
    ["↯"] = "⚡",  -- Full/Charged
    ["⌁"] = "🤷"   -- WTF
}



local function battery()
  return utils.label_wrap(
    'BAT ',
    function ()
      local widget = wibox.widget.textbox()
      vicious.register(
        widget,
        vicious.widgets.bat,
        function(widget, args)
          local status = args[1]
          local percent = args[2]
          local time_left = args[3]
          if time_left == "N/A" then
            return string.format(
              "%s %s%%",
              status_icons[status],
              percent
            )
          else
            return string.format(
              "%s %s%% (%s)",
              status_icons[status],
              percent,
              time_left
            )
          end
        end,
        5,
        "BAT0")
      return widget
    end)()
end

return battery
