local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    width = 100,
    height = 8,
    border = borders.rounded_corners_border,
    title = {
        text = "Testing Title",
        link_to = "Boolean"
    },
    text = {
        "Project Metadata",
        "   Group    =>",
        "   Artifact =>",
        "   Name     =>",
        "Language    =>",
    },
    callback = function()
    end
}

popcorn:new(opts):pop()
