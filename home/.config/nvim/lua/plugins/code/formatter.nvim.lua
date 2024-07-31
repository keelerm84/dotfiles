return {
  "mhartington/formatter.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("formatter").setup({
      -- All formatter configurations are opt-in
      filetype = {
        css = { require("formatter.filetypes.css").prettier },
        helm = { require("formatter.filetypes.yaml").pyyaml },
        html = { require("formatter.filetypes.html").prettier },

        go = {
          require("formatter.filetypes.go").gofumpt,
          require("formatter.filetypes.go").goimports,
        },

        java = { require("formatter.filetypes.java").google_java_format },
        javascript = { require("formatter.filetypes.javascript").prettier },
        json = { require("formatter.filetypes.json").prettier },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettier },
        php = { require("formatter.filetypes.php").phpcbf },
        proto = { require("formatter.filetypes.proto").buf_format },
        python = { require("formatter.filetypes.python").black },
        react = { require("formatter.filetypes.javascriptreact").prettier },
        rust = { require("formatter.filetypes.rust").rustfmt },
        sh = { require("formatter.filetypes.sh").shfmt },
        terraform = { require("formatter.filetypes.terraform").terraformfmt },
        typescript = { require("formatter.filetypes.typescript").prettier },
        yaml = { require("formatter.filetypes.yaml").prettier },
        zsh = { require("formatter.filetypes.zsh").beautyzsh },
      },
    })

    -- Mason Formatting
    --
    vim.api.nvim_create_augroup("__formatter__", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "__formatter__",
      command = ":FormatWrite",
    })
  end,
}
