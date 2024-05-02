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
    callback_keymap = "<C-Space>",
    callback = function()
        print("Callback result =>" .. (string.gsub(vim.fn.getline(1), "Type value:", "")))
        return function()
            vim.cmd("quit")
        end
    end,
    do_after = function()
        vim.api.nvim_win_set_cursor(0, { 1, 13 })
    end
}

popcorn:new(opts):pop()
