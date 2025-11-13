return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      "netcoredbg",
      "cppdbg",
      "lua_ls",
      "rust_analyzer",
      "stylua",
      "ts_ls",
      "roslyn",
    },
  },
  dependencies = {
    {
      "mason-org/mason-lspconfig.nvim",
      config = function()
        require("mason").setup({
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
          },
        })
        require("mason-nvim-dap").setup({
          automatic_installation = true,
          handlers = {
            function(config)
              require("mason-nvim-dap").default_setup(config) -- registers "cppdbg"
            end,
          },
          ensure_installed = {},
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
    },
  },
}
