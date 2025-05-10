return {
  "neovim/nvim-lspconfig",
  -- TODO: Remove this when this issue is resolved:
  -- https://github.com/williamboman/mason-lspconfig.nvim/issues/469
  version = "1.x.x",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lspconfig").lua_ls.setup({
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              -- Make the server aware of Neovim runtime files
              workspace = { library = { vim.env.VIMRUNTIME .. "/lua" } },
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end,
    })
  end,
}
