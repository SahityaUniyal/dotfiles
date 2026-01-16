return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "gopls", "pyright", "harper_ls" },
            })
        end,
    },
    {
        "jayp0521/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "stylua",
                    "prettier",
                    -- Go
                    "golangci_lint",
                    "goimports",
                    "gomodifytags",
                    -- Python Formatters
                    "black", -- Auto-format Python code (PEP8 compliant")
                    "isort", -- Sort import"s
                }
            })
        end,
    }
}
