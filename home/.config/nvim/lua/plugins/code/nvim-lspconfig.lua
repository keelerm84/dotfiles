return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "salesforce-misc/bazelrc-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
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

    -- -- Add configuration for your specific language server
    -- lspconfig.gopls.setup({
    --   settings = {
    --     gopls = {
    --       buildFlags = { "-tags=integration" },
    --       directoryFilters = { "+/bazel-bin", "-bazel-out", "-bazel-testlogs", "-bazel-genfiles" },
    --       -- experimentalWorkspaceModule = true,
    --     },
    --   },
    -- })
  end,
}
