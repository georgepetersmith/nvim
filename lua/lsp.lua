vim.lsp.enable({
  "omnisharp",
  "rust_analyzer",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>n", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "gh", "<cmd>lua vim.diagnostic.open_float()<cr>")
  end,
})
