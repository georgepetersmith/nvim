return {
  "olimorris/codecompanion.nvim",
  opts = {
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true,  -- Show mcp tool results in chat
          make_vars = true,            -- Convert resources to #variables
          make_slash_commands = true,  -- Add prompts as /slash commands
          adapters = {
            anthropic = function ()
              return require("codecompanion.adapters").extend("anthropic", {
                env = {
                  api_key = "cmd:os.getenv('ANTHROPIC_API_KEY')",
                },
              })
            end
          },
          strategies = {
            chat = {
              adapter = "anthropic",
            },
            inline = {
              adapter = "anthropic",
            },
            cmd = {
              adapter = "anthropic",
            },
          },
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      build = "npm install -g mcp-hub@latest",
      opts = {},
    },
  },
}
