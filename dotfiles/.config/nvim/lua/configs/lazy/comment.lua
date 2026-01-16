return {
    {
        "tpope/vim-commentary",
        config = function()
            -- Commentary keybindings
            vim.keymap.set("n", "<C-_>", ":Commentary<CR>")
            vim.keymap.set("v", "<C-_>", ":Commentary<CR>")    
        end,
    },
}
