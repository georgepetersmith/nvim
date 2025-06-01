local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_windows = has "win32"

if is_mac then
  vim.opt.clipboard:apend { "unnamedplus" }
end
if is_windows then
  vim.opt.clipboard:prepend { "unnamed","unnamedplus" }

  vim.o.shell= "pwsh"
  vim.o.shellcmdflag= "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellquote= ""
  vim.o.shellxquote= ""
  vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
end
