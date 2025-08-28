return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",
  opts = {
    appearance = { nerd_font_variant = "normal" },
  },
  per_filetype = {
    sql = { "snippets", "dadbod", "buffer" },
  },
  providers = {
    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
  },
}
