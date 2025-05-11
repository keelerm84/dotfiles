return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters = {
          stylua = {
            prepend_args = {
              "--indent-type",
              "spaces",
              "--indent-width",
              2,
            },
          },
        },
        default_format_opts = {
          quiet = true,
        },
        formatters_by_ft = {
          go = { "gofumpt", "goimports" },
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      })
    end,
  },
}
