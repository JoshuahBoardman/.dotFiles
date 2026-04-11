return {
  {
    'renerocksai/telekasten.nvim',
    enabled = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-telekasten/calendar-vim',
    },
    keys = {
      { '<leader>n', '', desc = '[N]otes management' },
      { '<leader>np', '<cmd>Telekasten panel<CR>', desc = 'Launch Telekasten pannel' },

      { '<leader>nf', '<cmd>Telekasten find_notes<CR>', desc = '[F]ind note' },
      { '<leader>ns', '<cmd>Telekasten search_notes<CR>', desc = '[S]earch note' },
      { '<leader>nd', '<cmd>Telekasten goto_today<CR>', desc = 'Open [D]aily note' },
      { '<leader>nw', '<cmd>Telekasten goto_thisweek<CR>', desc = 'Open [W]eekly note' },
      { '<leader>nl', '<cmd>Telekasten follow_link<CR>', desc = 'Follow note [L]ink' },
      { '<leader>nn', '<cmd>Telekasten new_note<CR>', desc = '[N]ew note' },
      { '<leader>nt', '<cmd>Telekasten new_templated_note<CR>', desc = 'New [T]emplate note' },
      { '<leader>nc', '<cmd>Telekasten show_calendar<CR>', desc = 'Open [C]alendar' },
      { '<leader>nb', '<cmd>Telekasten show_backlinks<CR>', desc = 'Show [B]acklinks' },
      { '<leader>nr', '<cmd>Telekasten find_friends<CR>', desc = 'Find [R]elated notes' },
    },
    opts = {
      home = vim.fn.expand '~/my_obsidian_vault', -- Put the name of your notes directory here
    },
  },
}
