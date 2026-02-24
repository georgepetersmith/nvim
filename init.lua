---@diagnostic disable: missing-fields

local enabled_lsps = {
  "roslyn",
  "rust_analyzer",
  "lua_ls",
  "ts_ls",
  "html",
  "css",
}

local treesitter_parsers = {
  "bash",
  "c",
  "c_sharp",
  "cpp",
  "csv",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",
  "json",
  "jsonc",
  "toml",
  "yaml",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  "python",
  "go",
  "rust",
  "sql",
  "dockerfile",
  "gitignore",
}

vim.g.mapleader = " "
vim.opt.winborder = "single"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.path:append({ "**" })
vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.fillchars = { eob = " " }
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.pumheight = 10
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.termguicolors = true
vim.opt.spell = false
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.belloff = "all"
vim.opt.foldlevelstart = 99

vim.g.editorconfig = true

vim.cmd("filetype plugin on")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
local is_windows = has("win32")

if is_mac then
  vim.opt.clipboard:append({ "unnamedplus" })
end
if is_windows then
  vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })

  vim.o.shell = "pwsh"
  vim.o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
end

vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Allow leader w to prefix window commands" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Esc enters normal mode in the terminal" })
vim.keymap.set("n", "<C-w>q", "<cmd>%bd<cr>", { desc = "Delete the current buffer" })
vim.keymap.set("n", "<Leader>yf", '<cmd>let @+=expand("%:p")<CR>', { desc = "Copy full path" })
vim.keymap.set("n", "<Leader>yr", '<cmd>let @+=expand("%")<CR>', { desc = "Copy relative path" })
vim.keymap.set("n", "<Leader>yn", '<cmd>let @+=expand("%:t")<CR>', { desc = "Copy relative path" })

vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })
require("vague").setup({})
vim.api.nvim_set_option_value("background", "dark", {})
vim.cmd.colorscheme("vague")

-- Full path to system clipboard
vim.keymap.set("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Copied full path: " .. vim.fn.getreg("+"))
end)
-- Relative path
vim.keymap.set("n", "<leader>yr", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  print("Copied relative path: " .. vim.fn.getreg("+"))
end)
-- Filename only
vim.keymap.set("n", "<leader>yn", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
  print("Copied filename: " .. vim.fn.getreg("+"))
end)

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
require("fzf-lua").setup({
  fzf_colors = true,
  keymap = {
    builtin = {
      true,
      ["<Esc>"] = "hide",
    },
  },
  winopts = {
    preview = {
      hidden = "hidden",
    },
  },
})
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua help_tags<cr>")
vim.keymap.set("n", "<leader>;", "<cmd>FzfLua resume<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>FzfLua lsp_document_symbols<cr>")
vim.keymap.set("n", "<leader>S", "<cmd>FzfLua lsp_live_workspace_symbols<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>FzfLua diagnostics_document<cr>")
vim.keymap.set("n", "<leader>D", "<cmd>FzfLua diagnostics_workspace<cr>")
vim.keymap.set("n", "<leader>@", "<cmd>FzfLua lsp_finder<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>FzfLua lsp_code_actions<cr>")

vim.api.nvim_create_autocmd("PackChanged", {
  pattern = "blink.cmp",
  group = vim.api.nvim_create_augroup("blink_update", { clear = true }),
  callback = function(e)
    if e.data.kind == "update" then
      vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
      require("blink.cmp.fuzzy.build").build()
    end
  end,
})
vim.pack.add({ "https://github.com/saghen/blink.cmp" })
require("blink.cmp").setup({})

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "leptosfmt", "rustfmt", lsp_format = "fallback" },
    javascript = { "prettier", stop_after_first = true },
    html = { "prettier", stop_after_first = true },
    css = { "prettier", stop_after_first = true },
  },
})

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({})
vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Hunk" })
vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev Hunk" })

vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
    win_options = {
      wrap = true,
    },
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
})
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local installed = vim.tbl_map(function(p)
      return p:match("[^/\\]+$")
    end, vim.api.nvim_get_runtime_file("parser/*.so", true))
    for _, lang in ipairs(treesitter_parsers) do
      if not vim.tbl_contains(installed, lang) then
        vim.cmd("TSInstall " .. lang)
      end
    end
  end,
  once = true,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["as"] = "@class.outer",
      ["is"] = "@class.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]f"] = "@function.outer",
      ["]s"] = "@class.outer",
    },
    goto_previous_start = {
      ["[f"] = "@function.outer",
      ["[s"] = "@class.outer",
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
      ["<leader>A"] = "@parameter.inner",
    },
  },
})

require("nvim-ts-autotag").setup({})

local aug = vim.api.nvim_create_augroup("my_lsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(args)
    local bufnr = args.buf
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "gr", vim.lsp.buf.references, "Goto References")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, "Code Action")
    map("n", "gh", vim.diagnostic.open_float, "Line Diagnostics")
  end,
})
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/seblyng/roslyn.nvim" })
vim.lsp.enable(enabled_lsps)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
