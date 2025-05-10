return {
  { 'neovim/nvim-lspconfig' },
  {
    'mason-org/mason.nvim',
    opts = {}
  },

  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    init = function()
      vim.keymap.set('n', 'gd', '<C-]>', { noremap = false, silent = true })
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostic", noremap = true, silent = true })

    end,
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'bright_script',
          'clangd',
          'dockerls',
          'gopls',
          'hls',
          'html',
          'intelephense',
          'jdtls',
          'lua_ls',
          'omnisharp',
          'phpactor',
          'pylsp',
          'rust_analyzer',
          'solargraph',
          'sqlls',
          'terraformls',
          'ts_ls',
          'zls',
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
    end,
  }
}
