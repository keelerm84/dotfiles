return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("dapui").setup()

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<F5>", ":DapToggleBreakpoint<CR>", { desc = "DAP: Toggle breakpoint" })
    keymap.set("n", "<F6>", ":DapStepOut<CR>", { desc = "DAP: Step out" })
    keymap.set("n", "<F7>", ":DapStepInto<CR>", { desc = "DAP: Step into" })
    keymap.set("n", "<F8>", ":DapStepOver<CR>", { desc = "DAP: Step over" })
    keymap.set("n", "<F9>", ":DapContinue<CR>", { desc = "DAP: Continue" })
  end,
}
