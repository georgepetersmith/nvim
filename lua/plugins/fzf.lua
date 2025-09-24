return {
  "ibhagwan/fzf-lua",
  lazy = false,
  opts = {
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
  },
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>" },
    { "<leader>b", "<cmd>FzfLua buffers<cr>" },
    { "<leader>h", "<cmd>FzfLua help_tags<cr>" },
    { "<leader>;", "<cmd>FzfLua resume<cr>" },
    { "<leader>i", "<cmd>FzfLua lsp_finder<cr>" },
    { "<leader>s", "<cmd>FzfLua lsp_document_symbols<cr>" },
    { "<leader>S", "<cmd>FzfLua lsp_workspace_symbols<cr>" },
    { "<leader>d", "<cmd>FzfLua lsp_document_diagnostics<cr>" },
    { "gr", "<cmd>FzfLua lsp_references<cr>" },
    { "gi", "<cmd>FzfLua lsp_implementations<cr>" },
    { "gD", "<cmd>FzfLua lsp_declarations<cr>" },
    {
      "<leader>fs",
      function()
        local fzf = require("fzf-lua")
        -- filename without the last extension, e.g. "abc.component.html" -> "abc.component"
        local base = vim.fn.expand("%:t:r")

        fzf.files({
          -- Optional: search from project root (fzf-lua detects git root by default)
          -- cwd = require("fzf-lua.path").git_root_or_cwd(), -- needs fzf-lua >= 0.44
          -- Prepopulate the fzf query with the base
          fzf_opts = { ["--query"] = base },
          -- Optional: nicer prompt
          prompt = "Find siblings > ",
        })
      end,
    },
  },
}
