return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = { section_separators = '', component_separators = '', always_show_tabline = false },
    tabline = {
      lualine_a = {
        {
          'tabs',
          mode = 2,
          fmt = function(name, context)
            -- Prefer the project name set by the Switch Project picker
            local project = vim.fn.gettabvar(context.tabnr, 'project_name', '')
            if project ~= '' then
              return project
            end
            -- t:project_name is never stored in a session (mksession skips tab
            -- variables), so fall back to the tab-local cwd, which it does
            -- restore. Relative to the global cwd, to match the picker labels.
            if vim.fn.haslocaldir(-1, context.tabnr) == 1 then
              local cwd = vim.fn.getcwd(-1, context.tabnr)
              local root = vim.fn.getcwd(-1, -1)
              local rel = cwd:gsub('^' .. vim.pesc(root) .. '/', '')
              -- no match means the tab is the root itself: use its basename
              return rel ~= cwd and rel or vim.fn.fnamemodify(cwd, ':t')
            end
            return name
          end,
        },
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = { { 'filename', path = 1 } },
      lualine_c = { 'diagnostics' },
      lualine_x = { 'diff' },
      lualine_y = {
        'fileformat',
        'filetype',
        -- {
        --   function()
        --     local buffers = vim.fn.getbufinfo { buflisted = 1 }
        --     local current_buf = vim.api.nvim_get_current_buf()
        --     local current_index = 1
        --
        --     for i, buf in ipairs(buffers) do
        --       if buf.bufnr == current_buf then
        --         current_index = i
        --         break
        --       end
        --     end
        --
        --     return string.format('%d/%d', current_index, #buffers)
        --   end,
        --   icon = '󰓩 ',
        -- },
      },
    },
  },
}
