return {
  "williamboman/mason-lspconfig.nvim",
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'neovim/nvim-lspconfig',
    {
      "williamboman/mason.nvim",
      cmd = { 'Mason' },
      lazy = true,
      opts = {
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      },
    },
  },
  opts = {
    ensure_installed = {
      "angularls",
      "html",
      "cssls",
      "tailwindcss",
      "lua_ls",
      "marksman",
      'rust_analyzer',
      'jsonls',
      'ts_ls',
      'powershell_es',
    },
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,
    },
  },
}
