local cmp = require("cmp")
local luasnip = require("luasnip")

-- Lazy load VSCode-style snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Tabnine configuration
-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
--     max_lines = 1000,            -- Max number of lines to read from the buffer
--     max_num_results = 20,        -- Max number of completion results
--     sort = true,                 -- Sort results by relevance
--     run_on_every_keystroke = true, -- Trigger completion on every keystroke
--     snippet_placeholder = '..'   -- Placeholder for snippet mode
-- })

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-d>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    }),
    sources = cmp.config.sources({
        -- { name = 'cmp_tabnine' }, -- Tabnine soue
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
    }, {
        { name = "buffer" },
    }),
})
