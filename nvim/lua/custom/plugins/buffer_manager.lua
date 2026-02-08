return {
  'j-morano/buffer_manager.nvim',
  opts = {
    width = 0.75,
  },
  keys = function()
    local keymaps = {
      {
        '<leader>,',
        function()
          require('buffer_manager.ui').toggle_quick_menu()
        end,
        desc = 'Buffer Manager',
      },
      {
        '<leader>bl',
        function()
          require('buffer_manager.ui').nav_next()
        end,
        desc = 'Next buffer',
      },
      {
        '<leader>bh',
        function()
          require('buffer_manager.ui').nav_prev()
        end,
        desc = 'Previous buffer',
      },
    }

    for i = 1, 9 do
      table.insert(keymaps, {
        string.format('<leader>b%d', i),
        function()
          require('buffer_manager.ui').nav_file(i)
        end,
        desc = 'Move to buffer ' .. i,
      })
    end

    return keymaps
  end,
}
