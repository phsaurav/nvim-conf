return {
	{
		"mfussenegger/nvim-dap",
		-- Defer loading until a DAP command is triggered
		cmd = { "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut", "DapTerminate" },
	},
	{
		"dreamsofcode-io/nvim-dap-go",
		ft = "go", -- Load only for Go files
		dependencies = "mfussenegger/nvim-dap", -- Ensure nvim-dap is loaded first
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
		-- Defer loading until a DAP command for Go is triggered
		cmd = { "GoDebug", "GoDebugStart" },
	},
	-- Custom key mappings for debugging Go
	config = function()
		local dap = require("dap")
		local dap_go = require("dap-go")

		-- Go specific debugging mappings
		vim.keymap.set("n", "<leader>ds", function()
			dap.continue()
		end, { desc = "Start/Continue Debugging" })

		vim.keymap.set("n", "<leader>do", function()
			dap.step_out()
		end, { desc = "Step Out" })

		vim.keymap.set("n", "<leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })

		vim.keymap.set("n", "<leader>dc", function()
			dap.clear_breakpoints()
		end, { desc = "Clear All Breakpoints" })

		vim.keymap.set("n", "<leader>dr", function()
			dap.repl.open()
		end, { desc = "Open Debug REPL" })

		vim.keymap.set("n", "<leader>dt", function()
			dap.terminate()
		end, { desc = "Terminate Debugger" })

		-- Start debugging a Go file
		vim.keymap.set("n", "<leader>dgs", function()
			dap_go.debug()
		end, { desc = "Start Go Debugging" })
	end,
}
