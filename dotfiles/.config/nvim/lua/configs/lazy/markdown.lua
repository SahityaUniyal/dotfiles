return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {},
	config = function()
		md = require("markview")

		md.setup({
			preview = { enable = false },
		})

		-- vim.api.nvim_set_keymap(
		-- 	"n",
		-- 	"<leader>m",
		-- 	"<CMD>Markview<CR>",
		-- 	{ desc = "Toggles `markview` previews globally." }
		-- )

		vim.api.nvim_set_keymap(
			"n",
			"<leader>m",
			"<CMD>Markview splitToggle<CR>",
			{ desc = "Toggles `splitview` for current buffer." }
		)
	end,
}
