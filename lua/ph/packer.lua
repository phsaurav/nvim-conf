-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "Shatur/neovim-ayu", as = "ayu" }

    -- vim.o.termguicolors = true

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use { 'ThePrimeagen/harpoon' }

    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use { 'justinmk/vim-sneak' }
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    })
    use {
        "hrsh7th/cmp-nvim-lsp",
        after = "nvim-cmp" -- Ensure it loads after nvim-cmp
    }

    use {
        "L3MON4D3/LuaSnip",
        requires = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        after = "nvim-cmp", -- Ensure LuaSnip loads after nvim-cmp
    }

    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.cmp") -- Move the config to a separate file
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-tree/nvim-tree.lua',
    }
end)
