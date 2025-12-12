---@diagnostic disable: missing-fields

local enabled_lsps = {
  "roslyn",
  "rust_analyzer",
  "lua_ls",
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
vim.g.editorconfig = true
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
})
vim.cmd("filetype plugin on")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
local is_windows = has("win32")

if is_mac then
  vim.opt.clipboard:apend({ "unnamedplus" })
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
  },
})

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({})
vim.keymap.set("n", "]c", "Gitsigns next_hunk", { desc = "Next Hunk" })
vim.keymap.set("n", "[c", "Gitsigns prev_hunk", { desc = "Prev Hunk" })

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
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "master" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
})
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function()
    require("nvim-treesitter").update()
  end,
})
require("nvim-treesitter.configs").setup({
  ensure_installed = treesitter_parsers,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
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
  },
  autotag = {
    enable = true,
  },
})
require("treesitter-context").setup({
  max_lines = 3,
  trim_scope = "outer",
  mode = "cursor",
})

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
    map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
    map({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, "Code Action")
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Prev Diagnostic")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Next Diagnostic")
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

vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })
require("vague").setup({})

vim.pack.add({ "https://github.com/f-person/auto-dark-mode.nvim" })
require("auto-dark-mode").setup({
  set_dark_mode = function()
    vim.api.nvim_set_option_value("background", "dark", {})
    vim.cmd.colorscheme("vague")
  end,
  set_light_mode = function()
    vim.api.nvim_set_option_value("background", "light", {})
    vim.cmd.colorscheme("default")
  end,
})

-- DAP (Debug Adapter Protocol)
vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
})

local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup({})
dapui.setup({})

-- Automatically open/close DAP UI
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- DAP Keymaps
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Debug: Set Log Point" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Debug: Evaluate Expression" })

-- Debug adapter configurations
-- C#/.NET (netcoredbg)
dap.adapters.coreclr = {
  type = "executable",
  command = "netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch",
    request = "launch",
    program = function()
      local fzf = require("fzf-lua")
      local co = coroutine.running()

      fzf.files({
        cmd = "fd -I --type f --extension dll .",
        prompt = "Select DLL> ",
        actions = {
          ["default"] = function(selected)
            local path = selected[1]
            -- fzf-lua may include icons/prefixes, extract the path
            path = fzf.path.entry_to_file(selected[1]).path
            coroutine.resume(co, path)
          end,
        },
      })

      return coroutine.yield()
    end,
  },
}

-- Rust (codelldb)
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- Lua (local-lua-debugger-vscode)
dap.adapters["local-lua"] = {
  type = "executable",
  command = "local-lua-dbg",
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath = vim.fn.exepath("local-lua-dbg"):match("(.*)[/\\]")
      on_config(c)
    else
      on_config(config)
    end
  end,
}

if vim.g.neovide then
  local font_size = 10

  local function set_gui_font_size(value)
    vim.o.guifont = "Monaspace Neon NF:h" .. value
  end

  local function adjust_gui_font_size(delta)
    font_size = font_size + delta
    set_gui_font_size(font_size)
  end

  vim.keymap.set("n", "<c-->", function()
    adjust_gui_font_size(-1)
  end)
  vim.keymap.set("n", "<c-+>", function()
    adjust_gui_font_size(1)
  end)
  vim.keymap.set("n", "<F11>", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<cr>")

  set_gui_font_size(font_size)
end
