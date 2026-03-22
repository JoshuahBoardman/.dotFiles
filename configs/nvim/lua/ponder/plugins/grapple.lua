return {
  {
    'cbochs/grapple.nvim',
    opts = {
      scope = 'git', -- also try out "git_branch"
      icons = false, -- setting to "true" requires "nvim-web-devicons"
      status = false,
    },
    config = function()
      require('telescope').load_extension 'grapple'
    end,
    keys = {
      { '<leader>g', '', desc = '[G]rapple files' },
      { '<leader>ga', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
      { '<leader>ge', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },

      { '<leader>g1', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
      { '<leader>g2', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
      { '<leader>g3', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
      { '<leader>g4', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },
      { '<leader>g5', '<cmd>Grapple select index=5<cr>', desc = 'Select fifth tag' },

      { '<leader>gn', '<cmd>Grapple cycle_tags next<cr>', desc = 'Go to next tag' },
      { '<leader>gp', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Go to previous tag' },

      { '<leader>sm', '<cmd>Telescope grapple tags<cr>', desc = '[S]earch Grappel [M]arks' },
    },
  },
}
