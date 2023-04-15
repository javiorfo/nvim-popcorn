local M = {}

M.simple_border = {
    horizontal        = "─",
    vertical          = "│",
    corner_left_up    = "┌",
    corner_right_up   = "┐",
    corner_right_down = "┘",
    corner_left_down  = "└"
}

M.simple_thick_border = {
    horizontal        = "━",
    vertical          = "┃",
    corner_left_up    = "┏",
    corner_right_up   = "┓",
    corner_right_down = "┛",
    corner_left_down  = "┗"
}

M.double_border = {
    horizontal        = "═",
    vertical          = "║",
    corner_left_up    = "╔",
    corner_right_up   = "╗",
    corner_right_down = "╝",
    corner_left_down  = "╚"
}

M.rounded_corners_border = {
    horizontal        = "─",
    vertical          = "│",
    corner_left_up    = "╭",
    corner_right_up   = "╮",
    corner_right_down = "╯",
    corner_left_down  = "╰"
}

M.double_simple_border = {
    horizontal        = "═",
    vertical          = "│",
    corner_left_up    = "╒",
    corner_right_up   = "╕",
    corner_right_down = "╛",
    corner_left_down  = "╘"
}

return M
