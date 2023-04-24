local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    width = 50,
    height = 8,
    border = borders.rounded_corners_border,
    title = { "Popcorn Callback" },
    content = {
        { "Type value: ", "Boolean" }
    },
    callback = function()
        print("Callback result => " .. (string.gsub(vim.fn.getline(1), "Type value: ", "")))
    end
}

popcorn:new(opts):pop()
