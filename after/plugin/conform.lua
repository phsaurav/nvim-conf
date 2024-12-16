local conform = require('conform')
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

vim.keymap.set({ "n", "v" }, "<leader>;", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500
    })
end, { desc = "Format file or range (in visual mode)" })

conform.setup({
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
    formatters = {
        go = { "gofmt", "goimports_revisor" },
    },
})
