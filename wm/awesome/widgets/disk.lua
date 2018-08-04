-- {{{ Imports

-- Standart awesome library
local wibox = require("wibox")
local vicious = require("vicious")

local utils = require("widgets/common");
-- }}}


local function disk_status(diskname)
  return utils.label_wrap(
    '[' .. diskname .. ']',
    function ()
      local state = {
        disk = diskname,
        widget = wibox.widget.textbox(),
      }
      state.size_key = '{' .. state.disk .. ' size_gb}'
      state.used_key = '{' .. state.disk .. ' used_gb}'
      vicious.register(
        state.widget,
        vicious.widgets.fs,
        function (w, data)
          return data[state.used_key] .. '/' .. data[state.size_key]
        end)
      return state.widget
    end
  )()
end


return disk_status
