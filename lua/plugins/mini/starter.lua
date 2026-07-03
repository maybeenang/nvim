-- NOTE: DASHBOARD
local starter = require 'mini.starter'

local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

starter.setup {
  header = header,
  footer = '',
  items = {
    {
      name = 'Restore Session',
      action = ':Persisted load',
      section = 'Sessions',
    },
    starter.sections.recent_files(3, true, function(path)
      local cwd = vim.fn.getcwd() .. '/'
      local rel = path:find(cwd, 1, true) and path:sub(#cwd + 1) or vim.fn.fnamemodify(path, ':t')
      if #rel > 50 then rel = '…' .. rel:sub(-49) end
      return ' ' .. rel
    end),
    starter.sections.builtin_actions(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet '',
    starter.gen_hook.aligning('center', 'center'),
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniStarterOpened',
  callback = function(ev)
    vim.keymap.set('n', 'j', function() starter.update_current_item('next', ev.buf) end, { buffer = ev.buf, silent = true })
    vim.keymap.set('n', 'k', function() starter.update_current_item('previous', ev.buf) end, { buffer = ev.buf, silent = true })
  end,
})
