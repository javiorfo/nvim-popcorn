local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    width = 84,
    height = 25,
    border = borders.double_border,
    footer = { "Popcorn File", "Boolean" },
    content = "LICENSE",
}

popcorn:new(opts):pop()
