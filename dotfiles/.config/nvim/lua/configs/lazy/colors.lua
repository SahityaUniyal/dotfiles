return {
    {
        "catppuccin/nvim",           -- Lazy load Catppuccin theme
        name = "catppuccin",
        priority = 1000,             -- High priority to load this theme first
        config = function()
            vim.cmd.colorscheme("catppuccin") -- Set the desired Catppuccin flavor, e.g., "latte", "macchiato", "mocha", "frappe"
        end,
    },
    -- {
    -- 	"rose-pine/neovim", -- Lazy load Catppuccin theme
    -- 	name = "rose-pine",
    -- 	priority = 2000, -- High priority to load this theme first
    -- 	config = function()
    -- 		vim.cmd.colorscheme("rose-pine") -- Set the desired Catppuccin flavor, e.g., "latte", "macchiato", "mocha", "frappe"
    -- 	end,
    -- },
}
