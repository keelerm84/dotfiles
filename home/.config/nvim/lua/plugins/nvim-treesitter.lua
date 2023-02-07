-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter
local treesitter_status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not treesitter_status_ok then
  return
end

local orgmode_status_ok, orgmode = pcall(require, 'orgmode')
if not orgmode_status_ok then
  return
end

orgmode.setup_ts_grammar()

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
    'toml',
    'typescript',
    'vim',
    'yaml',
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
