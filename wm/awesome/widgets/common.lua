local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local colorize_cache = {}

local colorSet = {
  '#e5fc99',
  '#b4fc99',
  '#fce299',
  '#b299fc',
  '#99e3fc',
  '#99b2fc',
  '#fc99fa',
}

local function _colorize(str)
  if colorize_cache[str] == nil then
    colorize_cache[str] = colorSet[math.random(#colorSet)]
  end
  return '<span color="' .. colorize_cache[str] .. '">' .. str .. '</span>'
end


local function label_wrap(label_text, func)
  local caption = wibox.widget.textbox(_colorize(label_text))

  return function ()
    return wibox.widget {
      wibox.container.margin(caption, 4, 2, 2),
      wibox.container.margin(func(), 0, 4, 2),
      layout = wibox.layout.align.horizontal,
    }
  end
end


local function separator()
  return wibox.widget.textbox(_colorize(' ⟨ '))
end

return {
    label_wrap = label_wrap,
    separator = separator,
}
