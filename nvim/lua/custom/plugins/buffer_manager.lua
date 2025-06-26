return {
  'j-morano/buffer_manager.nvim',
  opts = {
    width = 0.5,
  },
  keys = {
    {
      '<leader>,',
      function()
        require('buffer_manager.ui').toggle_quick_menu()
      end,
      desc = 'Buffer Manager',
    },
    {
      'L',
      function()
        require('buffer_manager.ui').nav_next()
      end,
      desc = 'Next buffer',
    },
    {
      'H',
      function()
        require('buffer_manager.ui').nav_prev()
      end,
      desc = 'Next buffer',
    },
  },
}
