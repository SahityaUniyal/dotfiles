return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				-- Go
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.code_actions.gomodifytags,
				-- Python Formatters
				null_ls.builtins.formatting.black, -- Auto-format Python code (PEP8 compliant)
				null_ls.builtins.formatting.isort, -- Sort imports
			},
		})
		-- Automatically format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
