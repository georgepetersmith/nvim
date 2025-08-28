return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "markdown",
          "c_sharp",
          "dockerfile",
          "sql",
          "json",
          "typescript",
        },
        indent = { enable = true },
        highlight = { enable = true },
        additional_vim_regex_highlighting = false,
      })
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          require("nvim-treesitter.configs").setup({
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                },
              },
            },
          })
        end,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
    config = function()
      -- Independent nvim-ts-autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true, -- Auto-close tags
          enable_rename = true, -- Auto-rename pairs
          enable_close_on_slash = false, -- Disable auto-close on trailing `</`
        },
        per_filetype = {
          ["html"] = {
            enable_close = true, -- Disable auto-closing for HTML
          },
          ["typescriptreact"] = {
            enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
          },
        },
      })
    end,
  },
}
