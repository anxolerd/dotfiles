local utils = require("widgets/common");

local battery = require("widgets/battery");
local disk = require("widgets/disk");
local brightness = require("widgets/brightness");
local volume = require("widgets/volume");

return {
    battery = battery,
    disk = disk,
    brightness = brightness,
    volume = volume,
    separator = utils.separator,
};
