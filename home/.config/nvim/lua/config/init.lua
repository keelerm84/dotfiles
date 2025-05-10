require("config.options")
require("config.functions")
require("config.keymaps")
require("config.autocmd")
require("config.lazy")

pcall(require, 'local.init')
