local ok, config = pcall(require, "local")

if not ok then
  config = {}
end

if type(config.plugins) ~= "table" then
  config.plugins = {}
end

if type(config.after_load) ~= "function" then
  config.after_load = function() end
end

require("config.options")
require("config.functions")
require("config.keymaps")
require("config.autocmd")
require("config.lazy").setup(config)

config.after_load()
