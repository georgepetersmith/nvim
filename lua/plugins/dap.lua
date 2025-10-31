return {
  "rcarriga/nvim-dap-ui",
  keys = {
    {
      "<leader>dt",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
    },
    {
      "<leader>dq",
      function()
        require("dap").terminate()
      end,
    },
    {
      "<leader>db",
      function()
        require("dap").list_breakpoints()
      end,
    },
  },
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup()

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
  end,
}
