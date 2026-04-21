return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  opts = {
    multiplexer_integration = (function()
      local term = vim.env.TERM_PROGRAM
      if term == 'WezTerm' then
        return 'wezterm'
      elseif term == 'kitty' then
        return 'kitty'
      end
      return nil
    end)(),
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
