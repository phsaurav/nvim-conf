return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings
			api.config.mappings.default_on_attach(bufnr)
			local keymap = vim.keymap
			local opt = { noremap = true, silent = true }

			-- Custom mappings
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Parent"))
			vim.keymap.set("n", "l", api.node.open.no_window_picker, opts("Open File No Window Picker"))
			-- Open the selected file in a horizontal split
			vim.keymap.set("n", "<leader>sh", function()
				api.node.open.horizontal()
			end, opts("Open: Horizontal Split"))

			-- Open the selected file in a vertical split
			vim.keymap.set("n", "<leader>sv", function()
				api.node.open.vertical()
			end, opts("Open: Vertical Split"))
		end

		-- Nvim-tree setup
		require("nvim-tree").setup({
			sort_by = "case_sensitive", -- Correct key for sorting
			view = {
				width = 35,
				relativenumber = true,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = true,
			},
			on_attach = my_on_attach,
		})

		-- Key mappings
		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus on current file in file explorer" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse all in file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
