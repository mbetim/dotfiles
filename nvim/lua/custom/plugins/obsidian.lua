if true then
  return {}
end

return {
  -- "epwalsh/obsidian.nvim",
  'obsidian-nvim/obsidian.nvim',
  version = '3.12',
  lazy = true,
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/dev/obsidian/**.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/dev/obsidian/**.md',
  },
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'personal',
        path = '~/dev/obsidian/flat',
      },
    },

    completion = {
      blink = true,
      min_chars = 2,
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = 'journal/daily',
      template = 'templates/daily.md',
    },

    preferred_link_style = 'wiki',

    templates = {
      folder = 'templates',
      subdir = 'templates',
    },

    new_notes_location = '',
    default_template = 'templates/default.md',

    note_id_func = function(title)
      local filename = ''
      if title ~= nil then
        filename = title:gsub('[^%w%s]', '') -- Removes all special characters except alphanumeric and spaces
      else
        for _ = 1, 4 do
          filename = filename .. string.char(math.random(65, 90))
        end
      end

      return filename
    end,

    ui = {
      enable = false,
      checkbox = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
      },
    },
    attachments = {
      img_folder = 'assets',
    },
    pickers = {
      name = 'snacks',
    },
    checkbox = {
      order = { ' ', 'x' },
    },
    disable_formatter = true,
    statusline = { enabled = false },
    footer = { enabled = false },
  },
  keys = {
    { '<leader>on', '<cmd>Obsidian new<CR>', desc = 'New note' },
    { '<leader>od', '<cmd>Obsidian dailies<CR>', desc = 'Search journal notes' },
    {
      '<leader>oe',
      ':Obsidian extract_note ',
      desc = 'Extract the highlighted text to a new note',
      mode = { 'v' },
    },
    {
      '<leader>ol',
      ':Obsidian link<CR>',
      desc = 'Turn the highlighted text into a link',
      mode = { 'v' },
    },
    { '<leader>oT', '<cmd>Obsidian template<CR>', desc = 'Templates' },
    { '<leader>ot', '<cmd>Obsidian today<CR>', desc = 'Today daily note' },
    { '<leader>oO', '<cmd>Obsidian open<CR>', desc = 'Open on Obsidian app' },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'ObsidianNoteEnter',
      callback = function(ev)
        -- vim.keymap.set('n', '<leader>ch', '<cmd>Obsidian toggle_checkbox<cr>', {
        --   buffer = ev.buf,
        --   desc = 'Toggle checkbox',
        -- })

        vim.keymap.del('n', '<CR>', { buffer = ev.buf })
      end,
    })
  end,
}
