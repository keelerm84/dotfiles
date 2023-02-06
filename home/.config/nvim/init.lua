--[[

Neovim init file
Version: 0.62.0 - 2022/06/07
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

-- Import Lua modules
require('packer_init')
require('core/functions')
require('core/options')
require('core/autocmds')
require('core/keymaps')
require('plugins/nvim-tree')
require('plugins/nvim-cmp')
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')
require('plugins/alpha-nvim')
require('plugins/org')
