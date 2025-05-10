return {
  {
    'zbirenbaum/copilot.lua',
    event = "InsertEnter",
    opts = {
      panel = {
        auto_refresh = true,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-j>",
        },
      },
    },
  }
}
