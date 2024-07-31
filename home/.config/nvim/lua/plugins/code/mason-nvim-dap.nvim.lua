return {
  "williamboman/mason-nvim-dap.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "python",
      },
      automatic_installation = true,
      handlers = {
        python = function(config)
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
      },
    })
  end,
}
