return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'sainnhe/gruvbox-material',
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
      local configuration = vim.fn['gruvbox_material#get_configuration']()
      local palette = vim.fn['gruvbox_material#get_palette'](configuration.background, configuration.foreground, configuration.colors_override)

      vim.api.nvim_set_hl(0, "@variable.php", { fg = palette.blue[1] })
    end,
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    opts = {
      indent = {
        enable = true,
      },
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'c_sharp',
        'css',
        'dart',
        'dockerfile',
        'elixir',
        'go',
        'graphql',
        'haskell',
        'html',
        'java',
        'javascript',
        'javascript',
        'json',
        'json',
        'latex',
        'lua',
        'php',
        'phpdoc',
        'python',
        'ruby',
        'rust',
        'swift',
        'terraform',
        'toml',
        'typescript',
        'twig',
        'vim',
        'yaml',
        'zig',
      }
    }
  }
}
