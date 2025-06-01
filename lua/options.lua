vim.g.mapleader = " "
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.path:append { '**' }
vim.opt.syntax = 'ON'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.fillchars = { eob = " " }
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.fileencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.pumheight = 10
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.termguicolors = true
vim.opt.spell = false
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.belloff = 'all'
vim.g.editorconfig = true
vim.cmd('filetype plugin on')
