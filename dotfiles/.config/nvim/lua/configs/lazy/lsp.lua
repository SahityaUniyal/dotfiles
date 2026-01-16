return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable('pyright')
            vim.lsp.enable('gopls')
            vim.lsp.enable('lua_ls')

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
            vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { noremap = true })

            -- Configure diagnostics for floating window
            vim.keymap.set("n", "<leader>dw", function()
                vim.diagnostic.open_float(nil, { focus = false })
            end, {})
        end,
    },
}
