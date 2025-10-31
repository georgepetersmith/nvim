require("options")
require("os")
require("keybinds")
require("lazy-pm")

if vim.g.neovide then
  require("neovide")
end

vim.o.background = "dark"
local status_ok, _ = pcall(function()
  vim.cmd.colorscheme("darcubox")
end)
if not status_ok then
  vim.cmd.colorscheme("default")
end
