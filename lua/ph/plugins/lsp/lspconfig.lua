return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		local lspconfig_defaults = require("lspconfig").util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			"force",
			lspconfig_defaults.capabilities,
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("lspattach", {
			group = vim.api.nvim_create_augroup("userlspconfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "show lsp references"
				keymap.set("n", "gr", "<cmd>telescope lsp_references<cr>", opts) -- show definition, references

				opts.desc = "go to declaration"
				keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts) -- go to declaration

				opts.desc = "show lsp implementations"
				keymap.set("n", "gi", "<cmd>telescope lsp_implementations<cr>", opts) -- show lsp implementations

				opts.desc = "show lsp type definitions"
				keymap.set("n", "gt", "<cmd>telescope lsp_type_definitions<cr>", opts) -- show lsp type definitions

				opts.desc = "see available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "show buffer diagnostics"
				keymap.set("n", "<leader>df", "<cmd>telescope diagnostics bufnr=0<cr>", opts) -- show  diagnostics for file

				opts.desc = "show line diagnostics"
				keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "go to previous diagnostic"
				keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "go to next diagnostic"
				keymap.set("n", "<leader>dp", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "restart lsp"
				keymap.set("n", "<leader>rs", ":lsprestart<cr>", opts) -- mapping to restart lsp if necessary
			end,
		})

		local signs = { error = " ", warn = " ", hint = "󰠠 ", info = " " }
		for type, icon in pairs(signs) do
			local hl = "diagnosticsign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig.gopls.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				-- Custom actions when LSP is attached to buffer
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			end,

			settings = {
				gopls = {
					completeUnimported = true,
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					usePlaceholders = true,
				},
			},
		})
	end,
}
