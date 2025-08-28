return {
  "stevearc/conform.nvim",
  lazy = false,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
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
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
  keys = {
    {
      "<leader>gq",
      function()
        require("conform").format()
      end,
    },
  },
}
