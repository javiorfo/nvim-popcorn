-- ########################################################
-- # Maintainer: Javier Orfo                              #
-- # URL:        https://github.com/javiorfo/nvim-popcorn #
-- ########################################################

local M = {}
local borders = {
    horizontal        = "─",
    vertical          = "│",
    corner_left_up    = "┌",
    corner_right_up   = "┐",
    corner_right_down = "┘",
    corner_left_down  = "└"
}

M.callback = nil

local function build_popup(title, width, height)
    local size_top_length = ((width - 4 - #title) / 2)
    local side_top = string.rep(borders.horizontal, size_top_length)
    local popup = {}
    local top_line = string.format("%s%s %s %s%s", borders.corner_left_up, side_top, title, side_top, borders.corner_right_up)
    local top_line_length = #top_line:gsub("[\128-\191]", "")
    local lateral_line = string.format("%s%s%s", borders.vertical, string.rep(" ", top_line_length - 2), borders.vertical)
    local bottom_line = string.format("%s%s%s", borders.corner_left_down, string.rep(borders.horizontal, top_line_length - 2), borders.corner_right_down)
    table.insert(popup, top_line)
    height = height - 2
    for _ = 1, height do
        table.insert(popup, lateral_line)
    end
    table.insert(popup, bottom_line)
    return popup
end

function M:new(opts)
    opts = {
        width = 40,
        height = 8,
        title = "Probando",
        text = { "line 1", "line 2" },
        callback = function() print("callbackote") end
    }
    M.callback = opts.callback
    self.__index = self
    setmetatable(opts, self)
    return opts
end

function M.execute_callback()
    -- TODO close popup before
    M.callback()
    M.callback = nil
end

function M:pop()
        local buf_border = vim.api.nvim_create_buf(false, true)
        local ui = vim.api.nvim_list_uis()[1]
        local width = self.width
        local height = self.height

        local lines = build_popup(self.title, width, height)
        vim.api.nvim_buf_set_lines(buf_border, 0, -1, true, lines)

        local opts_border = { relative = 'editor',
            width = width,
            height = height,
            col = (ui.width / 2) - (width / 2),
            row = (ui.height / 2) - (height / 2),
            style = 'minimal',
            focusable = false
        }

        vim.api.nvim_open_win(buf_border, true, opts_border)
        vim.cmd("syn keyword wildcatInfoTitle WILDCAT | hi link wildcatInfoTitle Boolean")

        local opts_text = {
            relative = 'editor',
            row = opts_border.row + 1,
            height = opts_border.height - 2,
            col = opts_border.col + 2,
            width = opts_border.width - 4,
            style = 'minimal',
        }

        local buf_text = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_open_win(buf_text, true, opts_text)
        vim.cmd("syn keyword wildcatInfoText Server App Base Deployed Home | hi link wildcatInfoText Boolean")

        vim.api.nvim_buf_set_lines(buf_text, 0, -1, true, self.text)

        vim.cmd(string.format("au BufLeave <buffer> bd %d | quit", buf_border))
        -- TODO cambiar por nvim_buf_set_keymap
        vim.cmd("nnoremap <buffer> <esc> <cmd>quit<cr>")
        vim.cmd("nnoremap <buffer> <cr> <cmd>lua require'popcorn'.execute_callback()<cr>")
end

return M
