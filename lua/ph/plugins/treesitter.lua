return{
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            highlight = {
                enable = true,
            },
            -- enable indentation
            indent = { enable = true },
            ensure_installed = { "lua", "markdown", "json", "yaml", "vim", "bash","markdown_inline", "go", "javascript",  "dart", "python" },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>]",
                    node_incremental = "<leader>]",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end
}
