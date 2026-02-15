return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
      "sainnhe/gruvbox-material",
    },
    lazy = false,
    config = function()
      -- Gruvbox material color customization
      local configuration = vim.fn["gruvbox_material#get_configuration"]()
      local palette = vim.fn["gruvbox_material#get_palette"](
        configuration.background,
        configuration.foreground,
        configuration.colors_override
      )

      vim.api.nvim_set_hl(0, "@variable.php", { fg = palette.blue[1] })

      -- Install parsers
      require'nvim-treesitter'.install {
        "bash",
        "c",
        "cpp",
        "c_sharp",
        "css",
        "dart",
        "diff",
        "dockerfile",
        "elixir",
        "gitcommit",
        "git_config",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "graphql",
        "haskell",
        "hcl",
        "helm",
        "html",
        "ini",
        "java",
        "javascript",
        "json",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "passwd",
        "php",
        "phpdoc",
        "printf",
        "proto",
        "python",
        "regex",
        "ruby",
        "rust",
        "scss",
        "sql",
        "ssh_config",
        "starlark",
        "swift",
        "terraform",
        "toml",
        "tsx",
        "twig",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
      }
    end,
    build = ':TSUpdate',
  },
}
