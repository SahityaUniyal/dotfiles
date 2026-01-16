return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim"
        },
        config = function()
            require('telescope').setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })

            -- Load extensions
            require("telescope").load_extension("ui-select")

            local builtin = require('telescope.builtin')
            -- Regular find_files without hidden files
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

            -- New keybinding for finding hidden files
            vim.keymap.set('n', '<leader>ph', function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                    follow = true
                })
            end, { desc = "Find hidden files" })

            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>pws', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end)
            vim.keymap.set('n', '<leader>pWs', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        end
    }
}
