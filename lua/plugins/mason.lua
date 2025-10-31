return {
  "mason-org/mason-lspconfig.nvim",
  config = function()
    require("mason").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "stylua",
        "ts_ls",
      },
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    })
    require("mason-nvim-dap").setup({
      ensure_installed = { "netcoredbg", "cppdbg" },
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config) -- registers "cppdbg"
        end,
      },
    })
    require("mason-lspconfig").setup()
  end,
  dependencies = {
    "neovim/nvim-lspconfig",
    "jay-babu/mason-nvim-dap.nvim",
    "mason-org/mason.nvim",
    {
      "seblyng/roslyn.nvim",
      ---@module 'roslyn.config'
      ---@type RoslynNvimConfig
      opts = {},
    },
  },
}
