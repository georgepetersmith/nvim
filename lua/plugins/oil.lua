return {
  'stevearc/oil.nvim',
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = {
    {
      "echasnovski/mini.icons",
      opts = {},
    },
  },
  config = function ()
    require('oil').setup({
      skip_confirm_for_simple_edits = true,
    })

    -- opens parent dir over current active window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    -- open parent dir in float window
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'oil',
      callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end
    })
  end
}
