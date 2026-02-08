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
