return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    scroll = { enabled = false },
    lazygit = { enabled = true },
    bufdelete = { enabled = true },
    indent = { enabled = true },
    image = { enabled = false, doc = { inline = false } },
    picker = {
      hidden = true,
      matcher = {
        frecency = true,
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
      debug = {
        scores = false,
      },
      win = {
        input = {
          keys = {
            ['<CR>'] = { 'confirm', mode = { 'i', 'n' } },
            ['<C-y>'] = { 'confirm', mode = { 'i', 'n' } },
            ['J'] = { 'preview_scroll_down', mode = { 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'n' } },
            ['M'] = { 'toggle_hidden', mode = { 'n' } },
            ['d'] = { 'bufdelete', mode = { 'n' } },
          },
        },
      },
    },
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files()' },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'Lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        {
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          cwd = true,
          indent = 2,
          padding = 1,
        },
        { section = 'startup' },
      },
    },
  },
  keys = function()
    local Snacks = require 'snacks'
    return {
      -- Top Pickers & Explorer
      {
        '<leader><space>',
        function()
          Snacks.picker.files()
        end,
        desc = 'Smart Find Files',
      },
      -- {
      --   '<leader>,',
      --   function()
      --     Snacks.picker.buffers()
      --   end,
      --   desc = 'Buffers',
      -- },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>n',
        function()
          Snacks.picker.notifications()
        end,
        desc = 'Notification History',
      },
      -- find
      {
        '<leader>fc',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.git_files()
        end,
        desc = 'Find Git Files',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
      -- git
      -- {
      --   '<leader>gb',
      --   function()
      --     Snacks.picker.git_branches()
      --   end,
      --   desc = 'Git Branches',
      -- },
      -- {
      --   '<leader>gl',
      --   function()
      --     Snacks.picker.git_log()
      --   end,
      --   desc = 'Git Log',
      -- },
      -- {
      --   '<leader>gL',
      --   function()
      --     Snacks.picker.git_log_line()
      --   end,
      --   desc = 'Git Log Line',
      -- },
      {
        '<leader>fs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Find Git Status',
      },
      -- {
      --   '<leader>gS',
      --   function()
      --     Snacks.picker.git_stash()
      --   end,
      --   desc = 'Git Stash',
      -- },
      -- {
      --   '<leader>gd',
      --   function()
      --     Snacks.picker.git_diff()
      --   end,
      --   desc = 'Git Diff (Hunks)',
      -- },
      -- {
      --   '<leader>gf',
      --   function()
      --     Snacks.picker.git_log_file()
      --   end,
      --   desc = 'Git Log File',
      -- },
      -- Grep
      {
        '<leader>sb',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sB',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = 'Registers',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'Search History',
      },
      {
        '<leader>sa',
        function()
          Snacks.picker.autocmds()
        end,
        desc = 'Autocmds',
      },
      {
        '<leader>sc',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>sC',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sD',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        function()
          Snacks.picker.highlights()
        end,
        desc = 'Highlights',
      },
      {
        '<leader>si',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Icons',
      },
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>sM',
        function()
          Snacks.picker.man()
        end,
        desc = 'Man Pages',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.lazy()
        end,
        desc = 'Search for Plugin Spec',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      {
        '<leader>uC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'grr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sS',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
    }
  end,
}
