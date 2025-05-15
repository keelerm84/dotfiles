return {
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
          require("mason").setup()

          require("mason-tool-installer").setup({
            ensure_installed = {
              --
              -- Linter, Formatter, & LSP
              --
              "ruff",

              --
              -- LSP
              --
              "bashls",
              "bright_script",
              "bzl",
              "clangd",
              "cssls",
              "dockerls",
              "gopls",
              "helm_ls",
              "hls",
              "html",
              "intelephense",
              "jsonls",
              "jdtls",
              "ltex",
              "lua_ls",
              "omnisharp",
              "phpactor",
              "pylsp",
              "pyright",
              "rust_analyzer",
              "solargraph",
              "sqlls",
              "stimulus_ls",
              "terraformls",
              "ts_ls",
              "zls",

              --
              -- Linter
              --
              "checkmake",
              "eslint_d",
              "golangci-lint",
              "sonarlint-language-server",
              "sqlfluff",

              --
              -- Linter + Formatter
              --
              "buf",

              --
              -- Formatter only
              --
              "beautysh",
              "black",
              "brighterscript-formatter",
              "fourmolu",
              "gofumpt",
              "goimports",
              "google-java-format",
              "jq",
              "php-cs-fixer",
              "prettier",
              "rubocop",
              "rubyfmt",
              "shfmt",
              "stylua",
              "trivy",
            },
          })

          require("mason-lspconfig").setup()

          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })

          vim.lsp.config("stylua", {
            settings = {
              indent_type = "Spaces",
            },
          })
        end,
      },
    },
    init = function()
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "gd", "<C-]>", { noremap = false, silent = true })
    end,
  },
}
