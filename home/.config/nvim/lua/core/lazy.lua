-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load local overrides
local locals = {}
local file_path = vim.fn.stdpath("config") .. "/../nvim.local/lazy.lua"
if vim.api.nvim_call_function("filereadable", { file_path }) == 1 then
  locals = dofile(file_path)
end

-- Use a protected call so we don't error out on first use
local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
  return
end

lazy.setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.code" },
    { import = "plugins.comments" },
    { import = "plugins.completion" },
    { import = "plugins.copilot" },
    { import = "plugins.files" },
    { import = "plugins.git" },
    { import = "plugins.ui" },
    { import = "local.plugins" },
    locals,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
