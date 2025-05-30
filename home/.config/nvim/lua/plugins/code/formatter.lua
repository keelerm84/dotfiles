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
          brightscript = { "bsfmt" },
          go = { "gofumpt", "goimports" },
          haskell = { "fourmolu" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          json = { "jq", "prettierd", "prettier", stop_after_first = true },
          lua = { "stylua" },
          php = { "php_cs_fixer" },
          python = { "isort", "black" },
          ruby = { "rubocop" },
          rust = { "rustfmt" },
          sh = { "beautysh", "shfmt" },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          zsh = { "shfmt" },
        },
      })
    end,
  },
}
