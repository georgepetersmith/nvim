return {
  'joeveiga/ng.nvim',
  ft = {'html', 'ts'},
  config = function ()
    local opts = { noremap = true, silent = true }
    local ng = require("ng");
    vim.keymap.set("n", "<leader>gt", ng.goto_template_for_component, opts)
    vim.keymap.set("n", "<leader>gc", ng.goto_component_with_template_file, opts)
  end,
}
