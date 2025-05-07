return {
  {
    'junegunn/fzf',
    build = function()
      vim.fn["fzf#install"]()
    end
  },

  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    keys = {
      { '<C-p>', ':call SmartFzfSearching()<CR>', silent = true },
      { 'g<C-p>', ':Files<CR>', silent = true },
      { 'gs<C-p>', ':GFiles?<CR>', silent = true },

      { '<leader>T', ':BTags<CR>', silent = true },
      { 'g<leader>T', ':Tags<CR>', silent = true },

      { '<leader>l', ':BLines<CR>', silent = true },
      { 'g<leader>l', ':Lines<CR>', silent = true },

      { '<leader>b', ':Buffers<CR>', silent = true },

      { '<leader>c', ':BCommits<CR>', silent = true },
      { 'g<leader>c', ':Commits<CR>', silent = true },
    },
    init = function()
      vim.g.fzf_action = {
        ['ctrl-t'] = 'tab split',
        ['ctrl-h'] = 'split',
        ['ctrl-v'] = 'vsplit',
      }

      vim.g.fzf_layout = {
        ['window'] = {
          ['width'] = 0.9,
          ['height'] = 0.9
        }
      }

      vim.g.fzf_preview_window = {'right:50%:hidden', 'ctrl-o'}

      vim.g.fzf_colors = {
        ['fg'] = {'fg', 'Normal'},
        ['bg'] = {'bg', 'Normal'},
        ['hl'] = {'fg', 'GruvboxAqua'},
        ['fg+'] = {'fg', 'String'},
        ['bg+'] = {'bg', 'Normal'},
        ['hl+'] = {'fg', 'GruvboxBlue'},
        ['info'] = {'fg', 'PreProc'},
        ['border'] = {'fg', 'Comment'},
        ['prompt'] = {'fg', 'GruvboxPurple'},
        ['pointer'] = {'fg', 'GruvboxPurple'},
        ['marker'] = {'fg', 'Keyword'},
        ['spinner'] = {'fg', 'Label'},
        ['header'] = {'fg', 'Comment'}
      }
    end,
  },
}
