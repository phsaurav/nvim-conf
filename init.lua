require("ph")
vim.opt.clipboard:append("unnamedplus")
vim.opt.mouse = "a"

color = color or 'ayu'

require('ayu').setup({
    mirage = true,
    terminal = true,
    overrides = {
        Normal = { bg = "None" },
        ColorColumn = { bg = "None" },
        SignColumn = { bg = "None" },
        Folded = { bg = "None" },
        FoldColumn = { bg = "None" },
        CursorLine = { bg = "None" },
        CursorColumn = { bg = "None" },
        WhichKeyFloat = { bg = "None" },
        VertSplit = { fg = "NONE", bg = "NONE" },
        LineNr = { fg = "#5c422e", bg = "NONE" },
        CursorLineNr = { fg = "#ffaf00", bg = "NONE" },
    },
})

vim.cmd.colorscheme(color)
