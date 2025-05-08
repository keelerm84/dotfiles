return {
  { 'neovim/nvim-lspconfig' },
  {
    'mason-org/mason.nvim',
    opts = {}
  },

  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
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
