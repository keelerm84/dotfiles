return {
  "sainnhe/gruvbox-material",
  config = function()
    vim.cmd([[
          let g:gruvbox_material_foreground = 'material'
          let g:gruvbox_material_background = 'soft'
          let g:gruvbox_material_disable_italic_comment = 1
          colorscheme gruvbox-material
        ]])
  end,
}
