return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    globalstatus = true,
    ignore_focus = {
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_console",
      "dapui_stacks",
      "dap-repl",
    },
  },
}
