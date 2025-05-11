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
              -- Language Server (LSP)
              --
              "bashls",
              "bright_script",
              "clangd",
              "cssls", -- css, scss, less
              "dockerls",
              "gopls",
              "helm_ls",
              "hls", -- haskell
              "html",
              "intelephense", -- php
              "jdtls",
              "ltex", -- text, markdown, latex, restructuredtext
              "lua_ls",
              "omnisharp",
              "phpactor",
              "pylsp",
              "pyright",
              "rust_analyzer",
              "solargraph", -- ruby
              "spectral", -- json, yaml
              "sqlls",
              "stimulus_ls", -- blade, html, php, ruby
              "terraformls",
              "ts_ls", -- javascript, typescript
              "zls", -- zig

              --
              -- Linter
              --
              "checkmake",
              "eslint_d",
              "golangci-lint",

              --
              -- Linter + Formatter
              --
              "buf", -- protobuf

              --
              -- Formatter only
              --
              "beautysh",
              "black", -- python
              "gofumpt",
              "goimports",
              "google-java-format",
              "phpcbf",
              "prettier", -- angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml
              "shfmt", -- bash, mksh, shell
              "stylua", -- lua, luau

              "trivy", -- security scanning
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
      vim.keymap.set("n", "gd", "<C-]>", { noremap = false, silent = true })
      vim.keymap.set(
        "n",
        "<leader>d",
        vim.diagnostic.open_float,
        { desc = "Show diagnostic", noremap = true, silent = true }
      )
    end,
  },
}
