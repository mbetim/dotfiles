return {
  -- "epwalsh/obsidian.nvim",
  'obsidian-nvim/obsidian.nvim',
  version = '*',
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
    workspaces = {
      {
        name = 'personal',
        path = '~/dev/obsidian/flat',
      },
    },

    completion = {
      blink = true,
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
        filename = title
      else
        for _ = 1, 4 do
          filename = filename .. string.char(math.random(65, 90))
        end
      end

      return filename
    end,

    ui = {
      enable = false,
      checkboxes = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
      },
    },
    attachments = {
      img_folder = 'assets',
    },
    mappings = {
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
    pickers = {
      name = 'snacks',
    },
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<CR>', desc = 'New note' },
    { '<leader>od', '<cmd>ObsidianDailies<CR>', desc = 'Search journal notes' },
    {
      '<leader>oe',
      ':ObsidianExtractNote ',
      desc = 'Extract the highlighted text to a new note',
      mode = { 'v' },
    },
    {
      '<leader>ol',
      ':ObsidianLink<CR>',
      desc = 'Turn the highlighted text into a link',
      mode = { 'v' },
    },
    { '<leader>oT', '<cmd>ObsidianTemplate<CR>', desc = 'Templates' },
    { '<leader>ot', '<cmd>ObsidianToday<CR>', desc = 'Today daily note' },
    { '<leader>oO', '<cmd>ObsidianOpen<CR>', desc = 'Open on Obsidian app' },
  },
}
