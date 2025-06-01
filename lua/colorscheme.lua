vim.o.background = 'dark'

local status_ok, err = pcall(
  function()
    vim.cmd.colorscheme("solarized-osaka")
  end
)
if not status_ok then
  vim.cmd.colorscheme("default")
end
