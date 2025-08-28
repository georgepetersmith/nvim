vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Allow leader w to prefix window commands" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Esc enters normal mode in the terminal" })
vim.keymap.set("n", "<C-k><C-w>", "<cmd>%bd<cr>", { desc = "Delete the current buffer" })
vim.keymap.set("n", "<C-w>q", "<cmd>%bd<cr>", { desc = "Delete the current buffer" })
