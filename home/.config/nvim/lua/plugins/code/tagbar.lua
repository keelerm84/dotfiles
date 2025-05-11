return {
  {
    "preservim/tagbar",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>tt", ":TagbarOpen fj<CR>", silent = true, desc = "Open tagbar" },
      { "<leader>tc", ":TagbarClose<CR>", silent = true, desc = "Close tagbar" },
    },
    init = function()
      vim.g.tagbar_type_haskell = {
        ctagsbin = "hasktags",
        ctagsargs = "-x -c -o-",
        kinds = {
          "m:modules:0:1",
          "d:data: 0:1",
          "d_gadt: data gadt:0:1",
          "t:type names:0:1",
          "nt:new types:0:1",
          "c:classes:0:1",
          "cons:constructors:1:1",
          "c_gadt:constructor gadt:1:1",
          "c_a:constructor accessors:1:1",
          "ft:function types:1:1",
          "fi:function implementations:0:1",
          "i:instance:0:1",
          "o:others:0:1",
        },
        sro = ".",
        kind2scope = {
          m = "module",
          c = "class",
          d = "data",
          t = "type",
          i = "instance",
        },
        scope2kind = {
          module = "m",
          class = "c",
          data = "d",
          type = "t",
          instance = "i",
        },
      }

      vim.g.tagbar_type_ruby = {
        kinds = {
          "m:modules",
          "c:classes",
          "d:describes",
          "C:contexts",
          'i:things described with "it"',
          "f:methods",
          "F:singleton methods",
        },
      }
    end,
  },
}
