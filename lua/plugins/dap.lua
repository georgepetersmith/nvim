return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",  -- Required dependency for nvim-dap-ui
  },
  config = function()
    -- Configuration goes here (see Step 3)
    local dap = require('dap')
    local dapui = require('dapui')

    -- Setup dap-ui with default configuration
    dapui.setup()

    -- Configure the debug adapter
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg', -- Adjust path as needed
      args = {'--interpreter=vscode'}
    }

    -- Configure debug configurations for C#
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
      {
        type = "coreclr",
        name = "attach - netcoredbg",
        request = "attach",
        processId = function()
          return require('dap.utils').pick_process()
        end,
      },
    }

    -- Auto-open/close dap-ui
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Custom breakpoint icons
    vim.fn.sign_define('DapBreakpoint', {
      text='🔴', 
      texthl='DapBreakpoint', 
      linehl='DapBreakpoint', 
      numhl='DapBreakpoint'
    })

    vim.fn.sign_define('DapStopped', {
      text='▶️', 
      texthl='DapStopped', 
      linehl='DapStopped', 
      numhl='DapStopped'
    })
  end,
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Debug UI" },
  },
}
