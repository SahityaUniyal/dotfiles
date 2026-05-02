return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- Install parsers (no-op if already installed)
			require("nvim-treesitter").install({
				"vimdoc",
				"javascript",
				"c",
				"lua",
				"go",
				"python",
				"jsdoc",
				"bash",
			})

			-- Enable treesitter highlighting via autocommand
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					-- Disable for html
					if ft == "html" then
						return
					end
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable treesitter-based indentation
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- Enable treesitter-based folding
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function()
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
				end,
			})

			-- For markdown, also enable syntax highlighting alongside treesitter
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "markdown" },
				callback = function()
					vim.cmd("syntax on")
				end,
			})

			-- Example: Adding custom parser (commented out)
			-- vim.api.nvim_create_autocmd("User", {
			-- 	pattern = "TSUpdate",
			-- 	callback = function()
			-- 		require("nvim-treesitter.parsers").templ = {
			-- 			install_info = {
			-- 				url = "https://github.com/vrischmann/tree-sitter-templ.git",
			-- 				branch = "master",
			-- 			},
			-- 		}
			-- 	end,
			-- })
			-- vim.treesitter.language.register("templ", "templ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = false,
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
