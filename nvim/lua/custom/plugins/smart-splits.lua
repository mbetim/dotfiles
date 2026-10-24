return {
  'smart-splits-nvim/smart-splits.nvim',
  version = '^3.0.0',
  lazy = false,
  dependencies = {
    { 'rawnly/smart-splits-backend-rex', main = 'smart-splits-backend-rex', opts = {} },
    { 'smart-splits-nvim/backend-tmux', main = 'smart-splits-backend-tmux' },
  },
  opts = {
    mux = {
      backend = { 'smart-splits-backend-rex', 'smart-splits-backend-tmux' },
    },
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
        -- Nightly's default <C-L> clears the built-in multicursors, which this
        -- mapping shadows. Clear them first when present, otherwise move.
        local ns = vim.api.nvim_create_namespace 'nvim.multicursor'
        if #vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { limit = 1 }) > 0 then
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          return
        end
        require('smart-splits').move_cursor_right()
      end,
      mode = { 'n' },
      desc = 'Clear multicursors or move to right pane',
    },
  },
}
