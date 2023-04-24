local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    width = 50,
    height = 8,
    border = borders.simple_border,
    title = { "Popcorn Simple", "Boolean" },
    footer = { "Popcorn Bottom", "String" },
    content = {
        { "Hello There! ", "Type" },
        { "" },
        { "This is a paragraph."},
        { "This is another paragraph." },
    },
}

popcorn:new(opts):pop()
