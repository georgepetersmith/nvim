local fontsize = 16

function setguifontsize(size)
  vim.o.guifont = "JetbrainsMono Nerd Font:h" .. size
end

function adjustguifontsize(adjustment)
  fontsize = fontsize + adjustment
  setguifontsize(fontsize)
end

setguifontsize(fontsize)

vim.keymap.set("n", "<c-->", function()
  adjustguifontsize(-1)
end)
vim.keymap.set("n", "<c-=>", function()
  adjustguifontsize(1)
end)

vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
