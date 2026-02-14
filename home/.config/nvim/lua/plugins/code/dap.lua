return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",

      -- Virtual text showing variable values
      "theHamsta/nvim-dap-virtual-text",

      -- Mason integration for installing debug adapters
      "jay-babu/mason-nvim-dap.nvim",

      -- Language-specific extensions
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      -- Basic debugging
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue", },
      { "<F8>", function() require("dap").step_into() end, desc = "Debug: Step Into", },
      { "<F9>", function() require("dap").step_over() end, desc = "Debug: Step Over", },
      { "<F10>", function() require("dap").step_out() end, desc = "Debug: Step Out", },

      -- Breakpoints
      { "<F7>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint", },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional Breakpoint", },

      -- UI
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Debug: Evaluate Expression" },

      -- Control
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup mason-nvim-dap for automatic installation
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = {
          "codelldb",      -- Rust, C, C++
          "delve",         -- Go
          "debugpy",       -- Python
        },
        handlers = {},
      })

      -- Setup DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Language-specific configurations

      -- Go (handled by nvim-dap-go)
      require("dap-go").setup()

      -- Python
      require("dap-python").setup("python") -- or specify path to python with debugpy


      -- Custom signs for breakpoints
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })
    end,
  },
}
