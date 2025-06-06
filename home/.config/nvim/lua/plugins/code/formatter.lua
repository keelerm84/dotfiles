return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>fa",
        function()
          if vim.b.disable_autoformat then
            vim.b.disable_autoformat = false
            vim.notify("Auto formatting enabled")
          else
            vim.b.disable_autoformat = true
            vim.notify("Auto formatting disabled")
          end
        end,
        desc = "Toggle auto formatting on save",
      },
    },
    init = function()
      vim.g.disable_autoformat = false
    end,
    config = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
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
          php = { "php-cs-fixer" },
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
