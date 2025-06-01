return {
  "lewis6991/gitsigns.nvim",
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]c", gs.next_hunk, "Next Hunk")
      map("n", "[c", gs.prev_hunk, "Prev Hunk")

      -- Actions
      map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")

      map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
      map("n", "<leader>gd", gs.diffthis, "Diff this")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this ~")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
    end,
  },
}
