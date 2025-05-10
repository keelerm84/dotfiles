-- Diagnostic options, see: `:help vim.diagnostic.config`
vim.diagnostic.config({ virtual_text = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local function bufopts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = "lsp: " .. desc }
  end
  -- See `:help vim.lsp.*` for documentation on any of the below functions

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("Display hover information"))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("List all implementations"))

  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts("Add folder to workspace"))
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts("Remove folder from workspace"))
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts("List workspace folders"))
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts("Rename all references"))
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts("Code action"))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("List all references"))
  vim.keymap.set("n", "<leader>ff", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts("Format buffer"))

  local function opts(desc)
    return { noremap = true, silent = true, desc = "diagnostic: " .. desc }
  end
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts("Show diagnostics"))
  vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts("Move to previous diagnostic"))
  vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts("Move to next diagnostic"))
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts("Add buffer diagnostics to the location list"))
end

return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Add additional capabilities supported by nvim-cmp
    -- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    mason_lspconfig.setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      --
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,

      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      -- ["rust_analyzer"] = function ()
      --   require("rust-tools").setup {}
      -- end

      ["gopls"] = function()
        lspconfig.gopls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          cmd = { "gopls", "-remote=auto" },
          settings = {
            gopls = {
              env = {
                GOPACKAGESDRIVER = vim.fn.expand("tools/go/gopackagesdriver.sh"),
              },
            },
          },
        })
      end,

      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
        })
      end,

      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })

    mason_lspconfig.setup()

    require("go").setup()
  end,
}
