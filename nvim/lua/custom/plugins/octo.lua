return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = 'Octo',
  opts = {
    picker = 'snacks',
    enable_builtin = true,
  },
  keys = {
    {
      '<leader>op',
      '<CMD>Octo pr list<CR>',
      desc = 'List GitHub PullRequests',
    },
    {
      '<leader>or',
      '<CMD>Octo review<CR>',
      desc = 'Review PR on current branch',
    },
    {
      '<leader>ogn',
      '<CMD>Octo notification list<CR>',
      desc = 'List GitHub Notifications',
    },
    {
      '<leader>os',
      function()
        require('octo.utils').create_base_search_command { include_current_repo = true }
      end,
      desc = 'Search GitHub',
    },
  },
}
