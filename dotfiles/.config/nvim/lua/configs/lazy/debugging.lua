return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require("dap-go").setup()
			require("nvim-dap-virtual-text").setup()
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set conditional breakpoint" })
			vim.keymap.set("n", "<Leader>?", function()
				dapui.eval(nil, { enter = true })
			end)
			-- vim.keymap.set("n", "<Leader>dB", dap.set_breakpoint, {})

			vim.keymap.set("n", "<F1>", dap.continue, {})
			vim.keymap.set("n", "<F2>", dap.step_into, {})
			vim.keymap.set("n", "<F3>", dap.step_over, {})
			vim.keymap.set("n", "<F4>", dap.step_out, {})
			vim.keymap.set("n", "<F5>", dap.step_back, {})
			vim.keymap.set("n", "<F6>", dap.restart, {})
		end,
	},
}
