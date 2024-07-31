--[[

Neovim init file
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

-- Import Lua modules
require("core.functions")
require("core.autocmds")
require("core.keymaps")
require("core.options")
require("core.lazy")

-- While not included in these dotfiles, creating a local directory in
-- ~/.config/nvim/lua allows for local overrides.
pcall(require, "local.init")
