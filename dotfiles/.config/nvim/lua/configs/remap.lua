vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- move line up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete the line below and append it to the end
vim.keymap.set("n", "J", "mzJ`z")
-- paste something into the selected area without overwriting the default register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- YANK
-- yank to the selected text to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- yank to the complete line to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without placing in register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- formats the selected json in json format
vim.keymap.set("v", "jq", "!jq .<CR>")
