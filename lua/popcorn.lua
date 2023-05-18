local borders = require'popcorn.borders'
local popcorn = {}

popcorn.callback = nil

local function bottom_amend(title, footer)
    if (#title % 2 == 0 and #footer % 2 == 0) or (#title % 2 ~= 0 and #footer % 2 ~= 0) then
        return false else return true
    end
end

local function clean_length(value)
    return #value:gsub("[\128-\191]", "")
end

local function build_popup(title, footer, width, height, border)
    local size_top_length = ((width - 4 - clean_length(title)) / 2)
    local side_top = string.rep(border.horizontal, size_top_length)
    local popup = {}

    title = title ~= "" and string.format(" %s ", title) or border.horizontal
    local top_line = string.format("%s%s%s%s%s", border.corner_left_up, side_top, title, side_top, border.corner_right_up)
    local top_line_length = clean_length(top_line)

    local lateral_line = string.format("%s%s%s", border.vertical, string.rep(" ", top_line_length - 2), border.vertical)

    local bottom_line
    if #footer == 0 then
        bottom_line = string.format("%s%s%s", border.corner_left_down, string.rep(border.horizontal, top_line_length - 2), border.corner_right_down)
    else
        local size_bottom_length = ((width - 4 - clean_length(footer)) / 2)
        local side_bottom = string.rep(border.horizontal, size_bottom_length)
        local side_bottom2 = string.rep(border.horizontal, bottom_amend(title, footer) and size_bottom_length - 1 or size_bottom_length)
        bottom_line = string.format("%s%s %s %s%s", border.corner_left_down, side_bottom, footer, side_bottom2, border.corner_right_down)
        if clean_length(bottom_line) < top_line_length then
            local add_bottom =  string.rep(border.horizontal, top_line_length - clean_length(bottom_line))
            bottom_line = string.format("%s%s %s %s%s", border.corner_left_down, side_bottom, footer, side_bottom2 .. add_bottom, border.corner_right_down)
        end
    end

    table.insert(popup, top_line)
    height = height - 2
    for _ = 1, height do
        table.insert(popup, lateral_line)
    end

    table.insert(popup, bottom_line)
    return popup
end

function popcorn:new(opts)
    popcorn.callback = opts.callback
    self.__index = self
    setmetatable(opts, self)
    return opts
end

function popcorn.execute_callback()
    if popcorn.callback then
        popcorn.callback()
        popcorn.callback = nil
        vim.cmd("quit")
    end
end

local function process_content(content)
    local result = {}
    for k, v in ipairs(content) do
        table.insert(result, v[1])
        if v[2] then
            vim.cmd(string.format("syn match popcornStyle%d '%s' | hi link popcornStyle%d %s", k, v[1], k, v[2]))
        end
    end

    return result
end

function popcorn:pop()
        if not self.border then
            self.border = borders.simple_border
        end
        local buf_border = vim.api.nvim_create_buf(false, true)
        local ui = vim.api.nvim_list_uis()[1]
        local width = self.width
        local height = self.height

        width = ui.width > width and width or (ui.width - 4)
        height = ui.height > height and height or (ui.height - 4)

        local footer_text = ""
        if self.footer then
            footer_text = self.footer[1] or footer_text
        end

        local title_text = ""
        if self.title then
            title_text = self.title[1] or title_text
        end

        local lines = build_popup(title_text, footer_text, width, height, (self.border or borders.simple_thick_border))

        vim.api.nvim_buf_set_lines(buf_border, 0, -1, true, lines)

        local opts_border = {
            relative = 'editor',
            width = width,
            height = height,
            col = (ui.width / 2) - (width / 2),
            row = (ui.height / 2) - (height / 2),
            style = 'minimal',
            focusable = false
        }

        vim.api.nvim_open_win(buf_border, true, opts_border)

        if self.title and self.title[1] and self.title[2] then
            vim.cmd(string.format("syn match popcornTitle '%s' | hi link popcornTitle %s", self.title[1], self.title[2]))
        end

        if self.footer and self.footer[1] and self.footer[2] then
            vim.cmd(string.format("syn match popcornFooter '%s' | hi link popcornFooter %s", self.footer[1], self.footer[2]))
        end

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

        if type(self.content) == "table" then
            vim.api.nvim_buf_set_lines(buf_text, 0, -1, true, process_content(self.content))
        elseif type(self.content) == "string" and self.content ~= "" and vim.fn.filereadable(self.content) then
            vim.cmd("e " .. self.content)
        elseif type(self.content) == "function" then
            self.content()
        end

        vim.api.nvim_create_autocmd({ "BufLeave" }, {
            pattern = { "<buffer>" },
            callback = function()
                pcall(vim.cmd, string.format("bd %d | quit", buf_border))
            end
        })

        local map_opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(buf_text, 'n', '<esc>', '<cmd>quit<cr>', map_opts)
        vim.api.nvim_buf_set_keymap(buf_text, 'n', '<cr>', '<cmd>lua require("popcorn").execute_callback()<cr>', map_opts)

        return buf_text
end

return popcorn
