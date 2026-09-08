return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  build = './kitty/install-kittens.bash',
  opts = {
    disable_multiplexer_nav_when_zoomed = true,
  },
  keys = {
    {
      '<c-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      mode = { 'n' },
      desc = 'Move to left pane',
    },
    {
      '<c-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      mode = { 'n' },
      desc = 'Move to bottom pane',
    },
    {
      '<c-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      mode = { 'n' },
      desc = 'Move to top pane',
    },
    {
      '<c-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      mode = { 'n' },
      desc = 'Move to right pane',
    },
  },
}
