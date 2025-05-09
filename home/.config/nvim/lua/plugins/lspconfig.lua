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
    opts = {
      ensure_installed = {
        'bashls',
        'bright_script',
        'clangd',
        'dockerls',
        'gopls',
        'hls',
        'html',
        'jdtls',
        'omnisharp',
        'intelephense',
        'phpactor',
        'pylsp',
        'rust_analyzer',
        'solargraph',
        'sqlls',
        'terraformls',
        'ts_ls',
        'zls'
      }
    }
  }
}
