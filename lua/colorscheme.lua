vim.o.background = 'dark'

local status_ok, err = pcall(
  function()
    vim.cmd.colorscheme("darcubox")
  end
)
if not status_ok then
  vim.cmd.colorscheme("retrobox")
end
