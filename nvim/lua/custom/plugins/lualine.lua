return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    sections = {
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_y = {
        {
          function()
            local buffers = vim.fn.getbufinfo { buflisted = 1 }
            local current_buf = vim.api.nvim_get_current_buf()
            local current_index = 1

            for i, buf in ipairs(buffers) do
              if buf.bufnr == current_buf then
                current_index = i
                break
              end
            end

            return string.format('%d/%d', current_index, #buffers)
          end,
          icon = '󰓩 ',
        },
      },
    },
  },
}
