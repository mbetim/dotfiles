return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  init = function()
    -- One session for the whole Neovim instance: every project tab, its window
    -- layout, and its tab-local cwd. 'tabpages' and 'curdir' are what make the
    -- multi-tab restore work, so they are spelled out rather than left implicit.
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,terminal,winsize'
  end,
  opts = {},
  config = function(_, opts)
    local persistence = require 'persistence'
    persistence.setup(opts)

    local Config = require 'persistence.config'
    local uv = vim.uv or vim.loop

    -- The Switch Project picker gives each tab its own tcd, so vim.fn.getcwd()
    -- returns whichever project tab happens to be active -- at exit that would
    -- key the session under a random subdirectory. Key it on the global cwd
    -- (the directory Neovim was started in) so one session covers every tab and
    -- is found again on the next launch from that directory.
    local function global_cwd()
      return vim.fn.getcwd(-1, -1)
    end

    function persistence.branch()
      local cwd = global_cwd()
      if uv.fs_stat(cwd .. '/.git') then
        local ret = vim.fn.systemlist({ 'git', '-C', cwd, 'branch', '--show-current' })[1]
        return vim.v.shell_error == 0 and ret or nil
      end
    end

    function persistence.current(o)
      o = o or {}
      local name = global_cwd():gsub('[\\/:]+', '%%')
      if Config.options.branch and o.branch ~= false then
        local branch = persistence.branch()
        if branch and branch ~= 'main' and branch ~= 'master' then
          name = name .. '%%' .. branch:gsub('[\\/:]+', '%%')
        end
      end
      return Config.options.dir .. name .. '.vim'
    end
  end,
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'Restore Session',
    },
  },
}
