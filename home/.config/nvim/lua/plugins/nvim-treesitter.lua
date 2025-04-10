-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter

local treesitter_status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not treesitter_status_ok then
  return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'c_sharp',
    'css',
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
    'org',
    'php',
    'phpdoc',
    'python',
    'ruby',
    'rust',
    'swift',
    'terraform',
    'toml',
    'typescript',
    'vim',
    'yaml',
    'zig',
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
