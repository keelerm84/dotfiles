return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Debug Adapter Protocol (DAP)
        --
        -- "go-debug-adapter", -- (keywords: go)

        -- Language Server (LSP)
        --
        "bashls", -- (keywords: bash)
        "cssls", -- (keywords: css, scss, less)
        "dockerls", -- (keywords: docker)
        "gopls", -- (keywords: go)
        "ltex", -- (keywords: text, markdown, latex, restructuredtext)
        "lua_ls", -- (keywords: lua)
        "pyright", -- (keywords: python)
        "spectral", -- (keywords: json, yaml)
        "sqlls", -- (keywords: sql)
        "stimulus_ls", -- (keywords: blade, html, php, ruby)
        "terraformls", -- (keywords: terraform)
        -- "harper_ls" FYI: This printing a bunch of linting errors in nearly all files (pertaining to spelling, etc)
        -- "harper_ls", -- (keywords: markdown, rust, typescript, javascript, python, go, c, c++, ruby, c#, toml, lua)
        -- "hls", -- (keywords: haskell)

        -- Linter
        --
        "checkmake", -- (keywords: makefile)
        "eslint_d", -- (keywords: typescript, javascript)
        "golangci-lint", -- (keywords: go)
        -- "sonarlint-language-server" FYI: Didn't do anything
        -- "sonarlint-language-server", -- (keywords: c, c++, c#, cloudformation, css, docker, go, html, ipython, java, javascript, kubernetes, typescript, python, php, terraform, text, xml, yaml)
        -- "trivy" FYI: Didn't do anything
        -- "trivy", -- (keywords: c, c#, c++, dart, docker, elixir, go, helm, java, javascript, php, python, ruby, rust, terraform, typescript)

        -- Linter + Formatter
        --
        "buf", -- (keywords: protobuf)

        -- Formatter only
        --
        "beautysh", -- (keywords: bash, csh, ksh, sh, zsh)
        "black", -- (keywords: python)
        "gofumpt", -- (keywords: go)
        "goimports", -- (keywords: go)
        "google-java-format", -- (keywords: java)
        "phpcbf", -- (keywords: php)
        "prettier", -- (keywords: angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml)
        "shfmt", -- (keywords: bash, mksh, shell)
        "stylua", -- (keywords: lua, luau)
        -- "rustfmt", -- (keywords: rust) (deprecated: rustfmt should now be installed via rustup.)
      },
    })
  end,
}
