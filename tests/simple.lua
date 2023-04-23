local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    width = 100,
    height = 8,
--     border = borders.rounded_corners_border,
    border = borders.simple_thick_border,
    title = { "SHIP", "Boolean" },
    footer = { "Bottom Titldfasd", "String" },
    content = {
        { "Project Metadata: ", "Type" },
        { "   Group    =>", "Annotation" },
        { "   Artifact =>" },
    },
--     content = "/home/javier/.local/share/nvim/site/pack/packer/start/nvim-ship/tests/ships/auth.ship",
--[[     content = function()
        vim.cmd("start | term lua /home/javier/Documentos/lua/oop.lua")
    end, ]]
    callback = function()
    end
}

popcorn:new(opts):pop()
