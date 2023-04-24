local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    width = 100,
    height = 20,
    border = borders.double_simple_border,
    title = { "Popcorn Terminal", "WarningMsg" },
    content = function()
        vim.cmd("start | term")
    end
}

popcorn:new(opts):pop()
