return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")
		local action_state = require("telescope.actions.state")

		local custom_actions = {}

		function custom_actions.fzf_multi_select(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local num_selections = #picker:get_multi_selection()

			if num_selections > 1 then
				actions.close(prompt_bufnr)
				for _, entry in ipairs(picker:get_multi_selection()) do
					vim.cmd(string.format("%s %s", "edit", entry.value))
				end
			else
				actions.file_edit(prompt_bufnr)
			end
		end

		-- Function to open selected file in horizontal split
		function custom_actions.file_split(prompt_bufnr)
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(string.format("split %s", selection.value))
		end

		-- Function to open selected file in vertical split
		function custom_actions.file_vsplit(prompt_bufnr)
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(string.format("vsplit %s", selection.value))
		end

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-t>"] = trouble_telescope.open,
						["<C-h>"] = custom_actions.file_split,
						["<C-v>"] = custom_actions.file_vsplit,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		keymap.set("n", "<leader>fd", builtin.git_files, { desc = "Git File Search" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
	end,
}
